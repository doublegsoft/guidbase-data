/**
 * useFeedback — Academy Pro 全局反馈（对话框模式）
 *
 * 通过 provide / inject 在任意组件中调起模态对话框。
 * 在 App.vue（或任意根组件）中调用 `provideFeedback()` 注册，
 * 子组件中调用 `useFeedback()` 获取反馈方法。
 *
 * 用法:
 *   // 根组件
 *   const { dialog, close } = provideFeedback()
 *   // <Feedback :dialog="dialog" :on-close="close" />
 *
 *   // 任意子组件
 *   const fb = useFeedback()
 *   await fb.success('保存成功')              // alert 风格，单按钮
 *   await fb.error('操作失败', '请重试')       // alert 风格，单按钮
 *   const ok = await fb.confirm('确定删除？')  // confirm 风格，确定/取消
 * 
 *   // loading 用法:
 *   fb.loading('正在保存中...')               // loading 风格，无按钮，屏蔽遮罩/ESC
 *   await doAsyncWork()
 *   fb.close()                               // 操作完成手动关闭
 *   // 或直接无缝切换为成功弹窗:
 *   await fb.success('保存成功')
 */
import { ref, provide, inject } from 'vue'

const KEY = Symbol('feedback')

/**
 * 在根组件调用，注册 feedback 上下文
 */
export function provideFeedback() {
  /** @type {Ref<null|{show:boolean,type:string,title:string,message:string,resolve:Function}>} */
  const dialog = ref(null)

  function show(type, title, message = '') {
    // 若当前已有弹窗（如正在展示 loading），先清理并 resolve 掉前一个 Promise
    if (dialog.value?.resolve) {
      dialog.value.resolve(false)
    }

    return new Promise(resolve => {
      dialog.value = { show: true, type, title, message, resolve }
    })
  }

  function close(result = false) {
    if (dialog.value) {
      if (dialog.value.resolve) {
        dialog.value.resolve(result)
      }
      dialog.value = null
    }
  }

  function success(title, message = '') { return show('success', title, message) }
  function warning(title, message = '') { return show('warning', title, message) }
  function error(title, message = '')   { return show('error', title, message)   }
  function info(title, message = '')    { return show('info', title, message)    }
  function confirm(title, message = '') { return show('confirm', title, message) }
  
  /**
   * 调起加载中弹窗（无按钮，防遮罩/ESC误触）
   * @param {string} [title='正在处理'] 提示标题或内容
   * @param {string} [message=''] 补充详情内容
   */
  function loading(title = '正在处理', message = '') {
    return show('loading', title, message)
  }

  const ctx = { dialog, success, warning, error, info, confirm, loading, close }
  provide(KEY, ctx)
  return ctx
}

/**
 * 在任意子组件调用，获取 feedback 方法
 */
export function useFeedback() {
  const ctx = inject(KEY, null)
  if (!ctx) {
    const noop = () => Promise.resolve()
    const noopConfirm = () => Promise.resolve(false)
    return {
      dialog: ref(null),
      success: noop, warning: noop, error: noop, info: noop,
      confirm: noopConfirm, loading: noop, close: noop,
    }
  }
  return ctx
}