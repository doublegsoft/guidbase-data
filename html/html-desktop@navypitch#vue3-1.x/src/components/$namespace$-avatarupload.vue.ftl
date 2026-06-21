<template>
  <div class="au-root">
    <div
      class="au-avatar"
      :class="{
        'au-avatar--sm': size === 'sm',
        'au-avatar--lg': size === 'lg',
        'au-avatar--xl': size === 'xl',
        'au-avatar--dragover': dragging,
        'au-avatar--disabled': disabled,
      }"
      @click="triggerInput"
      @dragover.prevent="onDragOver"
      @dragleave.prevent="onDragLeave"
      @drop.prevent="onDrop"
      role="button"
      :tabindex="disabled ? -1 : 0"
      @keydown.enter="triggerInput"
      @keydown.space.prevent="triggerInput"
    >
      <!-- Uploaded image -->
      <img
        v-if="previewUrl"
        :src="previewUrl"
        class="au-avatar__img"
        alt="头像"
      />

      <!-- Default: initials or icon -->
      <span v-else class="au-avatar__placeholder">{{ initials }}</span>

      <!-- Hover overlay -->
      <div v-if="!disabled" class="au-avatar__overlay">
        <span class="au-avatar__overlay-icon">📷</span>
        <span v-if="size === 'lg' || size === 'xl'" class="au-avatar__overlay-text">更换头像</span>
      </div>

      <!-- Uploading progress ring -->
      <svg
        v-if="uploading"
        class="au-avatar__ring"
        viewBox="0 0 100 100"
      >
        <circle
          class="au-avatar__ring-bg"
          cx="50" cy="50" r="46"
          fill="none"
          stroke="rgba(255,255,255,0.25)"
          stroke-width="4"
        />
        <circle
          class="au-avatar__ring-fill"
          cx="50" cy="50" r="46"
          fill="none"
          stroke="var(--color-teal)"
          stroke-width="4"
          stroke-linecap="round"
          :stroke-dasharray="2 * Math.PI * 46"
          :stroke-dashoffset="2 * Math.PI * 46 * (1 - progress / 100)"
          transform="rotate(-90 50 50)"
        />
      </svg>
    </div>

    <!-- Hint text -->
    <div v-if="hint && !disabled" class="au-hint">
      {{ uploading ? `上传中 ${r"${"}Math.round(progress)}%…` : hint }}
    </div>

    <!-- Hidden file input -->
    <input
      ref="inputRef"
      type="file"
      class="au-input"
      accept="image/png, image/jpeg, image/webp, image/gif"
      @change="onFileChange"
    />
  </div>
</template>

<script setup>
import { ref, computed, watch } from 'vue'

/* ───────────────────────────────────────────────
   Props
   ─────────────────────────────────────────────── */

const props = defineProps({
  /** Current image URL — external */
  modelValue: { type: String, default: '' },

  /** Size variant */
  size: { type: String, default: 'md' },     // 'sm' | 'md' | 'lg' | 'xl'

  /** Name used to derive initials */
  name: { type: String, default: '' },

  /** Hint text below avatar */
  hint: { type: String, default: '点击上传头像' },

  /** Max file size in MB */
  maxSizeMB: { type: Number, default: 5 },

  /** Disabled */
  disabled: { type: Boolean, default: false },
})

/* ───────────────────────────────────────────────
   Emits
   ─────────────────────────────────────────────── */

const emit = defineEmits(['update:modelValue', 'upload', 'error'])

/* ───────────────────────────────────────────────
   State
   ─────────────────────────────────────────────── */

const inputRef = ref(null)
const previewUrl = ref(props.modelValue)
const dragging = ref(false)
const uploading = ref(false)
const progress = ref(0)

watch(() => props.modelValue, v => { previewUrl.value = v })

/* ───────────────────────────────────────────────
   Computed
   ─────────────────────────────────────────────── */

const initials = computed(() => {
  if (!props.name) return '?'
  const parts = props.name.trim().split(/\s+/)
  if (parts.length >= 2) {
    return (parts[0][0] + parts[parts.length - 1][0]).toUpperCase()
  }
  return props.name.slice(0, 2).toUpperCase()
})

/* ───────────────────────────────────────────────
   Actions
   ─────────────────────────────────────────────── */

function triggerInput() {
  if (props.disabled || uploading.value) return
  inputRef.value?.click()
}

function onDragOver() {
  if (props.disabled || uploading.value) return
  dragging.value = true
}

function onDragLeave() {
  dragging.value = false
}

function onDrop(e) {
  dragging.value = false
  if (props.disabled || uploading.value) return
  const file = e.dataTransfer?.files?.[0]
  if (file) processFile(file)
}

function onFileChange(e) {
  const file = e.target?.files?.[0]
  if (file) processFile(file)
  // Reset so re-selecting the same file triggers change
  if (inputRef.value) inputRef.value.value = ''
}

