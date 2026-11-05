<template>
  <div
    ref="wrapEl"
    class="${namespace}-ms"
    :class="{
      '${namespace}-ms--disabled': disabled,
      '${namespace}-ms--open': isOpen,
      '${namespace}-ms--searchable': searchable,
      '${namespace}-ms--block': block,
      '${namespace}-ms--plain': plain,
    }"
  >
    <!-- 触发器区域：直角、等宽、聚焦硬阴影 -->
    <div
      ref="triggerEl"
      class="${namespace}-ms__trigger"
      tabindex="0"
      role="combobox"
      aria-haspopup="listbox"
      :aria-expanded="isOpen"
      :aria-disabled="disabled"
      @click="toggleOpen"
      @keydown="onTriggerKey"
    >
      <!-- 已选标签芯片组 -->
      <div class="${namespace}-ms__tags">
        <template v-for="opt in visibleTags" :key="opt[valueKey]">
          <span class="${namespace}-ms__tag">
            <span class="${namespace}-ms__tag-text">{{ opt[labelKey] }}</span>
            <span class="${namespace}-ms__tag-remove" @click.stop="removeValue(opt[valueKey])">&times;</span>
          </span>
        </template>
        <span v-if="hiddenCount > 0" class="${namespace}-ms__tag-more">+{{ hiddenCount }}</span>

        <!-- 占位提示 -->
        <span v-if="selectedOptions.length === 0" class="${namespace}-ms__placeholder">{{ placeholder }}</span>
      </div>

      <!-- 终端风格计数与折叠指示 -->
      <div class="${namespace}-ms__aside">
        <span class="${namespace}-ms__count">[{{ selectedOptions.length }}/{{ options.length }}]</span>
        <span class="${namespace}-ms__arrow">▾</span>
      </div>
    </div>

    <!-- 弹窗面板 (Teleport 到 body) -->
    <teleport to="body">
      <div
        v-if="isOpen"
        ref="panelEl"
        class="${namespace}-ms__panel"
        :style="panelStyle"
        @mousedown.prevent
      >
        <!-- 全选 / 取消控制台条 -->
        <div v-if="showSelectAll" class="${namespace}-ms__actions">
          <button type="button" class="${namespace}-ms__action-btn ${namespace}-ms__action-btn--pri" @click="selectAll">全选</button>
          <button type="button" class="${namespace}-ms__action-btn" @click="deselectAll">清空</button>
        </div>

        <!-- 搜索输入框 -->
        <div v-if="searchable" class="${namespace}-ms__search-wrap">
          <input
            ref="searchEl"
            v-model="searchText"
            class="${namespace}-ms__search"
            placeholder="FILTER..."
            autocomplete="off"
            @keydown.stop="onSearchKey"
          />
        </div>

        <!-- 无匹配结果 -->
        <div v-if="filteredOptions.length === 0" class="${namespace}-ms__empty">NO MATCHES FOUND</div>

        <!-- 选项列表 -->
        <div v-else class="${namespace}-ms__options">
          <div
            v-for="opt in filteredOptions"
            :key="opt[valueKey]"
            class="${namespace}-ms__option"
            :class="{
              '${namespace}-ms__option--selected': isSelected(opt[valueKey]),
              '${namespace}-ms__option--disabled': opt.disabled,
            }"
            @click="toggleValue(opt)"
          >
            <!-- 直角物理复选框 -->
            <span
              class="${namespace}-ms__checkbox"
              :class="{ '${namespace}-ms__checkbox--checked': isSelected(opt[valueKey]) }"
            ></span>
            <span class="${namespace}-ms__opt-label">{{ opt[labelKey] }}</span>
            <span v-if="opt.desc" class="${namespace}-ms__opt-desc">{{ opt.desc }}</span>
          </div>
        </div>
      </div>
    </teleport>
  </div>
</template>

