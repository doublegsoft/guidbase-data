<template>
  <router-view v-if="isLoginPage" />

  <div v-else class="${namespace}-shell">

    <header class="${namespace}-topbar">
      <div class="${namespace}-logo">
        <div class="${namespace}-logo-badge">🌱</div>
        <span>如期<em>v2.8</em></span>
      </div>

      <div 
        v-for="m in modules" 
        :key="m.key"
        class="${namespace}-tnav"
        :class="{ '${namespace}-active': activeModule === m.key }"
        @click="switchModule(m.key)">
        {{ m.label }}
      </div>

      <div class="${namespace}-topbar-right">
        <div class="${namespace}-pet-capsule" @click="petCompanion">
          <span class="${namespace}-pet-avatar">🐶</span>
          <span style="font-size: 11px; font-weight: 900; color: var(--${namespace}-gold-dark);">
            {{ currentPetQuote }}
          </span>
        </div>

        <span style="font-family: var(--${namespace}-mono); font-weight: 700; color: var(--${namespace}-text-muted);">
          {{ clock }}
        </span>

        <span class="${namespace}-tag ${namespace}-tag--primary" style="padding: 4px 10px; cursor: pointer;" @click="logout">
          <i class="fa-solid fa-user-ninja" style="margin-right: 4px;"></i>{{ username }} [退出]
        </span>
      </div>
    </header>

    <div class="${namespace}-main">

      <aside class="${namespace}-sidebar">
        <div class="${namespace}-nav-card-list">
          <template v-for="(sec, sIdx) in currentSections" :key="sIdx">
            <div v-if="sec.title" class="${namespace}-nav-section-label">
              {{ sec.title }}
            </div>

            <div 
              v-for="item in sec.items" 
              :key="item.id"
              class="${namespace}-nav-card"
              :class="[
                { '${namespace}-nav-card--active': activeId === item.id },
                item.theme ? ('${namespace}-nav-card--' + item.theme) : ''
              ]"
              @click="selectItem(item)"
            >
              <div class="${namespace}-nav-card__icon">
                <template v-if="item.emoji">{{ item.emoji }}</template>
                <i v-else-if="item.icon" :class="item.icon"></i>
                <span v-else>📌</span>
              </div>

              <span class="${namespace}-nav-card__title">{{ item.label }}</span>

              <span 
                v-if="item.badge !== undefined && item.badge !== null" 
                class="${namespace}-nav-card__badge"
                :class="item.badgeType ? ('${namespace}-nav-card__badge--' + item.badgeType) : ''"
              >
                {{ item.badge }}
              </span>
            </div>
          </template>
        </div>

        <div class="${namespace}-sidebar-footer">
          <div class="${namespace}-pet-hint-bubble">
            <span class="pet-paw">🐾</span>
            <span>今天也要元气满满哦！</span>
          </div>
        </div>
      </aside>

      <section class="${namespace}-content">
        
        <div class="${namespace}-breadcrumb">
          <span>当前位置：</span>
          <a href="javascript:void(0)">{{ currentModuleLabel }}</a>
          <span>&gt;</span>
          <span>{{ breadPage }}</span>

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

        <main class="${namespace}-page">
          
          <router-view />

          <div v-if="route.path === '/' || route.path === '/home'" style="display: flex; flex-direction: column; gap: 14px;">
            
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

        <footer class="${namespace}-statusbar">
          <div style="display: flex; align-items: center; gap: 8px;">
            <span class="${namespace}-tag ${namespace}-tag--warning" style="border: none;">🐾 陪伴小柴在线</span>
            <span>今天的小步前进，正在化为明天的底气 ✨</span>
          </div>
          <div>如期 (Stepaw) 数字化自律系统 · 运行良好</div>
        </footer>

      </section>

    </div>

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

const isLoginPage = computed(() => route.path === '/login')

const modules = MODULE_LIST
const activeModule = ref(modules[0].key)

