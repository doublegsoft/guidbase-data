<template>
  <div class="xls-wrap">
    <div class="xls-sheet" ref="sheetRef">
      <table>
        <thead>
          <tr>
            <th class="xls-corner"></th>
            <th
              v-for="(col, ci) in columns"
              :key="col.key"
              class="xls-ch"
              :class="{ sc: isColSelected(ci) }"
              :style="colStyle(ci)"
              @click="sortCol(ci)"
            >
              {{ col.label || col.title }}
              <span v-if="sortIdx === ci" class="xls-sort">{{ sortDir === 1 ? '▲' : '▼' }}</span>
              <div class="xls-resize" @mousedown.stop="startResize($event, ci)"></div>
            </th>
          </tr>
        </thead>
        <tbody>
          <tr v-for="(row, ri) in localData" :key="ri">
            <th
              class="xls-rh"
              :class="{ sr: isRowSelected(ri) }"
              @click="selectRow(ri)"
              @contextmenu="showCtx($event, ri)"
            >{{ ri + 1 }}</th>
            <td
              v-for="(col, ci) in columns"
              :key="col.key"
              :class="tdClass(ri, ci)"
              :style="tdStyle(ri, ci)"
              @click="clickCell($event, ri, ci)"
              @dblclick="startEdit(ri, ci)"
              @contextmenu="showCtx($event, ri)"
            >
              <!-- 1. Checkbox 开关类型 (点击直接切换) -->
              <div v-if="col.type === 'check' || col.type === 'checkbox'" class="xls-cbc" @click.stop>
                <input
                  type="checkbox"
                  :checked="!!row[col.key]"
                  :disabled="col.disabled"
                  @change="toggleCb($event, ri, ci)"
                />
              </div>

              <!-- 2. 普通文本 / 数字输入框编辑态 (双击触发) -->
              <input
                v-else-if="editing(ri, ci) && isSimpleInputCol(col)"
                ref="editInput"
                class="xls-input"
                :type="col.type === 'number' ? 'number' : 'text'"
                :value="row[col.key] ?? ''"
                :placeholder="col.placeholder || ''"
                :disabled="col.disabled"
                @blur="commitEdit(ri, ci, $event.target.value)"
                @keydown="onEditKey($event, ri, ci)"
              />

              <!-- 3. Dropdown 单选组件编辑态 (双击触发) -->
              <div
                v-else-if="editing(ri, ci) && col.type === 'select'"
                class="xls-cell-comp"
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
                  @update:model-value="function(val) { onComponentCommit(ri, ci, val) }"
                />
              </div>

              <!-- 4. DatePicker 日期组件编辑态 (双击触发) -->
              <div
                v-else-if="editing(ri, ci) && col.type === 'date'"
                class="xls-cell-comp"
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
                  @update:model-value="function(val) { onComponentCommit(ri, ci, val) }"
                />
              </div>

              <!-- 5. TimePicker 时间组件编辑态 (双击触发) -->
              <div
                v-else-if="editing(ri, ci) && (col.type === 'time' || col.type === 'timepicker')"
                class="xls-cell-comp"
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
                  @change="function(val) { onComponentCommit(ri, ci, val) }"
                />
              </div>

              <!-- 6. MultiSelect 多选组件编辑态 (双击触发) -->
              <div
                v-else-if="editing(ri, ci) && col.type === 'multiselect'"
                class="xls-cell-comp"
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
                  @change="function(vals) { onMultiSelectCommit(ri, ci, col, vals) }"
                />
              </div>

              <!-- 7. Cascader 级联组件编辑态 (保存值作为 Array，界面展示 labels 用 / 分割) -->
              <div
                v-else-if="editing(ri, ci) && (col.type === 'cascade' || col.type === 'cascader')"
                class="xls-cell-comp"
                @click.stop
              >
                <Cascader
                  ref="activeEditorRef"
                  :model-value="normalizeCascaderValue(row[col.key])"
                  :labels="getCascaderLabels(col, row)"
                  :options="col.options || col.opts || []"
                  :fetch-options="getStableFetchOptions(col, row, ri)"
                  :placeholder="col.placeholder || '请选择...'"
                  :placeholders="col.placeholders"
                  :levels="col.levels"
                  :disabled="col.disabled"
                  :separator="col.separator || '/'"
                  :variant="col.variant || 'single'"
                  plain
                  @update:model-value="function(path) { onCascaderInput(ri, ci, col, path) }"
                  @change="function(path, labels) { onCascaderCommit(ri, ci, col, path, labels) }"
                />
              </div>

              <!-- 8. 统一只读显示状态 (展示 labels 用 / 分割，绝不显示编码/值，无值时留白) -->
              <div v-else class="xls-ci" :class="{ 'xls-ci--r': col.type === 'number' }">
                <span v-if="col.render" v-html="col.render(row[col.key], row, col)"></span>
                <span v-else-if="col.type === 'select'">{{ getSelectLabel(col, row[col.key]) }}</span>
                <span v-else-if="col.type === 'date'">{{ getDateText(row[col.key]) }}</span>
                <span v-else-if="col.type === 'time' || col.type === 'timepicker'">{{ getTimeText(row[col.key]) }}</span>
                <span v-else-if="col.type === 'multiselect'">{{ getMultiSelectText(col, row[col.key]) }}</span>
                <span v-else-if="col.type === 'cascade' || col.type === 'cascader'">{{ getCascaderText(col, row) }}</span>
                <span v-else-if="col.type === 'number'">{{ fmtNum(row[col.key]) }}</span>
                <span v-else>{{ hasValue(row[col.key]) ? row[col.key] : '' }}</span>
              </div>
            </td>
          </tr>
        </tbody>
      </table>
    </div>

    <!-- 右键菜单 (Context menu) -->
    <teleport to="body">
      <div
        v-if="ctxOn"
        class="xls-ctx"
        :style="ctxStyle"
        @click.stop
        @click.self="ctxOn = false"
      >
        <div class="xls-cxi" @click="ctxAct('ins-above')"><i class="ti ti-row-insert-top"></i>上方插入行</div>
        <div class="xls-cxi" @click="ctxAct('ins-below')"><i class="ti ti-row-insert-bottom"></i>下方插入行</div>
        <div class="xls-cxs"></div>
        <div class="xls-cxi xls-cxi--danger" @click="ctxAct('del')"><i class="ti ti-trash"></i>删除行</div>
        <div class="xls-cxs"></div>
        <div class="xls-cxi" @click="ctxAct('copy')"><i class="ti ti-copy"></i>复制 <span class="xls-cxsc">Ctrl+C</span></div>
        <div class="xls-cxi" @click="ctxAct('paste')"><i class="ti ti-clipboard"></i>粘贴 <span class="xls-cxsc">Ctrl+V</span></div>
        <div class="xls-cxs"></div>
        <div class="xls-cxi" @click="ctxAct('clear')"><i class="ti ti-eraser"></i>清除内容</div>
        <div class="xls-cxs"></div>
        <div class="xls-cxi" @click="ctxOn = false"><i class="ti ti-x"></i>关闭</div>
      </div>
    </teleport>
  </div>
