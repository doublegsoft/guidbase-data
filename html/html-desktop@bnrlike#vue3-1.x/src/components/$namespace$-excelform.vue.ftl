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
              {{ col.label }}
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
              <!-- Checkbox -->
              <div v-if="col.type === 'check'" class="xls-cbc">
                <input
                  type="checkbox"
                  :checked="!!row[col.key]"
                  @change="toggleCb($event, ri, ci)"
                />
              </div>

              <!-- Editing input (text/num) -->
              <input
                v-else-if="editing(ri, ci) && col.type !== 'select' && col.type !== 'date'"
                ref="editInput"
                class="xls-input"
                :value="row[col.key] ?? ''"
                @blur="commitEdit(ri, ci, $event.target.value)"
                @keydown="onEditKey($event, ri, ci)"
              />

              <!-- Dropdown: open trigger -->
              <div
                v-else-if="dropOpen && dropR === ri && dropC === ci"
                class="xls-drop-trigger"
                @mousedown.stop
              >
                <span>{{ row[col.key] ?? '' }}</span>
                <span class="xls-drop-arrow">▾</span>
              </div>

              <!-- Date: open trigger -->
              <div
                v-else-if="dateOpen && dateR === ri && dateC === ci"
                class="xls-date-trigger"
                @mousedown.stop
              >
                <span>{{ row[col.key] ?? '' }}</span>
                <span class="xls-date-arrow">📅</span>
              </div>

              <!-- Date: display -->
              <div
                v-else-if="col.type === 'date'"
                class="xls-ci"
                style="justify-content:space-between;padding-right:3px"
              >
                <span v-if="col.render" v-html="col.render(row[col.key], row, col)"></span>
                <span v-else>{{ row[col.key] ?? '' }}</span>
                <span class="xls-drop-hint">📅</span>
              </div>

              <!-- Dropdown: display -->
              <div
                v-else-if="col.type === 'select'"
                class="xls-ci"
                style="justify-content:space-between;padding-right:3px"
              >
                <span v-if="col.render" v-html="col.render(row[col.key], row, col)"></span>
                <span v-else>{{ row[col.key] }}</span>
                <span class="xls-drop-hint">▾</span>
              </div>

              <!-- Number -->
              <div v-else-if="col.type === 'number'" class="xls-ci xls-ci--r">
                <span v-if="col.render" v-html="col.render(row[col.key], row, col)"></span>
                <span v-else>{{ fmtNum(row[col.key]) }}</span>
              </div>

              <!-- Text (default) -->
              <div v-else class="xls-ci">
                <span v-if="col.render" v-html="col.render(row[col.key], row, col)"></span>
                <span v-else>{{ row[col.key] ?? '' }}</span>
              </div>
            </td>
          </tr>
        </tbody>
      </table>
    </div>

    <!-- Dropdown panel -->
    <teleport to="body">
      <div
        v-if="dropOpen"
        class="xls-drop-panel"
        :style="dropStyle"
        @mousedown.stop
      >
        <div
          v-for="opt in dropOpts"
          :key="opt"
          class="xls-drop-item"
          :class="{ active: localData[dropR]?.[columns[dropC]?.key] === opt }"
          @mousedown.prevent.stop
          @click.stop="commitDrop(opt)"
        >{{ opt }}</div>
      </div>
    </teleport>

    <!-- Date picker panel -->
    <teleport to="body">
      <div
        v-if="dateOpen"
        class="xls-date-panel"
        :style="dateStyle"
        @mousedown.stop
      >
        <div class="xls-date-head">
          <div class="xls-date-nav" @mousedown.prevent.stop @click.stop="dateStep(-1, true)">&laquo;</div>
          <div class="xls-date-nav" @mousedown.prevent.stop @click.stop="dateStep(-1, false)">&lsaquo;</div>
          <div class="xls-date-title" @mousedown.prevent.stop @click.stop="dateDrillUp">{{ dateTitle }}</div>
          <div class="xls-date-nav" @mousedown.prevent.stop @click.stop="dateStep(1, false)">&rsaquo;</div>
          <div class="xls-date-nav" @mousedown.prevent.stop @click.stop="dateStep(1, true)">&raquo;</div>
        </div>

        <template v-if="dateView === 'day'">
          <div class="xls-date-weekdays">
            <div v-for="w in dateWeekdays" :key="w" class="xls-date-wd">{{ w }}</div>
          </div>
          <div class="xls-date-days">
            <div
              v-for="d in dateDayCells"
              :key="d.ymd"
              class="xls-date-day"
              :class="{
                'xls-date-day--other': d.isOther,
                'xls-date-day--weekend': d.isWeekend,
                'xls-date-day--today': d.isToday,
                'xls-date-day--selected': d.isSelected,
              }"
              @mousedown.prevent.stop
              @click.stop="commitDate(d.ymd)"
            >{{ d.day }}</div>
          </div>
        </template>

        <div v-if="dateView === 'month'" class="xls-date-my-grid">
          <div
            v-for="m in 12" :key="m"
            class="xls-date-my-item"
            :class="{ 'xls-date-my-item--selected': isDateMonthSelected(m - 1) }"
            @mousedown.prevent.stop
            @click.stop="pickDateMonth(m - 1)"
          >{{ m }}月</div>
        </div>

        <div v-if="dateView === 'year'" class="xls-date-my-grid">
          <div
            v-for="yr in dateYearRange" :key="yr"
            class="xls-date-my-item"
            :class="{ 'xls-date-my-item--selected': yr === dateSelectedYear }"
            @mousedown.prevent.stop
            @click.stop="pickDateYear(yr)"
          >{{ yr }}</div>
        </div>

        <div class="xls-date-footer">
          <span class="xls-date-today" @mousedown.prevent.stop @click.stop="commitDateToday">今天</span>
          <span class="xls-date-clear" @mousedown.prevent.stop @click.stop="clearDateValue">清除</span>
        </div>
      </div>
    </teleport>

    <!-- Context menu -->
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

