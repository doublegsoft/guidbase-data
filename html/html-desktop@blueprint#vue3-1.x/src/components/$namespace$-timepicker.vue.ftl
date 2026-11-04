<template>
  <div
    ref="wrapEl"
    class="${namespace}-timepicker"
    :class="{
      '${namespace}-timepicker--disabled': disabled,
      '${namespace}-timepicker--open': isOpen,
      ['${namespace}-timepicker--' + size]: size,
    }"
  >
    <!-- 触发框：物理硬阴影、直角细线、等宽格式 -->
    <div
      ref="triggerEl"
      class="${namespace}-timepicker__trigger"
      tabindex="0"
      role="combobox"
      aria-haspopup="dialog"
      :aria-expanded="isOpen"
      @click="toggleOpen"
      @keydown="onTriggerKey"
    >
      <span class="${namespace}-timepicker__text" :class="{ '${namespace}-timepicker__text--placeholder': !displayValue }">
        {{ displayValue || placeholder }}
      </span>
      <span class="${namespace}-timepicker__icon">◷</span>
      <span
        v-if="displayValue && !disabled"
        class="${namespace}-timepicker__clear"
        title="CLEAR"
        @click.stop="clearValue"
      >&times;</span>
    </div>

    <!-- 弹窗面板 (Teleport 到 body) -->
    <teleport to="body">
      <div
        v-if="isOpen"
        ref="panelEl"
        class="${namespace}-timepicker__panel"
        :style="panelStyle"
        tabindex="-1"
        @keydown="onPanelKey"
        @mousedown.prevent
      >
        <!-- 头部：大字体时间仪表盘 + 步进器调节 -->
        <div class="${namespace}-timepicker__head">
          <div class="${namespace}-timepicker__digital">
            <span class="${namespace}-timepicker__dig-seg" :class="{ active: activeUnit === 'hour' }" @click="activeUnit = 'hour'">{{ pad2(hour) }}</span>
            <span class="${namespace}-timepicker__dig-sep">:</span>
            <span class="${namespace}-timepicker__dig-seg" :class="{ active: activeUnit === 'minute' }" @click="activeUnit = 'minute'">{{ pad2(minute) }}</span>
            <template v-if="format === 'HH:mm:ss'">
              <span class="${namespace}-timepicker__dig-sep">:</span>
              <span class="${namespace}-timepicker__dig-seg" :class="{ active: activeUnit === 'second' }" @click="activeUnit = 'second'">{{ pad2(second) }}</span>
            </template>
          </div>

          <!-- + / - 快速微调器 (参考 HTML .num 按钮) -->
          <div class="${namespace}-timepicker__stepper">
            <button type="button" class="${namespace}-timepicker__step-btn" title="增加" @click="stepCurrent(1)">+</button>
            <button type="button" class="${namespace}-timepicker__step-btn" title="减少" @click="stepCurrent(-1)">&minus;</button>
          </div>
        </div>

        <!-- 维度切换分段条 (参考 HTML .seg2) -->
        <div class="${namespace}-timepicker__seg-bar">
          <button type="button" :class="{ on: activeUnit === 'hour' }" @click="activeUnit = 'hour'">时 [HH]</button>
          <button type="button" :class="{ on: activeUnit === 'minute' }" @click="activeUnit = 'minute'">分 [MM]</button>
          <button v-if="format === 'HH:mm:ss'" type="button" :class="{ on: activeUnit === 'second' }" @click="activeUnit = 'second'">秒 [SS]</button>
        </div>

        <!-- 核心交互区：矩阵单元格直选 (Grid Matrix) -->
        <div class="${namespace}-timepicker__body">
          <!-- 小时直选矩阵 (00 - 23, 6列×4行) -->
          <div v-if="activeUnit === 'hour'" class="${namespace}-timepicker__grid ${namespace}-timepicker__grid--hour">
            <div
              v-for="h in 24"
              :key="'h' + (h - 1)"
              class="${namespace}-timepicker__cell"
              :class="{
                '${namespace}-timepicker__cell--active': hour === h - 1,
                '${namespace}-timepicker__cell--disabled': isDisabledHour(h - 1)
              }"
              @click="setHour(h - 1)"
            >
              {{ pad2(h - 1) }}
            </div>
          </div>

          <!-- 分钟/秒直选矩阵 (5为间隔优先高亮，可点选全量) -->
          <div v-else class="${namespace}-timepicker__grid ${namespace}-timepicker__grid--min">
            <div
              v-for="m in 60"
              :key="'m' + (m - 1)"
              class="${namespace}-timepicker__cell"
              :class="{
                '${namespace}-timepicker__cell--active': activeUnit === 'minute' ? minute === m - 1 : second === m - 1,
                '${namespace}-timepicker__cell--step5': (m - 1) % 5 === 0,
                '${namespace}-timepicker__cell--disabled': activeUnit === 'minute' ? isDisabledMin(m - 1) : false
              }"
              @click="activeUnit === 'minute' ? setMin(m - 1) : setSec(m - 1)"
            >
              {{ pad2(m - 1) }}
            </div>
          </div>
        </div>

        <!-- 预设时间快捷标签 -->
        <div class="${namespace}-timepicker__presets">
          <button
            v-for="t in presets"
            :key="t"
            type="button"
            class="${namespace}-timepicker__preset-chip"
            @click="applyPreset(t)"
          >{{ t }}</button>
        </div>

        <!-- 底部操作按钮栏 -->
        <div class="${namespace}-timepicker__footer">
          <button type="button" class="${namespace}-timepicker__btn" @click="setNow">此刻</button>
          <div style="display: flex; gap: 6px;">
            <button type="button" class="${namespace}-timepicker__btn" @click="clearValue">清空</button>
            <button type="button" class="${namespace}-timepicker__btn ${namespace}-timepicker__btn--pri" @click="confirm">确定</button>
          </div>
        </div>
      </div>
    </teleport>
  </div>
