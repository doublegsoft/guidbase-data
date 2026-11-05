<template>
  <div class="${namespace}-page-grid">
    <div class="${namespace}-grid-area">
      <!-- 加载遮罩 -->
      <div v-if="loading" class="${namespace}-page-grid__loading-mask">
        <span class="${namespace}-page-grid__loading-text">加载中...</span>
      </div>

      <!-- 空数据 -->
      <div v-if="!loading && pageData.length === 0" class="${namespace}-grid-empty">
        <span>暂无数据</span>
      </div>

      <!-- 卡片网格 -->
      <div class="${namespace}-grid-container" ref="scrollContainer">
        <div class="${namespace}-grid-list"
          :style="{ gridTemplateColumns: ${r"`repeat(auto-fill, minmax(${cardMinWidth}px, 1fr))`"} }">
          <div
            v-for="(row, rowIndex) in pageData"
            :key="String(row[idKey])"
            class="${namespace}-grid-card"
            :class="cardClass(row)"
            @click="onCardClick($event, row, rowIndex)"
          >
            <!-- scoped slot：父组件自定义每个卡片的展示 -->
            <slot name="default" :row="row" :index="rowIndex" />
          </div>
        </div>
      </div>

      <${namespace}-pagination
        :total="paginationTotal"
        v-model:current-page="currentPage"
        v-model:page-size="pageSize"
        :page-sizes="[12, 24, 48, 96]"
        @change="onPageChange"
      />
    </div>
  </div>
</template>

<script setup>
import { ref, computed, watch, onMounted } from 'vue'
import ${js.nameType(namespace)}Pagination from './${namespace}-pagination.vue'

const props = defineProps({
  data:          { type: Array,    default: () => [] },
  currentPage:   { type: Number,   default: 1 },
  pageSize:      { type: Number,   default: 12 },
  idKey:         { type: String,   default: 'id' },
  cardMinWidth:  { type: Number,   default: 220 },
  cardClassName: { type: Function, default: null },
  // 远端数据获取
  fetchData:     { type: Function, default: null },
  fetchParams:   { type: Object,   default: () => ({}) },
  // 操作按钮回调 { handlerName: (row, index) => void }
  // 当卡片内容通过 v-html 渲染时（非 slot），用于委托 @click 事件
  rowAction:     { type: Object,   default: null },
})

const emit = defineEmits(['update:currentPage', 'update:pageSize', 'card-click', 'row-action'])

const currentPage = ref(props.currentPage)
const pageSize = ref(props.pageSize)
const scrollContainer = ref(null)

watch(() => props.currentPage, (v) => { currentPage.value = v })
watch(() => props.pageSize,    (v) => { pageSize.value = v })

// ── 远端数据模式 ──
const isServerMode = computed(() => typeof props.fetchData === 'function')

const internalData = ref([])
const internalTotal = ref(0)
const loading = ref(false)
let reqId = 0

const serverData = computed(() => isServerMode.value ? internalData.value : props.data)

const displayData = computed(() => {
  return isServerMode.value ? serverData.value : props.data
})

const pageData = computed(() => {
  if (isServerMode.value) return serverData.value
  const start = (currentPage.value - 1) * pageSize.value
  return displayData.value.slice(start, start + pageSize.value)
})

const paginationTotal = computed(() => isServerMode.value ? internalTotal.value : displayData.value.length)

// ── 数据加载 ──
async function loadData() {
  if (!isServerMode.value) return
  const id = ++reqId
  loading.value = true
  try {
    const params = { ...props.fetchParams }
    const res = await props.fetchData(params, currentPage.value, pageSize.value)
    if (id !== reqId) return
    if (res) {
      internalData.value = res.data ?? []
      internalTotal.value = res.total ?? (Array.isArray(res.data) ? res.data.length : 0)
    } else {
      internalData.value = []
      internalTotal.value = 0
    }
  } catch (e) {
    if (id !== reqId) return
    console.error('PagedGrid fetchData error:', e)
    internalData.value = []
    internalTotal.value = 0
  } finally {
    if (id === reqId) {
      loading.value = false
    }
  }
}

watch(() => props.fetchParams, () => {
  if (isServerMode.value) {
    currentPage.value = 1
    emit('update:currentPage', 1)
    loadData()
  }
})

watch(() => props.fetchData, () => {
  if (isServerMode.value) loadData()
})

onMounted(() => {
  if (isServerMode.value) loadData()
})

// ── 卡片样式 ──
function cardClass(row) {
  const parts = []
  if (props.cardClassName) parts.push(props.cardClassName(row))
  return parts
}

