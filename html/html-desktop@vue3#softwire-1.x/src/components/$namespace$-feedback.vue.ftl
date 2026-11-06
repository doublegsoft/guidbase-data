<template>
  <teleport to="body">
    <transition name="${namespace}-fd-mask">
      <div v-if="visible" class="${namespace}-fd-mask" @click.self="onMaskClick">
        <transition name="${namespace}-fd-box" appear>
          <div v-if="visible" class="${namespace}-fd-box">
            <!-- 顶部类型指示色条 (3px 直角) -->
            <div class="${namespace}-fd-stripe" :class="'${namespace}-fd-stripe--' + typeVal"></div>
            
            <!-- 内容主体 -->
            <div class="${namespace}-fd-body">
              <div class="${namespace}-fd-icon">
                <!-- loading 模式展示等宽工程雷达旋转圈，其它模式展示纯正线框符号 -->
                <span v-if="typeVal === 'loading'" class="${namespace}-fd-spinner"></span>
                <span v-else class="${namespace}-fd-badge" :class="'${namespace}-fd-badge--' + typeVal">
                  {{ symbolIcons[typeVal] || 'i' }}
                </span>
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
                {{ cancelText || 'CANCEL' }}
              </button>
              <button 
                type="button"
                class="${namespace}-fd-btn" 
                :class="'${namespace}-fd-btn--' + typeVal" 
                ref="okBtn"
                @click="onConfirm" 
              >
                {{ confirmText || 'CONFIRM' }}
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
  dialog: { 
    type: Object, 
    default: null 
  },
  onClose: { 
    type: Function, 
    default: null 
  },
  modelValue:  { type: Boolean, default: false },
  type:        { type: String,  default: 'info' }, // 'info' | 'success' | 'error' | 'warning' | 'confirm' | 'loading'
  title:       { type: String,  default: '' },
  message:     { type: String,  default: '' },
  confirmText: { type: String,  default: '' },
  cancelText:  { type: String,  default: '' },
})

const emit = defineEmits(['update:modelValue', 'confirm', 'cancel'])

const hasDialog = computed(() => props.dialog !== null)

const visible = computed(() => hasDialog.value ? !!props.dialog?.show : props.modelValue)
const typeVal = computed(() => hasDialog.value ? (props.dialog?.type || 'info') : props.type)
const titleVal = computed(() => {
  if (hasDialog.value && props.dialog?.title) return props.dialog.title
  if (props.title) return props.title
  return typeVal.value === 'loading' ? 'PROCESSING...' : 'SYSTEM NOTICE'
})
const messageVal = computed(() => hasDialog.value ? (props.dialog?.message || '') : props.message)

const okBtn = ref(null)

// 彻底弃用彩色 Emoji，改用极客工程字符符号
const symbolIcons = {
  confirm: '?',
  success: '✓',
  error:   '×',
  warning: '!',
  info:    'i'
}

watch(visible, (v) => {
  if (v && typeVal.value !== 'loading') {
    nextTick(() => okBtn.value?.focus())
  }
})

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

function onMaskClick() {
  if (typeVal.value !== 'confirm' && typeVal.value !== 'loading') {
    close(false)
  }
}

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
/* ══════════════════════════════════════════════
   Protocol Explorer Feedback 蓝图工程规范
   ══════════════════════════════════════════════ */

/* 遮罩背景 */
.${namespace}-fd-mask {
  position: fixed;
  inset: 0;
  z-index: 99999;
  background: rgba(8, 13, 34, 0.55);
  backdrop-filter: blur(1px);
  display: flex;
  align-items: center;
  justify-content: center;
  user-select: none;
}

