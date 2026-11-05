<template>
  <div
    class="${namespace}-iu"
    :class="{ '${namespace}-iu--disabled': disabled }"
    @dragover.prevent="onDragOver"
    @dragleave.prevent="onDragLeave"
    @drop.prevent="onDrop"
  >
    <label v-if="label" class="${namespace}-field-label">{{ label }}</label>

    <!-- ── 缩略图网格：4列等宽直角网格 ── -->
    <div class="${namespace}-iu__grid">
      <div
        v-for="(item, idx) in items" :key="item.id"
        class="${namespace}-iu__cell"
        :class="{
          '${namespace}-iu__cell--uploading': item.uploading,
          '${namespace}-iu__cell--error': item.error,
        }"
      >
        <!-- 缩略图 -->
        <img
          v-if="item.previewUrl"
          :src="item.previewUrl"
          class="${namespace}-iu__thumb"
          alt=""
          @click="previewItem(idx)"
        />
        <!-- 极客等宽空状态 (替代 Emoji) -->
        <div v-else class="${namespace}-iu__thumb ${namespace}-iu__thumb--empty">
          <span>[IMAGE]</span>
        </div>

        <!-- 悬停直角操作条 -->
        <div v-if="!disabled && !item.uploading" class="${namespace}-iu__actions">
          <span class="${namespace}-iu__actions-preview" title="ZOOM" @click="previewItem(idx)">[+]</span>
          <span class="${namespace}-iu__actions-del" title="REMOVE" @click="removeItem(idx)">&times;</span>
        </div>

        <!-- 传输进度条 -->
        <div v-if="item.uploading" class="${namespace}-iu__progress-bar">
          <div class="${namespace}-iu__progress-fill" :style="{ width: item.progress + '%' }"></div>
        </div>

        <!-- 传输完成闪烁边框 -->
        <div v-if="item.justDone" class="${namespace}-iu__done-flash"></div>

        <!-- 错误标记 -->
        <span v-if="item.error" class="${namespace}-iu__error-mark" title="ERROR">!</span>
      </div>

      <!-- 添加直角虚线槽位 -->
      <div
        v-if="items.length < maxCount && !disabled"
        class="${namespace}-iu__cell ${namespace}-iu__cell--add"
        :class="{ '${namespace}-iu__cell--dragover': dragging }"
        @click="triggerInput"
      >
        <span class="${namespace}-iu__add-icon">+</span>
        <span class="${namespace}-iu__add-text">
          {{ items.length === 0 ? (placeholder || 'ADD IMAGE') : (items.length + '/' + maxCount) }}
        </span>
      </div>
    </div>

    <div v-if="hint" class="${namespace}-iu__hint">{{ hint }}</div>

    <input
      ref="inputRef"
      type="file"
      class="${namespace}-iu__input"
      :accept="accept"
      :multiple="maxCount > 1"
      @change="onFileChange"
    />

    <!-- ── 预览灯箱 (物理硬阴影直角弹窗) ── -->
    <Teleport to="body">
      <Transition name="${namespace}-iu-lb">
        <div v-if="previewVisible" class="${namespace}-iu__lightbox" @click="closePreview">
          <div class="${namespace}-iu__lightbox-mask"></div>
          <div class="${namespace}-iu__lightbox-body" @click.stop>
            <div class="${namespace}-iu__lightbox-head">
              <span class="${namespace}-iu__lightbox-title">
                IMAGE INSPECTOR <span v-if="items.length > 1">// {{ String(previewIndex + 1).padStart(2, '0') }} OF {{ String(items.length).padStart(2, '0') }}</span>
              </span>
              <button type="button" class="${namespace}-iu__lightbox-close" title="CLOSE" @click="closePreview">&times;</button>
            </div>
            <div class="${namespace}-iu__lightbox-main">
              <button
                v-if="items.length > 1"
                type="button"
                class="${namespace}-iu__lightbox-nav ${namespace}-iu__lightbox-nav--prev"
                :disabled="previewIndex <= 0"
                title="PREV"
                @click="previewPrev"
              >&lsaquo;</button>
              <img
                :src="items[previewIndex]?.previewUrl"
                class="${namespace}-iu__lightbox-img"
                alt="PREVIEW"
              />
              <button
                v-if="items.length > 1"
                type="button"
                class="${namespace}-iu__lightbox-nav ${namespace}-iu__lightbox-nav--next"
                :disabled="previewIndex >= items.length - 1"
                title="NEXT"
                @click="previewNext"
              >&rsaquo;</button>
            </div>
          </div>
        </div>
      </Transition>
    </Teleport>
  </div>
</template>

