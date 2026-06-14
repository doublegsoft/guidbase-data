<template>
  <div class="dp-root" ref="rootRef">
    <!-- ── Trigger / Input ─────────────────────── -->
    <div
      class="dp-trigger"
      :class="{
        'dp-trigger--focus': open,
        'dp-trigger--error': error,
        'dp-trigger--disabled': disabled,
      }"
      @click="toggleOpen"
      tabindex="0"
      @keydown.enter="toggleOpen"
      @keydown.space.prevent="toggleOpen"
    >
      <#--  <span class="dp-trigger-icon">📅</span>  -->
      <span v-if="hasValue" class="dp-trigger-value">
        {{ displayValue }}
      </span>
      <span v-else class="dp-trigger-placeholder">
        {{ placeholder }}
      </span>
      <button
        v-if="hasValue && clearable && !disabled"
        class="dp-trigger-clear"
        @click.stop="clearValue"
        title="清除"
      >✕</button>
      <span class="dp-trigger-chevron" :class="{ 'dp-trigger-chevron--open': open }">▾</span>
    </div>

    <!-- ── Dropdown Panel ───────────────────────── -->
    <Transition name="dp-panel">
      <div v-if="open" class="dp-panel" :style="panelStyle" @click.stop>
        <!-- Sidebar-style header with year/month on one row -->
        <div class="dp-panel__header">
          <button class="dp-panel__nav-btn" @click="prevMonth" title="上一月">‹</button>
          <div class="dp-panel__header-center">
            <span class="dp-panel__month" @click="showYearPicker = false; showMonthPicker = !showMonthPicker">{{ monthLabel }}</span>
            <span class="dp-panel__year" @click="showMonthPicker = false; showYearPicker = !showYearPicker">{{ currentYear }}</span>
          </div>
          <button class="dp-panel__nav-btn" @click="nextMonth" title="下一月">›</button>
        </div>

        <!-- Quick-select: month grid -->
        <div v-if="showMonthPicker" class="dp-panel__month-grid">
          <button
            v-for="(m, i) in monthNames"
            :key="i"
            class="dp-panel__month-cell"
            :class="{ 'dp-panel__month-cell--active': i === currentMonth }"
            @click="selectMonth(i)"
          >{{ m }}</button>
        </div>

        <!-- Quick-select: year list -->
        <div v-else-if="showYearPicker" class="dp-panel__year-list">
          <button
            v-for="y in yearRange"
            :key="y"
            class="dp-panel__year-cell"
            :class="{ 'dp-panel__year-cell--active': y === currentYear }"
            @click="selectYear(y)"
          >{{ y }}</button>
        </div>

        <!-- Calendar grid -->
        <div v-else class="dp-panel__body">
          <!-- Weekday headers -->
          <div class="dp-cal__row dp-cal__row--header">
            <span
              v-for="d in weekDays"
              :key="d"
              class="dp-cal__day-header"
            >{{ d }}</span>
          </div>

          <!-- Day cells -->
          <div
            v-for="(week, wi) in weeks"
            :key="wi"
            class="dp-cal__row"
          >
            <button
              v-for="(day, di) in week"
              :key="di"
              class="dp-cal__day"
              :class="dayClasses(day)"
              :disabled="day.disabled"
              @click="selectDay(day)"
              @mouseenter="hoverDay(day)"
            >
              <span class="dp-cal__day-num">{{ day.label }}</span>
              <span v-if="day.hasEvent" class="dp-cal__day-dot"></span>
            </button>
          </div>
        </div>

        <!-- ── Footer ────────────────────────────── -->
        <div v-if="!showMonthPicker && !showYearPicker" class="dp-panel__footer">
          <button class="dp-panel__footer-btn dp-panel__footer-btn--today" @click="goToday">
            今天
          </button>
          <div class="dp-panel__footer-right">
            <span v-if="events.length" class="dp-panel__event-hint">
              <span class="dp-cal__day-dot"></span> 有安排
            </span>
            <button
              v-if="hasValue && clearable"
              class="dp-panel__footer-btn dp-panel__footer-btn--clear"
              @click="clearValue"
            >
              清除
            </button>
          </div>
        </div>
      </div>
    </Transition>

    <!-- ── Overlay (click to close) ──────────────── -->
    <Transition name="dp-overlay">
      <div v-if="open" class="dp-overlay" @click="close"></div>
    </Transition>
  </div>
