<template>
  <div
    ref="rootEl"
    class="${namespace}-dd"
    :class="[
      sizeClass,
      {
        '${namespace}-dd--plain': plain,
        '${namespace}-dd--disabled': disabled,
        '${namespace}-dd--open': open
      }
    ]"
  >
    <!-- Trigger: 新拟态内凹微槽触发器 (与输入框体系完全一致) -->
    <button
      ref="triggerEl"
      class="${namespace}-dd-trigger"
      :class="{ '${namespace}-dd-trigger--placeholder': !selectedOption }"
      type="button"
      :disabled="disabled"
      @click="togglePanel"
      @keydown="onTriggerKeydown"
    >
      <!-- 选中文本呈现 (Label) -->
      <span class="${namespace}-dd-trigger-text">
        {{ selectedOption ? selectedOption.label : placeholder }}
      </span>

      <!-- 拟态浅色角标 Code -->
      <span v-if="selectedOption && selectedOption.code" class="${namespace}-dd-trigger-code">
        {{ selectedOption.code }}
      </span>

      <!-- 柔和平滑折叠箭头 -->
      <span class="${namespace}-dd-arrow" :class="{ 'is-open': open }">▾</span>
    </button>

    <!-- 清除按钮：微凸浮雕圆扣 -->
    <span
      v-if="clearable && selectedOption && !disabled"
      class="${namespace}-dd-clear"
      title="清除"
      @click.stop="clearValue"
    >&times;</span>

    <!-- 下拉面板 (Teleported to body)：柔和双向大浮雕卡片 -->
    <teleport to="body">
      <div
        v-if="open"
        ref="panelEl"
        class="${namespace}-dd-panel"
        :style="panelStyle"
        @click.stop
      >
        <!-- 搜索输入框：内嵌刻槽搜索条 -->
        <div v-if="searchable" class="${namespace}-dd-search">
          <input
            ref="searchEl"
            v-model="query"
            class="${namespace}-dd-search-input"
            type="text"
            placeholder="搜索选项..."
            autocomplete="off"
            @keydown="onSearchKeydown"
          />
        </div>

        <!-- 选项列表：圆角浮雕条目 -->
        <div class="${namespace}-dd-options-box">
          <template v-if="filteredOptions.length">
            <div
              v-for="(opt, idx) in filteredOptions"
              :key="opt.value"
              class="${namespace}-dd-option"
              :class="{
                '${namespace}-dd-option--focused': idx === focusedIdx,
                '${namespace}-dd-option--selected': opt.value === modelValue,
                '${namespace}-dd-option--disabled': opt.disabled,
              }"
              @click="selectOption(opt)"
              @mouseenter="focusedIdx = idx"
            >
              <!-- 主要名称 -->
              <span class="${namespace}-dd-label">
                <span v-if="searchable && query" v-html="highlightLabel(opt.label, query)"></span>
                <span v-else>{{ opt.label }}</span>
              </span>

              <!-- 右侧 Code 角标 -->
              <span v-if="opt.code" class="${namespace}-dd-code">{{ opt.code }}</span>
            </div>
          </template>
          <div v-else class="${namespace}-dd-empty">无匹配项</div>
        </div>
      </div>
    </teleport>
  </div>
</template>

<script setup>
import { ref, computed, watch, nextTick, onMounted, onBeforeUnmount } from 'vue'

const props = defineProps({
  modelValue:  { default: null },
  options:     { type: Array,   default: () => [] },
  placeholder: { type: String,  default: '请选择...' },
  searchable:  { type: Boolean, default: false },
  clearable:   { type: Boolean, default: false },
  disabled:    { type: Boolean, default: false },
  plain:       { type: Boolean, default: false },
  size:        { type: String,  default: '' },
})

const emit = defineEmits(['update:modelValue'])

const rootEl     = ref(null)
const triggerEl  = ref(null)
const panelEl    = ref(null)
const searchEl   = ref(null)
const open       = ref(false)
const query      = ref('')
const focusedIdx = ref(-1)
const panelStyle = ref({})

const sizeClass = computed(() => {
  if (props.size === 'sm') return '${namespace}-dd--sm'
  if (props.size === 'lg') return '${namespace}-dd--lg'
  return ''
})

const selectedOption = computed(() =>
  props.options.find(o => o.value === props.modelValue) || null
)

