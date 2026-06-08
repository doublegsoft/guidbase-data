/**
 * Cura Design System
 * 基于 BNR Design System 架构，适配医疗健康场景
 * ─────────────────────────────────────────────
 * 目录
 *  1. Reset & Base
 *  2. Design Tokens (CSS Variables)
 *  3. Layout — Shell / Main / Sidebar / Content
 *  4. Topbar
 *  5. Breadcrumb
 *  6. Object Header
 *  7. Tabs
 *  8. Panel
 *  9. Field View  (只读字段网格)
 * 10. Form Grid   (编辑表单)
 * 11. Buttons
 * 12. Badge / Tag
 * 13. Table
 * 14. Alert Bar
 * 15. Status Bar
 * 16. Timeline
 * 17. Map Placeholder
 * 18. Tooltip Mark
 * 19. Utility Classes
 * ─────────────────────────────────────────────
 */

/* ══════════════════════════════════════════════
   1. Reset & Base
   ══════════════════════════════════════════════ */
*, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }

html, body {
  height: 100%;
  font-family: var(--${namespace}-font);
  font-size: 12px;
  color: var(--${namespace}-text);
  background: var(--${namespace}-bg-page);
  overflow: hidden;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}

a {
  color: var(--${namespace}-primary);
  text-decoration: none;
}
a:hover { text-decoration: underline; }

img, svg { display: block; max-width: 100%; }

input, button, textarea, select {
  font-family: inherit;
  font-size: inherit;
}

button {
  cursor: pointer;
  border: none;
  background: none;
}

/* Scrollbar — Cura subtle style */
.${namespace}-scrollbar::-webkit-scrollbar,
.${namespace}-scrollbar-y::-webkit-scrollbar {
  width: 4px;
}
.${namespace}-scrollbar::-webkit-scrollbar-thumb,
.${namespace}-scrollbar-y::-webkit-scrollbar-thumb {
  background: var(--${namespace}-primary-mid);
  border-radius: var(--${namespace}-radius-sm);
}

/* ══════════════════════════════════════════════
   2. Design Tokens
   ══════════════════════════════════════════════ */
