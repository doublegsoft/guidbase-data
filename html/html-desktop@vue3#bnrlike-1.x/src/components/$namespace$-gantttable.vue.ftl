<template>
  <div class="${namespace}-gantt" :style="{ height: height }">
    <!-- 加载遮罩 -->
    <div v-if="loading" class="${namespace}-gantt__loading-mask">
      <span class="${namespace}-gantt__loading-text">加载中...</span>
    </div>

    <!-- 顶部工具栏 -->
    <div class="${namespace}-toolbar ${namespace}-gantt__toolbar">
      <span class="${namespace}-gantt__title">{{ title }}</span>
      <div class="${namespace}-gantt__toolbar-actions">
        <button type="button" class="${namespace}-btn ${namespace}-btn--default ${namespace}-btn--sm" @click="scrollToToday">
          定位今日
        </button>
        <button type="button" class="${namespace}-btn ${namespace}-btn--default ${namespace}-btn--sm" @click="toggleSort">
          ⇅ {{ sortDir === 1 ? '名称 A-Z' : sortDir === -1 ? '名称 Z-A' : '排序' }}
        </button>
        <button
          type="button"
          class="${namespace}-btn ${namespace}-btn--sm"
          :class="hideDone ? '${namespace}-btn--primary' : '${namespace}-btn--default'"
          @click="hideDone = !hideDone"
        >
          {{ hideDone ? '✓ 已隐藏完成' : '隐藏已完成' }}
        </button>
        <button type="button" class="${namespace}-btn ${namespace}-btn--default ${namespace}-btn--sm" @click="toggleAllCollapse">
          {{ allCollapsed ? '展开全部' : '折叠全部' }}
        </button>
        <button
          v-if="!readonly"
          type="button"
          class="${namespace}-btn ${namespace}-btn--primary ${namespace}-btn--sm"
          @click="addProject"
        >
          ＋ 新建项目
        </button>
      </div>
    </div>

    <!-- 项目甘特列表 -->
    <div class="${namespace}-gantt__list">
      <div
        v-for="project in displayProjects"
        :key="project.id"
        class="${namespace}-panel ${namespace}-gantt__card"
        :style="{
          '--gantt-ac': getPalette(project.pal).accent,
          '--gantt-bar': getPalette(project.pal).bar
        }"
      >
        <!-- 项目头部 -->
        <div class="${namespace}-panel-head ${namespace}-gantt__card-head">
          <input
            v-if="editingProjectId === project.id && !readonly"
            ref="projNameInputRef"
            v-model="project.name"
            class="${namespace}-input ${namespace}-gantt__proj-input"
            @blur="finishRenameProject"
            @keydown.enter="finishRenameProject"
          />
          <span
            v-else
            class="${namespace}-gantt__proj-title"
            :title="readonly ? project.name : '双击重命名'"
            @dblclick="!readonly && startRenameProject(project.id)"
          >
            {{ project.name }}
          </span>

          <span class="${namespace}-tag ${namespace}-tag--primary">
            {{ visibleTasks(project).length }} 项任务
          </span>

          <div class="${namespace}-panel-head-right">
            <button
              v-if="!readonly"
              type="button"
              class="${namespace}-btn ${namespace}-btn--default ${namespace}-btn--sm"
              @click="addTask(project)"
            >
              ＋ 任务
            </button>
            <button
              v-if="!readonly"
              type="button"
              class="${namespace}-btn ${namespace}-btn--default ${namespace}-btn--sm"
              @click="startRenameProject(project.id)"
            >
              重命名
            </button>
            <button
              type="button"
              class="${namespace}-btn ${namespace}-btn--default ${namespace}-btn--sm"
              @click="project.collapsed = !project.collapsed"
            >
              {{ project.collapsed ? '展开' : '折叠' }}
            </button>
            <button
              v-if="!readonly"
              type="button"
              class="${namespace}-btn ${namespace}-btn--danger ${namespace}-btn--sm"
              @click="removeProject(project)"
            >
              删除
            </button>
          </div>
        </div>

        <!-- 主体：左侧任务表 + 右侧时间轴 -->
        <div v-show="!project.collapsed" class="${namespace}-gantt__body">
          <!-- 左侧固定任务明细 -->
          <div class="${namespace}-gantt__left">
            <div class="${namespace}-gantt__left-subhead">
              <span>任务明细</span>
            </div>
            <div class="${namespace}-gantt__th">
              <span>任务名称</span>
              <span class="${namespace}-cell-center">进度</span>
              <span class="${namespace}-cell-center">负责人</span>
              <span class="${namespace}-cell-center">开始日期</span>
              <span class="${namespace}-cell-center">结束日期</span>
              <span class="${namespace}-cell-center">天数</span>
              <span class="${namespace}-cell-center">操作</span>
            </div>

            <div class="${namespace}-gantt__rows">
              <div
                v-for="task in visibleTasks(project)"
                :key="task.id"
                class="${namespace}-gantt__row"
              >
                <span>
                  <input
                    v-model="task.name"
                    class="${namespace}-gantt__inline-input"
                    :readonly="readonly"
                    @change="emitChange"
                  />
                </span>

                <span class="${namespace}-cell-center">
                  <input
                    type="number"
                    min="0"
                    max="100"
                    :value="task.progress"
                    :readonly="readonly"
                    class="${namespace}-gantt__pct-input"
                    :class="{ 'is-zero': !task.progress }"
                    @input="onProgressInput(task, $event)"
                  />%
                </span>

                <span class="${namespace}-cell-center">
                  <button
                    type="button"
                    class="${namespace}-gantt__avatar"
                    :style="{ background: getWorker(task.worker).color }"
                    :title="getWorker(task.worker).name"
                    @click.stop="!readonly && openWorkerMenu($event, project, task)"
                  >
                    {{ getInitials(getWorker(task.worker).name) }}
                  </button>
                </span>

                <span class="${namespace}-cell-center">
                  <label class="${namespace}-gantt__date">
                    <span class="${namespace}-gantt__mono">{{ shortDate(task.start) }}</span>
                    <input
                      v-if="!readonly"
                      type="date"
                      :value="task.start"
                      @change="onDateChange(project, task, 'start', $event)"
                    />
                  </label>
                </span>

                <span class="${namespace}-cell-center">
                  <label class="${namespace}-gantt__date">
                    <span class="${namespace}-gantt__mono">{{ shortDate(task.end) }}</span>
                    <input
                      v-if="!readonly"
                      type="date"
                      :value="task.end"
                      @change="onDateChange(project, task, 'end', $event)"
                    />
                  </label>
                </span>

                <span class="${namespace}-cell-right ${namespace}-gantt__days">
                  {{ calcDays(task.start, task.end) }}
                </span>

                <span class="${namespace}-cell-center">
                  <button
                    v-if="!readonly"
                    type="button"
                    class="${namespace}-gantt__del-btn"
                    title="删除任务"
                    @click="removeTask(project, task)"
                  >
                    ×
                  </button>
                </span>
              </div>

              <div v-if="visibleTasks(project).length === 0" class="${namespace}-gantt__empty">
                暂无任务，点击右上角「＋ 任务」添加
              </div>
            </div>
          </div>

          <!-- 右侧时间轴画布 -->
          <div class="${namespace}-gantt__right">
            <div
              :ref="el => setScrollRef(project.id, el)"
              class="${namespace}-gantt__scroll"
              @scroll="onTimelineScroll(project.id, $event)"
            >
              <div class="${namespace}-gantt__canvas" :style="{ width: totalDays * dayWidth + 'px' }">
                <!-- 月份行 -->
                <div class="${namespace}-gantt__months">
                  <div
                    v-for="m in monthSpans"
                    :key="m.key"
                    class="${namespace}-gantt__month-cell"
                    :style="{ width: m.days * dayWidth + 'px' }"
                  >
                    <span>{{ m.label }}</span>
                  </div>
                </div>

                <!-- 日期行 -->
                <div class="${namespace}-gantt__days-head">
                  <div
                    v-for="d in dayCells"
                    :key="d.iso"
                    class="${namespace}-gantt__day-cell"
                    :class="{ 'is-weekend': d.isWeekend, 'is-today': d.iso === todayDate }"
                    :style="{ width: dayWidth + 'px' }"
                  >
                    <div>{{ d.dow }}</div>
                    <div class="${namespace}-gantt__mono">{{ d.day }}</div>
                  </div>
                </div>

                <!-- 网格 + 甘特条 + SVG 依赖线 -->
                <div
                  :ref="el => setGridRef(project.id, el)"
                  class="${namespace}-gantt__grid"
                  :style="{
                    height: Math.max(1, visibleTasks(project).length) * ROW_HEIGHT + 'px',
                    backgroundSize: '100% ' + ROW_HEIGHT + 'px'
                  }"
                >
                  <div
                    v-for="d in weekendCells"
                    :key="'we-' + d.iso"
                    class="${namespace}-gantt__weekend-bg"
                    :style="{ left: d.index * dayWidth + 'px', width: dayWidth + 'px' }"
                  />

                  <!-- 今日标记线 -->
                  <div
                    v-if="todayIndex >= 0 && todayIndex < totalDays"
                    class="${namespace}-gantt__today-line"
                    :style="{ left: todayIndex * dayWidth + dayWidth / 2 + 'px' }"
                  >
                    <span class="${namespace}-gantt__today-tag">今日</span>
                  </div>

                  <!-- SVG 依赖层 -->
                  <svg
                    class="${namespace}-gantt__svg"
                    :width="totalDays * dayWidth"
                    :height="Math.max(1, visibleTasks(project).length) * ROW_HEIGHT"
                  >
                    <defs>
                      <marker
                        :id="'gantt-arrow-' + project.id"
                        viewBox="0 0 10 10"
                        refX="8"
                        refY="5"
                        markerWidth="6"
                        markerHeight="6"
                        orient="auto"
                      >
                        <path d="M0 0L10 5L0 10z" :fill="getPalette(project.pal).accent" />
                      </marker>
                    </defs>

                    <g v-for="edge in getDependencyEdges(project)" :key="edge.id">
                      <path
                        class="${namespace}-gantt__dep-line"
                        :d="edge.d"
                        :marker-end="'url(#gantt-arrow-' + project.id + ')'"
                      />
                      <path
                        v-if="!readonly"
                        class="${namespace}-gantt__dep-hit"
                        :d="edge.d"
                        @click="removeDependency(edge.target)"
                      >
                        <title>点击删除依赖关系</title>
                      </path>
                    </g>

                    <path
                      v-if="dragState && dragState.mode === 'link' && dragState.project.id === project.id"
                      class="${namespace}-gantt__dep-tmp"
                      :d="dragState.tmpPath"
                    />
                  </svg>

                  <!-- 甘特条 -->
                  <div
                    v-for="(task, idx) in visibleTasks(project)"
                    :key="'bar-' + task.id"
                    :data-task-id="task.id"
                    class="${namespace}-gantt__bar"
                    :class="{
                      'is-out': isLabelOutside(task),
                      'is-target': dragState && dragState.mode === 'link' && dragState.hoverTaskId === task.id,
                      'is-readonly': readonly
                    }"
                    :style="getBarStyle(task, idx)"
                    @pointerdown="!readonly && startBarDrag($event, project, task, 'move')"
                  >
                    <div class="${namespace}-gantt__bar-pg" :style="{ width: task.progress + '%' }" />
                    <span
                      v-if="!readonly"
                      class="${namespace}-gantt__handle ${namespace}-gantt__handle--l"
                      @pointerdown.stop="startBarDrag($event, project, task, 'left')"
                    />
                    <span class="${namespace}-gantt__bar-label">{{ task.name }}</span>
                    <span
                      v-if="!readonly"
                      class="${namespace}-gantt__handle ${namespace}-gantt__handle--r"
                      @pointerdown.stop="startBarDrag($event, project, task, 'right')"
                    />
                    <span
                      v-if="!readonly"
                      class="${namespace}-gantt__link-dot"
                      title="拖向其他任务建立前置依赖"
                      @pointerdown.stop="startBarDrag($event, project, task, 'link')"
                    />
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>

      <div v-if="displayProjects.length === 0" class="${namespace}-panel ${namespace}-gantt__empty-all">
        {{ loading ? '加载中...' : '暂无项目数据' }}
      </div>
    </div>

    <!-- 负责人选择浮层 -->
    <div
      v-if="workerMenu.open"
      class="${namespace}-gantt__worker-menu"
      :style="{ left: workerMenu.x + 'px', top: workerMenu.y + 'px' }"
      @click.stop
    >
      <div
        v-for="(w, idx) in workers"
        :key="w.name"
        class="${namespace}-gantt__worker-item"
        :class="{ 'is-active': workerMenu.task?.worker === idx }"
        @click="selectWorker(idx)"
      >
        <span class="${namespace}-gantt__avatar ${namespace}-gantt__avatar--sm" :style="{ background: w.color }">
          {{ getInitials(w.name) }}
        </span>
        <span>{{ w.name }}</span>
      </div>
    </div>

    <!-- 轻提示 -->
    <div v-if="toastMsg" class="${namespace}-gantt__toast">
      {{ toastMsg }}
    </div>
  </div>
