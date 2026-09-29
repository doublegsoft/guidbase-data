/* 
** ═══════════════════════════════════════════════════════════════════════
**  DESIGN SYSTEM: NEUMORPHISM EDITION (新拟物主义 / 软拟态)
**  Platform: WeChat Mini Program (100% Native RPX)
**  Architecture: Dual-Shadow Extrusion & Inset Tactile System
** ═══════════════════════════════════════════════════════════════════════ 
*/

/* 
** ─────────────────────────────────────────────────────────────────────
**  FOUNDATION: DESIGN TOKENS (系统设计变量令牌)
** ───────────────────────────────────────────────────────────────────── 
*/
page {
  /* ── 语义色彩系统 (保留饱和度以在柔和拟物灰底上呈现点睛效果) ── */
  --color-primary:         #0284C7;
  --color-primary-light:   #38BDF8;
  --color-primary-hover:   #0369A1;
  --color-primary-dim:     rgba(2, 132, 199, 0.12);
  --color-primary-text:    #0284C7;

  --color-secondary:       #1E293B;
  --color-secondary-light: #334155;
  --color-secondary-hover: #0F172A;
  --color-secondary-dim:   rgba(30, 41, 59, 0.1);
  --color-secondary-text:  #1E293B;

  --color-warning:         #D97706;
  --color-warning-light:   #F59E0B;
  --color-warning-hover:   #B45309;
  --color-warning-dim:     rgba(217, 119, 6, 0.12);
  --color-warning-text:    #B45309;

  --color-danger:          #E11D48;
  --color-danger-light:    #FB7185;
  --color-danger-hover:    #BE123C;
  --color-danger-dim:      rgba(225, 29, 72, 0.12);
  --color-danger-text:     #BE123C;

  --color-success:         #059669;
  --color-success-light:   #10B981;
  --color-success-hover:   #047857;
  --color-success-dim:     rgba(5, 150, 105, 0.12);
  --color-success-text:    #047857;

  --color-info:            #6366F1;
  --color-info-light:      #818CF8;
  --color-info-hover:      #4F46E5;
  --color-info-dim:        rgba(99, 102, 241, 0.12);
  --color-info-text:       #4F46E5;

  /* ── Neumorphism 核心基底与阴影令牌 (关键：背景与卡片同色) ── */
  --color-bg:              #E6EDF5; /* 经典新拟物冷灰底色 */
  --color-card:            #E6EDF5; /* 卡片与背景同源 */
  --color-surface:         #DBE4EF; /* 凹陷态/次级填充色 */
  --color-surface-hover:   #D1DDEB;
  --color-surface-active:  #C7D5E5;

  /* 物理双重投影：左上极亮纯白 + 右下漫反射柔灰暗影 */
  --neu-light:             #FFFFFF;
  --neu-dark:              rgba(163, 177, 198, 0.65);
  --neu-dark-deep:         rgba(163, 177, 198, 0.9);

  /* ── 排版文字与微弱辅助线 ── */
  --color-text-main:       #1E293B; /* 柔和深板岩墨色 */
  --color-text-sub:        #475569;
  --color-text-muted:      #8B9BB4;
  --color-border:          rgba(255, 255, 255, 0.6); /* 拟物风格主要靠阴影，边框转为环境微光 */
  --color-border-subtle:   rgba(163, 177, 198, 0.25);

  /* ── 字体大小标尺 ── */
  --text-2xs:  20rpx;
  --text-xs:   22rpx;
  --text-sm:   24rpx;
  --text-base: 26rpx;
  --text-md:   28rpx;
  --text-body: 30rpx;
  --text-lg:   32rpx;
  --text-xl:   34rpx;
  --text-2xl:  36rpx;
  --text-3xl:  40rpx;
  --text-4xl:  44rpx;
  --text-5xl:  48rpx;
  --text-6xl:  56rpx;
  --text-7xl:  64rpx;

  /* ── 字重阶梯 ── */
  --weight-light:     300;
  --weight-normal:    400;
  --weight-medium:    500;
  --weight-semibold:  600;
  --weight-bold:      700;
  --weight-extrabold: 800;

  /* ── 间距体系 ── */
  --space-1:    4rpx;
  --space-2:    8rpx;
  --space-3:   12rpx;
  --space-4:   16rpx;
  --space-5:   20rpx;
  --space-6:   24rpx;
  --space-7:   28rpx;
  --space-8:   32rpx;
  --space-9:   36rpx;
  --space-10:  40rpx;
  --space-11:  44rpx;
  --space-12:  48rpx;
  --space-13:  56rpx;
  --space-14:  64rpx;

  /* ── 圆角系统 (新拟物化依赖大圆角来呈现圆润塑料/橡皮泥挤压感) ── */
  --radius-xs:    8rpx;
  --radius-sm:   14rpx;
  --radius-md:   20rpx;
  --radius-lg:   26rpx;
  --radius-xl:   34rpx;
  --radius-2xl:  44rpx;
  --radius-pill: 9999rpx;
  --radius-full: 50%;

  /* ── 新拟物多级双向阴影规范 ── */
  --shadow-sm:   -4rpx -4rpx 10rpx var(--neu-light), 4rpx 4rpx 10rpx var(--neu-dark);
  --shadow-md:   -8rpx -8rpx 18rpx var(--neu-light), 8rpx 8rpx 18rpx var(--neu-dark);
  --shadow-lg:   -14rpx -14rpx 28rpx var(--neu-light), 14rpx 14rpx 28rpx var(--neu-dark);
  
  /* 凹陷/按压态内阴影 (Inset Shadows) */
  --shadow-inset-sm: inset -3rpx -3rpx 6rpx var(--neu-light), inset 3rpx 3rpx 6rpx var(--neu-dark);
  --shadow-inset-md: inset -6rpx -6rpx 12rpx var(--neu-light), inset 6rpx 6rpx 12rpx var(--neu-dark);

  /* ── 动效转场 ── */
  --anim-fast:   0.15s ease;
  --anim-base:   0.25s ease;
  --anim-smooth: 0.35s cubic-bezier(0.4, 0, 0.2, 1);
}

/* 
** ─────────────────────────────────────────────────────────────────────
**  GLOBAL BASE & RESETS (全局重置与页面基底)
** ───────────────────────────────────────────────────────────────────── 
*/
page {
  background: var(--color-bg);
  color: var(--color-text-main);
  font-family: -apple-system, BlinkMacSystemFont, "SF Pro Text", "PingFang SC", "Segoe UI", Roboto, sans-serif;
  font-size: var(--text-md);
  line-height: 1.5;
  letter-spacing: -0.2rpx;
  -webkit-font-smoothing: antialiased;
}

