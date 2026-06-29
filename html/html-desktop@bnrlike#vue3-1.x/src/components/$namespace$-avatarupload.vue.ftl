<template>
  <div class="ef-au">
    <div
      class="ef-au__avatar"
      :class="{
        'ef-au__avatar--sm': size === 'sm',
        'ef-au__avatar--lg': size === 'lg',
        'ef-au__avatar--xl': size === 'xl',
        'ef-au__avatar--dragover': dragging,
        'ef-au__avatar--disabled': disabled,
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
      <img v-if="previewUrl" :src="previewUrl" class="ef-au__img" alt="头像" />
      <span v-else class="ef-au__placeholder">{{ initials }}</span>
      <div v-if="!disabled" class="ef-au__overlay">
        <span class="ef-au__overlay-icon">📷</span>
        <span v-if="size === 'lg' || size === 'xl'" class="ef-au__overlay-text">更换头像</span>
      </div>
      <svg v-if="uploading" class="ef-au__ring" viewBox="0 0 100 100">
        <circle class="ef-au__ring-bg" cx="50" cy="50" r="46" fill="none" stroke="rgba(255,255,255,0.25)" stroke-width="4" />
        <circle
          class="ef-au__ring-fill"
          cx="50" cy="50" r="46" fill="none"
          stroke="var(--ef-primary)" stroke-width="4" stroke-linecap="round"
          :stroke-dasharray="2 * Math.PI * 46"
          :stroke-dashoffset="2 * Math.PI * 46 * (1 - progress / 100)"
          transform="rotate(-90 50 50)"
        />
      </svg>
    </div>
    <div v-if="hint && !disabled" class="ef-au__hint">
      {{ uploading ? `上传中 ${r"${"}Math.round(progress)}%…` : hint }}
    </div>
    <input ref="inputRef" type="file" class="ef-au__input" accept="image/png, image/jpeg, image/webp, image/gif" @change="onFileChange" />
  </div>
</template>

<script setup>
import { ref, computed, watch } from 'vue'

const props = defineProps({
  modelValue: { type: String, default: '' },
  size: { type: String, default: 'md' },
  name: { type: String, default: '' },
  hint: { type: String, default: '点击上传头像' },
  maxSizeMB: { type: Number, default: 5 },
  disabled: { type: Boolean, default: false },
})

const emit = defineEmits(['update:modelValue', 'upload', 'error'])

const inputRef = ref(null)
const previewUrl = ref(props.modelValue)
const dragging = ref(false)
const uploading = ref(false)
const progress = ref(0)

watch(() => props.modelValue, v => { previewUrl.value = v })

const initials = computed(() => {
  if (!props.name) return '?'
  const parts = props.name.trim().split(/\s+/)
  if (parts.length >= 2) return (parts[0][0] + parts[parts.length - 1][0]).toUpperCase()
  return props.name.slice(0, 2).toUpperCase()
})

function triggerInput() {
  if (props.disabled || uploading.value) return
  inputRef.value?.click()
}

function onDragOver() {
  if (props.disabled || uploading.value) return
  dragging.value = true
}

function onDragLeave() { dragging.value = false }

function onDrop(e) {
  dragging.value = false
  if (props.disabled || uploading.value) return
  const file = e.dataTransfer?.files?.[0]
  if (file) processFile(file)
}

function onFileChange(e) {
  const file = e.target?.files?.[0]
  if (file) processFile(file)
  if (inputRef.value) inputRef.value.value = ''
}

function processFile(file) {
  if (!file.type.startsWith('image/')) { emit('error', '请选择图片文件'); return }
  if (file.size > props.maxSizeMB * 1024 * 1024) { emit('error', `文件大小不能超过 ${r"${"}props.maxSizeMB}MB`); return }
  const reader = new FileReader()
  reader.onload = () => { previewUrl.value = reader.result }
  reader.readAsDataURL(file)
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
/* ══════════════════════════════════════════════
   AVATAR UPLOAD — BNR Style
   ══════════════════════════════════════════════ */

.ef-au { display: flex; flex-direction: column; align-items: center; gap: 4px; }

.ef-au__avatar {
  position: relative;
  width: 72px; height: 72px;
  border-radius: 50%;
  background: linear-gradient(135deg, var(--ef-primary-dark), var(--ef-primary));
  display: flex; align-items: center; justify-content: center;
  cursor: pointer; overflow: hidden;
  transition: box-shadow 0.18s ease, transform 0.18s ease;
  user-select: none; flex-shrink: 0;
  border: 2px solid var(--ef-bg);
}
.ef-au__avatar:hover:not(.ef-au__avatar--disabled) {
  box-shadow: 0 0 0 3px var(--ef-primary-bg);
  transform: scale(1.04);
}
.ef-au__avatar:focus-visible { outline: 2px solid var(--ef-primary); outline-offset: 2px; }
.ef-au__avatar--sm { width: 40px; height: 40px; }
.ef-au__avatar--lg { width: 88px; height: 88px; }
.ef-au__avatar--xl { width: 110px; height: 110px; }
.ef-au__avatar--disabled { opacity: 0.5; cursor: not-allowed; }
.ef-au__avatar--dragover {
  box-shadow: 0 0 0 3px var(--ef-primary-bg), 0 0 0 5px var(--ef-primary);
  transform: scale(1.06);
}

.ef-au__img {
  width: 100%; height: 100%; object-fit: cover; border-radius: 50%;
}

.ef-au__placeholder {
  font-size: 28px; font-weight: 800; color: #fff; letter-spacing: 0.5px; z-index: 1;
}
.ef-au__avatar--sm .ef-au__placeholder { font-size: 14px; }
.ef-au__avatar--lg .ef-au__placeholder { font-size: 36px; }
.ef-au__avatar--xl .ef-au__placeholder { font-size: 40px; }

.ef-au__overlay {
  position: absolute; inset: 0; border-radius: 50%;
  background: rgba(26,79,138,0.5);
  display: flex; flex-direction: column; align-items: center; justify-content: center;
  gap: 2px; opacity: 0; transition: opacity 0.18s ease; z-index: 2;
}
.ef-au__avatar:hover .ef-au__overlay,
.ef-au__avatar--dragover .ef-au__overlay { opacity: 1; }

.ef-au__overlay-icon { font-size: 24px; }
.ef-au__avatar--sm .ef-au__overlay-icon { font-size: 14px; }
.ef-au__avatar--lg .ef-au__overlay-icon { font-size: 32px; }
.ef-au__avatar--xl .ef-au__overlay-icon { font-size: 36px; }

.ef-au__overlay-text { font-size: 10px; color: #fff; font-weight: 600; }

.ef-au__ring {
  position: absolute; inset: -4px;
  width: calc(100% + 8px); height: calc(100% + 8px);
  z-index: 5; pointer-events: none;
}
.ef-au__ring-fill { transition: stroke-dashoffset 0.3s ease; }

.ef-au__hint { font-size: 11px; color: var(--ef-text-muted); text-align: center; }
.ef-au__input { position: absolute; width: 0; height: 0; opacity: 0; pointer-events: none; }
</style>
