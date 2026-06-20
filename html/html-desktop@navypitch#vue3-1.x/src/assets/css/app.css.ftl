/* ═══════════════════════════════════════════════════════════════════════
   ACADEMY PRO — Design System
   青训管理系统 · Complete CSS Tokens & Component Library
   ═══════════════════════════════════════════════════════════════════════ */

/* ─────────────────────────────────────────────────────────────────────
   1.  FOUNDATIONS — CSS Custom Properties / Design Tokens
   ───────────────────────────────────────────────────────────────────── */

:root {
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

  /* Accent — Dim backgrounds (opacity layers) */
  --color-teal-dim:   rgba(0,201,167,0.12);
  --color-amber-dim:  rgba(245,166,35,0.12);
  --color-red-dim:    rgba(231,76,111,0.12);
  --color-blue-dim:   rgba(59,139,235,0.12);
  --color-purple-dim: rgba(155,89,182,0.1);

  /* Accent — Tag text colors (accessible contrast on dim bg) */
  --color-teal-text:  #00a085;
  --color-amber-text: #c8830a;
  --color-red-text:   #c0294f;
  --color-blue-text:  #2a6dc7;
  --color-purple-text:#7d3c98;

  /* Surfaces */
  --color-surface:    #F0F4F8;
  --color-card:       #FFFFFF;

  /* Text */
  --color-text-main:  #1A2B3C;
  --color-text-sub:   #5A7080;
  --color-text-muted: #95AABA;

  /* Borders */
  --color-border:     #E2EAF0;
  --color-border-hover:rgba(255,255,255,0.07);

  /* Sidebar-specific */
  --color-nav-text:       rgba(255,255,255,0.5);
  --color-nav-text-hover: rgba(255,255,255,0.85);
  --color-nav-text-active:#fff;
  --color-nav-bg-hover:   rgba(255,255,255,0.05);
  --color-nav-bg-active:  rgba(0,201,167,0.12);
  --color-sidebar-section:rgba(255,255,255,0.25);
  --color-sidebar-divider:rgba(255,255,255,0.07);
  --color-sidebar-glow:   rgba(0,201,167,0.08);

  /* ── 1b.  Typography ──────────────────────── */

  --font-family-base:   'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
  --font-size-root:     14px;

  /* Type scale */
  --text-xs:   10px;
  --text-sm:   11px;
  --text-base: 12px;
  --text-md:   13px;
  --text-body: 13.5px;
  --text-lg:   14px;
  --text-xl:   15px;
  --text-2xl:  16px;
  --text-3xl:  17px;
  --text-4xl:  18px;
  --text-5xl:  20px;
  --text-6xl:  22px;
  --text-7xl:  28px;

  /* Font weights */
  --weight-light:  300;
  --weight-normal: 400;
  --weight-medium: 500;
  --weight-semibold:600;
  --weight-bold:   700;
  --weight-extrabold:800;

  /* Letter spacing */
  --tracking-tight:  -0.5px;
  --tracking-normal: 0.3px;
  --tracking-wide:   0.6px;
  --tracking-wider:  1px;
  --tracking-widest: 1.2px;

  /* ── 1c.  Spacing Scale ───────────────────── */

  --space-0:   0;
  --space-1:   2px;
  --space-2:   3px;
  --space-3:   4px;
  --space-4:   6px;
  --space-5:   8px;
  --space-6:   10px;
  --space-7:   12px;
  --space-8:   14px;
  --space-9:   16px;
  --space-10:  18px;
  --space-11:  20px;
  --space-12:  22px;
  --space-13:  24px;
  --space-14:  28px;

  /* ── 1d.  Layout ──────────────────────────── */

  --sidebar-w: 240px;
  --header-h:  64px;

  /* ── 1e.  Border Radius ───────────────────── */

  --radius-none:  0;
  --radius-xs:    3px;
  --radius-sm:    6px;
  --radius-md:    8px;
  --radius-lg:    10px;
  --radius-xl:    12px;
  --radius-2xl:   16px;
  --radius-full:  50%;
  --radius-pill:  20px;

  /* ── 1f.  Shadows ─────────────────────────── */

  --shadow-sm:   0 2px 16px rgba(13,27,42,0.08);
  --shadow-md:   0 4px 24px rgba(13,27,42,0.12);
  --shadow-lg:   0 20px 60px rgba(0,0,0,0.2);
  --shadow-glow-teal: 0 4px 12px rgba(0,201,167,0.35);

  /* ── 1g.  Transitions ─────────────────────── */

  --transition-fast:   0.12s ease;
  --transition-base:   0.15s ease;
  --transition-smooth: 0.18s ease;
  --transition-medium: 0.22s ease;
  --transition-slow:   0.5s ease;

  /* ── 1h.  Z-Index Scale ───────────────────── */

  --z-sidebar: 100;
  --z-sticky:  50;
  --z-modal:   500;
}


/* ═══════════════════════════════════════════════════════════════════════
   2.  RESET / GLOBAL BASE
   ═══════════════════════════════════════════════════════════════════════ */

*,
*::before,
*::after {
  box-sizing: border-box;
  margin: 0;
  padding: 0;
}

body {
  font-family: var(--font-family-base);
  font-size: var(--font-size-root);
  background: var(--color-surface);
  color: var(--color-text-main);
  display: flex;
  min-height: 100vh;
  line-height: 1.5;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}

/* Custom scrollbar */
::-webkit-scrollbar {
  width: 5px;
  height: 5px;
}

::-webkit-scrollbar-track {
  background: transparent;
}

::-webkit-scrollbar-thumb {
  background: #cdd8e0;
  border-radius: var(--radius-lg);
}

::-webkit-scrollbar-thumb:hover {
  background: #b0c0cc;
}

#app {
  flex: 1;
  display: flex;
}

.app-shell {
  flex: 1;
  display: flex;
}

/* ═══════════════════════════════════════════════════════════════════════
   3.  LAYOUT SYSTEM
   ═══════════════════════════════════════════════════════════════════════ */

/* ── 3a.  Sidebar ─────────────────────────── */

.sidebar {
  width: var(--sidebar-w);
  background: var(--color-navy);
  min-height: 100vh;
  display: flex;
  flex-direction: column;
  position: fixed;
  top: 0;
  left: 0;
  z-index: var(--z-sidebar);
  overflow: hidden;
}

.sidebar::before {
  content: '';
  position: absolute;
  bottom: 0;
  left: 0;
  right: 0;
  height: 200px;
  background: linear-gradient(to top, var(--color-sidebar-glow), transparent);
  pointer-events: none;
}

/* Sidebar — Logo */
.sidebar-logo {
  padding: var(--space-11) var(--space-11) var(--space-9);
  border-bottom: 1px solid var(--color-sidebar-divider);
  display: flex;
  align-items: center;
  gap: var(--space-7);
}

.logo-icon {
  width: 38px;
  height: 38px;
  background: linear-gradient(135deg, var(--color-teal), var(--color-teal-text));
  border-radius: var(--radius-lg);
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: var(--text-4xl);
  flex-shrink: 0;
  box-shadow: var(--shadow-glow-teal);
}

.logo-text {
  line-height: 1.2;
}

