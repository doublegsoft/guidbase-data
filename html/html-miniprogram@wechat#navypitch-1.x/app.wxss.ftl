/*
** ═══════════════════════════════════════════════════════════════════════
**  DESIGN SYSTEM: NAVY PITCH (深蓝绿茵 / 绿茵先锋)
**  Architecture: Foundations — CSS Custom Properties / Design Tokens
**  Platform: WeChat Mini Program (100% Native RPX)
** ═══════════════════════════════════════════════════════════════════════
*/

page {
  /* ── 1. 语义色彩系统 (Semantic Color Tokens) ── */

  /* Primary: 活力薄荷青 (原 --color-teal) */
  --color-primary:         #00C9A7;
  --color-primary-light:   #34D399;
  --color-primary-hover:   #00B599;
  --color-primary-dim:     rgba(0, 201, 167, 0.12);
  --color-primary-text:    #00A085;

  /* Secondary: 深邃海军蓝 (原 --color-navy / steel) */
  --color-secondary:       #0D1B2A;
  --color-secondary-light: #1D3448;
  --color-secondary-hover: #152636;
  --color-secondary-dim:   rgba(13, 27, 42, 0.08);
  --color-secondary-text:  #1B4F72;

  /* Warning: 阳光琥珀橙 (原 --color-amber) */
  --color-warning:         #F5A623;
  --color-warning-light:   #FBBF24;
  --color-warning-hover:   #E8981A;
  --color-warning-dim:     rgba(245, 166, 35, 0.12);
  --color-warning-text:    #C8830A;

  /* Danger: 警示珊瑚红 (原 --color-red) */
  --color-danger:          #E74C6F;
  --color-danger-light:    #F87171;
  --color-danger-hover:    #C0294F;
  --color-danger-dim:      rgba(231, 76, 111, 0.12);
  --color-danger-text:     #C0294F;

  /* Success: 森林活力绿 (原 --color-green) */
  --color-success:         #27AE60;
  --color-success-light:   #4ADE80;
  --color-success-hover:   #219A52;
  --color-success-dim:     rgba(39, 174, 96, 0.12);
  --color-success-text:    #1E8449;

  /* Info: 智慧信息蓝/紫 (原 --color-blue / purple) */
  --color-info:            #3B8BEB;
  --color-info-light:      #60A5FA;
  --color-info-hover:      #2A6DC7;
  --color-info-dim:        rgba(59, 139, 235, 0.12);
  --color-info-text:       #2A6DC7;

  /* ── 2. 纸张表面与边框排版 ── */
  --color-bg:              #F5F7FA; /* 护眼晨光冷灰底色 */
  --color-card:            #FFFFFF; /* 纯白卡片容器 */
  --color-surface:         #F0F4F8; /* 浅灰次级表面 */
  --color-surface-hover:   #E4EBF2;
  --color-surface-active:  #D5DFEA;

  --color-text-main:       #1A2B3C; /* 一级深板岩主文字 */
  --color-text-sub:        #5A7080; /* 二级次要正文 */
  --color-text-muted:      #95AABA; /* 三级占位与停用文字 */
  --color-border:          #E2EAF0; /* 一级硬结构分割线 */
  --color-border-subtle:   #EDF3F7; /* 二级弱边框线 */

  /* TabBar 选项卡适配映射 */
  --color-tab-text:        var(--color-text-muted);
  --color-tab-text-active: var(--color-primary);

  /* ── 3. 字体大小标尺 (Type Scale in rpx) ── */
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

  /* ── 4. 字重阶梯 ── */
  --weight-light:     300;
  --weight-normal:    400;
  --weight-medium:    500;
  --weight-semibold:  600;
  --weight-bold:      700;
  --weight-extrabold: 800;

  /* ── 5. 间距体系 (标准 8-Point 网格) ── */
  --space-1:   4rpx;
  --space-2:   8rpx;
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

  /* ── 6. 弹性圆角系统 ── */
  --radius-xs:    6rpx;
  --radius-sm:   10rpx;
  --radius-md:   16rpx;
  --radius-lg:   20rpx;
  --radius-xl:   28rpx;
  --radius-2xl:  36rpx;
  --radius-pill: 9999rpx;
  --radius-full: 50%;

  /* ── 7. 双层高透光物理阴影 ── */
  --shadow-sm:   0 4rpx 16rpx rgba(13, 27, 42, 0.05);
  --shadow-md:   0 8rpx 32rpx rgba(13, 27, 42, 0.08), 0 2rpx 8rpx rgba(13, 27, 42, 0.03);
  --shadow-lg:   0 16rpx 48rpx rgba(13, 27, 42, 0.12);

  /* ── 8. 动效转场速度 ── */
  --anim-fast:   0.12s cubic-bezier(0.4, 0, 0.2, 1);
  --anim-base:   0.2s cubic-bezier(0.4, 0, 0.2, 1);
  --anim-smooth: 0.28s cubic-bezier(0.4, 0, 0.2, 1);
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
  z-index: 9999;
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: 16rpx var(--space-6);
  background: rgba(255, 255, 255, 0.96);
  backdrop-filter: blur(20rpx);
  -webkit-backdrop-filter: blur(20rpx);
  border-bottom: 1.5rpx solid var(--color-border);
  box-sizing: border-box;
}

/* ── 顶部防遮挡占位槽 (放在页面滚动区最上方，高度与 toolbar 保持一致) ── */
.page-toolbar-placeholder {
  width: 100%;
  height: 96rpx;
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
  padding: 20rpx var(--space-6);
  background: rgba(255, 255, 255, 0.96);
  backdrop-filter: blur(20rpx);
  -webkit-backdrop-filter: blur(20rpx);
  border-top: 1.5rpx solid var(--color-border);
  box-sizing: border-box;
  /* 自动适配全面屏安全区 */
  padding-bottom: calc(20rpx + constant(safe-area-inset-bottom));
  padding-bottom: calc(20rpx + env(safe-area-inset-bottom));
}

/* 按钮在 footer 内默认撑满弹性扩展 */
.page-footer .btn {
  flex: 1;
}

/* ── 辅助占位块 (防止页面主体内容被底部固定栏遮挡) ── */
.page-footer-placeholder {
  width: 100%;
  height: 120rpx;
  padding-bottom: constant(safe-area-inset-bottom);
  padding-bottom: env(safe-area-inset-bottom);
  box-sizing: content-box;
}

.page-footer-offset {
  padding-bottom: 160rpx;
}

.page-toolbar-offset {
  position:relative;
  top: 122rpx;
}

/* 底部安全区适配 */
.safe-area-bottom {
  padding-bottom: constant(safe-area-inset-bottom);
  padding-bottom: env(safe-area-inset-bottom);
}

/*
** ─────────────────────────────────────────────────────────────────────
**  LAYOUT & UTILITIES (盒模型、排版与原子工具类)
** ─────────────────────────────────────────────────────────────────────
*/

/* ── Flex 布局 ── */
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

/* ── Grid 网格 ── */
.grid-2 { display: grid; grid-template-columns: repeat(2, 1fr); gap: var(--space-4); }
.grid-3 { display: grid; grid-template-columns: repeat(3, 1fr); gap: var(--space-3); }
.grid-4 { display: grid; grid-template-columns: repeat(4, 1fr); gap: var(--space-2); }

/* ── 间隔 (Gaps) ── */
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

/* ── 内边距 (Padding) ── */
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

/* ── 外边距 (Margin) ── */
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

/* ── 尺寸与对齐 ── */
.ml-auto { margin-left: auto; }
.mr-auto { margin-right: auto; }
.w-full  { width: 100%; box-sizing: border-box; }
.h-full  { height: 100%; }

/* ── 排版工具类 ── */
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

/* ── 字体颜色 ── */
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
**  COMPONENT: BUTTON (按键组件体系)
** ─────────────────────────────────────────────────────────────────────
*/

