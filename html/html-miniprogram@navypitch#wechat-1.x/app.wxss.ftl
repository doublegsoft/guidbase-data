/* ═══════════════════════════════════════════════════════════════════════
   ACADEMY PRO · 青训家长端 — WXSS Design System
   基于 Academy Pro CSS Tokens 转换为微信小程序 WXSS
   适配 rpx 单位 · 移除不兼容属性 · 保留完整设计语言
   ═══════════════════════════════════════════════════════════════════════ */

/* ─────────────────────────────────────────────────────────────────────
   1.  FOUNDATIONS — CSS Custom Properties / Design Tokens
   ───────────────────────────────────────────────────────────────────── */

page {
  /* ── 1a.  Color Palette ───────────────────── */

  /* Brand / Primary */
  --color-navy:       #0D1B2A;
  --color-navy-mid:   #152636;
  --color-navy-light: #1D3448;
  --color-steel:      #1B4F72;

  /* Accent */
  --color-teal:       #00C9A7;
  --color-teal-hover: #00b599;
  --color-amber:      #F5A623;
  --color-amber-hover:#e8981a;
  --color-red:        #E74C6F;
  --color-blue:       #3B8BEB;
  --color-purple:     #9B59B6;

  /* Accent — Dim backgrounds */
  --color-teal-dim:   rgba(0,201,167,0.12);
  --color-amber-dim:  rgba(245,166,35,0.12);
  --color-red-dim:    rgba(231,76,111,0.12);
  --color-blue-dim:   rgba(59,139,235,0.12);
  --color-purple-dim: rgba(155,89,182,0.1);

  /* Accent — Tag text */
  --color-teal-text:  #00a085;
  --color-amber-text: #c8830a;
  --color-red-text:   #c0294f;
  --color-blue-text:  #2a6dc7;
  --color-purple-text:#7d3c98;

  /* Surfaces */
  --color-surface:    #F0F4F8;
  --color-card:       #FFFFFF;
  --color-bg:         #F5F7FA;

  /* Text */
  --color-text-main:  #1A2B3C;
  --color-text-sub:   #5A7080;
  --color-text-muted: #95AABA;

  /* Borders */
  --color-border:     #E2EAF0;

  /* Tab bar */
  --color-tab-text:       #95AABA;
  --color-tab-text-active:#00C9A7;

  /* ── 1b.  Typography ──────────────────────── */
  --font-family-base: 'PingFang SC', -apple-system, 'Helvetica Neue', sans-serif;
  --font-size-root:   28rpx;

  /* Type scale (in rpx for WeChat) */
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

  /* Font weights */
  --weight-normal:   400;
  --weight-medium:   500;
  --weight-semibold: 600;
  --weight-bold:     700;
  --weight-extrabold:800;

  /* ── 1c.  Spacing Scale (rpx) ─────────────── */
  --space-1:   4rpx;
  --space-2:   6rpx;
  --space-3:   8rpx;
  --space-4:   12rpx;
  --space-5:   16rpx;
  --space-6:   20rpx;
  --space-7:   24rpx;
  --space-8:   28rpx;
  --space-9:   32rpx;
  --space-10:  36rpx;
  --space-11:  40rpx;
  --space-12:  44rpx;
  --space-13:  48rpx;
  --space-14:  56rpx;

  /* ── 1d.  Border Radius ───────────────────── */
  --radius-xs:    6rpx;
  --radius-sm:    12rpx;
  --radius-md:    16rpx;
  --radius-lg:    20rpx;
  --radius-xl:    24rpx;
  --radius-2xl:   32rpx;
  --radius-full:  50%;
  --radius-pill:  40rpx;

  /* ── 1e.  Shadows ─────────────────────────── */
  --shadow-sm:   0 4rpx 32rpx rgba(13,27,42,0.08);
  --shadow-md:   0 8rpx 48rpx rgba(13,27,42,0.12);

  /* ── 1f.  Transitions ─────────────────────── */
  --transition-fast:   0.12s ease;
  --transition-base:   0.15s ease;
  --transition-smooth: 0.18s ease;
}

/* ═══════════════════════════════════════════════════════════════════════
   2.  GLOBAL RESET & BASE
   ═══════════════════════════════════════════════════════════════════════ */

page {
  font-family: var(--font-family-base);
  font-size: var(--font-size-root);
  background: var(--color-bg);
  color: var(--color-text-main);
  line-height: 1.5;
  -webkit-font-smoothing: antialiased;
}

