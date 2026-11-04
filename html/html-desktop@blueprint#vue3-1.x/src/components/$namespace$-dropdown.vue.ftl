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
    <!-- Trigger: 宽体蓝图触发器 (直角、硬阴影、无内置小图标) -->
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

      <!-- 仅在显式配置了 code 时显示代号，绝不显示 value -->
      <span v-if="selectedOption && selectedOption.code" class="${namespace}-dd-trigger-code">
        {{ selectedOption.code }}
      </span>

      <!-- 纯文本/线框直角折叠箭头 -->
      <span class="${namespace}-dd-arrow" :class="{ 'is-open': open }">▾</span>
    </button>

    <!-- 清除按钮 -->
    <span
      v-if="clearable && selectedOption && !disabled"
      class="${namespace}-dd-clear"
      title="CLEAR"
      @click.stop="clearValue"
    >&times;</span>

    <!-- 下拉面板 (Teleported to body) -->
    <teleport to="body">
      <div
        v-if="open"
        ref="panelEl"
        class="${namespace}-dd-panel"
        :style="panelStyle"
        @click.stop
      >
        <!-- 搜索输入框 (参考 HTML .in 规范) -->
        <div v-if="searchable" class="${namespace}-dd-search">
          <input
            ref="searchEl"
            v-model="query"
            class="${namespace}-dd-search-input"
            type="text"
            placeholder="FILTER..."
            autocomplete="off"
            @keydown="onSearchKeydown"
          />
        </div>

        <!-- 选项列表 (纯文字排版：主标签靠左，仅显式 code 靠右) -->
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

            <!-- 右侧仅在存在 code 时显示代码，无 code 则不显示任何内容 -->
            <span v-if="opt.code" class="${namespace}-dd-code">{{ opt.code }}</span>
          </div>
        </template>
        <div v-else class="${namespace}-dd-empty">NO MATCHES FOUND</div>
      </div>
    </teleport>
  </div>
</template>

<script setup>
import { ref, computed, watch, nextTick, onMounted, onBeforeUnmount } from 'vue'

