<template>
  <div
    ref="wrapEl"
    class="${namespace}-tp"
    :class="{
      '${namespace}-tp--disabled': disabled,
      '${namespace}-tp--open': isOpen,
      ['${namespace}-tp--' + size]: size,
    }"
  >
    <!-- 触发器 -->
    <div
      ref="triggerEl"
      class="${namespace}-tp__trigger"
      tabindex="0"
      role="combobox"
      aria-haspopup="dialog"
      :aria-expanded="isOpen"
      @click="toggleOpen"
      @keydown="onTriggerKey"
    >
      <span class="${namespace}-tp__text" :class="{ '${namespace}-tp__text--placeholder': !displayValue }">
        {{ displayValue || placeholder }}
      </span>
      <span
        v-if="displayValue && !disabled"
        class="${namespace}-tp__clear"
        @click.stop="clearValue"
      >&#xD7;</span>
    </div>

    <!-- 面板 -->
    <teleport to="body">
      <div
        v-if="isOpen"
        ref="panelEl"
        class="${namespace}-tp__panel"
        :style="panelStyle"
        tabindex="-1"
        @keydown="onPanelKey"
        @mousedown.prevent
      >
        <!-- 头部：大字体当前时间 -->
        <div class="${namespace}-tp__head">
          <span class="${namespace}-tp__head-time">{{ displayValue || '--:--' }}</span>
        </div>

        <!-- 三列滚轮 -->
        <div class="${namespace}-tp__cols">
          <!-- 时 -->
          <div class="${namespace}-tp__col">
            <div class="${namespace}-tp__col-label">时</div>
            <div ref="colHour" class="${namespace}-tp__col-list" @scroll="onScrollCol">
              <div
                v-for="h in 24"
                :key="'h' + (h - 1)"
                class="${namespace}-tp__item"
                :class="{
                  '${namespace}-tp__item--active': hour === h - 1,
                  '${namespace}-tp__item--disabled': isDisabledHour(h - 1),
                }"
                @click="setHour(h - 1)"
              >{{ pad2(h - 1) }}</div>
            </div>
          </div>

          <!-- 分 -->
          <div class="${namespace}-tp__col">
            <div class="${namespace}-tp__col-label">分</div>
            <div ref="colMin" class="${namespace}-tp__col-list" @scroll="onScrollCol">
              <div
                v-for="m in 60"
                :key="'m' + (m - 1)"
                class="${namespace}-tp__item"
                :class="{
                  '${namespace}-tp__item--active': minute === m - 1,
                  '${namespace}-tp__item--disabled': isDisabledMin(m - 1),
                }"
                @click="setMin(m - 1)"
              >{{ pad2(m - 1) }}</div>
            </div>
          </div>

          <!-- 秒（可选） -->
          <div v-if="format === 'HH:mm:ss'" class="${namespace}-tp__col">
            <div class="${namespace}-tp__col-label">秒</div>
            <div ref="colSec" class="${namespace}-tp__col-list" @scroll="onScrollCol">
              <div
                v-for="s in 60"
                :key="'s' + (s - 1)"
                class="${namespace}-tp__item"
                :class="{ '${namespace}-tp__item--active': second === s - 1 }"
                @click="setSec(s - 1)"
              >{{ pad2(s - 1) }}</div>
            </div>
          </div>
        </div>

        <!-- 底部：快捷 + 此刻 + 确定 -->
        <div class="${namespace}-tp__footer">
          <div class="${namespace}-tp__presets">
            <button
              v-for="t in presets"
              :key="t"
              type="button"
              class="${namespace}-tp__preset-btn"
              @click="applyPreset(t)"
            >{{ t }}</button>
          </div>
          <button type="button" class="${namespace}-tp__btn ${namespace}-tp__btn--now" @click="setNow">此刻</button>
          <button type="button" class="${namespace}-tp__btn ${namespace}-tp__btn--ok" @click="confirm">确定</button>
        </div>
      </div>
    </teleport>
  </div>
</template>

