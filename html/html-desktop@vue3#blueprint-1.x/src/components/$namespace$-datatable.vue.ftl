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
      <div class="${namespace}-table-container" ref="scrollContainer">
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

              <!-- 业务数据列 (表头居中对齐) -->
              <th
                v-for="(col, ci) in columns"
                :key="col.key"
                :style="{ width: col.width || '', textAlign: col.headerAlign || col.titleAlign || 'center' }"
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
              <th v-if="showRowAction" style="width: 95px" class="${namespace}-tc">操作</th>
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
                  '${namespace}-cell-editing': isCellEditing(rowIndex, col.key),
                  '${namespace}-cell-ms': col.type === 'multiselect',
                  '${namespace}-cell-tp': col.type === 'time' || col.type === 'timepicker',
                  '${namespace}-cell-cscd': col.type === 'cascade' || col.type === 'cascader'
                }"
                :style="{ textAlign: col.align || 'left' }"
                @click="onCellClick(rowIndex, colIndex)"
                @dblclick.stop="startEdit(row, col, rowIndex, colIndex)"
              >
                <!-- 1. Checkbox 开关类型 (点击直接切换) -->
                <div v-if="col.type === 'check' || col.type === 'checkbox'" class="${namespace}-tc" @click.stop>
                  <input
                    type="checkbox"
                    :checked="!!row[col.key]"
                    :disabled="col.disabled"
                    class="${namespace}-checkbox"
                    @change="toggleCheckbox(row, col.key, $event.target.checked, rowIndex)"
                  />
                </div>

                <!-- 2. 原地输入编辑态 (text / number，双击触发) -->
                <div
                  v-else-if="isCellEditing(rowIndex, col.key) && (!col.type || col.type === 'text' || col.type === 'number')"
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

                <!-- 3. Dropdown 单选组件编辑态 (双击触发) -->
                <div
                  v-else-if="isCellEditing(rowIndex, col.key) && col.type === 'select'"
                  class="${namespace}-cell-editor"
                  @click.stop
                >
                  <Dropdown
                    ref="activeEditorRef"
                    :model-value="row[col.key]"
                    :options="col.options || col.opts || []"
                    :placeholder="col.placeholder || '请选择...'"
                    :searchable="col.searchable ?? false"
                    :clearable="col.clearable ?? true"
                    :disabled="col.disabled"
                    plain
                    @update:model-value="(val) => onSelectChange(row, col, val, rowIndex)"
                  />
                </div>

                <!-- 4. DatePicker 日期组件编辑态 (双击触发) -->
                <div
                  v-else-if="isCellEditing(rowIndex, col.key) && col.type === 'date'"
                  class="${namespace}-cell-editor"
                  @click.stop
                >
                  <DatePicker
                    ref="activeEditorRef"
                    :model-value="row[col.key]"
                    :placeholder="col.placeholder || '请选择日期'"
                    :format="col.format || 'YYYY-MM-DD'"
                    :min-date="col.minDate"
                    :max-date="col.maxDate"
                    :disabled="col.disabled"
                    plain
                    @update:model-value="(val) => onDateChange(row, col, val, rowIndex)"
                  />
                </div>

                <!-- 5. MultiSelect 多选组件编辑态 (双击触发) -->
                <div
                  v-else-if="isCellEditing(rowIndex, col.key) && col.type === 'multiselect'"
                  class="${namespace}-cell-multiselect"
                  @click.stop
                >
                  <MultiSelect
                    ref="activeEditorRef"
                    :model-value="normalizeMultiSelectValue(row[col.key])"
                    :options="col.options || col.opts || []"
                    :placeholder="col.placeholder || '请选择...'"
                    :searchable="col.searchable ?? true"
                    :disabled="col.disabled"
                    :show-select-all="col.showSelectAll ?? true"
                    :max-count="col.maxCount || 0"
                    :max-tag-count="col.maxTagCount || 2"
                    :value-key="col.valueKey || 'value'"
                    :label-key="col.labelKey || 'label'"
                    plain
                    block
                    @change="(vals) => onMultiSelectChange(row, col, vals, rowIndex)"
                  />
                </div>

                <!-- 6. TimePicker 时间组件编辑态 (双击触发) -->
                <div
                  v-else-if="isCellEditing(rowIndex, col.key) && (col.type === 'time' || col.type === 'timepicker')"
                  class="${namespace}-cell-time"
                  @click.stop
                >
                  <TimePicker
                    ref="activeEditorRef"
                    :model-value="row[col.key] || ''"
                    :placeholder="col.placeholder || '选择时间...'"
                    :format="col.format || 'HH:mm'"
                    :disabled="col.disabled"
                    :min-time="col.minTime"
                    :max-time="col.maxTime"
                    @change="(val) => onTimeChange(row, col, val, rowIndex)"
                  />
                </div>

                <!-- 7. Cascader 级联组件编辑态 (双击触发) -->
                <div
                  v-else-if="isCellEditing(rowIndex, col.key) && (col.type === 'cascade' || col.type === 'cascader')"
                  class="${namespace}-cell-cascader"
                  @click.stop
                >
                  <Cascader
                    ref="activeEditorRef"
                    :model-value="normalizeCascaderValue(row[col.key])"
                    :labels="col.labelsKey ? row[col.labelsKey] : col.labels"
                    :options="col.options || col.opts || []"
                    :fetch-options="col.fetchOptions"
                    :placeholder="col.placeholder || '请选择...'"
                    :placeholders="col.placeholders"
                    :levels="col.levels"
                    :disabled="col.disabled"
                    :separator="col.separator || '/'"
                    :variant="col.variant || 'single'"
                    plain
                    @change="(path, labels) => onCascaderChange(row, col, path, labels, rowIndex)"
                  />
                </div>

                <!-- 8. 统一只读显示状态 (未双击编辑时纯文本展示，支持 placeholder) -->
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

                  <!-- select 只读 -->
                  <span
                    v-else-if="col.type === 'select'"
                    class="${namespace}-cell-text"
                    :class="{ '${namespace}-cell-placeholder': getSelectDisplayText(col, row[col.key]).isPlaceholder }"
                  >
                    {{ getSelectDisplayText(col, row[col.key]).text }}
                  </span>

                  <!-- date 只读 -->
                  <span
                    v-else-if="col.type === 'date'"
                    class="${namespace}-cell-text"
                    :class="{ '${namespace}-cell-placeholder': getDateDisplayText(col, row[col.key]).isPlaceholder }"
                  >
                    {{ getDateDisplayText(col, row[col.key]).text }}
                  </span>

                  <!-- time 只读 -->
                  <span
                    v-else-if="col.type === 'time' || col.type === 'timepicker'"
                    class="${namespace}-cell-text"
                    :class="{ '${namespace}-cell-placeholder': getTimeDisplayText(col, row[col.key]).isPlaceholder }"
                  >
                    {{ getTimeDisplayText(col, row[col.key]).text }}
                  </span>

                  <!-- multiselect 只读 -->
                  <span
                    v-else-if="col.type === 'multiselect'"
                    class="${namespace}-cell-text"
                    :class="{ '${namespace}-cell-placeholder': getMultiSelectDisplayText(col, row[col.key]).isPlaceholder }"
                  >
                    {{ getMultiSelectDisplayText(col, row[col.key]).text }}
                  </span>

                  <!-- cascade 只读 -->
                  <span
                    v-else-if="col.type === 'cascade' || col.type === 'cascader'"
                    class="${namespace}-cell-text"
                    :class="{ '${namespace}-cell-placeholder': getCascaderDisplayText(col, row).isPlaceholder }"
                  >
                    {{ getCascaderDisplayText(col, row).text }}
                  </span>

                  <!-- number 只读 -->
                  <span v-else-if="col.type === 'number'" class="${namespace}-cell-text">
                    {{ fmtNum(row[col.key]) }}
                  </span>

                  <!-- text 常规只读 -->
                  <span
                    v-else
                    class="${namespace}-cell-text"
                    :class="{ '${namespace}-cell-placeholder': !hasValue(row[col.key]) && col.placeholder }"
                  >
                    {{ hasValue(row[col.key]) ? formatCell(row[col.key]) : (col.placeholder || '') }}
                  </span>
                </template>
              </td>

              <!-- 操作列：常驻显眼的删除按钮 -->
              <td v-if="showRowAction" class="${namespace}-tc ${namespace}-action-cell" @click.stop>
                <button
                  type="button"
                  class="${namespace}-btn-action-del"
                  title="删除此行"
                  @click="handleRemoveRow(rowIndex)"
                >
                  <svg class="${namespace}-action-icon" viewBox="0 0 24 24" width="13" height="13" stroke="currentColor" stroke-width="2.2" fill="none" stroke-linecap="round" stroke-linejoin="round">
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

    <!-- ════════ 调用已有的 Feedback 确认组件 ════════ -->
    <FeedbackDialog
      :dialog="feedbackDialog"
      :on-close="onFeedbackClose"
    />
  </div>
