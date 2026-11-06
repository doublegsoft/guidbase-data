<template>
  <div class="neumorphic-login-page">
    <!-- 背景柔和极光微光晕与定位标 -->
    <div class="hud-crosshair top-left">+</div>
    <div class="hud-crosshair top-right">+</div>
    <div class="hud-crosshair bottom-left">+</div>
    <div class="hud-crosshair bottom-right">+</div>

    <!-- 登录终端新拟态卡片主体 -->
    <div class="login-container">
      <!-- 顶部诊断与终端控制条 (微凹嵌合设计) -->
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
          <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2" stroke-linecap="round" stroke-linejoin="round">
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
                <svg width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                  <path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2"></path>
                  <circle cx="12" cy="7" r="4"></circle>
                </svg>
              </span>
              <input
                v-model="form.username"
                type="text"
                class="form-input"
                placeholder="请输入操作员账号"
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
                <svg width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                  <rect x="3" y="11" width="18" height="11" rx="2" ry="2"></rect>
                  <path d="M7 11V7a5 5 0 0 1 10 0v4"></path>
                </svg>
              </span>
              <input
                v-model="form.password"
                type="password"
                class="form-input"
                placeholder="请输入访问凭证密钥"
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
                  <svg width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                    <path d="M12 22s8-4 8-10V5l-8-3-8 3v7c0 6 8 10 8 10z"></path>
                  </svg>
                </span>
                <input
                  v-model="form.captcha"
                  type="text"
                  class="form-input"
                  placeholder="验证码"
                  required
                  autocomplete="off"
                >
              </div>
              <div
                class="captcha-img-box"
                title="点击刷新哈希验证码"
                @click="generateCaptcha"
              >
                <span class="captcha-text">{{ captchaCode }}</span>
              </div>
            </div>
          </div>

          <!-- 辅助选项：新拟态开关控件 -->
          <div class="form-options">
            <label class="checkbox-item">
              <input v-model="form.remember" type="checkbox" class="neu-checkbox">
              <span class="neu-checkbox-box"></span>
              <span class="checkbox-text">保持登录凭证</span>
            </label>
            <a href="#" class="reset-link">重置权限?</a>
          </div>

          <!-- 建立连接按钮：渐变高光柔和按钮 -->
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

      <!-- 诊断与安全提示行：嵌合底栏 -->
      <div class="card-footer-strip">
        <span class="pulse-dot"></span>
        <span>GATEWAY: 192.168.1.1 // SECURE & READY</span>
      </div>
    </div>

    <!-- 底部版权声明 -->
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
  }, 900)
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
/* ══════════════════════════════════════════════
   新拟态系统变量注入
   ══════════════════════════════════════════════ */
.neumorphic-login-page {
  --bg: #e0e5ec;
  --pn: #e0e5ec;
  --sl: rgba(255, 255, 255, 0.75);
  --sd: rgba(163, 177, 198, 0.65);
  
  --ink: #4a5568;
  --mu: #8390a6;
  --ln: rgba(131, 144, 166, 0.28);
  --pri: #4d7cfe;
  
  /* 拟态核心阶梯阴影 */
  --sp: 9px 9px 20px var(--sd), -9px -9px 20px var(--sl);
  --su: 5px 5px 14px var(--sd), -5px -5px 14px var(--sl);
  --ss: 3px 3px 7px var(--sd),  -3px -3px 7px var(--sl);
  --si: inset 5px 5px 10px var(--sd), inset -5px -5px 10px var(--sl);
  --sis: inset 2px 2px 5px var(--sd), inset -2px -2px 5px var(--sl);

  --font-m: "IBM Plex Mono", "SF Mono", Consolas, monospace;
  --font-sans: -apple-system, "PingFang SC", "Helvetica Neue", sans-serif;

  min-height: 100vh;
  width: 100vw;
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  background-color: var(--bg);
  font-family: var(--font-sans);
  position: relative;
  overflow: hidden;
  user-select: none;
  padding: 30px 16px;
  box-sizing: border-box;
}

/* 四角 HUD 十字刻度标 */
.hud-crosshair {
  position: absolute;
  color: var(--mu);
  font-family: var(--font-m);
  font-size: 14px;
  opacity: 0.5;
}
.top-left { top: 24px; left: 28px; }
.top-right { top: 24px; right: 28px; }
.bottom-left { bottom: 24px; left: 28px; }
.bottom-right { bottom: 24px; right: 28px; }

