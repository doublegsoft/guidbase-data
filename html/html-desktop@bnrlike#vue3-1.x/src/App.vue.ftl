<template>
  <!-- 登录页：直接渲染，不带布局 -->
  <router-view v-if="isLoginPage" />

  <!-- 其他页面：带 sidebar 和 topbar -->
  <div v-else class="${namespace}-shell">
    <div class="${namespace}-topbar">
      <div class="${namespace}-logo">⚡<em>某市供电公司</em> · 营销管理系统</div>
      <div
          v-for="m in modules" :key="m.key"
          class="${namespace}-tnav" :class="{ '${namespace}-active': activeModule === m.key }"
          @click="switchModule(m.key)"
      >{{ m.label }}</div>
      <div class="${namespace}-topbar-right">
        <span class="${namespace}-clock">{{ clock }}</span>
        <span>🔔</span>
        <span>👤 {{ username }} / 客服中心</span>
        <span style="color:#ffd700;cursor:pointer;" @click="logout">退出</span>
      </div>
    </div>

    <div class="${namespace}-main">
      <!-- Sidebar -->
      <nav class="${namespace}-sidebar">
        <template v-for="sec in currentSections" :key="sec.title">
          <div class="${namespace}-nav-section">{{ sec.title }}</div>
          <div
              v-for="item in sec.items" :key="item.id"
              class="${namespace}-nav-item"
              :class="{ '${namespace}-active': activeId === item.id }"
              :style="item.indent ? { paddingLeft: (16 + item.indent * 12) + 'px' } : {}"
              @click="selectItem(item)"
          >
            <span>{{ item.label }}</span>
            <span v-if="item.badge" class="${namespace}-tag ${namespace}-tag--danger" style="font-size:10px">{{ item.badge }}</span>
          </div>
        </template>
      </nav>
      <!-- Content -->
      <div class="${namespace}-content">
        <div class="${namespace}-breadcrumb">
          <a>首页</a><span>/</span>
          <a>{{ currentModuleLabel }}</a><span>/</span>
          <span>{{ breadPage }}</span>
          <div style="margin-left:auto;font-size:11px;color:#909eac">上一条 ◀ &nbsp; ▶ 下一条</div>
        </div>
        <div class="${namespace}-page">
          <router-view />
        </div>
      </div>

    </div>
  </div>
</template>

<script setup>
import { ref, computed, onMounted, onBeforeUnmount } from 'vue'
import { useRoute } from 'vue-router'
import { MENUS, MODULE_LIST } from './menu.js'
import router from './router'

const route = useRoute()

// 判断是否为登录页
const isLoginPage = computed(() => route.path === '/login')

const modules = MODULE_LIST;
const activeModule = ref('customer')
const activeId     = ref('account')
const activePath   = ref('/customer/account')
const breadPage    = ref('账户 (Account)')
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
  clock.value = `${r"${now.getFullYear()}-${p(now.getMonth()+1)}-${p(now.getDate())} ${p(now.getHours())}:${p(now.getMinutes())}:${p(now.getSeconds())}"}`
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
