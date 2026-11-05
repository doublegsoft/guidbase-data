<template>
  <div class="${namespace}-fu" :class="{ '${namespace}-fu--disabled': disabled }"
       @dragover.prevent="dragging=true" @dragleave.prevent="dragging=false" @drop.prevent="onDrop">
    <label v-if="label" class="${namespace}-field-label">{{ label }}</label>

    <div class="${namespace}-fu__list" v-if="items.length > 0">
      <div v-for="(item, idx) in items" :key="item.id"
           class="${namespace}-fu__item"
           :class="{ '${namespace}-fu__item--uploading': item.uploading, '${namespace}-fu__item--error': item.error }">
        <span class="${namespace}-fu__item-icon">{{ fileIcon(item.file?.name || item.name) }}</span>
        <div class="${namespace}-fu__item-info">
          <span class="${namespace}-fu__item-name" :title="item.file?.name || item.name">
            {{ truncate(item.file?.name || item.name, 28) }}
          </span>
          <span class="${namespace}-fu__item-meta">
            {{ formatSize(item.file?.size || 0) }}
            <span v-if="item.uploading"> · 上传中 {{ Math.round(item.progress) }}%</span>
            <span v-else-if="item.error" class="${namespace}-fu__text--error"> · 失败</span>
            <span v-else class="${namespace}-fu__text--success"> · 已上传</span>
          </span>
        </div>
        <div v-if="item.uploading" class="${namespace}-fu__item-progress">
          <div class="${namespace}-fu__item-progress-bar" :style="{ width: item.progress + '%' }"></div>
        </div>
        <button v-if="!disabled && !item.uploading" class="${namespace}-fu__item-delete"
                @click="removeItem(idx)" title="删除">✕</button>
        <div v-if="item.justDone" class="${namespace}-fu__item-pulse"></div>
      </div>
    </div>

    <div v-if="items.length < maxCount && !disabled"
         class="${namespace}-fu__add"
         :class="{ '${namespace}-fu__add--dragover': dragging }"
         @click="triggerInput" role="button" tabindex="0"
         @keydown.enter="triggerInput" @keydown.space.prevent="triggerInput">
      <span class="${namespace}-fu__add-icon">+</span>
      <span>{{ items.length === 0 ? placeholder : '继续添加文件' }}</span>
    </div>

    <div v-if="hint && !disabled" class="${namespace}-fu__hint">{{ hint }}</div>

    <input ref="inputRef" type="file" class="${namespace}-fu__input" :accept="accept"
           :multiple="maxCount > 1" @change="onFileChange" />
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
  const u = ['B','KB','MB','GB']; let i = 0; let s = bytes
  while (s >= 1024 && i < u.length-1) { s /= 1024; i++ }
  return s.toFixed(i > 0 ? 1 : 0) + ' ' + u[i]
}

const FILE_ICONS = {
  pdf: '📄', doc: '📝', docx: '📝', xls: '📊', xlsx: '📊',
  ppt: '📽', pptx: '📽', txt: '📃', csv: '📊',
  zip: '📦', rar: '📦', '7z': '📦',
  mp4: '🎬', mov: '🎬', avi: '🎬', mp3: '🎵', wav: '🎵',
  jpg: '🖼', png: '🖼', gif: '🖼', webp: '🖼',
}
function fileIcon(name) {
  if (!name) return '📎'
  const ext = name.split('.').pop()?.toLowerCase()
  return FILE_ICONS[ext] || '📎'
}

const props = defineProps({
  modelValue: { type: Array, default: () => [] },
  key: { type: String, default: 'id' },
  text: { type: String, default: 'name' },
  url: { type: String, default: 'url' },
  label: { type: String, default: '' },
  placeholder: { type: String, default: '上传文件' },
  hint: { type: String, default: '' },
  maxCount: { type: Number, default: 10 },
  maxSizeMB: { type: Number, default: 50 },
  accept: { type: String, default: '.pdf,.doc,.docx,.xls,.xlsx,.ppt,.pptx,.txt,.csv,.zip' },
  disabled: { type: Boolean, default: false },
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
      return { id: v[props.key]||genId(), name: v[props.text]||v.name||'', url: v[props.url]||v.url||'', uploading: false, progress: 0, error: false, file: v.file||null, _raw: v }
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

function triggerInput() { if (!props.disabled) inputRef.value?.click() }
function onDrop(e) { dragging.value = false; if (props.disabled) return; const files = Array.from(e.dataTransfer?.files||[]); if (files.length) addFiles(files) }
function onFileChange(e) { const files = Array.from(e.target?.files||[]); if (files.length) addFiles(files); if (inputRef.value) inputRef.value.value = '' }

function addFiles(files) {
  const remaining = props.maxCount - items.value.length
  if (remaining <= 0) { emit('error', '最多上传 ' + props.maxCount + ' 个文件'); return }
  for (const file of files.slice(0, remaining)) {
    if (file.size > props.maxSizeMB*1024*1024) { emit('error', file.name + ' 超过 ' + props.maxSizeMB + 'MB 限制'); continue }
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
      item.progress = 100; item.justDone = true; item.url = result.url || item.file?.name || ''
      setTimeout(() => { item.uploading = false; item.justDone = false; emit('upload', { file: item.file, ...result, index: items.value.indexOf(item) }); syncModel() }, 350)
    }).catch(err => {
      item.error = true; item.uploading = false
      emit('error', err?.message || '上传失败')
    })
    return
  }
  let elapsed = 0
  const totalDuration = 1000 + Math.random() * 2000
  const tick = 60
  const interval = setInterval(() => {
    elapsed += tick
    const ratio = elapsed / totalDuration
    const curved = 1/(1+Math.exp(-10*(ratio-0.4)))
    const noise = (Math.random()-0.5)*0.06
    item.progress = Math.min(99, Math.round((curved+noise)*100))
    if (ratio >= 1) {
      item.progress = 100; clearInterval(interval); item.justDone = true
      setTimeout(() => { item.url = item.file?.name||''; item.uploading = false; item.justDone = false; emit('upload',{file:item.file,index:items.value.indexOf(item)}); syncModel() }, 350)
    }
  }, tick)
}