function processFile(file) {
  // Validate type
  if (!file.type.startsWith('image/')) {
    emit('error', '请选择图片文件')
    return
  }

  // Validate size
  if (file.size > props.maxSizeMB * 1024 * 1024) {
    emit('error', `文件大小不能超过 ${r"${"}props.maxSizeMB}MB`)
    return
  }

  // Read as data URL for preview
  const reader = new FileReader()
  reader.onload = () => {
    previewUrl.value = reader.result
  }
  reader.readAsDataURL(file)

  // Simulate upload progress
  uploading.value = true
  progress.value = 0

  const interval = setInterval(() => {
    progress.value += Math.random() * 30 + 5
    if (progress.value >= 100) {
      progress.value = 100
      clearInterval(interval)
      setTimeout(() => {
        uploading.value = false
        progress.value = 0
        emit('update:modelValue', previewUrl.value)
        emit('upload', { file, url: previewUrl.value })
      }, 300)
    }
  }, 200)
}
</script>

<style scoped>
/* ═══════════════════════════════════════════════════════════════════════════
   AVATAR UPLOAD — Academy Pro Style
   ═══════════════════════════════════════════════════════════════════════════ */

.au-root {
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: var(--space-4);
}

/* ── Avatar circle ────────────────────────────── */

.au-avatar {
  position: relative;
  width: 72px;
  height: 72px;
  border-radius: var(--radius-full);
  background: linear-gradient(135deg, var(--color-steel), var(--color-teal));
  display: flex;
  align-items: center;
  justify-content: center;
  cursor: pointer;
  overflow: hidden;
  transition: box-shadow var(--transition-base), transform var(--transition-base);
  user-select: none;
  flex-shrink: 0;
}

.au-avatar:hover:not(.au-avatar--disabled) {
  box-shadow: var(--shadow-glow-teal);
  transform: scale(1.04);
}

.au-avatar:focus-visible {
  outline: 2px solid var(--color-teal);
  outline-offset: 3px;
}

/* Sizes */
.au-avatar--sm { width: 40px; height: 40px; }
.au-avatar--lg { width: 88px; height: 88px; }
.au-avatar--xl { width: 110px; height: 110px; }

/* Disabled */
.au-avatar--disabled {
  opacity: 0.6;
  cursor: not-allowed;
}

/* Drag-over state */
.au-avatar--dragover {
  box-shadow: 0 0 0 4px var(--color-teal-dim), 0 0 0 6px var(--color-teal);
  transform: scale(1.06);
}

/* ── Image ────────────────────────────────────── */

.au-avatar__img {
  width: 100%;
  height: 100%;
  object-fit: cover;
  border-radius: var(--radius-full);
}

/* ── Placeholder (initials) ───────────────────── */

.au-avatar__placeholder {
  font-size: var(--text-5xl);
  font-weight: var(--weight-extrabold);
  color: #fff;
  letter-spacing: 0.5px;
  z-index: 1;
}

.au-avatar--sm .au-avatar__placeholder { font-size: var(--text-lg); }
.au-avatar--lg .au-avatar__placeholder { font-size: var(--text-7xl); }
.au-avatar--xl .au-avatar__placeholder { font-size: 36px; }

/* ── Hover overlay ────────────────────────────── */

.au-avatar__overlay {
  position: absolute;
  inset: 0;
  border-radius: var(--radius-full);
  background: rgba(13, 27, 42, 0.55);
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  gap: var(--space-2);
  opacity: 0;
  transition: opacity var(--transition-base);
  z-index: 2;
}

.au-avatar:hover .au-avatar__overlay,
.au-avatar--dragover .au-avatar__overlay {
  opacity: 1;
}

.au-avatar__overlay-icon {
  font-size: var(--text-5xl);
}

.au-avatar--sm .au-avatar__overlay-icon { font-size: var(--text-lg); }
.au-avatar--lg .au-avatar__overlay-icon { font-size: var(--text-7xl); }
.au-avatar--xl .au-avatar__overlay-icon { font-size: 32px; }

.au-avatar__overlay-text {
  font-size: var(--text-xs);
  color: #fff;
  font-weight: var(--weight-semibold);
}

/* ── Upload progress ring ─────────────────────── */

.au-avatar__ring {
  position: absolute;
  inset: -4px;
  width: calc(100% + 8px);
  height: calc(100% + 8px);
  z-index: 5;
  pointer-events: none;
}

.au-avatar__ring-fill {
  transition: stroke-dashoffset 0.3s ease;
}

/* ── Hint ─────────────────────────────────────── */

.au-hint {
  font-size: var(--text-sm);
  color: var(--color-text-muted);
  text-align: center;
}

/* ── Hidden input ─────────────────────────────── */

.au-input {
  position: absolute;
  width: 0;
  height: 0;
  opacity: 0;
  pointer-events: none;
}
</style>