const props = defineProps({
  columns:     { type: Array, required: true },
  data:        { type: Array, default: () => [] },
  // ── 远端数据获取 ──
  // fetchData: async (params, pageNumber, pageSize) => { data: [...], total: N }
  fetchData:   { type: Function, default: null },
  // fetchParams: 传入 fetchData 的搜索条件参数
  fetchParams: { type: Object, default: () => ({}) },
  // pageSize 总是 -1 表示不分页，pageNumber 总是 1
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
// dropdown
const dropR = ref(-1)
const dropC = ref(-1)
const dropOpen = ref(false)
const dropStyle = ref({})
// date picker
const dateR = ref(-1)
const dateC = ref(-1)
const dateOpen = ref(false)
const dateView = ref('day')
const dateCursor = ref(new Date())
const dateStyle = ref({})
// context menu
const ctxOn = ref(false)
const ctxR = ref(-1)
const ctxStyle = ref({})
// other
const colW = ref({})
const styles = ref({})
const clip = ref(null)
const localData = ref([])
const sheetRef = ref(null)
const editInput = ref([])

watch(() => props.data, v => {
  localData.value = v.map(r => ({ ...r }))
}, { immediate: true, deep: true })

// ═══════════════════ Remote data mode ═══════════════════
const isServerMode = computed(() => typeof props.fetchData === 'function')
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
      localData.value = (res.data ?? []).map(r => ({ ...r }))
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

// fetchParams 引用变化 → 重新加载
watch(() => props.fetchParams, () => {
  if (isServerMode.value) loadData()
})

// fetchData 函数变化 → 重新加载
watch(() => props.fetchData, () => {
  if (isServerMode.value) loadData()
})

onMounted(() => {
  if (isServerMode.value) loadData()
})

// Expose refresh
function refresh() { loadData() }
defineExpose({ refresh, loading })

// ═══════════════════ Helpers ═══════════════════
const ck = (r, c) => ${r"`${r},${c}`"}
const gs = (r, c) => styles.value[ck(r, c)] || {}
const w  = ci => colW.value[ci] || props.columns[ci]?.width || 90
const editing = (ri, ci) => editR.value === ri && editC.value === ci

// date helpers
const dateYmd = d =>
  d.getFullYear() + '-' +
  String(d.getMonth() + 1).padStart(2, '0') + '-' +
  String(d.getDate()).padStart(2, '0')
const dateParse = s => {
  if (!s) return null
  const n = String(s).replace(/\//g, '-').replace(/年|月/g, '-').replace(/日/g, '')
  const d = new Date(n)
  return isNaN(d.getTime()) ? null : d
}
const dateWeekdays = ['日', '一', '二', '三', '四', '五', '六']

// ═══════════════════ Computed ═══════════════════
const range = computed(() => {
  const r1 = Math.min(selR.value, selR2.value)
  const r2 = Math.max(selR.value, selR2.value)
  const c1 = Math.min(selC.value, selC2.value)
  const c2 = Math.max(selC.value, selC2.value)
  return { r1, r2, c1, c2 }
})

const dropOpts = computed(() =>
  dropC.value >= 0 ? props.columns[dropC.value]?.opts || [] : []
)

const dateSelectedStr = computed(() => {
  if (dateR.value < 0 || dateC.value < 0) return null
  return localData.value[dateR.value]?.[props.columns[dateC.value]?.key] ?? null
})

const dateSelectedYear = computed(() => {
  const d = dateParse(dateSelectedStr.value)
  return d ? d.getFullYear() : null
})

const dateTitle = computed(() => {
  const y = dateCursor.value.getFullYear()
  const m = dateCursor.value.getMonth()
  if (dateView.value === 'day')   return y + '年 ' + (m + 1) + '月'
  if (dateView.value === 'month') return y + '年'
  const base = Math.floor(y / 12) * 12
  return base + ' — ' + (base + 11)
})

const dateDayCells = computed(() => {
  const y = dateCursor.value.getFullYear()
  const m = dateCursor.value.getMonth()
  const today = dateYmd(new Date())
  const sel = dateSelectedStr.value
    ? (dateParse(dateSelectedStr.value) ? dateYmd(dateParse(dateSelectedStr.value)) : null)
    : null

  const sd  = new Date(y, m, 1).getDay()
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
      isOther,
      isWeekend: dw === 0 || dw === 6,
      isToday: ymdVal === today,
      isSelected: ymdVal === sel,
    })
  }
  return cells
})

