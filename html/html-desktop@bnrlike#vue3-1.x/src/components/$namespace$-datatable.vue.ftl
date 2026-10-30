<template>
  <div class="${namespace}-data-table" ref="tableRootRef">
    <div class="${namespace}-list-area">
      <!-- 顶部操作栏 -->
      <div v-if="showToolbar" class="${namespace}-table-toolbar">
        <div class="${namespace}-toolbar-left">
          <button
            type="button"
            class="${namespace}-btn ${namespace}-btn-primary"
            @click="addRow()"
          >
            <span class="${namespace}-btn-icon">+</span> 新增行
          </button>
          <button
            v-if="selectedIds.size > 0"
            type="button"
            class="${namespace}-btn ${namespace}-btn-danger"
            @click="handleDeleteSelected"
          >
            <svg class="${namespace}-icon-svg" viewBox="0 0 24 24" width="13" height="13" stroke="currentColor" stroke-width="2" fill="none" stroke-linecap="round" stroke-linejoin="round">
              <polyline points="3 6 5 6 21 6"></polyline>
              <path d="M19 6v14a2 2 0 0 1-2 2H7a2 2 0 0 1-2-2V6m3 0V4a2 2 0 0 1 2-2h4a2 2 0 0 1 2 2v2"></path>
            </svg>
            批量删除 ({{ selectedIds.size }})
          </button>
          <slot name="toolbar-left"></slot>
        </div>
        <div class="${namespace}-toolbar-right">
          <slot name="toolbar-right"></slot>
        </div>
      </div>

      <!-- 加载遮罩 -->
      <div v-if="loading" class="${namespace}-data-table__loading-mask">
        <span class="${namespace}-data-table__loading-text">加载中...</span>
      </div>

      <!-- 表格主体容器 -->
      <div class="${namespace}-table-container" ref="scrollContainer" @scroll="onScroll">
        <table class="${namespace}-table">
          <thead>
            <tr>
              <!-- 多选列 -->
              <th v-if="selectable" style="width: 40px" class="${namespace}-tc">
                <input
                  type="checkbox"
                  :checked="isAllChecked"
                  @change="toggleAll($event.target.checked)"
                  class="${namespace}-checkbox"
                />
              </th>
              <!-- 序号列 -->
              <th v-if="showIndex" style="width: 50px" class="${namespace}-tc">序号</th>

              <!-- 业务数据列 -->
              <th
                v-for="(col, ci) in columns"
                :key="col.key"
                :style="{ width: col.width || '', textAlign: col.align || 'left' }"
                :class="{
                  '${namespace}-sortable': col.sortable,
                  '${namespace}-asc': sortKey === col.key && sortAsc,
                  '${namespace}-desc': sortKey === col.key && !sortAsc
                }"
                @click="col.sortable && toggleSort(col.key)"
              >
                {{ col.title || col.label }}
                <span v-if="col.sortable" class="${namespace}-sort-icon"></span>
              </th>

              <!-- 操作列 -->
              <th v-if="showRowAction" style="width: 90px" class="${namespace}-tc">操作</th>
            </tr>
          </thead>
          <tbody>
            <tr v-if="tableData.length === 0">
              <td
                :colspan="totalColspan"
                class="${namespace}-tc"
                style="padding: 40px; color: var(--${namespace}-tl, #999)"
              >
                {{ loading ? '加载中...' : '暂无数据，请点击上方“新增行”添加数据' }}
              </td>
            </tr>

            <tr
              v-for="(row, rowIndex) in tableData"
              :key="String(row[idKey])"
              :data-id="String(row[idKey])"
              :class="rowClasses(row)"
              @click="onRowClick($event, row, rowIndex)"
            >
              <!-- 多选单元格 -->
              <td v-if="selectable" class="${namespace}-tc" @click.stop>
                <input
                  type="checkbox"
                  :checked="selectedIds.has(String(row[idKey]))"
                  @change="toggleRow(String(row[idKey]), $event.target.checked)"
                  class="${namespace}-checkbox"
                />
              </td>

              <!-- 序号单元格 -->
              <td v-if="showIndex" class="${namespace}-tc ${namespace}-index-cell">
                {{ rowIndex + 1 }}
              </td>

              <!-- 各列数据单元格 -->
              <td
                v-for="(col, colIndex) in columns"
                :key="col.key"
                :ref="function(el) { setCellRef(el, rowIndex, colIndex) }"
                :class="{
                  '${namespace}-cell-active': isCellActive(rowIndex, colIndex),
                  '${namespace}-cell-editing': isInputEditing(rowIndex, col.key)
                }"
                :style="{ textAlign: col.align || 'left' }"
                @click="onCellClick(rowIndex, colIndex)"
                @dblclick.stop="startEdit(row, col, rowIndex, colIndex)"
              >
                <!-- 1. Checkbox 开关类型 -->
                <div v-if="col.type === 'check' || col.type === 'checkbox'" class="${namespace}-tc" @click.stop>
                  <input
                    type="checkbox"
                    :checked="!!row[col.key]"
                    :disabled="col.disabled"
                    class="${namespace}-checkbox"
                    @change="toggleCheckbox(row, col.key, $event.target.checked, rowIndex)"
                  />
                </div>

                <!-- 2. 原地输入编辑态 (text / number) -->
                <div
                  v-else-if="isInputEditing(rowIndex, col.key)"
                  class="${namespace}-cell-editor"
                  @click.stop
                >
                  <input
                    ref="editInputRef"
                    :type="col.type === 'number' ? 'number' : 'text'"
                    :value="row[col.key] ?? ''"
                    class="${namespace}-cell-input"
                    :placeholder="col.placeholder || ''"
                    :disabled="col.disabled"
                    :min="col.min"
                    :max="col.max"
                    :step="col.step || 'any'"
                    @blur="finishInputEdit(row, col, rowIndex, $event.target.value)"
                    @keydown.enter="finishInputEdit(row, col, rowIndex, $event.target.value)"
                    @keydown.esc="cancelInputEdit"
                  />
                </div>

                <!-- 3. 常规只读状态（与分页表格完全一致） -->
                <template v-else>
                  <slot
                    v-if="$slots['cell-' + col.key]"
                    :name="'cell-' + col.key"
                    :row="row"
                    :col="col"
                    :index="rowIndex"
                    :value="row[col.key]"
                  />

                  <span
                    v-else-if="col.render"
                    v-html="renderCustomContent(col, row, rowIndex)"
                  ></span>

                  <span v-else-if="col.type === 'select'" class="${namespace}-cell-text">
                    {{ getSelectLabel(col.options || col.opts, row[col.key]) }}
                  </span>

                  <span v-else-if="col.type === 'number'" class="${namespace}-cell-text">
                    {{ fmtNum(row[col.key]) }}
                  </span>

                  <span v-else class="${namespace}-cell-text">
                    {{ formatCell(row[col.key]) }}
                  </span>
                </template>
              </td>

              <!-- 操作列：删除单行（触发已有 Feedback 弹窗） -->
              <td v-if="showRowAction" class="${namespace}-tc ${namespace}-action-cell" @click.stop>
                <button
                  type="button"
                  class="${namespace}-btn-action-del"
                  title="删除此行"
                  @click="handleRemoveRow(rowIndex)"
                >
                  <svg class="${namespace}-action-icon" viewBox="0 0 24 24" width="13" height="13" stroke="currentColor" stroke-width="2" fill="none" stroke-linecap="round" stroke-linejoin="round">
                    <polyline points="3 6 5 6 21 6"></polyline>
                    <path d="M19 6v14a2 2 0 0 1-2 2H7a2 2 0 0 1-2-2V6m3 0V4a2 2 0 0 1 2-2h4a2 2 0 0 1 2 2v2"></path>
                    <line x1="10" y1="11" x2="10" y2="17"></line>
                    <line x1="14" y1="11" x2="14" y2="17"></line>
                  </svg>
                  <span>删除</span>
                </button>
              </td>
            </tr>
          </tbody>
        </table>
      </div>

      <!-- 底部统计状态栏 -->
      <div class="${namespace}-table-footer">
        <span class="${namespace}-footer-info">
          共 <strong style="color:var(--${namespace}-p, #1890ff)">{{ tableData.length }}</strong> 条记录
          <template v-if="selectedIds.size > 0">
            ，已选择 <strong>{{ selectedIds.size }}</strong> 项
          </template>
        </span>
      </div>
    </div>

    <!-- ════════════════ 浮动下拉选择器面板 (Teleport) ════════════════ -->
    <teleport to="body">
      <div
        v-if="dropOpen"
        class="${namespace}-drop-panel"
        :style="dropStyle"
        @mousedown.stop
      >
        <div
          v-for="opt in dropOptions"
          :key="opt.value"
          class="${namespace}-drop-item"
          :class="{ active: isDropSelected(opt.value) }"
          @mousedown.prevent.stop
          @click.stop="commitDrop(opt.value)"
        >
          {{ opt.label }}
        </div>
      </div>
    </teleport>

    <!-- ════════════════ 浮动日历选择器面板 (Teleport) ════════════════ -->
    <teleport to="body">
      <div
        v-if="dateOpen"
        class="${namespace}-date-panel"
        :style="dateStyle"
        @mousedown.stop
      >
        <div class="${namespace}-date-head">
          <div class="${namespace}-date-nav" @mousedown.prevent.stop @click.stop="dateStep(-1, true)">&laquo;</div>
          <div class="${namespace}-date-nav" @mousedown.prevent.stop @click.stop="dateStep(-1, false)">&lsaquo;</div>
          <div class="${namespace}-date-title" @mousedown.prevent.stop @click.stop="dateDrillUp">{{ dateTitle }}</div>
          <div class="${namespace}-date-nav" @mousedown.prevent.stop @click.stop="dateStep(1, false)">&rsaquo;</div>
          <div class="${namespace}-date-nav" @mousedown.prevent.stop @click.stop="dateStep(1, true)">&raquo;</div>
        </div>

        <template v-if="dateView === 'day'">
          <div class="${namespace}-date-weekdays">
            <div v-for="w in dateWeekdays" :key="w" class="${namespace}-date-wd">{{ w }}</div>
          </div>
          <div class="${namespace}-date-days">
            <div
              v-for="d in dateDayCells"
              :key="d.ymd"
              class="${namespace}-date-day"
              :class="{
                'is-other': d.isOther,
                'is-weekend': d.isWeekend,
                'is-today': d.isToday,
                'is-selected': d.isSelected,
              }"
              @mousedown.prevent.stop
              @click.stop="commitDate(d.ymd)"
            >{{ d.day }}</div>
          </div>
        </template>

        <div v-if="dateView === 'month'" class="${namespace}-date-my-grid">
          <div
            v-for="m in 12"
            :key="m"
            class="${namespace}-date-my-item"
            :class="{ 'is-selected': isDateMonthSelected(m - 1) }"
            @mousedown.prevent.stop
            @click.stop="pickDateMonth(m - 1)"
          >{{ m }}月</div>
        </div>

        <div v-if="dateView === 'year'" class="${namespace}-date-my-grid">
          <div
            v-for="yr in dateYearRange"
            :key="yr"
            class="${namespace}-date-my-item"
            :class="{ 'is-selected': yr === dateSelectedYear }"
            @mousedown.prevent.stop
            @click.stop="pickDateYear(yr)"
          >{{ yr }}</div>
        </div>

        <div class="${namespace}-date-footer">
          <span class="${namespace}-date-today-btn" @mousedown.prevent.stop @click.stop="commitDateToday">今天</span>
          <span class="${namespace}-date-clear-btn" @mousedown.prevent.stop @click.stop="clearDateValue">清除</span>
        </div>
      </div>
    </teleport>

    <!-- ════════ 调用已有的 Feedback 确认组件 ════════ -->
    <FeedbackDialog
      :dialog="feedbackDialog"
      :on-close="onFeedbackClose"
    />
  </div>
