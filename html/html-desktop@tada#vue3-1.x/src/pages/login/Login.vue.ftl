<template>
  <div class="login-wrapper min-h-screen w-screen flex items-center justify-center p-4 selection:bg-emerald-200 select-none">
    
    <!-- 登录居中卡片 -->
    <div class="tada-card max-w-md w-full p-8 md:p-10 relative overflow-visible">

      <!-- 顶部挂载桌宠头像与动态问候气泡 -->
      <div class="absolute -top-16 left-1/2 -translate-x-1/2 flex flex-col items-center">
        <!-- 气泡文字 -->
        <div class="animate-float mb-2 bg-white border-2 border-amber-300 text-amber-900 text-xs font-black px-4 py-1.5 rounded-full shadow-md whitespace-nowrap">
          {{ petBubble }}
        </div>

        <!-- 交互桌宠 (输入密码自动蒙眼 🙈) -->
        <div 
          @click="petBark"
          class="w-20 h-20 rounded-3xl bg-amber-100 border-3 border-amber-300 flex items-center justify-center text-4xl shadow-lg shadow-amber-900/10 cursor-pointer animate-wiggle select-none transform hover:scale-105 active:scale-95 transition">
          {{ petAvatar }}
        </div>
      </div>

      <!-- 标题与副标题 -->
      <div class="text-center mt-8 mb-6">
        <div class="inline-flex items-center gap-2 mb-1">
          <h1 class="text-2xl font-black text-slate-800 tracking-tight">步步爪</h1>
          <span class="text-xs bg-emerald-100 text-emerald-800 border border-emerald-300 px-2.5 py-0.5 rounded-full font-black">
            v2.8
          </span>
        </div>
        <p class="text-xs font-bold text-slate-400">大目标轻轻拆，从容推进今天的小确幸 🐾</p>
      </div>

      <!-- 登录模式切换 Tab -->
      <div class="flex p-1.5 bg-[#eaf4ee] border-2 border-[#d6ebe0] rounded-2xl mb-6 text-xs font-black">
        <button 
          type="button" 
          @click="loginType = 'pwd'" 
          :class="loginType === 'pwd' ? 'bg-white text-emerald-800 shadow-sm' : 'text-slate-500 hover:text-slate-800'"
          class="flex-1 py-2 rounded-xl transition">
          账号密码登录
        </button>
        <button 
          type="button" 
          @click="loginType = 'otp'" 
          :class="loginType === 'otp' ? 'bg-white text-emerald-800 shadow-sm' : 'text-slate-500 hover:text-slate-800'"
          class="flex-1 py-2 rounded-xl transition">
          免密验证码
        </button>
      </div>

      <!-- 登录表单 -->
      <form @submit.prevent="handleLogin" class="space-y-4">
        
        <!-- 账号输入 -->
        <div>
          <label class="block text-xs font-black text-slate-700 mb-1.5">电子邮箱 / 手机号</label>
          <div class="relative">
            <i class="fa-regular fa-envelope absolute left-4 top-3.5 text-slate-400 text-sm"></i>
            <input 
              type="text" 
              v-model="form.account" 
              required 
              placeholder="creator@orderly.app" 
              class="tada-input" 
              @focus="onAccountFocus" 
              @blur="onInputBlur" />
          </div>
        </div>

        <!-- 密码登录区 -->
        <div v-if="loginType === 'pwd'">
          <div class="flex items-center justify-between mb-1.5">
            <label class="text-xs font-black text-slate-700">账户密码</label>
            <a href="javascript:void(0)" class="text-xs font-black text-emerald-600 hover:underline">忘记密码？</a>
          </div>
          <div class="relative">
            <i class="fa-solid fa-lock absolute left-4 top-3.5 text-slate-400 text-sm"></i>
            <input 
              type="password" 
              v-model="form.password" 
              required
              placeholder="输入密码 (小柴会自动捂眼哦)" 
              class="tada-input" 
              @focus="onPasswordFocus" 
              @blur="onInputBlur" />
          </div>
        </div>

        <!-- 短信验证码登录区 -->
        <div v-else>
          <label class="block text-xs font-black text-slate-700 mb-1.5">短信验证码</label>
          <div class="flex gap-2">
            <div class="relative flex-1">
              <i class="fa-solid fa-shield-halved absolute left-4 top-3.5 text-slate-400 text-sm"></i>
              <input 
                type="text" 
                v-model="form.otp" 
                required
                placeholder="6 位验证码" 
                class="tada-input" 
                @focus="onAccountFocus" 
                @blur="onInputBlur" />
            </div>
            <button 
              type="button" 
              @click="sendOtp"
              class="px-4 bg-emerald-50 border-2 border-emerald-200 text-emerald-800 rounded-2xl text-xs font-black hover:bg-emerald-100 transition whitespace-nowrap">
              获取验证码
            </button>
          </div>
        </div>

        <!-- 免登录勾选 -->
        <div class="flex items-center justify-between pt-1">
          <label class="flex items-center space-x-2 cursor-pointer text-xs font-extrabold text-slate-500">
            <input type="checkbox" v-model="form.remember" class="w-4 h-4 rounded-lg accent-emerald-500 cursor-pointer">
            <span>7天内免登录 (保持小柴常驻)</span>
          </label>
        </div>

        <!-- 3D 果冻大登录按键 -->
        <div class="pt-2">
          <button 
            type="submit" 
            class="w-full btn-jelly-primary text-white text-sm font-black py-3.5 rounded-2xl flex items-center justify-center space-x-2">
            <span>开始今天的微启动之旅</span>
            <i class="fa-solid fa-arrow-right text-xs"></i>
          </button>
        </div>

      </form>

      <!-- 虚线分隔条 -->
      <div class="relative my-6">
        <div class="absolute inset-0 flex items-center">
          <div class="w-full border-t-2 border-dashed border-[#e6f1eb]"></div>
        </div>
        <div class="relative flex justify-center text-xs font-black">
          <span class="bg-white px-3 text-slate-400">快捷开启</span>
        </div>
      </div>

      <!-- 第三方快速登录 -->
      <div class="grid grid-cols-3 gap-3">
        <button type="button" @click="socialLogin('微信')" class="btn-social py-2.5 rounded-2xl flex items-center justify-center text-emerald-600 text-base">
          <i class="fa-brands fa-weixin"></i>
        </button>
        <button type="button" @click="socialLogin('Apple')" class="btn-social py-2.5 rounded-2xl flex items-center justify-center text-slate-800 text-base">
          <i class="fa-brands fa-apple"></i>
        </button>
        <button type="button" @click="socialLogin('GitHub')" class="btn-social py-2.5 rounded-2xl flex items-center justify-center text-slate-700 text-base">
          <i class="fa-brands fa-github"></i>
        </button>
      </div>

      <!-- 底部协议说明 -->
      <p class="text-center text-[11px] font-bold text-slate-400 mt-6">
        登录即代表同意 <a href="javascript:void(0)" class="text-emerald-700 underline font-black">《如期服务条款》</a> 与 <a href="javascript:void(0)" class="text-emerald-700 underline font-black">《自律成长公约》</a>
      </p>

    </div>

  </div>
