<template>
  <div ref="wrapEl" class="${namespace}-ac" :class="{ '${namespace}-ac--disabled': disabled, '${namespace}-ac--open': isOpen }">
    <!-- 输入框 -->
    <div class="${namespace}-ac__input-wrap">
      <input
        ref="inputEl"
        v-model="inputText"
        class="${namespace}-ac__input"
        :placeholder="placeholder"
        :disabled="disabled"
        autocomplete="off"
        role="combobox"
        :aria-expanded="isOpen"
        @input="onInput"
        @keydown="onKeydown"
        @focus="onFocus"
        @blur="onBlur"
      />
      <!-- 清除按钮 -->
      <span v-if="inputText && !disabled" class="${namespace}-ac__clear" @mousedown.prevent="clear">×</span>
      <!-- 加载中 -->
      <span v-if="loading" class="${namespace}-ac__loading">⟳</span>
    </div>

    <!-- 下拉面板（teleport 到 body） -->
    <teleport to="body">
      <div
        v-if="isOpen"
        ref="panelEl"
        class="${namespace}-ac__panel"
        :style="panelStyle"
        @mousedown.prevent
      >
        <!-- 搜索中提示 -->
        <div v-if="loading" class="${namespace}-ac__status">搜索中...</div>

        <!-- 无结果 -->
        <div v-else-if="filteredOptions.length === 0" class="${namespace}-ac__empty">
          {{ emptyText }}
        </div>

        <!-- 选项列表 -->
        <template v-else>
          <!-- 结果数量提示 -->
          <div v-if="filteredOptions.length > 1" class="${namespace}-ac__count">
            找到 {{ filteredOptions.length }} 条结果
          </div>
          <div
            v-for="(opt, idx) in filteredOptions"
            :key="opt.value"
            class="${namespace}-ac__option"
            :class="{
              '${namespace}-ac__option--focused': idx === focusedIdx,
              '${namespace}-ac__option--selected': opt.value === modelValue,
            }"
            @click="selectOption(opt)"
            @mouseenter="focusedIdx = idx"
          >
            <!-- 自定义渲染 -->
            <slot name="option" :option="opt" :query="inputText">
              <!-- 默认：高亮匹配文字 -->
              <span class="${namespace}-ac__opt-label" v-html="highlight(opt.label)"></span>
              <span v-if="opt.desc" class="${namespace}-ac__opt-desc">{{ opt.desc }}</span>
              <span v-if="opt.tag" class="${namespace}-ac__opt-tag" :class="opt.tagCls||'tag-grey'">{{ opt.tag }}</span>
            </slot>
          </div>
        </template>
      </div>
    </teleport>
  </div>
</template>

<script setup>
import { ref, computed, watch, nextTick, onBeforeUnmount } from 'vue'

const props = defineProps({
  modelValue:  { default: null },                    // 绑定值（value）
  options:     { type: Array,    default: () => [] }, // 静态选项 [{value, label, desc?, tag?}]
  placeholder: { type: String,   default: '请输入搜索关键词...' },
  disabled:    { type: Boolean,  default: false },
  emptyText:   { type: String,   default: '无匹配结果' },
  minLength:   { type: Number,   default: 1 },       // 触发搜索的最少字符数
  maxResults:  { type: Number,   default: 20 },      // 最多显示条数
  filterFn:    { type: Function, default: null },    // 自定义过滤函数 (option, query) => bool
  fetchFn:     { type: Function, default: null },    // 异步搜索函数 async (query) => options[]
  valueKey:    { type: String,   default: 'value' }, // 选项的 value 字段名
  labelKey:    { type: String,   default: 'label' }, // 选项的 label 字段名
})

const emit = defineEmits(['update:modelValue', 'select', 'clear', 'search'])

const wrapEl    = ref(null)
const inputEl   = ref(null)
const panelEl   = ref(null)
const inputText = ref('')
const isOpen    = ref(false)
const focusedIdx= ref(-1)
const loading   = ref(false)
const asyncOpts = ref([])
const panelStyle= ref({})

// 当外部 modelValue 变化时，同步 inputText 显示 label
watch(() => props.modelValue, (val) => {
  if (val === null || val === undefined || val === '') {
    inputText.value = ''
    return
  }
  const opt = props.options.find(o => String(o[props.valueKey]) === String(val))
  if (opt) inputText.value = opt[props.labelKey]
}, { immediate: true })

