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
    <!-- 新拟态触发器：内凹微槽、柔和触感反馈 -->
    <div
      class="${namespace}-dp__trigger"
      :class="{'${namespace}-dp__trigger--ph': !hasValue}"
      tabindex="0"
      @click="toggle"
      @keydown="onKeydown"
    >
      <span class="${namespace}-dp__text">{{ displayText }}</span>
      <span class="${namespace}-dp__icon">
        <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
          <rect x="3" y="4" width="18" height="18" rx="4" ry="4"></rect>
          <line x1="16" y1="2" x2="16" y2="6"></line>
          <line x1="8" y1="2" x2="8" y2="6"></line>
          <line x1="3" y1="10" x2="21" y2="10"></line>
        </svg>
      </span>
    </div>

    <!-- 清除按钮：微凸小圆扣 -->
    <span v-if="hasValue && !disabled" class="${namespace}-dp__clear" title="清除" @click.stop="clear">&times;</span>

    <!-- 日历弹窗面板 (Teleported to body)：悬浮大浮雕卡片 -->
    <Teleport to="body">
      <div
        v-if="open"
        ref="panelEl"
        class="${namespace}-dp__panel ${namespace}-dp__panel--open"
        :style="panelStyle"
        @click.stop
      >
        <!-- 面板头部：浮雕圆形步进按钮与平滑标题 -->
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
            {{ String(m).padStart(2, '0') }}月
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

        <!-- 底部快捷操作栏 -->
        <div class="${namespace}-dp__footer">
          <button type="button" class="${namespace}-dp__btn ${namespace}-dp__btn--clear" @click="clear">重置</button>
          <button type="button" class="${namespace}-dp__btn ${namespace}-dp__btn--today" @click="pickToday">今天</button>
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

