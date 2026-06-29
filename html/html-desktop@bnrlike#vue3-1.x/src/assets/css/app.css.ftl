/**
 * BNR Design System
 * 基于 ccb-premise.html 提取，前缀统一为 ${namespace}-
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
}

/* ══════════════════════════════════════════════
   2. Design Tokens
   ══════════════════════════════════════════════ */
:root {

  /* -- Primary (blue) -- */
  --${namespace}-primary:          #1a4f8a;
  --${namespace}-primary-dark:     #15407a;
  --${namespace}-primary-bg:       #e8edf5;
  --${namespace}-primary-border:   #d0d8e8;
  --${namespace}-primary-hover:    #d0e0f5;

  /* -- Success (green) -- */
  --${namespace}-success:          #1e8449;
  --${namespace}-success-dark:     #196f3d;
  --${namespace}-success-bg:       #e6f5e6;
  --${namespace}-success-border:   #8cc88c;

  /* -- Danger (red) -- */
  --${namespace}-danger:           #c0392b;
  --${namespace}-danger-dark:      #a93226;
  --${namespace}-danger-bg:        #fcecea;
  --${namespace}-danger-border:    #f0a0a0;

  /* -- Warning (orange) -- */
  --${namespace}-warning:          #d46b08;
  --${namespace}-warning-bg:       #fef3e6;
  --${namespace}-warning-border:   #e8b87a;

  /* -- Purple -- */
  --${namespace}-purple:           #6c3483;
  --${namespace}-purple-bg:        #f5eef8;
  --${namespace}-purple-border:    #c39bd3;

  /* -- Teal -- */
  --${namespace}-teal:             #0e6655;
  --${namespace}-teal-bg:          #d1f2eb;
  --${namespace}-teal-border:      #a2d9ce;

  /* -- Neutral text -- */
  --${namespace}-text:             #1c2833;
  --${namespace}-text-muted:       #5d6d7e;
  --${namespace}-text-light:       #909eac;
  --${namespace}-text-disabled:    #c8d0d8;

  /* -- Neutral surface -- */
  --${namespace}-border:           #c8c8c8;
  --${namespace}-border-light:     #e4e8f0;
  --${namespace}-bg:               #ffffff;
  --${namespace}-bg-page:          #f0f2f5;
  --${namespace}-bg-hover:         #e8edf5;

  /* -- Accent -- */
  --${namespace}-gold:             #ffd700;
  --${namespace}-gold-dark:        #DAA520;

  /* -- Typography -- */
  --${namespace}-font:   "Microsoft YaHei", "微软雅黑", SimSun, sans-serif;
  --${namespace}-mono:   Consolas, "Courier New", monospace;

  /* -- Spacing -- */
  --${namespace}-sp-xs:  4px;
  --${namespace}-sp-sm:  6px;
  --${namespace}-sp-md:  8px;
  --${namespace}-sp-lg:  14px;

  /* -- Radius -- */
  --${namespace}-radius-sm: 2px;
  --${namespace}-radius-md: 4px;

  /* -- Shadow -- */
  --${namespace}-shadow-inset: inset 0 1px 2px rgba(28,40,51,0.06);
  --${namespace}-shadow-sm: 0 1px 3px rgba(28,40,51,0.05), 0 1px 2px rgba(28,40,51,0.03);
  --${namespace}-shadow-md: 0 4px 12px rgba(21,64,122,0.06);

  --${namespace}-p: #1a4f8a; --${namespace}-pd: #15407a; --${namespace}-ph: #d0e0f5;
  --${namespace}-pb: #e8edf5; --${namespace}-pbd: #d0d8e8;
  --${namespace}-bl: #e4e8f0; --${namespace}-bd: #c8c8c8; --${namespace}-bg: #fff; --${namespace}-bgp: #f0f2f5;
  --${namespace}-t: #1c2833; --${namespace}-tm: #5d6d7e; --${namespace}-tl: #909eac;
  --${namespace}-rb: #fcecea; --${namespace}-ob: #fef3e6;
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
  width: 168px;
  background: var(--${namespace}-bg);
  border-right: 1px solid #ddd;
  overflow-y: auto;
  flex-shrink: 0;
}

.${namespace}-divider {
  height: 8px;
}

.${namespace}-toolbar { 
  flex-shrink:0; 
  display:flex; 
  align-items:center; 
  gap:8px; 
  padding:8px 14px; 
  background:#fff;
  order-bottom:1px solid #d9d9d9; 
}

