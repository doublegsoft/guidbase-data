import { ref } from 'vue'

// 模块级单例 — 所有组件共享同一个状态
const showPrevNext = ref(true)

export function useNavControl() {
  function show()  { showPrevNext.value = true }
  function hide()  { showPrevNext.value = false }
  function toggle(){ showPrevNext.value = !showPrevNext.value }

  return { showPrevNext, show, hide, toggle }
}
