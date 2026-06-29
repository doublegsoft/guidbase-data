<template>
  <div
    class="ef-iu"
    :class="{ 'ef-iu--disabled': disabled }"
    @dragover.prevent="onDragOver"
    @dragleave.prevent="onDragLeave"
    @drop.prevent="onDrop"
  >
    <label v-if="label" class="ef-field-label">{{ label }}</label>

    <!-- ── 缩略图网格 ──────────────────────────── -->
    <div class="ef-iu__grid">
      <div
        v-for="(item, idx) in items" :key="item.id"
        class="ef-iu__cell"
        :class="{
          'ef-iu__cell--uploading': item.uploading,
          'ef-iu__cell--error': item.error,
        }"
      >
        <!-- 缩略图 -->
        <img
          v-if="item.previewUrl"
          :src="item.previewUrl"
          class="ef-iu__thumb"
          alt=""
          @click="previewItem(idx)"
        />
        <div v-else class="ef-iu__thumb ef-iu__thumb--empty">🖼</div>

        <!-- 悬停操作栏 -->
        <div v-if="!disabled && !item.uploading" class="ef-iu__actions">
          <span class="ef-iu__actions-preview" @click="previewItem(idx)" title="预览">🔍</span>
          <span class="ef-iu__actions-del" @click="removeItem(idx)" title="删除">✕</span>
        </div>

        <!-- 上传进度条 -->
        <div v-if="item.uploading" class="ef-iu__progress-bar">
          <div class="ef-iu__progress-fill" :style="{ width: item.progress + '%' }"></div>
        </div>

        <!-- 完成闪烁 -->
        <div v-if="item.justDone" class="ef-iu__done-flash"></div>

        <!-- 错误标记 -->
        <span v-if="item.error" class="ef-iu__error-mark" title="上传失败">!</span>
      </div>

      <!-- 添加按钮 -->
      <div
        v-if="items.length < maxCount && !disabled"
        class="ef-iu__cell ef-iu__cell--add"
        :class="{ 'ef-iu__cell--dragover': dragging }"
        @click="triggerInput"
      >
        <span class="ef-iu__add-icon">+</span>
        <span class="ef-iu__add-text">{{ items.length === 0 ? placeholder : (items.length + '/' + maxCount) }}</span>
      </div>
    </div>

    <div v-if="hint" class="ef-iu__hint">{{ hint }}</div>

    <input ref="inputRef" type="file" class="ef-iu__input" :accept="accept"
           :multiple="maxCount > 1" @change="onFileChange" />

    <!-- ── 预览灯箱 (匹配 ef-dialog 风格) ──────────── -->
    <Teleport to="body">
      <Transition name="ef-iu-lb">
        <div v-if="previewVisible" class="ef-iu__lightbox" @click="closePreview">
          <!-- 遮罩 -->
          <div class="ef-iu__lightbox-mask"></div>
          <!-- 内容 -->
          <div class="ef-iu__lightbox-body" @click.stop>
            <div class="ef-iu__lightbox-head">
              <span class="ef-iu__lightbox-title">图片预览</span>
              <button class="ef-iu__lightbox-close" @click="closePreview">✕</button>
            </div>
            <div class="ef-iu__lightbox-main">
              <button
                v-if="items.length > 1"
                class="ef-iu__lightbox-nav ef-iu__lightbox-nav--prev"
                :disabled="previewIndex <= 0"
                @click="previewPrev"
              >‹</button>
              <img
                :src="items[previewIndex]?.previewUrl"
                class="ef-iu__lightbox-img"
                alt="预览"
              />
              <button
                v-if="items.length > 1"
                class="ef-iu__lightbox-nav ef-iu__lightbox-nav--next"
                :disabled="previewIndex >= items.length - 1"
                @click="previewNext"
              >›</button>
            </div>
            <div class="ef-iu__lightbox-foot">
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
function genId() { return ${r"`img_${Date.now()}_${nextId++}`"} }

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
  if (remaining <= 0) { emit('error', ${r"`最多上传 ${props.maxCount} 张图片`"}); return }
  for (const file of files.slice(0, remaining)) {
    if (!file.type.startsWith('image/')) { emit('error', ${r"`${file.name} 不是图片文件`"}); continue }
    if (file.size > props.maxSizeMB * 1024 * 1024) { emit('error', ${r"`${file.name} 超过 ${props.maxSizeMB}MB 限制`"}); continue }
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

.ef-iu { display: flex; flex-direction: column; gap: var(--ef-sp-xs); }
.ef-iu--disabled { opacity: 0.45; pointer-events: none; }

/* ── 缩略图网格 ─────────────────────────────── */
.ef-iu__grid {
  display: grid;
  grid-template-columns: repeat(4, 1fr);
  gap: 4px;
}

.ef-iu__cell {
  position: relative;
  aspect-ratio: 1 / 1;
  border: 1px solid var(--ef-border);
  background: var(--ef-bg-page);
  overflow: hidden;
  transition: border-color 0.15s;
}
.ef-iu__cell:hover { border-color: var(--ef-primary); }
.ef-iu__cell--error { border-color: var(--ef-danger) !important; }

.ef-iu__thumb {
  width: 100%; height: 100%;
  object-fit: cover;
  display: block;
  cursor: pointer;
}
.ef-iu__thumb--empty {
  display: flex; align-items: center; justify-content: center;
  font-size: 24px; opacity: 0.2; cursor: default;
}

/* ── 悬停操作栏 ──────────────────────────────── */
.ef-iu__actions {
  position: absolute; top: 0; right: 0;
  display: flex;
  opacity: 0; transition: opacity 0.15s;
}
.ef-iu__cell:hover .ef-iu__actions { opacity: 1; }

.ef-iu__actions-preview,
.ef-iu__actions-del {
  width: 22px; height: 20px;
  display: flex; align-items: center; justify-content: center;
  cursor: pointer; font-size: 11px;
  background: rgba(28,40,51,0.55); color: #fff;
  transition: background 0.12s;
}
.ef-iu__actions-preview:hover { background: var(--ef-primary); }
.ef-iu__actions-del:hover { background: var(--ef-danger); }

/* ── 进度条 ─────────────────────────────────── */
.ef-iu__progress-bar {
  position: absolute; bottom: 0; left: 0; right: 0; height: 2px;
  background: var(--ef-border-light);
}
.ef-iu__progress-fill {
  height: 100%; background: var(--ef-primary);
  transition: width 0.1s linear;
}

/* ── 完成闪烁 ───────────────────────────────── */
.ef-iu__done-flash {
  position: absolute; inset: 0;
  border: 2px solid var(--ef-success);
  animation: iu-flash 0.35s ease-out forwards;
  pointer-events: none;
}
@keyframes iu-flash {
  0%   { opacity: 1; }
  100% { opacity: 0; }
}

/* ── 错误标记 ───────────────────────────────── */
.ef-iu__error-mark {
  position: absolute; top: 1px; left: 3px;
  width: 16px; height: 16px; line-height: 16px; text-align: center;
  background: var(--ef-danger); color: #fff;
  font-size: 10px; font-weight: bold;
}

/* ── 添加格 ─────────────────────────────────── */
.ef-iu__cell--add {
  border: 1px dashed var(--ef-border);
  display: flex; flex-direction: column; align-items: center; justify-content: center;
  gap: 2px; cursor: pointer;
  transition: border-color 0.15s, background 0.15s;
}
.ef-iu__cell--add:hover,
.ef-iu__cell--dragover {
  border-color: var(--ef-primary);
  background: var(--ef-primary-bg);
}
.ef-iu__add-icon {
  font-size: 22px; color: var(--ef-text-light); font-weight: 300; line-height: 1;
}
.ef-iu__cell--add:hover .ef-iu__add-icon,
.ef-iu__cell--dragover .ef-iu__add-icon { color: var(--ef-primary); }
.ef-iu__add-text {
  font-size: 10px; color: var(--ef-text-light);
}

.ef-iu__hint { font-size: 10px; color: var(--ef-text-light); }
.ef-iu__input { position: absolute; width: 0; height: 0; opacity: 0; pointer-events: none; }

/* ══════════════════════════════════════════════
   预览灯箱 — 匹配 ef-dialog 风格
   ══════════════════════════════════════════════ */
.ef-iu__lightbox {
  position: fixed; inset: 0; z-index: 1100;
  display: flex; align-items: center; justify-content: center;
}
.ef-iu__lightbox-mask {
  position: absolute; inset: 0;
  background: rgba(0,0,0,0.5);
}
.ef-iu__lightbox-body {
  position: relative;
  width: 90vw; max-width: 960px;
  max-height: 90vh;
  background: var(--ef-bg);
  border-radius: var(--ef-radius-md);
  box-shadow: 0 8px 32px rgba(0,0,0,0.25);
  display: flex; flex-direction: column;
  z-index: 1;
}

/* 灯箱头部 — 匹配 ef-dialog-header */
.ef-iu__lightbox-head {
  display: flex; align-items: center; justify-content: space-between;
  padding: 10px 14px; flex-shrink: 0;
  border-bottom: 2px solid var(--ef-primary);
}
.ef-iu__lightbox-title {
  font-size: 14px; font-weight: bold; color: var(--ef-primary);
}
.ef-iu__lightbox-close {
  width: 26px; height: 26px; border: none; background: none;
  cursor: pointer; font-size: 14px; color: var(--ef-text-light);
  display: flex; align-items: center; justify-content: center;
  border-radius: var(--ef-radius-sm); transition: color 0.12s, background 0.12s;
}
.ef-iu__lightbox-close:hover { color: var(--ef-text); background: var(--ef-bg-page); }

/* 灯箱主体 */
.ef-iu__lightbox-main {
  flex: 1; overflow: hidden;
  display: flex; align-items: center; justify-content: center;
  padding: 10px; position: relative;
  min-height: 200px;
  background: var(--ef-bg-page);
}
.ef-iu__lightbox-img {
  max-width: 100%; max-height: 65vh;
  object-fit: contain;
  user-select: none;
}

/* 导航按钮 */
.ef-iu__lightbox-nav {
  position: absolute; top: 50%; transform: translateY(-50%);
  width: 32px; height: 48px;
  border: 1px solid var(--ef-border); background: var(--ef-bg);
  color: var(--ef-text); font-size: 22px; cursor: pointer;
  display: flex; align-items: center; justify-content: center;
  transition: background 0.12s, color 0.12s;
  font-family: var(--ef-font);
}
.ef-iu__lightbox-nav:hover:not(:disabled) {
  background: var(--ef-primary-bg); color: var(--ef-primary);
}
.ef-iu__lightbox-nav:disabled { opacity: 0.25; cursor: not-allowed; }
.ef-iu__lightbox-nav--prev { left: 8px; }
.ef-iu__lightbox-nav--next { right: 8px; }

/* 灯箱底部 */
.ef-iu__lightbox-foot {
  padding: 6px 14px; border-top: 1px solid var(--ef-border-light);
  text-align: center; font-size: 11px; color: var(--ef-text-muted);
}

/* 灯箱过渡 */
.ef-iu-lb-enter-active,
.ef-iu-lb-leave-active { transition: opacity 0.2s ease; }
.ef-iu-lb-enter-from,
.ef-iu-lb-leave-to { opacity: 0; }
.ef-iu-lb-enter-active .ef-iu__lightbox-body {
  transition: transform 0.2s ease, opacity 0.2s ease;
}
.ef-iu-lb-enter-from .ef-iu__lightbox-body {
  transform: scale(0.95); opacity: 0;
}
</style>
