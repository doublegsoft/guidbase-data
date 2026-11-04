<template>
  <div class="${namespace}-kanban-ft" :style="{ height: height }">
    <!-- 加载遮罩 -->
    <div v-if="loading" class="${namespace}-kanban-ft__loading-mask">
      <span class="${namespace}-kanban-ft__loading-text">加载中...</span>
    </div>

    <!-- 滚动阴影 -->
    <div class="${namespace}-kanban-ft__shadow ${namespace}-kanban-ft__shadow--left" :class="{ 'is-visible': showLeftShadow }"></div>
    <div class="${namespace}-kanban-ft__shadow ${namespace}-kanban-ft__shadow--right" :class="{ 'is-visible': showRightShadow }"></div>

    <div
      ref="wrapRef"
      class="${namespace}-kanban-ft__wrap"
      @scroll="onScroll"
    >
      <table class="${namespace}-kanban-ft__table">
        <!-- 泳道表头（支持 WIP 限制与添加按钮） -->
        <thead>
          <tr>
            <th
              v-for="col in columns"
              :key="col.key"
              :class="thClasses(col)"
              :style="colStyle(col)"
            >
              <div class="${namespace}-kanban-ft__col-header">
                <span class="${namespace}-kanban-ft__col-title">{{ col.title }}</span>
                
                <!-- WIP 限制指示器 -->
                <span 
                  v-if="col.limit" 
                  class="${namespace}-kanban-ft__wip-badge" 
                  :class="{ 'is-overflow': (columnCardsCount[col.key] || 0) > col.limit }"
                >
                  {{ columnCardsCount[col.key] || 0 }}/{{ col.limit }}
                </span>
                <span v-else class="${namespace}-kanban-ft__wip-badge">
                  {{ columnCardsCount[col.key] || 0 }}
                </span>

                <div class="${namespace}-kanban-ft__header-actions">
                  <button 
                    class="${namespace}-kanban-ft__action-btn"
                    title="添加卡片"
                    @click.stop="triggerColAction('add-card', col)"
                  >
                    +
                  </button>
                  <button 
                    class="${namespace}-kanban-ft__action-btn"
                    title="更多选项"
                    @click.stop="triggerColAction('menu', col, $event)"
                  >
                    ⋯
                  </button>
                </div>
              </div>
            </th>
          </tr>
        </thead>

        <!-- 看板卡片单元格 -->
        <tbody>
          <tr v-if="matrixRows.length === 0">
            <td :colspan="columns.length" class="${namespace}-kanban-ft__empty">
              {{ loading ? '加载中...' : '暂无卡片数据' }}
            </td>
          </tr>

          <!-- 矩阵行渲染：每一行展现各列在相同纵深 index 上的卡片 -->
          <tr v-for="(matrixRow, rowIndex) in matrixRows" :key="'row-' + rowIndex">
            <td
              v-for="col in columns"
              :key="col.key"
              :class="tdClasses(col)"
              :style="colStyle(col)"
              @dragover.prevent="onDragOver($event, col.key, rowIndex)"
              @drop="onDrop($event, col.key, rowIndex)"
            >
              <!-- 存在该卡片时渲染 -->
              <div
                v-if="matrixRow[col.key]"
                class="${namespace}-kanban-ft__card"
                :class="cardClasses(matrixRow[col.key])"
                :draggable="draggable"
                @dragstart="onDragStart($event, matrixRow[col.key], col.key)"
                @dragend="onDragEnd"
                @click="onCardClick($event, matrixRow[col.key], rowIndex, col.key)"
              >
                <!-- 卡片自定义 Slot / 默认渲染引擎 -->
                <slot name="card" :card="matrixRow[col.key]" :column="col">
                  <!-- Tag / Label -->
                  <div class="${namespace}-kanban-ft__card-tag" :class="'is-' + matrixRow[col.key][fieldMapping.color || 'c']">
                    {{ matrixRow[col.key][fieldMapping.label || 'l'] }}
                  </div>

                  <!-- 标题 -->
                  <p class="${namespace}-kanban-ft__card-title">
                    {{ matrixRow[col.key][fieldMapping.title || 't'] }}
                  </p>

                  <!-- 底部信息元数据 -->
                  <div class="${namespace}-kanban-ft__card-footer">
                    <span class="${namespace}-kanban-ft__card-user">
                      {{ matrixRow[col.key][fieldMapping.user || 'who'] }}
                    </span>
                    <span class="${namespace}-kanban-ft__card-due">
                      {{ matrixRow[col.key][fieldMapping.due || 'due'] }}
                    </span>
                  </div>
                </slot>
              </div>

              <!-- 占位空槽（支持拖入底部空位） -->
              <div v-else class="${namespace}-kanban-ft__card-placeholder"></div>
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
  /**
   * 泳道列定义 (Schema)
   * 格式: [{ key: 'backlog', title: 'Backlog', limit: 5, fixed: 'left', width: '260px' }, ...]
   */
  columns: {
    type: Array,
    required: true,
  },
  /**
   * 看板数据源对象映射
   * 格式: { backlog: [ { id: 'k1', t: 'xxx', l: 'api', c: 'b', who: 'Tom', due: 'Oct 20' } ], ... }
   */
  data: {
    type: Object,
    default: () => ({}),
  },
  /** 字段映射配置 */
  fieldMapping: {
    type: Object,
    default: () => ({
      id: 'id',
      title: 't',
      label: 'l',
      color: 'c',
      user: 'who',
      due: 'due'
    })
  },
  height:       { type: String, default: '600px' },
  draggable:    { type: Boolean, default: true },
  loading:      { type: Boolean, default: false },
  cardClass:    { type: Function, default: null }
})

