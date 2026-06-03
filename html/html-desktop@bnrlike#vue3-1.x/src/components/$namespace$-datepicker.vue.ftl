<template>
  <div class="${namespace}-dp" :class="{[`${namespace}-dp--${r"${size}"}`]: size, '${namespace}-dp--open': open, '${namespace}-dp--disabled': disabled, '${namespace}-dp--has-value': hasValue}" ref="rootEl">
    <div class="${namespace}-dp__trigger" :class="{'${namespace}-dp__trigger--ph': !hasValue}" @click="toggle" @keydown="onKeydown" tabindex="0">
      {{ displayText }}
    </div>
    <span class="${namespace}-dp__clear" @click.stop="clear">&times;</span>

    <Teleport to="body">
      <div v-if="open" class="${namespace}-dp__panel ${namespace}-dp__panel--open" :style="panelStyle" ref="panelEl" @click.stop>
        <div class="${namespace}-dp__head">
          <div class="${namespace}-dp__nav" @click="step(-1, true)">&laquo;</div>
          <div class="${namespace}-dp__nav" @click="step(-1, false)">&lsaquo;</div>
          <div class="${namespace}-dp__title" @click="drillUp">{{ titleText }}</div>
          <div class="${namespace}-dp__nav" @click="step(1, false)">&rsaquo;</div>
          <div class="${namespace}-dp__nav" @click="step(1, true)">&raquo;</div>
        </div>

        <template v-if="view === 'day'">
          <div class="${namespace}-dp__weekdays">
            <div class="${namespace}-dp__wd" v-for="w in weekdays" :key="w">{{ w }}</div>
          </div>
          <div class="${namespace}-dp__days">
            <div v-for="d in dayCells" :key="d.ymd"
              class="${namespace}-dp__day"
              :class="{
                '${namespace}-dp__day--other': d.isOther,
                '${namespace}-dp__day--weekend': d.isWeekend,
                '${namespace}-dp__day--today': d.isToday,
                '${namespace}-dp__day--selected': d.isSelected,
                '${namespace}-dp__day--disabled': d.isDisabled
              }"
              @click="pickDay(d)">{{ d.day }}</div>
          </div>
        </template>

        <div v-if="view === 'month'" class="${namespace}-dp__my-grid">
          <div v-for="m in 12" :key="m"
            class="${namespace}-dp__my-item"
            :class="{
              '${namespace}-dp__my-item--selected': isMonthSelected(m - 1),
              '${namespace}-dp__my-item--current': isMonthCurrent(m - 1)
            }"
            @click="pickMonth(m - 1)">{{ m }}月</div>
        </div>

        <div v-if="view === 'year'" class="${namespace}-dp__my-grid">
          <div v-for="yr in yearRange" :key="yr"
            class="${namespace}-dp__my-item"
            :class="{
              '${namespace}-dp__my-item--selected': yr === selectedYear,
              '${namespace}-dp__my-item--current': yr === currentYear
            }"
            @click="pickYear(yr)">{{ yr }}</div>
        </div>

        <div class="${namespace}-dp__footer">
          <span class="${namespace}-dp__today-btn" @click="pickToday">今天</span>
          <span class="${namespace}-dp__clear-btn" @click="clear">清除</span>
        </div>
      </div>
    </Teleport>
  </div>
</template>

<script setup>
import { ref, computed, watch, onMounted, onBeforeUnmount, nextTick } from 'vue'

const props = defineProps({
  modelValue:  { type: String,  default: null },
  placeholder: { type: String,  default: '请选择日期' },
  disabled:    { type: Boolean, default: false },
  size:        { type: String,  default: '' },
  format:      { type: String,  default: 'YYYY-MM-DD' },
  minDate:     { type: String,  default: null },
  maxDate:     { type: String,  default: null },
})

const emit = defineEmits(['update:modelValue'])

// ── helpers ──
const ymd = (d) => d.getFullYear() + '-' + String(d.getMonth() + 1).padStart(2, '0') + '-' + String(d.getDate()).padStart(2, '0')

const fmt = (d) => {
  if (!d) return ''
  return props.format
    .replace('YYYY', d.getFullYear())
    .replace('MM', String(d.getMonth() + 1).padStart(2, '0'))
    .replace('DD', String(d.getDate()).padStart(2, '0'))
}

