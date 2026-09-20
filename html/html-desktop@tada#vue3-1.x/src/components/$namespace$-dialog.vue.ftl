<template>
  <Transition name="tada-dialog">
    <div v-if="modelValue" class="${namespace}-dialog-root">
      <div class="${namespace}-dialog-overlay" @click="closeOnOverlay && close()"></div>

      <div
        class="${namespace}-dialog-box"
        :class="{
          '${namespace}-dialog-box--sm': size === 'sm',
          '${namespace}-dialog-box--lg': size === 'lg',
        }"
        role="dialog"
        aria-modal="true"
        @keydown.escape="close()"
      >
        <div class="${namespace}-dialog-header">
          <div class="${namespace}-dialog-header__text">
            <h3 class="${namespace}-dialog-title">{{ title }}</h3>
            <p v-if="subtitle" class="${namespace}-dialog-subtitle">{{ subtitle }}</p>
          </div>
          <button class="${namespace}-dialog-close" @click="close()" title="关闭">✕</button>
        </div>

        <div class="${namespace}-dialog-body">
          <slot />
        </div>

        <div v-if="$slots.footer" class="${namespace}-dialog-footer">
          <slot name="footer" />
        </div>
      </div>
    </div>
  </Transition>
</template>

<script setup>
defineProps({
  modelValue:    { type: Boolean, default: false },
  title:         { type: String, default: '' },
  subtitle:      { type: String, default: '' },
  size:          { type: String, default: 'md' },
  closeOnOverlay:{ type: Boolean, default: true },
})

const emit = defineEmits(['update:modelValue'])
function close() { emit('update:modelValue', false) }
</script>

<style scoped>
.${namespace}-dialog-root {
  position: fixed;
  inset: 0;
  z-index: 999;
  display: flex;
  align-items: center;
  justify-content: center;
  padding: 20px;
}

.${namespace}-dialog-overlay {
  position: absolute;
  inset: 0;
  background: rgba(30, 41, 59, 0.35);
  backdrop-filter: blur(5px);
}

.${namespace}-dialog-box {
  position: relative;
  width: 520px;
  max-width: 100%;
  max-height: 88vh;
  background: var(--${namespace}-bg, #FFFFFF);
  border: 3px solid var(--${namespace}-border, #E2EFE8);
  border-radius: var(--${namespace}-radius-lg, 24px);
  box-shadow: 0 12px 32px -4px rgba(16, 185, 129, 0.18), 0 6px 12px rgba(0, 0, 0, 0.04);
  display: flex;
  flex-direction: column;
  overflow: hidden;
  font-family: var(--${namespace}-font);
}

.${namespace}-dialog-box--sm { width: 380px; }
.${namespace}-dialog-box--lg { width: 720px; }

.${namespace}-dialog-header {
  padding: 16px 20px;
  background: #FFFFFF;
  border-bottom: 2px solid var(--${namespace}-border-light, #EEF5F1);
  display: flex;
  align-items: center;
  justify-content: space-between;
  gap: 12px;
  flex-shrink: 0;
  position: relative;
}

.${namespace}-dialog-header::before {
  content: '';
  position: absolute;
  left: 20px;
  top: 50%;
  transform: translateY(-50%);
  width: 6px;
  height: 18px;
  background: var(--${namespace}-primary, #10B981);
  border-radius: var(--${namespace}-radius-pill, 9999px);
}

.${namespace}-dialog-header__text {
  min-width: 0;
  padding-left: 14px;
}

.${namespace}-dialog-title {
  font-size: 16px;
  font-weight: 900;
  color: var(--${namespace}-text, #1E293B);
  letter-spacing: 0.02em;
}

.${namespace}-dialog-subtitle {
  font-size: 12px;
  font-weight: 700;
  color: var(--${namespace}-text-light, #94A3B8);
  margin-top: 2px;
}

.${namespace}-dialog-close {
  width: 32px;
  height: 32px;
  border-radius: var(--${namespace}-radius-pill, 9999px);
  background: #F8FCFA;
  border: 2px solid var(--${namespace}-border, #E2EFE8);
  box-shadow: 0 2px 0 #D1E3D9;
  cursor: pointer;
  font-size: 13px;
  font-weight: 900;
  display: flex;
  align-items: center;
  justify-content: center;
  color: var(--${namespace}-text-muted, #475569);
  transition: all 0.15s cubic-bezier(0.34, 1.56, 0.64, 1);
  flex-shrink: 0;
}

.${namespace}-dialog-close:hover {
  background: var(--${namespace}-danger-bg, #FFF1F2);
  border-color: var(--${namespace}-danger-border, #FECDD3);
  color: var(--${namespace}-danger, #F43F5E);
  transform: rotate(90deg) scale(1.08);
}

.${namespace}-dialog-close:active {
  transform: translateY(2px);
  box-shadow: none;
}

.${namespace}-dialog-body {
  flex: 1;
  overflow-y: auto;
  padding: 20px;
  font-size: 13px;
  font-weight: 800;
  color: var(--${namespace}-text, #1E293B);
  background: #FFFFFF;
}

.${namespace}-dialog-footer {
  padding: 14px 20px;
  background: #F8FCFA;
  border-top: 2px solid var(--${namespace}-border-light, #EEF5F1);
  display: flex;
  justify-content: flex-end;
  gap: 10px;
  flex-shrink: 0;
}

.tada-dialog-enter-active {
  transition: opacity 0.25s ease;
}

.tada-dialog-enter-active .${namespace}-dialog-box {
  transition: transform 0.3s cubic-bezier(0.34, 1.56, 0.64, 1), opacity 0.25s ease;
}

.tada-dialog-leave-active {
  transition: opacity 0.15s ease;
}

.tada-dialog-leave-active .${namespace}-dialog-box {
  transition: transform 0.15s ease, opacity 0.15s ease;
}

.tada-dialog-enter-from {
  opacity: 0;
}

.tada-dialog-enter-from .${namespace}-dialog-box {
  transform: scale(0.9) translateY(12px);
  opacity: 0;
}

.tada-dialog-leave-to {
  opacity: 0;
}

.tada-dialog-leave-to .${namespace}-dialog-box {
  transform: scale(0.95);
  opacity: 0;
}
</style>