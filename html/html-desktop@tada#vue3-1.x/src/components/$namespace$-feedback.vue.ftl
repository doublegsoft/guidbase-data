<template>
  <Teleport to="body">
    <div
      v-if="dialog && dialog.show"
      style="position: fixed; inset: 0; z-index: 9999; background: rgba(30, 41, 59, 0.45); backdrop-filter: blur(4px); display: flex; align-items: center; justify-content: center; padding: 20px;"
      @click.self="onOverlayClick"
    >
      <!-- ── 对话框主体卡片 (复用 ${namespace}-panel) ────────────────── -->
      <div
        class="${namespace}-panel"
        style="width: 380px; max-width: 100%; padding: 24px 20px; background: #ffffff; text-align: center; display: flex; flex-direction: column; align-items: center; box-shadow: var(--${namespace}-shadow-md);"
        role="alertdialog"
        aria-modal="true"
      >
        <!-- 萌系微章图标区 -->
        <div
          :style="iconBoxStyle"
          style="width: 58px; height: 58px; border-radius: var(--${namespace}-radius-md); display: flex; align-items: center; justify-content: center; font-size: 28px; margin-bottom: 14px; border: 2px solid;"
        >
          <!-- success -->
          <span v-if="dialog.type === 'success'">🌱</span>
          <!-- warning -->
          <span v-else-if="dialog.type === 'warning'">🧀</span>
          <!-- error -->
          <span v-else-if="dialog.type === 'error'">🍧</span>
          <!-- info -->
          <span v-else-if="dialog.type === 'info'">✨</span>
          <!-- confirm -->
          <span v-else-if="dialog.type === 'confirm'">🐾</span>
        </div>

        <!-- 标题 -->
        <h3 style="font-size: 16px; font-weight: 900; color: var(--${namespace}-text); margin-bottom: 6px;">
          {{ dialog.title }}
        </h3>

        <!-- 详细说明文案 -->
        <p
          v-if="dialog.message"
          style="font-size: 13px; font-weight: 700; color: var(--${namespace}-text-muted); line-height: 1.6; margin-bottom: 20px; padding: 0 10px;"
        >
          {{ dialog.message }}
        </p>

        <!-- ── 底部操作区 (复用 3D 果冻物理按键体系) ─────────────── -->
        <div style="display: flex; gap: 12px; justify-content: center; width: 100%;">
          <!-- confirm 类型：取消 + 确定 -->
          <template v-if="dialog.type === 'confirm'">
            <button
              type="button"
              class="${namespace}-btn ${namespace}-btn--default"
              style="flex: 1;"
              @click="resolve(false)"
            >
              再想想
            </button>
            <button
              type="button"
              class="${namespace}-btn"
              :style="confirmBtnStyle"
              ref="confirmBtnRef"
              @click="resolve(true)"
            >
              确定执行
            </button>
          </template>

          <!-- 提示类型：单按钮 -->
          <template v-else>
            <button
              type="button"
              class="${namespace}-btn ${namespace}-btn--primary"
              style="min-width: 140px;"
              ref="alertBtnRef"
              @click="resolve(true)"
            >
              {{ alertBtnText }}
            </button>
          </template>
        </div>
      </div>
    </div>
  </Teleport>
</template>

<script setup>
import { ref, computed, watch, nextTick } from 'vue'

const props = defineProps({
  /** 对话框状态对象（包含 show, type, title, message, resolve 等） */
  dialog: { type: Object, default: null },
})

const confirmBtnRef = ref(null)
const alertBtnRef = ref(null)

// 打开时自动聚焦主操作按钮
watch(() => props.dialog?.show, (v) => {
  if (v) {
    nextTick(() => {
      confirmBtnRef.value?.focus()
      alertBtnRef.value?.focus()
    })
  }
})

// 图标徽章背景与边框配色
const iconBoxStyle = computed(() => {
  const t = props.dialog?.type
  if (t === 'success') {
    return 'background: var(--' + '${namespace}' + '-primary-bg); border-color: var(--' + '${namespace}' + '-primary-border);'
  }
  if (t === 'warning' || t === 'confirm') {
    return 'background: var(--' + '${namespace}' + '-gold-bg); border-color: var(--' + '${namespace}' + '-gold-border);'
  }
  if (t === 'error') {
    return 'background: var(--' + '${namespace}' + '-danger-bg); border-color: var(--' + '${namespace}' + '-danger-border);'
  }
  return 'background: var(--' + '${namespace}' + '-primary-bg); border-color: var(--' + '${namespace}' + '-primary-border);'
})

// 确认按钮样式：如果触发危险操作采用蜜桃柔红，常规操作采用薄荷绿
const confirmBtnStyle = computed(() => {
  const isDanger = props.dialog?.danger !== false
  if (isDanger) {
    return 'flex: 1; background: linear-gradient(180deg, #fb7185 0%, var(--' + '${namespace}' + '-danger-dark) 100%); color: #fff; border-color: var(--' + '${namespace}' + '-danger-dark); box-shadow: 0 4px 0 var(--' + '${namespace}' + '-danger-dark), 0 8px 14px rgba(190, 18, 60, 0.25);'
  }
  return 'flex: 1; background: linear-gradient(180deg, #34D399 0%, var(--' + '${namespace}' + '-primary-dark) 100%); color: #fff; border-color: var(--' + '${namespace}' + '-primary-deep); box-shadow: 0 4px 0 var(--' + '${namespace}' + '-primary-deep), 0 8px 14px rgba(5, 150, 105, 0.25);'
})

// 提示类型按钮文案
const alertBtnText = computed(() => {
  const t = props.dialog?.type
  if (t === 'success') return '太棒了 🌱'
  if (t === 'warning') return '收到 🐾'
  if (t === 'error')   return '关闭'
  return '知道了 ✨'
})

function resolve(value) {
  if (props.dialog) {
    props.dialog.resolve?.(value)
    props.dialog.show = false
  }
}

function onOverlayClick() {
  // confirm 对话框禁止点击背景关闭，防止误触
  if (props.dialog?.type !== 'confirm') {
    resolve(true)
  }
}
</script>