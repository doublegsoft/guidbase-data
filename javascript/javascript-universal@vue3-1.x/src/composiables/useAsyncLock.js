import { ref } from 'vue'

/**
 * 异步锁 Composable
 * 防止异步操作（如表单提交）重复触发
 * 
 * @param {Function} fn - 需要执行的异步函数（应返回一个 Promise）
 */
export function useAsyncLock(fn) {
  const loading = ref(false)

  const run = async (...args) => {
    // 如果已经在执行中，则直接拦截，不再重复触发
    if (loading.value) return
    loading.value = true
    try {
      await fn(...args)
    } finally {
      // 无论异步函数执行成功还是失败，最后都释放锁
      loading.value = false
    }
  }

  return {
    loading,
    run
  }
}