.logo-name {
  font-size: var(--text-xl);
  font-weight: var(--weight-bold);
  color: #fff;
  letter-spacing: var(--tracking-normal);
}

.logo-sub {
  font-size: var(--text-xs);
  color: rgba(255,255,255,0.4);
  text-transform: uppercase;
  letter-spacing: var(--tracking-wider);
}

/* Sidebar — Section label */
.sidebar-section-label {
  padding: var(--space-10) var(--space-11) var(--space-4);
  font-size: var(--text-xs);
  font-weight: var(--weight-semibold);
  color: var(--color-sidebar-section);
  text-transform: uppercase;
  letter-spacing: var(--tracking-widest);
  user-select: none;
}

/* Sidebar — Navigation */
.nav-item {
  display: flex;
  align-items: center;
  gap: var(--space-6);
  padding: 9px var(--space-11);
  cursor: pointer;
  color: var(--color-nav-text);
  transition: all var(--transition-smooth);
  border-radius: var(--radius-none);
  position: relative;
  font-size: var(--text-body);
  font-weight: var(--weight-medium);
  user-select: none;
}

.nav-item:hover {
  color: var(--color-nav-text-hover);
  background: var(--color-nav-bg-hover);
}

.nav-item.active {
  color: var(--color-nav-text-active);
  background: var(--color-nav-bg-active);
}

.nav-item.active::before {
  content: '';
  position: absolute;
  left: 0;
  top: var(--space-3);
  bottom: var(--space-3);
  width: 3px;
  background: var(--color-teal);
  border-radius: 0 var(--radius-xs) var(--radius-xs) 0;
}

.nav-item .nav-icon {
  font-size: var(--text-2xl);
  width: 20px;
  text-align: center;
}

/* Sidebar — Badge */
.nav-badge {
  margin-left: auto;
  background: var(--color-amber);
  color: var(--color-navy);
  font-size: var(--text-xs);
  font-weight: var(--weight-bold);
  padding: 1px var(--space-4);
  border-radius: var(--radius-lg);
  line-height: 16px;
}

.nav-badge.blue {
  background: var(--color-blue);
  color: #fff;
}

/* Sidebar — Footer */
.sidebar-footer {
  margin-top: auto;
  padding: var(--space-9) var(--space-11);
  border-top: 1px solid var(--color-sidebar-divider);
  display: flex;
  align-items: center;
  gap: var(--space-6);
  cursor: pointer;
}

/* ── 3b.  Main Content Area ───────────────── */

.main {
  margin-left: var(--sidebar-w);
  padding-top: var(--header-h);
  flex: 1;
  display: flex;
  flex-direction: column;
  min-height: 100vh;
  width: calc(100% - 240px);
}

/* ── 3c.  Topbar ──────────────────────────── */

.topbar {
  height: var(--header-h);
  background: var(--color-card);
  border-bottom: 1px solid var(--color-border);
  display: flex;
  align-items: center;
  padding: 0 var(--space-14);
  gap: var(--space-9);
  position: fixed;
  top: 0;
  left: var(--sidebar-w);
  right: 0;
  z-index: 50;
}

.topbar-title {
  font-size: var(--text-3xl);
  font-weight: var(--weight-bold);
  color: var(--color-text-main);
  flex: 1;
}

.topbar-actions {
  display: flex;
  align-items: center;
  gap: var(--space-6);
}

/* ── 3d.  Content Area ────────────────────── */

.content {
  padding: var(--space-13) var(--space-14);
  flex: 1;
}

/* ── 3e.  Grid Layouts ────────────────────── */

.stats-grid {
  display: grid;
  grid-template-columns: repeat(4, 1fr);
  gap: var(--space-9);
  margin-bottom: var(--space-13);
}

.two-col {
  display: grid;
  grid-template-columns: 1fr 1fr;
  gap: var(--space-11);
}

.three-col {
  display: grid;
  grid-template-columns: 1fr 1fr 1fr;
  gap: var(--space-9);
}

.col-span-2 {
  grid-column: span 2;
}

.grid-cards {
  display: grid;
  grid-template-columns: repeat(3, 1fr);
  gap: var(--space-9);
}


/* ═══════════════════════════════════════════════════════════════════════
   4.  PRIMITIVES
   ═══════════════════════════════════════════════════════════════════════ */

/* ── 4a.  Buttons ──────────────────────────── */

.btn {
  display: inline-flex;
  align-items: center;
  gap: var(--space-4);
  padding: var(--space-5) var(--space-9);
  border-radius: var(--radius-md);
  font-size: var(--text-md);
  font-weight: var(--weight-semibold);
  cursor: pointer;
  border: none;
  transition: all var(--transition-base);
  white-space: nowrap;
  font-family: inherit;
  line-height: 1.4;
}

.btn:focus-visible {
  outline: 2px solid var(--color-teal);
  outline-offset: 2px;
}

/* Button variants */

.btn-group {
  display: flex;
  align-items: center;
  gap: var(--space-6);
  flex-wrap: wrap;
}

.btn-primary {
  background: var(--color-teal);
  color: #fff;
}

.btn-primary:hover {
  background: var(--color-teal-hover);
  box-shadow: var(--shadow-glow-teal);
}

.btn-default {
  background: var(--color-surface);
  color: var(--color-text-main);
  border: 1px solid var(--color-border);
}

.btn-default:hover {
  background: #e5ecf2;
}

.btn-warning {
  background: var(--color-amber);
  color: var(--color-navy);
}

.btn-warning:hover {
  background: var(--color-amber-hover);
}

.btn-danger {
  background: var(--color-red-dim);
  color: var(--color-red);
  border: 1px solid rgba(231,76,111,0.2);
}

.btn-danger:hover {
  background: var(--color-red);
  color: #fff;
}

/* Button sizes */
.btn-sm {
  padding: 5px 11px;
  font-size: var(--text-base);
}

/* Button — full width */
.btn-block {
  width: 100%;
  justify-content: center;
}

/* ── 4b.  Tags / Badges ────────────────────── */

.tag {
  display: inline-flex;
  align-items: center;
  gap: var(--space-3);
  padding: 3px var(--space-6);
  border-radius: var(--radius-pill);
  font-size: var(--text-sm);
  font-weight: var(--weight-semibold);
  white-space: nowrap;
}

.tag-teal   { background: var(--color-teal-dim);   color: var(--color-teal-text);   }
.tag-amber  { background: var(--color-amber-dim);  color: var(--color-amber-text);  }
.tag-blue   { background: var(--color-blue-dim);   color: var(--color-blue-text);   }
.tag-red    { background: var(--color-red-dim);    color: var(--color-red-text);    }
.tag-purple { background: var(--color-purple-dim); color: var(--color-purple-text); }
.tag-gray   { background: var(--color-surface);    color: var(--color-text-sub);    }

.tag-sm {
  font-size: var(--text-xs);
  padding: 2px var(--space-5);
}

/* ── 4c.  Avatars ──────────────────────────── */

.avatar {
  width: 34px;
  height: 34px;
  border-radius: var(--radius-full);
  font-size: var(--text-base);
  font-weight: var(--weight-bold);
  color: #fff;
  display: flex;
  align-items: center;
  justify-content: center;
  flex-shrink: 0;
  background: linear-gradient(135deg, var(--color-steel), var(--color-teal));
}