</template>

<script setup>
import { ref, computed, watch, onMounted, onUnmounted, nextTick } from 'vue'

/* ───────────────────────────────────────────────
   Props
   ─────────────────────────────────────────────── */

const props = defineProps({
  /** v-model: selected date(s) */
  modelValue: { type: [Date, Array, String, Number], default: null },

  /** Selection mode */
  mode: {
    type: String,
    default: 'single',          // 'single' | 'range' | 'multiple'
    validator: v => ['single', 'range', 'multiple'].includes(v),
  },

  /** Placeholder text */
  placeholder: { type: String, default: '选择日期' },

  /** Display format — uses simple token replacement */
  format: { type: String, default: 'YYYY-MM-DD' },

  /** Min selectable date */
  minDate: { type: Date, default: null },

  /** Max selectable date */
  maxDate: { type: Date, default: null },

  /** Array of dates that have events (shown as dots) */
  events: { type: Array, default: () => [] },

  /** Disable specific dates (array of Date or fn) */
  disabledDates: { type: Array, default: () => [] },

  /** Disable weekends */
  disableWeekends: { type: Boolean, default: false },

  /** Show clear button */
  clearable: { type: Boolean, default: true },

  /** Disabled state */
  disabled: { type: Boolean, default: false },

  /** Error state */
  error: { type: Boolean, default: false },

  /** First day of week: 0=Sun, 1=Mon */
  firstDayOfWeek: { type: Number, default: 0 },

  /** Locale */
  locale: { type: String, default: 'zh-CN' },
})

/* ───────────────────────────────────────────────
   Emits
   ─────────────────────────────────────────────── */

const emit = defineEmits(['update:modelValue', 'change', 'focus', 'blur'])

/* ───────────────────────────────────────────────
   State
   ─────────────────────────────────────────────── */

const open = ref(false)
const rootRef = ref(null)
const panelRef = ref(null)
const currentYear = ref(new Date().getFullYear())
const currentMonth = ref(new Date().getMonth())   // 0-indexed
const showMonthPicker = ref(false)
const showYearPicker = ref(false)
const hoverDate = ref(null)                       // for range preview
const panelStyle = ref({})                        // dynamic positioning

/* ───────────────────────────────────────────────
   Smart Panel Positioning
   Uses position:fixed & auto-flips when space
   is insufficient — never expands page height.
   ─────────────────────────────────────────────── */

const PANEL_GAP = 6          // gap between trigger and panel
const PANEL_WIDTH = 300      // must match CSS .dp-panel width

function updatePanelPosition() {
  if (!open.value) return
  const trigger = rootRef.value?.querySelector('.dp-trigger')
  if (!trigger) return

  const triggerRect = trigger.getBoundingClientRect()
  const vw = window.innerWidth
  const vh = window.innerHeight

  // ── Vertical: prefer below, flip above if insufficient ──
  const spaceBelow = vh - triggerRect.bottom - PANEL_GAP
  const spaceAbove = triggerRect.top - PANEL_GAP
  const panelEl = rootRef.value?.querySelector('.dp-panel')
  const panelHeight = panelEl ? panelEl.offsetHeight : 380
  // For month/year picker variants, use a taller estimate
  const estimatedHeight = panelHeight > 100 ? panelHeight : 380

  let top, bottom
  let originY = 'top'   // for transform-origin of the scale animation

  if (spaceBelow >= estimatedHeight || spaceBelow >= spaceAbove) {
    // Position below
    top = triggerRect.bottom + PANEL_GAP
    originY = 'top'
  } else {
    // Position above
    top = triggerRect.top - estimatedHeight - PANEL_GAP
    if (top < 0) top = PANEL_GAP   // clamp to viewport top
    originY = 'bottom'
  }

  // ── Horizontal: align-left by default, flip if overflow ──
  let left = triggerRect.left
  if (left + PANEL_WIDTH > vw - 8) {
    // Align right edge of panel with right edge of trigger
    left = triggerRect.right - PANEL_WIDTH
  }
  if (left < 8) left = 8   // clamp to viewport edge

  panelStyle.value = {
    position: 'fixed',
    top: top + 'px',
    left: left + 'px',
  }

  // Update transform-origin so the scale animation plays in the right direction
  if (panelEl) {
    panelEl.style.transformOrigin = `center ${r"${originY}"}`
  }
}