// 过滤后的选项
const filteredOptions = computed(() => {
  const q = inputText.value.trim().toLowerCase()
  if (!q || q.length < props.minLength) return []

  // 异步模式
  if (props.fetchFn) return asyncOpts.value.slice(0, props.maxResults)

  // 静态过滤
  const source = props.options
  let results
  if (props.filterFn) {
    results = source.filter(o => props.filterFn(o, q))
  } else {
    results = source.filter(o => {
      const label = String(o[props.labelKey] || '').toLowerCase()
      const value = String(o[props.valueKey] || '').toLowerCase()
      const desc  = String(o.desc || '').toLowerCase()
      return label.includes(q) || value.includes(q) || desc.includes(q)
    })
  }
  return results.slice(0, props.maxResults)
})

// 高亮匹配文字
function highlight(text) {
  const q = inputText.value.trim()
  if (!q) return text
  const escaped = q.replace(${r"/[.*+?^${}()|[\]\\]/g"}, '\\$&')
  return String(text).replace(
    new RegExp(escaped, 'gi'),
    m => `<mark class="${namespace}-ac__mark">${r"${m}"}</mark>`
  )
}

// 输入事件
let debounceTimer = null
function onInput() {
  focusedIdx.value = -1
  const q = inputText.value.trim()

  // 清空时重置
  if (!q) {
    emit('update:modelValue', null)
    closePanel()
    return
  }

  if (q.length < props.minLength) {
    closePanel()
    return
  }

  emit('search', q)

  // 异步搜索
  if (props.fetchFn) {
    clearTimeout(debounceTimer)
    debounceTimer = setTimeout(async () => {
      loading.value = true
      openPanel()
      try {
        asyncOpts.value = await props.fetchFn(q)
      } finally {
        loading.value = false
      }
    }, 300)
    return
  }

  // 静态搜索
  openPanel()
}

function onFocus() {
  if (inputText.value.trim().length >= props.minLength) openPanel()
}

function onBlur() {
  // 延迟关闭，允许点击选项
  setTimeout(() => {
    if (!wrapEl.value?.contains(document.activeElement)) closePanel()
  }, 150)
}

function onKeydown(e) {
  if (!isOpen.value) return
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
    inputEl.value?.blur()
  } else if (e.key === 'Tab') {
    closePanel()
  }
}

function scrollFocused() {
  nextTick(() => {
    const el = panelEl.value?.querySelectorAll('.${namespace}-ac__option')[focusedIdx.value]
    el?.scrollIntoView({ block: 'nearest' })
  })
}

function selectOption(opt) {
  inputText.value = opt[props.labelKey]
  emit('update:modelValue', opt[props.valueKey])
  emit('select', opt)
  closePanel()
  inputEl.value?.blur()
}

function clear() {
  inputText.value = ''
  emit('update:modelValue', null)
  emit('clear')
  closePanel()
  nextTick(() => inputEl.value?.focus())
}

// 面板定位（teleport 到 body，同 BnrDropdown 逻辑）
function positionPanel() {
  if (!inputEl.value) return
  const rect = inputEl.value.getBoundingClientRect()
  const wrapRect = wrapEl.value.getBoundingClientRect()
  const panelW = 320
  const panelH = 280
  const spaceBelow = window.innerHeight - rect.bottom
  const spaceRight = window.innerWidth - wrapRect.left

  const top    = spaceBelow >= panelH || spaceBelow >= 120 ? rect.bottom + 2 : 'auto'
  const bottom = spaceBelow < panelH && spaceBelow < 120 ? window.innerHeight - rect.top + 2 : 'auto'
  const left   = spaceRight >= panelW ? wrapRect.left : 'auto'
  const right  = spaceRight < panelW ? window.innerWidth - wrapRect.right : 'auto'

  panelStyle.value = {
    position: 'fixed',
    zIndex: '99999',
    top:    top    !== 'auto' ? top    + 'px' : 'auto',
    bottom: bottom !== 'auto' ? bottom + 'px' : 'auto',
    left:   left   !== 'auto' ? left   + 'px' : 'auto',
    right:  right  !== 'auto' ? right  + 'px' : 'auto',
    minWidth: wrapRect.width + 'px',
    maxWidth: Math.max(wrapRect.width, panelW) + 'px',
  }
}