<script setup>
import { ref, computed, watch, nextTick, onMounted, onBeforeUnmount } from 'vue'

const props = defineProps({
  modelValue:   { type: String,  default: '' },
  placeholder:  { type: String,  default: '请选择时间...' },
  format:       { type: String,  default: 'HH:mm' },   // 'HH:mm' | 'HH:mm:ss'
  disabled:     { type: Boolean, default: false },
  size:         { type: String,  default: '' },
  minTime:      { type: String,  default: null },
  maxTime:      { type: String,  default: null },
})

const emit = defineEmits(['update:modelValue', 'change'])

const wrapEl    = ref(null)
const triggerEl = ref(null)
const panelEl   = ref(null)
const colHour   = ref(null)
const colMin    = ref(null)
const colSec    = ref(null)
const isOpen    = ref(false)
const hour      = ref(0)
const minute    = ref(0)
const second    = ref(0)
const panelStyle = ref({})

const presets = ['08:00', '09:00', '12:00', '14:00', '18:00', '20:00']

// parse modelValue
watch(() => props.modelValue, parseValue, { immediate: true })

function parseValue(v) {
  if (!v) { hour.value = 0; minute.value = 0; second.value = 0; return }
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
  const h = String(hour.value).padStart(2, '0')
  const m = String(minute.value).padStart(2, '0')
  const s = String(second.value).padStart(2, '0')
  return props.format === 'HH:mm:ss' ? h + ':' + m + ':' + s : h + ':' + m
})

function pad2(n) { return String(n).padStart(2, '0') }

function fmtVal() {
  const h = String(hour.value).padStart(2, '0')
  const m = String(minute.value).padStart(2, '0')
  const s = String(second.value).padStart(2, '0')
  return props.format === 'HH:mm:ss' ? h + ':' + m + ':' + s : h + ':' + m
}

// ── time range check ──
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

// ── setters ──
function setHour(h) { if (!isDisabledHour(h)) { hour.value = h; scrollTo('hour') } }
function setMin(m)  { if (!isDisabledMin(m))  { minute.value = m; scrollTo('min') } }
function setSec(s)  { second.value = s; scrollTo('sec') }

function setNow() {
  const now = new Date()
  hour.value = now.getHours()
  minute.value = now.getMinutes()
  second.value = now.getSeconds()
  scrollTo('hour')
}

function applyPreset(t) {
  parseValue(t)
  scrollTo('hour')
}

function clearValue() {
  emit('update:modelValue', '')
  emit('change', '', { hour: 0, min: 0, sec: 0 })
  hour.value = 0; minute.value = 0; second.value = 0
  if (isOpen.value) close()
}

function confirm() {
  const val = fmtVal()
  emit('update:modelValue', val)
  emit('change', val, { hour: hour.value, min: minute.value, sec: second.value })
  close()
}

// ── scroll sync ──
let isProgScroll = false   // 程序滚动标记，跳过 sync
let scrollTimer = null
function onScrollCol() {
  if (isProgScroll) return
  clearTimeout(scrollTimer)
  scrollTimer = setTimeout(syncFromScroll, 100)
}

function syncFromScroll() {
  if (isProgScroll) return
  const h = getScrollCentered(colHour.value)
  const m = getScrollCentered(colMin.value)
  if (h !== null) hour.value = h
  if (m !== null) minute.value = m
  if (colSec.value) {
    const s = getScrollCentered(colSec.value)
    if (s !== null) second.value = s
  }
}

function getScrollCentered(el) {
  if (!el) return null
  const items = el.querySelectorAll('.${namespace}-tp__item:not(.${namespace}-tp__item--disabled)')
  if (!items.length) return null
  const center = el.scrollTop + el.offsetHeight / 2
  let best = null, bestDist = Infinity
  items.forEach(item => {
    const dist = Math.abs(item.offsetTop + item.offsetHeight / 2 - center)
    if (dist < bestDist) { bestDist = dist; best = item }
  })
  return best ? parseInt(best.textContent) : null
}