</template>

<script setup>
import { ref, reactive, computed, watch, nextTick, onMounted, onBeforeUnmount } from 'vue'

const ROW_HEIGHT = 30
const DAY_MS = 86400000
const DOW_ZH = ['日', '一', '二', '三', '四', '五', '六']

const PALETTES = [
  { accent: '#1a4f8a', bar: '#d0e0f5' },
  { accent: '#1e8449', bar: '#cdecd9' },
  { accent: '#d46b08', bar: '#fbe2c4' },
  { accent: '#6c3483', bar: '#e6d5ee' },
  { accent: '#0e6655', bar: '#c5ebe3' },
]

const props = defineProps({
  modelValue:  { type: Array,    default: null },
  title:       { type: String,   default: '项目计划甘特视图' },
  height:      { type: String,   default: '100%' },
  rangeStart:  { type: String,   default: '2026-03-01' },
  rangeEnd:    { type: String,   default: '2026-05-15' },
  todayDate:   { type: String,   default: '2026-03-25' },
  dayWidth:    { type: Number,   default: 32 },
  readonly:    { type: Boolean,  default: false },
  fetchData:   { type: Function, default: null },
  fetchParams: { type: Object,   default: () => ({}) },
  workers: {
    type: Array,
    default: () => [
      { name: '张伟', color: '#1a4f8a' },
      { name: '李敏', color: '#1e8449' },
      { name: '王强', color: '#d46b08' },
      { name: '陈静', color: '#6c3483' },
      { name: '刘洋', color: '#0e6655' },
      { name: '赵磊', color: '#c0392b' },
    ],
  },
})