</template>

<script setup>
import { ref, computed, watch, nextTick, onMounted, onUnmounted } from 'vue'
import FeedbackDialog from './${namespace}-feedback.vue'
import MultiSelect from './${namespace}-multiselect.vue'
import TimePicker from './${namespace}-timepicker.vue'
import Cascader from './${namespace}-cascadepicker.vue'
import DatePicker from './${namespace}-datepicker.vue'
import Dropdown from './${namespace}-dropdown.vue'

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

// 当前处于双击编辑中的单元格
const editCell = ref({ r: -1, c: -1, key: null, originalValue: null, type: null })
const editInputRef = ref(null)
const activeEditorRef = ref(null)

// ══════════════════ 驱动 Feedback 组件状态 ══════════════════
const feedbackDialog = ref({
  show: false,
  type: 'confirm',
  title: '提示',
  message: '',
  resolve: null
})

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

function hasValue(val) {
  return val !== undefined && val !== null && val !== 'undefined' && val !== 'null' && val !== ''
}

function formatCell(val) {
  if (!hasValue(val)) return ''
  return val
}

function fmtNum(v) {
  if (!hasValue(v)) return ''
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
  if (!hasValue(val)) return ''
  const list = normalizeOptions(options)
  const item = list.find(function(o) { return String(o.value) === String(val) })
  return item ? item.label : formatCell(val)
}

