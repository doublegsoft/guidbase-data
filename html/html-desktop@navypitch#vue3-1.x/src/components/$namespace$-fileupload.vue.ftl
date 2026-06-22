<template>
  <div class="fu-root" :class="{ 'fu--disabled': disabled }"
       @dragover.prevent="dragging=true" @dragleave.prevent="dragging=false" @drop.prevent="onDrop">
    <label v-if="label" class="form-label">{{ label }}</label>

    <!-- File list -->
    <div class="fu-list" v-if="items.length > 0">
      <div v-for="(item, idx) in items" :key="item.id"
           class="fu-item"
           :class="{ 'fu-item--uploading': item.uploading, 'fu-item--error': item.error }">
        <!-- File icon -->
        <span class="fu-item__icon">{{ fileIcon(item.file?.name || item.name) }}</span>
        <!-- Info -->
        <div class="fu-item__info">
          <span class="fu-item__name" :title="item.file?.name || item.name">
            {{ truncate(item.file?.name || item.name, 28) }}
          </span>
          <span class="fu-item__meta">
            {{ formatSize(item.file?.size || 0) }}
            <span v-if="item.uploading"> · 上传中 {{ Math.round(item.progress) }}%</span>
            <span v-else-if="item.error" style="color:var(--color-red)"> · 失败</span>
            <span v-else style="color:var(--color-teal)"> · 已上传</span>
          </span>
        </div>
        <!-- Progress bar -->
        <div v-if="item.uploading" class="fu-item__progress">
          <div class="fu-item__progress-bar" :style="{ width: item.progress + '%' }"></div>
        </div>
        <!-- Delete -->
        <button v-if="!disabled && !item.uploading" class="fu-item__delete"
                @click="removeItem(idx)" title="删除">✕</button>
        <!-- Completion pulse -->
        <div v-if="item.justDone" class="fu-item__pulse"></div>
      </div>
    </div>

    <!-- Add button -->
    <div v-if="items.length < maxCount && !disabled"
         class="fu-add"
         :class="{ 'fu-add--dragover': dragging }"
         @click="triggerInput" role="button" tabindex="0"
         @keydown.enter="triggerInput" @keydown.space.prevent="triggerInput">
      <span class="fu-add__icon">+</span>
      <span>{{ items.length === 0 ? placeholder : '继续添加文件' }}</span>
    </div>

    <div v-if="hint && !disabled" class="fu-hint">{{ hint }}</div>

    <input ref="inputRef" type="file" class="fu-input" :accept="accept"
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
  const u = ['B','KB','MB','GB']; let i = 0
  let s = bytes
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
  /** 对象数组中唯一标识的字段名 */
  key: { type: String, default: 'id' },
  /** 对象数组中展示文件名的字段名 */
  text: { type: String, default: 'name' },
  /** 对象数组中 URL 的字段名 */
  url: { type: String, default: 'url' },
  label: { type: String, default: '' },
  placeholder: { type: String, default: '上传文件' },
  hint: { type: String, default: '' },
  maxCount: { type: Number, default: 10 },
  maxSizeMB: { type: Number, default: 50 },
  accept: { type: String, default: '.pdf,.doc,.docx,.xls,.xlsx,.ppt,.pptx,.txt,.csv,.zip' },
  disabled: { type: Boolean, default: false },
  /** 自定义上传函数 (file, { setProgress }) => Promise<{ url }>，不传则模拟上传 */
  customUpload: { type: Function, default: null },
})

const emit = defineEmits(['update:modelValue', 'upload', 'error', 'remove'])

const inputRef = ref(null), dragging = ref(false)
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
      item.progress = 100
      item.justDone = true
      item.url = result.url || item.file?.name || ''
      setTimeout(() => {
        item.uploading = false
        item.justDone = false
        emit('upload', { file: item.file, ...result, index: items.value.indexOf(item) })
        syncModel()
      }, 350)
    }).catch(err => {
      item.error = true
      item.uploading = false
      emit('error', err?.message || '上传失败')
    })
    return
  }

  // Built-in simulated upload
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
      item.progress = 100; clearInterval(interval)
      item.justDone = true
      setTimeout(() => { item.url = item.file?.name||''; item.uploading = false; item.justDone = false; emit('upload',{file:item.file,index:items.value.indexOf(item)}); syncModel() }, 350)
    }
  }, tick)
}

function removeItem(idx) { items.value.splice(idx, 1); syncModel(); emit('remove', { index: idx }) }
</script>

<style scoped>
.fu-root { display: flex; flex-direction: column; gap: var(--space-4); }
.fu--disabled { opacity: 0.55; pointer-events: none; }

.fu-list { display: flex; flex-direction: column; gap: var(--space-2); }

.fu-item {
  position: relative;
  display: flex; align-items: center; gap: var(--space-6);
  padding: var(--space-5) var(--space-7);
  background: var(--color-card);
  border: 1px solid var(--color-border);
  border-radius: var(--radius-md);
  transition: all var(--transition-base);
  overflow: hidden;
}
.fu-item:hover { border-color: var(--color-teal); }
.fu-item--error { border-color: var(--color-red); box-shadow: 0 0 0 2px var(--color-red-dim); }

.fu-item__icon { font-size: 24px; flex-shrink: 0; }
.fu-item__info { flex: 1; min-width: 0; display: flex; flex-direction: column; gap: var(--space-1); }
.fu-item__name { font-size: var(--text-md); font-weight: var(--weight-medium); color: var(--color-text-main); white-space: nowrap; overflow: hidden; text-overflow: ellipsis; }
.fu-item__meta { font-size: var(--text-xs); color: var(--color-text-muted); }

.fu-item__progress { position: absolute; bottom: 0; left: 0; right: 0; height: 3px; background: var(--color-surface); }
.fu-item__progress-bar { height: 100%; background: var(--color-teal); transition: width 0.08s linear; border-radius: 0 2px 2px 0; }

.fu-item__delete {
  flex-shrink: 0; width: 28px; height: 28px; border-radius: var(--radius-full);
  background: transparent; border: none; cursor: pointer; font-size: var(--text-md);
  color: var(--color-text-muted); transition: all var(--transition-fast); font-family: inherit;
}
.fu-item__delete:hover { background: var(--color-red-dim); color: var(--color-red); }

.fu-item__pulse {
  position: absolute; inset: -2px; border-radius: var(--radius-md);
  border: 2px solid var(--color-teal);
  animation: fu-pulse 0.4s ease-out forwards; pointer-events: none; z-index: 2;
}
@keyframes fu-pulse { 0%{opacity:1;transform:scale(0.98)} 100%{opacity:0;transform:scale(1.04)} }

.fu-add {
  display: flex; align-items: center; justify-content: center; gap: var(--space-4);
  padding: var(--space-7); border: 2px dashed var(--color-border); border-radius: var(--radius-md);
  cursor: pointer; font-size: var(--text-md); color: var(--color-text-muted);
  transition: all var(--transition-base);
}
.fu-add:hover, .fu-add--dragover { border-color: var(--color-teal); background: var(--color-teal-dim); color: var(--color-teal); }
.fu-add__icon { font-size: 22px; font-weight: var(--weight-light); }

.fu-hint { font-size: var(--text-xs); color: var(--color-text-muted); }
.fu-input { position: absolute; width: 0; height: 0; opacity: 0; pointer-events: none; }
</style>
