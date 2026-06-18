<template>
  <div
    class="ac-pt"
    :class="{
      'ac-pt--bordered': bordered,
      'ac-pt--striped': striped,
      'ac-pt--hover': hover,
      'ac-pt--loading': displayLoading,
    }"
  >
    <!-- ── Table ──────────────────────────────────── -->
    <div class="ac-pt__table-wrap" ref="tableWrapRef">
      <table class="ac-pt__table">
        <!-- Colgroup for column widths -->
        <colgroup>
          <col
            v-for="col in columns"
            :key="col.key"
            :style="{ minWidth: col.width || 'auto', width: col.width || 'auto' }"
          />
        </colgroup>

        <!-- Header -->
        <thead>
          <tr>
            <th
              v-for="col in columns"
              :key="col.key"
              :class="[
                col.align ? 'ac-pt__th--' + col.align : '',
                col.sortable ? 'ac-pt__th--sortable' : '',
                sortKey === col.key ? 'ac-pt__th--sorted' : '',
              ]"
              :style="col.width ? { width: col.width } : {}"
              @click="col.sortable && toggleSort(col)"
            >
              <span class="ac-pt__th-label">{{ col.title }}</span>
              <span
                v-if="col.sortable"
                class="ac-pt__sort-icon"
                :class="{
                  'ac-pt__sort-icon--asc': sortKey === col.key && sortOrder === 'asc',
                  'ac-pt__sort-icon--desc': sortKey === col.key && sortOrder === 'desc',
                }"
              >
                <svg width="10" height="14" viewBox="0 0 10 14">
                  <path d="M5 0l4 5H1z" class="ac-pt__sort-arrow ac-pt__sort-arrow--up" />
                  <path d="M5 14l4-5H1z" class="ac-pt__sort-arrow ac-pt__sort-arrow--down" />
                </svg>
              </span>
            </th>
          </tr>
        </thead>

        <!-- Body -->
        <tbody>
          <!-- Default slot: users provide their own rows -->
          <slot
            v-if="$slots.default"
            :rows="displayData"
            :columns="columns"
          />

          <!-- Auto-render from columns -->
          <template v-else>
            <tr
              v-for="(row, idx) in displayData"
              :key="getRowKey(row, idx)"
              :class="{
                'ac-pt__row--clickable': !!$attrs.onRowClick || !!$listeners?.rowClick,
              }"
              @click="onRowClick(row, idx)"
            >
              <td
                v-for="col in columns"
                :key="col.key"
                :class="[
                  col.align ? 'ac-pt__td--' + col.align : '',
                  col.className || '',
                ]"
              >
                <!-- Named slot for specific column cell -->
                <slot
                  v-if="$slots['cell-' + col.key]"
                  :name="'cell-' + col.key"
                  :row="row"
                  :value="row[col.key]"
                  :index="idx"
                />
                <!-- Render function (returns HTML string, matches generated code) -->
                <template v-else-if="col.render">
                  <span
                    v-html="col.render(row[col.key], row)"
                    @click="handleActionClick($event, row, idx)"
                  ></span>
                </template>
                <!-- Formatter function (returns plain text) -->
                <template v-else-if="col.formatter">
                  {{ col.formatter(row, col, row[col.key], idx) }}
                </template>
                <!-- Plain value -->
                <template v-else>
                  {{ row[col.key] }}
                </template>
              </td>
            </tr>
          </template>

          <!-- Empty body fallback -->
          <tr v-if="!$slots.default && displayData.length === 0 && !displayLoading">
            <td :colspan="columns.length" class="ac-pt__empty-cell">
              <slot name="empty">
                <div class="ac-pt__empty">
                  <span class="ac-pt__empty-icon">📭</span>
                  <span class="ac-pt__empty-text">{{ emptyText }}</span>
                </div>
              </slot>
            </td>
          </tr>
        </tbody>
      </table>

      <!-- Loading overlay -->
      <Transition name="ac-pt-loading">
        <div v-if="displayLoading" class="ac-pt__loading-overlay">
          <slot name="loading">
            <div class="ac-pt__loading-spinner">
              <span class="ac-pt__spinner-dot"></span>
              <span class="ac-pt__spinner-text">加载中…</span>
            </div>
          </slot>
        </div>
      </Transition>
    </div>

    <!-- ── Pagination ─────────────────────────────── -->
    <div v-if="showPagination" class="ac-pt__pagination">
      <${namespace}-pagination
        :current-page="displayCurrentPage"
        :page-size="displayPageSize"
        :total="displayTotal"
        :page-size-options="pageSizeOptions"
        :show-total="showPaginationTotal"
        :show-page-size="showPaginationSizer"
        :show-jumper="showPaginationJumper"
        :size="paginationSize"
        @update:current-page="onPageChange({ page: $event, pageSize: displayPageSize })"
        @update:page-size="onPageChange({ page: displayCurrentPage, pageSize: $event })"
        @change="onPageChange($event)"
      />
    </div>
  </div>
