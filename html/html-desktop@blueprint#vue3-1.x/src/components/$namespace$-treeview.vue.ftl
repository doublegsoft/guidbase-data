<template>
  <div class="${namespace}-tree-ft" :style="{ height: height }">
    <!-- 顶部工具栏（搜索、展开/折叠全部） -->
    <div v-if="showToolbar" class="${namespace}-tree-ft__toolbar">
      <div class="${namespace}-tree-ft__search">
        <svg class="icon-search" viewBox="0 0 16 16">
          <circle cx="7" cy="7" r="4.5" fill="none" stroke="currentColor" stroke-width="1.6" />
          <path d="M10.5 10.5 14 14" fill="none" stroke="currentColor" stroke-width="1.6" stroke-linecap="round" />
        </svg>
        <input 
          v-model="searchQuery" 
          placeholder="Filter tree nodes…" 
          class="${namespace}-tree-ft__search-input"
        />
      </div>
      <button class="${namespace}-tree-ft__tool-btn" @click="expandAll">Expand all</button>
      <button class="${namespace}-tree-ft__tool-btn" @click="collapseAll">Collapse all</button>
      <span class="${namespace}-tree-ft__count-info">{{ visibleRows.length }} items</span>
    </div>

    <!-- 滚动阴影 -->
    <div class="${namespace}-tree-ft__shadow ${namespace}-tree-ft__shadow--left" :class="{ 'is-visible': showLeftShadow }"></div>
    <div class="${namespace}-tree-ft__shadow ${namespace}-tree-ft__shadow--right" :class="{ 'is-visible': showRightShadow }"></div>

    <div
      ref="wrapRef"
      class="${namespace}-tree-ft__wrap"
      tabindex="0"
      @keydown="onKeydown"
      @scroll="onScroll"
    >
      <table class="${namespace}-tree-ft__table">
        <thead>
          <tr>
            <th
              v-for="col in columns"
              :key="col.key"
              :class="thClasses(col)"
              :style="colStyle(col)"
            >
              {{ col.title }}
            </th>
          </tr>
        </thead>
        <tbody>
          <tr v-if="visibleRows.length === 0">
            <td :colspan="columns.length" class="${namespace}-tree-ft__empty">
              No matching records found.
            </td>
          </tr>

          <!-- 扁平化展示可视的树节点行 -->
          <tr
            v-for="(row, rowIndex) in visibleRows"
            :key="row._nodePath"
            :class="rowClasses(row)"
            @click="onRowClick($event, row, rowIndex)"
          >
            <td
              v-for="col in columns"
              :key="col.key"
              :class="tdClasses(col)"
              :style="colStyle(col)"
            >
              <!-- 树主干列（缩进、展开/折叠三角、图标及高亮） -->
              <div 
                v-if="col.isTreeColumn" 
                class="${namespace}-tree-ft__node-cell"
                :style="{ paddingLeft: (row._level * indentSize) + 'px' }"
              >
                <!-- 展开折叠手柄 -->
                <span 
                  class="${namespace}-tree-ft__chevron"
                  :class="{ 
                    'is-leaf': !row.hasChildren,
                    'is-open': expandedSet.has(row._nodePath)
                  }"
                  @click.stop="toggleExpand(row)"
                >
                  <svg v-if="row.hasChildren" viewBox="0 0 16 16" class="icon-chev">
                    <path d="M6 3l5 5-5 5" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round" />
                  </svg>
                </span>

                <!-- 节点图标 / 文件类型图标 -->
                <span 
                  v-if="typeColors[row.type] || row.hasChildren" 
                  class="${namespace}-tree-ft__type-badge" 
                  :style="{ background: typeColors[row.type] || '#c9a24a' }"
                >
                  {{ row.hasChildren ? 'DIR' : (row.type || 'TXT').slice(0, 3).toUpperCase() }}
                </span>

                <!-- 节点文字标签（带过滤高亮） -->
                <span class="${namespace}-tree-ft__node-title" v-html="highlightText(row[col.key])"></span>
              </div>

              <!-- 其他普通属性列 -->
              <template v-else>
                <span v-if="col.render" v-html="col.render(getCellValue(row, col), row) ?? ''"></span>
                <template v-else>{{ getCellValue(row, col) }}</template>
              </template>
            </td>
          </tr>
        </tbody>
      </table>
    </div>
  </div>
</template>

<script setup>
import { ref, computed, watch, onMounted, nextTick } from 'vue'

