<template>
  <div
    ref="wrapEl"
    class="${namespace}-tags"
    :class="{
      '${namespace}-tags--disabled': disabled,
      '${namespace}-tags--focus': isFocus,
      ['${namespace}-tags--' + size]: size,
      '${namespace}-tags--block': block,
      '${namespace}-tags--plain': plain,
    }"
  >
    <!-- 外层容器：直角、等宽、聚焦硬阴影 -->
    <div class="${namespace}-tags__wrap" @click="focusInput">
      <!-- 标签芯片列表 (Chips) -->
      <div class="${namespace}-tags__list">
        <span
          v-for="tag in tags"
          :key="caseSensitive ? tag : tag.toLowerCase()"
          class="${namespace}-tags__tag"
        >
          <span class="${namespace}-tags__tag-text">{{ tag }}</span>
          <b class="${namespace}-tags__tag-remove" @click.stop="removeTag(tag)">&times;</b>
        </span>

        <!-- 内嵌式无边框输入框 -->
        <input
          v-if="!reachedMax"
          ref="inputEl"
          v-model="inputText"
          class="${namespace}-tags__input"
          :placeholder="tags.length === 0 ? placeholder : ''"
          :disabled="disabled"
          :maxlength="maxTagLength"
          autocomplete="off"
          spellcheck="false"
          @keydown="onKeydown"
          @paste="onPaste"
          @focus="isFocus = true"
          @blur="onBlur"
        />
      </div>

      <!-- 终端等宽计数器 -->
      <div v-if="maxCount > 0" class="${namespace}-tags__counter">
        [{{ tags.length }}/{{ maxCount }}]
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, computed, watch } from 'vue'

const props = defineProps({
  modelValue:      { type: Array,    default: () => [] },
  placeholder:     { type: String,   default: '添加标签…' },
  maxCount:        { type: Number,   default: 0 },
  allowDuplicates: { type: Boolean,  default: false },
  caseSensitive:   { type: Boolean,  default: false },
  maxTagLength:    { type: Number,   default: 50 },
  disabled:        { type: Boolean,  default: false },
  size:            { type: String,   default: '' },
  block:           { type: Boolean,  default: false },
  plain:           { type: Boolean,  default: false },
  separator:       { type: Array,    default: null },
  onCreate:        { type: Function, default: null },
})

const emit = defineEmits(['update:modelValue', 'change', 'create', 'remove'])

const wrapEl  = ref(null)
const inputEl = ref(null)
const inputText = ref('')
const isFocus   = ref(false)
const tags = ref([...props.modelValue])

watch(() => props.modelValue, (v) => { tags.value = [...(v || [])] })

const seps = computed(() => {
  if (props.separator) return props.separator
  return [',', '\xFF0C', ';', '\xFF1B', '、']
})

const reachedMax = computed(() =>
  props.maxCount > 0 && tags.value.length >= props.maxCount
)

function eq(a, b) {
  return props.caseSensitive ? a === b : a.toLowerCase() === b.toLowerCase()
}

function has(tag) {
  return tags.value.some(t => eq(t, tag))
}

function addTag(raw) {
  let tag = raw.trim()
  if (!tag) return false
  if (tag.length > props.maxTagLength) tag = tag.substring(0, props.maxTagLength)
  if (!props.allowDuplicates && has(tag)) return false
  if (reachedMax.value) return false
  if (props.onCreate) {
    const result = props.onCreate(tag)
    if (result === false) return false
    if (typeof result === 'string') tag = result
  }
  tags.value.push(tag)
  emitChange()
  emit('create', tag)
  return true
}

function removeTag(tag) {
  const idx = tags.value.findIndex(t => eq(t, tag))
  if (idx < 0) return
  const removed = tags.value.splice(idx, 1)[0]
  emitChange()
  emit('remove', removed)
}

function clear() {
  tags.value = []
  emitChange()
}

function emitChange() {
  const copy = [...tags.value]
  emit('update:modelValue', copy)
  emit('change', copy)
}

function focusInput() {
  if (!props.disabled) inputEl.value?.focus()
}

function onKeydown(e) {
  if (props.disabled) return
  const val = inputText.value

  if (e.key === 'Enter') {
    e.preventDefault()
    splitAndAdd(val)
    inputText.value = ''
  } else if (seps.value.includes(e.key)) {
    e.preventDefault()
    splitAndAdd(val)
    inputText.value = ''
  } else if (e.key === 'Backspace' && val === '') {
    removeLast()
  }
}

function onPaste(e) {
  if (props.disabled) return
  const paste = (e.clipboardData || window.clipboardData).getData('text')
  const hasSep = seps.value.some(s => paste.includes(s))
  if (hasSep) {
    e.preventDefault()
    splitAndAdd(paste)
  }
}

function onBlur() {
  isFocus.value = false
  setTimeout(() => {
    if (inputText.value.trim()) {
      splitAndAdd(inputText.value)
      inputText.value = ''
    }
  }, 100)
}

function splitAndAdd(str) {
  const escaped = seps.value.map(s => s.replace(${r"/[.*+?^${}()|[\]\\]/g"}, '\\$&'))
  const re = new RegExp('[' + escaped.join('') + ']+')
  str.split(re).filter(s => s.trim()).forEach(s => addTag(s))
}

function removeLast() {
  if (tags.value.length === 0) return
  const removed = tags.value.pop()
  emitChange()
  emit('remove', removed)
}

