<template>
  <!-- ========== multi 模式：多个 trigger 并排 ========== -->
  <div
    v-if="variant === 'multi'"
    ref="rootEl"
    class="${namespace}-cscd"
    :class="{ '${namespace}-cscd--plain': plain }"
  >
    <template v-for="(level, idx) in levelStates" :key="idx">
      <span v-if="idx > 0" class="${namespace}-cscd__sep">{{ separator }}</span>
      <div class="${namespace}-cscd__level" :class="{ '${namespace}-cscd__level--open': activeLevel === idx }">
        <div
          class="${namespace}-cscd__trigger"
          :class="{
            '${namespace}-cscd__trigger--ph': !level.value && !level.label,
            '${namespace}-cscd__trigger--disabled': disabled
          }"
          tabindex="0"
          @click.stop="toggleLevel(idx)"
          @keydown="onKeydownMulti"
        >
          <span class="${namespace}-cscd__trigger-text">{{ level.label || getPlaceholder(idx) }}</span>
          <span class="${namespace}-cscd__arrow">▾</span>
        </div>
      </div>
    </template>

    <Teleport to="body">
      <div
        v-if="activeLevel >= 0"
        ref="panelEl"
        class="${namespace}-cscd__panel"
        :style="panelStyle"
        @click.stop
      >
        <div v-if="isLoadingLevel(activeLevel)" class="${namespace}-cscd__loading">LOADING...</div>
        <template v-else>
          <div
            v-for="opt in activeOptions"
            :key="opt.value"
            class="${namespace}-cscd__option"
            :class="{
              '${namespace}-cscd__option--selected': isSelected(activeLevel, opt.value),
              '${namespace}-cscd__option--disabled': opt.disabled
            }"
            @click="selectMulti(activeLevel, opt)"
          >
            <span class="${namespace}-cscd__opt-text">{{ opt.label }}</span>
            <span v-if="hasNextLevel(activeLevel, opt)" class="${namespace}-cscd__has-next">›</span>
          </div>
          <div v-if="!activeOptions.length" class="${namespace}-cscd__empty">NO OPTIONS</div>
        </template>
      </div>
    </Teleport>
  </div>

  <!-- ========== single 模式：一个 trigger + 多列面板 ========== -->
  <div
    v-else
    ref="rootEl"
    class="${namespace}-cscd ${namespace}-cscd--single"
    :class="{
      '${namespace}-cscd--plain': plain,
      '${namespace}-cscd--open': open,
    }"
  >
    <div
      class="${namespace}-cscd__trigger ${namespace}-cscd__trigger--single"
      :class="{
        '${namespace}-cscd__trigger--ph': !hasValue && !hasCustomLabels,
        '${namespace}-cscd__trigger--disabled': disabled
      }"
      tabindex="0"
      @click.stop="toggleSingle"
      @keydown="onKeydownSingle"
    >
      <span class="${namespace}-cscd__trigger-text">{{ displayText }}</span>
      <span class="${namespace}-cscd__arrow">▾</span>
    </div>

    <Teleport to="body">
      <div
        v-if="open"
        ref="panelEl"
        class="${namespace}-cscd__panel ${namespace}-cscd__panel--cascade"
        :style="panelStyle"
        @click.stop
      >
        <div class="${namespace}-cscd__cols">
          <div v-for="(col, colIdx) in columns" :key="colIdx" class="${namespace}-cscd__col">
            <div v-if="isLoadingCol(colIdx)" class="${namespace}-cscd__loading">LOADING...</div>
            <template v-else>
              <div
                v-for="opt in col"
                :key="opt.value"
                class="${namespace}-cscd__option"
                :class="{
                  '${namespace}-cscd__option--selected': isPathSelected(colIdx, opt.value),
                  '${namespace}-cscd__option--disabled': opt.disabled,
                }"
                @click="onColClick(colIdx, opt)"
              >
                <span class="${namespace}-cscd__opt-text">{{ opt.label }}</span>
                <span v-if="hasNextLevel(colIdx, opt)" class="${namespace}-cscd__has-next">›</span>
              </div>
              <div v-if="!col.length" class="${namespace}-cscd__empty">—</div>
            </template>
          </div>
        </div>
      </div>
    </Teleport>
  </div>
