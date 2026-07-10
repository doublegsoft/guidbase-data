<#import "/$/guidbase.ftl" as guidbase>
<#import "/$/guidbase4kotlin.ftl" as guidbase4kotlin>
package ${namespace}.${java.nameNamespace(app.name)}.behavior

import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.flow.StateFlow
import kotlinx.coroutines.flow.asStateFlow

import ${namespace}.${java.nameNamespace(app.name)}.model.*

/**
 * 通用分页行为 —— 在 ViewModel 中封装分页列表的逐页加载、累加与重置逻辑。
 *
 * 不依赖 Android 框架，仅持有列表状态并通过注入的 [fetch] 闭包执行具体网络请求，
 * 由 ViewModel 在合适的协程作用域中调用 [refresh] / [loadMore]。
 *
 * ### 典型用法
 * ```
 * class ListPageViewModel(repository: Repository, handle: SavedStateHandle) : ViewModel() {
 *
 *   private val paging = PagingBehavior(pageSize = PAGE_SIZE) { params, start, limit ->
 *     repository.fetchOrders(params, start, limit)
 *   }
 *
 *   fun refresh() {
 *     viewModelScope.launch {
 *       _viewState.value = ViewState.Loading
 *       try {
 *         paging.refresh(OrderQuery())
 *         _viewState.value = ViewState.Success(rows = paging.rows.toList(), hasMore = paging.hasMore)
 *       } catch (e: Exception) {
 *         _viewState.value = ViewState.Error(e.message ?: "加载失败")
 *       }
 *     }
 *   }
 *
 *   fun loadMore() {
 *     viewModelScope.launch {
 *       val current = _viewState.value as? ViewState.Success ?: return@launch
 *       _viewState.value = current.copy(isLoadingMore = true)
 *       try {
 *         paging.loadMore()
 *         _viewState.value = current.copy(
 *           rows = paging.rows.toList(),
 *           isLoadingMore = false,
 *           hasMore = paging.hasMore
 *         )
 *       } catch (e: Exception) {
 *         _viewState.value = current.copy(isLoadingMore = false)
 *       }
 *     }
 *   }
 * }
 * ```
 *
 * @param T         列表项数据类型。
 * @param Q         查询参数类型。
 * @param pageSize  每页条数。
 * @param fetch     执行分页请求的 suspend 函数：([params], [start], [limit]) → [Pagination]。
 */
class PagingBehavior<T, Q>(
  private val fetch: suspend (params: Q, start: Int, limit: Int) -> Pagination<T>,
  private val pageSize: Int = 12,
) {
  
  /** 不可变分页快照，供 ViewModel 直接交给 ViewState。 */
  data class Snapshot<T>(
    val rows: List<T>,
    val isLoading: Boolean,
    val hasMore: Boolean,
  )

  // ── 内部累加器 ────────────────────────────────────────────────────────
  private val _rows = mutableListOf<T>()

  /** 当前已加载的全部数据行（只读快照）。 */
  val rows: List<T> get() = _rows

  /** 数据总条数（服务端返回）。 */
  var total: Int = 0
    private set

  /** 最后一次 [refresh] 传入的查询参数。 */
  var params: Q? = null
    private set

  /** 是否正在加载中。 */
  var isLoading: Boolean = false
    private set

  // ── 派生状态 ──────────────────────────────────────────────────────────

  /** 是否还有更多数据可加载。 */
  val hasMore: Boolean get() = _rows.size < total

  /** 列表是否为空。 */
  val isEmpty: Boolean get() = _rows.isEmpty()

  /** 已加载条数。 */
  val count: Int get() = _rows.size

  val snapshot: Snapshot<T> get() = Snapshot(rows = _rows.toList(), isLoading = isLoading, hasMore = hasMore)

  // ── 可观察状态 ──────────────────────────────────────────────────────────
  private val _snapshotFlow = MutableStateFlow(snapshot)
  /** 状态流，每次内部状态变化时发射新的 [Snapshot]。调用者 collect 即可感知变化。 */
  val snapshotFlow: StateFlow<Snapshot<T>> = _snapshotFlow.asStateFlow()

  private fun publish() {
    _snapshotFlow.value = snapshot
  }

  // ── 公开方法 ──────────────────────────────────────────────────────────

  /**
   * 重置累加器并以 [newParams] 加载第一页。
   * 通常由 ViewModel.refresh() 调用。
   */
  suspend fun refresh(newParams: Q) {
    params = newParams
    total = 0
    _rows.clear()
    isLoading = false
    loadPage()
  }

  /**
   * 加载下一页并累加到 [rows]。
   *
   * @return 本次新增的数据条数；若 [isLoading] 或 [!hasMore] 则直接返回 0。
   */
  suspend fun loadMore(): Int {
    if (isLoading || !hasMore) return 0
    return loadPage()
  }

  /**
   * 重置所有状态（不清空 [params]）。
   */
  fun reset() {
    total = 0
    _rows.clear()
    isLoading = false
    publish()
  }

  // ── 内部实现 ──────────────────────────────────────────────────────────

  private suspend fun loadPage(): Int {
    isLoading = true
    publish()
    try {
      val page = fetch(params!!, _rows.size, pageSize)
      total = page.total
      _rows.addAll(page.data)
      return page.data.size
    } finally {
      isLoading = false
      publish()
    }
  }
}
