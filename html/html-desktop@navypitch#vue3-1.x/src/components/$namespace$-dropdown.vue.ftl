<template>
  <div
    class="ac-dd"
    :class="{
      'ac-dd--open': open,
      'ac-dd--disabled': disabled,
      'ac-dd--error': error,
    }"
    ref="rootRef"
    :data-test="dataTest"
  >
    <!-- ── Trigger ──────────────────────────────── -->
    <div
      class="ac-dd__trigger"
      :class="{
        'ac-dd__trigger--focus': open,
        'ac-dd__trigger--plain': plain,
      }"
      @click="toggleOpen"
      tabindex="0"
      @keydown.enter="toggleOpen"
      @keydown.space.prevent="toggleOpen"
      @keydown.escape="close"
      @keydown.up.prevent="highlightPrev"
      @keydown.down.prevent="highlightNext"
    >
      <span v-if="selectedOption" class="ac-dd__trigger-value">
        {{ selectedOption.label }}
      </span>
      <span v-else class="ac-dd__trigger-placeholder">
        {{ placeholder }}
      </span>

      <button
        v-if="hasValue && clearable && !disabled"
        class="ac-dd__trigger-clear"
        @click.stop="clearValue"
        title="清除选择"
      >✕</button>

      <span class="ac-dd__trigger-arrow" :class="{ 'ac-dd__trigger-arrow--flip': open }">▾</span>
    </div>

    <!-- ── Dropdown Panel ───────────────────────── -->
    <Transition name="ac-dd-drop">
      <div v-if="open" class="ac-dd__panel" @click.stop>
        <!-- Search -->
        <div class="ac-dd__search" v-if="searchable">
          <svg class="ac-dd__search-icon" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><circle cx="11" cy="11" r="8"/><path d="m21 21-4.35-4.35"/></svg>
          <input
            ref="searchRef"
            class="ac-dd__search-input"
            v-model="query"
            placeholder="输入关键词筛选…"
            @keydown.escape="close"
            @keydown.up.prevent="highlightPrev"
            @keydown.down.prevent="highlightNext"
            @keydown.enter.prevent="selectHighlighted"
          />
        </div>

        <!-- Options list -->
        <ul class="ac-dd__list" ref="listRef">
          <li
            v-for="(opt, idx) in filteredOptions"
            :key="opt.value"
            class="ac-dd__option"
            :class="{
              'ac-dd__option--selected': isSelected(opt),
              'ac-dd__option--highlighted': highlightedIndex === idx,
            }"
            @click="select(opt)"
          >
            <span class="ac-dd__option-label">{{ opt.label }}</span>
            <span v-if="isSelected(opt)" class="ac-dd__option-check">✓</span>
          </li>
          <li class="ac-dd__empty" v-if="filteredOptions.length === 0">
            <span>无匹配选项</span>
          </li>
        </ul>
      </div>
    </Transition>
  </div>
</template>

<script setup>
/**
 * AcDropdown — Academy Pro 下拉选择器
 *
 * 设计对齐 Academy Pro 设计系统:
 * - 触发框: 8px 圆角 · 1px E2EAF0 边框 · focus → teal 发光环
 * - 下拉面板: 12px 圆角 · card 白底 · 柔阴影 · 最大高度 280px 滚动
 * - 选项: 悬停 teal-dim 背景 · 选中 teal 文字 + ✓ 勾号
 * - 支持搜索过滤 · 键盘导航 · 点击外部关闭 · 动画过渡
 */
import { ref, computed, watch, nextTick, onMounted, onBeforeUnmount } from 'vue'

const props = defineProps({
  /** v-model 绑定值 */
  modelValue:    { type: [String, Number], default: '' },
  /** 选项列表 [{ label, value }] */
  options:       { type: Array,  default: () => [] },
  /** 占位提示 */
  placeholder:   { type: String, default: '请选择' },
  /** 是否可清除 */
  clearable:     { type: Boolean, default: true },
  /** 是否禁用 */
  disabled:      { type: Boolean, default: false },
  /** 是否可搜索 */
  searchable:    { type: Boolean, default: true },
  /** 是否校验错误 */
  error:         { type: Boolean, default: false },
  /** 朴素模式 — 无边框无背景，用于表格行内 */
  plain:         { type: Boolean, default: false },
  /** 测试标识 */
  dataTest:      { type: String,  default: '' },
})

const emit = defineEmits(['update:modelValue'])