const dateYearRange = computed(() => {
  const base = Math.floor(dateCursor.value.getFullYear() / 12) * 12
  return Array.from({ length: 12 }, (_, i) => base + i)
})

const isDateMonthSelected = m => {
  const d = dateParse(dateSelectedStr.value)
  if (!d) return false
  return d.getFullYear() === dateCursor.value.getFullYear() && d.getMonth() === m
}

// ═══════════════════ Style ═══════════════════
const colStyle = ci => {
  const wpx = w(ci)
  return { width: wpx + 'px', minWidth: wpx + 'px' }
}

const tdStyle = (ri, ci) => {
  const wpx = w(ci)
  const s = gs(ri, ci)
  const open = (editR.value === ri && editC.value === ci) ||
    (dropOpen.value && dropR.value === ri && dropC.value === ci) ||
    (dateOpen.value && dateR.value === ri && dateC.value === ci)
  return {
    width: wpx + 'px',
    minWidth: wpx + 'px',
    fontWeight: s.bold ? '700' : undefined,
    fontStyle: s.italic ? 'italic' : undefined,
    textDecoration: s.underline ? 'underline' : undefined,
    textAlign: s.align || undefined,
    overflow: open ? 'visible' : undefined,
  }
}

const isColSelected = ci =>
  selR.value >= 0 && ci >= range.value.c1 && ci <= range.value.c2

const isRowSelected = ri =>
  selR.value >= 0 && ri >= range.value.r1 && ri <= range.value.r2

const tdClass = (ri, ci) => ({
  sel: ri === selR.value && ci === selC.value,
  inr: !(ri === selR.value && ci === selC.value) &&
    ri >= range.value.r1 && ri <= range.value.r2 &&
    ci >= range.value.c1 && ci <= range.value.c2,
})

