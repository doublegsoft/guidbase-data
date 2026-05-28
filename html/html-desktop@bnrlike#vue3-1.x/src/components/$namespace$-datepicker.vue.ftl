<template>
  <div class="${namespace}-dp" :class="{ '${namespace}-dp--disabled': disabled }" ref="rootEl">
    <input
      class="${namespace}-dp-input"
      type="text"
      :value="displayValue"
      :placeholder="placeholder"
      :disabled="disabled"
      readonly
      @click="togglePanel"
      @keydown.escape="closePanel"
    />
    <button
      class="${namespace}-dp-trigger"
      type="button"
      :disabled="disabled"
      @click.stop="togglePanel"
      tabindex="-1"
    >&#x1F4C5;</button>

    <div v-if="open" class="${namespace}-dp-panel" @click.stop>
      <!-- Header: month / year navigation -->
      <div class="${namespace}-dp-header">
        <button class="${namespace}-dp-nav" type="button" @click="prevMonth">&lsaquo;</button>
        <span class="${namespace}-dp-header-label">{{ headerLabel }}</span>
        <button class="${namespace}-dp-nav" type="button" @click="nextMonth">&rsaquo;</button>
      </div>

      <!-- Weekday labels -->
      <div class="${namespace}-dp-weekdays">
        <span v-for="w in weekdays" :key="w" class="${namespace}-dp-weekday">{{ w }}</span>
      </div>

      <!-- Day grid -->
      <div class="${namespace}-dp-days">
        <button
          v-for="(d, i) in days"
          :key="i"
          class="${namespace}-dp-day"
          :class="dayClass(d)"
          :disabled="d.type === 'other'"
          type="button"
          @click="selectDay(d)"
        >{{ d.label }}</button>
      </div>

      <!-- Footer: today / clear -->
      <div class="${namespace}-dp-footer">
        <button class="${namespace}-dp-btn" type="button" @click="setToday">今天</button>
        <button class="${namespace}-dp-btn" type="button" @click="clearValue">清除</button>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, computed, watch, onMounted, onBeforeUnmount } from 'vue'

const props = defineProps({
  modelValue: { type: String, default: null },
  placeholder: { type: String, default: '请选择日期' },
  disabled: { type: Boolean, default: false },
})

const emit = defineEmits(['update:modelValue'])

const weekdays = ['日', '一', '二', '三', '四', '五', '六']

const rootEl = ref(null)
const open = ref(false)
const viewYear = ref(new Date().getFullYear())
const viewMonth = ref(new Date().getMonth() + 1) // 1-based

// Parse modelValue into { year, month, day } or null
function parseDate(v) {
  if (!v || typeof v !== 'string') return null
  const m = v.match(/^(\d{4})-(\d{2})-(\d{2})$/)
  if (!m) return null
  return { year: +m[1], month: +m[2], day: +m[3] }
}

function formatDate(y, m, d) {
  const mm = String(m).padStart(2, '0')
  const dd = String(d).padStart(2, '0')
  return `${r"${"}y${r"}"}-${r"${"}mm${r"}"}-${r"${"}dd${r"}"}`
}

// Today
function today() {
  const d = new Date()
  return { year: d.getFullYear(), month: d.getMonth() + 1, day: d.getDate() }
}

const selectedDate = ref(parseDate(props.modelValue))

const displayValue = computed(() => {
  if (selectedDate.value) {
    return formatDate(selectedDate.value.year, selectedDate.value.month, selectedDate.value.day)
  }
  return ''
})

const headerLabel = computed(() => `${r"${"}viewYear.value${r"}"}年 ${r"${"}viewMonth.value${r"}"}月`)

// Days in a month
function daysInMonth(y, m) {
  return new Date(y, m, 0).getDate()
}

// First day of week for a month (0=Sun)
function firstDayOfWeek(y, m) {
  return new Date(y, m - 1, 1).getDay()
}

