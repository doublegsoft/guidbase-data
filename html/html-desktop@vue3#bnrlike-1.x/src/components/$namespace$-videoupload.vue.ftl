<template>
  <div
    class="${namespace}-vu"
    :class="{ '${namespace}-vu--disabled': disabled }"
    @dragover.prevent="onDragOver"
    @dragleave.prevent="onDragLeave"
    @drop.prevent="onDrop"
  >
    <label v-if="label" class="${namespace}-field-label">{{ label }}</label>

    <!-- ── 缩略图网格 (与图片组件完全一致：4列横排限宽 280px) ── -->
    <div class="${namespace}-vu__grid">
      <div
        v-for="(item, idx) in items" :key="item.id"
        class="${namespace}-vu__cell"
        :class="{
          '${namespace}-vu__cell--uploading': item.uploading,
          '${namespace}-vu__cell--error': item.error,
        }"
      >
        <!-- 缩略图：有封面图优先显示封面图，无封面图显示视频首帧，防止破图 -->
        <img
          v-if="item.thumbnailUrl"
          :src="item.thumbnailUrl"
          class="${namespace}-vu__thumb"
          alt=""
          @click="playVideo(idx)"
          @error="item.thumbnailUrl = ''"
        />
        <video
          v-else-if="item.url || item.blobUrl"
          :src="item.blobUrl || item.url"
          class="${namespace}-vu__thumb"
          preload="metadata"
          muted
          @click="playVideo(idx)"
        />
        <div v-else class="${namespace}-vu__thumb ${namespace}-vu__thumb--empty" @click="playVideo(idx)">🎬</div>

        <!-- 时长角标 -->
        <span v-if="item.duration && !item.uploading" class="${namespace}-vu__duration">
          {{ formatDuration(item.duration) }}
        </span>

        <!-- 悬停操作栏 (与图片完全一致) -->
        <div v-if="!disabled && !item.uploading" class="${namespace}-vu__actions">
          <span class="${namespace}-vu__actions-preview" @click="playVideo(idx)" title="播放">▶</span>
          <span class="${namespace}-vu__actions-del" @click="removeItem(idx)" title="删除">✕</span>
        </div>

        <!-- 上传进度条 -->
        <div v-if="item.uploading" class="${namespace}-vu__progress-bar">
          <div class="${namespace}-vu__progress-fill" :style="{ width: item.progress + '%' }"></div>
        </div>

        <!-- 完成闪烁 -->
        <div v-if="item.justDone" class="${namespace}-vu__done-flash"></div>

        <!-- 错误标记 -->
        <span v-if="item.error" class="${namespace}-vu__error-mark" title="上传失败">!</span>

        <!-- 隐藏 video 用于提取缩略图与时长 -->
        <video
          v-if="item.extracting"
          :ref="el => setVideoRef(idx, el)"
          :src="item.blobUrl"
          muted preload="metadata"
          class="${namespace}-vu__hidden-video"
          @loadedmetadata="onVideoMeta(idx, $event)"
          @seeked="onVideoSeeked(idx, $event)"
        />
      </div>

      <!-- 添加按钮 (与图片完全一致) -->
      <div
        v-if="items.length < maxCount && !disabled"
        class="${namespace}-vu__cell ${namespace}-vu__cell--add"
        :class="{ '${namespace}-vu__cell--dragover': dragging }"
        @click="triggerInput"
      >
        <span class="${namespace}-vu__add-icon">+</span>
        <span class="${namespace}-vu__add-text">{{ items.length === 0 ? placeholder : (items.length + '/' + maxCount) }}</span>
      </div>
    </div>

    <div v-if="hint" class="${namespace}-vu__hint">{{ hint }}</div>

    <input ref="inputRef" type="file" class="${namespace}-vu__input" :accept="accept"
           :multiple="maxCount > 1" @change="onFileChange" />

    <!-- ── 播放器灯箱 ──────────────────────────── -->
    <Teleport to="body">
      <Transition name="${namespace}-vu-lb">
        <div v-if="playerVisible" class="${namespace}-vu__lightbox" @click="closePlayer">
          <div class="${namespace}-vu__lightbox-mask"></div>
          <div class="${namespace}-vu__lightbox-body" @click.stop>
            <div class="${namespace}-vu__lightbox-head">
              <span class="${namespace}-vu__lightbox-title">视频播放</span>
              <button class="${namespace}-vu__lightbox-close" @click="closePlayer">✕</button>
            </div>
            <div class="${namespace}-vu__lightbox-main">
              <video
                v-if="playerUrl"
                :src="playerUrl"
                class="${namespace}-vu__player-video"
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
function genId() { return 'vid_' + Date.now() + '_' + (nextId++) }

function formatDuration(sec) {
  if (!sec || !isFinite(sec)) return ''
  const m = Math.floor(sec / 60)
  const s = Math.floor(sec % 60)
  return m + ':' + String(s).padStart(2, '0')
}

