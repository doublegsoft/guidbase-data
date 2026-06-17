<template>
  <div class="${namespace}-page-table">
    <div class="${namespace}-list-area">
      <!-- 加载遮罩 -->
      <div v-if="loading" class="${namespace}-page-table__loading-mask">
        <span class="${namespace}-page-table__loading-text">加载中...</span>
      </div>

      <div class="${namespace}-table-container" ref="scrollContainer">
        <table class="${namespace}-table">
          <thead>
            <tr>
              <th style="width:40px" class="${namespace}-tc">
                <input type="checkbox" :checked="isAllChecked" @change="toggleAll($event.target.checked)" style="width:14px;height:14px;accent-color:var(--p);cursor:pointer">
              </th>
              <th v-for="col in columns" :key="col.key"
                :style="{ width: col.width || '', textAlign: 'center' }"
                :class="{ '${namespace}-sortable': col.sortable, '${namespace}-asc': sortKey === col.key && sortAsc, '${namespace}-desc': sortKey === col.key && !sortAsc }"
                @click="col.sortable && toggleSort(col.key)">
                {{ col.title }}
                <span v-if="col.sortable" class="${namespace}-sort-icon"></span>
              </th>
            </tr>
          </thead>
          <tbody>
            <tr v-if="pageData.length === 0">
              <td :colspan="columns.length + 1" class="${namespace}-tc" style="padding:40px;color:var(--tl)">
                {{ loading ? '加载中...' : '暂无数据' }}
              </td>
            </tr>
            <tr v-for="(row, rowIndex) in pageData" :key="String(row[idKey])"
              :data-id="String(row[idKey])"
              :class="rowClasses(row)"
              @click="onRowClick($event, row, rowIndex)">
              <td class="${namespace}-tc" @click.stop>
                <input type="checkbox" :checked="selectedIds.has(String(row[idKey]))" @change="toggleRow(String(row[idKey]), $event.target.checked)" style="width:14px;height:14px;accent-color:var(--p);cursor:pointer">
              </td>
              <td v-for="col in columns" :key="col.key" :style="{ textAlign: col.align || 'left' }">
                <span v-if="col.render" v-html="col.render(row[col.key], row)"></span>
                <template v-else>{{ row[col.key] }}</template>
              </td>
            </tr>
          </tbody>
        </table>
      </div>
      <${namespace}-pagination
        :total="paginationTotal"
        v-model:current-page="currentPage"
        v-model:page-size="pageSize"
        :page-sizes="[10, 20, 50, 100]"
        @change="onPageChange"
      />
    </div>
    <div class="${namespace}-drawer" :class="{ '${namespace}-drawer-closed': !drawerOpen }" @click="onDrawerClick">
      <div v-if="drawerOpen && drawerRender" v-html="drawerRender(drawerRow)"></div>
    </div>
  </div>
</template>

<script setup>
import { ref, computed, watch, onMounted } from 'vue'
import PtPagination from './${namespace}-pagination.vue'

const props = defineProps({
  data:         { type: Array,    default: () => [] },
  columns:      { type: Array,    required: true },
  currentPage:  { type: Number,   default: 1 },
  pageSize:     { type: Number,   default: 20 },
  idKey:        { type: String,   default: 'id' },
  rowClassName: { type: Function, default: null },
  drawerRender: { type: Function, default: null },
  total:        { type: Number,   default: 0 },
  // ── 远端数据获取 ──
  // fetchData: async (params, pageNumber, pageSize) => { data: [...], total: N }
  fetchData:    { type: Function, default: null },
  // fetchParams: 传入 fetchData 的搜索条件参数
  fetchParams:  { type: Object,   default: () => ({}) },
  // rowAction: 操作按钮回调映射 { handlerName: (row, index) => void }
  rowAction:    { type: Object,   default: null },
})

const emit = defineEmits(['update:currentPage', 'update:pageSize', 'selection-change', 'row-click', 'row-action'])

const currentPage = ref(props.currentPage)
const pageSize = ref(props.pageSize)
const sortKey = ref(null)
const sortAsc = ref(true)
const selectedIds = ref(new Set())
const drawerOpen = ref(false)
const drawerRow = ref(null)
const scrollContainer = ref(null)

watch(() => props.currentPage, (v) => { currentPage.value = v })
watch(() => props.pageSize,    (v) => { pageSize.value = v })

// ── 远端数据模式 ──
const isServerMode = computed(() => typeof props.fetchData === 'function')

const internalData = ref([])
const internalTotal = ref(0)
const loading = ref(false)
let reqId = 0

