<template>
  <router-view v-if="isLoginPage" />
  <div v-else class="${namespace}-shell">
    <!-- Topbar: 蓝图工程仪表台 -->
    <header class="${namespace}-topbar">
      <!-- 极客 Logo -->
      <div class="${namespace}-logo">
        <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2" stroke-linecap="round" stroke-linejoin="round" style="margin-right: 2px;">
          <polygon points="12 2 2 7 12 12 22 7 12 2"></polygon>
          <polyline points="2 17 12 22 22 17"></polyline>
          <polyline points="2 12 12 17 22 12"></polyline>
        </svg>
        <span>ENTERPRISE <em>SYSTEM</em></span>
      </div>

      <!-- 顶栏模块导航 -->
      <nav class="${namespace}-topbar-modules" style="display: flex; height: 100%;">
        <div
          v-for="m in modules" :key="m.key"
          class="${namespace}-tnav" :class="{ '${namespace}-active': activeModule === m.key }"
          @click="switchModule(m.key)"
        >
          {{ m.label }}
        </div>
      </nav>

      <!-- 系统诊断/遥测微状态 -->
      <div class="${namespace}-progress-strip" style="margin-left: 12px; display: none; @media(min-width: 1200px){display: flex;}">
        <span style="color: var(--${namespace}-text-light);">SYS.STATUS</span>
        <div class="${namespace}-progress-strip-bars">
          <span class="${namespace}-progress-strip-bar active"></span>
          <span class="${namespace}-progress-strip-bar active"></span>
          <span class="${namespace}-progress-strip-bar active"></span>
          <span class="${namespace}-progress-strip-bar"></span>
        </div>
        <span style="color: var(--${namespace}-success); font-weight: 700;">NORMAL</span>
      </div>

      <!-- 顶栏右侧状态与用户信息 -->
      <div class="${namespace}-topbar-right">
        <!-- 终端等宽时钟 -->
        <span class="${namespace}-clock">{{ clock }}</span>
        
        <!-- 环境标签 -->
        <span class="${namespace}-tag ${namespace}-tag--primary" style="font-size: 9px;">PROD</span>

        <!-- 用户名胶囊 -->
        <div class="${namespace}-user-badge" style="display: flex; align-items: center; gap: 6px; font-family: var(--${namespace}-mono); font-size: 11px;">
          <span class="${namespace}-status-dot" style="background: var(--${namespace}-success);"></span>
          <span style="font-weight: 700; color: var(--${namespace}-text);">{{ username }}</span>
          <span style="color: var(--${namespace}-text-light);">/ OPS</span>
        </div>

        <!-- 退出动作项 -->
        <button 
          class="${namespace}-btn ${namespace}-btn--sm" 
          style="border-color: var(--${namespace}-danger-border); color: var(--${namespace}-danger); height: 22px; padding: 0 8px;"
          @click="logout"
          title="Disconnect Session"
        >
          EXIT
        </button>
      </div>
    </header>

    <!-- 主体区域 -->
    <div class="${namespace}-main">
      <!-- 协议树状侧边栏 (Sidebar) -->
      <nav class="${namespace}-sidebar">
        <!-- 侧边栏顶部小标 -->
        <div style="padding: 10px 12px 6px; font-family: var(--${namespace}-mono); font-size: 11px; font-weight: 800; color: var(--${namespace}-primary); display: flex; justify-content: space-between; align-items: center; border-bottom: 1.5px solid var(--${namespace}-border-light);">
          <span>EXPLORER</span>
          <span style="font-size: 12px; color: var(--${namespace}-text-light);">•••</span>
        </div>

        <template v-for="sec in currentSections" :key="sec.title">
          <div class="${namespace}-nav-section">{{ sec.title }}</div>
          <div
            v-for="item in sec.items" :key="item.id"
            class="${namespace}-nav-item"
            :class="{ '${namespace}-active': activeId === item.id }"
            :style="item.indent ? { paddingLeft: (14 + item.indent * 12) + 'px' } : {}"
            @click="selectItem(item)"
          >
            <div style="display: flex; align-items: center; gap: 8px; overflow: hidden; text-overflow: ellipsis; white-space: nowrap;">
              <!-- 协议状态微圆点 -->
              <span 
                style="width: 6px; height: 6px; border-radius: 50%; border: 1.5px solid var(--${namespace}-border-dark); flex-shrink: 0;"
                :style="activeId === item.id ? { background: 'var(--${namespace}-primary)', borderColor: 'var(--${namespace}-primary)' } : {}"
              ></span>
              <span>{{ item.label }}</span>
            </div>
            
            <!-- 蓝图风格的极客 Badge 或箭头 -->
            <span v-if="item.badge" class="${namespace}-tag ${namespace}-tag--danger" style="font-size: 9px; padding: 0 4px;">{{ item.badge }}</span>
            <span v-else style="font-size: 10px; color: var(--${namespace}-text-light); opacity: 0.6;">›</span>
          </div>
        </template>
      </nav>

      <!-- 核心内容展示区 (Content) -->
      <div class="${namespace}-content">
        <!-- 蓝图代码风格面包屑 -->
        <div class="${namespace}-breadcrumb">
          <span style="color: var(--${namespace}-text-light);">LOC:</span>
          <a>[ ROOT ]</a>
          <span style="color: var(--${namespace}-border);">/</span>
          <a>{{ currentModuleLabel }}</a>
          <span style="color: var(--${namespace}-border);">/</span>
          <span style="font-weight: 700; color: var(--${namespace}-text);">{{ breadPage }}</span>

          <!-- 报文记录 / 数据项穿梭切换条 -->
          <div v-if="showPrevNext" class="${namespace}-record-nav">
            <button class="${namespace}-rn-btn" :disabled="!hasPrev" @click="goPrev" title="PREV RECORD">
              <span class="${namespace}-rn-arrow ${namespace}-rn-arrow--left">◀</span>
              <span>PREV</span>
            </button>
            <span class="${namespace}-rn-idx"># 01 / 01</span>
            <button class="${namespace}-rn-btn" :disabled="!hasNext" @click="goNext" title="NEXT RECORD">
              <span>NEXT</span>
              <span class="${namespace}-rn-arrow ${namespace}-rn-arrow--right">▶</span>
            </button>
          </div>
        </div>

        <!-- 页面挂载视口容器 -->
        <div class="${namespace}-page">
          <router-view />
        </div>
      </div>
    </div>
  </div>

  <!-- 反馈对话框 -->
  <${namespace}-feedback :dialog="dialog" :on-close="close" />
