<template>
  <div class="ck-root" ref="rootRef">
    <!-- ── Trigger / Input ─────────────────────── -->
    <div
      class="ck-trigger"
      :class="{
        'ck-trigger--focus': open,
        'ck-trigger--error': error,
        'ck-trigger--disabled': disabled,
      }"
      @click="toggleOpen"
      tabindex="0"
      @keydown.enter="toggleOpen"
      @keydown.space.prevent="toggleOpen"
    >
      <span class="ck-trigger-icon">🕐</span>
      <span v-if="hasValue" class="ck-trigger-value">
        {{ displayValue }}
      </span>
      <span v-else class="ck-trigger-placeholder">
        {{ placeholder }}
      </span>
      <button
        v-if="hasValue && clearable && !disabled"
        class="ck-trigger-clear"
        @click.stop="clearValue"
        title="清除"
      >✕</button>
      <span class="ck-trigger-chevron" :class="{ 'ck-trigger-chevron--open': open }">▾</span>
    </div>

    <!-- ── Dropdown Panel ───────────────────────── -->
    <Transition name="ck-panel">
      <div v-if="open" class="ck-panel" :style="panelStyle" @click.stop>
        <!-- Header -->
        <div class="ck-panel__header">
          <span class="ck-panel__header-label">选择时间</span>
          <div class="ck-panel__header-time">
            <button
              class="ck-panel__header-num"
              :class="{ 'ck-panel__header-num--active': mode === 'hour' }"
              @click="switchMode('hour')"
            >{{ pad(displayHour) }}</button>
            <span class="ck-panel__header-colon">:</span>
            <button
              class="ck-panel__header-num"
              :class="{ 'ck-panel__header-num--active': mode === 'minute' }"
              @click="switchMode('minute')"
            >{{ pad(displayMinute) }}</button>
            <div class="ck-panel__header-ampm">
              <button
                class="ck-ampm-btn"
                :class="{ 'ck-ampm-btn--active': isAM }"
                @click="setAMPM('AM')"
              >AM</button>
              <button
                class="ck-ampm-btn"
                :class="{ 'ck-ampm-btn--active': !isAM }"
                @click="setAMPM('PM')"
              >PM</button>
            </div>
          </div>
        </div>

        <!-- ── Clock face ─────────────────────────── -->
        <div class="ck-panel__body">
          <div
            class="ck-clock"
            ref="clockRef"
            @pointerdown="onPointerDown"
            @pointermove="onPointerMove"
            @pointerup="onPointerUp"
            @pointerleave="onPointerUp"
          >
            <!-- Outer ring -->
            <svg class="ck-clock__svg" viewBox="-120 -120 240 240">
              <!-- Tick marks (60 small ticks) -->
              <line
                v-for="m in 60"
                :key="'tick-'+m"
                :x1="tickX1(m)"
                :y1="tickY1(m)"
                :x2="tickX2(m)"
                :y2="tickY2(m)"
                class="ck-tick"
                :class="{ 'ck-tick--major': m % 5 === 0 }"
              />

              <!-- Number labels (12 markers) -->
              <text
                v-for="n in 12"
                :key="'label-'+n"
                :x="numberX(n)"
                :y="numberY(n)"
                class="ck-number"
                :class="{ 'ck-number--active': isNumberActive(n) }"
                text-anchor="middle"
                dominant-baseline="central"
              >{{ numberLabel(n) }}</text>

              <!-- Hand line -->
              <line
                v-if="hasSelection"
                x1="0" y1="0"
                :x2="handX"
                :y2="handY"
                class="ck-hand"
              />

              <!-- Center dot -->
              <circle cx="0" cy="0" r="6" class="ck-center" />
            </svg>

            <!-- Invisible click ring for easier touch targets -->
            <div class="ck-clock__ring"></div>
          </div>
        </div>

        <!-- ── Footer ────────────────────────────── -->
        <div class="ck-panel__footer">
          <button class="ck-panel__footer-btn ck-panel__footer-btn--now" @click="selectNow">
            此刻
          </button>
          <div class="ck-panel__footer-right">
            <button
              v-if="hasValue && clearable"
              class="ck-panel__footer-btn ck-panel__footer-btn--clear"
              @click="clearValue"
            >
              清除
            </button>
            <button class="ck-panel__footer-btn ck-panel__footer-btn--ok" @click="confirm">
              确定
            </button>
          </div>
        </div>
      </div>
    </Transition>

    <!-- ── Overlay (click to close) ──────────────── -->
    <Transition name="ck-overlay">
      <div v-if="open" class="ck-overlay" @click="close"></div>
    </Transition>
  </div>
