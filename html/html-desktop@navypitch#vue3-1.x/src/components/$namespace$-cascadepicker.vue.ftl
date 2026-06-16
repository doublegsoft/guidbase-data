<template>
  <div
    class="cp-root"
    :class="{ 'cp--open': open, 'cp--disabled': disabled, 'cp--error': error }"
    ref="rootRef"
    :data-test="dataTest"
  >
    <!-- ── Trigger ──────────────────────────────── -->
    <div
      class="cp-trigger"
      @click="toggleOpen"
      tabindex="0"
      @keydown.enter="toggleOpen"
      @keydown.space.prevent="toggleOpen"
      @keydown.escape="close"
    >
      <span v-if="selectedPath.length" class="cp-trigger-value">
        {{ pathDisplay }}
      </span>
      <span v-else class="cp-trigger-placeholder">
        {{ placeholder }}
      </span>

      <button
        v-if="hasValue && clearable && !disabled"
        class="cp-trigger-clear"
        @click.stop="clearValue"
        title="清除"
      >✕</button>

      <span class="cp-trigger-arrow" :class="{ 'cp-trigger-arrow--flip': open }">▾</span>
    </div>

    <!-- ── Dropdown Panel ───────────────────────── -->
    <Transition name="cp-panel">
      <div v-if="open" class="cp-panel" @click.stop>
        <!-- Breadcrumb — only shown when path is deeper than level 1 -->
        <div class="cp-breadcrumb" v-if="selectedPath.length > 0">
          <template v-for="(p, i) in selectedPath" :key="p.value">
            <span
              class="cp-breadcrumb__item"
              :class="{ 'cp-breadcrumb__item--active': i === selectedPath.length - 1 && i === activeColumn }"
              @click="navigateTo(i)"
            >{{ p.label }}</span>
            <span v-if="i < selectedPath.length - 1" class="cp-breadcrumb__sep">›</span>
          </template>
        </div>

        <!-- Columns -->
        <div class="cp-columns" ref="columnsRef">
          <div
            v-for="(col, ci) in columns"
            :key="ci"
            class="cp-column"
          >
            <ul class="cp-column__list">
              <li
                v-for="opt in col.options"
                :key="opt.value"
                class="cp-column__option"
                :class="{
                  'cp-column__option--active': col.selectedValue === opt.value,
                  'cp-column__option--loading': col.loadingValue === opt.value,
                }"
                @click="onOptionClick(ci, opt)"
              >
                <span class="cp-column__option-label">{{ opt.label }}</span>
                <span v-if="opt.hasChildren" class="cp-column__option-arrow">›</span>
                <span v-if="col.loadingValue === opt.value" class="cp-column__option-spinner"></span>
              </li>
              <li class="cp-column__empty" v-if="col.loading && col.options.length === 0">
                加载中…
              </li>
              <li class="cp-column__empty" v-if="!col.loading && col.options.length === 0">
                暂无数据
              </li>
            </ul>
          </div>
        </div>
      </div>
    </Transition>

    <!-- ── Overlay ──────────────────────────────── -->
    <Transition name="cp-overlay">
      <div v-if="open" class="cp-overlay" @click="close"></div>
    </Transition>
  </div>
</template>

<script setup>
import { ref, computed, watch, nextTick, onMounted, onBeforeUnmount } from 'vue'

/* ───────────────────────────────────────────────
   Props
   ─────────────────────────────────────────────── */

const props = defineProps({
  /** v-model: selected leaf value */
  modelValue:    { type: [String, Number], default: '' },

  /** Async function: (parentValue|null) => Promise<[{value,label,hasChildren}]> */
  fetchOptions:  { type: Function, required: true },

  /** Placeholder text */
  placeholder:   { type: String, default: '请选择' },

  /** Show clear button */
  clearable:     { type: Boolean, default: true },

  /** Disabled state */
  disabled:      { type: Boolean, default: false },

  /** Error state */
  error:         { type: Boolean, default: false },

  /** Test identifier */
  dataTest:      { type: String, default: '' },
})

/* ───────────────────────────────────────────────
   Emits
   ─────────────────────────────────────────────── */