</template>

<script setup>
/**
 * AcPagedTable — Academy Pro 分页表格
 *
 * 两种数据模式:
 *   1. 受控模式: 传入 data / total / loading props，父组件自行管理数据
 *   2. fetch 模式: 传入 fetchData / fetchParams，组件内部自动请求数据
 *
 * 设计对齐 Academy Pro 设计系统:
 * - 表头: surface 背景 · 大写 · 加粗 · 11px 字号
 * - 单元格: 左对齐 · body 字号 · 底边分隔线
 * - 排序: 可排序列显示双箭头 · 激活态 teal 高亮
 * - 加载: 半透明遮罩 + 居中旋转动画
 * - 空态: 居中 emoji + 文字提示
 * - 分页: 内置 AcPagination · 底部分隔线之上
 * - 支持列插槽: ${r"`cell-${key}`"} 命名插槽自定义单元格
 */
import { ref, computed, watch, onMounted, toRefs } from 'vue'
import ${js.nameType(namespace)}Pagination from './${namespace}-pagination.vue'

const props = defineProps({
  /** 列定义 [{ key, title, width?, align?, sortable?, formatter?, className? }] */
  columns:       { type: Array, required: true },
  /** 数据行（受控模式） */
  data:          { type: Array, default: () => [] },
  /** 数据总数（受控模式） */
  total:         { type: Number, default: 0 },
  /** 当前页码 (v-model) */
  currentPage:   { type: Number, default: 1 },
  /** 每页条数 (v-model) */
  pageSize:      { type: Number, default: 10 },
  /** 每页条数选项 */
  pageSizeOptions:{ type: Array, default: () => [10, 20, 50, 100] },
  /** 加载中（受控模式） */
  loading:       { type: Boolean, default: false },
  /** 空数据提示文案 */
  emptyText:     { type: String, default: '暂无数据' },
  /** 是否显示分页器 */
  showPagination: { type: Boolean, default: true },
  /** 分页器是否显示总数 */
  showPaginationTotal: { type: Boolean, default: true },
  /** 分页器是否显示条数选择 */
  showPaginationSizer: { type: Boolean, default: true },
  /** 分页器是否显示快捷跳转 */
  showPaginationJumper:{ type: Boolean, default: false },
  /** 分页器尺寸 */
  paginationSize: { type: String, default: 'md' },
  /** 是否显示边框 */
  bordered:      { type: Boolean, default: false },
  /** 是否斑马纹 */
  striped:       { type: Boolean, default: false },
  /** 是否行悬停效果 */
  hover:         { type: Boolean, default: true },
  /** 行的唯一 key 生成方式: 字段名 / 函数 (row, idx) => key */
  rowKey:        { type: [String, Function], default: 'id' },
  /** 当前排序列 key */
  sortKey:       { type: String, default: '' },
  /** 当前排序方向 */
  sortOrder:     { type: String, default: '' },
  /** [fetch 模式] 数据获取函数 (params) => Promise<{ data, total }> */
  fetchData:     { type: Function, default: null },
  /** [fetch 模式] 额外查询参数，变化时自动重新请求 */
  fetchParams:   { type: Object, default: () => ({}) },
})

const emit = defineEmits([
  'update:currentPage',
  'update:pageSize',
  'update:sortKey',
  'update:sortOrder',
  'pageChange',
  'rowClick',
  'sortChange',
  'rowAction',
])

const tableWrapRef = ref(null)

// ── fetch 模式内部状态 ────────────────────────────

const isFetchMode = computed(() => typeof props.fetchData === 'function')

const _data  = ref([])
const _total = ref(0)
const _loading = ref(false)
const _initialLoaded = ref(false)
const _currentPage = ref(props.currentPage)
const _pageSize = ref(props.pageSize)

const displayData  = computed(() => isFetchMode.value ? _data.value  : props.data)
const displayTotal = computed(() => isFetchMode.value ? _total.value : props.total)
const displayLoading = computed(() => isFetchMode.value ? _loading.value : props.loading)
const displayCurrentPage = computed(() => isFetchMode.value ? _currentPage.value : props.currentPage)
const displayPageSize    = computed(() => isFetchMode.value ? _pageSize.value    : props.pageSize)

// ── Pagination handlers (fetch 模式下更新内部状态) ──

function onPageChange({ page, pageSize }) {
  if (isFetchMode.value) {
    _currentPage.value = page
    _pageSize.value = pageSize
  }
  emit('update:currentPage', page)
  emit('update:pageSize', pageSize)
  emit('pageChange', { page, pageSize })
}

// ── fetch 触发器 ──────────────────────────────────