</template>

<script setup>
import { ref, computed, watch, nextTick, onMounted, onUnmounted } from 'vue'
import Dropdown from './${namespace}-dropdown.vue'
import DatePicker from './${namespace}-datepicker.vue'
import TimePicker from './${namespace}-timepicker.vue'
import MultiSelect from './${namespace}-multiselect.vue'
import Cascader from './${namespace}-cascadepicker.vue'

const props = defineProps({
  columns:     { type: Array, required: true },
  data:        { type: Array, default: function() { return [] } },
  fetchData:   { type: Function, default: null },
  fetchParams: { type: Object, default: function() { return {} } },
  pageSize:    { type: Number, default: -1 },
  pageNumber:  { type: Number, default: 1 },
})

const emit = defineEmits(['update:data', 'cell-change'])

// ═══════════════════ State ═══════════════════
const selR = ref(-1)
const selC = ref(-1)
const selR2 = ref(-1)
const selC2 = ref(-1)
const editR = ref(-1)
const editC = ref(-1)
const sortIdx = ref(-1)
const sortDir = ref(1)

// 编辑器 DOM / 组件实例引用
const editInput = ref([])
const activeEditorRef = ref(null)

// 右键菜单状态
const ctxOn = ref(false)
const ctxR = ref(-1)
const ctxStyle = ref({})

// 其他排版与数据状态
const colW = ref({})
const styles = ref({})
const clip = ref(null)
const localData = ref([])
const sheetRef = ref(null)

watch(
  function() { return props.data },
  function(v) {
    localData.value = v.map(function(r) { return { ...r } })
  },
  { immediate: true, deep: true }
)

// ═══════════════════ 远端数据模式 ═══════════════════
const isServerMode = computed(function() { return typeof props.fetchData === 'function' })
const loading = ref(false)
let reqId = 0