// ── 事件处理 ──
function onCardClick(e, row, rowIndex) {
  // 操作按钮点击 → 事件委托（兼容 v-html 渲染的按钮）
  const btn = e.target.closest('button, a')
  if (btn) {
    const actionName = btn.getAttribute('@click')
    if (actionName) {
      if (props.rowAction && typeof props.rowAction[actionName] === 'function') {
        props.rowAction[actionName](row, rowIndex)
      }
      emit('row-action', { handler: actionName, row, index: rowIndex })
      return
    }
  }
  emit('card-click', row, rowIndex)
}

function onPageChange({ currentPage: cp, pageSize: ps }) {
  emit('update:currentPage', cp)
  emit('update:pageSize', ps)
  scrollToTop()
  if (isServerMode.value) {
    loadData()
  }
}

function scrollToTop() {
  if (scrollContainer.value) scrollContainer.value.scrollTop = 0
}

function refresh() {
  currentPage.value = 1
  emit('update:currentPage', 1)
  loadData()
}

defineExpose({
  refresh,
  loading,
})
</script>

<style scoped>
/* 核心布局 */
.${namespace}-page-grid {
  flex: 1;
  display: flex;
  overflow: hidden;
  background: var(--${namespace}-bg);
}

.${namespace}-grid-area {
  flex: 1;
  display: flex;
  flex-direction: column;
  overflow: hidden;
  position: relative;
}

/* 加载遮罩 */
.${namespace}-page-grid__loading-mask {
  position: absolute;
  top: 0; left: 0; right: 0; bottom: 0;
  z-index: 20;
  display: flex;
  align-items: center;
  justify-content: center;
  background: rgba(255, 255, 255, 0.6);
}
.${namespace}-page-grid__loading-text {
  padding: 8px 20px;
  background: var(--${namespace}-primary-bg);
  border-radius: 4px;
  font-size: 13px;
  color: var(--${namespace}-primary);
}

/* 空数据 */
.${namespace}-grid-empty {
  flex: 1;
  display: flex;
  align-items: center;
  justify-content: center;
  color: var(--${namespace}-tl);
  font-size: 13px;
}

/* 滚动容器 */
.${namespace}-grid-container {
  flex: 1;
  overflow: auto;
  padding: 12px;
  background: var(--${namespace}-bgp);
}

/* 网格列表 */
.${namespace}-grid-list {
  display: grid;
  gap: 10px;
}

/* 卡片 */
.${namespace}-grid-card {
  background: var(--${namespace}-bg);
  border: 1px solid var(--${namespace}-bd);
  border-radius: var(--${namespace}-radius-md);
  padding: 10px 12px;
  cursor: pointer;
  transition: box-shadow 0.18s, border-color 0.18s;
  min-height: 120px;
}
.${namespace}-grid-card:hover {
  border-color: var(--${namespace}-p);
  box-shadow: 0 2px 8px rgba(26,79,138,0.12);
}

/* 分页穿透 */
.${namespace}-grid-area :deep(.${namespace}-pagination) {
  flex-shrink: 0;
  display: flex;
  align-items: center;
  gap: 4px;
  padding: 8px 14px;
  background: var(--${namespace}-bg);
  border-top: 1px solid var(--${namespace}-bd);
  font-size: 12px;
  color: var(--${namespace}-t);
  z-index: 20;
}
.${namespace}-grid-area :deep(.${namespace}-pg-info) {
  display: flex;
  align-items: center;
  gap: 5px;
  color: var(--${namespace}-tm);
  margin-right: auto;
}
.${namespace}-grid-area :deep(.${namespace}-pg-size) {
  height: 24px;
  border: 1px solid var(--${namespace}-bd);
  padding: 0 4px;
  border-radius: 2px;
  outline: none;
}
.${namespace}-grid-area :deep(.${namespace}-pg-controls) {
  display: flex;
  align-items: center;
  gap: 4px;
}
.${namespace}-grid-area :deep(.${namespace}-pg-btn) {
  height: 24px;
  min-width: 24px;
  padding: 0 6px;
  background: var(--${namespace}-bg);
  border: 1px solid var(--${namespace}-bd);
  color: var(--${namespace}-t);
  border-radius: 2px;
  cursor: pointer;
  display: flex;
  align-items: center;
  justify-content: center;
}
.${namespace}-grid-area :deep(.${namespace}-pg-btn:hover:not(:disabled)) {
  border-color: var(--${namespace}-p);
  color: var(--${namespace}-p);
}
.${namespace}-grid-area :deep(.${namespace}-pg-btn.${namespace}-on) {
  background: var(--${namespace}-p);
  color: var(--${namespace}-bg);
  border-color: var(--${namespace}-p);
}
.${namespace}-grid-area :deep(.${namespace}-pg-btn:disabled) {
  opacity: 0.5;
  cursor: not-allowed;
  background: var(--${namespace}-bgp);
}
.${namespace}-grid-area :deep(.${namespace}-pg-ellipsis) {
  font-size: 12px;
  color: var(--${namespace}-tl);
  padding: 0 2px;
}
</style>