const emit = defineEmits(['update:modelValue', 'change'])

/* ── 日期工具 ── */
function parseDate(iso) {
  const parts = String(iso).split('-').map(Number)
  return new Date(parts[0], parts[1] - 1, parts[2])
}

function formatDate(date) {
  const y = date.getFullYear()
  const m = String(date.getMonth() + 1).padStart(2, '0')
  const d = String(date.getDate()).padStart(2, '0')
  return y + '-' + m + '-' + d
}

function addDays(iso, delta) {
  const dt = parseDate(iso)
  dt.setDate(dt.getDate() + delta)
  return formatDate(dt)
}

function diffDays(aIso, bIso) {
  return Math.round((parseDate(bIso) - parseDate(aIso)) / DAY_MS)
}

function calcDays(s, e) {
  if (!s || !e) return 0
  return Math.max(1, diffDays(s, e) + 1)
}

function shortDate(iso) {
  return iso ? iso.slice(5) : '-'
}

/* ── 演示种子数据 ── */
function createSeedProjects() {
  return [
    {
      id: 1,
      name: '信贷审批流程改造一期',
      pal: 0,
      collapsed: false,
      tasks: [
        { id: 101, name: '需求调研与原型确认', progress: 100, worker: 0, start: '2026-03-08', end: '2026-03-13', dep: null },
        { id: 102, name: 'BPMN 流程建模与评审', progress: 75, worker: 1, start: '2026-03-14', end: '2026-03-21', dep: 101 },
        { id: 103, name: 'jBPM 引擎集成联调', progress: 30, worker: 2, start: '2026-03-22', end: '2026-03-31', dep: 102 },
        { id: 104, name: 'UAT 测试与上线验收', progress: 0, worker: 3, start: '2026-04-01', end: '2026-04-08', dep: 103 },
      ],
    },
    {
      id: 2,
      name: '押品评估子系统升级',
      pal: 1,
      collapsed: false,
      tasks: [
        { id: 201, name: 'GIS 地图组件接入', progress: 100, worker: 4, start: '2026-03-12', end: '2026-03-18', dep: null },
        { id: 202, name: '估值模型接口开发', progress: 50, worker: 5, start: '2026-03-19', end: '2026-03-28', dep: 201 },
        { id: 203, name: '公文函件套打联调', progress: 0, worker: 0, start: '2026-03-29', end: '2026-04-04', dep: 202 },
      ],
    },
  ]
}