:root {

  /* -- Primary (Teal) — 关怀与信任 -- */
  --${namespace}-teal-900: #004d42;
  --${namespace}-teal-800: #006b5e;
  --${namespace}-teal-700: #008a78;
  --${namespace}-teal-600: #00a890;
  --${namespace}-teal-500: #00c0a4;
  --${namespace}-teal-400: #40d4bc;
  --${namespace}-teal-300: #80e4d4;
  --${namespace}-teal-200: #b0e4dc;
  --${namespace}-teal-100: #d8f2ec;
  --${namespace}-teal-50:  #e0f5f2;

  /* -- Secondary (Navy) — 权威之锚 -- */
  --${namespace}-navy-900: #061e30;
  --${namespace}-navy-800: #0a3050;
  --${namespace}-navy-700: #0e4070;
  --${namespace}-navy-600: #105090;
  --${namespace}-navy-500: #1868b0;
  --${namespace}-navy-400: #4088d0;
  --${namespace}-navy-300: #80b0e0;
  --${namespace}-navy-200: #b0d0f0;
  --${namespace}-navy-100: #d8e8f8;
  --${namespace}-navy-50:  #e8f0ff;

  /* -- Danger (Crimson) — 紧急信号 -- */
  --${namespace}-red-900:  #8c1606;
  --${namespace}-red-800:  #a81a06;
  --${namespace}-red-700:  #c8200a;
  --${namespace}-red-600:  #e03018;
  --${namespace}-red-500:  #f04830;
  --${namespace}-red-400:  #f87060;
  --${namespace}-red-300:  #f8a098;
  --${namespace}-red-200:  #f0c0c0;
  --${namespace}-red-100:  #ffe8e8;
  --${namespace}-red-50:   #fff0ee;

  /* -- Warning (Amber) — 注意提示 -- */
  --${namespace}-amber-900: #7a4000;
  --${namespace}-amber-800: #a05000;
  --${namespace}-amber-700: #b86000;
  --${namespace}-amber-600: #d07800;
  --${namespace}-amber-500: #e89020;
  --${namespace}-amber-400: #f0b040;
  --${namespace}-amber-300: #e8d080;
  --${namespace}-amber-200: #f0dea0;
  --${namespace}-amber-100: #fff8e0;
  --${namespace}-amber-50:  #fffef8;

  /* -- Success (Sage) — 康复之慰 -- */
  --${namespace}-green-900: #105020;
  --${namespace}-green-800: #1a7a3c;
  --${namespace}-green-700: #209050;
  --${namespace}-green-600: #28a860;
  --${namespace}-green-500: #40c878;
  --${namespace}-green-400: #70d898;
  --${namespace}-green-300: #a8d8b8;
  --${namespace}-green-200: #c8e8d0;
  --${namespace}-green-100: #e8f8ee;
  --${namespace}-green-50:  #f0faf4;

  /* -- Info (Azure) — 数据低语 -- */
  --${namespace}-blue-900:  #0a3060;
  --${namespace}-blue-800:  #1050a0;
  --${namespace}-blue-700:  #1868c0;
  --${namespace}-blue-600:  #2880d8;
  --${namespace}-blue-500:  #5098e8;
  --${namespace}-blue-400:  #80b8f0;
  --${namespace}-blue-300:  #b0c8f0;
  --${namespace}-blue-200:  #d0ddf8;
  --${namespace}-blue-100:  #e8f0ff;
  --${namespace}-blue-50:   #f0f4ff;

  /* -- Purple (Violet) — 静谧专家 -- */
  --${namespace}-purple-900: #301860;
  --${namespace}-purple-800: #5028a0;
  --${namespace}-purple-700: #6030a0;
  --${namespace}-purple-600: #7848c0;
  --${namespace}-purple-500: #9870d8;
  --${namespace}-purple-400: #b898e8;
  --${namespace}-purple-300: #d0b8f0;
  --${namespace}-purple-200: #e0d0f8;
  --${namespace}-purple-100: #f0eaff;
  --${namespace}-purple-50:  #f8f4ff;

  /* -- Neutral — 表面与结构 -- */
  --${namespace}-white:      #ffffff;
  --${namespace}-gray-50:    #f7faf9;
  --${namespace}-gray-75:    #f4f9f7;
  --${namespace}-gray-100:   #f0f4f2;
  --${namespace}-gray-150:   #e8f4f0;
  --${namespace}-gray-200:   #d8e8e4;
  --${namespace}-gray-300:   #c0d4cc;
  --${namespace}-gray-400:   #a0b4a8;
  --${namespace}-gray-500:   #809888;
  --${namespace}-gray-600:   #6a8078;
  --${namespace}-gray-700:   #3a5048;
  --${namespace}-gray-800:   #1a2820;
  --${namespace}-gray-900:   #0a1410;

  /* ── Semantic Aliases ── */
  --${namespace}-primary:          var(--${namespace}-teal-800);
  --${namespace}-primary-dark:     var(--${namespace}-teal-900);
  --${namespace}-primary-bg:       var(--${namespace}-teal-50);
  --${namespace}-primary-border:   var(--${namespace}-teal-200);
  --${namespace}-primary-hover:    var(--${namespace}-teal-100);
  --${namespace}-primary-mid:      var(--${namespace}-teal-200);

  --${namespace}-secondary:        var(--${namespace}-navy-800);
  --${namespace}-secondary-dark:   var(--${namespace}-navy-900);
  --${namespace}-secondary-bg:     var(--${namespace}-navy-50);
  --${namespace}-secondary-border: var(--${namespace}-navy-200);

  --${namespace}-success:          var(--${namespace}-green-800);
  --${namespace}-success-dark:     var(--${namespace}-green-900);
  --${namespace}-success-bg:       var(--${namespace}-green-100);
  --${namespace}-success-border:   var(--${namespace}-green-300);

  --${namespace}-danger:           var(--${namespace}-red-700);
  --${namespace}-danger-dark:      var(--${namespace}-red-900);
  --${namespace}-danger-bg:        var(--${namespace}-red-50);
  --${namespace}-danger-border:    var(--${namespace}-red-200);

  --${namespace}-warning:          var(--${namespace}-amber-700);
  --${namespace}-warning-dark:     var(--${namespace}-amber-900);
  --${namespace}-warning-bg:       var(--${namespace}-amber-100);
  --${namespace}-warning-border:   var(--${namespace}-amber-300);

  --${namespace}-info:             var(--${namespace}-blue-800);
  --${namespace}-info-bg:          var(--${namespace}-blue-100);
  --${namespace}-info-border:      var(--${namespace}-blue-300);

  --${namespace}-purple:           var(--${namespace}-purple-700);
  --${namespace}-purple-bg:        var(--${namespace}-purple-100);
  --${namespace}-purple-border:    var(--${namespace}-purple-300);

  /* -- Neutral text -- */
  --${namespace}-text:             var(--${namespace}-gray-800);
  --${namespace}-text-muted:       var(--${namespace}-gray-700);
  --${namespace}-text-light:       var(--${namespace}-gray-600);
  --${namespace}-text-disabled:    var(--${namespace}-gray-400);
  --${namespace}-text-inverse:     var(--${namespace}-white);

  /* -- Neutral surface -- */
  --${namespace}-border:           var(--${namespace}-gray-300);
  --${namespace}-border-light:     var(--${namespace}-gray-200);
  --${namespace}-bg:               var(--${namespace}-white);
  --${namespace}-bg-page:          var(--${namespace}-gray-100);
  --${namespace}-bg-surface:       var(--${namespace}-gray-50);
  --${namespace}-bg-hover:         var(--${namespace}-gray-150);
  --${namespace}-bg-row-alt:       var(--${namespace}-gray-75);
  --${namespace}-bg-selection:     #d0f0e8;

  /* -- Accent -- */
  --${namespace}-gold:             #ffd700;
  --${namespace}-gold-dark:        #DAA520;
  --${namespace}-accent-glow:      #80ffe8;

  /* -- Typography -- */
  --${namespace}-font:   "Noto Sans SC", "Microsoft YaHei", "微软雅黑", -apple-system, BlinkMacSystemFont, "Segoe UI", sans-serif;
  --${namespace}-mono:   "SF Mono", "Cascadia Code", "Fira Code", Consolas, "Courier New", monospace;

  /* -- Spacing -- */
  --${namespace}-sp-xs:  4px;
  --${namespace}-sp-sm:  6px;
  --${namespace}-sp-md:  8px;
  --${namespace}-sp-lg:  14px;

  /* -- Radius -- */
  --${namespace}-radius-sm: 2px;
  --${namespace}-radius-md: 4px;
  --${namespace}-radius-lg: 6px;
  --${namespace}-radius-xl: 8px;
  --${namespace}-radius-full: 9999px;

  /* -- Shadow -- */
  --${namespace}-shadow-inset: inset 0 1px 2px rgba(0,80,60,0.06);
  --${namespace}-shadow-sm:    0 1px 4px rgba(0,80,60,0.06);
  --${namespace}-shadow-md:    0 4px 12px rgba(0,80,60,0.08);
  --${namespace}-shadow-lg:    0 8px 40px rgba(0,80,60,0.12);
  --${namespace}-shadow-xl:    0 8px 40px rgba(0,0,0,0.24);

  /* -- Z-Index -- */
  --${namespace}-z-base:     0;
  --${namespace}-z-dropdown: 100;
  --${namespace}-z-sticky:   200;
  --${namespace}-z-overlay:  500;
  --${namespace}-z-modal:    600;
  --${namespace}-z-toast:    700;

  /* -- Transition -- */
  --${namespace}-transition-fast:   120ms ease;
  --${namespace}-transition-normal: 200ms ease;
  --${namespace}-transition-slow:   300ms ease;

  /* ── Short aliases (bnrlike-compatible) ── */
  --${namespace}-p:   var(--${namespace}-teal-800);
  --${namespace}-pd:  var(--${namespace}-teal-900);
  --${namespace}-ph:  var(--${namespace}-teal-100);
  --${namespace}-pb:  var(--${namespace}-teal-50);
  --${namespace}-pbd: var(--${namespace}-teal-200);
  --${namespace}-bl:  var(--${namespace}-gray-200);
  --${namespace}-bd:  var(--${namespace}-gray-300);
  --${namespace}-t:   var(--${namespace}-gray-800);
  --${namespace}-tm:  var(--${namespace}-gray-700);
  --${namespace}-tl:  var(--${namespace}-gray-600);
  --${namespace}-rb:  var(--${namespace}-red-50);
  --${namespace}-ob:  var(--${namespace}-amber-100);
}

