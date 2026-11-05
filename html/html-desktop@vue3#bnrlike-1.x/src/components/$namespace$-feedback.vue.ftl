<template>
  <teleport to="body">
    <transition name="${namespace}-fd-mask">
      <div v-if="visible" class="${namespace}-fd-mask" @click.self="onMaskClick">
        <transition name="${namespace}-fd-box" appear>
          <div v-if="visible" class="${namespace}-fd-box">
            <!-- 顶部类型指示色条 -->
            <div class="${namespace}-fd-stripe" :class="'${namespace}-fd-stripe--' + typeVal"></div>
            
            <!-- 内容主体 -->
            <div class="${namespace}-fd-body">
              <div class="${namespace}-fd-icon">
                <!-- loading 模式展示 CSS 动态旋转光圈，其它模式展示 Emoji 图标 -->
                <span v-if="typeVal === 'loading'" class="${namespace}-fd-spinner"></span>
                <span v-else>{{ icons[typeVal] || 'ℹ️' }}</span>
              </div>
              <div class="${namespace}-fd-text">
                <div class="${namespace}-fd-title">{{ titleVal }}</div>
                <div v-if="messageVal" class="${namespace}-fd-message">{{ messageVal }}</div>
              </div>
            </div>

            <!-- 底部按钮区（loading 状态自动隐藏） -->
            <div v-if="typeVal !== 'loading'" class="${namespace}-fd-footer">
              <button 
                v-if="typeVal === 'confirm'" 
                type="button"
                class="${namespace}-fd-btn ${namespace}-fd-btn--cancel" 
                @click="onCancel"
              >
                {{ cancelText || '取消' }}
              </button>
              <button 
                type="button"
                class="${namespace}-fd-btn" 
                :class="'${namespace}-fd-btn--' + typeVal" 
                @click="onConfirm" 
                ref="okBtn"
              >
                {{ confirmText || '确定' }}
              </button>
            </div>
          </div>
        </transition>
      </div>
    </transition>
  </teleport>
</template>

<script setup>
import { ref, watch, nextTick, computed } from 'vue'

const props = defineProps({
  // 1. composable 模式：dialog 状态对象 { show, type, title, message, resolve }
  dialog: { 
    type: Object, 
    default: null 
  },
  // composable 模式：关闭回调函数，由 useFeedback 的 close() 提供
  onClose: { 
    type: Function, 
    default: null 
  },

  // 2. 独立 v-model 模式（兼顾传统组件化传参）
  modelValue:  { type: Boolean, default: false },
  type:        { type: String,  default: 'info' }, // 'info' | 'success' | 'error' | 'warning' | 'confirm' | 'loading'
  title:       { type: String,  default: '' },
  message:     { type: String,  default: '' },
  confirmText: { type: String,  default: '' },
  cancelText:  { type: String,  default: '' },
})

const emit = defineEmits(['update:modelValue', 'confirm', 'cancel'])

// 判断使用哪种模式
const hasDialog = computed(() => props.dialog !== null)

const visible = computed(() => hasDialog.value ? !!props.dialog?.show : props.modelValue)
const typeVal = computed(() => hasDialog.value ? (props.dialog?.type || 'info') : props.type)
const titleVal = computed(() => {
  if (hasDialog.value && props.dialog?.title) return props.dialog.title
  if (props.title) return props.title
  return typeVal.value === 'loading' ? '正在处理' : '提示'
})
const messageVal = computed(() => hasDialog.value ? (props.dialog?.message || '') : props.message)

const okBtn = ref(null)
const icons = {
  confirm: '❓',
  success: '✅',
  error:   '❌',
  warning: '⚠️',
  info:    'ℹ️'
}

// 弹窗打开且非 loading 模式时，自动聚焦到确定按钮
watch(visible, (v) => {
  if (v && typeVal.value !== 'loading') {
    nextTick(() => okBtn.value?.focus())
  }
})

// 统一关闭逻辑
function close(result) {
  if (hasDialog.value) {
    if (props.onClose) {
      props.onClose(result)
    } else if (props.dialog?.resolve) {
      props.dialog.resolve(result)
    }
  } else {
    emit('update:modelValue', false)
    emit(result ? 'confirm' : 'cancel')
  }
}

function onConfirm() { close(true) }
function onCancel()  { close(false) }

// 点击遮罩：confirm 和 loading 类型不可通过点击遮罩关闭
function onMaskClick() {
  if (typeVal.value !== 'confirm' && typeVal.value !== 'loading') {
    close(false)
  }
}

// 按键拦截：loading 类型下锁定键盘 ESC，防止中断异步保存
function onKey(e) {
  if (e.key === 'Escape' && typeVal.value !== 'loading') {
    close(false)
  }
}