/* ── Buttons ──────────────────────────── */
.btn {
  display: inline-flex;
  align-items: center;
  justify-content: center;
  gap: var(--space-4);
  padding: var(--space-5) var(--space-10);
  border-radius: var(--radius-md);
  font-size: var(--text-md);
  font-weight: var(--weight-semibold);
  border: none;
  transition: all var(--transition-base);
  white-space: nowrap;
  line-height: 1.4;
}
.btn::after { border: none; }

/* ── 语义变体 ── */
.btn-primary {
  background: linear-gradient(180deg, var(--color-primary-light) 0%, var(--color-primary) 100%);
  color: #FFFFFF;
  box-shadow: 0 4rpx 14rpx rgba(2, 132, 199, 0.28);
}
.btn-primary:active { transform: scale(0.985); opacity: 0.92; }

.btn-default {
  background: var(--color-card);
  color: var(--color-text-sub);
  border: 1.5rpx solid var(--color-border);
  box-shadow: 0 2rpx 4rpx rgba(15, 23, 42, 0.02);
}
.btn-default:active { background: var(--color-surface); border-color: var(--color-secondary-hover); }

.btn-secondary {
  background: var(--color-secondary);
  color: #FFFFFF;
}
.btn-secondary:active { background: var(--color-secondary-light); transform: scale(0.985); }

.btn-warning {
  background: linear-gradient(180deg, var(--color-warning-light) 0%, var(--color-warning) 100%);
  color: #FFFFFF;
  box-shadow: 0 4rpx 14rpx rgba(217, 119, 6, 0.25);
}
.btn-warning:active { transform: scale(0.985); }

