<template>
  <div
    class="${namespace}-iu"
    :class="{ '${namespace}-iu--disabled': disabled }"
    @dragover.prevent="onDragOver"
    @dragleave.prevent="onDragLeave"
    @drop.prevent="onDrop"
  >
    <label v-if="label" class="${namespace}-field-label">{{ label }}</label>

    <!-- ── 缩略图网格 ──────────────────────────── -->
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
        <div v-else class="${namespace}-iu__thumb ${namespace}-iu__thumb--empty">🖼</div>

        <!-- 悬停操作栏 -->
        <div v-if="!disabled && !item.uploading" class="${namespace}-iu__actions">
          <span class="${namespace}-iu__actions-preview" @click="previewItem(idx)" title="预览">🔍</span>
          <span class="${namespace}-iu__actions-del" @click="removeItem(idx)" title="删除">✕</span>
        </div>

        <!-- 上传进度条 -->
        <div v-if="item.uploading" class="${namespace}-iu__progress-bar">
          <div class="${namespace}-iu__progress-fill" :style="{ width: item.progress + '%' }"></div>
        </div>

        <!-- 完成闪烁 -->
        <div v-if="item.justDone" class="${namespace}-iu__done-flash"></div>

        <!-- 错误标记 -->
        <span v-if="item.error" class="${namespace}-iu__error-mark" title="上传失败">!</span>
      </div>

      <!-- 添加按钮 -->
      <div
        v-if="items.length < maxCount && !disabled"
        class="${namespace}-iu__cell ${namespace}-iu__cell--add"
        :class="{ '${namespace}-iu__cell--dragover': dragging }"
        @click="triggerInput"
      >
        <span class="${namespace}-iu__add-icon">+</span>
        <span class="${namespace}-iu__add-text">{{ items.length === 0 ? placeholder : (items.length + '/' + maxCount) }}</span>
      </div>
    </div>

    <div v-if="hint" class="${namespace}-iu__hint">{{ hint }}</div>

    <input ref="inputRef" type="file" class="${namespace}-iu__input" :accept="accept"
           :multiple="maxCount > 1" @change="onFileChange" />

    <!-- ── 预览灯箱 (匹配 ${namespace}-dialog 风格) ──────────── -->
    <Teleport to="body">
      <Transition name="${namespace}-iu-lb">
        <div v-if="previewVisible" class="${namespace}-iu__lightbox" @click="closePreview">
          <!-- 遮罩 -->
          <div class="${namespace}-iu__lightbox-mask"></div>
          <!-- 内容 -->
          <div class="${namespace}-iu__lightbox-body" @click.stop>
            <div class="${namespace}-iu__lightbox-head">
              <span class="${namespace}-iu__lightbox-title">图片预览</span>
              <button class="${namespace}-iu__lightbox-close" @click="closePreview">✕</button>
            </div>
            <div class="${namespace}-iu__lightbox-main">
              <button
                v-if="items.length > 1"
                class="${namespace}-iu__lightbox-nav ${namespace}-iu__lightbox-nav--prev"
                :disabled="previewIndex <= 0"
                @click="previewPrev"
              >‹</button>
              <img
                :src="items[previewIndex]?.previewUrl"
                class="${namespace}-iu__lightbox-img"
                alt="预览"
              />
              <button
                v-if="items.length > 1"
                class="${namespace}-iu__lightbox-nav ${namespace}-iu__lightbox-nav--next"
                :disabled="previewIndex >= items.length - 1"
                @click="previewNext"
              >›</button>
            </div>
            <div class="${namespace}-iu__lightbox-foot">
              <span v-if="items.length > 1">{{ previewIndex + 1 }} / {{ items.length }}</span>
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
  modelValue:  { type: Array, default: () => [] },
  key:         { type: String, default: 'id' },
  url:         { type: String, default: 'url' },
  thumbnail:   { type: String, default: 'thumbnailUrl' },
  label:       { type: String, default: '' },
  placeholder: { type: String, default: '上传图片' },
  hint:        { type: String, default: '' },
  maxCount:    { type: Number, default: 9 },
  maxSizeMB:   { type: Number, default: 10 },
  accept:      { type: String, default: 'image/png, image/jpeg, image/webp, image/gif' },
  disabled:    { type: Boolean, default: false },
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
    if (!file.type.startsWith('image/')) { emit('error', file.name + ' 不是图片文件'); continue }
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
        item.progress = 100; item.justDone = true; item.url = result.url || item.previewUrl
        setTimeout(() => { item.justDone = false; item.uploading = false }, 350)
        emit('upload', { file, ...result, index: idx })
      } catch (err) {
        item.error = true; item.uploading = false
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
    const dur = 1000 + Math.random() * 1500
    const iv = setInterval(() => {
      elapsed += 60
      const r = elapsed / dur
      item.progress = Math.min(99, Math.round((1/(1+Math.exp(-10*(r-0.4))) + (Math.random()-0.5)*0.05)*100))
      if (r >= 1) {
        item.progress = 100; clearInterval(iv); item.justDone = true
        setTimeout(() => { item.url = item.previewUrl; item.justDone = false; resolve() }, 300)
      }
    }, 60)
  })
}

