<template>
  <div
    ref="rootEl"
    class="${namespace}-dp"
    :class="[
      sizeClass,
      {
        '${namespace}-dp--plain': plain,
        '${namespace}-dp--open': open,
        '${namespace}-dp--disabled': disabled,
        '${namespace}-dp--has-value': hasValue
      }
    ]"
  >
    <!-- 极客触发器：直角、等宽、聚焦硬阴影 -->
    <div
      class="${namespace}-dp__trigger"
      :class="{'${namespace}-dp__trigger--ph': !hasValue}"
      tabindex="0"
      @click="toggle"
      @keydown="onKeydown"
    >
      <span class="${namespace}-dp__text">{{ displayText }}</span>
      <span class="${namespace}-dp__icon">▤</span>
    </div>

    <!-- 清除按钮 -->
    <span v-if="hasValue && !disabled" class="${namespace}-dp__clear" @click.stop="clear">&times;</span>

    <!-- 日历弹窗面板 (Teleported to body) -->
    <Teleport to="body">
      <div
        v-if="open"
        ref="panelEl"
        class="${namespace}-dp__panel ${namespace}-dp__panel--open"
        :style="panelStyle"
        @click.stop
      >
        <!-- 面板头部：直角小方块步进器 -->
        <div class="${namespace}-dp__head">
          <button type="button" class="${namespace}-dp__nav" title="上一年" @click="step(-1, true)">&laquo;</button>
          <button type="button" class="${namespace}-dp__nav" title="上一月" @click="step(-1, false)">&lsaquo;</button>
          <div class="${namespace}-dp__title" @click="drillUp">{{ titleText }}</div>
          <button type="button" class="${namespace}-dp__nav" title="下一月" @click="step(1, false)">&rsaquo;</button>
          <button type="button" class="${namespace}-dp__nav" title="下一年" @click="step(1, true)">&raquo;</button>
        </div>

        <!-- 日视图 -->
        <template v-if="view === 'day'">
          <div class="${namespace}-dp__weekdays">
            <div v-for="w in weekdays" :key="w" class="${namespace}-dp__wd">{{ w }}</div>
          </div>
          <div class="${namespace}-dp__days">
            <div
              v-for="d in dayCells"
              :key="d.ymd"
              class="${namespace}-dp__day"
              :class="{
                '${namespace}-dp__day--other': d.isOther,
                '${namespace}-dp__day--weekend': d.isWeekend,
                '${namespace}-dp__day--today': d.isToday,
                '${namespace}-dp__day--selected': d.isSelected,
                '${namespace}-dp__day--disabled': d.isDisabled
              }"
              @click="pickDay(d)"
            >
              {{ String(d.day).padStart(2, '0') }}
            </div>
          </div>
        </template>

        <!-- 月视图 -->
        <div v-if="view === 'month'" class="${namespace}-dp__grid">
          <div
            v-for="m in 12"
            :key="m"
            class="${namespace}-dp__grid-item"
            :class="{
              '${namespace}-dp__grid-item--selected': isMonthSelected(m - 1),
              '${namespace}-dp__grid-item--current': isMonthCurrent(m - 1)
            }"
            @click="pickMonth(m - 1)"
          >
            {{ String(m).padStart(2, '0') }}M
          </div>
        </div>

        <!-- 年视图 -->
        <div v-if="view === 'year'" class="${namespace}-dp__grid">
          <div
            v-for="yr in yearRange"
            :key="yr"
            class="${namespace}-dp__grid-item"
            :class="{
              '${namespace}-dp__grid-item--selected': yr === selectedYear,
              '${namespace}-dp__grid-item--current': yr === currentYear
            }"
            @click="pickYear(yr)"
          >
            {{ yr }}
          </div>
        </div>

        <!-- 底部快捷控制行 -->
        <div class="${namespace}-dp__footer">
          <button type="button" class="${namespace}-dp__btn ${namespace}-dp__btn--today" @click="pickToday">TODAY</button>
          <button type="button" class="${namespace}-dp__btn ${namespace}-dp__btn--clear" @click="clear">CLEAR</button>
        </div>
      </div>
    </Teleport>
  </div>
</template>