</template>

<script setup>
import { ref, computed, watch, onMounted, onUnmounted, nextTick } from 'vue'

/* ───────────────────────────────────────────────
   Props
   ─────────────────────────────────────────────── */

const props = defineProps({
  modelValue: { type: [Date, String, Number], default: null },
  placeholder: { type: String, default: '选择时间' },
  format: { type: String, default: 'HH:mm' },
  clearable: { type: Boolean, default: true },
  disabled: { type: Boolean, default: false },
  error: { type: Boolean, default: false },
})

const emit = defineEmits(['update:modelValue', 'change', 'focus', 'blur'])

/* ───────────────────────────────────────────────
   State
   ─────────────────────────────────────────────── */

const open = ref(false)
const rootRef = ref(null)
const clockRef = ref(null)
const mode = ref('hour')       // 'hour' | 'minute'
const selectedHour = ref(null)  // 0-23
const selectedMinute = ref(null) // 0-59
const isDragging = ref(false)
const panelStyle = ref({})

/* ───────────────────────────────────────────────
   Derived
   ─────────────────────────────────────────────── */

const isAM = computed(() => (selectedHour.value ?? 0) < 12)
const displayHour = computed(() => {
  const h = selectedHour.value ?? 0
  const h12 = h % 12
  return h12 === 0 ? 12 : h12
})
const displayMinute = computed(() => selectedMinute.value ?? 0)

const hasValue = computed(() => selectedHour.value !== null && selectedMinute.value !== null)

const displayValue = computed(() => {
  if (!hasValue.value) return ''
  return formatTime(selectedHour.value, selectedMinute.value)
})

const hasSelection = computed(() => {
  if (mode.value === 'hour') return selectedHour.value !== null
  return selectedMinute.value !== null
})

const handAngle = computed(() => {
  if (mode.value === 'hour') {
    if (selectedHour.value === null) return 0
    return ((selectedHour.value % 12) / 12) * 360
  }
  if (selectedMinute.value === null) return 0
  return (selectedMinute.value / 60) * 360
})

const handX = computed(() => {
  const rad = (handAngle.value - 90) * Math.PI / 180
  return Math.cos(rad) * 68
})

const handY = computed(() => {
  const rad = (handAngle.value - 90) * Math.PI / 180
  return Math.sin(rad) * 68
})

/* ───────────────────────────────────────────────
   Helpers
   ─────────────────────────────────────────────── */

function pad(n) {
  if (n == null) return '--'
  return String(n).padStart(2, '0')
}

function formatTime(h, m) {
  return props.format
    .replace('HH', String(h).padStart(2, '0'))
    .replace('mm', String(m).padStart(2, '0'))
}

function parseTime(v) {
  if (v instanceof Date && !isNaN(v.getTime())) {
    return { h: v.getHours(), m: v.getMinutes() }
  }
  if (typeof v === 'string' && v) {
    const parts = v.split(':')
    return { h: parseInt(parts[0], 10), m: parseInt(parts[1], 10) }
  }
  if (typeof v === 'number' && !isNaN(v)) {
    const d = new Date(v)
    return { h: d.getHours(), m: d.getMinutes() }
  }
  return null
}

