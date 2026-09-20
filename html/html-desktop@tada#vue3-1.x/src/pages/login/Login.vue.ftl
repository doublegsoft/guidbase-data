<template>
  <div class="${namespace}-login-wrapper">
    
    <!-- 登录居中卡片 (基于系统 panel 微凸面板规范) -->
    <div class="${namespace}-panel ${namespace}-login-card">

      <!-- 顶部挂载桌宠头像与动态问候气泡 -->
      <div class="${namespace}-pet-float-group">
        <!-- 动态浮动气泡 -->
        <div class="${namespace}-bubble-tip">
          {{ petBubble }}
        </div>

        <!-- 交互桌宠 (输入密码自动蒙眼 🙈，使用系统 tadaPetWiggle 动画) -->
        <div 
          class="${namespace}-pet-badge" 
          @click="petBark" 
          title="戳我有惊喜哦！"
        >
          {{ petAvatar }}
        </div>
      </div>

      <!-- 标题与副标题 -->
      <div class="${namespace}-login-header">
        <div class="${namespace}-login-title-row">
          <h1 class="${namespace}-login-title">步步爪</h1>
          <span class="${namespace}-tag ${namespace}-tag--primary">v2.8</span>
        </div>
        <p class="${namespace}-login-subtitle">大目标轻轻拆，从容推进今天的小确幸 🐾</p>
      </div>

      <!-- 登录模式切换 Tab (系统原生 ${namespace}-tabs) -->
      <div class="${namespace}-tabs ${namespace}-login-tabs">
        <div 
          class="${namespace}-tab" 
          :class="{ '${namespace}-active': loginType === 'pwd' }"
          @click="loginType = 'pwd'"
        >
          账号密码登录
        </div>
        <div 
          class="${namespace}-tab" 
          :class="{ '${namespace}-active': loginType === 'otp' }"
          @click="loginType = 'otp'"
        >
          免密验证码
        </div>
      </div>

      <!-- 登录表单 -->
      <form @submit.prevent="handleLogin" class="${namespace}-login-form">
        
        <!-- 账号输入 -->
        <div class="${namespace}-field">
          <label class="${namespace}-field-label">电子邮箱 / 手机号</label>
          <div class="${namespace}-input-wrap">
            <i class="${namespace}-regular ${namespace}-envelope ${namespace}-input-icon"></i>
            <input 
              type="text" 
              v-model="form.account" 
              required 
              placeholder="creator@orderly.app" 
              class="${namespace}-input" 
              @focus="onAccountFocus" 
              @blur="onInputBlur" 
            />
          </div>
        </div>

        <!-- 密码登录区 -->
        <div v-if="loginType === 'pwd'" class="${namespace}-field">
          <div class="${namespace}-field-header">
            <label class="${namespace}-field-label">账户密码</label>
            <a href="javascript:void(0)" class="${namespace}-login-link">忘记密码？</a>
          </div>
          <div class="${namespace}-input-wrap">
            <i class="${namespace}-solid ${namespace}-lock ${namespace}-input-icon"></i>
            <input 
              type="password" 
              v-model="form.password" 
              required
              placeholder="输入密码 (小柴会自动捂眼哦)" 
              class="${namespace}-input" 
              @focus="onPasswordFocus" 
              @blur="onInputBlur" 
            />
          </div>
        </div>

        <!-- 短信验证码登录区 -->
        <div v-else class="${namespace}-field">
          <label class="${namespace}-field-label">短信验证码</label>
          <div class="${namespace}-otp-row">
            <div class="${namespace}-input-wrap ${namespace}-otp-input">
              <i class="${namespace}-solid ${namespace}-shield-halved ${namespace}-input-icon"></i>
              <input 
                type="text" 
                v-model="form.otp" 
                required
                placeholder="6 位验证码" 
                class="${namespace}-input" 
                @focus="onAccountFocus" 
                @blur="onInputBlur" 
              />
            </div>
            <button 
              type="button" 
              @click="sendOtp"
              class="${namespace}-btn ${namespace}-btn--default ${namespace}-btn-otp"
            >
              获取验证码
            </button>
          </div>
        </div>

        <!-- 免登录勾选 -->
        <div class="${namespace}-field">
          <label class="${namespace}-checkbox-wrap">
            <input type="checkbox" v-model="form.remember" class="${namespace}-checkbox" />
            <span>7 天内免登录 (保持小柴常驻)</span>
          </label>
        </div>

        <!-- 3D 果冻主按键 (系统原生 ${namespace}-btn--primary) -->
        <button 
          type="submit" 
          class="${namespace}-btn ${namespace}-btn--primary ${namespace}-btn-submit"
        >
          <span>开始今天的微启动之旅</span>
          <i class="${namespace}-solid ${namespace}-arrow-right"></i>
        </button>

      </form>

      <!-- 虚线中间文字分隔条 -->
      <div class="${namespace}-separator">
        <span>快捷开启</span>
      </div>

      <!-- 第三方快速登录 (系统原生 24 栅格 ${namespace}-row / ${namespace}-col-8 + ${namespace}-btn--default) -->
      <div class="${namespace}-row ${namespace}-social-row">
        <div class="${namespace}-col-8">
          <button type="button" @click="socialLogin('微信')" class="${namespace}-btn ${namespace}-btn--default ${namespace}-btn-social">
            <i class="${namespace}-brands ${namespace}-weixin ${namespace}-icon-wechat"></i>
          </button>
        </div>
        <div class="${namespace}-col-8">
          <button type="button" @click="socialLogin('Apple')" class="${namespace}-btn ${namespace}-btn--default ${namespace}-btn-social">
            <i class="${namespace}-brands ${namespace}-apple"></i>
          </button>
        </div>
        <div class="${namespace}-col-8">
          <button type="button" @click="socialLogin('GitHub')" class="${namespace}-btn ${namespace}-btn--default ${namespace}-btn-social">
            <i class="${namespace}-brands ${namespace}-github"></i>
          </button>
        </div>
      </div>

      <!-- 底部协议说明 -->
      <p class="${namespace}-login-agreement">
        登录即代表同意 
        <a href="javascript:void(0)">《如期服务条款》</a> 与 
        <a href="javascript:void(0)">《自律成长公约》</a>
      </p>

    </div>

  </div>