// Reposition on open
watch(open, async (val) => {
  if (val) {
    await nextTick()
    updatePanelPosition()
  }
})

// Reposition on scroll/resize while open
function onScrollOrResize() {
  if (open.value) updatePanelPosition()
}

onMounted(() => {
  window.addEventListener('scroll', onScrollOrResize, true)   // capture phase for scrollable ancestors
  window.addEventListener('resize', onScrollOrResize)
})

onUnmounted(() => {
  window.removeEventListener('scroll', onScrollOrResize, true)
  window.removeEventListener('resize', onScrollOrResize)
})

/* ───────────────────────────────────────────────
   Locale data
   ─────────────────────────────────────────────── */

const locales = {
  'zh-CN': {
    weekDays:  ['日', '一', '二', '三', '四', '五', '六'],
    months:    ['1月','2月','3月','4月','5月','6月','7月','8月','9月','10月','11月','12月'],
    today:     '今天',
    clear:     '清除',
  },
  'en': {
    weekDays:  ['Su','Mo','Tu','We','Th','Fr','Sa'],
    months:    ['Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'],
    today:     'Today',
    clear:     'Clear',
  },
}

const L = computed(() => locales[props.locale] || locales['zh-CN'])
const weekDays = computed(() => {
  const base = L.value.weekDays
  // Rotate based on firstDayOfWeek
  if (props.firstDayOfWeek === 0) return base
  return [...base.slice(props.firstDayOfWeek), ...base.slice(0, props.firstDayOfWeek)]
})
const monthNames = computed(() => L.value.months)
const monthLabel = computed(() => L.value.months[currentMonth.value])

/* ───────────────────────────────────────────────
   Year range for year picker (±5 years)
   ─────────────────────────────────────────────── */

const yearRange = computed(() => {
  const base = currentYear.value
  const years = []
  for (let y = base - 5; y <= base + 5; y++) years.push(y)
  return years
})

/* ───────────────────────────────────────────────
   Helpers
   ─────────────────────────────────────────────── */

function toDate(v) {
  if (v instanceof Date) return new Date(v)
  if (typeof v === 'string' || typeof v === 'number') {
    const d = new Date(v)
    return isNaN(d.getTime()) ? null : d
  }
  return null
}

function sameDay(a, b) {
  if (!a || !b) return false
  return a.getFullYear() === b.getFullYear()
      && a.getMonth() === b.getMonth()
      && a.getDate() === b.getDate()
}

function isInRange(day, start, end) {
  if (!start || !end) return false
  const t = day.getTime()
  return t >= start.getTime() && t <= end.getTime()
}

function clampDate(d) {
  let out = new Date(d)
  if (props.minDate && out < props.minDate) out = new Date(props.minDate)
  if (props.maxDate && out > props.maxDate) out = new Date(props.maxDate)
  return out
}

/* ───────────────────────────────────────────────
   Internal model + computed display
   ─────────────────────────────────────────────── */

const innerValue = ref(null)   // for single: Date | null ; range: [Date,Date] ; multiple: Date[]

// Sync external → internal
watch(() => props.modelValue, v => { innerValue.value = normalizeIn(v) }, { immediate: true })

function normalizeIn(v) {
  if (!v) return props.mode === 'range' ? [null, null] : props.mode === 'multiple' ? [] : null
  if (props.mode === 'range') {
    if (Array.isArray(v)) return [toDate(v[0]), toDate(v[1])]
    return [null, null]
  }
  if (props.mode === 'multiple') {
    if (Array.isArray(v)) return v.map(toDate).filter(Boolean)
    return []
  }
  return toDate(v)
}

const hasValue = computed(() => {
  if (props.mode === 'range') return innerValue.value?.[0] || innerValue.value?.[1]
  if (props.mode === 'multiple') return innerValue.value?.length > 0
  return !!innerValue.value
})

