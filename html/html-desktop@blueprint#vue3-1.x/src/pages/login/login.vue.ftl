<template>
  <div class="blueprint-login-page">
    <!-- 背景十字定位标与工程坐标提示 (Blueprint HUD Marks) -->
    <div class="hud-crosshair top-left">+</div>
    <div class="hud-crosshair top-right">+</div>
    <div class="hud-crosshair bottom-left">+</div>
    <div class="hud-crosshair bottom-right">+</div>
    
    <div class="hud-axis-x"></div>
    <div class="hud-axis-y"></div>

    <!-- 登录终端卡片主体 -->
    <div class="login-container">
      <!-- 顶部诊断与终端控制条 -->
      <div class="terminal-bar">
        <div class="terminal-dots">
          <span class="dot dot--red"></span>
          <span class="dot dot--amber"></span>
          <span class="dot dot--green"></span>
        </div>
        <div class="terminal-session-title">AUTH_SESSION // PORT: 443</div>
        <div class="terminal-tag">TLS 1.3</div>
      </div>

      <!-- 头部：协议系统标识 -->
      <header class="login-header">
        <div class="logo-box">
          <svg width="26" height="26" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2" stroke-linecap="round" stroke-linejoin="round">
            <polygon points="12 2 2 7 12 12 22 7 12 2"></polygon>
            <polyline points="2 17 12 22 22 17"></polyline>
            <polyline points="2 12 12 17 22 12"></polyline>
          </svg>
        </div>
        <div class="title-wrap">
          <h1 class="system-title">PROTOCOL <em>EXPLORER</em></h1>
          <p class="system-subtitle">CORE SYSTEM ARCHITECTURE // VER 2.4.0</p>
        </div>
      </header>

      <!-- 登录表单 -->
      <main class="login-body">
        <form id="loginForm" @submit.prevent="handleLogin">
          <!-- 账号输入 -->
          <div class="form-group">
            <div class="label-row">
              <label class="form-label">IDENTITY / ACCOUNT_ID</label>
              <span class="label-desc">REQUIRED</span>
            </div>
            <div class="input-wrapper">
              <span class="input-icon">
                <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                  <path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2"></path>
                  <circle cx="12" cy="7" r="4"></circle>
                </svg>
              </span>
              <input
                v-model="form.username"
                type="text"
                class="form-input"
                placeholder="Enter operator identifier"
                required
                autocomplete="off"
              >
            </div>
          </div>

          <!-- 密码输入 -->
          <div class="form-group">
            <div class="label-row">
              <label class="form-label">CREDENTIAL / PASSWORD</label>
              <span class="label-desc">ENCRYPTED</span>
            </div>
            <div class="input-wrapper">
              <span class="input-icon">
                <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                  <rect x="3" y="11" width="18" height="11" rx="2" ry="2"></rect>
                  <path d="M7 11V7a5 5 0 0 1 10 0v4"></path>
                </svg>
              </span>
              <input
                v-model="form.password"
                type="password"
                class="form-input"
                placeholder="Enter access token"
                required
              >
            </div>
          </div>

          <!-- 安全验证码 (Checksum Seed) -->
          <div class="form-group">
            <div class="label-row">
              <label class="form-label">CHALLENGE CODE</label>
              <span class="label-desc">CRC32_CHECK</span>
            </div>
            <div class="captcha-row">
              <div class="input-wrapper" style="flex: 1;">
                <span class="input-icon">
                  <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                    <path d="M12 22s8-4 8-10V5l-8-3-8 3v7c0 6 8 10 8 10z"></path>
                  </svg>
                </span>
                <input
                  v-model="form.captcha"
                  type="text"
                  class="form-input"
                  placeholder="Code"
                  required
                  autocomplete="off"
                >
              </div>
              <div
                class="captcha-img-box"
                title="Click to recalculate hash"
                @click="generateCaptcha"
              >
                <span class="captcha-text">{{ captchaCode }}</span>
              </div>
            </div>
          </div>

          <!-- 辅助选项 -->
          <div class="form-options">
            <label class="checkbox-item">
              <input v-model="form.remember" type="checkbox" class="blueprint-checkbox">
              <span>PERSIST OPERATOR_ID</span>
            </label>
            <a href="#" class="reset-link">RESET ACCESS?</a>
          </div>

          <!-- 建立连接按钮 -->
          <button
            type="submit"
            class="btn-connect"
            :disabled="isLoading"
          >
            <span v-if="isLoading" class="spinner"></span>
            <span>{{ isLoading ? 'NEGOTIATING HANDSHAKE...' : 'ESTABLISH CONNECTION' }}</span>
          </button>
        </form>
      </main>

      <!-- 诊断与安全提示行 -->
      <div class="card-footer-strip">
        <span class="pulse-dot"></span>
        <span>GATEWAY: 192.168.1.1 // READY</span>
      </div>
    </div>

    <!-- 底部工程版权声明 -->
    <footer class="login-footer">
      <div class="footer-meta">
        <span>SECURITY LEVEL: CLASS-A</span>
        <span class="sep">|</span>
        <span>ENGINEERED BY ARCHITECTURE TEAM</span>
        <span class="sep">|</span>
        <span>ALL COMMUNICATIONS RECORDED</span>
      </div>
      <p class="copyright">&copy; 2026 PROTOCOL EXPLORER CORP. ALL RIGHTS RESERVED.</p>
    </footer>
  </div>
