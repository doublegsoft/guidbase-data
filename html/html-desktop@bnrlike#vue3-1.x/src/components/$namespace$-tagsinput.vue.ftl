<template>
  <div
    ref="wrapEl"
    class="${namespace}-tags"
    :class="{
      '${namespace}-tags--disabled': disabled,
      '${namespace}-tags--focus': isFocus,
      ['${namespace}-tags--' + size]: size,
      '${namespace}-tags--block': block,
    }"
  >
    <div class="${namespace}-tags__wrap" @click="focusInput">
      <!-- 标签列表 -->
      <TransitionGroup name="tag" tag="div" class="${namespace}-tags__list">
        <span
          v-for="tag in tags"
          :key="caseSensitive ? tag : tag.toLowerCase()"
          class="${namespace}-tags__tag">
          <span class="${namespace}-tags__tag-text">{{ tag }}</span>
          <span class="${namespace}-tags__tag-remove" @click.stop="removeTag(tag)">&times;</span>
        </span>
      </TransitionGroup>

      <!-- 输入框 -->
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

    <!-- 计数 -->
  </div>
</template>

<script setup>
import { ref, computed, watch, nextTick } from 'vue'

const props = defineProps({
  modelValue:      { type: Array,    default: () => [] },
  placeholder:     { type: String,   default: '输入后回车添加...' },
  maxCount:        { type: Number,   default: 0 },
  allowDuplicates: { type: Boolean,  default: false },
  caseSensitive:   { type: Boolean,  default: false },
  maxTagLength:    { type: Number,   default: 50 },
  disabled:        { type: Boolean,  default: false },
  size:            { type: String,   default: '' },
  block:           { type: Boolean,  default: false },
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
  return [',', '\xFF0C', ';', '\xFF1B', '、'] // ,，;；、
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

// ── keyboard ──
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
  // 失焦自动创建
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

// expose
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
/* ═══════════════════════════════════════════
   BNR TagsInput — ${namespace}-tags
   ═══════════════════════════════════════════ */

.${namespace}-tags {
  align-items: center;
  gap: 6px;
  min-width: 200px;
  font-family: var(--${namespace}-font, "Microsoft YaHei", sans-serif);
  font-size: 12px;
  flex: 1;
}
.${namespace}-tags--block { display: flex; width: 100%; }
.${namespace}-tags--disabled { opacity: .6; }

.${namespace}-tags__wrap {
  flex: 1;
  display: flex;
  flex-wrap: wrap;
  align-items: center;
  gap: 4px;
  min-height: 24px;
  border: 1px solid var(--${namespace}-border);
  border-radius: 2px;
  background: var(--${namespace}-bg);
  cursor: text;
  transition: border-color .15s, box-shadow .15s;
}
.${namespace}-tags--focus .${namespace}-tags__wrap {
  border-color: var(--${namespace}-primary);
  box-shadow: 0 0 0 2px rgba(190,0,0,.15);
}
.${namespace}-tags--disabled .${namespace}-tags__wrap {
  background: var(--${namespace}-bg-page);
  cursor: not-allowed;
}

.${namespace}-tags__list {
  display: flex;
  flex-wrap: wrap;
  align-items: center;
  gap: 4px;
}

.${namespace}-tags__tag {
  display: inline-flex;
  align-items: center;
  gap: 2px;
  height: 18px;
  padding: 0 4px;
  background: var(--${namespace}-primary-bg);
  border: 1px solid var(--${namespace}-primary-border);
  border-radius: 2px;
  font-size: 10px;
  color: var(--${namespace}-primary);
  white-space: nowrap;
  max-width: 120px;
}
.${namespace}-tags__tag:hover {
  background: linear-gradient(135deg, var(--${namespace}-primary-hover), var(--${namespace}-primary-border));
}
.${namespace}-tags__tag-text {
  max-width: 100px;
  overflow: hidden;
  text-overflow: ellipsis;
}
.${namespace}-tags__tag-remove {
  font-size: 13px;
  color: var(--${namespace}-text-muted);
  cursor: pointer;
  line-height: 1;
  flex-shrink: 0;
  transition: color .1s;
}
.${namespace}-tags__tag-remove:hover { color: var(--${namespace}-danger); }

/* TransitionGroup */
.tag-enter-active { transition: all .15s ease-out; }
.tag-leave-active { transition: all .1s ease-in; }
.tag-enter-from   { transform: scale(.85); opacity: 0; }
.tag-leave-to     { transform: scale(.85); opacity: 0; }

.${namespace}-tags__input {
  flex: 1;
  min-width: 60px;
  height: 20px;
  border: none;
  outline: none;
  background: transparent;
  font-size: 12px;
  font-family: inherit;
  color: var(--${namespace}-text);
  padding: 0;
  line-height: 20px;
}
.${namespace}-tags__input::placeholder { color: var(--${namespace}-text-light); }
.${namespace}-tags--disabled .${namespace}-tags__input { cursor: not-allowed; }

.${namespace}-tags__counter {
  font-size: 10px;
  color: var(--${namespace}-text-light);
  white-space: nowrap;
  flex-shrink: 0;
}

.${namespace}-tags--sm .${namespace}-tags__wrap { min-height: 22px; padding: 2px 5px; }
.${namespace}-tags--sm .${namespace}-tags__tag  { height: 17px; font-size: 10px; padding: 0 5px; }
.${namespace}-tags--sm .${namespace}-tags__input { height: 17px; font-size: 11px; }
.${namespace}-tags--lg .${namespace}-tags__wrap { min-height: 30px; padding: 4px 8px; }
.${namespace}-tags--lg .${namespace}-tags__tag  { height: 24px; font-size: 12px; padding: 0 8px; }
.${namespace}-tags--lg .${namespace}-tags__input { height: 24px; font-size: 13px; }
</style>