// ══════════════════ 只读状态 Placeholder 解析 ══════════════════
function getSelectDisplayText(col, val) {
  const lbl = getSelectLabel(col.options || col.opts, val)
  if (hasValue(lbl)) {
    return { text: lbl, isPlaceholder: false }
  }
  return {
    text: col.placeholder || '请选择...',
    isPlaceholder: true
  }
}

function getDateDisplayText(col, val) {
  if (hasValue(val)) {
    return { text: String(val), isPlaceholder: false }
  }
  return {
    text: col.placeholder || '请选择日期...',
    isPlaceholder: true
  }
}

function getTimeDisplayText(col, val) {
  if (hasValue(val)) {
    return { text: String(val), isPlaceholder: false }
  }
  return {
    text: col.placeholder || '选择时间...',
    isPlaceholder: true
  }
}

function getMultiSelectDisplayText(col, val) {
  const vals = normalizeMultiSelectValue(val)
  if (!vals.length) {
    return { text: col.placeholder || '请选择...', isPlaceholder: true }
  }
  const opts = normalizeOptions(col.options || col.opts)
  const valKey = col.valueKey || 'value'
  const lblKey = col.labelKey || 'label'
  const labels = vals.map(v => {
    const item = opts.find(o => String(o[valKey] ?? o.value) === String(v))
    return item ? (item[lblKey] ?? item.label) : v
  })
  return { text: labels.join(', '), isPlaceholder: false }
}

