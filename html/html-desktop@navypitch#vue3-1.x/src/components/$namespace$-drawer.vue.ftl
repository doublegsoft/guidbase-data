<template>
  <Transition name="drawer">
    <div v-if="modelValue" class="drawer-root">
      <!-- Overlay -->
      <div class="drawer-overlay" @click="closeOnOverlay && close()"></div>

      <!-- Panel -->
      <div
        class="drawer-panel"
        :class="{ 'drawer-panel--wide': wide }"
        :style="{ width: width }"
        role="dialog"
        aria-modal="true"
        @keydown.escape="close()"
      >
        <!-- Header -->
        <div class="drawer-header">
          <div class="drawer-header__left">
            <div v-if="icon" class="drawer-header__icon">{{ icon }}</div>
            <div>
              <h3 class="drawer-header__title">{{ title }}</h3>
              <p v-if="subtitle" class="drawer-header__sub">{{ subtitle }}</p>
            </div>
          </div>
          <button class="drawer-close" @click="close()" title="关闭">✕</button>
        </div>

        <!-- Body -->
        <div class="drawer-body">
          <slot />
        </div>

        <!-- Footer (optional) -->
        <div v-if="$slots.footer" class="drawer-footer">
          <slot name="footer" />
        </div>
      </div>
    </div>
  </Transition>
</template>

<script setup>
defineProps({
  modelValue: { type: Boolean, default: false },
  title:      { type: String, default: '' },
  subtitle:   { type: String, default: '' },
  icon:       { type: String, default: '' },
  width:      { type: String, default: '480px' },
  wide:       { type: Boolean, default: false },
  closeOnOverlay: { type: Boolean, default: true },
})

const emit = defineEmits(['update:modelValue'])

function close() {
  emit('update:modelValue', false)
}
</script>

<style scoped>
/* ═══════════════════════════════════════════════════════════════════════════
   DRAWER — Academy Pro · Right-Slide Panel
   ═══════════════════════════════════════════════════════════════════════════ */

.drawer-root {
  position: fixed;
  inset: 0;
  z-index: 500;
}

/* ── Overlay ──────────────────────────────────── */

.drawer-overlay {
  position: absolute;
  inset: 0;
  background: rgba(13, 27, 42, 0.5);
  backdrop-filter: blur(2px);
}

/* ── Panel ────────────────────────────────────── */

.drawer-panel {
  position: absolute;
  top: 0;
  right: 0;
  bottom: 0;
  width: 480px;
  max-width: 100vw;
  background: var(--color-card);
  box-shadow: -8px 0 40px rgba(13, 27, 42, 0.15);
  display: flex;
  flex-direction: column;
  overflow: hidden;
}

.drawer-panel--wide {
  width: 640px;
}

/* ── Header ───────────────────────────────────── */

.drawer-header {
  padding: var(--space-11) var(--space-13);
  border-bottom: 1px solid var(--color-border);
  display: flex;
  align-items: center;
  justify-content: space-between;
  gap: var(--space-7);
  flex-shrink: 0;
  background: var(--color-card);
}

.drawer-header__left {
  display: flex;
  align-items: center;
  gap: var(--space-7);
  min-width: 0;
}

.drawer-header__icon {
  width: 40px;
  height: 40px;
  border-radius: var(--radius-lg);
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: var(--text-5xl);
  flex-shrink: 0;
  background: var(--color-teal-dim);
}

.drawer-header__title {
  font-size: var(--text-2xl);
  font-weight: var(--weight-bold);
  color: var(--color-text-main);
  white-space: nowrap;
  overflow: hidden;
  text-overflow: ellipsis;
}

.drawer-header__sub {
  font-size: var(--text-md);
  color: var(--color-text-sub);
  margin-top: var(--space-1);
}

/* Close button */
.drawer-close {
  width: 32px;
  height: 32px;
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

.drawer-close:hover {
  background: var(--color-red-dim);
  border-color: var(--color-red);
  color: var(--color-red);
}

/* ── Body ─────────────────────────────────────── */

.drawer-body {
  flex: 1;
  overflow-y: auto;
  padding: var(--space-11) var(--space-13);
}

/* ── Footer ───────────────────────────────────── */

.drawer-footer {
  padding: var(--space-9) var(--space-13);
  border-top: 1px solid var(--color-border);
  display: flex;
  justify-content: flex-end;
  gap: var(--space-6);
  flex-shrink: 0;
  background: var(--color-card);
}

/* ── Transitions ──────────────────────────────── */

.drawer-enter-active {
  transition: opacity var(--transition-smooth);
}

.drawer-enter-active .drawer-panel {
  transition: transform var(--transition-smooth);
}

.drawer-leave-active {
  transition: opacity 0.15s ease;
}

.drawer-leave-active .drawer-panel {
  transition: transform 0.15s ease;
}

.drawer-enter-from {
  opacity: 0;
}

.drawer-enter-from .drawer-panel {
  transform: translateX(100%);
}

.drawer-leave-to {
  opacity: 0;
}

.drawer-leave-to .drawer-panel {
  transform: translateX(100%);
}
</style>