function openPanel() {
  isOpen.value = true
  nextTick(positionPanel)
  onScrollResize = () => positionPanel()
  window.addEventListener('scroll', onScrollResize, true)
  window.addEventListener('resize', onScrollResize)
}

function closePanel() {
  isOpen.value = false
  focusedIdx.value = -1
  if (onScrollResize) {
    window.removeEventListener('scroll', onScrollResize, true)
    window.removeEventListener('resize', onScrollResize)
    onScrollResize = null
  }
}

let onScrollResize = null
onBeforeUnmount(() => {
  closePanel()
  clearTimeout(debounceTimer)
})

// 点击外部关闭
function onDocClick(e) {
  if (!wrapEl.value?.contains(e.target) && !panelEl.value?.contains(e.target)) {
    closePanel()
  }
}
import { onMounted } from 'vue'
onMounted(() => document.addEventListener('click', onDocClick, true))
onBeforeUnmount(() => document.removeEventListener('click', onDocClick, true))
</script>

<style scoped>
.${namespace}-ac { position: relative; display: inline-flex; width: 100%; }
.${namespace}-ac--disabled { opacity: .6; pointer-events: none; }

.${namespace}-ac__input-wrap {
  position: relative; display: flex; align-items: center; width: 100%;
}
.${namespace}-ac__input {
  width: 100%; height: 24px;
  border: 1px solid #c8c8c8; border-radius: 2px;
  padding: 0 28px 0 8px;
  font-size: 12px; font-family: inherit; color: #1c2833;
  background: #fff; outline: none;
  transition: border-color .15s, box-shadow .15s;
}
.${namespace}-ac__input:focus {
  border-color: #1a4f8a;
  box-shadow: 0 0 0 2px rgba(26,79,138,.1);
}
.${namespace}-ac--open .${namespace}-ac__input { border-color: #1a4f8a; }

.${namespace}-ac__clear, .${namespace}-ac__loading {
  position: absolute; right: 6px;
  font-size: 14px; color: #909eac; cursor: pointer; line-height: 1;
  user-select: none;
}
.${namespace}-ac__clear:hover { color: #333; }
.${namespace}-ac__loading { animation: ${namespace}-ac-spin .8s linear infinite; }
@keyframes ${namespace}-ac-spin { to { transform: rotate(360deg); } }

/* 下拉面板 */
.${namespace}-ac__panel {
  background: #fff;
  border: 1px solid #d0d8e8;
  border-radius: 2px;
  box-shadow: 0 4px 16px rgba(0,0,0,.12);
  max-height: 280px;
  overflow-y: auto;
  overflow-x: hidden;
}

.${namespace}-ac__count {
  padding: 5px 10px;
  font-size: 11px; color: #909eac;
  border-bottom: 1px solid #f0f2f5;
  background: #f8f9fa;
}

.${namespace}-ac__status, .${namespace}-ac__empty {
  padding: 14px 12px;
  font-size: 12px; color: #909eac; text-align: center;
}

.${namespace}-ac__option {
  display: flex; align-items: center; gap: 8px;
  padding: 7px 12px;
  font-size: 12px; color: #1c2833;
  cursor: pointer;
  border-bottom: 1px solid #f5f7fa;
  transition: background .1s;
}
.${namespace}-ac__option:last-child { border-bottom: none; }
.${namespace}-ac__option--focused  { background: #eef5ff; }
.${namespace}-ac__option--selected { background: #e8edf5; }
.${namespace}-ac__option--selected .${namespace}-ac__opt-label { color: #1a4f8a; font-weight: bold; }

.${namespace}-ac__opt-label { flex: 1; }
.${namespace}-ac__opt-desc  { font-size: 11px; color: #909eac; flex-shrink: 0; }
.${namespace}-ac__opt-tag   {
  font-size: 10px; padding: 1px 5px; border-radius: 2px;
  border: 1px solid; flex-shrink: 0; white-space: nowrap;
}
.tag-grey   { background: #f0f0f0; color: #5d6d7e; border-color: #d9d9d9; }
.tag-blue   { background: #e8edf5; color: #1a4f8a; border-color: #d0d8e8; }
.tag-green  { background: #e6f5e6; color: #1e8449; border-color: #8cc88c; }
.tag-orange { background: #fef3e6; color: #d46b08; border-color: #e8b87a; }
.tag-red    { background: #fcecea; color: #c0392b; border-color: #f0a0a0; }
</style>
