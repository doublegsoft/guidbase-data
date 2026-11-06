<template>
  <div
    class="${namespace}-vu"
    :class="{ '${namespace}-vu--disabled': disabled }"
    @dragover.prevent="onDragOver"
    @dragleave.prevent="onDragLeave"
    @drop.prevent="onDrop"
  >
    <label v-if="label" class="${namespace}-field-label">{{ label }}</label>

    <!-- ── 缩略图网格：4列等宽直角网格 ── -->
    <div class="${namespace}-vu__grid">
      <div
        v-for="(item, idx) in items"
        :key="item.id"
        class="${namespace}-vu__cell"
        :class="{
          '${namespace}-vu__cell--uploading': item.uploading,
          '${namespace}-vu__cell--error': item.error,
        }"
      >
        <!-- 缩略图 / 视频流视口 -->
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
        <!-- 极客等宽空状态提示 (替代 Emoji) -->
        <div v-else class="${namespace}-vu__thumb ${namespace}-vu__thumb--empty" @click="playVideo(idx)">
          <span>[VIDEO]</span>
        </div>

        <!-- 等宽时间戳角标 -->
        <span v-if="item.duration && !item.uploading" class="${namespace}-vu__duration">
          {{ formatDuration(item.duration) }}
        </span>

        <!-- 悬停直角操作条 -->
        <div v-if="!disabled && !item.uploading" class="${namespace}-vu__actions">
          <span class="${namespace}-vu__actions-preview" title="PLAY" @click="playVideo(idx)">▶</span>
          <span class="${namespace}-vu__actions-del" title="REMOVE" @click="removeItem(idx)">&times;</span>
        </div>

        <!-- 传输进度条 -->
        <div v-if="item.uploading" class="${namespace}-vu__progress-bar">
          <div class="${namespace}-vu__progress-fill" :style="{ width: item.progress + '%' }"></div>
        </div>

        <!-- 传输完成闪烁边框 -->
        <div v-if="item.justDone" class="${namespace}-vu__done-flash"></div>

        <!-- 错误标记 -->
        <span v-if="item.error" class="${namespace}-vu__error-mark" title="ERROR">!</span>

        <!-- 隐藏解析提取器 -->
        <video
          v-if="item.extracting"
          :ref="el => setVideoRef(idx, el)"
          :src="item.blobUrl"
          muted
          preload="metadata"
          class="${namespace}-vu__hidden-video"
          @loadedmetadata="onVideoMeta(idx, $event)"
          @seeked="onVideoSeeked(idx, $event)"
        />
      </div>

      <!-- 添加/拖拽槽位 (直角虚线方框) -->
      <div
        v-if="items.length < maxCount && !disabled"
        class="${namespace}-vu__cell ${namespace}-vu__cell--add"
        :class="{ '${namespace}-vu__cell--dragover': dragging }"
        @click="triggerInput"
      >
        <span class="${namespace}-vu__add-icon">+</span>
        <span class="${namespace}-vu__add-text">
          {{ items.length === 0 ? (placeholder || 'ADD VIDEO') : (items.length + '/' + maxCount) }}
        </span>
      </div>
    </div>

    <div v-if="hint" class="${namespace}-vu__hint">{{ hint }}</div>

    <input
      ref="inputRef"
      type="file"
      class="${namespace}-vu__input"
      :accept="accept"
      :multiple="maxCount > 1"
      @change="onFileChange"
    />

    <!-- ── 播放器灯箱 (物理硬阴影直角弹窗) ── -->
    <Teleport to="body">
      <Transition name="${namespace}-vu-lb">
        <div v-if="playerVisible" class="${namespace}-vu__lightbox" @click="closePlayer">
          <div class="${namespace}-vu__lightbox-mask"></div>
          <div class="${namespace}-vu__lightbox-body" @click.stop>
            <div class="${namespace}-vu__lightbox-head">
              <span class="${namespace}-vu__lightbox-title">VIDEO INSPECTOR // STREAM</span>
              <button type="button" class="${namespace}-vu__lightbox-close" title="CLOSE" @click="closePlayer">&times;</button>
            </div>
            <div class="${namespace}-vu__lightbox-main">
              <video
                v-if="playerUrl"
                :src="playerUrl"
                class="${namespace}-vu__player-video"
                controls
                autoplay
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
  return String(m).padStart(2, '0') + ':' + String(s).padStart(2, '0')
}