</template>

<script setup>
import { ref, reactive, onMounted } from 'vue'
import { useRouter } from 'vue-router'

const router = useRouter()

const form = reactive({
  username: 'admin',
  password: '••••••••',
  captcha: '',
  remember: false
})

const captchaCode = ref('')
const captchaValue = ref('')
const isLoading = ref(false)

function generateCaptcha() {
  const chars = '23456789ABCDEFGHJKLMNPQRSTUVWXYZ'
  let captcha = ''
  for (let i = 0; i < 4; i++) {
    captcha += chars.charAt(Math.floor(Math.random() * chars.length))
  }
  captchaCode.value = captcha
  captchaValue.value = captcha.toLowerCase()
}

async function handleLogin() {
  isLoading.value = true

  // 模拟握手与密钥交换延迟
  setTimeout(() => {
    localStorage.setItem('isLoggedIn', 'true')
    localStorage.setItem('username', form.username)

    if (form.remember) {
      localStorage.setItem('rememberedUsername', form.username)
    } else {
      localStorage.removeItem('rememberedUsername')
    }

    isLoading.value = false
    router.push('/account/list')
  }, 1000)
}

onMounted(() => {
  generateCaptcha()
  const remembered = localStorage.getItem('rememberedUsername')
  if (remembered) {
    form.username = remembered
    form.remember = true
  }
})
</script>

<style scoped>
/* 蓝图变量注入 */
.blueprint-login-page {
  --b-primary: #0052cc;
  --b-primary-dark: #073b88;
  --b-primary-bg: #e8f0fe;
  --b-border: #cbd5e1;
  --b-border-light: #e2e8f0;
  --b-text: #0f172a;
  --b-text-muted: #475569;
  --b-text-light: #64748b;
  --b-bg: #ffffff;
  --b-bg-page: #f8fafc;
  --b-font-mono: "JetBrains Mono", "SF Mono", Consolas, Monaco, monospace;
  --b-font-sans: "SF Pro Text", -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, sans-serif;

  height: 100vh;
  width: 100vw;
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  background-color: var(--b-bg-page);
  font-family: var(--b-font-sans);
  position: relative;
  overflow: hidden;
  user-select: none;

  /* 经典蓝图坐标背景网格 */
  background-image: 
    linear-gradient(to right, rgba(203, 213, 225, 0.5) 1px, transparent 1px),
    linear-gradient(to bottom, rgba(203, 213, 225, 0.5) 1px, transparent 1px);
  background-size: 28px 28px;
}

/* 四角十字标 (HUD Crosshairs) */
.hud-crosshair {
  position: absolute;
  color: var(--b-text-light);
  font-family: var(--b-font-mono);
  font-size: 14px;
  font-weight: 300;
  opacity: 0.6;
}
.top-left { top: 20px; left: 24px; }
.top-right { top: 20px; right: 24px; }
.bottom-left { bottom: 20px; left: 24px; }
.bottom-right { bottom: 20px; right: 24px; }

/* 核心登录卡片 */
.login-container {
  width: 420px;
  background: var(--b-bg);
  border: 1.5px solid var(--b-border);
  border-radius: 4px;
  box-shadow: 0 10px 25px -5px rgba(15, 23, 42, 0.08), 0 8px 10px -6px rgba(15, 23, 42, 0.05);
  position: relative;
  z-index: 10;
}