// ═══════════════════ Cell interaction ═══════════════════
const clickCell = (e, r, c) => {
  if (dropOpen.value && (dropR.value !== r || dropC.value !== c)) closeDrop()
  if (dateOpen.value && (dateR.value !== r || dateC.value !== c)) closeDate()
  finishEdit()
  selR.value = r; selC.value = c; selR2.value = r; selC2.value = c
  const col = props.columns[c]
  if (col?.type === 'select') { editR.value = r; editC.value = c; openDrop(r, c) }
  else if (col?.type === 'date') { editR.value = r; editC.value = c; openDate(r, c) }
}

const startEdit = (r, c) => {
  closeDrop(); closeDate()
  const col = props.columns[c]
  if (col.type === 'check') return
  if (col.type === 'select') { editR.value = r; editC.value = c; openDrop(r, c); return }
  if (col.type === 'date') { editR.value = r; editC.value = c; openDate(r, c); return }
  editR.value = r; editC.value = c
  nextTick(() => {
    const inp = editInput.value?.[0]
    if (inp) { inp.focus(); try { inp.setSelectionRange(9999, 9999) } catch {} }
  })
}

const finishEdit = () => {
  if (editR.value < 0) return
  const col = props.columns[editC.value]
  if (col.type === 'select') { closeDrop(); editR.value = -1; editC.value = -1; return }
  if (col.type === 'date') { closeDate(); editR.value = -1; editC.value = -1; return }
  if (col.type === 'text' || col.type === 'number') {
    const inp = editInput.value?.[0]
    if (inp) commitEdit(editR.value, editC.value, inp.value)
    else { editR.value = -1; editC.value = -1 }
  } else { editR.value = -1; editC.value = -1 }
}

const commitEdit = (r, c, v) => {
  const col = props.columns[c]
  const val = (col.type === 'number' && v !== '') ? (Number(v) || 0) : v
  localData.value[r] = { ...localData.value[r], [col.key]: val }
  editR.value = -1; editC.value = -1
  emit('cell-change', { row: r, col: c, key: col.key, value: val })
  sync()
}

const toggleCb = (e, r, c) => {
  localData.value[r] = { ...localData.value[r], [props.columns[c].key]: e.target.checked }
  selR.value = r; selC.value = c; selR2.value = r; selC2.value = c
  sync()
}

const onEditKey = (e, r, c) => {
  if (e.key === 'Enter') { commitEdit(r, c, e.target.value); nav(1, 0) }
  else if (e.key === 'Tab') { e.preventDefault(); commitEdit(r, c, e.target.value); nav(0, e.shiftKey ? -1 : 1) }
  else if (e.key === 'Escape') { editR.value = -1; editC.value = -1 }
}

const nav = (dr, dc) => {
  selR.value = Math.max(0, Math.min(localData.value.length - 1, selR.value + dr))
  selC.value = Math.max(0, Math.min(props.columns.length - 1, selC.value + dc))
  selR2.value = selR.value; selC2.value = selC.value
}

const selectRow = r => {
  selR.value = r; selC.value = 0
  selR2.value = r; selC2.value = props.columns.length - 1
}

const fmtNum = v => {
  if (v === '' || v == null) return ''
  return Number(v).toLocaleString()
}

// ═══════════════════ Sort ═══════════════════
const sortCol = ci => {
  if (sortIdx.value === ci) sortDir.value *= -1
  else { sortIdx.value = ci; sortDir.value = 1 }
  const k = props.columns[ci].key
  localData.value.sort((a, b) => {
    const av = a[k], bv = b[k]
    if (typeof av === 'boolean') return (av === bv ? 0 : av ? -1 : 1) * sortDir.value
    if (typeof av === 'number' && typeof bv === 'number') return (av - bv) * sortDir.value
    return String(av ?? '').localeCompare(String(bv ?? ''), 'zh') * sortDir.value
  })
  sync()
}

