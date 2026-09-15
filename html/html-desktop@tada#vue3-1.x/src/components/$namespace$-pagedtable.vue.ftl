<template>
  <div class="${namespace}-table-wrap">
    <!-- ── 顶部工具栏（搜索与操作区） ────────────────────── -->
    <div v-if="showToolbar || $slots.toolbar" class="${namespace}-toolbar">
      <slot name="toolbar">
        <div style="flex: 1; display: flex; align-items: center; gap: 8px;">
          <input
            v-if="showSearch"
            type="text"
            class="${namespace}-input"
            :placeholder="searchPlaceholder"
            :value="searchKeyword"
            @input="onSearchInput"
          />
          <slot name="toolbar-left" />
        </div>
        <div style="display: flex; align-items: center; gap: 8px;">
          <slot name="toolbar-right" />
        </div>
      </slot>
    </div>

    <!-- ── 核心表格区域 ──────────────────────────────── -->
    <div style="overflow-x: auto; width: 100%;">
      <table class="${namespace}-table">
        <colgroup>
          <col
            v-for="col in columns"
            :key="col.key"
            :style="{ width: col.width || 'auto', minWidth: col.width || 'auto' }"
          />
        </colgroup>

        <thead>
          <tr>
            <th
              v-for="col in columns"
              :key="col.key"
              :style="{ textAlign: col.align || 'left' }"
            >
              {{ col.title }}
            </th>
          </tr>
        </thead>

        <tbody>
          <!-- 自定义整行 Slot -->
          <slot
            v-if="$slots.default"
            :rows="displayData"
            :columns="columns"
          />

          <!-- 自动渲染数据行 -->
          <template v-else>
            <tr
              v-for="(row, idx) in displayData"
              :key="getRowKey(row, idx)"
              @click="$emit('rowClick', row, idx)"
            >
              <td
                v-for="col in columns"
                :key="col.key"
                :style="{ textAlign: col.align || 'left' }"
              >
                <!-- 1. 命名插槽 cell-[key] -->
                <slot
                  v-if="$slots['cell-' + col.key]"
                  :name="'cell-' + col.key"
                  :row="row"
                  :value="row[col.key]"
                  :index="idx"
                />

                <!-- 2. 内置类型支持: progress 进度条 -->
                <template v-else-if="col.type === 'progress'">
                  <div style="display: flex; flex-direction: column; gap: 4px; min-width: 120px;">
                    <div style="display: flex; justify-content: space-between; font-size: 11px;">
                      <span>完成度</span>
                      <span>{{ row[col.key] }}%</span>
                    </div>
                    <div class="${namespace}-progress-bar">
                      <div
                        class="${namespace}-progress-fill"
                        :style="{ width: Math.min(100, Math.max(0, row[col.key] || 0)) + '%' }"
                      ></div>
                    </div>
                  </div>
                </template>

                <!-- 3. 内置类型支持: tag 标签胶囊 -->
                <template v-else-if="col.type === 'tag'">
                  <span
                    class="${namespace}-tag"
                    :class="col.tagType ? `${namespace}-tag--` : `${namespace}-tag--primary`"
                  >
                    {{ row[col.key] }}
                  </span>
                </template>

                <!-- 4. 自定义 render 函数 -->
                <template v-else-if="col.render">
                  <span
                    v-html="col.render(row[col.key], row)"
                    @click="handleActionClick($event, row, idx)"
                  ></span>
                </template>

                <!-- 5. 普通格式化输出 -->
                <template v-else-if="col.formatter">
                  {{ col.formatter(row, col, row[col.key], idx) }}
                </template>

                <!-- 6. 纯文本输出 -->
                <template v-else>
                  {{ row[col.key] }}
                </template>
              </td>
            </tr>
          </template>

          <!-- 空状态 -->
          <tr v-if="!$slots.default && displayData.length === 0 && !loading">
            <td :colspan="columns.length" style="text-align: center; padding: 48px 16px;">
              <slot name="empty">
                <div style="display: flex; flex-direction: column; align-items: center; gap: 8px;">
                  <span style="font-size: 32px;">🐾</span>
                  <span style="font-weight: 800; opacity: 0.6;">{{ emptyText }}</span>
                </div>
              </slot>
            </td>
          </tr>
        </tbody>
      </table>
    </div>

    <!-- ── 底部分页与状态控制栏 ──────────────────────── -->
    <div v-if="showPagination" class="${namespace}-statusbar">
      <div style="display: flex; align-items: center; gap: 12px;">
        <span>共 <b>{{ displayTotal }}</b> 条记录</span>
        <div v-if="showPageSize" style="display: flex; align-items: center; gap: 4px;">
          <span>每页</span>
          <select
            class="${namespace}-select"
            style="height: 28px; padding: 0 8px; font-size: 11px;"
            :value="currentPageSize"
            @change="onPageSizeChange"
          >
            <option v-for="size in pageSizeOptions" :key="size" :value="size">
              {{ size }} 条
            </option>
          </select>
        </div>
      </div>

      <!-- 翻页胶囊组 (完全复用 CSS 第6节 .${namespace}-record-nav 规范) -->
      <div class="${namespace}-record-nav">
        <button
          type="button"
          class="${namespace}-rn-btn"
          :disabled="current <= 1 || loading"
          @click="changePage(current - 1)"
        >
          上一页
        </button>

        <span class="${namespace}-rn-idx">
          {{ current }} / {{ totalPages || 1 }}
        </span>

        <button
          type="button"
          class="${namespace}-rn-btn"
          :disabled="current >= totalPages || loading"
          @click="changePage(current + 1)"
        >
          下一页
        </button>
      </div>
    </div>
  </div>
