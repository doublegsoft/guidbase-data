<template>
  <div class="${namespace}-page-table">
    <div class="${namespace}-list-area">
      <!-- 极客蓝图加载遮罩 -->
      <div v-if="loading" class="${namespace}-page-table__loading-mask">
        <span class="${namespace}-page-table__loading-text">LOADING...</span>
      </div>

      <div ref="scrollContainer" class="${namespace}-table-container">
        <table class="${namespace}-table">
          <thead>
            <tr>
              <th style="width: 28px" class="${namespace}-tc">
                <input
                  type="checkbox"
                  class="${namespace}-checkbox"
                  :checked="isAllChecked"
                  @change="toggleAll($event.target.checked)"
                >
              </th>
              <th
                v-for="col in columns"
                :key="col.key"
                :style="{ width: col.width || '', textAlign: col.align || 'left' }"
                :class="{
                  '${namespace}-sortable': col.sortable,
                  '${namespace}-asc': sortKey === col.key && sortAsc,
                  '${namespace}-desc': sortKey === col.key && !sortAsc
                }"
                @click="col.sortable && toggleSort(col.key)"
              >
                <span>{{ col.title }}</span>
                <span v-if="col.sortable" class="${namespace}-sort-icon"></span>
              </th>
            </tr>
          </thead>
          <tbody>
            <tr v-if="pageData.length === 0">
              <td :colspan="columns.length + 1" class="${namespace}-tc" style="padding: 24px; color: var(--${namespace}-mu, #6f7fb4); font-weight: 700;">
                {{ loading ? 'FETCHING PACKETS...' : 'NO DATA' }}
              </td>
            </tr>
            <tr
              v-for="(row, rowIndex) in pageData"
              :key="getRowKey(row, rowIndex)"
              :data-id="getRowKey(row, rowIndex)"
              :class="rowClasses(row, rowIndex)"
              @click="onRowClick($event, row, rowIndex)"
            >
              <td class="${namespace}-tc" @click.stop>
                <input
                  type="checkbox"
                  class="${namespace}-checkbox"
                  :checked="selectedIds.has(getRowKey(row, rowIndex))"
                  @change="toggleRow(row, rowIndex, $event.target.checked)"
                >
              </td>
              <td v-for="col in columns" :key="col.key" :style="{ textAlign: col.align || 'left' }">
                <!-- 自定义 render -->
                <span v-if="col.render" class="${namespace}-cell-render" v-html="col.render(formatCell(row[col.key]), row) ?? ''"></span>
                <!-- 默认展示 -->
                <template v-else>{{ formatCell(row[col.key]) }}</template>
              </td>
            </tr>
          </tbody>
        </table>
      </div>

      <!-- 分页栏 -->
      <${namespace}-pagination
        :total="paginationTotal"
        v-model:current-page="currentPage"
        v-model:page-size="pageSize"
        :page-sizes="[10, 20, 50, 100]"
        @change="onPageChange"
      />
    </div>

    <!-- 右侧检查抽屉 (Inspector Drawer) -->
    <div class="${namespace}-drawer" :class="{ '${namespace}-drawer-closed': !drawerOpen }" @click="onDrawerClick">
      <div v-if="drawerOpen && drawerRender" class="${namespace}-drawer__content" v-html="drawerRender(drawerRow)"></div>
    </div>
  </div>
</template>

<script setup>
import { ref, computed, watch, onMounted } from 'vue'
import ${js.nameType(namespace)}Pagination from './${namespace}-pagination.vue'

