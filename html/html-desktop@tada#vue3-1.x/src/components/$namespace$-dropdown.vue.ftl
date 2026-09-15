<template>
  <div
    style="position: relative; width: 100%; display: inline-block;"
    ref="rootRef"
    :data-test="dataTest"
  >
    <!-- ── 触发框 (复用 ${namespace}-input 软萌微凸质感) ───────────── -->
    <div
      :class="plain ? '' : '${namespace}-input'"
      :style="getTriggerStyle"
      @click="toggleOpen"
      tabindex="0"
      @keydown.enter="toggleOpen"
      @keydown.space.prevent="toggleOpen"
      @keydown.escape="close"
      @keydown.up.prevent="highlightPrev"
      @keydown.down.prevent="highlightNext"
    >
      <!-- 选中值 / 占位符 -->
      <span
        v-if="selectedOption"
        style="flex: 1; overflow: hidden; text-overflow: ellipsis; white-space: nowrap; font-weight: 800; min-width: 0;"
      >
        {{ selectedOption.label }}
      </span>
      <span
        v-else
        style="flex: 1; overflow: hidden; text-overflow: ellipsis; white-space: nowrap; color: var(--${namespace}-text-light); font-weight: 700; min-width: 0;"
      >
        {{ placeholder }}
      </span>

      <!-- 清除小圆钮 (复用 ${namespace}-btn--default 贴纸钮) -->
      <button
        v-if="hasValue && clearable && !disabled"
        type="button"
        class="${namespace}-btn ${namespace}-btn--default ${namespace}-btn--sm"
        style="width: 20px; height: 20px; padding: 0; border-radius: 9999px; font-size: 10px; flex-shrink: 0;"
        @click.stop="clearValue"
        title="清除选择"
      >✕</button>

      <!-- 展开小三角 -->
      <span
        style="font-size: 10px; color: var(--${namespace}-text-light); transition: transform 0.2s; flex-shrink: 0;"
        :style="open ? 'transform: rotate(180deg); color: var(--${namespace}-primary);' : ''"
      >▾</span>
    </div>

    <!-- ── 下拉浮层面板 (复用 ${namespace}-panel 卡片容器) ───────── -->
    <Teleport to="body">
      <div
        v-if="open"
        class="${namespace}-panel"
        :style="panelStyle"
        ref="panelRef"
        style="z-index: 9999; box-shadow: var(--${namespace}-shadow-md); background: #ffffff; overflow: hidden;"
        @click.stop
      >
        <!-- 搜索筛选框 -->
        <div
          v-if="searchable"
          style="padding: 8px 10px; border-bottom: 2px solid var(--${namespace}-border-light); display: flex; align-items: center; gap: 6px;"
        >
          <span style="font-size: 12px; color: var(--${namespace}-text-light);">🔍</span>
          <input
            ref="searchRef"
            class="${namespace}-input"
            style="height: 30px; font-size: 12px; padding: 0 8px;"
            v-model="query"
            placeholder="输入关键词筛选…"
            @keydown.escape="close"
            @keydown.up.prevent="highlightPrev"
            @keydown.down.prevent="highlightNext"
            @keydown.enter.prevent="selectHighlighted"
          />
        </div>

        <!-- 选项列表 -->
        <ul
          ref="listRef"
          style="list-style: none; margin: 0; padding: 6px; max-height: 240px; overflow-y: auto;"
        >
          <li
            v-for="(opt, idx) in filteredOptions"
            :key="opt.value"
            :style="getOptionStyle(opt, idx)"
            @click="select(opt)"
            @mouseenter="highlightedIndex = idx"
          >
            <span style="flex: 1; overflow: hidden; text-overflow: ellipsis; white-space: nowrap; min-width: 0;">
              {{ opt.label }}
            </span>
            <span
              v-if="isSelected(opt)"
              style="font-size: 12px; font-weight: 900; color: var(--${namespace}-primary-dark); flex-shrink: 0;"
            >✓</span>
          </li>

          <!-- 空选项状态 -->
          <li
            v-if="filteredOptions.length === 0"
            style="padding: 16px; text-align: center; color: var(--${namespace}-text-light); font-weight: 800; font-size: 12px;"
          >
            无匹配选项 (•ㅅ•)
          </li>
        </ul>
      </div>
    </Teleport>
  </div>
</template>

<script setup>
import { ref, computed, watch, nextTick, onMounted, onBeforeUnmount } from 'vue'