</template>

<script setup>
import { ref, computed, watch, onBeforeUnmount, nextTick, reactive } from 'vue'

const props = defineProps({
  modelValue:   { type: Array,                 default: () => [] },
  labels:       { type: [Array, String],       default: () => [] },
  options:      { type: Array,                 default: () => [] },
  fetchOptions: { type: Function,              default: null },
  placeholder:  { type: String,                default: 'SELECT...' },
  placeholders: { type: Array,                 default: () => [] },
  levels:       { type: [Number, String],      default: 0 },
  disabled:     { type: Boolean,               default: false },
  separator:    { type: String,                default: '/' },
  variant:      { type: String,                default: 'single' },
  plain:        { type: Boolean,               default: false },
})

const emit = defineEmits(['update:modelValue', 'update:labels', 'change'])

const customLabels = computed(() => {
  if (Array.isArray(props.labels)) return props.labels.map(v => v != null ? String(v) : '')
  if (typeof props.labels === 'string' && props.labels) {
    return props.labels.split(/[,，/]/).map(s => s.trim()).filter(Boolean)
  }
  return []
})

const hasCustomLabels = computed(() => customLabels.value.some(Boolean))

const maxLevels = computed(() => {
  const lv = Number(props.levels)
  if (!isNaN(lv) && lv > 0) return lv
  if (props.placeholders && props.placeholders.length > 0) return props.placeholders.length
  if (customLabels.value && customLabels.value.length > 0) return customLabels.value.length
  return 0
})

function getPlaceholder(idx) {
  if (props.labels && customLabels.value[idx]) return customLabels.value[idx]
  if (props.placeholders && props.placeholders[idx]) return props.placeholders[idx]
  return props.placeholder || 'SELECT...'
}

const ROOT_KEY = '__root__'
const optionCache = reactive({})
const loadingKeys = reactive(new Set())

function cacheKey(parentValue) {
  return parentValue === null || parentValue === undefined ? ROOT_KEY : String(parentValue)
}

function hasChildren(opt) {
  if (opt.hasChildren !== undefined) return opt.hasChildren
  if (opt.children && opt.children.length) return true
  if (optionCache[cacheKey(opt.value)] && optionCache[cacheKey(opt.value)].length) return true
  return false
}

function hasNextLevel(currentIdx, opt) {
  if (maxLevels.value > 0) {
    return (currentIdx + 1) < maxLevels.value
  }
  return hasChildren(opt)
}

function findOptInNodes(nodes, value) {
  if (!nodes) return null
  for (const n of nodes) {
    if (String(n.value) === String(value)) return n
  }
  return null
}

function populateStaticCache() {
  for (const k of Object.keys(optionCache)) { delete optionCache[k] }
  if (!props.options || !props.options.length) return
  function walk(nodes, parentKey) {
    optionCache[parentKey] = nodes.map(n => ({
      value: n.value, label: n.label, disabled: n.disabled,
      hasChildren: !!(n.children && n.children.length),
    }))
    for (const n of nodes) {
      if (n.children && n.children.length) walk(n.children, cacheKey(n.value))
    }
  }
  walk(props.options, ROOT_KEY)
}

async function loadLazyOptions(parentValue) {
  const key = cacheKey(parentValue)
  if (optionCache[key]) return optionCache[key]
  if (loadingKeys.has(key)) return []
  if (!props.fetchOptions) return []

  loadingKeys.add(key)
  try {
    const opts = await props.fetchOptions(parentValue)
    optionCache[key] = (opts || []).map(o => ({
      value: o.value, label: o.label, disabled: o.disabled,
      hasChildren: o.hasChildren !== undefined ? o.hasChildren : !!(o.children && o.children.length),
    }))
    return optionCache[key]
  } catch (e) {
    optionCache[key] = []
    return []
  } finally {
    loadingKeys.delete(key)
  }
}

