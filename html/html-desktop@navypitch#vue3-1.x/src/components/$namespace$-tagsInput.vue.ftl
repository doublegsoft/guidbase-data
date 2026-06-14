<template>
  <div
    class="ti"
    :class="{ 'ti--focused': focused, 'ti--disabled': disabled, 'ti--full': isFull }"
    ref="rootRef"
  >
    <div class="ti-wrap" @click="focusInput">
      <span
        v-for="(tag, i) in modelValue"
        :key="i"
        class="ti-tag"
      >
        <span class="ti-tag__text">{{ tag }}</span>
        <span class="ti-tag__x" @click.stop="remove(i)">&times;</span>
      </span>
      <input
        ref="inputRef"
        class="ti-input"
        v-model="text"
        :placeholder="isFull ? '已达上限' : (modelValue.length === 0 ? placeholder : '')"
        :disabled="disabled || isFull"
        @keydown.enter.prevent="add"
        @keydown.,.prevent="add"
        @keydown.backspace="onBackspace"
        @focus="focused = true"
        @blur="handleBlur"
      />
    </div>
    <span class="ti-hint" v-if="maxTags && modelValue.length >= maxTags">
      已达上限 {{ maxTags }} 个
    </span>
  </div>
</template>

<script setup>
import { ref, computed, nextTick } from 'vue'

const props = defineProps({
  modelValue: { type: Array, default: () => [] },
  placeholder: { type: String, default: '输入后按回车添加' },
  disabled: { type: Boolean, default: false },
  maxTags: { type: Number, default: 0 },
  allowDuplicates: { type: Boolean, default: false },
})

const emit = defineEmits(['update:modelValue'])

const text = ref('')
const focused = ref(false)
const inputRef = ref(null)
const rootRef = ref(null)

const isFull = computed(() => props.maxTags > 0 && props.modelValue.length >= props.maxTags)

function add() {
  const val = text.value.trim()
  if (!val) return
  if (!props.allowDuplicates && props.modelValue.includes(val)) {
    text.value = ''
    return
  }
  if (isFull.value) return
  emit('update:modelValue', [...props.modelValue, val])
  text.value = ''
}

function remove(index) {
  const arr = [...props.modelValue]
  arr.splice(index, 1)
  emit('update:modelValue', arr)
}

function onBackspace() {
  if (text.value === '' && props.modelValue.length > 0) {
    remove(props.modelValue.length - 1)
  }
}

function handleBlur() {
  focused.value = false
  // add pending text on blur
  if (text.value.trim()) {
    add()
  }
}

function focusInput() {
  inputRef.value?.focus()
}
</script>

<style scoped>
.ti {
  width: 100%;
  font-size: var(--text-sm);
}
.ti--disabled {
  opacity: 0.5;
  pointer-events: none;
}

.ti-wrap {
  display: flex;
  flex-wrap: wrap;
  align-items: center;
  gap: var(--space-2);
  min-height: 38px;
  padding: var(--space-3) var(--space-6);
  border: 1px solid var(--color-border);
  border-radius: var(--radius-md);
  background: var(--color-card);
  cursor: text;
  transition: border-color var(--transition-base), box-shadow var(--transition-base);
}
.ti-wrap:hover {
  border-color: var(--color-teal);
}
.ti--focused .ti-wrap {
  border-color: var(--color-teal);
  box-shadow: 0 0 0 3px color-mix(in srgb, var(--color-teal) 20%, transparent);
}
.ti--full .ti-wrap {
  border-color: var(--color-amber);
}

/* tags */
.ti-tag {
  display: inline-flex;
  align-items: center;
  gap: 3px;
  padding: 1px 8px;
  background: color-mix(in srgb, var(--color-teal) 12%, transparent);
  color: var(--color-teal-hover, #00a88c);
  border-radius: var(--radius-pill);
  font-size: var(--text-xs);
  font-weight: var(--weight-semibold);
  white-space: nowrap;
  animation: ti-pop-in var(--transition-smooth) ease;
}
.ti-tag__x {
  flex-shrink: 0;
  width: 15px;
  height: 15px;
  border-radius: 50%;
  display: inline-flex;
  align-items: center;
  justify-content: center;
  cursor: pointer;
  font-size: 11px;
  line-height: 1;
  transition: all var(--transition-fast);
  margin-left: 1px;
}
.ti-tag__x:hover {
  background: var(--color-teal);
  color: #fff;
}

/* input */
.ti-input {
  flex: 1;
  min-width: 80px;
  height: 26px;
  border: none;
  outline: none;
  background: transparent;
  font-size: var(--text-sm);
  color: var(--color-text-main);
  padding: 0;
  font-family: inherit;
}
.ti-input::placeholder {
  color: var(--color-text-muted);
}

/* hint */
.ti-hint {
  display: block;
  margin-top: var(--space-2);
  font-size: var(--text-xs);
  color: var(--color-amber);
}

@keyframes ti-pop-in {
  from { opacity: 0; transform: scale(0.85); }
  to   { opacity: 1; transform: scale(1); }
}
</style>