</template>

<script setup>
import { ref, reactive } from 'vue'

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

// 密码框聚焦时，触发蒙眼交互 (Peek-a-boo)
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
/* 居中背景 */
.${namespace}-login-wrapper {
  min-height: 100vh;
  width: 100vw;
  display: flex;
  align-items: center;
  justify-content: center;
  padding: var(--${namespace}-sp-lg, 20px);
  user-select: none;
}

/* 核心卡片 (继承 panel 并配置定位上下文) */
.${namespace}-login-card {
  width: 100%;
  max-width: 420px;
  position: relative;
  overflow: visible;
  padding: 38px 32px 28px;
  box-shadow: var(--${namespace}-shadow-md);
}

/* 顶部桌宠悬挂锚点 */
.${namespace}-pet-float-group {
  position: absolute;
  top: -64px;
  left: 50%;
  transform: translateX(-50%);
  display: flex;
  flex-direction: column;
  align-items: center;
}

/* 浮动气泡 */
.${namespace}-bubble-tip {
  margin-bottom: 8px;
  background: var(--${namespace}-bg, #FFFFFF);
  border: 2px solid var(--${namespace}-gold-border);
  color: var(--${namespace}-gold-dark);
  font-size: 11px;
  font-weight: 900;
  padding: 4px 14px;
  border-radius: var(--${namespace}-radius-pill);
  box-shadow: 0 4px 10px rgba(217, 119, 6, 0.12);
  white-space: nowrap;
  animation: faBubbleFloat 2.5s ease-in-out infinite;
}

@keyframes faBubbleFloat {
  0%, 100% { transform: translateY(0); }
  50% { transform: translateY(-4px); }
}

/* 桌宠本体大徽章 (复用系统 tadaPetWiggle 动效) */
.${namespace}-pet-badge {
  width: 76px;
  height: 76px;
  border-radius: var(--${namespace}-radius-lg);
  background: var(--${namespace}-gold-bg);
  border: 3px solid var(--${namespace}-gold-border);
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 38px;
  cursor: pointer;
  box-shadow: 0 4px 0 var(--${namespace}-gold-border), 0 8px 16px rgba(217, 119, 6, 0.15);
  animation: tadaPetWiggle 3.5s ease-in-out infinite;
  transform-origin: bottom center;
  transition: transform 0.2s cubic-bezier(0.34, 1.56, 0.64, 1);
}
.${namespace}-pet-badge:hover {
  transform: scale(1.08);
}
.${namespace}-pet-badge:active {
  transform: scale(0.95);
}

/* 标题区 */
.${namespace}-login-header {
  text-align: center;
  margin-top: 16px;
  margin-bottom: 20px;
}
.${namespace}-login-title-row {
  display: inline-flex;
  align-items: center;
  gap: 8px;
  margin-bottom: 4px;
}
.${namespace}-login-title {
  font-size: 24px;
  font-weight: 900;
  color: var(--${namespace}-text);
  margin: 0;
}
.${namespace}-login-subtitle {
  font-size: 12px;
  font-weight: 700;
  color: var(--${namespace}-text-light);
  margin: 0;
}

/* Tab 适配全宽 */
.${namespace}-login-tabs {
  width: 100%;
  margin-bottom: 18px;
  display: flex;
}
.${namespace}-login-tabs .${namespace}-tab {
  flex: 1;
  text-align: center;
}

/* 表单主体 */
.${namespace}-login-form {
  display: flex;
  flex-direction: column;
  gap: 14px;
}

.${namespace}-field-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
}
.${namespace}-login-link {
  font-size: 11px;
  font-weight: 900;
  color: var(--${namespace}-primary-dark);
  text-decoration: none;
}
.${namespace}-login-link:hover {
  text-decoration: underline;
}

