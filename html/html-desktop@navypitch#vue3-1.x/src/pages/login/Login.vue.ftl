<template>
  <div class="login-page">
    <div class="login-container">
      <div class="login-top-line"></div>

      <header class="login-header">
        <div class="logo-area">
          <span class="logo-icon">⚡</span>
          <span class="system-title">这里是标题</span>
        </div>
        <div class="system-subtitle">这里是子标题</div>
      </header>
      <main class="login-body">
        <form id="loginForm" @submit.prevent="handleLogin">
          <div class="form-group">
            <label class="form-label">员工工号 / 账号</label>
            <div class="input-wrapper">
              <span class="input-icon">👤</span>
              <input
                v-model="form.username"
                type="text"
                class="form-input"
                placeholder="请输入工号"
                required>
            </div>
          </div>
          <div class="form-group">
            <label class="form-label">登录密码</label>
            <div class="input-wrapper">
              <span class="input-icon">🔒</span>
              <input
                v-model="form.password"
                type="password"
                class="form-input"
                placeholder="请输入密码"
                required>
            </div>
          </div>
          <div class="form-group">
            <label class="form-label">安全验证码</label>
            <div class="captcha-row">
              <div class="input-wrapper" style="flex:1">
                <span class="input-icon">🛡️</span>
                <input
                  v-model="form.captcha"
                  type="text"
                  class="form-input"
                  placeholder="验证码"
                  required
                  autocomplete="off">
              </div>
              <div
                class="captcha-img-box"
                :title="'点击刷新验证码'"
                @click="generateCaptcha">
                {{ captchaCode }}
              </div>
            </div>
          </div>

          <div class="form-options">
            <label class="checkbox-item">
              <input v-model="form.remember" type="checkbox"> 记住工号
            </label>
            <a href="#" style="color:var(--main-blue); text-decoration:none;">忘记密码？</a>
          </div>

          <button
            type="submit"
            class="btn-login"
            :disabled="isLoading">
            {{ isLoading ? '正在验证安全环境...' : '登 录' }}
          </button>
        </form>
      </main>
    </div>

    <footer class="login-footer">
      <p>Copyright &copy; 2025 某市供电局 信息通信中心 版权所有</p>
      <p style="margin-top:5px;">建议使用 Chrome 90+ 或 Edge 浏览器以获得最佳体验</p>
    </footer>
  </div>
</template>

<script setup>
import { ref, reactive, onMounted } from 'vue'
import { useRouter } from 'vue-router'

const router = useRouter()

// 表单数据
const form = reactive({
  username: 'hello',
  password: 'world',
  captcha: '',
  remember: false
})

// 验证码
const captchaCode = ref('')
const captchaValue = ref('')

// 加载状态
const isLoading = ref(false)

// 生成验证码
function generateCaptcha() {
  const chars = 'ABCDEFGHJKMNPQRSTWXYZabcdefhijkmnprstwxyz2345678'
  let captcha = ''
  for (let i = 0; i < 4; i++) {
    captcha += chars.charAt(Math.floor(Math.random() * chars.length))
  }
  captchaCode.value = captcha
  captchaValue.value = captcha.toLowerCase()
}

// 登录处理
async function handleLogin() {
  // 验证码校验
  // if (form.captcha.toLowerCase() !== captchaValue.value) {
  //   alert('验证码输入错误，请重新输入！')
  //   generateCaptcha()
  //   form.captcha = ''
  //   return
  // }

  isLoading.value = true

  // 模拟登录验证
  setTimeout(() => {
    // 存储登录状态
    localStorage.setItem('isLoggedIn', 'true')
    localStorage.setItem('username', form.username)

    // 如果选择了记住工号
    if (form.remember) {
      localStorage.setItem('rememberedUsername', form.username)
    } else {
      localStorage.removeItem('rememberedUsername')
    }

    isLoading.value = false
    router.push('/account/list')
  }, 1000)
}

// 初始化
onMounted(() => {
  generateCaptcha()
  // 加载记住的工号
  const remembered = localStorage.getItem('rememberedUsername')
  if (remembered) {
    form.username = remembered
    form.remember = true
  }
})
</script>

