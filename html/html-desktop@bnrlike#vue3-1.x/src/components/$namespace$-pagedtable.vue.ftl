<template>
  <div class="${namespace}-page-table">
    <div class="${namespace}-list-area">
      <div class="${namespace}-table-container" ref="scrollContainer">
        <table class="${namespace}-table">
          <thead>
            <tr>
              <th style="width:40px" class="${namespace}-tc">
                <input type="checkbox" :checked="isAllChecked" @change="toggleAll($event.target.checked)" style="width:14px;height:14px;accent-color:var(--p);cursor:pointer">
              </th>
              <th v-for="col in columns" :key="col.key"
                :style="{ width: col.width || '', textAlign: col.align || 'left' }"
                :class="{ '${namespace}-sortable': col.sortable, '${namespace}-asc': sortKey === col.key && sortAsc, '${namespace}-desc': sortKey === col.key && !sortAsc }"
                @click="col.sortable && toggleSort(col.key)">
                {{ col.title }}
                <span v-if="col.sortable" class="${namespace}-sort-icon"></span>
              </th>
            </tr>
          </thead>
          <tbody>
            <tr v-if="pageData.length === 0">
              <td :colspan="columns.length + 1" class="${namespace}-tc" style="padding:40px;color:var(--tl)">暂无数据</td>
            </tr>
            <tr v-for="row in pageData" :key="String(row[idKey])"
              :data-id="String(row[idKey])"
              :class="rowClasses(row)"
              @click="onRowClick($event, row)">
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
import { ref, computed, watch } from 'vue'
import ${js.nameType(namespace)}Pagination from './${namespace}-pagination.vue'

const props = defineProps({
  data:         { type: Array,    default: () => [] },
  columns:      { type: Array,    required: true },
  currentPage:  { type: Number,   default: 1 },
  pageSize:     { type: Number,   default: 20 },
  idKey:        { type: String,   default: 'id' },
  rowClassName: { type: Function, default: null },
  drawerRender: { type: Function, default: null },
  // 服务端分页模式：传入 fetchData 后，页码/页大小/排序变化时自动调用，参数 { currentPage, pageSize, sortKey, sortAsc }
  fetchData:    { type: Function, default: null },
  // 服务端分页模式：数据总条数（用于分页条显示）
  total:        { type: Number,   default: 0 },
})

const emit = defineEmits(['update:currentPage', 'update:pageSize', 'selection-change', 'row-click'])

const currentPage = ref(props.currentPage)
const pageSize = ref(props.pageSize)
const sortKey = ref(null)
const sortAsc = ref(true)
const selectedIds = ref(new Set())
const drawerOpen = ref(false)
const drawerRow = ref(null)
const scrollContainer = ref(null)

watch(() => props.data, () => {
  if (!isServerMode.value) currentPage.value = 1
})

watch(() => props.currentPage, (v) => {
  currentPage.value = v
})

watch(() => props.pageSize, (v) => {
  pageSize.value = v
})

const isServerMode = computed(() => typeof props.fetchData === 'function')

const displayData = computed(() => {
  if (isServerMode.value) return props.data
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
  if (isServerMode.value) return props.data
  const start = (currentPage.value - 1) * pageSize.value
  return displayData.value.slice(start, start + pageSize.value)
})

const paginationTotal = computed(() => isServerMode.value ? props.total : displayData.value.length)

const isAllChecked = computed(() =>
  pageData.value.length > 0 && pageData.value.every(r => selectedIds.value.has(String(r[props.idKey])))
)

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
    // props.fetchData({ currentPage: 1, pageSize: pageSize.value, sortKey: sortKey.value, sortAsc: sortAsc.value })
    props.fetchData(1, pageSize.value)
  }
  scrollToTop()
}

function onPageChange({ currentPage: cp, pageSize: ps }) {
  scrollToTop()
  if (isServerMode.value) {
    // props.fetchData({ pageNumber: cp, pageSize: ps, sortKey: sortKey.value, sortAsc: sortAsc.value })
    props.fetchData(cp, ps)
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
  // trigger reactivity for Set
  selectedIds.value = new Set(selectedIds.value)
  notifySelection()
}

function onRowClick(e, row) {
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

defineExpose({
  clearSelection: () => {
    selectedIds.value = new Set()
    notifySelection()
  },
})
</script>

<style>
:root {
  --${namespace}-p: #1a4f8a; --${namespace}-pd: #15407a; --${namespace}-ph: #d0e0f5;
  --${namespace}-pb: #e8edf5; --${namespace}-pbd: #d0d8e8;
  --${namespace}-bl: #e4e8f0; --${namespace}-bd: #c8c8c8; --${namespace}-bg: #fff; --${namespace}-bgp: #f0f2f5;
  --${namespace}-t: #1c2833; --${namespace}-tm: #5d6d7e; --${namespace}-tl: #909eac;
  --${namespace}-rb: #fcecea; --${namespace}-ob: #fef3e6;
}

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
}

.${namespace}-table-container {
  flex: 1;
  overflow: auto;
  position: relative;
  background: #fff;
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

.${namespace}-table tbody tr:nth-child(even) td { background: #fafbfc; }
.${namespace}-table tbody tr:hover td { background: #eef5ff; cursor: pointer; }
.${namespace}-table tbody tr.${namespace}-selected td { background: #e0edff; }
.${namespace}-table tbody tr.${namespace}-danger td { background: var(--${namespace}-rb); }
.${namespace}-table tbody tr.${namespace}-warning td { background: var(--${namespace}-ob); }
.${namespace}-table tbody tr.${namespace}-danger:hover td,
.${namespace}-table tbody tr.${namespace}-warning:hover td { background: #eef5ff; }

.${namespace}-tc { text-align: center; }

/* 分页 — 穿透 BnrPagination 子组件 */
.${namespace}-list-area :deep(.${namespace}-pagination) {
  flex-shrink: 0;
  display: flex;
  align-items: center;
  gap: 4px;
  padding: 8px 14px;
  background: #fff;
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
  background: #fff;
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
  color: #fff;
  border-color: var(--${namespace}-p);
}

.${namespace}-list-area :deep(.${namespace}-pg-btn:disabled) {
  opacity: 0.5;
  cursor: not-allowed;
  background: #f5f5f5;
}

.${namespace}-list-area :deep(.${namespace}-pg-ellipsis) {
  font-size: 12px;
  color: var(--${namespace}-tl);
  padding: 0 2px;
}

/* 右侧抽屉 */
.${namespace}-drawer {
  width: 360px;
  background: #fff;
  border-left: 1px solid #ddd;
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
  color: #fff;
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