.avatar-sm {
  width: 32px;
  height: 32px;
  border-radius: var(--radius-full);
  font-size: var(--text-base);
  color: #fff;
  font-weight: var(--weight-bold);
  display: flex;
  align-items: center;
  justify-content: center;
  flex-shrink: 0;
  background: linear-gradient(135deg, var(--color-steel), var(--color-teal));
}

.avatar-lg {
  width: 60px;
  height: 60px;
  border-radius: var(--radius-full);
  font-size: var(--text-5xl);
  font-weight: var(--weight-extrabold);
  color: #fff;
  display: flex;
  align-items: center;
  justify-content: center;
  flex-shrink: 0;
}

.avatar-xl {
  width: 72px;
  height: 72px;
  border-radius: var(--radius-full);
  font-size: var(--text-6xl);
  font-weight: var(--weight-extrabold);
  color: #fff;
  display: flex;
  align-items: center;
  justify-content: center;
  flex-shrink: 0;
}

/* ── 4d.  Progress Bar ─────────────────────── */

.progress-bar {
  height: 6px;
  background: var(--color-surface);
  border-radius: var(--radius-sm);
  overflow: hidden;
}

.progress-bar-sm {
  height: 4px;
}

.progress-bar-lg {
  height: 10px;
}

.progress-fill {
  height: 100%;
  border-radius: var(--radius-sm);
  background: var(--color-teal);
  transition: width var(--transition-slow);
}

.progress-fill.amber  { background: var(--color-amber);  }
.progress-fill.blue   { background: var(--color-blue);   }
.progress-fill.red    { background: var(--color-red);    }
.progress-fill.purple { background: var(--color-purple); }

/* ── 4e.  Rating Stars ─────────────────────── */

.stars {
  color: var(--color-amber);
  letter-spacing: 2px;
  font-size: var(--text-base);
}

/* ── 4f.  Divider ──────────────────────────── */

.divider {
  border: none;
  border-top: 1px solid var(--color-border);
}

/* ── 4g.  Icons ────────────────────────────── */

.icon-btn {
  width: 36px;
  height: 36px;
  border-radius: var(--radius-md);
  background: var(--color-surface);
  border: 1px solid var(--color-border);
  display: flex;
  align-items: center;
  justify-content: center;
  cursor: pointer;
  color: var(--color-text-sub);
  font-size: var(--text-2xl);
  transition: all var(--transition-base);
  position: relative;
}

.icon-btn:hover {
  background: var(--color-teal-dim);
  border-color: var(--color-teal);
  color: var(--color-teal);
}

.notif-dot {
  position: absolute;
  top: 7px;
  right: 7px;
  width: 7px;
  height: 7px;
  background: var(--color-red);
  border-radius: var(--radius-full);
  border: 2px solid var(--color-card);
}

/* ── 4h.  Search Box ───────────────────────── */

.search-box {
  display: flex;
  align-items: center;
  gap: var(--space-5);
  background: var(--color-surface);
  border: 1px solid var(--color-border);
  border-radius: var(--radius-md);
  padding: 7px var(--space-8);
  color: var(--color-text-sub);
  font-size: var(--text-md);
  cursor: pointer;
  transition: border-color var(--transition-base);
  width: 200px;
}

.search-box:hover {
  border-color: var(--color-teal);
}


/* ═══════════════════════════════════════════════════════════════════════
   5.  COMPONENTS
   ═══════════════════════════════════════════════════════════════════════ */

/* ── 5a.  Page Header ──────────────────────── */

.page-header {
  display: flex;
  align-items: center;
  justify-content: space-between;
  margin-bottom: var(--space-12);
}

.page-header-left h2 {
  font-size: var(--text-5xl);
  font-weight: var(--weight-bold);
  color: var(--color-text-main);
}

.page-header-left p {
  font-size: var(--text-md);
  color: var(--color-text-sub);
  margin-top: var(--space-1);
}

/* ── 5b.  Stat Card ────────────────────────── */

.stat-card {
  background: var(--color-card);
  border: 1px solid var(--color-border);
  border-radius: var(--radius-xl);
  padding: var(--space-11);
  box-shadow: var(--shadow-sm);
  position: relative;
  overflow: hidden;
  transition: transform var(--transition-smooth), box-shadow var(--transition-smooth);
}

.stat-card:hover {
  transform: translateY(-2px);
  box-shadow: var(--shadow-md);
}

/* Decorative circle in corner */
.stat-card::after {
  content: '';
  position: absolute;
  top: 0;
  right: 0;
  width: 80px;
  height: 80px;
  border-radius: var(--radius-full);
  transform: translate(30px, -30px);
  opacity: 0.12;
}

.stat-card.teal::after  { background: var(--color-teal);  }
.stat-card.amber::after { background: var(--color-amber); }
.stat-card.blue::after  { background: var(--color-blue);  }
.stat-card.red::after   { background: var(--color-red);   }

.stat-icon {
  width: 40px;
  height: 40px;
  border-radius: var(--radius-lg);
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: var(--text-4xl);
  margin-bottom: var(--space-7);
}

.stat-icon.teal  { background: var(--color-teal-dim); }
.stat-icon.amber { background: var(--color-amber-dim); }
.stat-icon.blue  { background: var(--color-blue-dim); }
.stat-icon.red   { background: var(--color-red-dim); }

.stat-number {
  font-size: var(--text-7xl);
  font-weight: var(--weight-extrabold);
  color: var(--color-text-main);
  line-height: 1;
  letter-spacing: var(--tracking-tight);
}

.stat-label {
  font-size: var(--text-md);
  color: var(--color-text-sub);
  margin-top: var(--space-3);
}

.stat-delta {
  font-size: var(--text-base);
  font-weight: var(--weight-semibold);
  margin-top: var(--space-5);
  display: flex;
  align-items: center;
  gap: var(--space-2);
}

.stat-delta.up   { color: var(--color-teal);  }
.stat-delta.down { color: var(--color-red);   }

/* ── 5c.  Card ─────────────────────────────── */

.card {
  background: var(--color-card);
  border: 1px solid var(--color-border);
  border-radius: var(--radius-xl);
  box-shadow: var(--shadow-sm);
  overflow: hidden;
}

.card-header {
  padding: var(--space-10) var(--space-11) var(--space-8);
  display: flex;
  align-items: center;
  justify-content: space-between;
  border-bottom: 1px solid var(--color-border);
}

.card-title {
  font-size: var(--text-lg);
  font-weight: var(--weight-bold);
  color: var(--color-text-main);
}

.card-sub {
  font-size: var(--text-base);
  color: var(--color-text-sub);
  margin-top: var(--space-1);
}

.card-body {
  padding: var(--space-9) var(--space-11);
}

.card-actions {
  display: flex;
  justify-content: flex-end;
  gap: var(--space-6);
  margin-top: var(--space-9);
  padding-top: var(--space-9);
  border-top: 1px solid var(--color-border);
}

/* ── 5d.  Table ────────────────────────────── */

.table-wrap {
  overflow-x: auto;
}

table {
  width: 100%;
  border-collapse: collapse;
}

thead tr {
  border-bottom: 1px solid var(--color-border);
}