<script setup>
import { ref, computed, watch, nextTick, onMounted, onBeforeUnmount } from 'vue'

const props = defineProps({
  modelValue:    { type: Array,    default: () => [] },
  options:       { type: Array,    default: () => [] },
  placeholder:   { type: String,   default: 'SELECT...' },
  searchable:    { type: Boolean,  default: false },
  disabled:      { type: Boolean,  default: false },
  showSelectAll: { type: Boolean,  default: false },
  maxCount:      { type: Number,   default: 0 },
  maxTagCount:   { type: Number,   default: 4 },
  plain:         { type: Boolean,  default: false },
  block:         { type: Boolean,  default: false },
  valueKey:      { type: String,   default: 'value' },
  labelKey:      { type: String,   default: 'label' },
})

const emit = defineEmits(['update:modelValue', 'change'])

const wrapEl    = ref(null)
const triggerEl = ref(null)
const panelEl   = ref(null)
const searchEl  = ref(null)
const isOpen    = ref(false)
const searchText = ref('')
const panelStyle = ref({})

const localValue = ref([...props.modelValue])

watch(() => props.modelValue, (v) => {
  localValue.value = [...(v || [])]
})

const filteredOptions = computed(() => {
  const q = searchText.value.trim().toLowerCase()
  if (!q) return props.options
  return props.options.filter(o => {
    const label = String(o[props.labelKey] || '').toLowerCase()
    const value = String(o[props.valueKey] || '').toLowerCase()
    const desc  = String(o.desc || '').toLowerCase()
    return label.includes(q) || value.includes(q) || desc.includes(q)
  })
})

const selectedOptions = computed(() =>
  props.options.filter(o => localValue.value.includes(o[props.valueKey]))
)

const visibleTags = computed(() =>
  selectedOptions.value.slice(0, props.maxTagCount || 4)
)
const hiddenCount = computed(() =>
  Math.max(0, selectedOptions.value.length - (props.maxTagCount || 4))
)

function isSelected(val) {
  return localValue.value.includes(val)
}

function toggleValue(opt) {
  if (opt.disabled) return
  const idx = localValue.value.indexOf(opt[props.valueKey])
  if (idx >= 0) {
    localValue.value.splice(idx, 1)
  } else {
    if (props.maxCount > 0 && localValue.value.length >= props.maxCount) return
    localValue.value.push(opt[props.valueKey])
  }
  emitChange()
}

function removeValue(val) {
  const idx = localValue.value.indexOf(val)
  if (idx >= 0) localValue.value.splice(idx, 1)
  emitChange()
}

function selectAll() {
  const available = filteredOptions.value.filter(o => !o.disabled)
  const max = props.maxCount > 0 ? props.maxCount : available.length
  localValue.value = available.slice(0, max).map(o => o[props.valueKey])
  emitChange()
}

function deselectAll() {
  localValue.value = []
  emitChange()
}

function emitChange() {
  const v = [...localValue.value]
  emit('update:modelValue', v)
  emit('change', v, selectedOptions.value)
}

function toggleOpen() {
  if (props.disabled) return
  isOpen.value ? close() : open()
}

function open() {
  if (isOpen.value || props.disabled) return
  isOpen.value = true
  searchText.value = ''
  nextTick(() => {
    if (panelEl.value && panelEl.value.parentNode !== document.body) {
      document.body.appendChild(panelEl.value)
    }
    positionPanel()
    if (searchEl.value) searchEl.value.focus()
  })
  document.addEventListener('click', onDocClick, true)
  window.addEventListener('scroll', onScrollResize, true)
  window.addEventListener('resize', onScrollResize)
}

function close() {
  if (!isOpen.value) return
  isOpen.value = false
  document.removeEventListener('click', onDocClick, true)
  window.removeEventListener('scroll', onScrollResize, true)
  window.removeEventListener('resize', onScrollResize)
  nextTick(() => {
    if (panelEl.value && panelEl.value.parentNode === document.body && wrapEl.value) {
      wrapEl.value.appendChild(panelEl.value)
    }
  })
}