const emit = defineEmits([
  'card-click',
  'card-action',
  'card-move',
  'col-action'
])

const wrapRef = ref(null)
const showLeftShadow = ref(false)
const showRightShadow = ref(false)

// ── 拖拽状态 ──
const draggedItem = ref(null)
const sourceColumn = ref(null)

// ── 统计各列当前卡片数 ──
const columnCardsCount = computed(() => {
  const map = {}
  props.columns.forEach(col => {
    map[col.key] = Array.isArray(props.data[col.key]) ? props.data[col.key].length : 0
  })
  return map
})

// ── 矩阵化转换（核心元编程：将看板按列数据展开成表格 Row 数组） ──
const matrixRows = computed(() => {
  let maxLen = 0
  props.columns.forEach(col => {
    const len = (props.data[col.key] || []).length
    if (len > maxLen) maxLen = len
  })

  const rows = []
  for (let i = 0; i < maxLen; i++) {
    const rowObj = {}
    props.columns.forEach(col => {
      rowObj[col.key] = props.data[col.key]?.[i] || null
    })
    rows.push(rowObj)
  }
  return rows
})

// ── 粘性固定列计算 (Sticky Offsets) ──
const leftOffsets = computed(() => calcOffsets('left'))
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
  if (!w) return 240
  const n = parseInt(w, 10)
  return isNaN(n) ? 240 : n
}

function colStyle(col) {
  const widthStr = col.width || '240px'
  const style = {
    width: widthStr,
    minWidth: widthStr,
    maxWidth: widthStr,
  }
  if (col.fixed === 'left') {
    style.position = 'sticky'
    style.left = (leftOffsets.value[col.key] || 0) + 'px'
  } else if (col.fixed === 'right') {
    style.position = 'sticky'
    style.right = (rightOffsets.value[col.key] || 0) + 'px'
  }
  return style
}

function thClasses(col) {
  return {
    '${namespace}-kanban-ft__th': true,
    '${namespace}-kanban-ft__th--fixed-left': col.fixed === 'left',
    '${namespace}-kanban-ft__th--fixed-right': col.fixed === 'right',
  }
}

