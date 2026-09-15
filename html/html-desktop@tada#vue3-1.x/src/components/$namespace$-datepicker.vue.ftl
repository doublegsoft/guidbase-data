<template>
  <div style="position: relative; width: 100%; display: inline-block;" ref="rootRef">
    <!-- ── 触发输入框 (复用 ${namespace}-input 与贴纸圆钮) ──────────── -->
    <div
      class="${namespace}-input"
      style="display: flex; align-items: center; justify-content: space-between; cursor: pointer; user-select: none; gap: 8px;"
      :style="disabled ? 'opacity: 0.5; cursor: not-allowed;' : ''"
      @click="toggleOpen"
      tabindex="0"
      @keydown.enter="toggleOpen"
      @keydown.space.prevent="toggleOpen"
    >
      <div style="display: flex; align-items: center; gap: 6px; overflow: hidden; text-overflow: ellipsis; white-space: nowrap;">
        <span style="font-size: 14px;">📅</span>
        <span v-if="hasValue" style="font-weight: 800;">{{ displayValue }}</span>
        <span v-else style="color: var(--${namespace}-text-light); font-weight: 700;">{{ placeholder }}</span>
      </div>

      <div style="display: flex; align-items: center; gap: 6px; flex-shrink: 0;">
        <button
          v-if="hasValue && clearable && !disabled"
          type="button"
          class="${namespace}-btn ${namespace}-btn--default ${namespace}-btn--sm"
          style="width: 20px; height: 20px; padding: 0; border-radius: 9999px; font-size: 10px;"
          @click.stop="clearValue"
          title="清除"
        >✕</button>
        <span
          style="font-size: 10px; color: var(--${namespace}-text-light); transition: transform 0.2s;"
          :style="open ? 'transform: rotate(180deg); color: var(--${namespace}-primary);' : ''"
        >▾</span>
      </div>
    </div>

    <!-- ── 日历弹出面板 (复用 ${namespace}-panel) ────────────────── -->
    <div
      v-if="open"
      class="${namespace}-panel"
      :style="panelStyle"
      style="width: 300px; z-index: 600; box-shadow: var(--${namespace}-shadow-md); background: #ffffff;"
      @click.stop
    >
      <!-- 面板头部 (复用 ${namespace}-panel-head & ${namespace}-rn-btn 翻页钮) -->
      <div class="${namespace}-panel-head" style="justify-content: space-between; padding: 10px 14px;">
        <button
          type="button"
          class="${namespace}-rn-btn"
          style="width: 28px; height: 28px; padding: 0;"
          @click="prevMonth"
          title="上一月"
        >‹</button>

        <div style="display: flex; align-items: center; gap: 6px;">
          <span
            class="${namespace}-rn-idx"
            style="cursor: pointer; padding: 3px 8px;"
            @click="showYearPicker = false; showMonthPicker = !showMonthPicker"
          >
            {{ monthLabel }}
          </span>
          <span
            class="${namespace}-rn-idx"
            style="cursor: pointer; padding: 3px 8px;"
            @click="showMonthPicker = false; showYearPicker = !showYearPicker"
          >
            {{ currentYear }} 年
          </span>
        </div>

        <button
          type="button"
          class="${namespace}-rn-btn"
          style="width: 28px; height: 28px; padding: 0;"
          @click="nextMonth"
          title="下一月"
        >›</button>
      </div>

      <!-- 快速选择：月份宫格 (复用 ${namespace}-btn) -->
      <div
        v-if="showMonthPicker"
        style="display: grid; grid-template-columns: repeat(3, 1fr); gap: 8px; padding: 14px;"
      >
        <button
          v-for="(m, i) in monthNames"
          :key="i"
          type="button"
          class="${namespace}-btn"
          :class="i === currentMonth ? '${namespace}-btn--primary' : '${namespace}-btn--default'"
          style="height: 32px; font-size: 12px;"
          @click="selectMonth(i)"
        >{{ m }}</button>
      </div>

      <!-- 快速选择：年份列表 (复用 ${namespace}-btn) -->
      <div
        v-else-if="showYearPicker"
        style="display: grid; grid-template-columns: repeat(3, 1fr); gap: 8px; padding: 14px; max-height: 220px; overflow-y: auto;"
      >
        <button
          v-for="y in yearRange"
          :key="y"
          type="button"
          class="${namespace}-btn"
          :class="y === currentYear ? '${namespace}-btn--primary' : '${namespace}-btn--default'"
          style="height: 32px; font-size: 12px;"
          @click="selectYear(y)"
        >{{ y }}</button>
      </div>

      <!-- 日历网格主体 -->
      <div v-else style="padding: 10px 12px;">
        <!-- 星期标题行 -->
        <div style="display: grid; grid-template-columns: repeat(7, 1fr); gap: 2px; margin-bottom: 6px; text-align: center;">
          <span
            v-for="d in weekDays"
            :key="d"
            style="font-size: 11px; font-weight: 900; color: var(--${namespace}-text-light);"
          >{{ d }}</span>
        </div>

        <!-- 日期格子 -->
        <div
          v-for="(week, wi) in weeks"
          :key="wi"
          style="display: grid; grid-template-columns: repeat(7, 1fr); gap: 2px; margin-bottom: 2px;"
        >
          <button
            v-for="(day, di) in week"
            :key="di"
            type="button"
            class="${namespace}-btn ${namespace}-btn--sm"
            :class="getDayBtnClass(day)"
            :style="getDayCustomStyle(day)"
            :disabled="day.disabled"
            @click="selectDay(day)"
            @mouseenter="hoverDay(day)"
          >
            <span>{{ day.label }}</span>
            <span
              v-if="day.hasEvent"
              style="position: absolute; bottom: 2px; width: 4px; height: 4px; border-radius: 9999px; background: var(--${namespace}-gold);"
            ></span>
          </button>
        </div>
      </div>

      <!-- 面板底栏 (复用 ${namespace}-statusbar 与操作按钮) -->
      <div
        v-if="!showMonthPicker && !showYearPicker"
        class="${namespace}-statusbar"
        style="padding: 8px 14px; border-top: 2px solid var(--${namespace}-border-light);"
      >
        <button
          type="button"
          class="${namespace}-btn ${namespace}-btn--default ${namespace}-btn--sm"
          @click="goToday"
        >今天</button>

        <div style="display: flex; align-items: center; gap: 8px;">
          <span v-if="events.length" style="font-size: 11px; color: var(--${namespace}-text-muted); display: flex; align-items: center; gap: 4px;">
            <span style="width: 5px; height: 5px; border-radius: 9999px; background: var(--${namespace}-gold); display: inline-block;"></span> 安排
          </span>
          <button
            v-if="hasValue && clearable"
            type="button"
            class="${namespace}-btn ${namespace}-btn--default ${namespace}-btn--sm"
            style="color: var(--${namespace}-danger);"
            @click="clearValue"
          >清除</button>
        </div>
      </div>
    </div>

    <!-- 背景遮罩 (用于点击面板外自动关闭) -->
    <div
      v-if="open"
      style="position: fixed; inset: 0; z-index: 599; background: transparent;"
      @click="close"
    ></div>
  </div>