/* ── Safe area for notch devices ── */
.safe-area-bottom {
  padding-bottom: constant(safe-area-inset-bottom);
  padding-bottom: env(safe-area-inset-bottom);
}

/* ═══════════════════════════════════════════════════════════════════════
   3.  LAYOUT UTILITIES
   ═══════════════════════════════════════════════════════════════════════ */

/* ── Flex ───────────────────────────────────── */
.flex           { display: flex; }
.flex-col       { display: flex; flex-direction: column; }
.flex-row       { display: flex; flex-direction: row; }
.flex-wrap      { flex-wrap: wrap; }
.flex-1         { flex: 1; }
.items-center   { align-items: center; }
.items-start    { align-items: flex-start; }
.items-end      { align-items: flex-end; }
.justify-center { justify-content: center; }
.justify-between{ justify-content: space-between; }
.justify-end    { justify-content: flex-end; }

/* ── Grid ───────────────────────────────────── */
.grid-2 { display: grid; grid-template-columns: 1fr 1fr; }
.grid-3 { display: grid; grid-template-columns: 1fr 1fr 1fr; }
.grid-4 { display: grid; grid-template-columns: 1fr 1fr 1fr 1fr; }

/* ── Spacing gaps ───────────────────────────── */
.gap-4  { gap: var(--space-4);  }
.gap-6  { gap: var(--space-6);  }
.gap-8  { gap: var(--space-8);  }
.gap-10 { gap: var(--space-10); }
.gap-12 { gap: var(--space-12); }

/* ── Padding ────────────────────────────────── */
.p-8  { padding: var(--space-8);  }
.p-10 { padding: var(--space-10); }
.p-12 { padding: var(--space-12); }
.px-8  { padding-left: var(--space-8); padding-right: var(--space-8); }
.px-10 { padding-left: var(--space-10); padding-right: var(--space-10); }
.px-12 { padding-left: var(--space-12); padding-right: var(--space-12); }
.py-6  { padding-top: var(--space-6); padding-bottom: var(--space-6); }
.py-8  { padding-top: var(--space-8); padding-bottom: var(--space-8); }
.py-10 { padding-top: var(--space-10); padding-bottom: var(--space-10); }

/* ── Margin ─────────────────────────────────── */
.mt-4  { margin-top: var(--space-4);  }
.mt-6  { margin-top: var(--space-6);  }
.mt-8  { margin-top: var(--space-8);  }
.mt-10 { margin-top: var(--space-10); }
.mt-12 { margin-top: var(--space-12); }
.mb-4  { margin-bottom: var(--space-4);  }
.mb-6  { margin-bottom: var(--space-6);  }
.mb-8  { margin-bottom: var(--space-8);  }
.mb-10 { margin-bottom: var(--space-10); }
.mb-12 { margin-bottom: var(--space-12); }
.mb-16 { margin-bottom: var(--space-14); }
.ml-auto { margin-left: auto; }

/* ── Width ──────────────────────────────────── */
.w-full { width: 100%; }

/* ═══════════════════════════════════════════════════════════════════════
   4.  PRIMITIVES — Buttons, Tags, Avatars
   ═══════════════════════════════════════════════════════════════════════ */

/* ── 4a.  Buttons ──────────────────────────── */
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

.btn::after { border: none; } /* override wechat button border */