function getCascaderDisplayText(col, row) {
  const sep = ' ' + (col.separator || '/') + ' '
  if (col.labelsKey && hasValue(row[col.labelsKey])) {
    const lblVal = row[col.labelsKey]
    if (Array.isArray(lblVal)) return { text: lblVal.join(sep), isPlaceholder: false }
    return { text: String(lblVal), isPlaceholder: false }
  }
  const path = normalizeCascaderValue(row[col.key])
  if (!path.length) {
    return { text: col.placeholder || '请选择...', isPlaceholder: true }
  }
  const labels = []
  let currNodes = col.options || col.opts || []
  for (const v of path) {
    const found = Array.isArray(currNodes) ? currNodes.find(n => String(n.value) === String(v)) : null
    if (found) {
      labels.push(found.label)
      currNodes = found.children || []
    } else {
      labels.push(String(v))
      currNodes = []
    }
  }
  return { text: labels.join(sep), isPlaceholder: false }
}

function isCellActive(r, c) {
  return activeCell.value.r === r && activeCell.value.c === c
}

function isCellEditing(r, key) {
  return editCell.value.r === r && editCell.value.key === key
}

function onCellClick(r, c) {
  activeCell.value = { r: r, c: c }
}

// ══════════════════ 数据更新处理函数 ══════════════════
function onSelectChange(row, col, val, rowIndex) {
  row[col.key] = val
  emit('cell-change', { row: row, key: col.key, value: val, rowIndex: rowIndex })
  emit('update:data', tableData.value)
  emit('change', tableData.value)
  closeActiveEditor()
}

function onDateChange(row, col, val, rowIndex) {
  row[col.key] = val
  emit('cell-change', { row: row, key: col.key, value: val, rowIndex: rowIndex })
  emit('update:data', tableData.value)
  emit('change', tableData.value)
  closeActiveEditor()
}

function normalizeMultiSelectValue(val) {
  if (Array.isArray(val)) return val
  if (!hasValue(val)) return []
  if (typeof val === 'string') {
    return val.split(',').map(s => s.trim()).filter(Boolean)
  }
  return [val]
}

function onMultiSelectChange(row, col, vals, rowIndex) {
  const isStringOutput = col.valueType === 'string' || (typeof row[col.key] === 'string' && !Array.isArray(row[col.key]))
  const finalVal = isStringOutput ? vals.join(',') : vals
  row[col.key] = finalVal
  emit('cell-change', { row: row, key: col.key, value: finalVal, rowIndex: rowIndex })
  emit('update:data', tableData.value)
  emit('change', tableData.value)
}

function onTimeChange(row, col, val, rowIndex) {
  row[col.key] = val
  emit('cell-change', { row: row, key: col.key, value: val, rowIndex: rowIndex })
  emit('update:data', tableData.value)
  emit('change', tableData.value)
  closeActiveEditor()
}

function normalizeCascaderValue(val) {
  if (Array.isArray(val)) return val
  if (!hasValue(val)) return []
  if (typeof val === 'string') {
    return val.split(/[,，/]/).map(s => s.trim()).filter(Boolean)
  }
  return [val]
}

function onCascaderChange(row, col, path, labels, rowIndex) {
  const sep = col.separator || '/'
  const isStringOutput = col.valueType === 'string' || (typeof row[col.key] === 'string' && !Array.isArray(row[col.key]))
  const finalVal = isStringOutput ? path.join(sep) : path
  row[col.key] = finalVal

  if (col.labelsKey) {
    row[col.labelsKey] = col.labelsType === 'string' ? labels.join(sep) : labels
  }

  emit('cell-change', { row: row, key: col.key, value: finalVal, labels: labels, rowIndex: rowIndex })
  emit('update:data', tableData.value)
  emit('change', tableData.value)
  closeActiveEditor()
}

