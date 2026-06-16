<template>
  <div class="tp-root" ref="rootRef">
    <!-- ── Trigger / Input ─────────────────────── -->
    <div
      class="tp-trigger"
      :class="{
        'tp-trigger--focus': open,
        'tp-trigger--error': error,
        'tp-trigger--disabled': disabled,
      }"
      @click="toggleOpen"
      tabindex="0"
      @keydown.enter="toggleOpen"
      @keydown.space.prevent="toggleOpen"
    >
      <span v-if="hasValue" class="tp-trigger-value">
        {{ displayValue }}
      </span>
      <span v-else class="tp-trigger-placeholder">
        {{ placeholder }}
      </span>
      <button
        v-if="hasValue && clearable && !disabled"
        class="tp-trigger-clear"
        @click.stop="clearValue"
        title="清除"
      >✕</button>
      <span class="tp-trigger-chevron" :class="{ 'tp-trigger-chevron--open': open }">▾</span>
    </div>

    <!-- ── Dropdown Panel ───────────────────────── -->
    <Transition name="tp-panel">
      <div v-if="open" class="tp-panel" :style="panelStyle" @click.stop>
        <!-- Header: current selection preview -->
        <div class="tp-panel__header">
          <span class="tp-panel__header-label">选择时间</span>
          <span class="tp-panel__header-value">{{ hasValue ? displayValue : '--:--' }}</span>
        </div>

        <!-- Time columns -->
        <div class="tp-panel__body">
          <!-- Hours column -->
          <div class="tp-col">
            <div class="tp-col__label">时</div>
            <div class="tp-col__list" ref="hourListRef">
              <button
                v-for="h in hourOptions"
                :key="h.value"
                class="tp-col__item"
                :class="{ 'tp-col__item--active': h.value === selectedHour }"
                @click="selectHour(h.value)"
              >{{ h.label }}</button>
            </div>
          </div>

          <!-- Minutes column -->
          <div class="tp-col">
            <div class="tp-col__label">分</div>
            <div class="tp-col__list" ref="minuteListRef">
              <button
                v-for="m in minuteOptions"
                :key="m.value"
                class="tp-col__item"
                :class="{ 'tp-col__item--active': m.value === selectedMinute }"
                @click="selectMinute(m.value)"
              >{{ m.label }}</button>
            </div>
          </div>

          <!-- Seconds column (only when format includes seconds) -->
          <div v-if="showSeconds" class="tp-col">
            <div class="tp-col__label">秒</div>
            <div class="tp-col__list" ref="secondListRef">
              <button
                v-for="s in secondOptions"
                :key="s.value"
                class="tp-col__item"
                :class="{ 'tp-col__item--active': s.value === selectedSecond }"
                @click="selectSecond(s.value)"
              >{{ s.label }}</button>
            </div>
          </div>
        </div>

        <!-- ── Footer ────────────────────────────── -->
        <div class="tp-panel__footer">
          <button class="tp-panel__footer-btn tp-panel__footer-btn--now" @click="selectNow">
            此刻
          </button>
          <div class="tp-panel__footer-right">
            <button
              v-if="hasValue && clearable"
              class="tp-panel__footer-btn tp-panel__footer-btn--clear"
              @click="clearValue"
            >
              清除
            </button>
          </div>
        </div>
      </div>
    </Transition>

    <!-- ── Overlay (click to close) ──────────────── -->
    <Transition name="tp-overlay">
      <div v-if="open" class="tp-overlay" @click="close"></div>
    </Transition>
  </div>
</template>

<script setup>
import { ref, computed, watch, onMounted, onUnmounted, nextTick } from 'vue'

/* ───────────────────────────────────────────────
   Props
   ─────────────────────────────────────────────── */