</template>

<script setup>
import { ref, reactive } from 'vue'
// 如果你的项目已配置 vue-router，可解开下行引入：
// import { useRouter } from 'vue-router'
// const router = useRouter()

// 1. 登录表单与模式状态
const loginType = ref('pwd') // 'pwd' | 'otp'
const form = reactive({
  account: 'creator@orderly.app',
  password: '',
  otp: '',
  remember: true
})

// 2. 小柴桌宠眼神与气泡状态
const petAvatar = ref('🐶')
const petBubble = ref('汪！你今天来得真早呀！✨')

const onAccountFocus = () => {
  petAvatar.value = '🐶'
  petBubble.value = '在看你输入账号哦~ 🐾'
}

// ⭐ 密码框聚焦时，触发蒙眼交互 (Peek-a-boo)
const onPasswordFocus = () => {
  petAvatar.value = '🙈'
  petBubble.value = '保密时间！小柴不看你的密码 🤫'
}

const onInputBlur = () => {
  petAvatar.value = '🐶'
  petBubble.value = '准备好开启今天的小目标了吗？✨'
}

const petBark = () => {
  triggerConfetti()
  petBubble.value = '嗷呜！加油加油！今天也要如期交付！🍖'
}

// 3. 登录操作
const handleLogin = () => {
  petAvatar.value = '🎉'
  petBubble.value = '验证通过！如期系统正在开启... 🚀'
  
  triggerConfetti()

  setTimeout(() => {
    // 页面跳转示例：
    // router.push('/home')
    alert('登录成功！正在跳转至工作台总览...')
  }, 700)
}

