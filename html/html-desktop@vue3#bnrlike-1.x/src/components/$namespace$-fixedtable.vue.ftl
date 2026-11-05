<template>
  <div class="${namespace}-ft" :style="{ height: height }">
    <!-- 加载遮罩 -->
    <div v-if="loading" class="${namespace}-ft__loading-mask">
      <span class="${namespace}-ft__loading-text">加载中...</span>
    </div>

    <!-- 左阴影 -->
    <div class="${namespace}-ft__shadow ${namespace}-ft__shadow--left" :class="{ 'is-visible': showLeftShadow }"></div>
    <!-- 右阴影 -->
    <div class="${namespace}-ft__shadow ${namespace}-ft__shadow--right" :class="{ 'is-visible': showRightShadow }"></div>

    <div
      ref="wrapRef"
      class="${namespace}-ft__wrap"
      @scroll="onScroll"
    >
      <table class="${namespace}-ft__table">
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
          <tr v-if="displayData.length === 0">
            <td :colspan="columns.length" class="${namespace}-ft__empty">
              {{ loading ? '加载中...' : '暂无数据' }}
            </td>
          </tr>
          <tr
            v-for="(row, rowIndex) in displayData"
            :key="String(row[idKey])"
            :data-id="String(row[idKey])"
            :class="rowClasses(row)"
            @click="onRowClick($event, row, rowIndex)"
          >
            <td
              v-for="col in columns"
              :key="col.key"
              :class="tdClasses(col)"
              :style="colStyle(col)"
            >
              <!-- 1. 自定义 render 渲染 -->
              <span v-if="col.render" v-html="col.render(getCellValue(row, col), row) ?? ''"></span>

              <!-- 2. Tag 数组拆分显示 -->
              <div v-else-if="isTagCell(row, col)" class="${namespace}-ft__tags">
                <span
                  v-for="(tag, tIdx) in getTags(row, col)"
                  :key="tIdx"
                  class="${namespace}-ft__tag"
                  :style="getTagStyle(tag, col, tIdx)"
                >
                  {{ getTagLabel(tag) }}
                </span>
              </div>

              <!-- 3. 普通文本 -->
              <template v-else>{{ getCellValue(row, col) }}</template>
            </td>
          </tr>
        </tbody>
      </table>
    </div>

    <!-- 分页 -->
    <${namespace}-pagination
      v-if="showPagination"
      :total="internalTotal"
      v-model:current-page="currentPageModel"
      v-model:page-size="pageSizeModel"
      :page-sizes="pageSizes"
      @change="onPageChange"
    />
  </div>
</template>

<script setup>
import { ref, computed, watch, onMounted, nextTick } from 'vue'
import ${js.nameType(namespace)}Pagination from './${namespace}-pagination.vue'

const props = defineProps({
  columns:      { type: Array,    required: true },
  data:         { type: Array,    default: () => [] },
  height:       { type: String,   default: '400px' },
  idKey:        { type: String,   default: 'id' },
  rowClassName: { type: Function, default: null },
  total:        { type: Number,   default: 0 },
  // ── 远端数据获取 ──
  // fetchData: async (params, pageNumber, pageSize) => { data: [...], total: N }
  fetchData:    { type: Function, default: null },
  // fetchParams: 传入 fetchData 的搜索条件参数
  fetchParams:  { type: Object,   default: () => ({}) },
  // ── 分页 ──
  // pagination: true | false | undefined（undefined 时若有 fetchData 则自动开启）
  pagination:   { type: [Boolean, Object], default: undefined },
  currentPage:  { type: Number,   default: 1 },
  pageSize:     { type: Number,   default: 20 },
  pageSizes:    { type: Array,    default: () => [20, 50, 100] },
  // rowAction: 操作按钮回调映射 { handlerName: (row, index) => void }
  rowAction:    { type: Object,   default: null },
})

const emit = defineEmits(['row-click', 'row-action', 'update:currentPage', 'update:pageSize'])

const wrapRef = ref(null)
const showLeftShadow  = ref(false)
const showRightShadow = ref(false)

// ── 远端数据模式 ──
const hasFetcher = computed(() => typeof props.fetchData === 'function')

// 是否显示分页：显式传了 pagination 以它为准，否则有 fetchData 时自动开启
const showPagination = computed(() => {
  if (props.pagination !== undefined) return !!props.pagination
  return hasFetcher.value
})

const internalData = ref([])
const internalTotal = ref(0)
const loading = ref(false)
let reqId = 0

// 分页内部状态，与 props 双向同步
const currentPageModel = ref(props.currentPage)
const pageSizeModel    = ref(props.pageSize)