function removeItem(idx) { items.value.splice(idx, 1); syncModel(); emit('remove', { index: idx }) }

function previewItem(idx) {
  if (!items.value[idx]?.previewUrl || items.value[idx]?.uploading) return
  previewIndex.value = idx; previewVisible.value = true
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
   IMAGE UPLOAD — BNR Enterprise Style
   ══════════════════════════════════════════════ */

.${namespace}-iu { display: flex; flex-direction: column; gap: var(--${namespace}-sp-xs); }
.${namespace}-iu--disabled { opacity: 0.45; pointer-events: none; }

/* ── Label 顶部对齐与留白 ────────────────────── */
.${namespace}-field-label {
  align-self: flex-start;
  padding-top: 2px;
  padding-bottom: 2px;
  line-height: 1.2;
}

/* ── 缩略图网格（保持 4 列横排，限宽控制大小） ── */
.${namespace}-iu__grid {
  display: grid;
  grid-template-columns: repeat(4, 1fr);
  gap: 4px;
  max-width: 280px; /* 控制整体宽度，保证 4 格横向排列且每格尺寸更小 */
  width: 100%;
}

.${namespace}-iu__cell {
  position: relative;
  aspect-ratio: 1 / 1;
  border: 1px solid var(--${namespace}-border);
  background: var(--${namespace}-bg-page);
  overflow: hidden;
  transition: border-color 0.15s;
}
.${namespace}-iu__cell:hover { border-color: var(--${namespace}-primary); }
.${namespace}-iu__cell--error { border-color: var(--${namespace}-danger) !important; }

.${namespace}-iu__thumb {
  width: 100%; height: 100%;
  object-fit: cover;
  display: block;
  cursor: pointer;
}
.${namespace}-iu__thumb--empty {
  display: flex; align-items: center; justify-content: center;
  font-size: 20px; opacity: 0.2; cursor: default;
}

/* ── 悬停操作栏 ──────────────────────────────── */
.${namespace}-iu__actions {
  position: absolute; top: 0; right: 0;
  display: flex;
  opacity: 0; transition: opacity 0.15s;
}
.${namespace}-iu__cell:hover .${namespace}-iu__actions { opacity: 1; }

.${namespace}-iu__actions-preview,
.${namespace}-iu__actions-del {
  width: 20px; height: 18px;
  display: flex; align-items: center; justify-content: center;
  cursor: pointer; font-size: 10px;
  background: rgba(28,40,51,0.6); color: #fff;
  transition: background 0.12s;
}
.${namespace}-iu__actions-preview:hover { background: var(--${namespace}-primary); }
.${namespace}-iu__actions-del:hover { background: var(--${namespace}-danger); }

/* ── 进度条 ─────────────────────────────────── */
.${namespace}-iu__progress-bar {
  position: absolute; bottom: 0; left: 0; right: 0; height: 2px;
  background: var(--${namespace}-border-light);
}
.${namespace}-iu__progress-fill {
  height: 100%; background: var(--${namespace}-primary);
  transition: width 0.1s linear;
}

/* ── 完成闪烁 ───────────────────────────────── */
.${namespace}-iu__done-flash {
  position: absolute; inset: 0;
  border: 2px solid var(--${namespace}-success);
  animation: iu-flash 0.35s ease-out forwards;
  pointer-events: none;
}
@keyframes iu-flash {
  0%   { opacity: 1; }
  100% { opacity: 0; }
}

/* ── 错误标记 ───────────────────────────────── */
.${namespace}-iu__error-mark {
  position: absolute; top: 1px; left: 2px;
  width: 14px; height: 14px; line-height: 14px; text-align: center;
  background: var(--${namespace}-danger); color: #fff;
  font-size: 9px; font-weight: bold;
}

/* ── 添加格 ─────────────────────────────────── */
.${namespace}-iu__cell--add {
  border: 1px dashed var(--${namespace}-border);
  display: flex; flex-direction: column; align-items: center; justify-content: center;
  gap: 1px; cursor: pointer;
  transition: border-color 0.15s, background 0.15s;
}
.${namespace}-iu__cell--add:hover,
.${namespace}-iu__cell--dragover {
  border-color: var(--${namespace}-primary);
  background: var(--${namespace}-primary-bg);
}
.${namespace}-iu__add-icon {
  font-size: 18px; color: var(--${namespace}-text-light); font-weight: 300; line-height: 1;
}
.${namespace}-iu__cell--add:hover .${namespace}-iu__add-icon,
.${namespace}-iu__cell--dragover .${namespace}-iu__add-icon { color: var(--${namespace}-primary); }
.${namespace}-iu__add-text {
  font-size: 9px; color: var(--${namespace}-text-light);
  transform: scale(0.9);
}

.${namespace}-iu__hint { font-size: 10px; color: var(--${namespace}-text-light); }
.${namespace}-iu__input { position: absolute; width: 0; height: 0; opacity: 0; pointer-events: none; }

/* ══════════════════════════════════════════════
   预览灯箱 — 匹配 ${namespace}-dialog 风格
   ══════════════════════════════════════════════ */
.${namespace}-iu__lightbox {
  position: fixed; inset: 0; z-index: 1100;
  display: flex; align-items: center; justify-content: center;
}
.${namespace}-iu__lightbox-mask {
  position: absolute; inset: 0;
  background: rgba(0,0,0,0.5);
}
.${namespace}-iu__lightbox-body {
  position: relative;
  width: 80vw; max-width: 580px;
  max-height: 80vh;
  background: var(--${namespace}-bg);
  border-radius: var(--${namespace}-radius-md);
  box-shadow: 0 8px 32px rgba(0,0,0,0.25);
  display: flex; flex-direction: column;
  z-index: 1;
}

/* 灯箱头部 — 匹配 ${namespace}-dialog-header */
.${namespace}-iu__lightbox-head {
  display: flex; align-items: center; justify-content: space-between;
  padding: 8px 12px; flex-shrink: 0;
  border-bottom: 2px solid var(--${namespace}-primary);
}
.${namespace}-iu__lightbox-title {
  font-size: 13px; font-weight: bold; color: var(--${namespace}-primary);
}
.${namespace}-iu__lightbox-close {
  width: 24px; height: 24px; border: none; background: none;
  cursor: pointer; font-size: 13px; color: var(--${namespace}-text-light);
  display: flex; align-items: center; justify-content: center;
  border-radius: var(--${namespace}-radius-sm); transition: color 0.12s, background 0.12s;
}
.${namespace}-iu__lightbox-close:hover { color: var(--${namespace}-text); background: var(--${namespace}-bg-page); }

/* 灯箱主体 */
.${namespace}-iu__lightbox-main {
  flex: 1; overflow: hidden;
  display: flex; align-items: center; justify-content: center;
  padding: 12px; position: relative;
  min-height: 180px;
  background: var(--${namespace}-bg-page);
}
.${namespace}-iu__lightbox-img {
  max-width: 100%; max-height: 50vh;
  object-fit: contain;
  user-select: none;
}

/* 导航按钮 */
.${namespace}-iu__lightbox-nav {
  position: absolute; top: 50%; transform: translateY(-50%);
  width: 28px; height: 42px;
  border: 1px solid var(--${namespace}-border); background: var(--${namespace}-bg);
  color: var(--${namespace}-text); font-size: 20px; cursor: pointer;
  display: flex; align-items: center; justify-content: center;
  transition: background 0.12s, color 0.12s;
  font-family: var(--${namespace}-font);
}
.${namespace}-iu__lightbox-nav:hover:not(:disabled) {
  background: var(--${namespace}-primary-bg); color: var(--${namespace}-primary);
}
.${namespace}-iu__lightbox-nav:disabled { opacity: 0.25; cursor: not-allowed; }
.${namespace}-iu__lightbox-nav--prev { left: 8px; }
.${namespace}-iu__lightbox-nav--next { right: 8px; }

/* 灯箱底部 */
.${namespace}-iu__lightbox-foot {
  padding: 5px 12px; border-top: 1px solid var(--${namespace}-border-light);
  text-align: center; font-size: 11px; color: var(--${namespace}-text-muted);
}

/* 灯箱过渡 */
.${namespace}-iu-lb-enter-active,
.${namespace}-iu-lb-leave-active { transition: opacity 0.2s ease; }
.${namespace}-iu-lb-enter-from,
.${namespace}-iu-lb-leave-to { opacity: 0; }
.${namespace}-iu-lb-enter-active .${namespace}-iu__lightbox-body {
  transition: transform 0.2s ease, opacity 0.2s ease;
}
.${namespace}-iu-lb-enter-from .${namespace}-iu__lightbox-body {
  transform: scale(0.95); opacity: 0;
}
</style>