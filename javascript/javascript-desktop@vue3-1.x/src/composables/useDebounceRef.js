import { customRef } from 'vue'

/**
 * 防抖 Ref Composable (JavaScript 版本)
 * 
 * @param {*} value - 初始值
 * @param {number} [delay=500] - 延迟时间（毫秒）
 */
export function useDebouncedRef(value, delay = 500) {
  let timeoutId
  return customRef((track, trigger) => {
    return {
      get() {
        track()
        return value
      },
      set(newValue) {
        clearTimeout(timeoutId)
        timeoutId = setTimeout(() => {
          value = newValue
          trigger() // 触发更新
        }, delay)
      }
    }
  })
}