<template>
  <div
    class="ef-vu"
    :class="{ 'ef-vu--disabled': disabled }"
    @dragover.prevent="onDragOver"
    @dragleave.prevent="onDragLeave"
    @drop.prevent="onDrop"
  >
    <label v-if="label" class="ef-field-label">{{ label }}</label>

    <!-- ── 视频网格 ──────────────────────────── -->
    <div class="ef-vu__grid">
      <div
        v-for="(item, idx) in items" :key="item.id"
        class="ef-vu__cell"
        :class="{
          'ef-vu__cell--uploading': item.uploading,
          'ef-vu__cell--error': item.error,
        }"
      >
        <!-- 缩略图 / 骨架 -->
        <img
          v-if="item.thumbnailUrl"
          :src="item.thumbnailUrl"
          class="ef-vu__thumb"
          alt=""
        />
        <div v-else class="ef-vu__thumb ef-vu__thumb--empty">
          <span class="ef-vu__thumb-icon">🎬</span>
          <span v-if="item.extracting" class="ef-vu__thumb-text">提取帧…</span>
        </div>

        <!-- 时长角标 -->
        <span v-if="item.duration && !item.uploading" class="ef-vu__duration">
          {{ formatDuration(item.duration) }}
        </span>

        <!-- 播放按钮 (居中) -->
        <div
          v-if="!item.uploading && item.thumbnailUrl"
          class="ef-vu__play-btn"
          @click="playVideo(idx)"
        >
          <span>▶</span>
        </div>

        <!-- 悬停操作 -->
        <div v-if="!disabled && !item.uploading" class="ef-vu__actions">
          <span class="ef-vu__actions-del" @click.stop="removeItem(idx)" title="删除">✕</span>
        </div>

        <!-- 进度条 -->
        <div v-if="item.uploading" class="ef-vu__progress-bar">
          <div class="ef-vu__progress-fill" :style="{ width: item.progress + '%' }"></div>
        </div>
        <div v-if="item.justDone" class="ef-vu__done-flash"></div>
        <span v-if="item.error" class="ef-vu__error-mark" title="上传失败">!</span>

        <!-- 隐藏 video 用于提取缩略图 -->
        <video
          v-if="item.extracting"
          :ref="el => setVideoRef(idx, el)"
          :src="item.blobUrl"
          muted preload="metadata"
          class="ef-vu__hidden-video"
          @loadedmetadata="onVideoMeta(idx, $event)"
          @seeked="onVideoSeeked(idx, $event)"
        />
      </div>

      <!-- 添加格 -->
      <div
        v-if="items.length < maxCount && !disabled"
        class="ef-vu__cell ef-vu__cell--add"
        :class="{ 'ef-vu__cell--dragover': dragging }"
        @click="triggerInput"
      >
        <span class="ef-vu__add-icon">+</span>
        <span class="ef-vu__add-text">{{ items.length === 0 ? placeholder : (items.length + '/' + maxCount) }}</span>
      </div>
    </div>

    <div v-if="hint" class="ef-vu__hint">{{ hint }}</div>

    <input ref="inputRef" type="file" class="ef-vu__input" :accept="accept"
           :multiple="maxCount > 1" @change="onFileChange" />

    <!-- ── 播放器灯箱 (匹配 ef-dialog 风格) ──────── -->
    <Teleport to="body">
      <Transition name="ef-vu-lb">
        <div v-if="playerVisible" class="ef-vu__lightbox" @click="closePlayer">
          <div class="ef-vu__lightbox-mask"></div>
          <div class="ef-vu__lightbox-body" @click.stop>
            <div class="ef-vu__lightbox-head">
              <span class="ef-vu__lightbox-title">视频播放</span>
              <button class="ef-vu__lightbox-close" @click="closePlayer">✕</button>
            </div>
            <div class="ef-vu__lightbox-main">
              <video
                v-if="playerUrl"
                :src="playerUrl"
                class="ef-vu__player-video"
                controls autoplay
              />
            </div>
          </div>
        </div>
      </Transition>
    </Teleport>
  </div>
</template>

<script setup>
import { ref, watch, onBeforeUnmount } from 'vue'

let nextId = 1
function genId() { return `vid_${r"${"}Date.now()}_${r"${"}nextId++}` }

function formatDuration(sec) {
  if (!sec || !isFinite(sec)) return ''
  const m = Math.floor(sec / 60)
  const s = Math.floor(sec % 60)
  return `${r"${"}m}:${r"${"}String(s).padStart(2, '0')}`
}