const parse = (s) => {
  if (!s) return null
  const n = s.replace(/\//g, '-').replace(/年|月/g, '-').replace(/日/g, '')
  const d = new Date(n)
  return isNaN(d.getTime()) ? null : d
}

const isOff = (d) => {
  const s = ymd(d)
  return (props.minDate && s < props.minDate) || (props.maxDate && s > props.maxDate)
}

// ── state ──
const open = ref(false)
const view = ref('day')
const cursorDate = ref(new Date())
const selectedDate = ref(null)
const rootEl = ref(null)
const panelEl = ref(null)
const panelStyle = ref({})

const weekdays = ['日', '一', '二', '三', '四', '五', '六']

// init
if (props.modelValue) {
  const d = parse(props.modelValue)
  if (d) {
    selectedDate.value = d
    cursorDate.value = new Date(d.getFullYear(), d.getMonth(), 1)
  }
}
cursorDate.value.setDate(1)

// ── sync from external ──
watch(() => props.modelValue, (v) => {
  const d = parse(v)
  const cur = selectedDate.value ? ymd(selectedDate.value) : null
  const ext = d ? ymd(d) : null
  if (cur !== ext) {
    selectedDate.value = d
    if (d) cursorDate.value = new Date(d.getFullYear(), d.getMonth(), 1)
  }
})

// ── computed ──
const hasValue = computed(() => !!selectedDate.value)
const displayText = computed(() => selectedDate.value ? fmt(selectedDate.value) : props.placeholder)

const titleText = computed(() => {
  const y = cursorDate.value.getFullYear()
  const m = cursorDate.value.getMonth()
  if (view.value === 'day') return y + '年 ' + (m + 1) + '月'
  if (view.value === 'month') return y + '年'
  const base = Math.floor(y / 12) * 12
  return base + ' — ' + (base + 11)
})

const dayCells = computed(() => {
  const y = cursorDate.value.getFullYear()
  const m = cursorDate.value.getMonth()
  const today = ymd(new Date())
  const sel = selectedDate.value ? ymd(selectedDate.value) : null

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
    const ymdVal = ymd(date)
    cells.push({
      ymd: ymdVal,
      day: date.getDate(),
      isOther,
      isWeekend: dw === 0 || dw === 6,
      isToday: ymdVal === today,
      isSelected: ymdVal === sel,
      isDisabled: isOff(date),
    })
  }
  return cells
})

const yearRange = computed(() => {
  const base = Math.floor(cursorDate.value.getFullYear() / 12) * 12
  return Array.from({ length: 12 }, (_, i) => base + i)
})

const selectedYear = computed(() => selectedDate.value ? selectedDate.value.getFullYear() : null)
const currentYear = new Date().getFullYear()

function isMonthSelected(m) {
  if (!selectedDate.value) return false
  return selectedDate.value.getFullYear() === cursorDate.value.getFullYear() && selectedDate.value.getMonth() === m
}

function isMonthCurrent(m) {
  const now = new Date()
  return now.getFullYear() === cursorDate.value.getFullYear() && now.getMonth() === m
}

// ── actions ──
function toggle() {
  if (props.disabled) return
  open.value ? closePanel() : openPanel()
}

function openPanel() {
  // close other datepickers
  document.querySelectorAll('.${namespace}-dp--open').forEach(el => {
    if (el !== rootEl.value && el._bnrDpClose) el._bnrDpClose()
  })
  open.value = true
  nextTick(() => positionPanel())
}

function closePanel() {
  open.value = false
}

function positionPanel() {
  if (!rootEl.value || !panelEl.value) return
  const rect = rootEl.value.querySelector('.${namespace}-dp__trigger').getBoundingClientRect()
  const pw = panelEl.value.offsetWidth || 260
  const ph = panelEl.value.offsetHeight || 280
  const spaceRight = window.innerWidth - rect.left
  const spaceBelow = window.innerHeight - rect.bottom

  const style = { position: 'fixed', zIndex: '99999' }
  if (spaceBelow >= ph || spaceBelow >= 120) {
    style.top = (rect.bottom + 2) + 'px'
  } else {
    style.bottom = (window.innerHeight - rect.top + 2) + 'px'
  }
  if (spaceRight >= pw) {
    style.left = rect.left + 'px'
  } else {
    style.right = (window.innerWidth - rect.right) + 'px'
  }
  panelStyle.value = style
}

function pickDay(d) {
  if (d.isDisabled) return
  const date = new Date(d.ymd)
  selectedDate.value = date
  cursorDate.value = new Date(date.getFullYear(), date.getMonth(), 1)
  emit('update:modelValue', fmt(date))
  closePanel()
}

function pickMonth(m) {
  cursorDate.value = new Date(cursorDate.value.getFullYear(), m, 1)
  view.value = 'day'
}

function pickYear(yr) {
  cursorDate.value = new Date(yr, cursorDate.value.getMonth(), 1)
  view.value = 'month'
}

