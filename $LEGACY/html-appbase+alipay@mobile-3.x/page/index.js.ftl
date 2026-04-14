// index.js
// 获取应用实例
const app = getApp()

Page({
  data: {
  },
<#list pages as page>
  goto${js.nameType(page.uri?substring(page.uri?indexOf("/") + 1))}() {
    wx.navigateTo({
      url: '${page.uri?substring(page.uri?indexOf("/") + 1)}',
    })
  },
</#list>
})