defineExpose({
  getValue: () => [...tags.value],
  setValue: (arr) => { tags.value = [...(arr || [])]; emitChange() },
  addTag: (s) => { if (Array.isArray(s)) s.forEach(t => addTag(t)); else addTag(s) },
  removeTag: (s) => { if (Array.isArray(s)) s.forEach(t => removeTag(t)); else removeTag(s) },
  clear,
  focus: () => inputEl.value?.focus(),
})
</script>

<style scoped>
/* ══════════════════════════════════════════════
   Protocol Explorer TagsInput (Chips) 蓝图样式规范
   ══════════════════════════════════════════════ */
.${namespace}-tags {
  display: inline-flex;
  min-width: 200px;
  font-family: var(--${namespace}-f, "IBM Plex Mono", monospace);
  font-size: 13px;
  user-select: none;
  width: 100%;
}
.${namespace}-tags--block { display: flex; width: 100%; }
.${namespace}-tags--disabled { opacity: .45; }

/* ── 芯片容器外框 (参考 HTML .chips 规则) ── */
.${namespace}-tags__wrap {
  flex: 1;
  display: flex;
  align-items: center;
  justify-content: space-between;
  flex-wrap: wrap;
  gap: 6px;
  min-height: 34px;
  padding: 4px 8px;
  border: 1px solid var(--${namespace}-ln, #d3dbef);
  border-radius: 0;
  background: var(--${namespace}-pn, #ffffff);
  cursor: text;
  transition: .15s;
}

/* 聚焦时：物理上浮与实体墨水硬阴影 */
.${namespace}-tags--focus .${namespace}-tags__wrap {
  border-color: var(--${namespace}-pri, #0a2fb5);
  box-shadow: 3px 3px 0 color-mix(in srgb, var(--${namespace}-pri, #0a2fb5) 30%, transparent);
  transform: translate(-1px, -1px);
}
.${namespace}-tags--disabled .${namespace}-tags__wrap {
  background: var(--${namespace}-bg, #f4f6fb);
  cursor: not-allowed;
  transform: none;
  box-shadow: none;
  border-color: var(--${namespace}-ln, #d3dbef);
}

/* 芯片流式列表 */
.${namespace}-tags__list {
  display: flex;
  flex-wrap: wrap;
  align-items: center;
  gap: 6px;
  flex: 1;
  min-width: 0;
}

/* ── 标签芯片单元 (1:1 对齐 HTML .chips span) ── */
.${namespace}-tags__tag {
  display: inline-flex;
  align-items: center;
  background: color-mix(in srgb, var(--${namespace}-pri, #0a2fb5) 12%, transparent);
  border: 1px solid color-mix(in srgb, var(--${namespace}-pri, #0a2fb5) 20%, transparent);
  border-radius: 0;
  padding: 2px 6px 2px 8px;
  font-size: 12px;
  font-weight: 600;
  color: var(--${namespace}-ink, #0a2a9a);
  white-space: nowrap;
  letter-spacing: .05em;
  line-height: 1.4;
}

.${namespace}-tags__tag-text {
  overflow: hidden;
  text-overflow: ellipsis;
  white-space: nowrap;
  max-width: 140px;
}

/* 叉号删除键 (1:1 对齐 HTML .chips span b) */
.${namespace}-tags__tag-remove {
  font-style: normal;
  font-weight: bold;
  cursor: pointer;
  margin-left: 6px;
  color: var(--${namespace}-mu, #6f7fb4);
  font-size: 14px;
  line-height: 1;
  transition: color .12s;
}
.${namespace}-tags__tag-remove:hover {
  color: var(--${namespace}-red, #d6343e);
}

/* ── 输入框 (1:1 对齐 HTML .chips input) ── */
.${namespace}-tags__input {
  border: 0;
  outline: 0;
  background: none;
  flex: 1;
  min-width: 80px;
  height: 24px;
  font: inherit;
  font-size: 13px;
  color: var(--${namespace}-ink, #0a2a9a);
  padding: 0 4px;
  line-height: 24px;
}
.${namespace}-tags__input::placeholder {
  color: var(--${namespace}-mu, #6f7fb4);
  font-size: 12px;
}
.${namespace}-tags--disabled .${namespace}-tags__input {
  cursor: not-allowed;
}

/* 终端计数器 */
.${namespace}-tags__counter {
  font-size: 11px;
  font-weight: 700;
  color: var(--${namespace}-mu, #6f7fb4);
  letter-spacing: .05em;
  padding-left: 4px;
  flex-shrink: 0;
}

/* 尺寸变体 */
.${namespace}-tags--sm .${namespace}-tags__wrap { min-height: 26px; padding: 2px 6px; }
.${namespace}-tags--sm .${namespace}-tags__tag  { font-size: 11px; padding: 1px 4px 1px 6px; }
.${namespace}-tags--sm .${namespace}-tags__input { height: 20px; font-size: 11px; }

.${namespace}-tags--lg .${namespace}-tags__wrap { min-height: 40px; padding: 6px 10px; }
.${namespace}-tags--lg .${namespace}-tags__tag  { font-size: 13px; padding: 4px 8px; }
.${namespace}-tags--lg .${namespace}-tags__input { height: 28px; font-size: 14px; }

/* 无边框变体 */
.${namespace}-tags--plain .${namespace}-tags__wrap {
  border-color: transparent;
  background: transparent;
  box-shadow: none;
  transform: none;
}
</style>