const displayValue = computed(() => {
  if (props.mode === 'range') {
    const [s, e] = innerValue.value || [null, null]
    if (s && e) return ${r"`${fmt(s)} — ${fmt(e)}`"}
    if (s) return ${r"`${fmt(s)} — …`"}
    return ''
  }
  if (props.mode === 'multiple') {
    const arr = innerValue.value || []
    if (arr.length === 0) return ''
    if (arr.length === 1) return fmt(arr[0])
    return ${r"`${fmt(arr[0])} 等 ${arr.length} 天`"}
  }
  return innerValue.value ? fmt(innerValue.value) : ''
})

function fmt(d) {
  if (!d) return ''
  const y = d.getFullYear()
  const m = String(d.getMonth() + 1).padStart(2, '0')
  const day = String(d.getDate()).padStart(2, '0')
  return props.format
    .replace('YYYY', y)
    .replace('MM', m)
    .replace('DD', day)
}

/* ───────────────────────────────────────────────
   Calendar grid builder
   ─────────────────────────────────────────────── */

const weeks = computed(() => {
  const year = currentYear.value
  const month = currentMonth.value
  const firstDay = new Date(year, month, 1)
  const lastDay  = new Date(year, month + 1, 0)

  // Determine the start of the first week
  let start = new Date(firstDay)
  const fdow = props.firstDayOfWeek
  const dayOfWeek = firstDay.getDay()
  const diff = (dayOfWeek - fdow + 7) % 7
  start.setDate(start.getDate() - diff)

  const today = new Date()
  today.setHours(0, 0, 0, 0)

  const rows = []
  let cursor = new Date(start)
  let done = false

  while (!done) {
    const week = []
    for (let i = 0; i < 7; i++) {
      const d = new Date(cursor)
      const isCurrentMonth = d.getMonth() === month
      const isToday = sameDay(d, today)
      const eventDates = props.events.map(toDate).filter(Boolean)
      const hasEvent = eventDates.some(ed => sameDay(ed, d))

      // Disabled logic
      let disabled = false
      if (props.minDate && d < new Date(props.minDate.setHours(0,0,0,0))) disabled = true
      if (props.maxDate) {
        const mx = new Date(props.maxDate)
        mx.setHours(23, 59, 59, 999)
        if (d > mx) disabled = true
      }
      if (props.disableWeekends && (d.getDay() === 0 || d.getDay() === 6)) disabled = true
      if (props.disabledDates.some(dd => sameDay(toDate(dd), d))) disabled = true

      week.push({
        date: d,
        label: d.getDate(),
        isCurrentMonth,
        isToday,
        hasEvent,
        disabled,
      })

      cursor.setDate(cursor.getDate() + 1)
    }
    rows.push(week)
    // Stop when we've passed the last day of the month and completed the week
    if (cursor > lastDay && cursor.getDay() === (props.firstDayOfWeek % 7)) {
      done = true
    }
    // Safety: max 6 rows
    if (rows.length >= 6) done = true
  }
  return rows
})

/* ───────────────────────────────────────────────
   Day CSS classes
   ─────────────────────────────────────────────── */

function dayClasses(day) {
  const cls = {}
  if (!day.isCurrentMonth) cls['dp-cal__day--dimmed'] = true
  if (day.isToday)         cls['dp-cal__day--today'] = true

  const iv = innerValue.value

  if (props.mode === 'single') {
    if (sameDay(iv, day.date)) cls['dp-cal__day--selected'] = true
  }

  if (props.mode === 'range') {
    const [s, e] = iv || [null, null]
    if (s && sameDay(s, day.date)) cls['dp-cal__day--range-start'] = true
    if (e && sameDay(e, day.date)) cls['dp-cal__day--range-end'] = true
    if (s && e && isInRange(day.date, s, e) && !sameDay(day.date, s) && !sameDay(day.date, e)) {
      cls['dp-cal__day--in-range'] = true
    }
    // Hover preview
    if (s && !e && hoverDate.value && isInRange(day.date, s, hoverDate.value) && !sameDay(day.date, s)) {
      cls['dp-cal__day--in-range'] = true
    }
  }

  if (props.mode === 'multiple') {
    const arr = iv || []
    if (arr.some(d => sameDay(d, day.date))) cls['dp-cal__day--selected'] = true
  }

  return cls
}