function step(dir, byYear) {
  const cur = cursorDate.value
  if (view.value === 'day') {
    byYear ? cur.setFullYear(cur.getFullYear() + dir) : cur.setMonth(cur.getMonth() + dir)
  } else if (view.value === 'month') {
    cur.setFullYear(cur.getFullYear() + dir)
  } else {
    cur.setFullYear(cur.getFullYear() + dir * 12)
  }
  cursorDate.value = new Date(cur)
}

function drillUp() {
  if (view.value === 'day') view.value = 'month'
  else if (view.value === 'month') view.value = 'year'
}

function pickToday() {
  const today = new Date()
  if (isOff(today)) return
  selectedDate.value = today
  cursorDate.value = new Date(today.getFullYear(), today.getMonth(), 1)
  view.value = 'day'
  emit('update:modelValue', fmt(today))
  closePanel()
}

function clear() {
  selectedDate.value = null
  emit('update:modelValue', null)
  closePanel()
}

function onKeydown(e) {
  if (e.key === 'Enter' || e.key === ' ') { e.preventDefault(); toggle() }
  else if (e.key === 'Escape') closePanel()
  else if (e.key === 'Tab') closePanel()
}

// ── outside click ──
function onDocClick(e) {
  if (rootEl.value && !rootEl.value.contains(e.target) && !(panelEl.value && panelEl.value.contains(e.target))) closePanel()
}
watch(open, (v) => {
  if (v) {
    document.addEventListener('click', onDocClick, true)
    window.addEventListener('scroll', positionPanel, true)
    window.addEventListener('resize', positionPanel)
  } else {
    document.removeEventListener('click', onDocClick, true)
    window.removeEventListener('scroll', positionPanel, true)
    window.removeEventListener('resize', positionPanel)
  }
})

onMounted(() => {
  if (rootEl.value) rootEl.value._bnrDpClose = closePanel
})

onBeforeUnmount(() => {
  if (rootEl.value) delete rootEl.value._bnrDpClose
  document.removeEventListener('click', onDocClick, true)
  window.removeEventListener('scroll', positionPanel, true)
  window.removeEventListener('resize', positionPanel)
})

defineExpose({ openPanel, closePanel, clear })
</script>
<style scoped>
/* BNR Datepicker — ${namespace}-datepicker.css */
/* Namespace: ${namespace}-dp */

.${namespace}-dp {
  position: relative;
  display: inline-flex;
  min-width: 140px;
  font-family: var(--${namespace}-font, "Microsoft YaHei", sans-serif);
  font-size: 12px;
  user-select: none;
  width: 100%;
}

