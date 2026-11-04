<template>
  <div class="${namespace}-pagination">
    <!-- 左侧信息区：等宽大写字、加粗高亮 -->
    <div class="${namespace}-pg-info">
      TOTAL: <b>{{ total }}</b>
      <span class="${namespace}-pg-sep">/</span>
      PER_PAGE:
      <div class="${namespace}-pg-select-wrap">
        <select class="${namespace}-pg-size" :value="innerSize" @change="onSizeChange">
          <option v-for="s in pageSizes" :key="s" :value="s">{{ s }}</option>
        </select>
        <span class="${namespace}-pg-arrow">▾</span>
      </div>
      <span class="${namespace}-pg-sep">/</span>
      PAGE: <b>{{ innerPage }}</b> OF <b>{{ totalPages }}</b>
    </div>

    <!-- 右侧控制区：直角微型方块按钮组 -->
    <div class="${namespace}-pg-controls">
      <button
        type="button"
        class="${namespace}-pg-btn"
        :disabled="innerPage <= 1"
        title="FIRST"
        @click="goToPage(1)"
      >&laquo;</button>
      <button
        type="button"
        class="${namespace}-pg-btn"
        :disabled="innerPage <= 1"
        title="PREV"
        @click="goToPage(innerPage - 1)"
      >&lsaquo;</button>

      <template v-for="p in pages" :key="p">
        <span v-if="p === '...'" class="${namespace}-pg-ellipsis">&hellip;</span>
        <button
          v-else
          type="button"
          class="${namespace}-pg-btn"
          :class="{ '${namespace}-on': p === innerPage }"
          @click="goToPage(p)"
        >
          {{ p }}
        </button>
      </template>

      <button
        type="button"
        class="${namespace}-pg-btn"
        :disabled="innerPage >= totalPages"
        title="NEXT"
        @click="goToPage(innerPage + 1)"
      >&rsaquo;</button>
      <button
        type="button"
        class="${namespace}-pg-btn"
        :disabled="innerPage >= totalPages"
        title="LAST"
        @click="goToPage(totalPages)"
      >&raquo;</button>
    </div>
  </div>
</template>

<script setup>
import { ref, computed, watch } from 'vue'

const props = defineProps({
  total:       { type: Number, default: 0 },
  currentPage: { type: Number, default: 1 },
  pageSize:    { type: Number, default: 20 },
  pageSizes:   { type: Array,  default: () => [20, 50, 100] },
})

const emit = defineEmits(['update:currentPage', 'update:pageSize', 'change'])

const innerPage = ref(props.currentPage)
const innerSize = ref(props.pageSize)

watch(() => props.currentPage, (v) => { innerPage.value = v })
watch(() => props.pageSize,    (v) => { innerSize.value = v })

const totalPages = computed(() => Math.max(1, Math.ceil(props.total / innerSize.value)))

const pages = computed(() => {
  const tp = totalPages.value
  const cp = innerPage.value
  if (tp <= 7) return Array.from({ length: tp }, (_, i) => i + 1)
  const r = [1, 2]
  if (cp > 4) r.push('...')
  for (let i = Math.max(3, cp - 1); i <= Math.min(tp - 2, cp + 1); i++) r.push(i)
  if (cp < tp - 3) r.push('...')
  r.push(tp - 1, tp)
  return r
})

watch([() => props.total, innerSize], () => {
  if (innerPage.value > totalPages.value) {
    innerPage.value = totalPages.value
    emit('update:currentPage', totalPages.value)
    emit('change', { currentPage: totalPages.value, pageSize: innerSize.value })
  }
})

function goToPage(p) {
  if (p < 1 || p > totalPages.value || p === innerPage.value) return
  innerPage.value = p
  emit('update:currentPage', p)
  emit('change', { currentPage: p, pageSize: innerSize.value })
}

function onSizeChange(e) {
  const s = parseInt(e.target.value, 10)
  if (s === innerSize.value) return
  innerSize.value = s
  innerPage.value = 1
  emit('update:pageSize', s)
  emit('update:currentPage', 1)
  emit('change', { currentPage: 1, pageSize: s })
}
</script>