// 服务端模式：使用内部数据；客户端模式：使用 props.data
const serverData = computed(() => isServerMode.value ? internalData.value : props.data)

const displayData = computed(() => {
  if (isServerMode.value) return serverData.value
  const arr = [...props.data]
  if (sortKey.value) {
    arr.sort((a, b) => {
      const va = a[sortKey.value]
      const vb = b[sortKey.value]
      if (typeof va === 'number') return sortAsc.value ? va - vb : vb - va
      return sortAsc.value ? String(va).localeCompare(String(vb)) : String(vb).localeCompare(String(va))
    })
  }
  return arr
})

const pageData = computed(() => {
  if (isServerMode.value) return serverData.value
  const start = (currentPage.value - 1) * pageSize.value
  return displayData.value.slice(start, start + pageSize.value)
})

const paginationTotal = computed(() => isServerMode.value ? internalTotal.value : displayData.value.length)

const isAllChecked = computed(() =>
  pageData.value.length > 0 && pageData.value.every(r => selectedIds.value.has(String(r[props.idKey])))
)

// ── 远端数据加载 ──
async function loadData() {
  if (!isServerMode.value) return
  const id = ++reqId
  loading.value = true
  try {
    const params = { ...props.fetchParams }
    const res = await props.fetchData(params, currentPage.value, pageSize.value)
    if (id !== reqId) return
    if (res) {
      internalData.value = res.data ?? []
      internalTotal.value = res.total ?? (Array.isArray(res.data) ? res.data.length : 0)
    } else {
      internalData.value = []
      internalTotal.value = 0
    }
  } catch (e) {
    if (id !== reqId) return
    console.error('PagedTable fetchData error:', e)
    internalData.value = []
    internalTotal.value = 0
  } finally {
    if (id === reqId) {
      loading.value = false
    }
  }
}

// fetchParams 引用变化 → 回到第 1 页重新加载
watch(() => props.fetchParams, () => {
  if (isServerMode.value) {
    currentPage.value = 1
    emit('update:currentPage', 1)
    loadData()
  }
})

// fetchData 函数变化 → 重新加载
watch(() => props.fetchData, () => {
  if (isServerMode.value) loadData()
})

onMounted(() => {
  if (isServerMode.value) loadData()
})

// ── 事件处理 ──
function rowClasses(row) {
  const parts = []
  if (selectedIds.value.has(String(row[props.idKey]))) parts.push('${namespace}-selected')
  if (props.rowClassName) parts.push(props.rowClassName(row))
  return parts
}

function toggleSort(key) {
  if (sortKey.value === key) {
    sortAsc.value = !sortAsc.value
  } else {
    sortKey.value = key
    sortAsc.value = true
  }
  if (isServerMode.value) {
    currentPage.value = 1
    loadData()
  }
  scrollToTop()
}

function onPageChange({ currentPage: cp, pageSize: ps }) {
  emit('update:currentPage', cp)
  emit('update:pageSize', ps)
  scrollToTop()
  if (isServerMode.value) {
    loadData()
  }
}

function toggleAll(checked) {
  pageData.value.forEach(r => {
    const id = String(r[props.idKey])
    if (checked) selectedIds.value.add(id)
    else selectedIds.value.delete(id)
  })
  notifySelection()
}

function toggleRow(id, checked) {
  if (checked) selectedIds.value.add(id)
  else selectedIds.value.delete(id)
  selectedIds.value = new Set(selectedIds.value)
  notifySelection()
}

function onRowClick(e, row, rowIndex) {
  // 操作按钮点击 → 事件委托：v-html 中的 @click="handlerName" 不会被 Vue 编译，
  // 但作为 DOM 属性存在，通过 getAttribute('@click') 提取 handler 名
  const btn = e.target.closest('button, a')
  if (btn) {
    const actionName = btn.getAttribute('@click')
    if (actionName) {
      // 优先走 rowAction prop（直接调用，无需页面监听事件）
      if (props.rowAction && typeof props.rowAction[actionName] === 'function') {
        props.rowAction[actionName](row, rowIndex)
      }
      // 同时 emit row-action 事件，兼容 @row-action 监听方式
      emit('row-action', { handler: actionName, row, index: rowIndex })
      return
    }
  }
  if (e.target.tagName.toLowerCase() === 'a' && e.target.dataset.action) return
  if (props.drawerRender) openDrawer(row)
  emit('row-click', row)
}

function openDrawer(row) {
  drawerRow.value = row
  drawerOpen.value = true
}