.pt-toolbar > .pt-dp,
.pt-toolbar > .pt-dd,
.pt-toolbar > .pt-input,
.pt-toolbar > .pt-select {
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

/* Page body — scrollable content area inside ${namespace}-page */
.${namespace}-page-body {
  flex: 1;
  overflow-y: auto;
  min-height: 0;
  padding: var(--${namespace}-sp-md);
  display: flex;
  flex-direction: column;
  gap: 7px;
}

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
  background: linear-gradient(90deg, #0d3a6e 0%, var(--${namespace}-primary) 60%, #1a5f9a 100%);
  color: #fff;
  height: 42px;
  display: flex;
  align-items: center;
  padding: 0 var(--${namespace}-lg, 14px);
  flex-shrink: 0;
  border-bottom: 2px solid var(--${namespace}-gold);
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
.${namespace}-logo em { color: var(--${namespace}-gold); font-style: normal; }

/* Top navigation item */
.${namespace}-tnav {
  padding: 0 10px;
  height: 42px;
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
  border-bottom-color: var(--${namespace}-gold);
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
  padding: 0 var(--${namespace}-lg, 14px);
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
  background: linear-gradient(180deg, var(--${namespace}-primary-bg) 0%, #dce7f5 100%);
  border-bottom: 1px solid var(--${namespace}-primary-border);
  padding: 8px var(--${namespace}-lg, 14px);
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
  color: var(--${namespace}-gold);
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

/* ══════════════════════════════════════════════
   7. Tabs
   ══════════════════════════════════════════════ */
.${namespace}-tabs {
  display: flex;
  background: var(--${namespace}-bg);
  border-bottom: 2px solid var(--${namespace}-primary);
  flex-shrink: 0;
}
.${namespace}-tab {
  padding: 6px 14px;
  font-size: 12px;
  cursor: pointer;
  color: #555;
  border-right: 1px solid #eee;
  display: flex;
  align-items: center;
  gap: 4px;
  white-space: nowrap;
}
.${namespace}-tab:hover { background: var(--${namespace}-primary-bg); color: var(--${namespace}-primary); }
.${namespace}-tab.${namespace}-active { background: var(--${namespace}-primary); color: #fff; font-weight: bold; }

/* Badge inside tab (count pill) */
.${namespace}-tab-badge {
  background: var(--${namespace}-primary);
  color: #fff;
  font-size: 10px;
  padding: 0 4px;
  border-radius: 8px;
  margin-left: 2px;
}
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

.${namespace}-tabs-content div {
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
.${namespace}-fview--1 { grid-template-columns: repeat(1, 1fr); }
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
.${namespace}-fview--1 > .${namespace}-fv:nth-child(1n) { border-right: none; }
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
  /*text-align: right;*/
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
}
.${namespace}-input:focus,
.${namespace}-select:focus,
.${namespace}-textarea:focus  { border-color: var(--${namespace}-primary); box-shadow: 0 0 0 2px rgba(26,79,138,.08); }

.${namespace}-input--readonly { background: #f5f7fa; color: var(--${namespace}-text-muted); }
.${namespace}-input--mono     { font-family: var(--${namespace}-mono); }
.${namespace}-input--error,
.${namespace}-select--error   { border-color: var(--${namespace}-danger) !important; background: var(--${namespace}-danger-bg); }

.${namespace}-field-unit {
  font-size: 10px; 
  color: rgb(144, 158, 172); 
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

/* 含 textarea 的 field 行：顶部对齐，label 加小 margin */
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

/* Edit mode hint bar (orange strip above form) */
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
}
.${namespace}-btn:disabled { opacity: .5; cursor: not-allowed; }

/* Variants */
.${namespace}-btn--primary {
  background: var(--${namespace}-primary);
  color: #fff;
  border-color: var(--${namespace}-primary);
}
.${namespace}-btn--primary:hover { background: var(--${namespace}-primary-dark); }

.${namespace}-btn--success {
  background: var(--${namespace}-success);
  color: #fff;
  border-color: var(--${namespace}-success);
}
.${namespace}-btn--success:hover { background: var(--${namespace}-success-dark); }

.${namespace}-btn--warning {
  background: var(--${namespace}-warning);
  color: #fff;
  border-color: var(--${namespace}-warning);
}
.${namespace}-btn--warning:hover { background: #b85c06; }

.${namespace}-btn--danger {
  background: var(--${namespace}-danger);
  color: #fff;
  border-color: var(--${namespace}-danger);
}
.${namespace}-btn--danger:hover { background: var(--${namespace}-danger-dark); }

.${namespace}-btn--default {
  background: var(--${namespace}-bg);
  color: #333;
  border-color: var(--${namespace}-border);
}
.${namespace}-btn--default:hover { background: #f5f5f5; }

.${namespace}-btn--purple {
  background: var(--${namespace}-purple);
  color: #fff;
  border-color: var(--${namespace}-purple);
}

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
}

.${namespace}-tag--success { background: var(--${namespace}-success-bg); color: #1a6b1a;  border-color: var(--${namespace}-success-border); }
.${namespace}-tag--danger  { background: var(--${namespace}-danger-bg);  color: #922b21;  border-color: var(--${namespace}-danger-border);  }
.${namespace}-tag--warning { background: var(--${namespace}-warning-bg); color: #8a4800;  border-color: var(--${namespace}-warning-border); }
.${namespace}-tag--primary { background: var(--${namespace}-primary-bg); color: #154360;  border-color: var(--${namespace}-primary-border); }
.${namespace}-tag--neutral { background: #f0f0f0;               color: #555;     border-color: #c8c8c8; }
.${namespace}-tag--purple  { background: var(--${namespace}-purple-bg);  color: #4a235a;  border-color: var(--${namespace}-purple-border);  }
.${namespace}-tag--teal    { background: var(--${namespace}-teal-bg);    color: #0e6655;  border-color: var(--${namespace}-teal-border);    }

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
}
.${namespace}-table tbody td {
  padding: 4px 6px;
  border: 1px solid var(--${namespace}-border-light);
  white-space: nowrap;
  overflow: hidden;
  text-overflow: ellipsis;
}
.${namespace}-table tbody tr:nth-child(even) { background: #f7fafc; }
.${namespace}-table tbody tr:hover           { background: #ddeeff; }
.${namespace}-table tbody tr.${namespace}-row-selected { background: #cce0ff; }

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
   15. Status Bar  (bottom of shell)
   ══════════════════════════════════════════════ */
.${namespace}-statusbar {
  background: var(--${namespace}-primary-bg);
  border-top: 1px solid var(--${namespace}-primary-border);
  padding: 2px 12px;
  font-size: 11px;
  color: var(--${namespace}-text-muted);
  display: flex;
  gap: 14px;
  align-items: center;
  flex-shrink: 0;
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
.${namespace}-tl-dot--primary { background: var(--${namespace}-primary); }
.${namespace}-tl-dot--success { background: var(--${namespace}-success); }
.${namespace}-tl-dot--danger  { background: var(--${namespace}-danger);  }
.${namespace}-tl-dot--warning { background: var(--${namespace}-warning); }
.${namespace}-tl-dot--neutral { background: #aaa; }

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
    repeating-linear-gradient(0deg, transparent, transparent 30px, rgba(26,79,138,.04) 30px, rgba(26,79,138,.04) 31px),
    repeating-linear-gradient(90deg, transparent, transparent 30px, rgba(26,79,138,.04) 30px, rgba(26,79,138,.04) 31px);
}
.${namespace}-map-pin-icon  { font-size: 28px; position: relative; z-index: 1; }
.${namespace}-map-addr      { font-weight: bold; position: relative; z-index: 1; color: var(--${namespace}-primary-dark); }
.${namespace}-map-pin-dot {
  width: 12px;
  height: 12px;
  border-radius: 50%;
  background: var(--${namespace}-danger);
  border: 2px solid #fff;
  box-shadow: 0 0 0 3px rgba(192,57,43,.3);
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

/* OfficialForm                          */
/* Namespace: ${namespace}-of            */
/* 国企公文表单：红头立项审批单               */
/* 所有颜色均通过 BNR Design System 变量引用 */

/* ══════════════════════════════════════════════
   1. Root
   ══════════════════════════════════════════════ */
.${namespace}-of {
  font-family: "SimSun", "Microsoft YaHei", sans-serif;
  font-size: 12px;
  color: var(--${namespace}-text);
}

/* ══════════════════════════════════════════════
   2. Toolbar
   ══════════════════════════════════════════════ */
.${namespace}-of__toolbar {
  background-color: var(--${namespace}-bg-page);
  border: 1px solid var(--${namespace}-text-light);
  padding: 4px 10px;
  margin-bottom: 8px;
  display: flex;
  gap: 5px;
  max-width: 930px;
  margin-left: auto;
  margin-right: auto;
}

/* ══════════════════════════════════════════════
   3. Buttons
   ══════════════════════════════════════════════ */
.${namespace}-of__btn {
  font-size: 12px;
  padding: 2px 8px;
  background: var(--${namespace}-bg);
  border: 1px solid var(--${namespace}-text-light);
  cursor: pointer;
}

.${namespace}-of__btn:hover {
  background-color: var(--${namespace}-primary-bg);
  border-color: var(--${namespace}-primary);
}

/* -- submit variant -- */
.${namespace}-of__btn--submit {
  color: var(--${namespace}-danger);
  font-weight: bold;
}

/* -- add row -- */
.${namespace}-of__btn--add {
  font-size: 11px;
  padding: 1px 8px;
  background: var(--${namespace}-bg);
  border: 1px dashed var(--${namespace}-primary);
  color: var(--${namespace}-primary);
  cursor: pointer;
}

.${namespace}-of__btn--add:hover {
  background: var(--${namespace}-primary-bg);
}

/* -- delete row -- */
.${namespace}-of__btn--del {
  font-size: 11px;
  padding: 0 4px;
  background: var(--${namespace}-bg);
  border: 1px solid var(--${namespace}-border);
  color: var(--${namespace}-danger);
  cursor: pointer;
}

.${namespace}-of__btn--del:hover {
  background: var(--${namespace}-danger-bg);
  border-color: var(--${namespace}-danger);
}

/* ══════════════════════════════════════════════
   4. Container — 表单主容器
   ══════════════════════════════════════════════ */
.${namespace}-of__container {
  width: 850px;
  margin: 0 auto;
  background-color: var(--${namespace}-bg);
  border: 1px solid var(--${namespace}-text-muted);
  padding: 30px 40px;
  box-shadow: 2px 2px 5px rgba(0, 0, 0, 0.2);
}

/* ══════════════════════════════════════════════
   5. Header — 红头标题
   ══════════════════════════════════════════════ */
.${namespace}-of__header {
  text-align: center;
  margin-bottom: 20px;
}

.${namespace}-of__header h1 {
  font-family: "KaiTi", "STKaiti", serif;
  font-size: 26px;
  color: var(--${namespace}-danger);
  font-weight: bold;
  margin: 0 0 10px 0;
  letter-spacing: 2px;
}

.${namespace}-of__meta {
  display: flex;
  justify-content: space-between;
  color: var(--${namespace}-text);
  padding: 0 5px;
  font-size: 12px;
}

/* ══════════════════════════════════════════════
   6. Main Table — 主表格
   ══════════════════════════════════════════════ */
.${namespace}-of__table {
  width: 100%;
  border-collapse: collapse;
  border: 2px solid var(--${namespace}-text);
}

.${namespace}-of__table td {
  border: 1px solid var(--${namespace}-text);
  height: 28px;
  padding: 2px 4px;
  vertical-align: middle;
}

/* ══════════════════════════════════════════════
   7. Label — 标签列
   ══════════════════════════════════════════════ */
.${namespace}-of__label {
  background-color: var(--${namespace}-primary-bg);
  font-weight: bold;
  text-align: center;
  width: 13%;
  color: var(--${namespace}-primary);
}

/* -- required marker -- */
.${namespace}-of__required::after {
  content: " *";
  color: var(--${namespace}-danger);
}

/* ══════════════════════════════════════════════
   8. Input / Select — 输入控件
   ══════════════════════════════════════════════ */
.${namespace}-of__input,
.${namespace}-of__select {
  width: 100%;
  height: 24px;
  border: none;
  outline: none;
  padding: 0 4px;
  font-size: 12px;
  box-sizing: border-box;
  background-color: transparent;
}

.${namespace}-of__input:focus,
.${namespace}-of__select:focus,
.${namespace}-of__textarea:focus {
  background-color: var(--${namespace}-warning-bg);
}

/* -- amount variant -- */
.${namespace}-of__input--amount {
  font-weight: bold;
  color: var(--${namespace}-danger);
}

/* ══════════════════════════════════════════════
   9. Readonly state
   ══════════════════════════════════════════════ */
.${namespace}-of__readonly {
  background-color: var(--${namespace}-bg-page);
  color: var(--${namespace}-text-muted);
}

/* ══════════════════════════════════════════════
   10. Textarea — 文本域
   ══════════════════════════════════════════════ */
.${namespace}-of__textarea {
  width: 100%;
  height: 70px;
  border: none;
  outline: none;
  resize: none;
  font-size: 12px;
  font-family: inherit;
  padding: 4px;
  box-sizing: border-box;
  display: block;
  background-color: transparent;
}

/* ══════════════════════════════════════════════
   11. Sub-table — 预算明细 / 嵌套表格
   ══════════════════════════════════════════════ */
.${namespace}-of__sub-table {
  width: 100%;
  border-collapse: collapse;
  margin: 4px 0;
}

.${namespace}-of__sub-table th {
  border: 1px solid var(--${namespace}-text-muted);
  background-color: var(--${namespace}-border-light);
  font-weight: normal;
  font-size: 11px;
  height: 22px;
}

.${namespace}-of__sub-table td {
  border: 1px solid var(--${namespace}-text-muted);
  height: 22px;
  background-color: var(--${namespace}-bg);
}

/* ══════════════════════════════════════════════
   12. Attachments — 附件
   ══════════════════════════════════════════════ */
.${namespace}-of__attach {
  padding: 2px;
}

.${namespace}-of__attach-list {
  margin-top: 4px;
  color: var(--${namespace}-text-muted);
  font-size: 11px;
}

.${namespace}-of__link {
  color: var(--${namespace}-primary);
  text-decoration: none;
}

/* ══════════════════════════════════════════════
   13. Opinion — 审批意见
   ══════════════════════════════════════════════ */
.${namespace}-of__opinion {
  height: 80px;
  position: relative;
}

.${namespace}-of__opinion-sign {
  position: absolute;
  right: 15px;
  bottom: 5px;
  text-align: right;
  color: var(--${namespace}-text-muted);
}

.${namespace}-of__opinion-sign span {
  display: inline-block;
  width: 100px;
  border-bottom: 1px solid var(--${namespace}-text);
  text-align: center;
}

/* ══════════════════════════════════════════════
   14. Print — 打印样式
   ══════════════════════════════════════════════ */
@media print {
  .${namespace}-of__toolbar   { display: none; }
  .${namespace}-of__container { box-shadow: none; border: none; padding: 0; }
}

/* ── Row ── */
.${namespace}-row {
  display: flex;
  flex-wrap: wrap;
}

/* ── 基础列 (1-24) ── */
.${namespace}-col-1  { flex: 0 0 4.16666667%; max-width: 4.16666667%; }
.${namespace}-col-2  { flex: 0 0 8.33333333%; max-width: 8.33333333%; }
.${namespace}-col-3  { flex: 0 0 12.5%;       max-width: 12.5%;       }
.${namespace}-col-4  { flex: 0 0 16.66666667%; max-width: 16.66666667%; }
.${namespace}-col-5  { flex: 0 0 20.83333333%; max-width: 20.83333333%; }
.${namespace}-col-6  { flex: 0 0 25%;          max-width: 25%;          }
.${namespace}-col-7  { flex: 0 0 29.16666667%; max-width: 29.16666667%; }
.${namespace}-col-8  { flex: 0 0 33.33333333%; max-width: 33.33333333%; }
.${namespace}-col-9  { flex: 0 0 37.5%;        max-width: 37.5%;        }
.${namespace}-col-10 { flex: 0 0 41.66666667%; max-width: 41.66666667%; }
.${namespace}-col-11 { flex: 0 0 45.83333333%; max-width: 45.83333333%; }
.${namespace}-col-12 { flex: 0 0 50%;          max-width: 50%;          }
.${namespace}-col-13 { flex: 0 0 54.16666667%; max-width: 54.16666667%; }
.${namespace}-col-14 { flex: 0 0 58.33333333%; max-width: 58.33333333%; }
.${namespace}-col-15 { flex: 0 0 62.5%;        max-width: 62.5%;        }
.${namespace}-col-16 { flex: 0 0 66.66666667%; max-width: 66.66666667%; }
.${namespace}-col-17 { flex: 0 0 70.83333333%; max-width: 70.83333333%; }
.${namespace}-col-18 { flex: 0 0 75%;          max-width: 75%;          }
.${namespace}-col-19 { flex: 0 0 79.16666667%; max-width: 79.16666667%; }
.${namespace}-col-20 { flex: 0 0 83.33333333%; max-width: 83.33333333%; }
.${namespace}-col-21 { flex: 0 0 87.5%;        max-width: 87.5%;        }
.${namespace}-col-22 { flex: 0 0 91.66666667%; max-width: 91.66666667%; }
.${namespace}-col-23 { flex: 0 0 95.83333333%; max-width: 95.83333333%; }
.${namespace}-col-24 { flex: 0 0 100%;         max-width: 100%;         }

/* ── 偏移 (1-24) ── */
.${namespace}-col-offset-1  { margin-left: 4.16666667%; }
.${namespace}-col-offset-2  { margin-left: 8.33333333%; }
.${namespace}-col-offset-3  { margin-left: 12.5%;       }
.${namespace}-col-offset-4  { margin-left: 16.66666667%; }
.${namespace}-col-offset-5  { margin-left: 20.83333333%; }
.${namespace}-col-offset-6  { margin-left: 25%;          }
.${namespace}-col-offset-7  { margin-left: 29.16666667%; }
.${namespace}-col-offset-8  { margin-left: 33.33333333%; }
.${namespace}-col-offset-9  { margin-left: 37.5%;        }
.${namespace}-col-offset-10 { margin-left: 41.66666667%; }
.${namespace}-col-offset-11 { margin-left: 45.83333333%; }
.${namespace}-col-offset-12 { margin-left: 50%;          }
.${namespace}-col-offset-13 { margin-left: 54.16666667%; }
.${namespace}-col-offset-14 { margin-left: 58.33333333%; }
.${namespace}-col-offset-15 { margin-left: 62.5%;        }
.${namespace}-col-offset-16 { margin-left: 66.66666667%; }
.${namespace}-col-offset-17 { margin-left: 70.83333333%; }
.${namespace}-col-offset-18 { margin-left: 75%;          }
.${namespace}-col-offset-19 { margin-left: 79.16666667%; }
.${namespace}-col-offset-20 { margin-left: 83.33333333%; }
.${namespace}-col-offset-21 { margin-left: 87.5%;        }
.${namespace}-col-offset-22 { margin-left: 91.66666667%; }
.${namespace}-col-offset-23 { margin-left: 95.83333333%; }
.${namespace}-col-offset-24 { margin-left: 100%;         }

/* ── Gutter ── */
.${namespace}-row--gap    { margin-left: -6px;  margin-right: -6px;  }
.${namespace}-row--gap    > [class*="${namespace}-col-"] { padding-left: 6px;  padding-right: 6px;  }
.${namespace}-row--gap-sm { margin-left: -4px;  margin-right: -4px;  }
.${namespace}-row--gap-sm > [class*="${namespace}-col-"] { padding-left: 4px;  padding-right: 4px;  }
.${namespace}-row--gap-lg { margin-left: -12px; margin-right: -12px; }
.${namespace}-row--gap-lg > [class*="${namespace}-col-"] { padding-left: 12px; padding-right: 12px; }

/* ── 响应式栅格: sm (< 576px) ── */
@media (max-width: 576px) {
  .${namespace}-col-sm-1  { flex: 0 0 4.16666667%; max-width: 4.16666667%; }
  .${namespace}-col-sm-2  { flex: 0 0 8.33333333%; max-width: 8.33333333%; }
  .${namespace}-col-sm-3  { flex: 0 0 12.5%;       max-width: 12.5%;       }
  .${namespace}-col-sm-4  { flex: 0 0 16.66666667%; max-width: 16.66666667%; }
  .${namespace}-col-sm-5  { flex: 0 0 20.83333333%; max-width: 20.83333333%; }
  .${namespace}-col-sm-6  { flex: 0 0 25%;          max-width: 25%;          }
  .${namespace}-col-sm-7  { flex: 0 0 29.16666667%; max-width: 29.16666667%; }
  .${namespace}-col-sm-8  { flex: 0 0 33.33333333%; max-width: 33.33333333%; }
  .${namespace}-col-sm-9  { flex: 0 0 37.5%;        max-width: 37.5%;        }
  .${namespace}-col-sm-10 { flex: 0 0 41.66666667%; max-width: 41.66666667%; }
  .${namespace}-col-sm-11 { flex: 0 0 45.83333333%; max-width: 45.83333333%; }
  .${namespace}-col-sm-12 { flex: 0 0 50%;          max-width: 50%;          }
  .${namespace}-col-sm-13 { flex: 0 0 54.16666667%; max-width: 54.16666667%; }
  .${namespace}-col-sm-14 { flex: 0 0 58.33333333%; max-width: 58.33333333%; }
  .${namespace}-col-sm-15 { flex: 0 0 62.5%;        max-width: 62.5%;        }
  .${namespace}-col-sm-16 { flex: 0 0 66.66666667%; max-width: 66.66666667%; }
  .${namespace}-col-sm-17 { flex: 0 0 70.83333333%; max-width: 70.83333333%; }
  .${namespace}-col-sm-18 { flex: 0 0 75%;          max-width: 75%;          }
  .${namespace}-col-sm-19 { flex: 0 0 79.16666667%; max-width: 79.16666667%; }
  .${namespace}-col-sm-20 { flex: 0 0 83.33333333%; max-width: 83.33333333%; }
  .${namespace}-col-sm-21 { flex: 0 0 87.5%;        max-width: 87.5%;        }
  .${namespace}-col-sm-22 { flex: 0 0 91.66666667%; max-width: 91.66666667%; }
  .${namespace}-col-sm-23 { flex: 0 0 95.83333333%; max-width: 95.83333333%; }
  .${namespace}-col-sm-24 { flex: 0 0 100%;         max-width: 100%;         }
}

/* ── 响应式栅格: md (≥ 768px) ── */
@media (min-width: 768px) {
  .${namespace}-col-md-1  { flex: 0 0 4.16666667%; max-width: 4.16666667%; }
  .${namespace}-col-md-2  { flex: 0 0 8.33333333%; max-width: 8.33333333%; }
  .${namespace}-col-md-3  { flex: 0 0 12.5%;       max-width: 12.5%;       }
  .${namespace}-col-md-4  { flex: 0 0 16.66666667%; max-width: 16.66666667%; }
  .${namespace}-col-md-5  { flex: 0 0 20.83333333%; max-width: 20.83333333%; }
  .${namespace}-col-md-6  { flex: 0 0 25%;          max-width: 25%;          }
  .${namespace}-col-md-7  { flex: 0 0 29.16666667%; max-width: 29.16666667%; }
  .${namespace}-col-md-8  { flex: 0 0 33.33333333%; max-width: 33.33333333%; }
  .${namespace}-col-md-9  { flex: 0 0 37.5%;        max-width: 37.5%;        }
  .${namespace}-col-md-10 { flex: 0 0 41.66666667%; max-width: 41.66666667%; }
  .${namespace}-col-md-11 { flex: 0 0 45.83333333%; max-width: 45.83333333%; }
  .${namespace}-col-md-12 { flex: 0 0 50%;          max-width: 50%;          }
  .${namespace}-col-md-13 { flex: 0 0 54.16666667%; max-width: 54.16666667%; }
  .${namespace}-col-md-14 { flex: 0 0 58.33333333%; max-width: 58.33333333%; }
  .${namespace}-col-md-15 { flex: 0 0 62.5%;        max-width: 62.5%;        }
  .${namespace}-col-md-16 { flex: 0 0 66.66666667%; max-width: 66.66666667%; }
  .${namespace}-col-md-17 { flex: 0 0 70.83333333%; max-width: 70.83333333%; }
  .${namespace}-col-md-18 { flex: 0 0 75%;          max-width: 75%;          }
  .${namespace}-col-md-19 { flex: 0 0 79.16666667%; max-width: 79.16666667%; }
  .${namespace}-col-md-20 { flex: 0 0 83.33333333%; max-width: 83.33333333%; }
  .${namespace}-col-md-21 { flex: 0 0 87.5%;        max-width: 87.5%;        }
  .${namespace}-col-md-22 { flex: 0 0 91.66666667%; max-width: 91.66666667%; }
  .${namespace}-col-md-23 { flex: 0 0 95.83333333%; max-width: 95.83333333%; }
  .${namespace}-col-md-24 { flex: 0 0 100%;         max-width: 100%;         }
}

/* ── 响应式栅格: lg (≥ 992px) ── */
@media (min-width: 992px) {
  .${namespace}-col-lg-1  { flex: 0 0 4.16666667%; max-width: 4.16666667%; }
  .${namespace}-col-lg-2  { flex: 0 0 8.33333333%; max-width: 8.33333333%; }
  .${namespace}-col-lg-3  { flex: 0 0 12.5%;       max-width: 12.5%;       }
  .${namespace}-col-lg-4  { flex: 0 0 16.66666667%; max-width: 16.66666667%; }
  .${namespace}-col-lg-5  { flex: 0 0 20.83333333%; max-width: 20.83333333%; }
  .${namespace}-col-lg-6  { flex: 0 0 25%;          max-width: 25%;          }
  .${namespace}-col-lg-7  { flex: 0 0 29.16666667%; max-width: 29.16666667%; }
  .${namespace}-col-lg-8  { flex: 0 0 33.33333333%; max-width: 33.33333333%; }
  .${namespace}-col-lg-9  { flex: 0 0 37.5%;        max-width: 37.5%;        }
  .${namespace}-col-lg-10 { flex: 0 0 41.66666667%; max-width: 41.66666667%; }
  .${namespace}-col-lg-11 { flex: 0 0 45.83333333%; max-width: 45.83333333%; }
  .${namespace}-col-lg-12 { flex: 0 0 50%;          max-width: 50%;          }
  .${namespace}-col-lg-13 { flex: 0 0 54.16666667%; max-width: 54.16666667%; }
  .${namespace}-col-lg-14 { flex: 0 0 58.33333333%; max-width: 58.33333333%; }
  .${namespace}-col-lg-15 { flex: 0 0 62.5%;        max-width: 62.5%;        }
  .${namespace}-col-lg-16 { flex: 0 0 66.66666667%; max-width: 66.66666667%; }
  .${namespace}-col-lg-17 { flex: 0 0 70.83333333%; max-width: 70.83333333%; }
  .${namespace}-col-lg-18 { flex: 0 0 75%;          max-width: 75%;          }
  .${namespace}-col-lg-19 { flex: 0 0 79.16666667%; max-width: 79.16666667%; }
  .${namespace}-col-lg-20 { flex: 0 0 83.33333333%; max-width: 83.33333333%; }
  .${namespace}-col-lg-21 { flex: 0 0 87.5%;        max-width: 87.5%;        }
  .${namespace}-col-lg-22 { flex: 0 0 91.66666667%; max-width: 91.66666667%; }
  .${namespace}-col-lg-23 { flex: 0 0 95.83333333%; max-width: 95.83333333%; }
  .${namespace}-col-lg-24 { flex: 0 0 100%;         max-width: 100%;         }
}

/* ── 响应式栅格: xl (≥ 1200px) ── */
@media (min-width: 1200px) {
  .${namespace}-col-xl-1  { flex: 0 0 4.16666667%; max-width: 4.16666667%; }
  .${namespace}-col-xl-2  { flex: 0 0 8.33333333%; max-width: 8.33333333%; }
  .${namespace}-col-xl-3  { flex: 0 0 12.5%;       max-width: 12.5%;       }
  .${namespace}-col-xl-4  { flex: 0 0 16.66666667%; max-width: 16.66666667%; }
  .${namespace}-col-xl-5  { flex: 0 0 20.83333333%; max-width: 20.83333333%; }
  .${namespace}-col-xl-6  { flex: 0 0 25%;          max-width: 25%;          }
  .${namespace}-col-xl-7  { flex: 0 0 29.16666667%; max-width: 29.16666667%; }
  .${namespace}-col-xl-8  { flex: 0 0 33.33333333%; max-width: 33.33333333%; }
  .${namespace}-col-xl-9  { flex: 0 0 37.5%;        max-width: 37.5%;        }
  .${namespace}-col-xl-10 { flex: 0 0 41.66666667%; max-width: 41.66666667%; }
  .${namespace}-col-xl-11 { flex: 0 0 45.83333333%; max-width: 45.83333333%; }
  .${namespace}-col-xl-12 { flex: 0 0 50%;          max-width: 50%;          }
  .${namespace}-col-xl-13 { flex: 0 0 54.16666667%; max-width: 54.16666667%; }
  .${namespace}-col-xl-14 { flex: 0 0 58.33333333%; max-width: 58.33333333%; }
  .${namespace}-col-xl-15 { flex: 0 0 62.5%;        max-width: 62.5%;        }
  .${namespace}-col-xl-16 { flex: 0 0 66.66666667%; max-width: 66.66666667%; }
  .${namespace}-col-xl-17 { flex: 0 0 70.83333333%; max-width: 70.83333333%; }
  .${namespace}-col-xl-18 { flex: 0 0 75%;          max-width: 75%;          }
  .${namespace}-col-xl-19 { flex: 0 0 79.16666667%; max-width: 79.16666667%; }
  .${namespace}-col-xl-20 { flex: 0 0 83.33333333%; max-width: 83.33333333%; }
  .${namespace}-col-xl-21 { flex: 0 0 87.5%;        max-width: 87.5%;        }
  .${namespace}-col-xl-22 { flex: 0 0 91.66666667%; max-width: 91.66666667%; }
  .${namespace}-col-xl-23 { flex: 0 0 95.83333333%; max-width: 95.83333333%; }
  .${namespace}-col-xl-24 { flex: 0 0 100%;         max-width: 100%;         }
}

.tile {
  display: flex;
  flex-direction: column;
  gap: 6px;
  padding: 12px;
  border: 1px solid var(--tile-border, #e8e8e8);
  border-radius: var(--tile-radius, 8px);
  background: var(--tile-bg, #fff);
  font-size: 13px;
  color: var(--tile-color, #333);
  line-height: 1.4;
}

.tile-row {
  display: flex;
  align-items: center;
  gap: 8px;
}

.tile-header {
  justify-content: space-between;
}

.tile-body {
  flex: 1;
  min-width: 0;
}

.tile-footer {
  justify-content: space-between;
  margin-top: 2px;
}

.tile-inline {
  flex-wrap: wrap;
}

.tile-col {
  flex: 1;
  min-width: 0;
}
.tile-col + .tile-col {
  margin-left: 8px;
}

.tile-cols {
  gap: 8px;
}

.tile-col-left {
  border-right: 1px solid var(--tile-border, #e8e8e8);
  padding-right: 8px;
}

.tile-col-right {
  padding-left: 4px;
}

.tile-justified {
  justify-content: space-between;
}

.tile-left {
  justify-content: flex-start;
  text-align: left;
}

.tile-right {
  justify-content: flex-end;
  text-align: right;
}

.tile-sep {
  color: var(--tile-sep, #ddd);
  margin: 0 4px;
  user-select: none;
}

.tile-primary {
  font-weight: 600;
  font-size: 14px;
  color: var(--tile-primary-color, #1a1a1a);
}

.tile-secondary {
  font-size: 12px;
  color: var(--tile-secondary-color, #666);
}

.tile-tertiary {
  font-size: 11px;
  color: var(--tile-tertiary-color, #999);
}

.tile-image {
  display: flex;
  align-items: center;
  justify-content: center;
  border-radius: 6px;
  overflow: hidden;
  background: var(--tile-image-bg, #f0f0f0);
  flex-shrink: 0;
}

.tile-image img {
  width: 100%;
  height: 100%;
  object-fit: cover;
}

.tile-image-wrap {
  position: relative;
  border-radius: 6px;
  overflow: hidden;
}

.tile-image-wrap .tile-image {
  width: 100%;
  border-radius: 6px;
}

.tile-image-tags {
  position: absolute;
  bottom: 8px;
  left: 8px;
  z-index: 1;
}

.tile-avatar {
  width: 36px;
  height: 36px;
  border-radius: 50%;
  overflow: hidden;
  background: var(--tile-avatar-bg, #4a90d9);
  color: #fff;
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 14px;
  font-weight: 600;
  flex-shrink: 0;
}

.tile-avatar img {
  width: 100%;
  height: 100%;
  object-fit: cover;
}

.tile-avatars {
  display: flex;
  align-items: center;
}

.tile-avatar-img {
  width: 28px;
  height: 28px;
  border-radius: 50%;
  border: 2px solid var(--tile-bg, #fff);
  background: var(--tile-avatar-bg, #4a90d9);
  object-fit: cover;
  margin-left: -8px;
  flex-shrink: 0;
}
.tile-avatar-img:first-child {
  margin-left: 0;
}

.tile-avatars-wrap {
  border: 1px solid var(--tile-border, #e8e8e8);
  border-radius: 6px;
  padding: 8px;
}

.tile-tags {
  display: flex;
  gap: 4px;
  flex-wrap: wrap;
  align-items: center;
}

.tile-tag {
  display: inline-block;
  padding: 2px 8px;
  border-radius: 4px;
  background: var(--tile-tag-bg, #e8f4fd);
  color: var(--tile-tag-color, #4a90d9);
  font-size: 11px;
  white-space: nowrap;
}

.tile-tags-row {
  display: flex;
  gap: 4px;
  flex-wrap: wrap;
}

.tile-status {
  font-size: 11px;
  font-weight: 500;
  white-space: nowrap;
}

.tile-status-col {
  min-width: 40px;
  display: flex;
  align-items: center;
  justify-content: center;
  flex-shrink: 0;
}

.tile-time,
.tile-start-time,
.tile-end-time {
  font-size: 11px;
  color: var(--tile-time-color, #999);
  white-space: nowrap;
}

.tile-time-sep {
  color: var(--tile-sep, #ccc);
  margin: 0 2px;
}

.tile-background {
  position: absolute;
  inset: 0;
  border-radius: var(--tile-radius, 8px);
  overflow: hidden;
  z-index: 0;
}

.tile-background img {
  width: 100%;
  height: 100%;
  object-fit: cover;
}

.tile-overlay {
  position: relative;
  z-index: 1;
  display: flex;
  flex-direction: column;
  gap: 6px;
}

.tile-overlay-content {
  position: relative;
  z-index: 2;
  margin-top: -20px;
  display: flex;
  align-items: center;
  gap: 8px;
}

.tile-timeline {
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 2px;
  min-width: 60px;
}

.tile-timeline-dot {
  width: 8px;
  height: 8px;
  border-radius: 50%;
  background: var(--tile-avatar-bg, #4a90d9);
  margin: 4px 0;
  flex-shrink: 0;
}

.tile-timeline-line {
  padding-left: 12px;
}

.tile-timeline-indent {
  color: var(--tile-border, #ddd);
  font-family: monospace;
}

.tile-workflow-chain {
  display: flex;
  align-items: center;
  flex-wrap: wrap;
  gap: 2px;
}

.tile-workflow-arrow {
  color: var(--tile-sep, #bbb);
  margin: 0 4px;
  font-size: 10px;
  user-select: none;
}

.tile-progress {
  display: flex;
  align-items: center;
  gap: 4px;
  font-size: 10px;
}

.tile-progress-bar {
  flex: 1;
  color: var(--tile-border, #ddd);
  letter-spacing: 2px;
  user-select: none;
}

.tile-step-line {
  display: flex;
  align-items: center;
  gap: 4px;
  font-size: 11px;
  color: var(--tile-secondary-color, #888);
  margin: 2px 0;
}

.tile-step-branch {
  color: var(--tile-sep, #ccc);
  font-family: monospace;
  user-select: none;
}

.tile-three-stage {
  display: flex;
  align-items: center;
  justify-content: space-around;
}

.tile-stage-arrow {
  color: var(--tile-sep, #bbb);
  margin: 0 6px;
  font-size: 11px;
  user-select: none;
}

.tile-stacked-card {
  position: relative;
  z-index: 2;
  margin-top: -20px;
  background: var(--tile-bg, #fff);
  border-radius: 8px;
  padding: 10px;
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
}

.tile-meeting-event .tile-time {
  font-size: 12px;
  font-weight: 500;
}

.tile-media-article .tile-image {
  min-height: 120px;
}
.tile-media-article .tile-image img {
  width: 100%;
  height: 100%;
  object-fit: cover;
}

.tile-user-profile .tile-avatar {
  width: 40px;
  height: 40px;
  font-size: 16px;
}

.tile-task-board .tile-header {
  margin-bottom: 4px;
}

.tile-promo-banner {
  position: relative;
  overflow: hidden;
  min-height: 130px;
  color: #fff;
  border: none;
}
.tile-promo-banner .tile-overlay {
  color: #fff;
}
.tile-promo-banner .tile-primary,
.tile-promo-banner .tile-secondary,
.tile-promo-banner .tile-tertiary {
  color: inherit;
  text-shadow: 0 1px 2px rgba(0, 0, 0, 0.3);
}
.tile-promo-banner .tile-tag {
  background: rgba(255, 255, 255, 0.2);
  color: #fff;
}

.tile-compact-list .tile-inline {
  flex-wrap: nowrap;
}

.tile-split-content .tile-image {
  width: 80px;
  min-height: 80px;
}

.tile-notification .tile-primary {
  font-size: 13px;
}

.tile-hero-profile {
  position: relative;
  overflow: hidden;
  min-height: 150px;
  color: #fff;
  border: none;
  text-align: center;
}
.tile-hero-profile .tile-overlay {
  color: #fff;
  align-items: center;
}
.tile-hero-profile .tile-avatar {
  width: 48px;
  height: 48px;
  font-size: 18px;
  border: 3px solid rgba(255, 255, 255, 0.5);
}
.tile-hero-profile .tile-primary,
.tile-hero-profile .tile-secondary {
  color: inherit;
  text-shadow: 0 1px 2px rgba(0, 0, 0, 0.3);
}

.tile-timeline-node .tile-row {
  align-items: stretch;
}
.tile-timeline-node .tile-body {
  padding-left: 8px;
  border-left: 1px dashed var(--tile-border, #ddd);
}

.tile-message .tile-avatar {
  width: 40px;
  height: 40px;
}
.tile-message .tile-header .tile-time {
  margin-left: auto;
}

.tile-ticket {
  position: relative;
  overflow: hidden;
  min-height: 120px;
  color: #fff;
  border: none;
}
.tile-ticket .tile-overlay {
  color: #fff;
  justify-content: space-between;
  height: 100%;
}
.tile-ticket .tile-primary {
  color: inherit;
  font-size: 16px;
}
.tile-ticket .tile-time {
  color: rgba(255, 255, 255, 0.8);
}

.tile-dense-detail-list .tile-image {
  width: 48px;
  height: 48px;
  border-radius: 6px;
}
.tile-dense-detail-list .tile-body > .tile-row {
  font-size: 11px;
}

.tile-vertical-poster {
  max-width: 240px;
  padding: 0;
}
.tile-vertical-poster .tile-image {
  width: 100%;
  min-height: 140px;
  border-radius: 8px 8px 0 0;
}
.tile-vertical-poster .tile-body {
  padding: 10px 12px 12px;
}

.tile-issue-detail .tile-header {
  margin-bottom: 6px;
}
.tile-issue-detail .tile-footer .tile-avatar {
  width: 28px;
  height: 28px;
  font-size: 12px;
}

.tile-team-directory .tile-body {
  margin-bottom: 8px;
}

.tile-immersive-highlight {
  position: relative;
  overflow: hidden;
  min-height: 110px;
  color: #fff;
  border: none;
  justify-content: flex-end;
}
.tile-immersive-highlight .tile-overlay {
  color: #fff;
}
.tile-immersive-highlight .tile-primary {
  color: inherit;
  font-size: 18px;
  font-weight: 700;
}
.tile-immersive-highlight .tile-status {
  color: inherit;
}

.tile-mini-status {
  max-width: 200px;
  gap: 8px;
}
.tile-mini-status .tile-header {
  margin-bottom: 2px;
}

.tile-dual-column-content .tile-col-left {
  border-right: 1px solid var(--tile-border, #eee);
  padding-right: 10px;
}

.tile-gallery .tile-image-wrap .tile-image {
  min-height: 110px;
}

.tile-key-metric {
  max-width: 200px;
  text-align: center;
}
.tile-key-metric .tile-primary {
  font-size: 28px;
  font-weight: 700;
  line-height: 1.2;
}

.tile-overlay-avatar .tile-image-wrap .tile-image {
  min-height: 100px;
}

.tile-audit-log .tile-avatar {
  width: 32px;
  height: 32px;
  font-size: 12px;
}

.tile-calendar-cell {
  max-width: 180px;
  gap: 4px;
}

.tile-side-status .tile-status-col {
  min-width: 48px;
  padding-right: 8px;
}

.tile-multi-tag .tile-tags-row {
  margin-bottom: 6px;
}

.tile-shift-planner .tile-header {
  margin-bottom: 4px;
}

.tile-social-post-feed .tile-image-wrap .tile-image {
  min-height: 100px;
  border-radius: 6px;
}

.tile-product {
  max-width: 220px;
}
.tile-product .tile-image-wrap .tile-image {
  min-height: 110px;
}

.tile-dual-profile-comparison .tile-header {
  justify-content: space-between;
}
.tile-dual-profile-comparison .tile-header .tile-avatar {
  width: 40px;
  height: 40px;
}

.tile-left-feature-image .tile-image {
  width: 120px;
  min-height: 100px;
  border-radius: 6px;
}
.tile-left-feature-image .tile-body {
  padding-left: 4px;
}

.tile-workflow-strip .tile-workflow-chain {
  margin-bottom: 4px;
}

.tile-text-over-background {
  position: relative;
  overflow: hidden;
  min-height: 120px;
  color: #fff;
  border: none;
}
.tile-text-over-background .tile-overlay {
  color: #fff;
}
.tile-text-over-background .tile-primary,
.tile-text-over-background .tile-secondary {
  color: inherit;
  text-shadow: 0 1px 2px rgba(0, 0, 0, 0.3);
}
.tile-text-over-background .tile-tag {
  background: rgba(255, 255, 255, 0.2);
  color: #fff;
}

.tile-micro-badge .tile-inline {
  gap: 6px;
}
.tile-micro-badge .tile-avatar {
  width: 24px;
  height: 24px;
  font-size: 11px;
}

.tile-stepped-process .tile-body {
  padding-left: 8px;
}

.tile-stacked-overlay .tile-image-wrap .tile-image {
  min-height: 100px;
}

.tile-group-hub .tile-avatars {
  margin-bottom: 4px;
}

.tile-tall-sidebar {
  max-width: 180px;
  align-items: stretch;
}
.tile-tall-sidebar .tile-image {
  width: 100%;
  min-height: 80px;
}

.tile-justified-meta .tile-justified {
  margin-bottom: 2px;
}

.tile-multidimensional-board .tile-cols .tile-col {
  border: 1px solid var(--tile-border, #eee);
  border-radius: 6px;
  padding: 8px;
}

.tile-media-player .tile-image {
  width: 56px;
  height: 56px;
}

.tile-left-anchor-time .tile-header {
  margin-bottom: 4px;
}

.tile-duration-span .tile-time {
  font-size: 12px;
  font-weight: 500;
}

.tile-media-history .tile-image {
  width: 56px;
  height: 56px;
}
.tile-media-history .tile-start-time {
  margin-bottom: 4px;
}

.tile-status-transition .tile-avatar {
  width: 28px;
  height: 28px;
  font-size: 11px;
}

.tile-compact-time .tile-inline {
  flex-wrap: nowrap;
  gap: 0;
}

.tile-horizontal-flow {
  max-width: 160px;
  text-align: center;
  align-items: center;
}

.tile-right-biased-node {
  max-width: 180px;
}

.tile-left-biased-node {
  max-width: 180px;
}

.tile-internal-chronology .tile-timeline-line {
  margin: 2px 0;
}

.tile-three-stage-segment .tile-three-stage {
  margin-bottom: 4px;
}

.tile-horizontal-log .tile-inline {
  flex-wrap: nowrap;
  gap: 0;
}
.tile-horizontal-log .tile-avatar {
  width: 24px;
  height: 24px;
  font-size: 11px;
}

.tile-bulletin .tile-tags {
  margin-bottom: 4px;
}

.tile-timestamp-stamp {
  position: relative;
  overflow: hidden;
  min-height: 100px;
  color: #fff;
  border: none;
}
.tile-timestamp-stamp .tile-overlay {
  color: #fff;
}
.tile-timestamp-stamp .tile-primary,
.tile-timestamp-stamp .tile-status {
  color: inherit;
  text-shadow: 0 1px 2px rgba(0, 0, 0, 0.3);
}

.tile-compact-chat .tile-avatar {
  width: 32px;
  height: 32px;
  font-size: 13px;
}

.tile-side-image-time-capsule .tile-cols .tile-col:first-child {
  border: 1px solid var(--tile-border, #eee);
  border-radius: 6px;
  padding: 8px;
}
.tile-side-image-time-capsule .tile-image {
  min-height: 60px;
}

.tile-multi-tag-end-node .tile-header {
  margin-bottom: 4px;
}