watch(() => props.currentPage, (v) => { currentPageModel.value = v })
watch(() => props.pageSize,    (v) => { pageSizeModel.value = v })

// 实际渲染的数据：有 fetchData 时使用内部数据，否则使用 props.data
const displayData = computed(() =>
  hasFetcher.value ? internalData.value : props.data
)

// 获取单元格数据，当为 undefined 时显示空字符串（保留 0 和 false）
function getCellValue(row, col) {
  const val = row[col.key]
  return val === undefined ? '' : val
}

// ── Tag 标签展示与配色 ──
const TAG_PALETTE = [
  { bg: '#e6f4ff', color: '#0958d9', border: '#91caff' }, // 蓝
  { bg: '#f6ffed', color: '#389e0d', border: '#b7eb8f' }, // 绿
  { bg: '#fff7e6', color: '#d46b08', border: '#ffd591' }, // 橙
  { bg: '#f9f0ff', color: '#531dab', border: '#d3adf7' }, // 紫
  { bg: '#e6fffb', color: '#08979c', border: '#87e8de' }, // 青
  { bg: '#fff1f0', color: '#cf1322', border: '#ffa39e' }, // 红
  { bg: '#feffe6', color: '#ad8b00', border: '#fffb8f' }, // 黄
]

function isTagCell(row, col) {
  if (col.type === 'tag' || col.tag) return true
  return Array.isArray(row[col.key])
}

function getTags(row, col) {
  const val = row[col.key]
  if (Array.isArray(val)) return val
  if (typeof val === 'string' && val.trim()) {
    return val.split(/[,，、|]/).map(s => s.trim()).filter(Boolean)
  }
  return []
}

function getTagLabel(tag) {
  if (tag === null || tag === undefined) return ''
  if (typeof tag === 'object') {
    return tag.label ?? tag.text ?? tag.name ?? tag.title ?? tag.value ?? ''
  }
  return String(tag)
}

function getTagStyle(tag, col, index) {
  const label = getTagLabel(tag)
  // 1. 如果 tag 对象自身指定了 color
  if (typeof tag === 'object' && tag !== null) {
    if (tag.bg && tag.color) {
      return { backgroundColor: tag.bg, color: tag.color, borderColor: tag.border || tag.bg }
    }
    if (tag.color && tag.color.startsWith('#')) {
      return { backgroundColor: tag.color + '18', color: tag.color, borderColor: tag.color + '40' }
    }
  }
  // 2. 如果列配置提供了 tagColor 函数
  if (typeof col.tagColor === 'function') {
    const res = col.tagColor(label, tag, index)
    if (typeof res === 'object') return res
    if (typeof res === 'string') return { backgroundColor: res + '18', color: res, borderColor: res + '40' }
  }
  // 3. 如果列配置提供了 tagColors 字典映射
  if (col.tagColors && col.tagColors[label]) {
    const res = col.tagColors[label]
    if (typeof res === 'object') return res
    return { backgroundColor: res + '18', color: res, borderColor: res + '40' }
  }
  // 4. 默认根据文字 Hash 分配固定配色（同名 Tag 保持颜色一致）
  let hash = 0
  for (let i = 0; i < label.length; i++) {
    hash = (hash << 5) - hash + label.charCodeAt(i)
    hash |= 0
  }
  const item = TAG_PALETTE[Math.abs(hash) % TAG_PALETTE.length]
  return {
    backgroundColor: item.bg,
    color: item.color,
    borderColor: item.border
  }
}

/**
 * 加载远端数据
 * 调用 props.fetchData(fetchParams, pageNumber, pageSize)
 */
async function loadData() {
  if (!hasFetcher.value) return
  const id = ++reqId
  loading.value = true
  try {
    const params = { ...props.fetchParams }
    const res = await props.fetchData(params, currentPageModel.value, pageSizeModel.value)
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
    console.error('FixedTable fetchData error:', e)
    internalData.value = []
    internalTotal.value = 0
  } finally {
    if (id === reqId) {
      loading.value = false
      nextTick(() => onScroll())
    }
  }
}

// fetchParams 引用变化时自动重新加载（回到第 1 页）
watch(() => props.fetchParams, () => {
  if (hasFetcher.value) {
    currentPageModel.value = 1
    emit('update:currentPage', 1)
    loadData()
  }
})

// fetchData 函数变化时重新加载
watch(() => props.fetchData, () => {
  if (hasFetcher.value) loadData()
})

// ── 分页事件 ──
function onPageChange({ currentPage: cp, pageSize: ps }) {
  emit('update:currentPage', cp)
  emit('update:pageSize', ps)
  if (hasFetcher.value) {
    loadData()
  }
}

