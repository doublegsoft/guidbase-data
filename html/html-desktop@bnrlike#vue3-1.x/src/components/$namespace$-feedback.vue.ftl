<template>
  <teleport to="body">
    <transition name="${namespace}-fd-mask">
      <div v-if="visible" class="${namespace}-fd-mask" @click.self="onMaskClick">
        <transition name="${namespace}-fd-box" appear>
          <div v-if="visible" class="${namespace}-fd-box">
            <div class="${namespace}-fd-stripe" :class="'${namespace}-fd-stripe--'+typeVal"></div>
            <div class="${namespace}-fd-body">
              <div class="${namespace}-fd-icon">{{ icons[typeVal] }}</div>
              <div class="${namespace}-fd-text">
                <div class="${namespace}-fd-title">{{ titleVal }}</div>
                <div v-if="messageVal" class="${namespace}-fd-message">{{ messageVal }}</div>
              </div>
            </div>
            <div class="${namespace}-fd-footer">
              <button v-if="typeVal==='confirm'" class="${namespace}-fd-btn ${namespace}-fd-btn--cancel" @click="onCancel">{{ cancelText||'取消' }}</button>
              <button class="${namespace}-fd-btn" :class="'${namespace}-fd-btn--'+typeVal" @click="onConfirm" ref="okBtn">{{ confirmText||'确定' }}</button>
            </div>
          </div>
        </transition>
      </div>
    </transition>
  </teleport>
</template>
<script setup>
import { ref, watch, nextTick, computed } from 'vue'
const props=defineProps({
  // composable 模式：dialog 对象 { show, type, title, message, resolve }
  dialog:     { type: Object, default: null },
  // composable 模式：关闭回调，由 useFeedback 的 close() 提供
  onClose:    { type: Function, default: null },
  // 独立 v-model 模式（兼容旧用法）
  modelValue: { type: Boolean, default: false },
  type:       { type: String, default: 'info' },
  title:      { type: String, default: '提示' },
  message:    { type: String, default: '' },
  confirmText:{ type: String, default: '' },
  cancelText: { type: String, default: '' },
})
const emit=defineEmits(['update:modelValue','confirm','cancel'])

// 如果传了 dialog prop，使用 composable 模式；否则使用独立 v-model 模式
const hasDialog = computed(() => props.dialog !== null)

const visible = computed(() => hasDialog.value ? !!props.dialog?.show : props.modelValue)
const typeVal = computed(() => hasDialog.value ? (props.dialog?.type || 'info') : props.type)
const titleVal = computed(() => hasDialog.value ? (props.dialog?.title || '提示') : props.title)
const messageVal = computed(() => hasDialog.value ? (props.dialog?.message || '') : props.message)

const okBtn=ref(null)
const icons={confirm:'❓',success:'✅',error:'❌',warning:'⚠️',info:'ℹ️'}

// visible 变化时聚焦 OK 按钮
watch(visible, v => { if(v) nextTick(()=>okBtn.value?.focus()) })

function close(r){
  if (hasDialog.value) {
    // composable 模式：调用 onClose 回调，由 useFeedback.close() 清理 dialog 并 resolve
    if (props.onClose) {
      props.onClose(r)
    } else if (props.dialog?.resolve) {
      // 兜底：直接 resolve，但 dialog 不会自动清理
      props.dialog.resolve(r)
    }
  } else {
    // 独立 v-model 模式
    emit('update:modelValue', false);
    emit(r ? 'confirm' : 'cancel');
  }
}
function onConfirm(){close(true)}
function onCancel(){close(false)}
function onMaskClick(){if(typeVal.value!=='confirm')close(false)}
function onKey(e){if(e.key==='Escape')close(false)}
watch(visible,v=>{if(v)document.addEventListener('keydown',onKey);else document.removeEventListener('keydown',onKey)})
</script>
<style scoped>
.${namespace}-fd-mask{position:fixed;inset:0;z-index:9999;background:rgba(0,0,0,.45);display:flex;align-items:center;justify-content:center}
.${namespace}-fd-box{background:#fff;border-radius:4px;min-width:300px;max-width:460px;width:90vw;box-shadow:0 8px 32px rgba(0,0,0,.2);overflow:hidden}
.${namespace}-fd-stripe{height:4px}
.${namespace}-fd-stripe--confirm,.${namespace}-fd-stripe--info{background:#1a4f8a}
.${namespace}-fd-stripe--success{background:#1e8449}
.${namespace}-fd-stripe--error{background:#c0392b}
.${namespace}-fd-stripe--warning{background:#d46b08}
.${namespace}-fd-body{padding:22px 22px 14px;display:flex;gap:14px;align-items:flex-start}
.${namespace}-fd-icon{font-size:28px;flex-shrink:0;line-height:1;margin-top:2px}
.${namespace}-fd-text{flex:1}
.${namespace}-fd-title{font-size:15px;font-weight:bold;color:#1c2833;margin-bottom:6px;line-height:1.4}
.${namespace}-fd-message{font-size:13px;color:#5d6d7e;line-height:1.6;white-space:pre-line}   
.${namespace}-fd-footer{display:flex;justify-content:flex-end;gap:8px;padding:12px 20px;border-top:1px solid #f0f0f0;background:#fafbfc}
.${namespace}-fd-btn{height:30px;padding:0 18px;font-size:13px;font-family:inherit;border:1px solid;border-radius:2px;cursor:pointer;transition:background .15s}
.${namespace}-fd-btn--cancel{background:#fff;color:#333;border-color:#c8c8c8}
.${namespace}-fd-btn--cancel:hover{background:#f5f5f5}
.${namespace}-fd-btn--confirm,.${namespace}-fd-btn--info{background:#1a4f8a;color:#fff;border-color:#1a4f8a}
.${namespace}-fd-btn--confirm:hover,.${namespace}-fd-btn--info:hover{background:#15407a}
.${namespace}-fd-btn--success{background:#1e8449;color:#fff;border-color:#1e8449}
.${namespace}-fd-btn--success:hover{background:#196f3d}
.${namespace}-fd-btn--error{background:#c0392b;color:#fff;border-color:#c0392b}
.${namespace}-fd-btn--error:hover{background:#a93226}
.${namespace}-fd-btn--warning{background:#d46b08;color:#fff;border-color:#d46b08}
.${namespace}-fd-btn--warning:hover{background:#b85a06}
</style>