const emit = defineEmits(['update:modelValue'])

/* ───────────────────────────────────────────────
   State
   ─────────────────────────────────────────────── */

const open = ref(false)
const rootRef = ref(null)
const columnsRef = ref(null)

// Each column: { options, selectedValue, loading, loadingValue }
const columns = ref([])

// Selected path: [{ value, label }] from root to current selection
const selectedPath = ref([])

// Tracking which column is the "active" one (showing options for the next level)
const activeColumn = ref(-1)

/* ───────────────────────────────────────────────
   Computed
   ─────────────────────────────────────────────── */

const hasValue = computed(() => props.modelValue !== '' && props.modelValue != null)

const pathDisplay = computed(() => {
  if (selectedPath.value.length === 0) return ''
  return selectedPath.value.map(p => p.label).join(' / ')
})

/* ───────────────────────────────────────────────
   Methods — Open / Close
   ─────────────────────────────────────────────── */

async function toggleOpen() {
  if (props.disabled) return
  open.value = !open.value
  if (open.value) {
    // If root data is already loaded (pre-fetched on mount), just reset UI state
    if (columns.value.length > 0 && !columns.value[0].loading && columns.value[0].options.length > 0) {
      columns.value = columns.value.slice(0, 1)
      selectedPath.value = []
      activeColumn.value = 0
      columns.value.forEach(c => { c.selectedValue = null })
    } else {
      await initColumns()
    }
  }
}

async function initColumns() {
  columns.value = []
  selectedPath.value = []
  activeColumn.value = -1
  await addColumn(null)
}

async function addColumn(parentValue) {
  const col = {
    options: [],
    selectedValue: null,
    loading: true,
    loadingValue: null,
    parentValue,
  }

  columns.value.push(col)
  const colIndex = columns.value.length - 1
  activeColumn.value = colIndex

  try {
    const opts = await props.fetchOptions(parentValue)
    col.options = opts || []
  } catch {
    col.options = []
  } finally {
    col.loading = false
  }

  // If modelValue is set externally and we're building the initial path,
  // try to find the matching option
  if (props.modelValue && selectedPath.value.length === 0) {
    resolveInitialPath()
  }
}

function close() {
  open.value = false
}

/* ───────────────────────────────────────────────
   Methods — Option Click
   ─────────────────────────────────────────────── */

async function onOptionClick(colIndex, opt) {
  const col = columns.value[colIndex]

  // Mark this option as selected in its column
  col.selectedValue = opt.value

  // Update selectedPath: truncate to colIndex, then add this option
  selectedPath.value = selectedPath.value.slice(0, colIndex)
  selectedPath.value.push({ value: opt.value, label: opt.label })

  // Clear columns to the right
  columns.value = columns.value.slice(0, colIndex + 1)

  if (opt.hasChildren) {
    // Load children
    col.loadingValue = opt.value
    await addColumn(opt.value)
    col.loadingValue = null
  } else {
    // Leaf selected — emit and close
    emit('update:modelValue', opt.value)
    close()
  }
}

/* ───────────────────────────────────────────────
   Methods — Navigation
   ─────────────────────────────────────────────── */

async function navigateTo(colIndex) {
  // colIndex === -1 means "reset to root"
  if (colIndex === -1) {
    selectedPath.value = []
    activeColumn.value = 0
    columns.value = columns.value.slice(0, 1)
    // Reset selected values in remaining columns
    columns.value.forEach(c => { c.selectedValue = null })
    return
  }

  // Truncate path and columns to this level
  selectedPath.value = selectedPath.value.slice(0, colIndex + 1)
  columns.value = columns.value.slice(0, colIndex + 2) // keep the current showing column too
  activeColumn.value = colIndex + 1

  // Clear selected values in the current active column
  if (columns.value[activeColumn.value]) {
    columns.value[activeColumn.value].selectedValue = null
  }
}

/* ───────────────────────────────────────────────
   Methods — Clear / Resolve
   ─────────────────────────────────────────────── */