// ══════════════════ 核心：双击编辑与打开面板 ══════════════════
function startEdit(row, col, r, c) {
  if (col.disabled || col.editable === false) return

  finishInputEditNow()
  if (col.type === 'check' || col.type === 'checkbox') return

  // 激活当前单元格编辑状态
  editCell.value = { r: r, c: c, key: col.key, originalValue: row[col.key], type: col.type }
  emit('cell-edit-start', { row: row, col: col, rowIndex: r })

  nextTick(function() {
    // 文本/数字输入框自动获取焦点并全选
    if (editInputRef.value) {
      const el = Array.isArray(editInputRef.value) ? editInputRef.value[0] : editInputRef.value
      el?.focus?.()
      el?.select?.()
    }
    // 独立组件：自动触发打开面板逻辑
    if (activeEditorRef.value) {
      const comp = Array.isArray(activeEditorRef.value) ? activeEditorRef.value[0] : activeEditorRef.value
      if (typeof comp?.openPanel === 'function') {
        comp.openPanel()
      } else if (typeof comp?.open === 'function') {
        comp.open()
      } else if (typeof comp?.togglePanel === 'function') {
        comp.togglePanel()
      } else {
        const trigger = comp?.$el?.querySelector?.(
          '.${namespace}-dd-trigger, .${namespace}-dp__trigger, .${namespace}-cscd__trigger, .${namespace}-ms__trigger, .${namespace}-tp__trigger'
        ) || comp?.$el
        trigger?.click?.()
      }
    }
  })
}

function closeActiveEditor() {
  editCell.value = { r: -1, c: -1, key: null, originalValue: null, type: null }
}

function finishInputEdit(row, col, r, val) {
  if (editCell.value.r !== r || editCell.value.key !== col.key) return
  const finalVal = (col.type === 'number' && val !== '') ? (Number(val) || 0) : val
  row[col.key] = finalVal
  closeActiveEditor()
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
  closeActiveEditor()
}

function toggleCheckbox(row, key, checked, r) {
  row[key] = checked
  emit('cell-change', { row: row, key: key, value: checked, rowIndex: r })
  emit('update:data', tableData.value)
  emit('change', tableData.value)
}

// ══════════════════ 点击页面外部时退出编辑态 ══════════════════
function onGlobalMouseDown(e) {
  // 如果点击的是各类浮层面板内部，不打断编辑交互
  if (e?.target?.closest?.(
    '.${namespace}-dd-panel, .${namespace}-dp__panel, .${namespace}-ms__panel, .${namespace}-tp__panel, .${namespace}-cscd__panel'
  )) {
    return
  }
  finishInputEditNow()
  if (editCell.value.r >= 0) {
    closeActiveEditor()
  }
}

onMounted(function() {
  window.addEventListener('mousedown', onGlobalMouseDown)
})