async function doFetch() {
  if (!isFetchMode.value) return
  _loading.value = true
  try {
    const page = _currentPage.value
    const size = _pageSize.value
    const params = {
      page,
      pageSize: size,
      sortKey:   props.sortKey,
      sortOrder: props.sortOrder,
      ...props.fetchParams,
    }
    const res = await props.fetchData(params)
    _data.value  = res.data ?? []
    _total.value = res.total ?? 0
    _initialLoaded.value = true
  } catch (e) {
    _data.value = []
    _total.value = 0
  } finally {
    _loading.value = false
  }
}

// 监听分页 / 排序 / 查询参数变化，自动请求
watch(
  () => [
    _currentPage.value,
    _pageSize.value,
    props.sortKey,
    props.sortOrder,
    props.fetchParams,
  ],
  () => { if (isFetchMode.value) doFetch() },
  { deep: true },
)

onMounted(() => {
  if (isFetchMode.value) doFetch()
})

// ── Public methods ──────────────────────────────

function refresh() {
  if (isFetchMode.value) {
    _currentPage.value = 1
    doFetch()
  }
}

defineExpose({ refresh })

// ── Row key ──────────────────────────────────────

function getRowKey(row, idx) {
  if (typeof props.rowKey === 'function') {
    return props.rowKey(row, idx)
  }
  return row[props.rowKey] ?? idx
}

// ── Sort ─────────────────────────────────────────

function toggleSort(col) {
  if (!col.sortable) return
  let newKey = col.key
  let newOrder = 'asc'

  if (props.sortKey === col.key) {
    if (props.sortOrder === 'asc') {
      newOrder = 'desc'
    } else if (props.sortOrder === 'desc') {
      newKey = ''
      newOrder = ''
    }
  }

  emit('update:sortKey', newKey)
  emit('update:sortOrder', newOrder)
  emit('sortChange', { key: newKey, order: newOrder })
}

// ── Row click ────────────────────────────────────

function onRowClick(row, idx) {
  emit('rowClick', row, idx)
}

// ── Action button click (event delegation) ─────
// Reads @click attribute from the rendered HTML button, parses the handler
// expression, and emits rowAction so the parent can dispatch.