const props = defineProps({
  modelValue:  { default: null },
  options:     { type: Array,   default: () => [] },
  placeholder: { type: String,  default: 'SELECT...' },
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
  
  // 保持宽体尺寸：默认最小 300px，若组件本体更宽则跟随自身宽度
  const minPanelWidth = Math.max(rect.width, 300)

  panelStyle.value = {
    position: 'fixed',
    zIndex: '10000',
    top: spaceBelow >= 320 ? (rect.bottom + 3) + 'px' : 'auto',
    bottom: spaceBelow < 320 ? (window.innerHeight - rect.top + 3) + 'px' : 'auto',
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
   Protocol Explorer Dropdown 蓝图样式规范
   ══════════════════════════════════════════════ */
.${namespace}-dd {
  position: relative;
  display: inline-flex;
  width: 100%;
  min-width: 220px;
  font-family: var(--${namespace}-f, "IBM Plex Mono", monospace);
  font-size: 13px;
  user-select: none;
}
.${namespace}-dd--disabled {
  opacity: .45;
  pointer-events: none;
}

/* ── 宽体触发按钮 (直角、物理硬阴影) ── */
.${namespace}-dd-trigger {
  display: flex;
  align-items: center;
  justify-content: space-between;
  width: 100%;
  height: 34px;
  border: 1px solid var(--${namespace}-ln, #d3dbef);
  border-radius: 0;
  padding: 0 10px;
  background: var(--${namespace}-pn, #ffffff);
  color: var(--${namespace}-ink, #0a2a9a);
  cursor: pointer;
  outline: none;
  transition: .15s;
  white-space: nowrap;
  font: inherit;
}
.${namespace}-dd-trigger:hover,
.${namespace}-dd--open .${namespace}-dd-trigger {
  border-color: var(--${namespace}-pri, #0a2fb5);
  transform: translate(-1px, -1px);
  box-shadow: 3px 3px 0 color-mix(in srgb, var(--${namespace}-pri, #0a2fb5) 30%, transparent);
}

/* 选中项标签 */
.${namespace}-dd-trigger-text {
  font-weight: 600;
  letter-spacing: .05em;
  color: var(--${namespace}-ink, #0a2a9a);
  margin-right: auto;
  overflow: hidden;
  text-overflow: ellipsis;
}

/* 显式 Code 缩写标识 */
.${namespace}-dd-trigger-code {
  font-weight: 700;
  color: var(--${namespace}-pri, #0a2fb5);
  margin-right: 8px;
  letter-spacing: .08em;
}

.${namespace}-dd-trigger--placeholder .${namespace}-dd-trigger-text {
  color: var(--${namespace}-mu, #6f7fb4);
  font-weight: normal;
}

/* 纯文本箭头 */
.${namespace}-dd-arrow {
  color: var(--${namespace}-mu, #6f7fb4);
  font-size: 13px;
  transition: transform .15s;
  line-height: 1;
}
.${namespace}-dd-arrow.is-open {
  transform: rotate(180deg);
  color: var(--${namespace}-pri, #0a2fb5);
}

/* ── 弹窗面板 (直角与 4px 实体硬阴影) ── */
.${namespace}-dd-panel {
  position: fixed;
  z-index: 10000;
  background: var(--${namespace}-pn, #ffffff);
  border: 1px solid var(--${namespace}-ink, #0a2a9a);
  border-radius: 0;
  box-shadow: 4px 4px 0 var(--${namespace}-ln, #d3dbef);
  max-height: 340px;
  overflow-y: auto;
  overflow-x: hidden;
  padding: 4px 0;
  box-sizing: border-box;
  font-family: var(--${namespace}-f, "IBM Plex Mono", monospace);
}

/* ── 搜索输入框 (参考 HTML .in 规范) ── */
.${namespace}-dd-search {
  position: sticky;
  top: -4px;
  z-index: 2;
  background: var(--${namespace}-pn, #ffffff);
  padding: 6px 8px;
  border-bottom: 1px solid var(--${namespace}-ln, #d3dbef);
}
.${namespace}-dd-search-input {
  width: 100%;
  height: 28px;
  border: 1px solid var(--${namespace}-ln, #d3dbef);
  border-radius: 0;
  padding: 0 8px;
  font: inherit;
  font-size: 12px;
  color: var(--${namespace}-ink, #0a2a9a);
  background: var(--${namespace}-bg, #f4f6fb);
  outline: none;
  transition: .15s;
}
.${namespace}-dd-search-input:focus {
  border-color: var(--${namespace}-pri, #0a2fb5);
  background: #ffffff;
}

/* ── 选项条目 (双端对齐、极客高亮) ── */
.${namespace}-dd-option {
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: 8px 14px;
  color: var(--${namespace}-ink, #0a2a9a);
  cursor: pointer;
  transition: background .12s;
  border-bottom: 1px solid color-mix(in srgb, var(--${namespace}-ln, #d3dbef) 40%, transparent);
}
.${namespace}-dd-option:last-child {
  border-bottom: none;
}

.${namespace}-dd-option:hover,
.${namespace}-dd-option--focused {
  background: color-mix(in srgb, var(--${namespace}-ln, #d3dbef) 40%, transparent);
}

/* 选中项状态 */
.${namespace}-dd-option--selected {
  background: color-mix(in srgb, var(--${namespace}-pri, #0a2fb5) 12%, transparent);
}
.${namespace}-dd-option--selected .${namespace}-dd-label,
.${namespace}-dd-option--selected .${namespace}-dd-code {
  color: var(--${namespace}-pri, #0a2fb5);
  font-weight: 700;
}

/* 标签名称 */
.${namespace}-dd-label {
  font-weight: 600;
  letter-spacing: .05em;
  white-space: nowrap;
  overflow: hidden;
  text-overflow: ellipsis;
}

/* 右侧仅在存在 code 时展示的缩写 */
.${namespace}-dd-code {
  font-weight: 700;
  color: var(--${namespace}-mu, #6f7fb4);
  letter-spacing: .08em;
  text-transform: uppercase;
  margin-left: 20px;
  flex-shrink: 0;
}

/* 禁用态 */
.${namespace}-dd-option--disabled {
  opacity: .35;
  cursor: not-allowed;
  pointer-events: none;
}

/* ── 清除按钮 ── */
.${namespace}-dd-clear {
  position: absolute;
  right: 28px;
  top: 50%;
  transform: translateY(-50%);
  width: 16px;
  height: 16px;
  display: none;
  align-items: center;
  justify-content: center;
  font-size: 14px;
  font-weight: 700;
  color: var(--${namespace}-mu, #6f7fb4);
  cursor: pointer;
}
.${namespace}-dd:hover .${namespace}-dd-clear {
  display: flex;
}
.${namespace}-dd-clear:hover {
  color: var(--${namespace}-red, #d6343e);
}

/* ── 空结果 ── */
.${namespace}-dd-empty {
  padding: 16px;
  font-weight: 700;
  color: var(--${namespace}-mu, #6f7fb4);
  text-align: center;
  letter-spacing: .08em;
  font-size: 12px;
}

/* ── 关键字高亮 ── */
.${namespace}-dd-mark {
  background: var(--${namespace}-cmd, #f0a500);
  color: #000000;
  padding: 0 2px;
}

/* ── 尺寸变体 ── */
.${namespace}-dd--sm .${namespace}-dd-trigger { height: 26px; font-size: 11px; padding: 0 8px; }
.${namespace}-dd--lg .${namespace}-dd-trigger { height: 40px; font-size: 14px; padding: 0 14px; }

/* ── 无边框变体 ── */
.${namespace}-dd--plain .${namespace}-dd-trigger {
  border-color: transparent;
  background: transparent;
  box-shadow: none;
  transform: none;
}
</style>