// ── State ────────────────────────────────────────
const open = ref(false)
const query = ref('')
const highlightedIndex = ref(-1)
const rootRef = ref(null)
const searchRef = ref(null)
const listRef = ref(null)

// ── Computed ─────────────────────────────────────
const hasValue = computed(() => props.modelValue !== '' && props.modelValue != null)

const selectedOption = computed(() => {
  if (!hasValue.value) return null
  return props.options.find(o => o.value === props.modelValue) || null
})

const filteredOptions = computed(() => {
  if (!query.value.trim()) return props.options
  const q = query.value.trim().toLowerCase()
  return props.options.filter(o => String(o.label).toLowerCase().includes(q))
})

// ── Methods ──────────────────────────────────────
function isSelected(opt) {
  return opt.value === props.modelValue
}

function toggleOpen() {
  if (props.disabled) return
  open.value = !open.value
  if (open.value) {
    query.value = ''
    highlightedIndex.value = -1
    nextTick(() => searchRef.value?.focus())
  }
}

function close() {
  open.value = false
  highlightedIndex.value = -1
}

function select(opt) {
  emit('update:modelValue', opt.value)
  close()
}

function clearValue() {
  emit('update:modelValue', '')
  close()
}

function highlightPrev() {
  if (!open.value) { open.value = true; return }
  highlightedIndex.value = highlightedIndex.value <= 0
    ? filteredOptions.value.length - 1
    : highlightedIndex.value - 1
  scrollToHighlighted()
}

function highlightNext() {
  if (!open.value) { open.value = true; return }
  highlightedIndex.value = highlightedIndex.value >= filteredOptions.value.length - 1
    ? 0
    : highlightedIndex.value + 1
  scrollToHighlighted()
}

function selectHighlighted() {
  if (highlightedIndex.value >= 0 && highlightedIndex.value < filteredOptions.value.length) {
    select(filteredOptions.value[highlightedIndex.value])
  }
}

function scrollToHighlighted() {
  nextTick(() => {
    const el = listRef.value?.children[highlightedIndex.value]
    el?.scrollIntoView?.({ block: 'nearest' })
  })
}

// ── Click-outside ────────────────────────────────
function onPointerDown(e) {
  if (rootRef.value && !rootRef.value.contains(e.target)) {
    close()
  }
}

onMounted(() => document.addEventListener('pointerdown', onPointerDown, true))
onBeforeUnmount(() => document.removeEventListener('pointerdown', onPointerDown, true))

// ── Reset query when panel closes ────────────────
watch(open, (v) => {
  if (!v) query.value = ''
})
</script>

<style scoped>
/* ═══════════════════════════════════════════════════════════════════════════
   AcDropdown — Academy Pro 下拉选择器
   设计令牌: var(--color-*) var(--space-*) var(--radius-*) var(--shadow-*)
   ═══════════════════════════════════════════════════════════════════════════ */

.ac-dd {
  position: relative;
  width: 100%;
  font-family: var(--font-family-base);
}

/* ── Trigger ──────────────────────────────────── */

.ac-dd__trigger {
  display: flex;
  align-items: center;
  gap: var(--space-5);
  width: 100%;
  min-height: 36px;
  padding: var(--space-5) var(--space-7);
  border: 1px solid var(--color-border);
  border-radius: var(--radius-md);
  background: var(--color-card);
  cursor: pointer;
  transition: border-color var(--transition-base), box-shadow var(--transition-base);
  outline: none;
  user-select: none;
  position: relative;
}

.ac-dd__trigger:hover {
  border-color: #c8d6e0;
}

.ac-dd__trigger--focus,
.ac-dd__trigger:focus {
  border-color: var(--color-teal);
  box-shadow: 0 0 0 3px var(--color-teal-dim);
}

.ac-dd__trigger-value {
  flex: 1;
  font-size: var(--text-body);
  color: var(--color-text-main);
  overflow: hidden;
  text-overflow: ellipsis;
  white-space: nowrap;
  min-width: 0;
}

.ac-dd__trigger-placeholder {
  flex: 1;
  font-size: var(--text-body);
  color: var(--color-text-muted);
  min-width: 0;
}

/* Clear button */
.ac-dd__trigger-clear {
  display: flex;
  align-items: center;
  justify-content: center;
  width: 18px;
  height: 18px;
  border-radius: var(--radius-full);
  border: none;
  background: var(--color-text-muted);
  color: #fff;
  font-size: 10px;
  cursor: pointer;
  flex-shrink: 0;
  transition: background var(--transition-fast);
  padding: 0;
  line-height: 1;
}