/* ───────────────────────────────────────────────
   Actions
   ─────────────────────────────────────────────── */

function toggleOpen() {
  if (props.disabled) return
  open.value = !open.value
  if (open.value) {
    showMonthPicker.value = false
    showYearPicker.value = false
    // Sync calendar to selected date
    syncCalendarToValue()
    nextTick(() => rootRef.value?.querySelector('.dp-panel')?.focus?.())
    emit('focus')
  } else {
    emit('blur')
  }
}

function close() {
  open.value = false
  showMonthPicker.value = false
  showYearPicker.value = false
  hoverDate.value = null
  emit('blur')
}

function syncCalendarToValue() {
  const iv = innerValue.value
  let target
  if (props.mode === 'range') {
    target = iv?.[0] || iv?.[1]
  } else if (props.mode === 'multiple') {
    target = iv?.[0]
  } else {
    target = iv
  }
  if (target) {
    currentYear.value = target.getFullYear()
    currentMonth.value = target.getMonth()
  }
}

function selectDay(day) {
  if (day.disabled) return

  if (props.mode === 'single') {
    innerValue.value = new Date(day.date)
    emit('update:modelValue', innerValue.value)
    emit('change', innerValue.value)
    close()
  }

  if (props.mode === 'range') {
    const [s, e] = innerValue.value || [null, null]
    if (!s || (s && e)) {
      // Start new range
      innerValue.value = [new Date(day.date), null]
      hoverDate.value = null
      emit('update:modelValue', [innerValue.value[0], null])
    } else {
      // Complete range
      let end = new Date(day.date)
      if (end < s) {
        innerValue.value = [end, new Date(s)]
      } else {
        innerValue.value = [new Date(s), end]
      }
      hoverDate.value = null
      emit('update:modelValue', [...innerValue.value])
      emit('change', [...innerValue.value])
      close()
    }
  }

  if (props.mode === 'multiple') {
    const arr = [...(innerValue.value || [])]
    const idx = arr.findIndex(d => sameDay(d, day.date))
    if (idx >= 0) {
      arr.splice(idx, 1)
    } else {
      arr.push(new Date(day.date))
    }
    innerValue.value = arr
    emit('update:modelValue', arr.map(d => new Date(d)))
    emit('change', arr.map(d => new Date(d)))
    // Don't close for multiple — user may pick several
  }
}

function hoverDay(day) {
  if (props.mode === 'range' && innerValue.value?.[0] && !innerValue.value?.[1]) {
    hoverDate.value = day.date
  }
}

function prevMonth() {
  if (currentMonth.value === 0) {
    currentMonth.value = 11
    currentYear.value--
  } else {
    currentMonth.value--
  }
}

function nextMonth() {
  if (currentMonth.value === 11) {
    currentMonth.value = 0
    currentYear.value++
  } else {
    currentMonth.value++
  }
}

function prevYear()  { currentYear.value-- }
function nextYear()  { currentYear.value++ }

function goToday() {
  const today = new Date()
  today.setHours(0, 0, 0, 0)
  currentYear.value = today.getFullYear()
  currentMonth.value = today.getMonth()
  if (props.mode === 'single') {
    innerValue.value = today
    emit('update:modelValue', today)
    emit('change', today)
    close()
  }
}

function clearValue() {
  if (props.mode === 'range') {
    innerValue.value = [null, null]
    emit('update:modelValue', [null, null])
  } else if (props.mode === 'multiple') {
    innerValue.value = []
    emit('update:modelValue', [])
  } else {
    innerValue.value = null
    emit('update:modelValue', null)
  }
  emit('change', innerValue.value)
  if (props.mode === 'single') close()
}

function selectMonth(i) {
  currentMonth.value = i
  showMonthPicker.value = false
}

function selectYear(y) {
  currentYear.value = y
  showYearPicker.value = false
}

/* ───────────────────────────────────────────────
   Click outside → close
   ─────────────────────────────────────────────── */

function onClickOutside(e) {
  if (rootRef.value && !rootRef.value.contains(e.target)) {
    close()
  }
}