/* ══════════════════════════════════════════════
   核心登录面板 (Panel Card)
   ══════════════════════════════════════════════ */
.login-container {
  width: 100%;
  max-width: 430px;
  background: var(--pn);
  border-radius: 28px;
  /* 运用内高光融合技术，左上角光影平滑顺畅，绝不产生生硬白块 */
  box-shadow: 
    8px 8px 22px var(--sd),
    -6px -6px 20px var(--sl),
    inset 1px 1px 2px rgba(255, 255, 255, 0.8);
  border: 0;
  position: relative;
  z-index: 10;
  padding: 18px 20px 16px;
  box-sizing: border-box;
}

/* 顶部状态控制条 (嵌合微凹槽) */
.terminal-bar {
  display: flex;
  align-items: center;
  padding: 8px 14px;
  border-radius: 14px;
  box-shadow: var(--sis);
  font-family: var(--font-m);
  font-size: 10.5px;
  margin-bottom: 18px;
}
.terminal-dots {
  display: flex;
  gap: 6px;
  margin-right: 12px;
}
.dot {
  width: 8px;
  height: 8px;
  border-radius: 50%;
  box-shadow: inset 1px 1px 2px rgba(0,0,0,0.25);
}
.dot--red   { background: #ec5b62; box-shadow: 0 0 6px rgba(236, 91, 98, 0.6); }
.dot--amber { background: #f5a623; }
.dot--green { background: #2dbd6e; }

.terminal-session-title {
  color: var(--mu);
  font-weight: 700;
  letter-spacing: 0.5px;
}
.terminal-tag {
  margin-left: auto;
  font-size: 9.5px;
  padding: 1px 7px;
  border-radius: 8px;
  box-shadow: var(--ss);
  color: var(--pri);
  font-weight: 700;
}

/* 头部 Logo 区域 */
.login-header {
  padding: 6px 12px 18px;
  display: flex;
  align-items: center;
  gap: 16px;
}
.logo-box {
  width: 48px;
  height: 48px;
  background: var(--pn);
  color: var(--pri);
  border-radius: 16px;
  box-shadow: var(--su);
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
  font-family: var(--font-m);
  font-size: 19px;
  font-weight: 800;
  letter-spacing: 1.2px;
  color: var(--ink);
  margin: 0;
  line-height: 1.2;
}
.system-title em {
  color: var(--pri);
  font-style: italic;
}
.system-subtitle {
  font-family: var(--font-m);
  font-size: 9.5px;
  color: var(--mu);
  letter-spacing: 0.8px;
  margin-top: 4px;
}

/* 表单主体 */
.login-body {
  padding: 0 8px;
}
.form-group {
  margin-bottom: 20px;
}
.label-row {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 8px;
  padding: 0 4px;
}
.form-label {
  font-family: var(--font-m);
  font-size: 11px;
  font-weight: 700;
  color: var(--mu);
  letter-spacing: 0.5px;
}
.label-desc {
  font-family: var(--font-m);
  font-size: 9.5px;
  color: var(--mu);
  opacity: 0.8;
}

/* 拟态内凹输入框 */
.input-wrapper {
  position: relative;
  display: flex;
  align-items: center;
}
.input-icon {
  position: absolute;
  left: 14px;
  color: var(--mu);
  display: flex;
  align-items: center;
  justify-content: center;
  transition: color 0.15s;
  pointer-events: none;
}
.form-input {
  width: 100%;
  height: 42px;
  border: 0;
  border-radius: 14px;
  padding: 0 14px 0 42px;
  font-family: var(--font-m);
  font-size: 13px;
  color: var(--ink);
  background: var(--pn);
  box-shadow: var(--sis);
  outline: none;
  transition: box-shadow 0.15s ease, color 0.15s;
  box-sizing: border-box;
}
.form-input:focus {
  box-shadow: var(--sis), 0 0 0 2px rgba(77, 124, 254, 0.55);
  color: var(--pri);
}
.input-wrapper:focus-within .input-icon {
  color: var(--pri);
}
.form-input::placeholder {
  color: var(--mu);
  font-family: var(--font-sans);
  font-size: 12px;
}

/* 验证码微凸按钮区域 */
.captcha-row {
  display: flex;
  gap: 12px;
}
.captcha-img-box {
  width: 110px;
  height: 42px;
  background: var(--pn);
  border-radius: 14px;
  box-shadow: var(--ss);
  display: flex;
  align-items: center;
  justify-content: center;
  cursor: pointer;
  transition: box-shadow 0.15s ease, transform 0.1s;
  user-select: none;
  flex-shrink: 0;
}
.captcha-img-box:hover {
  box-shadow: var(--su);
}
.captcha-img-box:active {
  box-shadow: var(--sis);
  transform: scale(0.98);
}
.captcha-text {
  font-family: var(--font-m);
  font-size: 17px;
  font-weight: 800;
  color: var(--pri);
  letter-spacing: 4px;
}

/* 辅助选项项 */
.form-options {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 24px;
  padding: 0 4px;
}

/* 自定义拟态复选框 */
.checkbox-item {
  display: inline-flex;
  align-items: center;
  gap: 8px;
  cursor: pointer;
}
.neu-checkbox {
  display: none;
}
.neu-checkbox-box {
  width: 18px;
  height: 18px;
  border-radius: 6px;
  background: var(--pn);
  box-shadow: var(--sis);
  display: inline-block;
  position: relative;
  transition: 0.15s;
}
.neu-checkbox:checked + .neu-checkbox-box {
  background: var(--pri);
  box-shadow: 2px 2px 5px var(--sd), 0 0 8px rgba(77, 124, 254, 0.6);
}
.neu-checkbox:checked + .neu-checkbox-box::after {
  content: "✓";
  position: absolute;
  left: 3px;
  top: -1px;
  color: #fff;
  font-size: 12px;
  font-weight: 700;
}
.checkbox-text {
  font-family: var(--font-m);
  font-size: 11px;
  color: var(--mu);
}

.reset-link {
  font-family: var(--font-m);
  font-size: 11px;
  color: var(--mu);
  text-decoration: none;
  transition: color 0.15s;
}
.reset-link:hover {
  color: var(--pri);
}

/* 建立连接按钮 (蓝紫渐变立体浮雕) */
.btn-connect {
  width: 100%;
  height: 46px;
  background: linear-gradient(145deg, #6b93ff, #3f6df0);
  color: #fff;
  border: 0;
  border-radius: 14px;
  font-family: var(--font-m);
  font-size: 13px;
  font-weight: 700;
  letter-spacing: 1px;
  cursor: pointer;
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 10px;
  box-shadow: 5px 5px 14px rgba(63, 109, 240, 0.38), -4px -4px 10px var(--sl);
  transition: all 0.15s ease;
  outline: none;
}
.btn-connect:hover:not(:disabled) {
  filter: brightness(1.07);
}
.btn-connect:active:not(:disabled) {
  box-shadow: inset 3px 3px 8px rgba(20, 50, 160, 0.55);
  transform: scale(0.99);
}
.btn-connect:disabled {
  opacity: 0.5;
  cursor: not-allowed;
  box-shadow: none;
}

/* 旋转器动画 */
.spinner {
  width: 14px;
  height: 14px;
  border: 2px solid rgba(255, 255, 255, 0.35);
  border-top-color: #fff;
  border-radius: 50%;
  animation: spin 0.8s linear infinite;
}
@keyframes spin {
  to { transform: rotate(360deg); }
}

/* 底部状态提示条 (内嵌融合槽) */
.card-footer-strip {
  margin-top: 20px;
  border-radius: 14px;
  box-shadow: var(--sis);
  padding: 8px 14px;
  font-family: var(--font-m);
  font-size: 10px;
  color: var(--mu);
  display: flex;
  align-items: center;
  gap: 8px;
}
.pulse-dot {
  width: 8px;
  height: 8px;
  background: #2dbd6e;
  border-radius: 50%;
  box-shadow: 0 0 8px #2dbd6e;
  animation: pulse 1.6s infinite;
}
@keyframes pulse {
  50% { box-shadow: 0 0 12px 3px #2dbd6e; }
}

/* 页脚声明 */
.login-footer {
  margin-top: 28px;
  text-align: center;
  font-family: var(--font-m);
}
.footer-meta {
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 12px;
  font-size: 10px;
  color: var(--mu);
  letter-spacing: 0.5px;
}
.sep {
  opacity: 0.4;
}
.copyright {
  margin-top: 6px;
  font-size: 9.5px;
  color: var(--mu);
  opacity: 0.7;
}
</style>