function tdClasses(col) {
  return {
    '${namespace}-kanban-ft__td': true,
    '${namespace}-kanban-ft__td--fixed-left': col.fixed === 'left',
    '${namespace}-kanban-ft__td--fixed-right': col.fixed === 'right',
  }
}

function cardClasses(card) {
  if (props.cardClass) return props.cardClass(card)
  return {}
}

// ── 拖拽交互（Drag & Drop） ──
function onDragStart(e, card, colKey) {
  if (!props.draggable) return
  draggedItem.value = card
  sourceColumn.value = colKey
  e.dataTransfer.effectAllowed = 'move'
  e.target.classList.add('is-dragging')
}

function onDragEnd(e) {
  e.target.classList.remove('is-dragging')
  draggedItem.value = null
  sourceColumn.value = null
}

function onDragOver(e) {
  e.dataTransfer.dropEffect = 'move'
}

function onDrop(e, targetColKey, targetIndex) {
  if (!draggedItem.value || !sourceColumn.value) return
  emit('card-move', {
    card: draggedItem.value,
    fromColumn: sourceColumn.value,
    toColumn: targetColKey,
    toIndex: targetIndex,
  })
}

// ── 行点击与操作事件 ──
function onCardClick(e, card, rowIndex, colKey) {
  const btn = e.target.closest('button, a')
  if (btn) {
    const action = btn.getAttribute('@click') || btn.dataset.action
    if (action) {
      emit('card-action', { action, card, colKey, rowIndex })
      return
    }
  }
  emit('card-click', { card, colKey, rowIndex })
}

function triggerColAction(type, col, event) {
  emit('col-action', { type, column: col, event })
}

// ── 滚动阴影 ──
function onScroll() {
  const el = wrapRef.value
  if (!el) return
  showLeftShadow.value = el.scrollLeft > 0
  showRightShadow.value = el.scrollLeft + el.clientWidth < el.scrollWidth - 1
}

watch(() => props.data, () => nextTick(onScroll), { deep: true })
onMounted(() => nextTick(onScroll))
</script>

<style scoped>
/* ═══════════════════════════════════════════
   看板 FixedTable 样式定义
   ═══════════════════════════════════════════ */