<style scoped>
/* ══════════════════════════════════════════════
   Protocol Explorer Pagination 蓝图工程规范
   ══════════════════════════════════════════════ */
.${namespace}-pagination {
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: 8px 14px;
  background: var(--${namespace}-bg, #f4f6fb);
  border-top: 1px solid var(--${namespace}-ln, #d3dbef);
  font-family: var(--${namespace}-f, "IBM Plex Mono", monospace);
  font-size: 12px;
  color: var(--${namespace}-ink, #0a2a9a);
  flex-shrink: 0;
  user-select: none;
}

/* 左侧信息栏 */
.${namespace}-pg-info {
  display: flex;
  align-items: center;
  gap: 8px;
  font-size: 11px;
  font-weight: 600;
  letter-spacing: .06em;
  color: var(--${namespace}-ink, #0a2a9a);
}
.${namespace}-pg-info b {
  font-weight: 800;
  color: var(--${namespace}-pri, #0a2fb5);
}
.${namespace}-pg-sep {
  color: var(--${namespace}-ln, #d3dbef);
  font-weight: normal;
}

/* 下拉尺寸包装器 */
.${namespace}-pg-select-wrap {
  position: relative;
  display: inline-flex;
  align-items: center;
}
.${namespace}-pg-size {
  height: 26px;
  border: 1px solid var(--${namespace}-ln, #d3dbef);
  border-radius: 0;
  padding: 0 20px 0 6px;
  background: var(--${namespace}-pn, #ffffff);
  color: var(--${namespace}-ink, #0a2a9a);
  font: inherit;
  font-size: 11px;
  font-weight: 700;
  outline: none;
  cursor: pointer;
  appearance: none;
  transition: .15s;
}
.${namespace}-pg-size:focus {
  border-color: var(--${namespace}-pri, #0a2fb5);
  box-shadow: 2px 2px 0 color-mix(in srgb, var(--${namespace}-pri, #0a2fb5) 30%, transparent);
}
.${namespace}-pg-arrow {
  position: absolute;
  right: 6px;
  pointer-events: none;
  font-size: 10px;
  color: var(--${namespace}-mu, #6f7fb4);
}

/* 右侧控制栏 */
.${namespace}-pg-controls {
  display: flex;
  align-items: center;
  gap: 4px;
}

/* 翻页按钮：直角、实体硬阴影、微位移悬停 */
.${namespace}-pg-btn {
  height: 26px;
  min-width: 26px;
  padding: 0 6px;
  background: var(--${namespace}-pn, #ffffff);
  border: 1px solid var(--${namespace}-ink, #0a2a9a);
  border-radius: 0;
  color: var(--${namespace}-ink, #0a2a9a);
  cursor: pointer;
  display: flex;
  align-items: center;
  justify-content: center;
  font: inherit;
  font-size: 11px;
  font-weight: 700;
  transition: .12s;
  box-sizing: border-box;
}

.${namespace}-pg-btn:hover:not(:disabled) {
  transform: translate(-1px, -1px);
  box-shadow: 2px 2px 0 var(--${namespace}-ink, #0a2a9a);
}

.${namespace}-pg-btn:active:not(:disabled) {
  transform: translate(1px, 1px);
  box-shadow: none;
}

/* 激活选中的页码 */
.${namespace}-pg-btn.${namespace}-on {
  background: var(--${namespace}-pri, #0a2fb5);
  color: var(--${namespace}-on, #ffffff);
  border-color: var(--${namespace}-pri, #0a2fb5);
}
.${namespace}-pg-btn.${namespace}-on:hover {
  box-shadow: 2px 2px 0 color-mix(in srgb, var(--${namespace}-pri, #0a2fb5) 45%, transparent);
}

/* 禁用态 */
.${namespace}-pg-btn:disabled {
  opacity: .35;
  cursor: not-allowed;
  transform: none;
  box-shadow: none;
  border-color: var(--${namespace}-ln, #d3dbef);
}

/* 省略号 */
.${namespace}-pg-ellipsis {
  font-size: 12px;
  font-weight: 700;
  color: var(--${namespace}-mu, #6f7fb4);
  padding: 0 3px;
  letter-spacing: .1em;
}
</style>