onMounted(() => document.addEventListener('pointerdown', onClickOutside))
onUnmounted(() => document.removeEventListener('pointerdown', onClickOutside))
</script>

<style scoped>
/* ═══════════════════════════════════════════════════════════════════════════
   DATEPICKER — Academy Pro Style
   ═══════════════════════════════════════════════════════════════════════════ */

.dp-root {
  position: relative;
  display: inline-block;
  width: 100%;
}

/* ── Trigger ──────────────────────────────────── */

.dp-trigger {
  display: flex;
  align-items: center;
  gap: var(--space-5);
  border: 1px solid var(--color-border);
  border-radius: var(--radius-md);
  padding: var(--space-5) var(--space-7);
  font-size: var(--text-body);
  color: var(--color-text-main);
  background: var(--color-card);
  transition: border-color var(--transition-base), box-shadow var(--transition-base);
  cursor: pointer;
  outline: none;
  width: 100%;
  user-select: none;
}

.dp-trigger:hover {
  border-color: var(--color-teal);
}

.dp-trigger--focus {
  border-color: var(--color-teal);
  box-shadow: 0 0 0 3px var(--color-teal-dim);
}

.dp-trigger--error {
  border-color: var(--color-red);
  box-shadow: 0 0 0 3px var(--color-red-dim);
}

.dp-trigger--disabled {
  opacity: 0.5;
  cursor: not-allowed;
  background: var(--color-surface);
}

.dp-trigger-icon {
  font-size: var(--text-2xl);
  flex-shrink: 0;
}

.dp-trigger-value {
  flex: 1;
  font-weight: var(--weight-medium);
  color: var(--color-text-main);
  font-variant-numeric: tabular-nums;
}

.dp-trigger-placeholder {
  flex: 1;
  color: var(--color-text-muted);
}

.dp-trigger-clear {
  background: none;
  border: none;
  cursor: pointer;
  color: var(--color-text-muted);
  font-size: var(--text-lg);
  padding: 2px;
  border-radius: var(--radius-xs);
  transition: all var(--transition-fast);
  line-height: 1;
}

.dp-trigger-clear:hover {
  color: var(--color-red);
  background: var(--color-red-dim);
}

.dp-trigger-chevron {
  color: var(--color-text-muted);
  font-size: var(--text-sm);
  transition: transform var(--transition-base);
}

.dp-trigger-chevron--open {
  transform: rotate(180deg);
  color: var(--color-teal);
}

/* ── Panel ──────────────────────────────────────
   NOTE: position / top / left are set dynamically
   via :style to auto-flip when space is tight.
   The static fallback below is overridden at open.
   ─────────────────────────────────────────────── */

.dp-panel {
  position: absolute;           /* fallback; overridden by :style */
  top: calc(100% + 6px);       /* fallback; overridden by :style */
  left: 0;                     /* fallback; overridden by :style */
  z-index: 600;
  background: var(--color-card);
  border: 1px solid var(--color-border);
  border-radius: var(--radius-xl);
  box-shadow: var(--shadow-lg);
  width: 300px;
  overflow: hidden;
}

/* ── Panel Header (navy sidebar style, single row) ── */

.dp-panel__header {
  background: var(--color-navy);
  padding: var(--space-7) var(--space-9);
  display: flex;
  align-items: center;
  justify-content: space-between;
  gap: var(--space-5);
  position: relative;
}

.dp-panel__header::after {
  content: '';
  position: absolute;
  bottom: 0;
  left: 0;
  right: 0;
  height: 1px;
  background: linear-gradient(
    90deg,
    transparent,
    var(--color-teal),
    transparent
  );
  opacity: 0.4;
}

.dp-panel__header-center {
  display: flex;
  align-items: baseline;
  gap: var(--space-5);
}

.dp-panel__year {
  font-size: var(--text-xs);
  font-weight: var(--weight-semibold);
  color: rgba(255,255,255,0.4);
  text-transform: uppercase;
  letter-spacing: 1.5px;
  cursor: pointer;
  transition: color var(--transition-fast);
}

.dp-panel__year:hover {
  color: var(--color-teal);
}