/* ───────────────────────────────────────────────
   Sync from external
   ─────────────────────────────────────────────── */

function syncFromExternal(v) {
  const parsed = parseTime(v)
  if (parsed && !isNaN(parsed.h) && !isNaN(parsed.m)) {
    selectedHour.value = parsed.h
    selectedMinute.value = parsed.m
  } else {
    selectedHour.value = null
    selectedMinute.value = null
  }
}

watch(() => props.modelValue, syncFromExternal, { immediate: true })

/* ───────────────────────────────────────────────
   Tick & number geometry
   ─────────────────────────────────────────────── */

function tickX1(m) {
  const angle = (m / 60) * 2 * Math.PI - Math.PI / 2
  return Math.cos(angle) * 90
}
function tickY1(m) {
  const angle = (m / 60) * 2 * Math.PI - Math.PI / 2
  return Math.sin(angle) * 90
}
function tickX2(m) {
  const angle = (m / 60) * 2 * Math.PI - Math.PI / 2
  const r = m % 5 === 0 ? 82 : 86
  return Math.cos(angle) * r
}
function tickY2(m) {
  const angle = (m / 60) * 2 * Math.PI - Math.PI / 2
  const r = m % 5 === 0 ? 82 : 86
  return Math.sin(angle) * r
}

function numberX(n) {
  // n: 1-12, where 1=top(12 o'clock), clockwise
  const angle = ((n % 12) / 12) * 2 * Math.PI - Math.PI / 2
  return Math.cos(angle) * 70
}
function numberY(n) {
  const angle = ((n % 12) / 12) * 2 * Math.PI - Math.PI / 2
  return Math.sin(angle) * 70
}

function numberLabel(n) {
  if (mode.value === 'hour') {
    // 12, 1, 2, ..., 11
    return n === 12 ? '12' : String(n)
  }
  // minute mode: 00, 05, 10, ..., 55
  return String(((n % 12) * 5)).padStart(2, '0')
}

function isNumberActive(n) {
  if (mode.value === 'hour') {
    const h12 = selectedHour.value !== null ? (selectedHour.value % 12) : null
    const expected = n === 12 ? 0 : n
    return h12 === expected
  }
  // minute mode
  if (selectedMinute.value === null) return false
  const slot = Math.floor(selectedMinute.value / 5)
  return slot === (n % 12)
}

/* ───────────────────────────────────────────────
   Angle from pointer event
   ─────────────────────────────────────────────── */

function angleFromPointer(e) {
  if (!clockRef.value) return null
  const rect = clockRef.value.getBoundingClientRect()
  const cx = rect.left + rect.width / 2
  const cy = rect.top + rect.height / 2
  const x = e.clientX - cx
  const y = e.clientY - cy
  // atan2 gives angle from positive X axis. We want from 12 o'clock, clockwise.
  let deg = Math.atan2(y, x) * 180 / Math.PI + 90
  if (deg < 0) deg += 360
  return deg
}

function angleToValue(deg) {
  if (mode.value === 'hour') {
    // 12 positions, each 30°. 0° = 12 o'clock.
    let slot = Math.round(deg / 30) % 12
    // slot 0 = 12 o'clock = hour 12 or 0
    return slot === 0 ? 0 : slot  // 0 = 12 o'clock → internal 0
  }
  // minute mode: 60 positions, each 6°
  return Math.round(deg / 6) % 60
}

/* ───────────────────────────────────────────────
   Pointer interaction
   ─────────────────────────────────────────────── */

function onPointerDown(e) {
  isDragging.value = true
  clockRef.value?.setPointerCapture?.(e.pointerId)
  updateFromPointer(e)
}

function onPointerMove(e) {
  if (!isDragging.value) return
  updateFromPointer(e)
}