th {
  text-align: left;
  padding: var(--space-6) var(--space-8);
  font-size: var(--text-sm);
  font-weight: var(--weight-semibold);
  color: var(--color-text-muted);
  text-transform: uppercase;
  letter-spacing: var(--tracking-wide);
  white-space: nowrap;
  background: var(--color-surface);
}

th:first-child {
  /* border-radius: var(--radius-md) 0 0 var(--radius-md); */
}

th:last-child {
  /* border-radius: 0 var(--radius-md) var(--radius-md) 0; */
}

td {
  padding: var(--space-7) var(--space-8);
  font-size: var(--text-body);
  color: var(--color-text-main);
  border-bottom: 1px solid var(--color-border);
  vertical-align: middle;
}

tr:last-child td {
  border-bottom: none;
}

tbody tr:hover td {
  background: #f7fafc;
}

/* ── 5e.  Player Cell ──────────────────────── */

.player-cell {
  display: flex;
  align-items: center;
  gap: var(--space-6);
}

.player-name {
  font-weight: var(--weight-semibold);
  font-size: var(--text-body);
}

.player-meta {
  font-size: var(--text-sm);
  color: var(--color-text-muted);
}

/* ── 5f.  Schedule Item ────────────────────── */

.schedule-item {
  display: flex;
  gap: var(--space-8);
  align-items: flex-start;
  padding: var(--space-8) 0;
  border-bottom: 1px solid var(--color-border);
}

.schedule-item:last-child {
  border-bottom: none;
}

.schedule-time {
  width: 60px;
  text-align: center;
  flex-shrink: 0;
}

.time-main {
  font-size: var(--text-lg);
  font-weight: var(--weight-bold);
  color: var(--color-text-main);
}

.time-sub {
  font-size: var(--text-xs);
  color: var(--color-text-muted);
  margin-top: 1px;
}

.schedule-dot {
  width: 10px;
  height: 10px;
  border-radius: var(--radius-full);
  background: var(--color-teal);
  margin-top: 5px;
  flex-shrink: 0;
  box-shadow: 0 0 0 3px var(--color-teal-dim);
}

.schedule-dot.amber { background: var(--color-amber); box-shadow: 0 0 0 3px var(--color-amber-dim); }
.schedule-dot.blue  { background: var(--color-blue);  box-shadow: 0 0 0 3px var(--color-blue-dim);  }

.schedule-info {
  flex: 1;
}

.schedule-title {
  font-size: var(--text-body);
  font-weight: var(--weight-semibold);
  color: var(--color-text-main);
}

.schedule-meta {
  font-size: var(--text-base);
  color: var(--color-text-sub);
  margin-top: var(--space-2);
}

/* ── 5g.  Match Card ───────────────────────── */

.match-card {
  background: var(--color-card);
  border: 1px solid var(--color-border);
  border-radius: var(--radius-xl);
  padding: var(--space-11);
  display: flex;
  flex-direction: column;
  gap: var(--space-7);
  transition: box-shadow var(--transition-smooth), transform var(--transition-smooth);
  cursor: pointer;
}

.match-card:hover {
  box-shadow: var(--shadow-md);
  transform: translateY(-2px);
}

.match-card--add {
  border: 2px dashed var(--color-border);
  background: transparent;
  box-shadow: none;
  align-items: center;
  justify-content: center;
  min-height: 140px;
}

.match-card--add:hover {
  border-color: var(--color-teal);
}

.match-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.match-competition {
  font-size: var(--text-sm);
  font-weight: var(--weight-semibold);
  color: var(--color-text-muted);
  text-transform: uppercase;
}

.match-teams {
  display: flex;
  align-items: center;
  justify-content: center;
  gap: var(--space-9);
  padding: var(--space-5) 0;
}

.match-team {
  text-align: center;
  flex: 1;
}

.match-team-name {
  font-size: var(--text-xl);
  font-weight: var(--weight-bold);
}

.match-score {
  font-size: var(--text-7xl);
  font-weight: var(--weight-extrabold);
  color: var(--color-text-main);
  background: var(--color-surface);
  border-radius: var(--radius-md);
  padding: var(--space-3) var(--space-9);
  display: flex;
  gap: var(--space-5);
  align-items: center;
}

.score-sep {
  color: var(--color-text-muted);
  font-weight: var(--weight-normal);
}

.match-footer {
  display: flex;
  gap: var(--space-5);
  flex-wrap: wrap;
}

/* ── 5h.  Person Card ──────────────────────── */

.person-card {
  background: var(--color-card);
  border: 1px solid var(--color-border);
  border-radius: var(--radius-xl);
  padding: var(--space-11);
  text-align: center;
  transition: box-shadow var(--transition-smooth), transform var(--transition-smooth);
  cursor: pointer;
}

.person-card:hover {
  box-shadow: var(--shadow-md);
  transform: translateY(-2px);
}

.person-avatar {
  width: 60px;
  height: 60px;
  border-radius: var(--radius-full);
  font-size: var(--text-5xl);
  font-weight: var(--weight-extrabold);
  color: #fff;
  margin: 0 auto var(--space-7);
  display: flex;
  align-items: center;
  justify-content: center;
}

.person-name {
  font-size: var(--text-xl);
  font-weight: var(--weight-bold);
}

.person-role {
  font-size: var(--text-base);
  color: var(--color-text-sub);
  margin-top: var(--space-2);
}

.person-stats {
  display: flex;
  gap: 0;
  margin-top: var(--space-8);
  border-top: 1px solid var(--color-border);
  padding-top: var(--space-8);
}

.p-stat {
  flex: 1;
  text-align: center;
}

.p-stat:not(:last-child) {
  border-right: 1px solid var(--color-border);
}

.p-stat-num {
  font-size: var(--text-2xl);
  font-weight: var(--weight-extrabold);
  color: var(--color-text-main);
}

.p-stat-label {
  font-size: var(--text-xs);
  color: var(--color-text-muted);
  margin-top: var(--space-1);
}

/* ── 5i.  Drill Item ───────────────────────── */

.drill-item {
  display: flex;
  align-items: center;
  gap: var(--space-7);
  padding: var(--space-6) 0;
  border-bottom: 1px solid var(--color-border);
}

.drill-item:last-child {
  border-bottom: none;
}

.drill-num {
  width: 26px;
  height: 26px;
  border-radius: var(--radius-sm);
  background: var(--color-surface);
  font-size: var(--text-sm);
  font-weight: var(--weight-bold);
  color: var(--color-text-sub);
  display: flex;
  align-items: center;
  justify-content: center;
  flex-shrink: 0;
}

.drill-info {
  flex: 1;
}

.drill-name {
  font-size: var(--text-body);
  font-weight: var(--weight-semibold);
}

.drill-meta {
  font-size: var(--text-sm);
  color: var(--color-text-sub);
  margin-top: var(--space-1);
}

/* ── 5j.  Lesson Section ───────────────────── */

.lesson-section {
  border-left: 3px solid var(--color-teal);
  padding-left: var(--space-8);
  margin-bottom: var(--space-10);
}

.lesson-section.amber { border-color: var(--color-amber); }
.lesson-section.blue  { border-color: var(--color-blue);  }
.lesson-section.purple{ border-color: var(--color-purple);}