</template>

<script setup>
import { ref, computed, watch, nextTick, onMounted, onUnmounted } from 'vue'
// 正式引入已有的 Feedback 组件（根据项目规范自动替换命名空间）
import FeedbackDialog from './${namespace}-feedback.vue'

const props = defineProps({
  data: {
    type: Array,
    default: () => []
  },
  columns: {
    type: Array,
    required: true
  },
  idKey: {
    type: String,
    default: 'id'
  },
  selectable: {
    type: Boolean,
    default: true
  },
  showIndex: {
    type: Boolean,
    default: true
  },
  showRowAction: {
    type: Boolean,
    default: true
  },
  showToolbar: {
    type: Boolean,
    default: true
  },
  loading: {
    type: Boolean,
    default: false
  },
  rowClassName: {
    type: Function,
    default: null
  },
  defaultRowData: {
    type: [Object, Function],
    default: () => ({})
  }
})

const emit = defineEmits([
  'update:data',
  'change',
  'row-add',
  'row-remove',
  'cell-change',
  'cell-edit-start',
  'cell-edit-end',
  'selection-change',
  'row-click'
])

// ══════════════════ 基础状态 ══════════════════
const tableData = ref([])
const selectedIds = ref(new Set())
const sortKey = ref(null)
const sortAsc = ref(true)
const scrollContainer = ref(null)
const tableRootRef = ref(null)