</template>

<script setup>
import { computed, ref, watch } from 'vue'

const props = defineProps({
  /** 列配置 [{ key, title, width?, align?, type?, tagType?, render?, formatter? }] */
  columns: {
    type: Array,
    required: true
  },
  /** 列表数据 */
  data: {
    type: Array,
    default: () => []
  },
  /** 总数量（受控模式） */
  total: {
    type: Number,
    default: 0
  },
  /** 当前页数 (v-model:currentPage) */
  currentPage: {
    type: Number,
    default: 1
  },
  /** 每页条数 (v-model:pageSize) */
  pageSize: {
    type: Number,
    default: 4
  },
  /** 每页条数可选项 */
  pageSizeOptions: {
    type: Array,
    default: () => [4, 6, 10, 20]
  },
  /** 加载中状态 */
  loading: {
    type: Boolean,
    default: false
  },
  /** 唯一主键键名或提取函数 */
  rowKey: {
    type: [String, Function],
    default: 'id'
  },
  /** 空提示文案 */
  emptyText: {
    type: String,
    default: '空空如也，添加一个新计划吧 (•ㅅ•)'
  },
  /** 是否开启工具栏 */
  showToolbar: {
    type: Boolean,
    default: false
  },
  /** 是否显示搜索框 */
  showSearch: {
    type: Boolean,
    default: false
  },
  searchPlaceholder: {
    type: String,
    default: '搜索关键字...'
  },
  /** 是否显示分页 */
  showPagination: {
    type: Boolean,
    default: true
  },
  /** 是否显示每页行数下拉 */
  showPageSize: {
    type: Boolean,
    default: true
  }
})

const emit = defineEmits([
  'update:currentPage',
  'update:pageSize',
  'pageChange',
  'rowClick',
  'rowAction',
  'search'
])

const current = ref(props.currentPage)
const currentPageSize = ref(props.pageSize)
const searchKeyword = ref('')

watch(() => props.currentPage, (val) => { current.value = val })
watch(() => props.pageSize, (val) => { currentPageSize.value = val })

// 总数判断与分页计算
const displayTotal = computed(() => (props.total > 0 ? props.total : props.data.length))
const totalPages = computed(() => Math.ceil(displayTotal.value / currentPageSize.value) || 1)

// 如果没有传入受控 total，组件会自动进行本地分页切片
const displayData = computed(() => {
  if (props.total > 0) return props.data
  const start = (current.value - 1) * currentPageSize.value
  return props.data.slice(start, start + currentPageSize.value)
})

function getRowKey(row, idx) {
  if (typeof props.rowKey === 'function') return props.rowKey(row, idx)
  return row[props.rowKey] ?? idx
}

function changePage(page) {
  if (page < 1 || page > totalPages.value) return
  current.value = page
  emit('update:currentPage', page)
  emit('pageChange', { page, pageSize: currentPageSize.value })
}

function onPageSizeChange(e) {
  const size = parseInt(e.target.value, 10)
  currentPageSize.value = size
  current.value = 1
  emit('update:pageSize', size)
  emit('update:currentPage', 1)
  emit('pageChange', { page: 1, pageSize: size })
}

function onSearchInput(e) {
  searchKeyword.value = e.target.value
  emit('search', e.target.value)
}

function handleActionClick(event, row, idx) {
  const btn = event.target.closest('button')
  if (!btn) return
  const expr = btn.getAttribute('@click')
  if (!expr) return
  const match = expr.match(/^(\w+)\s*\(?\s*(.*?)\s*\)?$/)
  if (!match) return
  const handler = match[1]
  const args = match[2]
    ? match[2].split(',').map(s => {
        const trimmed = s.trim()
        return trimmed === 'row' ? row : trimmed.replace(/^['"]|['"]$/g, '')
      })
    : []
  emit('rowAction', { handler, args, row, index: idx })
}
</script>