function isVideoUrl(url) {
  if (!url || typeof url !== 'string') return false
  return /\.(mp4|webm|ogg|mov|avi|wmv|m4v)(\?.*)?$/i.test(url) || url.startsWith('data:video/')
}

const props = defineProps({
  modelValue:  { type: Array,    default: () => [] },
  key:         { type: String,   default: 'id' },
  url:         { type: String,   default: 'url' },
  thumbnail:   { type: String,   default: 'thumbnailUrl' },
  duration:    { type: String,   default: 'duration' },
  label:       { type: String,   default: '' },
  placeholder: { type: String,   default: '' },
  hint:        { type: String,   default: '' },
  maxCount:    { type: Number,   default: 9 },
  maxSizeMB:   { type: Number,   default: 100 },
  maxDuration: { type: Number,   default: 300 },
  accept:      { type: String,   default: 'video/mp4, video/webm, video/quicktime, video/x-msvideo' },
  disabled:    { type: Boolean,  default: false },
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
    if (!file.type.startsWith('video/')) { emit('error', file.name + ' 不是有效视频格式'); continue }
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
    item.error = true
    item.extracting = false
    item.uploading = false
    URL.revokeObjectURL(item.blobUrl)
    emit('error', '视频时长 ' + Math.round(video.duration) + 's 超过 ' + props.maxDuration + 's 限制')
    syncModel()
    return
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
    cvs.width = 320
    cvs.height = 180
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
      item.progress = 100
      item.justDone = true
      item.url = result.url || item.blobUrl || ''
      if (result.thumbnailUrl) item.thumbnailUrl = result.thumbnailUrl
      if (result.duration != null) item.duration = result.duration
      setTimeout(() => {
        item.uploading = false
        item.justDone = false
        emit('upload', { ...result, url: item.url, thumbnailUrl: item.thumbnailUrl, duration: item.duration })
      }, 300)
    }).catch(err => {
      item.error = true
      item.uploading = false
      emit('error', err?.message || '上传失败')
    })
  }
  return new Promise(resolve => {
    let elapsed = 0
    const dur = 1000 + Math.random() * 1500
    const iv = setInterval(() => {
      elapsed += 60
      const r = elapsed / dur
      item.progress = Math.min(99, Math.round(r * 100))
      if (r >= 1) {
        item.progress = 100
        clearInterval(iv)
        item.justDone = true
        setTimeout(() => {
          item.url = item.blobUrl
          item.uploading = false
          item.justDone = false
          emit('upload', { url: item.url, thumbnailUrl: item.thumbnailUrl, duration: item.duration })
          resolve()
        }, 300)
      }
    }, 60)
  })
}

function removeItem(idx) {
  const item = items.value[idx]
  if (item.blobUrl) URL.revokeObjectURL(item.blobUrl)
  items.value.splice(idx, 1)
  syncModel()
  emit('remove', { index: idx, item })
}

function playVideo(idx) {
  const item = items.value[idx]
  if (!item || item.uploading) return
  playerUrl.value = item.blobUrl || item.url || ''
  playerVisible.value = true
}

function closePlayer() {
  playerVisible.value = false
  playerUrl.value = ''
}

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
   Protocol Explorer VideoUpload 蓝图工程规范
   ══════════════════════════════════════════════ */
.${namespace}-vu {
  display: flex;
  flex-direction: column;
  gap: 6px;
  font-family: var(--${namespace}-f, "IBM Plex Mono", monospace);
  font-size: 13px;
  user-select: none;
}
.${namespace}-vu--disabled { opacity: .45; pointer-events: none; }

/* ── 缩略图网格：纯直角、4列横排 ── */
.${namespace}-vu__grid {
  display: grid;
  grid-template-columns: repeat(4, 1fr);
  gap: 6px;
  max-width: 280px;
  width: 100%;
}