function removeItem(idx) { items.value.splice(idx, 1); syncModel(); emit('remove', { index: idx }) }
</script>

<style scoped>
/* ══════════════════════════════════════════════
   FILE UPLOAD — BNR Style (紧凑型)
   ══════════════════════════════════════════════ */

.${namespace}-fu { display: flex; flex-direction: column; gap: 3px; }
.${namespace}-fu--disabled { opacity: 0.5; pointer-events: none; }

/* ── Label 顶部对齐与微边距 ──────────────────── */
.${namespace}-field-label {
  align-self: flex-start;
  padding-top: 2px;
  padding-bottom: 2px;
  line-height: 1.2;
}

.${namespace}-fu__list { display: flex; flex-direction: column; gap: 2px; }

/* ── 单项卡片（紧凑化） ──────────────────────── */
.${namespace}-fu__item {
  position: relative;
  display: flex; align-items: center; gap: 5px;
  padding: 2px 6px;
  background: var(--${namespace}-bg);
  border: 1px solid var(--${namespace}-border);
  border-radius: var(--${namespace}-radius-sm, 2px);
  transition: border-color 0.15s ease;
  overflow: hidden;
  min-height: 24px;
}
.${namespace}-fu__item:hover { border-color: var(--${namespace}-primary); }
.${namespace}-fu__item--error { border-color: var(--${namespace}-danger); box-shadow: 0 0 0 1px var(--${namespace}-danger-bg); }

.${namespace}-fu__item-icon { font-size: 14px; line-height: 1; flex-shrink: 0; }
.${namespace}-fu__item-info { flex: 1; min-width: 0; display: flex; flex-direction: column; gap: 0; }
.${namespace}-fu__item-name {
  font-size: 11px; font-weight: 500; color: var(--${namespace}-text);
  white-space: nowrap; overflow: hidden; text-overflow: ellipsis;
  line-height: 1.2;
}
.${namespace}-fu__item-meta { font-size: 9px; color: var(--${namespace}-text-muted); line-height: 1.2; }
.${namespace}-fu__text--success { color: var(--${namespace}-success); }
.${namespace}-fu__text--error { color: var(--${namespace}-danger); }

.${namespace}-fu__item-progress { position: absolute; bottom: 0; left: 0; right: 0; height: 1.5px; background: var(--${namespace}-bg-page); }
.${namespace}-fu__item-progress-bar { height: 100%; background: var(--${namespace}-primary); transition: width 0.08s linear; }

/* ── 删除按钮微型化 ──────────────────────────── */
.${namespace}-fu__item-delete {
  flex-shrink: 0; width: 16px; height: 16px; border-radius: 50%;
  background: transparent; border: none; cursor: pointer; font-size: 10px;
  color: var(--${namespace}-text-muted); transition: all 0.12s ease;
  font-family: var(--${namespace}-font);
  display: flex; align-items: center; justify-content: center;
  padding: 0; line-height: 1;
}
.${namespace}-fu__item-delete:hover { background: var(--${namespace}-danger-bg); color: var(--${namespace}-danger); }

.${namespace}-fu__item-pulse {
  position: absolute; inset: -1px; border-radius: var(--${namespace}-radius-sm, 2px);
  border: 1px solid var(--${namespace}-primary);
  animation: fu-pulse 0.35s ease-out forwards; pointer-events: none; z-index: 2;
}
@keyframes fu-pulse {
  0% { opacity:1; transform:scale(0.98); }
  100% { opacity:0; transform:scale(1.02); }
}

/* ── 添加按钮（高度缩为标准 22px，对齐输入框） ── */
.${namespace}-fu__add {
  display: flex; align-items: center; justify-content: center; gap: 4px;
  padding: 0 8px; border: 1px dashed var(--${namespace}-border);
  border-radius: var(--${namespace}-radius-sm, 2px);
  cursor: pointer; font-size: 11px; color: var(--${namespace}-text-muted);
  transition: all 0.15s ease;
  height: 22px;
}
.${namespace}-fu__add:hover, .${namespace}-fu__add--dragover {
  border-color: var(--${namespace}-primary); background: var(--${namespace}-primary-bg); color: var(--${namespace}-primary);
}
.${namespace}-fu__add-icon { font-size: 13px; font-weight: 300; line-height: 1; }

.${namespace}-fu__hint { font-size: 9px; color: var(--${namespace}-text-muted); line-height: 1.2; }
.${namespace}-fu__input { position: absolute; width: 0; height: 0; opacity: 0; pointer-events: none; }
</style>