function clearValue() {
  emit('update:modelValue', '')
  selectedPath.value = []
  // Keep root column data so it doesn't need to reload next time
  if (columns.value.length > 0) {
    columns.value = columns.value.slice(0, 1)
    columns.value[0].selectedValue = null
    activeColumn.value = 0
  } else {
    activeColumn.value = -1
  }
  close()
}

// Attempt to resolve the display path from an externally-set modelValue
// Since we only have forward-lookup (parent→children), we can't walk backward.
// The path will be populated during normal user interaction.
async function resolveInitialPath() {
  // For now, we don't try to resolve backwards.
  // The selectedPath is built during user interaction and stored.
  // When value is set externally (e.g. form submit/load), the raw value
  // is available via modelValue but the display path can't be reconstructed
  // without a reverse-lookup API.
}

/* ───────────────────────────────────────────────
   Click outside → close
   ─────────────────────────────────────────────── */

function onClickOutside(e) {
  if (rootRef.value && !rootRef.value.contains(e.target)) {
    close()
  }
}

onMounted(async () => {
  document.addEventListener('pointerdown', onClickOutside, true)
  // Pre-load first-level data so dropdown opens instantly without loading flash
  await addColumn(null)
  activeColumn.value = 0
})

onBeforeUnmount(() => document.removeEventListener('pointerdown', onClickOutside, true))
</script>

<style scoped>
/* ═══════════════════════════════════════════════════════════════════════════
   CASCADEPICKER — Academy Pro Style
   ═══════════════════════════════════════════════════════════════════════════ */

.cp-root {
  position: relative;
  display: inline-block;
  width: 100%;
  font-family: var(--font-family-base);
}

/* ── Trigger ──────────────────────────────────── */

.cp-trigger {
  display: flex;
  align-items: center;
  gap: var(--space-5);
  width: 100%;
  padding: var(--space-5) var(--space-7);
  border: 1px solid var(--color-border);
  border-radius: var(--radius-md);
  background: var(--color-card);
  cursor: pointer;
  transition: border-color var(--transition-base), box-shadow var(--transition-base);
  outline: none;
  user-select: none;
  font-size: var(--text-body);
}

.cp-trigger:hover {
  border-color: var(--color-teal);
}

.cp--open .cp-trigger {
  border-color: var(--color-teal);
  box-shadow: 0 0 0 3px var(--color-teal-dim);
}

.cp--error .cp-trigger {
  border-color: var(--color-red);
  box-shadow: 0 0 0 3px var(--color-red-dim);
}

.cp--disabled .cp-trigger {
  opacity: 0.5;
  cursor: not-allowed;
  background: var(--color-surface);
}

.cp-trigger-value {
  flex: 1;
  font-weight: var(--weight-medium);
  color: var(--color-text-main);
  overflow: hidden;
  text-overflow: ellipsis;
  white-space: nowrap;
  min-width: 0;
}

.cp-trigger-placeholder {
  flex: 1;
  color: var(--color-text-muted);
  min-width: 0;
}