/* 网格单元格：纯直角、1px 细线框 */
.${namespace}-vu__cell {
  position: relative;
  aspect-ratio: 1 / 1;
  border: 1px solid var(--${namespace}-ln, #d3dbef);
  border-radius: 0;
  background: var(--${namespace}-bg, #f4f6fb);
  overflow: hidden;
  transition: .12s;
  box-sizing: border-box;
}
.${namespace}-vu__cell:hover {
  border-color: var(--${namespace}-ink, #0a2a9a);
  transform: translate(-1px, -1px);
  box-shadow: 2px 2px 0 var(--${namespace}-ln, #d3dbef);
}
.${namespace}-vu__cell--error {
  border-color: var(--${namespace}-red, #d6343e) !important;
  background: var(--${namespace}-sel, #fdecee);
}

.${namespace}-vu__thumb {
  width: 100%;
  height: 100%;
  object-fit: cover;
  display: block;
  cursor: pointer;
  background: #080d22;
}
.${namespace}-vu__thumb--empty {
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 10px;
  font-weight: 800;
  letter-spacing: .05em;
  color: var(--${namespace}-mu, #6f7fb4);
  background: var(--${namespace}-bg, #f4f6fb);
}

/* 时长等宽小角标 */
.${namespace}-vu__duration {
  position: absolute;
  bottom: 2px;
  right: 2px;
  padding: 0 4px;
  height: 14px;
  line-height: 14px;
  background: var(--${namespace}-ink, #0a2a9a);
  color: var(--${namespace}-on, #ffffff);
  font-size: 9px;
  font-weight: 700;
  letter-spacing: .05em;
  pointer-events: none;
}

/* 悬停直角操作条 */
.${namespace}-vu__actions {
  position: absolute;
  top: 0;
  right: 0;
  z-index: 5;
  display: flex;
  opacity: 0;
  transition: opacity .15s;
}
.${namespace}-vu__cell:hover .${namespace}-vu__actions { opacity: 1; }

.${namespace}-vu__actions-preview,
.${namespace}-vu__actions-del {
  width: 20px;
  height: 20px;
  display: flex;
  align-items: center;
  justify-content: center;
  cursor: pointer;
  font-size: 11px;
  font-weight: 700;
  background: var(--${namespace}-ink, #0a2a9a);
  color: var(--${namespace}-on, #ffffff);
  transition: .12s;
}
.${namespace}-vu__actions-preview:hover { background: var(--${namespace}-pri, #0a2fb5); }
.${namespace}-vu__actions-del:hover     { background: var(--${namespace}-red, #d6343e); }

/* 上传进度条 */
.${namespace}-vu__progress-bar {
  position: absolute;
  bottom: 0;
  left: 0;
  right: 0;
  height: 2px;
  background: var(--${namespace}-ln, #d3dbef);
}
.${namespace}-vu__progress-fill {
  height: 100%;
  background: var(--${namespace}-pri, #0a2fb5);
  transition: width 0.08s linear;
}

/* 闪烁光效 */
.${namespace}-vu__done-flash {
  position: absolute;
  inset: 0;
  border: 2px solid var(--${namespace}-tcp, #13a05d);
  animation: vu-flash 0.35s ease-out forwards;
  pointer-events: none;
}
@keyframes vu-flash {
  0%   { opacity: 1; }
  100% { opacity: 0; }
}

/* 错误符号标记 */
.${namespace}-vu__error-mark {
  position: absolute;
  top: 2px;
  left: 2px;
  width: 14px;
  height: 14px;
  line-height: 14px;
  text-align: center;
  background: var(--${namespace}-red, #d6343e);
  color: #fff;
  font-size: 9px;
  font-weight: 800;
}

/* 添加直角虚线方框 */
.${namespace}-vu__cell--add {
  border: 1px dashed var(--${namespace}-ln, #d3dbef);
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  gap: 2px;
  cursor: pointer;
  background: var(--${namespace}-bg, #f4f6fb);
  transition: .12s;
}
.${namespace}-vu__cell--add:hover,
.${namespace}-vu__cell--dragover {
  border-color: var(--${namespace}-pri, #0a2fb5);
  background: color-mix(in srgb, var(--${namespace}-pri, #0a2fb5) 8%, transparent);
}
.${namespace}-vu__add-icon {
  font-size: 16px;
  color: var(--${namespace}-mu, #6f7fb4);
  line-height: 1;
}
.${namespace}-vu__cell--add:hover .${namespace}-vu__add-icon {
  color: var(--${namespace}-pri, #0a2fb5);
}
.${namespace}-vu__add-text {
  font-size: 9px;
  font-weight: 700;
  color: var(--${namespace}-mu, #6f7fb4);
  letter-spacing: .05em;
}

.${namespace}-vu__hint {
  font-size: 11px;
  color: var(--${namespace}-mu, #6f7fb4);
  line-height: 1.3;
}
.${namespace}-vu__input,
.${namespace}-vu__hidden-video {
  position: absolute;
  width: 0;
  height: 0;
  opacity: 0;
  pointer-events: none;
}

/* ══════════════════════════════════════════════
   播放器灯箱：纯直角、6px 墨水实体投影
   ══════════════════════════════════════════════ */
.${namespace}-vu__lightbox {
  position: fixed;
  inset: 0;
  z-index: 100000;
  display: flex;
  align-items: center;
  justify-content: center;
  user-select: none;
}
.${namespace}-vu__lightbox-mask {
  position: absolute;
  inset: 0;
  background: rgba(8, 13, 34, 0.6);
  backdrop-filter: blur(1px);
}
.${namespace}-vu__lightbox-body {
  position: relative;
  width: 80vw;
  max-width: 620px;
  background: var(--${namespace}-pn, #ffffff);
  border: 1px solid var(--${namespace}-ink, #0a2a9a);
  border-radius: 0;
  box-shadow: 6px 6px 0 var(--${namespace}-ln, #d3dbef);
  display: flex;
  flex-direction: column;
  z-index: 1;
  font-family: var(--${namespace}-f, "IBM Plex Mono", monospace);
}

.${namespace}-vu__lightbox-body {
  box-shadow: none !important; /* 核心修改：去除 6px 6px 0 投影 */
  border: 1px solid var(--${namespace}-ink, #0a2a9a);
}

/* 灯箱头部 */
.${namespace}-vu__lightbox-head {
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: 8px 14px;
  background: var(--${namespace}-ink, #0a2a9a);
  color: var(--${namespace}-on, #ffffff);
  flex-shrink: 0;
}
.${namespace}-vu__lightbox-title {
  font-size: 12px;
  font-weight: 800;
  letter-spacing: .08em;
  text-transform: uppercase;
}
.${namespace}-vu__lightbox-close {
  width: 22px;
  height: 22px;
  border: none;
  background: transparent;
  cursor: pointer;
  font-size: 16px;
  font-weight: 700;
  color: var(--${namespace}-on, #ffffff);
  display: flex;
  align-items: center;
  justify-content: center;
  line-height: 1;
  transition: .12s;
}
.${namespace}-vu__lightbox-close:hover {
  background: var(--${namespace}-red, #d6343e);
}

/* 灯箱播放主体 */
.${namespace}-vu__lightbox-main {
  flex: 1;
  display: flex;
  align-items: center;
  justify-content: center;
  padding: 10px;
  background: #080d22;
}
.${namespace}-vu__player-video {
  width: 100%;
  max-height: 52vh;
  display: block;
  outline: none;
  background: #000;
}

/* 进退场微动效 */
.${namespace}-vu-lb-enter-active,
.${namespace}-vu-lb-leave-active { transition: opacity 0.15s ease; }
.${namespace}-vu-lb-enter-from,
.${namespace}-vu-lb-leave-to { opacity: 0; }
.${namespace}-vu-lb-enter-active .${namespace}-vu__lightbox-body {
  transition: transform 0.15s ease;
}
.${namespace}-vu-lb-enter-from .${namespace}-vu__lightbox-body {
  transform: scale(0.96);
}
</style>