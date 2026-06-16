<template>
  <div
    class="ms"
    :class="{ 'ms--open': open, 'ms--disabled': disabled }"
    ref="rootRef"
  >
    <div class="ms-trigger" @click="toggle" tabindex="0" @keydown.space.prevent="toggle" @keydown.escape="close">
      <div class="ms-tags" v-if="selected.length > 0">
        <span
          v-for="item in visibleTags"
          :key="item.value"
          class="ms-tag"
        >
          <span class="ms-tag__text">{{ item.label }}</span>
          <span class="ms-tag__x" @click.stop="remove(item.value)">&times;</span>
        </span>
        <span class="ms-overflow" v-if="hiddenCount > 0">+{{ hiddenCount }}</span>
      </div>
      <span class="ms-placeholder" v-else>{{ placeholder }}</span>
      <span class="ms-arrow" :class="{ 'ms-arrow--up': open }">▾</span>
    </div>

    <Teleport to="body">
      <Transition name="ms-drop">
        <div
          class="ms-drop"
          v-if="open"
          :style="dropStyle"
          ref="dropRef"
        >
          <div class="ms-search" v-if="searchable">
            <span class="ms-search__icon">🔍</span>
            <input
              ref="searchRef"
              class="ms-search__input"
              v-model="query"
              placeholder="搜索…"
              @keydown.escape="close"
            />
          </div>

          <ul class="ms-list">
            <li
              v-for="opt in filteredOptions"
              :key="opt.value"
              class="ms-option"
              :class="{ 'ms-option--checked': isSelected(opt.value) }"
              @click="toggleOption(opt)"
            >
              <span class="ms-checkbox" :class="{ 'ms-checkbox--on': isSelected(opt.value) }">
                <span v-if="isSelected(opt.value)">✓</span>
              </span>
              <span class="ms-option__label">{{ opt.label }}</span>
            </li>
            <li class="ms-empty" v-if="filteredOptions.length === 0">
              <span>无匹配选项</span>
            </li>
          </ul>

          <div class="ms-actions" v-if="selected.length > 0">
            <span class="ms-hint">{{ selected.length }} 项已选</span>
            <button class="ms-clear" @click="clear">清除全部</button>
          </div>
        </div>
      </Transition>
    </Teleport>
  </div>
</template>

<script setup>
import { ref, computed, watch, nextTick, onMounted, onBeforeUnmount } from 'vue'

const props = defineProps({
  modelValue: { type: Array, default: () => [] },
  options: { type: Array, default: () => [] },
  placeholder: { type: String, default: '请选择' },
  disabled: { type: Boolean, default: false },
  searchable: { type: Boolean, default: true },
})

const emit = defineEmits(['update:modelValue'])

const open = ref(false)
const query = ref('')
const rootRef = ref(null)
const searchRef = ref(null)
const dropRef = ref(null)
const dropStyle = ref({})

// allow controlling visible tag count
const MAX_TAGS = 3

const selected = computed(() => {
  const set = new Set(props.modelValue)
  return props.options.filter(o => set.has(o.value))
})

const visibleTags = computed(() => selected.value.slice(0, MAX_TAGS))
const hiddenCount = computed(() => Math.max(0, selected.value.length - MAX_TAGS))

const filteredOptions = computed(() => {
  const q = query.value.trim().toLowerCase()
  if (!q) return props.options
  return props.options.filter(o => o.label.toLowerCase().includes(q))
})

function isSelected(val) {
  return props.modelValue.includes(val)
}

function toggleOption(opt) {
  const arr = [...props.modelValue]
  const idx = arr.indexOf(opt.value)
  if (idx >= 0) {
    arr.splice(idx, 1)
  } else {
    arr.push(opt.value)
  }
  emit('update:modelValue', arr)
}

function remove(val) {
  const arr = props.modelValue.filter(v => v !== val)
  emit('update:modelValue', arr)
}

function clear() {
  emit('update:modelValue', [])
}

function calcDropPosition() {
  if (!rootRef.value) return
  const rect = rootRef.value.getBoundingClientRect()
  const gap = 4
  dropStyle.value = {
    position: 'fixed',
    top: rect.bottom + gap + 'px',
    left: rect.left + 'px',
    width: rect.width + 'px',
    minWidth: rect.width + 'px',
    maxWidth: rect.width + 'px',
  }
}

function toggle() {
  if (props.disabled) return
  open.value = !open.value
  if (open.value) {
    query.value = ''
    nextTick(() => {
      calcDropPosition()
      searchRef.value?.focus()
    })
  }
}

function close() {
  open.value = false
  query.value = ''
}

function onDocumentClick(e) {
  if (rootRef.value && !rootRef.value.contains(e.target)) {
    // also check the teleported dropdown
    if (dropRef.value && dropRef.value.contains(e.target)) return
    close()
  }
}

function onResizeOrScroll() {
  if (open.value) {
    calcDropPosition()
  }
}

onMounted(() => {
  document.addEventListener('click', onDocumentClick, true)
  window.addEventListener('resize', onResizeOrScroll, true)
  window.addEventListener('scroll', onResizeOrScroll, true)
})

onBeforeUnmount(() => {
  document.removeEventListener('click', onDocumentClick, true)
  window.removeEventListener('resize', onResizeOrScroll, true)
  window.removeEventListener('scroll', onResizeOrScroll, true)
})
</script>

<style scoped>
.ms {
  position: relative;
  width: 100%;
  font-size: var(--text-body);
  user-select: none;
}
.ms--disabled {
  opacity: 0.5;
  pointer-events: none;
}