.lesson-section-title {
  font-size: var(--text-md);
  font-weight: var(--weight-bold);
  color: var(--color-text-main);
}

.lesson-section-time {
  font-size: var(--text-sm);
  color: var(--color-text-sub);
  margin-top: var(--space-1);
}

.lesson-section-desc {
  font-size: var(--text-md);
  color: var(--color-text-sub);
  margin-top: var(--space-4);
  line-height: 1.6;
}

/* ── 5k.  Activity Item ────────────────────── */

.activity-item {
  display: flex;
  gap: var(--space-7);
  align-items: flex-start;
  padding: var(--space-6) 0;
  border-bottom: 1px solid var(--color-border);
}

.activity-item:last-child {
  border-bottom: none;
}

.activity-dot {
  width: 8px;
  height: 8px;
  border-radius: var(--radius-full);
  margin-top: 5px;
  flex-shrink: 0;
}

.activity-text {
  font-size: var(--text-md);
  color: var(--color-text-main);
  line-height: 1.5;
}

.activity-time {
  font-size: var(--text-sm);
  color: var(--color-text-muted);
  margin-top: var(--space-1);
}

/* ── 5l.  Rank Row ─────────────────────────── */

.rank-row {
  display: flex;
  align-items: center;
  gap: var(--space-7);
  padding: var(--space-6) var(--space-8);
  border-radius: var(--radius-md);
  transition: background var(--transition-base);
}

.rank-row:hover {
  background: var(--color-surface);
}

.rank-num {
  font-size: var(--text-md);
  font-weight: var(--weight-extrabold);
  color: var(--color-text-muted);
  width: 20px;
  text-align: center;
}