.ac-dd__trigger-clear:hover {
  background: var(--color-red);
}

/* Arrow */
.ac-dd__trigger-arrow {
  font-size: var(--text-xs);
  color: var(--color-text-muted);
  transition: transform var(--transition-fast);
  flex-shrink: 0;
  line-height: 1;
}

.ac-dd__trigger-arrow--flip {
  transform: rotate(180deg);
}

/* ── Disabled State ───────────────────────────── */

.ac-dd--disabled .ac-dd__trigger {
  background: var(--color-surface);
  color: var(--color-text-sub);
  cursor: not-allowed;
  opacity: 0.7;
}

/* ── Plain Variant (表格行内) ─────────────────── */

.ac-dd__trigger--plain {
  border: none;
  background: transparent;
  padding: var(--space-3) var(--space-5);
  min-height: auto;
  box-shadow: none;
  border-radius: var(--radius-sm);
}

.ac-dd__trigger--plain:hover {
  background: var(--color-surface);
}

.ac-dd__trigger--plain.ac-dd__trigger--focus {
  box-shadow: none;
  background: var(--color-surface);
}

/* ── Error State ──────────────────────────────── */

.ac-dd--error .ac-dd__trigger {
  border-color: var(--color-red);
}

.ac-dd--error .ac-dd__trigger:focus {
  box-shadow: 0 0 0 3px var(--color-red-dim);
}

/* ── Dropdown Panel ───────────────────────────── */

.ac-dd__panel {
  position: absolute;
  top: calc(100% + var(--space-3));
  left: 0;
  right: 0;
  z-index: 500;
  background: var(--color-card);
  border: 1px solid var(--color-border);
  border-radius: var(--radius-xl);
  box-shadow: var(--shadow-md);
  overflow: hidden;
  min-width: 160px;
}

/* ── Search ───────────────────────────────────── */

.ac-dd__search {
  display: flex;
  align-items: center;
  gap: var(--space-5);
  padding: var(--space-6) var(--space-7);
  border-bottom: 1px solid var(--color-border);
}

.ac-dd__search-icon {
  color: var(--color-text-muted);
  flex-shrink: 0;
}

.ac-dd__search-input {
  flex: 1;
  border: none;
  outline: none;
  background: transparent;
  font-size: var(--text-md);
  color: var(--color-text-main);
  font-family: var(--font-family-base);
  min-width: 0;
}

.ac-dd__search-input::placeholder {
  color: var(--color-text-muted);
}

/* ── Options List ─────────────────────────────── */

.ac-dd__list {
  list-style: none;
  margin: 0;
  padding: var(--space-3) 0;
  max-height: 240px;
  overflow-y: auto;
}

.ac-dd__option {
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: var(--space-5) var(--space-9);
  font-size: var(--text-body);
  color: var(--color-text-main);
  cursor: pointer;
  transition: background var(--transition-fast), color var(--transition-fast);
  gap: var(--space-6);
}

.ac-dd__option:hover {
  background: var(--color-teal-dim);
}

.ac-dd__option--highlighted {
  background: var(--color-teal-dim);
}

.ac-dd__option--selected {
  color: var(--color-teal-text);
  font-weight: var(--weight-semibold);
}

.ac-dd__option--selected .ac-dd__option-check {
  color: var(--color-teal);
  font-weight: var(--weight-bold);
}

.ac-dd__option-label {
  flex: 1;
  overflow: hidden;
  text-overflow: ellipsis;
  white-space: nowrap;
  min-width: 0;
}

.ac-dd__option-check {
  flex-shrink: 0;
  font-size: var(--text-sm);
}

/* ── Empty State ──────────────────────────────── */

.ac-dd__empty {
  padding: var(--space-9) var(--space-9);
  text-align: center;
  color: var(--color-text-muted);
  font-size: var(--text-md);
}

/* ── Transition ───────────────────────────────── */

.ac-dd-drop-enter-active {
  transition: opacity var(--transition-smooth), transform var(--transition-smooth);
}

.ac-dd-drop-leave-active {
  transition: opacity 0.12s ease, transform 0.12s ease;
}

.ac-dd-drop-enter-from {
  opacity: 0;
  transform: translateY(-6px) scaleY(0.96);
}

.ac-dd-drop-leave-to {
  opacity: 0;
  transform: translateY(-4px) scaleY(0.97);
}
</style>