const filteredOptions = computed(() => {
  if (!props.searchable || !query.value.trim()) return props.options
  const q = query.value.trim().toLowerCase()
  return props.options.filter(o => {
    const labelMatch = String(o.label).toLowerCase().includes(q)
    const codeMatch = o.code ? String(o.code).toLowerCase().includes(q) : false
    return labelMatch || codeMatch
  })
})

function highlightLabel(text, q) {
  if (!q) return text
  const escaped = q.replace(${r"/[.*+?^${}()|[\]\\]/g"}, '\\$&')
  return String(text).replace(
    new RegExp(escaped, 'gi'),
    m => `<mark class="${namespace}-dd-mark">${r"${m}"}</mark>`
  )
}

function togglePanel() {
  if (props.disabled) return
  open.value ? closePanel() : openPanel()
}

function openPanel() {
  open.value = true
  query.value = ''
  focusedIdx.value = -1
  nextTick(() => {
    positionPanel()
    searchEl.value?.focus()
  })
}

function closePanel() {
  open.value = false
  query.value = ''
  focusedIdx.value = -1
}

function selectOption(opt) {
  if (opt.disabled) return
  emit('update:modelValue', opt.value)
  closePanel()
}

function clearValue() {
  emit('update:modelValue', null)
}

function positionPanel() {
  if (!triggerEl.value) return
  const rect = triggerEl.value.getBoundingClientRect()
  const spaceBelow = window.innerHeight - rect.bottom
  
  const minPanelWidth = Math.max(rect.width, 280)

  panelStyle.value = {
    position: 'fixed',
    zIndex: '10000',
    top: spaceBelow >= 300 ? (rect.bottom + 8) + 'px' : 'auto',
    bottom: spaceBelow < 300 ? (window.innerHeight - rect.top + 8) + 'px' : 'auto',
    left: rect.left + 'px',
    width: minPanelWidth + 'px',
  }
}

function onTriggerKeydown(e) {
  if (e.key === 'ArrowDown' || e.key === 'ArrowUp') {
    e.preventDefault()
    if (!open.value) openPanel()
    else if (e.key === 'ArrowDown') focusedIdx.value = Math.min(focusedIdx.value + 1, filteredOptions.value.length - 1)
    else if (e.key === 'ArrowUp') focusedIdx.value = Math.max(focusedIdx.value - 1, 0)
  } else if (e.key === 'Escape') {
    closePanel()
    triggerEl.value?.focus()
  }
}

function onSearchKeydown(e) {
  const opts = filteredOptions.value
  if (e.key === 'ArrowDown') {
    e.preventDefault()
    focusedIdx.value = Math.min(focusedIdx.value + 1, opts.length - 1)
    scrollFocused()
  } else if (e.key === 'ArrowUp') {
    e.preventDefault()
    focusedIdx.value = Math.max(focusedIdx.value - 1, 0)
    scrollFocused()
  } else if (e.key === 'Enter') {
    e.preventDefault()
    if (focusedIdx.value >= 0 && opts[focusedIdx.value]) {
      selectOption(opts[focusedIdx.value])
    }
  } else if (e.key === 'Escape') {
    closePanel()
    triggerEl.value?.focus()
  }
}

function scrollFocused() {
  nextTick(() => {
    const el = panelEl.value?.querySelectorAll('.${namespace}-dd-option')[focusedIdx.value]
    el?.scrollIntoView({ block: 'nearest' })
  })
}

let onResizeScroll = null

watch(open, (val) => {
  if (val) {
    onResizeScroll = () => positionPanel()
    window.addEventListener('scroll', onResizeScroll, true)
    window.addEventListener('resize', onResizeScroll)
  } else {
    if (onResizeScroll) {
      window.removeEventListener('scroll', onResizeScroll, true)
      window.removeEventListener('resize', onResizeScroll)
      onResizeScroll = null
    }
  }
})

function onDocClick(e) {
  if (!rootEl.value?.contains(e.target) && !panelEl.value?.contains(e.target)) {
    closePanel()
  }
}

onMounted(() => document.addEventListener('click', onDocClick, true))
onBeforeUnmount(() => {
  document.removeEventListener('click', onDocClick, true)
  if (onResizeScroll) {
    window.removeEventListener('scroll', onResizeScroll, true)
    window.removeEventListener('resize', onResizeScroll)
  }
})
</script>

<style scoped>
/* ══════════════════════════════════════════════
   Protocol Explorer Dropdown 新拟态样式规范
   ══════════════════════════════════════════════ */