</template>

<script setup>
import { ref, computed, watch, onMounted, onUnmounted, nextTick } from 'vue'

const props = defineProps({
  modelValue: { type: [Date, Array, String, Number], default: null },
  mode: { type: String, default: 'single' }, // 'single' | 'range' | 'multiple'
  placeholder: { type: String, default: '选择日期' },
  format: { type: String, default: 'YYYY-MM-DD' },
  minDate: { type: Date, default: null },
  maxDate: { type: Date, default: null },
  events: { type: Array, default: () => [] },
  disabledDates: { type: Array, default: () => [] },
  disableWeekends: { type: Boolean, default: false },
  clearable: { type: Boolean, default: true },
  disabled: { type: Boolean, default: false },
  firstDayOfWeek: { type: Number, default: 0 },
  locale: { type: String, default: 'zh-CN' }
})

const emit = defineEmits(['update:modelValue', 'change', 'focus', 'blur'])

const open = ref(false)
const rootRef = ref(null)
const currentYear = ref(new Date().getFullYear())
const currentMonth = ref(new Date().getMonth())
const showMonthPicker = ref(false)
const showYearPicker = ref(false)
const hoverDate = ref(null)
const panelStyle = ref({})

const PANEL_GAP = 6
const PANEL_WIDTH = 300