function closeDrawer() {
  drawerOpen.value = false
}

function onDrawerClick(e) {
  if (e.target.closest('.${namespace}-dd-close')) closeDrawer()
}

function notifySelection() {
  emit('selection-change', Array.from(selectedIds.value))
}

function scrollToTop() {
  if (scrollContainer.value) scrollContainer.value.scrollTop = 0
}

/** 手动刷新数据，回到第 1 页 */
function refresh() {
  currentPage.value = 1
  emit('update:currentPage', 1)
  loadData()
}

defineExpose({
  refresh,
  /** 内部加载状态 */
  loading,
  clearSelection: () => {
    selectedIds.value = new Set()
    notifySelection()
  },
})
</script>

<style>
.vue-${namespace}-wrapper {
  display: flex;
  flex: 1;
  height: 100%;
  overflow: hidden;
}
</style>

<style scoped>
/* 核心布局 */
.${namespace}-page-table {
  flex: 1;
  display: flex;
  overflow: hidden;
  background: var(--${namespace}-bg);
}

.${namespace}-list-area {
  flex: 1;
  display: flex;
  flex-direction: column;
  overflow: hidden;
  position: relative;
}

/* ── 加载遮罩 ── */
.${namespace}-page-table__loading-mask {
  position: absolute;
  top: 0; left: 0; right: 0; bottom: 0;
  z-index: 20;
  display: flex;
  align-items: center;
  justify-content: center;
  background: rgba(255, 255, 255, 0.6);
}
.${namespace}-page-table__loading-text {
  padding: 8px 20px;
  background: var(--${namespace}-primary-bg);
  border-radius: 4px;
  font-size: 13px;
  color: var(--${namespace}-primary);
}

.${namespace}-table-container {
  flex: 1;
  overflow: auto;
  position: relative;
  background: var(--${namespace}-bg);
  overscroll-behavior: contain;
  -webkit-overflow-scrolling: auto;
}

/* 表格 */
.${namespace}-table {
  width: 100%;
  table-layout: fixed;
  border-collapse: separate;
  border-spacing: 0;
  font-size: 13px;
  color: var(--${namespace}-t);
}

.${namespace}-table thead th {
  position: sticky;
  top: 0;
  z-index: 10;
  background: var(--${namespace}-pb);
  color: var(--${namespace}-p);
  padding: 8px 10px;
  font-weight: bold;
  text-align: left;
  white-space: nowrap;
  border-bottom: 1px solid var(--${namespace}-pbd);
  border-right: 1px solid var(--${namespace}-pbd);
}

.${namespace}-table thead th:first-child { border-left: 1px solid var(--${namespace}-pbd); }
.${namespace}-table thead th:last-child { border-right: none; }

.${namespace}-table thead th.${namespace}-sortable { cursor: pointer; user-select: none; }
.${namespace}-table thead th.${namespace}-sortable:hover { background: var(--${namespace}-ph); }

.${namespace}-sort-icon { font-size: 10px; margin-left: 4px; opacity: 0.4; }
.${namespace}-table thead th.${namespace}-asc .${namespace}-sort-icon::after { content: '▲'; opacity: 1; }
.${namespace}-table thead th.${namespace}-desc .${namespace}-sort-icon::after { content: '▼'; opacity: 1; }

.${namespace}-table tbody td {
  padding: 6px 10px;
  border-bottom: 1px solid var(--${namespace}-bl);
  border-right: 1px solid var(--${namespace}-bl);
  white-space: nowrap;
  overflow: hidden;
  text-overflow: ellipsis;
  vertical-align: middle;
}
.${namespace}-table tbody td:last-child { border-right: none; }

.${namespace}-table tbody tr:nth-child(even) td { background: var(--${namespace}-bg-page); }
.${namespace}-table tbody tr:hover td { background: var(--${namespace}-primary-bg); cursor: pointer; }
.${namespace}-table tbody tr.${namespace}-selected td { background: var(--${namespace}-primary-hover); }
.${namespace}-table tbody tr.${namespace}-danger td { background: var(--${namespace}-rb); }
.${namespace}-table tbody tr.${namespace}-warning td { background: var(--${namespace}-ob); }
.${namespace}-table tbody tr.${namespace}-danger:hover td,
.${namespace}-table tbody tr.${namespace}-warning:hover td { background: var(--${namespace}-primary-bg); }

.${namespace}-tc { text-align: center; }