function isLoadingLevel(levelIdx) {
  if (levelIdx < 0 || levelIdx >= levelStates.value.length) return false
  return loadingKeys.has(cacheKey(levelStates.value[levelIdx]._parentValue))
}

function isLoadingCol(colIdx) {
  return columns.value[colIdx] && columns.value[colIdx]._loading === true
}

function initCache() {
  if (props.fetchOptions) {
    for (const k of Object.keys(optionCache)) { delete optionCache[k] }
    loadLazyOptions(null)
  } else {
    populateStaticCache()
  }
}
initCache()

watch(() => props.fetchOptions, () => initCache())
watch(() => props.options, () => { if (!props.fetchOptions) populateStaticCache() }, { deep: true })

function resolveLabels(path) {
  let parentKey = ROOT_KEY
  const labels = []
  const fallbacks = customLabels.value
  for (let i = 0; i < path.length; i++) {
    const v = path[i]
    const nodes = optionCache[parentKey] || []
    const opt = findOptInNodes(nodes, v)
    if (opt) {
      labels.push(opt.label)
      parentKey = cacheKey(opt.value)
    } else if (fallbacks[i]) {
      labels.push(fallbacks[i])
      parentKey = cacheKey(v)
    } else {
      labels.push(String(v))
      parentKey = '__missing__'
    }
  }
  return labels
}

async function ensurePathLoaded(path) {
  let parentValue = null
  for (const v of path) {
    if (!optionCache[cacheKey(parentValue)] && props.fetchOptions) {
      await loadLazyOptions(parentValue)
    }
    const nodes = optionCache[cacheKey(parentValue)] || []
    const opt = findOptInNodes(nodes, v)
    if (opt) parentValue = opt.value
    else break
  }
}

const rootEl = ref(null)
const panelEl = ref(null)

const DEFAULT_PANEL_STYLE = {
  position: 'fixed',
  zIndex: '99999',
  top: '-9999px',
  left: '-9999px',
  visibility: 'hidden',
}
const panelStyle = ref({ ...DEFAULT_PANEL_STYLE })
let isInternalChange = false

const activeLevel = ref(-1)
const levelStates = ref([])

async function initLevels() {
  const rawPath = (props.modelValue || []).filter(Boolean)
  const path = maxLevels.value > 0 ? rawPath.slice(0, maxLevels.value) : rawPath
  const fallbacks = customLabels.value
  
  let targetCount
  if (maxLevels.value > 0) {
    targetCount = maxLevels.value
  } else {
    targetCount = Math.max(path.length + (path.length > 0 ? 1 : 0), fallbacks.length, 1)
  }

  if (props.fetchOptions) await ensurePathLoaded(path)
  const labels = resolveLabels(path)
  const states = []
  let parentValue = null

  for (let i = 0; i < targetCount; i++) {
    const nodes = optionCache[cacheKey(parentValue)] || []
    const val = i < path.length ? path[i] : null
    const lbl = i < path.length ? (labels[i] || fallbacks[i] || null) : (fallbacks[i] || null)
    states.push({
      value: val,
      label: lbl,
      options: nodes,
      _parentValue: parentValue,
    })
    if (i < path.length) {
      const opt = findOptInNodes(nodes, path[i])
      parentValue = opt ? opt.value : path[i]
    } else {
      parentValue = '__none__'
    }
  }
  levelStates.value = states
}
initLevels()

watch(() => props.modelValue, async (v) => {
  if (isInternalChange) return
  const path = (v || []).filter(Boolean)
  const extLabels = resolveLabels(path)
  const curLabels = levelStates.value.map(s => s.label).filter(Boolean)
  if (extLabels.length === curLabels.length && extLabels.every((l, i) => l === curLabels[i])) {
    for (let i = 0; i < path.length; i++) {
      if (levelStates.value[i]) levelStates.value[i].value = path[i]
    }
    return
  }
  await initLevels()
}, { deep: true })