const fallbackSections = [
  {
    title: '',
    items: [
      { id: 'today',     label: '今天任务',   emoji: '📅', badge: 0, path: '/today' },
      { id: 'short',     label: '短期项目',   emoji: '📋', badge: 3, path: '/short' },
      { id: 'long',      label: '长期项目',   emoji: '🏔️', badge: 1, path: '/long' },
      { id: 'milestone', label: '里程碑勋章', emoji: '🏆', badge: '2/24', theme: 'gold', path: '/milestones' },
      { id: 'hermes',    label: 'Hermes 连通', emoji: '🔮', badge: 'MCP', badgeType: 'text', path: '/hermes' },
      { id: 'done',      label: '已达成目标', emoji: '🎉', badge: 3, path: '/done' }
    ]
  }
]

const currentSections = computed(() => {
  const mod = MENUS[activeModule.value]
  return (mod && mod.sections && mod.sections.length > 0) ? mod.sections : fallbackSections
})

const activeId     = ref('short')
const activePath   = ref('/short')
const breadPage    = ref('短期项目')
const clock        = ref('')
const username     = ref(localStorage.getItem('username') || '旅行者')

const currentModuleLabel = computed(() => MENUS[activeModule.value]?.label || '自律空间')

function switchModule(key) {
  activeModule.value = key
  const sec = currentSections.value[0]
  if (sec && sec.items && sec.items[0]) {
    selectItem(sec.items[0])
  }
}

function selectItem(item) {
  if (item.disabled) return
  activeId.value   = item.id
  activePath.value = item.path || ''
  breadPage.value  = item.label.replace(/^└\s*/, '')
  if (item.path) {
    router.push(item.path)
  }
}

let timer
function tick() {
  const now = new Date()
  const p = n => String(n).padStart(2, '0')
  clock.value = now.getFullYear() + '-' + p(now.getMonth() + 1) + '-' + p(now.getDate()) + ' ' + p(now.getHours()) + ':' + p(now.getMinutes()) + ':' + p(now.getSeconds())
}
onMounted(() => { tick(); timer = setInterval(tick, 1000) })
onBeforeUnmount(() => clearInterval(timer))

function logout() {
  localStorage.removeItem('isLoggedIn')
  localStorage.removeItem('username')
  router.push('/login')
}

const goalInput = ref('岗位: AWS架构师准备 / 景观方案深化 / 雅思口语7分')
const goalDeadline = ref('2026-09-19')

const projectCards = ref([
  { id: 1, icon: '🏡', title: '某三期工程景观施工图', progress: 58, deadline: '2026-08-23', nextTask: '施工图绘制深化 📐', subNodes: '1/1' },
  { id: 2, icon: '🛍️', title: '某商业金街效果图深化', progress: 25, deadline: '2026-08-23', nextTask: '主材打样效果图 🎨', subNodes: '1/2' },
  { id: 3, icon: '🌿', title: '某产业园区方案汇报', progress: 58, deadline: '2026-08-23', nextTask: '商务造价清单审核 📊', subNodes: '1/1' },
  { id: 4, icon: '🍁', title: '某秋季新品品牌策划', progress: 67, deadline: '2026-12-08', nextTask: '与甲方沟通初审方案 💡', subNodes: '1/1' },
])

const petQuotes = [
  '汪！摸摸头，今天也超级棒！✨',
  '哪怕只前进一步也很厉害啦！🐾',
  '喝口水，稍微活动下肩膀吧 🍵',
  '今天的小柴也是你的头号粉丝！⭐'
]
const currentPetQuote = ref(petQuotes[0])

function petCompanion() {
  fireConfetti()
  const randomIdx = Math.floor(Math.random() * petQuotes.length)
  currentPetQuote.value = petQuotes[randomIdx]
}

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

