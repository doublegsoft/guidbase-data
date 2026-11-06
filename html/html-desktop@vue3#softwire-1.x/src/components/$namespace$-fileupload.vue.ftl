<template>
  <div
    class="${namespace}-fu"
    :class="{ '${namespace}-fu--disabled': disabled }"
    @dragover.prevent="dragging = true"
    @dragleave.prevent="dragging = false"
    @drop.prevent="onDrop"
  >
    <label v-if="label" class="${namespace}-field-label">{{ label }}</label>

    <!-- 已选文件流列表 -->
    <div v-if="items.length > 0" class="${namespace}-fu__list">
      <div
        v-for="(item, idx) in items"
        :key="item.id"
        class="${namespace}-fu__item"
        :class="{
          '${namespace}-fu__item--uploading': item.uploading,
          '${namespace}-fu__item--error': item.error
        }"
      >
        <!-- 等宽代码扩展名方块徽章 (替代 Emoji) -->
        <span class="${namespace}-fu__item-badge">
          {{ getExt(item.file?.name || item.name) }}
        </span>

        <!-- 文件详情信息 -->
        <div class="${namespace}-fu__item-info">
          <span class="${namespace}-fu__item-name" :title="item.file?.name || item.name">
            {{ truncate(item.file?.name || item.name, 32) }}
          </span>
          <span class="${namespace}-fu__item-meta">
            {{ formatSize(item.file?.size || 0) }}
            <span v-if="item.uploading" class="${namespace}-fu__text--uploading"> // TRANSMITTING {{ Math.round(item.progress) }}%</span>
            <span v-else-if="item.error" class="${namespace}-fu__text--error"> // ERROR</span>
            <span v-else class="${namespace}-fu__text--success"> // UPLOADED</span>
          </span>
        </div>

        <!-- 传输进度条 -->
        <div v-if="item.uploading" class="${namespace}-fu__item-progress">
          <div class="${namespace}-fu__item-progress-bar" :style="{ width: item.progress + '%' }"></div>
        </div>

        <!-- 删除直角叉号按钮 -->
        <button
          v-if="!disabled && !item.uploading"
          type="button"
          class="${namespace}-fu__item-delete"
          title="REMOVE"
          @click="removeItem(idx)"
        >&times;</button>
      </div>
    </div>

    <!-- 蓝图工程添加/拖拽槽位 (Dashed Add Box) -->
    <div
      v-if="items.length < maxCount && !disabled"
      class="${namespace}-fu__add"
      :class="{ '${namespace}-fu__add--dragover': dragging }"
      role="button"
      tabindex="0"
      @click="triggerInput"
      @keydown.enter="triggerInput"
      @keydown.space.prevent="triggerInput"
    >
      <span class="${namespace}-fu__add-icon">+</span>
      <span class="${namespace}-fu__add-text">
        {{ items.length === 0 ? (placeholder || 'CHOOSE FILE OR DRAG HERE') : 'APPEND ANOTHER FILE' }}
      </span>
      <span class="${namespace}-fu__add-quota">[{{ items.length }}/{{ maxCount }}]</span>
    </div>

    <div v-if="hint && !disabled" class="${namespace}-fu__hint">{{ hint }}</div>

    <!-- 原生隐藏输入框 -->
    <input
      ref="inputRef"
      type="file"
      class="${namespace}-fu__input"
      :accept="accept"
      :multiple="maxCount > 1"
      @change="onFileChange"
    />
  </div>
</template>

<script setup>
import { ref, watch } from 'vue'

let nextId = 1
function genId() { return 'file_' + Date.now() + '_' + (nextId++) }

function truncate(name, max) {
  if (!name) return ''
  if (name.length <= max) return name
  const ext = name.lastIndexOf('.')
  if (ext > 0 && name.length - ext <= 6) {
    return name.slice(0, max - (name.length - ext) - 2) + '…' + name.slice(ext)
  }
  return name.slice(0, max - 1) + '…'
}

function formatSize(bytes) {
  if (!bytes) return '0 B'
  const u = ['B', 'KB', 'MB', 'GB']
  let i = 0
  let s = bytes
  while (s >= 1024 && i < u.length - 1) { s /= 1024; i++ }
  return s.toFixed(i > 0 ? 1 : 0) + ' ' + u[i]
}

function getExt(name) {
  if (!name) return 'RAW'
  const ext = name.split('.').pop()?.toUpperCase()
  return ext && ext.length <= 4 ? ext : 'FILE'
}