<script setup>
import { ref, watch } from 'vue'

let nextId = 1
function genId() { return 'img_' + Date.now() + '_' + (nextId++) }

const props = defineProps({
  modelValue:  { type: Array,    default: () => [] },
  key:         { type: String,   default: 'id' },
  url:         { type: String,   default: 'url' },
  thumbnail:   { type: String,   default: 'thumbnailUrl' },
  label:       { type: String,   default: '' },
  placeholder: { type: String,   default: '' },
  hint:        { type: String,   default: '' },
  maxCount:    { type: Number,   default: 9 },
  maxSizeMB:   { type: Number,   default: 10 },
  accept:      { type: String,   default: 'image/png, image/jpeg, image/webp, image/gif' },
  disabled:    { type: Boolean,  default: false },
  customUpload:{ type: Function, default: null },
})

const emit = defineEmits(['update:modelValue', 'upload', 'error', 'remove'])

const inputRef = ref(null)
const dragging = ref(false)
const previewVisible = ref(false)
const previewIndex = ref(0)
const items = ref([])

watch(() => props.modelValue, (vals) => {
  const safe = Array.isArray(vals) ? vals : []
  if (safe.length === 0) { items.value = []; return }
  if (items.value.length === 0) {
    items.value = safe.map(v => {
      if (typeof v === 'string') {
        return { id: genId(), previewUrl: v, url: v, uploading: false, progress: 0, error: false, file: null, _raw: v }
      }
      const src = v[props.url] || v.url || v.previewUrl || ''
      const thumb = v[props.thumbnail] || v.thumbnailUrl || src
      return { id: v[props.key] || genId(), previewUrl: thumb, url: src, uploading: false, progress: 0, error: false, file: v.file || null, _raw: v }
    })
  }
}, { immediate: true })

function syncModel() {
  const result = items.value.map(i => {
    const val = i.url || i.previewUrl
    if (!val) return null
    if (i._raw && typeof i._raw === 'object') {
      return { ...i._raw, [props.url]: val, [props.thumbnail]: i.previewUrl || val, [props.key]: i.id }
    }
    return val
  }).filter(Boolean)
  emit('update:modelValue', result)
}

function triggerInput() { if (!props.disabled) inputRef.value?.click() }
function onDragOver() { if (!props.disabled) dragging.value = true }
function onDragLeave() { dragging.value = false }

function onDrop(e) {
  dragging.value = false
  if (props.disabled) return
  const files = Array.from(e.dataTransfer?.files || []).filter(f => f.type.startsWith('image/'))
  if (files.length) addFiles(files)
}

function onFileChange(e) {
  const files = Array.from(e.target?.files || [])
  if (files.length) addFiles(files)
  if (inputRef.value) inputRef.value.value = ''
}

async function addFiles(files) {
  const remaining = props.maxCount - items.value.length
  if (remaining <= 0) { emit('error', '最多上传 ' + props.maxCount + ' 张图片'); return }
  for (const file of files.slice(0, remaining)) {
    if (!file.type.startsWith('image/')) { emit('error', file.name + ' 不是有效图片格式'); continue }
    if (file.size > props.maxSizeMB * 1024 * 1024) { emit('error', file.name + ' 超过 ' + props.maxSizeMB + 'MB 限制'); continue }
    const item = { id: genId(), previewUrl: '', url: '', uploading: true, progress: 0, error: false, file }
    items.value.push(item)
    const idx = items.value.length - 1
    const reader = new FileReader()
    reader.onload = () => { item.previewUrl = reader.result }
    reader.readAsDataURL(file)

    if (props.customUpload) {
      try {
        const result = await props.customUpload(file, { setProgress: (p) => { item.progress = Math.min(99, p) } })
        item.progress = 100
        item.justDone = true
        item.url = result.url || item.previewUrl
        setTimeout(() => { item.justDone = false; item.uploading = false }, 300)
        emit('upload', { file, ...result, index: idx })
      } catch (err) {
        item.error = true
        item.uploading = false
        emit('error', err?.message || '上传失败')
      }
    } else {
      await simulateUpload(item)
      item.uploading = false
      emit('upload', { file, url: item.previewUrl, index: idx })
    }
  }
  syncModel()
}

function simulateUpload(item) {
  return new Promise(resolve => {
    let elapsed = 0
    const dur = 800 + Math.random() * 1200
    const iv = setInterval(() => {
      elapsed += 50
      const r = elapsed / dur
      item.progress = Math.min(99, Math.round(r * 100))
      if (r >= 1) {
        item.progress = 100
        clearInterval(iv)
        item.justDone = true
        setTimeout(() => { item.url = item.previewUrl; item.justDone = false; resolve() }, 300)
      }
    }, 50)
  })
}