async function loadData() {
  if (!isServerMode.value) return
  const id = ++reqId
  loading.value = true
  try {
    const params = { ...props.fetchParams }
    const res = await props.fetchData(params, props.pageNumber, props.pageSize)
    if (id !== reqId) return
    if (res) {
      localData.value = (res.data ?? []).map(function(r) { return { ...r } })
    } else {
      localData.value = []
    }
    sync()
  } catch (e) {
    if (id !== reqId) return
    console.error('ExcelForm fetchData error:', e)
    localData.value = []
    sync()
  } finally {
    if (id === reqId) {
      loading.value = false
    }
  }
}

watch(function() { return props.fetchParams }, function() { if (isServerMode.value) loadData() })
watch(function() { return props.fetchData }, function() { if (isServerMode.value) loadData() })

onMounted(function() { if (isServerMode.value) loadData() })

function refresh() { loadData() }
defineExpose({ refresh: refresh, loading: loading })

// ═══════════════════ 基础辅助函数 ═══════════════════
function ck(r, c) { return r + ',' + c }
function gs(r, c) { return styles.value[ck(r, c)] || {} }
function w(ci) { return colW.value[ci] || props.columns[ci]?.width || 90 }
function editing(ri, ci) { return editR.value === ri && editC.value === ci }

function hasValue(val) {
  return val !== undefined && val !== null && val !== 'undefined' && val !== 'null' && val !== ''
}

function fmtNum(v) {
  if (!hasValue(v)) return ''
  return Number(v).toLocaleString()
}