const props = defineProps({
  modelValue:   { type: Array,    default: () => [] },
  key:          { type: String,   default: 'id' },
  text:         { type: String,   default: 'name' },
  url:          { type: String,   default: 'url' },
  label:        { type: String,   default: '' },
  placeholder:  { type: String,   default: '' },
  hint:         { type: String,   default: '' },
  maxCount:     { type: Number,   default: 10 },
  maxSizeMB:    { type: Number,   default: 50 },
  accept:       { type: String,   default: '.pdf,.doc,.docx,.xls,.xlsx,.ppt,.pptx,.txt,.csv,.zip' },
  disabled:     { type: Boolean,  default: false },
  customUpload: { type: Function, default: null },
})

const emit = defineEmits(['update:modelValue', 'upload', 'error', 'remove'])

const inputRef = ref(null)
const dragging = ref(false)
const items = ref([])

watch(() => props.modelValue, (vals) => {
  const safe = Array.isArray(vals) ? vals : []
  if (safe.length === 0) { items.value = []; return }
  if (items.value.length === 0) {
    items.value = safe.map(v => {
      if (typeof v === 'string') {
        return { id: genId(), name: v, url: v, uploading: false, progress: 0, error: false, file: null, _raw: v }
      }
      return { id: v[props.key] || genId(), name: v[props.text] || v.name || '', url: v[props.url] || v.url || '', uploading: false, progress: 0, error: false, file: v.file || null, _raw: v }
    })
  }
}, { immediate: true })

function syncModel() {
  const result = items.value.map(i => {
    if (i._raw && typeof i._raw === 'object') {
      return { ...i._raw, [props.text]: i.file?.name || i.name, [props.url]: i.url, size: i.file?.size || 0 }
    }
    return { name: i.file?.name || i.name, url: i.url, size: i.file?.size || 0 }
  })
  emit('update:modelValue', result)
}

function triggerInput() {
  if (!props.disabled) inputRef.value?.click()
}

function onDrop(e) {
  dragging.value = false
  if (props.disabled) return
  const files = Array.from(e.dataTransfer?.files || [])
  if (files.length) addFiles(files)
}

function onFileChange(e) {
  const files = Array.from(e.target?.files || [])
  if (files.length) addFiles(files)
  if (inputRef.value) inputRef.value.value = ''
}

function addFiles(files) {
  const remaining = props.maxCount - items.value.length
  if (remaining <= 0) { emit('error', '最多上传 ' + props.maxCount + ' 个文件'); return }
  for (const file of files.slice(0, remaining)) {
    if (file.size > props.maxSizeMB * 1024 * 1024) { emit('error', file.name + ' 超过 ' + props.maxSizeMB + 'MB 限制'); continue }
    const item = { id: genId(), name: file.name, url: '', uploading: true, progress: 0, error: false, file }
    items.value.push(item)
    simulateUpload(item)
  }
  syncModel()
}

function simulateUpload(item) {
  if (props.customUpload) {
    props.customUpload(item.file, {
      setProgress: (p) => { item.progress = Math.min(99, p) },
    }).then(result => {
      item.progress = 100
      item.url = result.url || item.file?.name || ''
      item.uploading = false
      emit('upload', { file: item.file, ...result, index: items.value.indexOf(item) })
      syncModel()
    }).catch(err => {
      item.error = true
      item.uploading = false
      emit('error', err?.message || '上传失败')
    })
    return
  }
  let elapsed = 0
  const totalDuration = 800 + Math.random() * 1200
  const tick = 50
  const interval = setInterval(() => {
    elapsed += tick
    const ratio = elapsed / totalDuration
    item.progress = Math.min(99, Math.round(ratio * 100))
    if (ratio >= 1) {
      item.progress = 100
      clearInterval(interval)
      item.url = item.file?.name || ''
      item.uploading = false
      emit('upload', { file: item.file, index: items.value.indexOf(item) })
      syncModel()
    }
  }, tick)
}

function removeItem(idx) {
  items.value.splice(idx, 1)
  syncModel()
  emit('remove', { index: idx })
}
</script>

<style scoped>
/* ══════════════════════════════════════════════
   Protocol Explorer FileUpload 蓝图工程规范
   ══════════════════════════════════════════════ */
.${namespace}-fu {
  display: flex;
  flex-direction: column;
  gap: 6px;
  width: 100%;
  font-family: var(--${namespace}-f, "IBM Plex Mono", monospace);
  font-size: 13px;
  user-select: none;
}
.${namespace}-fu--disabled {
  opacity: .45;
  pointer-events: none;
}

/* 列表容器 */
.${namespace}-fu__list {
  display: flex;
  flex-direction: column;
  gap: 4px;
}

