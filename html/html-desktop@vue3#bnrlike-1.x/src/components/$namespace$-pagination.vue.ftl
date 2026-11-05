<template>
  <div class="${namespace}-pagination">
    <div class="${namespace}-pg-info">
      共 <b>{{ total }}</b> 条，每页
      <select class="${namespace}-pg-size" :value="innerSize" @change="onSizeChange">
        <option v-for="s in pageSizes" :key="s" :value="s">{{ s }}</option>
      </select>
      条，当前 <b>{{ innerPage }}</b> / <b>{{ totalPages }}</b> 页
    </div>
    <div class="${namespace}-pg-controls">
      <button class="${namespace}-pg-btn" :disabled="innerPage <= 1" @click="goToPage(1)">&laquo;</button>
      <button class="${namespace}-pg-btn" :disabled="innerPage <= 1" @click="goToPage(innerPage - 1)">&lsaquo;</button>
      <template v-for="p in pages" :key="p">
        <span v-if="p === '...'" class="${namespace}-pg-ellipsis">&hellip;</span>
        <button v-else class="${namespace}-pg-btn" :class="{ '${namespace}-on': p === innerPage }" @click="goToPage(p)">{{ p }}</button>
      </template>
      <button class="${namespace}-pg-btn" :disabled="innerPage >= totalPages" @click="goToPage(innerPage + 1)">&rsaquo;</button>
      <button class="${namespace}-pg-btn" :disabled="innerPage >= totalPages" @click="goToPage(totalPages)">&raquo;</button>
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
.${namespace}-pagination {
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: 8px 14px;
  background: var(--${namespace}-bg);
  border-top: 1px solid var(--${namespace}-border);
  font-size: 12px;
  color: var(--${namespace}-text);
  flex-shrink: 0;
}

.${namespace}-pg-info {
  display: flex;
  align-items: center;
  gap: 5px;
  color: var(--${namespace}-text-muted);
}

.${namespace}-pg-size {
  height: 24px;
  border: 1px solid var(--${namespace}-border);
  padding: 0 4px;
  border-radius: 2px;
  outline: none;
  font-size: 12px;
}

.${namespace}-pg-controls {
  display: flex;
  align-items: center;
  gap: 4px;
}

.${namespace}-pg-btn {
  height: 24px;
  min-width: 24px;
  padding: 0 6px;
  background: var(--${namespace}-bg);
  border: 1px solid var(--${namespace}-border);
  color: var(--${namespace}-text);
  border-radius: 2px;
  cursor: pointer;
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 12px;
  font-family: inherit;
}

.${namespace}-pg-btn:hover:not(:disabled) {
  border-color: var(--${namespace}-primary);
  color: var(--${namespace}-primary);
}

.${namespace}-pg-btn.${namespace}-on {
  background: var(--${namespace}-primary);
  color: var(--${namespace}-bg);
  border-color: var(--${namespace}-primary);
  font-weight: bold;
}

.${namespace}-pg-btn:disabled {
  opacity: 0.4;
  cursor: not-allowed;
  background: var(--${namespace}-bg-page);
}

.${namespace}-pg-ellipsis {
  font-size: 12px;
  color: var(--${namespace}-text-light);
  padding: 0 2px;
}
</style>