/* ── 数据与远端加载 ── */
const hasFetcher = computed(() => typeof props.fetchData === 'function')
const loading = ref(false)
let reqId = 0

const innerProjects = ref(
  props.modelValue
    ? JSON.parse(JSON.stringify(props.modelValue))
    : (hasFetcher.value ? [] : createSeedProjects())
)

watch(
  () => props.modelValue,
  (val) => {
    if (val) innerProjects.value = JSON.parse(JSON.stringify(val))
  },
  { deep: true }
)

async function loadData() {
  if (!hasFetcher.value) return
  const id = ++reqId
  loading.value = true
  try {
    const res = await props.fetchData({ ...props.fetchParams })
    if (id !== reqId) return
    const list = Array.isArray(res) ? res : (res?.data ?? [])
    innerProjects.value = JSON.parse(JSON.stringify(list))
  } catch (e) {
    if (id !== reqId) return
    console.error('Gantt fetchData error:', e)
    innerProjects.value = []
  } finally {
    if (id === reqId) loading.value = false
  }
}

watch(() => props.fetchParams, () => {
  if (hasFetcher.value) loadData()
}, { deep: true })

watch(() => props.fetchData, () => {
  if (hasFetcher.value) loadData()
})

function emitChange() {
  const snapshot = JSON.parse(JSON.stringify(innerProjects.value))
  emit('update:modelValue', snapshot)
  emit('change', snapshot)
}

/* ── 视图控制 ── */
const sortDir = ref(0)
const hideDone = ref(false)
const editingProjectId = ref(null)
const projNameInputRef = ref(null)
const toastMsg = ref('')
let toastTimer = null

function showToast(msg) {
  toastMsg.value = msg
  clearTimeout(toastTimer)
  toastTimer = setTimeout(() => { toastMsg.value = '' }, 2000)
}

const displayProjects = computed(() => {
  const list = [...innerProjects.value]
  if (sortDir.value !== 0) {
    list.sort((a, b) => sortDir.value * a.name.localeCompare(b.name, 'zh-CN'))
  }
  return list
})

const allCollapsed = computed(
  () => innerProjects.value.length > 0 && innerProjects.value.every(p => p.collapsed)
)

function visibleTasks(project) {
  const list = project.tasks || []
  return hideDone.value ? list.filter(t => (t.progress || 0) < 100) : list
}

function getPalette(pal) {
  return PALETTES[(pal || 0) % PALETTES.length]
}

function getWorker(idx) {
  return props.workers[idx] || props.workers[0] || { name: '未分配', color: '#5d6d7e' }
}

function getInitials(name) {
  return (name || '').slice(-2)
}

/* ── 时间轴计算 ── */
const totalDays = computed(() => Math.max(1, diffDays(props.rangeStart, props.rangeEnd) + 1))

const dayCells = computed(() => {
  const arr = []
  for (let i = 0; i < totalDays.value; i++) {
    const iso = addDays(props.rangeStart, i)
    const dt = parseDate(iso)
    const w = dt.getDay()
    arr.push({
      index: i,
      iso,
      day: String(dt.getDate()).padStart(2, '0'),
      dow: DOW_ZH[w],
      isWeekend: w === 0 || w === 6,
    })
  }
  return arr
})

const weekendCells = computed(() => dayCells.value.filter(d => d.isWeekend))

const monthSpans = computed(() => {
  const spans = []
  let curKey = ''
  let count = 0
  let curLabel = ''
  dayCells.value.forEach((cell) => {
    const ym = cell.iso.slice(0, 7)
    if (ym !== curKey) {
      if (curKey) spans.push({ key: curKey, label: curLabel, days: count })
      curKey = ym
      curLabel = ym.replace('-', '年') + '月'
      count = 1
    } else {
      count++
    }
  })
  if (curKey) spans.push({ key: curKey, label: curLabel, days: count })
  return spans
})

const todayIndex = computed(() => diffDays(props.rangeStart, props.todayDate))

/* ── 项目/任务操作 ── */
function toggleSort() {
  sortDir.value = sortDir.value === 1 ? -1 : 1
}

function toggleAllCollapse() {
  const target = !allCollapsed.value
  innerProjects.value.forEach(p => { p.collapsed = target })
}

function addProject() {
  const id = Date.now()
  innerProjects.value.push({
    id,
    name: '新建项目 ' + (innerProjects.value.length + 1),
    pal: innerProjects.value.length % PALETTES.length,
    collapsed: false,
    tasks: [
      {
        id: id + 1,
        name: '初始任务节点',
        progress: 0,
        worker: 0,
        start: props.todayDate,
        end: addDays(props.todayDate, 3),
        dep: null,
      },
    ],
  })
  emitChange()
}

function removeProject(project) {
  innerProjects.value = innerProjects.value.filter(p => p.id !== project.id)
  emitChange()
}