<style scoped>
.${namespace}-sidebar {
  width: 260px;
  background: var(--${namespace}-bg-page, #EDF5F1);
  background-image: 
    radial-gradient(var(--${namespace}-dot-color, #CCE7DA) 1.5px, transparent 1.5px), 
    radial-gradient(var(--${namespace}-dot-color, #CCE7DA) 1.5px, var(--${namespace}-bg-page, #EDF5F1) 1.5px);
  background-size: 24px 24px;
  background-position: 0 0, 12px 12px;
  border-right: 3px solid var(--${namespace}-border, #E2EFE8);
  overflow-y: auto;
  flex-shrink: 0;
  display: flex;
  flex-direction: column;
  justify-content: space-between;
  padding: 16px 14px;
  gap: 12px;
}

.${namespace}-nav-card-list {
  display: flex;
  flex-direction: column;
  gap: 14px;
}

.${namespace}-nav-section-label {
  font-size: 11px;
  font-weight: 900;
  color: var(--${namespace}-text-light, #94A3B8);
  padding: 2px 10px;
  letter-spacing: 0.05em;
}

.${namespace}-nav-card {
  min-height: 58px;
  background: var(--${namespace}-bg, #FFFFFF);
  border: 2.5px solid var(--${namespace}-border, #E2EFE8);
  border-radius: var(--${namespace}-radius-lg, 24px);
  padding: 8px 16px;
  display: flex;
  align-items: center;
  justify-content: space-between;
  cursor: pointer;
  user-select: none;
  position: relative;
  box-shadow: 0 4px 0 #D2E7DC, 0 6px 12px rgba(45, 74, 62, 0.03);
  transition: all 0.2s cubic-bezier(0.34, 1.56, 0.64, 1);
}

.${namespace}-nav-card:hover {
  transform: translateY(-2px);
  border-color: var(--${namespace}-primary-border, #A7F3D0);
  box-shadow: 0 6px 0 #D2E7DC, 0 10px 16px rgba(16, 185, 129, 0.08);
}

.${namespace}-nav-card:active {
  transform: translateY(2px);
  box-shadow: 0 2px 0 #D2E7DC;
}

.${namespace}-nav-card__icon {
  font-size: 26px;
  display: flex;
  align-items: center;
  justify-content: center;
  margin-right: 12px;
  flex-shrink: 0;
  filter: drop-shadow(0 2px 3px rgba(0, 0, 0, 0.08));
}

.${namespace}-nav-card__title {
  font-size: 15px;
  font-weight: 900;
  color: var(--${namespace}-text, #1E293B);
  flex: 1;
  letter-spacing: 0.02em;
}

.${namespace}-nav-card__badge {
  min-width: 32px;
  height: 28px;
  padding: 0 10px;
  background: #DCFCE7;
  color: #047857;
  border-radius: var(--${namespace}-radius-pill, 9999px);
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 13px;
  font-weight: 900;
  flex-shrink: 0;
}

.${namespace}-nav-card.${namespace}-nav-card--active {
  background: linear-gradient(135deg, #10B981 0%, #059669 100%);
  border-color: #047857;
  box-shadow: 0 4px 0 #047857, 0 10px 20px rgba(5, 150, 105, 0.3);
}
.${namespace}-nav-card.${namespace}-nav-card--active .${namespace}-nav-card__title {
  color: #FFFFFF;
}
.${namespace}-nav-card.${namespace}-nav-card--active .${namespace}-nav-card__badge {
  background: #FFFFFF;
  color: #047857;
  box-shadow: 0 2px 6px rgba(0, 0, 0, 0.1);
}

.${namespace}-nav-card--gold {
  background: #FFFDF0;
  border-color: #FDE68A;
  box-shadow: 0 4px 0 #FCD34D, 0 6px 12px rgba(217, 119, 6, 0.06);
}
.${namespace}-nav-card--gold .${namespace}-nav-card__title {
  color: #78350F;
}
.${namespace}-nav-card--gold .${namespace}-nav-card__badge {
  background: #FBBF24;
  color: #FFFFFF;
  box-shadow: 0 2px 4px rgba(217, 119, 6, 0.2);
}

.${namespace}-nav-card__badge--text {
  background: #A7F3D0;
  color: #065F46;
  font-size: 11px;
  letter-spacing: 0.05em;
  padding: 0 8px;
}

.${namespace}-sidebar-footer {
  padding-top: 8px;
}
.${namespace}-pet-hint-bubble {
  background: #FFFFFF;
  border: 2px solid var(--${namespace}-border, #E2EFE8);
  border-radius: var(--${namespace}-radius-md, 16px);
  padding: 10px 12px;
  font-size: 12px;
  font-weight: 800;
  color: var(--${namespace}-text-muted, #475569);
  display: flex;
  align-items: center;
  gap: 8px;
  box-shadow: 0 2px 0 #D2E7DC;
}
.${namespace}-pet-hint-bubble .pet-paw {
  font-size: 16px;
}
</style>