<template>
  <!-- ========== multi 模式：多个 trigger 并排 ========== -->
  <div v-if="variant === 'multi'" class="${namespace}-cscd" ref="rootEl">
    <template v-for="(level, idx) in levelStates" :key="idx">
      <span v-if="idx > 0" class="${namespace}-cscd__sep">{{ separator }}</span>
      <div class="${namespace}-cscd__level" :class="{ '${namespace}-cscd__level--open': activeLevel === idx }">
        <div class="${namespace}-cscd__trigger"
          :class="{ '${namespace}-cscd__trigger--ph': !level.value, '${namespace}-cscd__trigger--disabled': disabled }"
          @click.stop="toggleLevel(idx)"
          @keydown="onKeydownMulti"
          tabindex="0">
          <span class="${namespace}-cscd__trigger-text">{{ level.label || (idx < placeholders.length ? placeholders[idx] : '请选择') }}</span>
        </div>
      </div>
    </template>
    <Teleport to="body">
      <div v-if="activeLevel >= 0" class="${namespace}-cscd__panel" :style="panelStyle" ref="panelEl" @click.stop>
        <div v-if="isLoadingLevel(activeLevel)" class="${namespace}-cscd__loading">加载中...</div>
        <template v-else>
          <div v-for="opt in activeOptions" :key="opt.value"
            class="${namespace}-cscd__option"
            :class="{ '${namespace}-cscd__option--selected': isSelected(activeLevel, opt.value), '${namespace}-cscd__option--disabled': opt.disabled }"
            @click="selectMulti(activeLevel, opt)">
            <span>{{ opt.label }}</span>
            <span v-if="hasChildren(opt)" class="${namespace}-cscd__has-next">&rsaquo;</span>
          </div>
          <div v-if="!activeOptions.length" class="${namespace}-cscd__empty">无匹配选项</div>
        </template>
      </div>
    </Teleport>
  </div>

  <!-- ========== single 模式：一个 trigger + 多列面板 ========== -->
  <div v-else class="${namespace}-cscd ${namespace}-cscd--single" ref="rootEl">
    <div class="${namespace}-cscd__trigger ${namespace}-cscd__trigger--single"
      :class="{ '${namespace}-cscd__trigger--ph': !hasValue, '${namespace}-cscd__trigger--disabled': disabled }"
      @click.stop="toggleSingle"
      @keydown="onKeydownSingle"
      tabindex="0">
      <span class="${namespace}-cscd__trigger-text">{{ displayText }}</span>
    </div>
    <Teleport to="body">
      <div v-if="open" class="${namespace}-cscd__panel ${namespace}-cscd__panel--cascade" :style="panelStyle" ref="panelEl" @click.stop>
        <div class="${namespace}-cscd__cols">
          <div v-for="(col, colIdx) in columns" :key="colIdx" class="${namespace}-cscd__col">
            <div v-if="isLoadingCol(colIdx)" class="${namespace}-cscd__loading">加载中...</div>
            <template v-else>
              <div v-for="opt in col" :key="opt.value"
                class="${namespace}-cscd__option"
                :class="{
                  '${namespace}-cscd__option--selected': isPathSelected(colIdx, opt.value),
                  '${namespace}-cscd__option--disabled': opt.disabled,
                }"
                @click="onColClick(colIdx, opt)">
                <span>{{ opt.label }}</span>
                <span v-if="hasChildren(opt)" class="${namespace}-cscd__has-next">&rsaquo;</span>
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
  modelValue:   { type: Array,    default: () => [] },
  options:      { type: Array,    default: () => [] },
  fetchOptions: { type: Function, default: null },   // async (parentValue) => Option[]
  placeholder:  { type: String,   default: '请选择' },
  placeholders: { type: Array,    default: () => [] },
  disabled:     { type: Boolean,  default: false },
  separator:    { type: String,   default: '/' },
  variant:      { type: String,   default: 'single' },  // 'single' | 'multi'
})

const emit = defineEmits(['update:modelValue', 'change'])

// ═══════════════════════════════════════════
// 统一数据缓存
// ═══════════════════════════════════════════
const ROOT_KEY = '__root__'
const optionCache = reactive({})        // { [parentKey]: Option[] }
const loadingKeys = reactive(new Set()) // 正在加载的 parentKey

