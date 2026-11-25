import { ref, getCurrentInstance } from 'vue'
import { useRouter } from 'vue-router'

// 全局单例状态
const extraCrumbs = ref([]) // 子级面包屑栈：[{ label, path, fullPath, parentComponentName }]
const cachedViews = ref([]) // KeepAlive 缓存的组件 name 列表

// 缓存 router 实例，避免顶层 import '@/router' 引发路径错误或循环引用
let _router = null

export function setBreadcrumbRouter(routerInstance) {
  if (routerInstance) {
    _router = routerInstance
  }
}

/**
 * 在 C 页面点击按钮跳转到 D 页面时调用
 * @param {Object} options { label: 'D的标题', path: '/d路径', query?: {}, currentRoute?: route, keepPrev?: true }
 */
export function pushCrumb({ label, path, query, currentRoute, keepPrev = true }) {
  const router = _router
  if (!router) {
    console.error('[useBreadcrumb] router 未初始化，请先在组件 setup 中调用 useBreadcrumb()')
    return
  }

  const curRoute = currentRoute || router.currentRoute.value
  const matched = curRoute.matched || []
  const curComp = matched[matched.length - 1]?.components?.default
  const curName = curComp?.name || curComp?.__name

  // 1. 把当前页面(C)加入 KeepAlive 缓存，防止跳走时被销毁
  if (keepPrev && curName && !cachedViews.value.includes(curName)) {
    cachedViews.value.push(curName)
  }

  // 解析完整路径（兼容纯 path 或带 query）
  const targetLocation = query ? { path, query } : path
  const resolved = router.resolve(targetLocation)

  // 2. 压入子级面包屑并跳转 D（D 不在 cachedViews 中，离开时自动销毁）
  extraCrumbs.value.push({
    label,
    path: resolved.path,
    fullPath: resolved.fullPath,
    parentComponentName: curName
  })
  router.push(targetLocation)
}

// 兼容别名：保证 import { navigateWithCrumb } 也能直接调用
export const navigateWithCrumb = pushCrumb

/**
 * 点击面包屑中的 C（返回菜单根页面，销毁 D 及后续所有子页面）
 */
export function backToRootPage(rootPath) {
  const router = _router
  if (!router) {
    console.error('[useBreadcrumb] router 未初始化，请先在组件 setup 中调用 useBreadcrumb()')
    return
  }

  const rootCompName = extraCrumbs.value[0]?.parentComponentName
  cachedViews.value = rootCompName ? [rootCompName] : []
  extraCrumbs.value = []
  if (rootPath) {
    router.push(rootPath)
  }
}

/**
 * 支持更深层级（如 A / B / C / D / E 中点击 D，销毁 E）
 */
export function goToExtraCrumb(index) {
  const router = _router
  if (!router) {
    console.error('[useBreadcrumb] router 未初始化，请先在组件 setup 中调用 useBreadcrumb()')
    return
  }

  const target = extraCrumbs.value[index]
  if (!target) return
  extraCrumbs.value.splice(index + 1)
  const keepNames = extraCrumbs.value
    .map(item => item.parentComponentName)
    .filter(Boolean)
  cachedViews.value = [...new Set(keepNames)]
  router.push(target.fullPath || target.path)
}

/**
 * 切换顶部模块 / 左侧菜单 / 退出登录时调用：清空面包屑栈与所有缓存
 */
export function resetCrumbs() {
  extraCrumbs.value = []
  cachedViews.value = []
}

/**
 * 监听浏览器自带“后退”按钮，自动同步销毁 D
 */
export function syncOnRouteChange(newFullPath, rootPath) {
  if (extraCrumbs.value.length === 0) return
  if (newFullPath === rootPath) {
    const rootCompName = extraCrumbs.value[0]?.parentComponentName
    cachedViews.value = rootCompName ? [rootCompName] : []
    extraCrumbs.value = []
    return
  }
  const idx = extraCrumbs.value.findIndex(
    c => c.fullPath === newFullPath || c.path === newFullPath
  )
  if (idx !== -1) {
    extraCrumbs.value.splice(idx + 1)
    const keepNames = extraCrumbs.value
      .map(item => item.parentComponentName)
      .filter(Boolean)
    cachedViews.value = [...new Set(keepNames)]
  }
}

export function useBreadcrumb(customRouter) {
  if (customRouter) {
    _router = customRouter
  } else if (!_router && getCurrentInstance()) {
    _router = useRouter()
  }

  return {
    extraCrumbs,
    cachedViews,
    pushCrumb,
    navigateWithCrumb,
    backToRootPage,
    goToExtraCrumb,
    resetCrumbs,
    syncOnRouteChange
  }
}