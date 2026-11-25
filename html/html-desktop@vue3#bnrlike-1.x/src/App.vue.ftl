<template>
  <router-view v-if="isLoginPage" />
  <div v-else class="${namespace}-shell">
    <div class="${namespace}-topbar">
      <div class="${namespace}-logo">⚡<em>某某企业</em> · 某某系统</div>
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
          <a @click="switchModule(modules[0].key)">首页</a><span>/</span>
          <a @click="switchModule(activeModule)">{{ currentModuleLabel }}</a><span>/</span>

          <!-- C 页面：如果有下级页面 D，则 C 变成可点击返回；否则是当前末级 -->
          <a v-if="extraCrumbs.length > 0" @click="backToRootPage(activePath)">{{ breadPage }}</a>
          <span v-else>{{ breadPage }}</span>

          <!-- 追加的 D / E ... 子页面包屑 -->
          <template v-for="(crumb, idx) in extraCrumbs" :key="crumb.path">
            <span>/</span>
            <a v-if="idx < extraCrumbs.length - 1" @click="goToExtraCrumb(idx)">{{ crumb.label }}</a>
            <span v-else>{{ crumb.label }}</span>
          </template>

          <div v-if="showPrevNext" class="${namespace}-record-nav">
            <button class="${namespace}-rn-btn" :disabled="!hasPrev" @click="goPrev" title="上一条">
              <span class="${namespace}-rn-arrow ${namespace}-rn-arrow--left">◀</span>
              <span>上一条</span>
            </button>
            <span class="${namespace}-rn-idx">{{ 1 }} / {{ 1 }}</span>
            <button class="${namespace}-rn-btn" :disabled="!hasNext" @click="goNext" title="下一条">
              <span>下一条</span>
              <span class="${namespace}-rn-arrow ${namespace}-rn-arrow--right">▶</span>
            </button>
          </div>
        </div>
        <div class="${namespace}-page">
          <!-- 关键修改：用 keep-alive 包裹 router-view，只保活 cachedViews 里的 C -->
          <router-view v-slot="{ Component }">
            <keep-alive :include="cachedViews">
              <component :is="Component" :key="route.fullPath" />
            </keep-alive>
          </router-view>
        </div>
      </div>
    </div>
  </div>
  <${namespace}-feedback :dialog="dialog" :on-close="close" />
</template>

<script setup>
import { ref, computed, watch, onMounted, onBeforeUnmount } from 'vue'
import { useRoute } from 'vue-router'
import { useNavControl } from '@/composables/useNavControl'
import { useBreadcrumb } from '@/composables/useBreadcrumb'
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

const {
  extraCrumbs,
  cachedViews,
  backToRootPage,
  goToExtraCrumb,
  resetCrumbs,
  syncOnRouteChange
} = useBreadcrumb()

watch(() => route.fullPath, (newPath) => {
  syncOnRouteChange(newPath, activePath.value)
})

function switchModule(key) {
  activeModule.value = key
  const first = MENUS[key].sections[0].items[0]
  activeId.value   = first.id
  activePath.value = first.path || ''
  breadPage.value  = first.label.replace(/^└\s*/, '')
  if (first.path) router.push(first.path)
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