const days = computed(() => {
  const y = viewYear.value
  const m = viewMonth.value
  const total = daysInMonth(y, m)
  const firstDow = firstDayOfWeek(y, m)
  const lastMonthTotal = daysInMonth(m === 1 ? y - 1 : y, m === 1 ? 12 : m - 1)

  const result = []

  // Previous month filler
  for (let i = firstDow - 1; i >= 0; i--) {
    result.push({ label: lastMonthTotal - i, type: 'other' })
  }

  // Current month
  for (let d = 1; d <= total; d++) {
    result.push({ label: d, type: 'current', year: y, month: m, day: d })
  }

  // Next month filler
  const remaining = 7 - (result.length % 7)
  if (remaining < 7) {
    for (let d = 1; d <= remaining; d++) {
      result.push({ label: d, type: 'other' })
    }
  }

  return result
})

function dayClass(d) {
  if (d.type === 'other') return '${namespace}-dp-day--other'

  const t = today()
  const isToday = d.year === t.year && d.month === t.month && d.day === t.day
  const isSelected = selectedDate.value &&
    d.year === selectedDate.value.year &&
    d.month === selectedDate.value.month &&
    d.day === selectedDate.value.day

  return {
    '${namespace}-dp-day--today': isToday,
    '${namespace}-dp-day--selected': isSelected,
  }
}

function selectDay(d) {
  if (d.type !== 'current') return
  const date = { year: d.year, month: d.month, day: d.day }
  selectedDate.value = date
  emit('update:modelValue', formatDate(date.year, date.month, date.day))
  closePanel()
}

function setToday() {
  const t = today()
  viewYear.value = t.year
  viewMonth.value = t.month
  selectedDate.value = t
  emit('update:modelValue', formatDate(t.year, t.month, t.day))
  closePanel()
}

function clearValue() {
  selectedDate.value = null
  emit('update:modelValue', null)
  closePanel()
}

function prevMonth() {
  if (viewMonth.value === 1) {
    viewYear.value--
    viewMonth.value = 12
  } else {
    viewMonth.value--
  }
}

function nextMonth() {
  if (viewMonth.value === 12) {
    viewYear.value++
    viewMonth.value = 1
  } else {
    viewMonth.value++
  }
}

function togglePanel() {
  if (props.disabled) return
  open.value = !open.value
  if (open.value) {
    syncViewToSelected()
  }
}

function closePanel() {
  open.value = false
}

function syncViewToSelected() {
  const d = selectedDate.value || today()
  viewYear.value = d.year
  viewMonth.value = d.month
}

// Click outside to close
function onDocClick(e) {
  if (rootEl.value && !rootEl.value.contains(e.target)) {
    closePanel()
  }
}

// Keep view synced with external modelValue changes
watch(() => props.modelValue, (v) => {
  const parsed = parseDate(v)
  selectedDate.value = parsed
  if (parsed) {
    viewYear.value = parsed.year
    viewMonth.value = parsed.month
  }
})

onMounted(() => {
  document.addEventListener('click', onDocClick, true)
})

onBeforeUnmount(() => {
  document.removeEventListener('click', onDocClick, true)
})
</script>

<style scoped>
.${namespace}-dp {
  position: relative;
  display: inline-flex;
  align-items: center;
  width: 100%;
  min-width: 0;
}

/* ── Input ── */
.${namespace}-dp-input {
  flex: 1;
  height: 22px;
  border: 1px solid var(--${namespace}-border);
  font-size: 12px;
  font-family: var(--${namespace}-font);
  padding: 0 22px 0 5px;
  background: var(--${namespace}-bg);
  color: var(--${namespace}-text);
  outline: none;
  min-width: 0;
  cursor: pointer;
  border-radius: var(--${namespace}-radius-sm);
}
.${namespace}-dp-input:focus {
  border-color: var(--${namespace}-primary);
  box-shadow: 0 0 0 2px rgba(26,79,138,.08);
}
.${namespace}-dp-input::placeholder {
  color: var(--${namespace}-text-light);
}
.${namespace}-dp-input:disabled {
  background: #f5f7fa;
  color: var(--${namespace}-text-disabled);
  cursor: not-allowed;
}