/* ── 固定在视口顶部的操作容器 ── */
.page-toolbar {
  position: fixed;
  top: 0;
  left: 0;
  right: 0;
  z-index: 90;
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: 18rpx var(--space-6);
  background: var(--color-bg);
  box-shadow: 0 10rpx 20rpx -6rpx var(--neu-dark);
  box-sizing: border-box;
}

/* ── 顶部防遮挡占位槽 ── */
.page-toolbar-placeholder {
  width: 100%;
  height: 100rpx;
  box-sizing: content-box;
}

/* ── 固定在视口底部的操作容器 ── */
.page-footer {
  position: fixed;
  left: 0;
  right: 0;
  bottom: 0;
  z-index: 90;
  display: flex;
  align-items: center;
  gap: var(--space-4);
  padding: 24rpx var(--space-6);
  background: var(--color-bg);
  box-shadow: 0 -10rpx 24rpx -4rpx var(--neu-dark);
  box-sizing: border-box;
  padding-bottom: calc(24rpx + constant(safe-area-inset-bottom));
  padding-bottom: calc(24rpx + env(safe-area-inset-bottom));
}

.page-footer .btn {
  flex: 1;
}

/* ── 辅助占位块 ── */
.page-footer-placeholder {
  width: 100%;
  height: 130rpx;
  padding-bottom: constant(safe-area-inset-bottom);
  padding-bottom: env(safe-area-inset-bottom);
  box-sizing: content-box;
}

.safe-area-bottom {
  padding-bottom: constant(safe-area-inset-bottom);
  padding-bottom: env(safe-area-inset-bottom);
}

/* 
** ─────────────────────────────────────────────────────────────────────
**  LAYOUT & UTILITIES (盒模型、排版与原子工具类)
** ───────────────────────────────────────────────────────────────────── 
*/
.flex           { display: flex; }
.flex-col       { display: flex; flex-direction: column; }
.flex-row       { display: flex; flex-direction: row; }
.flex-wrap      { flex-wrap: wrap; }
.flex-nowrap    { flex-wrap: nowrap; }
.flex-1         { flex: 1; min-width: 0; }
.items-center   { align-items: center; }
.items-start    { align-items: flex-start; }
.items-end      { align-items: flex-end; }
.items-stretch  { align-items: stretch; }
.justify-center { justify-content: center; }
.justify-between{ justify-content: space-between; }
.justify-end    { justify-content: flex-end; }
.justify-start  { justify-content: flex-start; }

.grid-2 { display: grid; grid-template-columns: repeat(2, 1fr); gap: var(--space-5); }
.grid-3 { display: grid; grid-template-columns: repeat(3, 1fr); gap: var(--space-4); }
.grid-4 { display: grid; grid-template-columns: repeat(4, 1fr); gap: var(--space-3); }

.gap-1  { gap: var(--space-1); }
.gap-2  { gap: var(--space-2); }
.gap-3  { gap: var(--space-3); }
.gap-4  { gap: var(--space-4); }
.gap-5  { gap: var(--space-5); }
.gap-6  { gap: var(--space-6); }
.gap-7  { gap: var(--space-7); }
.gap-8  { gap: var(--space-8); }
.gap-10 { gap: var(--space-10); }
.gap-12 { gap: var(--space-12); }

.p-2    { padding: var(--space-2); }
.p-4    { padding: var(--space-4); }
.p-5    { padding: var(--space-5); }
.p-6    { padding: var(--space-6); }
.p-7    { padding: var(--space-7); }
.p-8    { padding: var(--space-8); }
.p-10   { padding: var(--space-10); }
.p-12   { padding: var(--space-12); }

.px-2   { padding-left: var(--space-2); padding-right: var(--space-2); }
.px-4   { padding-left: var(--space-4); padding-right: var(--space-4); }
.px-6   { padding-left: var(--space-6); padding-right: var(--space-6); }
.px-8   { padding-left: var(--space-8); padding-right: var(--space-8); }
.px-10  { padding-left: var(--space-10); padding-right: var(--space-10); }
.px-12  { padding-left: var(--space-12); padding-right: var(--space-12); }

.py-2   { padding-top: var(--space-2); padding-bottom: var(--space-2); }
.py-4   { padding-top: var(--space-4); padding-bottom: var(--space-4); }
.py-6   { padding-top: var(--space-6); padding-bottom: var(--space-6); }
.py-8   { padding-top: var(--space-8); padding-bottom: var(--space-8); }
.py-10  { padding-top: var(--space-10); padding-bottom: var(--space-10); }

.mt-1   { margin-top: var(--space-1); }
.mt-2   { margin-top: var(--space-2); }
.mt-3   { margin-top: var(--space-3); }
.mt-4   { margin-top: var(--space-4); }
.mt-5   { margin-top: var(--space-5); }
.mt-6   { margin-top: var(--space-6); }
.mt-7   { margin-top: var(--space-7); }
.mt-8   { margin-top: var(--space-8); }
.mt-10  { margin-top: var(--space-10); }
.mt-12  { margin-top: var(--space-12); }
.mt-14  { margin-top: var(--space-14); }

.mb-1   { margin-bottom: var(--space-1); }
.mb-2   { margin-bottom: var(--space-2); }
.mb-3   { margin-bottom: var(--space-3); }
.mb-4   { margin-bottom: var(--space-4); }
.mb-5   { margin-bottom: var(--space-5); }
.mb-6   { margin-bottom: var(--space-6); }
.mb-7   { margin-bottom: var(--space-7); }
.mb-8   { margin-bottom: var(--space-8); }
.mb-10  { margin-bottom: var(--space-10); }
.mb-12  { margin-bottom: var(--space-12); }
.mb-14  { margin-bottom: var(--space-14); }

.ml-auto { margin-left: auto; }
.mr-auto { margin-right: auto; }
.w-full  { width: 100%; box-sizing: border-box; }
.h-full  { height: 100%; }

.text-2xs  { font-size: var(--text-2xs); }
.text-xs   { font-size: var(--text-xs); }
.text-sm   { font-size: var(--text-sm); }
.text-base { font-size: var(--text-base); }
.text-md   { font-size: var(--text-md); }
.text-body { font-size: var(--text-body); }
.text-lg   { font-size: var(--text-lg); }
.text-xl   { font-size: var(--text-xl); }
.text-2xl  { font-size: var(--text-2xl); }
.text-3xl  { font-size: var(--text-3xl); }
.text-4xl  { font-size: var(--text-4xl); }
.text-5xl  { font-size: var(--text-5xl); }
.text-6xl  { font-size: var(--text-6xl); }
.text-7xl  { font-size: var(--text-7xl); }

.weight-normal    { font-weight: var(--weight-normal); }
.weight-medium    { font-weight: var(--weight-medium); }
.weight-semibold  { font-weight: var(--weight-semibold); }
.weight-bold      { font-weight: var(--weight-bold); }
.weight-extrabold { font-weight: var(--weight-extrabold); }