const activeCell = ref({ r: -1, c: -1 })

const cellRefs = ref({})
function setCellRef(el, r, c) {
  if (el) {
    cellRefs.value[r + '_' + c] = el
  }
}

const editInputRef = ref(null)
const editCell = ref({ r: -1, c: -1, key: null, originalValue: null })

// ══════════════════ 下拉选择浮层状态 ══════════════════
const dropOpen = ref(false)
const dropR = ref(-1)
const dropC = ref(-1)
const dropStyle = ref({})

// ══════════════════ 日历选择浮层状态 ══════════════════
const dateOpen = ref(false)
const dateR = ref(-1)
const dateC = ref(-1)
const dateView = ref('day')
const dateCursor = ref(new Date())
const dateStyle = ref({})

// ══════════════════ 驱动已有 Feedback 组件的核心状态 ══════════════════
const feedbackDialog = ref({
  show: false,
  type: 'confirm',
  title: '提示',
  message: '',
  resolve: null
})

// Promise 式唤起 Feedback 确认弹窗
function confirm(title, message) {
  return new Promise(function(resolve) {
    feedbackDialog.value = {
      show: true,
      type: 'confirm',
      title: title || '确认删除',
      message: message || '确定要删除此项数据吗？',
      resolve: resolve
    }
  })
}

// Feedback 关闭回调
function onFeedbackClose(r) {
  if (feedbackDialog.value && typeof feedbackDialog.value.resolve === 'function') {
    feedbackDialog.value.resolve(r)
  }
  feedbackDialog.value = {
    show: false,
    type: 'confirm',
    title: '',
    message: '',
    resolve: null
  }
}

watch(
  () => props.data,
  (newVal) => {
    tableData.value = Array.isArray(newVal) ? newVal : []
  },
  { immediate: true, deep: true }
)

const totalColspan = computed(() => {
  let count = props.columns.length
  if (props.selectable) count++
  if (props.showIndex) count++
  if (props.showRowAction) count++
  return count
})

function formatCell(val) {
  if (val === undefined || val === null || val === 'undefined' || val === 'null') {
    return ''
  }
  return val
}

function fmtNum(v) {
  if (v === '' || v == null) return ''
  return Number(v).toLocaleString()
}

function renderCustomContent(col, row, rowIndex) {
  const result = col.render(row[col.key], row, rowIndex)
  return formatCell(result)
}

function normalizeOptions(options) {
  if (!options || !Array.isArray(options)) return []
  return options.map(function(opt) {
    if (typeof opt === 'object' && opt !== null) {
      return { label: opt.label ?? opt.value ?? '', value: opt.value ?? opt.label ?? '' }
    }
    return { label: String(opt), value: opt }
  })
}

function getSelectLabel(options, val) {
  if (val === undefined || val === null || val === 'undefined') return ''
  const list = normalizeOptions(options)
  const item = list.find(function(o) { return o.value === val })
  return item ? item.label : formatCell(val)
}

function isCellActive(r, c) {
  return activeCell.value.r === r && activeCell.value.c === c
}

function isInputEditing(r, key) {
  return editCell.value.r === r && editCell.value.key === key
}

function onCellClick(r, c) {
  activeCell.value = { r: r, c: c }
  if (dropOpen.value && (dropR.value !== r || dropC.value !== c)) closeDrop()
  if (dateOpen.value && (dateR.value !== r || dateC.value !== c)) closeDate()
}