.${namespace}-dd {
  position: relative;
  display: inline-flex;
  width: 100%;
  min-width: 180px;
  font-family: var(--${namespace}-f, -apple-system, "PingFang SC", sans-serif);
  font-size: 13.5px;
  user-select: none;
}
.${namespace}-dd--disabled {
  opacity: .45;
  pointer-events: none;
}

/* ── 拟态触发器：内凹微槽与舒适触感 ── */
.${namespace}-dd-trigger {
  display: flex;
  align-items: center;
  justify-content: space-between;
  width: 100%;
  height: 38px;
  border: 0;
  border-radius: 14px;
  padding: 0 14px;
  background: var(--${namespace}-pn, #e0e5ec);
  box-shadow: var(--${namespace}-sis, inset 2px 2px 5px var(--${namespace}-sd, #a3b1c6), inset -2px -2px 5px var(--${namespace}-sl, #ffffff));
  color: var(--${namespace}-ink, #4a5568);
  cursor: pointer;
  outline: none;
  transition: box-shadow .15s ease, color .15s ease;
  white-space: nowrap;
  font: inherit;
}

.${namespace}-dd-trigger:hover {
  color: var(--${namespace}-pri, #4d7cfe);
}

.${namespace}-dd--open .${namespace}-dd-trigger,
.${namespace}-dd-trigger:focus {
  box-shadow: var(--${namespace}-sis, inset 2px 2px 5px var(--${namespace}-sd, #a3b1c6), inset -2px -2px 5px var(--${namespace}-sl, #ffffff)), 0 0 0 2px rgba(77, 124, 254, .55);
  color: var(--${namespace}-pri, #4d7cfe);
}

/* 选中项标签 */
.${namespace}-dd-trigger-text {
  font-weight: 600;
  letter-spacing: .02em;
  color: var(--${namespace}-ink, #4a5568);
  margin-right: auto;
  overflow: hidden;
  text-overflow: ellipsis;
}

/* 显式 Code 缩写标识 (微凹小药丸) */
.${namespace}-dd-trigger-code {
  font-family: var(--${namespace}-m, monospace);
  font-weight: 700;
  font-size: 11px;
  color: var(--${namespace}-pri, #4d7cfe);
  background: var(--${namespace}-pn, #e0e5ec);
  box-shadow: var(--${namespace}-sis, inset 2px 2px 5px var(--${namespace}-sd, #a3b1c6), inset -2px -2px 5px var(--${namespace}-sl, #ffffff));
  padding: 2px 6px;
  border-radius: 8px;
  margin-right: 8px;
  letter-spacing: .06em;
}

.${namespace}-dd-trigger--placeholder .${namespace}-dd-trigger-text {
  color: var(--${namespace}-mu, #8390a6);
  font-weight: normal;
}

/* 折叠小箭头 */
.${namespace}-dd-arrow {
  color: var(--${namespace}-mu, #8390a6);
  font-size: 13px;
  transition: transform .2s ease, color .15s;
  line-height: 1;
}
.${namespace}-dd-arrow.is-open {
  transform: rotate(180deg);
  color: var(--${namespace}-pri, #4d7cfe);
}

/* ── 弹窗面板：大圆角与双向柔和高光投影 ── */
.${namespace}-dd-panel {
  position: fixed;
  z-index: 10000;
  background: var(--${namespace}-pn, #e0e5ec);
  border-radius: 20px;
  box-shadow: var(--${namespace}-sp, 9px 9px 18px var(--${namespace}-sd, #a3b1c6), -9px -9px 18px var(--${namespace}-sl, #ffffff));
  border: 0;
  max-height: 320px;
  display: flex;
  flex-direction: column;
  padding: 8px;
  box-sizing: border-box;
  font-family: var(--${namespace}-f, -apple-system, sans-serif);
  animation: ddFadeIn .2s ease both;
}

@keyframes ddFadeIn {
  from { opacity: 0; transform: translateY(-6px); }
  to { opacity: 1; transform: translateY(0); }
}

/* ── 搜索输入框 (内凹圆角输入槽) ── */
.${namespace}-dd-search {
  padding: 4px 6px 8px;
  flex-shrink: 0;
}
.${namespace}-dd-search-input {
  width: 100%;
  height: 32px;
  border: 0;
  border-radius: 12px;
  padding: 0 12px;
  font: inherit;
  font-size: 12.5px;
  color: var(--${namespace}-ink, #4a5568);
  background: var(--${namespace}-pn, #e0e5ec);
  box-shadow: var(--${namespace}-sis, inset 2px 2px 5px var(--${namespace}-sd, #a3b1c6), inset -2px -2px 5px var(--${namespace}-sl, #ffffff));
  outline: none;
  transition: box-shadow .15s;
  box-sizing: border-box;
}
.${namespace}-dd-search-input:focus {
  box-shadow: var(--${namespace}-sis, inset 2px 2px 5px var(--${namespace}-sd, #a3b1c6), inset -2px -2px 5px var(--${namespace}-sl, #ffffff)), 0 0 0 2px rgba(77, 124, 254, .55);
}

/* 选项滚动盒 */
.${namespace}-dd-options-box {
  flex: 1;
  overflow-y: auto;
  min-height: 0;
  padding: 2px;
}

/* ── 选项条目 (浮雕交互) ── */
.${namespace}-dd-option {
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: 8px 14px;
  margin: 3px 2px;
  border-radius: 12px;
  color: var(--${namespace}-ink, #4a5568);
  cursor: pointer;
  transition: all .15s ease;
  border: 0;
}

.${namespace}-dd-option:hover,
.${namespace}-dd-option--focused {
  box-shadow: var(--${namespace}-ss, 3px 3px 7px var(--${namespace}-sd, #a3b1c6), -3px -3px 7px var(--${namespace}-sl, #ffffff));
  color: var(--${namespace}-pri, #4d7cfe);
}

/* 选中项状态：内凹微槽高亮 */
.${namespace}-dd-option--selected {
  box-shadow: var(--${namespace}-sis, inset 2px 2px 5px var(--${namespace}-sd, #a3b1c6), inset -2px -2px 5px var(--${namespace}-sl, #ffffff));
  color: var(--${namespace}-pri, #4d7cfe);
  font-weight: 700;
}
.${namespace}-dd-option--selected .${namespace}-dd-label,
.${namespace}-dd-option--selected .${namespace}-dd-code {
  color: var(--${namespace}-pri, #4d7cfe);
}

/* 标签名称 */
.${namespace}-dd-label {
  font-weight: 600;
  white-space: nowrap;
  overflow: hidden;
  text-overflow: ellipsis;
}

/* 右侧 Code 代码标识 */
.${namespace}-dd-code {
  font-family: var(--${namespace}-m, monospace);
  font-weight: 700;
  font-size: 11px;
  color: var(--${namespace}-mu, #8390a6);
  letter-spacing: .06em;
  text-transform: uppercase;
  margin-left: 16px;
  flex-shrink: 0;
}

/* 禁用态 */
.${namespace}-dd-option--disabled {
  opacity: .35;
  cursor: not-allowed;
  pointer-events: none;
}

/* ── 悬停清除圆扣 ── */
.${namespace}-dd-clear {
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
  font-size: 13px;
  font-weight: 700;
  color: var(--${namespace}-mu, #8390a6);
  cursor: pointer;
  line-height: 1;
  transition: .15s;
}
.${namespace}-dd:hover .${namespace}-dd-clear {
  display: flex;
}
.${namespace}-dd-clear:hover {
  color: var(--${namespace}-red, #ec5b62);
  box-shadow: var(--${namespace}-sis, inset 2px 2px 5px var(--${namespace}-sd, #a3b1c6), inset -2px -2px 5px var(--${namespace}-sl, #ffffff));
}

/* ── 空结果 ── */
.${namespace}-dd-empty {
  padding: 20px 14px;
  font-weight: 600;
  color: var(--${namespace}-mu, #8390a6);
  text-align: center;
  font-size: 12.5px;
}

/* ── 关键字高亮 ── */
.${namespace}-dd-mark {
  background: rgba(77, 124, 254, .18);
  color: var(--${namespace}-pri, #4d7cfe);
  border-radius: 4px;
  padding: 1px 3px;
}

/* ── 尺寸变体 ── */
.${namespace}-dd--sm .${namespace}-dd-trigger {
  height: 30px;
  font-size: 12px;
  padding: 0 10px;
  border-radius: 10px;
}
.${namespace}-dd--lg .${namespace}-dd-trigger {
  height: 44px;
  font-size: 15px;
  padding: 0 16px;
  border-radius: 16px;
}

/* ── 无边框透明变体 ── */
.${namespace}-dd--plain .${namespace}-dd-trigger {
  background: transparent;
  box-shadow: none;
}
</style>