</template>

<script setup>
import { ref, computed, watch, nextTick, onMounted, onBeforeUnmount } from 'vue'

const props = defineProps({
  modelValue:   { type: String,  default: '' },
  placeholder:  { type: String,  default: 'HH:mm' },
  format:       { type: String,  default: 'HH:mm' },
  disabled:     { type: Boolean, default: false },
  size:         { type: String,  default: '' },
  minTime:      { type: String,  default: null },
  maxTime:      { type: String,  default: null },
})

const emit = defineEmits(['update:modelValue', 'change'])

const wrapEl    = ref(null)
const triggerEl = ref(null)
const panelEl   = ref(null)
const isOpen    = ref(false)
const hour      = ref(0)
const minute    = ref(0)
const second    = ref(0)
const activeUnit = ref('hour')
const panelStyle = ref({})

const presets = ['09:00', '12:00', '14:00', '18:00', '20:00']

watch(() => props.modelValue, parseValue, { immediate: true })

function parseValue(v) {
  if (!v) {
    const now = new Date()
    hour.value = now.getHours()
    minute.value = now.getMinutes()
    second.value = now.getSeconds()
    return
  }
  const parts = v.split(':')
  if (parts.length >= 2) {
    hour.value   = Math.max(0, Math.min(23, parseInt(parts[0]) || 0))
    minute.value = Math.max(0, Math.min(59, parseInt(parts[1]) || 0))
  }
  if (parts.length >= 3) {
    second.value = Math.max(0, Math.min(59, parseInt(parts[2]) || 0))
  }
}

const displayValue = computed(() => {
  if (!props.modelValue) return ''
  const h = pad2(hour.value)
  const m = pad2(minute.value)
  const s = pad2(second.value)
  return props.format === 'HH:mm:ss' ? `${r"${h}:${m}:${s}"}` : `${r"${h}:${m}"}`
})

function pad2(n) { return String(n).padStart(2, '0') }

function fmtVal() {
  const h = pad2(hour.value)
  const m = pad2(minute.value)
  const s = pad2(second.value)
  return props.format === 'HH:mm:ss' ? `${r"${h}:${m}:${s}"}` : `${r"${h}:${m}"}`
}

function isDisabledHour(h) {
  if (!props.minTime && !props.maxTime) return false
  if (props.minTime) {
    const [mh] = props.minTime.split(':').map(Number)
    if (h < mh) return true
  }
  if (props.maxTime) {
    const [mh] = props.maxTime.split(':').map(Number)
    if (h > mh) return true
  }
  return false
}

function isDisabledMin(m) {
  if (!props.minTime && !props.maxTime) return false
  if (props.minTime) {
    const [mh, mm] = props.minTime.split(':').map(Number)
    if (hour.value === mh && m < mm) return true
  }
  if (props.maxTime) {
    const [mh, mm] = props.maxTime.split(':').map(Number)
    if (hour.value === mh && m > mm) return true
  }
  return false
}