.${namespace}-dp__trigger {
  flex: 1;
  height: 22px;
  display: flex;
  align-items: center;
  padding: 0 26px 0 5px;
  border: 1px solid var(--${namespace}-border, #c8c8c8);
  background: #fff;
  color: var(--${namespace}-text, #1c2833);
  cursor: pointer;
  position: relative;
  white-space: nowrap;
  overflow: hidden;
  text-overflow: ellipsis;
  transition: border-color .15s;
}
.${namespace}-dp__trigger::after {
  content: '\25A6';
  position: absolute;
  right: 6px;
  top: 50%;
  transform: translateY(-50%);
  font-size: 12px;
  color: var(--${namespace}-text-muted, #5d6d7e);
  pointer-events: none;
}
.${namespace}-dp--open .${namespace}-dp__trigger {
  border-color: var(--${namespace}-primary, #1a4f8a);
  box-shadow: 0 0 0 2px rgba(26,79,138,.08);
}
.${namespace}-dp--disabled .${namespace}-dp__trigger {
  background: #f5f7fa;
  color: var(--${namespace}-text-muted, #5d6d7e);
  cursor: not-allowed;
}
.${namespace}-dp__trigger--placeholder, .${namespace}-dp__trigger--ph { color: var(--${namespace}-text-light, #909eac); }

.${namespace}-dp__clear { display: none !important; }


.${namespace}-dp__panel {
  display: none;
  position: absolute;
  top: calc(100% + 2px);
  left: 0;
  background: #fff;
  border: 1px solid var(--${namespace}-primary-border, #d0d8e8);
  box-shadow: 0 4px 12px rgba(0,0,0,.12);
  z-index: 9999;
  width: 224px;
}
.${namespace}-dp--open .${namespace}-dp__panel { display: block; }
.${namespace}-dp__panel--open { display: block; }

.${namespace}-dp__head {
  background: var(--${namespace}-primary, #1a4f8a);
  color: #fff;
  display: flex;
  align-items: center;
  height: 28px;
  padding: 0 4px;
  gap: 2px;
}
.${namespace}-dp__nav {
  width: 22px;
  height: 22px;
  display: flex;
  align-items: center;
  justify-content: center;
  cursor: pointer;
  border-radius: 2px;
  font-size: 13px;
  flex-shrink: 0;
  color: rgba(255,255,255,.85);
}
.${namespace}-dp__nav:hover { background: rgba(255,255,255,.2); color: #fff; }
.${namespace}-dp__title {
  flex: 1;
  text-align: center;
  font-size: 12px;
  font-weight: bold;
  cursor: pointer;
  padding: 2px 4px;
  border-radius: 2px;
}
.${namespace}-dp__title:hover { background: rgba(255,255,255,.15); }

.${namespace}-dp__weekdays {
  display: grid;
  grid-template-columns: repeat(7, 1fr);
  background: var(--${namespace}-primary-bg, #e8edf5);
  border-bottom: 1px solid var(--${namespace}-primary-border, #d0d8e8);
}
.${namespace}-dp__wd {
  text-align: center;
  font-size: 10px;
  font-weight: bold;
  color: var(--${namespace}-primary, #1a4f8a);
  padding: 3px 0;
}
.${namespace}-dp__wd:first-child,
.${namespace}-dp__wd:last-child { color: var(--${namespace}-danger, #c0392b); }

.${namespace}-dp__days {
  display: grid;
  grid-template-columns: repeat(7, 1fr);
  padding: 3px;
  gap: 1px;
}
.${namespace}-dp__day {
  text-align: center;
  font-size: 11px;
  padding: 4px 0;
  cursor: pointer;
  border-radius: 2px;
  color: var(--${namespace}-text, #1c2833);
  line-height: 1.4;
}
.${namespace}-dp__day:hover:not(.${namespace}-dp__day--disabled) {
  background: var(--${namespace}-primary-bg, #e8edf5);
  color: var(--${namespace}-primary, #1a4f8a);
}
.${namespace}-dp__day--other { color: var(--${namespace}-text-light, #909eac); }
.${namespace}-dp__day--today {
  font-weight: bold;
  color: var(--${namespace}-primary, #1a4f8a);
  border: 1px solid var(--${namespace}-primary-border, #d0d8e8);
}
.${namespace}-dp__day--selected {
  background: var(--${namespace}-primary, #1a4f8a) !important;
  color: #fff !important;
  font-weight: bold;
}
.${namespace}-dp__day--disabled {
  color: var(--${namespace}-text-disabled, #c8d0d8);
  cursor: not-allowed;
}
.${namespace}-dp__day--weekend { color: var(--${namespace}-danger, #c0392b); }
.${namespace}-dp__day--weekend.${namespace}-dp__day--selected { color: #fff !important; }

.${namespace}-dp__my-grid {
  display: grid;
  grid-template-columns: repeat(4, 1fr);
  padding: 6px;
  gap: 3px;
}
.${namespace}-dp__my-item {
  text-align: center;
  font-size: 11px;
  padding: 5px 2px;
  cursor: pointer;
  border-radius: 2px;
  color: var(--${namespace}-text, #1c2833);
}
.${namespace}-dp__my-item:hover { background: var(--${namespace}-primary-bg, #e8edf5); color: var(--${namespace}-primary, #1a4f8a); }
.${namespace}-dp__my-item--selected { background: var(--${namespace}-primary, #1a4f8a); color: #fff; font-weight: bold; }
.${namespace}-dp__my-item--current { font-weight: bold; color: var(--${namespace}-primary, #1a4f8a); }

.${namespace}-dp__footer {
  border-top: 1px solid var(--${namespace}-border-light, #e4e8f0);
  padding: 4px 6px;
  display: flex;
  align-items: center;
  justify-content: space-between;
  background: var(--${namespace}-bg-page, #f0f2f5);
}
.${namespace}-dp__today-btn {
  font-size: 11px;
  color: var(--${namespace}-primary, #1a4f8a);
  cursor: pointer;
  padding: 1px 4px;
  border-radius: 2px;
}
.${namespace}-dp__today-btn:hover { background: var(--${namespace}-primary-bg, #e8edf5); }
.${namespace}-dp__clear-btn {
  font-size: 11px;
  color: var(--${namespace}-text-muted, #5d6d7e);
  cursor: pointer;
  padding: 1px 4px;
  border-radius: 2px;
}
.${namespace}-dp__clear-btn:hover { color: var(--${namespace}-danger, #c0392b); background: var(--${namespace}-danger-bg, #fcecea); }

.${namespace}-dp--sm .${namespace}-dp__trigger { height: 20px; font-size: 11px; }
.${namespace}-dp--lg .${namespace}-dp__trigger { height: 28px; font-size: 13px; }
.${namespace}-dp--block { display: flex; width: 100%; }
</style>