function removeItem(idx) {
  items.value.splice(idx, 1)
  syncModel()
  emit('remove', { index: idx })
}

function previewItem(idx) {
  if (!items.value[idx]?.previewUrl || items.value[idx]?.uploading) return
  previewIndex.value = idx
  previewVisible.value = true
}

function closePreview() { previewVisible.value = false }
function previewPrev() { if (previewIndex.value > 0) previewIndex.value-- }
function previewNext() { if (previewIndex.value < items.value.length - 1) previewIndex.value++ }

function onKeydown(e) {
  if (!previewVisible.value) return
  if (e.key === 'Escape') closePreview()
  if (e.key === 'ArrowLeft') previewPrev()
  if (e.key === 'ArrowRight') previewNext()
}
if (typeof window !== 'undefined') window.addEventListener('keydown', onKeydown)
</script>

<style scoped>
/* ══════════════════════════════════════════════
   Protocol Explorer ImageUpload 蓝图工程规范
   ══════════════════════════════════════════════ */
.${namespace}-iu {
  display: flex;
  flex-direction: column;
  gap: 6px;
  font-family: var(--${namespace}-f, "IBM Plex Mono", monospace);
  font-size: 13px;
  user-select: none;
}
.${namespace}-iu--disabled { opacity: .45; pointer-events: none; }

/* ── 缩略图网格：纯直角、4列横排 ── */
.${namespace}-iu__grid {
  display: grid;
  grid-template-columns: repeat(4, 1fr);
  gap: 6px;
  max-width: 280px;
  width: 100%;
}