const props = defineProps({
  modelValue:  { type: Array, default: () => [] },
  key:         { type: String, default: 'id' },
  url:         { type: String, default: 'url' },
  thumbnail:   { type: String, default: 'thumbnailUrl' },
  duration:    { type: String, default: 'duration' },
  label:       { type: String, default: '' },
  placeholder: { type: String, default: '上传视频' },
  hint:        { type: String, default: '' },
  maxCount:    { type: Number, default: 9 },
  maxSizeMB:   { type: Number, default: 100 },
  maxDuration: { type: Number, default: 300 },
  accept:      { type: String, default: 'video/mp4, video/webm, video/quicktime, video/x-msvideo' },
  disabled:    { type: Boolean, default: false },
  customUpload:{ type: Function, default: null },
})

const emit = defineEmits(['update:modelValue', 'upload', 'error', 'remove'])

const inputRef = ref(null)
const dragging = ref(false)
const playerVisible = ref(false)
const playerUrl = ref('')
const videoRefs = {}

function setVideoRef(idx, el) { if (el) videoRefs[idx] = el }

const items = ref([])

watch(() => props.modelValue, (vals) => {
  const safe = Array.isArray(vals) ? vals : []
  if (safe.length === 0) { items.value = []; return }
  if (items.value.length === 0) {
    items.value = safe.map(v => {
      if (typeof v === 'string') {
        return { id: genId(), thumbnailUrl: '', url: v, duration: 0, uploading: false, progress: 0, error: false, extracting: false, blobUrl: '', file: null, _raw: v }
      }
      const src = v[props.url] || v.url || ''
      return {
        id: v[props.key] || genId(),
        thumbnailUrl: v[props.thumbnail] || v.thumbnailUrl || src,
        url: src,
        duration: v[props.duration] || v.duration || 0,
        uploading: false, progress: 0, error: false,
        extracting: false, blobUrl: '', file: v.file || null, _raw: v,
      }
    })
  }
}, { immediate: true })

function syncModel() {
  const vals = items.value.map(i => {
    const base = { url: i.url || '', thumbnailUrl: i.thumbnailUrl || '', duration: i.duration || 0 }
    if (i._raw && typeof i._raw === 'object') {
      return { ...i._raw, [props.url]: i.url || '', [props.thumbnail]: i.thumbnailUrl || '', [props.duration]: i.duration || 0, [props.key]: i.id }
    }
    return base
  })
  emit('update:modelValue', vals)
}

function triggerInput() { if (!props.disabled) inputRef.value?.click() }
function onDragOver() { if (!props.disabled) dragging.value = true }
function onDragLeave() { dragging.value = false }
function onDrop(e) {
  dragging.value = false
  if (props.disabled) return
  const files = Array.from(e.dataTransfer?.files || []).filter(f => f.type.startsWith('video/'))
  if (files.length) addFiles(files)
}
function onFileChange(e) {
  const files = Array.from(e.target?.files || [])
  if (files.length) addFiles(files)
  if (inputRef.value) inputRef.value.value = ''
}

async function addFiles(files) {
  const remaining = props.maxCount - items.value.length
  if (remaining <= 0) { emit('error', `最多上传 ${r"${"}props.maxCount} 个视频`); return }
  for (const file of files.slice(0, remaining)) {
    if (!file.type.startsWith('video/')) { emit('error', `${r"${"}file.name} 不是视频文件`); continue }
    if (file.size > props.maxSizeMB * 1024 * 1024) { emit('error', `${r"${"}file.name} 超过 ${r"${"}props.maxSizeMB}MB 限制`); continue }
    const blobUrl = URL.createObjectURL(file)
    items.value.push({ id: genId(), thumbnailUrl: '', url: '', duration: 0, uploading: true, progress: 0, error: false, extracting: true, blobUrl, file })
  }
  syncModel()
}

function onVideoMeta(idx, e) {
  const video = e.target
  const item = items.value[idx]
  if (!item) return
  if (video.duration > props.maxDuration) {
    item.error = true; item.extracting = false; item.uploading = false
    URL.revokeObjectURL(item.blobUrl)
    emit('error', `视频时长 ${r"${"}Math.round(video.duration)}s 超过 ${r"${"}props.maxDuration}s 限制`)
    syncModel(); return
  }
  item.duration = video.duration
  video.currentTime = Math.min(1, video.duration * 0.1)
}

function onVideoSeeked(idx, e) {
  const video = e.target
  const item = items.value[idx]
  if (!item || item.thumbnailUrl) return
  try {
    const cvs = document.createElement('canvas')
    cvs.width = 320; cvs.height = 180
    cvs.getContext('2d').drawImage(video, 0, 0, cvs.width, cvs.height)
    item.thumbnailUrl = cvs.toDataURL('image/jpeg', 0.85)
  } catch (_) { /* 无缩略图 */ }
  item.extracting = false
  URL.revokeObjectURL(item.blobUrl)
  delete videoRefs[idx]
  simulateUpload(item).then(() => syncModel())
}