/* 弹窗实体卡片：纯直角、1px 细线框、6px 实体硬阴影 */
.${namespace}-fd-box {
  background: var(--${namespace}-pn, #ffffff);
  border: 1px solid var(--${namespace}-ink, #0a2a9a);
  border-radius: 0;
  min-width: 340px;
  max-width: 460px;
  width: 90vw;
  box-shadow: 6px 6px 0 var(--${namespace}-ln, #d3dbef);
  overflow: hidden;
  font-family: var(--${namespace}-f, "IBM Plex Mono", monospace);
}

.${namespace}-fd-box {
  background: var(--${namespace}-pn, #ffffff);
  border: 1px solid var(--${namespace}-ln, #d3dbef); /* 可改用更柔和的细线 */
  box-shadow: none !important; /* 核心修改：去除 6px 6px 0 硬阴影 */
}

/* 顶部类型指示色条 */
.${namespace}-fd-stripe { height: 3px; }
.${namespace}-fd-stripe--confirm,
.${namespace}-fd-stripe--info,
.${namespace}-fd-stripe--loading { background: var(--${namespace}-pri, #0a2fb5); }
.${namespace}-fd-stripe--success { background: var(--${namespace}-tcp, #13a05d); }
.${namespace}-fd-stripe--error   { background: var(--${namespace}-red, #d6343e); }
.${namespace}-fd-stripe--warning { background: var(--${namespace}-cmd, #f0a500); }

/* 主体内容 */
.${namespace}-fd-body {
  padding: 20px 24px;
  display: flex;
  gap: 14px;
  align-items: flex-start;
  background: var(--${namespace}-pn, #ffffff);
}

/* 符号徽章容器 */
.${namespace}-fd-icon {
  flex-shrink: 0;
  display: flex;
  align-items: center;
  justify-content: center;
}

/* 纯正工程圆形符号徽章 (参考 HTML .bd 规范) */
.${namespace}-fd-badge {
  width: 28px;
  height: 28px;
  border-radius: 50%;
  color: var(--${namespace}-on, #ffffff);
  display: inline-grid;
  place-items: center;
  font-weight: 800;
  font-size: 14px;
  line-height: 1;
}
.${namespace}-fd-badge--confirm,
.${namespace}-fd-badge--info    { background: var(--${namespace}-pri, #0a2fb5); }
.${namespace}-fd-badge--success { background: var(--${namespace}-tcp, #13a05d); }
.${namespace}-fd-badge--error   { background: var(--${namespace}-red, #d6343e); }
.${namespace}-fd-badge--warning { background: var(--${namespace}-cmd, #f0a500); color: #000; }

/* 极客 Loading 动画：直角硬质旋转框 */
.${namespace}-fd-spinner {
  display: inline-block;
  width: 24px;
  height: 24px;
  border: 2px solid var(--${namespace}-ln, #d3dbef);
  border-top-color: var(--${namespace}-pri, #0a2fb5);
  border-radius: 0;
  animation: ${namespace}-fd-spin 0.65s linear infinite;
}
@keyframes ${namespace}-fd-spin {
  0%   { transform: rotate(0deg); }
  100% { transform: rotate(360deg); }
}

.${namespace}-fd-text { flex: 1; min-width: 0; }
.${namespace}-fd-title {
  font-size: 15px;
  font-weight: 800;
  letter-spacing: .08em;
  color: var(--${namespace}-ink, #0a2a9a);
  margin-bottom: 6px;
  line-height: 1.3;
}
.${namespace}-fd-message {
  font-size: 12px;
  color: #334155;
  font-weight: 500;
  line-height: 1.6;
  white-space: pre-line;
  word-break: break-word;
}

/* 底部操作条 (按钮靠右对齐) */
.${namespace}-fd-footer {
  display: flex;
  justify-content: flex-end;
  gap: 8px;
  padding: 10px 18px;
  border-top: 1px solid var(--${namespace}-ln, #d3dbef);
  background: var(--${namespace}-bg, #f4f6fb);
}

/* 物理压平按钮：直角、硬阴影、微位移悬停 */
.${namespace}-fd-btn {
  height: 30px;
  padding: 0 16px;
  font-size: 12px;
  font-family: var(--${namespace}-f, "IBM Plex Mono", monospace);
  font-weight: 700;
  letter-spacing: .06em;
  border: 1px solid var(--${namespace}-ink, #0a2a9a);
  border-radius: 0;
  cursor: pointer;
  transition: .12s;
}
.${namespace}-fd-btn:hover {
  transform: translate(-1px, -1px);
  box-shadow: 2px 2px 0 var(--${namespace}-ink, #0a2a9a);
}
.${namespace}-fd-btn:active {
  transform: translate(1px, 1px);
  box-shadow: none;
}

/* 取消按钮 */
.${namespace}-fd-btn--cancel {
  background: var(--${namespace}-pn, #ffffff);
  color: var(--${namespace}-ink, #0a2a9a);
  border-color: var(--${namespace}-ln, #d3dbef);
}
.${namespace}-fd-btn--cancel:hover {
  border-color: var(--${namespace}-ink, #0a2a9a);
}

/* 确认与语义类型按钮 */
.${namespace}-fd-btn--confirm,
.${namespace}-fd-btn--info {
  background: var(--${namespace}-pri, #0a2fb5);
  color: var(--${namespace}-on, #ffffff);
  border-color: var(--${namespace}-pri, #0a2fb5);
}
.${namespace}-fd-btn--confirm:hover,
.${namespace}-fd-btn--info:hover {
  box-shadow: 2px 2px 0 color-mix(in srgb, var(--${namespace}-pri, #0a2fb5) 45%, transparent);
}

.${namespace}-fd-btn--success {
  background: var(--${namespace}-tcp, #13a05d);
  color: var(--${namespace}-on, #ffffff);
  border-color: var(--${namespace}-tcp, #13a05d);
}

.${namespace}-fd-btn--error {
  background: var(--${namespace}-red, #d6343e);
  color: var(--${namespace}-on, #ffffff);
  border-color: var(--${namespace}-red, #d6343e);
}

.${namespace}-fd-btn--warning {
  background: var(--${namespace}-cmd, #f0a500);
  color: #000000;
  border-color: var(--${namespace}-cmd, #f0a500);
}

/* 进退场动效 (快速利落) */
.${namespace}-fd-mask-enter-active,
.${namespace}-fd-mask-leave-active {
  transition: opacity 0.15s ease;
}
.${namespace}-fd-mask-enter-from,
.${namespace}-fd-mask-leave-to {
  opacity: 0;
}
.${namespace}-fd-box-enter-active {
  transition: transform 0.15s ease, opacity 0.15s ease;
}
.${namespace}-fd-box-enter-from {
  transform: scale(0.96);
  opacity: 0;
}
</style>