const props = defineProps({
  /** v-model: time string or Date */
  modelValue: { type: [Date, String, Number], default: null },

  /** Placeholder text */
  placeholder: { type: String, default: '选择时间' },

  /** Display format */
  format: { type: String, default: 'HH:mm' },

  /** Minute step (e.g. 5 → 00, 05, 10, …) */
  minuteStep: { type: Number, default: 1 },

  /** Second step */
  secondStep: { type: Number, default: 1 },

  /** Hour range: [min, max] (inclusive) */
  hourRange: { type: Array, default: () => [0, 23] },

  /** Show clear button */
  clearable: { type: Boolean, default: true },

  /** Disabled state */
  disabled: { type: Boolean, default: false },

  /** Error state */
  error: { type: Boolean, default: false },
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
const hourListRef = ref(null)
const minuteListRef = ref(null)
const secondListRef = ref(null)
const selectedHour = ref(null)
const selectedMinute = ref(null)
const selectedSecond = ref(null)
const panelStyle = ref({})

/* ───────────────────────────────────────────────
   Derive display format detection
   ─────────────────────────────────────────────── */

const showSeconds = computed(() => props.format.includes('ss'))

/* ───────────────────────────────────────────────
   Options generators
   ─────────────────────────────────────────────── */

const hourOptions = computed(() => {
  const [min, max] = props.hourRange
  const opts = []
  for (let h = min; h <= max; h++) {
    opts.push({ value: h, label: String(h).padStart(2, '0') })
  }
  return opts
})

const minuteOptions = computed(() => {
  const opts = []
  for (let m = 0; m < 60; m += props.minuteStep) {
    opts.push({ value: m, label: String(m).padStart(2, '0') })
  }
  return opts
})

const secondOptions = computed(() => {
  const opts = []
  for (let s = 0; s < 60; s += props.secondStep) {
    opts.push({ value: s, label: String(s).padStart(2, '0') })
  }
  return opts
})

/* ───────────────────────────────────────────────
   Parse / format helpers
   ─────────────────────────────────────────────── */

function parseTime(v) {
  if (v instanceof Date && !isNaN(v.getTime())) {
    return { h: v.getHours(), m: v.getMinutes(), s: v.getSeconds() }
  }
  if (typeof v === 'string' && v) {
    // Support HH:mm, HH:mm:ss
    const parts = v.split(':')
    return {
      h: parseInt(parts[0], 10),
      m: parseInt(parts[1], 10),
      s: parts.length > 2 ? parseInt(parts[2], 10) : 0,
    }
  }
  if (typeof v === 'number' && !isNaN(v)) {
    const d = new Date(v)
    return { h: d.getHours(), m: d.getMinutes(), s: d.getSeconds() }
  }
  return null
}

function formatTime(h, m, s) {
  let result = props.format
    .replace('HH', String(h).padStart(2, '0'))
    .replace('mm', String(m).padStart(2, '0'))
    .replace('ss', String(s ?? 0).padStart(2, '0'))
  return result
}

function isValidNum(n) {
  return typeof n === 'number' && !isNaN(n) && isFinite(n)
}

/* ───────────────────────────────────────────────
   Internal model + computed display
   ─────────────────────────────────────────────── */

function syncFromExternal(v) {
  const parsed = parseTime(v)
  if (parsed && isValidNum(parsed.h) && isValidNum(parsed.m)) {
    selectedHour.value = parsed.h
    selectedMinute.value = parsed.m
    selectedSecond.value = showSeconds.value ? (parsed.s ?? 0) : 0
  } else {
    selectedHour.value = null
    selectedMinute.value = null
    selectedSecond.value = showSeconds.value ? 0 : null
  }
}

watch(() => props.modelValue, syncFromExternal, { immediate: true })

const hasValue = computed(() => isValidNum(selectedHour.value) && isValidNum(selectedMinute.value))

const displayValue = computed(() => {
  if (!hasValue.value) return ''
  return formatTime(selectedHour.value, selectedMinute.value, selectedSecond.value)
})

/* ───────────────────────────────────────────────
   Selection actions
   ─────────────────────────────────────────────── */

function selectHour(h) {
  selectedHour.value = h
  // Auto-set minute/second to 0 if none selected
  if (!isValidNum(selectedMinute.value)) selectedMinute.value = 0
  if (showSeconds.value && !isValidNum(selectedSecond.value)) selectedSecond.value = 0
  commitValue()
}

function selectMinute(m) {
  selectedMinute.value = m
  if (!isValidNum(selectedHour.value)) selectedHour.value = 0
  if (showSeconds.value && !isValidNum(selectedSecond.value)) selectedSecond.value = 0
  commitValue()
}

function selectSecond(s) {
  selectedSecond.value = s
  if (!isValidNum(selectedHour.value)) selectedHour.value = 0
  if (!isValidNum(selectedMinute.value)) selectedMinute.value = 0
  commitValue()
}

function selectNow() {
  const now = new Date()
  selectedHour.value = now.getHours()
  selectedMinute.value = now.getMinutes()
  selectedSecond.value = now.getSeconds()
  commitValue()
  close()
}

function clearValue() {
  selectedHour.value = null
  selectedMinute.value = null
  selectedSecond.value = showSeconds.value ? 0 : null
  emit('update:modelValue', '')
  emit('change', '')
}

function commitValue() {
  if (!hasValue.value) return
  const formatted = formatTime(selectedHour.value, selectedMinute.value, selectedSecond.value)
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
    nextTick(() => {
      updatePanelPosition()
      scrollToSelected()
    })
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
   Scroll selected item into view
   ─────────────────────────────────────────────── */

function scrollToSelected() {
  nextTick(() => {
    scrollColumnToSelected(hourListRef.value, selectedHour.value, hourOptions.value)
    scrollColumnToSelected(minuteListRef.value, selectedMinute.value, minuteOptions.value)
    if (showSeconds.value) {
      scrollColumnToSelected(secondListRef.value, selectedSecond.value, secondOptions.value)
    }
  })
}

function scrollColumnToSelected(listEl, selectedVal, options) {
  if (!listEl || !isValidNum(selectedVal)) return
  const idx = options.findIndex(o => o.value === selectedVal)
  if (idx < 0) return
  const itemHeight = 36  // approximate height of each item in px
  const scrollTarget = idx * itemHeight - listEl.clientHeight / 2 + itemHeight / 2
  listEl.scrollTo({ top: Math.max(0, scrollTarget), behavior: 'smooth' })
}

/* ───────────────────────────────────────────────
   Smart Panel Positioning
   Uses position:fixed & auto-flips when space
   is insufficient — never expands page height.
   (Same pattern as ef-datepicker)
   ─────────────────────────────────────────────── */

const PANEL_GAP = 6
const PANEL_WIDTH = 240   // ~3 columns × 80px; wider if seconds shown

function getPanelWidth() {
  return showSeconds.value ? 280 : 220
}

function updatePanelPosition() {
  if (!open.value) return
  const trigger = rootRef.value?.querySelector('.tp-trigger')
  if (!trigger) return

  const triggerRect = trigger.getBoundingClientRect()
  const vw = window.innerWidth
  const vh = window.innerHeight

  const panelEl = rootRef.value?.querySelector('.tp-panel')
  const panelHeight = panelEl ? panelEl.offsetHeight : 320
  const estimatedHeight = panelHeight > 100 ? panelHeight : 320
  const panelW = getPanelWidth()

  // ── Vertical: prefer below, flip above if insufficient ──
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

  // ── Horizontal: align-left by default, flip if overflow ──
  let left = triggerRect.left
  if (left + panelW > vw - 8) {
    left = triggerRect.right - panelW
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
   TIMEPICKER — Academy Pro Style
   ═══════════════════════════════════════════════════════════════════════════ */

.tp-root {
  position: relative;
  display: inline-block;
  width: 100%;
}

/* ── Trigger ──────────────────────────────────── */

.tp-trigger {
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

.tp-trigger:hover {
  border-color: var(--color-teal);
}

.tp-trigger--focus {
  border-color: var(--color-teal);
  box-shadow: 0 0 0 3px var(--color-teal-dim);
}

.tp-trigger--error {
  border-color: var(--color-red);
  box-shadow: 0 0 0 3px var(--color-red-dim);
}

.tp-trigger--disabled {
  opacity: 0.5;
  cursor: not-allowed;
  background: var(--color-surface);
}

.tp-trigger-value {
  flex: 1;
  font-weight: var(--weight-medium);
  color: var(--color-text-main);
  font-variant-numeric: tabular-nums;
}

.tp-trigger-placeholder {
  flex: 1;
  color: var(--color-text-muted);
}

.tp-trigger-clear {
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

.tp-trigger-clear:hover {
  color: var(--color-red);
  background: var(--color-red-dim);
}

.tp-trigger-chevron {
  color: var(--color-text-muted);
  font-size: var(--text-sm);
  transition: transform var(--transition-base);
}

.tp-trigger-chevron--open {
  transform: rotate(180deg);
  color: var(--color-teal);
}

/* ── Panel ────────────────────────────────────── */

.tp-panel {
  position: absolute;
  top: calc(100% + 6px);
  left: 0;
  z-index: 600;
  background: var(--color-card);
  border: 1px solid var(--color-border);
  border-radius: var(--radius-xl);
  box-shadow: var(--shadow-lg);
  width: 220px;
  overflow: hidden;
}

/* ── Panel Header ─────────────────────────────── */

.tp-panel__header {
  background: var(--color-navy);
  padding: var(--space-7) var(--space-9);
  display: flex;
  align-items: baseline;
  justify-content: space-between;
  gap: var(--space-5);
  position: relative;
}

.tp-panel__header::after {
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

.tp-panel__header-label {
  font-size: var(--text-xs);
  font-weight: var(--weight-semibold);
  color: rgba(255,255,255,0.4);
  text-transform: uppercase;
  letter-spacing: 1.5px;
}

.tp-panel__header-value {
  font-size: var(--text-2xl);
  font-weight: var(--weight-bold);
  color: #fff;
  font-variant-numeric: tabular-nums;
  letter-spacing: 0.5px;
}

/* ── Panel Body — 3-column time selector ──────── */

.tp-panel__body {
  display: flex;
  gap: 0;
  border-bottom: 1px solid var(--color-border);
  border-top: 1px solid var(--color-border);
  position: relative;
}

.tp-col {
  flex: 1;
  display: flex;
  flex-direction: column;
  border-right: 1px solid var(--color-border);
}

.tp-col:last-child {
  border-right: none;
}

.tp-col__label {
  text-align: center;
  font-size: var(--text-xs);
  font-weight: var(--weight-semibold);
  color: var(--color-text-muted);
  text-transform: uppercase;
  letter-spacing: 1px;
  padding: var(--space-4) 0;
  background: var(--color-surface);
  border-bottom: 1px solid var(--color-border);
  position: sticky;
  top: 0;
  z-index: 1;
}

.tp-col__list {
  height: 224px;
  overflow-y: auto;
  scroll-behavior: smooth;
  padding: var(--space-2) 0;
}

.tp-col__list::-webkit-scrollbar {
  width: 3px;
}

.tp-col__list::-webkit-scrollbar-thumb {
  background: var(--color-border);
  border-radius: var(--radius-full);
}

.tp-col__item {
  display: block;
  width: 100%;
  padding: var(--space-4) var(--space-2);
  border: none;
  background: transparent;
  font-family: inherit;
  font-size: var(--text-md);
  font-weight: var(--weight-medium);
  color: var(--color-text-main);
  cursor: pointer;
  transition: all var(--transition-fast);
  text-align: center;
  font-variant-numeric: tabular-nums;
}

.tp-col__item:hover {
  background: var(--color-surface);
  color: var(--color-teal);
}

.tp-col__item--active {
  background: var(--color-teal) !important;
  color: #fff !important;
  font-weight: var(--weight-bold);
}

/* ── Footer ───────────────────────────────────── */

.tp-panel__footer {
  padding: var(--space-6) var(--space-9);
  display: flex;
  align-items: center;
  justify-content: space-between;
  gap: var(--space-6);
}

.tp-panel__footer-btn {
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

.tp-panel__footer-btn:hover {
  background: var(--color-teal-dim);
  color: var(--color-teal);
}

.tp-panel__footer-btn--clear:hover {
  background: var(--color-red-dim);
  color: var(--color-red);
}

.tp-panel__footer-right {
  display: flex;
  align-items: center;
  gap: var(--space-6);
}

/* ── Overlay ──────────────────────────────────── */

.tp-overlay {
  position: fixed;
  inset: 0;
  z-index: 599;
  background: transparent;
}

/* ── Transitions ──────────────────────────────── */

.tp-panel-enter-active {
  animation: tpPanelIn var(--transition-smooth);
}

.tp-panel-leave-active {
  animation: tpPanelOut 0.12s ease;
}

@keyframes tpPanelIn {
  from { opacity: 0; transform: translateY(-6px) scale(0.97); }
  to   { opacity: 1; transform: translateY(0) scale(1); }
}

@keyframes tpPanelOut {
  from { opacity: 1; transform: translateY(0) scale(1); }
  to   { opacity: 0; transform: translateY(-6px) scale(0.97); }
}

.tp-overlay-enter-active { animation: fadeIn var(--transition-fast); }
.tp-overlay-leave-active { animation: fadeOut var(--transition-fast); }

@keyframes fadeIn  { from { opacity: 0; } to { opacity: 1; } }
@keyframes fadeOut { from { opacity: 1; } to { opacity: 0; } }
</style>