.text-center { text-align: center; }
.text-right  { text-align: right; }
.text-left   { text-align: left; }

.color-main      { color: var(--color-text-main); }
.color-sub       { color: var(--color-text-sub); }
.color-muted     { color: var(--color-text-muted); }
.color-primary   { color: var(--color-primary); }
.color-secondary { color: var(--color-secondary); }
.color-warning   { color: var(--color-warning); }
.color-danger    { color: var(--color-danger); }
.color-success   { color: var(--color-success); }
.color-info      { color: var(--color-info); }

/* 
** ─────────────────────────────────────────────────────────────────────
**  COMPONENT: BUTTON (新拟物触感按键)
** ───────────────────────────────────────────────────────────────────── 
*/
/* ── 按钮基类 (凸起塑料按键形态) ── */
/* 
** ─────────────────────────────────────────────────────────────────────
**  COMPONENT: BUTTON (纯正新拟物软浮雕物理按键系统)
** ───────────────────────────────────────────────────────────────────── 
*/

/* ── 按钮基类 (默认与背景同色，依靠双向阴影呈现软塑料微凸台) ── */
.btn {
  position: relative;
  display: inline-flex;
  align-items: center;
  justify-content: center;
  gap: var(--space-3);
  padding: 22rpx 44rpx;
  border-radius: var(--radius-pill);
  font-size: var(--text-md);
  font-weight: var(--weight-semibold);
  border: 1.5rpx solid rgba(255, 255, 255, 0.8); /* 顶部边缘微高光环境线 */
  background: var(--color-bg);                     /* 关键：底色与背景绝对同色 */
  color: var(--color-text-main);
  box-shadow: -6rpx -6rpx 14rpx var(--neu-light), 
               6rpx  6rpx 14rpx var(--neu-dark);
  line-height: 1.35;
  box-sizing: border-box;
  white-space: nowrap;
  transition: all var(--anim-fast);
}
.btn::after { border: none; }

/* ── 核心通用物理按压态 (从凸出立即转变为被手指凹陷进去的 Inset 状态) ── */
.btn:active {
  box-shadow: inset -4rpx -4rpx 10rpx var(--neu-light), 
              inset  4rpx  4rpx 10rpx var(--neu-dark);
  transform: translateY(2rpx);
}

/* ── 1. Default 次要/常规按键 ── */
.btn-default {
  background: var(--color-bg);
  color: var(--color-text-sub);
}
.btn-default:active {
  color: var(--color-text-main);
}

/* ── 2. Primary 核心主色按钮 (拟物青蓝：暗底带彩色微光扩散) ── */
.btn-primary {
  background: var(--color-bg);
  color: var(--color-primary-text);
  font-weight: var(--weight-bold);
  box-shadow: -6rpx -6rpx 14rpx var(--neu-light), 
               6rpx  6rpx 16rpx rgba(0, 201, 167, 0.35); /* 右下暗影融入主色微光 */
}
.btn-primary:active {
  background: var(--color-surface);
  box-shadow: inset -4rpx -4rpx 10rpx var(--neu-light), 
              inset  4rpx  4rpx 12rpx rgba(0, 201, 167, 0.4);
}

/* ── 3. Secondary 极夜深墨凸起按键 (反色实体拟物变体) ── */
.btn-secondary {
  background: var(--color-secondary);
  color: #FFFFFF;
  border-color: rgba(255, 255, 255, 0.12);
  box-shadow: -6rpx -6rpx 14rpx var(--neu-light), 
               6rpx  6rpx 16rpx var(--neu-dark);
}
.btn-secondary:active {
  box-shadow: inset -4rpx -4rpx 10rpx rgba(255, 255, 255, 0.15), 
              inset  4rpx  4rpx 12rpx #000000;
}

/* ── 4. Warning 琥珀警告/打卡挑战按键 ── */
.btn-warning {
  background: var(--color-bg);
  color: var(--color-warning-text);
  font-weight: var(--weight-bold);
  box-shadow: -6rpx -6rpx 14rpx var(--neu-light), 
               6rpx  6rpx 16rpx rgba(245, 166, 35, 0.35);
}
.btn-warning:active {
  background: var(--color-surface);
  box-shadow: inset -4rpx -4rpx 10rpx var(--neu-light), 
              inset  4rpx  4rpx 12rpx rgba(245, 166, 35, 0.4);
}

/* ── 5. Danger 珊瑚红危险/删除按键 ── */
.btn-danger {
  background: var(--color-bg);
  color: var(--color-danger-text);
  font-weight: var(--weight-bold);
  box-shadow: -6rpx -6rpx 14rpx var(--neu-light), 
               6rpx  6rpx 16rpx rgba(231, 76, 111, 0.35);
}
.btn-danger:active {
  background: var(--color-surface);
  box-shadow: inset -4rpx -4rpx 10rpx var(--neu-light), 
              inset  4rpx  4rpx 12rpx rgba(231, 76, 111, 0.4);
}

/* ── 6. Success 达成/成功活力绿按键 ── */
.btn-success {
  background: var(--color-bg);
  color: var(--color-success-text);
  font-weight: var(--weight-bold);
  box-shadow: -6rpx -6rpx 14rpx var(--neu-light), 
               6rpx  6rpx 16rpx rgba(39, 174, 96, 0.35);
}
.btn-success:active {
  background: var(--color-surface);
  box-shadow: inset -4rpx -4rpx 10rpx var(--neu-light), 
              inset  4rpx  4rpx 12rpx rgba(39, 174, 96, 0.4);
}

/* ── 7. Info 认知靛青按键 ── */
.btn-info {
  background: var(--color-bg);
  color: var(--color-info-text);
  font-weight: var(--weight-bold);
  box-shadow: -6rpx -6rpx 14rpx var(--neu-light), 
               6rpx  6rpx 16rpx rgba(59, 139, 235, 0.35);
}
.btn-info:active {
  background: var(--color-surface);
  box-shadow: inset -4rpx -4rpx 10rpx var(--neu-light), 
              inset  4rpx  4rpx 12rpx rgba(59, 139, 235, 0.4);
}

/* ── 8. Outline 凹槽镂空按钮 (默认即为微凹陷态) ── */
.btn-outline {
  background: var(--color-surface);
  color: var(--color-primary);
  border: 1.5rpx solid rgba(255, 255, 255, 0.6);
  box-shadow: inset -3rpx -3rpx 8rpx var(--neu-light), 
              inset  3rpx  3rpx 8rpx var(--neu-dark);
}
.btn-outline:active {
  box-shadow: -4rpx -4rpx 10rpx var(--neu-light), 
               4rpx  4rpx 10rpx var(--neu-dark); /* 反转回浮起 */
}