/* ── Trigger icon ── */
.${namespace}-dp-trigger {
  position: absolute;
  right: 0;
  top: 0;
  width: 22px;
  height: 22px;
  display: flex;
  align-items: center;
  justify-content: center;
  cursor: pointer;
  color: var(--${namespace}-text-muted);
  font-size: 13px;
  border: none;
  background: none;
  padding: 0;
  line-height: 1;
}
.${namespace}-dp-trigger:hover {
  color: var(--${namespace}-primary);
}
.${namespace}-dp-trigger:disabled,
.${namespace}-dp--disabled .${namespace}-dp-trigger {
  cursor: not-allowed;
  color: var(--${namespace}-text-disabled);
}

/* ── Dropdown panel ── */
.${namespace}-dp-panel {
  position: absolute;
  top: 100%;
  left: 0;
  z-index: 1000;
  margin-top: 2px;
  background: var(--${namespace}-bg);
  border: 1px solid var(--${namespace}-border);
  border-radius: var(--${namespace}-radius-md);
  box-shadow: 0 4px 12px rgba(0,0,0,.12);
  padding: 6px 8px 8px;
  width: 230px;
  user-select: none;
}

/* ── Header (month/year + nav) ── */
.${namespace}-dp-header {
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding-bottom: 6px;
  margin-bottom: 4px;
  border-bottom: 1px solid var(--${namespace}-border-light);
}

.${namespace}-dp-header-label {
  font-size: 13px;
  font-weight: bold;
  color: var(--${namespace}-text);
  cursor: default;
  min-width: 90px;
  text-align: center;
}

.${namespace}-dp-nav {
  width: 22px;
  height: 22px;
  display: flex;
  align-items: center;
  justify-content: center;
  cursor: pointer;
  border: none;
  background: none;
  border-radius: var(--${namespace}-radius-sm);
  font-size: 12px;
  color: var(--${namespace}-text-muted);
  padding: 0;
  line-height: 1;
}
.${namespace}-dp-nav:hover {
  background: var(--${namespace}-primary-bg);
  color: var(--${namespace}-primary);
}

/* ── Weekday row ── */
.${namespace}-dp-weekdays {
  display: grid;
  grid-template-columns: repeat(7, 1fr);
  text-align: center;
  margin-bottom: 2px;
}

.${namespace}-dp-weekday {
  font-size: 11px;
  color: var(--${namespace}-text-light);
  padding: 3px 0;
  font-weight: bold;
}

/* ── Day grid ── */
.${namespace}-dp-days {
  display: grid;
  grid-template-columns: repeat(7, 1fr);
  gap: 1px;
}

.${namespace}-dp-day {
  display: flex;
  align-items: center;
  justify-content: center;
  height: 26px;
  font-size: 12px;
  cursor: pointer;
  border-radius: var(--${namespace}-radius-sm);
  color: var(--${namespace}-text);
  border: none;
  background: none;
  font-family: var(--${namespace}-font);
  padding: 0;
}
.${namespace}-dp-day:hover {
  background: var(--${namespace}-primary-bg);
  color: var(--${namespace}-primary);
}

/* Other-month filler */
.${namespace}-dp-day--other {
  color: var(--${namespace}-text-disabled);
  cursor: default;
}
.${namespace}-dp-day--other:hover {
  background: none;
  color: var(--${namespace}-text-disabled);
}

/* Today */
.${namespace}-dp-day--today {
  font-weight: bold;
  color: var(--${namespace}-primary);
  border: 1px solid var(--${namespace}-primary);
}

/* Selected */
.${namespace}-dp-day--selected {
  background: var(--${namespace}-primary) !important;
  color: #fff !important;
  font-weight: bold;
}

/* ── Footer (today + clear) ── */
.${namespace}-dp-footer {
  display: flex;
  justify-content: space-between;
  margin-top: 6px;
  padding-top: 6px;
  border-top: 1px solid var(--${namespace}-border-light);
  gap: 4px;
}

.${namespace}-dp-btn {
  height: 20px;
  padding: 0 8px;
  font-size: 11px;
  font-family: var(--${namespace}-font);
  border: 1px solid var(--${namespace}-border);
  border-radius: var(--${namespace}-radius-sm);
  cursor: pointer;
  background: var(--${namespace}-bg);
  color: #333;
  display: inline-flex;
  align-items: center;
}
.${namespace}-dp-btn:hover {
  background: var(--${namespace}-primary-bg);
  color: var(--${namespace}-primary);
  border-color: var(--${namespace}-primary-border);
}

</style>