<script setup>
import { ref, computed, watch, onMounted, onBeforeUnmount, nextTick } from 'vue'

const props = defineProps({
  modelValue:  { type: String,  default: null },
  placeholder: { type: String,  default: 'YYYY-MM-DD' },
  disabled:    { type: Boolean, default: false },
  plain:       { type: Boolean, default: false },
  size:        { type: String,  default: '' },
  format:      { type: String,  default: 'YYYY-MM-DD' },
  minDate:     { type: String,  default: null },
  maxDate:     { type: String,  default: null },
})

const emit = defineEmits(['update:modelValue'])

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

const open = ref(false)
const view = ref('day')
const cursorDate = ref(new Date())
const selectedDate = ref(null)
const rootEl = ref(null)
const panelEl = ref(null)
const panelStyle = ref({})

// 极客等宽英文字符表头
const weekdays = ['SU', 'MO', 'TU', 'WE', 'TH', 'FR', 'SA']

if (props.modelValue) {
  const d = parse(props.modelValue)
  if (d) {
    selectedDate.value = d
    cursorDate.value = new Date(d.getFullYear(), d.getMonth(), 1)
  }
}
cursorDate.value.setDate(1)

watch(() => props.modelValue, (v) => {
  const d = parse(v)
  const cur = selectedDate.value ? ymd(selectedDate.value) : null
  const ext = d ? ymd(d) : null
  if (cur !== ext) {
    selectedDate.value = d
    if (d) cursorDate.value = new Date(d.getFullYear(), d.getMonth(), 1)
  }
})

const hasValue = computed(() => !!selectedDate.value)
const displayText = computed(() => selectedDate.value ? fmt(selectedDate.value) : props.placeholder)

const sizeClass = computed(() => {
  if (props.size === 'sm') return '${namespace}-dp--sm'
  if (props.size === 'lg') return '${namespace}-dp--lg'
  return ''
})