<style scoped>
:root {
  --main-blue: #004b91;
  --nav-bg: #003366;
  --text-main: #333333;
  --border-color: #dcdfe6;
  --bg-gradient: linear-gradient(135deg, #003366 0%, #004b91 100%);
  --font-family: "Microsoft YaHei", "微软雅黑", sans-serif;
}

.login-page {
  font-family: "Microsoft YaHei", "微软雅黑", sans-serif;
  height: 100vh;
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  background: linear-gradient(135deg, #003366 0%, #004b91 100%);
  /* 模拟电力网格背景纹理 */
  background-image: radial-gradient(rgba(255,255,255,0.1) 1px, transparent 1px);
  background-size: 30px 30px;
}

* { box-sizing: border-box; margin: 0; padding: 0; }

.login-container {
  width: 400px;
  background: #fff;
  border-radius: 2px;
  box-shadow: 0 15px 35px rgba(0,0,0,0.3);
  overflow: hidden;
  position: relative;
}

/* 卡片顶部装饰条 */
.login-top-line {
  height: 4px;
  background: #ffd700; /* 电力金 */
}

/* 头部 */
.login-header {
  padding: 40px 40px 20px;
  text-align: center;
}
.logo-area {
  margin-bottom: 15px;
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 10px;
}
.logo-icon {
  font-size: 32px;
  color: #004b91;
}
.system-title {
  font-size: 22px;
  font-weight: bold;
  color: #003366;
  letter-spacing: 1px;
}
.system-subtitle {
  font-size: 11px;
  color: #999;
  text-transform: uppercase;
  letter-spacing: 2px;
  margin-top: 5px;
}

/* 表单 */
.login-body {
  padding: 0 40px 40px;
}
.form-group {
  margin-bottom: 20px;
  position: relative;
}
.form-label {
  display: block;
  font-size: 12px;
  color: #666;
  margin-bottom: 8px;
}
.input-wrapper {
  position: relative;
  display: flex;
  align-items: center;
}
.input-icon {
  position: absolute;
  left: 10px;
  color: #999;
  font-size: 14px;
}
.form-input {
  width: 100%;
  height: 40px;
  border: 1px solid #dcdfe6;
  border-radius: 2px;
  padding: 0 15px 0 35px;
  font-size: 14px;
  outline: none;
  transition: all 0.2s;
}
.form-input:focus {
  border-color: #004b91;
  box-shadow: 0 0 0 3px rgba(0,75,145,0.1);
}

/* 验证码区域 */
.captcha-row {
  display: flex;
  gap: 10px;
}

.captcha-img-box {
  width: 120px;
  height: 40px;
  background: #f0f2f5;
  border: 1px solid #dcdfe6;
  cursor: pointer;
  display: flex;
  align-items: center;
  justify-content: center;
  font-family: "Courier New", Courier, monospace;
  font-size: 20px;
  font-weight: bold;
  font-style: italic;
  letter-spacing: 5px;
  color: #004b91;
  user-select: none;
  background-image: repeating-linear-gradient(45deg, transparent, transparent 10px, rgba(0,0,0,0.03) 10px, rgba(0,0,0,0.03) 20px);
}

.form-options {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 25px;
  font-size: 12px;
  color: #666;
}
.checkbox-item {
  display: flex;
  align-items: center;
  gap: 5px;
  cursor: pointer;
}

/* 登录按钮 */
.btn-login {
  width: 100%;
  height: 44px;
  background: #004b91;
  color: #fff;
  border: none;
  border-radius: 2px;
  font-size: 16px;
  font-weight: bold;
  cursor: pointer;
  transition: background 0.3s;
  box-shadow: 0 4px 10px rgba(0,75,145,0.2);
}
.btn-login:hover:not(:disabled) {
  background: #003a70;
}
.btn-login:active:not(:disabled) {
  transform: translateY(1px);
}
.btn-login:disabled {
  background: #ccc;
  cursor: not-allowed;
}

/* 底部声明 */
.login-footer {
  text-align: center;
  margin-top: 30px;
  color: rgba(255,255,255,0.6);
  font-size: 11px;
}
</style>