.dp-panel__month {
  font-size: var(--text-2xl);
  font-weight: var(--weight-bold);
  color: #fff;
  cursor: pointer;
  transition: color var(--transition-fast);
  letter-spacing: 0.3px;
}

.dp-panel__month:hover {
  color: var(--color-teal);
}

.dp-panel__nav-btn {
  width: 28px;
  height: 28px;
  border-radius: var(--radius-sm);
  background: rgba(255,255,255,0.06);
  border: 1px solid rgba(255,255,255,0.08);
  color: rgba(255,255,255,0.6);
  cursor: pointer;
  font-size: var(--text-lg);
  display: flex;
  align-items: center;
  justify-content: center;
  transition: all var(--transition-fast);
  font-family: inherit;
  flex-shrink: 0;
}

.dp-panel__nav-btn:hover {
  background: var(--color-teal-dim);
  border-color: var(--color-teal);
  color: var(--color-teal);
}

/* ── Panel Body (calendar grid) ───────────────── */

.dp-panel__body {
  padding: var(--space-7) var(--space-6);
}

.dp-cal__row {
  display: grid;
  grid-template-columns: repeat(7, 1fr);
  gap: 2px;
}

.dp-cal__row--header {
  margin-bottom: var(--space-2);
}

.dp-cal__day-header {
  text-align: center;
  font-size: var(--text-xs);
  font-weight: var(--weight-semibold);
  color: var(--color-text-muted);
  text-transform: uppercase;
  padding: var(--space-4) 0;
  letter-spacing: 0.5px;
}

.dp-cal__day {
  position: relative;
  aspect-ratio: 1;
  border: none;
  background: transparent;
  border-radius: var(--radius-sm);
  font-size: var(--text-base);
  font-family: inherit;
  font-weight: var(--weight-medium);
  color: var(--color-text-main);
  cursor: pointer;
  transition: all var(--transition-fast);
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  font-variant-numeric: tabular-nums;
}

.dp-cal__day:hover:not(:disabled) {
  background: var(--color-surface);
}

.dp-cal__day:focus-visible {
  outline: 2px solid var(--color-teal);
  outline-offset: -2px;
}

/* Dimmed (other month) */
.dp-cal__day--dimmed {
  color: var(--color-text-muted);
}

/* Today */
.dp-cal__day--today {
  font-weight: var(--weight-bold);
  color: var(--color-teal);
}

.dp-cal__day--today::before {
  content: '';
  position: absolute;
  top: 2px;
  left: 50%;
  transform: translateX(-50%);
  width: 4px;
  height: 4px;
  border-radius: var(--radius-full);
  background: var(--color-teal);
  opacity: 0;
}

/* Selected (single / multiple) */
.dp-cal__day--selected {
  background: var(--color-teal) !important;
  color: #fff !important;
  font-weight: var(--weight-bold);
}

/* Range start */
.dp-cal__day--range-start {
  background: var(--color-teal) !important;
  color: #fff !important;
  font-weight: var(--weight-bold);
  border-radius: var(--radius-sm) 0 0 var(--radius-sm);
}

/* Range end */
.dp-cal__day--range-end {
  background: var(--color-teal) !important;
  color: #fff !important;
  font-weight: var(--weight-bold);
  border-radius: 0 var(--radius-sm) var(--radius-sm) 0;
}

/* In range */
.dp-cal__day--in-range {
  background: var(--color-teal-dim);
  border-radius: 0;
  color: var(--color-teal-text);
}

/* Disabled */
.dp-cal__day:disabled {
  color: var(--color-text-muted);
  opacity: 0.35;
  cursor: not-allowed;
}

/* Event dot */
.dp-cal__day-dot {
  position: absolute;
  bottom: 3px;
  left: 50%;
  transform: translateX(-50%);
  width: 4px;
  height: 4px;
  border-radius: var(--radius-full);
  background: var(--color-amber);
}

.dp-cal__day--selected .dp-cal__day-dot,
.dp-cal__day--range-start .dp-cal__day-dot,
.dp-cal__day--range-end .dp-cal__day-dot {
  background: #fff;
}

/* ── Month Picker Grid ────────────────────────── */