const sendOtp = () => {
  triggerConfetti()
  alert('验证码已发送，测试验证码为：888888')
}

const socialLogin = (platform) => {
  triggerConfetti()
  alert(`已拉起 ${r"${"}platform} 快捷授权登录！`)
}

// 4. 彩带彩屑粒子动画
const triggerConfetti = () => {
  if (typeof window !== 'undefined' && window.confetti) {
    window.confetti({
      particleCount: 55,
      spread: 70,
      origin: { y: 0.6 },
      colors: ['#34d399', '#10b981', '#fbbf24', '#f472b6', '#60a5fa']
    })
  }
}
</script>

<style scoped>
/* 治愈系背景网点 */
.login-wrapper {
  background: #edf5f1;
  background-image: 
    radial-gradient(#cce7da 1.5px, transparent 1.5px), 
    radial-gradient(#cce7da 1.5px, #edf5f1 1.5px);
  background-size: 28px 28px;
}

/* TADA 3D 软萌微凸卡片 */
.tada-card {
  background: #ffffff;
  border: 3.5px solid #e1efe7;
  border-radius: 36px;
  box-shadow: 0 16px 35px -6px rgba(45, 74, 62, 0.08);
}

/* 3D 果冻物理按键 */
.btn-jelly-primary {
  background: linear-gradient(180deg, #34d399 0%, #059669 100%);
  box-shadow: 0 5px 0 #047857, 0 10px 18px rgba(5, 150, 105, 0.3);
  transition: all 0.1s ease;
}
.btn-jelly-primary:active {
  transform: translateY(4px);
  box-shadow: 0 1px 0 #047857, 0 4px 8px rgba(5, 150, 105, 0.2);
}

/* 快捷第三方登录小圆钮 */
.btn-social {
  background: #f8fcfa;
  border: 2px solid #d9ece2;
  box-shadow: 0 3px 0 #cde5d8;
  transition: all 0.15s ease;
}
.btn-social:hover {
  background: #ffffff;
  border-color: #10b981;
  transform: translateY(-2px);
}
.btn-social:active {
  transform: translateY(2px);
  box-shadow: none;
}

/* 软萌输入框控件 */
.tada-input {
  background-color: #f7faf8;
  border: 2.5px solid #d9ece2;
  border-radius: 20px;
  padding: 12px 16px 12px 44px;
  font-size: 13px;
  font-weight: 800;
  color: #1e293b;
  outline: none;
  transition: all 0.2s ease;
  width: 100%;
}
.tada-input:focus {
  background-color: #ffffff;
  border-color: #10b981;
  box-shadow: 0 0 0 4px rgba(16, 185, 129, 0.15);
}

/* 柴犬晃晃动效 */
@keyframes petWiggle {
  0%, 100% { transform: rotate(0deg); }
  25% { transform: rotate(-8deg) scale(1.04); }
  75% { transform: rotate(8deg) scale(1.04); }
}
.animate-wiggle {
  animation: petWiggle 3.5s ease-in-out infinite;
  transform-origin: bottom center;
}

/* 浮动气泡 */
@keyframes floatSlow {
  0%, 100% { transform: translateY(0); }
  50% { transform: translateY(-5px); }
}
.animate-float {
  animation: floatSlow 2.5s ease-in-out infinite;
}
</style>