watch(visible, (v) => {
  if (v) document.addEventListener('keydown', onKey)
  else document.removeEventListener('keydown', onKey)
})
</script>

<style scoped>
/* 遮罩背景 */
.${namespace}-fd-mask {
  position: fixed;
  inset: 0;
  z-index: 99999;
  background: rgba(0, 0, 0, 0.45);
  display: flex;
  align-items: center;
  justify-content: center;
}

/* 弹窗实体卡片 */
.${namespace}-fd-box {
  background: #ffffff;
  border-radius: 4px;
  min-width: 320px;
  max-width: 460px;
  width: 90vw;
  box-shadow: 0 10px 36px rgba(0, 0, 0, 0.22);
  overflow: hidden;
}

/* 顶部类型条 */
.${namespace}-fd-stripe { height: 4px; }
.${namespace}-fd-stripe--confirm,
.${namespace}-fd-stripe--info,
.${namespace}-fd-stripe--loading { background: #1a4f8a; }
.${namespace}-fd-stripe--success { background: #1e8449; }
.${namespace}-fd-stripe--error   { background: #c0392b; }
.${namespace}-fd-stripe--warning { background: #d46b08; }

/* 主体内容 */
.${namespace}-fd-body {
  padding: 22px 24px 20px;
  display: flex;
  gap: 14px;
  align-items: flex-start;
}
.${namespace}-fd-icon {
  font-size: 28px;
  flex-shrink: 0;
  line-height: 1;
  margin-top: 2px;
  display: flex;
  align-items: center;
  justify-content: center;
}

/* Loading 旋转动画 Spinner */
.${namespace}-fd-spinner {
  display: inline-block;
  width: 26px;
  height: 26px;
  border: 3px solid #e8edf5;
  border-top-color: #1a4f8a;
  border-radius: 50%;
  animation: ${namespace}-fd-spin 0.75s linear infinite;
}
@keyframes ${namespace}-fd-spin {
  0%   { transform: rotate(0deg); }
  100% { transform: rotate(360deg); }
}

.${namespace}-fd-text { flex: 1; min-width: 0; }
.${namespace}-fd-title {
  font-size: 15px;
  font-weight: bold;
  color: #1c2833;
  margin-bottom: 6px;
  line-height: 1.4;
}
.${namespace}-fd-message {
  font-size: 13px;
  color: #5d6d7e;
  line-height: 1.6;
  white-space: pre-line;
  word-break: break-word;
}

/* 底部操作条 */
.${namespace}-fd-footer {
  display: flex;
  justify-content: flex-end;
  gap: 8px;
  padding: 12px 20px;
  border-top: 1px solid #f0f0f0;
  background: #fafbfc;
}
.${namespace}-fd-btn {
  height: 30px;
  padding: 0 18px;
  font-size: 13px;
  font-family: inherit;
  border: 1px solid transparent;
  border-radius: 2px;
  cursor: pointer;
  transition: background 0.15s, border-color 0.15s;
}
.${namespace}-fd-btn--cancel {
  background: #ffffff;
  color: #333333;
  border-color: #c8c8c8;
}
.${namespace}-fd-btn--cancel:hover { background: #f5f5f5; }

.${namespace}-fd-btn--confirm,
.${namespace}-fd-btn--info {
  background: #1a4f8a;
  color: #ffffff;
  border-color: #1a4f8a;
}
.${namespace}-fd-btn--confirm:hover,
.${namespace}-fd-btn--info:hover { background: #15407a; }

.${namespace}-fd-btn--success {
  background: #1e8449;
  color: #ffffff;
  border-color: #1e8449;
}
.${namespace}-fd-btn--success:hover { background: #196f3d; }

.${namespace}-fd-btn--error {
  background: #c0392b;
  color: #ffffff;
  border-color: #c0392b;
}
.${namespace}-fd-btn--error:hover { background: #a93226; }

.${namespace}-fd-btn--warning {
  background: #d46b08;
  color: #ffffff;
  border-color: #d46b08;
}
.${namespace}-fd-btn--warning:hover { background: #b85a06; }

/* 进退场平滑动效 */
.${namespace}-fd-mask-enter-active,
.${namespace}-fd-mask-leave-active {
  transition: opacity 0.2s ease;
}
.${namespace}-fd-mask-enter-from,
.${namespace}-fd-mask-leave-to {
  opacity: 0;
}
.${namespace}-fd-box-enter-active {
  transition: transform 0.2s cubic-bezier(0.16, 1, 0.3, 1), opacity 0.2s ease;
}
.${namespace}-fd-box-enter-from {
  transform: scale(0.92);
  opacity: 0;
}
</style>