async function startRenameProject(id) {
  editingProjectId.value = id
  await nextTick()
  const el = Array.isArray(projNameInputRef.value) ? projNameInputRef.value[0] : projNameInputRef.value
  el?.focus()
  el?.select()
}

function finishRenameProject() {
  editingProjectId.value = null
  emitChange()
}

function addTask(project) {
  const id = Date.now() + Math.floor(Math.random() * 1000)
  project.tasks.push({
    id,
    name: '新任务',
    progress: 0,
    worker: project.tasks.length % props.workers.length,
    start: props.todayDate,
    end: addDays(props.todayDate, 2),
    dep: null,
  })
  emitChange()
}

function removeTask(project, task) {
  project.tasks = project.tasks.filter(t => t.id !== task.id)
  project.tasks.forEach(t => {
    if (t.dep === task.id) t.dep = null
  })
  emitChange()
}

function onProgressInput(task, ev) {
  task.progress = Math.max(0, Math.min(100, parseInt(ev.target.value, 10) || 0))
  emitChange()
}

function onDateChange(project, task, field, ev) {
  const val = ev.target.value
  if (!val) return
  if (field === 'start') {
    task.start = val
    if (diffDays(task.start, task.end) < 0) task.end = val
  } else {
    task.end = val
    if (diffDays(task.start, task.end) < 0) task.start = val
  }
  cascadeTasks(task, project)
  emitChange()
}

/* ── 依赖连线与级联 ── */
function cascadeTasks(preTask, project) {
  project.tasks.forEach((succ) => {
    if (succ.dep === preTask.id) {
      const gap = diffDays(preTask.end, succ.start)
      if (gap < 1) {
        const shift = 1 - gap
        succ.start = addDays(succ.start, shift)
        succ.end = addDays(succ.end, shift)
        cascadeTasks(succ, project)
      }
    }
  })
}

function wouldCreateCycle(project, fromId, toId) {
  let cur = project.tasks.find(t => t.id === fromId)
  while (cur && cur.dep) {
    if (cur.dep === toId) return true
    cur = project.tasks.find(t => t.id === cur.dep)
  }
  return false
}

function getDependencyEdges(project) {
  const list = visibleTasks(project)
  const indexMap = new Map()
  list.forEach((t, idx) => indexMap.set(t.id, idx))

  const edges = []
  list.forEach((target, j) => {
    if (!target.dep || !indexMap.has(target.dep)) return
    const i = indexMap.get(target.dep)
    const source = list[i]
    const x1 = (diffDays(props.rangeStart, source.end) + 1) * props.dayWidth - 2
    const y1 = i * ROW_HEIGHT + ROW_HEIGHT / 2
    const x2 = diffDays(props.rangeStart, target.start) * props.dayWidth + 2
    const y2 = j * ROW_HEIGHT + ROW_HEIGHT / 2
    const k = Math.max(24, Math.abs(x2 - x1) / 2)
    edges.push({
      id: source.id + '-' + target.id,
      target,
      d: 'M' + x1 + ' ' + y1 + 'C' + (x1 + k) + ' ' + y1 + ' ' + (x2 - k) + ' ' + y2 + ' ' + x2 + ' ' + y2,
    })
  })
  return edges
}

function removeDependency(task) {
  task.dep = null
  emitChange()
  showToast('已取消「' + task.name + '」的前置依赖')
}

/* ── 甘特条拖拽 ── */
function getBarStyle(task, rowIndex) {
  const startIdx = diffDays(props.rangeStart, task.start)
  const spanDays = calcDays(task.start, task.end)
  return {
    left: startIdx * props.dayWidth + 2 + 'px',
    top: rowIndex * ROW_HEIGHT + 5 + 'px',
    width: Math.max(12, spanDays * props.dayWidth - 4) + 'px',
  }
}

function isLabelOutside(task) {
  const w = calcDays(task.start, task.end) * props.dayWidth - 4
  return w < (task.name?.length || 0) * 12 + 20
}

const gridRefs = new Map()
const scrollRefs = new Map()
function setGridRef(pid, el) {
  if (el) gridRefs.set(pid, el)
  else gridRefs.delete(pid)
}
function setScrollRef(pid, el) {
  if (el) scrollRefs.set(pid, el)
  else scrollRefs.delete(pid)
}

const dragState = ref(null)

function startBarDrag(ev, project, task, mode) {
  ev.preventDefault()
  dragState.value = {
    project,
    task,
    mode,
    x0: ev.clientX,
    start0: task.start,
    end0: task.end,
    hoverTaskId: null,
    tmpPath: '',
  }
}

function onWindowPointerMove(ev) {
  const st = dragState.value
  if (!st) return

  if (st.mode === 'link') {
    const gridEl = gridRefs.get(st.project.id)
    if (!gridEl) return
    const rect = gridEl.getBoundingClientRect()
    const list = visibleTasks(st.project)
    const rowIdx = list.findIndex(t => t.id === st.task.id)
    const x1 = (diffDays(props.rangeStart, st.task.end) + 1) * props.dayWidth - 2
    const y1 = rowIdx * ROW_HEIGHT + ROW_HEIGHT / 2
    const x2 = ev.clientX - rect.left
    const y2 = ev.clientY - rect.top
    st.tmpPath = 'M' + x1 + ' ' + y1 + 'L' + x2 + ' ' + y2

    const hit = document.elementFromPoint(ev.clientX, ev.clientY)?.closest('[data-task-id]')
    const hitId = hit ? Number(hit.dataset.taskId) : null
    st.hoverTaskId = hitId && hitId !== st.task.id ? hitId : null
    return
  }

  const delta = Math.round((ev.clientX - st.x0) / props.dayWidth)
  if (st.mode === 'move') {
    st.task.start = addDays(st.start0, delta)
    st.task.end = addDays(st.end0, delta)
  } else if (st.mode === 'left') {
    const nextStart = addDays(st.start0, delta)
    st.task.start = diffDays(nextStart, st.end0) >= 0 ? nextStart : st.end0
  } else if (st.mode === 'right') {
    const nextEnd = addDays(st.end0, delta)
    st.task.end = diffDays(st.start0, nextEnd) >= 0 ? nextEnd : st.start0
  }
  cascadeTasks(st.task, st.project)
}