/* ── 规格阶梯 ── */
.btn-sm  { padding: 12rpx 26rpx; font-size: var(--text-xs); }
.btn-lg  { padding: 28rpx 54rpx; font-size: var(--text-lg); }
.btn-block { width: 100%; display: flex; }

/* ── 操作按钮组 ── */
.btn-actions { display: flex; gap: var(--space-4); padding: var(--space-4) 0; }
.btn-action {
  flex: 1;
  padding: 22rpx;
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: var(--text-md);
  font-weight: var(--weight-semibold);
  border-radius: var(--radius-pill);
  box-sizing: border-box;
}

/* 
** ─────────────────────────────────────────────────────────────────────
**  COMPONENT: CARD (新拟物浮雕卡片系统)
** ───────────────────────────────────────────────────────────────────── 
*/
/* ── 基础标准卡片 (浮出表面的圆润凸台) ── */
.card {
  margin: 0 var(--space-6) var(--space-6);
  background: var(--color-bg);
  border-radius: var(--radius-xl);
  border: 1.5rpx solid rgba(255, 255, 255, 0.7);
  box-shadow: var(--shadow-md);
  overflow: hidden;
  transition: all var(--anim-fast);
}

/* 交互卡片按压态 (从凸出浮雕变为被按入平面) */
.card-interactive:active {
  transform: translateY(2rpx);
  box-shadow: var(--shadow-sm);
}

.card-header {
  padding: 26rpx 30rpx;
  display: flex;
  align-items: center;
  justify-content: space-between;
  border-bottom: 1.5rpx solid var(--color-border-subtle);
}

.card-title {
  font-size: var(--text-body);
  font-weight: var(--weight-bold);
  color: var(--color-text-main);
  letter-spacing: -0.4rpx;
  line-height: 1.3;
}

.card-sub {
  font-size: var(--text-xs);
  color: var(--color-text-muted);
  margin-top: 4rpx;
  line-height: 1.4;
}

.card-body {
  padding: 26rpx 30rpx;
}

.card-body-flush {
  padding: 0;
}

.card-footer {
  padding: 22rpx 30rpx;
  display: flex;
  align-items: center;
  justify-content: flex-end;
  gap: var(--space-3);
  border-top: 1.5rpx solid var(--color-border-subtle);
  background: var(--color-bg);
  box-sizing: border-box;
}

.card-footer-between {
  justify-content: space-between;
}

.card-footer-subtle {
  background: var(--color-surface);
  box-shadow: inset 0 3rpx 6rpx rgba(163, 177, 198, 0.2);
}

.card-footer-text {
  font-size: var(--text-xs);
  color: var(--color-text-muted);
  line-height: 1.4;
}

/* 
** ─────────────────────────────────────────────────────────────────────
**  COMPONENT: AVATAR (双向光泽立体头像)
** ───────────────────────────────────────────────────────────────────── 
*/
.avatar {
  position: relative;
  display: inline-flex;
  align-items: center;
  justify-content: center;
  width: 76rpx;
  height: 76rpx;
  border-radius: var(--radius-lg);
  font-size: var(--text-base);
  font-weight: var(--weight-bold);
  color: var(--color-text-main);
  background: var(--color-bg);
  border: 2rpx solid rgba(255, 255, 255, 0.8);
  box-shadow: var(--shadow-sm);
  box-sizing: border-box;
  flex-shrink: 0;
}

.avatar-img {
  width: 100%;
  height: 100%;
  border-radius: inherit;
  object-fit: cover;
  display: block;
}

.avatar-text {
  font-size: inherit;
  font-weight: inherit;
  line-height: 1;
}

.avatar-round,
.avatar-circle {
  border-radius: var(--radius-full);
}

.avatar-square {
  border-radius: var(--radius-sm);
}

.avatar-xs { width: 48rpx; height: 48rpx; font-size: var(--text-2xs); }
.avatar-sm { width: 60rpx; height: 60rpx; font-size: var(--text-xs); }
.avatar-md { width: 76rpx; height: 76rpx; font-size: var(--text-base); }
.avatar-lg { width: 100rpx; height: 100rpx; font-size: var(--text-xl); border-radius: var(--radius-xl); }
.avatar-xl { width: 128rpx; height: 128rpx; font-size: var(--text-3xl); border-radius: var(--radius-2xl); border-width: 4rpx; }
.avatar-2xl { width: 168rpx; height: 168rpx; font-size: var(--text-5xl); border-radius: var(--radius-2xl); border-width: 6rpx; }