function onScrollResize() {
  if (isOpen.value) positionPanel()
}

function positionPanel() {
  if (!triggerEl.value || !panelEl.value) return
  const rect = triggerEl.value.getBoundingClientRect()
  const pw = Math.max(rect.width, 240)
  const ph = panelEl.value.offsetHeight || 260
  const spaceBelow = window.innerHeight - rect.bottom

  const style = { position: 'fixed', zIndex: '99999' }

  if (spaceBelow >= ph || spaceBelow >= 160) {
    style.top = (rect.bottom + 3) + 'px'
  } else {
    style.top = Math.max(8, rect.top - ph - 3) + 'px'
  }

  if (rect.left + pw <= window.innerWidth - 8) {
    style.left = rect.left + 'px'
  } else {
    style.left = Math.max(8, rect.right - pw) + 'px'
  }
  style.width = pw + 'px'

  panelStyle.value = style
}

function onTriggerKey(e) {
  if (props.disabled) return
  if (e.key === 'Enter' || e.key === 'ArrowDown') {
    e.preventDefault()
    if (!isOpen.value) open()
  }
  if (e.key === 'Escape') {
    close()
    triggerEl.value?.focus()
  }
}

function onSearchKey(e) {
  if (e.key === 'Escape') {
    close()
    triggerEl.value?.focus()
  }
}

function onDocClick(e) {
  if (!wrapEl.value || !panelEl.value) return
  if (!wrapEl.value.contains(e.target) && !panelEl.value.contains(e.target)) {
    close()
  }
}

onMounted(() => {
  document.addEventListener('click', onDocClick, true)
})

onBeforeUnmount(() => {
  close()
  document.removeEventListener('click', onDocClick, true)
  window.removeEventListener('scroll', onScrollResize, true)
  window.removeEventListener('resize', onScrollResize)
  if (panelEl.value && panelEl.value.parentNode === document.body) {
    document.body.removeChild(panelEl.value)
  }
})

defineExpose({
  open, close, selectAll, deselectAll,
  getValue: () => [...localValue.value],
  setValue: (arr) => { localValue.value = [...arr]; emitChange() },
})
</script>

<style scoped>
/* ══════════════════════════════════════════════
   Protocol Explorer MultiSelect 蓝图样式规范
   ══════════════════════════════════════════════ */
.${namespace}-ms {
  position: relative;
  display: inline-flex;
  min-width: 200px;
  font-family: var(--${namespace}-f, "IBM Plex Mono", monospace);
  font-size: 13px;
  user-select: none;
  width: 100%;
}
.${namespace}-ms--block { display: flex; width: 100%; }

