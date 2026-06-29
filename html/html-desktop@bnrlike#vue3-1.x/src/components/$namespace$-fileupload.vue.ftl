<template>
  <div class="ef-fu" :class="{ 'ef-fu--disabled': disabled }"
       @dragover.prevent="dragging=true" @dragleave.prevent="dragging=false" @drop.prevent="onDrop">
    <label v-if="label" class="ef-field-label">{{ label }}</label>

    <div class="ef-fu__list" v-if="items.length > 0">
      <div v-for="(item, idx) in items" :key="item.id"
           class="ef-fu__item"
           :class="{ 'ef-fu__item--uploading': item.uploading, 'ef-fu__item--error': item.error }">
        <span class="ef-fu__item-icon">{{ fileIcon(item.file?.name || item.name) }}</span>
        <div class="ef-fu__item-info">
          <span class="ef-fu__item-name" :title="item.file?.name || item.name">
            {{ truncate(item.file?.name || item.name, 28) }}
          </span>
          <span class="ef-fu__item-meta">
            {{ formatSize(item.file?.size || 0) }}
            <span v-if="item.uploading"> · 上传中 {{ Math.round(item.progress) }}%</span>
            <span v-else-if="item.error" class="ef-fu__text--error"> · 失败</span>
            <span v-else class="ef-fu__text--success"> · 已上传</span>
          </span>
        </div>
        <div v-if="item.uploading" class="ef-fu__item-progress">
          <div class="ef-fu__item-progress-bar" :style="{ width: item.progress + '%' }"></div>
        </div>
        <button v-if="!disabled && !item.uploading" class="ef-fu__item-delete"
                @click="removeItem(idx)" title="删除">✕</button>
        <div v-if="item.justDone" class="ef-fu__item-pulse"></div>
      </div>
    </div>

    <div v-if="items.length < maxCount && !disabled"
         class="ef-fu__add"
         :class="{ 'ef-fu__add--dragover': dragging }"
         @click="triggerInput" role="button" tabindex="0"
         @keydown.enter="triggerInput" @keydown.space.prevent="triggerInput">
      <span class="ef-fu__add-icon">+</span>
      <span>{{ items.length === 0 ? placeholder : '继续添加文件' }}</span>
    </div>

    <div v-if="hint && !disabled" class="ef-fu__hint">{{ hint }}</div>

    <input ref="inputRef" type="file" class="ef-fu__input" :accept="accept"
           :multiple="maxCount > 1" @change="onFileChange" />
  </div>
</template>

<script setup>
import { ref, watch } from 'vue'

let nextId = 1
function genId() { return `file_${r"${"}Date.now()}_${r"${"}nextId++}` }

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
  return `${r"${"}s.toFixed(i>0?1:0)} ${r"${"}u[i]}`
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
  if (remaining <= 0) { emit('error', `最多上传 ${r"${"}props.maxCount} 个文件`); return }
  for (const file of files.slice(0, remaining)) {
    if (file.size > props.maxSizeMB*1024*1024) { emit('error', `${r"${"}file.name} 超过 ${r"${"}props.maxSizeMB}MB 限制`); continue }
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
   FILE UPLOAD — BNR Style
   ══════════════════════════════════════════════ */

.ef-fu { display: flex; flex-direction: column; gap: 4px; }
.ef-fu--disabled { opacity: 0.5; pointer-events: none; }

.ef-fu__list { display: flex; flex-direction: column; gap: 3px; }

.ef-fu__item {
  position: relative;
  display: flex; align-items: center; gap: 6px;
  padding: 5px 7px; background: var(--ef-bg);
  border: 1px solid var(--ef-border); border-radius: var(--ef-radius-sm);
  transition: all 0.18s ease; overflow: hidden;
}
.ef-fu__item:hover { border-color: var(--ef-primary); }
.ef-fu__item--error { border-color: var(--ef-danger); box-shadow: 0 0 0 2px var(--ef-danger-bg); }

.ef-fu__item-icon { font-size: 20px; flex-shrink: 0; }
.ef-fu__item-info { flex: 1; min-width: 0; display: flex; flex-direction: column; gap: 1px; }
.ef-fu__item-name {
  font-size: 12px; font-weight: 500; color: var(--ef-text);
  white-space: nowrap; overflow: hidden; text-overflow: ellipsis;
}
.ef-fu__item-meta { font-size: 10px; color: var(--ef-text-muted); }
.ef-fu__text--success { color: var(--ef-success); }
.ef-fu__text--error { color: var(--ef-danger); }

.ef-fu__item-progress { position: absolute; bottom: 0; left: 0; right: 0; height: 2px; background: var(--ef-bg-page); }
.ef-fu__item-progress-bar { height: 100%; background: var(--ef-primary); transition: width 0.08s linear; border-radius: 0 1px 1px 0; }

.ef-fu__item-delete {
  flex-shrink: 0; width: 22px; height: 22px; border-radius: 50%;
  background: transparent; border: none; cursor: pointer; font-size: 12px;
  color: var(--ef-text-muted); transition: all 0.12s ease; font-family: var(--ef-font);
  display: flex; align-items: center; justify-content: center;
}
.ef-fu__item-delete:hover { background: var(--ef-danger-bg); color: var(--ef-danger); }

.ef-fu__item-pulse {
  position: absolute; inset: -2px; border-radius: var(--ef-radius-sm);
  border: 2px solid var(--ef-primary);
  animation: fu-pulse 0.4s ease-out forwards; pointer-events: none; z-index: 2;
}
@keyframes fu-pulse {
  0% { opacity:1; transform:scale(0.98); }
  100% { opacity:0; transform:scale(1.04); }
}

.ef-fu__add {
  display: flex; align-items: center; justify-content: center; gap: 4px;
  padding: 6px; border: 1px dashed var(--ef-border); border-radius: var(--ef-radius-sm);
  cursor: pointer; font-size: 12px; color: var(--ef-text-muted);
  transition: all 0.18s ease; height: 28px;
}
.ef-fu__add:hover, .ef-fu__add--dragover {
  border-color: var(--ef-primary); background: var(--ef-primary-bg); color: var(--ef-primary);
}
.ef-fu__add-icon { font-size: 16px; font-weight: 300; }

.ef-fu__hint { font-size: 10px; color: var(--ef-text-muted); }
.ef-fu__input { position: absolute; width: 0; height: 0; opacity: 0; pointer-events: none; }
</style>
