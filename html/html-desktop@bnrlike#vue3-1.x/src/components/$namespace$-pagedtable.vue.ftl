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
      <BnrPagination
        :total="displayData.length"
        v-model:current-page="currentPage"
        v-model:page-size="pageSize"
        :page-sizes="[10, 20, 50, 100]"
        @change="scrollToTop"
      />
    </div>
    <div class="${namespace}-drawer" :class="{ '${namespace}-drawer-closed': !drawerOpen }" @click="onDrawerClick">
      <div v-if="drawerOpen && drawerRender" v-html="drawerRender(drawerRow)"></div>
    </div>
  </div>
</template>

<script setup>
import { ref, computed, watch } from 'vue'
import BnrPagination from './BnrPagination.vue'

const props = defineProps({
  data:         { type: Array,    default: () => [] },
  columns:      { type: Array,    required: true },
  currentPage:  { type: Number,   default: 1 },
  pageSize:     { type: Number,   default: 20 },
  idKey:        { type: String,   default: 'id' },
  rowClassName: { type: Function, default: null },
  drawerRender: { type: Function, default: null },
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
  currentPage.value = 1
})

watch(() => props.currentPage, (v) => {
  currentPage.value = v
})

watch(() => props.pageSize, (v) => {
  pageSize.value = v
})

const displayData = computed(() => {
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
  const start = (currentPage.value - 1) * pageSize.value
  return displayData.value.slice(start, start + pageSize.value)
})

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
  scrollToTop()
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
<style scoped>
.${namespace}-page-table {
  flex: 1;
  display: flex;
  overflow: hidden;
  background: var(--${namespace}-bg);
}

.${namespace}-list-area {
  flex: 1;
  display: flex;
  flex-direction: column; /* 垂直排布 */
  overflow: hidden;
}

/* 滚动区域: 占用除了分页外的所有剩余空间 */
.${namespace}-table-container {
  flex: 1;
  overflow: auto;
  position: relative;
  background: #fff;
}

/* 固定在底部的分页栏 */
.${namespace}-pagination {
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
/* 表格样式 */
.${namespace}-table {
  width: 100%;
  table-layout: fixed;
  border-collapse: separate; /* 必须用 separate 才能完美兼容 sticky header 的边框 */
  border-spacing: 0;
  font-size: 13px;
  color: var(--${namespace}-t);
}

/* 表头固定在顶部 */
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

  /* 解决 border-collapse: separate 带来的边框问题 */
  border-bottom: 1px solid var(--${namespace}-pbd);
  border-right: 1px solid var(--${namespace}-pbd);
}
/* 补充左上边框 */
.${namespace}-table thead th:first-child { border-left: 1px solid var(--${namespace}-pbd); }
.${namespace}-table thead th:last-child { border-right: none; }

.${namespace}-table thead th.${namespace}-sortable { cursor: pointer; user-select: none; }
.${namespace}-table thead th.${namespace}-sortable:hover { background: var(--${namespace}-ph); }
.${namespace}-sort-icon { font-size: 10px; margin-left: 4px; opacity: 0.4; }
.${namespace}-table thead th.${namespace}-asc .${namespace}-sort-icon::after { content: '▲'; opacity: 1; }
.${namespace}-table thead th.${namespace}-desc .${namespace}-sort-icon::after { content: '▼'; opacity: 1; }

/* 表身单元格 */
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
.${namespace}-table tbody tr.${namespace}-danger:hover td, .${namespace}-table tbody tr.${namespace}-warning:hover td { background: #eef5ff; }

/* 分页子组件样式 */
.${namespace}-pg-info { display: flex; align-items: center; gap: 5px; color: var(--${namespace}-tm); margin-right: auto; }
.${namespace}-pg-size { height: 24px; border: 1px solid var(--${namespace}-bd); padding: 0 4px; border-radius: 2px; outline: none; }
.${namespace}-pg-controls { display: flex; align-items: center; gap: 4px; }
.${namespace}-pg-btn {
  height: 24px; min-width: 24px; padding: 0 6px;
  background: #fff; border: 1px solid var(--${namespace}-bd);
  color: var(--${namespace}-t); border-radius: 2px;
  cursor: pointer; display: flex; align-items: center; justify-content: center;
}
.${namespace}-pg-btn:hover:not(:disabled) { border-color: var(--${namespace}-p); color: var(--${namespace}-p); }
.${namespace}-pg-btn.${namespace}-on { background: var(--${namespace}-p); color: #fff; border-color: var(--${namespace}-p); }
.${namespace}-pg-btn:disabled { opacity: 0.5; cursor: not-allowed; background: #f5f5f5; }

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
.${namespace}-dd-head { background: var(--${namespace}-p); color: #fff; padding: 10px 14px; display: flex; align-items: center; justify-content: space-between; flex-shrink: 0; }
.${namespace}-dd-title { font-size: 14px; font-weight: bold; overflow: hidden; text-overflow: ellipsis; white-space: nowrap; }
.${namespace}-dd-close { cursor: pointer; font-size: 16px; opacity: 0.8; }
.${namespace}-dd-close:hover { opacity: 1; }
.${namespace}-dd-body { flex: 1; overflow-y: auto; padding: 0; }

/* 抽屉内容区常用样式预设 */
.${namespace}-dd-sec-head { background: var(--${namespace}-bgp); color: var(--${namespace}-p); padding: 6px 12px; font-size: 12px; font-weight: bold; border-bottom: 1px solid var(--${namespace}-pbd); }
.${namespace}-dd-row { display: flex; border-bottom: 1px solid var(--${namespace}-bl); }
.${namespace}-dd-label { width: 90px; flex-shrink: 0; background: var(--${namespace}-bgp); color: var(--${namespace}-tm); padding: 8px 12px; border-right: 1px solid var(--${namespace}-pbd); font-size: 12px; }
.${namespace}-dd-val { flex: 1; padding: 8px 12px; font-size: 12px; color: var(--${namespace}-t); word-break: break-all; line-height: 1.4; }

.${namespace}-tc { text-align: center; }
</style>