const weekdays = ['日', '一', '二', '三', '四', '五', '六']

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
  if (view.value === 'day') return `${r"${y}"} 年 ${r"${String(m + 1).padStart(2, '0')}"} 月`
  if (view.value === 'month') return `${r"${y}"} 年`
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
  const ph = (panelEl.value.offsetHeight && panelEl.value.offsetHeight > 50) ? panelEl.value.offsetHeight : 310
  const pw = (panelEl.value.offsetWidth && panelEl.value.offsetWidth > 50) ? panelEl.value.offsetWidth : 270

  const spaceBelow = window.innerHeight - rect.bottom
  const style = { position: 'fixed', zIndex: '99999' }

  if (spaceBelow >= ph + 8) {
    style.top = (rect.bottom + 8) + 'px'
  } else {
    style.top = Math.max(8, rect.top - ph - 8) + 'px'
  }

  if (rect.left + pw <= window.innerWidth - 12) {
    style.left = rect.left + 'px'
  } else {
    style.left = Math.max(12, rect.right - pw) + 'px'
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
   Protocol Explorer Datepicker 新拟态样式规范
   ══════════════════════════════════════════════ */
.${namespace}-dp {
  position: relative;
  display: inline-flex;
  min-width: 150px;
  font-family: var(--${namespace}-f, -apple-system, sans-serif);
  font-size: 13.5px;
  user-select: none;
  width: 100%;
}

/* ── 触发框：内凹微槽 (与输入框风格统一) ── */
.${namespace}-dp__trigger {
  flex: 1;
  height: 38px;
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: 0 14px;
  border: 0;
  border-radius: 14px;
  background: var(--${namespace}-pn, #e0e5ec);
  box-shadow: var(--${namespace}-sis, inset 2px 2px 5px var(--${namespace}-sd, #a3b1c6), inset -2px -2px 5px var(--${namespace}-sl, #ffffff));
  color: var(--${namespace}-ink, #4a5568);
  cursor: pointer;
  outline: none;
  transition: box-shadow .15s ease, color .15s ease;
}

.${namespace}-dp__trigger:hover {
  color: var(--${namespace}-pri, #4d7cfe);
}

.${namespace}-dp--open .${namespace}-dp__trigger,
.${namespace}-dp__trigger:focus {
  box-shadow: var(--${namespace}-sis, inset 2px 2px 5px var(--${namespace}-sd, #a3b1c6), inset -2px -2px 5px var(--${namespace}-sl, #ffffff)), 0 0 0 2px rgba(77, 124, 254, .55);
  color: var(--${namespace}-pri, #4d7cfe);
}

.${namespace}-dp--disabled .${namespace}-dp__trigger {
  opacity: .45;
  box-shadow: none;
  cursor: not-allowed;
}

.${namespace}-dp__trigger--ph {
  color: var(--${namespace}-mu, #8390a6);
}

.${namespace}-dp__text {
  font-family: var(--${namespace}-m, "IBM Plex Mono", monospace);
  font-weight: 600;
  letter-spacing: .04em;
}

.${namespace}-dp__icon {
  display: flex;
  align-items: center;
  color: var(--${namespace}-mu, #8390a6);
  transition: color .15s;
}

.${namespace}-dp__trigger:hover .${namespace}-dp__icon,
.${namespace}-dp--open .${namespace}-dp__icon {
  color: var(--${namespace}-pri, #4d7cfe);
}

/* 悬停清除圆扣 */
.${namespace}-dp__clear {
  position: absolute;
  right: 34px;
  top: 50%;
  transform: translateY(-50%);
  width: 18px;
  height: 18px;
  border-radius: 50%;
  display: none;
  align-items: center;
  justify-content: center;
  background: var(--${namespace}-pn, #e0e5ec);
  box-shadow: var(--${namespace}-ss, 3px 3px 7px var(--${namespace}-sd, #a3b1c6), -3px -3px 7px var(--${namespace}-sl, #ffffff));
  color: var(--${namespace}-mu, #8390a6);
  cursor: pointer;
  font-size: 13px;
  font-weight: 700;
  line-height: 1;
  transition: .15s;
}

.${namespace}-dp:hover .${namespace}-dp__clear {
  display: flex;
}

.${namespace}-dp__clear:hover {
  color: var(--${namespace}-red, #ec5b62);
  box-shadow: var(--${namespace}-sis, inset 2px 2px 5px var(--${namespace}-sd, #a3b1c6), inset -2px -2px 5px var(--${namespace}-sl, #ffffff));
}

/* ── 日历弹出面板：大圆角与双向柔和高凸起投影 ── */
.${namespace}-dp__panel {
  display: none;
  position: fixed;
  background: var(--${namespace}-pn, #e0e5ec);
  border-radius: 22px;
  box-shadow: var(--${namespace}-sp, 9px 9px 18px var(--${namespace}-sd, #a3b1c6), -9px -9px 18px var(--${namespace}-sl, #ffffff));
  border: 0;
  padding: 16px;
  z-index: 99999;
  width: 270px;
  font-family: var(--${namespace}-f, -apple-system, sans-serif);
  animation: dpFadeIn .2s ease both;
}

.${namespace}-dp__panel--open {
  display: block;
}

@keyframes dpFadeIn {
  from { opacity: 0; transform: translateY(-6px); }
  to { opacity: 1; transform: translateY(0); }
}

/* 面板头部 */
.${namespace}-dp__head {
  display: flex;
  align-items: center;
  justify-content: space-between;
  margin-bottom: 12px;
  padding: 0 2px;
}

.${namespace}-dp__nav {
  width: 28px;
  height: 28px;
  border-radius: 50%;
  border: 0;
  background: var(--${namespace}-pn, #e0e5ec);
  box-shadow: var(--${namespace}-ss, 3px 3px 7px var(--${namespace}-sd, #a3b1c6), -3px -3px 7px var(--${namespace}-sl, #ffffff));
  color: var(--${namespace}-mu, #8390a6);
  display: grid;
  place-items: center;
  cursor: pointer;
  font-size: 15px;
  font-weight: 700;
  transition: .15s;
  outline: none;
}

.${namespace}-dp__nav:hover {
  color: var(--${namespace}-pri, #4d7cfe);
}

.${namespace}-dp__nav:active {
  box-shadow: var(--${namespace}-sis, inset 2px 2px 5px var(--${namespace}-sd, #a3b1c6), inset -2px -2px 5px var(--${namespace}-sl, #ffffff));
  color: var(--${namespace}-pri, #4d7cfe);
}

.${namespace}-dp__title {
  flex: 1;
  text-align: center;
  font-size: 13.5px;
  font-weight: 700;
  color: var(--${namespace}-ink, #4a5568);
  cursor: pointer;
  padding: 4px 8px;
  border-radius: 10px;
  transition: .15s;
}

.${namespace}-dp__title:hover {
  color: var(--${namespace}-pri, #4d7cfe);
  box-shadow: var(--${namespace}-sis, inset 2px 2px 5px var(--${namespace}-sd, #a3b1c6), inset -2px -2px 5px var(--${namespace}-sl, #ffffff));
}

/* 星期表头：内凹平滑底槽 */
.${namespace}-dp__weekdays {
  display: grid;
  grid-template-columns: repeat(7, 1fr);
  padding: 5px 2px;
  border-radius: 10px;
  box-shadow: var(--${namespace}-sis, inset 2px 2px 5px var(--${namespace}-sd, #a3b1c6), inset -2px -2px 5px var(--${namespace}-sl, #ffffff));
  margin-bottom: 8px;
}

.${namespace}-dp__wd {
  text-align: center;
  font-size: 11.5px;
  font-weight: 700;
  color: var(--${namespace}-mu, #8390a6);
}

.${namespace}-dp__wd:first-child,
.${namespace}-dp__wd:last-child {
  color: var(--${namespace}-red, #ec5b62);
  opacity: .85;
}

/* 日期矩阵网格 */
.${namespace}-dp__days {
  display: grid;
  grid-template-columns: repeat(7, 1fr);
  gap: 4px;
}

.${namespace}-dp__day {
  height: 30px;
  border-radius: 50%;
  display: grid;
  place-items: center;
  font-size: 12px;
  font-family: var(--${namespace}-m, monospace);
  color: var(--${namespace}-ink, #4a5568);
  font-weight: 600;
  cursor: pointer;
  transition: all .15s ease;
}

.${namespace}-dp__day:hover:not(.${namespace}-dp__day--disabled) {
  box-shadow: var(--${namespace}-ss, 3px 3px 7px var(--${namespace}-sd, #a3b1c6), -3px -3px 7px var(--${namespace}-sl, #ffffff));
  color: var(--${namespace}-pri, #4d7cfe);
}

.${namespace}-dp__day:active:not(.${namespace}-dp__day--disabled) {
  box-shadow: var(--${namespace}-sis, inset 2px 2px 5px var(--${namespace}-sd, #a3b1c6), inset -2px -2px 5px var(--${namespace}-sl, #ffffff));
}

.${namespace}-dp__day--other {
  color: var(--${namespace}-mu, #8390a6);
  opacity: .4;
}

.${namespace}-dp__day--weekend {
  color: var(--${namespace}-red, #ec5b62);
}

/* 当天：内凹高亮标识 */
.${namespace}-dp__day--today {
  box-shadow: var(--${namespace}-sis, inset 2px 2px 5px var(--${namespace}-sd, #a3b1c6), inset -2px -2px 5px var(--${namespace}-sl, #ffffff));
  color: var(--${namespace}-pri, #4d7cfe);
  font-weight: 700;
}

/* 选中项：高光渐变与专属蓝色光晕 */
.${namespace}-dp__day--selected {
  background: linear-gradient(145deg, #6b93ff, #3f6df0) !important;
  color: #ffffff !important;
  box-shadow: 3px 3px 8px rgba(63, 109, 240, .38), -2px -2px 6px var(--${namespace}-sl, #ffffff) !important;
  font-weight: 700;
}

.${namespace}-dp__day--disabled {
  opacity: .25;
  cursor: not-allowed;
  pointer-events: none;
}

/* 月份/年份矩阵网格 */
.${namespace}-dp__grid {
  display: grid;
  grid-template-columns: repeat(3, 1fr);
  gap: 10px;
  padding: 8px 2px;
}

.${namespace}-dp__grid-item {
  text-align: center;
  font-size: 13px;
  font-weight: 600;
  padding: 12px 0;
  border-radius: 14px;
  background: var(--${namespace}-pn, #e0e5ec);
  box-shadow: var(--${namespace}-ss, 3px 3px 7px var(--${namespace}-sd, #a3b1c6), -3px -3px 7px var(--${namespace}-sl, #ffffff));
  color: var(--${namespace}-ink, #4a5568);
  cursor: pointer;
  transition: all .15s ease;
}

.${namespace}-dp__grid-item:hover {
  color: var(--${namespace}-pri, #4d7cfe);
  transform: translateY(-1px);
}

.${namespace}-dp__grid-item:active {
  box-shadow: var(--${namespace}-sis, inset 2px 2px 5px var(--${namespace}-sd, #a3b1c6), inset -2px -2px 5px var(--${namespace}-sl, #ffffff));
  transform: translateY(0);
}

.${namespace}-dp__grid-item--current {
  box-shadow: var(--${namespace}-sis, inset 2px 2px 5px var(--${namespace}-sd, #a3b1c6), inset -2px -2px 5px var(--${namespace}-sl, #ffffff));
  color: var(--${namespace}-pri, #4d7cfe);
}

.${namespace}-dp__grid-item--selected {
  background: linear-gradient(145deg, #6b93ff, #3f6df0) !important;
  color: #ffffff !important;
  box-shadow: 3px 3px 8px rgba(63, 109, 240, .38) !important;
}

/* 底部操作区 */
.${namespace}-dp__footer {
  margin-top: 14px;
  padding-top: 10px;
  display: flex;
  align-items: center;
  justify-content: space-between;
  border-top: 1px solid var(--${namespace}-ln, rgba(131, 144, 166, 0.28));
}

.${namespace}-dp__btn {
  font: 600 12px var(--${namespace}-f, -apple-system, sans-serif);
  padding: 6px 14px;
  border-radius: 10px;
  border: 0;
  background: var(--${namespace}-pn, #e0e5ec);
  box-shadow: var(--${namespace}-ss, 3px 3px 7px var(--${namespace}-sd, #a3b1c6), -3px -3px 7px var(--${namespace}-sl, #ffffff));
  cursor: pointer;
  transition: .15s;
}

.${namespace}-dp__btn:active {
  box-shadow: var(--${namespace}-sis, inset 2px 2px 5px var(--${namespace}-sd, #a3b1c6), inset -2px -2px 5px var(--${namespace}-sl, #ffffff));
}

.${namespace}-dp__btn--clear {
  color: var(--${namespace}-red, #ec5b62);
}

.${namespace}-dp__btn--today {
  color: #ffffff;
  background: linear-gradient(145deg, #6b93ff, #3f6df0);
  box-shadow: 3px 3px 8px rgba(63, 109, 240, .35), -2px -2px 5px var(--${namespace}-sl, #ffffff);
}

.${namespace}-dp__btn--today:hover {
  filter: brightness(1.06);
}

.${namespace}-dp__btn--today:active {
  box-shadow: inset 2px 2px 5px rgba(20, 50, 160, .5);
}

/* 尺寸变体 */
.${namespace}-dp--sm .${namespace}-dp__trigger {
  height: 30px;
  padding: 0 10px;
  font-size: 12px;
  border-radius: 10px;
}
.${namespace}-dp--lg .${namespace}-dp__trigger {
  height: 44px;
  padding: 0 16px;
  font-size: 15px;
  border-radius: 16px;
}

/* 无边框透明变体 */
.${namespace}-dp--plain .${namespace}-dp__trigger {
  background: transparent;
  box-shadow: none;
}
</style>