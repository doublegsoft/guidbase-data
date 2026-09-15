<template>
  <div
    class="ac-pgn"
    :class="{
      'ac-pgn--sm': size === 'sm',
      'ac-pgn--disabled': disabled,
    }"
  >
    <!-- Left: total info + page size selector -->
    <div class="ac-pgn__left">
      <span v-if="showTotal" class="ac-pgn__total">
        共 <strong>{{ total }}</strong> 条
      </span>

      <div v-if="showPageSize" class="ac-pgn__sizer">
        <select
          class="ac-pgn__sizer-select"
          :value="pageSize"
          :disabled="disabled"
          @change="onPageSizeChange($event)"
        >
          <option
            v-for="opt in pageSizeOptions"
            :key="opt"
            :value="opt"
          >{{ opt }} 条/页</option>
        </select>
      </div>
    </div>

    <!-- Center: page buttons -->
    <nav class="ac-pgn__pages" aria-label="分页导航">
      <!-- Prev -->
      <button
        class="ac-pgn__btn ac-pgn__btn--nav"
        :disabled="disabled || currentPage <= 1"
        @click="goTo(currentPage - 1)"
        title="上一页"
      >
        <span class="ac-pgn__btn-arrow">‹</span>
      </button>

      <!-- First page + left ellipsis -->
      <template v-if="displayPages.length > 0">
        <button
          v-if="displayPages[0].value !== 1"
          class="ac-pgn__btn"
          :class="{ 'ac-pgn__btn--active': currentPage === 1 }"
          :disabled="disabled"
          @click="goTo(1)"
        >1</button>

        <span
          v-if="displayPages[0].type === 'ellipsis' || displayPages[0].value > 2"
          class="ac-pgn__ellipsis"
          :class="{ 'ac-pgn__ellipsis--clickable': displayPages[0].type === 'ellipsis' }"
          @click="displayPages[0].type === 'ellipsis' && goTo(displayPages[0].value)"
        >…</span>
      </template>

      <!-- Page number buttons -->
      <button
        v-for="p in displayPages"
        :key="p.value"
        v-show="p.type === 'page'"
        class="ac-pgn__btn"
        :class="{ 'ac-pgn__btn--active': currentPage === p.value }"
        :disabled="disabled"
        @click="goTo(p.value)"
      >{{ p.value }}</button>

      <!-- Right ellipsis + last page -->
      <template v-if="displayPages.length > 0 && lastDisplayedValue < totalPages">
        <span
          v-if="displayPages[displayPages.length - 1].type === 'ellipsis'"
          class="ac-pgn__ellipsis ac-pgn__ellipsis--clickable"
          @click="goTo(displayPages[displayPages.length - 1].value)"
        >…</span>

        <button
          class="ac-pgn__btn"
          :class="{ 'ac-pgn__btn--active': currentPage === totalPages }"
          :disabled="disabled"
          @click="goTo(totalPages)"
        >{{ totalPages }}</button>
      </template>

      <!-- Next -->
      <button
        class="ac-pgn__btn ac-pgn__btn--nav"
        :disabled="disabled || currentPage >= totalPages"
        @click="goTo(currentPage + 1)"
        title="下一页"
      >
        <span class="ac-pgn__btn-arrow">›</span>
      </button>
    </nav>

    <!-- Right: quick jumper -->
    <div v-if="showJumper" class="ac-pgn__right">
      <span class="ac-pgn__jumper-label">跳至</span>
      <input
        class="ac-pgn__jumper-input"
        type="number"
        :min="1"
        :max="totalPages"
        :disabled="disabled"
        :value="jumperValue"
        @input="onJumperInput"
        @keydown.enter="onJumperConfirm"
        @blur="onJumperConfirm"
      />
      <span class="ac-pgn__jumper-label">页</span>
    </div>
  </div>
</template>

<script setup>
/**
 * AcPagination — Academy Pro 分页器
 *
 * 设计对齐 Academy Pro 设计系统:
 * - 页面按钮: 8px 圆角 · teal 激活态 · 悬停 surface 背景
 * - 导航箭头: 前后翻页 · 禁用态半透明
 * - 条数选择器: 原生 select 统一样式
 * - 快捷跳转: 数字输入框 · 回车/失焦触发
 * - 省略号: 可点击前跳 5 页
 */
import { ref, computed, watch } from 'vue'

const props = defineProps({
  /** 当前页码 (v-model) */
  currentPage:  { type: Number, required: true },
  /** 每页条数 (v-model) */
  pageSize:     { type: Number, default: 10 },
  /** 数据总数 */
  total:        { type: Number, required: true },
  /** 每页条数选项 */
  pageSizeOptions: { type: Array, default: () => [10, 20, 50, 100] },
  /** 显示总数信息 */
  showTotal:    { type: Boolean, default: true },
  /** 显示条数选择器 */
  showPageSize: { type: Boolean, default: true },
  /** 显示快捷跳转 */
  showJumper:   { type: Boolean, default: false },
  /** 可见页码按钮数量（奇数，≥5） */
  pagerCount:   { type: Number, default: 7 },
  /** 禁用 */
  disabled:     { type: Boolean, default: false },
  /** 尺寸 */
  size:         { type: String, default: 'md' },
})