</template>

<script setup>
import { ref, computed, onMounted, onBeforeUnmount } from 'vue'
import { useRoute } from 'vue-router'
import { useNavControl } from '@/composables/useNavControl'
import { MENUS, MODULE_LIST } from './menu.js'
import router from './router'
import { provideFeedback } from '@/composables/useFeedback.js'
import ${js.nameType(namespace)}Feedback from '@/components/${namespace}-feedback.vue'

const { dialog, success, warning, error, info, confirm, close } = provideFeedback()

const route = useRoute()
const { showPrevNext, show, hide, toggle } = useNavControl()

// 判断是否为登录页
const isLoginPage = computed(() => route.path === '/login')

const modules = MODULE_LIST
const activeModule = ref(modules[0]?.key || '')
const activeId     = ref(MENUS[modules[0]?.key]?.sections[0]?.items[0]?.id || '')
const activePath   = ref(MENUS[modules[0]?.key]?.sections[0]?.items[0]?.path || '')
const breadPage    = ref(MENUS[modules[0]?.key]?.sections[0]?.items[0]?.label || '')
const clock        = ref('')
const username     = ref(localStorage.getItem('username') || 'ADMIN_USER')

const currentSections    = computed(() => MENUS[activeModule.value]?.sections || [])
const currentModuleLabel = computed(() => MENUS[activeModule.value]?.label || '')

function switchModule(key) {
  activeModule.value = key
  const first = MENUS[key]?.sections[0]?.items[0]
  if (first) {
    activeId.value   = first.id
    activePath.value = first.path || ''
    breadPage.value  = first.label.replace(/^└\s*/, '')
    router.push(first.path || '/')
  }
}

function selectItem(item) {
  if (item.disabled) return
  activeId.value   = item.id
  activePath.value = item.path || ''
  breadPage.value  = item.label.replace(/^└\s*/, '')
  router.push(item.path || '/')
}

let timer
function tick() {
  const now = new Date()
  const p = n => String(n).padStart(2, '0')
  // 保持与 FTL 兼容的格式化串输出
  clock.value = `${r"${now.getFullYear()}.${p(now.getMonth()+1)}.${p(now.getDate())} - ${p(now.getHours())}:${p(now.getMinutes())}:${p(now.getSeconds())}"}`
}

onMounted(() => {
  tick()
  timer = setInterval(tick, 1000)
})

onBeforeUnmount(() => clearInterval(timer))

// 退出登录
function logout() {
  localStorage.removeItem('isLoggedIn')
  localStorage.removeItem('username')
  router.push('/login')
}
</script>