.${namespace}-kanban-ft {
  position: relative;
  display: flex;
  flex-direction: column;
  overflow: hidden;
  border: 1px solid var(--${namespace}-border, #e6e3dc);
  background: var(--${namespace}-bg, #eceae4);
  font-family: var(--${namespace}-sans, Inter, sans-serif);
  font-size: 13px;
  color: var(--${namespace}-ink, #161616);
}

.${namespace}-kanban-ft__loading-mask {
  position: absolute;
  top: 0; left: 0; right: 0; bottom: 0;
  z-index: 30;
  display: flex;
  align-items: center;
  justify-content: center;
  background: rgba(255, 255, 255, 0.65);
}

.${namespace}-kanban-ft__wrap {
  flex: 1;
  width: 100%;
  overflow: auto;
  overscroll-behavior: contain;
}

.${namespace}-kanban-ft__table {
  width: max-content;
  min-width: 100%;
  table-layout: fixed;
  border-collapse: separate;
  border-spacing: 0;
}

/* ── 表头泳道 ── */
.${namespace}-kanban-ft__th {
  position: sticky;
  top: 0;
  z-index: 10;
  background: var(--${namespace}-card, #f6f4f0);
  padding: 10px 12px;
  border-bottom: 2px solid var(--${namespace}-line, #e6e3dc);
  border-right: 1px solid var(--${namespace}-line, #e6e3dc);
}

.${namespace}-kanban-ft__col-header {
  display: flex;
  align-items: center;
  gap: 8px;
}

.${namespace}-kanban-ft__col-title {
  font-weight: 600;
  font-size: 13px;
}

.${namespace}-kanban-ft__wip-badge {
  font-size: 11px;
  font-family: var(--${namespace}-mono, monospace);
  padding: 1px 7px;
  border-radius: 999px;
  background: var(--${namespace}-panel, #fff);
  border: 1px solid var(--${namespace}-line, #e6e3dc);
  color: var(--${namespace}-mut, #8b8881);
}

.${namespace}-kanban-ft__wip-badge.is-overflow {
  color: #c0362c;
  border-color: #c0362c;
  background: #fdecea;
}

.${namespace}-kanban-ft__header-actions {
  margin-left: auto;
  display: flex;
  gap: 4px;
}

.${namespace}-kanban-ft__action-btn {
  border: none;
  background: transparent;
  cursor: pointer;
  padding: 2px 5px;
  border-radius: 4px;
  color: var(--${namespace}-mut, #8b8881);
}
.${namespace}-kanban-ft__action-btn:hover {
  background: var(--${namespace}-hov, #faf9f6);
  color: var(--${namespace}-ink, #161616);
}

/* ── 单元格与卡片槽 ── */
.${namespace}-kanban-ft__td {
  padding: 8px;
  vertical-align: top;
  background: var(--${namespace}-bg, #eceae4);
  border-right: 1px solid var(--${namespace}-line, #e6e3dc);
  border-bottom: 1px dashed var(--${namespace}-line, #e6e3dc);
}

/* ── 泳道卡片卡身 ── */
.${namespace}-kanban-ft__card {
  background: var(--${namespace}-panel, #ffffff);
  border: 1px solid var(--${namespace}-line, #e6e3dc);
  border-radius: 9px;
  padding: 10px;
  cursor: grab;
  box-shadow: 0 1px 2px rgba(0, 0, 0, 0.04);
  transition: box-shadow 0.15s, border-color 0.15s, transform 0.15s;
}

.${namespace}-kanban-ft__card:hover {
  border-color: var(--${namespace}-line2, #d4d0c7);
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.06);
  transform: translateY(-1px);
}

.${namespace}-kanban-ft__card.is-dragging {
  opacity: 0.35;
}

.${namespace}-kanban-ft__card-tag {
  display: inline-block;
  font-size: 10.5px;
  font-family: var(--${namespace}-mono, monospace);
  padding: 0 6px;
  border-radius: 4px;
  margin-bottom: 6px;
  background: #e6eefc;
  color: #2f64d6;
}
.${namespace}-kanban-ft__card-tag.is-a { background: #fff1cf; color: #9a6a00; }
.${namespace}-kanban-ft__card-tag.is-g { background: #e2f2e7; color: #237a47; }
.${namespace}-kanban-ft__card-tag.is-r { background: #fdecea; color: #c0362c; }

.${namespace}-kanban-ft__card-title {
  margin: 0 0 8px;
  font-weight: 500;
  line-height: 1.35;
}

.${namespace}-kanban-ft__card-footer {
  display: flex;
  align-items: center;
  justify-content: space-between;
  color: var(--${namespace}-mut, #8b8881);
  font-size: 11px;
}

.${namespace}-kanban-ft__card-placeholder {
  min-height: 20px;
}

/* ── 固定列增强 ── */
.${namespace}-kanban-ft__th--fixed-left,
.${namespace}-kanban-ft__td--fixed-left {
  z-index: 12;
}
.${namespace}-kanban-ft__th--fixed-right,
.${namespace}-kanban-ft__td--fixed-right {
  z-index: 12;
}

/* 阴影效果 */
.${namespace}-kanban-ft__shadow {
  position: absolute;
  top: 0; bottom: 0; width: 20px;
  z-index: 20;
  pointer-events: none;
  opacity: 0;
  transition: opacity 0.2s;
}
.${namespace}-kanban-ft__shadow.is-visible { opacity: 1; }
.${namespace}-kanban-ft__shadow--left {
  left: 0;
  background: linear-gradient(to right, rgba(0,0,0,0.08), transparent);
}
.${namespace}-kanban-ft__shadow--right {
  right: 0;
  background: linear-gradient(to left, rgba(0,0,0,0.08), transparent);
}
</style>