function startEdit(row, col, r, c) {
  if (col.disabled || col.editable === false) return
  closeDrop()
  closeDate()
  finishInputEditNow()

  if (col.type === 'select') {
    openDrop(r, c)
    return
  }
  if (col.type === 'date') {
    openDate(r, c)
    return
  }
  if (col.type === 'check' || col.type === 'checkbox') {
    toggleCheckbox(row, col.key, !row[col.key], r)
    return
  }

  editCell.value = { r: r, c: c, key: col.key, originalValue: row[col.key] }
  emit('cell-edit-start', { row: row, col: col, rowIndex: r })

  nextTick(function() {
    if (editInputRef.value) {
      const el = Array.isArray(editInputRef.value) ? editInputRef.value[0] : editInputRef.value
      el?.focus?.()
      el?.select?.()
    }
  })
}

function finishInputEdit(row, col, r, val) {
  if (editCell.value.r !== r || editCell.value.key !== col.key) return
  const finalVal = (col.type === 'number' && val !== '') ? (Number(val) || 0) : val
  row[col.key] = finalVal
  editCell.value = { r: -1, c: -1, key: null, originalValue: null }
  emit('cell-change', { row: row, key: col.key, value: finalVal, rowIndex: r })
  emit('update:data', tableData.value)
  emit('change', tableData.value)
  emit('cell-edit-end', { row: row, col: col, rowIndex: r })
}

function finishInputEditNow() {
  if (editCell.value.r >= 0 && editCell.value.key) {
    const r = editCell.value.r
    const row = tableData.value[r]
    const col = props.columns[editCell.value.c]
    if (row && col && editInputRef.value) {
      const el = Array.isArray(editInputRef.value) ? editInputRef.value[0] : editInputRef.value
      finishInputEdit(row, col, r, el?.value ?? row[col.key])
    }
  }
}

function cancelInputEdit() {
  if (editCell.value.r >= 0 && editCell.value.originalValue !== undefined) {
    const row = tableData.value[editCell.value.r]
    if (row) row[editCell.value.key] = editCell.value.originalValue
  }
  editCell.value = { r: -1, c: -1, key: null, originalValue: null }
}

function toggleCheckbox(row, key, checked, r) {
  row[key] = checked
  emit('cell-change', { row: row, key: key, value: checked, rowIndex: r })
  emit('update:data', tableData.value)
  emit('change', tableData.value)
}

// ══════════════════ 下拉浮层逻辑 ══════════════════
const dropOptions = computed(function() {
  if (dropC.value < 0) return []
  const col = props.columns[dropC.value]
  return normalizeOptions(col?.options || col?.opts)
})

function isDropSelected(val) {
  if (dropR.value < 0 || dropC.value < 0) return false
  const key = props.columns[dropC.value]?.key
  return tableData.value[dropR.value]?.[key] === val
}

function openDrop(r, c) {
  dropR.value = r
  dropC.value = c
  dropOpen.value = true
  nextTick(function() { positionPanel(r, c, 'drop') })
}

function closeDrop() {
  dropOpen.value = false
  dropR.value = -1
  dropC.value = -1
}

function commitDrop(val) {
  if (dropR.value < 0 || dropC.value < 0) return
  const r = dropR.value
  const col = props.columns[dropC.value]
  tableData.value[r][col.key] = val
  emit('cell-change', { row: tableData.value[r], key: col.key, value: val, rowIndex: r })
  emit('update:data', tableData.value)
  emit('change', tableData.value)
  closeDrop()
}

// ══════════════════ 日历浮层逻辑 ══════════════════
const dateWeekdays = ['日', '一', '二', '三', '四', '五', '六']

function dateYmd(d) {
  return d.getFullYear() + '-' +
    String(d.getMonth() + 1).padStart(2, '0') + '-' +
    String(d.getDate()).padStart(2, '0')
}