function updatePanelPosition() {
  if (!open.value) return
  const trigger = rootRef.value?.querySelector('.${namespace}-input')
  if (!trigger) return

  const triggerRect = trigger.getBoundingClientRect()
  const vw = window.innerWidth
  const vh = window.innerHeight

  const spaceBelow = vh - triggerRect.bottom - PANEL_GAP
  const spaceAbove = triggerRect.top - PANEL_GAP
  const estimatedHeight = 350

  let top
  if (spaceBelow >= estimatedHeight || spaceBelow >= spaceAbove) {
    top = triggerRect.bottom + PANEL_GAP
  } else {
    top = triggerRect.top - estimatedHeight - PANEL_GAP
    if (top < 0) top = PANEL_GAP
  }

  let left = triggerRect.left
  if (left + PANEL_WIDTH > vw - 8) {
    left = triggerRect.right - PANEL_WIDTH
  }
  if (left < 8) left = 8

  panelStyle.value = {
    position: 'fixed',
    top: top + 'px',
    left: left + 'px'
  }
}

watch(open, async (val) => {
  if (val) {
    await nextTick()
    updatePanelPosition()
  }
})

function onScrollOrResize() {
  if (open.value) updatePanelPosition()
}

onMounted(() => {
  window.addEventListener('scroll', onScrollOrResize, true)
  window.addEventListener('resize', onScrollOrResize)
})

onUnmounted(() => {
  window.removeEventListener('scroll', onScrollOrResize, true)
  window.removeEventListener('resize', onScrollOrResize)
})

const locales = {
  'zh-CN': {
    weekDays: ['日', '一', '二', '三', '四', '五', '六'],
    months: ['1月', '2月', '3月', '4月', '5月', '6月', '7月', '8月', '9月', '10月', '11月', '12月']
  },
  'en': {
    weekDays: ['Su', 'Mo', 'Tu', 'We', 'Th', 'Fr', 'Sa'],
    months: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec']
  }
}

const L = computed(() => locales[props.locale] || locales['zh-CN'])
const weekDays = computed(() => {
  const base = L.value.weekDays
  if (props.firstDayOfWeek === 0) return base
  return [...base.slice(props.firstDayOfWeek), ...base.slice(0, props.firstDayOfWeek)]
})
const monthNames = computed(() => L.value.months)
const monthLabel = computed(() => L.value.months[currentMonth.value])

const yearRange = computed(() => {
  const base = currentYear.value
  const years = []
  for (let y = base - 5; y <= base + 5; y++) years.push(y)
  return years
})

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
  return a.getFullYear() === b.getFullYear() &&
         a.getMonth() === b.getMonth() &&
         a.getDate() === b.getDate()
}

function isInRange(day, start, end) {
  if (!start || !end) return false
  const t = day.getTime()
  return t >= start.getTime() && t <= end.getTime()
}

const innerValue = ref(null)

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
    if (s && e) return `${r"${"}fmt(s)} ~ ${r"${"}fmt(e)}`
    if (s) return `${r"${"}fmt(s)} ~ …`
    return ''
  }
  if (props.mode === 'multiple') {
    const arr = innerValue.value || []
    if (arr.length === 0) return ''
    if (arr.length === 1) return fmt(arr[0])
    return `${r"${"}fmt(arr[0])} 等 ${r"${"}arr.length} 天`
  }
  return innerValue.value ? fmt(innerValue.value) : ''
})

