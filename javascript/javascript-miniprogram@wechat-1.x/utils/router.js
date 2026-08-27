let isNavigating = false;

export function safeNavigateTo(options) {
  if (isNavigating) return;
  isNavigating = true;

  const originalComplete = options.complete;

  options.complete = function (res) {
    // Release the lock after 1 second to allow future navigations
    setTimeout(() => {
      isNavigating = false;
    }, 1000);

    if (originalComplete) {
      originalComplete.call(this, res);
    }
  };

  wx.navigateTo(options);
}