function simulateUpload(item) {
  if (props.customUpload) {
    return props.customUpload(item.file, {
      setProgress: (p) => { item.progress = Math.min(99, p) },
    }).then(result => {
      item.progress = 100; item.justDone = true
      item.url = result.url || item.thumbnailUrl || ''
      if (result.thumbnailUrl) item.thumbnailUrl = result.thumbnailUrl
      if (result.duration != null) item.duration = result.duration
      setTimeout(() => { item.uploading = false; item.justDone = false; emit('upload', { ...result, url: item.url, thumbnailUrl: item.thumbnailUrl, duration: item.duration }) }, 350)
    }).catch(err => { item.error = true; item.uploading = false; emit('error', err?.message || '上传失败') })
  }
  return new Promise(resolve => {
    let elapsed = 0
    const dur = 1500 + Math.random() * 2000
    const iv = setInterval(() => {
      elapsed += 80
      const r = elapsed / dur
      item.progress = Math.min(99, Math.round((1/(1+Math.exp(-10*(r-0.4))) + (Math.random()-0.5)*0.05)*100))
      if (r >= 1) {
        item.progress = 100; clearInterval(iv); item.justDone = true
        setTimeout(() => { item.url = item.thumbnailUrl; item.uploading = false; item.justDone = false; emit('upload', { url: item.url, thumbnailUrl: item.thumbnailUrl, duration: item.duration }); resolve() }, 300)
      }
    }, 80)
  })
}

function removeItem(idx) {
  const item = items.value[idx]
  if (item.blobUrl) URL.revokeObjectURL(item.blobUrl)
  items.value.splice(idx, 1); syncModel()
  emit('remove', { index: idx, item })
}

function playVideo(idx) {
  const item = items.value[idx]
  if (!item || item.uploading) return
  playerUrl.value = item.blobUrl || item.url || item.thumbnailUrl
  playerVisible.value = true
}
function closePlayer() { playerVisible.value = false; playerUrl.value = '' }

function onKeydown(e) {
  if (e.key === 'Escape' && playerVisible.value) closePlayer()
}
if (typeof window !== 'undefined') window.addEventListener('keydown', onKeydown)

onBeforeUnmount(() => {
  items.value.forEach(i => { if (i.blobUrl) URL.revokeObjectURL(i.blobUrl) })
  if (typeof window !== 'undefined') window.removeEventListener('keydown', onKeydown)
})
</script>

<style scoped>
/* ══════════════════════════════════════════════
   VIDEO UPLOAD — BNR Enterprise Style
   ══════════════════════════════════════════════ */

.ef-vu { display: flex; flex-direction: column; gap: var(--ef-sp-xs); }
.ef-vu--disabled { opacity: 0.45; pointer-events: none; }

/* ── 视频网格 ─────────────────────────────── */
.ef-vu__grid {
  display: grid;
  grid-template-columns: repeat(3, 1fr);
  gap: 4px;
}

.ef-vu__cell {
  position: relative;
  aspect-ratio: 16 / 9;
  border: 1px solid var(--ef-border);
  background: var(--ef-bg-page);
  overflow: hidden;
  transition: border-color 0.15s;
}
.ef-vu__cell:hover { border-color: var(--ef-primary); }
.ef-vu__cell--error { border-color: var(--ef-danger) !important; }

/* 缩略图 */
.ef-vu__thumb {
  width: 100%; height: 100%;
  object-fit: cover;
  display: block;
}
.ef-vu__thumb--empty {
  display: flex; flex-direction: column; align-items: center; justify-content: center;
  gap: 4px;
}
.ef-vu__thumb-icon { font-size: 28px; opacity: 0.25; }
.ef-vu__thumb-text { font-size: 10px; color: var(--ef-text-light); }

/* 时长角标 */
.ef-vu__duration {
  position: absolute; bottom: 2px; right: 2px;
  padding: 0 4px; height: 16px; line-height: 16px;
  background: rgba(28,40,51,0.78); color: #fff;
  font-size: 10px; font-family: var(--ef-mono); font-weight: 600;
  user-select: none;
}

/* 播放按钮 */
.ef-vu__play-btn {
  position: absolute; inset: 0;
  display: flex; align-items: center; justify-content: center;
  cursor: pointer;
}
.ef-vu__play-btn span {
  width: 36px; height: 36px; line-height: 36px; text-align: center;
  background: rgba(26,79,138,0.7); color: #fff;
  font-size: 14px; transition: background 0.12s, transform 0.12s;
}
.ef-vu__cell:hover .ef-vu__play-btn span {
  background: var(--ef-primary);
  transform: scale(1.08);
}

