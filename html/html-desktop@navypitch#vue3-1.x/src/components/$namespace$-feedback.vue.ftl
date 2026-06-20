<template>
  <Teleport to="body">
    <Transition name="ac-fb">
      <div v-if="dialog && dialog.show" class="ac-fb-root" @click.self="onOverlayClick">
        <!-- Dialog box -->
        <div class="ac-fb-box" role="alertdialog" aria-modal="true">
          <!-- Icon area -->
          <div class="ac-fb-icon-wrap" :class="'ac-fb-icon-wrap--' + dialog.type">
            <!-- success -->
            <svg v-if="dialog.type === 'success'" width="28" height="28" viewBox="0 0 24 24" fill="none">
              <circle cx="12" cy="12" r="11" fill="var(--color-teal-dim)" stroke="currentColor" stroke-width="1.5"/>
              <path d="m8 12 2.5 2.5L16 9" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
            </svg>
            <!-- warning -->
            <svg v-else-if="dialog.type === 'warning'" width="28" height="28" viewBox="0 0 24 24" fill="none">
              <circle cx="12" cy="12" r="11" fill="var(--color-amber-dim)" stroke="currentColor" stroke-width="1.5"/>
              <line x1="12" y1="8" x2="12" y2="14" stroke="currentColor" stroke-width="2" stroke-linecap="round"/>
              <circle cx="12" cy="17" r="1" fill="currentColor"/>
            </svg>
            <!-- error -->
            <svg v-else-if="dialog.type === 'error'" width="28" height="28" viewBox="0 0 24 24" fill="none">
              <circle cx="12" cy="12" r="11" fill="var(--color-red-dim)" stroke="currentColor" stroke-width="1.5"/>
              <path d="m15 9-6 6M9 9l6 6" stroke="currentColor" stroke-width="2" stroke-linecap="round"/>
            </svg>
            <!-- info -->
            <svg v-else-if="dialog.type === 'info'" width="28" height="28" viewBox="0 0 24 24" fill="none">
              <circle cx="12" cy="12" r="11" fill="var(--color-blue-dim)" stroke="currentColor" stroke-width="1.5"/>
              <line x1="12" y1="11" x2="12" y2="17" stroke="currentColor" stroke-width="2" stroke-linecap="round"/>
              <circle cx="12" cy="7.5" r="1" fill="currentColor"/>
            </svg>
            <!-- confirm -->
            <svg v-else-if="dialog.type === 'confirm'" width="28" height="28" viewBox="0 0 24 24" fill="none">
              <circle cx="12" cy="12" r="11" fill="var(--color-amber-dim)" stroke="currentColor" stroke-width="1.5"/>
              <path d="M12 8v4M12 16h.01" stroke="currentColor" stroke-width="2" stroke-linecap="round"/>
            </svg>
          </div>

          <!-- Title -->
          <h3 class="ac-fb-title">{{ dialog.title }}</h3>

          <!-- Message -->
          <p v-if="dialog.message" class="ac-fb-message">{{ dialog.message }}</p>

          <!-- Actions -->
          <div class="ac-fb-actions">
            <!-- confirm 类型：取消 + 确定 -->
            <template v-if="dialog.type === 'confirm'">
              <button class="btn btn-danger" ref="confirmBtnRef" @click="resolve(true)">确定</button>
              <button class="btn btn-default" @click="resolve(false)">取消</button>
            </template>
            <!-- alert 类型：单按钮 -->
            <template v-else>
              <button
                class="btn"
                :class="alertBtnClass"
                ref="alertBtnRef"
                @click="resolve(true)"
              >{{ alertBtnText }}</button>
            </template>
          </div>
        </div>
      </div>
    </Transition>
  </Teleport>
</template>

<script setup>
/**
 * AcFeedback — Academy Pro 全局反馈对话框
 *
 * 配合 useFeedback.js 使用：
 *   1. 根组件调用 provideFeedback()
 *   2. 传入 :dialog="dialog"
 *   3. 任意子组件调用 useFeedback().success() / .confirm() 等
 *
 * 特性:
 *   - 居中的模态对话框
 *   - 四种 alert 类型：success / warning / error / info（单确认按钮）
 *   - confirm 类型：取消 + 确定（危险操作用红色确定按钮）
 *   - 点击遮罩关闭（confirm 类型除外，防止误操作）
 *   - Teleport 到 body 保证层级
 */
import { ref, computed, watch, nextTick } from 'vue'