const props = defineProps({
  columns: {
    type: Array,
    required: true,
  },
  treeData: {
    type: Array,
    default: () => [],
  },
  height: { type: String, default: '500px' },
  indentSize: { type: Number, default: 18 },
  showToolbar: { type: Boolean, default: true },
  rowAction: { type: Object, default: null },
  typeColors: {
    type: Object,
    default: () => ({
      folder: '#c9a24a',
      json: '#c58a2b',
      fig: '#8b5cf6',
      tsx: '#2f7de1',
      ts: '#2f7de1',
      md: '#5b6b7a',
      txt: '#8b8881',
    }),
  },
})

const emit = defineEmits([
  'node-click',
  'node-select',
  'row-action',
  'expand-change'
])

const wrapRef = ref(null)
const showLeftShadow = ref(false)
const showRightShadow = ref(false)
const searchQuery = ref('')
const selectedPath = ref('')
const expandedSet = ref(new Set())

// 单元格防 undefined 过滤
function getCellValue(row, col) {
  const val = row[col.key]
  return val === undefined ? '' : val
}

// 递归拍平树结构【已移除 ES6 模板字符串，避免 FreeMarker 误解析】
function flattenTree(nodes, parentPath = '', level = 0, query = '') {
  const result = []

  for (const node of nodes) {
    // 改用纯 JS 字符串拼接
    const currentPath = parentPath ? (parentPath + '/' + node.name) : node.name
    const children = node.children || node.c
    const hasChildren = Array.isArray(children) && children.length > 0

    const hit = !query || node.name.toLowerCase().includes(query)
    let matchingChildren = []
    
    if (hasChildren) {
      matchingChildren = flattenTree(children, currentPath, level + 1, query)
    }

    if (hit || matchingChildren.length > 0) {
      const flattenedNode = {
        ...node,
        _nodePath: currentPath,
        _level: level,
        hasChildren,
      }
      result.push(flattenedNode)

      if ((expandedSet.value.has(currentPath) || query) && matchingChildren.length > 0) {
        result.push(...matchingChildren)
      }
    }
  }
  return result
}

const visibleRows = computed(() => {
  return flattenTree(props.treeData, '', 0, searchQuery.value.trim().toLowerCase())
})

// 展开 / 折叠交互
function toggleExpand(row) {
  if (!row.hasChildren) return
  if (expandedSet.value.has(row._nodePath)) {
    expandedSet.value.delete(row._nodePath)
  } else {
    expandedSet.value.add(row._nodePath)
  }
  expandedSet.value = new Set(expandedSet.value)
  emit('expand-change', { node: row, expanded: expandedSet.value.has(row._nodePath) })
  nextTick(onScroll)
}

function expandAll() {
  const walk = (nodes, p = '') => {
    for (const n of nodes) {
      // 改用纯 JS 字符串拼接
      const path = p ? (p + '/' + n.name) : n.name
      const kids = n.children || n.c
      if (kids && kids.length) {
        expandedSet.value.add(path)
        walk(kids, path)
      }
    }
  }
  walk(props.treeData)
  expandedSet.value = new Set(expandedSet.value)
  nextTick(onScroll)
}

function collapseAll() {
  expandedSet.value.clear()
  expandedSet.value = new Set()
  nextTick(onScroll)
}

// 安全转义正则特殊字符【严禁在 FTL 中写包含的正则表达式】
function escapeRegExp(str) {
  return str
    .replace(/[.*+?^$()|[\]\\]/g, '\\$&')
    .replace(/\{/g, '\\{')
    .replace(/\}/g, '\\}')
}

// 搜索文本高亮【安全字符串拼接】
function highlightText(text) {
  if (!text) return ''
  const q = searchQuery.value.trim()
  if (!q) return text
  const reg = new RegExp('(' + escapeRegExp(q) + ')', 'gi')
  return String(text).replace(reg, '<mark class="${namespace}-tree-ft__mark">$1</mark>')
}

// 键盘无障碍支持
function onKeydown(e) {
  const list = visibleRows.value
  const curIndex = list.findIndex(r => r._nodePath === selectedPath.value)
  if (curIndex < 0 && list.length > 0 && ['ArrowDown', 'ArrowUp'].includes(e.key)) {
    selectedPath.value = list[0]._nodePath
    return
  }

  const cur = list[curIndex]
  if (!cur) return

  if (e.key === 'ArrowDown') {
    e.preventDefault()
    if (list[curIndex + 1]) selectedPath.value = list[curIndex + 1]._nodePath
  } else if (e.key === 'ArrowUp') {
    e.preventDefault()
    if (list[curIndex - 1]) selectedPath.value = list[curIndex - 1]._nodePath
  } else if (e.key === 'ArrowRight') {
    e.preventDefault()
    if (cur.hasChildren && !expandedSet.value.has(cur._nodePath)) {
      toggleExpand(cur)
    } else if (list[curIndex + 1] && list[curIndex + 1]._level > cur._level) {
      selectedPath.value = list[curIndex + 1]._nodePath
    }
  } else if (e.key === 'ArrowLeft') {
    e.preventDefault()
    if (cur.hasChildren && expandedSet.value.has(cur._nodePath)) {
      toggleExpand(cur)
    } else {
      const parentPath = cur._nodePath.split('/').slice(0, -1).join('/')
      if (parentPath) selectedPath.value = parentPath
    }
  }
}