const props = defineProps({
  data:         { type: Array,    default: () => [] },
  columns:      { type: Array,    required: true },
  currentPage:  { type: Number,   default: 1 },
  pageSize:     { type: Number,   default: 20 },
  idKey:        { type: String,   default: 'id' },
  rowClassName: { type: Function, default: null },
  drawerRender: { type: Function, default: null },
  total:        { type: Number,   default: 0 },
  fetchData:    { type: Function, default: null },
  fetchParams:  { type: Object,   default: () => ({}) },
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

function getRowKey(row, index) {
  if (!row) return String(index)
  const val = row[props.idKey]
  if (val !== undefined && val !== null && val !== '') {
    return String(val)
  }
  if (row.key !== undefined && row.key !== null) return String(row.key)
  if (row._id !== undefined && row._id !== null) return String(row._id)
  return 'row_idx_' + index
}

function formatCell(val) {
  if (val === undefined || val === null || val === 'undefined') return ''
  return val
}

const isServerMode = computed(() => typeof props.fetchData === 'function')
const internalData = ref([])
const internalTotal = ref(0)
const loading = ref(false)
let reqId = 0

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

const isAllChecked = computed(() => {
  if (!pageData.value || pageData.value.length === 0) return false
  return pageData.value.every((r, idx) => selectedIds.value.has(getRowKey(r, idx)))
})

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

watch(() => props.fetchParams, () => {
  if (isServerMode.value) {
    currentPage.value = 1
    emit('update:currentPage', 1)
    loadData()
  }
})

watch(() => props.fetchData, () => {
  if (isServerMode.value) loadData()
})

onMounted(() => {
  if (isServerMode.value) loadData()
})

function rowClasses(row, index) {
  const parts = []
  const key = getRowKey(row, index)
  if (selectedIds.value.has(key)) parts.push('${namespace}-selected')
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
  const nextSet = new Set(selectedIds.value)
  pageData.value.forEach((r, idx) => {
    const key = getRowKey(r, idx)
    if (checked) nextSet.add(key)
    else nextSet.delete(key)
  })
  selectedIds.value = nextSet
  notifySelection()
}

function toggleRow(row, index, checked) {
  const key = getRowKey(row, index)
  const nextSet = new Set(selectedIds.value)
  if (checked) {
    nextSet.add(key)
  } else {
    nextSet.delete(key)
  }
  selectedIds.value = nextSet
  notifySelection()
}

function onRowClick(e, row, rowIndex) {
  const btn = e.target.closest('button, a')
  if (btn) {
    const actionName = btn.getAttribute('@click')
    if (actionName) {
      if (props.rowAction && typeof props.rowAction[actionName] === 'function') {
        props.rowAction[actionName](row, rowIndex)
      }
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

function refresh() {
  currentPage.value = 1
  emit('update:currentPage', 1)
  loadData()
}

defineExpose({
  refresh,
  loading,
  clearSelection: () => {
    selectedIds.value = new Set()
    notifySelection()
  },
})
</script>

<style scoped>
/* ══════════════════════════════════════════════
   Protocol Explorer PageTable (极限紧凑工程版)
   ══════════════════════════════════════════════ */
.${namespace}-page-table {
  flex: 1;
  display: flex;
  overflow: hidden;
  background: var(--${namespace}-bg, #f4f6fb);
  font-family: var(--${namespace}-f, "IBM Plex Mono", monospace);
}

.${namespace}-list-area {
  flex: 1;
  display: flex;
  flex-direction: column;
  overflow: hidden;
  position: relative;
  background: var(--${namespace}-pn, #ffffff);
  border: 1px solid var(--${namespace}-ln, #d3dbef);
}

/* ── 加载遮罩 ── */
.${namespace}-page-table__loading-mask {
  position: absolute;
  inset: 0;
  z-index: 50;
  display: flex;
  align-items: center;
  justify-content: center;
  background: rgba(244, 246, 251, 0.75);
}
.${namespace}-page-table__loading-text {
  padding: 4px 10px;
  background: var(--${namespace}-pn, #ffffff);
  border: 1px solid var(--${namespace}-ink, #0a2a9a);
  font-size: 11px;
  font-weight: 700;
  letter-spacing: .08em;
  color: var(--${namespace}-pri, #0a2fb5);
}

.${namespace}-table-container {
  flex: 1;
  overflow: auto;
  position: relative;
  background: var(--${namespace}-pn, #ffffff);
}

/* ── 表格主体 (高密度压缩) ── */
.${namespace}-table {
  width: 100%;
  table-layout: fixed;
  border-collapse: collapse;
  white-space: nowrap;
  font-size: 12px;
  color: var(--${namespace}-ink, #0a2a9a);
}

/* 表头：26px 高度紧凑压缩 */
.${namespace}-table thead th {
  position: sticky;
  top: 0;
  z-index: 10;
  background: var(--${namespace}-pn, #ffffff);
  color: var(--${namespace}-ink, #0a2a9a);
  padding: 3px 6px;
  height: 26px;
  font-size: 11px;
  font-weight: 700;
  letter-spacing: .04em;
  text-transform: uppercase;
  border-bottom: 2px solid var(--${namespace}-ink, #0a2a9a);
  border-right: 1px solid var(--${namespace}-ln, #d3dbef);
  box-sizing: border-box;
}
.${namespace}-table thead th:last-child {
  border-right: none;
}

.${namespace}-table thead th.${namespace}-sortable {
  cursor: pointer;
  user-select: none;
}
.${namespace}-table thead th.${namespace}-sortable:hover {
  background: color-mix(in srgb, var(--${namespace}-ln, #d3dbef) 35%, transparent);
}
.${namespace}-sort-icon {
  margin-left: 3px;
  font-size: 9px;
}
.${namespace}-sort-icon::after {
  content: '▿';
  color: var(--${namespace}-mu, #6f7fb4);
}
.${namespace}-table thead th.${namespace}-asc .${namespace}-sort-icon::after {
  content: '▲';
  color: var(--${namespace}-pri, #0a2fb5);
}
.${namespace}-table thead th.${namespace}-desc .${namespace}-sort-icon::after {
  content: '▼';
  color: var(--${namespace}-pri, #0a2fb5);
}

/* 单元格：24px 极致行高，严禁折行撑大 */
.${namespace}-table tbody td {
  padding: 2px 6px;
  height: 24px;
  border-top: 1px solid var(--${namespace}-ln, #d3dbef);
  border-right: 1px solid var(--${namespace}-ln, #d3dbef);
  overflow: hidden;
  text-overflow: ellipsis;
  vertical-align: middle;
  line-height: 1.2;
  box-sizing: border-box;
}
.${namespace}-table tbody td:last-child {
  border-right: none;
}

/* ── 核心改造：单元格内部所有按钮微型化 (Micro Buttons) ── */
.${namespace}-table tbody td :deep(button),
.${namespace}-table tbody td :deep(.${namespace}-btn),
.${namespace}-cell-render :deep(button),
.${namespace}-cell-render :deep(.${namespace}-btn) {
  height: 19px !important;
  line-height: 17px !important;
  min-height: 19px !important;
  padding: 0 5px !important;
  font-size: 11px !important;
  font-family: inherit !important;
  font-weight: 600 !important;
  letter-spacing: 0 !important;
  border-width: 1px !important;
  border-radius: 0 !important;
  box-sizing: border-box !important;
  display: inline-flex !important;
  align-items: center !important;
  justify-content: center !important;
  margin: 0 2px !important;
  vertical-align: middle !important;
}

/* 单元格内链接微型化 */
.${namespace}-table tbody td :deep(a),
.${namespace}-cell-render :deep(a) {
  font-size: 11px !important;
  padding: 0 2px !important;
  line-height: 18px !important;
  display: inline-block !important;
  vertical-align: middle !important;
  text-decoration: underline;
  cursor: pointer;
}

/* 单元格微型标签徽章 */
.${namespace}-table tbody td :deep(.${namespace}-tag),
.${namespace}-table tbody td :deep(.${namespace}-pill) {
  height: 16px !important;
  line-height: 14px !important;
  padding: 0 4px !important;
  font-size: 10px !important;
  gap: 2px !important;
  vertical-align: middle !important;
}

/* 行悬停与高亮状态 */
.${namespace}-table tbody tr:hover td {
  background: color-mix(in srgb, var(--${namespace}-ln, #d3dbef) 30%, transparent);
  cursor: pointer;
}
.${namespace}-table tbody tr.${namespace}-selected td {
  background: color-mix(in srgb, var(--${namespace}-pri, #0a2fb5) 12%, transparent);
  font-weight: 600;
}
.${namespace}-table tbody tr.${namespace}-danger td {
  background: var(--${namespace}-sel, #fdecee);
  color: var(--${namespace}-red, #d6343e);
}
.${namespace}-table tbody tr.${namespace}-warning td {
  background: color-mix(in srgb, var(--${namespace}-cmd, #f0a500) 15%, transparent);
}

.${namespace}-tc {
  text-align: center;
}

/* ── 12px 极简直角复选框 ── */
.${namespace}-checkbox {
  appearance: none;
  width: 12px;
  height: 12px;
  border: 1px solid var(--${namespace}-ink, #0a2a9a);
  border-radius: 0;
  background: var(--${namespace}-pn, #ffffff);
  cursor: pointer;
  outline: none;
  vertical-align: middle;
  position: relative;
  transition: .1s;
  box-sizing: border-box;
  margin: 0;
}
.${namespace}-checkbox:checked {
  background: var(--${namespace}-pri, #0a2fb5);
  border-color: var(--${namespace}-pri, #0a2fb5);
}
.${namespace}-checkbox:checked::after {
  content: '';
  position: absolute;
  left: 2px;
  top: 2px;
  width: 6px;
  height: 6px;
  background: var(--${namespace}-on, #ffffff);
}

/* ── 紧凑抽屉 (Inspector Drawer) ── */
.${namespace}-drawer {
  width: 320px;
  background: var(--${namespace}-pn, #ffffff);
  border-left: 1px solid var(--${namespace}-ink, #0a2a9a);
  flex-shrink: 0;
  display: flex;
  flex-direction: column;
  transition: width 0.2s cubic-bezier(0.16, 1, 0.3, 1);
  overflow: hidden;
  z-index: 30;
}
.${namespace}-drawer.${namespace}-drawer-closed {
  width: 0;
  border-left: none;
}

.${namespace}-drawer__content {
  flex: 1;
  display: flex;
  flex-direction: column;
  height: 100%;
}

.${namespace}-drawer :deep(.${namespace}-dd-head) {
  background: var(--${namespace}-ink, #0a2a9a);
  color: var(--${namespace}-on, #ffffff);
  padding: 6px 10px;
  height: 28px;
  display: flex;
  align-items: center;
  justify-content: space-between;
  flex-shrink: 0;
  box-sizing: border-box;
}
.${namespace}-drawer :deep(.${namespace}-dd-title) {
  font-size: 12px;
  font-weight: 700;
  letter-spacing: .06em;
  text-transform: uppercase;
  overflow: hidden;
  text-overflow: ellipsis;
  white-space: nowrap;
}
.${namespace}-drawer :deep(.${namespace}-dd-close) {
  cursor: pointer;
  font-size: 14px;
  font-weight: 700;
  line-height: 1;
  background: none;
  border: none;
  color: #fff;
}
.${namespace}-drawer :deep(.${namespace}-dd-close:hover) {
  color: var(--${namespace}-red, #d6343e);
}
.${namespace}-drawer :deep(.${namespace}-dd-body) {
  flex: 1;
  overflow-y: auto;
  padding: 0;
}
.${namespace}-drawer :deep(.${namespace}-dd-row) {
  display: flex;
  border-bottom: 1px solid var(--${namespace}-ln, #d3dbef);
}
.${namespace}-drawer :deep(.${namespace}-dd-label) {
  width: 80px;
  flex-shrink: 0;
  background: var(--${namespace}-bg, #f4f6fb);
  color: var(--${namespace}-ink, #0a2a9a);
  font-weight: 700;
  padding: 5px 8px;
  border-right: 1px solid var(--${namespace}-ln, #d3dbef);
  font-size: 11px;
}
.${namespace}-drawer :deep(.${namespace}-dd-val) {
  flex: 1;
  padding: 5px 8px;
  font-size: 11px;
  color: var(--${namespace}-ink, #0a2a9a);
  word-break: break-all;
  line-height: 1.3;
}
</style>