const props = defineProps({
  /** 对话框状态（来自 useFeedback） */
  dialog: { type: Object, default: null },
})

const confirmBtnRef = ref(null)
const alertBtnRef = ref(null)

// 打开时聚焦确认按钮
watch(() => props.dialog?.show, (v) => {
  if (v) {
    nextTick(() => {
      confirmBtnRef.value?.focus()
      alertBtnRef.value?.focus()
    })
  }
})

const alertBtnClass = computed(() => {
  const t = props.dialog?.type
  if (t === 'success') return 'btn-primary'
  if (t === 'warning') return 'btn-amber'
  if (t === 'error')   return 'btn-danger'
  return 'btn-primary' // info
})

const alertBtnText = computed(() => {
  const t = props.dialog?.type
  if (t === 'success') return '知道了'
  if (t === 'warning') return '我知道了'
  if (t === 'error')   return '关闭'
  return '确定' // info
})

function resolve(value) {
  if (props.dialog) {
    props.dialog.resolve(value)
    props.dialog.show = false
  }
}

function onOverlayClick() {
  // confirm 类型不允许点遮罩关闭
  if (props.dialog?.type !== 'confirm') {
    resolve(true)
  }
}
</script>

<style scoped>
/* ═══════════════════════════════════════════════════════════════════════════
   AcFeedback — Academy Pro 反馈对话框
   设计令牌: var(--color-*) var(--space-*) var(--radius-*) var(--shadow-*)
   ═══════════════════════════════════════════════════════════════════════════ */

/* ── Root / Overlay ─────────────────────────────── */

.ac-fb-root {
  position: fixed;
  inset: 0;
  z-index: 600;
  background: rgba(13, 27, 42, 0.45);
  backdrop-filter: blur(2px);
  display: flex;
  align-items: center;
  justify-content: center;
  padding: var(--space-13);
}

/* ── Dialog Box ─────────────────────────────────── */

.ac-fb-box {
  background: var(--color-card);
  border-radius: var(--radius-2xl);
  box-shadow: 0 20px 60px rgba(0, 0, 0, 0.25);
  width: 400px;
  max-width: 100%;
  padding: var(--space-13) var(--space-13) var(--space-11);
  text-align: center;
  display: flex;
  flex-direction: column;
  align-items: center;
}

/* ── Icon ──────────────────────────────────────── */

.ac-fb-icon-wrap {
  width: 56px;
  height: 56px;
  border-radius: var(--radius-full);
  display: flex;
  align-items: center;
  justify-content: center;
  margin-bottom: var(--space-9);
}

.ac-fb-icon-wrap--success { color: var(--color-teal);  }
.ac-fb-icon-wrap--warning { color: var(--color-amber); }
.ac-fb-icon-wrap--error   { color: var(--color-red);   }
.ac-fb-icon-wrap--info    { color: var(--color-blue);  }
.ac-fb-icon-wrap--confirm { color: var(--color-amber); }

/* ── Title ──────────────────────────────────────── */

.ac-fb-title {
  font-size: var(--text-lg);
  font-weight: var(--weight-bold);
  color: var(--color-text-main);
  margin-bottom: var(--space-4);
  line-height: 1.4;
}

/* ── Message ────────────────────────────────────── */

.ac-fb-message {
  font-size: var(--text-md);
  color: var(--color-text-sub);
  line-height: 1.6;
  margin-bottom: var(--space-11);
}

/* ── Actions ────────────────────────────────────── */

.ac-fb-actions {
  display: flex;
  gap: var(--space-7);
  justify-content: center;
  width: 100%;
}

.ac-fb-actions .btn {
  min-width: 100px;
  justify-content: center;
}

/* ── Transition ─────────────────────────────────── */

.ac-fb-enter-active {
  transition: opacity var(--transition-smooth);
}

.ac-fb-enter-active .ac-fb-box {
  transition: transform var(--transition-smooth), opacity var(--transition-smooth);
}

.ac-fb-leave-active {
  transition: opacity 0.15s ease;
}

.ac-fb-leave-active .ac-fb-box {
  transition: transform 0.15s ease, opacity 0.15s ease;
}

.ac-fb-enter-from { opacity: 0; }
.ac-fb-enter-from .ac-fb-box {
  transform: scale(0.92);
  opacity: 0;
}

.ac-fb-leave-to { opacity: 0; }
.ac-fb-leave-to .ac-fb-box {
  transform: scale(0.92);
  opacity: 0;
}
</style>