.dp-panel__month-grid {
  display: grid;
  grid-template-columns: repeat(3, 1fr);
  gap: var(--space-5);
  padding: var(--space-9) var(--space-9);
}

.dp-panel__month-cell {
  padding: var(--space-6) var(--space-3);
  border: 1px solid var(--color-border);
  border-radius: var(--radius-md);
  background: var(--color-card);
  font-family: inherit;
  font-size: var(--text-md);
  font-weight: var(--weight-medium);
  color: var(--color-text-main);
  cursor: pointer;
  transition: all var(--transition-fast);
}

.dp-panel__month-cell:hover {
  border-color: var(--color-teal);
  background: var(--color-teal-dim);
}

.dp-panel__month-cell--active {
  background: var(--color-teal);
  color: #fff;
  border-color: var(--color-teal);
  font-weight: var(--weight-bold);
}

/* ── Year Picker List ─────────────────────────── */

.dp-panel__year-list {
  display: grid;
  grid-template-columns: repeat(3, 1fr);
  gap: var(--space-5);
  padding: var(--space-9) var(--space-9);
  max-height: 200px;
  overflow-y: auto;
}

.dp-panel__year-cell {
  padding: var(--space-5) var(--space-3);
  border: 1px solid var(--color-border);
  border-radius: var(--radius-md);
  background: var(--color-card);
  font-family: inherit;
  font-size: var(--text-md);
  font-weight: var(--weight-medium);
  color: var(--color-text-main);
  cursor: pointer;
  transition: all var(--transition-fast);
  font-variant-numeric: tabular-nums;
}

.dp-panel__year-cell:hover {
  border-color: var(--color-teal);
  background: var(--color-teal-dim);
}

.dp-panel__year-cell--active {
  background: var(--color-teal);
  color: #fff;
  border-color: var(--color-teal);
  font-weight: var(--weight-bold);
}

/* ── Footer ───────────────────────────────────── */

.dp-panel__footer {
  padding: var(--space-6) var(--space-9);
  border-top: 1px solid var(--color-border);
  display: flex;
  align-items: center;
  justify-content: space-between;
  gap: var(--space-6);
}

.dp-panel__footer-btn {
  border: none;
  background: var(--color-surface);
  border-radius: var(--radius-sm);
  padding: var(--space-3) var(--space-7);
  font-family: inherit;
  font-size: var(--text-base);
  font-weight: var(--weight-semibold);
  cursor: pointer;
  transition: all var(--transition-fast);
  color: var(--color-text-sub);
}

.dp-panel__footer-btn:hover {
  background: var(--color-teal-dim);
  color: var(--color-teal);
}

.dp-panel__footer-btn--clear:hover {
  background: var(--color-red-dim);
  color: var(--color-red);
}

.dp-panel__footer-right {
  display: flex;
  align-items: center;
  gap: var(--space-6);
}

.dp-panel__event-hint {
  font-size: var(--text-sm);
  color: var(--color-text-muted);
  display: flex;
  align-items: center;
  gap: var(--space-3);
}

.dp-panel__event-hint .dp-cal__day-dot {
  position: static;
  transform: none;
}

/* ── Overlay ──────────────────────────────────── */

.dp-overlay {
  position: fixed;
  inset: 0;
  z-index: 599;
  background: transparent;
}

/* ── Transitions ──────────────────────────────── */

.dp-panel-enter-active {
  animation: dpPanelIn var(--transition-smooth);
}

.dp-panel-leave-active {
  animation: dpPanelOut 0.12s ease;
}

@keyframes dpPanelIn {
  from { opacity: 0; transform: translateY(-6px) scale(0.97); }
  to   { opacity: 1; transform: translateY(0) scale(1); }
}

@keyframes dpPanelOut {
  from { opacity: 1; transform: translateY(0) scale(1); }
  to   { opacity: 0; transform: translateY(-6px) scale(0.97); }
}

.dp-overlay-enter-active { animation: fadeIn var(--transition-fast); }
.dp-overlay-leave-active { animation: fadeOut var(--transition-fast); }

@keyframes fadeIn  { from { opacity: 0; } to { opacity: 1; } }
@keyframes fadeOut { from { opacity: 1; } to { opacity: 0; } }
</style>