/* ══════════════════════════════════════════════
   3. Layout
   ══════════════════════════════════════════════ */

/* Shell — full-viewport column flex container */
.${namespace}-shell {
  display: flex;
  flex-direction: column;
  height: 100vh;
}

/* Main — horizontal flex row below topbar */
.${namespace}-main {
  display: flex;
  flex: 1;
  overflow: hidden;
}

/* Sidebar */
.${namespace}-sidebar {
  width: 210px;
  background: var(--${namespace}-bg-surface);
  border-right: 1px solid var(--${namespace}-border);
  overflow-y: auto;
  flex-shrink: 0;
  display: flex;
  flex-direction: column;
}

.${namespace}-toolbar {
  flex-shrink: 0;
  display: flex;
  align-items: center;
  gap: 8px;
  padding: 8px 14px;
  background: var(--${namespace}-bg);
  border-bottom: 1px solid #d9d9d9;
}

.${namespace}-toolbar > .${namespace}-input,
.${namespace}-toolbar > .${namespace}-select {
  flex: 0 0 140px;
  min-width: 100px;
}

.${namespace}-nav-section {
  font-size: 10px;
  font-weight: bold;
  color: var(--${namespace}-text-light);
  text-transform: uppercase;
  letter-spacing: .06em;
  padding: 7px 10px 2px;
  background: var(--${namespace}-bg-page);
}

.${namespace}-nav-item {
  padding: 6px 8px 6px 16px;
  font-size: 12px;
  cursor: pointer;
  border-bottom: 1px solid #f5f5f5;
  color: #444;
  display: flex;
  align-items: center;
  justify-content: space-between;
}
.${namespace}-nav-item:hover { background: var(--${namespace}-primary-bg); color: var(--${namespace}-primary); }
.${namespace}-nav-item.${namespace}-active {
  background: var(--${namespace}-primary-hover);
  color: var(--${namespace}-primary);
  font-weight: bold;
  border-left: 3px solid var(--${namespace}-primary);
  padding-left: 13px;
}

/* Content area */
.${namespace}-content {
  flex: 1;
  overflow: hidden;
  display: flex;
  flex-direction: column;
}

/* Page scroll area */
.${namespace}-page {
  flex: 1;
  overflow: hidden;
  display: flex;
  flex-direction: column;
  background: var(--${namespace}-bg-page);
}
.${namespace}-page.${namespace}-hidden { display: none; }

.${namespace}-page-inner {
  padding: var(--${namespace}-sp-md);
  display: flex;
  flex-direction: column;
  gap: 7px;
}

/* ══════════════════════════════════════════════
   4. Topbar
   ══════════════════════════════════════════════ */