watch([() => props.levels, () => props.labels, () => props.placeholders], () => {
  if (isInternalChange) return
  initLevels()
}, { deep: true })

watch(() => props.options, async () => {
  if (!props.fetchOptions) { populateStaticCache(); await initLevels() }
}, { deep: true })

watch(() => optionCache, () => {
  for (const ls of levelStates.value) {
    const key = cacheKey(ls._parentValue)
    if (optionCache[key] && optionCache[key] !== ls.options) ls.options = optionCache[key]
  }
}, { deep: true })

const activeOptions = computed(() => {
  if (activeLevel.value < 0 || activeLevel.value >= levelStates.value.length) return []
  return levelStates.value[activeLevel.value].options || []
})

function isSelected(levelIdx, val) {
  if (levelIdx >= levelStates.value.length) return false
  return String(levelStates.value[levelIdx].value) === String(val)
}

function toggleLevel(idx) {
  if (props.disabled) return
  if (idx > 0) {
    for (let i = 0; i < idx; i++) {
      if (!levelStates.value[i] || levelStates.value[i].value == null) {
        openPanel(i)
        return
      }
    }
  }
  activeLevel.value === idx ? closePanel() : openPanel(idx)
}

function openPanel(idx) {
  closeSiblings()
  activeLevel.value = idx
  nextTick(() => positionPanelMulti(idx))
}

async function selectMulti(levelIdx, opt) {
  if (opt.disabled) return

  levelStates.value[levelIdx].value = opt.value
  levelStates.value[levelIdx].label = opt.label

  for (let i = levelIdx + 1; i < levelStates.value.length; i++) {
    levelStates.value[i].value = null
    levelStates.value[i].label = null
    levelStates.value[i].options = []
    levelStates.value[i]._parentValue = null
  }

  const currentPath = levelStates.value
    .slice(0, levelIdx + 1)
    .map(s => s.value)
    .filter(v => v != null)

  const willHaveNext = hasNextLevel(levelIdx, opt)

  if (willHaveNext) {
    const nextIdx = levelIdx + 1
    if (maxLevels.value > 0 && nextIdx >= maxLevels.value) {
      emitPath(currentPath, true)
      closePanel()
      return
    }

    if (nextIdx >= levelStates.value.length) {
      levelStates.value.push({
        value: null,
        label: null,
        options: [],
        _parentValue: opt.value
      })
    } else {
      levelStates.value[nextIdx]._parentValue = opt.value
    }

    const childKey = cacheKey(opt.value)
    const childOpts = optionCache[childKey]

    activeLevel.value = nextIdx
    nextTick(() => positionPanelMulti(nextIdx))

    emitPath(currentPath, false)

    if (!childOpts && props.fetchOptions) {
      await loadLazyOptions(opt.value)
      if (levelStates.value[nextIdx]) {
        levelStates.value[nextIdx].options = optionCache[childKey] || []
      }
      nextTick(() => positionPanelMulti(nextIdx))
    } else {
      levelStates.value[nextIdx].options = childOpts || []
    }
  } else {
    emitPath(currentPath, true)
    closePanel()
  }
}

function onKeydownMulti(e) {
  if (props.disabled) return
  if (e.key === 'Enter' || e.key === ' ') { e.preventDefault(); activeLevel.value >= 0 ? closePanel() : openPanel(0) }
  else if (e.key === 'Escape') closePanel()
}

const open = ref(false)
const hasValue = computed(() => (props.modelValue || []).length > 0)

const displayText = computed(() => {
  if (!hasValue.value) {
    if (hasCustomLabels.value) {
      return customLabels.value.filter(Boolean).join(' ' + props.separator + ' ')
    }
    return props.placeholder
  }
  const labels = resolveLabels(props.modelValue)
  return labels.join(' ' + props.separator + ' ')
})