function onWindowPointerUp() {
  const st = dragState.value
  if (!st) return

  if (st.mode === 'link' && st.hoverTaskId) {
    const target = st.project.tasks.find(t => t.id === st.hoverTaskId)
    if (target) {
      if (wouldCreateCycle(st.project, st.task.id, target.id)) {
        showToast('无法创建依赖：不能形成循环依赖')
      } else {
        target.dep = st.task.id
        cascadeTasks(st.task, st.project)
        showToast('已建立依赖：「' + st.task.name + '」→「' + target.name + '」')
      }
    }
  }

  dragState.value = null
  emitChange()
}

/* ── 负责人选择 ── */
const workerMenu = reactive({
  open: false,
  x: 0,
  y: 0,
  task: null,
})

function openWorkerMenu(ev, project, task) {
  const rect = ev.currentTarget.getBoundingClientRect()
  workerMenu.x = rect.left
  workerMenu.y = rect.bottom + 4
  workerMenu.task = task
  workerMenu.open = true
}

function selectWorker(idx) {
  if (workerMenu.task) {
    workerMenu.task.worker = idx
    emitChange()
  }
  workerMenu.open = false
}

function closeWorkerMenu() {
  workerMenu.open = false
}

/* ── 横向滚动同步 ── */
let syncingScroll = false
function onTimelineScroll(pid, ev) {
  if (syncingScroll) return
  syncingScroll = true
  const left = ev.target.scrollLeft
  scrollRefs.forEach((el, key) => {
    if (key !== pid && el.scrollLeft !== left) el.scrollLeft = left
  })
  syncingScroll = false
}

function scrollToToday() {
  const targetLeft = Math.max(0, (todayIndex.value - 4) * props.dayWidth)
  scrollRefs.forEach((el) => {
    el.scrollTo({ left: targetLeft, behavior: 'smooth' })
  })
}

function refresh() {
  loadData()
}

onMounted(() => {
  window.addEventListener('pointermove', onWindowPointerMove)
  window.addEventListener('pointerup', onWindowPointerUp)
  document.addEventListener('pointerdown', closeWorkerMenu)
  if (hasFetcher.value) loadData()
  nextTick(() => {
    const initLeft = Math.max(0, (todayIndex.value - 4) * props.dayWidth)
    scrollRefs.forEach((el) => { el.scrollLeft = initLeft })
  })
})

onBeforeUnmount(() => {
  window.removeEventListener('pointermove', onWindowPointerMove)
  window.removeEventListener('pointerup', onWindowPointerUp)
  document.removeEventListener('pointerdown', closeWorkerMenu)
  clearTimeout(toastTimer)
})

defineExpose({
  refresh,
  scrollToToday,
  loading,
})
</script>

<style scoped>
/* ═══════════════════════════════════════════
   BNR Gantt — ${namespace}-gantt
   可编辑项目甘特图组件
   ═══════════════════════════════════════════ */

.${namespace}-gantt {
  position: relative;
  display: flex;
  flex-direction: column;
  min-height: 0;
  overflow: hidden;
  border: 1px solid var(--${namespace}-border);
  background: var(--${namespace}-bg-page);
  font-family: var(--${namespace}-font, "Microsoft YaHei", sans-serif);
  font-size: 12px;
  color: var(--${namespace}-text);
}

/* ── 加载遮罩 ── */
.${namespace}-gantt__loading-mask {
  position: absolute;
  inset: 0;
  z-index: 20;
  display: flex;
  align-items: center;
  justify-content: center;
  background: rgba(255, 255, 255, 0.6);
}
.${namespace}-gantt__loading-text {
  padding: 8px 20px;
  background: var(--${namespace}-primary-bg);
  border: 1px solid var(--${namespace}-primary-border);
  border-radius: var(--${namespace}-radius-sm);
  font-size: 12px;
  color: var(--${namespace}-primary);
}

/* ── 工具栏 ── */
.${namespace}-gantt__toolbar {
  justify-content: space-between;
  border-bottom: 1px solid var(--${namespace}-border-light);
}
.${namespace}-gantt__title {
  font-weight: bold;
  font-size: 13px;
  color: var(--${namespace}-primary);
}
.${namespace}-gantt__toolbar-actions {
  display: flex;
  align-items: center;
  gap: 6px;
}

/* ── 列表区 ── */
.${namespace}-gantt__list {
  flex: 1;
  min-height: 0;
  overflow-y: auto;
  padding: var(--${namespace}-sp-md);
  display: flex;
  flex-direction: column;
  gap: 8px;
}

.${namespace}-gantt__card {
  border-left: 3px solid var(--gantt-ac, var(--${namespace}-primary));
}
.${namespace}-gantt__card-head {
  gap: 8px;
}
.${namespace}-gantt__proj-title {
  font-weight: bold;
  color: var(--${namespace}-primary);
  cursor: pointer;
}
.${namespace}-gantt__proj-input {
  width: 240px;
  flex: none;
}