function handleActionClick(event, row, idx) {
  const btn = event.target.closest('button')
  if (!btn) return
  const expr = btn.getAttribute('@click')
  if (!expr) return
  // Parse handler name and arguments: "handleEdit(row)" or "handleEdit"
  const match = expr.match(/^(\w+)\s*\(?\s*(.*?)\s*\)?$/);
  if (!match) return;
  const handler = match[1]
  // Resolve "row" → actual row object, otherwise pass string as-is
  const args = match[2]
    ? match[2].split(',').map(s => {
        const trimmed = s.trim()
        return trimmed === 'row' ? row : trimmed.replace(/^['"]|['"]$/g, '')
      })
    : []
  emit('rowAction', { handler, args, row, index: idx })
}
</script>

<style scoped>
/* ═══════════════════════════════════════════════════════════════════════════
   AcPagedTable — Academy Pro 分页表格
   设计令牌: var(--color-*) var(--space-*) var(--radius-*) var(--shadow-*)
   ═══════════════════════════════════════════════════════════════════════════ */

.ac-pt {
  background: var(--color-card);
  /* border-radius: var(--radius-xl); */
  overflow: hidden;
  position: relative;
}

/* ── Border variant ─────────────────────────────── */

.ac-pt--bordered {
  border: 1px solid var(--color-border);
}

.ac-pt--bordered .ac-pt__table td,
.ac-pt--bordered .ac-pt__table th {
  border-right: 1px solid var(--color-border);
}

.ac-pt--bordered .ac-pt__table td:last-child,
.ac-pt--bordered .ac-pt__table th:last-child {
  border-right: none;
}

/* ── Table wrap ─────────────────────────────────── */

.ac-pt__table-wrap {
  position: relative;
  overflow-x: auto;
  min-height: 120px;
}

/* ── Table ──────────────────────────────────────── */

.ac-pt__table {
  width: 100%;
  border-collapse: collapse;
  table-layout: auto;
}

/* Header */
.ac-pt__table thead tr {
  border-bottom: 1px solid var(--color-border);
}

.ac-pt__table th {
  text-align: center;
  padding: var(--space-6) var(--space-8);
  font-size: var(--text-sm);
  font-weight: var(--weight-semibold);
  color: var(--color-text-muted);
  text-transform: uppercase;
  letter-spacing: var(--tracking-wide);
  white-space: normal;
  word-break: keep-all;
  overflow-wrap: break-word;
  background: var(--color-surface);
  transition: color var(--transition-fast);
}

.ac-pt__table th:first-child {
  /* border-radius: var(--radius-md) 0 0 var(--radius-md); */
}

.ac-pt__table th:last-child {
  /* border-radius: 0 var(--radius-md) var(--radius-md) 0; */
}

/* Column alignment */
.ac-pt__th--center,
.ac-pt__td--center {
  text-align: center;
}

.ac-pt__th--right,
.ac-pt__td--right {
  text-align: right;
}

/* ── Sortable header ────────────────────────────── */

.ac-pt__th--sortable {
  cursor: pointer;
  user-select: none;
}

.ac-pt__th--sortable:hover {
  color: var(--color-text-main);
}

.ac-pt__th--sorted {
  color: var(--color-teal-text) !important;
}

.ac-pt__th-label {
  vertical-align: middle;
}

.ac-pt__sort-icon {
  display: inline-flex;
  vertical-align: middle;
  margin-left: var(--space-3);
  opacity: 0.3;
  transition: opacity var(--transition-fast);
}

.ac-pt__th--sortable:hover .ac-pt__sort-icon {
  opacity: 0.6;
}

.ac-pt__th--sorted .ac-pt__sort-icon {
  opacity: 1;
}

.ac-pt__sort-arrow {
  fill: var(--color-text-muted);
  transition: fill var(--transition-fast);
}

.ac-pt__th--sorted .ac-pt__sort-arrow {
  fill: var(--color-teal);
}

.ac-pt__sort-icon--asc .ac-pt__sort-arrow--up {
  fill: var(--color-teal);
}

.ac-pt__sort-icon--asc .ac-pt__sort-arrow--down {
  fill: var(--color-text-muted);
  opacity: 0.3;
}

.ac-pt__sort-icon--desc .ac-pt__sort-arrow--down {
  fill: var(--color-teal);
}

.ac-pt__sort-icon--desc .ac-pt__sort-arrow--up {
  fill: var(--color-text-muted);
  opacity: 0.3;
}

/* ── Body cells ─────────────────────────────────── */

.ac-pt__table td {
  padding: var(--space-7) var(--space-8);
  font-size: var(--text-body);
  color: var(--color-text-main);
  border-bottom: 1px solid var(--color-border);
  vertical-align: middle;
  white-space: normal;
  word-break: keep-all;
  overflow-wrap: break-word;
}

.ac-pt__table tbody tr:last-child td {
  border-bottom: none;
}

/* ── Hover ──────────────────────────────────────── */

.ac-pt--hover .ac-pt__table tbody tr:hover td {
  background: #f7fafc;
}

.ac-pt--loading.ac-pt--hover .ac-pt__table tbody tr:hover td {
  background: transparent;
}

/* ── Striped ────────────────────────────────────── */

.ac-pt--striped .ac-pt__table tbody tr:nth-child(even) td {
  background: #fafbfc;
}

.ac-pt--striped.ac-pt--hover .ac-pt__table tbody tr:hover td {
  background: #f0f5f8;
}

/* ── Clickable rows ─────────────────────────────── */

.ac-pt__row--clickable {
  cursor: pointer;
}

/* ── Empty state ────────────────────────────────── */

.ac-pt__empty-cell {
  text-align: center !important;
  padding: var(--space-13) var(--space-9) !important;
}

.ac-pt__empty {
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: var(--space-6);
}

.ac-pt__empty-icon {
  font-size: 36px;
  opacity: 0.4;
}

.ac-pt__empty-text {
  font-size: var(--text-md);
  color: var(--color-text-muted);
}

/* ── Loading overlay ────────────────────────────── */

.ac-pt__loading-overlay {
  position: absolute;
  inset: 0;
  background: rgba(255, 255, 255, 0.7);
  backdrop-filter: blur(1px);
  display: flex;
  align-items: center;
  justify-content: center;
  z-index: 10;
  border-radius: var(--radius-xl);
}

.ac-pt__loading-spinner {
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: var(--space-7);
}

.ac-pt__spinner-dot {
  width: 28px;
  height: 28px;
  border: 3px solid var(--color-border);
  border-top-color: var(--color-teal);
  border-radius: var(--radius-full);
  animation: ac-pt-spin 0.7s linear infinite;
}

@keyframes ac-pt-spin {
  to { transform: rotate(360deg); }
}

.ac-pt__spinner-text {
  font-size: var(--text-md);
  color: var(--color-text-sub);
  font-weight: var(--weight-medium);
}

/* Loading transition */
.ac-pt-loading-enter-active {
  transition: opacity var(--transition-smooth);
}

.ac-pt-loading-leave-active {
  transition: opacity 0.15s ease;
}

.ac-pt-loading-enter-from,
.ac-pt-loading-leave-to {
  opacity: 0;
}

/* ── Pagination bar ─────────────────────────────── */

.ac-pt__pagination {
  border-top: 1px solid var(--color-border);
}
</style>