function cacheKey(parentValue) {
  return parentValue === null || parentValue === undefined ? ROOT_KEY : String(parentValue)
}

function hasChildren(opt) {
  if (opt.hasChildren !== undefined) return opt.hasChildren
  if (opt.children && opt.children.length) return true
  if (optionCache[cacheKey(opt.value)] && optionCache[cacheKey(opt.value)].length) return true
  return false
}

function findOptInNodes(nodes, value) {
  if (!nodes) return null
  for (const n of nodes) {
    if (String(n.value) === String(value)) return n
  }
  return null
}

// ── 静态模式：从 props.options 全量填充缓存 ──
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

// ── 懒加载模式：按需通过 fetchOptions 加载 ──
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

// ── 初始化缓存 ──
function initCache() {
  if (props.fetchOptions) {
    for (const k of Object.keys(optionCache)) { delete optionCache[k] }
    loadLazyOptions(null) // 预加载根级
  } else {
    populateStaticCache()
  }
}
initCache()

watch(() => props.fetchOptions, () => initCache())
watch(() => props.options, () => { if (!props.fetchOptions) populateStaticCache() }, { deep: true })

// ═══════════════════════════════════════════
// 标签解析（从缓存中查找）
// ═══════════════════════════════════════════
function resolveLabels(path) {
  let parentKey = ROOT_KEY
  const labels = []
  for (const v of path) {
    const nodes = optionCache[parentKey] || []
    const opt = findOptInNodes(nodes, v)
    if (opt) { labels.push(opt.label); parentKey = cacheKey(opt.value) }
    else { labels.push(String(v)); parentKey = '__missing__' }
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

// ═══════════════════════════════════════════
// 通用 state
// ═══════════════════════════════════════════
const rootEl = ref(null)
const panelEl = ref(null)
const panelStyle = ref({})

// ═══════════════════════════════════════════
// multi 模式 state & methods
// ═══════════════════════════════════════════
const activeLevel = ref(-1)
const levelStates = ref([])

async function initLevels() {
  const path = (props.modelValue || []).filter(Boolean)
  if (!path.length) {
    if (!optionCache[ROOT_KEY] && props.fetchOptions) await loadLazyOptions(null)
    levelStates.value = [{ value: null, label: null, options: optionCache[ROOT_KEY] || [], _parentValue: null }]
    return
  }
  if (props.fetchOptions) await ensurePathLoaded(path)
  const labels = resolveLabels(path)
  const states = []
  let parentValue = null
  for (let i = 0; i <= path.length; i++) {
    const nodes = optionCache[cacheKey(parentValue)] || []
    states.push({
      value: i < path.length ? path[i] : null,
      label: i < path.length ? (labels[i] || null) : null,
      options: nodes,
      _parentValue: parentValue,
    })
    if (i < path.length) {
      const opt = findOptInNodes(nodes, path[i])
      parentValue = opt ? opt.value : null
    }
  }
  levelStates.value = states
}
initLevels()

watch(() => props.modelValue, async (v) => {
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

watch(() => props.options, async () => {
  if (!props.fetchOptions) { populateStaticCache(); await initLevels() }
}, { deep: true })

// 缓存变化 → 同步更新 levelStates 中的 options
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
  activeLevel.value === idx ? closePanel() : openPanel(idx)
}

function openPanel(idx) {
  closeSiblings()
  activeLevel.value = idx
  nextTick(() => positionPanelMulti(idx))
}

async function selectMulti(levelIdx, opt) {
  if (opt.disabled) return
  levelStates.value.splice(levelIdx + 1)
  levelStates.value[levelIdx].value = opt.value
  levelStates.value[levelIdx].label = opt.label

  if (hasChildren(opt)) {
    const childKey = cacheKey(opt.value)
    const childOpts = optionCache[childKey]
    levelStates.value.push({ value: null, label: null, options: childOpts || [], _parentValue: opt.value })

    if (!childOpts && props.fetchOptions) {
      const newIdx = levelStates.value.length - 1
      activeLevel.value = newIdx
      nextTick(() => positionPanelMulti(newIdx))
      await loadLazyOptions(opt.value)
      if (levelStates.value[newIdx]) levelStates.value[newIdx].options = optionCache[childKey] || []
    } else {
      activeLevel.value = levelIdx + 1
      nextTick(() => positionPanelMulti(levelIdx + 1))
    }
  } else {
    closePanel()
  }
  emitPath(levelStates.value.map(s => s.value).filter(v => v != null))
}

function onKeydownMulti(e) {
  if (props.disabled) return
  if (e.key === 'Enter' || e.key === ' ') { e.preventDefault(); activeLevel.value >= 0 ? closePanel() : openPanel(0) }
  else if (e.key === 'Escape') closePanel()
}

// ═══════════════════════════════════════════
// single 模式 state & methods
// ═══════════════════════════════════════════
const open = ref(false)

const hasValue = computed(() => (props.modelValue || []).length > 0)

const displayText = computed(() => {
  if (!hasValue.value) return props.placeholder
  const labels = resolveLabels(props.modelValue)
  return labels.join(' ' + props.separator + ' ')
})

const columns = computed(() => {
  const cols = []
  let parentValue = null
  const path = props.modelValue || []

  cols.push(optionCache[ROOT_KEY] || [])

  for (const v of path) {
    const nodes = optionCache[cacheKey(parentValue)] || []
    const opt = findOptInNodes(nodes, v)
    if (opt) {
      parentValue = opt.value
      const childKey = cacheKey(parentValue)
      if (optionCache[childKey]) {
        cols.push(optionCache[childKey])
      } else if (loadingKeys.has(childKey)) {
        cols.push(Object.defineProperty([], '_loading', { value: true, enumerable: false }))
        break
      } else {
        break
      }
    } else {
      break
    }
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

  if (hasChildren(opt)) {
    emitPath(path)
    const childKey = cacheKey(opt.value)
    if (!optionCache[childKey] && props.fetchOptions) {
      await loadLazyOptions(opt.value)
    }
  } else {
    emitPath(path)
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

// ═══════════════════════════════════════════
// 通用: 面板定位 & 关闭
// ═══════════════════════════════════════════
function closePanel() {
  activeLevel.value = -1
  open.value = false
}

function closeSiblings() {
  document.querySelectorAll('.${namespace}-cscd__panel').forEach(el => {
    if (el !== panelEl.value && el._bnrCscdClose) el._bnrCscdClose()
  })
  document.querySelectorAll('.${namespace}-dd--open').forEach(el => {
    if (el._bnrDd) el._bnrDd.close()
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
  const pw = panelEl.value.offsetWidth || 200
  const ph = panelEl.value.offsetHeight || 240
  const style = { position: 'fixed', zIndex: '99999' }
  if ((window.innerHeight - rect.bottom) >= ph || (window.innerHeight - rect.bottom) >= 120) {
    style.top = (rect.bottom + 2) + 'px'
  } else {
    style.bottom = (window.innerHeight - rect.top + 2) + 'px'
  }
  if ((window.innerWidth - rect.left) >= pw) {
    style.right = (window.innerWidth - rect.right) + 'px'
  } else {
    style.left = rect.left + 'px'
  }
  panelStyle.value = style
}

function emitPath(path) {
  emit('update:modelValue', path)
  emit('change', path)
}

// ═══════════════════════════════════════════
// 通用: 外部点击 & scroll 监听
// ═══════════════════════════════════════════
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
/* ═══ 通用 ═══ */
.${namespace}-cscd {
  align-items: center;
  gap: 2px;
  font-size: 12px;
  font-family: var(--${namespace}-font, "Microsoft YaHei", sans-serif);
  user-select: none;
  flex-wrap: wrap;
  flex: 1;
}

/* ═══ multi 模式 ═══ */
.${namespace}-cscd__sep {
  color: var(--${namespace}-text-light, #909eac);
  font-size: 11px;
  padding: 0 1px;
  flex-shrink: 0;
}
.${namespace}-cscd__level { position: relative; flex-shrink: 0; }

/* ═══ trigger 通用 ═══ */
.${namespace}-cscd__trigger {
  display: flex;
  align-items: center;
  gap: 6px;
  height: 22px;
  padding: 0 20px 0 6px;
  border: 1px solid var(--${namespace}-border, #c8c8c8);
  background: #fff;
  color: var(--${namespace}-text, #1c2833);
  cursor: pointer;
  white-space: nowrap;
  min-width: 80px;
  position: relative;
  transition: border-color .15s;
}
.${namespace}-cscd__trigger::after {
  content: '';
  position: absolute;
  right: 7px;
  top: 50%;
  width: 0;
  height: 0;
  border-left: 4px solid transparent;
  border-right: 4px solid transparent;
  border-top: 5px solid var(--${namespace}-text-muted);
  transform: translateY(-50%);
  pointer-events: none;
}
.${namespace}-cscd__trigger:hover { border-color: var(--${namespace}-primary, #1a4f8a); }
.${namespace}-cscd__level--open .${namespace}-cscd__trigger,
.${namespace}-cscd--single .${namespace}-cscd__trigger--single:focus,
.${namespace}-cscd--single .${namespace}-cscd__trigger--single:hover {
  border-color: var(--${namespace}-primary, #1a4f8a);
}
.${namespace}-cscd__trigger--ph { color: var(--${namespace}-text-light, #909eac); }
.${namespace}-cscd__trigger--disabled { background: #f5f7fa; color: var(--${namespace}-text-muted, #5d6d7e); cursor: not-allowed; }
.${namespace}-cscd__trigger-text { overflow: hidden; text-overflow: ellipsis; flex: 1; }
.${namespace}-cscd__arrow {
  position: absolute; right: 5px; top: 50%; transform: translateY(-50%);
  font-size: 9px; color: var(--${namespace}-text-muted, #5d6d7e); pointer-events: none; flex-shrink: 0;
}

/* single trigger */
.${namespace}-cscd--single .${namespace}-cscd__trigger--single {
  min-width: 160px;
}

/* ═══ 面板通用 ═══ */
.${namespace}-cscd__panel {
  background: #fff;
  border: 1px solid var(--${namespace}-primary-border, #d0d8e8);
  box-shadow: 0 4px 12px rgba(0,0,0,.12);
  max-height: 240px;
  overflow-y: auto;
  padding: 3px 0;
}

/* ═══ single: 多列面板 ═══ */
.${namespace}-cscd__panel--cascade {
  padding: 0;
  overflow: hidden;
}
.${namespace}-cscd__cols {
  display: flex;
  height: 100%;
}
.${namespace}-cscd__col {
  flex: 1;
  min-width: 130px;
  max-width: 200px;
  overflow-y: auto;
  max-height: 240px;
  border-right: 1px solid var(--${namespace}-border-light, #e4e8f0);
  padding: 3px 0;
}
.${namespace}-cscd__col:last-child { border-right: none; }

/* ═══ 选项 ═══ */
.${namespace}-cscd__option {
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: 5px 10px;
  cursor: pointer;
  color: var(--${namespace}-text, #1c2833);
  font-size: 12px;
  white-space: nowrap;
}
.${namespace}-cscd__option:hover { background: var(--${namespace}-primary-bg, #e8edf5); color: var(--${namespace}-primary, #1a4f8a); }
.${namespace}-cscd__option--selected { background: var(--${namespace}-primary, #1a4f8a); color: #fff; font-weight: bold; }
.${namespace}-cscd__option--selected:hover { background: var(--${namespace}-primary-dark, #15407a); color: #fff; }
.${namespace}-cscd__option--disabled { color: var(--${namespace}-text-disabled, #c8d0d8); cursor: not-allowed; }
.${namespace}-cscd__option--disabled:hover { background: none; color: var(--${namespace}-text-disabled, #c8d0d8); }
.${namespace}-cscd__has-next {
  font-size: 14px;
  color: var(--${namespace}-text-light, #909eac);
  flex-shrink: 0;
  margin-left: 8px;
}
.${namespace}-cscd__option--selected .${namespace}-cscd__has-next { color: rgba(255,255,255,.7); }
.${namespace}-cscd__empty {
  padding: 12px;
  text-align: center;
  color: var(--${namespace}-text-light, #909eac);
  font-size: 12px;
}
.${namespace}-cscd__loading {
  padding: 12px;
  text-align: center;
  color: var(--${namespace}-primary, #1a4f8a);
  font-size: 12px;
}
</style>