.btn-primary { background: var(--color-teal); color: #fff; }
.btn-primary:active { background: var(--color-teal-hover); }

.btn-secondary { background: var(--color-surface); color: var(--color-text-main); border: 2rpx solid var(--color-border); }
.btn-secondary:active { background: #e5ecf2; }

.btn-amber { background: var(--color-amber); color: #fff; }
.btn-amber:active { background: var(--color-amber-hover); }

.btn-danger { background: var(--color-red-dim); color: var(--color-red); border: 2rpx solid rgba(231,76,111,0.2); }
.btn-danger:active { background: var(--color-red); color: #fff; }

.btn-outline { background: transparent; color: var(--color-teal); border: 2rpx solid var(--color-teal); }
.btn-outline:active { background: var(--color-teal-dim); }

/* Button sizes */
.btn-sm  { padding: 6rpx 22rpx; font-size: var(--text-xs); }
.btn-lg  { padding: var(--space-7) var(--space-13); font-size: var(--text-lg); }
.btn-block { width: 100%; }

/* ── 4b.  Tags / Badges ────────────────────── */
.tag {
  display: inline-flex;
  align-items: center;
  gap: var(--space-3);
  padding: 4rpx 16rpx;
  border-radius: var(--radius-pill);
  font-size: var(--text-xs);
  font-weight: var(--weight-semibold);
  white-space: nowrap;
}

.tag-teal   { background: var(--color-teal-dim);   color: var(--color-teal-text);   }
.tag-amber  { background: var(--color-amber-dim);  color: var(--color-amber-text);  }
.tag-blue   { background: var(--color-blue-dim);   color: var(--color-blue-text);   }
.tag-red    { background: var(--color-red-dim);    color: var(--color-red-text);    }
.tag-purple { background: var(--color-purple-dim); color: var(--color-purple-text); }
.tag-gray   { background: var(--color-surface);    color: var(--color-text-sub);    }

.tag-sm { font-size: 20rpx; padding: 2rpx 12rpx; }

/* ── 4c.  Avatars ──────────────────────────── */
.avatar {
  width: 68rpx;
  height: 68rpx;
  border-radius: var(--radius-full);
  font-size: var(--text-base);
  font-weight: var(--weight-bold);
  color: #fff;
  display: flex;
  align-items: center;
  justify-content: center;
  flex-shrink: 0;
}

.avatar-sm { width: 56rpx; height: 56rpx; font-size: var(--text-xs); }
.avatar-lg { width: 120rpx; height: 120rpx; font-size: var(--text-4xl); }
.avatar-xl { width: 144rpx; height: 144rpx; font-size: var(--text-5xl); }

/* Avatar color presets */
.avatar-teal      { background: linear-gradient(135deg, #00C9A7, #00a085); }
.avatar-amber     { background: linear-gradient(135deg, #F5A623, #c8830a); }
.avatar-blue      { background: linear-gradient(135deg, #3B8BEB, #2a6dc7); }
.avatar-purple    { background: linear-gradient(135deg, #9B59B6, #7d3c98); }
.avatar-red       { background: linear-gradient(135deg, #E74C6F, #c0294f); }
.avatar-navy      { background: linear-gradient(135deg, #0D1B2A, #1B4F72); }
.avatar-steel     { background: linear-gradient(135deg, #1B4F72, #3B8BEB); }

/* ── 4d.  Progress Bar ─────────────────────── */
.progress-bar {
  height: 12rpx;
  background: var(--color-surface);
  border-radius: var(--radius-sm);
  overflow: hidden;
}

.progress-fill {
  height: 100%;
  border-radius: var(--radius-sm);
  background: var(--color-teal);
  transition: width 0.5s ease;
}

.progress-fill.teal   { background: var(--color-teal);  }
.progress-fill.amber  { background: var(--color-amber); }
.progress-fill.blue   { background: var(--color-blue);  }
.progress-fill.red    { background: var(--color-red);   }
.progress-fill.purple { background: var(--color-purple);}

/* ── 4e.  Stars ────────────────────────────── */
.stars { color: var(--color-amber); letter-spacing: 4rpx; font-size: var(--text-base); }

/* ── 4f.  Divider ──────────────────────────── */
.divider { border: none; border-top: 2rpx solid var(--color-border); }

.widget-divider { height: 16px; }

/* ═══════════════════════════════════════════════════════════════════════
   5.  COMPONENTS
   ═══════════════════════════════════════════════════════════════════════ */

/* ── 5a.  Card ─────────────────────────────── */
.card {
  margin: 0 var(--space-8) var(--space-14);
  background: var(--color-card);
  border-radius: var(--radius-xl);
  box-shadow: var(--shadow-sm);
  overflow: hidden;
  margin-bottom: var(--space-8);
}

.card-header {
  padding: var(--space-8) var(--space-10);
  display: flex;
  align-items: center;
  justify-content: space-between;
  border-bottom: 2rpx solid var(--color-border);
}

.card-title {
  font-size: var(--text-lg);
  font-weight: var(--weight-bold);
  color: var(--color-text-main);
}

.card-sub {
  font-size: var(--text-sm);
  color: var(--color-text-sub);
  margin-top: var(--space-2);
}

.card-body {
  padding: var(--space-8) var(--space-10);
}

.card-body-flush { padding: 0; }

/* ── 5b.  Page Header ──────────────────────── */
.page-header {
  padding: var(--space-10) var(--space-10) var(--space-6);
}

.page-header-title {
  font-size: var(--text-4xl);
  font-weight: var(--weight-bold);
  color: var(--color-text-main);
}

.page-header-sub {
  font-size: var(--text-sm);
  color: var(--color-text-sub);
  margin-top: var(--space-2);
}

/* ── 5c.  Stat Card ────────────────────────── */
.stat-card {
  background: var(--color-card);
  border-radius: var(--radius-xl);
  padding: var(--space-8) var(--space-10);
  box-shadow: var(--shadow-sm);
  display: flex;
  flex-direction: column;
  align-items: center;
  text-align: center;
}

.stat-card-icon {
  width: 72rpx;
  height: 72rpx;
  border-radius: var(--radius-lg);
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: var(--text-4xl);
  margin-bottom: var(--space-5);
}

.stat-card-icon.teal  { background: var(--color-teal-dim);  }
.stat-card-icon.amber { background: var(--color-amber-dim); }
.stat-card-icon.blue  { background: var(--color-blue-dim);  }
.stat-card-icon.red   { background: var(--color-red-dim);   }

.stat-card-number {
  font-size: var(--text-7xl);
  font-weight: var(--weight-extrabold);
  color: var(--color-text-main);
  line-height: 1;
}

.stat-card-label {
  font-size: var(--text-xs);
  color: var(--color-text-sub);
  margin-top: var(--space-2);
}

/* ── 5d.  Schedule Item ────────────────────── */
.schedule-item {
  display: flex;
  gap: var(--space-8);
  align-items: flex-start;
  padding: var(--space-8) var(--space-10);
  border-bottom: 2rpx solid var(--color-border);
}

.schedule-item:last-child { border-bottom: none; }

.schedule-dot {
  width: 20rpx;
  height: 20rpx;
  border-radius: var(--radius-full);
  flex-shrink: 0;
  margin-top: 6rpx;
}

.schedule-dot.teal   { background: var(--color-teal);  }
.schedule-dot.amber  { background: var(--color-amber); }
.schedule-dot.blue   { background: var(--color-blue);  }
.schedule-dot.red    { background: var(--color-red);   }
.schedule-dot.purple { background: var(--color-purple);}

.schedule-info { flex: 1; min-width: 0; }

.schedule-title {
  font-size: var(--text-md);
  font-weight: var(--weight-semibold);
  color: var(--color-text-main);
}

.schedule-meta {
  font-size: var(--text-xs);
  color: var(--color-text-sub);
  margin-top: var(--space-2);
}

.schedule-time {
  font-size: var(--text-xs);
  color: var(--color-text-muted);
  white-space: nowrap;
  text-align: right;
}

/* ── 5e.  Message Item ─────────────────────── */
.msg-item {
  display: flex;
  gap: var(--space-7);
  padding: var(--space-8) var(--space-10);
  border-bottom: 2rpx solid var(--color-border);
  position: relative;
}

.msg-item:active { background: #f7fafc; }

.msg-avatar {
  width: 80rpx;
  height: 80rpx;
  border-radius: var(--radius-full);
  flex-shrink: 0;
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: var(--text-3xl);
}

.msg-body { flex: 1; min-width: 0; }

.msg-header {
  display: flex;
  align-items: center;
  justify-content: space-between;
  margin-bottom: var(--space-3);
}

.msg-name {
  font-size: var(--text-md);
  font-weight: var(--weight-semibold);
  color: var(--color-text-main);
}

.msg-time {
  font-size: var(--text-xs);
  color: var(--color-text-muted);
}

.msg-preview {
  font-size: var(--text-sm);
  color: var(--color-text-sub);
  overflow: hidden;
  text-overflow: ellipsis;
  white-space: nowrap;
}

.msg-badge {
  position: absolute;
  top: var(--space-8);
  right: var(--space-10);
  min-width: 32rpx;
  height: 32rpx;
  background: var(--color-red);
  color: #fff;
  font-size: 20rpx;
  font-weight: var(--weight-bold);
  border-radius: 16rpx;
  display: flex;
  align-items: center;
  justify-content: center;
  padding: 0 8rpx;
}

/* ── 5f.  Player/Child Card ────────────────── */
.child-card {
  background: linear-gradient(135deg, var(--color-navy), var(--color-navy-mid));
  border-radius: var(--radius-xl);
  padding: var(--space-10);
  color: #fff;
  margin-bottom: var(--space-8);
}

.child-card-top {
  display: flex;
  align-items: center;
  gap: var(--space-8);
  margin-bottom: var(--space-8);
}

.child-card-avatar {
  width: 100rpx;
  height: 100rpx;
  border-radius: var(--radius-full);
  border: 4rpx solid rgba(255,255,255,0.3);
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: var(--text-4xl);
  font-weight: var(--weight-bold);
  color: #fff;
  background: linear-gradient(135deg, var(--color-teal), var(--color-steel));
  flex-shrink: 0;
}

.child-card-info { flex: 1; }

.child-card-name {
  font-size: var(--text-2xl);
  font-weight: var(--weight-bold);
}

.child-card-meta {
  font-size: var(--text-xs);
  color: rgba(255,255,255,0.7);
  margin-top: var(--space-2);
}

.child-card-stats {
  display: flex;
  gap: 0;
  background: rgba(255,255,255,0.08);
  border-radius: var(--radius-md);
  padding: var(--space-5) 0;
}

.child-stat {
  flex: 1;
  text-align: center;
}

.child-stat-num {
  font-size: var(--text-3xl);
  font-weight: var(--weight-extrabold);
}

.child-stat-label {
  font-size: 20rpx;
  color: rgba(255,255,255,0.6);
  margin-top: var(--space-1);
}

/* ── 5g.  Match Card ───────────────────────── */
.match-card {
  background: var(--color-card);
  border-radius: var(--radius-xl);
  padding: var(--space-10);
  box-shadow: var(--shadow-sm);
  margin-bottom: var(--space-8);
}

.match-card:active { box-shadow: var(--shadow-md); }

.match-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: var(--space-8);
}

.match-league {
  font-size: var(--text-xs);
  color: var(--color-text-muted);
  font-weight: var(--weight-semibold);
}

.match-teams {
  display: flex;
  align-items: center;
  justify-content: center;
  gap: var(--space-8);
  padding: var(--space-5) 0;
}

.match-team {
  flex: 1;
  text-align: center;
}

.match-team-name {
  font-size: var(--text-lg);
  font-weight: var(--weight-bold);
  color: var(--color-text-main);
}

.match-score-box {
  background: var(--color-surface);
  border-radius: var(--radius-md);
  padding: var(--space-4) var(--space-9);
  display: flex;
  align-items: center;
  gap: var(--space-5);
}

.match-score-num {
  font-size: var(--text-6xl);
  font-weight: var(--weight-extrabold);
  color: var(--color-text-main);
}

.match-score-divider {
  font-size: var(--text-2xl);
  color: var(--color-text-muted);
}

.match-footer {
  display: flex;
  gap: var(--space-6);
  margin-top: var(--space-8);
  flex-wrap: wrap;
}

/* ── 5h.  Announcement Card ────────────────── */
.announce-card {
  background: var(--color-card);
  border-left: 6rpx solid var(--color-teal);
  border-radius: var(--radius-md);
  padding: var(--space-8) var(--space-10);
  margin-bottom: var(--space-6);
  box-shadow: var(--shadow-sm);
}

.announce-card.amber { border-left-color: var(--color-amber); }
.announce-card.red   { border-left-color: var(--color-red);   }

.announce-title {
  font-size: var(--text-md);
  font-weight: var(--weight-semibold);
  color: var(--color-text-main);
}

.announce-text {
  font-size: var(--text-sm);
  color: var(--color-text-sub);
  margin-top: var(--space-3);
  line-height: 1.6;
}

.announce-time {
  font-size: var(--text-xs);
  color: var(--color-text-muted);
  margin-top: var(--space-4);
}

/* ═══════════════════════════════════════════════════════════════════════
   6.  FORMS
   ═══════════════════════════════════════════════════════════════════════ */

.form-group {
  display: flex;
  flex-direction: column;
  gap: var(--space-3);
  margin-bottom: var(--space-8);
}

.form-label {
  font-size: var(--text-sm);
  font-weight: var(--weight-semibold);
  color: var(--color-text-sub);
}

.form-input {
  border: 2rpx solid var(--color-border);
  border-radius: var(--radius-md);
  padding: var(--space-5) var(--space-7);
  font-size: var(--text-md);
  color: var(--color-text-main);
  background: var(--color-card);
  width: 100%;
}

.form-input:focus {
  border-color: var(--color-teal);
}

.form-placeholder { color: var(--color-text-muted); }

/* ═══════════════════════════════════════════════════════════════════════
   7.  TABS (Inside page)
   ═══════════════════════════════════════════════════════════════════════ */

.tabs {
  display: flex;
  background: var(--color-card);
  border-bottom: 2rpx solid var(--color-border);
}

.tab-item {
  flex: 1;
  text-align: center;
  padding: var(--space-7) 0;
  font-size: var(--text-md);
  font-weight: var(--weight-medium);
  color: var(--color-text-sub);
  position: relative;
  transition: all var(--transition-base);
}

.tab-item.active {
  color: var(--color-teal);
  font-weight: var(--weight-bold);
}

.tab-item.active::after {
  content: '';
  position: absolute;
  bottom: 0;
  left: 50%;
  transform: translateX(-50%);
  width: 48rpx;
  height: 4rpx;
  background: var(--color-teal);
  border-radius: 2rpx;
}

/* ═══════════════════════════════════════════════════════════════════════
   8.  WEEK CALENDAR STRIP
   ═══════════════════════════════════════════════════════════════════════ */

.week-strip {
  display: flex;
  background: var(--color-card);
  padding: var(--space-4) 0;
}

.week-day {
  flex: 1;
  text-align: center;
  padding: var(--space-5) 0;
  font-size: var(--text-xs);
  color: var(--color-text-muted);
  position: relative;
}

.week-day-num {
  font-size: var(--text-2xl);
  font-weight: var(--weight-bold);
  color: var(--color-text-main);
  display: block;
}

.week-day.active .week-day-num {
  color: #fff;
  background: var(--color-teal);
  width: 56rpx;
  height: 56rpx;
  border-radius: var(--radius-full);
  display: flex;
  align-items: center;
  justify-content: center;
  margin: 0 auto 4rpx;
}

.week-day.has-event::after {
  content: '';
  position: absolute;
  bottom: 2rpx;
  left: 50%;
  transform: translateX(-50%);
  width: 8rpx;
  height: 8rpx;
  border-radius: var(--radius-full);
  background: var(--color-amber);
}

/* ═══════════════════════════════════════════════════════════════════════
   9.  EMPTY STATE
   ═══════════════════════════════════════════════════════════════════════ */

.empty-state {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  padding: 80rpx var(--space-10);
}

.empty-icon {
  font-size: 96rpx;
  margin-bottom: var(--space-8);
  opacity: 0.4;
}

.empty-text {
  font-size: var(--text-md);
  color: var(--color-text-muted);
  text-align: center;
}

/* ═══════════════════════════════════════════════════════════════════════
   10.  COLOR UTILITIES
   ═══════════════════════════════════════════════════════════════════════ */

.color-teal   { color: var(--color-teal);   }
.color-amber  { color: var(--color-amber);  }
.color-blue   { color: var(--color-blue);   }
.color-red    { color: var(--color-red);    }
.color-purple { color: var(--color-purple); }
.color-muted  { color: var(--color-text-muted); }
.color-sub    { color: var(--color-text-sub);   }

/* Text utilities */
.text-xs   { font-size: var(--text-xs);   }
.text-sm   { font-size: var(--text-sm);   }
.text-md   { font-size: var(--text-md);   }
.text-lg   { font-size: var(--text-lg);   }
.text-xl   { font-size: var(--text-xl);   }
.text-bold { font-weight: var(--weight-bold); }
.text-center { text-align: center; }

/* ═══════════════════════════════════════════════════════════════════════
   11.  DISPLAY FORM — 只读表单组件（单列行式布局）
   通用可复用：左侧标签 + 右侧值，每行一字段
   ═══════════════════════════════════════════════════════════════════════ */

/* ── 11a.  Section Dot 分组圆点 ──────────────── */
.section-dot {
  width: 16rpx;
  height: 16rpx;
  border-radius: var(--radius-full);
  background: var(--color-teal);
  flex-shrink: 0;
}
.section-dot-amber  { background: var(--color-amber);  }
.section-dot-purple { background: var(--color-purple); }
.section-dot-blue   { background: var(--color-blue);   }
.section-dot-red    { background: var(--color-red);    }

/* ── 11b.  Display Row 展示行 ────────────────── */
.disp-row {
  display: flex;
  align-items: center;
  padding: var(--space-7) var(--space-10);
  border-bottom: 2rpx solid var(--color-border);
  gap: var(--space-8);
}
.disp-row:active {
  background: #fafbfc;
}
.disp-row-last {
  border-bottom: none;
}
.disp-row-longtext {
  align-items: flex-start;
}

/* ── 11c.  Row Left — 字段标签 ───────────────── */
.disp-row-left {
  width: 160rpx;
  flex-shrink: 0;
}
.disp-label {
  font-size: var(--text-sm);
  font-weight: var(--weight-semibold);
  color: var(--color-text-sub);
  line-height: 1.5;
}
.required-star {
  color: var(--color-red);
  font-size: var(--text-sm);
}

/* ── 11d.  Row Right — 字段值 ────────────────── */
.disp-row-right {
  flex: 1;
  min-width: 0;
  display: flex;
  align-items: center;
  justify-content: flex-end;
  text-align: right;
}
.disp-value {
  font-size: var(--text-md);
  font-weight: var(--weight-medium);
  color: var(--color-text-main);
  line-height: 1.6;
  word-break: break-all;
}
.disp-value-longtext {
  font-size: var(--text-base);
  color: var(--color-text-sub);
  line-height: 1.8;
  text-align: left;
  justify-content: flex-start;
}
.disp-unit {
  font-size: var(--text-xs);
  color: var(--color-text-muted);
  font-weight: var(--weight-normal);
  margin-left: var(--space-2);
}

/* ── 11e.  Readonly Field 只读字段标识 ────────── */
.disp-readonly-badge {
  display: inline-flex;
  align-items: center;
  padding: var(--space-3) var(--space-6);
  border-radius: var(--radius-sm);
  background: linear-gradient(135deg, rgba(59,139,235,0.06), rgba(59,139,235,0.02));
  border: 2rpx solid rgba(59,139,235,0.15);
}
.disp-readonly-badge .disp-value {
  color: var(--color-blue-text);
}

/* ── 11f.  Footer Bar 底部操作栏 ──────────────── */
.footer-bar {
  display: flex;
  gap: var(--space-6);
  padding: var(--space-8) var(--space-8);
  background: var(--color-card);
  border-top: 2rpx solid var(--color-border);
  margin-top: var(--space-4);
}
.footer-bar .btn {
  flex: 1;
}

/* ── 11g.  Page Shell 页面容器 ────────────────── */
.page-shell {
  /* padding: 0 var(--space-8) var(--space-14); */
}

/* ═══════════════════════════════════════════════════════════════════════
   12.  ENTRY FORM — 可编辑表单组件（垂直布局）
   通用可复用：标签在上 · 输入在下 · 呼吸间距
   ═══════════════════════════════════════════════════════════════════════ */

/* ── 12a.  Field 字段容器 ─────────────────────── */
.field {
  padding: var(--space-7) 0;
  border-bottom: 2rpx solid var(--color-border);
}
.field-last {
  border-bottom: none;
  padding-bottom: 0;
}

/* ── 12b.  Field Label 字段标签 ───────────────── */
.field-label {
  display: block;
  font-size: var(--text-sm);
  font-weight: var(--weight-semibold);
  color: var(--color-text-sub);
  margin-bottom: var(--space-4);
}
.field-required .field-label::after {
  content: ' *';
  color: var(--color-red);
}

/* ── 12c.  Field Input 文本输入 ────────────────── */
.field-input {
  width: 100%;
  height: 80rpx;
  padding: 0 var(--space-7);
  font-size: var(--text-md);
  color: var(--color-text-main);
  background: var(--color-surface);
  border: 2rpx solid transparent;
  border-radius: var(--radius-md);
  box-sizing: border-box;
}
.field-input:focus {
  background: var(--color-card);
  border-color: var(--color-teal);
}
.field-input-ro {
  color: var(--color-blue-text);
  background: linear-gradient(135deg, rgba(59,139,235,0.04), rgba(59,139,235,0.01));
  border-color: rgba(59,139,235,0.10);
}

/* ── 12d.  Field Control — picker / select ─────── */
.field-control {
  display: flex;
  align-items: center;
  justify-content: space-between;
  width: 100%;
  height: 80rpx;
  padding: 0 var(--space-7);
  background: var(--color-surface);
  border: 2rpx solid transparent;
  border-radius: var(--radius-md);
  box-sizing: border-box;
}
.field-value {
  font-size: var(--text-md);
  color: var(--color-text-main);
}
.field-placeholder {
  font-size: var(--text-md);
  color: var(--color-text-muted);
}
.field-arrow {
  font-size: var(--text-xs);
  color: var(--color-text-muted);
  margin-left: var(--space-4);
}

/* ── 12e.  Input + 单位后缀 ───────────────────── */
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
  padding: 0 var(--space-7);
  font-size: var(--text-xs);
  font-weight: var(--weight-medium);
  color: var(--color-text-muted);
  background: var(--color-surface);
  border: 2rpx solid var(--color-border);
  border-left: none;
  border-radius: 0 var(--radius-md) var(--radius-md) 0;
  white-space: nowrap;
}
.field-suffix-ro {
  background: linear-gradient(135deg, rgba(59,139,235,0.04), rgba(59,139,235,0.01));
  border-color: rgba(59,139,235,0.10);
}

/* ── 12f.  Textarea ────────────────────────────── */
.field-textarea {
  width: 100%;
  min-height: 160rpx;
  padding: var(--space-5) var(--space-7);
  font-size: var(--text-base);
  color: var(--color-text-main);
  background: var(--color-surface);
  border: 2rpx solid transparent;
  border-radius: var(--radius-md);
  line-height: 1.7;
  box-sizing: border-box;
}
.field-textarea:focus {
  background: var(--color-card);
  border-color: var(--color-teal);
}

/* ── 12g.  Avatar Upload 头像上传 ───────────────── */
.avatar-upload {
  display: flex;
  flex-direction: column;
  align-items: center;
  padding: var(--space-6) 0;
}

/* ── 12h.  Option Chips 多选胶囊 ───────────────── */
.option-chips {
  display: flex;
  flex-wrap: wrap;
  gap: 12rpx;
}
.option-chip {
  display: flex;
  align-items: center;
  gap: 8rpx;
  padding: 12rpx 28rpx;
  font-size: var(--text-sm);
  font-weight: var(--weight-medium);
  color: var(--color-text-sub);
  background: var(--color-surface);
  border: 2rpx solid transparent;
  border-radius: var(--radius-pill);
  transition: all var(--transition-fast);
}
.option-chip:active {
  transform: scale(0.97);
}
.option-chip-on {
  color: #fff;
  background: var(--color-teal);
  border-color: var(--color-teal);
}
.option-chip-check {
  font-size: var(--text-xs);
  font-weight: var(--weight-bold);
}

/* ── 12i.  Upload Cards 上传卡片 ────────────────── */
.upload-row {
  display: flex;
  flex-wrap: wrap;
  gap: var(--space-5);
}
.upload-card {
  width: 144rpx;
  height: 144rpx;
  border-radius: var(--radius-md);
  position: relative;
  overflow: hidden;
  background: var(--color-surface);
}
.upload-card-wide {
  width: 216rpx;
}
.upload-card-img {
  width: 100%;
  height: 100%;
}
.upload-card-video {
  width: 100%;
  height: 100%;
  background: linear-gradient(135deg, var(--color-navy-mid), var(--color-steel));
  display: flex;
  align-items: center;
  justify-content: center;
  color: rgba(255,255,255,0.45);
}
.upload-card-del {
  position: absolute;
  top: 0;
  right: 0;
  width: 44rpx;
  height: 44rpx;
  background: rgba(13,27,42,0.55);
  color: #fff;
  font-size: 20rpx;
  border-radius: 0 var(--radius-md) 0 var(--radius-md);
  display: flex;
  align-items: center;
  justify-content: center;
}
.upload-card-add {
  border: 2rpx dashed var(--color-border);
  background: transparent;
  display: flex;
  align-items: center;
  justify-content: center;
  transition: all var(--transition-fast);
}
.upload-card-add:active {
  border-color: var(--color-teal);
  background: var(--color-teal-dim);
}
.upload-card-plus {
  font-size: 56rpx;
  font-weight: var(--weight-light);
  color: var(--color-text-muted);
  line-height: 1;
}

/* ── 12j.  File List 文件列表 ──────────────────── */
.file-row {
  display: flex;
  align-items: center;
  gap: var(--space-5);
  padding: var(--space-5) var(--space-6);
  background: var(--color-surface);
  border-radius: var(--radius-sm);
  margin-bottom: var(--space-3);
}
.file-row:last-child {
  margin-bottom: 0;
}
.file-row-icon {
  font-size: var(--text-xl);
}
.file-row-name {
  flex: 1;
  font-size: var(--text-sm);
  font-weight: var(--weight-medium);
  color: var(--color-text-main);
  overflow: hidden;
  text-overflow: ellipsis;
  white-space: nowrap;
}
.file-row-del {
  width: 40rpx;
  height: 40rpx;
  border-radius: var(--radius-full);
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: var(--text-xs);
  color: var(--color-text-muted);
  transition: all var(--transition-fast);
}
.file-row-del:active {
  background: var(--color-red-dim);
  color: var(--color-red);
}
.file-add {
  font-size: var(--text-sm);
  font-weight: var(--weight-medium);
  color: var(--color-teal);
  padding: var(--space-3) 0;
}
.file-add:active {
  opacity: 0.7;
}

/* ── 12k.  Tag Add 标签添加 ────────────────────── */
.tag-add {
  border: 2rpx dashed var(--color-border);
  background: transparent;
  color: var(--color-text-sub);
}

.top-fixed {
  position: fixed;
  top: 0;
  left: 0;
  width: 100%;
  z-index: 100;
}

<#include "/$/tile.css.ftl">