.avatar-primary   { background: linear-gradient(145deg, #028fd7, #0276b3); color: #FFFFFF; }
.avatar-secondary { background: linear-gradient(145deg, #222e40, #1a2434); color: #FFFFFF; }
.avatar-warning   { background: linear-gradient(145deg, #e88006, #c46b05); color: #FFFFFF; }
.avatar-danger    { background: linear-gradient(145deg, #f0204d, #ca193f); color: #FFFFFF; }
.avatar-success   { background: linear-gradient(145deg, #05a473, #04885f); color: #FFFFFF; }
.avatar-info      { background: linear-gradient(145deg, #6c6ff5, #5558da); color: #FFFFFF; }

.avatar-badge {
  position: absolute;
  top: -4rpx;
  right: -4rpx;
  min-width: 30rpx;
  height: 30rpx;
  padding: 0 6rpx;
  background: var(--color-danger);
  color: #FFFFFF;
  font-size: 18rpx;
  font-weight: var(--weight-bold);
  border-radius: var(--radius-pill);
  border: 2rpx solid #FFFFFF;
  display: flex;
  align-items: center;
  justify-content: center;
  line-height: 1;
  box-shadow: 2rpx 2rpx 6rpx var(--neu-dark);
}

.avatar-status {
  position: absolute;
  right: -2rpx;
  bottom: -2rpx;
  width: 20rpx;
  height: 20rpx;
  border-radius: var(--radius-full);
  background: var(--color-success);
  border: 3rpx solid #FFFFFF;
  box-shadow: 1rpx 1rpx 4rpx var(--neu-dark);
}
.avatar-status.offline { background: var(--color-text-muted); }
.avatar-status.busy    { background: var(--color-danger); }

.avatar-group {
  display: inline-flex;
  align-items: center;
  flex-direction: row;
}
.avatar-group .avatar {
  margin-left: -20rpx;
}
.avatar-group .avatar:first-child {
  margin-left: 0;
}

.avatar-upload {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  padding: var(--space-6) 0;
  gap: var(--space-3);
}

.avatar-upload-tip {
  font-size: var(--text-xs);
  color: var(--color-text-muted);
  line-height: 1.4;
}

/* 
** ─────────────────────────────────────────────────────────────────────
**  COMPONENT: TAGS & TAG (软浮雕胶囊标签)
** ───────────────────────────────────────────────────────────────────── 
*/
.tags {
  display: flex;
  flex-wrap: wrap;
  align-items: center;
  gap: var(--space-3);
}

.tag {
  display: inline-flex;
  align-items: center;
  justify-content: center;
  gap: 8rpx;
  height: 52rpx;
  padding: 0 20rpx;
  border-radius: var(--radius-pill);
  font-size: var(--text-xs);
  font-weight: var(--weight-semibold);
  letter-spacing: 0.2rpx;
  line-height: 1;
  box-sizing: border-box;
  white-space: nowrap;
  background: var(--color-bg);
  border: 1rpx solid rgba(255, 255, 255, 0.7);
  box-shadow: -2rpx -2rpx 6rpx var(--neu-light), 2rpx 2rpx 6rpx var(--neu-dark);
  transition: all var(--anim-fast);
}

.tag-primary   { color: var(--color-primary); }
.tag-secondary { color: var(--color-secondary); }
.tag-warning   { color: var(--color-warning); }
.tag-danger    { color: var(--color-danger); }
.tag-success   { color: var(--color-success); }
.tag-info      { color: var(--color-info); }
.tag-surface   { color: var(--color-text-sub); }

/* 实色微浮雕 */
.tag-solid.tag-primary   { background: var(--color-primary); color: #FFFFFF; }
.tag-solid.tag-secondary { background: var(--color-secondary); color: #FFFFFF; }
.tag-solid.tag-warning   { background: var(--color-warning); color: #FFFFFF; }
.tag-solid.tag-danger    { background: var(--color-danger); color: #FFFFFF; }
.tag-solid.tag-success   { background: var(--color-success); color: #FFFFFF; }
.tag-solid.tag-info      { background: var(--color-info); color: #FFFFFF; }

/* 凹陷嵌条标签 (Inset Mode) */
.tag-outline {
  background: var(--color-surface) !important;
  box-shadow: var(--shadow-inset-sm) !important;
  border: none;
}

.tag-pill   { border-radius: var(--radius-pill); }
.tag-square { border-radius: var(--radius-xs); }

.tag-sm { height: 40rpx; padding: 0 14rpx; font-size: var(--text-2xs); }
.tag-md { height: 52rpx; padding: 0 20rpx; font-size: var(--text-xs); }
.tag-lg { height: 60rpx; padding: 0 24rpx; font-size: var(--text-sm); }

.tag-dot {
  width: 12rpx;
  height: 12rpx;
  border-radius: var(--radius-full);
  background: currentColor;
  box-shadow: 1rpx 1rpx 2rpx var(--neu-dark);
}

/* 
** ─────────────────────────────────────────────────────────────────────
**  COMPONENT: FORM (新拟物沉浸凹陷表单体系)
** ───────────────────────────────────────────────────────────────────── 
*/
.field {
  padding: 24rpx 0;
  border-bottom: 1.5rpx solid var(--color-border-subtle);
}
.field-last {
  border-bottom: none;
  padding-bottom: 0;
}

.field-label {
  display: block;
  font-size: var(--text-sm);
  font-weight: var(--weight-bold);
  color: var(--color-text-sub);
  margin-bottom: 16rpx;
  line-height: 1.4;
}

.field-required .field-label::after {
  content: ' *';
  color: var(--color-danger);
  font-size: var(--text-sm);
}

/* ── 单行输入框 (关键：呈现像嵌进塑料板的内凹深色阴影) ── */
.field-input {
  width: 100%;
  height: 88rpx;
  padding: 0 28rpx;
  font-size: var(--text-md);
  color: var(--color-text-main);
  background: var(--color-bg);
  border: none;
  border-radius: var(--radius-md);
  box-shadow: var(--shadow-inset-sm);
  box-sizing: border-box;
  transition: all var(--anim-fast);
}

/* 输入框聚焦时凹陷更深，并泛出主色微光 */
.field-input:focus {
  box-shadow: inset -4rpx -4rpx 8rpx var(--neu-light), inset 4rpx 4rpx 8rpx var(--neu-dark-deep), 0 0 0 2rpx var(--color-primary);
}

.field-input-ro {
  color: var(--color-primary-text);
  background: var(--color-surface);
  box-shadow: var(--shadow-inset-sm);
}

/* ── 组合选择控制器 ── */
.field-control {
  display: flex;
  align-items: center;
  justify-content: space-between;
  width: 100%;
  height: 88rpx;
  padding: 0 28rpx;
  background: var(--color-bg);
  border-radius: var(--radius-md);
  box-shadow: var(--shadow-inset-sm);
  box-sizing: border-box;
}

.field-value { font-size: var(--text-md); color: var(--color-text-main); font-weight: var(--weight-medium); }
.field-placeholder { font-size: var(--text-md); color: var(--color-text-muted); }
.field-arrow { font-size: var(--text-2xs); color: var(--color-text-muted); margin-left: 12rpx; }

/* ── 后缀单位输入 ── */
.field-with-suffix {
  display: flex;
  align-items: stretch;
  width: 100%;
  background: var(--color-bg);
  border-radius: var(--radius-md);
  box-shadow: var(--shadow-inset-sm);
  overflow: hidden;
}
.field-input-suffix {
  flex: 1;
  box-shadow: none;
  background: transparent;
}
.field-suffix {
  display: flex;
  align-items: center;
  padding: 0 24rpx;
  font-size: var(--text-sm);
  color: var(--color-text-muted);
  background: var(--color-surface);
  border-left: 1.5rpx solid rgba(163, 177, 198, 0.2);
  white-space: nowrap;
}

/* ── 文本域 ── */
.field-textarea {
  width: 100%;
  min-height: 160rpx;
  padding: 22rpx 28rpx;
  font-size: var(--text-md);
  color: var(--color-text-main);
  background: var(--color-bg);
  border-radius: var(--radius-md);
  box-shadow: var(--shadow-inset-sm);
  box-sizing: border-box;
  line-height: 1.6;
}
.field-textarea:focus {
  box-shadow: inset -4rpx -4rpx 8rpx var(--neu-light), inset 4rpx 4rpx 8rpx var(--neu-dark-deep), 0 0 0 2rpx var(--color-primary);
}

/* ── 胶囊选择器 (Chips) ── */
.field-chips {
  display: flex;
  flex-wrap: wrap;
  gap: var(--space-4);
  padding: var(--space-2) 0;
}

.field-chip {
  display: inline-flex;
  align-items: center;
  justify-content: center;
  min-width: 120rpx;
  height: 72rpx;
  padding: 0 32rpx;
  background: var(--color-bg);
  color: var(--color-text-sub);
  font-size: var(--text-md);
  font-weight: var(--weight-medium);
  border-radius: var(--radius-pill);
  box-shadow: var(--shadow-sm);
  box-sizing: border-box;
  white-space: nowrap;
  transition: all var(--anim-fast);
}

.field-chip:active {
  box-shadow: var(--shadow-inset-sm);
}

/* 选中态：立刻从浮起变为凹陷，内嵌主色 */
.field-chip.active,
.field-chip-active {
  background: var(--color-surface);
  color: var(--color-primary);
  font-weight: var(--weight-bold);
  box-shadow: var(--shadow-inset-md);
}

.field-chip.disabled,
.field-chip-disabled {
  opacity: 0.4;
  box-shadow: none;
  background: var(--color-surface);
}

/* ── 可增删动态标签 (Tags Input) ── */
.field-tags {
  display: flex;
  flex-wrap: wrap;
  align-items: center;
  gap: var(--space-3);
  padding: var(--space-2) 0;
}

.field-tag {
  display: inline-flex;
  align-items: center;
  height: 64rpx;
  padding: 0 24rpx;
  background: var(--color-bg);
  border-radius: var(--radius-pill);
  box-shadow: var(--shadow-sm);
  box-sizing: border-box;
  white-space: nowrap;
}

.field-tag-text {
  font-size: var(--text-md);
  color: var(--color-success-text);
  font-weight: var(--weight-medium);
  line-height: 1;
}

.field-tag-close {
  display: inline-flex;
  align-items: center;
  justify-content: center;
  width: 32rpx;
  height: 32rpx;
  margin-left: 12rpx;
  border-radius: var(--radius-full);
  font-size: var(--text-xs);
  color: var(--color-text-muted);
  box-shadow: var(--shadow-sm);
}

.field-tag-close:active {
  box-shadow: var(--shadow-inset-sm);
  color: var(--color-danger);
}

.field-tag-add {
  display: inline-flex;
  align-items: center;
  justify-content: center;
  gap: 6rpx;
  height: 64rpx;
  padding: 0 28rpx;
  background: var(--color-bg);
  color: var(--color-text-sub);
  font-size: var(--text-md);
  font-weight: var(--weight-medium);
  border-radius: var(--radius-pill);
  box-shadow: var(--shadow-sm);
  border: 1.5rpx dashed rgba(163, 177, 198, 0.6);
  box-sizing: border-box;
  transition: all var(--anim-fast);
}

.field-tag-add:active {
  box-shadow: var(--shadow-inset-sm);
  border-color: var(--color-primary);
  color: var(--color-primary);
}

/* ── 上传网格 ── */
.field-uploader {
  display: flex;
  flex-wrap: wrap;
  gap: var(--space-4);
  padding: var(--space-2) 0;
}

.field-uploader-item {
  position: relative;
  width: 148rpx;
  height: 148rpx;
  border-radius: var(--radius-xl);
  overflow: hidden;
  background: var(--color-bg);
  box-shadow: var(--shadow-sm);
  box-sizing: border-box;
  padding: 6rpx; /* 外层拟物白台包边 */
}

.field-uploader-img {
  width: 100%;
  height: 100%;
  border-radius: var(--radius-lg);
  object-fit: cover;
  display: block;
}

.field-uploader-del {
  position: absolute;
  top: 10rpx;
  right: 10rpx;
  width: 44rpx;
  height: 44rpx;
  background: rgba(15, 23, 42, 0.65);
  backdrop-filter: blur(8rpx);
  border-radius: var(--radius-full);
  display: flex;
  align-items: center;
  justify-content: center;
  color: #FFFFFF;
  font-size: 24rpx;
  line-height: 1;
  box-shadow: 2rpx 2rpx 6rpx rgba(0,0,0,0.25);
  z-index: 2;
}

.field-uploader-del:active {
  background: var(--color-danger);
}

.field-uploader-add {
  display: flex;
  align-items: center;
  justify-content: center;
  background: var(--color-bg);
  border-radius: var(--radius-xl);
  box-shadow: var(--shadow-sm);
  transition: all var(--anim-fast);
}

.field-uploader-add:active {
  box-shadow: var(--shadow-inset-sm);
}

.field-uploader-plus {
  font-size: 60rpx;
  font-weight: var(--weight-light);
  color: var(--color-text-muted);
  line-height: 1;
}

.field-uploader-add:active .field-uploader-plus {
  color: var(--color-primary);
}

/* ── 文件列表 ── */
.field-files {
  display: flex;
  flex-direction: column;
  gap: var(--space-3);
  padding: var(--space-2) 0;
}

.field-file-add {
  display: inline-flex;
  align-items: center;
  gap: 10rpx;
  align-self: flex-start;
  padding: 16rpx 32rpx;
  font-size: var(--text-md);
  font-weight: var(--weight-semibold);
  color: var(--color-success-text);
  background: var(--color-bg);
  border-radius: var(--radius-pill);
  box-shadow: var(--shadow-sm);
  transition: all var(--anim-fast);
}

.field-file-add:active {
  box-shadow: var(--shadow-inset-sm);
}

.field-file-item {
  display: flex;
  align-items: center;
  gap: var(--space-3);
  padding: 20rpx 24rpx;
  background: var(--color-bg);
  border-radius: var(--radius-lg);
  box-shadow: var(--shadow-sm);
  box-sizing: border-box;
}

.field-file-icon {
  font-size: var(--text-xl);
  line-height: 1;
}

.field-file-name {
  flex: 1;
  min-width: 0;
  font-size: var(--text-sm);
  font-weight: var(--weight-medium);
  color: var(--color-text-main);
  overflow: hidden;
  text-overflow: ellipsis;
  white-space: nowrap;
}

.field-file-del {
  display: flex;
  align-items: center;
  justify-content: center;
  width: 40rpx;
  height: 40rpx;
  border-radius: var(--radius-full);
  font-size: var(--text-xs);
  color: var(--color-text-muted);
  background: var(--color-bg);
  box-shadow: var(--shadow-sm);
}

.field-file-del:active {
  box-shadow: var(--shadow-inset-sm);
  color: var(--color-danger);
}

/* 
** ─────────────────────────────────────────────────────────────────────
**  COMPONENT: LOAD MORE (拟物旋转指示器与触底)
** ───────────────────────────────────────────────────────────────────── 
*/
.load-more {
  display: flex;
  align-items: center;
  justify-content: center;
  gap: var(--space-4);
  width: 100%;
  min-height: 96rpx;
  padding: var(--space-6) 0;
  box-sizing: border-box;
}

.load-spinner {
  width: 36rpx;
  height: 36rpx;
  border-radius: var(--radius-full);
  border: 4rpx solid var(--color-bg);
  border-top-color: var(--color-primary);
  box-shadow: var(--shadow-sm);
  animation: load-spin 0.8s linear infinite;
  box-sizing: border-box;
  flex-shrink: 0;
}

@keyframes load-spin {
  0%   { transform: rotate(0deg); }
  100% { transform: rotate(360deg); }
}

.load-text {
  font-size: var(--text-sm);
  color: var(--color-text-muted);
  font-weight: var(--weight-medium);
  letter-spacing: 0.5rpx;
}

.load-finished,
.load-end {
  position: relative;
  display: flex;
  align-items: center;
  justify-content: center;
  width: 100%;
  padding: var(--space-6) var(--space-8);
  box-sizing: border-box;
}

.load-finished::before,
.load-finished::after,
.load-end::before,
.load-end::after {
  content: '';
  flex: 1;
  height: 2rpx;
  background: linear-gradient(90deg, transparent, rgba(163, 177, 198, 0.4), transparent);
}

.load-finished .load-text,
.load-end .load-text {
  padding: 0 var(--space-4);
  font-size: var(--text-xs);
  color: var(--color-text-muted);
}

.load-error {
  cursor: pointer;
}
.load-error .load-text {
  color: var(--color-primary);
}
.load-error:active {
  opacity: 0.7;
}

/* 
** ─────────────────────────────────────────────────────────────────────
**  COMPONENT: BTN-GRID (浮雕凸起九宫格矩阵)
** ───────────────────────────────────────────────────────────────────── 
*/
.btn-grid {
  display: grid;
  grid-template-columns: repeat(3, 1fr);
  gap: var(--space-4);
  width: 100%;
  padding: var(--space-4);
  background: var(--color-bg);
  box-sizing: border-box;
}

.btn-grid-col4 {
  grid-template-columns: repeat(4, 1fr);
}

.btn-grid-item {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  min-height: 200rpx;
  padding: var(--space-4);
  background: var(--color-bg);
  border-radius: var(--radius-xl);
  box-shadow: var(--shadow-md);
  border: 1.5rpx solid rgba(255, 255, 255, 0.6);
  box-sizing: border-box;
  transition: all var(--anim-fast);
}

.btn-grid-item:active {
  box-shadow: var(--shadow-inset-sm);
  transform: translateY(2rpx);
}

.btn-grid-label {
  font-size: var(--text-md);
  font-weight: var(--weight-semibold);
  color: var(--color-text-main);
  text-align: center;
  line-height: 1.4;
  white-space: nowrap;
}

.btn-grid-icon {
  font-size: 52rpx;
  line-height: 1;
  margin-bottom: var(--space-3);
  color: var(--color-primary);
}

/* 
** ─────────────────────────────────────────────────────────────────────
**  COMPONENT: LIST VIEW (纯正新拟物双向立体列表系统)
** ───────────────────────────────────────────────────────────────────── 
*/

/* ── 列表大面板：从背景平滑挤出的软塑微凸台 ── */
.list-view {
  background: var(--color-bg);
  border-radius: var(--radius-xl);
  box-shadow: var(--shadow-md);
  border: 1.5rpx solid rgba(255, 255, 255, 0.8); /* 顶部微反光环境高光 */
  box-sizing: border-box;
  margin: 0 var(--space-6) var(--space-6);
  padding: var(--space-2) 0;                     /* 预留边缘间距使按压态内阴影呼吸更顺畅 */
  overflow: hidden;
}

.list-view-flush {
  margin: 0;
  border-radius: 0;
  box-shadow: none;
  border: none;
  padding: 0;
}

/* ── 分组标题：带极浅高光微浮雕刻印感 ── */
.list-header {
  padding: 24rpx 36rpx 14rpx;
  font-size: var(--text-xs);
  font-weight: var(--weight-bold);
  color: var(--color-text-muted);
  text-transform: uppercase;
  letter-spacing: 1.5rpx;
  text-shadow: 1rpx 1rpx 0 var(--neu-light); /* 软拟态浮雕字印 */
}

/* ── 列表条目：与外壳一体化成型 ── */
.list-item {
  position: relative;
  align-items: center;
  justify-content: space-between;
  min-height: 114rpx;
  padding: 24rpx 32rpx;
  background: var(--color-bg);
  box-sizing: border-box;
  transition: all var(--anim-fast);
}

/* ── 核心拟物技法：材质双向挤压凹槽替代传统 Border ── */
.list-item + .list-item {
  /* 上暗下亮：模拟面板表面向内凹陷的微型物理刻槽 */
  box-shadow: 0 -1.5rpx 0 var(--color-border-subtle),
              0 1.5rpx 0 var(--neu-light);
}

/* ── 按压触感：手指按压时向内沉降，触发凹坑物理反馈 ── */
.list-item:active {
  background: var(--color-surface);
  box-shadow: var(--shadow-inset-sm);
  transform: scale(0.995); /* 轻微形变受压感 */
}

/* ── 前缀装饰区：冲压微凸起圆形软键 ── */
.list-prefix {
  display: flex;
  align-items: center;
  justify-content: center;
  width: 68rpx;
  height: 68rpx;
  border-radius: var(--radius-full);
  background: var(--color-bg);
  box-shadow: -2rpx -2rpx 6rpx var(--neu-light), 2rpx 2rpx 6rpx var(--neu-dark);
  margin-right: var(--space-4);
  flex-shrink: 0;
  transition: all var(--anim-fast);
}

/* 条目被按压时，前缀图标连带产生沉入效果 */
.list-item:active .list-prefix {
  box-shadow: var(--shadow-inset-sm);
  background: var(--color-surface);
}

.list-icon {
  font-size: var(--text-xl);
  color: var(--color-primary);
  line-height: 1;
}

/* ── 文本布局核心 ── */
.list-content {
  flex: 1;
  min-width: 0;
  display: flex;
  flex-direction: column;
  justify-content: center;
}

.list-title {
  font-size: var(--text-md);
  font-weight: var(--weight-semibold);
  color: var(--color-text-main);
  line-height: 1.4;
  overflow: hidden;
  text-overflow: ellipsis;
  white-space: nowrap;
}

.list-desc {
  font-size: var(--text-xs);
  color: var(--color-text-muted);
  line-height: 1.4;
  margin-top: 4rpx;
  overflow: hidden;
  text-overflow: ellipsis;
  white-space: nowrap;
}

/* ── 后缀交互状态 ── */
.list-suffix {
  display: flex;
  align-items: center;
  gap: var(--space-2);
  margin-left: var(--space-4);
  flex-shrink: 0;
}

.list-extra {
  font-size: var(--text-sm);
  color: var(--color-text-muted);
  font-weight: var(--weight-medium);
  line-height: 1;
}

.list-arrow {
  margin-left: var(--space-1);
  font-size: 28rpx;
  color: var(--color-text-muted);
  line-height: 1;
  font-weight: var(--weight-light);
  text-shadow: 1rpx 1rpx 0 var(--neu-light); /* 箭头附带微凹光晕 */
  transition: transform var(--anim-fast);
}

.list-item:active .list-arrow {
  transform: translateX(4rpx); /* 点击微推移触感 */
}

/* 
** ─────────────────────────────────────────────────────────────────────
**  COMPONENT: EMPTY STATE (新拟物沉浸空状态)
** ───────────────────────────────────────────────────────────────────── 
*/
.empty-state {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  padding: 80rpx var(--space-8);
  box-sizing: border-box;
  text-align: center;
}

/* 拟物圆形凸台 */
.empty-icon {
  display: flex;
  align-items: center;
  justify-content: center;
  width: 160rpx;
  height: 160rpx;
  margin-bottom: var(--space-6);
  border-radius: var(--radius-full);
  background: var(--color-bg);
  color: var(--color-text-muted);
  font-size: 72rpx;
  line-height: 1;
  box-shadow: var(--shadow-md);
  border: 2rpx solid rgba(255, 255, 255, 0.7);
}

.empty-img {
  width: 240rpx;
  height: 240rpx;
  margin-bottom: var(--space-6);
  object-fit: contain;
}

.empty-title {
  font-size: var(--text-lg);
  font-weight: var(--weight-bold);
  color: var(--color-text-main);
  line-height: 1.35;
}

.empty-desc {
  max-width: 480rpx;
  margin-top: var(--space-2);
  font-size: var(--text-sm);
  color: var(--color-text-muted);
  line-height: 1.6;
}

.empty-action {
  margin-top: var(--space-8);
  display: flex;
  align-items: center;
  justify-content: center;
  gap: var(--space-3);
}

.empty-sm {
  padding: 40rpx var(--space-4);
}
.empty-sm .empty-icon {
  width: 100rpx;
  height: 100rpx;
  font-size: 48rpx;
  margin-bottom: var(--space-3);
}
.empty-sm .empty-title { font-size: var(--text-md); }
.empty-sm .empty-desc  { font-size: var(--text-xs); margin-top: 4rpx; }
.empty-sm .empty-action{ margin-top: var(--space-4); }

<#include "/$/tile.css.ftl">

/* 
** ─────────────────────────────────────────────────────────────────────
**  COMPONENT: TILE (新拟物仪表盘磁贴 / 状态块系统)
** ───────────────────────────────────────────────────────────────────── 
*/

/* ── 基础标准磁贴 (从底板浮出的微凸塑胶触控台) ── */
.tile {
  position: relative;
  display: flex;
  flex-direction: column;
  justify-content: space-between;
  padding: var(--space-6);
  background: var(--color-bg);
  border-radius: var(--radius-xl);
  border: 1.5rpx solid rgba(255, 255, 255, 0.8); /* 顶部微反光环境线 */
  box-shadow: var(--shadow-md);
  box-sizing: border-box;
  overflow: hidden;
  transition: all var(--anim-base);
}

/* ── 交互按压态：受压凹陷质感 (Sunken State) ── */
.tile-interactive:active,
.tile:active {
  box-shadow: var(--shadow-inset-sm);
  background: var(--color-surface);
  transform: scale(0.985); /* 橡皮泥/软塑料整体受挤压微缩 */
}

/* ── 磁贴头部：常驻小图标与右上角角标/微开关 ── */
.tile-header {
  display: flex;
  align-items: center;
  justify-content: space-between;
  width: 100%;
  margin-bottom: var(--space-4);
}

/* 磁贴内部小图标台座：独立浮起的圆形小微台 */
.tile-icon-box {
  display: flex;
  align-items: center;
  justify-content: center;
  width: 76rpx;
  height: 76rpx;
  border-radius: var(--radius-lg);
  background: var(--color-bg);
  box-shadow: var(--shadow-sm);
  border: 1rpx solid rgba(255, 255, 255, 0.9);
  color: var(--color-primary);
  font-size: var(--text-2xl);
  transition: all var(--anim-fast);
  flex-shrink: 0;
}

/* 点击 Tile 时，内部图标基座同步凹陷陷落 */
.tile:active .tile-icon-box {
  box-shadow: var(--shadow-inset-sm);
  transform: scale(0.92);
}

/* ── 磁贴内容排版 ── */
.tile-body {
  display: flex;
  flex-direction: column;
  flex: 1;
  justify-content: flex-end;
}

.tile-title {
  font-size: var(--text-body);
  font-weight: var(--weight-bold);
  color: var(--color-text-main);
  line-height: 1.3;
  letter-spacing: -0.2rpx;
}

.tile-desc {
  font-size: var(--text-xs);
  color: var(--color-text-muted);
  line-height: 1.4;
  margin-top: var(--space-1);
}

/* 核心数值展示 (如温度、步数、用量等统计) */
.tile-value {
  font-size: var(--text-5xl);
  font-weight: var(--weight-extrabold);
  color: var(--color-text-main);
  line-height: 1.1;
  margin-bottom: var(--space-2);
  letter-spacing: -1rpx;
  text-shadow: 1rpx 1rpx 0 var(--neu-light); /* 数字微立体反光 */
}

.tile-value-unit {
  font-size: var(--text-sm);
  font-weight: var(--weight-medium);
  color: var(--color-text-muted);
  margin-left: var(--space-1);
}

/* 
** ── 特殊拟态变体 ──
*/

/* 1. 深度凹陷槽磁贴 (Inset Tile / 槽位式展示) */
.tile-sunken {
  background: var(--color-surface);
  box-shadow: var(--shadow-inset-md);
  border: 1.5rpx solid rgba(163, 177, 198, 0.2);
}

.tile-sunken:active {
  box-shadow: var(--shadow-inset-sm); /* 反弹触感 */
}

/* 2. 激活态磁贴 (Active/Selected - 带内部主色微光浸染) */
.tile.active,
.tile-active {
  background: var(--color-surface);
  box-shadow: var(--shadow-inset-md), 0 0 0 2rpx var(--color-primary);
}

.tile.active .tile-title,
.tile-active .tile-title {
  color: var(--color-primary);
}

.tile.active .tile-icon-box,
.tile-active .tile-icon-box {
  background: var(--color-primary);
  color: #FFFFFF;
  box-shadow: 0 4rpx 12rpx rgba(2, 132, 199, 0.4);
}

/* 3. 语义色微光环绕变体 */
.tile-primary .tile-icon-box   { color: var(--color-primary); }
.tile-success .tile-icon-box   { color: var(--color-success); }
.tile-warning .tile-icon-box   { color: var(--color-warning); }
.tile-danger .tile-icon-box    { color: var(--color-danger); }

/* ── 规格阶梯 ── */
.tile-sm {
  min-height: 140rpx;
  padding: var(--space-4);
}
.tile-sm .tile-icon-box {
  width: 60rpx;
  height: 60rpx;
  font-size: var(--text-lg);
}
.tile-sm .tile-title {
  font-size: var(--text-md);
}

.tile-lg {
  min-height: 240rpx;
  padding: var(--space-8);
}