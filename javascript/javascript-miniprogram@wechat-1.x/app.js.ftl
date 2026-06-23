// app.js

App({
  /**
   * 生命周期函数--监听小程序初始化
   * 当小程序初始化完成时，会触发 onLaunch（全局只触发一次）
   */
  onLaunch: function (options) {
    console.log("🚀 小程序启动启动中...", options);

    // 1. 执行自动登录
    // this.autoLogin();

    // 2. 获取设备系统信息并保存到全局
    this.getSystemInfo();
  },

  /**
   * 生命周期函数--监听小程序显示
   * 当小程序启动，或从后台进入前台显示时，会触发 onShow
   */
  onShow: function (options) {
    console.log("📱 小程序进入前台运行", options);
  },

  /**
   * 生命周期函数--监听小程序隐藏
   * 当小程序从前台进入后台运行时，会触发 onHide
   */
  onHide: function () {
    console.log("💤 小程序进入后台挂起");
  },

  /**
   * 错误监听函数
   * 当小程序发生脚本错误，或者 API 调用失败时，会触发 onError 并带上错误信息
   */
  onError: function (msg) {
    console.error("⚠️ 捕获到小程序全局错误:", msg);
  },

  // ==========================================
  // 自定义全局方法（可在任何页面通过 app.xxx 调用）
  // ==========================================

  // 微信快捷登录
  autoLogin: function () {
    wx.login({
      success: (res) => {
        if (res.code) {
          console.log("微信登录成功，获取到临时 code: " + res.code);
          // TODO: 将 res.code 发送给你的后端服务器，换取 openid 和 用户 Token
          this.globalData.isLoggedIn = true;
        } else {
          console.log("获取用户登录态失败！" + res.errMsg);
        }
      }
    });
  },

  // 获取系统设备信息
  getSystemInfo: function () {
    try {
      const res = wx.getSystemInfoSync();
      this.globalData.systemInfo = res;
      console.log("手机系统:", res.system);
      console.log("微信版本:", res.version);
    } catch (e) {
      console.error("获取设备系统信息失败", e);
    }
  },

  // ==========================================
  // 全局共享数据（核心）
  // ==========================================
  globalData: {
    userInfo: null,         // 存放用户信息
    isLoggedIn: false,      // 登录状态
    systemInfo: null,       // 存放手机系统信息
    apiBaseUrl: "https://api.example.com" // 全局接口地址
  }
});