function isVideoUrl(url) {
  if (!url || typeof url !== 'string') return false
  return /\.(mp4|webm|ogg|mov|avi|wmv|m4v)(\?.*)?$/i.test(url) || url.startsWith('data:video/')
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
        const isVid = isVideoUrl(v)
        return {
          id: genId(),
          thumbnailUrl: isVid ? '' : v,
          url: v,
          duration: 0,
          uploading: false,
          progress: 0,
          error: false,
          extracting: false,
          blobUrl: '',
          file: null,
          _raw: v
        }
      }
      const src = v[props.url] || v.url || ''
      const rawThumb = v[props.thumbnail] || v.thumbnailUrl || ''
      return {
        id: v[props.key] || genId(),
        thumbnailUrl: isVideoUrl(rawThumb) ? '' : rawThumb,
        url: src,
        duration: v[props.duration] || v.duration || 0,
        uploading: false,
        progress: 0,
        error: false,
        extracting: false,
        blobUrl: '',
        file: v.file || null,
        _raw: v,
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
  if (remaining <= 0) { emit('error', '最多上传 ' + props.maxCount + ' 个视频'); return }
  for (const file of files.slice(0, remaining)) {
    if (!file.type.startsWith('video/')) { emit('error', file.name + ' 不是视频文件'); continue }
    if (file.size > props.maxSizeMB * 1024 * 1024) { emit('error', file.name + ' 超过 ' + props.maxSizeMB + 'MB 限制'); continue }
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
    emit('error', '视频时长 ' + Math.round(video.duration) + 's 超过 ' + props.maxDuration + 's 限制')
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
  } catch (_) {}
  item.extracting = false
  delete videoRefs[idx]
  simulateUpload(item).then(() => syncModel())
}