const props = defineProps({
  /** v-model 绑定值 */
  modelValue:  { type: [String, Number], default: '' },
  /** 选项列表 [{ label, value }] */
  options:     { type: Array, default: () => [] },
  /** 占位文案 */
  placeholder: { type: String, default: '请选择' },
  /** 是否允许清除 */
  clearable:   { type: Boolean, default: true },
  /** 是否禁用 */
  disabled:    { type: Boolean, default: false },
  /** 是否开启搜索 */
  searchable:  { type: Boolean, default: false },
  /** 错误校验状态 */
  error:       { type: Boolean, default: false },
  /** 朴素模式（无边框背景，适配表格行内微编辑） */
  plain:       { type: Boolean, default: false },
  /** 测试标识 */
  dataTest:    { type: String, default: '' }
})

const emit = defineEmits(['update:modelValue', 'change'])

const open = ref(false)
const query = ref('')
const highlightedIndex = ref(-1)
const rootRef = ref(null)
const searchRef = ref(null)
const listRef = ref(null)
const panelRef = ref(null)
const panelStyle = ref({})

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

const getTriggerStyle = computed(() => {
  let style = 'display: flex; align-items: center; justify-content: space-between; cursor: pointer; user-select: none; gap: 8px;'
  if (props.disabled) {
    style += ' opacity: 0.5; cursor: not-allowed; background: var(--' + '${namespace}' + '-bg-hover);'
  }
  if (props.error) {
    style += ' border-color: var(--' + '${namespace}' + '-danger);'
  }
  if (props.plain) {
    style += ' border: none; background: transparent; padding: 4px 8px; box-shadow: none; border-radius: var(--' + '${namespace}' + '-radius-sm);'
  }
  return style
})

function isSelected(opt) {
  return opt.value === props.modelValue
}

function getOptionStyle(opt, idx) {
  const isSel = isSelected(opt)
  const isHigh = highlightedIndex.value === idx
  let style = 'display: flex; align-items: center; justify-content: space-between; padding: 8px 12px; margin-bottom: 2px; font-size: 13px; font-weight: 800; cursor: pointer; border-radius: var(--' + '${namespace}' + '-radius-md); transition: all 0.15s ease;'

  if (isSel) {
    style += ' background: var(--' + '${namespace}' + '-primary-bg); color: var(--' + '${namespace}' + '-primary-dark); font-weight: 900;'
  } else if (isHigh) {
    style += ' background: var(--' + '${namespace}' + '-bg-hover); color: var(--' + '${namespace}' + '-text);'
  } else {
    style += ' color: var(--' + '${namespace}' + '-text);'
  }
  return style
}

function calcPanelPosition() {
  if (!rootRef.value) return
  const gap = 6
  const triggerEl = rootRef.value.querySelector('.\\${namespace}-input') || rootRef.value
  const triggerRect = triggerEl.getBoundingClientRect()
  panelStyle.value = {
    position: 'fixed',
    top: triggerRect.bottom + gap + 'px',
    left: triggerRect.left + 'px',
    width: triggerRect.width + 'px',
    minWidth: '160px'
  }
}

function toggleOpen() {
  if (props.disabled) return
  open.value = !open.value
  if (open.value) {
    query.value = ''
    highlightedIndex.value = -1
    nextTick(() => {
      calcPanelPosition()
      if (props.searchable) {
        searchRef.value?.focus()
      }
    })
  }
}

function close() {
  open.value = false
  highlightedIndex.value = -1
}

function select(opt) {
  emit('update:modelValue', opt.value)
  emit('change', opt.value)
  close()
}

function clearValue() {
  emit('update:modelValue', '')
  emit('change', '')
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

function onPointerDown(e) {
  if (rootRef.value && !rootRef.value.contains(e.target)) {
    if (panelRef.value && panelRef.value.contains(e.target)) return
    close()
  }
}

function onResizeOrScroll() {
  if (open.value) calcPanelPosition()
}

onMounted(() => {
  document.addEventListener('pointerdown', onPointerDown, true)
  window.addEventListener('resize', onResizeOrScroll, true)
  window.addEventListener('scroll', onResizeOrScroll, true)
})

onBeforeUnmount(() => {
  document.removeEventListener('pointerdown', onPointerDown, true)
  window.removeEventListener('resize', onResizeOrScroll, true)
  window.removeEventListener('scroll', onResizeOrScroll, true)
})

watch(open, (v) => {
  if (!v) query.value = ''
})
</script>