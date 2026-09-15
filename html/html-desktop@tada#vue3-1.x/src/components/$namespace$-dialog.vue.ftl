<template>
  <Transition name="dialog">
    <div v-if="modelValue" class="dialog-root">
      <!-- Overlay -->
      <div class="dialog-overlay" @click="closeOnOverlay && close()"></div>

      <!-- Dialog box -->
      <div
        class="dialog-box"
        :class="{
          'dialog-box--sm': size === 'sm',
          'dialog-box--lg': size === 'lg',
        }"
        role="dialog"
        aria-modal="true"
        @keydown.escape="close()"
      >
        <!-- Header -->
        <div class="dialog-header">
          <div class="dialog-header__text">
            <h3 class="dialog-title">{{ title }}</h3>
            <p v-if="subtitle" class="dialog-subtitle">{{ subtitle }}</p>
          </div>
          <button class="dialog-close" @click="close()" title="关闭">✕</button>
        </div>

        <!-- Body -->
        <div class="dialog-body">
          <slot />
        </div>

        <!-- Footer -->
        <div v-if="$slots.footer" class="dialog-footer">
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
  size:          { type: String, default: 'md' },   // 'sm' | 'md' | 'lg'
  closeOnOverlay:{ type: Boolean, default: true },
})

const emit = defineEmits(['update:modelValue'])
function close() { emit('update:modelValue', false) }
</script>

<style scoped>
/* ═══════════════════════════════════════════════════════════════════════════
   DIALOG — Academy Pro · Centered Modal for Edit / Confirm
   ═══════════════════════════════════════════════════════════════════════════ */

.dialog-root {
  position: fixed;
  inset: 0;
  z-index: 500;
  display: flex;
  align-items: center;
  justify-content: center;
  padding: var(--space-13);
}

/* ── Overlay ──────────────────────────────────── */

.dialog-overlay {
  position: absolute;
  inset: 0;
  background: rgba(13, 27, 42, 0.5);
  backdrop-filter: blur(2px);
}

/* ── Box ──────────────────────────────────────── */

.dialog-box {
  position: relative;
  width: 540px;
  max-width: 100%;
  max-height: 85vh;
  background: var(--color-card);
  border-radius: var(--radius-2xl);
  box-shadow: 0 20px 60px rgba(0, 0, 0, 0.25);
  display: flex;
  flex-direction: column;
  overflow: hidden;
}

.dialog-box--sm { width: 400px; }
.dialog-box--lg { width: 720px; }

/* ── Header ───────────────────────────────────── */

.dialog-header {
  padding: var(--space-11) var(--space-13) var(--space-9);
  border-bottom: 1px solid var(--color-border);
  display: flex;
  align-items: flex-start;
  justify-content: space-between;
  gap: var(--space-7);
  flex-shrink: 0;
}

.dialog-header__text { min-width: 0; }

.dialog-title {
  font-size: var(--text-2xl);
  font-weight: var(--weight-bold);
  color: var(--color-text-main);
}

.dialog-subtitle {
  font-size: var(--text-md);
  color: var(--color-text-sub);
  margin-top: var(--space-1);
}

.dialog-close {
  width: 32px; height: 32px;
  border-radius: var(--radius-md);
  background: var(--color-surface);
  border: 1px solid var(--color-border);
  cursor: pointer;
  font-size: var(--text-lg);
  display: flex;
  align-items: center;
  justify-content: center;
  color: var(--color-text-sub);
  transition: all var(--transition-base);
  flex-shrink: 0;
  font-family: inherit;
}

.dialog-close:hover {
  background: var(--color-red-dim);
  border-color: var(--color-red);
  color: var(--color-red);
}

/* ── Body ─────────────────────────────────────── */

.dialog-body {
  flex: 1;
  overflow-y: auto;
  padding: var(--space-11) var(--space-13);
}

/* ── Footer ───────────────────────────────────── */

.dialog-footer {
  padding: var(--space-9) var(--space-13);
  border-top: 1px solid var(--color-border);
  display: flex;
  justify-content: flex-end;
  gap: var(--space-6);
  flex-shrink: 0;
}

/* ── Transitions ──────────────────────────────── */

.dialog-enter-active { transition: opacity var(--transition-smooth); }

.dialog-enter-active .dialog-box {
  transition: transform var(--transition-smooth), opacity var(--transition-smooth);
}

.dialog-leave-active {
  transition: opacity 0.12s ease;
}

.dialog-leave-active .dialog-box {
  transition: transform 0.12s ease, opacity 0.12s ease;
}

.dialog-enter-from { opacity: 0; }

.dialog-enter-from .dialog-box {
  transform: scale(0.95);
  opacity: 0;
}

.dialog-leave-to { opacity: 0; }

.dialog-leave-to .dialog-box {
  transform: scale(0.95);
  opacity: 0;
}
</style>