function simulateUpload(item) {
  if (props.customUpload) {
    return props.customUpload(item.file, {
      setProgress: (p) => { item.progress = Math.min(99, p) },
    }).then(result => {
      item.progress = 100; item.justDone = true
      item.url = result.url || item.blobUrl || ''
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
        setTimeout(() => { item.url = item.blobUrl; item.uploading = false; item.justDone = false; emit('upload', { url: item.url, thumbnailUrl: item.thumbnailUrl, duration: item.duration }); resolve() }, 300)
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
  playerUrl.value = item.blobUrl || item.url || ''
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
   VIDEO UPLOAD — 完全匹配 IMAGE UPLOAD 规范
   ══════════════════════════════════════════════ */

.${namespace}-vu { display: flex; flex-direction: column; gap: var(--${namespace}-sp-xs); }
.${namespace}-vu--disabled { opacity: 0.45; pointer-events: none; }

/* ── Label 顶部对齐与留白 ────────────────────── */
.${namespace}-field-label {
  align-self: flex-start;
  padding-top: 2px;
  padding-bottom: 2px;
  line-height: 1.2;
}

/* ── 缩略图网格（与图片组件完全一致：4列横排，限宽 280px） ── */
.${namespace}-vu__grid {
  display: grid;
  grid-template-columns: repeat(4, 1fr);
  gap: 4px;
  max-width: 280px;
  width: 100%;
}

.${namespace}-vu__cell {
  position: relative;
  aspect-ratio: 1 / 1;
  border: 1px solid var(--${namespace}-border);
  background: var(--${namespace}-bg-page);
  overflow: hidden;
  transition: border-color 0.15s;
}
.${namespace}-vu__cell:hover { border-color: var(--${namespace}-primary); }
.${namespace}-vu__cell--error { border-color: var(--${namespace}-danger) !important; }

.${namespace}-vu__thumb {
  width: 100%; height: 100%;
  object-fit: cover;
  display: block;
  cursor: pointer;
  background: #000;
}
.${namespace}-vu__thumb--empty {
  display: flex; align-items: center; justify-content: center;
  font-size: 20px; opacity: 0.2; cursor: default;
  background: var(--${namespace}-bg-page);
}

/* 时长角标 */
.${namespace}-vu__duration {
  position: absolute; bottom: 1px; right: 2px;
  padding: 0 3px; height: 13px; line-height: 13px;
  background: rgba(28,40,51,0.78); color: #fff;
  font-size: 9px; font-family: var(--${namespace}-mono); font-weight: 600;
  user-select: none; pointer-events: none;
}

/* ── 悬停操作栏（与图片组件完全一致：20px × 18px） ── */
.${namespace}-vu__actions {
  position: absolute; top: 0; right: 0; z-index: 3;
  display: flex;
  opacity: 0; transition: opacity 0.15s;
}
.${namespace}-vu__cell:hover .${namespace}-vu__actions { opacity: 1; }

.${namespace}-vu__actions-preview,
.${namespace}-vu__actions-del {
  width: 20px; height: 18px;
  display: flex; align-items: center; justify-content: center;
  cursor: pointer; font-size: 10px;
  background: rgba(28,40,51,0.6); color: #fff;
  transition: background 0.12s;
}
.${namespace}-vu__actions-preview:hover { background: var(--${namespace}-primary); }
.${namespace}-vu__actions-del:hover { background: var(--${namespace}-danger); }

/* ── 进度条 ─────────────────────────────────── */
.${namespace}-vu__progress-bar {
  position: absolute; bottom: 0; left: 0; right: 0; height: 2px;
  background: var(--${namespace}-border-light);
}
.${namespace}-vu__progress-fill {
  height: 100%; background: var(--${namespace}-primary);
  transition: width 0.1s linear;
}

/* ── 完成闪烁 ───────────────────────────────── */
.${namespace}-vu__done-flash {
  position: absolute; inset: 0;
  border: 2px solid var(--${namespace}-success);
  animation: vu-flash 0.35s ease-out forwards;
  pointer-events: none;
}
@keyframes vu-flash {
  0%   { opacity: 1; }
  100% { opacity: 0; }
}

/* ── 错误标记 ───────────────────────────────── */
.${namespace}-vu__error-mark {
  position: absolute; top: 1px; left: 2px;
  width: 14px; height: 14px; line-height: 14px; text-align: center;
  background: var(--${namespace}-danger); color: #fff;
  font-size: 9px; font-weight: bold;
}

/* ── 添加格（与图片组件完全一致） ─────────────── */
.${namespace}-vu__cell--add {
  border: 1px dashed var(--${namespace}-border);
  display: flex; flex-direction: column; align-items: center; justify-content: center;
  gap: 1px; cursor: pointer;
  transition: border-color 0.15s, background 0.15s;
}
.${namespace}-vu__cell--add:hover,
.${namespace}-vu__cell--dragover {
  border-color: var(--${namespace}-primary);
  background: var(--${namespace}-primary-bg);
}
.${namespace}-vu__add-icon {
  font-size: 18px; color: var(--${namespace}-text-light); font-weight: 300; line-height: 1;
}
.${namespace}-vu__cell--add:hover .${namespace}-vu__add-icon,
.${namespace}-vu__cell--dragover .${namespace}-vu__add-icon { color: var(--${namespace}-primary); }
.${namespace}-vu__add-text {
  font-size: 9px; color: var(--${namespace}-text-light);
  transform: scale(0.9);
}

.${namespace}-vu__hint { font-size: 10px; color: var(--${namespace}-text-light); }
.${namespace}-vu__input,
.${namespace}-vu__hidden-video { position: absolute; width: 0; height: 0; opacity: 0; pointer-events: none; }

/* ══════════════════════════════════════════════
   播放灯箱 — 匹配 ${namespace}-dialog 风格
   ══════════════════════════════════════════════ */
.${namespace}-vu__lightbox {
  position: fixed; inset: 0; z-index: 1100;
  display: flex; align-items: center; justify-content: center;
}
.${namespace}-vu__lightbox-mask {
  position: absolute; inset: 0;
  background: rgba(0,0,0,0.5);
}
.${namespace}-vu__lightbox-body {
  position: relative;
  width: 80vw; max-width: 580px;
  max-height: 80vh;
  background: var(--${namespace}-bg);
  border-radius: var(--${namespace}-radius-md);
  box-shadow: 0 8px 32px rgba(0,0,0,0.25);
  display: flex; flex-direction: column;
  z-index: 1;
}

/* 灯箱头部 */
.${namespace}-vu__lightbox-head {
  display: flex; align-items: center; justify-content: space-between;
  padding: 8px 12px; flex-shrink: 0;
  border-bottom: 2px solid var(--${namespace}-primary);
}
.${namespace}-vu__lightbox-title {
  font-size: 13px; font-weight: bold; color: var(--${namespace}-primary);
}
.${namespace}-vu__lightbox-close {
  width: 24px; height: 24px; border: none; background: none;
  cursor: pointer; font-size: 13px; color: var(--${namespace}-text-light);
  display: flex; align-items: center; justify-content: center;
  border-radius: var(--${namespace}-radius-sm); transition: color 0.12s, background 0.12s;
}
.${namespace}-vu__lightbox-close:hover { color: var(--${namespace}-text); background: var(--${namespace}-bg-page); }

/* 灯箱主体 */
.${namespace}-vu__lightbox-main {
  flex: 1; overflow: hidden;
  display: flex; align-items: center; justify-content: center;
  padding: 12px; position: relative;
  min-height: 180px;
  background: var(--${namespace}-bg-page);
}
.${namespace}-vu__player-video {
  width: 100%; max-height: 50vh;
  display: block; outline: none; background: #000;
}

/* 灯箱过渡 */
.${namespace}-vu-lb-enter-active,
.${namespace}-vu-lb-leave-active { transition: opacity 0.2s ease; }
.${namespace}-vu-lb-enter-from,
.${namespace}-vu-lb-leave-to { opacity: 0; }
.${namespace}-vu-lb-enter-active .${namespace}-vu__lightbox-body {
  transition: transform 0.2s ease, opacity 0.2s ease;
}
.${namespace}-vu-lb-enter-from .${namespace}-vu__lightbox-body {
  transform: scale(0.95); opacity: 0;
}
</style>