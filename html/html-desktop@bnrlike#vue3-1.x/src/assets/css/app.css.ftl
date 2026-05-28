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
  text-align: right;
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
  min-width: 0;
}
.${namespace}-input:focus,
.${namespace}-select:focus,
.${namespace}-textarea:focus  { border-color: var(--${namespace}-primary); box-shadow: 0 0 0 2px rgba(26,79,138,.08); }

.${namespace}-input--readonly { background: #f5f7fa; color: var(--${namespace}-text-muted); }
.${namespace}-input--mono     { font-family: var(--${namespace}-mono); }
.${namespace}-input--error,
.${namespace}-select--error   { border-color: var(--${namespace}-danger) !important; background: var(--${namespace}-danger-bg); }

.${namespace}-textarea {
  height: auto;
  padding: 3px 5px;
  resize: vertical;
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
