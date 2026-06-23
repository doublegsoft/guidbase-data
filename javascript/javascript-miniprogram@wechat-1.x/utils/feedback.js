/**
 * fb — 微信小程序全局错误反馈工具
 *
 * 提供与 Vue3 端 useFeedback 一致的 API，底层封装 wx.showModal / wx.showToast。
 *
 * 用法：
 *   const fb = require('@/utils/fb')
 *   await fb.success('保存成功')
 *   await fb.error('操作失败', '请重试')
 *   const ok = await fb.confirm('确定删除？')
 */

/**
 * 将 fb 方法转为 Promise，用户关闭弹窗后 resolve。
 * wx.showModal 的 success 回调拿到的是用户点了确定还是取消。
 */

function showAlert(title, message, type) {
  return new Promise(resolve => {
    const config = {
      title: title,
      content: message || '',
      showCancel: false,
      confirmText: type === 'error' ? '关闭' : type === 'warning' ? '我知道了' : '确定',
      success: () => resolve(true),
      fail:  () => resolve(false),
    }
    wx.showModal(config)
  })
}

function success(title, message) {
  return new Promise(resolve => {
    wx.showToast({
      title: title,
      icon: 'success',
      duration: 2000,
      mask: false,
      success: () => setTimeout(() => resolve(true), 2000),
      fail:   () => resolve(false),
    })
  })
}

function error(title, message) {
  return showAlert(title, message, 'error')
}

function warning(title, message) {
  return showAlert(title, message, 'warning')
}

function info(title, message) {
  return showAlert(title, message, 'info')
}

function confirm(title, message) {
  return new Promise(resolve => {
    wx.showModal({
      title: title,
      content: message || '',
      showCancel: true,
      confirmText: '确定',
      cancelText:  '取消',
      confirmColor: '#E15241',
      success: res => resolve(res.confirm),
      fail:   () => resolve(false),
    })
  })
}

module.exports = {
  success,
  warning,
  error,
  info,
  confirm,
}