function fmt(d) {
  if (!d) return ''
  const y = d.getFullYear()
  const m = String(d.getMonth() + 1).padStart(2, '0')
  const day = String(d.getDate()).padStart(2, '0')
  return props.format.replace('YYYY', y).replace('MM', m).replace('DD', day)
}

const weeks = computed(() => {
  const year = currentYear.value
  const month = currentMonth.value
  const firstDay = new Date(year, month, 1)
  const lastDay = new Date(year, month + 1, 0)

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
        disabled
      })

      cursor.setDate(cursor.getDate() + 1)
    }
    rows.push(week)
    if (cursor > lastDay && cursor.getDay() === (props.firstDayOfWeek % 7)) {
      done = true
    }
    if (rows.length >= 6) done = true
  }
  return rows
})

function isDaySelected(date) {
  const iv = innerValue.value
  if (props.mode === 'single') return sameDay(iv, date)
  if (props.mode === 'multiple') return (iv || []).some(d => sameDay(d, date))
  if (props.mode === 'range') {
    const [s, e] = iv || [null, null]
    return (s && sameDay(s, date)) || (e && sameDay(e, date))
  }
  return false
}

function isDayInRange(date) {
  if (props.mode !== 'range') return false
  const [s, e] = innerValue.value || [null, null]
  if (s && e) return isInRange(date, s, e) && !sameDay(date, s) && !sameDay(date, e)
  if (s && !e && hoverDate.value) return isInRange(date, s, hoverDate.value) && !sameDay(date, s)
  return false
}

// 动态赋予 TADA 设计规范中的对应类名
function getDayBtnClass(day) {
  if (isDaySelected(day.date)) {
    return '${namespace}-btn--primary'
  }
  return '${namespace}-btn--default'
}

// 辅助样式控制行内透明度与间距
function getDayCustomStyle(day) {
  const isSel = isDaySelected(day.date)
  const inRange = isDayInRange(day.date)
  let style = 'padding: 0; width: 100%; height: 32px; border-radius: var(--${namespace}-radius-sm); position: relative;'

  if (!day.isCurrentMonth && !isSel) {
    style += ' opacity: 0.35;'
  }
  if (inRange) {
    style += ' background: var(--${namespace}-primary-bg); color: var(--${namespace}-primary-dark); border-color: var(--${namespace}-primary-border);'
  }
  if (day.isToday && !isSel) {
    style += ' border-color: var(--${namespace}-primary); color: var(--${namespace}-primary-dark);'
  }
  return style
}

function toggleOpen() {
  if (props.disabled) return
  open.value = !open.value
  if (open.value) {
    showMonthPicker.value = false
    showYearPicker.value = false
    syncCalendarToValue()
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
  let target = props.mode === 'range' ? (iv?.[0] || iv?.[1]) : (props.mode === 'multiple' ? iv?.[0] : iv)
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
  } else if (props.mode === 'range') {
    const [s, e] = innerValue.value || [null, null]
    if (!s || (s && e)) {
      innerValue.value = [new Date(day.date), null]
      hoverDate.value = null
      emit('update:modelValue', [innerValue.value[0], null])
    } else {
      let end = new Date(day.date)
      innerValue.value = end < s ? [end, new Date(s)] : [new Date(s), end]
      hoverDate.value = null
      emit('update:modelValue', [...innerValue.value])
      emit('change', [...innerValue.value])
      close()
    }
  } else if (props.mode === 'multiple') {
    const arr = [...(innerValue.value || [])]
    const idx = arr.findIndex(d => sameDay(d, day.date))
    if (idx >= 0) arr.splice(idx, 1)
    else arr.push(new Date(day.date))
    innerValue.value = arr
    emit('update:modelValue', arr.map(d => new Date(d)))
    emit('change', arr.map(d => new Date(d)))
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
</script>