// 固定列计算
const leftOffsets  = computed(() => calcOffsets('left'))
const rightOffsets = computed(() => calcOffsets('right'))

function calcOffsets(side) {
  const map = {}
  const fixedCols = props.columns.filter(c => c.fixed === side)
  let offset = 0
  const list = side === 'left' ? fixedCols : [...fixedCols].reverse()
  for (const col of list) {
    map[col.key] = offset
    offset += parseWidth(col.width)
  }
  return map
}

function parseWidth(w) {
  if (!w) return 140
  const n = parseInt(w, 10)
  return isNaN(n) ? 140 : n
}

function colStyle(col) {
  const style = {
    width: col.width || (col.isTreeColumn ? '260px' : '140px'),
    minWidth: col.width || (col.isTreeColumn ? '260px' : '140px'),
  }
  if (col.fixed === 'left') {
    style.position = 'sticky'
    style.left = (leftOffsets.value[col.key] || 0) + 'px'
  } else if (col.fixed === 'right') {
    style.position = 'sticky'
    style.right = (rightOffsets.value[col.key] || 0) + 'px'
  }
  if (col.align) style.textAlign = col.align
  return style
}

function thClasses(col) {
  return {
    '${namespace}-tree-ft__th': true,
    '${namespace}-tree-ft__th--fixed-left': col.fixed === 'left',
    '${namespace}-tree-ft__th--fixed-right': col.fixed === 'right',
  }
}

function tdClasses(col) {
  return {
    '${namespace}-tree-ft__td': true,
    '${namespace}-tree-ft__td--fixed-left': col.fixed === 'left',
    '${namespace}-tree-ft__td--fixed-right': col.fixed === 'right',
  }
}

function rowClasses(row) {
  return {
    '${namespace}-tree-ft__row': true,
    'is-selected': selectedPath.value === row._nodePath,
  }
}

// 行点击委托
function onRowClick(e, row, rowIndex) {
  selectedPath.value = row._nodePath
  
  const btn = e.target.closest('button, a')
  if (btn) {
    const actionName = btn.getAttribute('@click') || btn.dataset.action
    if (actionName) {
      if (props.rowAction && typeof props.rowAction[actionName] === 'function') {
        props.rowAction[actionName](row, rowIndex)
      }
      emit('row-action', { handler: actionName, row, index: rowIndex })
      return
    }
  }
  emit('node-click', row)
}

function onScroll() {
  const el = wrapRef.value
  if (!el) return
  showLeftShadow.value  = el.scrollLeft > 0
  showRightShadow.value = el.scrollLeft + el.clientWidth < el.scrollWidth - 1
}

onMounted(() => {
  if (props.treeData.length > 0) {
    expandedSet.value.add(props.treeData[0].name)
    selectedPath.value = props.treeData[0].name
  }
  nextTick(onScroll)
})

defineExpose({
  expandAll,
  collapseAll,
  setSelected: (path) => { selectedPath.value = path }
})
</script>

