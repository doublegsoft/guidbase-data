<template>
  <div
    ref="wrapEl"
    class="tef-ms"
    :class="{
      'tef-ms--disabled': disabled,
      'tef-ms--open': isOpen,
      'tef-ms--searchable': searchable,
      'tef-ms--block': block,
    }"
  >
    <!-- 触发器区域 -->
    <div
      ref="triggerEl"
      class="tef-ms__trigger"
      tabindex="0"
      role="combobox"
      aria-haspopup="listbox"
      :aria-expanded="isOpen"
      :aria-disabled="disabled"
      @click="toggleOpen"
      @keydown="onTriggerKey"
    >
      <!-- 已选标签 -->
      <template v-for="(opt, i) in visibleTags" :key="opt[valueKey]">
        <span class="tef-ms__tag">
          <span class="tef-ms__tag-text">{{ opt[labelKey] }}</span>
          <span class="tef-ms__tag-remove" @click.stop="removeValue(opt[valueKey])">&times;</span>
        </span>
      </template>
      <span v-if="hiddenCount > 0" class="tef-ms__tag-more">+{{ hiddenCount }}</span>

      <!-- 占位 -->
      <span v-if="selectedOptions.length === 0" class="tef-ms__placeholder">{{ placeholder }}</span>

      <!-- 计数 -->
      <span class="tef-ms__count">{{ selectedOptions.length }}/{{ options.length }}</span>

      <!-- 箭头 -->
      <span class="tef-ms__arrow"></span>
    </div>

    <!-- 面板（teleport 到 body） -->
    <teleport to="body">
      <div
        v-if="isOpen"
        ref="panelEl"
        class="tef-ms__panel"
        :style="panelStyle"
        @mousedown.prevent
      >
        <!-- 全选/取消按钮 -->
        <div v-if="showSelectAll" class="tef-ms__actions">
          <button type="button" class="tef-ms__action-btn" @click="selectAll">全选</button>
          <button type="button" class="tef-ms__action-btn" @click="deselectAll">取消</button>
        </div>

        <!-- 搜索 -->
        <div v-if="searchable" class="tef-ms__search-wrap">
          <input
            ref="searchEl"
            v-model="searchText"
            class="tef-ms__search"
            placeholder="搜索..."
            autocomplete="off"
            @keydown.stop="onSearchKey"
          />
        </div>

        <!-- 无结果 -->
        <div v-if="filteredOptions.length === 0" class="tef-ms__empty">无匹配选项</div>

        <!-- 选项列表 -->
        <div v-else class="tef-ms__options">
          <div
            v-for="opt in filteredOptions"
            :key="opt[valueKey]"
            class="tef-ms__option"
            :class="{
              'tef-ms__option--selected': isSelected(opt[valueKey]),
              'tef-ms__option--disabled': opt.disabled,
            }"
            @click="toggleValue(opt)"
          >
            <span
              class="tef-ms__checkbox"
              :class="{ 'tef-ms__checkbox--checked': isSelected(opt[valueKey]) }"
            ></span>
            <span class="tef-ms__opt-label">{{ opt[labelKey] }}</span>
            <span v-if="opt.desc" class="tef-ms__opt-desc">{{ opt.desc }}</span>
          </div>
        </div>
      </div>
    </teleport>
  </div>
</template>

<script setup>
import { ref, computed, watch, nextTick, onMounted, onBeforeUnmount } from 'vue'