function scrollTo(type) {
  isProgScroll = true
  nextTick(() => {
    const col = type === 'hour' ? colHour.value : type === 'min' ? colMin.value : colSec.value
    const val = type === 'hour' ? hour.value : type === 'min' ? minute.value : second.value
    if (!col) { isProgScroll = false; return }
    const items = col.querySelectorAll('.${namespace}-tp__item')
    items.forEach(item => {
      item.classList.remove('${namespace}-tp__item--active')
      if (parseInt(item.textContent) === val) {
        item.classList.add('${namespace}-tp__item--active')
        const top = item.offsetTop - col.offsetHeight / 2 + item.offsetHeight / 2
        col.scrollTo({ top: Math.max(0, top), behavior: 'instant' })
      }
    })
    // 等滚动完成后再放开标记
    setTimeout(() => { isProgScroll = false }, 150)
  })
}

// ── panel open / close ──
function toggleOpen() { if (!props.disabled) isOpen.value ? close() : open() }

function open() {
  if (isOpen.value || props.disabled) return
  isOpen.value = true
  nextTick(() => {
    if (panelEl.value && panelEl.value.parentNode !== document.body) {
      document.body.appendChild(panelEl.value)
    }
    positionPanel()
    scrollTo('hour')
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

function onScrollResize() { if (isOpen.value) positionPanel() }

function positionPanel() {
  if (!triggerEl.value || !panelEl.value) return
  const rect = triggerEl.value.getBoundingClientRect()
  const pw = panelEl.value.offsetWidth || 260
  const ph = panelEl.value.offsetHeight || 340
  const spaceBelow = window.innerHeight - rect.bottom
  const spaceRight = window.innerWidth - rect.left

  const top    = spaceBelow >= ph || spaceBelow >= 200 ? rect.bottom + 2 : 'auto'
  const bottom = spaceBelow < ph && spaceBelow < 200 ? window.innerHeight - rect.top + 2 : 'auto'
  const left   = spaceRight >= pw ? 'auto' : rect.left
  const right  = spaceRight < pw ? 'auto' : window.innerWidth - rect.right

  panelStyle.value = {
    position: 'fixed', zIndex: '99999',
    top:    top    !== 'auto' ? top    + 'px' : 'auto',
    bottom: bottom !== 'auto' ? bottom + 'px' : 'auto',
    left:   left   !== 'auto' ? left   + 'px' : 'auto',
    right:  right  !== 'auto' ? right  + 'px' : 'auto',
  }
}

// ── keyboard ──
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

// ── lifecycle ──
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
  open, close, getValue: () => fmtVal(),
  setValue: (v) => { parseValue(v) },
})
</script>

<style scoped>
/* ═══════════════════════════════════════════
   BNR TimePicker — ${namespace}-tp
   所有颜色均通过 BNR Design System 变量引用
   ═══════════════════════════════════════════ */

.${namespace}-tp {
  position: relative;
  min-width: 120px;
  font-family: var(--${namespace}-font);
  font-size: 12px;
  user-select: none;
  flex: 1;
}
.${namespace}-tp--disabled { opacity: .6; pointer-events: none; }

.${namespace}-tp__trigger {
  flex: 1;
  height: 24px;
  display: flex;
  align-items: center;
  gap: 4px;
  padding: 0 6px;
  border: 1px solid var(--${namespace}-border);
  border-radius: 2px;
  background: var(--${namespace}-bg);
  cursor: pointer;
  transition: border-color .15s;
}
.${namespace}-tp--open .${namespace}-tp__trigger {
  border-color: var(--${namespace}-primary);
  box-shadow: 0 0 0 2px rgba(190,0,0,.08);
}
.${namespace}-tp__icon { font-size: 13px; flex-shrink: 0; }
.${namespace}-tp__text { flex: 1; font-size: 12px; color: var(--${namespace}-text); white-space: nowrap; overflow: hidden; text-overflow: ellipsis; }
.${namespace}-tp__text--placeholder { color: var(--${namespace}-text-light); }
.${namespace}-tp__clear { font-size: 14px; color: var(--${namespace}-text-light); cursor: pointer; line-height: 1; flex-shrink: 0; }
.${namespace}-tp__clear:hover { color: var(--${namespace}-danger); }

.${namespace}-tp__panel {
  width: 260px;
  background: var(--${namespace}-bg);
  border: 1px solid var(--${namespace}-border);
  border-radius: 2px;
  box-shadow: var(--${namespace}-shadow-md);
  outline: none;
}

.${namespace}-tp__head {
  padding: 10px 12px 8px;
  border-bottom: 1px solid var(--${namespace}-border-light);
  text-align: center;
  background: var(--${namespace}-bg);
}
.${namespace}-tp__head-time {
  font-size: 26px;
  font-weight: 300;
  color: var(--${namespace}-primary);
  letter-spacing: 2px;
  font-variant-numeric: tabular-nums;
}

.${namespace}-tp__cols {
  display: flex;
  height: 200px;
  border-bottom: 1px solid var(--${namespace}-border-light);
  overflow: hidden;
}
.${namespace}-tp__col {
  flex: 1;
  display: flex;
  flex-direction: column;
  border-right: 1px solid var(--${namespace}-border-light);
}
.${namespace}-tp__col:last-child { border-right: none; }
.${namespace}-tp__col-label {
  text-align: center;
  font-size: 10px;
  color: var(--${namespace}-text-light);
  padding: 4px 0;
  background: var(--${namespace}-bg-page);
  border-bottom: 1px solid var(--${namespace}-border-light);
  flex-shrink: 0;
}
.${namespace}-tp__col-list {
  flex: 1;
  overflow-y: auto;
  -webkit-overflow-scrolling: touch;
  scroll-snap-type: y mandatory;
}
.${namespace}-tp__item {
  height: 32px;
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 14px;
  color: var(--${namespace}-text);
  cursor: pointer;
  transition: background .1s;
  scroll-snap-align: center;
}
.${namespace}-tp__item:hover { background: var(--${namespace}-primary-bg); }
.${namespace}-tp__item--active { background: var(--${namespace}-primary-bg); color: var(--${namespace}-primary-dark); font-weight: bold; font-size: 16px; }
.${namespace}-tp__item--disabled { color: var(--${namespace}-text-disabled); cursor: not-allowed; pointer-events: none; }

.${namespace}-tp__footer {
  display: flex;
  align-items: center;
  gap: 4px;
  padding: 6px 8px;
  background: var(--${namespace}-bg);
}
.${namespace}-tp__presets { display: flex; gap: 3px; flex-wrap: wrap; flex: 1; }
.${namespace}-tp__preset-btn {
  font-size: 10px;
  padding: 2px 6px;
  border: 1px solid var(--${namespace}-primary-border);
  border-radius: 2px;
  background: var(--${namespace}-bg);
  color: var(--${namespace}-primary-dark);
  cursor: pointer;
  font-family: inherit;
  transition: background .1s;
}
.${namespace}-tp__preset-btn:hover { background: var(--${namespace}-primary-bg); }

.${namespace}-tp__btn {
  font-size: 11px;
  padding: 4px 12px;
  border: none;
  border-radius: 2px;
  cursor: pointer;
  font-family: inherit;
  transition: background .1s;
  flex-shrink: 0;
}
.${namespace}-tp__btn--now { background: var(--${namespace}-bg-page); color: var(--${namespace}-text-muted); }
.${namespace}-tp__btn--now:hover { background: var(--${namespace}-border-light); }
.${namespace}-tp__btn--ok { background: var(--${namespace}-primary); color: var(--${namespace}-bg); }
.${namespace}-tp__btn--ok:hover { background: var(--${namespace}-primary-dark); }

.${namespace}-tp--sm .${namespace}-tp__trigger { height: 20px; font-size: 11px; }
.${namespace}-tp--sm .${namespace}-tp__icon   { font-size: 11px; }
.${namespace}-tp--sm .${namespace}-tp__text   { font-size: 11px; }
.${namespace}-tp--lg .${namespace}-tp__trigger { height: 28px; font-size: 13px; }
</style>