function onPointerUp() {
  isDragging.value = false
  // Auto-advance from hour → minute
  if (mode.value === 'hour' && selectedHour.value !== null) {
    mode.value = 'minute'
  } else if (mode.value === 'minute' && selectedMinute.value !== null && hasValue.value) {
    // Don't auto-close; user can still adjust or click OK
  }
}

function updateFromPointer(e) {
  const deg = angleFromPointer(e)
  if (deg === null) return
  const val = angleToValue(deg)
  if (mode.value === 'hour') {
    // val is 0-11 (0 = top/12 o'clock)
    const h24 = isAM.value ? (val === 0 ? 0 : val) : (val === 0 ? 12 : val + 12)
    selectedHour.value = h24
  } else {
    selectedMinute.value = val
  }
  commitValue()
}

/* ───────────────────────────────────────────────
   Mode & AM/PM
   ─────────────────────────────────────────────── */

function switchMode(m) {
  mode.value = m
}

function setAMPM(ampm) {
  if (selectedHour.value === null) return
  if (ampm === 'AM' && selectedHour.value >= 12) {
    selectedHour.value = selectedHour.value - 12
  } else if (ampm === 'PM' && selectedHour.value < 12) {
    selectedHour.value = selectedHour.value + 12
  }
  commitValue()
}

function selectNow() {
  const now = new Date()
  selectedHour.value = now.getHours()
  selectedMinute.value = now.getMinutes()
  commitValue()
  close()
}

function clearValue() {
  selectedHour.value = null
  selectedMinute.value = null
  mode.value = 'hour'
  emit('update:modelValue', '')
  emit('change', '')
}

function confirm() {
  commitValue()
  close()
}

function commitValue() {
  if (!hasValue.value) return
  const formatted = formatTime(selectedHour.value, selectedMinute.value)
  emit('update:modelValue', formatted)
  emit('change', formatted)
}

/* ───────────────────────────────────────────────
   Open / close
   ─────────────────────────────────────────────── */

function toggleOpen() {
  if (props.disabled) return
  open.value = !open.value
  if (open.value) {
    mode.value = 'hour'
    nextTick(() => updatePanelPosition())
    emit('focus')
  } else {
    emit('blur')
  }
}

function close() {
  open.value = false
  emit('blur')
}

/* ───────────────────────────────────────────────
   Smart Panel Positioning (same pattern as datepicker)
   ─────────────────────────────────────────────── */

const PANEL_GAP = 6
const PANEL_WIDTH = 300