/* 单元格：纯直角、1px 细线框 */
.${namespace}-iu__cell {
  position: relative;
  aspect-ratio: 1 / 1;
  border: 1px solid var(--${namespace}-ln, #d3dbef);
  border-radius: 0;
  background: var(--${namespace}-bg, #f4f6fb);
  overflow: hidden;
  transition: .12s;
  box-sizing: border-box;
}
.${namespace}-iu__cell:hover {
  border-color: var(--${namespace}-ink, #0a2a9a);
  transform: translate(-1px, -1px);
  box-shadow: 2px 2px 0 var(--${namespace}-ln, #d3dbef);
}
.${namespace}-iu__cell--error {
  border-color: var(--${namespace}-red, #d6343e) !important;
  background: var(--${namespace}-sel, #fdecee);
}

.${namespace}-iu__thumb {
  width: 100%;
  height: 100%;
  object-fit: cover;
  display: block;
  cursor: pointer;
}
.${namespace}-iu__thumb--empty {
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 10px;
  font-weight: 800;
  letter-spacing: .05em;
  color: var(--${namespace}-mu, #6f7fb4);
  background: var(--${namespace}-bg, #f4f6fb);
}

/* 悬停直角操作条 */
.${namespace}-iu__actions {
  position: absolute;
  top: 0;
  right: 0;
  z-index: 5;
  display: flex;
  opacity: 0;
  transition: opacity .15s;
}
.${namespace}-iu__cell:hover .${namespace}-iu__actions { opacity: 1; }

.${namespace}-iu__actions-preview,
.${namespace}-iu__actions-del {
  width: 22px;
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
.${namespace}-iu__actions-preview:hover { background: var(--${namespace}-pri, #0a2fb5); }
.${namespace}-iu__actions-del:hover     { background: var(--${namespace}-red, #d6343e); }

/* 上传进度条 */
.${namespace}-iu__progress-bar {
  position: absolute;
  bottom: 0;
  left: 0;
  right: 0;
  height: 2px;
  background: var(--${namespace}-ln, #d3dbef);
}
.${namespace}-iu__progress-fill {
  height: 100%;
  background: var(--${namespace}-pri, #0a2fb5);
  transition: width 0.08s linear;
}

/* 闪烁光效 */
.${namespace}-iu__done-flash {
  position: absolute;
  inset: 0;
  border: 2px solid var(--${namespace}-tcp, #13a05d);
  animation: iu-flash 0.35s ease-out forwards;
  pointer-events: none;
}
@keyframes iu-flash {
  0%   { opacity: 1; }
  100% { opacity: 0; }
}

/* 错误符号标记 */
.${namespace}-iu__error-mark {
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

/* 添加直角虚线格位 */
.${namespace}-iu__cell--add {
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
.${namespace}-iu__cell--add:hover,
.${namespace}-iu__cell--dragover {
  border-color: var(--${namespace}-pri, #0a2fb5);
  background: color-mix(in srgb, var(--${namespace}-pri, #0a2fb5) 8%, transparent);
}
.${namespace}-iu__add-icon {
  font-size: 16px;
  color: var(--${namespace}-mu, #6f7fb4);
  line-height: 1;
}
.${namespace}-iu__cell--add:hover .${namespace}-iu__add-icon {
  color: var(--${namespace}-pri, #0a2fb5);
}
.${namespace}-iu__add-text {
  font-size: 9px;
  font-weight: 700;
  color: var(--${namespace}-mu, #6f7fb4);
  letter-spacing: .05em;
}

.${namespace}-iu__hint {
  font-size: 11px;
  color: var(--${namespace}-mu, #6f7fb4);
  line-height: 1.3;
}
.${namespace}-iu__input {
  position: absolute;
  width: 0;
  height: 0;
  opacity: 0;
  pointer-events: none;
}

/* ══════════════════════════════════════════════
   预览灯箱：纯直角、6px 墨水实体投影
   ══════════════════════════════════════════════ */
.${namespace}-iu__lightbox {
  position: fixed;
  inset: 0;
  z-index: 100000;
  display: flex;
  align-items: center;
  justify-content: center;
  user-select: none;
}
.${namespace}-iu__lightbox-mask {
  position: absolute;
  inset: 0;
  background: rgba(8, 13, 34, 0.6);
  backdrop-filter: blur(1px);
}
.${namespace}-iu__lightbox-body {
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

.${namespace}-iu__lightbox-body {
  box-shadow: none !important; /* 核心修改：去除 6px 6px 0 投影 */
  border: 1px solid var(--${namespace}-ink, #0a2a9a);
}

/* 预览大图自身的立体边框 */
.${namespace}-iu__lightbox-img {
  box-shadow: none !important;
}

/* 灯箱头部 */
.${namespace}-iu__lightbox-head {
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: 8px 14px;
  background: var(--${namespace}-ink, #0a2a9a);
  color: var(--${namespace}-on, #ffffff);
  flex-shrink: 0;
}
.${namespace}-iu__lightbox-title {
  font-size: 12px;
  font-weight: 800;
  letter-spacing: .08em;
  text-transform: uppercase;
}
.${namespace}-iu__lightbox-close {
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
.${namespace}-iu__lightbox-close:hover {
  background: var(--${namespace}-red, #d6343e);
}

/* 灯箱预览主体 */
.${namespace}-iu__lightbox-main {
  flex: 1;
  display: flex;
  align-items: center;
  justify-content: center;
  padding: 16px;
  position: relative;
  min-height: 220px;
  background: var(--${namespace}-bg, #f4f6fb);
}
.${namespace}-iu__lightbox-img {
  max-width: 100%;
  max-height: 54vh;
  object-fit: contain;
  user-select: none;
  border: 1px solid var(--${namespace}-ln, #d3dbef);
  box-shadow: 2px 2px 0 var(--${namespace}-ln, #d3dbef);
}

/* 导航按键：直角微位移 */
.${namespace}-iu__lightbox-nav {
  position: absolute;
  top: 50%;
  transform: translateY(-50%);
  width: 32px;
  height: 48px;
  border: 1px solid var(--${namespace}-ink, #0a2a9a);
  background: var(--${namespace}-pn, #ffffff);
  color: var(--${namespace}-ink, #0a2a9a);
  font-size: 22px;
  font-weight: 700;
  cursor: pointer;
  display: flex;
  align-items: center;
  justify-content: center;
  transition: .12s;
}
.${namespace}-iu__lightbox-nav:hover:not(:disabled) {
  background: var(--${namespace}-pri, #0a2fb5);
  color: var(--${namespace}-on, #ffffff);
  transform: translateY(-50%) translate(-1px, -1px);
  box-shadow: 2px 2px 0 var(--${namespace}-ink, #0a2a9a);
}
.${namespace}-iu__lightbox-nav:disabled {
  opacity: .2;
  cursor: not-allowed;
  transform: translateY(-50%);
  box-shadow: none;
}
.${namespace}-iu__lightbox-nav--prev { left: 8px; }
.${namespace}-iu__lightbox-nav--next { right: 8px; }

/* 进退场微动效 */
.${namespace}-iu-lb-enter-active,
.${namespace}-iu-lb-leave-active { transition: opacity 0.15s ease; }
.${namespace}-iu-lb-enter-from,
.${namespace}-iu-lb-leave-to { opacity: 0; }
.${namespace}-iu-lb-enter-active .${namespace}-iu__lightbox-body {
  transition: transform 0.15s ease;
}
.${namespace}-iu-lb-enter-from .${namespace}-iu__lightbox-body {
  transform: scale(0.96);
}
</style>