/* 分页 — 穿透 PtPagination 子组件 */
.${namespace}-list-area :deep(.${namespace}-pagination) {
  flex-shrink: 0;
  display: flex;
  align-items: center;
  gap: 4px;
  padding: 8px 14px;
  background: var(--${namespace}-bg);
  border-top: 1px solid var(--${namespace}-bd);
  font-size: 12px;
  color: var(--${namespace}-t);
  z-index: 20;
}

.${namespace}-list-area :deep(.${namespace}-pg-info) {
  display: flex;
  align-items: center;
  gap: 5px;
  color: var(--${namespace}-tm);
  margin-right: auto;
}

.${namespace}-list-area :deep(.${namespace}-pg-size) {
  height: 24px;
  border: 1px solid var(--${namespace}-bd);
  padding: 0 4px;
  border-radius: 2px;
  outline: none;
}

.${namespace}-list-area :deep(.${namespace}-pg-controls) {
  display: flex;
  align-items: center;
  gap: 4px;
}

.${namespace}-list-area :deep(.${namespace}-pg-btn) {
  height: 24px;
  min-width: 24px;
  padding: 0 6px;
  background: var(--${namespace}-bg);
  border: 1px solid var(--${namespace}-bd);
  color: var(--${namespace}-t);
  border-radius: 2px;
  cursor: pointer;
  display: flex;
  align-items: center;
  justify-content: center;
}

.${namespace}-list-area :deep(.${namespace}-pg-btn:hover:not(:disabled)) {
  border-color: var(--${namespace}-p);
  color: var(--${namespace}-p);
}

.${namespace}-list-area :deep(.${namespace}-pg-btn.${namespace}-on) {
  background: var(--${namespace}-p);
  color: var(--${namespace}-bg);
  border-color: var(--${namespace}-p);
}

.${namespace}-list-area :deep(.${namespace}-pg-btn:disabled) {
  opacity: 0.5;
  cursor: not-allowed;
  background: var(--${namespace}-bg-page);
}

.${namespace}-list-area :deep(.${namespace}-pg-ellipsis) {
  font-size: 12px;
  color: var(--${namespace}-tl);
  padding: 0 2px;
}

/* 右侧抽屉 */
.${namespace}-drawer {
  width: 360px;
  background: var(--${namespace}-bg);
  border-left: 1px solid var(--${namespace}-border-light);
  flex-shrink: 0;
  display: flex;
  flex-direction: column;
  transition: width 0.25s ease-in-out;
  overflow: hidden;
  box-shadow: -2px 0 8px rgba(0,0,0,0.05);
  z-index: 30;
}

.${namespace}-drawer.${namespace}-drawer-closed { width: 0; border-left: none; }

/* 抽屉内容（v-html 渲染，需要 :deep() 穿透） */
.${namespace}-drawer :deep(.${namespace}-dd-head) {
  background: var(--${namespace}-p);
  color: var(--${namespace}-bg);
  padding: 10px 14px;
  display: flex;
  align-items: center;
  justify-content: space-between;
  flex-shrink: 0;
}

.${namespace}-drawer :deep(.${namespace}-dd-title) {
  font-size: 14px;
  font-weight: bold;
  overflow: hidden;
  text-overflow: ellipsis;
  white-space: nowrap;
}

.${namespace}-drawer :deep(.${namespace}-dd-close) {
  cursor: pointer;
  font-size: 16px;
  opacity: 0.8;
}

.${namespace}-drawer :deep(.${namespace}-dd-close:hover) { opacity: 1; }

.${namespace}-drawer :deep(.${namespace}-dd-body) {
  flex: 1;
  overflow-y: auto;
  padding: 0;
}

.${namespace}-drawer :deep(.${namespace}-dd-sec-head) {
  background: var(--${namespace}-bgp);
  color: var(--${namespace}-p);
  padding: 6px 12px;
  font-size: 12px;
  font-weight: bold;
  border-bottom: 1px solid var(--${namespace}-pbd);
}

.${namespace}-drawer :deep(.${namespace}-dd-row) {
  display: flex;
  border-bottom: 1px solid var(--${namespace}-bl);
}

.${namespace}-drawer :deep(.${namespace}-dd-label) {
  width: 90px;
  flex-shrink: 0;
  background: var(--${namespace}-bgp);
  color: var(--${namespace}-tm);
  padding: 8px 12px;
  border-right: 1px solid var(--${namespace}-pbd);
  font-size: 12px;
}

.${namespace}-drawer :deep(.${namespace}-dd-val) {
  flex: 1;
  padding: 8px 12px;
  font-size: 12px;
  color: var(--${namespace}-t);
  word-break: break-all;
  line-height: 1.4;
}
</style>
