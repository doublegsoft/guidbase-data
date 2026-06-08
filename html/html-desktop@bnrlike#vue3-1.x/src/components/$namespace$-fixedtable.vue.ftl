<template>
  <div class="${namespace}-ft" :style="{ height: height }">
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
          <tr v-if="data.length === 0">
            <td :colspan="columns.length" class="${namespace}-ft__empty">
              暂无数据
            </td>
          </tr>
          <tr
            v-for="row in data"
            :key="String(row[idKey])"
            :class="rowClasses(row)"
          >
            <td
              v-for="col in columns"
              :key="col.key"
              :class="tdClasses(col)"
              :style="colStyle(col)"
            >
              <span v-if="col.render" v-html="col.render(row[col.key], row)"></span>
              <template v-else>{{ row[col.key] }}</template>
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
  columns:      { type: Array,    required: true },
  data:         { type: Array,    default: () => [] },
  height:       { type: String,   default: '400px' },
  idKey:        { type: String,   default: 'id' },
  rowClassName: { type: Function, default: null },
})

const emit = defineEmits(['row-click'])

const wrapRef = ref(null)
const showLeftShadow  = ref(false)
const showRightShadow = ref(false)

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
    // right side: offsets are from right edge, so the rightmost column gets 0
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

onMounted(() => {
  nextTick(() => onScroll())
})

watch(() => props.data, () => {
  nextTick(() => onScroll())
})

defineExpose({
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
   ═══════════════════════════════════════════ */

.${namespace}-ft {
  position: relative;
  overflow: hidden;
  border: 1px solid var(--${namespace}-border);
  background: var(--${namespace}-bg);
  font-family: var(--${namespace}-font, "Microsoft YaHei", sans-serif);
  font-size: 12px;
  color: var(--${namespace}-text);
}

/* ── scroll wrap ── */
.${namespace}-ft__wrap {
  width: 100%;
  height: 100%;
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
/* 左固定最后一列：加右边框阴影 */
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
/* 右固定第一列：加左边框阴影 */
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