.${namespace}-gantt__body {
  display: flex;
  border-top: 1px solid var(--${namespace}-border-light);
  background: var(--${namespace}-bg);
}

/* ── 左侧固定任务表 ── */
.${namespace}-gantt__left {
  width: 540px;
  flex-shrink: 0;
  border-right: 1px solid var(--${namespace}-border);
  display: flex;
  flex-direction: column;
}
.${namespace}-gantt__left-subhead {
  height: 26px;
  padding: 0 8px;
  display: flex;
  align-items: center;
  font-size: 11px;
  color: var(--${namespace}-text-muted);
  background: #fafbfd;
  border-bottom: 1px solid var(--${namespace}-border-light);
}

.${namespace}-gantt__th,
.${namespace}-gantt__row {
  display: grid;
  grid-template-columns: 170px 52px 46px 76px 76px 42px 36px;
  align-items: center;
  padding: 0 6px;
  column-gap: 6px;
}

.${namespace}-gantt__th {
  height: 28px;
  background: var(--${namespace}-primary-bg);
  color: var(--${namespace}-primary);
  font-weight: bold;
  font-size: 11px;
  border-bottom: 1px solid var(--${namespace}-primary-border);
}

.${namespace}-gantt__row {
  height: 30px;
  border-bottom: 1px solid var(--${namespace}-border-light);
}
.${namespace}-gantt__row:nth-child(even) {
  background: #f7fafc;
}
.${namespace}-gantt__row:hover {
  background: #ddeeff;
}

.${namespace}-gantt__inline-input {
  width: 100%;
  height: 22px;
  border: 1px solid transparent;
  background: transparent;
  font-family: var(--${namespace}-font);
  font-size: 12px;
  color: var(--${namespace}-text);
  padding: 0 4px;
  outline: none;
  border-radius: var(--${namespace}-radius-sm);
}
.${namespace}-gantt__inline-input:focus {
  border-color: var(--${namespace}-primary);
  background: var(--${namespace}-bg);
}

.${namespace}-gantt__pct-input {
  width: 34px;
  height: 20px;
  border: 1px solid transparent;
  background: transparent;
  font-family: var(--${namespace}-mono);
  font-size: 11px;
  text-align: right;
  color: var(--${namespace}-text);
  outline: none;
  border-radius: var(--${namespace}-radius-sm);
}
.${namespace}-gantt__pct-input.is-zero {
  color: var(--${namespace}-text-light);
}
.${namespace}-gantt__pct-input:focus {
  border-color: var(--${namespace}-primary);
  background: var(--${namespace}-bg);
}

.${namespace}-gantt__avatar {
  width: 22px;
  height: 22px;
  border-radius: 50%;
  border: 1px solid var(--${namespace}-bg);
  color: #ffffff;
  font-size: 10px;
  font-weight: bold;
  display: inline-flex;
  align-items: center;
  justify-content: center;
  cursor: pointer;
  box-shadow: 0 0 0 1px var(--${namespace}-border-light);
}
.${namespace}-gantt__avatar--sm {
  width: 20px;
  height: 20px;
}

.${namespace}-gantt__date {
  position: relative;
  display: inline-block;
  cursor: pointer;
  color: var(--${namespace}-text);
}
.${namespace}-gantt__date:hover {
  color: var(--${namespace}-primary);
  text-decoration: underline;
}
.${namespace}-gantt__date input[type="date"] {
  position: absolute;
  inset: 0;
  opacity: 0;
  width: 100%;
  cursor: pointer;
}

.${namespace}-gantt__mono {
  font-family: var(--${namespace}-mono);
  font-size: 11px;
}
.${namespace}-gantt__days {
  color: var(--${namespace}-text-muted);
  padding-right: 4px;
}

.${namespace}-gantt__del-btn {
  width: 18px;
  height: 18px;
  border: 1px solid transparent;
  background: transparent;
  color: var(--${namespace}-text-light);
  border-radius: var(--${namespace}-radius-sm);
  cursor: pointer;
  font-size: 13px;
  line-height: 16px;
}
.${namespace}-gantt__del-btn:hover {
  color: var(--${namespace}-danger);
  background: var(--${namespace}-danger-bg);
  border-color: var(--${namespace}-danger-border);
}

.${namespace}-gantt__empty,
.${namespace}-gantt__empty-all {
  padding: 20px;
  text-align: center;
  color: var(--${namespace}-text-light);
}

/* ── 右侧时间轴 ── */
.${namespace}-gantt__right {
  flex: 1;
  min-width: 0;
}
.${namespace}-gantt__scroll {
  overflow-x: auto;
  overflow-y: hidden;
}
.${namespace}-gantt__canvas {
  position: relative;
}

.${namespace}-gantt__months {
  height: 26px;
  display: flex;
  background: #fafbfd;
  border-bottom: 1px solid var(--${namespace}-border-light);
}
.${namespace}-gantt__month-cell {
  border-right: 1px solid var(--${namespace}-border-light);
  display: flex;
  align-items: center;
  padding-left: 8px;
  font-size: 11px;
  font-weight: bold;
  color: var(--${namespace}-text-muted);
}
.${namespace}-gantt__month-cell span {
  position: sticky;
  left: 8px;
}