.${namespace}-topbar {
  background: linear-gradient(90deg, var(--${namespace}-navy-800) 0%, var(--${namespace}-navy-700) 50%, #104870 100%);
  color: #fff;
  height: 44px;
  display: flex;
  align-items: center;
  padding: 0 var(--${namespace}-sp-lg);
  flex-shrink: 0;
  border-bottom: 2px solid var(--${namespace}-teal-600);
}

.${namespace}-logo {
  font-size: 14px;
  font-weight: bold;
  letter-spacing: 1px;
  padding-right: 14px;
  border-right: 1px solid rgba(255,255,255,.25);
  margin-right: 12px;
  white-space: nowrap;
  flex-shrink: 0;
}
.${namespace}-logo em { color: var(--${namespace}-accent-glow); font-style: normal; }

/* Top navigation item */
.${namespace}-tnav {
  padding: 0 10px;
  height: 44px;
  display: flex;
  align-items: center;
  font-size: 12px;
  cursor: pointer;
  color: rgba(255,255,255,.85);
  border-bottom: 2px solid transparent;
  white-space: nowrap;
}
.${namespace}-tnav:hover { background: rgba(255,255,255,.1); }
.${namespace}-tnav.${namespace}-active {
  background: rgba(255,255,255,.15);
  border-bottom-color: var(--${namespace}-accent-glow);
}

/* Topbar right slot */
.${namespace}-topbar-right {
  margin-left: auto;
  display: flex;
  align-items: center;
  gap: 12px;
  font-size: 11px;
  color: rgba(255,255,255,.8);
  flex-shrink: 0;
}
.${namespace}-topbar-right span { cursor: pointer; }
.${namespace}-topbar-right span:hover { color: #fff; }

/* Clock / monospace chip in topbar */
.${namespace}-clock {
  background: rgba(0,0,0,.2);
  padding: 2px 8px;
  font-family: var(--${namespace}-mono);
  letter-spacing: .5px;
}

/* ══════════════════════════════════════════════
   5. Breadcrumb
   ══════════════════════════════════════════════ */
.${namespace}-breadcrumb {
  background: var(--${namespace}-bg);
  padding: 0 var(--${namespace}-sp-lg);
  height: 28px;
  display: flex;
  align-items: center;
  gap: 5px;
  font-size: 12px;
  color: var(--${namespace}-text-light);
  border-bottom: 1px solid var(--${namespace}-border-light);
  flex-shrink: 0;
}
.${namespace}-breadcrumb a { color: var(--${namespace}-primary); cursor: pointer; }
.${namespace}-breadcrumb a:hover { text-decoration: underline; }

/* ── 记录导航 (上一条 / 下一条) ── */
.${namespace}-record-nav {
  margin-left: auto;
  display: flex;
  align-items: center;
  gap: 0;
  flex-shrink: 0;
}

.${namespace}-rn-btn {
  display: inline-flex;
  align-items: center;
  gap: 3px;
  height: 22px;
  padding: 0 8px;
  border: 1px solid var(--${namespace}-border-light);
  background: var(--${namespace}-bg);
  color: var(--${namespace}-text-muted);
  font-size: 11px;
  font-family: var(--${namespace}-font);
  cursor: pointer;
  white-space: nowrap;
  transition: all 0.18s ease;
}

.${namespace}-rn-btn:first-of-type {
  border-radius: var(--${namespace}-radius-sm) 0 0 var(--${namespace}-radius-sm);
}

.${namespace}-rn-btn:last-of-type {
  border-radius: 0 var(--${namespace}-radius-sm) var(--${namespace}-radius-sm) 0;
}

.${namespace}-rn-btn:hover:not(:disabled) {
  color: var(--${namespace}-primary);
  background: var(--${namespace}-primary-bg);
  border-color: var(--${namespace}-primary-border);
  z-index: 1;
}

.${namespace}-rn-btn:active:not(:disabled) {
  background: var(--${namespace}-primary-hover);
}

.${namespace}-rn-btn:disabled {
  opacity: 0.35;
  cursor: not-allowed;
  background: #fafbfc;
}

.${namespace}-rn-arrow {
  font-size: 9px;
  transition: transform 0.18s ease;
  opacity: 0.65;
}

.${namespace}-rn-btn:hover:not(:disabled) .${namespace}-rn-arrow {
  opacity: 1;
}

.${namespace}-rn-arrow--left  { margin-right: 1px; }
.${namespace}-rn-arrow--right { margin-left: 1px; }

.${namespace}-rn-btn:hover:not(:disabled) .${namespace}-rn-arrow--left  { transform: translateX(-1.5px); }
.${namespace}-rn-btn:hover:not(:disabled) .${namespace}-rn-arrow--right { transform: translateX(1.5px); }

.${namespace}-rn-idx {
  display: flex;
  align-items: center;
  justify-content: center;
  height: 22px;
  min-width: 40px;
  padding: 0 6px;
  font-size: 11px;
  font-family: var(--${namespace}-mono);
  color: var(--${namespace}-text-muted);
  background: #fafbfc;
  border-top: 1px solid var(--${namespace}-border-light);
  border-bottom: 1px solid var(--${namespace}-border-light);
  user-select: none;
}

/* ══════════════════════════════════════════════
   6. Object Header
   ══════════════════════════════════════════════ */
.${namespace}-obj-head {
  background: linear-gradient(180deg, var(--${namespace}-primary-bg) 0%, var(--${namespace}-teal-100) 100%);
  border-bottom: 1px solid var(--${namespace}-primary-border);
  padding: 8px var(--${namespace}-sp-lg);
  display: flex;
  align-items: center;
  gap: 14px;
  flex-shrink: 0;
}

.${namespace}-obj-icon {
  width: 38px;
  height: 38px;
  border-radius: var(--${namespace}-radius-md);
  background: var(--${namespace}-primary);
  color: var(--${namespace}-accent-glow);
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 18px;
  font-weight: bold;
  flex-shrink: 0;
  border: 1px solid var(--${namespace}-primary-dark);
}

.${namespace}-obj-title {
  font-size: 16px;
  font-weight: bold;
  color: var(--${namespace}-primary);
  letter-spacing: .5px;
}
.${namespace}-obj-id {
  font-family: var(--${namespace}-mono);
  font-size: 13px;
  color: var(--${namespace}-primary-dark);
  font-weight: bold;
  margin-top: 2px;
}
.${namespace}-obj-meta {
  font-size: 11px;
  color: var(--${namespace}-text-muted);
  margin-top: 2px;
  display: flex;
  gap: 10px;
  flex-wrap: wrap;
}
.${namespace}-obj-meta span { display: flex; align-items: center; gap: 3px; }

.${namespace}-obj-status {
  margin-left: auto;
  display: flex;
  flex-direction: column;
  align-items: flex-end;
  gap: 5px;
  flex-shrink: 0;
}
.${namespace}-obj-actions { display: flex; gap: 5px; align-items: center; }

/* Status chips */
.${namespace}-status-chip {
  padding: 3px 12px;
  font-size: 12px;
  font-weight: bold;
  border: 1px solid;
  border-radius: var(--${namespace}-radius-sm);
  text-align: center;
  min-width: 64px;
}
.${namespace}-status-active   { background: var(--${namespace}-success-bg);  color: var(--${namespace}-success);  border-color: var(--${namespace}-success-border); }
.${namespace}-status-inactive { background: #f5f5f5; color: #888; border-color: #ccc; }
.${namespace}-status-pending  { background: var(--${namespace}-warning-bg);  color: var(--${namespace}-warning);  border-color: var(--${namespace}-warning-border); }
.${namespace}-status-critical { background: var(--${namespace}-danger-bg);   color: var(--${namespace}-danger);   border-color: var(--${namespace}-danger-border);  }
.${namespace}-status-draft    { background: var(--${namespace}-amber-100);   color: #a06000;                      border-color: #e0c060; }

/* ══════════════════════════════════════════════
   7. Tabs
   ══════════════════════════════════════════════ */
.${namespace}-tabs {
  display: flex;
  background: var(--${namespace}-navy-800);
  flex-shrink: 0;
}
.${namespace}-tab {
  padding: 6px 14px;
  font-size: 12px;
  cursor: pointer;
  color: rgba(255,255,255,.6);
  border-bottom: 2px solid transparent;
  display: flex;
  align-items: center;
  gap: 4px;
  white-space: nowrap;
  transition: color var(--${namespace}-transition-fast),
              background var(--${namespace}-transition-fast),
              border-color var(--${namespace}-transition-fast);
}
.${namespace}-tab:hover { color: #fff; background: rgba(255,255,255,.07); }
.${namespace}-tab.${namespace}-active {
  color: #fff;
  border-bottom-color: var(--${namespace}-accent-glow);
  background: rgba(255,255,255,.07);
}

/* Badge inside tab (count pill) */
.${namespace}-tab-badge {
  background: rgba(255,120,80,.85);
  color: #fff;
  font-size: 10px;
  padding: 0 4px;
  border-radius: 8px;
  margin-left: 2px;
}
.${namespace}-tab-badge--success { background: rgba(80,200,120,.85); }
.${namespace}-tab.${namespace}-active .${namespace}-tab-badge { background: rgba(255,255,255,.3); }

/* Right-aligned slot in tabs row */
.${namespace}-tabs-right {
  margin-left: auto;
  padding: 4px 10px;
  display: flex;
  gap: 5px;
  align-items: center;
  flex-shrink: 0;
}

.${namespace}-tabs-content {
  flex: 1;
  overflow: hidden;
  display: flex;
  flex-direction: column;
}

.${namespace}-tabs-content > div {
  flex: 1;
  overflow-y: auto;
  min-height: 0;
}

/* ══════════════════════════════════════════════
   8. Panel
   ══════════════════════════════════════════════ */
.${namespace}-panel {
  background: var(--${namespace}-bg);
  border: 1px solid #d9d9d9;
}

/* Panel header */
.${namespace}-panel-head {
  background: var(--${namespace}-primary-bg);
  color: var(--${namespace}-primary);
  padding: 5px 10px;
  font-size: 12px;
  font-weight: bold;
  border-bottom: 1px solid var(--${namespace}-primary-border);
  display: flex;
  align-items: center;
  gap: 5px;
}
/* Left accent bar via pseudo-element */
.${namespace}-panel-head::before {
  content: '';
  width: 3px;
  height: 12px;
  background: var(--${namespace}-primary);
  display: inline-block;
  flex-shrink: 0;
}

/* Color variants */
.${namespace}-panel-head--warning {
  background: var(--${namespace}-warning-bg);
  color: var(--${namespace}-warning);
  border-bottom-color: var(--${namespace}-warning-border);
}
.${namespace}-panel-head--warning::before { background: var(--${namespace}-warning); }

.${namespace}-panel-head--success {
  background: var(--${namespace}-success-bg);
  color: var(--${namespace}-success);
  border-bottom-color: var(--${namespace}-success-border);
}
.${namespace}-panel-head--success::before { background: var(--${namespace}-success); }

.${namespace}-panel-head--danger {
  background: var(--${namespace}-danger-bg);
  color: var(--${namespace}-danger);
  border-bottom-color: var(--${namespace}-danger-border);
}
.${namespace}-panel-head--danger::before { background: var(--${namespace}-danger); }

/* Right-aligned actions slot inside panel header */
.${namespace}-panel-head-right {
  margin-left: auto;
  display: flex;
  gap: 4px;
  align-items: center;
  font-weight: normal;
}

/* ══════════════════════════════════════════════
   9. Field View  (只读字段网格)
   ══════════════════════════════════════════════ */
.${namespace}-fview {
  display: grid;
  grid-template-columns: repeat(4, 1fr);
  gap: 0;
  border-top: 1px solid var(--${namespace}-border-light);
}
.${namespace}-fview--2 { grid-template-columns: repeat(2, 1fr); }
.${namespace}-fview--3 { grid-template-columns: repeat(3, 1fr); }
.${namespace}-fview--6 { grid-template-columns: repeat(6, 1fr); }

.${namespace}-fv {
  display: flex;
  border-bottom: 1px solid var(--${namespace}-border-light);
  border-right:  1px solid var(--${namespace}-border-light);
  min-height: 30px;
}
/* Remove right border on last column of each row */
.${namespace}-fview    > .${namespace}-fv:nth-child(4n) { border-right: none; }
.${namespace}-fview--2 > .${namespace}-fv:nth-child(2n) { border-right: none; }
.${namespace}-fview--3 > .${namespace}-fv:nth-child(3n) { border-right: none; }
.${namespace}-fview--6 > .${namespace}-fv:nth-child(6n) { border-right: none; }

/* Column span helpers */
.${namespace}-fv--span2 { grid-column: span 2; }
.${namespace}-fv--span3 { grid-column: span 3; }
.${namespace}-fv--span4 { grid-column: span 4; border-right: none; }

.${namespace}-fv-label {
  width: 90px;
  flex-shrink: 0;
  background: var(--${namespace}-primary-bg);
  color: var(--${namespace}-text-muted);
  font-size: 11px;
  padding: 5px 8px;
  border-right: 1px solid var(--${namespace}-primary-border);
  display: flex;
  align-items: center;
  line-height: 1.4;
}
.${namespace}-fv-val {
  flex: 1;
  padding: 5px 8px;
  font-size: 12px;
  color: var(--${namespace}-text);
  display: flex;
  align-items: center;
  min-width: 0;
  word-break: break-all;
  line-height: 1.4;
}
.${namespace}-fv-val--mono    { font-family: var(--${namespace}-mono); }
.${namespace}-fv-val--bold    { font-weight: bold; color: var(--${namespace}-primary); }
.${namespace}-fv-val--success { color: var(--${namespace}-success); font-weight: bold; }
.${namespace}-fv-val--danger  { color: var(--${namespace}-danger);  font-weight: bold; }
.${namespace}-fv-val--link    { color: var(--${namespace}-primary); cursor: pointer; text-decoration: underline; }

/* ══════════════════════════════════════════════
   10. Form Grid  (编辑表单)
   ══════════════════════════════════════════════ */
.${namespace}-form {
  display: grid;
  grid-template-columns: repeat(4, 1fr);
  gap: 4px 8px;
  padding: 7px 10px;
  flex-shrink: 0;
}
.${namespace}-form--2 { grid-template-columns: repeat(2, 1fr); }
.${namespace}-form--3 { grid-template-columns: repeat(3, 1fr); }

/* Field row */
.${namespace}-field {
  display: flex;
  align-items: center;
  gap: 4px;
  font-size: 12px;
  min-width: 0;
}

/* Column span helpers */
.${namespace}-field--span2 { grid-column: span 2; }
.${namespace}-field--span3 { grid-column: span 3; }
.${namespace}-field--span4 { grid-column: span 4; }

/* Label */
.${namespace}-field-label {
  width: 80px;
  color: var(--${namespace}-text-muted);
  flex-shrink: 0;
  white-space: nowrap;
}
.${namespace}-field-label--w1 { width: 92px; }
.${namespace}-field-label--w2 { width: 108px; }

/* Required marker */
.${namespace}-field-label--required::before { content: "* "; color: var(--${namespace}-danger); }

/* Inputs */
.${namespace}-input,
.${namespace}-select,
.${namespace}-textarea {
  flex: 1;
  height: 22px;
  border: 1px solid var(--${namespace}-border);
  font-size: 12px;
  font-family: var(--${namespace}-font);
  padding: 0 5px;
  background: var(--${namespace}-bg);
  color: var(--${namespace}-text);
  outline: none;
  min-width: 80px;
  transition: border-color var(--${namespace}-transition-fast);
}
.${namespace}-input:focus,
.${namespace}-select:focus,
.${namespace}-textarea:focus  { border-color: var(--${namespace}-primary); box-shadow: 0 0 0 2px rgba(0,107,94,.08); }

.${namespace}-input--readonly { background: #f5f7fa; color: var(--${namespace}-text-muted); }
.${namespace}-input--mono     { font-family: var(--${namespace}-mono); }
.${namespace}-input--error,
.${namespace}-select--error   { border-color: var(--${namespace}-danger) !important; background: var(--${namespace}-danger-bg); }

.${namespace}-field-unit {
  font-size: 10px;
  color: var(--${namespace}-text-light);
  margin-left: 4px;
}

.${namespace}-textarea {
  height: auto;
  padding: 3px 5px;
  resize: vertical;
}

.${namespace}-input::placeholder,
.${namespace}-textarea::placeholder {
  color: var(--${namespace}-text-light);
  opacity: 1;
}

/* 含 textarea 的 field 行：顶部对齐 */
.${namespace}-field:has(.${namespace}-textarea) {
  align-items: flex-start;
}
.${namespace}-field:has(.${namespace}-textarea) .${namespace}-field-label {
  margin-top: 4px;
}

/* Form section subheading */
.${namespace}-form-section {
  grid-column: 1 / -1;
  font-size: 11px;
  font-weight: bold;
  color: var(--${namespace}-primary);
  padding: 2px 0 1px 6px;
  border-left: 2px solid var(--${namespace}-primary);
  margin: 3px 0 1px;
}

/* Form divider */
.${namespace}-form-divider {
  grid-column: 1 / -1;
  border: none;
  border-top: 1px dashed var(--${namespace}-border-light);
  margin: 2px 0;
}

/* Edit mode hint bar */
.${namespace}-edit-bar {
  background: var(--${namespace}-warning-bg);
  border-bottom: 1px solid var(--${namespace}-warning-border);
  padding: 5px 10px;
  display: flex;
  align-items: center;
  gap: 8px;
  font-size: 11px;
  color: var(--${namespace}-warning);
}
.${namespace}-edit-bar::before { content: "✏"; margin-right: 2px; }

.${namespace}-form-footer {
  z-index: 100;
  padding: 8px 14px;
  background: #fff;
  border-top: 2px solid var(--${namespace}-primary);
  display: flex;
  height: 42px;
  flex-shrink: 0;
}

/* ══════════════════════════════════════════════
   11. Buttons
   ══════════════════════════════════════════════ */
.${namespace}-btn {
  height: 24px;
  padding: 0 9px;
  font-size: 12px;
  font-family: var(--${namespace}-font);
  border: 1px solid;
  cursor: pointer;
  display: inline-flex;
  align-items: center;
  gap: 3px;
  white-space: nowrap;
  border-radius: var(--${namespace}-radius-sm);
  transition: background var(--${namespace}-transition-fast),
              border-color var(--${namespace}-transition-fast),
              color var(--${namespace}-transition-fast);
}
.${namespace}-btn:disabled { opacity: .5; cursor: not-allowed; }

/* Variants */
.${namespace}-btn--primary {
  background: var(--${namespace}-primary);
  color: #fff;
  border-color: var(--${namespace}-primary);
}
.${namespace}-btn--primary:hover { background: var(--${namespace}-teal-700); }

.${namespace}-btn--success {
  background: var(--${namespace}-success);
  color: #fff;
  border-color: var(--${namespace}-success);
}
.${namespace}-btn--success:hover { background: var(--${namespace}-green-700); }

.${namespace}-btn--warning {
  background: var(--${namespace}-warning);
  color: #fff;
  border-color: var(--${namespace}-warning);
}
.${namespace}-btn--warning:hover { background: var(--${namespace}-amber-800); }

.${namespace}-btn--danger {
  background: var(--${namespace}-danger);
  color: #fff;
  border-color: var(--${namespace}-danger);
}
.${namespace}-btn--danger:hover { background: var(--${namespace}-red-800); }

.${namespace}-btn--default {
  background: var(--${namespace}-bg);
  color: #333;
  border-color: var(--${namespace}-border);
}
.${namespace}-btn--default:hover { background: #f5f5f5; }

/* Sizes */
.${namespace}-btn--sm { height: 20px; padding: 0 6px; font-size: 11px; }
.${namespace}-btn--lg { height: 28px; padding: 0 14px; font-size: 12px; font-weight: bold; }

.${namespace}-btn-gap {
  margin-left: 6px;
}

/* ══════════════════════════════════════════════
   12. Badge / Tag
   ══════════════════════════════════════════════ */
.${namespace}-tag {
  display: inline-block;
  padding: 1px 5px;
  font-size: 10px;
  border-radius: var(--${namespace}-radius-sm);
  border: 1px solid;
  white-space: nowrap;
  font-weight: 600;
}

.${namespace}-tag--success { background: var(--${namespace}-success-bg); color: var(--${namespace}-success);  border-color: var(--${namespace}-success-border); }
.${namespace}-tag--danger  { background: var(--${namespace}-danger-bg);  color: var(--${namespace}-danger);   border-color: var(--${namespace}-danger-border);  }
.${namespace}-tag--warning { background: var(--${namespace}-warning-bg); color: var(--${namespace}-warning);  border-color: var(--${namespace}-warning-border); }
.${namespace}-tag--primary { background: var(--${namespace}-primary-bg); color: var(--${namespace}-primary);  border-color: var(--${namespace}-primary-border); }
.${namespace}-tag--neutral { background: #f0f0f0;                        color: #555;                          border-color: #c8c8c8; }
.${namespace}-tag--purple  { background: var(--${namespace}-purple-bg);  color: var(--${namespace}-purple);   border-color: var(--${namespace}-purple-border);  }
.${namespace}-tag--info    { background: var(--${namespace}-info-bg);    color: var(--${namespace}-info);     border-color: var(--${namespace}-info-border);    }

/* ══════════════════════════════════════════════
   13. Table
   ══════════════════════════════════════════════ */
.${namespace}-table {
  width: 100%;
  border-collapse: collapse;
  font-size: 12px;
  table-layout: fixed;
}
.${namespace}-table thead th {
  padding: 5px 6px;
  font-weight: bold;
  color: var(--${namespace}-primary);
  border: 1px solid var(--${namespace}-primary-border);
  text-align: center;
  background: var(--${namespace}-primary-bg);
  white-space: nowrap;
  position: sticky;
  top: 0;
  z-index: var(--${namespace}-z-sticky);
}
.${namespace}-table tbody td {
  padding: 4px 6px;
  border: 1px solid var(--${namespace}-border-light);
  white-space: nowrap;
  overflow: hidden;
  text-overflow: ellipsis;
  vertical-align: top;
}
.${namespace}-table tbody tr:nth-child(even) { background: #f7fafc; }
.${namespace}-table tbody tr:hover           { background: #ddeeff; }
.${namespace}-table tbody tr.${namespace}-row-selected { background: var(--${namespace}-bg-selection); }

/* Cell alignment helpers */
.${namespace}-cell-center { text-align: center; }
.${namespace}-cell-right  { text-align: right; font-family: var(--${namespace}-mono); }

/* ══════════════════════════════════════════════
   14. Alert Bar
   ══════════════════════════════════════════════ */
.${namespace}-alert {
  padding: 4px 12px;
  font-size: 11px;
  display: flex;
  align-items: center;
  gap: 6px;
  flex-shrink: 0;
  border-bottom: 1px solid;
}
.${namespace}-alert--warning {
  background: var(--${namespace}-warning-bg);
  color: var(--${namespace}-warning);
  border-color: var(--${namespace}-warning-border);
}
.${namespace}-alert--danger {
  background: var(--${namespace}-danger-bg);
  color: var(--${namespace}-danger);
  border-color: var(--${namespace}-danger-border);
}
.${namespace}-alert--success {
  background: var(--${namespace}-success-bg);
  color: var(--${namespace}-success);
  border-color: var(--${namespace}-success-border);
}

/* ══════════════════════════════════════════════
   15. Status Bar
   ══════════════════════════════════════════════ */
.${namespace}-statusbar {
  background: #0d3a28;
  border-top: 1px solid #081e14;
  height: 20px;
  display: flex;
  align-items: center;
  flex-shrink: 0;
  padding: 0 12px;
  font-size: 11px;
  color: rgba(255,255,255,.55);
  gap: 14px;
}

.${namespace}-status-dot {
  width: 6px;
  height: 6px;
  border-radius: 50%;
  display: inline-block;
  margin-right: 3px;
  vertical-align: middle;
}

/* ══════════════════════════════════════════════
   16. Timeline
   ══════════════════════════════════════════════ */
.${namespace}-timeline { padding: 8px 12px; }

.${namespace}-tl-item {
  display: flex;
  gap: 10px;
  position: relative;
  padding-bottom: 10px;
}
/* Vertical connector line */
.${namespace}-tl-item::before {
  content: '';
  position: absolute;
  left: 6px;
  top: 16px;
  bottom: 0;
  width: 1px;
  background: var(--${namespace}-primary-border);
}
.${namespace}-tl-item:last-child::before { display: none; }

.${namespace}-tl-dot {
  width: 14px;
  height: 14px;
  border-radius: 50%;
  border: 2px solid #fff;
  flex-shrink: 0;
  margin-top: 2px;
  position: relative;
  z-index: 1;
}
.${namespace}-tl-dot--primary  { background: var(--${namespace}-primary); }
.${namespace}-tl-dot--success  { background: var(--${namespace}-success); }
.${namespace}-tl-dot--danger   { background: var(--${namespace}-danger);  }
.${namespace}-tl-dot--warning  { background: var(--${namespace}-warning); }
.${namespace}-tl-dot--neutral  { background: #aaa; }

.${namespace}-tl-body  { flex: 1; min-width: 0; }
.${namespace}-tl-head  { display: flex; align-items: baseline; gap: 8px; margin-bottom: 2px; }
.${namespace}-tl-title { font-size: 12px; font-weight: bold; }
.${namespace}-tl-by    { font-size: 11px; color: var(--${namespace}-text-light); }
.${namespace}-tl-time  { font-size: 11px; color: var(--${namespace}-text-light); flex-shrink: 0; white-space: nowrap; font-family: var(--${namespace}-mono); }
.${namespace}-tl-desc  { font-size: 11px; color: var(--${namespace}-text-muted); line-height: 1.7; }

/* ══════════════════════════════════════════════
   17. Map Placeholder
   ══════════════════════════════════════════════ */
.${namespace}-map-placeholder {
  background: linear-gradient(135deg, #e8f0fa 0%, #d5e5f0 40%, #c8dce8 100%);
  border: 1px solid var(--${namespace}-primary-border);
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  gap: 8px;
  color: var(--${namespace}-primary);
  font-size: 12px;
  position: relative;
  overflow: hidden;
}
/* Grid overlay */
.${namespace}-map-placeholder::before {
  content: '';
  position: absolute;
  inset: 0;
  background:
    repeating-linear-gradient(0deg, transparent, transparent 30px, rgba(0,107,94,.04) 30px, rgba(0,107,94,.04) 31px),
    repeating-linear-gradient(90deg, transparent, transparent 30px, rgba(0,107,94,.04) 30px, rgba(0,107,94,.04) 31px);
}
.${namespace}-map-pin-icon  { font-size: 28px; position: relative; z-index: 1; }
.${namespace}-map-addr      { font-weight: bold; position: relative; z-index: 1; color: var(--${namespace}-primary-dark); }
.${namespace}-map-pin-dot {
  width: 12px;
  height: 12px;
  border-radius: 50%;
  background: var(--${namespace}-danger);
  border: 2px solid #fff;
  box-shadow: 0 0 0 3px rgba(200,32,10,.3);
  position: absolute;
  top: 40%;
  left: 60%;
  z-index: 2;
}

/* ══════════════════════════════════════════════
   18. Tooltip Mark
   ══════════════════════════════════════════════ */
.${namespace}-tooltip-mark {
  display: inline-block;
  width: 14px;
  height: 14px;
  border-radius: 50%;
  background: var(--${namespace}-primary);
  color: #fff;
  font-size: 9px;
  font-weight: bold;
  text-align: center;
  line-height: 14px;
  cursor: help;
  margin-left: 3px;
  flex-shrink: 0;
}

/* ══════════════════════════════════════════════
   19. Utility Classes
   ══════════════════════════════════════════════ */

.${namespace}-hidden       { display: none; }
.${namespace}-ml-auto      { margin-left: auto; }
.${namespace}-flex-1       { flex: 1; }
.${namespace}-flex-shrink-0 { flex-shrink: 0; }
.${namespace}-w-full       { width: 100%; }
.${namespace}-h-full       { height: 100%; }
.${namespace}-min-w-0      { min-width: 0; }
.${namespace}-overflow-y   { overflow-y: auto; }
.${namespace}-bg-white     { background: var(--${namespace}-bg); }
.${namespace}-cursor-pointer { cursor: pointer; }
.${namespace}-select-none  { user-select: none; }
.${namespace}-sr-only {
  position: absolute;
  width: 1px;
  height: 1px;
  padding: 0;
  margin: -1px;
  overflow: hidden;
  clip: rect(0,0,0,0);
  white-space: nowrap;
  border: 0;
}
