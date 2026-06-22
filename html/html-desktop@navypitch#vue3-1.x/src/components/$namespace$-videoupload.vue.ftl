<template>
  <div
    class="vu-root"
    :class="{ 'vu--disabled': disabled }"
    @dragover.prevent="onDragOver"
    @dragleave.prevent="onDragLeave"
    @drop.prevent="onDrop"
  >
    <!-- Label -->
    <label v-if="label" class="form-label">{{ label }}</label>

    <div class="vu-grid-wrap" :class="typeof cellSize === 'string' ? `vu-grid-wrap--${r"${"}cellSize}` : ''" :style="typeof cellSize === 'number' ? { maxWidth: `${r"${"}cellSize * 160}px` } : {}">
      <div class="vu-grid" :class="typeof cellSize === 'string' ? `vu-grid--${r"${"}cellSize}` : ''" :style="typeof cellSize === 'number' ? { gridTemplateColumns: `repeat(${r"${"}cellSize}, 1fr)` } : {}">
      <!-- Existing items -->
      <div
        v-for="(item, idx) in items"
        :key="item.id"
        class="vu-cell"
        :class="{
          'vu-cell--uploading': item.uploading,
          'vu-cell--error': item.error,
        }"
        @click="!item.uploading && playVideo(idx)"
      >
        <!-- Thumbnail -->
        <img
          v-if="item.thumbnailUrl"
          :src="item.thumbnailUrl"
          class="vu-cell__img"
          alt=""
        />

        <!-- Skeleton while extracting thumbnail -->
        <div v-else class="vu-cell__skeleton">
          <span class="vu-cell__skeleton-icon">🎬</span>
          <span v-if="item.extracting" class="vu-cell__skeleton-text">提取中…</span>
        </div>

        <!-- Duration badge -->
        <span v-if="item.duration && !item.uploading" class="vu-cell__duration">
          {{ formatDuration(item.duration) }}
        </span>

        <!-- Play icon overlay -->
        <div v-if="!disabled && !item.uploading && item.thumbnailUrl" class="vu-cell__overlay">
          <span class="vu-cell__play-icon">▶</span>
        </div>

        <!-- Hover overlay with delete -->
        <div v-if="!disabled && !item.uploading" class="vu-cell__actions">
          <button
            class="vu-cell__delete"
            title="删除"
            @click.stop="removeItem(idx)"
          >✕</button>
        </div>

        <!-- Upload progress overlay -->
        <div v-if="item.uploading" class="vu-cell__progress">
          <div class="vu-cell__shimmer"></div>
          <svg class="vu-cell__ring" viewBox="0 0 100 100">
            <circle
              class="vu-cell__ring-bg"
              cx="50" cy="50" r="42"
              fill="none"
              stroke="rgba(255,255,255,0.18)"
              stroke-width="5"
            />
            <circle
              class="vu-cell__ring-fill"
              cx="50" cy="50" r="42"
              fill="none"
              stroke="var(--color-teal)"
              stroke-width="5"
              stroke-linecap="round"
              :stroke-dasharray="2 * Math.PI * 42"
              :stroke-dashoffset="2 * Math.PI * 42 * (1 - item.progress / 100)"
              transform="rotate(-90 50 50)"
            />
          </svg>
          <span class="vu-cell__progress-text">{{ Math.round(item.progress) }}%</span>
        </div>
        <div v-if="item.justDone" class="vu-cell__done-pulse"></div>

        <!-- Error badge -->
        <div v-if="item.error" class="vu-cell__error-badge" title="上传失败">⚠</div>

        <!-- Hidden video element for thumbnail extraction -->
        <video
          v-if="item.extracting"
          :ref="el => setVideoRef(idx, el)"
          :src="item.blobUrl"
          muted
          preload="metadata"
          class="vu-hidden-video"
          @loadedmetadata="onVideoMeta(idx, $event)"
          @seeked="onVideoSeeked(idx, $event)"
        />
      </div>

      <!-- Add button -->
      <div
        v-if="items.length < maxCount && !disabled"
        class="vu-cell vu-cell--add"
        :class="{ 'vu-cell--dragover': dragging }"
        @click="triggerInput"
        role="button"
        tabindex="0"
        @keydown.enter="triggerInput"
        @keydown.space.prevent="triggerInput"
      >
        <span class="vu-cell__add-icon">+</span>
        <span class="vu-cell__add-text">{{ items.length === 0 ? placeholder : '继续添加' }}</span>
      </div>
    </div>
    </div><!-- /vu-grid-wrap -->

    <!-- Hint -->
    <div v-if="hint && !disabled" class="vu-hint">
      {{ hint }}
    </div>

    <!-- Hidden file input -->
    <input
      ref="inputRef"
      type="file"
      class="vu-input"
      :accept="accept"
      :multiple="maxCount > 1"
      @change="onFileChange"
    />

    <!-- ═══════════════════════════════════════════ -->
    <!-- Video Player Modal                              -->
    <!-- ═══════════════════════════════════════════ -->
    <Transition name="vp">
      <div v-if="playerVisible" class="vu-player" @click="closePlayer">
        <button class="vu-player__close" @click="closePlayer">✕</button>
        <video
          v-if="playerUrl"
          :src="playerUrl"
          class="vu-player__video"
          controls
          autoplay
          @click.stop
        />
      </div>
    </Transition>
  </div>
</template>

<script setup>
import { ref, watch, onBeforeUnmount } from 'vue'

/* ───────────────────────────────────────────────
   Helpers
   ─────────────────────────────────────────────── */
let nextId = 1
function genId() { return `vid_${r"${"}Date.now()}_${r"${"}nextId++}` }

function formatDuration(seconds) {
  if (!seconds || !isFinite(seconds)) return ''
  const m = Math.floor(seconds / 60)
  const s = Math.floor(seconds % 60)
  return `${r"${"}m}:${r"${"}String(s).padStart(2, '0')}`
}

/* ───────────────────────────────────────────────
   Props
   ─────────────────────────────────────────────── */
const props = defineProps({
  /** v-model: array of URL strings, or object array when key/text are set */
  modelValue: { type: Array, default: () => [] },

  /** Field name for unique identifier (when modelValue items are objects) */
  key: { type: String, default: 'id' },

  /** Field name for display URL (when modelValue items are objects) */
  url: { type: String, default: 'url' },

  /** Field name for thumbnail (when modelValue items are objects) */
  thumbnail: { type: String, default: 'thumbnailUrl' },

  /** Field name for duration (when modelValue items are objects) */
  duration: { type: String, default: 'duration' },

  /** Form label text */
  label: { type: String, default: '' },

  /** Placeholder shown on the add button when empty */
  placeholder: { type: String, default: '上传视频' },

  /** Hint text below the grid */
  hint: { type: String, default: '' },

  /** Maximum number of videos */
  maxCount: { type: Number, default: 9 },

  /** Per-file max size in MB */
  maxSizeMB: { type: Number, default: 100 },

  /** Max video duration in seconds */
  maxDuration: { type: Number, default: 300 },

  /** Accepted MIME types */
  accept: { type: String, default: 'video/mp4, video/webm, video/quicktime, video/x-msvideo' },

  /** Columns: preset string ('sm'=4|'md'=3|'lg'=2) or arbitrary number */
  cellSize: { type: [String, Number], default: 'md' },

  /** Disabled state */
  disabled: { type: Boolean, default: false },

  /** 自定义上传函数 (file, { setProgress }) => Promise<{ url, thumbnailUrl?, duration? }>，不传则模拟上传 */
  customUpload: { type: Function, default: null },
})

/* ───────────────────────────────────────────────
   Emits
   ─────────────────────────────────────────────── */
const emit = defineEmits(['update:modelValue', 'upload', 'error', 'remove'])

/* ───────────────────────────────────────────────
   State
   ─────────────────────────────────────────────── */
const inputRef = ref(null)
const dragging = ref(false)
const playerVisible = ref(false)
const playerUrl = ref('')

/** Video refs map for thumbnail extraction */
const videoRefs = {}

function setVideoRef(idx, el) {
  if (el) videoRefs[idx] = el
}

/** Internal item model */
const items = ref([])

// Hydrate / reset from modelValue
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

/** Emit current state back as v-model */
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

/* ───────────────────────────────────────────────
   Actions
   ─────────────────────────────────────────────── */

function triggerInput() {
  if (props.disabled) return
  inputRef.value?.click()
}

function onDragOver() {
  if (props.disabled) return
  dragging.value = true
}

function onDragLeave() {
  dragging.value = false
}

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
  if (remaining <= 0) {
    emit('error', `最多上传 ${r"${"}props.maxCount} 个视频`)
    return
  }

  const toAdd = files.slice(0, remaining)

  for (const file of toAdd) {
    // Validate type
    if (!file.type.startsWith('video/')) {
      emit('error', `${r"${"}file.name} 不是视频文件`)
      continue
    }

    // Validate size
    if (file.size > props.maxSizeMB * 1024 * 1024) {
      emit('error', `${r"${"}file.name} 超过 ${r"${"}props.maxSizeMB}MB 限制`)
      continue
    }

    const blobUrl = URL.createObjectURL(file)
    const item = {
      id: genId(),
      thumbnailUrl: '',
      url: '',
      duration: 0,
      uploading: true,
      progress: 0,
      error: false,
      extracting: true,
      blobUrl,
      file,
    }
    items.value.push(item)
  }

  syncModel()
}

/* ───────────────────────────────────────────────
   Thumbnail Extraction (Canvas from Video)
   ─────────────────────────────────────────────── */

function onVideoMeta(idx, e) {
  const video = e.target
  const item = items.value[idx]
  if (!item) return

  // Validate duration
  if (video.duration > props.maxDuration) {
    item.error = true
    item.extracting = false
    item.uploading = false
    URL.revokeObjectURL(item.blobUrl)
    emit('error', `视频时长 ${r"${"}Math.round(video.duration)}s 超过 ${r"${"}props.maxDuration}s 限制`)
    syncModel()
    return
  }

  item.duration = video.duration

  // Seek to ~1 second for thumbnail
  video.currentTime = Math.min(1, video.duration * 0.1)
}

function onVideoSeeked(idx, e) {
  const video = e.target
  const item = items.value[idx]
  if (!item || item.thumbnailUrl) return

  try {
    const canvas = document.createElement('canvas')
    canvas.width = 320
    canvas.height = 180
    const ctx = canvas.getContext('2d')
    ctx.drawImage(video, 0, 0, canvas.width, canvas.height)
    item.thumbnailUrl = canvas.toDataURL('image/jpeg', 0.85)
  } catch (err) {
    // Fallback: no thumbnail
    console.warn('[VideoUpload] thumbnail extraction failed:', err)
  }

  // Cleanup
  item.extracting = false
  URL.revokeObjectURL(item.blobUrl)
  delete videoRefs[idx]

  // Start upload simulation
  simulateUpload(item).then(() => {
    syncModel()
  })
}

/* ───────────────────────────────────────────────
   Upload Simulation
   ─────────────────────────────────────────────── */

function simulateUpload(item) {
  if (props.customUpload) {
    return props.customUpload(item.file, {
      setProgress: (p) => { item.progress = Math.min(99, p) },
    }).then(result => {
      item.progress = 100
      item.justDone = true
      item.url = result.url || item.thumbnailUrl || ''
      if (result.thumbnailUrl) item.thumbnailUrl = result.thumbnailUrl
      if (result.duration != null) item.duration = result.duration
      setTimeout(() => {
        item.uploading = false
        item.justDone = false
        emit('upload', { ...result, url: item.url, thumbnailUrl: item.thumbnailUrl, duration: item.duration })
      }, 350)
    }).catch(err => {
      item.error = true
      item.uploading = false
      emit('error', err?.message || '上传失败')
    })
  }

  // Built-in simulated upload
  return new Promise(resolve => {
    let elapsed = 0
    const totalDuration = 1800 + Math.random() * 2500
    const tick = 80
    const interval = setInterval(() => {
      elapsed += tick
      const ratio = elapsed / totalDuration
      const curved = 1 / (1 + Math.exp(-10 * (ratio - 0.4)))
      const noise = (Math.random() - 0.5) * 0.05
      item.progress = Math.min(99, Math.round((curved + noise) * 100))
      if (ratio >= 1) {
        item.progress = 100
        clearInterval(interval)
        item.justDone = true
        setTimeout(() => {
          item.url = item.thumbnailUrl
          item.uploading = false
          item.justDone = false
          emit('upload', { url: item.url, thumbnailUrl: item.thumbnailUrl, duration: item.duration })
          resolve()
        }, 350)
      }
    }, tick)
  })
}

/* ───────────────────────────────────────────────
   Remove
   ─────────────────────────────────────────────── */

function removeItem(idx) {
  const item = items.value[idx]
  if (item.blobUrl) URL.revokeObjectURL(item.blobUrl)
  items.value.splice(idx, 1)
  syncModel()
  emit('remove', { index: idx, item })
}

/* ───────────────────────────────────────────────
   Video Player Modal
   ─────────────────────────────────────────────── */

function playVideo(idx) {
  const item = items.value[idx]
  if (!item || item.uploading) return
  // Use blob URL if still available, otherwise the uploaded URL
  playerUrl.value = item.blobUrl || item.url || item.thumbnailUrl
  playerVisible.value = true
}

function closePlayer() {
  playerVisible.value = false
  playerUrl.value = ''
}

/** Escape key closes player */
function onKeydown(e) {
  if (e.key === 'Escape' && playerVisible.value) {
    closePlayer()
  }
}

if (typeof window !== 'undefined') {
  window.addEventListener('keydown', onKeydown)
}

onBeforeUnmount(() => {
  // Cleanup any remaining blob URLs
  items.value.forEach(item => {
    if (item.blobUrl) URL.revokeObjectURL(item.blobUrl)
  })
  if (typeof window !== 'undefined') {
    window.removeEventListener('keydown', onKeydown)
  }
})
</script>

<style scoped>
/* ═══════════════════════════════════════════════════════════════════════════
   VIDEO UPLOAD — Academy Pro · Multi-Video Grid
   Navy Pitch Design Tokens
   ═══════════════════════════════════════════════════════════════════════════ */

.vu-root {
  display: flex;
  flex-direction: column;
  gap: var(--space-4);
}

.vu--disabled {
  opacity: 0.55;
  pointer-events: none;
}

/* ── Grid ─────────────────────────────────────── */

.vu-grid-wrap--sm { max-width: 640px; }
.vu-grid-wrap--md { max-width: 540px; }
.vu-grid-wrap--lg { max-width: 580px; }

.vu-grid {
  display: grid;
  gap: var(--space-3);
}

.vu-grid--md { grid-template-columns: repeat(3, 1fr); }
.vu-grid--sm { grid-template-columns: repeat(4, 1fr); }
.vu-grid--lg { grid-template-columns: repeat(2, 1fr); gap: var(--space-5); }

@media (max-width: 480px) {
  .vu-grid-wrap--sm,
  .vu-grid-wrap--md { max-width: none; }
  .vu-grid--md,
  .vu-grid--sm { grid-template-columns: repeat(3, 1fr); }
  .vu-grid--lg { grid-template-columns: repeat(2, 1fr); }
}

/* ── Cell (shared) ────────────────────────────── */

.vu-cell {
  position: relative;
  aspect-ratio: 16 / 9;
  border-radius: var(--radius-lg);
  overflow: hidden;
  background: var(--color-surface);
  border: 1px solid var(--color-border);
  cursor: pointer;
  transition: box-shadow var(--transition-base), border-color var(--transition-base), transform var(--transition-base);
}

.vu-cell:hover:not(.vu-cell--uploading) {
  box-shadow: var(--shadow-md);
  border-color: var(--color-teal);
  transform: translateY(-1px);
}

.vu-cell:focus-visible {
  outline: 2px solid var(--color-teal);
  outline-offset: 2px;
}

/* ── Cell Image (thumbnail) ───────────────────── */

.vu-cell__img {
  width: 100%;
  height: 100%;
  object-fit: cover;
  display: block;
}

/* ── Cell Skeleton ────────────────────────────── */

.vu-cell__skeleton {
  width: 100%;
  height: 100%;
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  gap: var(--space-3);
  background: linear-gradient(135deg, var(--color-navy-light), var(--color-steel));
}

.vu-cell__skeleton-icon {
  font-size: 32px;
  opacity: 0.6;
}

.vu-cell__skeleton-text {
  font-size: var(--text-xs);
  color: rgba(255,255,255,0.5);
  font-weight: var(--weight-medium);
}

/* ── Duration badge ───────────────────────────── */

.vu-cell__duration {
  position: absolute;
  bottom: var(--space-4);
  right: var(--space-4);
  padding: 2px 6px;
  border-radius: var(--radius-xs);
  background: rgba(13, 27, 42, 0.8);
  color: #fff;
  font-size: var(--text-xs);
  font-weight: var(--weight-semibold);
  font-variant-numeric: tabular-nums;
  pointer-events: none;
  z-index: 1;
}

/* ── Play icon overlay ────────────────────────── */

.vu-cell__overlay {
  position: absolute;
  inset: 0;
  display: flex;
  align-items: center;
  justify-content: center;
  pointer-events: none;
  z-index: 1;
}

.vu-cell__play-icon {
  width: 44px;
  height: 44px;
  border-radius: var(--radius-full);
  background: rgba(0, 0, 0, 0.55);
  color: #fff;
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: var(--text-2xl);
  backdrop-filter: blur(4px);
  transition: transform var(--transition-fast), background var(--transition-fast);
}

.vu-cell:hover .vu-cell__play-icon {
  transform: scale(1.1);
  background: var(--color-teal);
}

/* ── Hover actions (delete) ───────────────────── */

.vu-cell__actions {
  position: absolute;
  top: var(--space-3);
  right: var(--space-3);
  z-index: 2;
  opacity: 0;
  transition: opacity var(--transition-base);
}

.vu-cell:hover .vu-cell__actions {
  opacity: 1;
}

.vu-cell__delete {
  width: 28px;
  height: 28px;
  border-radius: var(--radius-full);
  background: var(--color-red);
  color: #fff;
  border: none;
  cursor: pointer;
  font-size: var(--text-md);
  display: flex;
  align-items: center;
  justify-content: center;
  transition: transform var(--transition-fast), background var(--transition-fast);
  font-family: inherit;
  line-height: 1;
}

.vu-cell__delete:hover {
  transform: scale(1.12);
  background: #d43d5e;
}

/* ── Cell Progress Overlay ────────────────────── */

.vu-cell__progress {
  position: absolute;
  inset: 0;
  background: rgba(13, 27, 42, 0.65);
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  gap: var(--space-4);
  border-radius: var(--radius-lg);
  z-index: 3;
}

.vu-cell__ring {
  width: 56px;
  height: 56px;
}

.vu-cell__ring-fill {
  transition: stroke-dashoffset 0.3s ease;
}

.vu-cell__progress-text {
  font-size: var(--text-sm);
  font-weight: var(--weight-bold);
  color: var(--color-teal);
}

/* Shimmer */
.vu-cell__shimmer {
  position: absolute;
  top: 0; left: 0; right: 0; height: 3px;
  background: linear-gradient(90deg,
    transparent 0%,
    rgba(0,201,167,0.6) 50%,
    transparent 100%
  );
  background-size: 200% 100%;
  animation: vu-shimmer 1.2s ease-in-out infinite;
  z-index: 1;
}

@keyframes vu-shimmer {
  0%   { background-position: 200% 0; }
  100% { background-position: -200% 0; }
}

/* Completion pulse */
.vu-cell__done-pulse {
  position: absolute;
  inset: -4px;
  border-radius: var(--radius-lg);
  border: 3px solid var(--color-teal);
  animation: vu-pulse 0.4s ease-out forwards;
  pointer-events: none;
  z-index: 5;
}

@keyframes vu-pulse {
  0%   { opacity: 1; transform: scale(0.96); }
  100% { opacity: 0; transform: scale(1.08); }
}

/* ── Cell Error ───────────────────────────────── */

.vu-cell--error {
  border-color: var(--color-red);
  box-shadow: 0 0 0 3px var(--color-red-dim);
}

.vu-cell__error-badge {
  position: absolute;
  top: var(--space-3);
  left: var(--space-3);
  width: 24px;
  height: 24px;
  border-radius: var(--radius-full);
  background: var(--color-red);
  color: #fff;
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: var(--text-sm);
  z-index: 2;
}

/* ── Add Cell ─────────────────────────────────── */

.vu-cell--add {
  border: 2px dashed var(--color-border);
  background: transparent;
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  gap: var(--space-3);
  transition: border-color var(--transition-base), background var(--transition-base), box-shadow var(--transition-base);
}

.vu-cell--add:hover,
.vu-cell--dragover {
  border-color: var(--color-teal);
  background: var(--color-teal-dim);
  box-shadow: var(--shadow-glow-teal);
}

.vu-cell__add-icon {
  font-size: 32px;
  color: var(--color-text-muted);
  font-weight: var(--weight-light);
  line-height: 1;
  transition: color var(--transition-base);
}

.vu-cell--add:hover .vu-cell__add-icon,
.vu-cell--dragover .vu-cell__add-icon {
  color: var(--color-teal);
}

.vu-cell__add-text {
  font-size: var(--text-xs);
  color: var(--color-text-muted);
  font-weight: var(--weight-medium);
}

/* ── Hint ─────────────────────────────────────── */

.vu-hint {
  font-size: var(--text-xs);
  color: var(--color-text-muted);
}

/* ── Hidden input / video ─────────────────────── */

.vu-input,
.vu-hidden-video {
  position: absolute;
  width: 0;
  height: 0;
  opacity: 0;
  pointer-events: none;
}

/* ═══════════════════════════════════════════════ */
/* Video Player Modal                               */
/* ═══════════════════════════════════════════════ */

.vu-player {
  position: fixed;
  inset: 0;
  z-index: 600;
  background: rgba(13, 27, 42, 0.94);
  display: flex;
  align-items: center;
  justify-content: center;
  padding: var(--space-14);
}

.vu-player__close {
  position: absolute;
  top: var(--space-11);
  right: var(--space-11);
  width: 40px;
  height: 40px;
  border-radius: var(--radius-full);
  background: rgba(255,255,255,0.1);
  border: 1px solid rgba(255,255,255,0.15);
  color: #fff;
  font-size: var(--text-5xl);
  cursor: pointer;
  display: flex;
  align-items: center;
  justify-content: center;
  transition: background var(--transition-fast);
  font-family: inherit;
  z-index: 2;
}

.vu-player__close:hover {
  background: rgba(255,255,255,0.2);
}

.vu-player__video {
  max-width: 90vw;
  max-height: 85vh;
  border-radius: var(--radius-lg);
  box-shadow: 0 20px 60px rgba(0,0,0,0.5);
  outline: none;
}

/* ── Player transitions ───────────────────────── */

.vp-enter-active { transition: opacity var(--transition-smooth); }
.vp-leave-active { transition: opacity 0.12s ease; }
.vp-enter-from,
.vp-leave-to { opacity: 0; }

.vp-enter-active .vu-player__video {
  transition: transform var(--transition-smooth), opacity var(--transition-smooth);
}
.vp-enter-from .vu-player__video {
  transform: scale(0.92);
  opacity: 0;
}
.vp-leave-active .vu-player__video {
  transition: transform 0.12s ease, opacity 0.12s ease;
}
.vp-leave-to .vu-player__video {
  transform: scale(0.95);
  opacity: 0;
}
</style>
