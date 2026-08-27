/**
 * Retrieves device and window height dimensions.
 * Handles backward compatibility and converts values to both px and rpx.
 * 
 * @returns {Object} An object containing height dimensions
 */
export function getSystemHeights() {
  let info = {};
  
  // Use the modern API if available, fallback to the older synchronous API
  if (typeof wx.getWindowInfo === 'function') {
    info = wx.getWindowInfo();
  } else if (typeof wx.getSystemInfoSync === 'function') {
    info = wx.getSystemInfoSync();
  } else {
    // Basic fallback values in case of unexpected environment issues
    return {
      windowHeight: 600,
      screenHeight: 800,
      windowHeightRpx: 1200,
      screenHeightRpx: 1600,
      statusBarHeight: 20
    };
  }

  const { windowHeight, screenHeight, windowWidth, statusBarHeight } = info;
  
  // Conversion ratio: 750 rpx equals the screen/window width in px
  const pxToRpxRatio = 750 / (windowWidth || 375);

  return {
    // Values in Pixels (px)
    windowHeight,                     // Usable area height (excluding nav/tab bar)
    screenHeight,                     // Physical screen height
    statusBarHeight,                  // Status bar height (top notch area)
    
    // Values in WeChat Responsive Unit (rpx)
    windowHeightRpx: Math.round(windowHeight * pxToRpxRatio),
    screenHeightRpx: Math.round(screenHeight * pxToRpxRatio),
    statusBarHeightRpx: Math.round(statusBarHeight * pxToRpxRatio),
    
    // Original safeArea object for notch/home-indicator handling
    safeArea: info.safeArea || null
  };
}