function dateParse(s) {
  if (!s) return null
  const n = String(s).replace(/\//g, '-').replace(/年|月/g, '-').replace(/日/g, '')
  const d = new Date(n)
  return isNaN(d.getTime()) ? null : d
}

const dateSelectedStr = computed(function() {
  if (dateR.value < 0 || dateC.value < 0) return null
  return tableData.value[dateR.value]?.[props.columns[dateC.value]?.key] ?? null
})

const dateSelectedYear = computed(function() {
  const d = dateParse(dateSelectedStr.value)
  return d ? d.getFullYear() : null
})

const dateTitle = computed(function() {
  const y = dateCursor.value.getFullYear()
  const m = dateCursor.value.getMonth()
  if (dateView.value === 'day') return y + '年 ' + (m + 1) + '月'
  if (dateView.value === 'month') return y + '年'
  const base = Math.floor(y / 12) * 12
  return base + ' — ' + (base + 11)
})

const dateDayCells = computed(function() {
  const y = dateCursor.value.getFullYear()
  const m = dateCursor.value.getMonth()
  const today = dateYmd(new Date())
  const sel = dateSelectedStr.value
    ? (dateParse(dateSelectedStr.value) ? dateYmd(dateParse(dateSelectedStr.value)) : null)
    : null

  const sd = new Date(y, m, 1).getDay()
  const dim = new Date(y, m + 1, 0).getDate()
  const dip = new Date(y, m, 0).getDate()
  const total = Math.ceil((sd + dim) / 7) * 7

  const cells = []
  for (let i = 0; i < total; i++) {
    let date, isOther = false
    if (i < sd) {
      date = new Date(y, m - 1, dip - sd + 1 + i)
      isOther = true
    } else if (i >= sd + dim) {
      date = new Date(y, m + 1, i - sd - dim + 1)
      isOther = true
    } else {
      date = new Date(y, m, i - sd + 1)
    }
    const dw = date.getDay()
    const ymdVal = dateYmd(date)
    cells.push({
      ymd: ymdVal,
      day: date.getDate(),
      isOther: isOther,
      isWeekend: dw === 0 || dw === 6,
      isToday: ymdVal === today,
      isSelected: ymdVal === sel
    })
  }
  return cells
})

const dateYearRange = computed(function() {
  const base = Math.floor(dateCursor.value.getFullYear() / 12) * 12
  return Array.from({ length: 12 }, function(_, i) { return base + i })
})

function isDateMonthSelected(m) {
  const d = dateParse(dateSelectedStr.value)
  if (!d) return false
  return d.getFullYear() === dateCursor.value.getFullYear() && d.getMonth() === m
}

function openDate(r, c) {
  dateR.value = r
  dateC.value = c
  dateOpen.value = true
  const cur = dateParse(tableData.value[r]?.[props.columns[c]?.key])
  dateCursor.value = cur ? new Date(cur.getFullYear(), cur.getMonth(), 1) : new Date()
  dateCursor.value.setDate(1)
  dateView.value = 'day'
  nextTick(function() { positionPanel(r, c, 'date') })
}

function closeDate() {
  dateOpen.value = false
  dateR.value = -1
  dateC.value = -1
}

function commitDate(ymd) {
  if (dateR.value < 0 || dateC.value < 0) return
  const r = dateR.value
  const col = props.columns[dateC.value]
  tableData.value[r][col.key] = ymd
  emit('cell-change', { row: tableData.value[r], key: col.key, value: ymd, rowIndex: r })
  emit('update:data', tableData.value)
  emit('change', tableData.value)
  closeDate()
}

function clearDateValue() { commitDate('') }
function commitDateToday() { commitDate(dateYmd(new Date())) }

function dateStep(dir, byYear) {
  const cur = new Date(dateCursor.value)
  if (dateView.value === 'day') {
    byYear ? cur.setFullYear(cur.getFullYear() + dir) : cur.setMonth(cur.getMonth() + dir)
  } else if (dateView.value === 'month') {
    cur.setFullYear(cur.getFullYear() + dir)
  } else {
    cur.setFullYear(cur.getFullYear() + dir * 12)
  }
  dateCursor.value = cur
}

function dateDrillUp() {
  if (dateView.value === 'day') dateView.value = 'month'
  else if (dateView.value === 'month') dateView.value = 'year'
}

function pickDateMonth(m) {
  dateCursor.value = new Date(dateCursor.value.getFullYear(), m, 1)
  dateView.value = 'day'
}

function pickDateYear(yr) {
  dateCursor.value = new Date(yr, dateCursor.value.getMonth(), 1)
  dateView.value = 'month'
}

// ══════════════════ 定位计算 ══════════════════
function positionPanel(r, c, type) {
  const cell = cellRefs.value[r + '_' + c]
  if (!cell) return
  const rect = cell.getBoundingClientRect()

  if (type === 'drop') {
    const ph = Math.min(dropOptions.value.length * 32 + 8, 240)
    let top = rect.bottom
    if (top + ph > window.innerHeight) top = rect.top - ph
    dropStyle.value = {
      left: rect.left + 'px',
      top: top + 'px',
      minWidth: Math.max(rect.width, 100) + 'px'
    }
  } else if (type === 'date') {
    const pw = 240, ph = 285
    let left = rect.left
    if (left + pw > window.innerWidth) left = Math.max(8, window.innerWidth - pw - 8)
    let top = rect.bottom + 2
    if (top + ph > window.innerHeight) top = rect.top - ph - 2
    dateStyle.value = { left: left + 'px', top: top + 'px' }
  }
}

function onScroll() {
  if (dropOpen.value) positionPanel(dropR.value, dropC.value, 'drop')
  if (dateOpen.value) positionPanel(dateR.value, dateC.value, 'date')
}

function onGlobalMouseDown() {
  if (dropOpen.value || dateOpen.value) {
    closeDrop()
    closeDate()
  }
}

onMounted(function() {
  window.addEventListener('mousedown', onGlobalMouseDown)
  window.addEventListener('resize', onScroll)
})

onUnmounted(function() {
  window.removeEventListener('mousedown', onGlobalMouseDown)
  window.removeEventListener('resize', onScroll)
})

// ══════════════════ 基础行与多选逻辑 ══════════════════
function rowClasses(row) {
  const parts = []
  if (selectedIds.value.has(String(row[props.idKey]))) {
    parts.push('${namespace}-selected')
  }
  if (props.rowClassName) {
    parts.push(props.rowClassName(row))
  }
  return parts
}

const isAllChecked = computed(function() {
  return (
    tableData.value.length > 0 &&
    tableData.value.every(function(r) { return selectedIds.value.has(String(r[props.idKey])) })
  )
})

function toggleAll(checked) {
  tableData.value.forEach(function(r) {
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

function notifySelection() {
  emit('selection-change', Array.from(selectedIds.value))
}

function generateRowId() {
  return 'row_' + Date.now() + '_' + Math.random().toString(36).substr(2, 6)
}

function addRow(customData = {}) {
  const defaultTemplate =
    typeof props.defaultRowData === 'function'
      ? props.defaultRowData()
      : { ...props.defaultRowData }

  const blankRow = {}
  props.columns.forEach(function(col) {
    blankRow[col.key] = ''
  })

  const newRow = {
    [props.idKey]: generateRowId(),
    ...blankRow,
    ...defaultTemplate,
    ...customData
  }

  tableData.value.push(newRow)
  emit('update:data', tableData.value)
  emit('change', tableData.value)
  emit('row-add', { row: newRow, index: tableData.value.length - 1 })

  setTimeout(function() {
    if (scrollContainer.value) {
      scrollContainer.value.scrollTop = scrollContainer.value.scrollHeight
    }
  }, 50)
}

// ══════════════════ 结合 Feedback 组件的确认删除 ══════════════════
// 1. 单行删除
async function handleRemoveRow(index) {
  // 调用 Feedback 确认弹窗（返回 Promise<boolean>）
  const ok = await confirm('确认删除', '确定要删除此行数据吗？此操作无法撤销。')
  if (ok) {
    removeRow(index)
  }
}

function removeRow(index) {
  const removed = tableData.value.splice(index, 1)[0]
  if (removed && removed[props.idKey]) {
    selectedIds.value.delete(String(removed[props.idKey]))
    notifySelection()
  }
  emit('update:data', tableData.value)
  emit('change', tableData.value)
  emit('row-remove', { row: removed, index: index })
}

// 2. 批量删除
async function handleDeleteSelected() {
  const count = selectedIds.value.size
  if (count === 0) return

  // 调用 Feedback 确认弹窗
  const ok = await confirm('确认批量删除', '确定要删除已选中的 ' + count + ' 项数据吗？')
  if (ok) {
    deleteSelectedRows()
  }
}

function deleteSelectedRows() {
  const remaining = []
  const removed = []
  tableData.value.forEach(function(row, idx) {
    if (selectedIds.value.has(String(row[props.idKey]))) {
      removed.push({ row: row, index: idx })
    } else {
      remaining.push(row)
    }
  })
  tableData.value = remaining
  selectedIds.value.clear()
  notifySelection()
  emit('update:data', tableData.value)
  emit('change', tableData.value)
  emit('row-remove', removed)
}

function toggleSort(key) {
  if (sortKey.value === key) {
    sortAsc.value = !sortAsc.value
  } else {
    sortKey.value = key
    sortAsc.value = true
  }
  tableData.value.sort(function(a, b) {
    const va = a[sortKey.value]
    const vb = b[sortKey.value]
    if (typeof va === 'number' && typeof vb === 'number') {
      return sortAsc.value ? va - vb : vb - va
    }
    return sortAsc.value
      ? String(va ?? '').localeCompare(String(vb ?? ''))
      : String(vb ?? '').localeCompare(String(va ?? ''))
  })
}

function onRowClick(e, row, rowIndex) {
  emit('row-click', { row: row, rowIndex: rowIndex, event: e })
}

defineExpose({
  addRow: addRow,
  removeRow: removeRow,
  deleteSelectedRows: deleteSelectedRows,
  clearSelection: function() {
    selectedIds.value.clear()
    notifySelection()
  },
  getData: function() { return tableData.value }
})
</script>

<style scoped>
/* 核心布局 */
.${namespace}-data-table {
  flex: 1;
  display: flex;
  overflow: hidden;
  background: var(--${namespace}-bg, #fff);
  box-sizing: border-box;
}

.${namespace}-list-area {
  flex: 1;
  display: flex;
  flex-direction: column;
  overflow: hidden;
  position: relative;
}

/* 顶部操作工具栏 */
.${namespace}-table-toolbar {
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: 8px 12px;
  background: var(--${namespace}-bg, #fff);
  border-bottom: 1px solid var(--${namespace}-bl, #e8e8e8);
  gap: 8px;
}

.${namespace}-toolbar-left,
.${namespace}-toolbar-right {
  display: flex;
  align-items: center;
  gap: 8px;
}

.${namespace}-btn {
  height: 28px;
  padding: 0 12px;
  border-radius: 3px;
  font-size: 12px;
  cursor: pointer;
  display: inline-flex;
  align-items: center;
  justify-content: center;
  gap: 5px;
  border: 1px solid var(--${namespace}-bd, #d9d9d9);
  background: var(--${namespace}-bg, #fff);
  color: var(--${namespace}-t, #333);
  transition: all 0.2s;
}

.${namespace}-btn-primary {
  background: var(--${namespace}-p, #1890ff);
  color: #fff;
  border-color: var(--${namespace}-p, #1890ff);
}
.${namespace}-btn-primary:hover {
  background: var(--${namespace}-ph, #40a9ff);
  border-color: var(--${namespace}-ph, #40a9ff);
}

.${namespace}-btn-danger {
  background: var(--${namespace}-rb, #ff4d4f);
  color: #fff;
  border-color: var(--${namespace}-rb, #ff4d4f);
}
.${namespace}-btn-danger:hover {
  opacity: 0.88;
}

/* 行内删除操作按钮 */
.${namespace}-action-cell {
  padding: 0 4px !important;
}

.${namespace}-btn-action-del {
  display: inline-flex;
  align-items: center;
  justify-content: center;
  gap: 4px;
  height: 24px;
  padding: 0 8px;
  font-size: 12px;
  color: var(--${namespace}-rb, #ff4d4f);
  background-color: var(--${namespace}-danger-bg, #fff1f0);
  border: 1px solid var(--${namespace}-danger-bd, #ffccc7);
  border-radius: 4px;
  cursor: pointer;
  outline: none;
  transition: all 0.2s cubic-bezier(0.645, 0.045, 0.355, 1);
  user-select: none;
}

.${namespace}-btn-action-del:hover {
  color: #fff;
  background-color: var(--${namespace}-rb, #ff4d4f);
  border-color: var(--${namespace}-rb, #ff4d4f);
  box-shadow: 0 2px 5px rgba(255, 77, 79, 0.25);
}

.${namespace}-btn-action-del:active {
  background-color: #d9363e;
  border-color: #d9363e;
  transform: translateY(1px);
}

.${namespace}-action-icon,
.${namespace}-icon-svg {
  flex-shrink: 0;
  vertical-align: middle;
}

/* 加载遮罩 */
.${namespace}-data-table__loading-mask {
  position: absolute;
  top: 0; left: 0; right: 0; bottom: 0;
  z-index: 20;
  display: flex;
  align-items: center;
  justify-content: center;
  background: rgba(255, 255, 255, 0.6);
}

.${namespace}-data-table__loading-text {
  padding: 8px 20px;
  background: var(--${namespace}-primary-bg, #e6f7ff);
  border-radius: 4px;
  font-size: 13px;
  color: var(--${namespace}-p, #1890ff);
}

/* 表格容器 */
.${namespace}-table-container {
  flex: 1;
  overflow: auto;
  position: relative;
  background: var(--${namespace}-bg, #fff);
}

.${namespace}-table {
  width: 100%;
  table-layout: fixed;
  border-collapse: separate;
  border-spacing: 0;
  font-size: 13px;
  color: var(--${namespace}-t, #333);
}

/* 表头样式（与标准分页表格一致） */
.${namespace}-table thead th {
  position: sticky;
  top: 0;
  z-index: 10;
  background: var(--${namespace}-pb, #fafafa);
  color: var(--${namespace}-p, #1890ff);
  padding: 8px 10px;
  font-weight: bold;
  text-align: left;
  white-space: nowrap;
  border-bottom: 1px solid var(--${namespace}-pbd, #e8e8e8);
  border-right: 1px solid var(--${namespace}-pbd, #e8e8e8);
}
.${namespace}-table thead th:first-child { border-left: 1px solid var(--${namespace}-pbd, #e8e8e8); }
.${namespace}-table thead th:last-child { border-right: none; }

.${namespace}-table thead th.${namespace}-sortable { cursor: pointer; user-select: none; }
.${namespace}-table thead th.${namespace}-sortable:hover { background: var(--${namespace}-ph, #f0f0f0); }
.${namespace}-sort-icon { font-size: 10px; margin-left: 4px; opacity: 0.4; }
.${namespace}-table thead th.${namespace}-asc .${namespace}-sort-icon::after { content: '▲'; opacity: 1; }
.${namespace}-table thead th.${namespace}-desc .${namespace}-sort-icon::after { content: '▼'; opacity: 1; }

/* 表体单元格：默认状态与分页表格完全一致 */
.${namespace}-table tbody td {
  padding: 6px 10px;
  border-bottom: 1px solid var(--${namespace}-bl, #e8e8e8);
  border-right: 1px solid var(--${namespace}-bl, #e8e8e8);
  white-space: nowrap;
  vertical-align: middle;
  height: 38px;
  box-sizing: border-box;
  font-size: 13px;
  color: var(--${namespace}-t, #333);
  user-select: text;
}
.${namespace}-table tbody td:last-child { border-right: none; }

/* 斑马纹与悬浮 */
.${namespace}-table tbody tr:nth-child(even) td { background: var(--${namespace}-bg-page, #fcfcfc); }
.${namespace}-table tbody tr:hover td { background: var(--${namespace}-primary-bg, #f5faff); }
.${namespace}-table tbody tr.${namespace}-selected td { background: var(--${namespace}-primary-hover, #e6f7ff); }

/* 点击选中的单元格微高亮边框 */
.${namespace}-table tbody td.${namespace}-cell-active {
  outline: 1px dashed var(--${namespace}-p, #1890ff);
  outline-offset: -1px;
}

.${namespace}-tc { text-align: center; }
.${namespace}-index-cell { color: var(--${namespace}-tm, #888); font-size: 12px; }

/* 未编辑时的纯文本展示 */
.${namespace}-cell-text {
  display: block;
  overflow: hidden;
  text-overflow: ellipsis;
  white-space: nowrap;
}

/* 激活编辑状态时的样式 */
.${namespace}-table tbody td.${namespace}-cell-editing {
  padding: 2px 4px;
  background: var(--${namespace}-bg, #fff) !important;
}

.${namespace}-cell-editor {
  width: 100%;
  height: 100%;
  display: flex;
  align-items: center;
}

.${namespace}-cell-input {
  width: 100%;
  height: 30px;
  padding: 0 8px;
  font-size: 13px;
  color: var(--${namespace}-t, #333);
  background: var(--${namespace}-bg, #fff);
  border: 1px solid var(--${namespace}-p, #1890ff);
  border-radius: 3px;
  box-sizing: border-box;
  outline: none;
  box-shadow: 0 0 0 2px rgba(24, 144, 255, 0.15);
}

.${namespace}-checkbox {
  width: 14px;
  height: 14px;
  accent-color: var(--${namespace}-p, #1890ff);
  cursor: pointer;
  vertical-align: middle;
}

/* 底部状态信息栏 */
.${namespace}-table-footer {
  flex-shrink: 0;
  display: flex;
  align-items: center;
  justify-content: flex-end;
  padding: 6px 14px;
  background: var(--${namespace}-bg, #fff);
  border-top: 1px solid var(--${namespace}-bd, #e8e8e8);
  font-size: 12px;
  color: var(--${namespace}-tm, #666);
}
</style>

<!-- ════════ 全局浮层面板样式 (Teleport to body) ════════ -->
<style>
/* 浮动下拉菜单面板 */
.${namespace}-drop-panel {
  position: fixed;
  z-index: 9999;
  background: var(--${namespace}-bg, #fff);
  border: 1px solid var(--${namespace}-p, #1890ff);
  border-radius: 3px;
  box-shadow: 0 4px 16px rgba(0, 0, 0, 0.12);
  max-height: 220px;
  overflow-y: auto;
  box-sizing: border-box;
}

.${namespace}-drop-item {
  padding: 6px 14px;
  cursor: pointer;
  font-size: 13px;
  white-space: nowrap;
  color: var(--${namespace}-t, #333);
  transition: background 0.15s ease;
}

.${namespace}-drop-item:hover {
  background: var(--${namespace}-primary-bg, #f5faff);
}

.${namespace}-drop-item.active {
  background: rgba(24, 144, 255, 0.1);
  font-weight: 600;
  color: var(--${namespace}-p, #1890ff);
}

/* 浮动日历面板 */
.${namespace}-date-panel {
  position: fixed;
  z-index: 9999;
  background: var(--${namespace}-bg, #fff);
  border: 1px solid var(--${namespace}-p, #1890ff);
  border-radius: 4px;
  box-shadow: 0 4px 18px rgba(0, 0, 0, 0.15);
  width: 240px;
  overflow: hidden;
  font-family: inherit;
  box-sizing: border-box;
}

.${namespace}-date-head {
  background: linear-gradient(135deg, var(--${namespace}-primary-dark, #096dd9) 0%, var(--${namespace}-p, #1890ff) 100%);
  color: #fff;
  display: flex;
  align-items: center;
  height: 30px;
  padding: 0 4px;
  gap: 2px;
}

.${namespace}-date-nav {
  width: 22px;
  height: 22px;
  display: flex;
  align-items: center;
  justify-content: center;
  cursor: pointer;
  border-radius: 2px;
  font-size: 13px;
  flex-shrink: 0;
  color: rgba(255, 255, 255, 0.85);
}

.${namespace}-date-nav:hover {
  background: rgba(255, 255, 255, 0.2);
  color: #fff;
}

.${namespace}-date-title {
  flex: 1;
  text-align: center;
  font-size: 12px;
  font-weight: bold;
  cursor: pointer;
  padding: 2px 4px;
  border-radius: 2px;
}

.${namespace}-date-title:hover {
  background: rgba(255, 255, 255, 0.15);
}

.${namespace}-date-weekdays {
  display: grid;
  grid-template-columns: repeat(7, 1fr);
  background: var(--${namespace}-primary-bg, #f5faff);
  border-bottom: 1px solid var(--${namespace}-bl, #e8e8e8);
}

.${namespace}-date-wd {
  text-align: center;
  font-size: 11px;
  font-weight: bold;
  color: var(--${namespace}-p, #1890ff);
  padding: 4px 0;
}

.${namespace}-date-days {
  display: grid;
  grid-template-columns: repeat(7, 1fr);
  padding: 4px;
  gap: 2px;
}

.${namespace}-date-day {
  text-align: center;
  font-size: 11px;
  padding: 4px 0;
  cursor: pointer;
  border-radius: 2px;
  color: var(--${namespace}-t, #333);
  line-height: 1.4;
  transition: all 0.15s ease;
}

.${namespace}-date-day:hover {
  background: var(--${namespace}-primary-bg, #e6f7ff);
  color: var(--${namespace}-p, #1890ff);
}

.${namespace}-date-day.is-other {
  color: var(--${namespace}-tl, #bbb);
}

.${namespace}-date-day.is-today {
  font-weight: bold;
  color: var(--${namespace}-p, #1890ff);
  border: 1px solid var(--${namespace}-p, #1890ff);
}

.${namespace}-date-day.is-selected {
  background: var(--${namespace}-p, #1890ff) !important;
  color: #fff !important;
  font-weight: bold;
}

.${namespace}-date-my-grid {
  display: grid;
  grid-template-columns: repeat(4, 1fr);
  padding: 8px 6px;
  gap: 4px;
}

.${namespace}-date-my-item {
  text-align: center;
  font-size: 12px;
  padding: 6px 2px;
  cursor: pointer;
  border-radius: 3px;
  color: var(--${namespace}-t, #333);
  transition: all 0.15s ease;
}

.${namespace}-date-my-item:hover {
  background: var(--${namespace}-primary-bg, #e6f7ff);
  color: var(--${namespace}-p, #1890ff);
}

.${namespace}-date-my-item.is-selected {
  background: var(--${namespace}-p, #1890ff);
  color: #fff;
  font-weight: bold;
}

.${namespace}-date-footer {
  border-top: 1px solid var(--${namespace}-bl, #e8e8e8);
  padding: 4px 8px;
  display: flex;
  align-items: center;
  justify-content: space-between;
  background: var(--${namespace}-bg-page, #fcfcfc);
}

.${namespace}-date-today-btn {
  font-size: 11px;
  color: var(--${namespace}-p, #1890ff);
  cursor: pointer;
  padding: 2px 4px;
  border-radius: 2px;
}

.${namespace}-date-today-btn:hover {
  background: var(--${namespace}-primary-bg, #e6f7ff);
}

.${namespace}-date-clear-btn {
  font-size: 11px;
  color: var(--${namespace}-tm, #999);
  cursor: pointer;
  padding: 2px 4px;
  border-radius: 2px;
}

.${namespace}-date-clear-btn:hover {
  color: var(--${namespace}-rb, #ff4d4f);
  background: var(--${namespace}-danger-bg, #fff1f0);
}
</style>