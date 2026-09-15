<template>
  <!-- 如果是登录页面，直接全屏渲染，不加载 mainframe 外壳 -->
  <router-view v-if="isLoginPage" />

  <!-- 标准 TADA Mainframe 外壳 -->
  <div v-else class="${namespace}-shell">

    <!-- 1. 顶部固定 Topbar -->
    <header class="${namespace}-topbar">
      <!-- 品牌 Logo 区域 -->
      <div class="${namespace}-logo">
        <div class="${namespace}-logo-badge">🌱</div>
        <span>如期<em>v2.8</em></span>
      </div>

      <!-- 顶部模块切换 Tab (tnav) -->
      <div 
        v-for="m in modules" 
        :key="m.key"
        class="${namespace}-tnav"
        :class="{ '${namespace}-active': activeModule === m.key }"
        @click="switchModule(m.key)">
        {{ m.label }}
      </div>

      <!-- 顶部右侧槽位：小柴桌宠互动 + 时钟 + 用户信息 -->
      <div class="${namespace}-topbar-right">
        <!-- 桌面小宠交互胶囊 -->
        <div class="${namespace}-pet-capsule" @click="petCompanion">
          <span class="${namespace}-pet-avatar">🐶</span>
          <span style="font-size: 11px; font-weight: 900; color: var(--${namespace}-gold-dark);">
            {{ currentPetQuote }}
          </span>
        </div>

        <!-- 系统时钟 -->
        <span style="font-family: var(--${namespace}-mono); font-weight: 700; color: var(--${namespace}-text-muted);">
          {{ clock }}
        </span>

        <!-- 登录用户及退出 -->
        <span class="${namespace}-tag ${namespace}-tag--primary" style="padding: 4px 10px; cursor: pointer;" @click="logout">
          <i class="fa-solid fa-user-ninja" style="margin-right: 4px;"></i>{{ username }} [退出]
        </span>
      </div>
    </header>

    <!-- 2. 主工作区布局 (Sidebar + Content) -->
    <div class="${namespace}-main">

      <!-- 左侧：定宽、自身独立滚动 Sidebar -->
      <aside class="${namespace}-sidebar">
        <div>
          <!-- 动态渲染菜单分区 -->
          <template v-for="(sec, sIdx) in currentSections" :key="sIdx">
            <div class="${namespace}-nav-section">{{ sec.title || '任务与目标' }}</div>
            <div 
              v-for="item in sec.items" 
              :key="item.id"
              class="${namespace}-nav-item"
              :class="{ '${namespace}-active': activeId === item.id }"
              @click="selectItem(item)">
              <div style="display: flex; align-items: center; gap: 8px;">
                <i :class="item.icon || 'fa-regular fa-folder'"></i>
                <span>{{ item.label }}</span>
              </div>
              <span v-if="item.badge" class="${namespace}-tag ${namespace}-tag--neutral">
                {{ item.badge }}
              </span>
            </div>
          </template>
        </div>

        <!-- 侧边栏底部常驻状态 -->
        <div style="padding: 10px 14px; border-top: 2px solid var(--${namespace}-border-light);">
          <div class="${namespace}-alert" style="padding: 8px 10px; font-size: 11px; justify-content: center;">
            <i class="fa-regular fa-bell"></i> 每天 09:00 晨间提醒
          </div>
        </div>
      </aside>

      <!-- 右侧：Content 展示区 -->
      <section class="${namespace}-content">
        
        <!-- 面包屑与记录导航栏 -->
        <div class="${namespace}-breadcrumb">
          <span>当前位置：</span>
          <a href="javascript:void(0)">{{ currentModuleLabel }}</a>
          <span>&gt;</span>
          <span>{{ breadPage }}</span>

          <!-- 经典微翻页组件 -->
          <div class="${namespace}-record-nav" v-if="showPrevNext">
            <button class="${namespace}-rn-btn" @click="prevRecord">
              <i class="fa-solid fa-chevron-left" style="font-size: 10px; margin-right: 2px;"></i>上一个
            </button>
            <span class="${namespace}-rn-idx">1 / 4</span>
            <button class="${namespace}-rn-btn" @click="nextRecord">
              下一个<i class="fa-solid fa-chevron-right" style="font-size: 10px; margin-left: 2px;"></i>
            </button>
          </div>
        </div>

        <!-- 页面自滚动主区 -->
        <main class="${namespace}-page">
          
          <!-- 路由出口 (业务子页面优先挂载到这里) -->
          <router-view />

          <!-- 如果业务子页面为空，默认渲染的“今日推进总览”面板 (使用 100% 规范 class) -->
          <div v-if="route.path === '/' || route.path === '/home'" style="display: flex; flex-direction: column; gap: 14px;">
            
            <!-- SMART 快速输入面板 -->
            <div class="${namespace}-panel">
              <div class="${namespace}-panel-head">
                <span>🎯 今日核心目标快速拆解 (SMART 策略)</span>
                <div style="margin-left: auto; display: flex; gap: 8px;">
                  <span class="${namespace}-tag ${namespace}-tag--primary">微启动模式</span>
                </div>
              </div>

              <div class="${namespace}-form">
                <div class="${namespace}-field ${namespace}-field--span2">
                  <label class="${namespace}-field-label ${namespace}-field-label--required">目标愿望内容</label>
                  <input type="text" v-model="goalInput" class="${namespace}-input" placeholder="输入要拆解的大目标...">
                </div>

                <div class="${namespace}-field">
                  <label class="${namespace}-field-label ${namespace}-field-label--required">约定截止日期</label>
                  <input type="date" v-model="goalDeadline" class="${namespace}-input">
                </div>

                <div class="${namespace}-field" style="justify-content: flex-end; align-items: flex-end;">
                  <div style="display: flex; gap: 8px; width: 100%;">
                    <button class="${namespace}-btn ${namespace}-btn--primary" style="flex: 1;" @click="fireConfetti">
                      <i class="fa-solid fa-wand-magic-sparkles"></i> 存入愿望
                    </button>
                    <button class="${namespace}-btn ${namespace}-btn--default" @click="fireConfetti">
                      ⚡ 5min微启动
                    </button>
                  </div>
                </div>
              </div>
            </div>

            <!-- 今日推荐推进伴随提示条 (Alert) -->
            <div class="${namespace}-alert">
              <i class="fa-solid fa-bell animate-wiggle"></i>
              <span style="font-weight: 900;">🎯 推进提示：</span>
              <span>「某三期项目景观施工图」进度已达 58%，下一步请执行：施工图绘制深化。</span>
              <div style="margin-left: auto; display: flex; gap: 8px;">
                <button class="${namespace}-btn ${namespace}-btn--default ${namespace}-btn--sm" @click="fireConfetti">
                  5分钟微启动
                </button>
                <button class="${namespace}-btn ${namespace}-btn--primary ${namespace}-btn--sm" @click="fireConfetti">
                  打卡记录
                </button>
              </div>
            </div>

            <!-- 目标卡片多维网格 (利用 24 栅格体系) -->
            <div class="${namespace}-row">
              <div 
                v-for="card in projectCards" 
                :key="card.id" 
                class="${namespace}-col-12"
                style="margin-bottom: 14px;">
                <div class="${namespace}-panel" style="padding: 16px;">
                  <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 8px;">
                    <div style="font-size: 14px; font-weight: 900; color: var(--${namespace}-text);">
                      <span style="margin-right: 4px;">{{ card.icon }}</span> {{ card.title }}
                    </div>
                    <span class="${namespace}-tag ${namespace}-tag--primary">{{ card.progress }}%</span>
                  </div>

                  <div style="font-size: 11px; color: var(--${namespace}-text-light); margin-bottom: 10px;">
                    截止时间: {{ card.deadline }} · 子任务 {{ card.subNodes }}
                  </div>

                  <!-- 细致进度条 -->
                  <div class="${namespace}-progress-bar" style="margin-bottom: 12px;">
                    <div class="${namespace}-progress-fill" :style="{ width: card.progress + '%' }"></div>
                  </div>

                  <div style="display: flex; justify-content: space-between; align-items: center;">
                    <span style="font-size: 12px; font-weight: 800; color: var(--${namespace}-text-muted);">
                      下一步: <span style="color: var(--${namespace}-primary-dark);">{{ card.nextTask }}</span>
                    </span>
                    <button class="${namespace}-btn ${namespace}-btn--default ${namespace}-btn--sm" @click="fireConfetti">
                      ✍️ 记录打卡
                    </button>
                  </div>
                </div>
              </div>
            </div>

          </div>

        </main>

        <!-- 底部状态指示栏 (Status Bar) -->
        <footer class="${namespace}-statusbar">
          <div style="display: flex; align-items: center; gap: 8px;">
            <span class="${namespace}-tag ${namespace}-tag--warning" style="border: none;">🐾 陪伴小柴在线</span>
            <span>今天的小步前进，正在化为明天的底气 ✨</span>
          </div>
          <div>如期 (Stepaw) 数字化自律系统 · 运行良好</div>
        </footer>

      </section>

    </div>

    <!-- 全局反馈弹窗组件 -->
    <${js.nameType(namespace)}Feedback />

  </div>
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
const activeModule = ref(modules[0].key)
const activeId     = ref(MENUS[modules[0].key].sections[0].items[0].id)
const activePath   = ref(MENUS[modules[0].key].sections[0].items[0].path)
const breadPage    = ref(MENUS[modules[0].key].sections[0].items[0].label)
const clock        = ref('')
const username     = ref(localStorage.getItem('username') || '旅行者')

