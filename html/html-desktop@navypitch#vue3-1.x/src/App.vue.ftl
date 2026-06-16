<template>
  <router-view v-if="isLoginPage" />
  <div v-else class="app-shell">
    <!-- ═══════════ SIDEBAR ═══════════ -->
    <aside class="sidebar">
      <!-- Logo -->
      <div class="sidebar-logo">
        <div class="logo-icon">⚡</div>
        <div class="logo-text">
          <div class="logo-name">营销管理系统</div>
          <div class="logo-sub">某市供电公司</div>
        </div>
      </div>

      <!-- 动态导航（来自 menu.js） -->
      <div class="sidebar-nav">
        <template v-for="sec in currentSections" :key="sec.title">
          <div class="sidebar-section-label">{{ sec.title }}</div>
          <div
            v-for="item in sec.items" :key="item.id"
            class="nav-item"
            :class="{ active: activeId === item.id }"
            :style="item.indent ? { paddingLeft: (16 + item.indent * 12) + 'px' } : {}"
            @click="selectItem(item)"
          >
            <span class="nav-icon">📋</span>
            <span>{{ item.label }}</span>
            <span v-if="item.badge" class="nav-badge">{{ item.badge }}</span>
          </div>
        </template>
      </div>

      <!-- 侧边栏底部用户信息 -->
      <div class="sidebar-footer">
        <div class="avatar-sm">{{ username.charAt(0) }}</div>
        <div class="footer-info">
          <div class="footer-name">{{ username }}</div>
          <div class="footer-role">客服中心</div>
        </div>
        <span class="footer-dots" @click="logout" title="退出登录">⏻</span>
      </div>
    </aside>

    <!-- ═══════════ MAIN ═══════════ -->
    <div class="main">
      <!-- Topbar -->
      <div class="topbar">
        <!-- 模块切换 tabs -->
        <div class="topbar-modules">
          <span
            v-for="m in modules" :key="m.key"
            class="topbar-module-tab"
            :class="{ active: activeModule === m.key }"
            @click="switchModule(m.key)"
          >{{ m.label }}</span>
        </div>
        <div class="topbar-title">{{ breadPage }}</div>
        <div class="topbar-actions">
          <span class="topbar-clock">{{ clock }}</span>
          <div class="icon-btn" title="通知">🔔</div>
          <span class="topbar-user">👤 {{ username }} / 客服中心</span>
          <span class="topbar-logout" @click="logout">退出</span>
        </div>
      </div>
      <!-- Content area -->
      <div class="content">
        <div class="app-page">
          <router-view />
        </div>
      </div>
    </div>
  </div>
  <ef-feedback :dialog="dialog" :on-close="close" />
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

const modules = MODULE_LIST;
const activeModule = ref(modules[0].key)
const activeId     = ref(MENUS[modules[0].key].sections[0].items[0].id)
const activePath   = ref(MENUS[modules[0].key].sections[0].items[0].path)
const breadPage    = ref(MENUS[modules[0].key].sections[0].items[0].label)
const clock        = ref('')
const username     = ref(localStorage.getItem('username') || '张伟')

const currentSections    = computed(() => MENUS[activeModule.value].sections)
const currentModuleLabel = computed(() => MENUS[activeModule.value].label)

function switchModule(key) {
  activeModule.value = key
  const first = MENUS[key].sections[0].items[0]
  activeId.value   = first.id
  activePath.value = first.path || ''
  breadPage.value  = first.label.replace(/^└\s*/, '')
}

function selectItem(item) {
  if (item.disabled) return
  activeId.value   = item.id
  activePath.value = item.path || ''
  breadPage.value  = item.label.replace(/^└\s*/, '');
  router.push(item.path || '/');
}

let timer
function tick() {
  const now = new Date()
  const p = n => String(n).padStart(2, '0')
  clock.value = ${r"`${now.getFullYear()}-${p(now.getMonth()+1)}-${p(now.getDate())} ${p(now.getHours())}:${p(now.getMinutes())}:${p(now.getSeconds())}`"}
}
onMounted(() => { tick(); timer = setInterval(tick, 1000) })
onBeforeUnmount(() => clearInterval(timer))