onMounted(() => {
  nextTick(() => onScroll())
  if (hasFetcher.value) loadData()
})

// ── 行点击与操作按钮事件委托 ──
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
  emit('row-click', row)
}

// ── 计算固定列的 sticky 偏移 ──
const leftOffsets  = computed(() => calcOffsets('left'))
const rightOffsets = computed(() => calcOffsets('right'))

function calcOffsets(side) {
  const map = {}
  const fixedCols = props.columns.filter(c => c.fixed === side)
  if (side === 'left') {
    let offset = 0
    for (const col of fixedCols) {
      map[col.key] = offset
      offset += parseWidth(col.width)
    }
  } else {
    let offset = 0
    const reversed = [...fixedCols].reverse()
    for (const col of reversed) {
      map[col.key] = offset
      offset += parseWidth(col.width)
    }
  }
  return map
}

function parseWidth(w) {
  if (!w) return 120
  const n = parseInt(w, 10)
  return isNaN(n) ? 120 : n
}

// ── column style ──
function colStyle(col) {
  const style = {
    width: col.width || '120px',
    minWidth: col.width || '120px',
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

// ── classes ──
function thClasses(col) {
  return {
    '${namespace}-ft__th': true,
    '${namespace}-ft__th--fixed-left':  col.fixed === 'left',
    '${namespace}-ft__th--fixed-right': col.fixed === 'right',
    '${namespace}-ft__th--fixed-left-last':
      col.fixed === 'left' && !hasNextFixed(col, 'left'),
    '${namespace}-ft__th--fixed-right-first':
      col.fixed === 'right' && !hasPrevFixed(col, 'right'),
  }
}

function tdClasses(col) {
  return {
    '${namespace}-ft__td': true,
    '${namespace}-ft__td--fixed-left':  col.fixed === 'left',
    '${namespace}-ft__td--fixed-right': col.fixed === 'right',
    '${namespace}-ft__td--fixed-left-last':
      col.fixed === 'left' && !hasNextFixed(col, 'left'),
    '${namespace}-ft__td--fixed-right-first':
      col.fixed === 'right' && !hasPrevFixed(col, 'right'),
  }
}

function hasNextFixed(col, side) {
  const fixedCols = props.columns.filter(c => c.fixed === side)
  const idx = fixedCols.findIndex(c => c.key === col.key)
  return idx >= 0 && idx < fixedCols.length - 1
}

function hasPrevFixed(col, side) {
  const fixedCols = props.columns.filter(c => c.fixed === side)
  const idx = fixedCols.findIndex(c => c.key === col.key)
  return idx > 0
}

function rowClasses(row) {
  const parts = []
  if (props.rowClassName) {
    const c = props.rowClassName(row)
    if (c) parts.push(c)
  }
  return parts
}

// ── scroll shadows ──
function onScroll() {
  const el = wrapRef.value
  if (!el) return
  showLeftShadow.value  = el.scrollLeft > 0
  showRightShadow.value = el.scrollLeft + el.clientWidth < el.scrollWidth - 1
}

// 外部 data 变化时刷新滚动阴影
watch(() => props.data, () => {
  nextTick(() => onScroll())
})

/** 手动刷新数据，回到第 1 页 */
function refresh() {
  currentPageModel.value = 1
  emit('update:currentPage', 1)
  loadData()
}

defineExpose({
  refresh,
  /** 内部加载状态 */
  loading,
  scrollToLeft: () => { if (wrapRef.value) wrapRef.value.scrollLeft = 0 },
  scrollToRight: () => {
    if (wrapRef.value) wrapRef.value.scrollLeft = wrapRef.value.scrollWidth
  },
})
</script>

<style scoped>
/* ═══════════════════════════════════════════
   BNR FixedTable — ${namespace}-ft
   固定列表格：左侧/右侧列固定，中间滚动
   支持远端数据获取 + 分页
   ═══════════════════════════════════════════ */

.${namespace}-ft {
  position: relative;
  display: flex;
  flex-direction: column;
  overflow: hidden;
  border: 1px solid var(--${namespace}-border);
  background: var(--${namespace}-bg);
  font-family: var(--${namespace}-font, "Microsoft YaHei", sans-serif);
  font-size: 12px;
  color: var(--${namespace}-text);
}

/* ── 加载遮罩 ── */
.${namespace}-ft__loading-mask {
  position: absolute;
  top: 0; left: 0; right: 0; bottom: 0;
  z-index: 10;
  display: flex;
  align-items: center;
  justify-content: center;
  background: rgba(255, 255, 255, 0.6);
}
.${namespace}-ft__loading-text {
  padding: 8px 20px;
  background: var(--${namespace}-primary-bg);
  border-radius: 4px;
  font-size: 13px;
  color: var(--${namespace}-primary);
}

/* ── scroll wrap ── */
.${namespace}-ft__wrap {
  flex: 1;
  width: 100%;
  overflow: auto;
  overscroll-behavior: contain;
  -webkit-overflow-scrolling: auto;
}

/* ── table ── */
.${namespace}-ft__table {
  width: max-content;
  min-width: 100%;
  table-layout: fixed;
  border-collapse: separate;
  border-spacing: 0;
}

/* ── header ── */
.${namespace}-ft__th {
  position: sticky;
  top: 0;
  z-index: 3;
  background: var(--${namespace}-primary-bg);
  color: var(--${namespace}-primary);
  padding: 8px 10px;
  font-weight: bold;
  font-size: 12px;
  text-align: left;
  white-space: nowrap;
  border-bottom: 1px solid var(--${namespace}-primary-border);
  border-right: 1px solid var(--${namespace}-border-light);
}
.${namespace}-ft__th:last-child {
  border-right: none;
}

/* ── body ── */
.${namespace}-ft__td {
  padding: 6px 10px;
  border-bottom: 1px solid var(--${namespace}-border-light);
  border-right: 1px solid var(--${namespace}-border-light);
  white-space: nowrap;
  overflow: hidden;
  text-overflow: ellipsis;
  vertical-align: middle;
  background: var(--${namespace}-bg);
}
.${namespace}-ft__td:last-child {
  border-right: none;
}

/* ── tags 标签展示 ── */
.${namespace}-ft__tags {
  display: inline-flex;
  flex-wrap: wrap;
  gap: 4px;
  vertical-align: middle;
  max-width: 100%;
}
.${namespace}-ft__tag {
  display: inline-flex;
  align-items: center;
  padding: 1px 6px;
  font-size: 11px;
  line-height: 18px;
  border-radius: 3px;
  border: 1px solid transparent;
  white-space: nowrap;
  box-sizing: border-box;
  user-select: none;
}

/* ── stripe & hover ── */
.${namespace}-ft__table tbody tr:nth-child(even) .${namespace}-ft__td {
  background: var(--${namespace}-bg-page);
}
.${namespace}-ft__table tbody tr:hover .${namespace}-ft__td {
  background: var(--${namespace}-primary-bg);
  cursor: pointer;
}

/* ── empty ── */
.${namespace}-ft__empty {
  text-align: center;
  padding: 40px !important;
  color: var(--${namespace}-text-light);
}

/* ═══════════════════════════════════════════
   固定列（sticky）
   ═══════════════════════════════════════════ */

/* 左固定 — header */
.${namespace}-ft__th--fixed-left {
  position: sticky;
  z-index: 4;
}
.${namespace}-ft__th--fixed-left-last {
  border-right: 1px solid var(--${namespace}-primary-border);
}
.${namespace}-ft__th--fixed-left-last::after {
  content: '';
  position: absolute;
  top: 0; right: -1px; bottom: 0;
  width: 1px;
  background: transparent;
  transition: box-shadow 0.2s;
}

/* 右固定 — header */
.${namespace}-ft__th--fixed-right {
  position: sticky;
  z-index: 4;
}
.${namespace}-ft__th--fixed-right-first {
  border-left: 1px solid var(--${namespace}-primary-border);
}

/* 左固定 — body */
.${namespace}-ft__td--fixed-left {
  position: sticky;
  z-index: 1;
}
.${namespace}-ft__td--fixed-left-last::after {
  content: '';
  position: absolute;
  top: 0; right: -1px; bottom: 0;
  width: 1px;
  background: transparent;
  transition: box-shadow 0.2s;
}

/* 右固定 — body */
.${namespace}-ft__td--fixed-right {
  position: sticky;
  z-index: 1;
}

/* ═══════════════════════════════════════════
   滚动阴影
   ═══════════════════════════════════════════ */
.${namespace}-ft__shadow {
  position: absolute;
  top: 0;
  bottom: 0;
  width: 24px;
  z-index: 5;
  pointer-events: none;
  opacity: 0;
  transition: opacity 0.2s;
}
.${namespace}-ft__shadow.is-visible {
  opacity: 1;
}

.${namespace}-ft__shadow--left {
  left: 0;
  background: linear-gradient(to right, rgba(0,0,0,0.08), transparent);
}
.${namespace}-ft__shadow--right {
  right: 0;
  background: linear-gradient(to left, rgba(0,0,0,0.08), transparent);
}
</style>