const columns = computed(() => {
  const cols = []
  let parentValue = null
  const path = props.modelValue || []

  cols.push(optionCache[ROOT_KEY] || [])

  for (let i = 0; i < path.length; i++) {
    if (maxLevels.value > 0 && cols.length >= maxLevels.value) {
      break
    }

    const v = path[i]
    const nodes = optionCache[cacheKey(parentValue)] || []
    const opt = findOptInNodes(nodes, v)
    if (opt) {
      parentValue = opt.value
      const childKey = cacheKey(parentValue)

      if (maxLevels.value > 0 && cols.length >= maxLevels.value) {
        break
      }

      if (optionCache[childKey]) {
        cols.push(optionCache[childKey])
      } else if (loadingKeys.has(childKey) || (props.fetchOptions && (!maxLevels.value || cols.length < maxLevels.value))) {
        cols.push(Object.defineProperty([], '_loading', { value: true, enumerable: false }))
        break
      } else {
        break
      }
    } else {
      break
    }
  }

  if (maxLevels.value > 0 && cols.length > maxLevels.value) {
    return cols.slice(0, maxLevels.value)
  }
  return cols
})

function isPathSelected(colIdx, val) {
  const path = props.modelValue || []
  if (colIdx >= path.length) return false
  return String(path[colIdx]) === String(val)
}

async function onColClick(colIdx, opt) {
  if (opt.disabled) return
  const path = [...(props.modelValue || [])]
  path.splice(colIdx)
  path[colIdx] = opt.value

  const willHaveNext = hasNextLevel(colIdx, opt)

  if (willHaveNext) {
    emitPath(path, false)
    const childKey = cacheKey(opt.value)
    if (!optionCache[childKey] && props.fetchOptions) {
      await loadLazyOptions(opt.value)
    }
    nextTick(() => positionPanelSingle())
  } else {
    emitPath(path, true)
    closePanel()
  }
}

function toggleSingle() {
  if (props.disabled) return
  open.value ? closePanel() : openSingle()
}

function openSingle() {
  closeSiblings()
  open.value = true
  nextTick(() => positionPanelSingle())
}

function onKeydownSingle(e) {
  if (props.disabled) return
  if (e.key === 'Enter' || e.key === ' ') { e.preventDefault(); toggleSingle() }
  else if (e.key === 'Escape') closePanel()
}

function closePanel() {
  activeLevel.value = -1
  open.value = false
  panelStyle.value = { ...DEFAULT_PANEL_STYLE }
}

function closeSiblings() {
  document.querySelectorAll('.${namespace}-cscd__panel').forEach(el => {
    if (el !== panelEl.value && el._bnrCscdClose) el._bnrCscdClose()
  })
}

function positionPanelMulti(idx) {
  if (!rootEl.value || !panelEl.value) return
  const triggers = rootEl.value.querySelectorAll('.${namespace}-cscd__trigger')
  if (idx >= triggers.length) return
  positionAt(triggers[idx].getBoundingClientRect())
}

function positionPanelSingle() {
  if (!rootEl.value || !panelEl.value) return
  const trigger = rootEl.value.querySelector('.${namespace}-cscd__trigger--single')
  if (!trigger) return
  positionAt(trigger.getBoundingClientRect())
}

function positionAt(rect) {
  if (!panelEl.value) return
  const pw = panelEl.value.offsetWidth || 220
  const ph = (panelEl.value.offsetHeight && panelEl.value.offsetHeight > 50) ? panelEl.value.offsetHeight : 240
  const style = {
    position: 'fixed',
    zIndex: '99999',
    visibility: 'visible',
  }

  if ((window.innerHeight - rect.bottom) >= ph + 4) {
    style.top = (rect.bottom + 3) + 'px'
  } else {
    style.top = Math.max(8, rect.top - ph - 3) + 'px'
  }

  if (rect.left + pw <= window.innerWidth - 8) {
    style.left = Math.max(8, rect.left) + 'px'
  } else {
    style.left = Math.max(8, rect.right - pw) + 'px'
  }
  panelStyle.value = style
}