.${namespace}-gantt__days-head {
  height: 28px;
  display: flex;
  background: var(--${namespace}-primary-bg);
  border-bottom: 1px solid var(--${namespace}-primary-border);
}
.${namespace}-gantt__day-cell {
  flex: none;
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  font-size: 10px;
  line-height: 1.1;
  color: var(--${namespace}-primary);
  border-right: 1px solid rgba(208, 216, 232, 0.5);
}
.${namespace}-gantt__day-cell.is-weekend {
  background: rgba(28, 40, 51, 0.04);
  color: var(--${namespace}-text-light);
}
.${namespace}-gantt__day-cell.is-today {
  background: var(--${namespace}-primary);
  color: #ffffff;
  font-weight: bold;
}

.${namespace}-gantt__grid {
  position: relative;
  background-image: linear-gradient(var(--${namespace}-border-light) 1px, transparent 1px);
  background-position: 0 29px;
}
.${namespace}-gantt__weekend-bg {
  position: absolute;
  top: 0;
  bottom: 0;
  background: rgba(28, 40, 51, 0.025);
  pointer-events: none;
}

.${namespace}-gantt__today-line {
  position: absolute;
  top: 0;
  bottom: 0;
  width: 1px;
  background: var(--${namespace}-danger);
  z-index: 3;
  pointer-events: none;
}
.${namespace}-gantt__today-tag {
  position: absolute;
  top: 0;
  left: 2px;
  background: var(--${namespace}-danger);
  color: #ffffff;
  font-size: 9px;
  padding: 0 3px;
  border-radius: 1px;
  white-space: nowrap;
}

/* ── 甘特条 ── */
.${namespace}-gantt__bar {
  position: absolute;
  height: 20px;
  border-radius: var(--${namespace}-radius-sm);
  background: var(--gantt-bar, var(--${namespace}-primary-hover));
  border: 1px solid var(--gantt-ac, var(--${namespace}-primary));
  display: flex;
  align-items: center;
  cursor: grab;
  user-select: none;
  touch-action: none;
  z-index: 2;
}
.${namespace}-gantt__bar.is-readonly {
  cursor: default;
}
.${namespace}-gantt__bar:active:not(.is-readonly) {
  cursor: grabbing;
}
.${namespace}-gantt__bar.is-target {
  outline: 2px solid var(--${namespace}-danger);
}

.${namespace}-gantt__bar-pg {
  position: absolute;
  left: 0;
  top: 0;
  bottom: 0;
  background: var(--gantt-ac, var(--${namespace}-primary));
  opacity: 0.28;
  pointer-events: none;
}

.${namespace}-gantt__bar-label {
  position: relative;
  padding: 0 6px;
  font-size: 11px;
  color: var(--${namespace}-text);
  white-space: nowrap;
  pointer-events: none;
}
.${namespace}-gantt__bar.is-out .${namespace}-gantt__bar-label {
  position: absolute;
  left: 100%;
  padding-left: 6px;
}

.${namespace}-gantt__handle {
  position: absolute;
  top: 0;
  bottom: 0;
  width: 6px;
  cursor: ew-resize;
  z-index: 2;
}
.${namespace}-gantt__handle--l { left: 0; }
.${namespace}-gantt__handle--r { right: 0; }
.${namespace}-gantt__bar:hover .${namespace}-gantt__handle {
  background: rgba(26, 79, 138, 0.2);
}

.${namespace}-gantt__link-dot {
  position: absolute;
  right: -6px;
  top: 50%;
  transform: translateY(-50%);
  width: 10px;
  height: 10px;
  border-radius: 50%;
  background: var(--${namespace}-bg);
  border: 2px solid var(--gantt-ac, var(--${namespace}-primary));
  cursor: crosshair;
  display: none;
  z-index: 3;
}
.${namespace}-gantt__bar:hover .${namespace}-gantt__link-dot {
  display: block;
}

/* ── SVG 依赖连线 ── */
.${namespace}-gantt__svg {
  position: absolute;
  left: 0;
  top: 0;
  pointer-events: none;
  overflow: visible;
  z-index: 1;
}
.${namespace}-gantt__dep-line {
  fill: none;
  stroke: var(--gantt-ac, var(--${namespace}-primary));
  stroke-width: 1.5;
}
.${namespace}-gantt__dep-hit {
  fill: none;
  stroke: transparent;
  stroke-width: 10;
  pointer-events: stroke;
  cursor: pointer;
}
.${namespace}-gantt__dep-tmp {
  fill: none;
  stroke: var(--${namespace}-danger);
  stroke-width: 1.5;
  stroke-dasharray: 4 3;
}

/* ── 负责人选择浮层 ── */
.${namespace}-gantt__worker-menu {
  position: fixed;
  z-index: 200;
  background: var(--${namespace}-bg);
  border: 1px solid var(--${namespace}-border);
  border-radius: var(--${namespace}-radius-sm);
  box-shadow: var(--${namespace}-shadow-md);
  padding: 4px;
  min-width: 120px;
}
.${namespace}-gantt__worker-item {
  display: flex;
  align-items: center;
  gap: 6px;
  padding: 4px 6px;
  cursor: pointer;
  border-radius: var(--${namespace}-radius-sm);
  font-size: 12px;
}
.${namespace}-gantt__worker-item:hover,
.${namespace}-gantt__worker-item.is-active {
  background: var(--${namespace}-primary-bg);
  color: var(--${namespace}-primary);
}

/* ── 轻提示 ── */
.${namespace}-gantt__toast {
  position: fixed;
  left: 50%;
  bottom: 24px;
  transform: translateX(-50%);
  background: var(--${namespace}-primary-dark);
  color: #ffffff;
  padding: 6px 14px;
  border-radius: var(--${namespace}-radius-sm);
  font-size: 12px;
  z-index: 300;
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.2);
}
</style>