function setHour(h) {
  if (isDisabledHour(h)) return
  hour.value = h
  activeUnit.value = 'minute'
}

function setMin(m) {
  if (isDisabledMin(m)) return
  minute.value = m
  if (props.format === 'HH:mm:ss') {
    activeUnit.value = 'second'
  }
}

function setSec(s) {
  second.value = s
}

function stepCurrent(dir) {
  if (activeUnit.value === 'hour') {
    hour.value = (hour.value + dir + 24) % 24
  } else if (activeUnit.value === 'minute') {
    minute.value = (minute.value + dir + 60) % 60
  } else {
    second.value = (second.value + dir + 60) % 60
  }
}

function setNow() {
  const now = new Date()
  hour.value = now.getHours()
  minute.value = now.getMinutes()
  second.value = now.getSeconds()
}

function applyPreset(t) {
  const parts = t.split(':').map(Number)
  hour.value = parts[0]
  minute.value = parts[1] || 0
  second.value = 0
}

function clearValue() {
  emit('update:modelValue', '')
  emit('change', '', { hour: 0, min: 0, sec: 0 })
  close()
}

function confirm() {
  const val = fmtVal()
  emit('update:modelValue', val)
  emit('change', val, { hour: hour.value, min: minute.value, sec: second.value })
  close()
}

function toggleOpen() {
  if (!props.disabled) isOpen.value ? close() : open()
}

function open() {
  if (isOpen.value || props.disabled) return
  isOpen.value = true
  activeUnit.value = 'hour'
  parseValue(props.modelValue)
  nextTick(() => {
    if (panelEl.value && panelEl.value.parentNode !== document.body) {
      document.body.appendChild(panelEl.value)
    }
    positionPanel()
    panelEl.value?.focus()
  })
  document.addEventListener('click', onDocClick, true)
  window.addEventListener('scroll', onScrollResize, true)
  window.addEventListener('resize', onScrollResize)
}

function close() {
  if (!isOpen.value) return
  isOpen.value = false
  document.removeEventListener('click', onDocClick, true)
  window.removeEventListener('scroll', onScrollResize, true)
  window.removeEventListener('resize', onScrollResize)
  nextTick(() => {
    if (panelEl.value && panelEl.value.parentNode === document.body && wrapEl.value) {
      wrapEl.value.appendChild(panelEl.value)
    }
  })
}

function onScrollResize() {
  if (isOpen.value) positionPanel()
}

