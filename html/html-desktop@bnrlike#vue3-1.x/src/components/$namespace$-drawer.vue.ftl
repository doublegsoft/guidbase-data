<template>
  <teleport to="body">
    <transition name="${namespace}-drawer-mask-fade">
      <div v-if="modelValue" class="${namespace}-drawer-mask" @click="onMaskClick" />
    </transition>
    <transition name="${namespace}-drawer-slide">
      <div v-if="modelValue" class="${namespace}-drawer-panel" :style="{ width }">
        <!-- 头部 -->
        <div class="${namespace}-drawer-header">
          <slot name="header">
            <span class="${namespace}-drawer-title">{{ title }}</span>
          </slot>
          <button class="${namespace}-drawer-close" @click="close" aria-label="关闭">✕</button>
        </div>

        <!-- 内容 -->
        <div class="${namespace}-drawer-body">
          <slot />
        </div>

        <!-- 可选 footer slot -->
        <div v-if="$slots.footer" class="${namespace}-drawer-footer">
          <slot name="footer" />
        </div>
      </div>
    </transition>
  </teleport>
</template>

<script setup>
import { watch, provide } from 'vue'

const props = defineProps({
  modelValue:   { type: Boolean, default: false },
  title:        { type: String,  default: '' },
  width:        { type: String,  default: '480px' },
  maskClosable: { type: Boolean, default: true },
})

const emit = defineEmits(['update:modelValue', 'close', 'open'])

provide('dialogClose', close)

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
.${namespace}-drawer-mask {
  position: fixed; inset: 0; z-index: 1200;
  background: rgba(0,0,0,.45);
}

/* 抽屉面板 */
.${namespace}-drawer-panel {
  position: fixed; top: 0; right: 0; bottom: 0; z-index: 1201;
  background: #fff;
  box-shadow: -4px 0 20px rgba(0,0,0,.15);
  display: flex; flex-direction: column;
  overflow: hidden;
}

/* 头部 */
.${namespace}-drawer-header {
  display: flex; align-items: center; justify-content: space-between;
  height: 48px; padding: 0 16px; flex-shrink: 0;
  border-bottom: 2px solid #1a4f8a;
  background: #fff;
}
.${namespace}-drawer-title {
  font-size: 14px; font-weight: bold; color: #1a4f8a;
  overflow: hidden; text-overflow: ellipsis; white-space: nowrap;
}
.${namespace}-drawer-close {
  width: 28px; height: 28px; border: none; background: none;
  cursor: pointer; font-size: 15px; color: #909eac;
  display: flex; align-items: center; justify-content: center;
  border-radius: 2px; flex-shrink: 0;
  transition: color .15s, background .15s;
}
.${namespace}-drawer-close:hover { color: #333; background: #f0f2f5; }

/* 内容区 */
.${namespace}-drawer-body {
  flex: 1; overflow-y: auto;
}

/* footer */
.${namespace}-drawer-footer {
  flex-shrink: 0;
  padding: 10px 16px;
  border-top: 1px solid #e8e8e8;
  background: #fafbfc;
  display: flex; align-items: center; gap: 8px; justify-content: flex-end;
}

/* 遮罩动画 */
.${namespace}-drawer-mask-fade-enter-active,
.${namespace}-drawer-mask-fade-leave-active { transition: opacity .25s ease; }
.${namespace}-drawer-mask-fade-enter-from,
.${namespace}-drawer-mask-fade-leave-to     { opacity: 0; }

/* 抽屉滑动动画 */
.${namespace}-drawer-slide-enter-active,
.${namespace}-drawer-slide-leave-active {
  transition: transform .28s cubic-bezier(.4, 0, .2, 1);
}
.${namespace}-drawer-slide-enter-from,
.${namespace}-drawer-slide-leave-to { transform: translateX(100%); }
</style>