.rank-num.gold   { color: var(--color-amber);       }
.rank-num.silver { color: var(--color-text-muted);   }
.rank-num.bronze { color: #cd7f32;                   }

.rank-info {
  flex: 1;
}

.rank-name {
  font-size: var(--text-md);
  font-weight: var(--weight-semibold);
}

.rank-sub {
  font-size: var(--text-sm);
  color: var(--color-text-muted);
}

.rank-score {
  font-size: var(--text-lg);
  font-weight: var(--weight-extrabold);
  color: var(--color-text-main);
}

/* ── 5m.  Mini Calendar ────────────────────── */

.cal-grid {
  display: grid;
  grid-template-columns: repeat(7, 1fr);
  gap: var(--space-2);
  text-align: center;
}

.cal-day-header {
  font-size: var(--text-xs);
  font-weight: var(--weight-semibold);
  color: var(--color-text-muted);
  padding: var(--space-3) 0;
  text-transform: uppercase;
}

.cal-day {
  padding: var(--space-4) var(--space-3);
  border-radius: var(--radius-sm);
  font-size: var(--text-base);
  cursor: pointer;
  transition: all var(--transition-fast);
  position: relative;
}

.cal-day:hover {
  background: var(--color-surface);
}

.cal-day.today {
  background: var(--color-teal);
  color: #fff;
  font-weight: var(--weight-bold);
}

.cal-day.has-event::after {
  content: '';
  position: absolute;
  bottom: var(--space-1);
  left: 50%;
  transform: translateX(-50%);
  width: 4px;
  height: 4px;
  border-radius: var(--radius-full);
  background: var(--color-amber);
}

.cal-day.today.has-event::after {
  background: #fff;
}

.cal-day.dimmed {
  color: var(--color-text-muted);
}

/* ── 5n.  Tabs ─────────────────────────────── */

/* ═══════════════════════════════════════════════════════════════════════
   1.  DEFAULT UNDERLINE STYLE
   .tabs + .tab  — 设计系统默认组件
   ═══════════════════════════════════════════════════════════════════════ */

.tabs {
  display: flex;
  align-items: center;
  gap: 0;
  border-bottom: 1px solid var(--color-border);
}

.tabs-nav {
  display: flex;
  gap: 0;
  flex: 1;
}

.tab {
  display: inline-flex;
  align-items: center;
  gap: var(--space-3);
  padding: var(--space-6) var(--space-10);
  font-size: var(--text-md);
  font-weight: var(--weight-medium);
  color: var(--color-text-sub);
  cursor: pointer;
  border-bottom: 2px solid transparent;
  margin-bottom: -1px;
  transition: all var(--transition-base);
  white-space: nowrap;
  user-select: none;
}

.tab:hover {
  color: var(--color-text-main);
}

.tab.active {
  color: var(--color-teal);
  border-bottom-color: var(--color-teal);
  font-weight: var(--weight-bold);
}


/* ═══════════════════════════════════════════════════════════════════════
   1b.  TABS RIGHT ACTIONS
   .tabs-actions  — tabs 右侧按钮区域
   ═══════════════════════════════════════════════════════════════════════ */

.tabs-actions {
  display: flex;
  align-items: center;
  gap: var(--space-5);
  padding-bottom: 2px;
  flex-shrink: 0;
}

/* Button base inside tabs bar — compact, matches tab height */
.tabs-actions .btn-tab {
  display: inline-flex;
  align-items: center;
  gap: 5px;
  padding: 6px 12px;
  font-size: var(--text-base);
  font-weight: var(--weight-semibold);
  border-radius: var(--radius-md);
  cursor: pointer;
  border: none;
  transition: all var(--transition-fast);
  white-space: nowrap;
  font-family: inherit;
  line-height: 1.4;
}

/* Primary action */
.tabs-actions .btn-tab-primary {
  background: var(--color-teal);
  color: #fff;
}
.tabs-actions .btn-tab-primary:hover {
  background: var(--color-teal-hover);
}

/* Secondary action */
.tabs-actions .btn-tab-secondary {
  background: var(--color-surface);
  color: var(--color-text-main);
  border: 1px solid var(--color-border);
}
.tabs-actions .btn-tab-secondary:hover {
  background: #e5ecf2;
}

/* Text-only action (link-like) */
.tabs-actions .btn-tab-text {
  background: transparent;
  color: var(--color-text-sub);
  padding: 6px 8px;
}
.tabs-actions .btn-tab-text:hover {
  color: var(--color-teal);
}

/* Icon-only button */
.tabs-actions .btn-tab-icon {
  width: 32px;
  height: 32px;
  padding: 0;
  background: var(--color-surface);
  border: 1px solid var(--color-border);
  border-radius: var(--radius-md);
  color: var(--color-text-sub);
  font-size: 15px;
  display: inline-flex;
  align-items: center;
  justify-content: center;
  cursor: pointer;
  transition: all var(--transition-fast);
}
.tabs-actions .btn-tab-icon:hover {
  background: var(--color-card);
  border-color: var(--color-teal);
  color: var(--color-teal);
}

/* Danger action */
.tabs-actions .btn-tab-danger {
  background: transparent;
  color: var(--color-red);
  padding: 6px 10px;
}
.tabs-actions .btn-tab-danger:hover {
  background: rgba(231,76,111,0.08);
}

/* Divider between actions */
.tabs-actions .tabs-actions-divider {
  width: 1px;
  height: 20px;
  background: var(--color-border);
  margin: 0 2px;
}


/* ═══════════════════════════════════════════════════════════════════════
   2.  TAB ICON + BADGE
   在 .tab 内部嵌入图标和计数 Badge
   ═══════════════════════════════════════════════════════════════════════ */

.tab-icon-wrap {
  display: flex;
  align-items: center;
  gap: 6px;
}

.tab-icon-emoji {
  font-size: 15px;
}

.tab-badge {
  display: inline-flex;
  align-items: center;
  justify-content: center;
  min-width: 20px;
  height: 18px;
  padding: 0 6px;
  border-radius: 10px;
  font-size: var(--text-xs);
  font-weight: var(--weight-bold);
  margin-left: 4px;
  line-height: 1;
}

.tab-badge.gray  { background: var(--color-border);  color: var(--color-text-sub); }
.tab-badge.amber { background: var(--color-amber);   color: #fff; }
.tab-badge.blue  { background: var(--color-blue);    color: #fff; }
.tab-badge.teal  { background: var(--color-teal);    color: #fff; }
.tab-badge.red   { background: var(--color-red);     color: #fff; }


/* ═══════════════════════════════════════════════════════════════════════
   3.  PILL STYLE
   .tabs-pill + .tab-pill  — 胶囊 / Chrome-style
   ═══════════════════════════════════════════════════════════════════════ */

.tabs-pill {
  display: inline-flex;
  gap: 6px;
  background: #E8EDF2;
  border-radius: var(--radius-lg);
  padding: 4px;
  margin-bottom: var(--space-11);
}

.tab-pill {
  padding: var(--space-5) var(--space-9);
  font-size: var(--text-md);
  font-weight: var(--weight-medium);
  color: var(--color-text-sub);
  cursor: pointer;
  border-radius: var(--radius-md);
  transition: all var(--transition-smooth);
  white-space: nowrap;
  user-select: none;
}

.tab-pill:hover {
  color: var(--color-text-main);
}

.tab-pill.active {
  background: var(--color-card);
  color: var(--color-teal);
  font-weight: var(--weight-bold);
  box-shadow: var(--shadow-sm);
}


/* ═══════════════════════════════════════════════════════════════════════
   4.  CARD / SEGMENTED STYLE
   .tabs-card + .tab-card  — 分段按钮组
   ═══════════════════════════════════════════════════════════════════════ */

.tabs-card {
  display: inline-flex;
  gap: 0;
  margin-bottom: var(--space-11);
}

.tab-card {
  padding: var(--space-5) var(--space-9);
  font-size: var(--text-md);
  font-weight: var(--weight-medium);
  color: var(--color-text-sub);
  cursor: pointer;
  background: var(--color-card);
  border: 1px solid var(--color-border);
  border-right: none;
  transition: all var(--transition-fast);
  white-space: nowrap;
  user-select: none;
}

.tab-card:first-child {
  border-radius: var(--radius-md) 0 0 var(--radius-md);
}

.tab-card:last-child {
  border-radius: 0 var(--radius-md) var(--radius-md) 0;
  border-right: 1px solid var(--color-border);
}

.tab-card:hover {
  background: #f7fafc;
  color: var(--color-text-main);
}

.tab-card.active {
  background: var(--color-teal);
  color: #fff;
  border-color: var(--color-teal);
  font-weight: var(--weight-bold);
}

.tab-card.active + .tab-card {
  border-left: none;
}


/* ═══════════════════════════════════════════════════════════════════════
   5.  VERTICAL LINE STYLE
   .nav-item.active  — 侧边栏竖线导航
   ═══════════════════════════════════════════════════════════════════════ */

.tabs-vertical {
  display: flex;
  flex-direction: column;
  gap: 0;
  background: #0D1B2A;
  border-radius: var(--radius-xl);
  padding: var(--space-5) 0;
  overflow: hidden;
}

.tabs-vertical-label {
  padding: var(--space-8) var(--space-11) var(--space-3);
  font-size: var(--text-xs);
  font-weight: var(--weight-semibold);
  color: rgba(255,255,255,0.25);
  text-transform: uppercase;
  letter-spacing: 1.2px;
  user-select: none;
}

.tab-vertical {
  display: flex;
  align-items: center;
  gap: var(--space-6);
  padding: 9px var(--space-11);
  cursor: pointer;
  color: rgba(255,255,255,0.5);
  transition: all var(--transition-smooth);
  position: relative;
  font-size: 13.5px;
  font-weight: var(--weight-medium);
  user-select: none;
}

.tab-vertical:hover {
  color: rgba(255,255,255,0.85);
  background: rgba(255,255,255,0.05);
}

.tab-vertical.active {
  color: #fff;
  background: rgba(0,201,167,0.12);
}

.tab-vertical.active::before {
  content: '';
  position: absolute;
  left: 0;
  top: 4px;
  bottom: 4px;
  width: 3px;
  background: var(--color-teal);
  border-radius: 0 3px 3px 0;
}


/* ═══════════════════════════════════════════════════════════════════════
   6.  TAB PANEL (content area)
   ═══════════════════════════════════════════════════════════════════════ */

.tab-panel {
  display: none;
  padding: var(--space-11);
  background: var(--color-card);
  border: 1px solid var(--color-border);
  border-top: none;
  border-radius: 0 0 var(--radius-xl) var(--radius-xl);
  font-size: 13.5px;
  color: var(--color-text-main);
  line-height: 1.6;
}

.tab-panel.active {
  display: flex; 
  flex-direction: column; 
  min-height: 500px; 
  overflow: auto;
}

/* Standalone panel (for pill/card variants without border-top dependency) */
.tab-panel-standalone {
  padding: var(--space-11);
  background: var(--color-card);
  border: 1px solid var(--color-border);
  border-radius: var(--radius-xl);
  font-size: 13.5px;
  color: var(--color-text-main);
  line-height: 1.6;
}

.tab-content {
  flex: 1;
  display: flex;
  flex-direction: column;
  gap: var(--space-9);
  min-height: 450px;
}

/* ═══════════════════════════════════════════════════════════════════════
   7.  SIZE UTILITIES
   ═══════════════════════════════════════════════════════════════════════ */

/* Smaller tabs for tight spaces */
.tabs-sm .tab,
.tab-sm {
  padding: 6px 14px;
  font-size: var(--text-base);
}

.tabs-sm .tab-pill,
.tab-pill-sm {
  padding: 5px 14px;
  font-size: var(--text-base);
}

/* Larger tabs for hero / landing sections */
.tabs-lg .tab,
.tab-lg {
  padding: 12px 24px;
  font-size: 15px;
}


/* ── 5o.  Field Canvas (Football Pitch) ────── */

.field-canvas {
  border-radius: var(--radius-xl);
  background: linear-gradient(180deg, #2d8a4e 0%, #257a42 50%, #2d8a4e 100%);
  padding: var(--space-9);
  position: relative;
  overflow: hidden;
}

.field-lines {
  border: 2px solid rgba(255,255,255,0.35);
  border-radius: var(--radius-3xs, 4px);
  height: 140px;
  position: relative;
  display: flex;
  align-items: center;
  justify-content: center;
}

.field-lines::before {
  content: '';
  position: absolute;
  top: 0;
  bottom: 0;
  left: 50%;
  width: 2px;
  background: rgba(255,255,255,0.35);
  transform: translateX(-50%);
}

.field-circle {
  width: 50px;
  height: 50px;
  border-radius: var(--radius-full);
  border: 2px solid rgba(255,255,255,0.35);
}


/* ═══════════════════════════════════════════════════════════════════════
   6.  OVERLAYS
   ═══════════════════════════════════════════════════════════════════════ */

/* ── 6a.  Modal ────────────────────────────── */

.modal-overlay {
  position: fixed;
  inset: 0;
  background: rgba(0,0,0,0.45);
  backdrop-filter: blur(2px);
  z-index: var(--z-modal);
  display: none;
  align-items: center;
  justify-content: center;
}

.modal-overlay.open {
  display: flex;
}

.modal {
  background: var(--color-card);
  border-radius: var(--radius-2xl);
  box-shadow: var(--shadow-lg);
  width: 540px;
  max-height: 85vh;
  overflow-y: auto;
  animation: modalIn var(--transition-medium);
}

@keyframes modalIn {
  from { transform: scale(0.95); opacity: 0; }
  to   { transform: scale(1);    opacity: 1; }
}

.modal-header {
  padding: var(--space-11) var(--space-13) var(--space-9);
  border-bottom: 1px solid var(--color-border);
  display: flex;
  align-items: center;
  justify-content: space-between;
}

.modal-title {
  font-size: var(--text-2xl);
  font-weight: var(--weight-bold);
}

.modal-close {
  width: 30px;
  height: 30px;
  border-radius: var(--radius-md);
  background: var(--color-surface);
  border: none;
  cursor: pointer;
  font-size: var(--text-2xl);
  display: flex;
  align-items: center;
  justify-content: center;
  color: var(--color-text-sub);
  transition: all var(--transition-base);
}

.modal-close:hover {
  background: var(--color-red-dim);
  color: var(--color-red);
}

.modal-body {
  padding: var(--space-11) var(--space-13);
}

.modal-footer {
  padding: var(--space-9) var(--space-13);
  border-top: 1px solid var(--color-border);
  display: flex;
  justify-content: flex-end;
  gap: var(--space-6);
}

/* ── 6b.  Quick-Action Grid (inside modal) ─── */

.quick-action-grid {
  display: grid;
  grid-template-columns: 1fr 1fr;
  gap: var(--space-7);
}

.quick-action-item {
  border: 1px solid var(--color-border);
  border-radius: var(--radius-xl);
  padding: var(--space-10);
  text-align: center;
  cursor: pointer;
  transition: all var(--transition-base);
}

.quick-action-item:hover {
  border-color: var(--color-teal);
}

.quick-action-icon {
  font-size: var(--text-7xl);
  margin-bottom: var(--space-5);
}

.quick-action-label {
  font-weight: var(--weight-bold);
}


/* ═══════════════════════════════════════════════════════════════════════
   7.  FORMS
   ═══════════════════════════════════════════════════════════════════════ */

.form-footer {
  display: flex;
  align-items: center;
  position: fixed;
  bottom: 0;
  left: var(--sidebar-w);
  right: 0;
  z-index: 50;
  background: var(--color-card);
  padding: var(--space-9) var(--space-14);
  border-top: 1px solid var(--color-border);
  gap: var(--space-6);
}

.form-footer--right {
  justify-content: flex-end;
}

.form-row {
  display: grid;
  grid-template-columns: 1fr 1fr;
  gap: var(--space-8);
  margin-bottom: var(--space-8);
}

.form-row-2 { grid-template-columns: 1fr 1fr; }
.form-row-3 { grid-template-columns: 1fr 1fr 1fr; }
.form-row-4 { grid-template-columns: 1fr 1fr 1fr 1fr; }
.form-row-1-2 { grid-template-columns: 1fr 2fr; }

.form-col-span-2 { grid-column: span 2; }
.form-col-span-3 { grid-column: span 3; }
.form-col-span-4 { grid-column: span 4; }

.form-group {
  display: flex;
  flex-direction: column;
  gap: var(--space-4);
}

.form-label {
  font-size: var(--text-base);
  font-weight: var(--weight-semibold);
  color: var(--color-text-sub);
}

.form-input,
select.form-input,
textarea.form-input {
  border: 1px solid var(--color-border);
  border-radius: var(--radius-md);
  padding: var(--space-5) var(--space-7);
  font-size: var(--text-body);
  color: var(--color-text-main);
  background: var(--color-card);
  transition: border-color var(--transition-base), box-shadow var(--transition-base);
  outline: none;
  font-family: inherit;
  width: 100%;
  height: 38.25px;
}

.form-input:focus {
  border-color: var(--color-teal);
  box-shadow: 0 0 0 3px var(--color-teal-dim);
}

.form-input::placeholder {
  color: var(--color-text-muted);
}

select.form-input {
  cursor: pointer;
  appearance: none;
  background-image: url("data:image/svg+xml,%3Csvg width='10' height='6' xmlns='http://www.w3.org/2000/svg'%3E%3Cpath d='M1 1l4 4 4-4' stroke='%2395AABA' stroke-width='1.5' fill='none'/%3E%3C/svg%3E");
  background-repeat: no-repeat;
  background-position: right 12px center;
  padding-right: 32px;
}

textarea.form-input {
  resize: vertical;
  min-height: 100px;
}

.form-input:disabled,
.form-input[readonly] {
  opacity: 0.6;
  cursor: not-allowed;
  background: var(--color-surface);
  color: var(--color-text-sub);
  border-color: var(--color-border);
}

/* ── Input with unit label ────────────────── */

.input-with-unit {
  display: flex;
  align-items: center;
  gap: 0;
}

.input-with-unit .form-input {
  border-radius: var(--radius-md) 0 0 var(--radius-md);
  flex: 1;
  min-width: 0;
}

.input-unit-label {
  display: flex;
  align-items: center;
  padding: var(--space-5) var(--space-7);
  font-size: var(--text-body);
  color: var(--color-text-sub);
  background: var(--color-surface);
  border: 1px solid var(--color-border);
  border-left: none;
  border-radius: 0 var(--radius-md) var(--radius-md) 0;
  white-space: nowrap;
  user-select:
}

/* ── 8b.  Display Field Grid ───────────────────
   <dl class="df-grid df-grid--3">
     <div class="df-field">
       <dt class="df-label">Label</dt>
       <dd class="df-value">Value</dd>
     </div>
   </dl>
   ─────────────────────────────────────────────── */

.df-grid {
  display: grid;
  grid-template-columns: 1fr 1fr;
  gap: var(--space-10) var(--space-13);
}

.df-grid--3 { grid-template-columns: 1fr 1fr 1fr; }
.df-grid--4 { grid-template-columns: 1fr 1fr 1fr 1fr; }
.df-grid--1-2 { grid-template-columns: 1fr 2fr; }

/* ── 8c.  Display Field ──────────────────────── */

.df-field {
  display: flex;
  flex-direction: column;
  gap: var(--space-2);
}

.df-field--span-2 { grid-column: span 2; }
.df-field--span-3 { grid-column: span 3; }
.df-field--span-4 { grid-column: span 4; }

/* ── 8d.  Display Label ──────────────────────── */

.df-label {
  font-size: var(--text-sm);
  font-weight: var(--weight-semibold);
  color: var(--color-text-muted);
  text-transform: uppercase;
  letter-spacing: 0.5px;
  margin: 0;
}

/* ── 8e.  Display Value ──────────────────────── */

.df-value {
  font-size: var(--text-body);
  font-weight: var(--weight-medium);
  color: var(--color-text-main);
  margin: 0;
  min-height: 22px;
  line-height: 1.6;
  word-break: break-word;
}

.df-value--empty {
  color: var(--color-text-muted);
  font-weight: var(--weight-normal);
}

.df-value--highlight {
  font-size: var(--text-2xl);
  font-weight: var(--weight-bold);
  color: var(--color-teal);
}

.df-value--mono {
  font-family: 'SF Mono', 'Cascadia Code', 'Fira Code', monospace;
  font-variant-numeric: tabular-nums;
}

/* ── 8f.  Display Bar (progress row) ─────────── */

.df-bar-list {
  display: flex;
  flex-direction: column;
  gap: var(--space-6);
}

.df-bar {
  display: flex;
  align-items: center;
  gap: var(--space-7);
}

.df-bar__label {
  width: 48px;
  font-size: var(--text-sm);
  color: var(--color-text-sub);
  flex-shrink: 0;
}

.df-bar__num {
  width: 34px;
  text-align: right;
  font-size: var(--text-xs);
  font-weight: var(--weight-bold);
  flex-shrink: 0;
}

.df-bar__num.t  { color: var(--color-teal); }   /* teal */
.df-bar__num.a  { color: var(--color-amber); }  /* amber */
.df-bar__num.b  { color: var(--color-blue); }   /* blue */
.df-bar__num.r  { color: var(--color-red); }    /* red */

/* ── 8g.  Display Section (within a card body) ── */

.df-section + .df-section {
  margin-top: var(--space-12);
  padding-top: var(--space-10);
  border-top: 1px solid var(--color-border);
}

.df-section__title {
  font-size: var(--text-base);
  font-weight: var(--weight-bold);
  color: var(--color-text-main);
  margin-bottom: var(--space-8);
}

/* ═══════════════════════════════════════════════════════════════════════
   8.  TOGGLE SWITCH
   ═══════════════════════════════════════════════════════════════════════ */

.toggle {
  width: 38px;
  height: 22px;
  border-radius: 11px;
  position: relative;
  cursor: pointer;
  transition: background var(--transition-base);
  display: inline-block;
  flex-shrink: 0;
}

.toggle--on {
  background: var(--color-teal);
}

.toggle--off {
  background: var(--color-surface);
  border: 1px solid var(--color-border);
}

.toggle-knob {
  width: 18px;
  height: 18px;
  background: #fff;
  border-radius: var(--radius-full);
  position: absolute;
  top: 1px;
  transition: left var(--transition-base), right var(--transition-base);
}

.toggle--on .toggle-knob {
  right: 2px;
}

.toggle--off .toggle-knob {
  left: 2px;
  border: 1px solid var(--color-border);
}


/* ═══════════════════════════════════════════════════════════════════════
   9.  UTILITY CLASSES
   ═══════════════════════════════════════════════════════════════════════ */

/* ── 9a.  Color Utilities ──────────────────── */

.color-teal   { color: var(--color-teal);   }
.color-amber  { color: var(--color-amber);  }
.color-blue   { color: var(--color-blue);   }
.color-red    { color: var(--color-red);    }
.color-purple { color: var(--color-purple); }
.color-muted  { color: var(--color-text-muted); }
.color-sub    { color: var(--color-text-sub);   }

/* ── 9b.  Font Utilities ──────────────────── */

.text-xs   { font-size: var(--text-xs);   }
.text-sm   { font-size: var(--text-sm);   }
.text-base { font-size: var(--text-base); }
.text-md   { font-size: var(--text-md);   }
.text-body { font-size: var(--text-body); }
.text-lg   { font-size: var(--text-lg);   }
.text-xl   { font-size: var(--text-xl);   }
.text-2xl  { font-size: var(--text-2xl);  }

.text-bold  { font-weight: var(--weight-bold);      }
.text-black { font-weight: var(--weight-extrabold);  }
.text-medium{ font-weight: var(--weight-medium);     }

.text-upper { text-transform: uppercase; }
.text-mono  { font-variant-numeric: tabular-nums; }

/* ── 9c.  Spacing Utilities ────────────────── */

.gap-4    { gap: var(--space-4);  }
.gap-6    { gap: var(--space-6);  }
.gap-8    { gap: var(--space-5);  }
.gap-10   { gap: var(--space-6);  }
.gap-12   { gap: var(--space-7);  }
.gap-14   { gap: var(--space-8);  }
.gap-16   { gap: var(--space-9);  }
.gap-20   { gap: var(--space-11); }

.flex     { display: flex; }
.flex-col { display: flex; flex-direction: column; }
.flex-wrap{ flex-wrap: wrap; }
.flex-1   { flex: 1; }
.items-center { align-items: center; }
.justify-center { justify-content: center; }
.justify-between { justify-content: space-between; }

/* ── 9d.  Page Routing ─────────────────────── */

.page {
  display: none;
}

.page.active {
  display: block;
}


/* ═══════════════════════════════════════════════════════════════════════
   10. RESPONSIVE BREAKPOINTS
   ═══════════════════════════════════════════════════════════════════════ */

/* Tablet & smaller desktops */
@media (max-width: 1100px) {
  .stats-grid  { grid-template-columns: repeat(2, 1fr); }
  .grid-cards  { grid-template-columns: repeat(2, 1fr); }
  .two-col     { grid-template-columns: 1fr; }
  .three-col   { grid-template-columns: 1fr 1fr; }
  .col-span-2  { grid-column: span 1; }
}

/* Mobile */
@media (max-width: 768px) {
  :root {
    --sidebar-w: 0px;
  }

  .sidebar {
    transform: translateX(-100%);
    transition: transform var(--transition-smooth);
  }

  .sidebar.open {
    transform: translateX(0);
  }

  .main {
    margin-left: 0;
  }

  .stats-grid  { grid-template-columns: 1fr; }
  .grid-cards  { grid-template-columns: 1fr; }
  .three-col   { grid-template-columns: 1fr; }
  .form-row    { grid-template-columns: 1fr; }
  .topbar      { padding: 0 var(--space-9); }
  .content     { padding: var(--space-9); }
  .modal       { width: 95vw; margin: var(--space-9); }
  .quick-action-grid { grid-template-columns: 1fr; }
}

/* Mobile sidebar toggle button */
.sidebar-toggle {
  display: none;
}

@media (max-width: 768px) {
  .sidebar-toggle {
    display: flex;
  }
}


/* ═══════════════════════════════════════════════════════════════════════
   11. ANIMATION KEYFRAMES
   ═══════════════════════════════════════════════════════════════════════ */

@keyframes fadeIn {
  from { opacity: 0; }
  to   { opacity: 1; }
}

@keyframes slideUp {
  from { transform: translateY(8px); opacity: 0; }
  to   { transform: translateY(0);   opacity: 1; }
}

@keyframes pulse {
  0%, 100% { opacity: 1; }
  50%      { opacity: 0.5; }
}

.animate-fade-in  { animation: fadeIn var(--transition-smooth); }
.animate-slide-up { animation: slideUp var(--transition-smooth); }

<#include "/$/tile.css.ftl">