const emit = defineEmits(['update:currentPage', 'update:pageSize', 'change'])

// ── Computed ─────────────────────────────────────

const totalPages = computed(() => Math.max(1, Math.ceil(props.total / props.pageSize)))

/**
 * 计算显示的页码数组
 * 返回 [{ type: 'page'|'ellipsis', value: number }]
 *
 * 策略:
 *  - 总页数 ≤ pagerCount+2 → 全部显示
 *  - 否则: 首尾各 1 个 + 中间 pagerCount-2 个窗口 + 省略号
 */
const displayPages = computed(() => {
  const total = totalPages.value
  const cur = props.currentPage
  const half = Math.floor(props.pagerCount / 2)
  const pages = []

  if (total <= props.pagerCount + 2) {
    // 全部显示
    for (let i = 1; i <= total; i++) {
      pages.push({ type: 'page', value: i })
    }
    return pages
  }

  // 计算中间窗口 [left, right]
  let left = Math.max(2, cur - half)
  let right = Math.min(total - 1, cur + half)

  // 调整窗口大小以保证显示 pagerCount-2 个中间按钮
  if (right - left + 1 < props.pagerCount - 2) {
    if (left === 2) {
      right = Math.min(total - 1, left + props.pagerCount - 3)
    } else {
      left = Math.max(2, right - props.pagerCount + 3)
    }
  }

  // 构建结果
  // 第一个：始终显示 page 1（如果 left > 2 则省略号在中间之前）
  if (left > 2) {
    pages.push({ type: 'ellipsis', value: Math.max(1, cur - 5) })
  }

  for (let i = left; i <= right; i++) {
    pages.push({ type: 'page', value: i })
  }

  // 最后一个省略号
  if (right < total - 1) {
    pages.push({ type: 'ellipsis', value: Math.min(total, cur + 5) })
  }

  return pages
})

/** 最后显示的页码值，用于判断是否需要显示尾页按钮 */
const lastDisplayedValue = computed(() => {
  const pages = displayPages.value
  if (pages.length === 0) return totalPages.value
  // 找最后一个 type==='page' 的条目
  for (let i = pages.length - 1; i >= 0; i--) {
    if (pages[i].type === 'page') return pages[i].value
  }
  return totalPages.value
})

// ── Jumper ───────────────────────────────────────

const jumperValue = ref(String(props.currentPage))

watch(() => props.currentPage, (v) => {
  jumperValue.value = String(v)
})

function onJumperInput(e) {
  jumperValue.value = (e.target).value
}

function onJumperConfirm() {
  const num = parseInt(jumperValue.value, 10)
  if (!isNaN(num) && num >= 1 && num <= totalPages.value) {
    goTo(num)
  } else {
    // 回弹到当前页
    jumperValue.value = String(props.currentPage)
  }
}

// ── Methods ──────────────────────────────────────

function goTo(page) {
  if (props.disabled) return
  const p = Math.max(1, Math.min(totalPages.value, page))
  if (p === props.currentPage) return
  emit('update:currentPage', p)
  emit('change', { page: p, pageSize: props.pageSize })
}

function onPageSizeChange(ev) {
  const size = Number(ev.target.value)
  if (props.disabled) return
  emit('update:pageSize', size)
  // 切 pageSize 后 currentPage 可能要回缩
  const newTotal = Math.max(1, Math.ceil(props.total / size))
  const newPage = Math.min(props.currentPage, newTotal)
  if (newPage !== props.currentPage) {
    emit('update:currentPage', newPage)
  }
  emit('change', { page: newPage, pageSize: size })
}
</script>

<style scoped>
/* ═══════════════════════════════════════════════════════════════════════════
   AcPagination — Academy Pro 分页器
   设计令牌: var(--color-*) var(--space-*) var(--radius-*) var(--shadow-*)
   ═══════════════════════════════════════════════════════════════════════════ */

.ac-pgn {
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: var(--space-7) var(--space-11);
  gap: var(--space-9);
  flex-wrap: wrap;
  font-family: var(--font-family-base);
  user-select: none;
}

/* ── Size: sm ──────────────────────────────────── */

.ac-pgn--sm {
  padding: var(--space-4) var(--space-7);
}

.ac-pgn--sm .ac-pgn__btn {
  min-width: 28px;
  height: 28px;
  font-size: var(--text-sm);
  padding: 0 var(--space-4);
}

.ac-pgn--sm .ac-pgn__total {
  font-size: var(--text-sm);
}

.ac-pgn--sm .ac-pgn__sizer-select {
  font-size: var(--text-sm);
  padding: var(--space-2) var(--space-5);
  min-height: 28px;
}

/* ── Disabled ──────────────────────────────────── */

.ac-pgn--disabled {
  opacity: 0.5;
  pointer-events: none;
}

/* ── Left section ──────────────────────────────── */

.ac-pgn__left {
  display: flex;
  align-items: center;
  gap: var(--space-8);
  flex-shrink: 0;
}