function positionPanel() {
  if (!triggerEl.value || !panelEl.value) return
  const rect = triggerEl.value.getBoundingClientRect()
  const pw = 280
  const ph = 330
  const spaceBelow = window.innerHeight - rect.bottom

  const style = { position: 'fixed', zIndex: '99999', width: pw + 'px' }

  if (spaceBelow >= ph || spaceBelow >= 200) {
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

function onTriggerKey(e) {
  if (props.disabled) return
  if (e.key === 'Enter' || e.key === 'ArrowDown') { e.preventDefault(); open() }
  if (e.key === 'Escape') { close(); triggerEl.value?.focus() }
}

function onPanelKey(e) {
  if (e.key === 'Escape') { close(); triggerEl.value?.focus() }
  if (e.key === 'Enter')  { e.preventDefault(); confirm() }
}

function onDocClick(e) {
  if (!wrapEl.value || !panelEl.value) return
  if (!wrapEl.value.contains(e.target) && !panelEl.value.contains(e.target)) close()
}

onMounted(() => document.addEventListener('click', onDocClick, true))
onBeforeUnmount(() => {
  close()
  document.removeEventListener('click', onDocClick, true)
  window.removeEventListener('scroll', onScrollResize, true)
  window.removeEventListener('resize', onScrollResize)
  if (panelEl.value && panelEl.value.parentNode === document.body) {
    document.body.removeChild(panelEl.value)
  }
})

defineExpose({
  open, close,
  getValue: () => fmtVal(),
  setValue: (v) => { parseValue(v) },
})
</script>

<style scoped>
/* ══════════════════════════════════════════════
   Protocol Explorer TimePicker 蓝图样式规范
   ══════════════════════════════════════════════ */
.${namespace}-timepicker {
  position: relative;
  min-width: 130px;
  font-family: var(--${namespace}-f, "IBM Plex Mono", monospace);
  font-size: 13px;
  user-select: none;
  width: 100%;
}

/* 核心修复：彻底阻断继承全局 .tp::after 产生的黑方块/提示框 */
.${namespace}-timepicker::before,
.${namespace}-timepicker::after,
.${namespace}-timepicker__trigger::before,
.${namespace}-timepicker__trigger::after {
  content: none !important;
  display: none !important;
}

.${namespace}-timepicker--disabled {
  opacity: .45;
  pointer-events: none;
}

/* ── 触发框：物理硬阴影、直角细线 ── */
.${namespace}-timepicker__trigger {
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
.${namespace}-timepicker__trigger:hover,
.${namespace}-timepicker--open .${namespace}-timepicker__trigger {
  border-color: var(--${namespace}-pri, #0a2fb5);
  transform: translate(-1px, -1px);
  box-shadow: 3px 3px 0 color-mix(in srgb, var(--${namespace}-pri, #0a2fb5) 30%, transparent);
}
.${namespace}-timepicker__text {
  font-weight: 600;
  letter-spacing: .08em;
}
.${namespace}-timepicker__text--placeholder {
  color: var(--${namespace}-mu, #6f7fb4);
  font-weight: normal;
}
.${namespace}-timepicker__icon {
  font-size: 14px;
  color: var(--${namespace}-mu, #6f7fb4);
}
.${namespace}-timepicker__clear {
  position: absolute;
  right: 28px;
  top: 50%;
  transform: translateY(-50%);
  font-size: 14px;
  font-weight: 700;
  color: var(--${namespace}-mu, #6f7fb4);
  cursor: pointer;
  display: none;
}
.${namespace}-timepicker:hover .${namespace}-timepicker__clear {
  display: inline-block;
}
.${namespace}-timepicker__clear:hover {
  color: var(--${namespace}-red, #d6343e);
}

/* ── 弹窗面板：直角、4px 墨水实体投影 ── */
.${namespace}-timepicker__panel {
  background: var(--${namespace}-pn, #ffffff);
  border: 1px solid var(--${namespace}-ink, #0a2a9a);
  border-radius: 0;
  box-shadow: 4px 4px 0 var(--${namespace}-ln, #d3dbef);
  outline: none;
  font-family: var(--${namespace}-f, "IBM Plex Mono", monospace);
}

/* 顶部时间显示器与步进键 */
.${namespace}-timepicker__head {
  padding: 8px 12px;
  border-bottom: 1px solid var(--${namespace}-ln, #d3dbef);
  background: var(--${namespace}-bg, #f4f6fb);
  display: flex;
  align-items: center;
  justify-content: space-between;
}
.${namespace}-timepicker__digital {
  display: flex;
  align-items: center;
  gap: 2px;
  font-size: 22px;
  font-weight: 700;
  color: var(--${namespace}-ink, #0a2a9a);
  letter-spacing: .05em;
}
.${namespace}-timepicker__dig-seg {
  cursor: pointer;
  padding: 1px 4px;
  border: 1px solid transparent;
  transition: .12s;
}
.${namespace}-timepicker__dig-seg:hover {
  background: color-mix(in srgb, var(--${namespace}-pri, #0a2fb5) 15%, transparent);
}
.${namespace}-timepicker__dig-seg.active {
  background: var(--${namespace}-pri, #0a2fb5);
  color: var(--${namespace}-on, #ffffff);
}
.${namespace}-timepicker__dig-sep {
  color: var(--${namespace}-mu, #6f7fb4);
}

/* 步进按钮对 */
.${namespace}-timepicker__stepper {
  display: flex;
  border: 1px solid var(--${namespace}-ln, #d3dbef);
}
.${namespace}-timepicker__step-btn {
  width: 28px;
  height: 26px;
  background: var(--${namespace}-pn, #ffffff);
  border: none;
  border-right: 1px solid var(--${namespace}-ln, #d3dbef);
  color: var(--${namespace}-ink, #0a2a9a);
  cursor: pointer;
  font: inherit;
  font-weight: 700;
  display: grid;
  place-items: center;
  transition: .12s;
}
.${namespace}-timepicker__step-btn:last-child {
  border-right: none;
}
.${namespace}-timepicker__step-btn:hover {
  background: var(--${namespace}-pri, #0a2fb5);
  color: var(--${namespace}-on, #ffffff);
}

/* 维度切换分段条 */
.${namespace}-timepicker__seg-bar {
  display: flex;
  border-bottom: 1px solid var(--${namespace}-ln, #d3dbef);
  background: var(--${namespace}-pn, #ffffff);
}
.${namespace}-timepicker__seg-bar button {
  flex: 1;
  padding: 6px 0;
  border: none;
  background: transparent;
  color: var(--${namespace}-mu, #6f7fb4);
  font: inherit;
  font-size: 11px;
  font-weight: 700;
  cursor: pointer;
  letter-spacing: .05em;
  transition: .12s;
}
.${namespace}-timepicker__seg-bar button.on {
  background: var(--${namespace}-pri, #0a2fb5);
  color: var(--${namespace}-on, #ffffff);
}

/* ── 核心矩阵单元格交互区 ── */
.${namespace}-timepicker__body {
  padding: 8px;
  max-height: 180px;
  overflow-y: auto;
}

.${namespace}-timepicker__grid {
  display: grid;
  gap: 3px;
}
.${namespace}-timepicker__grid--hour {
  grid-template-columns: repeat(6, 1fr);
}
.${namespace}-timepicker__grid--min {
  grid-template-columns: repeat(6, 1fr);
}

.${namespace}-timepicker__cell {
  height: 26px;
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 12px;
  font-weight: 600;
  color: var(--${namespace}-ink, #0a2a9a);
  border: 1px solid transparent;
  cursor: pointer;
  transition: .12s;
}
.${namespace}-timepicker__cell:hover {
  background: color-mix(in srgb, var(--${namespace}-ln, #d3dbef) 50%, transparent);
  border-color: var(--${namespace}-ink, #0a2a9a);
}
.${namespace}-timepicker__cell--step5 {
  color: var(--${namespace}-pri, #0a2fb5);
  font-weight: 700;
}
.${namespace}-timepicker__cell--active {
  background: var(--${namespace}-pri, #0a2fb5) !important;
  color: var(--${namespace}-on, #ffffff) !important;
  border-color: var(--${namespace}-pri, #0a2fb5) !important;
}
.${namespace}-timepicker__cell--disabled {
  opacity: .2;
  cursor: not-allowed;
  pointer-events: none;
}

/* 预设标签 */
.${namespace}-timepicker__presets {
  display: flex;
  gap: 4px;
  padding: 6px 8px;
  border-top: 1px solid var(--${namespace}-ln, #d3dbef);
  background: var(--${namespace}-bg, #f4f6fb);
  overflow-x: auto;
}
.${namespace}-timepicker__preset-chip {
  padding: 2px 6px;
  border: 1px solid var(--${namespace}-ln, #d3dbef);
  border-radius: 0;
  background: var(--${namespace}-pn, #ffffff);
  color: var(--${namespace}-mu, #6f7fb4);
  font: inherit;
  font-size: 10px;
  font-weight: 600;
  cursor: pointer;
  transition: .12s;
  white-space: nowrap;
}
.${namespace}-timepicker__preset-chip:hover {
  border-color: var(--${namespace}-pri, #0a2fb5);
  color: var(--${namespace}-pri, #0a2fb5);
}

/* 底部操作行 */
.${namespace}-timepicker__footer {
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: 6px 8px;
  border-top: 1px solid var(--${namespace}-ln, #d3dbef);
  background: var(--${namespace}-pn, #ffffff);
}
.${namespace}-timepicker__btn {
  font: 600 11px var(--${namespace}-f, "IBM Plex Mono", monospace);
  padding: 4px 10px;
  border: 1px solid var(--${namespace}-ink, #0a2a9a);
  background: var(--${namespace}-pn, #ffffff);
  color: var(--${namespace}-ink, #0a2a9a);
  cursor: pointer;
  letter-spacing: .08em;
  transition: .12s;
}
.${namespace}-timepicker__btn:hover {
  transform: translate(-1px, -1px);
  box-shadow: 2px 2px 0 var(--${namespace}-ink, #0a2a9a);
}
.${namespace}-timepicker__btn:active {
  transform: translate(1px, 1px);
  box-shadow: none;
}
.${namespace}-timepicker__btn--pri {
  background: var(--${namespace}-pri, #0a2fb5);
  color: var(--${namespace}-on, #ffffff);
  border-color: var(--${namespace}-pri, #0a2fb5);
}

/* 尺寸变体 */
.${namespace}-timepicker--sm .${namespace}-timepicker__trigger { height: 26px; font-size: 11px; }
.${namespace}-timepicker--lg .${namespace}-timepicker__trigger { height: 40px; font-size: 14px; }
</style>