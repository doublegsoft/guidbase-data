<template>
  <teleport to="body">
    <!-- 遮罩 -->
    <transition name="${namespace}-dialog-mask-fade">
      <div v-if="modelValue" class="${namespace}-dialog-mask" @click="onMaskClick" />
    </transition>

    <!-- 弹框 -->
    <transition name="${namespace}-dialog-box">
      <div v-if="modelValue" class="${namespace}-dialog-box" :style="{ maxWidth }">
        <!-- 头部 -->
        <div class="${namespace}-dialog-header">
          <slot name="header">
            <span class="${namespace}-dialog-title">{{ title }}</span>
          </slot>
          <button class="${namespace}-dialog-close" @click="close" aria-label="关闭">✕</button>
        </div>

        <!-- 内容 -->
        <div class="${namespace}-dialog-body">
          <slot />
        </div>

        <!-- 底部（可选） -->
        <div v-if="$slots.footer" class="${namespace}-dialog-footer">
          <slot name="footer" />
        </div>
      </div>
    </transition>
  </teleport>
</template>

<script setup>
import { watch } from 'vue'

const props = defineProps({
  modelValue:   { type: Boolean, default: false },
  title:        { type: String,  default: '' },
  maxWidth:     { type: String,  default: '960px' },
  maskClosable: { type: Boolean, default: true },
})

const emit = defineEmits(['update:modelValue', 'close', 'open'])

function close() {
  emit('update:modelValue', false)
  emit('close')
}

function onMaskClick() {
  if (props.maskClosable) close()
}

// ESC 关闭
function onKeydown(e) {
  if (e.key === 'Escape' && props.modelValue) close()
}

// 锁定 body 滚动
watch(() => props.modelValue, (val) => {
  if (val) {
    document.body.style.overflow = 'hidden'
    document.addEventListener('keydown', onKeydown)
    emit('open')
  } else {
    document.body.style.overflow = ''
    document.removeEventListener('keydown', onKeydown)
  }
})
</script>

<style scoped>
/* 遮罩 */
.${namespace}-dialog-mask {
  position: fixed; inset: 0; z-index: 1000;
  background: rgba(0, 0, 0, .45);
}

/* 弹框容器 */
.${namespace}-dialog-box {
  position: fixed; top: 50%; left: 50%; transform: translate(-50%, -50%);
  z-index: 1001;
  background: #fff; border-radius: 4px;
  width: 92vw;
  height: 90vh;
  display: flex; flex-direction: column;
  box-shadow: 0 8px 32px rgba(0, 0, 0, .2);
}

/* 头部 */
.${namespace}-dialog-header {
  display: flex; align-items: center; justify-content: space-between;
  padding: 12px 16px; flex-shrink: 0;
  border-bottom: 2px solid #1a4f8a;
}
.${namespace}-dialog-title {
  font-size: 14px; font-weight: bold; color: #1a4f8a;
  overflow: hidden; text-overflow: ellipsis; white-space: nowrap;
}
.${namespace}-dialog-close {
  width: 28px; height: 28px; border: none; background: none;
  cursor: pointer; font-size: 15px; color: #909eac;
  display: flex; align-items: center; justify-content: center;
  border-radius: 2px; flex-shrink: 0;
  transition: color .15s, background .15s;
}
.${namespace}-dialog-close:hover { color: #333; background: #f0f2f5; }

/* 内容区 */
.${namespace}-dialog-body {
  flex: 1; overflow-y: auto;
  display: flex; flex-direction: column;
}

/* footer */
.${namespace}-dialog-footer {
  flex-shrink: 0;
  padding: 10px 16px;
  border-top: 1px solid #e8e8e8;
  background: #fafbfc;
  display: flex; align-items: center; gap: 8px; justify-content: flex-end;
}

/* 遮罩动画 */
.${namespace}-dialog-mask-fade-enter-active,
.${namespace}-dialog-mask-fade-leave-active {
  transition: opacity .25s ease;
}
.${namespace}-dialog-mask-fade-enter-from,
.${namespace}-dialog-mask-fade-leave-to {
  opacity: 0;
}

/* 弹框动画 */
.${namespace}-dialog-box-enter-active,
.${namespace}-dialog-box-leave-active {
  transition: opacity .25s ease, transform .25s ease;
}
.${namespace}-dialog-box-enter-from,
.${namespace}-dialog-box-leave-to {
  opacity: 0;
  transform: translate(-50%, -50%) scale(.92);
}
</style>