const props = defineProps({
  modelValue:    { type: Array,    default: () => [] },       // 已选 value 数组
  options:       { type: Array,    default: () => [] },       // [{value, label, desc?, disabled?}]
  placeholder:   { type: String,   default: '请选择...' },
  searchable:    { type: Boolean,  default: false },
  disabled:      { type: Boolean,  default: false },
  showSelectAll: { type: Boolean,  default: false },
  maxCount:      { type: Number,   default: 0 },              // 0 = 不限制
  maxTagCount:   { type: Number,   default: 5 },              // 最多显示标签数
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

// 本地已选值
const localValue = ref([...props.modelValue])

watch(() => props.modelValue, (v) => {
  localValue.value = [...(v || [])]
})

// 过滤后选项
const filteredOptions = computed(() => {
  const q = searchText.value.trim().toLowerCase()
  if (!q) return props.options
  return props.options.filter(o => {
    const label = String(o[props.labelKey] || '').toLowerCase()
    const value = String(o[props.valueKey] || '').toLowerCase()
    const desc  = String(o.desc || '').toLowerCase()
    return label.indexOf(q) >= 0 || value.indexOf(q) >= 0 || desc.indexOf(q) >= 0
  })
})

// 已选选项对象
const selectedOptions = computed(() =>
  props.options.filter(o => localValue.value.indexOf(o[props.valueKey]) >= 0)
)

// 可见标签
const visibleTags = computed(() =>
  selectedOptions.value.slice(0, props.maxTagCount || 5)
)
const hiddenCount = computed(() =>
  Math.max(0, selectedOptions.value.length - (props.maxTagCount || 5))
)

function isSelected(val) {
  return localValue.value.indexOf(val) >= 0
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

// ── 面板开关 ──
function toggleOpen() {
  if (props.disabled) return
  isOpen.value ? close() : open()
}

function open() {
  if (isOpen.value || props.disabled) return
  isOpen.value = true
  searchText.value = ''
  nextTick(() => {
    // teleport 到 body
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
  // 面板移回
  nextTick(() => {
    if (panelEl.value && panelEl.value.parentNode === document.body && wrapEl.value) {
      wrapEl.value.appendChild(panelEl.value)
    }
  })
}

function onScrollResize() {
  if (isOpen.value) positionPanel()
}

// ── 面板定位 ──
function positionPanel() {
  if (!triggerEl.value || !panelEl.value) return
  const rect = triggerEl.value.getBoundingClientRect()
  const pw = panelEl.value.offsetWidth || 220
  const ph = panelEl.value.offsetHeight || 280
  const spaceBelow = window.innerHeight - rect.bottom
  const spaceRight = window.innerWidth - rect.left

  const top    = spaceBelow >= ph || spaceBelow >= 150 ? rect.bottom + 2 : 'auto'
  const bottom = spaceBelow < ph && spaceBelow < 150 ? window.innerHeight - rect.top + 2 : 'auto'
  const left   = spaceRight >= pw ? 'auto' : rect.left
  const right  = spaceRight < pw ? 'auto' : window.innerWidth - rect.right

  panelStyle.value = {
    position: 'fixed', zIndex: '99999',
    top:    top    !== 'auto' ? top    + 'px' : 'auto',
    bottom: bottom !== 'auto' ? bottom + 'px' : 'auto',
    left:   left   !== 'auto' ? left   + 'px' : 'auto',
    right:  right  !== 'auto' ? right  + 'px' : 'auto',
    minWidth: Math.max(rect.width, 180) + 'px',
  }
}

// ── 键盘 ──
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

// ── 点击外部关闭 ──
function onDocClick(e) {
  if (!wrapEl.value || !panelEl.value) return
  if (!wrapEl.value.contains(e.target) && !panelEl.value.contains(e.target)) {
    close()
  }
}

// ── 生命周期 ──
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

// 暴露方法
defineExpose({
  open, close, selectAll, deselectAll,
  getValue: () => [...localValue.value],
  setValue: (arr) => { localValue.value = [...arr]; emitChange() },
})
</script>

<style scoped>
/* ═══════════════════════════════════════════
   BNR MultiSelect — tef-ms
   ═══════════════════════════════════════════ */

.tef-ms {
  position: relative;
  min-width: 180px;
  font-family: var(--tef-font, "Microsoft YaHei", sans-serif);
  font-size: 12px;
  user-select: none;
  flex: 1;
}
.tef-ms--block { display: flex; width: 100%; }

/* Trigger */
.tef-ms__trigger {
  flex: 1;
  min-height: 24px;
  display: flex;
  align-items: center;
  flex-wrap: wrap;
  gap: 3px;
  padding: 2px 24px 2px 5px;
  border: 1px solid var(--tef-border);
  background: var(--tef-bg);
  cursor: pointer;
  position: relative;
  transition: border-color .15s;
}
.tef-ms--open .tef-ms__trigger {
  border-color: var(--tef-primary);
  box-shadow: 0 0 0 2px rgba(190,0,0,.15);
}
.tef-ms--disabled .tef-ms__trigger {
  background: var(--tef-bg-page);
  color: var(--tef-text-muted);
  cursor: not-allowed;
}

/* Arrow */
.tef-ms__arrow {
  position: absolute;
  right: 7px;
  top: 50%;
  transform: translateY(-50%);
  width: 0; height: 0;
  border-left: 4px solid transparent;
  border-right: 4px solid transparent;
  border-top: 5px solid var(--tef-text-muted);
  transition: transform .15s;
  pointer-events: none;
  flex-shrink: 0;
}
.tef-ms--open .tef-ms__arrow {
  transform: translateY(-50%) rotate(180deg);
}

/* Tags */
.tef-ms__tags {
  display: flex;
  align-items: center;
  flex-wrap: wrap;
  gap: 3px;
  flex: 1;
  min-width: 0;
}
.tef-ms__tag {
  display: inline-flex;
  align-items: center;
  gap: 2px;
  height: 18px;
  padding: 0 4px;
  background: var(--tef-primary-bg);
  border: 1px solid var(--tef-primary-border);
  border-radius: 2px;
  font-size: 10px;
  color: var(--tef-primary);
  white-space: nowrap;
  max-width: 120px;
}
.tef-ms__tag-text {
  overflow: hidden;
  text-overflow: ellipsis;
  white-space: nowrap;
}
.tef-ms__tag-remove {
  font-size: 12px;
  cursor: pointer;
  color: var(--tef-text-muted);
  line-height: 1;
  flex-shrink: 0;
}
.tef-ms__tag-remove:hover { color: var(--tef-danger); }

.tef-ms__tag-more {
  font-size: 10px;
  color: var(--tef-text-light);
  white-space: nowrap;
  flex-shrink: 0;
}
.tef-ms__count {
  font-size: 10px;
  color: var(--tef-text-light);
  margin-left: auto;
  flex-shrink: 0;
  padding-left: 4px;
}
.tef-ms__placeholder {
  color: var(--tef-text-light);
  font-size: 12px;
  white-space: nowrap;
  overflow: hidden;
  text-overflow: ellipsis;
}

/* Panel */
.tef-ms__panel {
  background: var(--tef-bg);
  border: 1px solid var(--tef-primary-border);
  border-radius: 2px;
  box-shadow: 0 4px 16px rgba(0,0,0,.12);
  max-height: 280px;
  overflow-y: auto;
  overflow-x: hidden;
}

/* Search */
.tef-ms__search-wrap {
  padding: 4px 6px;
  border-bottom: 1px solid var(--tef-border-light);
  position: sticky;
  top: 0;
  background: var(--tef-bg);
  z-index: 1;
}
.tef-ms__search {
  width: 100%;
  height: 22px;
  border: 1px solid var(--tef-border);
  border-radius: 2px;
  font-size: 12px;
  font-family: inherit;
  padding: 0 5px;
  outline: none;
  color: var(--tef-text);
  box-sizing: border-box;
}
.tef-ms__search:focus { border-color: var(--tef-primary); }

/* Actions */
.tef-ms__actions {
  display: flex;
  gap: 4px;
  padding: 4px 6px;
  border-bottom: 1px solid var(--tef-border-light);
  background: var(--tef-bg-page);
  position: sticky;
  top: 0;
  z-index: 1;
}
.tef-ms__action-btn {
  font-size: 11px;
  padding: 2px 8px;
  border: 1px solid var(--tef-primary-border);
  border-radius: 2px;
  background: var(--tef-bg);
  color: var(--tef-primary);
  cursor: pointer;
  font-family: inherit;
  transition: background .1s;
}
.tef-ms__action-btn:hover { background: var(--tef-primary-bg); }

/* Options */
.tef-ms__option {
  display: flex;
  align-items: center;
  gap: 6px;
  padding: 6px 10px;
  font-size: 12px;
  cursor: pointer;
  color: var(--tef-text);
  border-bottom: 1px solid var(--tef-bg-page);
  transition: background .1s;
  white-space: nowrap;
}
.tef-ms__option:last-child { border-bottom: none; }
.tef-ms__option:hover { background: var(--tef-primary-bg); }
.tef-ms__option--selected {
  background: var(--tef-primary-bg);
  color: var(--tef-primary);
}
.tef-ms__option--disabled {
  color: var(--tef-text-light);
  cursor: not-allowed;
  background: none !important;
}

/* Checkbox */
.tef-ms__checkbox {
  width: 14px; height: 14px;
  border: 1px solid var(--tef-border);
  border-radius: 2px;
  background: var(--tef-bg);
  flex-shrink: 0;
  position: relative;
  transition: all .15s;
}
.tef-ms__checkbox--checked {
  background: var(--tef-primary);
  border-color: var(--tef-primary);
}
.tef-ms__checkbox--checked::after {
  content: '';
  position: absolute;
  left: 3px; top: 1px;
  width: 5px; height: 8px;
  border: solid var(--tef-bg);
  border-width: 0 2px 2px 0;
  transform: rotate(45deg);
}

.tef-ms__opt-label {
  flex: 1;
  overflow: hidden;
  text-overflow: ellipsis;
}
.tef-ms__opt-desc {
  font-size: 10px;
  color: var(--tef-text-light);
  flex-shrink: 0;
}

/* Empty */
.tef-ms__empty {
  padding: 14px 12px;
  font-size: 12px;
  color: var(--tef-text-light);
  text-align: center;
}
</style>
