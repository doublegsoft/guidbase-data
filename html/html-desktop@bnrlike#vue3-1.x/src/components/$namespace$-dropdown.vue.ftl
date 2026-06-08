<template>
  <div ref="rootEl" class="${namespace}-dd" :class="[sizeClass, { '${namespace}-dd--plain': plain, '${namespace}-dd--disabled': disabled }]">
    <!-- Trigger -->
    <button
      ref="triggerEl"
      class="${namespace}-dd-trigger"
      :class="{ '${namespace}-dd-trigger--placeholder': !selectedOption }"
      type="button"
      :disabled="disabled"
      @click="togglePanel"
      @keydown="onTriggerKeydown"
    >
      {{ selectedOption ? selectedOption.label : placeholder }}
    </button>
    <span
      v-if="clearable && selectedOption"
      class="${namespace}-dd-clear"
      @click.stop="clearValue"
      title="清除选择"
    >×</span>

    <!-- Panel (teleported to body) -->
    <teleport to="body">
      <div
        v-if="open"
        ref="panelEl"
        class="${namespace}-dd-panel"
        :style="panelStyle"
        @click.stop
      >
        <!-- Search input -->
        <div v-if="searchable" class="${namespace}-dd-search">
          <input
            ref="searchEl"
            v-model="query"
            class="${namespace}-dd-search-input"
            type="text"
            placeholder="输入关键词筛选..."
            @keydown="onSearchKeydown"
          />
        </div>

        <!-- Options -->
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
            <span v-if="searchable && query" v-html="highlightLabel(opt.label, query)"></span>
            <span v-else>{{ opt.label }}</span>
          </div>
        </template>
        <div v-else class="${namespace}-dd-empty">无匹配结果</div>
      </div>
    </teleport>
  </div>
</template>

<script setup>
import { ref, computed, watch, nextTick, onMounted, onBeforeUnmount } from 'vue'

const props = defineProps({
  modelValue: { default: null },
  options: { type: Array, default: () => [] },
  placeholder: { type: String, default: '请选择...' },
  searchable: { type: Boolean, default: false },
  clearable: { type: Boolean, default: false },
  disabled: { type: Boolean, default: false },
  plain: { type: Boolean, default: false },
  size: { type: String, default: '' },
})

const emit = defineEmits(['update:modelValue'])

const rootEl = ref(null)
const triggerEl = ref(null)
const panelEl = ref(null)
const searchEl = ref(null)
const open = ref(false)
const query = ref('')
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
  return props.options.filter(o => String(o.label).toLowerCase().includes(q))
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
  open.value = !open.value
  if (open.value) {
    query.value = ''
    focusedIdx.value = -1
    nextTick(() => {
      positionPanel()
      searchEl.value?.focus()
    })
  }
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
  const spaceRight = window.innerWidth - rect.left

  panelStyle.value = {
    position: 'fixed',
    zIndex: '10000',
    top: spaceBelow >= 260 ? rect.bottom + 2 + 'px' : 'auto',
    bottom: spaceBelow < 260 ? window.innerHeight - rect.top + 2 + 'px' : 'auto',
    left: rect.left + 'px',
    minWidth: rect.width + 'px',
    maxWidth: Math.max(rect.width, 280) + 'px',
  }
}

// Keyboard: trigger
function onTriggerKeydown(e) {
  if (e.key === 'ArrowDown' || e.key === 'ArrowUp') {
    e.preventDefault()
    if (!open.value) togglePanel()
    else if (e.key === 'ArrowDown') focusedIdx.value = Math.min(focusedIdx.value + 1, filteredOptions.value.length - 1)
    else if (e.key === 'ArrowUp') focusedIdx.value = Math.max(focusedIdx.value - 1, 0)
  } else if (e.key === 'Escape') {
    closePanel()
    triggerEl.value?.focus()
  }
}

// Keyboard: search input / panel
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

// Panel position on scroll/resize
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

// Click outside
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
.${namespace}-dd {
  position: relative;
  display: inline-flex;
  width: 100%;
  min-width: 0;
}
.${namespace}-dd--disabled {
  opacity: .6;
  pointer-events: none;
}