const currentSections    = computed(() => MODULE_LIST.flatMap(m => MENUS[m.key].sections))
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
  breadPage.value  = item.label.replace(/^└\s*/, '')
  router.push(item.path || '/')
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

// 示例数据模型
const goalInput = ref('岗位: AWS架构师准备 / 景观方案深化 / 雅思口语7分')
const goalDeadline = ref('2026-09-19')

const projectCards = ref([
  { id: 1, icon: '🏡', title: '某三期工程景观施工图', progress: 58, deadline: '2026-08-23', nextTask: '施工图绘制深化 📐', subNodes: '1/1' },
  { id: 2, icon: '🛍️', title: '某商业金街效果图深化', progress: 25, deadline: '2026-08-23', nextTask: '主材打样效果图 🎨', subNodes: '1/2' },
  { id: 3, icon: '🌿', title: '某产业园区方案汇报', progress: 58, deadline: '2026-08-23', nextTask: '商务造价清单审核 📊', subNodes: '1/1' },
  { id: 4, icon: '🍁', title: '某秋季新品品牌策划', progress: 67, deadline: '2026-12-08', nextTask: '与甲方沟通初审方案 💡', subNodes: '1/1' },
])

// 小柴互动台词
const petQuotes = [
  "汪！摸摸头，今天也超级棒！✨",
  "哪怕只前进一步也很厉害啦！🐾",
  "喝口水，稍微活动下肩膀吧 🍵",
  "今天的小柴也是你的头号粉丝！⭐"
]
const currentPetQuote = ref(petQuotes[0])

function petCompanion() {
  fireConfetti()
  const randomIdx = Math.floor(Math.random() * petQuotes.length)
  currentPetQuote.value = petQuotes[randomIdx]
}

// 彩屑粒子特效
function fireConfetti() {
  if (typeof window !== 'undefined' && window.confetti) {
    window.confetti({
      particleCount: 50,
      spread: 60,
      origin: { y: 0.7 },
      colors: ['#34D399', '#10B981', '#FBBF24', '#F43F5E', '#8B5CF6']
    })
  }
}
</script>