// ═══════════════════ Column resize ═══════════════════
let rzCi = -1, rzX = 0, rzW = 0
const startResize = (e, ci) => {
  e.preventDefault(); rzCi = ci; rzX = e.clientX; rzW = w(ci)
  document.addEventListener('mousemove', onResize)
  document.addEventListener('mouseup', stopResize)
}
const onResize = e => {
  if (rzCi < 0) return
  colW.value = { ...colW.value, [rzCi]: Math.max(30, rzW + (e.clientX - rzX)) }
}
const stopResize = () => {
  rzCi = -1
  document.removeEventListener('mousemove', onResize)
  document.removeEventListener('mouseup', stopResize)
}

// ═══════════════════ Dropdown picker ═══════════════════
const openDrop = (r, c) => {
  dropR.value = r; dropC.value = c; dropOpen.value = true
  nextTick(() => positionDrop(r, c))
}
const closeDrop = () => { dropOpen.value = false; dropR.value = -1; dropC.value = -1 }
const positionDrop = (r, c) => {
  const rows = sheetRef.value?.querySelectorAll('tbody tr')
  const cell = rows?.[r]?.cells?.[c + 1]
  if (!cell) return
  const rect = cell.getBoundingClientRect()
  const ph = dropOpts.value.length * 32 + 8
  let top = rect.bottom
  if (top + ph > window.innerHeight) top = rect.top - ph
  dropStyle.value = {
    left: rect.left + 'px',
    top: top + 'px',
    minWidth: rect.width + 'px',
  }
}
const commitDrop = v => {
  if (dropR.value < 0 || dropC.value < 0) return
  localData.value[dropR.value] = {
    ...localData.value[dropR.value],
    [props.columns[dropC.value].key]: v,
  }
  editR.value = -1; editC.value = -1; closeDrop(); sync()
}