onUnmounted(function() {
  window.removeEventListener('mousedown', onGlobalMouseDown)
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
    if (col.type === 'multiselect' || col.type === 'cascade' || col.type === 'cascader') {
      blankRow[col.key] = col.valueType === 'string' ? '' : []
    } else {
      blankRow[col.key] = ''
    }
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

// ══════════════════ 确认删除 ══════════════════
async function handleRemoveRow(index) {
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

async function handleDeleteSelected() {
  const count = selectedIds.value.size
  if (count === 0) return

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
    if (Array.isArray(va) || Array.isArray(vb)) {
      const sa = Array.isArray(va) ? va.join(',') : String(va ?? '')
      const sb = Array.isArray(vb) ? vb.join(',') : String(vb ?? '')
      return sortAsc.value ? sa.localeCompare(sb) : sb.localeCompare(sa)
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
  border-radius: 4px;
  font-size: 12px;
  font-weight: 500;
  cursor: pointer;
  display: inline-flex;
  align-items: center;
  justify-content: center;
  gap: 5px;
  border: 1px solid var(--${namespace}-bd, #d9d9d9);
  background: var(--${namespace}-bg, #fff);
  color: var(--${namespace}-t, #333);
  transition: all 0.2s cubic-bezier(0.645, 0.045, 0.355, 1);
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

/* 批量删除按钮 */
.${namespace}-btn-danger {
  background: var(--${namespace}-rb, #ff4d4f);
  color: #fff;
  border-color: var(--${namespace}-rb, #ff4d4f);
  box-shadow: 0 2px 4px rgba(255, 77, 79, 0.2);
}
.${namespace}-btn-danger:hover {
  background: #d9363e;
  border-color: #d9363e;
  box-shadow: 0 3px 8px rgba(217, 54, 62, 0.35);
  transform: translateY(-1px);
}
.${namespace}-btn-danger:active {
  background: #b3242b;
  border-color: #b3242b;
  transform: translateY(0);
}

/* 行内操作列 */
.${namespace}-action-cell {
  padding: 0 6px !important;
}

.${namespace}-btn-action-del {
  display: inline-flex;
  align-items: center;
  justify-content: center;
  gap: 4px;
  height: 25px;
  padding: 0 9px;
  font-size: 12px;
  font-weight: 500;
  color: #ffffff !important;
  background-color: #ff4d4f !important;
  border: 1px solid #ff4d4f !important;
  border-radius: 4px;
  cursor: pointer;
  outline: none;
  box-shadow: 0 2px 5px rgba(255, 77, 79, 0.28);
  transition: all 0.2s cubic-bezier(0.645, 0.045, 0.355, 1);
  user-select: none;
}

.${namespace}-btn-action-del:hover {
  color: #ffffff !important;
  background-color: #d9363e !important;
  border-color: #d9363e !important;
  box-shadow: 0 4px 10px rgba(217, 54, 62, 0.45);
  transform: translateY(-1px);
}

.${namespace}-btn-action-del:active {
  background-color: #b3242b !important;
  border-color: #b3242b !important;
  box-shadow: 0 1px 3px rgba(179, 36, 43, 0.4);
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

/* 表头样式（标题默认居中对齐） */
.${namespace}-table thead th {
  position: sticky;
  top: 0;
  z-index: 10;
  background: var(--${namespace}-pb, #fafafa);
  color: var(--${namespace}-p, #1890ff);
  padding: 8px 10px;
  font-weight: bold;
  text-align: center;
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

/* 表体单元格 */
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

/* 纯文本展示与占位符样式 */
.${namespace}-cell-text {
  display: block;
  overflow: hidden;
  text-overflow: ellipsis;
  white-space: nowrap;
  cursor: default;
}

.${namespace}-cell-placeholder {
  color: var(--${namespace}-text-light, #bfbfbf) !important;
  font-size: 12px;
  user-select: none;
}

/* 激活编辑状态时的样式 */
.${namespace}-table tbody td.${namespace}-cell-editing {
  padding: 2px 4px;
  background: var(--${namespace}-bg, #fff) !important;
}

.${namespace}-cell-editor,
.${namespace}-cell-multiselect,
.${namespace}-cell-time,
.${namespace}-cell-cascader {
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

/* 独立组件嵌入时的宽度与触发框自适应 */
.${namespace}-cell-editor :deep(.${namespace}-dd),
.${namespace}-cell-editor :deep(.${namespace}-dp),
.${namespace}-cell-time :deep(.${namespace}-tp),
.${namespace}-cell-cascader :deep(.${namespace}-cscd) {
  width: 100%;
  min-width: 0;
}
.${namespace}-cell-cascader :deep(.${namespace}-cscd--single .${namespace}-cscd__trigger--single) {
  min-width: 0;
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