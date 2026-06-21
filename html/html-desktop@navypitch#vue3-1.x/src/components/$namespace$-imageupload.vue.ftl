<template>
  <div
    class="iu-root"
    :class="{ 'iu--disabled': disabled }"
    @dragover.prevent="onDragOver"
    @dragleave.prevent="onDragLeave"
    @drop.prevent="onDrop"
  >
    <!-- Label (for form integration) -->
    <label v-if="label" class="form-label">{{ label }}</label>

    <!-- Grid (wrapped for max-width) -->
    <div class="iu-grid-wrap" :class="typeof cellSize === 'string' ? `iu-grid-wrap--${r"${"}cellSize}` : ''" :style="typeof cellSize === 'number' ? { maxWidth: `${r"${"}cellSize * 160}px` } : {}">
      <div class="iu-grid" :class="typeof cellSize === 'string' ? `iu-grid--${r"${"}cellSize}` : ''" :style="typeof cellSize === 'number' ? { gridTemplateColumns: `repeat(${r"${"}cellSize}, 1fr)` } : {}">
      <!-- Existing items -->
      <div
        v-for="(item, idx) in items"
        :key="item.id"
        class="iu-cell"
        :class="{
          'iu-cell--uploading': item.uploading,
          'iu-cell--error': item.error,
        }"
        @click="!item.uploading && previewItem(idx)"
      >
        <!-- Thumbnail -->
        <img
          v-if="item.previewUrl"
          :src="item.previewUrl"
          class="iu-cell__img"
          alt=""
        />

        <!-- Skeleton placeholder while no preview yet -->
        <div v-else class="iu-cell__skeleton">
          <span class="iu-cell__skeleton-icon">🖼</span>
        </div>

        <!-- Hover overlay with delete -->
        <div v-if="!disabled && !item.uploading" class="iu-cell__overlay">
          <button
            class="iu-cell__delete"
            title="删除"
            @click.stop="removeItem(idx)"
          >✕</button>
          <span class="iu-cell__preview-hint">点击预览</span>
        </div>

        <!-- Upload progress overlay -->
        <div v-if="item.uploading" class="iu-cell__progress">
          <!-- Shimmer bar -->
          <div class="iu-cell__shimmer"></div>
          <!-- Ring -->
          <svg class="iu-cell__ring" viewBox="0 0 100 100">
            <circle
              class="iu-cell__ring-bg"
              cx="50" cy="50" r="42"
              fill="none"
              stroke="rgba(255,255,255,0.18)"
              stroke-width="5"
            />
            <circle
              class="iu-cell__ring-fill"
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
          <span class="iu-cell__progress-text">{{ Math.round(item.progress) }}%</span>
        </div>
        <!-- Completion pulse -->
        <div v-if="item.justDone" class="iu-cell__done-pulse"></div>

        <!-- Error badge -->
        <div v-if="item.error" class="iu-cell__error-badge" title="上传失败">
          ⚠
        </div>
      </div>

      <!-- Add button -->
      <div
        v-if="items.length < maxCount && !disabled"
        class="iu-cell iu-cell--add"
        :class="{ 'iu-cell--dragover': dragging }"
        @click="triggerInput"
        role="button"
        tabindex="0"
        @keydown.enter="triggerInput"
        @keydown.space.prevent="triggerInput"
      >
        <span class="iu-cell__add-icon">+</span>
        <span class="iu-cell__add-text">{{ items.length === 0 ? placeholder : '继续添加' }}</span>
      </div>
    </div>
    </div><!-- /iu-grid-wrap -->

    <!-- Hint -->
    <div v-if="hint && !disabled" class="iu-hint">
      {{ hint }}
    </div>

    <!-- Hidden file input -->
    <input
      ref="inputRef"
      type="file"
      class="iu-input"
      :accept="accept"
      :multiple="maxCount > 1"
      @change="onFileChange"
    />

    <!-- ═══════════════════════════════════════════ -->
    <!-- Lightbox Preview                                -->
    <!-- ═══════════════════════════════════════════ -->
    <Transition name="lb">
      <div v-if="previewVisible" class="iu-lightbox" @click="closePreview">
        <button class="iu-lightbox__close" @click="closePreview">✕</button>
        <button
          v-if="items.length > 1"
          class="iu-lightbox__nav iu-lightbox__nav--prev"
          @click.stop="previewPrev"
        >‹</button>
        <img
          :src="items[previewIndex]?.previewUrl"
          class="iu-lightbox__img"
          @click.stop
          alt="预览"
        />
        <button
          v-if="items.length > 1"
          class="iu-lightbox__nav iu-lightbox__nav--next"
          @click.stop="previewNext"
        >›</button>
        <span v-if="items.length > 1" class="iu-lightbox__counter">
          {{ previewIndex + 1 }} / {{ items.length }}
        </span>
      </div>
    </Transition>
  </div>
</template>

<script setup>
import { ref, computed, watch } from 'vue'

/* ───────────────────────────────────────────────
   Helpers
   ─────────────────────────────────────────────── */
let nextId = 1
function genId() { return `img_${r"${"}Date.now()}_${r"${"}nextId++}` }

/* ───────────────────────────────────────────────
   Props
   ─────────────────────────────────────────────── */
const props = defineProps({
  /** v-model: array of URL strings, or object array when key/text are set */
  modelValue: { type: Array, default: () => [] },

  /** Field name for unique identifier (when modelValue items are objects) */
  key: { type: String, default: 'id' },

  /** Field name for display URL (when modelValue items are objects) */
  text: { type: String, default: 'url' },

  /** Form label text */
  label: { type: String, default: '' },

  /** Placeholder shown on the add button when empty */
  placeholder: { type: String, default: '上传图片' },

  /** Hint text below the grid */
  hint: { type: String, default: '' },

  /** Maximum number of images */
  maxCount: { type: Number, default: 9 },

  /** Per-file max size in MB */
  maxSizeMB: { type: Number, default: 10 },

  /** Accepted MIME types */
  accept: { type: String, default: 'image/png, image/jpeg, image/webp, image/gif' },

  /** Columns: preset string ('sm'=4|'md'=3|'lg'=2) or arbitrary number */
  cellSize: { type: [String, Number], default: 'md' },

  /** Disabled state */
  disabled: { type: Boolean, default: false },
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
const previewVisible = ref(false)
const previewIndex = ref(0)

/** Internal item model */
const items = ref([])

// Hydrate / reset from modelValue
watch(() => props.modelValue, (vals) => {
  const safe = Array.isArray(vals) ? vals : []
  // Reset: modelValue cleared
  if (safe.length === 0) {
    items.value = []
    return
  }
  // Hydrate: items not yet initialized
  if (items.value.length === 0) {
    items.value = safe.map(v => {
      if (typeof v === 'string') {
        return { id: genId(), previewUrl: v, url: v, uploading: false, progress: 0, error: false, file: null, _raw: v }
      }
      const src = v[props.text] || v.url || v.previewUrl || ''
      return {
        id: v[props.key] || genId(),
        previewUrl: src,
        url: src,
        uploading: false,
        progress: 0,
        error: false,
        file: v.file || null,
        _raw: v,
      }
    })
  }
}, { immediate: true })

/** Emit current state back as v-model */
function syncModel() {
  const result = items.value.map(i => {
    const val = i.url || i.previewUrl
    if (!val) return null
    // If item came from an object, emit updated object
    if (i._raw && typeof i._raw === 'object') {
      return { ...i._raw, [props.text]: val, [props.key]: i.id }
    }
    return val  // plain URL string (newly uploaded)
  }).filter(Boolean)
  emit('update:modelValue', result)
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
  const files = Array.from(e.dataTransfer?.files || []).filter(f => f.type.startsWith('image/'))
  if (files.length) addFiles(files)
}

function onFileChange(e) {
  const files = Array.from(e.target?.files || [])
  if (files.length) addFiles(files)
  // Reset input so re-selecting same file works
  if (inputRef.value) inputRef.value.value = ''
}

async function addFiles(files) {
  const remaining = props.maxCount - items.value.length
  if (remaining <= 0) {
    emit('error', `最多上传 ${r"${"}props.maxCount} 张图片`)
    return
  }

  const toAdd = files.slice(0, remaining)

  for (const file of toAdd) {
    // Validate type
    if (!file.type.startsWith('image/')) {
      emit('error', `${r"${"}file.name} 不是图片文件`)
      continue
    }

    // Validate size
    if (file.size > props.maxSizeMB * 1024 * 1024) {
      emit('error', `${r"${"}file.name} 超过 ${r"${"}props.maxSizeMB}MB 限制`)
      continue
    }

    const item = {
      id: genId(),
      previewUrl: '',
      url: '',
      uploading: true,
      progress: 0,
      error: false,
      file,
    }
    items.value.push(item)
    const idx = items.value.length - 1

    // Read preview
    const reader = new FileReader()
    reader.onload = () => {
      item.previewUrl = reader.result
    }
    reader.readAsDataURL(file)

    // Simulate upload progress
    await simulateUpload(item)

    item.uploading = false
    emit('upload', { file, url: item.previewUrl, index: idx })
  }

  syncModel()
}

function simulateUpload(item) {
  return new Promise(resolve => {
    // Realistic upload curve: fast start → slow middle → fast finish
    let elapsed = 0
    const totalDuration = 1200 + Math.random() * 1800 // 1.2~3s total
    const tick = 60
    const interval = setInterval(() => {
      elapsed += tick
      const ratio = elapsed / totalDuration
      // Sigmoid-like curve for realistic feel
      const curved = 1 / (1 + Math.exp(-10 * (ratio - 0.4)))
      const noise = (Math.random() - 0.5) * 0.06
      item.progress = Math.min(99, Math.round((curved + noise) * 100))
      if (ratio >= 1) {
        item.progress = 100
        clearInterval(interval)
        item.justDone = true
        setTimeout(() => {
          item.url = item.previewUrl
          item.justDone = false
          resolve()
        }, 350)
      }
    }, tick)
  })
}

function removeItem(idx) {
  const item = items.value[idx]
  items.value.splice(idx, 1)
  syncModel()
  emit('remove', { index: idx, item })
}

/* ───────────────────────────────────────────────
   Lightbox Preview
   ─────────────────────────────────────────────── */

function previewItem(idx) {
  if (!items.value[idx]?.previewUrl || items.value[idx]?.uploading) return
  previewIndex.value = idx
  previewVisible.value = true
}

function closePreview() {
  previewVisible.value = false
}

function previewPrev(e) {
  e.stopPropagation()
  if (previewIndex.value > 0) previewIndex.value--
}

function previewNext(e) {
  e.stopPropagation()
  if (previewIndex.value < items.value.length - 1) previewIndex.value++
}

/** Keyboard nav in lightbox */
function onKeydown(e) {
  if (!previewVisible.value) return
  if (e.key === 'Escape') closePreview()
  if (e.key === 'ArrowLeft') previewPrev(e)
  if (e.key === 'ArrowRight') previewNext(e)
}

// Register global keydown for lightbox
if (typeof window !== 'undefined') {
  window.addEventListener('keydown', onKeydown)
}
</script>

<style scoped>
/* ═══════════════════════════════════════════════════════════════════════════
   IMAGE UPLOAD — Academy Pro · Multi-Image Grid
   Navy Pitch Design Tokens
   ═══════════════════════════════════════════════════════════════════════════ */

.iu-root {
  display: flex;
  flex-direction: column;
  gap: var(--space-4);
}

.iu--disabled {
  opacity: 0.55;
  pointer-events: none;
}

/* ── Grid ─────────────────────────────────────── */

.iu-grid-wrap {
  /* limit grid expansion, keep thumbnails compact */
}

.iu-grid-wrap--sm { max-width: 520px; }
.iu-grid-wrap--md { max-width: 440px; }
.iu-grid-wrap--lg { max-width: 480px; }

.iu-grid {
  display: grid;
  gap: var(--space-3);
}

/* md (default): 3 columns */
.iu-grid--md { grid-template-columns: repeat(3, 1fr); }
/* sm: 4 columns */
.iu-grid--sm { grid-template-columns: repeat(4, 1fr); }
/* lg: 2 columns */
.iu-grid--lg { grid-template-columns: repeat(2, 1fr); gap: var(--space-5); }

@media (max-width: 480px) {
  .iu-grid-wrap--sm,
  .iu-grid-wrap--md { max-width: none; }
  .iu-grid--md,
  .iu-grid--sm { grid-template-columns: repeat(3, 1fr); }
  .iu-grid--lg { grid-template-columns: repeat(2, 1fr); }
}

/* ── Cell (shared) ────────────────────────────── */

.iu-cell {
  position: relative;
  aspect-ratio: 1 / 1;
  border-radius: var(--radius-lg);
  overflow: hidden;
  background: var(--color-surface);
  border: 1px solid var(--color-border);
  cursor: pointer;
  transition: box-shadow var(--transition-base), border-color var(--transition-base), transform var(--transition-base);
}

.iu-cell:hover:not(.iu-cell--uploading) {
  box-shadow: var(--shadow-md);
  border-color: var(--color-teal);
  transform: translateY(-1px);
}

.iu-cell:focus-visible {
  outline: 2px solid var(--color-teal);
  outline-offset: 2px;
}

/* ── Cell Image ───────────────────────────────── */

.iu-cell__img {
  width: 100%;
  height: 100%;
  object-fit: cover;
  display: block;
}

/* ── Cell Skeleton ────────────────────────────── */

.iu-cell__skeleton {
  width: 100%;
  height: 100%;
  display: flex;
  align-items: center;
  justify-content: center;
  background: linear-gradient(135deg, var(--color-surface), #e8edf2);
}

.iu-cell__skeleton-icon {
  font-size: 28px;
  opacity: 0.3;
}

/* ── Cell Overlay (hover) ─────────────────────── */

.iu-cell__overlay {
  position: absolute;
  inset: 0;
  background: rgba(13, 27, 42, 0.45);
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  gap: var(--space-3);
  opacity: 0;
  transition: opacity var(--transition-base);
  border-radius: var(--radius-lg);
}

.iu-cell:hover .iu-cell__overlay {
  opacity: 1;
}

.iu-cell__delete {
  width: 32px;
  height: 32px;
  border-radius: var(--radius-full);
  background: var(--color-red);
  color: #fff;
  border: none;
  cursor: pointer;
  font-size: var(--text-lg);
  display: flex;
  align-items: center;
  justify-content: center;
  transition: transform var(--transition-fast), background var(--transition-fast);
  font-family: inherit;
  line-height: 1;
}

.iu-cell__delete:hover {
  transform: scale(1.12);
  background: #d43d5e;
}

.iu-cell__preview-hint {
  font-size: var(--text-xs);
  color: rgba(255,255,255,0.8);
  font-weight: var(--weight-medium);
}

/* ── Cell Progress Overlay ────────────────────── */

.iu-cell__progress {
  position: absolute;
  inset: 0;
  background: rgba(13, 27, 42, 0.6);
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  gap: var(--space-4);
  border-radius: var(--radius-lg);
}

.iu-cell__ring {
  width: 56px;
  height: 56px;
}

.iu-cell__ring-fill {
  transition: stroke-dashoffset 0.3s ease;
}

.iu-cell__progress-text {
  font-size: var(--text-sm);
  font-weight: var(--weight-bold);
  color: var(--color-teal);
}

/* Shimmer bar */
.iu-cell__shimmer {
  position: absolute;
  top: 0; left: 0; right: 0; height: 3px;
  background: linear-gradient(90deg,
    transparent 0%,
    rgba(0,201,167,0.6) 50%,
    transparent 100%
  );
  background-size: 200% 100%;
  animation: iu-shimmer 1.2s ease-in-out infinite;
  z-index: 1;
}

@keyframes iu-shimmer {
  0%   { background-position: 200% 0; }
  100% { background-position: -200% 0; }
}

/* Completion pulse */
.iu-cell__done-pulse {
  position: absolute;
  inset: -4px;
  border-radius: var(--radius-lg);
  border: 3px solid var(--color-teal);
  animation: iu-pulse 0.4s ease-out forwards;
  pointer-events: none;
  z-index: 5;
}

@keyframes iu-pulse {
  0%   { opacity: 1; transform: scale(0.96); }
  100% { opacity: 0; transform: scale(1.08); }
}

/* ── Cell Error ───────────────────────────────── */

.iu-cell--error {
  border-color: var(--color-red);
  box-shadow: 0 0 0 3px var(--color-red-dim);
}

.iu-cell__error-badge {
  position: absolute;
  top: var(--space-3);
  right: var(--space-3);
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

.iu-cell--add {
  border: 2px dashed var(--color-border);
  background: transparent;
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  gap: var(--space-3);
  transition: border-color var(--transition-base), background var(--transition-base), box-shadow var(--transition-base);
}

.iu-cell--add:hover,
.iu-cell--dragover {
  border-color: var(--color-teal);
  background: var(--color-teal-dim);
  box-shadow: var(--shadow-glow-teal);
}

.iu-cell__add-icon {
  font-size: 32px;
  color: var(--color-text-muted);
  font-weight: var(--weight-light);
  line-height: 1;
  transition: color var(--transition-base);
}

.iu-cell--add:hover .iu-cell__add-icon,
.iu-cell--dragover .iu-cell__add-icon {
  color: var(--color-teal);
}

.iu-cell__add-text {
  font-size: var(--text-xs);
  color: var(--color-text-muted);
  font-weight: var(--weight-medium);
}

/* ── Hint ─────────────────────────────────────── */

.iu-hint {
  font-size: var(--text-xs);
  color: var(--color-text-muted);
}

/* ── Hidden input ─────────────────────────────── */

.iu-input {
  position: absolute;
  width: 0;
  height: 0;
  opacity: 0;
  pointer-events: none;
}

/* ═══════════════════════════════════════════════ */
/* Lightbox                                         */
/* ═══════════════════════════════════════════════ */

.iu-lightbox {
  position: fixed;
  inset: 0;
  z-index: 600;
  background: rgba(13, 27, 42, 0.92);
  display: flex;
  align-items: center;
  justify-content: center;
  padding: var(--space-14);
}

.iu-lightbox__close {
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

.iu-lightbox__close:hover {
  background: rgba(255,255,255,0.2);
}

.iu-lightbox__img {
  max-width: 85vw;
  max-height: 85vh;
  object-fit: contain;
  border-radius: var(--radius-lg);
  box-shadow: 0 20px 60px rgba(0,0,0,0.4);
  user-select: none;
}

/* ── Nav arrows ───────────────────────────────── */

.iu-lightbox__nav {
  position: absolute;
  top: 50%;
  transform: translateY(-50%);
  width: 48px;
  height: 48px;
  border-radius: var(--radius-full);
  background: rgba(255,255,255,0.08);
  border: 1px solid rgba(255,255,255,0.12);
  color: #fff;
  font-size: 28px;
  cursor: pointer;
  display: flex;
  align-items: center;
  justify-content: center;
  transition: background var(--transition-fast);
  font-family: inherit;
  z-index: 2;
}

.iu-lightbox__nav:hover {
  background: rgba(255,255,255,0.18);
}

.iu-lightbox__nav--prev { left: var(--space-11); }
.iu-lightbox__nav--next { right: var(--space-11); }

.iu-lightbox__counter {
  position: absolute;
  bottom: var(--space-11);
  left: 50%;
  transform: translateX(-50%);
  font-size: var(--text-md);
  color: rgba(255,255,255,0.6);
  font-weight: var(--weight-medium);
}

/* ── Lightbox transitions ─────────────────────── */

.lb-enter-active { transition: opacity var(--transition-smooth); }
.lb-leave-active { transition: opacity 0.12s ease; }
.lb-enter-from,
.lb-leave-to { opacity: 0; }

.lb-enter-active .iu-lightbox__img {
  transition: transform var(--transition-smooth), opacity var(--transition-smooth);
}
.lb-enter-from .iu-lightbox__img {
  transform: scale(0.92);
  opacity: 0;
}
.lb-leave-active .iu-lightbox__img {
  transition: transform 0.12s ease, opacity 0.12s ease;
}
.lb-leave-to .iu-lightbox__img {
  transform: scale(0.95);
  opacity: 0;
}
</style>