/* Total count */
.ac-pgn__total {
  font-size: var(--text-md);
  color: var(--color-text-sub);
  white-space: nowrap;
}

.ac-pgn__total strong {
  color: var(--color-text-main);
  font-weight: var(--weight-bold);
  margin: 0 var(--space-1);
}

/* Page size selector */
.ac-pgn__sizer-select {
  border: 1px solid var(--color-border);
  border-radius: var(--radius-md);
  padding: var(--space-4) var(--space-7);
  font-size: var(--text-md);
  color: var(--color-text-main);
  background: var(--color-card);
  cursor: pointer;
  transition: border-color var(--transition-base), box-shadow var(--transition-base);
  outline: none;
  font-family: var(--font-family-base);
  min-height: 34px;
  appearance: none;
  background-image: url("data:image/svg+xml,%3Csvg width='10' height='6' xmlns='http://www.w3.org/2000/svg'%3E%3Cpath d='M1 1l4 4 4-4' stroke='%2395AABA' stroke-width='1.5' fill='none'/%3E%3C/svg%3E");
  background-repeat: no-repeat;
  background-position: right 10px center;
  padding-right: 28px;
}

.ac-pgn__sizer-select:hover {
  border-color: #c8d6e0;
}

.ac-pgn__sizer-select:focus {
  border-color: var(--color-teal);
  box-shadow: 0 0 0 3px var(--color-teal-dim);
}

/* ── Page buttons ──────────────────────────────── */

.ac-pgn__pages {
  display: flex;
  align-items: center;
  gap: var(--space-3);
  flex-wrap: wrap;
  justify-content: center;
}

.ac-pgn__btn {
  min-width: 34px;
  height: 34px;
  padding: 0 var(--space-5);
  border-radius: var(--radius-md);
  border: 1px solid transparent;
  background: transparent;
  color: var(--color-text-main);
  font-size: var(--text-body);
  font-weight: var(--weight-medium);
  cursor: pointer;
  transition: all var(--transition-fast);
  display: inline-flex;
  align-items: center;
  justify-content: center;
  font-family: var(--font-family-base);
  line-height: 1;
}

.ac-pgn__btn:hover:not(:disabled) {
  background: var(--color-surface);
  border-color: var(--color-border);
}

.ac-pgn__btn:focus-visible {
  outline: 2px solid var(--color-teal);
  outline-offset: 2px;
}

.ac-pgn__btn--active {
  background: var(--color-teal) !important;
  border-color: var(--color-teal) !important;
  color: #fff !important;
  font-weight: var(--weight-bold);
  box-shadow: var(--shadow-glow-teal);
}

.ac-pgn__btn:disabled {
  opacity: 0.35;
  cursor: not-allowed;
}

/* Navigation arrows */
.ac-pgn__btn--nav {
  font-size: var(--text-xl);
  font-weight: var(--weight-semibold);
  color: var(--color-text-sub);
}

.ac-pgn__btn--nav:hover:not(:disabled) {
  color: var(--color-teal);
  border-color: var(--color-teal);
  background: var(--color-teal-dim);
}

.ac-pgn__btn-arrow {
  line-height: 1;
  position: relative;
  top: -1px;
}

/* ── Ellipsis ──────────────────────────────────── */

.ac-pgn__ellipsis {
  min-width: 34px;
  height: 34px;
  display: inline-flex;
  align-items: center;
  justify-content: center;
  font-size: var(--text-body);
  color: var(--color-text-muted);
  letter-spacing: 1px;
  cursor: default;
}

.ac-pgn__ellipsis--clickable {
  cursor: pointer;
  border-radius: var(--radius-md);
  transition: all var(--transition-fast);
}

.ac-pgn__ellipsis--clickable:hover {
  background: var(--color-surface);
  color: var(--color-teal);
}

/* ── Jumper ────────────────────────────────────── */

.ac-pgn__right {
  display: flex;
  align-items: center;
  gap: var(--space-4);
  flex-shrink: 0;
}

.ac-pgn__jumper-label {
  font-size: var(--text-md);
  color: var(--color-text-sub);
  white-space: nowrap;
}

.ac-pgn__jumper-input {
  width: 52px;
  border: 1px solid var(--color-border);
  border-radius: var(--radius-md);
  padding: var(--space-4) var(--space-5);
  font-size: var(--text-body);
  color: var(--color-text-main);
  background: var(--color-card);
  text-align: center;
  transition: border-color var(--transition-base), box-shadow var(--transition-base);
  outline: none;
  font-family: var(--font-family-base);
  /* hide spin buttons */
  -moz-appearance: textfield;
}

.ac-pgn__jumper-input::-webkit-outer-spin-button,
.ac-pgn__jumper-input::-webkit-inner-spin-button {
  -webkit-appearance: none;
  margin: 0;
}

.ac-pgn__jumper-input:focus {
  border-color: var(--color-teal);
  box-shadow: 0 0 0 3px var(--color-teal-dim);
}

.ac-pgn__jumper-input:disabled {
  background: var(--color-surface);
  color: var(--color-text-muted);
  cursor: not-allowed;
}
</style>