function emitPath(path, isFinished = false) {
  isInternalChange = true
  const resolved = resolveLabels(path)
  emit('update:modelValue', path)
  emit('update:labels', resolved)
  if (isFinished) {
    emit('change', path, resolved)
  }
  nextTick(() => { isInternalChange = false })
}

function onDocClick(e) {
  if (rootEl.value && !rootEl.value.contains(e.target) && !(panelEl.value && panelEl.value.contains(e.target))) {
    closePanel()
  }
}

function onScrollResize() {
  if (props.variant === 'single') positionPanelSingle()
  else if (activeLevel.value >= 0) positionPanelMulti(activeLevel.value)
}

const isPanelOpen = computed(() => props.variant === 'single' ? open.value : activeLevel.value >= 0)

watch(isPanelOpen, (v) => {
  if (v) {
    document.addEventListener('click', onDocClick, true)
    window.addEventListener('scroll', onScrollResize, true)
    window.addEventListener('resize', onScrollResize)
  } else {
    document.removeEventListener('click', onDocClick, true)
    window.removeEventListener('scroll', onScrollResize, true)
    window.removeEventListener('resize', onScrollResize)
  }
})

watch(panelEl, (el) => { if (el) el._bnrCscdClose = closePanel })

onBeforeUnmount(() => {
  document.removeEventListener('click', onDocClick, true)
  window.removeEventListener('scroll', onScrollResize, true)
  window.removeEventListener('resize', onScrollResize)
})

defineExpose({ closePanel })
</script>

<style scoped>
/* ══════════════════════════════════════════════
   Protocol Explorer Cascader 蓝图样式规范
   ══════════════════════════════════════════════ */
.${namespace}-cscd {
  display: inline-flex;
  align-items: center;
  gap: 4px;
  font-size: 13px;
  font-family: var(--${namespace}-f, "IBM Plex Mono", monospace);
  user-select: none;
  flex-wrap: wrap;
  flex: 1;
}