/* ── 触发框：物理硬阴影、直角细线 ── */
.${namespace}-ms__trigger {
  flex: 1;
  min-height: 34px;
  display: flex;
  align-items: center;
  justify-content: space-between;
  gap: 8px;
  padding: 3px 10px;
  border: 1px solid var(--${namespace}-ln, #d3dbef);
  border-radius: 0;
  background: var(--${namespace}-pn, #ffffff);
  color: var(--${namespace}-ink, #0a2a9a);
  cursor: pointer;
  outline: none;
  transition: .15s;
}
.${namespace}-ms__trigger:hover,
.${namespace}-ms--open .${namespace}-ms__trigger {
  border-color: var(--${namespace}-pri, #0a2fb5);
  transform: translate(-1px, -1px);
  box-shadow: 3px 3px 0 color-mix(in srgb, var(--${namespace}-pri, #0a2fb5) 30%, transparent);
}
.${namespace}-ms--disabled .${namespace}-ms__trigger {
  background: var(--${namespace}-bg, #f4f6fb);
  color: var(--${namespace}-mu, #6f7fb4);
  cursor: not-allowed;
  transform: none;
  box-shadow: none;
  border-color: var(--${namespace}-ln, #d3dbef);
}

/* 标签呈现区域 */
.${namespace}-ms__tags {
  display: flex;
  align-items: center;
  flex-wrap: wrap;
  gap: 4px;
  flex: 1;
  min-width: 0;
}

/* 直角工程标签芯片 */
.${namespace}-ms__tag {
  display: inline-flex;
  align-items: center;
  gap: 4px;
  height: 22px;
  padding: 0 6px;
  background: color-mix(in srgb, var(--${namespace}-pri, #0a2fb5) 12%, transparent);
  border: 1px solid var(--${namespace}-ln, #d3dbef);
  border-radius: 0;
  font-size: 11px;
  font-weight: 600;
  color: var(--${namespace}-ink, #0a2a9a);
  white-space: nowrap;
}
.${namespace}-ms__tag-text {
  overflow: hidden;
  text-overflow: ellipsis;
  white-space: nowrap;
}
.${namespace}-ms__tag-remove {
  font-size: 13px;
  cursor: pointer;
  color: var(--${namespace}-mu, #6f7fb4);
  line-height: 1;
  margin-left: 2px;
  transition: .12s;
}
.${namespace}-ms__tag-remove:hover {
  color: var(--${namespace}-red, #d6343e);
}

.${namespace}-ms__tag-more {
  font-size: 11px;
  font-weight: 700;
  color: var(--${namespace}-mu, #6f7fb4);
  padding: 0 2px;
}
.${namespace}-ms__placeholder {
  color: var(--${namespace}-mu, #6f7fb4);
  font-size: 12px;
  letter-spacing: .05em;
}

/* 触发器右侧信息：[2/14] 与箭头 */
.${namespace}-ms__aside {
  display: flex;
  align-items: center;
  gap: 6px;
  flex-shrink: 0;
}
.${namespace}-ms__count {
  font-size: 11px;
  font-weight: 700;
  color: var(--${namespace}-mu, #6f7fb4);
  letter-spacing: .05em;
}
.${namespace}-ms__arrow {
  color: var(--${namespace}-mu, #6f7fb4);
  font-size: 12px;
  transition: transform .15s;
}
.${namespace}-ms--open .${namespace}-ms__arrow {
  transform: rotate(180deg);
  color: var(--${namespace}-pri, #0a2fb5);
}

/* ── 下拉面板：直角与 4px 实体硬阴影 ── */
.${namespace}-ms__panel {
  background: var(--${namespace}-pn, #ffffff);
  border: 1px solid var(--${namespace}-ink, #0a2a9a);
  border-radius: 0;
  box-shadow: 4px 4px 0 var(--${namespace}-ln, #d3dbef);
  max-height: 280px;
  overflow-y: auto;
  overflow-x: hidden;
  font-family: var(--${namespace}-f, "IBM Plex Mono", monospace);
}

/* 顶部操作条 (全选/清空) */
.${namespace}-ms__actions {
  display: flex;
  gap: 6px;
  padding: 6px 10px;
  border-bottom: 1px solid var(--${namespace}-ln, #d3dbef);
  background: var(--${namespace}-bg, #f4f6fb);
  position: sticky;
  top: 0;
  z-index: 2;
}
.${namespace}-ms__action-btn {
  font: 600 11px var(--${namespace}-f, "IBM Plex Mono", monospace);
  padding: 3px 8px;
  border: 1px solid var(--${namespace}-ink, #0a2a9a);
  border-radius: 0;
  background: var(--${namespace}-pn, #ffffff);
  color: var(--${namespace}-ink, #0a2a9a);
  cursor: pointer;
  transition: .12s;
}
.${namespace}-ms__action-btn:hover {
  transform: translate(-1px, -1px);
  box-shadow: 2px 2px 0 var(--${namespace}-ink, #0a2a9a);
}
.${namespace}-ms__action-btn:active {
  transform: translate(1px, 1px);
  box-shadow: none;
}
.${namespace}-ms__action-btn--pri {
  background: var(--${namespace}-pri, #0a2fb5);
  color: var(--${namespace}-on, #ffffff);
  border-color: var(--${namespace}-pri, #0a2fb5);
}

/* 搜索框 */
.${namespace}-ms__search-wrap {
  padding: 6px 8px;
  border-bottom: 1px solid var(--${namespace}-ln, #d3dbef);
  background: var(--${namespace}-pn, #ffffff);
  position: sticky;
  top: 36px;
  z-index: 2;
}
.${namespace}-ms__search {
  width: 100%;
  height: 28px;
  border: 1px solid var(--${namespace}-ln, #d3dbef);
  border-radius: 0;
  font: inherit;
  font-size: 12px;
  padding: 0 8px;
  outline: none;
  color: var(--${namespace}-ink, #0a2a9a);
  background: var(--${namespace}-bg, #f4f6fb);
  transition: .15s;
}
.${namespace}-ms__search:focus {
  border-color: var(--${namespace}-pri, #0a2fb5);
  background: #ffffff;
}

/* 选项列表 */
.${namespace}-ms__options {
  padding: 2px 0;
}
.${namespace}-ms__option {
  display: flex;
  align-items: center;
  gap: 10px;
  padding: 8px 12px;
  font-size: 13px;
  cursor: pointer;
  color: var(--${namespace}-ink, #0a2a9a);
  border-bottom: 1px solid color-mix(in srgb, var(--${namespace}-ln, #d3dbef) 40%, transparent);
  transition: background .12s;
  white-space: nowrap;
}
.${namespace}-ms__option:last-child {
  border-bottom: none;
}
.${namespace}-ms__option:hover {
  background: color-mix(in srgb, var(--${namespace}-ln, #d3dbef) 35%, transparent);
}
.${namespace}-ms__option--selected {
  background: color-mix(in srgb, var(--${namespace}-pri, #0a2fb5) 10%, transparent);
}

/* ── 直角物理复选框 (参考 HTML .ck s 样式) ── */
.${namespace}-ms__checkbox {
  width: 16px;
  height: 16px;
  border: 1px solid var(--${namespace}-ink, #0a2a9a);
  border-radius: 0;
  background: var(--${namespace}-pn, #ffffff);
  flex-shrink: 0;
  position: relative;
  transition: .15s;
}
.${namespace}-ms__checkbox--checked {
  background: var(--${namespace}-pri, #0a2fb5);
  border-color: var(--${namespace}-pri, #0a2fb5);
}
/* 选中时内部的直角实心方块 */
.${namespace}-ms__checkbox--checked::after {
  content: '';
  position: absolute;
  left: 3px;
  top: 3px;
  width: 8px;
  height: 8px;
  background: var(--${namespace}-on, #ffffff);
}

.${namespace}-ms__opt-label {
  flex: 1;
  font-weight: 600;
  letter-spacing: .05em;
  overflow: hidden;
  text-overflow: ellipsis;
}
.${namespace}-ms__opt-desc {
  font-size: 11px;
  color: var(--${namespace}-mu, #6f7fb4);
  flex-shrink: 0;
}

/* 禁用项 */
.${namespace}-ms__option--disabled {
  opacity: .3;
  cursor: not-allowed;
  pointer-events: none;
}

/* 无边框变体 */
.${namespace}-ms--plain .${namespace}-ms__trigger {
  border-color: transparent;
  background: transparent;
  box-shadow: none;
  transform: none;
}

/* 无结果空状态 */
.${namespace}-ms__empty {
  padding: 16px;
  font-size: 12px;
  font-weight: 700;
  color: var(--${namespace}-mu, #6f7fb4);
  text-align: center;
  letter-spacing: .08em;
}
</style>