function updatePanelPosition() {
  if (!open.value) return
  const trigger = rootRef.value?.querySelector('.ck-trigger')
  if (!trigger) return

  const triggerRect = trigger.getBoundingClientRect()
  const vw = window.innerWidth
  const vh = window.innerHeight

  const panelEl = rootRef.value?.querySelector('.ck-panel')
  const panelHeight = panelEl ? panelEl.offsetHeight : 420
  const estimatedHeight = panelHeight > 100 ? panelHeight : 420

  const spaceBelow = vh - triggerRect.bottom - PANEL_GAP
  const spaceAbove = triggerRect.top - PANEL_GAP

  let top, originY
  if (spaceBelow >= estimatedHeight || spaceBelow >= spaceAbove) {
    top = triggerRect.bottom + PANEL_GAP
    originY = 'top'
  } else {
    top = triggerRect.top - estimatedHeight - PANEL_GAP
    if (top < 0) top = PANEL_GAP
    originY = 'bottom'
  }

  let left = triggerRect.left
  if (left + PANEL_WIDTH > vw - 8) {
    left = triggerRect.right - PANEL_WIDTH
  }
  if (left < 8) left = 8

  panelStyle.value = {
    position: 'fixed',
    top: top + 'px',
    left: left + 'px',
  }

  if (panelEl) {
    panelEl.style.transformOrigin = ${r"`center ${originY}`"}
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
   CLOCKPICKER — Academy Pro · Analog Clock Face
   ═══════════════════════════════════════════════════════════════════════════ */

.ck-root {
  position: relative;
  display: inline-block;
  width: 100%;
}

/* ── Trigger ──────────────────────────────────── */

.ck-trigger {
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

.ck-trigger:hover { border-color: var(--color-teal); }

.ck-trigger--focus {
  border-color: var(--color-teal);
  box-shadow: 0 0 0 3px var(--color-teal-dim);
}

.ck-trigger--error {
  border-color: var(--color-red);
  box-shadow: 0 0 0 3px var(--color-red-dim);
}

.ck-trigger--disabled {
  opacity: 0.5;
  cursor: not-allowed;
  background: var(--color-surface);
}

.ck-trigger-icon { font-size: var(--text-lg); flex-shrink: 0; }

.ck-trigger-value {
  flex: 1;
  font-weight: var(--weight-medium);
  color: var(--color-text-main);
  font-variant-numeric: tabular-nums;
}

.ck-trigger-placeholder { flex: 1; color: var(--color-text-muted); }

.ck-trigger-clear {
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

.ck-trigger-clear:hover {
  color: var(--color-red);
  background: var(--color-red-dim);
}

.ck-trigger-chevron {
  color: var(--color-text-muted);
  font-size: var(--text-sm);
  transition: transform var(--transition-base);
}

.ck-trigger-chevron--open {
  transform: rotate(180deg);
  color: var(--color-teal);
}

/* ── Panel ────────────────────────────────────── */

.ck-panel {
  position: absolute;
  top: calc(100% + 6px);
  left: 0;
  z-index: 600;
  background: var(--color-card);
  border: 1px solid var(--color-border);
  border-radius: var(--radius-xl);
  box-shadow: var(--shadow-lg);
  width: 300px;
  overflow: hidden;
}

/* ── Panel Header ─────────────────────────────── */

.ck-panel__header {
  background: var(--color-navy);
  padding: var(--space-7) var(--space-9) var(--space-9);
  position: relative;
}

.ck-panel__header::after {
  content: '';
  position: absolute;
  bottom: 0;
  left: 0;
  right: 0;
  height: 1px;
  background: linear-gradient(90deg, transparent, var(--color-teal), transparent);
  opacity: 0.4;
}

.ck-panel__header-label {
  display: block;
  font-size: var(--text-xs);
  font-weight: var(--weight-semibold);
  color: rgba(255,255,255,0.4);
  text-transform: uppercase;
  letter-spacing: 1.5px;
  margin-bottom: var(--space-4);
}

.ck-panel__header-time {
  display: flex;
  align-items: center;
  gap: var(--space-2);
}

.ck-panel__header-num {
  border: none;
  background: none;
  font-family: inherit;
  font-size: 36px;
  font-weight: var(--weight-light);
  color: rgba(255,255,255,0.45);
  cursor: pointer;
  padding: 0 var(--space-1);
  border-radius: var(--radius-sm);
  transition: all var(--transition-fast);
  font-variant-numeric: tabular-nums;
  letter-spacing: 0.5px;
  line-height: 1;
}

.ck-panel__header-num:hover {
  color: rgba(255,255,255,0.7);
}

.ck-panel__header-num--active {
  color: #fff;
  font-weight: var(--weight-bold);
}

.ck-panel__header-colon {
  font-size: 36px;
  font-weight: var(--weight-light);
  color: rgba(255,255,255,0.45);
  line-height: 1;
  padding-bottom: 2px;
}

.ck-panel__header-ampm {
  display: flex;
  flex-direction: column;
  gap: 2px;
  margin-left: var(--space-6);
}

.ck-ampm-btn {
  border: 1px solid rgba(255,255,255,0.15);
  background: none;
  font-family: inherit;
  font-size: var(--text-xs);
  font-weight: var(--weight-semibold);
  color: rgba(255,255,255,0.45);
  cursor: pointer;
  padding: 2px var(--space-5);
  border-radius: var(--radius-xs);
  transition: all var(--transition-fast);
  letter-spacing: 0.5px;
}

.ck-ampm-btn:hover {
  color: rgba(255,255,255,0.7);
  border-color: rgba(255,255,255,0.25);
}

.ck-ampm-btn--active {
  background: var(--color-teal);
  border-color: var(--color-teal);
  color: #fff !important;
}

/* ── Panel Body ───────────────────────────────── */

.ck-panel__body {
  padding: var(--space-9);
  display: flex;
  justify-content: center;
  background: var(--color-card);
}

/* ── Clock Face ───────────────────────────────── */

.ck-clock {
  position: relative;
  width: 220px;
  height: 220px;
  border-radius: var(--radius-full);
  background: var(--color-surface);
  cursor: pointer;
  touch-action: none;
  user-select: none;
}

.ck-clock__svg {
  width: 100%;
  height: 100%;
  display: block;
}

/* Tick marks */
.ck-tick {
  stroke: var(--color-border);
  stroke-width: 1;
}

.ck-tick--major {
  stroke: var(--color-text-muted);
  stroke-width: 1.5;
}

/* Number labels */
.ck-number {
  font-size: 13px;
  font-family: var(--font-family-base);
  fill: var(--color-text-sub);
  font-weight: var(--weight-medium);
  pointer-events: none;
}

.ck-number--active {
  fill: #fff;
  font-weight: var(--weight-bold);
}

/* Hand */
.ck-hand {
  stroke: var(--color-teal);
  stroke-width: 2;
  stroke-linecap: round;
}

/* Center dot */
.ck-center {
  fill: var(--color-teal);
}

/* Invisible ring for touch targets */
.ck-clock__ring {
  position: absolute;
  inset: 0;
  border-radius: var(--radius-full);
  pointer-events: none;   /* SVG handles interaction */
}

/* ── Footer ───────────────────────────────────── */

.ck-panel__footer {
  padding: var(--space-6) var(--space-9);
  border-top: 1px solid var(--color-border);
  display: flex;
  align-items: center;
  justify-content: space-between;
  gap: var(--space-6);
}

.ck-panel__footer-btn {
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

.ck-panel__footer-btn:hover {
  background: var(--color-teal-dim);
  color: var(--color-teal);
}

.ck-panel__footer-btn--ok {
  background: var(--color-teal);
  color: #fff;
}

.ck-panel__footer-btn--ok:hover {
  background: var(--color-teal-hover);
  color: #fff;
}

.ck-panel__footer-btn--clear:hover {
  background: var(--color-red-dim);
  color: var(--color-red);
}

.ck-panel__footer-right {
  display: flex;
  align-items: center;
  gap: var(--space-6);
}

/* ── Overlay ──────────────────────────────────── */

.ck-overlay {
  position: fixed;
  inset: 0;
  z-index: 599;
  background: transparent;
}

/* ── Transitions ──────────────────────────────── */

.ck-panel-enter-active { animation: ckPanelIn var(--transition-smooth); }
.ck-panel-leave-active { animation: ckPanelOut 0.12s ease; }

@keyframes ckPanelIn {
  from { opacity: 0; transform: translateY(-6px) scale(0.97); }
  to   { opacity: 1; transform: translateY(0) scale(1); }
}

@keyframes ckPanelOut {
  from { opacity: 1; transform: translateY(0) scale(1); }
  to   { opacity: 0; transform: translateY(-6px) scale(0.97); }
}

.ck-overlay-enter-active { animation: fadeIn var(--transition-fast); }
.ck-overlay-leave-active { animation: fadeOut var(--transition-fast); }

@keyframes fadeIn  { from { opacity: 0; } to { opacity: 1; } }
@keyframes fadeOut { from { opacity: 1; } to { opacity: 0; } }
</style>