.cp-trigger-clear {
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

.cp-trigger-clear:hover {
  background: var(--color-red);
}

.cp-trigger-arrow {
  font-size: var(--text-xs);
  color: var(--color-text-muted);
  transition: transform var(--transition-fast);
  flex-shrink: 0;
  line-height: 1;
}

.cp-trigger-arrow--flip {
  transform: rotate(180deg);
  color: var(--color-teal);
}

/* ── Panel ────────────────────────────────────── */

.cp-panel {
  position: absolute;
  top: calc(100% + var(--space-3));
  left: 0;
  z-index: 600;
  background: var(--color-card);
  border: 1px solid var(--color-border);
  border-radius: var(--radius-xl);
  box-shadow: var(--shadow-lg);
  overflow: hidden;
  min-width: 100%;
}

/* ── Breadcrumb ───────────────────────────────── */

.cp-breadcrumb {
  background: var(--color-navy);
  padding: var(--space-6) var(--space-9);
  display: flex;
  align-items: center;
  gap: var(--space-3);
  flex-wrap: wrap;
  position: relative;
}

.cp-breadcrumb::after {
  content: '';
  position: absolute;
  bottom: 0;
  left: 0;
  right: 0;
  height: 1px;
  background: linear-gradient(
    90deg,
    transparent,
    var(--color-teal),
    transparent
  );
  opacity: 0.4;
}

.cp-breadcrumb__item {
  font-size: var(--text-md);
  color: rgba(255,255,255,0.5);
  cursor: pointer;
  padding: var(--space-2) var(--space-4);
  border-radius: var(--radius-sm);
  transition: all var(--transition-fast);
  white-space: nowrap;
  user-select: none;
}

.cp-breadcrumb__item:hover {
  color: rgba(255,255,255,0.85);
  background: rgba(255,255,255,0.08);
}

.cp-breadcrumb__item--active {
  color: var(--color-teal);
  font-weight: var(--weight-bold);
}

.cp-breadcrumb__sep {
  color: rgba(255,255,255,0.25);
  font-size: var(--text-md);
  user-select: none;
}

/* ── Columns ──────────────────────────────────── */

.cp-columns {
  display: flex;
  min-height: 180px;
}

.cp-column {
  flex: 1;
  min-width: 150px;
  border-right: 1px solid var(--color-border);
}

.cp-column:last-child {
  border-right: none;
}

.cp-column__list {
  list-style: none;
  margin: 0;
  padding: var(--space-3) 0;
  max-height: 240px;
  overflow-y: auto;
}

/* ── Options ──────────────────────────────────── */

.cp-column__option {
  display: flex;
  align-items: center;
  gap: var(--space-4);
  padding: var(--space-5) var(--space-9);
  font-size: var(--text-body);
  color: var(--color-text-main);
  cursor: pointer;
  transition: background var(--transition-fast), color var(--transition-fast);
  user-select: none;
}

.cp-column__option:hover {
  background: var(--color-teal-dim);
}

.cp-column__option--active {
  color: var(--color-teal-text);
  background: var(--color-teal-dim);
  font-weight: var(--weight-semibold);
}

.cp-column__option-label {
  flex: 1;
  overflow: hidden;
  text-overflow: ellipsis;
  white-space: nowrap;
  min-width: 0;
}

.cp-column__option-arrow {
  color: var(--color-text-muted);
  font-size: var(--text-lg);
  flex-shrink: 0;
  transition: color var(--transition-fast);
}

.cp-column__option:hover .cp-column__option-arrow {
  color: var(--color-teal);
}

/* ── Loading spinner ──────────────────────────── */

.cp-column__option--loading {
  pointer-events: none;
  opacity: 0.7;
}

.cp-column__option-spinner {
  width: 14px;
  height: 14px;
  border: 2px solid var(--color-border);
  border-top-color: var(--color-teal);
  border-radius: var(--radius-full);
  animation: cp-spin 0.6s linear infinite;
  flex-shrink: 0;
}

@keyframes cp-spin {
  to { transform: rotate(360deg); }
}

/* ── Empty state ──────────────────────────────── */

.cp-column__empty {
  padding: var(--space-9) var(--space-9);
  text-align: center;
  color: var(--color-text-muted);
  font-size: var(--text-md);
}

/* ── Overlay ──────────────────────────────────── */

.cp-overlay {
  position: fixed;
  inset: 0;
  z-index: 599;
  background: transparent;
}

/* ── Transitions ──────────────────────────────── */

.cp-panel-enter-active {
  animation: cpPanelIn var(--transition-smooth);
}

.cp-panel-leave-active {
  animation: cpPanelOut 0.12s ease;
}

@keyframes cpPanelIn {
  from { opacity: 0; transform: translateY(-6px) scale(0.97); }
  to   { opacity: 1; transform: translateY(0) scale(1); }
}

@keyframes cpPanelOut {
  from { opacity: 1; transform: translateY(0) scale(1); }
  to   { opacity: 0; transform: translateY(-6px) scale(0.97); }
}

.cp-overlay-enter-active { animation: cpFadeIn var(--transition-fast); }
.cp-overlay-leave-active { animation: cpFadeOut var(--transition-fast); }

@keyframes cpFadeIn  { from { opacity: 0; } to { opacity: 1; } }
@keyframes cpFadeOut { from { opacity: 1; } to { opacity: 0; } }
</style>