/* 悬停操作 */
.ef-vu__actions {
  position: absolute; top: 0; right: 0; z-index: 2;
  opacity: 0; transition: opacity 0.15s;
}
.ef-vu__cell:hover .ef-vu__actions { opacity: 1; }
.ef-vu__actions-del {
  width: 22px; height: 20px;
  display: flex; align-items: center; justify-content: center;
  cursor: pointer; font-size: 11px; line-height: 1;
  background: rgba(28,40,51,0.55); color: #fff;
  transition: background 0.12s;
}
.ef-vu__actions-del:hover { background: var(--ef-danger); }

/* 进度条 */
.ef-vu__progress-bar {
  position: absolute; bottom: 0; left: 0; right: 0; height: 2px;
  background: var(--ef-border-light);
}
.ef-vu__progress-fill {
  height: 100%; background: var(--ef-primary);
  transition: width 0.1s linear;
}

/* 完成闪烁 */
.ef-vu__done-flash {
  position: absolute; inset: 0;
  border: 2px solid var(--ef-success);
  animation: vu-flash 0.35s ease-out forwards;
  pointer-events: none;
}
@keyframes vu-flash {
  0%   { opacity: 1; }
  100% { opacity: 0; }
}

/* 错误标记 */
.ef-vu__error-mark {
  position: absolute; top: 1px; left: 3px;
  width: 16px; height: 16px; line-height: 16px; text-align: center;
  background: var(--ef-danger); color: #fff;
  font-size: 10px; font-weight: bold;
}

/* 添加格 */
.ef-vu__cell--add {
  border: 1px dashed var(--ef-border);
  display: flex; flex-direction: column; align-items: center; justify-content: center;
  gap: 2px; cursor: pointer;
  transition: border-color 0.15s, background 0.15s;
}
.ef-vu__cell--add:hover,
.ef-vu__cell--dragover {
  border-color: var(--ef-primary);
  background: var(--ef-primary-bg);
}
.ef-vu__add-icon {
  font-size: 22px; color: var(--ef-text-light); font-weight: 300; line-height: 1;
}
.ef-vu__cell--add:hover .ef-vu__add-icon,
.ef-vu__cell--dragover .ef-vu__add-icon { color: var(--ef-primary); }
.ef-vu__add-text {
  font-size: 10px; color: var(--ef-text-light);
}

.ef-vu__hint { font-size: 10px; color: var(--ef-text-light); }
.ef-vu__input,
.ef-vu__hidden-video { position: absolute; width: 0; height: 0; opacity: 0; pointer-events: none; }

/* ══════════════════════════════════════════════
   播放灯箱 — 匹配 ef-dialog 风格
   ══════════════════════════════════════════════ */
.ef-vu__lightbox {
  position: fixed; inset: 0; z-index: 1100;
  display: flex; align-items: center; justify-content: center;
}
.ef-vu__lightbox-mask {
  position: absolute; inset: 0;
  background: rgba(0,0,0,0.5);
}
.ef-vu__lightbox-body {
  position: relative;
  width: 90vw; max-width: 860px;
  background: var(--ef-bg);
  border-radius: var(--ef-radius-md);
  box-shadow: 0 8px 32px rgba(0,0,0,0.25);
  display: flex; flex-direction: column;
  z-index: 1;
}

/* 灯箱头部 */
.ef-vu__lightbox-head {
  display: flex; align-items: center; justify-content: space-between;
  padding: 10px 14px; flex-shrink: 0;
  border-bottom: 2px solid var(--ef-primary);
}
.ef-vu__lightbox-title {
  font-size: 14px; font-weight: bold; color: var(--ef-primary);
}
.ef-vu__lightbox-close {
  width: 26px; height: 26px; border: none; background: none;
  cursor: pointer; font-size: 14px; color: var(--ef-text-light);
  display: flex; align-items: center; justify-content: center;
  border-radius: var(--ef-radius-sm); transition: color 0.12s, background 0.12s;
}
.ef-vu__lightbox-close:hover { color: var(--ef-text); background: var(--ef-bg-page); }

/* 灯箱主体 */
.ef-vu__lightbox-main {
  flex: 1; overflow: hidden;
  display: flex; align-items: center; justify-content: center;
  background: #000;
}
.ef-vu__player-video {
  width: 100%; max-height: 70vh;
  display: block; outline: none;
}

/* 灯箱过渡 */
.ef-vu-lb-enter-active,
.ef-vu-lb-leave-active { transition: opacity 0.2s ease; }
.ef-vu-lb-enter-from,
.ef-vu-lb-leave-to { opacity: 0; }
.ef-vu-lb-enter-active .ef-vu__lightbox-body {
  transition: transform 0.2s ease, opacity 0.2s ease;
}
.ef-vu-lb-enter-from .ef-vu__lightbox-body {
  transform: scale(0.95); opacity: 0;
}
</style>