/* 级联分隔符 (//) */
.${namespace}-cscd__sep {
  color: var(--${namespace}-mu, #6f7fb4);
  font-weight: 700;
  font-size: 12px;
  padding: 0 2px;
  flex-shrink: 0;
}
.${namespace}-cscd__level {
  position: relative;
  flex-shrink: 0;
}

/* ── 触发框：物理硬阴影、直角细线 ── */
.${namespace}-cscd__trigger {
  display: flex;
  align-items: center;
  justify-content: space-between;
  gap: 8px;
  height: 34px;
  padding: 0 10px;
  border: 1px solid var(--${namespace}-ln, #d3dbef);
  border-radius: 0;
  background: var(--${namespace}-pn, #ffffff);
  color: var(--${namespace}-ink, #0a2a9a);
  cursor: pointer;
  white-space: nowrap;
  min-width: 90px;
  outline: none;
  transition: .15s;
}
.${namespace}-cscd__trigger:hover,
.${namespace}-cscd__level--open .${namespace}-cscd__trigger,
.${namespace}-cscd--single.${namespace}-cscd--open .${namespace}-cscd__trigger--single {
  border-color: var(--${namespace}-pri, #0a2fb5);
  transform: translate(-1px, -1px);
  box-shadow: 3px 3px 0 color-mix(in srgb, var(--${namespace}-pri, #0a2fb5) 30%, transparent);
}
.${namespace}-cscd__trigger--disabled {
  background: var(--${namespace}-bg, #f4f6fb);
  color: var(--${namespace}-mu, #6f7fb4);
  cursor: not-allowed;
  transform: none;
  box-shadow: none;
  border-color: var(--${namespace}-ln, #d3dbef);
}
.${namespace}-cscd__trigger--ph {
  color: var(--${namespace}-mu, #6f7fb4);
  font-weight: normal;
}
.${namespace}-cscd__trigger-text {
  font-weight: 600;
  letter-spacing: .05em;
  overflow: hidden;
  text-overflow: ellipsis;
  flex: 1;
}

/* 折叠箭头指示符 */
.${namespace}-cscd__arrow {
  color: var(--${namespace}-mu, #6f7fb4);
  font-size: 12px;
  line-height: 1;
  transition: transform .15s;
}
.${namespace}-cscd__level--open .${namespace}-cscd__arrow,
.${namespace}-cscd--single.${namespace}-cscd--open .${namespace}-cscd__arrow {
  transform: rotate(180deg);
  color: var(--${namespace}-pri, #0a2fb5);
}

/* single 模式主框体 */
.${namespace}-cscd--single .${namespace}-cscd__trigger--single {
  min-width: 180px;
  width: 100%;
}

/* 无边框变体 */
.${namespace}-cscd--plain .${namespace}-cscd__trigger {
  border-color: transparent !important;
  background: transparent !important;
  box-shadow: none !important;
  transform: none !important;
}

/* ── 弹窗面板：直角、4px 墨水实体投影 ── */
.${namespace}-cscd__panel {
  position: fixed;
  z-index: 99999;
  background: var(--${namespace}-pn, #ffffff);
  border: 1px solid var(--${namespace}-ink, #0a2a9a);
  border-radius: 0;
  box-shadow: 4px 4px 0 var(--${namespace}-ln, #d3dbef);
  max-height: 280px;
  overflow-y: auto;
  box-sizing: border-box;
  font-family: var(--${namespace}-f, "IBM Plex Mono", monospace);
}

/* ── 多列面板 ── */
.${namespace}-cscd__panel--cascade {
  padding: 0;
  overflow: hidden;
  width: auto;
}
.${namespace}-cscd__cols {
  display: flex;
  height: 100%;
}
.${namespace}-cscd__col {
  flex: 1;
  min-width: 140px;
  max-width: 220px;
  overflow-y: auto;
  max-height: 280px;
  border-right: 1px solid var(--${namespace}-ln, #d3dbef);
  padding: 4px 0;
}
.${namespace}-cscd__col:last-child {
  border-right: none;
}

/* ── 选项条目 ── */
.${namespace}-cscd__option {
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: 8px 12px;
  cursor: pointer;
  color: var(--${namespace}-ink, #0a2a9a);
  font-size: 13px;
  white-space: nowrap;
  transition: background .12s;
  border-bottom: 1px solid color-mix(in srgb, var(--${namespace}-ln, #d3dbef) 30%, transparent);
}
.${namespace}-cscd__option:last-child {
  border-bottom: none;
}
.${namespace}-cscd__option:hover {
  background: color-mix(in srgb, var(--${namespace}-ln, #d3dbef) 40%, transparent);
}

/* 选中项状态 */
.${namespace}-cscd__option--selected {
  background: var(--${namespace}-pri, #0a2fb5) !important;
  color: var(--${namespace}-on, #ffffff) !important;
  font-weight: 700;
}
.${namespace}-cscd__opt-text {
  overflow: hidden;
  text-overflow: ellipsis;
  letter-spacing: .05em;
}

/* 下级展开符 */
.${namespace}-cscd__has-next {
  font-size: 14px;
  font-weight: 700;
  color: var(--${namespace}-mu, #6f7fb4);
  flex-shrink: 0;
  margin-left: 10px;
}
.${namespace}-cscd__option--selected .${namespace}-cscd__has-next {
  color: var(--${namespace}-on, #ffffff);
}

/* 禁用态 */
.${namespace}-cscd__option--disabled {
  opacity: .35;
  cursor: not-allowed;
  pointer-events: none;
}

/* 加载与空状态 */
.${namespace}-cscd__empty,
.${namespace}-cscd__loading {
  padding: 16px;
  text-align: center;
  font-size: 12px;
  font-weight: 700;
  letter-spacing: .08em;
}
.${namespace}-cscd__empty {
  color: var(--${namespace}-mu, #6f7fb4);
}
.${namespace}-cscd__loading {
  color: var(--${namespace}-pri, #0a2fb5);
}
</style>