/* trigger */
.ms-trigger {
  display: flex;
  align-items: center;
  gap: var(--space-3);
  /* min-height: 38px; */
  height: 38px;
  padding: var(--space-4) var(--space-8) var(--space-4) var(--space-6);
  border: 1px solid var(--color-border);
  border-radius: var(--radius-md);
  background: var(--color-card);
  cursor: pointer;
  transition: border-color var(--transition-base), box-shadow var(--transition-base);
  position: relative;
  flex-wrap: wrap;
}
.ms-trigger:hover {
  border-color: var(--color-teal);
}
.ms--open .ms-trigger {
  border-color: var(--color-teal);
  box-shadow: 0 0 0 3px color-mix(in srgb, var(--color-teal) 20%, transparent);
}

.ms-placeholder {
  color: var(--color-text-muted);
  flex: 1;
  /* line-height: 26px; */
}

.ms-arrow {
  position: absolute;
  right: var(--space-6);
  top: 50%;
  transform: translateY(-50%);
  color: var(--color-text-muted);
  font-size: var(--text-base);
  transition: transform var(--transition-fast);
}
.ms-arrow--up {
  transform: translateY(-50%) rotate(180deg);
}

/* tags */
.ms-tags {
  display: flex;
  flex-wrap: wrap;
  gap: var(--space-2);
  flex: 1;
  min-width: 0;
  padding: 2px 0;
}
.ms-tag {
  display: inline-flex;
  align-items: center;
  gap: 3px;
  padding: 1px 8px;
  background: color-mix(in srgb, var(--color-teal) 12%, transparent);
  color: var(--color-teal-hover, #00a88c);
  border-radius: var(--radius-pill);
  font-size: var(--text-base);
  font-weight: var(--weight-semibold);
  white-space: nowrap;
}
.ms-tag__x {
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
.ms-tag__x:hover {
  background: var(--color-teal);
  color: #fff;
}
.ms-overflow {
  display: inline-flex;
  align-items: center;
  padding: 1px 8px;
  background: var(--color-border);
  border-radius: var(--radius-pill);
  font-size: var(--text-base);
  font-weight: var(--weight-semibold);
  color: var(--color-text-sub);
}

/* dropdown — teleported to body, positioned with fixed */
.ms-drop {
  position: fixed;
  background: var(--color-card);
  border: 1px solid var(--color-border);
  border-radius: var(--radius-md);
  box-shadow: var(--shadow-lg);
  z-index: 9999;
  overflow: hidden;
}

/* search */
.ms-search {
  display: flex;
  align-items: center;
  gap: var(--space-4);
  padding: var(--space-5) var(--space-6);
  border-bottom: 1px solid var(--color-border);
}
.ms-search__icon {
  font-size: var(--text-xs);
  color: var(--color-text-muted);
  flex-shrink: 0;
}
.ms-search__input {
  flex: 1;
  border: none;
  outline: none;
  background: transparent;
  font-size: var(--text-sm);
  color: var(--color-text-main);
  padding: 0;
}
.ms-search__input::placeholder {
  color: var(--color-text-muted);
}

/* list */
.ms-list {
  list-style: none;
  margin: 0;
  padding: var(--space-2);
  max-height: 220px;
  overflow-y: auto;
}
.ms-option {
  display: flex;
  align-items: center;
  gap: var(--space-5);
  padding: var(--space-4) var(--space-5);
  border-radius: var(--radius-sm);
  cursor: pointer;
  transition: background var(--transition-fast);
  font-size: var(--text-sm);
  color: var(--color-text-main);
}
.ms-option:hover {
  background: var(--color-surface);
}

/* checkbox */
.ms-checkbox {
  width: 18px;
  height: 18px;
  border-radius: var(--radius-xs);
  border: 2px solid var(--color-border);
  display: inline-flex;
  align-items: center;
  justify-content: center;
  flex-shrink: 0;
  font-size: 11px;
  font-weight: var(--weight-extrabold);
  color: #fff;
  transition: all var(--transition-fast);
}
.ms-checkbox--on {
  background: var(--color-teal);
  border-color: var(--color-teal);
}

.ms-option__label {
  flex: 1;
  overflow: hidden;
  text-overflow: ellipsis;
  white-space: nowrap;
}

/* empty */
.ms-empty {
  padding: var(--space-10) var(--space-6);
  text-align: center;
  color: var(--color-text-muted);
  font-size: var(--text-sm);
}

/* actions bar */
.ms-actions {
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: var(--space-4) var(--space-6);
  border-top: 1px solid var(--color-border);
}
.ms-hint {
  font-size: var(--text-base);
  color: var(--color-text-muted);
}
.ms-clear {
  border: none;
  background: none;
  color: var(--color-red-hover);
  font-size: var(--text-xs);
  cursor: pointer;
  font-weight: var(--weight-semibold);
  padding: var(--space-2) var(--space-4);
  border-radius: var(--radius-sm);
  transition: background var(--transition-fast);
}
.ms-clear:hover {
  background: color-mix(in srgb, var(--color-red) 10%, transparent);
}

/* dropdown transition */
.ms-drop-enter-active,
.ms-drop-leave-active {
  transition: opacity var(--transition-fast), transform var(--transition-fast);
}
.ms-drop-enter-from,
.ms-drop-leave-to {
  opacity: 0;
  transform: translateY(-4px);
}
</style>