/* 输入框内嵌图标 */
.${namespace}-input-wrap {
  position: relative;
  width: 100%;
}
.${namespace}-input-icon {
  position: absolute;
  left: 14px;
  top: 50%;
  transform: translateY(-50%);
  color: var(--${namespace}-text-light);
  font-size: 14px;
}
.${namespace}-input-wrap .${namespace}-input {
  width: 100%;
  padding-left: 40px;
}

/* 短信验证码行 */
.${namespace}-otp-row {
  display: flex;
  gap: 8px;
}
.${namespace}-otp-input {
  flex: 1;
}
.${namespace}-btn-otp {
  white-space: nowrap;
  font-size: 12px;
  padding: 0 12px;
}

/* 勾选框 */
.${namespace}-checkbox-wrap {
  display: inline-flex;
  align-items: center;
  gap: 8px;
  font-size: 12px;
  font-weight: 800;
  color: var(--${namespace}-text-muted);
  cursor: pointer;
}
.${namespace}-checkbox {
  width: 16px;
  height: 16px;
  accent-color: var(--${namespace}-primary);
  cursor: pointer;
}

/* 登录大按钮 */
.${namespace}-btn-submit {
  width: 100%;
  height: 44px;
  font-size: 14px;
  gap: 8px;
  margin-top: 4px;
}

/* 虚线分割带 */
.${namespace}-separator {
  position: relative;
  text-align: center;
  margin: 22px 0 16px;
}
.${namespace}-separator::before {
  content: '';
  position: absolute;
  left: 0;
  top: 50%;
  width: 100%;
  border-top: 2px dashed var(--${namespace}-border);
  z-index: 0;
}
.${namespace}-separator span {
  position: relative;
  z-index: 1;
  background: var(--${namespace}-bg, #FFFFFF);
  padding: 0 12px;
  font-size: 11px;
  font-weight: 900;
  color: var(--${namespace}-text-light);
}

/* 第三方登录 */
.${namespace}-social-row {
  margin-left: -4px;
  margin-right: -4px;
}
.${namespace}-social-row > [class*="${namespace}-col-"] {
  padding-left: 4px;
  padding-right: 4px;
}
.${namespace}-btn-social {
  width: 100%;
  font-size: 16px;
  height: 38px;
}
.${namespace}-icon-wechat {
  color: #07C160;
}

/* 协议页脚 */
.${namespace}-login-agreement {
  text-align: center;
  font-size: 11px;
  font-weight: 700;
  color: var(--${namespace}-text-light);
  margin-top: 20px;
}
.${namespace}-login-agreement a {
  color: var(--${namespace}-primary-dark);
  font-weight: 900;
  text-decoration: underline;
}
</style>