/* ── Trigger ── */
.${namespace}-dd-trigger {
  display: flex;
  align-items: center;
  width: 100%;
  height: 22px;
  border: 1px solid var(--${namespace}-border);
  border-radius: var(--${namespace}-radius-sm);
  font-size: 12px;
  font-family: var(--${namespace}-font);
  padding: 0 22px 0 5px;
  background: var(--${namespace}-bg);
  color: var(--${namespace}-text);
  cursor: pointer;
  outline: none;
  position: relative;
  white-space: nowrap;
  overflow: hidden;
  text-overflow: ellipsis;
}
.${namespace}-dd-trigger:focus {
  border-color: var(--${namespace}-primary);
  box-shadow: 0 0 0 2px rgba(26,79,138,.08);
}
.${namespace}-dd-trigger::after {
  content: '';
  position: absolute;
  right: 7px;
  top: 50%;
  width: 0;
  height: 0;
  border-left: 4px solid transparent;
  border-right: 4px solid transparent;
  border-top: 5px solid var(--${namespace}-text-muted);
  transform: translateY(-50%);
  pointer-events: none;
}
.${namespace}-dd-trigger--placeholder {
  color: var(--${namespace}-text-light);
}

/* Plain variant — 无边框、无图标 */
.${namespace}-dd--plain .${namespace}-dd-trigger {
  border: none;
  background: transparent;
  padding: 0 4px;
  box-shadow: none;
}
.${namespace}-dd--plain .${namespace}-dd-trigger::after {
  content: none;
}
.${namespace}-dd--plain .${namespace}-dd-trigger:focus {
  box-shadow: none;
}

/* Size variants */
.${namespace}-dd--sm .${namespace}-dd-trigger { height: 20px; font-size: 11px; }
.${namespace}-dd--lg .${namespace}-dd-trigger { height: 28px; font-size: 13px; }

/* ── Dropdown panel ── */
.${namespace}-dd-panel {
  position: fixed;
  z-index: 10000;
  background: var(--${namespace}-bg);
  border: 1px solid var(--${namespace}-border);
  border-radius: var(--${namespace}-radius-md);
  box-shadow: 0 4px 16px rgba(0,0,0,.12);
  max-height: 260px;
  overflow-y: auto;
  overflow-x: hidden;
}

/* ── Search input (searchable mode) ── */
.${namespace}-dd-search {
  position: sticky;
  top: 0;
  z-index: 1;
  background: var(--${namespace}-bg);
  padding: 4px 6px;
  border-bottom: 1px solid var(--${namespace}-border-light);
}
.${namespace}-dd-search-input {
  width: 100%;
  height: 24px;
  border: 1px solid var(--${namespace}-border);
  border-radius: var(--${namespace}-radius-sm);
  padding: 0 6px;
  font-size: 12px;
  font-family: var(--${namespace}-font);
  color: var(--${namespace}-text);
  background: var(--${namespace}-bg);
  outline: none;
}
.${namespace}-dd-search-input:focus {
  border-color: var(--${namespace}-primary);
}

/* ── Options list ── */
.${namespace}-dd-option {
  display: flex;
  align-items: center;
  padding: 6px 10px;
  font-size: 12px;
  color: var(--${namespace}-text);
  cursor: pointer;
  white-space: nowrap;
  overflow: hidden;
  text-overflow: ellipsis;
  transition: background .1s;
}
.${namespace}-dd-option:hover,
.${namespace}-dd-option--focused {
  background: var(--${namespace}-primary-bg);
  color: var(--${namespace}-primary);
}
.${namespace}-dd-option--selected {
  background: var(--${namespace}-primary-bg);
  color: var(--${namespace}-primary);
  font-weight: bold;
}
.${namespace}-dd-option--selected::after {
  content: '✓';
  margin-left: auto;
  font-size: 11px;
  flex-shrink: 0;
}
.${namespace}-dd-option--disabled {
  color: var(--${namespace}-text-disabled);
  cursor: not-allowed;
}
.${namespace}-dd-option--disabled:hover {
  background: none;
  color: var(--${namespace}-text-disabled);
}

/* ── Clear button ── */
.${namespace}-dd-clear {
  position: absolute;
  right: 20px;
  top: 50%;
  transform: translateY(-55%);
  z-index: 1;
  width: 14px;
  height: 14px;
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 13px;
  color: var(--${namespace}-text-light);
  cursor: pointer;
  border-radius: 50%;
  transition: background .1s, color .1s;
  line-height: 1;
  pointer-events: auto;
}
.${namespace}-dd-clear:hover {
  background: var(--${namespace}-danger-bg);
  color: var(--${namespace}-danger);
}

/* ── Empty / no-results ── */
.${namespace}-dd-empty {
  padding: 14px 12px;
  font-size: 12px;
  color: var(--${namespace}-text-light);
  text-align: center;
}

/* ── Highlight match text ── */
.${namespace}-dd-mark {
  background: #fff3b0;
  color: var(--${namespace}-text);
}
</style>