// ═══════════════════ Date picker ═══════════════════
const openDate = (r, c) => {
  dateR.value = r; dateC.value = c; dateOpen.value = true
  const cur = dateParse(localData.value[r]?.[props.columns[c]?.key])
  dateCursor.value = cur ? new Date(cur.getFullYear(), cur.getMonth(), 1) : new Date()
  dateCursor.value.setDate(1)
  dateView.value = 'day'
  nextTick(() => positionDate(r, c))
}
const closeDate = () => { dateOpen.value = false; dateR.value = -1; dateC.value = -1 }
const positionDate = (r, c) => {
  const rows = sheetRef.value?.querySelectorAll('tbody tr')
  const cell = rows?.[r]?.cells?.[c + 1]
  if (!cell) return
  const rect = cell.getBoundingClientRect()
  const pw = 232, ph = 280
  let left = rect.left; if (left + pw > window.innerWidth) left = Math.max(0, window.innerWidth - pw)
  let top = rect.bottom + 2; if (top + ph > window.innerHeight) top = rect.top - ph - 2
  dateStyle.value = { left: left + 'px', top: top + 'px' }
}
const commitDate = ymd => {
  if (dateR.value < 0 || dateC.value < 0) return
  localData.value[dateR.value] = {
    ...localData.value[dateR.value],
    [props.columns[dateC.value].key]: ymd,
  }
  editR.value = -1; editC.value = -1; closeDate(); sync()
}
const clearDateValue = () => {
  if (dateR.value < 0 || dateC.value < 0) return
  localData.value[dateR.value] = {
    ...localData.value[dateR.value],
    [props.columns[dateC.value].key]: '',
  }
  editR.value = -1; editC.value = -1; closeDate(); sync()
}
const commitDateToday = () => commitDate(dateYmd(new Date()))
const dateStep = (dir, byYear) => {
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
const dateDrillUp = () => {
  if (dateView.value === 'day') dateView.value = 'month'
  else if (dateView.value === 'month') dateView.value = 'year'
}
const pickDateMonth = m => {
  dateCursor.value = new Date(dateCursor.value.getFullYear(), m, 1)
  dateView.value = 'day'
}
const pickDateYear = yr => {
  dateCursor.value = new Date(yr, dateCursor.value.getMonth(), 1)
  dateView.value = 'month'
}

// ═══════════════════ Context menu ═══════════════════
const showCtx = (e, r) => {
  e.preventDefault(); ctxR.value = r; ctxOn.value = true
  ctxStyle.value = {
    left: Math.min(e.clientX, window.innerWidth - 190) + 'px',
    top: Math.min(e.clientY, window.innerHeight - 200) + 'px',
  }
}
const ctxAct = act => {
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

const insRow = at => {
  const row = {}
  props.columns.forEach(c => {
    if (c.type === 'check') row[c.key] = false
    else if (c.type === 'number') row[c.key] = 0
    else row[c.key] = ''
  })
  localData.value.splice(at, 0, row); sync()
}
const delSel = () => {
  if (selR.value < 0) return
  const { r1, r2 } = range.value
  localData.value.splice(r1, r2 - r1 + 1)
  selR.value = Math.max(0, r1 - 1); selR2.value = selR.value; sync()
}
const clearSel = () => {
  if (selR.value < 0) return
  const { r1, r2, c1, c2 } = range.value
  for (let r = r1; r <= r2; r++)
    for (let c = c1; c <= c2; c++)
      if (props.columns[c].type !== 'check')
        localData.value[r] = { ...localData.value[r], [props.columns[c].key]: '' }
  sync()
}

const sync = () => emit('update:data', [...localData.value])

// ═══════════════════ Keyboard ═══════════════════
const onKey = e => {
  const tag = document.activeElement?.tagName || ''
  const inInp = tag === 'INPUT' || tag === 'SELECT' || tag === 'TEXTAREA'
  if (dropOpen.value && e.key === 'Escape') { closeDrop(); editR.value = -1; editC.value = -1; return }
  if (dateOpen.value && e.key === 'Escape') { closeDate(); editR.value = -1; editC.value = -1; return }
  if (inInp) return
  if (e.key === 'Delete' && selR.value >= 0) { clearSel(); return }
  if (e.key === 'ArrowDown')     { e.preventDefault(); if (editR.value < 0) nav(1, 0) }
  else if (e.key === 'ArrowUp')    { e.preventDefault(); if (editR.value < 0) nav(-1, 0) }
  else if (e.key === 'ArrowLeft')  { e.preventDefault(); if (editR.value < 0) nav(0, -1) }
  else if (e.key === 'ArrowRight') { e.preventDefault(); if (editR.value < 0) nav(0, 1) }
  else if (e.key === 'Enter' && selR.value >= 0 && editR.value < 0) { e.preventDefault(); startEdit(selR.value, selC.value) }
  else if (e.key === 'Escape' && editR.value >= 0) { editR.value = -1; editC.value = -1 }
  else if (e.key === 'Tab') { e.preventDefault(); if (editR.value < 0) nav(0, e.shiftKey ? -1 : 1) }
  else if (e.shiftKey && e.key === 'ArrowDown')  { e.preventDefault(); selR2.value = Math.min(localData.value.length - 1, selR2.value + 1) }
  else if (e.shiftKey && e.key === 'ArrowUp')    { e.preventDefault(); selR2.value = Math.max(0, selR2.value - 1) }
  else if (e.shiftKey && e.key === 'ArrowRight') { e.preventDefault(); selC2.value = Math.min(props.columns.length - 1, selC2.value + 1) }
  else if (e.shiftKey && e.key === 'ArrowLeft')  { e.preventDefault(); selC2.value = Math.max(0, selC2.value - 1) }
  else if ((e.ctrlKey || e.metaKey) && e.key.toLowerCase() === 'c') {
    e.preventDefault(); if (selR.value >= 0) clip.value = JSON.parse(JSON.stringify(localData.value[selR.value]))
  }
  else if ((e.ctrlKey || e.metaKey) && e.key.toLowerCase() === 'v' && clip.value) {
    e.preventDefault(); localData.value.splice(selR.value + 1, 0, JSON.parse(JSON.stringify(clip.value))); sync()
  }
}

// reposition panels on scroll
watch([dropOpen, dropR, dropC], () => {
  if (dropOpen.value) positionDrop(dropR.value, dropC.value)
})
watch([dateOpen, dateR, dateC], () => {
  if (dateOpen.value) positionDate(dateR.value, dateC.value)
})

onMounted(() => document.addEventListener('keydown', onKey))
onUnmounted(() => document.removeEventListener('keydown', onKey))
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

/* Column headers — 浅红暖调 */
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

/* Row headers — 浅红暖调 */
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

/* Data cells — 暖条纹背景 */
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

/* Cell content */
.xls-ci {
  padding: 1px 6px; height: 100%; display: flex; align-items: center;
  white-space: nowrap; overflow: hidden; text-overflow: ellipsis; pointer-events: none;
}
.xls-ci--r { justify-content: flex-end; }
.xls-cbc { display: flex; align-items: center; justify-content: center; height: 100%; }
.xls-cbc input { width: 14px; height: 14px; accent-color: var(--${namespace}-primary); cursor: pointer; }
.xls-drop-hint { font-size: 10px; color: var(--${namespace}-text-light); flex-shrink: 0; padding-left: 2px; }

/* Edit input — 党政红聚焦 */
.xls-input {
  position: absolute; inset: 0; z-index: 20; width: 100%; height: 100%;
  padding: 1px 6px; border: none; outline: 2px solid var(--${namespace}-primary);
  font-size: 13px; font-family: inherit; background: var(--${namespace}-bg);
  box-shadow: 0 0 0 4px rgba(190,0,0,.15), 0 2px 12px rgba(0,0,0,.15);
}

/* Dropdown trigger — 党政红聚焦 */
.xls-drop-trigger {
  position: absolute; inset: 0; display: flex; align-items: center;
  padding: 0 4px 0 6px; font-size: 13px; cursor: pointer;
  background: var(--${namespace}-bg); outline: 2px solid var(--${namespace}-primary); z-index: 20;
  box-shadow: 0 0 0 4px rgba(190,0,0,.15), 0 2px 12px rgba(0,0,0,.15); user-select: none;
}
.xls-drop-arrow { margin-left: auto; font-size: 11px; color: var(--${namespace}-text-muted); }

/* Date trigger — 党政红聚焦 */
.xls-date-trigger {
  position: absolute; inset: 0; display: flex; align-items: center;
  padding: 0 4px 0 6px; font-size: 13px; cursor: pointer;
  background: var(--${namespace}-bg); outline: 2px solid var(--${namespace}-primary); z-index: 20;
  box-shadow: 0 0 0 4px rgba(190,0,0,.15), 0 2px 12px rgba(0,0,0,.15); user-select: none;
}
.xls-date-arrow { margin-left: auto; font-size: 11px; flex-shrink: 0; padding-left: 2px; }

/* Resize handle — 党政红悬停 */
.xls-resize {
  position: absolute; right: -3px; top: 0; width: 6px; height: 100%;
  cursor: col-resize; z-index: 11;
}
.xls-resize:hover { background: rgba(190,0,0,.25); }
.xls-sort { font-size: 10px; margin-left: 2px; opacity: .5; }

/* Dropdown panel — 暖灰白底 + 党政红边框 */
.xls-drop-panel {
  position: fixed; z-index: 9999;
  background: var(--${namespace}-bg); border: 1px solid var(--${namespace}-primary);
  border-radius: 2px; box-shadow: 0 4px 16px rgba(138,0,0,.10);
  min-width: 90px; overflow: hidden;
}
.xls-drop-item {
  padding: 5px 14px; cursor: pointer; font-size: 13px; white-space: nowrap;
  color: var(--${namespace}-text); transition: background 0.15s ease;
}
.xls-drop-item:hover { background: var(--${namespace}-primary-bg); }
.xls-drop-item.active { background: rgba(190,0,0,.08); font-weight: 600; color: var(--${namespace}-primary-dark); }

/* Date picker panel — 深红头部，暖调内容 */
.xls-date-panel {
  position: fixed; z-index: 9999;
  background: var(--${namespace}-bg); border: 1px solid var(--${namespace}-primary);
  border-radius: 2px; box-shadow: 0 4px 16px rgba(138,0,0,.10);
  width: 232px; overflow: hidden;
}
.xls-date-head {
  background: linear-gradient(135deg, var(--${namespace}-primary-dark) 0%, var(--${namespace}-primary) 50%, var(--${namespace}-primary-dark) 100%);
  color: var(--${namespace}-bg);
  display: flex; align-items: center; height: 28px; padding: 0 4px; gap: 2px;
}
.xls-date-nav {
  width: 22px; height: 22px; display: flex; align-items: center; justify-content: center;
  cursor: pointer; border-radius: 2px; font-size: 13px; flex-shrink: 0;
  color: rgba(255,255,255,.85);
}
.xls-date-nav:hover { background: rgba(255,255,255,.2); color: var(--${namespace}-bg); }
.xls-date-title {
  flex: 1; text-align: center; font-size: 12px; font-weight: bold;
  cursor: pointer; padding: 2px 4px; border-radius: 2px;
}
.xls-date-title:hover { background: rgba(255,255,255,.15); }
.xls-date-weekdays {
  display: grid; grid-template-columns: repeat(7, 1fr);
  background: var(--${namespace}-primary-bg); border-bottom: 1px solid var(--${namespace}-primary-border);
}
.xls-date-wd {
  text-align: center; font-size: 10px; font-weight: bold;
  color: var(--${namespace}-primary-dark); padding: 3px 0;
}
.xls-date-wd:first-child, .xls-date-wd:last-child { color: var(--${namespace}-danger); }
.xls-date-days {
  display: grid; grid-template-columns: repeat(7, 1fr);
  padding: 3px; gap: 1px;
}
.xls-date-day {
  text-align: center; font-size: 11px; padding: 4px 0;
  cursor: pointer; border-radius: 2px; color: var(--${namespace}-text); line-height: 1.4;
  transition: all 0.15s ease;
}
.xls-date-day:hover { background: var(--${namespace}-primary-bg); color: var(--${namespace}-primary-dark); }
.xls-date-day--other { color: var(--${namespace}-text-disabled); }
.xls-date-day--today {
  font-weight: bold; color: var(--${namespace}-primary); border: 1px solid var(--${namespace}-primary-border);
}
.xls-date-day--selected {
  background: var(--${namespace}-primary) !important; color: var(--${namespace}-bg) !important; font-weight: bold;
}
.xls-date-day--weekend { color: var(--${namespace}-danger); }
.xls-date-day--weekend.xls-date-day--selected { color: var(--${namespace}-bg) !important; }
.xls-date-my-grid {
  display: grid; grid-template-columns: repeat(4, 1fr);
  padding: 6px; gap: 3px;
}
.xls-date-my-item {
  text-align: center; font-size: 11px; padding: 5px 2px;
  cursor: pointer; border-radius: 2px; color: var(--${namespace}-text);
  transition: all 0.15s ease;
}
.xls-date-my-item:hover { background: var(--${namespace}-primary-bg); color: var(--${namespace}-primary-dark); }
.xls-date-my-item--selected {
  background: var(--${namespace}-primary); color: var(--${namespace}-bg); font-weight: bold;
}
.xls-date-footer {
  border-top: 1px solid var(--${namespace}-border-light); padding: 4px 6px;
  display: flex; align-items: center; justify-content: space-between;
  background: var(--${namespace}-bg-page);
}
.xls-date-today {
  font-size: 11px; color: var(--${namespace}-primary); cursor: pointer;
  padding: 1px 4px; border-radius: 2px;
}
.xls-date-today:hover { background: var(--${namespace}-primary-bg); }
.xls-date-clear {
  font-size: 11px; color: var(--${namespace}-text-muted); cursor: pointer;
  padding: 1px 4px; border-radius: 2px;
}
.xls-date-clear:hover { color: var(--${namespace}-danger); background: var(--${namespace}-danger-bg); }

/* Context menu — 暖白灰底 */
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