// 退出登录
function logout() {
  localStorage.removeItem('isLoggedIn')
  localStorage.removeItem('username')
  router.push('/login')
}
</script>

<style scoped>
/* ═══════════════════════════════════════════════════════════════════════════
   Sidebar — 补充全局 CSS 未覆盖的样式
   ═══════════════════════════════════════════════════════════════════════════ */

.sidebar-nav {
  flex: 1;
  overflow-y: auto;
  overflow-x: hidden;
  padding-bottom: var(--space-5);
  scrollbar-width: thin;
  scrollbar-color: rgba(255,255,255,0.12) transparent;
}

/* ═══════════════════════════════════════════════════════════════════════════
   Topbar — 模块切换 tabs
   ═══════════════════════════════════════════════════════════════════════════ */

.topbar-modules {
  display: flex;
  align-items: center;
  gap: var(--space-2);
  padding-right: var(--space-9);
  border-right: 1px solid var(--color-border);
  margin-right: var(--space-4);
}

.topbar-module-tab {
  padding: var(--space-4) var(--space-7);
  font-size: var(--text-md);
  font-weight: var(--weight-medium);
  color: var(--color-text-sub);
  cursor: pointer;
  border-radius: var(--radius-md);
  transition: all var(--transition-base);
  white-space: nowrap;
  user-select: none;
}

.topbar-module-tab:hover {
  color: var(--color-text-main);
  background: var(--color-surface);
}

.topbar-module-tab.active {
  color: #fff;
  background: var(--color-teal);
  font-weight: var(--weight-bold);
}

/* ═══════════════════════════════════════════════════════════════════════════
   Topbar — 右侧信息
   ═══════════════════════════════════════════════════════════════════════════ */

.topbar-clock {
  font-size: var(--text-md);
  color: var(--color-text-sub);
  font-variant-numeric: tabular-nums;
  white-space: nowrap;
}

.topbar-user {
  font-size: var(--text-md);
  color: var(--color-text-sub);
  white-space: nowrap;
}

.topbar-logout {
  font-size: var(--text-md);
  color: var(--color-red);
  cursor: pointer;
  font-weight: var(--weight-semibold);
  white-space: nowrap;
  transition: color var(--transition-base);
}

.topbar-logout:hover {
  color: var(--color-red-text);
}

/* ═══════════════════════════════════════════════════════════════════════════
   Content — 面包屑 + 上下条导航
   ═══════════════════════════════════════════════════════════════════════════ */

#app {
  flex: 1;          /* 作为 body 的 flex 子项，撑满可用宽度 */
  display: flex;    /* 让 .app-shell 撑满 #app */
}

.app-shell {
  flex: 1;          /* 撑满 #app */
  display: flex;    /* 让 .main 的 flex:1 生效，填满右侧剩余宽度 */
}

.app-breadcrumb {
  display: flex;
  align-items: center;
  gap: var(--space-4);
  font-size: var(--text-md);
  color: var(--color-text-sub);
  margin-bottom: var(--space-9);
  flex-wrap: wrap;
}

.app-breadcrumb a {
  color: var(--color-teal);
  cursor: pointer;
  text-decoration: none;
}

.app-breadcrumb a:hover {
  text-decoration: underline;
}

.app-record-nav {
  display: flex;
  align-items: center;
  gap: var(--space-4);
  margin-left: auto;
}

.app-rn-idx {
  font-size: var(--text-sm);
  color: var(--color-text-muted);
  font-variant-numeric: tabular-nums;
}

.app-page {
  animation: fadeIn var(--transition-smooth);
}

@keyframes fadeIn {
  from { opacity: 0; transform: translateY(4px); }
  to   { opacity: 1; transform: translateY(0); }
}
</style>