<style scoped>
.${namespace}-tree-ft {
  position: relative;
  display: flex;
  flex-direction: column;
  border: 1px solid var(--${namespace}-border, #e6e3dc);
  background: var(--${namespace}-panel, #ffffff);
  font-family: var(--${namespace}-sans, Inter, sans-serif);
  font-size: 13px;
  color: var(--${namespace}-ink, #161616);
  border-radius: 10px;
  overflow: hidden;
}

.${namespace}-tree-ft__toolbar {
  display: flex;
  align-items: center;
  gap: 8px;
  padding: 8px 12px;
  background: var(--${namespace}-bg, #eceae4);
  border-bottom: 1px solid var(--${namespace}-border, #e6e3dc);
}

.${namespace}-tree-ft__search {
  display: flex;
  align-items: center;
  gap: 6px;
  background: var(--${namespace}-panel, #fff);
  border: 1px solid var(--${namespace}-border-light, #d4d0c7);
  border-radius: 8px;
  padding: 0 8px;
  height: 28px;
}
.icon-search { width: 14px; height: 14px; color: var(--${namespace}-mut, #8b8881); }

.${namespace}-tree-ft__search-input {
  border: 0; outline: 0; background: none; font-size: 12px; width: 160px;
}

.${namespace}-tree-ft__tool-btn {
  height: 28px;
  padding: 0 10px;
  border: 1px solid var(--${namespace}-border-light, #d4d0c7);
  background: var(--${namespace}-panel, #fff);
  border-radius: 8px;
  font-size: 12px;
  cursor: pointer;
}
.${namespace}-tree-ft__tool-btn:hover { background: var(--${namespace}-hov, #faf9f6); }

.${namespace}-tree-ft__count-info {
  margin-left: auto;
  font-size: 11px;
  font-family: var(--${namespace}-mono, monospace);
  color: var(--${namespace}-mut, #8b8881);
}

.${namespace}-tree-ft__wrap {
  flex: 1;
  width: 100%;
  overflow: auto;
  outline: none;
  overscroll-behavior: contain;
}

.${namespace}-tree-ft__table {
  width: max-content;
  min-width: 100%;
  table-layout: fixed;
  border-collapse: separate;
  border-spacing: 0;
}

.${namespace}-tree-ft__th {
  position: sticky;
  top: 0;
  z-index: 4;
  background: var(--${namespace}-card, #f6f4f0);
  color: var(--${namespace}-mut, #8b8881);
  font-family: var(--${namespace}-mono, monospace);
  font-size: 11px;
  font-weight: 600;
  text-transform: uppercase;
  padding: 8px 12px;
  text-align: left;
  border-bottom: 1px solid var(--${namespace}-border, #e6e3dc);
  border-right: 1px solid var(--${namespace}-border-light, #eee);
  white-space: nowrap;
}

.${namespace}-tree-ft__td {
  padding: 6px 12px;
  border-bottom: 1px solid var(--${namespace}-border, #f0efe9);
  border-right: 1px solid var(--${namespace}-border, #f0efe9);
  white-space: nowrap;
  vertical-align: middle;
  background: var(--${namespace}-panel, #ffffff);
}

.${namespace}-tree-ft__row:hover .${namespace}-tree-ft__td {
  background: var(--${namespace}-hov, #faf9f6);
}

.${namespace}-tree-ft__row.is-selected .${namespace}-tree-ft__td {
  background: var(--${namespace}-sel, #f0efe9);
}

.${namespace}-tree-ft__node-cell {
  display: inline-flex;
  align-items: center;
  gap: 6px;
  user-select: none;
}

.${namespace}-tree-ft__chevron {
  width: 16px;
  height: 16px;
  display: inline-grid;
  place-items: center;
  cursor: pointer;
  color: var(--${namespace}-mut, #8b8881);
  transition: transform 0.15s ease;
}
.icon-chev { width: 12px; height: 12px; }
.${namespace}-tree-ft__chevron.is-open { transform: rotate(90deg); }
.${namespace}-tree-ft__chevron.is-leaf { visibility: hidden; }

.${namespace}-tree-ft__type-badge {
  width: 28px;
  height: 18px;
  border-radius: 4px;
  display: inline-grid;
  place-items: center;
  font: 700 8.5px var(--${namespace}-mono, monospace);
  color: #fff;
  flex: none;
}

.${namespace}-tree-ft__node-title {
  font-weight: 500;
}

:deep(.${namespace}-tree-ft__mark) {
  background: #ffe38a;
  color: #161616;
  border-radius: 2px;
  padding: 0 1px;
}

.${namespace}-tree-ft__th--fixed-left,
.${namespace}-tree-ft__td--fixed-left {
  z-index: 5;
}
.${namespace}-tree-ft__th--fixed-right,
.${namespace}-tree-ft__td--fixed-right {
  z-index: 5;
}

.${namespace}-tree-ft__shadow {
  position: absolute;
  top: 45px; bottom: 0; width: 24px;
  z-index: 8;
  pointer-events: none;
  opacity: 0;
  transition: opacity 0.2s;
}
.${namespace}-tree-ft__shadow.is-visible { opacity: 1; }
.${namespace}-tree-ft__shadow--left {
  left: 0;
  background: linear-gradient(to right, rgba(0,0,0,0.06), transparent);
}
.${namespace}-tree-ft__shadow--right {
  right: 0;
  background: linear-gradient(to left, rgba(0,0,0,0.06), transparent);
}
.${namespace}-tree-ft__empty {
  text-align: center;
  padding: 40px !important;
  color: var(--${namespace}-mut, #8b8881);
}
</style>