const titleText = computed(() => {
  const y = cursorDate.value.getFullYear()
  const m = cursorDate.value.getMonth()
  if (view.value === 'day') return `${r"${y}"} . ${r"${String(m + 1).padStart(2, '0')}"}`
  if (view.value === 'month') return `${r"${y}"}`
  const base = Math.floor(y / 12) * 12
  return `${r"${base}"} - ${r"${base + 11}"}`
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

function toggle() {
  if (props.disabled) return
  open.value ? closePanel() : openPanel()
}

function openPanel() {
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
  const triggerEl = rootEl.value.querySelector('.${namespace}-dp__trigger')
  if (!triggerEl) return

  const rect = triggerEl.getBoundingClientRect()
  const ph = (panelEl.value.offsetHeight && panelEl.value.offsetHeight > 50) ? panelEl.value.offsetHeight : 290
  const pw = (panelEl.value.offsetWidth && panelEl.value.offsetWidth > 50) ? panelEl.value.offsetWidth : 260

  const spaceBelow = window.innerHeight - rect.bottom
  const style = { position: 'fixed', zIndex: '99999' }

  if (spaceBelow >= ph + 4) {
    style.top = (rect.bottom + 3) + 'px'
  } else {
    style.top = Math.max(8, rect.top - ph - 3) + 'px'
  }

  if (rect.left + pw <= window.innerWidth - 8) {
    style.left = rect.left + 'px'
  } else {
    style.left = Math.max(8, rect.right - pw) + 'px'
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
/* ══════════════════════════════════════════════
   Protocol Explorer Datepicker 蓝图样式规范
   ══════════════════════════════════════════════ */
.${namespace}-dp {
  position: relative;
  display: inline-flex;
  min-width: 140px;
  font-family: var(--${namespace}-f, "IBM Plex Mono", monospace);
  font-size: 13px;
  user-select: none;
  width: 100%;
}

/* ── 触发框：物理硬阴影与等宽直角 ── */
.${namespace}-dp__trigger {
  flex: 1;
  height: 34px;
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: 0 10px;
  border: 1px solid var(--${namespace}-ln, #d3dbef);
  border-radius: 0;
  background: var(--${namespace}-pn, #ffffff);
  color: var(--${namespace}-ink, #0a2a9a);
  cursor: pointer;
  outline: none;
  transition: .15s;
}
.${namespace}-dp__trigger:hover,
.${namespace}-dp--open .${namespace}-dp__trigger {
  border-color: var(--${namespace}-pri, #0a2fb5);
  transform: translate(-1px, -1px);
  box-shadow: 3px 3px 0 color-mix(in srgb, var(--${namespace}-pri, #0a2fb5) 30%, transparent);
}
.${namespace}-dp--disabled .${namespace}-dp__trigger {
  background: var(--${namespace}-bg, #f4f6fb);
  color: var(--${namespace}-mu, #6f7fb4);
  cursor: not-allowed;
  transform: none;
  box-shadow: none;
  border-color: var(--${namespace}-ln, #d3dbef);
}
.${namespace}-dp__trigger--ph {
  color: var(--${namespace}-mu, #6f7fb4);
}
.${namespace}-dp__text {
  letter-spacing: .08em;
  font-weight: 600;
}
.${namespace}-dp__icon {
  font-size: 14px;
  color: var(--${namespace}-mu, #6f7fb4);
}

/* 悬停清除叉号 */
.${namespace}-dp__clear {
  position: absolute;
  right: 28px;
  top: 50%;
  transform: translateY(-50%);
  width: 16px;
  height: 16px;
  display: none;
  align-items: center;
  justify-content: center;
  color: var(--${namespace}-mu, #6f7fb4);
  cursor: pointer;
  font-size: 14px;
  font-weight: 700;
}
.${namespace}-dp:hover .${namespace}-dp__clear {
  display: flex;
}
.${namespace}-dp__clear:hover {
  color: var(--${namespace}-red, #d6343e);
}

/* ── 日历弹出面板：直角与 4px 墨水实体投影 ── */
.${namespace}-dp__panel {
  display: none;
  position: fixed;
  background: var(--${namespace}-pn, #ffffff);
  border: 1px solid var(--${namespace}-ink, #0a2a9a);
  box-shadow: 4px 4px 0 var(--${namespace}-ln, #d3dbef);
  z-index: 99999;
  width: 256px;
  font-family: var(--${namespace}-f, "IBM Plex Mono", monospace);
}
.${namespace}-dp__panel--open {
  display: block;
}

/* 面板头部 */
.${namespace}-dp__head {
  background: var(--${namespace}-ink, #0a2a9a);
  color: var(--${namespace}-on, #ffffff);
  display: flex;
  align-items: center;
  height: 36px;
  padding: 0 4px;
  gap: 2px;
}
.${namespace}-dp__nav {
  width: 28px;
  height: 28px;
  border: 1px solid transparent;
  background: transparent;
  color: var(--${namespace}-on, #ffffff);
  display: grid;
  place-items: center;
  cursor: pointer;
  font: inherit;
  font-size: 14px;
  font-weight: 700;
  transition: .12s;
}
.${namespace}-dp__nav:hover {
  background: color-mix(in srgb, #ffffff 20%, transparent);
  border-color: rgba(255, 255, 255, 0.4);
}
.${namespace}-dp__title {
  flex: 1;
  text-align: center;
  font-size: 13px;
  font-weight: 700;
  letter-spacing: .1em;
  cursor: pointer;
  padding: 4px;
  transition: .12s;
}
.${namespace}-dp__title:hover {
  background: color-mix(in srgb, #ffffff 15%, transparent);
}

/* 星期表头行 */
.${namespace}-dp__weekdays {
  display: grid;
  grid-template-columns: repeat(7, 1fr);
  background: var(--${namespace}-bg, #f4f6fb);
  border-bottom: 1px solid var(--${namespace}-ln, #d3dbef);
}
.${namespace}-dp__wd {
  text-align: center;
  font-size: 11px;
  font-weight: 700;
  color: var(--${namespace}-mu, #6f7fb4);
  padding: 6px 0;
  letter-spacing: .05em;
}
.${namespace}-dp__wd:first-child,
.${namespace}-dp__wd:last-child {
  color: var(--${namespace}-red, #d6343e);
}

/* 日期矩阵网格 */
.${namespace}-dp__days {
  display: grid;
  grid-template-columns: repeat(7, 1fr);
  padding: 6px;
  gap: 2px;
}
.${namespace}-dp__day {
  text-align: center;
  font-size: 12px;
  padding: 6px 0;
  cursor: pointer;
  border: 1px solid transparent;
  color: var(--${namespace}-ink, #0a2a9a);
  font-weight: 600;
  transition: .12s;
}
.${namespace}-dp__day:hover:not(.${namespace}-dp__day--disabled) {
  background: color-mix(in srgb, var(--${namespace}-ln, #d3dbef) 50%, transparent);
  border-color: var(--${namespace}-ink, #0a2a9a);
}
.${namespace}-dp__day--other {
  color: var(--${namespace}-mu, #6f7fb4);
  opacity: .5;
}
.${namespace}-dp__day--weekend {
  color: var(--${namespace}-red, #d6343e);
}
.${namespace}-dp__day--today {
  border-color: var(--${namespace}-ink, #0a2a9a);
  font-weight: 700;
}
.${namespace}-dp__day--selected {
  background: var(--${namespace}-pri, #0a2fb5) !important;
  color: var(--${namespace}-on, #ffffff) !important;
  border-color: var(--${namespace}-pri, #0a2fb5) !important;
}
.${namespace}-dp__day--disabled {
  opacity: .25;
  cursor: not-allowed;
  pointer-events: none;
}

/* 月份/年份网格 */
.${namespace}-dp__grid {
  display: grid;
  grid-template-columns: repeat(3, 1fr);
  padding: 10px;
  gap: 6px;
}
.${namespace}-dp__grid-item {
  text-align: center;
  font-size: 12px;
  font-weight: 700;
  padding: 10px 4px;
  cursor: pointer;
  border: 1px solid var(--${namespace}-ln, #d3dbef);
  color: var(--${namespace}-ink, #0a2a9a);
  transition: .12s;
}
.${namespace}-dp__grid-item:hover {
  background: color-mix(in srgb, var(--${namespace}-ln, #d3dbef) 50%, transparent);
  border-color: var(--${namespace}-ink, #0a2a9a);
}
.${namespace}-dp__grid-item--selected {
  background: var(--${namespace}-pri, #0a2fb5) !important;
  color: var(--${namespace}-on, #ffffff) !important;
  border-color: var(--${namespace}-pri, #0a2fb5) !important;
}
.${namespace}-dp__grid-item--current {
  border-color: var(--${namespace}-ink, #0a2a9a);
}

/* 底部操作区 */
.${namespace}-dp__footer {
  border-top: 1px solid var(--${namespace}-ln, #d3dbef);
  padding: 6px 10px;
  display: flex;
  align-items: center;
  justify-content: space-between;
  background: var(--${namespace}-bg, #f4f6fb);
}
.${namespace}-dp__btn {
  font: 600 11px var(--${namespace}-f, "IBM Plex Mono", monospace);
  padding: 4px 10px;
  border: 1px solid var(--${namespace}-ink, #0a2a9a);
  background: var(--${namespace}-pn, #ffffff);
  color: var(--${namespace}-ink, #0a2a9a);
  cursor: pointer;
  letter-spacing: .08em;
  transition: .12s;
}
.${namespace}-dp__btn:hover {
  transform: translate(-1px, -1px);
  box-shadow: 2px 2px 0 var(--${namespace}-ink, #0a2a9a);
}
.${namespace}-dp__btn:active {
  transform: translate(1px, 1px);
  box-shadow: none;
}
.${namespace}-dp__btn--today {
  background: var(--${namespace}-pri, #0a2fb5);
  color: var(--${namespace}-on, #ffffff);
  border-color: var(--${namespace}-pri, #0a2fb5);
}
.${namespace}-dp__btn--clear {
  color: var(--${namespace}-red, #d6343e);
  border-color: var(--${namespace}-red, #d6343e);
}

/* 尺寸变体 */
.${namespace}-dp--sm .${namespace}-dp__trigger { height: 26px; font-size: 11px; }
.${namespace}-dp--lg .${namespace}-dp__trigger { height: 40px; font-size: 14px; }

/* 无边框变体 */
.${namespace}-dp--plain .${namespace}-dp__trigger {
  border-color: transparent;
  background: transparent;
  box-shadow: none;
  transform: none;
}
</style>