.btn-danger {
  background: var(--color-danger-dim);
  color: var(--color-danger-text);
  border: 1.5rpx solid rgba(225, 29, 72, 0.2);
}
.btn-danger:active { background: var(--color-danger); color: #FFFFFF; }

.btn-success {
  background: var(--color-success);
  color: #FFFFFF;
  box-shadow: 0 4rpx 12rpx rgba(5, 150, 105, 0.25);
}
.btn-success:active { transform: scale(0.985); }

.btn-info {
  background: var(--color-info-dim);
  color: var(--color-info-text);
  border: 1.5rpx solid rgba(99, 102, 241, 0.2);
}
.btn-info:active { background: var(--color-info); color: #FFFFFF; }

.btn-outline {
  background: transparent;
  color: var(--color-primary);
  border: 2rpx solid var(--color-primary);
}
.btn-outline:active { background: var(--color-primary-dim); }

.btn-sm  { padding: 10rpx 22rpx; font-size: var(--text-xs); border-radius: var(--radius-sm); }
.btn-lg  { padding: 26rpx 48rpx; font-size: var(--text-lg); border-radius: var(--radius-lg); }
.btn-block { width: 100%; display: flex; }

.btn-actions { display: flex; gap: var(--space-4); padding: var(--space-4) 0; }
.btn-action {
  flex: 1;
  padding: 20rpx;
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: var(--text-md);
  font-weight: var(--weight-semibold);
  border-radius: var(--radius-md);
  box-sizing: border-box;
}

/*
** ─────────────────────────────────────────────────────────────────────
**  COMPONENT: CARD (卡片容器系统)
** ─────────────────────────────────────────────────────────────────────
*/

/* ── 基础标准卡片 (Base Card) ── */
.card {
  margin: 0 var(--space-6) var(--space-6);
  background: var(--color-card);
  border-radius: var(--radius-xl);
  border: 1.5rpx solid var(--color-border);
  box-shadow: var(--shadow-sm);
  overflow: hidden;
  transition: transform var(--anim-fast), box-shadow var(--anim-fast);
}

/* 交互卡片按压态 */
.card-interactive:active {
  transform: scale(0.995);
  box-shadow: var(--shadow-md);
  border-color: var(--color-border-subtle);
}

/* 卡片头部插槽 */
.card-header {
  padding: 24rpx 28rpx;
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

/* 卡片主体内容 */
.card-body {
  padding: 24rpx 28rpx;
}

/* 贴边内容模式 (去内边距，用于嵌列表/横滑栏) */
.card-body-flush {
  padding: 0;
}

/* ── 卡片底部操作栏 (Card Footer) ── */
.card-footer {
  padding: 20rpx 28rpx;
  display: flex;
  align-items: center;
  justify-content: flex-end;
  gap: var(--space-3);
  border-top: 1.5rpx solid var(--color-border-subtle);
  background: var(--color-card);
  box-sizing: border-box;
}

/* 底部通栏两端对齐 (左侧辅助信息/时间，右侧操作按钮) */
.card-footer-between {
  justify-content: space-between;
}

/* 底部灰色微衬底模式 (常用于区分主次操作) */
.card-footer-subtle {
  background: var(--color-surface);
}

/* 底部辅助说明文字 */
.card-footer-text {
  font-size: var(--text-xs);
  color: var(--color-text-muted);
  line-height: 1.4;
}

/*
** ─────────────────────────────────────────────────────────────────────
**  COMPONENT: AVATAR (头像与用户标识系统)
** ─────────────────────────────────────────────────────────────────────
*/

/* ── 头像基类 (默认中号 md: 72rpx，微圆角矩形形态) ── */
.avatar {
  position: relative;
  display: inline-flex;
  align-items: center;
  justify-content: center;
  width: 72rpx;
  height: 72rpx;
  border-radius: var(--radius-md);
  font-size: var(--text-base);
  font-weight: var(--weight-bold);
  color: #FFFFFF;
  background: var(--color-surface);
  border: 2rpx solid #FFFFFF;
  box-shadow: var(--shadow-sm);
  box-sizing: border-box;
  flex-shrink: 0;
  overflow: visible; /* 保证角标不被裁剪 */
}

/* 内部图片铺满 */
.avatar-img {
  width: 100%;
  height: 100%;
  border-radius: inherit;
  object-fit: cover;
  display: block;
}

/* 纯文字首字母/姓名缩写 */
.avatar-text {
  font-size: inherit;
  font-weight: inherit;
  color: inherit;
  line-height: 1;
}

/* ── 形态变体 (Shape Variants) ── */
/* 经典圆形头像 */
.avatar-round,
.avatar-circle {
  border-radius: var(--radius-full);
}

/* 直角微倒角 */
.avatar-square {
  border-radius: var(--radius-sm);
}

/* ── 尺寸阶梯 (Size Variants) ── */
.avatar-xs {
  width: 44rpx;
  height: 44rpx;
  font-size: var(--text-2xs);
  border-radius: var(--radius-xs);
}
.avatar-xs.avatar-round { border-radius: var(--radius-full); }

.avatar-sm {
  width: 56rpx;
  height: 56rpx;
  font-size: var(--text-xs);
  border-radius: var(--radius-sm);
}
.avatar-sm.avatar-round { border-radius: var(--radius-full); }

.avatar-md {
  width: 72rpx;
  height: 72rpx;
  font-size: var(--text-base);
}

.avatar-lg {
  width: 96rpx;
  height: 96rpx;
  font-size: var(--text-xl);
  border-radius: var(--radius-lg);
}
.avatar-lg.avatar-round { border-radius: var(--radius-full); }

.avatar-xl {
  width: 120rpx;
  height: 120rpx;
  font-size: var(--text-3xl);
  border-radius: var(--radius-xl);
  border-width: 4rpx;
}
.avatar-xl.avatar-round { border-radius: var(--radius-full); }

.avatar-2xl {
  width: 160rpx;
  height: 160rpx;
  font-size: var(--text-5xl);
  border-radius: var(--radius-2xl);
  border-width: 6rpx;
}
.avatar-2xl.avatar-round { border-radius: var(--radius-full); }

/* ── 语义渐变底色 (用于无头像时展示文字) ── */
.avatar-primary   { background: linear-gradient(135deg, var(--color-primary-light), var(--color-primary)); }
.avatar-secondary { background: linear-gradient(135deg, var(--color-secondary-light), var(--color-secondary)); }
.avatar-warning   { background: linear-gradient(135deg, var(--color-warning-light), var(--color-warning)); }
.avatar-danger    { background: linear-gradient(135deg, var(--color-danger-light), var(--color-danger)); }
.avatar-success   { background: linear-gradient(135deg, var(--color-success-light), var(--color-success)); }
.avatar-info      { background: linear-gradient(135deg, var(--color-info-light), var(--color-info)); }

/* ── 头像角标与状态点 (Badge & Status Dot) ── */
.avatar-badge {
  position: absolute;
  top: -4rpx;
  right: -4rpx;
  min-width: 28rpx;
  height: 28rpx;
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
  box-sizing: border-box;
}

/* 右下角在线状态点 */
.avatar-status {
  position: absolute;
  right: -2rpx;
  bottom: -2rpx;
  width: 18rpx;
  height: 18rpx;
  border-radius: var(--radius-full);
  background: var(--color-success);
  border: 3rpx solid #FFFFFF;
}
.avatar-status.offline { background: var(--color-text-muted); }
.avatar-status.busy    { background: var(--color-danger); }

/* ── 多人头像重叠组 (Avatar Group) ── */
.avatar-group {
  display: inline-flex;
  align-items: center;
  flex-direction: row;
}

.avatar-group .avatar {
  margin-left: -18rpx;
  border: 3rpx solid #FFFFFF;
  box-shadow: var(--shadow-sm);
}

.avatar-group .avatar:first-child {
  margin-left: 0;
}

/* ── 表单头像上传/更换插槽 (Avatar Upload) ── */
.avatar-upload {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  padding: var(--space-6) 0;
  gap: var(--space-2);
}

.avatar-upload-tip {
  font-size: var(--text-xs);
  color: var(--color-text-muted);
  line-height: 1.4;
}

/*
** ─────────────────────────────────────────────────────────────────────
**  COMPONENT: TAGS & TAG (标签容器与多维语义标签体系)
** ─────────────────────────────────────────────────────────────────────
*/

/* ── 标签容器 (Tags Wrapper: 支持自适应流动与自动换行) ── */
.tags {
  display: flex;
  flex-wrap: wrap;
  align-items: center;
  gap: var(--space-2);
}

/* ── 基础标签实体 (默认中号 md，轻量半透明浅底形态) ── */
.tag {
  display: inline-flex;
  align-items: center;
  justify-content: center;
  gap: 6rpx;
  height: 48rpx;
  padding: 0 16rpx;
  border-radius: var(--radius-sm);
  font-size: var(--text-xs);
  font-weight: var(--weight-semibold);
  letter-spacing: 0.2rpx;
  line-height: 1;
  box-sizing: border-box;
  white-space: nowrap;
  border: 1.5rpx solid transparent;
  transition: all var(--anim-fast);
}

/* ── 语义浅色变体 (Default Soft Dim Mode) ── */
.tag-primary   { background: var(--color-primary-dim);   color: var(--color-primary-text);   border-color: rgba(14, 165, 233, 0.2); }
.tag-secondary { background: var(--color-secondary-dim); color: var(--color-secondary-text); border-color: var(--color-border); }
.tag-warning   { background: var(--color-warning-dim);   color: var(--color-warning-text);   border-color: rgba(217, 119, 6, 0.2); }
.tag-danger    { background: var(--color-danger-dim);    color: var(--color-danger-text);    border-color: rgba(225, 29, 72, 0.2); }
.tag-success   { background: var(--color-success-dim);   color: var(--color-success-text);   border-color: rgba(5, 150, 105, 0.2); }
.tag-info      { background: var(--color-info-dim);      color: var(--color-info-text);      border-color: rgba(99, 102, 241, 0.2); }
.tag-surface   { background: var(--color-surface);       color: var(--color-text-sub);       border-color: var(--color-border); }

/* ── 实色高亮变体 (Solid Mode: 用于突出与主推场景) ── */
.tag-solid.tag-primary   { background: var(--color-primary);   color: #FFFFFF; border-color: transparent; }
.tag-solid.tag-secondary { background: var(--color-secondary); color: #FFFFFF; border-color: transparent; }
.tag-solid.tag-warning   { background: var(--color-warning);   color: #FFFFFF; border-color: transparent; }
.tag-solid.tag-danger    { background: var(--color-danger);    color: #FFFFFF; border-color: transparent; }
.tag-solid.tag-success   { background: var(--color-success);   color: #FFFFFF; border-color: transparent; }
.tag-solid.tag-info      { background: var(--color-info);      color: #FFFFFF; border-color: transparent; }

/* ── 纯镂空线框变体 (Outline Mode) ── */
.tag-outline { background: transparent !important; }
.tag-outline.tag-primary   { border-color: var(--color-primary);   color: var(--color-primary); }
.tag-outline.tag-secondary { border-color: var(--color-secondary); color: var(--color-secondary); }
.tag-outline.tag-warning   { border-color: var(--color-warning);   color: var(--color-warning); }
.tag-outline.tag-danger    { border-color: var(--color-danger);    color: var(--color-danger); }
.tag-outline.tag-success   { border-color: var(--color-success);   color: var(--color-success); }
.tag-outline.tag-info      { border-color: var(--color-info);      color: var(--color-info); }

/* ── 几何形态修饰符 (Shape Modifiers) ── */
/* 胶囊圆角 */
.tag-pill {
  border-radius: var(--radius-pill);
}

/* 直角极简 */
.tag-square {
  border-radius: var(--radius-xs);
}

/* ── 规格阶梯 (Size Variants) ── */
/* 紧凑微型标签 */
.tag-sm {
  height: 38rpx;
  padding: 0 10rpx;
  font-size: var(--text-2xs);
  border-radius: var(--radius-xs);
}
.tag-sm.tag-pill { border-radius: var(--radius-pill); }

/* 中号标准标签 (与默认高度一致) */
.tag-md {
  height: 48rpx;
  padding: 0 16rpx;
  font-size: var(--text-xs);
}

/* 大号状态标签 */
.tag-lg {
  height: 56rpx;
  padding: 0 22rpx;
  font-size: var(--text-sm);
  border-radius: var(--radius-md);
}
.tag-lg.tag-pill { border-radius: var(--radius-pill); }

/* ── 带状态指示点结构 (Status Dot) ── */
.tag-dot {
  width: 12rpx;
  height: 12rpx;
  border-radius: var(--radius-full);
  background: currentColor;
  opacity: 0.85;
}

/*
** ─────────────────────────────────────────────────────────────────────
**  COMPONENT: FORM (表单容器、字段、标签与输入控制)
** ─────────────────────────────────────────────────────────────────────
*/

/* ── 字段容器 (Field Container) ── */
.field {
  padding: 20rpx 0;
  border-bottom: 1.5rpx solid var(--color-border-subtle);
}

.field-last {
  border-bottom: none;
  padding-bottom: 0;
}

/* ── 字段标签 (Field Label) ── */
.field-label {
  display: block;
  font-size: var(--text-sm);
  font-weight: var(--weight-semibold);
  color: var(--color-text-sub);
  margin-bottom: 12rpx;
  line-height: 1.4;
}

/* 必填星号指示 */
.field-required .field-label::after {
  content: ' *';
  color: var(--color-danger);
  font-size: var(--text-sm);
}

/* ── 单行输入框 (Field Input) ── */
.field-input {
  width: 100%;
  height: 84rpx;
  padding: 0 24rpx;
  font-size: var(--text-md);
  color: var(--color-text-main);
  background: var(--color-surface);
  border: 1.5rpx solid transparent;
  border-radius: var(--radius-md);
  box-sizing: border-box;
  transition: all var(--anim-fast);
}

/* 聚焦发光态 */
.field-input:focus {
  background: #FFFFFF;
  border-color: var(--color-primary);
  box-shadow: 0 0 0 4rpx var(--color-primary-dim);
}

/* 只读输入框态 (Readonly) */
.field-input-ro {
  color: var(--color-primary-text);
  background: var(--color-primary-dim);
  border-color: rgba(14, 165, 233, 0.15);
}

/* ── 组合选择控制器 (Picker / Select Control) ── */
.field-control {
  display: flex;
  align-items: center;
  justify-content: space-between;
  width: 100%;
  height: 84rpx;
  padding: 0 24rpx;
  background: var(--color-surface);
  border-radius: var(--radius-md);
  box-sizing: border-box;
}

.field-value {
  font-size: var(--text-md);
  color: var(--color-text-main);
  font-weight: var(--weight-medium);
}

.field-placeholder {
  font-size: var(--text-md);
  color: var(--color-text-muted);
}

.field-arrow {
  font-size: var(--text-2xs);
  color: var(--color-text-muted);
  margin-left: 12rpx;
}

/* ── 后缀单位输入结构 (Input with Suffix) ── */
.field-with-suffix {
  display: flex;
  align-items: stretch;
  width: 100%;
}

.field-input-suffix {
  flex: 1;
  border-radius: var(--radius-md) 0 0 var(--radius-md);
}

.field-suffix {
  display: flex;
  align-items: center;
  padding: 0 24rpx;
  font-size: var(--text-sm);
  color: var(--color-text-muted);
  background: var(--color-surface);
  border: 1.5rpx solid var(--color-border);
  border-left: none;
  border-radius: 0 var(--radius-md) var(--radius-md) 0;
  white-space: nowrap;
}

/* ── 多行文本域 (Field Textarea) ── */
.field-textarea {
  width: 100%;
  min-height: 160rpx;
  padding: 20rpx 24rpx;
  font-size: var(--text-md);
  color: var(--color-text-main);
  background: var(--color-surface);
  border: 1.5rpx solid transparent;
  border-radius: var(--radius-md);
  box-sizing: border-box;
  line-height: 1.6;
}

.field-textarea:focus {
  background: #FFFFFF;
  border-color: var(--color-primary);
  box-shadow: 0 0 0 4rpx var(--color-primary-dim);
}

/* ── 胶囊容器 (包裹所有选项并支持自动换行) ── */
.field-chips {
  display: flex;
  flex-wrap: wrap;
  gap: var(--space-3);
  padding: var(--space-1) 0;
}

/* ── 单个胶囊选项 (默认未选状态) ── */
.field-chip {
  display: inline-flex;
  align-items: center;
  justify-content: center;
  min-width: 120rpx;
  height: 68rpx;
  padding: 0 28rpx;
  background: var(--color-surface);
  color: var(--color-text-sub);
  font-size: var(--text-md);
  font-weight: var(--weight-medium);
  border-radius: var(--radius-pill);
  border: 1.5rpx solid transparent;
  box-sizing: border-box;
  white-space: nowrap;
  transition: all var(--anim-fast);
}

/* 按压触感反馈 */
.field-chip:active {
  transform: scale(0.96);
  background: var(--color-surface-hover);
}

/* ── 激活 / 选中状态 (Active / Selected) ── */
.field-chip.active,
.field-chip-active {
  background: var(--color-primary);
  color: #FFFFFF;
  font-weight: var(--weight-semibold);
  box-shadow: 0 4rpx 12rpx rgba(2, 132, 199, 0.28);
}

/* ── 禁用状态 (Disabled) ── */
.field-chip.disabled,
.field-chip-disabled {
  opacity: 0.45;
  pointer-events: none;
}

/* ── 标签容器 (自动换行排列) ── */
.field-tags {
  display: flex;
  flex-wrap: wrap;
  align-items: center;
  gap: var(--space-3);
  padding: var(--space-1) 0;
}

/* ── 已生成的标签实体 (基础青绿胶囊形态) ── */
.field-tag {
  display: inline-flex;
  align-items: center;
  height: 60rpx;
  padding: 0 20rpx;
  background: var(--color-success-dim);
  border-radius: var(--radius-pill);
  box-sizing: border-box;
  white-space: nowrap;
}

/* 标签文字部分 */
.field-tag-text {
  font-size: var(--text-md);
  color: var(--color-success-text);
  font-weight: var(--weight-medium);
  line-height: 1;
}

/* ── 删除/关闭叉号 (Close Action) ── */
.field-tag-close {
  display: inline-flex;
  align-items: center;
  justify-content: center;
  width: 28rpx;
  height: 28rpx;
  margin-left: 10rpx;
  font-size: var(--text-xs);
  color: var(--color-success-text);
  opacity: 0.7;
  transition: opacity var(--anim-fast);
}

.field-tag-close:active {
  opacity: 1;
  transform: scale(0.9);
}

/* ── 添加标签按钮 (虚线边框触发态) ── */
.field-tag-add {
  display: inline-flex;
  align-items: center;
  justify-content: center;
  gap: 6rpx;
  height: 60rpx;
  padding: 0 24rpx;
  background: transparent;
  color: var(--color-text-sub);
  font-size: var(--text-md);
  font-weight: var(--weight-medium);
  border: 2rpx dashed var(--color-border);
  border-radius: var(--radius-pill);
  box-sizing: border-box;
  white-space: nowrap;
  transition: all var(--anim-fast);
}

.field-tag-add:active {
  border-color: var(--color-primary);
  color: var(--color-primary);
  background: var(--color-primary-dim);
}

/* ── 上传网格容器 (支持横向排列与自动换行) ── */
.field-uploader {
  display: flex;
  flex-wrap: wrap;
  gap: var(--space-4);
  padding: var(--space-1) 0;
}

/* ── 单个上传卡片基类 (固定等宽高正方形，140r~150rpx标准尺寸) ── */
.field-uploader-item {
  position: relative;
  width: 144rpx;
  height: 144rpx;
  border-radius: var(--radius-lg);
  overflow: hidden;
  background: var(--color-surface);
  box-sizing: border-box;
}

/* ── 已上传图片主体 ── */
.field-uploader-img {
  width: 100%;
  height: 100%;
  object-fit: cover;
  display: block;
}

/* ── 右上角删除操作遮罩 (暗色半透明，带单侧圆角) ── */
.field-uploader-del {
  position: absolute;
  top: 0;
  right: 0;
  width: 44rpx;
  height: 44rpx;
  background: rgba(15, 23, 42, 0.6);
  border-radius: 0 var(--radius-lg) 0 var(--radius-md);
  display: flex;
  align-items: center;
  justify-content: center;
  color: #FFFFFF;
  font-size: 24rpx;
  line-height: 1;
  transition: opacity var(--anim-fast);
}

.field-uploader-del:active {
  background: var(--color-danger);
}

/* ── 末尾新增触发卡片 (虚线边框 + 浅灰加号) ── */
.field-uploader-add {
  display: flex;
  align-items: center;
  justify-content: center;
  background: transparent;
  border: 2rpx dashed var(--color-border);
  transition: all var(--anim-fast);
}

.field-uploader-add:active {
  border-color: var(--color-primary);
  background: var(--color-primary-dim);
}

/* 虚线框内部加号字符 */
.field-uploader-plus {
  font-size: 56rpx;
  font-weight: var(--weight-light);
  color: var(--color-text-muted);
  line-height: 1;
}

.field-uploader-add:active .field-uploader-plus {
  color: var(--color-primary);
}

/* ── 文件列表容器 ── */
.field-files {
  display: flex;
  flex-direction: column;
  gap: var(--space-2);
  padding: var(--space-1) 0;
}

/* ── “+ 添加文件” 触发按钮 (文字链接形态) ── */
.field-file-add {
  display: inline-flex;
  align-items: center;
  gap: 8rpx;
  align-self: flex-start;
  padding: var(--space-2) 0;
  font-size: var(--text-md);
  font-weight: var(--weight-medium);
  color: var(--color-success-text);
  line-height: 1.4;
  cursor: pointer;
  transition: opacity var(--anim-fast);
}

.field-file-add:active {
  opacity: 0.7;
}

/* ── 已上传文件条目行 (选中后展示形态) ── */
.field-file-item {
  display: flex;
  align-items: center;
  gap: var(--space-3);
  padding: 18rpx 20rpx;
  background: var(--color-surface);
  border-radius: var(--radius-md);
  box-sizing: border-box;
}

/* 文件类型图标 (PDF/DOC/ZIP等) */
.field-file-icon {
  font-size: var(--text-lg);
  line-height: 1;
}

/* 文件名主体 (超长单行省略) */
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

/* 删除文件小叉号 */
.field-file-del {
  display: flex;
  align-items: center;
  justify-content: center;
  width: 36rpx;
  height: 36rpx;
  border-radius: var(--radius-full);
  font-size: var(--text-xs);
  color: var(--color-text-muted);
  transition: all var(--anim-fast);
}

.field-file-del:active {
  background: var(--color-danger-dim);
  color: var(--color-danger);
}

/* 
** ─────────────────────────────────────────────────────────────────────
**  COMPONENT: CELL (只读详情展示单元格 / 键值对系统)
** ───────────────────────────────────────────────────────────────────── 
*/

/* ── 1. 分组与标题容器 ── */
.cell-group {
  margin-bottom: var(--space-4);
}

.cell-group-title {
  display: flex;
  align-items: center;
  gap: var(--space-2);
  padding: 24rpx 28rpx 16rpx;
  font-size: var(--text-body);
  font-weight: var(--weight-bold);
  color: var(--color-text-main);
  border-bottom: 1.5rpx solid var(--color-border-subtle);
}

/* 分组标题左侧装饰指示圆点 */
.cell-group-dot {
  width: 12rpx;
  height: 12rpx;
  border-radius: var(--radius-full);
  background: var(--color-primary);
}

/* ── 2. 单行展示单元格 (核心 Flex 左右排版) ── */
.cell {
  display: flex;
  align-items: center;
  justify-content: space-between;
  min-height: 88rpx;
  padding: 20rpx 28rpx;
  border-bottom: 1.5rpx solid var(--color-border-subtle);
  box-sizing: border-box;
  background: var(--color-card);
  transition: background var(--anim-fast);
}

/* 点击反馈 */
.cell:active {
  background: var(--color-surface);
}

/* 最后一项自动去除底部分割线 */
.cell:last-child,
.cell-last {
  border-bottom: none;
}

/* ── 3. 左侧标签区 (定宽防换行被挤压) ── */
.cell-label {
  width: 180rpx;
  flex-shrink: 0;
  font-size: var(--text-base);
  font-weight: var(--weight-semibold);
  color: var(--color-text-sub);
  line-height: 1.4;
}

/* ── 4. 右侧内容值区 (默认右对齐) ── */
.cell-value {
  flex: 1;
  min-width: 0;
  display: flex;
  align-items: center;
  justify-content: flex-end;
  text-align: right;
  font-size: var(--text-md);
  font-weight: var(--weight-medium);
  color: var(--color-text-main);
  line-height: 1.5;
  word-break: break-all;
}

/* 数值后面的单位 (如 米/秒, %/天) */
.cell-unit {
  margin-left: 6rpx;
  font-size: var(--text-xs);
  color: var(--color-text-muted);
  font-weight: var(--weight-normal);
}

/* ── 5. 多行长文本场景 (顶端对齐、内容靠左) ── */
.cell-multiline,
.cell-vertical {
  align-items: flex-start;
  padding: 24rpx 28rpx;
}

.cell-multiline .cell-value,
.cell-vertical .cell-value {
  justify-content: flex-start;
  text-align: left;
  line-height: 1.6;
}

/* ── 6. 标签展示场景 (向右靠拢流动排列) ── */
.cell-tags {
  display: flex;
  flex-wrap: wrap;
  justify-content: flex-end;
  gap: var(--space-2);
}

/* ── 7. 只读状态高亮胶囊 ── */
.cell-badge {
  display: inline-flex;
  align-items: center;
  padding: 4rpx 14rpx;
  border-radius: var(--radius-sm);
  background: var(--color-primary-dim);
  border: 1rpx solid rgba(0, 201, 167, 0.2);
  color: var(--color-primary-text);
  font-size: var(--text-sm);
  font-weight: var(--weight-semibold);
}

/* 
** ─────────────────────────────────────────────────────────────────────
**  COMPONENT: BTN-GRID (按键组件 -> 网格矩阵)
** ───────────────────────────────────────────────────────────────────── 
*/
/* ── 网格按键容器 (默认3列平分，利用 top / left 边框形成闭合网格) ── */
.btn-grid {
  display: grid;
  grid-template-columns: repeat(3, 1fr);
  width: 100%;
  background: var(--color-card);
  border-top: 1.5rpx solid var(--color-border);
  border-left: 1.5rpx solid var(--color-border);
  box-sizing: border-box;
}

/* 4列紧凑变体 (可选) */
.btn-grid-col4 {
  grid-template-columns: repeat(4, 1fr);
}

/* ── 单个网格单元按键 ── */
.btn-grid-item {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  min-height: 200rpx;
  padding: var(--space-4);
  background: var(--color-card);
  border-right: 1.5rpx solid var(--color-border);
  border-bottom: 1.5rpx solid var(--color-border);
  box-sizing: border-box;
  transition: background var(--anim-fast);
}

/* 点击反馈态 (微沉暗底) */
.btn-grid-item:active {
  background: var(--color-surface);
}

/* ── 按键文案排版 ── */
.btn-grid-label {
  font-size: var(--text-md);
  font-weight: var(--weight-medium);
  color: var(--color-text-main);
  text-align: center;
  line-height: 1.4;
  white-space: nowrap;
}

/* ── 扩展：上方可选图标槽位 ── */
.btn-grid-icon {
  font-size: 48rpx;
  line-height: 1;
  margin-bottom: var(--space-2);
}

/* 
** ─────────────────────────────────────────────────────────────────────
**  COMPONENT: LIST VIEW (列表视图与单元格条目系统)
** ───────────────────────────────────────────────────────────────────── 
*/

/* ── 列表外层容器 (默认卡片式微悬浮形态) ── */
.list-view {
  background: var(--color-card);
  border-radius: var(--radius-xl);
  border: 1.5rpx solid var(--color-border);
  box-shadow: var(--shadow-sm);
  overflow: hidden;
  box-sizing: border-box;
}

/* 通栏模式 (无外圆角、两端贴边，适合主 Tab 页面全宽列表) */
.list-view-flush {
  border-radius: 0;
  border-left: none;
  border-right: none;
  box-shadow: none;
}

/* ── 列表分组标题 (List Group Header) ── */
.list-header {
  padding: 24rpx 28rpx 12rpx;
  font-size: var(--text-xs);
  font-weight: var(--weight-bold);
  color: var(--color-text-muted);
  text-transform: uppercase;
  letter-spacing: 0.5rpx;
}

/* ── 基础列表条目 (List Item) ── */
.list-item {
  position: relative;
  /* display: flex; */
  align-items: center;
  justify-content: space-between;
  min-height: 104rpx;
  padding: 24rpx 28rpx;
  background: var(--color-card);
  box-sizing: border-box;
  transition: background var(--anim-fast);
}

/* 单元格之间的极细微弱分割线 (最后一项自动去除) */
.list-item + .list-item {
  border-top: 1.5rpx solid var(--color-border-subtle);
}

/* 交互卡片/条目按压反馈态 */
.list-item:active {
  background: var(--color-surface);
}

/* ── 左侧前缀插槽 (Prefix: 图标/头像) ── */
.list-prefix {
  display: flex;
  align-items: center;
  justify-content: center;
  margin-right: var(--space-4);
  flex-shrink: 0;
}

.list-icon {
  font-size: var(--text-xl);
  line-height: 1;
}

/* ── 中间内容主体 (Content: 标题与描述) ── */
.list-content {
  flex: 1;
  min-width: 0; /* 触发单行截断关键属性 */
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

/* ── 右侧后缀插槽 (Suffix: 附加信息、状态、标签) ── */
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
  font-weight: var(--weight-normal);
  line-height: 1;
}

/* ── 右侧导航箭头 (Arrow) ── */
.list-arrow {
  display: flex;
  align-items: center;
  justify-content: center;
  margin-left: var(--space-2);
  font-size: var(--text-xs);
  color: var(--color-text-muted);
  line-height: 1;
  opacity: 0.7;
}

/* 
** ─────────────────────────────────────────────────────────────────────
**  COMPONENT: 瀑布流布局核心 (Waterfall Layout)
** ───────────────────────────────────────────────────────────────────── 
*/

.waterfall-container {
  display: flex;
  justify-content: space-between;
  align-items: flex-start; /* 关键：防止两列被拉伸等高 */
  padding: 16rpx 20rpx;
  box-sizing: border-box;
}

.waterfall-column {
  width: calc(50% - 10rpx); /* 两列均分，保留中间 20rpx 间距 */
  display: flex;
  flex-direction: column;
}

.waterfall-card {
  margin-bottom: 20rpx; /* 卡片之间的上下间距 */
  width: 100%;
}


/* 
** ─────────────────────────────────────────────────────────────────────
**  COMPONENT: TIMELINE COMMENT (时间轴批注、审批意见与沟通记录)
** ─────────────────────────────────────────────────────────────────────
*/

/* ── 1. 时间轴主容器 (包裹整条流水线) ── */
.timeline {
  display: flex;
  flex-direction: column;
  padding: var(--space-4) var(--space-6);
  box-sizing: border-box;
}

/* 嵌入卡片内的紧凑模式 (去外边距，自然融入 Card) */
.timeline-card {
  padding: var(--space-2) 0;
}

/* ── 2. 单个时间轴条目 (Timeline Item) ── */
.timeline-item {
  position: relative;
  display: flex;
  padding-bottom: var(--space-8);
  box-sizing: border-box;
}

/* 最后一项隐藏主轴连接线并缩小底部留白 */
.timeline-item:last-child {
  padding-bottom: 0;
}

/* ── 3. 轴线轨道系统 (The Vertical Track) ── */
/* 核心贯穿竖线：由左侧图标槽绝对定位居中延伸 */
.timeline-item::before {
  content: '';
  position: absolute;
  top: 36rpx;                   /* 从节点图标中央下方开始 */
  left: 27rpx;                  /* 锚定节点水平中轴线 (56rpx 宽度的中心约 27rpx) */
  bottom: 0;
  width: 2rpx;
  background: var(--color-border);
  transform: translateX(-50%);
  z-index: 1;
}

.timeline-item:last-child::before {
  display: none;                /* 尾节点切断向下延伸的轴线 */
}

/* 轨道线风格变体：虚线轨道 (常用于“待进行”或“预估步骤”) */
.timeline-item-dashed::before {
  background: repeating-linear-gradient(
    to bottom,
    var(--color-border) 0,
    var(--color-border) 8rpx,
    transparent 8rpx,
    transparent 16rpx
  );
}

/* ── 4. 节点指示器容器 (Node Indicator Slot) ── */
.timeline-node {
  position: relative;
  z-index: 2;                   /* 遮盖贯穿竖线 */
  display: flex;
  align-items: center;
  justify-content: center;
  width: 56rpx;
  height: 56rpx;
  margin-right: var(--space-4);
  flex-shrink: 0;
  background: var(--color-bg);  /* 底色与页面背景一致，形成天然隔断遮罩 */
}

/* 卡片内部嵌套时背景自动变纯白 */
.card .timeline-node {
  background: var(--color-card);
}

/* ── 4.1 节点形态变体 1：极简小圆点 (Dot Mode) ── */
.timeline-dot {
  width: 18rpx;
  height: 18rpx;
  border-radius: var(--radius-full);
  background: var(--color-text-muted);
  box-shadow: 0 0 0 6rpx var(--color-bg); /* 外圈光晕扩散 */
  transition: all var(--anim-base);
}
.card .timeline-dot {
  box-shadow: 0 0 0 6rpx var(--color-card);
}

/* ── 4.2 节点形态变体 2：微拟物立体徽标/图标台 (Icon Mode) ── */
.timeline-icon-box {
  width: 52rpx;
  height: 52rpx;
  border-radius: var(--radius-full);
  background: var(--color-surface);
  color: var(--color-text-sub);
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: var(--text-sm);
  border: 1.5rpx solid var(--color-border);
  box-shadow: var(--shadow-sm);
  transition: all var(--anim-base);
}

/* ── 5. 节点语义状态系统 (Semantic Statuses) ── */

/* ① Active / Current: 当前进行中 (薄荷青主色 + 呼吸光晕) */
.timeline-item-primary .timeline-dot,
.timeline-item-active .timeline-dot {
  background: var(--color-primary);
  box-shadow: 0 0 0 8rpx var(--color-primary-dim);
}

.timeline-item-primary .timeline-icon-box,
.timeline-item-active .timeline-icon-box {
  background: linear-gradient(135deg, var(--color-primary-light), var(--color-primary));
  color: #FFFFFF;
  border-color: transparent;
  box-shadow: 0 4rpx 14rpx rgba(0, 201, 167, 0.35);
}

/* ② Success: 已完成 / 成功 (森林绿) */
.timeline-item-success .timeline-dot {
  background: var(--color-success);
  box-shadow: 0 0 0 8rpx var(--color-success-dim);
}
.timeline-item-success .timeline-icon-box {
  background: var(--color-success);
  color: #FFFFFF;
  border-color: transparent;
  box-shadow: 0 4rpx 12rpx rgba(39, 174, 96, 0.25);
}

/* ③ Warning: 挂起 / 风险预警 (琥珀橙) */
.timeline-item-warning .timeline-dot {
  background: var(--color-warning);
  box-shadow: 0 0 0 8rpx var(--color-warning-dim);
}
.timeline-item-warning .timeline-icon-box {
  background: var(--color-warning);
  color: #FFFFFF;
  border-color: transparent;
  box-shadow: 0 4rpx 12rpx rgba(245, 166, 35, 0.25);
}

/* ④ Danger: 异常中断 / 驳回 (警示红) */
.timeline-item-danger .timeline-dot {
  background: var(--color-danger);
  box-shadow: 0 0 0 8rpx var(--color-danger-dim);
}
.timeline-item-danger .timeline-icon-box {
  background: var(--color-danger);
  color: #FFFFFF;
  border-color: transparent;
  box-shadow: 0 4rpx 12rpx rgba(231, 76, 111, 0.25);
}

/* ⑤ Pending / Secondary: 沉稳深海军蓝 */
.timeline-item-secondary .timeline-icon-box {
  background: var(--color-secondary);
  color: #FFFFFF;
  border-color: transparent;
}

/* ── 6. 右侧时间轴内容区 (Content Layout) ── */
.timeline-content {
  flex: 1;
  min-width: 0;
  display: flex;
  flex-direction: column;
  padding-top: 6rpx;            /* 对齐左侧指示器上边缘 */
}

/* 头部两端对齐栏：标题与右侧时间戳 */
.timeline-header {
  display: flex;
  align-items: center;
  justify-content: space-between;
  gap: var(--space-2);
  margin-bottom: var(--space-1);
}

.timeline-title {
  font-size: var(--text-md);
  font-weight: var(--weight-semibold);
  color: var(--color-text-main);
  line-height: 1.35;
}

/* 当前进行中的标题高亮强化 */
.timeline-item-active .timeline-title {
  color: var(--color-primary-text);
  font-weight: var(--weight-bold);
}

/* 发生时间标签 */
.timeline-time {
  font-size: var(--text-xs);
  color: var(--color-text-muted);
  font-weight: var(--weight-normal);
  white-space: nowrap;
}

/* 描述详情段落 */
.timeline-desc {
  font-size: var(--text-sm);
  color: var(--color-text-sub);
  line-height: 1.5;
  margin-top: 6rpx;
}

/* ── 7. 内容区下属附属插槽 ── */

/* 7.1 嵌入式微卡片插槽 (常用于审批意见留言、操作凭证) */
.timeline-card-box {
  margin-top: var(--space-3);
  padding: var(--space-4);
  background: var(--color-surface);
  border-radius: var(--radius-md);
  border: 1.5rpx solid var(--color-border-subtle);
  box-sizing: border-box;
}

/* 7.2 底部标签/信息组插槽 */
.timeline-tags {
  display: flex;
  flex-wrap: wrap;
  gap: var(--space-2);
  margin-top: var(--space-3);
}

/* ── 8. 扩展：左右交替对称时间轴 (Centered Alternate Mode) ── */
.timeline-alternate .timeline-item:nth-child(even) {
  flex-direction: row-reverse;
}
.timeline-alternate .timeline-item:nth-child(even) .timeline-content {
  text-align: right;
  padding-right: var(--space-4);
  padding-left: 0;
}
.timeline-alternate .timeline-item:nth-child(even) .timeline-header {
  flex-direction: row-reverse;
}

/* 
** ─────────────────────────────────────────────────────────────────────
**  COMPONENT: SEGMENTS (分段选择器与筛选工具条系统)
** ───────────────────────────────────────────────────────────────────── 
*/

/* ── 1. 配套筛选工具栏容器 (常置于页面顶部或吸顶悬浮) ── */
.segments-bar {
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: 16rpx var(--space-6);
  background: var(--color-card);
  box-sizing: border-box;
  width: 100%;
}

/* ── 2. 分段器滑轨基座 (支持横向滚动，不换行) ── */
.segments {
  display: inline-flex;
  align-items: center;
  gap: 8rpx;
  padding: 6rpx;
  background: var(--color-surface);
  border-radius: var(--radius-pill);
  box-sizing: border-box;
  overflow-x: auto;
  white-space: nowrap;
  /* 隐藏小程序原生滚动条 */
  scrollbar-width: none;
}

.segments::-webkit-scrollbar {
  display: none;
}

/* 均分宽度变体 (用于2~4个选项的固定标签页) */
.segments-fluid {
  display: flex;
  width: 100%;
}

.segments-fluid .seg {
  flex: 1;
  text-align: center;
  justify-content: center;
}

/* ── 3. 单个分段滑块选项 ── */
.seg {
  position: relative;
  display: inline-flex;
  align-items: center;
  justify-content: center;
  height: 60rpx;
  padding: 0 28rpx;
  font-size: var(--text-sm);
  font-weight: var(--weight-medium);
  color: var(--color-text-sub);
  border-radius: var(--radius-pill);
  background: transparent;
  box-sizing: border-box;
  white-space: nowrap;
  transition: all var(--anim-fast);
}

/* 未选状态的按压微触感 */
.seg:active {
  background: var(--color-surface-hover);
}

/* ── 4. 激活选中态 (Active: 默认极夜深墨纯净悬浮态) ── */
.seg-on,
.seg.active {
  background: var(--color-secondary);
  color: #FFFFFF;
  font-weight: var(--weight-bold);
  box-shadow: 0 4rpx 14rpx rgba(13, 27, 42, 0.16);
}

/* 激活选中态变体：薄荷青主色模式 (适用于高频强调交互) */
.seg-primary.seg-on,
.seg-primary.active {
  background: var(--color-primary);
  color: #FFFFFF;
  box-shadow: 0 4rpx 14rpx rgba(0, 201, 167, 0.28);
}

/* ── 5. 分段器内数字计数徽章 (Badge) ── */
.seg-badge {
  display: inline-flex;
  align-items: center;
  justify-content: center;
  min-width: 28rpx;
  height: 28rpx;
  margin-left: 8rpx;
  padding: 0 8rpx;
  font-size: 18rpx;
  font-weight: var(--weight-bold);
  border-radius: var(--radius-pill);
  background: var(--color-surface-hover);
  color: var(--color-text-sub);
  line-height: 1;
}

/* 选中项内部的徽章配色倒置 */
.seg-on .seg-badge,
.seg.active .seg-badge {
  background: rgba(255, 255, 255, 0.2);
  color: #FFFFFF;
}

.segments-btn {
  display: flex;
  align-items: center;
  gap: 8rpx;
  height: 60rpx;
  padding: 0 22rpx;
  font-size: var(--text-sm);
  font-weight: var(--weight-semibold);
  color: var(--color-primary-text);
  border: 1.5rpx solid var(--color-primary);
  border-radius: var(--radius-pill);
  background: transparent;
  flex-shrink: 0;
  margin-left: var(--space-4);
  transition: all var(--anim-fast);
}

.segments-btn:active {
  background: var(--color-primary-dim);
}

.segments-btn-arrow {
  font-size: 16rpx;
  transition: transform var(--anim-base);
}
.segments-btn-arrow-up {
  transform: rotate(180deg);
}

/* 
** ─────────────────────────────────────────────────────────────────────
**  COMPONENT: TABS (页面级选项卡与游标指示系统)
** ───────────────────────────────────────────────────────────────────── 
*/

/* ── 1. 选项卡顶层容器 (默认纯白卡片底，贴合底部分割线) ── */
.tabs {
  position: relative;
  width: 100%;
  background: var(--color-card);
  border-bottom: 1.5rpx solid var(--color-border);
  box-sizing: border-box;
}

/* 吸顶定位变体 (常置于 page-header 或顶部导航下方) */
.tabs-sticky {
  position: sticky;
  top: 0;
  z-index: 80;
}

/* ── 2. 横向滚动滑轨 (多于4个选项时长条自适应横滑) ── */
.tabs-scroll {
  display: flex;
  align-items: center;
  width: 100%;
  white-space: nowrap;
  box-sizing: border-box;
  padding: 0 var(--space-4);
  /* 隐藏小程序与各端滚动条 */
  scrollbar-width: none;
}
.tabs-scroll::-webkit-scrollbar {
  display: none;
}

/* ── 3. 单个选项卡单元 (Tab Item) ── */
.tab-item {
  position: relative;
  display: inline-flex;
  align-items: center;
  justify-content: center;
  height: 96rpx;
  padding: 0 var(--space-6);
  font-size: var(--text-md);
  font-weight: var(--weight-medium);
  color: var(--color-text-sub);
  box-sizing: border-box;
  white-space: nowrap;
  transition: color var(--anim-fast);
}

/* 点击反馈 */
.tab-item:active {
  color: var(--color-text-main);
}

/* ── 4. 激活选中状态 (Active / Tab-on) ── */
.tab-item.active,
.tab-item.tab-on {
  color: var(--color-primary-text);
  font-weight: var(--weight-bold);
}

/* 底部中央游标下划线 (薄荷青圆角高亮短条) */
.tab-item.active::after,
.tab-item.tab-on::after {
  content: '';
  position: absolute;
  bottom: 0;
  left: 50%;
  transform: translateX(-50%);
  width: 44rpx;
  height: 6rpx;
  border-radius: var(--radius-pill);
  background: var(--color-primary);
  box-shadow: 0 2rpx 8rpx rgba(0, 201, 167, 0.4);
}

/* ── 5. 等宽平铺变体 (Fluid: 用于2~4个选项均分屏幕宽度) ── */
.tabs-fluid .tabs-scroll {
  padding: 0;
}

.tabs-fluid .tab-item {
  flex: 1;
  padding: 0;
  justify-content: center;
}

/* ── 6. 胶囊风格变体 (Pill Tabs: 无下划线，改用内嵌浅底) ── */
.tabs-pill {
  border-bottom: none;
  background: transparent;
  padding: var(--space-2) var(--space-4);
}

.tabs-pill .tab-item {
  height: 68rpx;
  padding: 0 28rpx;
  border-radius: var(--radius-pill);
  margin-right: var(--space-2);
}

.tabs-pill .tab-item.active {
  background: var(--color-primary-dim);
  color: var(--color-primary-text);
}

.tabs-pill .tab-item.active::after {
  display: none; /* 隐藏下划线 */
}

/* ── 7. 选项卡角标与红点 ── */
/* 统计数字徽章 */
.tab-badge {
  display: inline-flex;
  align-items: center;
  justify-content: center;
  min-width: 28rpx;
  height: 28rpx;
  margin-left: 8rpx;
  padding: 0 6rpx;
  font-size: 18rpx;
  font-weight: var(--weight-bold);
  border-radius: var(--radius-pill);
  background: var(--color-danger);
  color: #FFFFFF;
  line-height: 1;
  transform: translateY(-8rpx);
}

/* 纯红点状态 */
.tab-dot {
  width: 14rpx;
  height: 14rpx;
  margin-left: 6rpx;
  border-radius: var(--radius-full);
  background: var(--color-danger);
  transform: translateY(-10rpx);
}

/* ── 8. 禁用状态 ── */
.tab-item.disabled {
  color: var(--color-text-muted);
  pointer-events: none;
}

/* 
** ─────────────────────────────────────────────────────────────────────
**  COMPONENT: DRAWER (滑出式抽屉控制面板)
** ───────────────────────────────────────────────────────────────────── 
*/

/* ── 1. 全局遮罩层 (Backdrop) ── */
.drawer-backdrop {
  position: fixed;
  inset: 0;
  z-index: 98;
  background: rgba(13, 27, 42, 0.45);
  backdrop-filter: blur(8rpx);
  -webkit-backdrop-filter: blur(8rpx);
  opacity: 0;
  pointer-events: none;
  transition: opacity var(--anim-base);
}

/* 遮罩激活显示态 */
.drawer-backdrop.show,
.drawer-backdrop-show {
  opacity: 1;
  pointer-events: auto;
}

/* ── 2. 抽屉主容器 (默认顶部滑出模式) ── */
.drawer {
  position: fixed;
  left: 0;
  right: 0;
  z-index: 99;
  background: var(--color-card);
  box-shadow: var(--shadow-lg);
  display: flex;
  flex-direction: column;
  box-sizing: border-box;
  transition: transform var(--anim-smooth);
}

/* 顶部滑出变体 (替代原 .filter-drawer) */
.drawer-top {
  top: 0;
  border-radius: 0 0 var(--radius-xl) var(--radius-xl);
  transform: translateY(-100%);
}

.drawer-top.open,
.drawer-top.show {
  transform: translateY(0);
}

/* 底部滑出变体 (常见弹窗模式，支持 iPhone 安全区) */
.drawer-bottom {
  bottom: 0;
  border-radius: var(--radius-xl) var(--radius-xl) 0 0;
  transform: translateY(100%);
  padding-bottom: calc(20rpx + constant(safe-area-inset-bottom));
  padding-bottom: calc(20rpx + env(safe-area-inset-bottom));
}

.drawer-bottom.open,
.drawer-bottom.show {
  transform: translateY(0);
}

/* ── 3. 抽屉内部结构插槽 ── */
/* 头部标题区 (可选) */
.drawer-header {
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: 24rpx var(--space-6);
  border-bottom: 1.5rpx solid var(--color-border-subtle);
}

.drawer-title {
  font-size: var(--text-body);
  font-weight: var(--weight-bold);
  color: var(--color-text-main);
}

.drawer-close {
  font-size: var(--text-lg);
  color: var(--color-text-muted);
  padding: 4rpx;
  line-height: 1;
}

/* 主体滚动表单内容区 */
.drawer-body {
  max-height: 60vh;
  overflow-y: auto;
  padding: 0 var(--space-6);
}

/* 单行键值对/筛选行 (替代原 .filter-row) */
.drawer-row {
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: 24rpx 0;
  border-bottom: 1.5rpx solid var(--color-border-subtle);
}

.drawer-row:last-child {
  border-bottom: none;
}

.drawer-label {
  font-size: var(--text-base);
  font-weight: var(--weight-semibold);
  color: var(--color-text-sub);
  width: 160rpx;
  flex-shrink: 0;
}

.drawer-value {
  flex: 1;
  text-align: right;
  font-size: var(--text-md);
  color: var(--color-text-main);
}

.drawer-placeholder {
  color: var(--color-text-muted);
}

/* ── 4. 底部双按键操作栏 (重置 + 确认) ── */
.drawer-footer {
  display: flex;
  gap: var(--space-4);
  padding: 20rpx var(--space-6);
  background: var(--color-card);
  border-top: 1.5rpx solid var(--color-border-subtle);
}

.drawer-btn {
  flex: 1;
}

.drawer-mask {
  position: fixed;
  inset: 0;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  z-index: 98;
  background: rgba(13, 27, 42, 0.45); /* 深海军蓝半透明遮罩 */
  backdrop-filter: blur(6rpx);        /* 高斯模糊增强层级感 */
  -webkit-backdrop-filter: blur(6rpx);
  opacity: 0;
  pointer-events: none;               /* 隐藏时不阻挡下方点击 */
  transition: opacity var(--anim-base);
}

/* 遮罩显示激活态 */
.drawer-mask.show {
  opacity: 1;
  pointer-events: auto;               /* 显示时捕获点击事件以触发关闭 */
}

/* 
** ─────────────────────────────────────────────────────────────────────
**  COMPONENT: LOAD MORE (页面触底加载状态与指示器系统)
** ───────────────────────────────────────────────────────────────────── 
*/

/* ── 加载状态主容器 (为页面底部提供充足呼吸空间) ── */
.load-more {
  display: flex;
  align-items: center;
  justify-content: center;
  gap: var(--space-3);
  width: 100%;
  min-height: 88rpx;
  padding: var(--space-6) 0;
  box-sizing: border-box;
}

/* ── 纯 CSS 轻量旋转环 (Loading Spinner) ── */
.load-spinner {
  width: 32rpx;
  height: 32rpx;
  border-radius: var(--radius-full);
  border: 3.5rpx solid var(--color-surface-hover);
  border-top-color: var(--color-primary);
  animation: load-spin 0.8s linear infinite;
  box-sizing: border-box;
  flex-shrink: 0;
}

@keyframes load-spin {
  0%   { transform: rotate(0deg); }
  100% { transform: rotate(360deg); }
}

/* ── 状态说明文字 ── */
.load-text {
  font-size: var(--text-sm);
  color: var(--color-text-muted);
  font-weight: var(--weight-medium);
  letter-spacing: 0.5rpx;
  line-height: 1;
}

/* ── 数据全部加载完毕状态 (Finished / End: 带左右两翼淡雅分割线) ── */
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
  height: 1.5rpx;
  background: var(--color-border);
}

.load-finished .load-text,
.load-end .load-text {
  padding: 0 var(--space-4);
  font-size: var(--text-xs);
  color: var(--color-text-muted);
}

/* ── 加载失败 / 点击重试状态 (Error / Retry) ── */
.load-error {
  cursor: pointer;
}

.load-error .load-text {
  color: var(--color-primary-text);
}

.load-error:active {
  opacity: 0.7;
}

<#include "/$/tile.css.ftl">