/* ── 已选文件卡片项：直角、1px 细线、硬阴影悬停 ── */
.${namespace}-fu__item {
  position: relative;
  display: flex;
  align-items: center;
  gap: 8px;
  padding: 4px 10px;
  background: var(--${namespace}-pn, #ffffff);
  border: 1px solid var(--${namespace}-ln, #d3dbef);
  border-radius: 0;
  transition: .12s;
  overflow: hidden;
  min-height: 32px;
  box-sizing: border-box;
}
.${namespace}-fu__item:hover {
  border-color: var(--${namespace}-ink, #0a2a9a);
  transform: translate(-1px, -1px);
  box-shadow: 2px 2px 0 var(--${namespace}-ln, #d3dbef);
}
.${namespace}-fu__item--error {
  border-color: var(--${namespace}-red, #d6343e);
  background: var(--${namespace}-sel, #fdecee);
}

/* 等宽扩展名徽章 (替代 Emoji) */
.${namespace}-fu__item-badge {
  font-size: 10px;
  font-weight: 800;
  padding: 1px 4px;
  background: color-mix(in srgb, var(--${namespace}-pri, #0a2fb5) 12%, transparent);
  border: 1px solid color-mix(in srgb, var(--${namespace}-pri, #0a2fb5) 25%, transparent);
  color: var(--${namespace}-pri, #0a2fb5);
  line-height: 1.2;
  letter-spacing: .05em;
  flex-shrink: 0;
}

/* 文件名称与状态 */
.${namespace}-fu__item-info {
  flex: 1;
  min-width: 0;
  display: flex;
  align-items: baseline;
  gap: 8px;
}
.${namespace}-fu__item-name {
  font-size: 12px;
  font-weight: 600;
  color: var(--${namespace}-ink, #0a2a9a);
  white-space: nowrap;
  overflow: hidden;
  text-overflow: ellipsis;
  letter-spacing: .02em;
}
.${namespace}-fu__item-meta {
  font-size: 11px;
  color: var(--${namespace}-mu, #6f7fb4);
  white-space: nowrap;
  flex-shrink: 0;
}
.${namespace}-fu__text--uploading {
  color: var(--${namespace}-cmd, #f0a500);
  font-weight: 700;
}
.${namespace}-fu__text--success {
  color: var(--${namespace}-tcp, #13a05d);
  font-weight: 700;
}
.${namespace}-fu__text--error {
  color: var(--${namespace}-red, #d6343e);
  font-weight: 700;
}

/* 传输进度槽位 */
.${namespace}-fu__item-progress {
  position: absolute;
  bottom: 0;
  left: 0;
  right: 0;
  height: 2px;
  background: var(--${namespace}-ln, #d3dbef);
}
.${namespace}-fu__item-progress-bar {
  height: 100%;
  background: var(--${namespace}-pri, #0a2fb5);
  transition: width 0.08s linear;
}

/* 删除直角按钮 */
.${namespace}-fu__item-delete {
  flex-shrink: 0;
  width: 18px;
  height: 18px;
  background: transparent;
  border: 1px solid transparent;
  cursor: pointer;
  font-size: 14px;
  font-weight: 700;
  color: var(--${namespace}-mu, #6f7fb4);
  transition: .12s;
  display: flex;
  align-items: center;
  justify-content: center;
  padding: 0;
  line-height: 1;
}
.${namespace}-fu__item-delete:hover {
  background: var(--${namespace}-sel, #fdecee);
  border-color: var(--${namespace}-red, #d6343e);
  color: var(--${namespace}-red, #d6343e);
}

/* ── 添加/拖拽区域：直角虚线、等宽配额 ── */
.${namespace}-fu__add {
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 6px;
  padding: 0 12px;
  border: 1px dashed var(--${namespace}-ln, #d3dbef);
  border-radius: 0;
  background: var(--${namespace}-bg, #f4f6fb);
  cursor: pointer;
  color: var(--${namespace}-mu, #6f7fb4);
  font-size: 12px;
  font-weight: 700;
  height: 32px;
  transition: .15s;
  box-sizing: border-box;
}
.${namespace}-fu__add:hover,
.${namespace}-fu__add--dragover {
  border-color: var(--${namespace}-pri, #0a2fb5);
  background: color-mix(in srgb, var(--${namespace}-pri, #0a2fb5) 8%, transparent);
  color: var(--${namespace}-pri, #0a2fb5);
}
.${namespace}-fu__add-icon {
  font-size: 14px;
  line-height: 1;
}
.${namespace}-fu__add-text {
  letter-spacing: .05em;
}
.${namespace}-fu__add-quota {
  font-size: 11px;
  opacity: .7;
}

/* 提示文本 */
.${namespace}-fu__hint {
  font-size: 11px;
  color: var(--${namespace}-mu, #6f7fb4);
  line-height: 1.3;
}
.${namespace}-fu__input {
  position: absolute;
  width: 0;
  height: 0;
  opacity: 0;
  pointer-events: none;
}
</style>