/* 顶部终端状态栏 */
.terminal-bar {
  background: #f1f5f9;
  border-bottom: 1.5px solid var(--b-border-light);
  padding: 6px 12px;
  display: flex;
  align-items: center;
  font-family: var(--b-font-mono);
  font-size: 10px;
}
.terminal-dots {
  display: flex;
  gap: 5px;
  margin-right: 12px;
}
.dot {
  width: 8px;
  height: 8px;
  border-radius: 50%;
}
.dot--red   { background: #ef4444; }
.dot--amber { background: #f59e0b; }
.dot--green { background: #10b981; }

.terminal-session-title {
  color: var(--b-text-muted);
  font-weight: 700;
  letter-spacing: 0.5px;
}
.terminal-tag {
  margin-left: auto;
  font-size: 9px;
  padding: 1px 4px;
  background: #e2e8f0;
  border-radius: 2px;
  color: var(--b-text-muted);
}

/* 头部 Logo 区域 */
.login-header {
  padding: 24px 32px 16px;
  display: flex;
  align-items: center;
  gap: 14px;
  border-bottom: 1.5px solid var(--b-border-light);
}
.logo-box {
  width: 44px;
  height: 44px;
  background: var(--b-primary-bg);
  color: var(--b-primary);
  border: 1.5px solid var(--b-primary);
  border-radius: 3px;
  display: flex;
  align-items: center;
  justify-content: center;
  flex-shrink: 0;
}
.title-wrap {
  display: flex;
  flex-direction: column;
}
.system-title {
  font-family: var(--b-font-mono);
  font-size: 18px;
  font-weight: 800;
  letter-spacing: 1px;
  color: var(--b-text);
  margin: 0;
  line-height: 1.2;
}
.system-title em {
  color: var(--b-primary);
  font-style: normal;
}
.system-subtitle {
  font-family: var(--b-font-mono);
  font-size: 9px;
  color: var(--b-text-light);
  letter-spacing: 0.8px;
  margin-top: 4px;
}

/* 表单主体 */
.login-body {
  padding: 24px 32px;
}
.form-group {
  margin-bottom: 18px;
}
.label-row {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 6px;
}
.form-label {
  font-family: var(--b-font-mono);
  font-size: 10px;
  font-weight: 700;
  color: var(--b-text-muted);
  letter-spacing: 0.5px;
}
.label-desc {
  font-family: var(--b-font-mono);
  font-size: 9px;
  color: var(--b-text-light);
}

.input-wrapper {
  position: relative;
  display: flex;
  align-items: center;
}
.input-icon {
  position: absolute;
  left: 10px;
  color: var(--b-text-light);
  display: flex;
  align-items: center;
  justify-content: center;
}
.form-input {
  width: 100%;
  height: 36px;
  border: 1.5px solid var(--b-border);
  border-radius: 2px;
  padding: 0 10px 0 34px;
  font-family: var(--b-font-mono);
  font-size: 12px;
  color: var(--b-text);
  background: #fff;
  outline: none;
  transition: all 0.15s ease;
}
.form-input:focus {
  border-color: var(--b-primary);
  box-shadow: 0 0 0 3px var(--b-primary-bg);
}
.form-input::placeholder {
  color: var(--b-text-light);
  font-family: var(--b-font-sans);
  font-size: 11px;
}

/* 校验码区域 */
.captcha-row {
  display: flex;
  gap: 8px;
}
.captcha-img-box {
  width: 105px;
  height: 36px;
  background: #fafcff;
  border: 1.5px solid var(--b-border);
  border-radius: 2px;
  display: flex;
  align-items: center;
  justify-content: center;
  cursor: pointer;
  background-image: repeating-linear-gradient(45deg, transparent, transparent 6px, rgba(203, 213, 225, 0.3) 6px, rgba(203, 213, 225, 0.3) 12px);
}
.captcha-text {
  font-family: var(--b-font-mono);
  font-size: 16px;
  font-weight: 800;
  color: var(--b-primary);
  letter-spacing: 4px;
}

/* 表单控制项 */
.form-options {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 22px;
  font-family: var(--b-font-mono);
  font-size: 10px;
}
.checkbox-item {
  display: flex;
  align-items: center;
  gap: 6px;
  cursor: pointer;
  color: var(--b-text-muted);
}
.blueprint-checkbox {
  accent-color: var(--b-primary);
}
.reset-link {
  color: var(--b-primary);
  text-decoration: none;
  font-weight: 700;
}
.reset-link:hover {
  text-decoration: underline;
}

/* 连接建立按钮 */
.btn-connect {
  width: 100%;
  height: 40px;
  background: var(--b-primary);
  color: #fff;
  border: 1.5px solid var(--b-primary-dark);
  border-radius: 2px;
  font-family: var(--b-font-mono);
  font-size: 12px;
  font-weight: 700;
  letter-spacing: 1px;
  cursor: pointer;
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 8px;
  transition: all 0.15s ease;
}
.btn-connect:hover:not(:disabled) {
  background: var(--b-primary-dark);
}
.btn-connect:disabled {
  opacity: 0.6;
  cursor: not-allowed;
}

/* 加载动画小轮 */
.spinner {
  width: 12px;
  height: 12px;
  border: 2px solid rgba(255, 255, 255, 0.3);
  border-top-color: #fff;
  border-radius: 50%;
  animation: spin 0.8s linear infinite;
}
@keyframes spin {
  to { transform: rotate(360deg); }
}

/* 底部状态提示条 */
.card-footer-strip {
  background: #fafcff;
  border-top: 1px solid var(--b-border-light);
  padding: 6px 14px;
  font-family: var(--b-font-mono);
  font-size: 9px;
  color: var(--b-text-light);
  display: flex;
  align-items: center;
  gap: 6px;
}
.pulse-dot {
  width: 6px;
  height: 6px;
  background: #10b981;
  border-radius: 50%;
  box-shadow: 0 0 0 2px rgba(16, 185, 129, 0.2);
}

/* 页脚声明 */
.login-footer {
  margin-top: 24px;
  text-align: center;
  font-family: var(--b-font-mono);
}
.footer-meta {
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 10px;
  font-size: 10px;
  color: var(--b-text-light);
  letter-spacing: 0.5px;
}
.sep {
  opacity: 0.4;
}
.copyright {
  margin-top: 6px;
  font-size: 9px;
  color: var(--b-text-light);
  opacity: 0.8;
}
</style>