function isSimpleInputCol(col) {
  return !col.type || col.type === 'text' || col.type === 'number'
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

// ═══════════════════ 级联异步函数引用缓存与节点归一化 ═══════════════════
var stableFetchMap = {}

function normalizeLazyNodes(res) {
  var list = res
  if (res && typeof res === 'object' && Array.isArray(res.data)) {
    list = res.data
  } else if (res && typeof res === 'object' && Array.isArray(res.list)) {
    list = res.list
  }
  if (!Array.isArray(list)) return []
  return list.map(function(item) {
    if (typeof item === 'object' && item !== null) {
      var val = item.value !== undefined ? item.value : (item.id !== undefined ? item.id : item.key)
      var lbl = item.label !== undefined ? item.label : (item.name !== undefined ? item.name : item.title)
      return {
        value: val,
        label: lbl !== undefined ? String(lbl) : String(val),
        disabled: !!item.disabled,
        children: item.children,
        hasChildren: item.hasChildren !== undefined ? item.hasChildren : !!(item.children && item.children.length)
      }
    }
    return { value: item, label: String(item), hasChildren: false }
  })
}

function getStableFetchOptions(col, row, ri) {
  if (typeof col.fetchOptions !== 'function') return null
  var cacheId = col.key + '_' + ri
  if (!stableFetchMap[cacheId]) {
    stableFetchMap[cacheId] = async function(parentValue) {
      var extraParams = null
      var curRow = localData.value[ri] || row
      if (typeof col.fetchParams === 'function') {
        extraParams = col.fetchParams(curRow, ri, col)
      } else if (col.fetchParams && typeof col.fetchParams === 'object') {
        extraParams = col.fetchParams
      }
      try {
        var res = await col.fetchOptions(parentValue, curRow, ri, col, extraParams)
        return normalizeLazyNodes(res)
      } catch (err) {
        console.error('Cascader fetchOptions error:', err)
        return []
      }
    }
  }
  return stableFetchMap[cacheId]
}

// 获取 Cascader 绑定的 labels
function getCascaderLabels(col, row) {
  var field = col.optionLabels || col.labelsKey
  if (field && typeof field === 'string' && row[field]) {
    return row[field]
  }
  // 内部持久化的标签数组
  if (row['__' + col.key + '_labels'] && row['__' + col.key + '_labels'].length) {
    return row['__' + col.key + '_labels']
  }
  if (Array.isArray(col.optionLabels)) {
    return col.optionLabels
  }
  return col.labels || []
}

// ═══════════════════ 只读文本展示 (无值留白) ═══════════════════
function getSelectLabel(col, val) {
  if (!hasValue(val)) return ''
  const list = normalizeOptions(col.options || col.opts)
  const item = list.find(function(o) { return String(o.value) === String(val) })
  return item ? item.label : ''
}

function getDateText(val) {
  if (hasValue(val)) return String(val)
  return ''
}

function getTimeText(val) {
  if (hasValue(val)) return String(val)
  return ''
}

function normalizeMultiSelectValue(val) {
  if (Array.isArray(val)) return val
  if (!hasValue(val)) return []
  if (typeof val === 'string') return val.split(',').map(function(s) { return s.trim() }).filter(Boolean)
  return [val]
}

function getMultiSelectText(col, val) {
  const vals = normalizeMultiSelectValue(val)
  if (!vals.length) return ''
  const opts = normalizeOptions(col.options || col.opts)
  const valKey = col.valueKey || 'value'
  const lblKey = col.labelKey || 'label'
  const labels = []
  for (var i = 0; i < vals.length; i++) {
    var v = vals[i]
    var item = opts.find(function(o) { return String(o[valKey] ?? o.value) === String(v) })
    if (item && (item[lblKey] ?? item.label)) {
      labels.push(item[lblKey] ?? item.label)
    }
  }
  return labels.join(', ')
}

function normalizeCascaderValue(val) {
  if (Array.isArray(val)) return val
  if (!hasValue(val)) return []
  if (typeof val === 'string') return val.split(/[,，/]/).map(function(s) { return s.trim() }).filter(Boolean)
  return [val]
}

// ═══════════════════ ★ 核心：级联只读文本展示 labels 用 / 分割 ═══════════════════
function getCascaderText(col, row) {
  var sep = ' ' + (col.separator || '/') + ' '

  if (typeof col.formatter === 'function') {
    return col.formatter(row[col.key], row, col) || ''
  }

  if (typeof col.optionLabels === 'function') {
    return col.optionLabels(row, col) || ''
  }

  // 1. 优先读取业务指定的 optionLabels / labelsKey 字段
  var labelField = col.optionLabels || col.labelsKey
  if (labelField && typeof labelField === 'string' && hasValue(row[labelField])) {
    var fieldVal = row[labelField]
    if (Array.isArray(fieldVal)) return fieldVal.filter(Boolean).join(sep)
    return String(fieldVal)
  }

  // 2. 读取选择后组件内部持久化绑定的 labels 数组
  if (row['__' + col.key + '_labels'] && Array.isArray(row['__' + col.key + '_labels']) && row['__' + col.key + '_labels'].length) {
    return row['__' + col.key + '_labels'].filter(Boolean).join(sep)
  }

  // 3. 静态指定的 optionLabels 数组
  if (Array.isArray(col.optionLabels)) {
    return col.optionLabels.filter(Boolean).join(sep)
  }

  // 4. 若为静态 options，根据选中的 value 路径匹配出 labels
  var path = normalizeCascaderValue(row[col.key])
  if (!path.length) return ''
  var labels = []
  var currNodes = col.options || col.opts || []
  for (var i = 0; i < path.length; i++) {
    var v = path[i]
    var found = Array.isArray(currNodes)
      ? currNodes.find(function(n) { return String(n.value) === String(v) })
      : null
    if (found && found.label) {
      labels.push(found.label)
      currNodes = found.children || []
    } else {
      currNodes = []
    }
  }

  // 严格要求：只有找到匹配的 labels 才展示并用 / 分割，绝不显示编码/值
  if (labels.length) {
    return labels.join(sep)
  }
  return ''
}

// ═══════════════════ Computed ═══════════════════
const range = computed(function() {
  const r1 = Math.min(selR.value, selR2.value)
  const r2 = Math.max(selR.value, selR2.value)
  const c1 = Math.min(selC.value, selC2.value)
  const c2 = Math.max(selC.value, selC2.value)
  return { r1: r1, r2: r2, c1: c1, c2: c2 }
})

// ═══════════════════ Style ═══════════════════
function colStyle(ci) {
  const wpx = w(ci)
  return { width: wpx + 'px', minWidth: wpx + 'px' }
}

function tdStyle(ri, ci) {
  const wpx = w(ci)
  const s = gs(ri, ci)
  const isEditing = editR.value === ri && editC.value === ci
  return {
    width: wpx + 'px',
    minWidth: wpx + 'px',
    fontWeight: s.bold ? '700' : undefined,
    fontStyle: s.italic ? 'italic' : undefined,
    textDecoration: s.underline ? 'underline' : undefined,
    textAlign: s.align || undefined,
    overflow: isEditing ? 'visible' : undefined,
  }
}

function isColSelected(ci) {
  return selR.value >= 0 && ci >= range.value.c1 && ci <= range.value.c2
}

function isRowSelected(ri) {
  return selR.value >= 0 && ri >= range.value.r1 && ri <= range.value.r2
}

function tdClass(ri, ci) {
  return {
    sel: ri === selR.value && ci === selC.value,
    inr: !(ri === selR.value && ci === selC.value) &&
      ri >= range.value.r1 && ri <= range.value.r2 &&
      ci >= range.value.c1 && ci <= range.value.c2,
  }
}

// ═══════════════════ 核心交互：单击选区、双击编辑 ═══════════════════
function clickCell(e, r, c) {
  if (editR.value !== r || editC.value !== c) {
    finishEdit()
  }
  selR.value = r
  selC.value = c
  selR2.value = r
  selC2.value = c
}

function startEdit(r, c) {
  finishEdit()
  const col = props.columns[c]
  if (!col || col.disabled || col.editable === false || col.type === 'check' || col.type === 'checkbox') return
  editR.value = r
  editC.value = c

  nextTick(function() {
    const inp = editInput.value?.[0] || editInput.value
    if (inp) {
      inp.focus?.()
      try { inp.setSelectionRange?.(0, inp.value.length) } catch (e) {}
    }
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

function finishEdit() {
  if (editR.value < 0) return
  const col = props.columns[editC.value]
  if (isSimpleInputCol(col)) {
    const inp = editInput.value?.[0] || editInput.value
    if (inp) commitEdit(editR.value, editC.value, inp.value)
    else { editR.value = -1; editC.value = -1 }
  } else {
    editR.value = -1
    editC.value = -1
  }
  stableFetchMap = {}
}

function commitEdit(r, c, v) {
  const col = props.columns[c]
  const val = (col.type === 'number' && v !== '') ? (Number(v) || 0) : v
  localData.value[r] = { ...localData.value[r], [col.key]: val }
  editR.value = -1
  editC.value = -1
  stableFetchMap = {}
  emit('cell-change', { row: r, col: c, key: col.key, value: val })
  sync()
}

function onComponentCommit(r, c, val) {
  const col = props.columns[c]
  localData.value[r] = { ...localData.value[r], [col.key]: val }
  editR.value = -1
  editC.value = -1
  stableFetchMap = {}
  emit('cell-change', { row: r, col: c, key: col.key, value: val })
  sync()
}

function onMultiSelectCommit(r, c, col, vals) {
  const isStringOutput = col.valueType === 'string' || (typeof localData.value[r][col.key] === 'string' && !Array.isArray(localData.value[r][col.key]))
  const finalVal = isStringOutput ? vals.join(',') : vals
  localData.value[r] = { ...localData.value[r], [col.key]: finalVal }
  emit('cell-change', { row: r, col: c, key: col.key, value: finalVal })
  sync()
}

// 递进选择中直接更新 array，驱动下一列展开
function onCascaderInput(r, c, col, path) {
  var finalVal = (col.valueType === 'string') ? path.join(col.separator || '/') : path.slice()
  localData.value[r][col.key] = finalVal
}

// ═══════════════════ ★ 核心：保存选择的值为 Array，记录 labels ═══════════════════
function onCascaderCommit(r, c, col, path, labels) {
  var sep = col.separator || '/'
  // 1. 严格将选择的值作为 Array 保存 (除非显式指定 valueType === 'string')
  var finalPath = (col.valueType === 'string') ? path.join(sep) : path.slice()
  localData.value[r][col.key] = finalPath

  // 2. 内部持久化记录所选的 labels 数组，保障即使没有 optionLabels 字段名也能以 / 展示
  var internalLabelKey = '__' + col.key + '_labels'
  localData.value[r][internalLabelKey] = labels.slice()

  // 3. 同步写回用户配置的 optionLabels / labelsKey 字段
  var labelField = col.optionLabels || col.labelsKey
  if (labelField && typeof labelField === 'string') {
    var isLabelString = col.labelsType === 'string' || col.valueType === 'string'
    localData.value[r][labelField] = isLabelString ? labels.join(' ' + sep + ' ') : labels.slice()
  }

  editR.value = -1
  editC.value = -1
  stableFetchMap = {}
  emit('cell-change', { row: r, col: c, key: col.key, value: finalPath, labels: labels })
  sync()
}

function toggleCb(e, r, c) {
  localData.value[r] = { ...localData.value[r], [props.columns[c].key]: e.target.checked }
  selR.value = r
  selC.value = c
  selR2.value = r
  selC2.value = c
  sync()
}

function onEditKey(e, r, c) {
  if (e.key === 'Enter') { commitEdit(r, c, e.target.value); nav(1, 0) }
  else if (e.key === 'Tab') { e.preventDefault(); commitEdit(r, c, e.target.value); nav(0, e.shiftKey ? -1 : 1) }
  else if (e.key === 'Escape') { editR.value = -1; editC.value = -1; stableFetchMap = {} }
}

function nav(dr, dc) {
  selR.value = Math.max(0, Math.min(localData.value.length - 1, selR.value + dr))
  selC.value = Math.max(0, Math.min(props.columns.length - 1, selC.value + dc))
  selR2.value = selR.value
  selC2.value = selC.value
}

function selectRow(r) {
  selR.value = r
  selC.value = 0
  selR2.value = r
  selC2.value = props.columns.length - 1
}

// ═══════════════════ Sort ═══════════════════
function sortCol(ci) {
  if (sortIdx.value === ci) sortDir.value *= -1
  else { sortIdx.value = ci; sortDir.value = 1 }
  const k = props.columns[ci].key
  localData.value.sort(function(a, b) {
    const av = a[k], bv = b[k]
    if (typeof av === 'boolean') return (av === bv ? 0 : av ? -1 : 1) * sortDir.value
    if (typeof av === 'number' && typeof vb === 'number') return (av - bv) * sortDir.value
    if (Array.isArray(av) || Array.isArray(bv)) {
      const sa = Array.isArray(av) ? av.join(',') : String(av ?? '')
      const sb = Array.isArray(bv) ? bv.join(',') : String(bv ?? '')
      return sa.localeCompare(sb, 'zh') * sortDir.value
    }
    return String(av ?? '').localeCompare(String(bv ?? ''), 'zh') * sortDir.value
  })
  sync()
}

// ═══════════════════ Column resize ═══════════════════
let rzCi = -1, rzX = 0, rzW = 0
function startResize(e, ci) {
  e.preventDefault()
  rzCi = ci
  rzX = e.clientX
  rzW = w(ci)
  document.addEventListener('mousemove', onResize)
  document.addEventListener('mouseup', stopResize)
}

function onResize(e) {
  if (rzCi < 0) return
  colW.value = { ...colW.value, [rzCi]: Math.max(30, rzW + (e.clientX - rzX)) }
}

function stopResize() {
  rzCi = -1
  document.removeEventListener('mousemove', onResize)
  document.removeEventListener('mouseup', stopResize)
}

// ═══════════════════ Context menu ═══════════════════
function showCtx(e, r) {
  e.preventDefault()
  ctxR.value = r
  ctxOn.value = true
  ctxStyle.value = {
    left: Math.min(e.clientX, window.innerWidth - 190) + 'px',
    top: Math.min(e.clientY, window.innerHeight - 200) + 'px',
  }
}

function ctxAct(act) {
  ctxOn.value = false
  if (act === 'ins-above' && ctxR.value >= 0) { insRow(ctxR.value) }
  else if (act === 'ins-below' && ctxR.value >= 0) { insRow(ctxR.value + 1) }
  else if (act === 'del') {
    if (ctxR.value >= 0) { localData.value.splice(ctxR.value, 1); sync() }
    else delSel()
  }
  else if (act === 'copy') {
    if (selR.value >= 0) clip.value = JSON.parse(JSON.stringify(localData.value[selR.value]))
  }
  else if (act === 'paste' && clip.value) {
    localData.value.splice(
      ctxR.value >= 0 ? ctxR.value + 1 : selR.value + 1, 0,
      JSON.parse(JSON.stringify(clip.value))
    )
    sync()
  }
  else if (act === 'clear') { clearSel() }
}

function insRow(at) {
  const row = {}
  props.columns.forEach(function(c) {
    if (c.type === 'check' || c.type === 'checkbox') row[c.key] = false
    else if (c.type === 'number') row[c.key] = 0
    else if (c.type === 'multiselect' || c.type === 'cascade' || c.type === 'cascader') {
      row[c.key] = c.valueType === 'string' ? '' : []
    } else row[c.key] = ''
  })
  localData.value.splice(at, 0, row)
  sync()
}

function delSel() {
  if (selR.value < 0) return
  const r1 = range.value.r1
  const r2 = range.value.r2
  localData.value.splice(r1, r2 - r1 + 1)
  selR.value = Math.max(0, r1 - 1)
  selR2.value = selR.value
  sync()
}

function clearSel() {
  if (selR.value < 0) return
  const r1 = range.value.r1
  const r2 = range.value.r2
  const c1 = range.value.c1
  const c2 = range.value.c2
  for (let r = r1; r <= r2; r++) {
    for (let c = c1; c <= c2; c++) {
      if (props.columns[c].type !== 'check' && props.columns[c].type !== 'checkbox') {
        localData.value[r] = { ...localData.value[r], [props.columns[c].key]: '' }
      }
    }
  }
  sync()
}

function sync() {
  emit('update:data', [...localData.value])
}

// ═══════════════════ 全局监听与键盘导航 ═══════════════════
function onKey(e) {
  const tag = document.activeElement?.tagName || ''
  const inInp = tag === 'INPUT' || tag === 'SELECT' || tag === 'TEXTAREA'

  if (e.key === 'Escape') {
    if (editR.value >= 0) { editR.value = -1; editC.value = -1; stableFetchMap = {}; return }
    if (ctxOn.value) { ctxOn.value = false; return }
  }
  if (inInp || editR.value >= 0) return

  if (e.key === 'Delete' && selR.value >= 0) { clearSel(); return }
  if (e.key === 'ArrowDown')     { e.preventDefault(); nav(1, 0) }
  else if (e.key === 'ArrowUp')    { e.preventDefault(); nav(-1, 0) }
  else if (e.key === 'ArrowLeft')  { e.preventDefault(); nav(0, -1) }
  else if (e.key === 'ArrowRight') { e.preventDefault(); nav(0, 1) }
  else if (e.key === 'Enter' && selR.value >= 0) { e.preventDefault(); startEdit(selR.value, selC.value) }
  else if (e.key === 'Tab') { e.preventDefault(); nav(0, e.shiftKey ? -1 : 1) }
  else if (e.shiftKey && e.key === 'ArrowDown')  { e.preventDefault(); selR2.value = Math.min(localData.value.length - 1, selR2.value + 1) }
  else if (e.shiftKey && e.key === 'ArrowUp')    { e.preventDefault(); selR2.value = Math.max(0, selR2.value - 1) }
  else if (e.shiftKey && e.key === 'ArrowRight') { e.preventDefault(); selC2.value = Math.min(props.columns.length - 1, selC2.value + 1) }
  else if (e.shiftKey && e.key === 'ArrowLeft')  { e.preventDefault(); selC2.value = Math.max(0, selC2.value - 1) }
  else if ((e.ctrlKey || e.metaKey) && e.key.toLowerCase() === 'c') {
    e.preventDefault()
    if (selR.value >= 0) clip.value = JSON.parse(JSON.stringify(localData.value[selR.value]))
  }
  else if ((e.ctrlKey || e.metaKey) && e.key.toLowerCase() === 'v' && clip.value) {
    e.preventDefault()
    localData.value.splice(selR.value + 1, 0, JSON.parse(JSON.stringify(clip.value)))
    sync()
  }
}

function onDocClick(e) {
  if (e?.target?.closest?.(
    '.${namespace}-dd-panel, .${namespace}-dp__panel, .${namespace}-ms__panel, .${namespace}-tp__panel, .${namespace}-cscd__panel, .xls-ctx'
  )) {
    return
  }
  if (sheetRef.value && !sheetRef.value.contains(e.target)) {
    finishEdit()
  }
}

onMounted(function() {
  document.addEventListener('keydown', onKey)
  document.addEventListener('mousedown', onDocClick)
})

onUnmounted(function() {
  document.removeEventListener('keydown', onKey)
  document.removeEventListener('mousedown', onDocClick)
})
</script>

<style scoped>
/* ══════════════════════════════════════════════
   Excel Grid — 党政红色风 (BNR Design System)
   ══════════════════════════════════════════════ */
.xls-wrap { height: 100%; display: flex; flex-direction: column; overflow: hidden; }

/* Sheet */
.xls-sheet { flex: 1; overflow: auto; }
.xls-sheet::-webkit-scrollbar { width: 10px; height: 10px; }
.xls-sheet::-webkit-scrollbar-track { background: var(--${namespace}-bg-page); }
.xls-sheet::-webkit-scrollbar-thumb { background: var(--${namespace}-border); border-radius: 5px; border: 2px solid var(--${namespace}-bg-page); }

table { border-collapse: collapse; table-layout: fixed; }
.xls-corner {
  position: sticky; top: 0; left: 0; z-index: 12;
  background: var(--${namespace}-primary-bg); border: 1px solid var(--${namespace}-border-light); width: 46px; min-width: 46px;
}

/* Column headers */
th.xls-ch {
  position: sticky; top: 0; z-index: 10;
  background: var(--${namespace}-primary-bg); border: 1px solid var(--${namespace}-border-light);
  text-align: center; font-weight: 600; color: var(--${namespace}-text-muted);
  padding: 4px 6px; cursor: pointer; user-select: none;
  font-size: 12px; white-space: nowrap;
  transition: background 0.15s ease;
}
th.xls-ch:hover { background: var(--${namespace}-primary-hover); }
th.xls-ch.sc { background: var(--${namespace}-primary-hover); color: var(--${namespace}-primary-dark); }

/* Row headers */
th.xls-rh {
  position: sticky; left: 0; z-index: 9;
  background: var(--${namespace}-primary-bg); border: 1px solid var(--${namespace}-border-light);
  text-align: center; font-weight: 400; color: var(--${namespace}-text-muted);
  padding: 2px 4px; user-select: none; font-size: 11px; cursor: pointer;
  width: 46px; min-width: 46px;
  transition: background 0.15s ease;
}
th.xls-rh:hover { background: var(--${namespace}-primary-hover); }
th.xls-rh.sr { background: var(--${namespace}-primary-hover); }

/* Data cells */
td {
  border: 1px solid var(--${namespace}-border-light); padding: 0; height: 24px;
  vertical-align: middle; cursor: cell; position: relative; overflow: hidden;
  font-size: 13px; color: var(--${namespace}-text);
}
tr:nth-child(even) td { background: var(--${namespace}-bg-page); }
tr:nth-child(odd) td  { background: var(--${namespace}-bg); }
td.sel {
  background: rgba(190,0,0,.10) !important;
  outline: 2px solid var(--${namespace}-primary); outline-offset: -1px; z-index: 3; overflow: visible;
}
td.inr { background: rgba(190,0,0,.06) !important; }

/* 单元格纯文本内容 (默认留白) */
.xls-ci {
  padding: 1px 6px; height: 100%; display: flex; align-items: center;
  white-space: nowrap; overflow: hidden; text-overflow: ellipsis; pointer-events: none;
}
.xls-ci--r { justify-content: flex-end; }
.xls-cbc { display: flex; align-items: center; justify-content: center; height: 100%; }
.xls-cbc input { width: 14px; height: 14px; accent-color: var(--${namespace}-primary); cursor: pointer; }

/* Edit input — 普通文本输入高亮 */
.xls-input {
  position: absolute; inset: 0; z-index: 20; width: 100%; height: 100%;
  padding: 1px 6px; border: none; outline: 2px solid var(--${namespace}-primary);
  font-size: 13px; font-family: inherit; background: var(--${namespace}-bg);
  box-shadow: 0 0 0 4px rgba(190,0,0,.15), 0 2px 12px rgba(0,0,0,.15);
}

/* 单元格内嵌组件编辑态容器 */
.xls-cell-comp {
  position: absolute; inset: 0; z-index: 20; display: flex; align-items: center;
  background: var(--${namespace}-bg); outline: 2px solid var(--${namespace}-primary);
  box-shadow: 0 0 0 4px rgba(190,0,0,.15), 0 2px 12px rgba(0,0,0,.15);
}

/* 独立组件嵌入时的尺寸自适应 */
.xls-cell-comp :deep(.${namespace}-dd),
.xls-cell-comp :deep(.${namespace}-dp),
.xls-cell-comp :deep(.${namespace}-tp),
.xls-cell-comp :deep(.${namespace}-ms),
.xls-cell-comp :deep(.${namespace}-cscd) {
  width: 100%;
  min-width: 0;
  height: 100%;
}
.xls-cell-comp :deep(.${namespace}-dd-trigger),
.xls-cell-comp :deep(.${namespace}-dp__trigger),
.xls-cell-comp :deep(.${namespace}-tp__trigger),
.xls-cell-comp :deep(.${namespace}-ms__trigger),
.xls-cell-comp :deep(.${namespace}-cscd__trigger) {
  height: 100%;
  border: none;
  background: transparent;
}

/* 列宽拖拽指示线 */
.xls-resize {
  position: absolute; right: -3px; top: 0; width: 6px; height: 100%;
  cursor: col-resize; z-index: 11;
}
.xls-resize:hover { background: rgba(190,0,0,.25); }
.xls-sort { font-size: 10px; margin-left: 2px; opacity: .5; }

/* 右键菜单 Context menu */
.xls-ctx {
  position: fixed; z-index: 9998;
  background: var(--${namespace}-bg); border: 1px solid var(--${namespace}-border-light);
  border-radius: 2px; box-shadow: 0 4px 16px rgba(45,37,34,.10);
  min-width: 170px; padding: 4px 0; font-size: 13px;
}
.xls-cxi {
  padding: 5px 16px; cursor: pointer;
  display: flex; align-items: center; gap: 8px; white-space: nowrap;
  color: var(--${namespace}-text); transition: background 0.15s ease;
}
.xls-cxi:hover { background: var(--${namespace}-primary-bg); }
.xls-cxi i { font-size: 14px; color: var(--${namespace}-text-muted); width: 16px; }
.xls-cxi--danger, .xls-cxi--danger i { color: var(--${namespace}-danger); }
.xls-cxs { height: 1px; background: var(--${namespace}-border-light); margin: 3px 0; }
.xls-cxsc { margin-left: auto; font-size: 11px; color: var(--${namespace}-text-light); }
</style>