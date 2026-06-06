/**
 * BNR Design System — 党政红色风（现代政务精细化版本）
 * 基于原 china-ui-styles 风格提炼，融合现代政务高精细度细节
 * ─────────────────────────────────────────────
 * 目录
 *  1. Reset & Base
 *  2. Design Tokens (重构色彩与阴影体系)
 *  3. Layout
 *  4. Topbar
 *  5. Sub Nav
 *  6. Breadcrumb
 *  7. Object Header
 *  8. Tabs
 *  9. Panel
 * 10. Field View
 * 11. Form Grid
 * 12. Buttons
 * 13. Badge / Tag
 * 14. Table
 * 15. Alert / Notice
 * 16. Status Bar
 * 17. Timeline
 * 18. Map Placeholder
 * 19. Tooltip Mark
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

/* ══════════════════════════════════════════════
   2. Design Tokens
   ══════════════════════════════════════════════ */
:root {
  /* -- Primary / 党政核心红 (微调为更沉稳的故宫红，避免刺眼) -- */
  --${namespace}-primary:          #BE0000;
  --${namespace}-primary-dark:     #8A0000;
  --${namespace}-primary-bg:       #FFF3F3; /* 温暖饱满的极浅红 */
  --${namespace}-primary-border:   #F5C2C2;
  --${namespace}-primary-hover:    #FCDADA;

  /* -- Gold accent / 党政辅助金 (微调为柔和雅致的香槟金) -- */
  --${namespace}-gold:             #F1C40F;
  --${namespace}-gold-dark:        #D4AC0D;

  /* -- Success (政务绿) -- */
  --${namespace}-success:          #196F3D;
  --${namespace}-success-dark:     #145A32;
  --${namespace}-success-bg:       #E8F5E9;
  --${namespace}-success-border:   #A3E4D7;

  /* -- Danger (警示红) -- */
  --${namespace}-danger:           #C0392B;
  --${namespace}-danger-dark:      #922B21;
  --${namespace}-danger-bg:        #FDEDEC;
  --${namespace}-danger-border:    #FADBD8;

  /* -- Warning (合规橙) -- */
  --${namespace}-warning:          #D35400;
  --${namespace}-warning-bg:       #FEF9E7;
  --${namespace}-warning-border:   #FAD7A0;

  /* -- Purple -- */
  --${namespace}-purple:           #7D3C98;
  --${namespace}-purple-bg:        #F5EEF8;
  --${namespace}-purple-border:    #D7BDE2;

  /* -- Teal -- */
  --${namespace}-teal:             #117A65;
  --${namespace}-teal-bg:          #E8F8F5;
  --${namespace}-teal-border:      #A3E4D7;

  /* -- Neutral text (温润泥土色系，比纯灰更有党政文献的厚重质感) -- */
  --${namespace}-text:             #2D2522;
  --${namespace}-text-muted:       #6E5F5A;
  --${namespace}-text-light:       #9C8C87;
  --${namespace}-text-disabled:    #C8BFBB;

  /* -- Neutral surface (宣纸微黄暖调，减轻视觉疲劳) -- */
  --${namespace}-border:           #C5BAB4;
  --${namespace}-border-light:     #E5DDD8;
  --${namespace}-bg:               #FFFFFF;
  --${namespace}-bg-page:          #F4F0EB;
  --${namespace}-bg-hover:         #FDF5F2;

  /* -- Typography -- */
  --${namespace}-font:   "PingFang SC", "Lantinghei SC", "Microsoft YaHei", "微软雅黑", SimSun, sans-serif;
  --${namespace}-mono:   Consolas, Menlo, Monaco, monospace;

  /* -- Spacing -- */
  --${namespace}-sp-xs:  4px;
  --${namespace}-sp-sm:  6px;
  --${namespace}-sp-md:  12px;
  --${namespace}-sp-lg:  16px;

  /* -- Radius -- */
  --${namespace}-radius-sm: 2px;
  --${namespace}-radius-md: 4px;

  /* -- Shadow -- */
  --${namespace}-shadow-inset: inset 0 1px 2px rgba(45,37,34,0.06);
  --${namespace}-shadow-sm: 0 1px 3px rgba(45,37,34,0.05), 0 1px 2px rgba(45,37,34,0.03);
  --${namespace}-shadow-md: 0 4px 12px rgba(138,0,0,0.06);

  /* Shortcuts (Keep alias mappings) */
  --${namespace}-p: #BE0000; --${namespace}-pd: #8A0000; --${namespace}-ph: #FCDADA;
  --${namespace}-pb: #FFF3F3; --${namespace}-pbd: #F5C2C2;
  --${namespace}-bl: #E5DDD8; --${namespace}-bd: #C5BAB4; --${namespace}-bg: #fff; --${namespace}-bgp: #F4F0EB;
  --${namespace}-t: #2D2522; --${namespace}-tm: #6E5F5A; --${namespace}-tl: #9C8C87;
  --${namespace}-rb: #FDEDEC; --${namespace}-ob: #FEF9E7;
}

/* ══════════════════════════════════════════════
   3. Layout
   ══════════════════════════════════════════════ */
.${namespace}-shell {
  display: flex;
  flex-direction: column;
  height: 100vh;
}

.${namespace}-main {
  display: flex;
  flex: 1;
  overflow: hidden;
}

/* Sidebar */
.${namespace}-sidebar {
  width: 185px;
  background: var(--${namespace}-bg);
  border-right: 1px solid var(--${namespace}-border-light);
  overflow-y: auto;
  flex-shrink: 0;
}

.${namespace}-toolbar {
  flex-shrink: 0;
  display: flex;
  align-items: center;
  gap: 8px;
  padding: 10px 14px;
  background: #fff;
  border-bottom: 1px solid var(--${namespace}-border-light);
}

.pt-toolbar > .pt-dp,
.pt-toolbar > .pt-dd,
.pt-toolbar > .pt-input,
.pt-toolbar > .pt-select {
  flex: 0 0 140px;
  min-width: 100px;
}

.${namespace}-nav-section {
  font-size: 11px;
  font-weight: 700;
  color: var(--${namespace}-text-muted);
  text-transform: uppercase;
  letter-spacing: .08em;
  padding: 10px 14px 4px;
  background: var(--${namespace}-bg-page);
  border-bottom: 1px solid var(--${namespace}-border-light);
}

.${namespace}-nav-item {
  padding: 9px 14px;
  font-size: 12px;
  cursor: pointer;
  border-bottom: 1px solid var(--${namespace}-border-light);
  color: var(--${namespace}-text);
  display: flex;
  align-items: center;
  justify-content: space-between;
  transition: all 0.15s ease;
}
.${namespace}-nav-item:hover { 
  background: var(--${namespace}-primary-bg); 
  color: var(--${namespace}-primary); 
}
.${namespace}-nav-item.${namespace}-active {
  background: var(--${namespace}-primary-bg);
  color: var(--${namespace}-primary-dark);
  font-weight: bold;
  border-left: 4px solid var(--${namespace}-primary);
  padding-left: 10px;
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
  gap: 10px;
  overflow-y: auto;
}

/* ══════════════════════════════════════════════
   4. Topbar (政务红色渐变头)
   ══════════════════════════════════════════════ */
.${namespace}-topbar {
  background: linear-gradient(135deg, #7A0000 0%, #A30000 45%, #BE0000 70%, #8A0000 100%);
  color: #fff;
  display: flex;
  align-items: center;
  padding: 0 20px;
  height: 50px;
  flex-shrink: 0;
  border-bottom: 3px solid var(--${namespace}-gold);
  position: relative;
  overflow: hidden;
  box-shadow: 0 3px 10px rgba(0,0,0,0.15);
}

/* 优化背景图案，使其呈现经典庄严的暗纹感 */
.${namespace}-topbar::before {
  content: '';
  position: absolute;
  inset: 0;
  background-image: radial-gradient(rgba(255, 255, 255, 0.04) 15%, transparent 16%);
  background-size: 24px 24px;
  pointer-events: none;
}

.${namespace}-logo {
  font-size: 15px;
  font-weight: bold;
  letter-spacing: 1.5px;
  padding-right: 16px;
  border-right: 1px solid rgba(255,255,255,.2);
  margin-right: 16px;
  white-space: nowrap;
  flex-shrink: 0;
  text-shadow: 0 1px 3px rgba(0,0,0,0.3);
}
.${namespace}-logo em { 
  color: var(--${namespace}-gold); 
  font-style: normal; 
  font-weight: 800;
}

/* Top navigation item */
.${namespace}-tnav {
  padding: 0 16px;
  height: 50px;
  display: flex;
  align-items: center;
  font-size: 13px;
  font-weight: 500;
  cursor: pointer;
  color: rgba(255,255,255,.85);
  border-bottom: 3px solid transparent;
  white-space: nowrap;
  transition: all 0.2s ease;
}
.${namespace}-tnav:hover { 
  background: rgba(255,255,255,.08); 
  color: #fff;
}
.${namespace}-tnav.${namespace}-active {
  background: rgba(255,255,255,.12);
  color: #fff;
  border-bottom-color: var(--${namespace}-gold);
  font-weight: bold;
}

/* Topbar right slot */
.${namespace}-topbar-right {
  margin-left: auto;
  display: flex;
  align-items: center;
  gap: 14px;
  font-size: 12px;
  color: rgba(255, 255, 255, 0.9);
  flex-shrink: 0;
}
.${namespace}-topbar-right span { 
  cursor: pointer; 
  transition: color 0.2s;
}
.${namespace}-topbar-right span:hover { 
  color: var(--${namespace}-gold); 
}

/* Clock (数字钟政务规范) */
.${namespace}-clock {
  background: rgba(0,0,0,0.25);
  padding: 3px 10px;
  font-family: var(--${namespace}-mono);
  letter-spacing: .5px;
  border-radius: var(--${namespace}-radius-sm);
  border: 1px solid rgba(255,255,255,0.1);
}

/* ══════════════════════════════════════════════
   5. Sub Nav (辅助深红带)
   ══════════════════════════════════════════════ */
.${namespace}-sub-nav {
  background: #900000;
  display: flex;
  align-items: center;
  border-bottom: 2px solid var(--${namespace}-gold-dark);
  flex-shrink: 0;
  box-shadow: 0 2px 5px rgba(0,0,0,0.08);
}
.${namespace}-sub-nav-item {
  padding: 0 20px;
  height: 38px;
  line-height: 38px;
  font-size: 13px;
  font-weight: 500;
  color: rgba(255,255,255,.9);
  text-decoration: none;
  border-right: 1px solid rgba(255,255,255,.08);
  transition: all 0.2s;
  cursor: pointer;
  white-space: nowrap;
}
.${namespace}-sub-nav-item:hover,
.${namespace}-sub-nav-item.${namespace}-active {
  background: rgba(255,215,0,.15);
  color: var(--${namespace}-gold);
  font-weight: bold;
}

/* ══════════════════════════════════════════════
   6. Breadcrumb
   ══════════════════════════════════════════════ */
.${namespace}-breadcrumb {
  background: var(--${namespace}-bg);
  padding: 0 var(--${namespace}-lg, 16px);
  height: 32px;
  display: flex;
  align-items: center;
  gap: 6px;
  font-size: 12px;
  color: var(--${namespace}-text-muted);
  border-bottom: 1px solid var(--${namespace}-border-light);
  flex-shrink: 0;
}
.${namespace}-breadcrumb a { 
  color: var(--${namespace}-primary-dark); 
  font-weight: 500;
  cursor: pointer; 
}
.${namespace}-breadcrumb a:hover { 
  color: var(--${namespace}-primary);
  text-decoration: underline; 
}

/* ── 记录导航 (经典翻页组) ── */
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
  height: 24px;
  padding: 0 10px;
  border: 1px solid var(--${namespace}-border-light);
  background: var(--${namespace}-bg);
  color: var(--${namespace}-text-muted);
  font-size: 11px;
  font-family: var(--${namespace}-font);
  cursor: pointer;
  white-space: nowrap;
  transition: all 0.15s ease;
}

.${namespace}-rn-btn:first-of-type {
  border-radius: var(--${namespace}-radius-sm) 0 0 var(--${namespace}-radius-sm);
}

.${namespace}-rn-btn:last-of-type {
  border-radius: 0 var(--${namespace}-radius-sm) var(--${namespace}-radius-sm) 0;
}

.${namespace}-rn-btn:hover:not(:disabled) {
  color: var(--${namespace}-primary-dark);
  background: var(--${namespace}-primary-bg);
  border-color: var(--${namespace}-primary-border);
  z-index: 2;
}

.${namespace}-rn-btn:active:not(:disabled) {
  background: var(--${namespace}-primary-hover);
}

.${namespace}-rn-btn:disabled {
  opacity: 0.4;
  cursor: not-allowed;
  background: #F4F1EE;
}

.${namespace}-rn-arrow {
  font-size: 10px;
  transition: transform 0.15s ease;
  opacity: 0.7;
}

.${namespace}-rn-btn:hover:not(:disabled) .${namespace}-rn-arrow {
  opacity: 1;
}

.${namespace}-rn-arrow--left  { margin-right: 1px; }
.${namespace}-rn-arrow--right { margin-left: 1px; }

.${namespace}-rn-btn:hover:not(:disabled) .${namespace}-rn-arrow--left  { transform: translateX(-2px); }
.${namespace}-rn-btn:hover:not(:disabled) .${namespace}-rn-arrow--right { transform: translateX(2px); }

.${namespace}-rn-idx {
  display: flex;
  align-items: center;
  justify-content: center;
  height: 24px;
  min-width: 44px;
  padding: 0 8px;
  font-size: 11px;
  font-family: var(--${namespace}-mono);
  color: var(--${namespace}-text-muted);
  background: #FAF8F5;
  border-top: 1px solid var(--${namespace}-border-light);
  border-bottom: 1px solid var(--${namespace}-border-light);
  user-select: none;
}

/* ══════════════════════════════════════════════
   7. Object Header (红底暖调摘要栏)
   ══════════════════════════════════════════════ */
.${namespace}-obj-head {
  background: linear-gradient(180deg, var(--${namespace}-primary-bg) 0%, #FFF5F5 100%);
  border-bottom: 1px solid var(--${namespace}-primary-border);
  padding: 10px var(--${namespace}-lg, 16px);
  display: flex;
  align-items: center;
  gap: 16px;
  flex-shrink: 0;
}

.${namespace}-obj-icon {
  width: 42px;
  height: 42px;
  border-radius: var(--${namespace}-radius-md);
  background: var(--${namespace}-primary);
  color: var(--${namespace}-gold);
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 20px;
  font-weight: bold;
  flex-shrink: 0;
  border: 1px solid var(--${namespace}-primary-dark);
  box-shadow: 0 2px 6px rgba(138,0,0,0.2);
}

.${namespace}-obj-title {
  font-size: 18px;
  font-weight: 700;
  color: var(--${namespace}-primary-dark);
  letter-spacing: .5px;
}
.${namespace}-obj-id {
  font-family: var(--${namespace}-mono);
  font-size: 13px;
  color: var(--${namespace}-primary);
  font-weight: bold;
  margin-top: 3px;
}
.${namespace}-obj-meta {
  font-size: 12px;
  color: var(--${namespace}-text-muted);
  margin-top: 4px;
  display: flex;
  gap: 14px;
  flex-wrap: wrap;
}
.${namespace}-obj-meta span { display: flex; align-items: center; gap: 4px; }

.${namespace}-obj-status {
  margin-left: auto;
  display: flex;
  flex-direction: column;
  align-items: flex-end;
  gap: 6px;
  flex-shrink: 0;
}
.${namespace}-obj-actions { display: flex; gap: 6px; align-items: center; }

/* Status chips */
.${namespace}-status-chip {
  padding: 4px 14px;
  font-size: 12px;
  font-weight: bold;
  border: 1px solid;
  border-radius: var(--${namespace}-radius-sm);
  text-align: center;
  min-width: 72px;
  box-shadow: var(--${namespace}-shadow-sm);
}
.${namespace}-status-active   { background: var(--${namespace}-success-bg);  color: var(--${namespace}-success);  border-color: var(--${namespace}-success-border); }
.${namespace}-status-inactive { background: #F5EFEB;               color: var(--${namespace}-text-muted); border-color: var(--${namespace}-border); }
.${namespace}-status-pending  { background: var(--${namespace}-warning-bg);  color: var(--${namespace}-warning);  border-color: var(--${namespace}-warning-border); }

/* ══════════════════════════════════════════════
   8. Tabs
   ══════════════════════════════════════════════ */
.${namespace}-tabs {
  display: flex;
  background: var(--${namespace}-bg);
  border-bottom: 2px solid var(--${namespace}-primary);
  flex-shrink: 0;
}
.${namespace}-tab {
  padding: 8px 18px;
  font-size: 12px;
  font-weight: 500;
  cursor: pointer;
  color: var(--${namespace}-text-muted);
  border-right: 1px solid var(--${namespace}-border-light);
  display: flex;
  align-items: center;
  gap: 5px;
  white-space: nowrap;
  transition: all 0.15s ease;
}
.${namespace}-tab:hover { 
  background: var(--${namespace}-primary-bg); 
  color: var(--${namespace}-primary-dark); 
}
.${namespace}-tab.${namespace}-active { 
  background: var(--${namespace}-primary); 
  color: #fff; 
  font-weight: bold; 
}

/* Tab badge */
.${namespace}-tab-badge {
  background: var(--${namespace}-primary-dark);
  color: var(--${namespace}-gold);
  font-size: 10px;
  padding: 1px 5px;
  border-radius: 10px;
  margin-left: 2px;
}
.${namespace}-tab.${namespace}-active .${namespace}-tab-badge { background: rgba(255,255,255,0.25); }

.${namespace}-tabs-right {
  margin-left: auto;
  padding: 4px 12px;
  display: flex;
  gap: 6px;
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
   9. Panel (左红带经典面板)
   ══════════════════════════════════════════════ */
.${namespace}-panel {
  background: var(--${namespace}-bg);
  border: 1px solid var(--${namespace}-border);
  box-shadow: var(--${namespace}-shadow-sm);
  border-radius: var(--${namespace}-radius-sm);
}

/* Panel header */
.${namespace}-panel-head {
  background: var(--${namespace}-primary-bg);
  color: var(--${namespace}-primary-dark);
  padding: 8px 12px;
  font-size: 13px;
  font-weight: bold;
  border-bottom: 1px solid var(--${namespace}-primary-border);
  display: flex;
  align-items: center;
  gap: 6px;
}

/* Left accent bar — 4px 红色 (政务标准标题指示器) */
.${namespace}-panel-head::before {
  content: '';
  width: 4px;
  height: 14px;
  background: var(--${namespace}-primary);
  display: inline-block;
  flex-shrink: 0;
  border-radius: var(--${namespace}-radius-sm);
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
  color: var(--${namespace}-success-dark);
  border-bottom-color: var(--${namespace}-success-border);
}
.${namespace}-panel-head--success::before { background: var(--${namespace}-success); }

.${namespace}-panel-head--danger {
  background: var(--${namespace}-danger-bg);
  color: var(--${namespace}-danger-dark);
  border-bottom-color: var(--${namespace}-danger-border);
}
.${namespace}-panel-head--danger::before { background: var(--${namespace}-danger); }

.${namespace}-panel-head-right {
  margin-left: auto;
  display: flex;
  gap: 6px;
  align-items: center;
  font-weight: normal;
}

/* ══════════════════════════════════════════════
   10. Field View (高密度只读数据网格)
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
  min-height: 32px;
}

.${namespace}-fview    > .${namespace}-fv:nth-child(4n) { border-right: none; }
.${namespace}-fview--2 > .${namespace}-fv:nth-child(2n) { border-right: none; }
.${namespace}-fview--3 > .${namespace}-fv:nth-child(3n) { border-right: none; }
.${namespace}-fview--6 > .${namespace}-fv:nth-child(6n) { border-right: none; }

.${namespace}-fv--span2 { grid-column: span 2; }
.${namespace}-fv--span3 { grid-column: span 3; }
.${namespace}-fv--span4 { grid-column: span 4; border-right: none; }

/* 政务规范：左侧淡灰红色标题栏，右侧白底数据栏 */
.${namespace}-fv-label {
  width: 95px;
  flex-shrink: 0;
  background: #FAF6F3;
  color: var(--${namespace}-text-muted);
  font-size: 11px;
  font-weight: 600;
  padding: 6px 10px;
  border-right: 1px solid var(--${namespace}-border-light);
  display: flex;
  align-items: center;
  line-height: 1.5;
}
.${namespace}-fv-val {
  flex: 1;
  padding: 6px 10px;
  font-size: 12px;
  color: var(--${namespace}-text);
  background: #FFF;
  display: flex;
  align-items: center;
  min-width: 0;
  word-break: break-all;
  line-height: 1.5;
}
.${namespace}-fv-val--mono    { font-family: var(--${namespace}-mono); }
.${namespace}-fv-val--bold    { font-weight: 700; color: var(--${namespace}-primary-dark); }
.${namespace}-fv-val--success { color: var(--${namespace}-success-dark); font-weight: 700; }
.${namespace}-fv-val--danger  { color: var(--${namespace}-danger); font-weight: 700; }
.${namespace}-fv-val--link    { color: var(--${namespace}-primary); cursor: pointer; text-decoration: underline; font-weight: 500; }

/* ══════════════════════════════════════════════
   11. Form Grid (高精度政务表单)
   ══════════════════════════════════════════════ */
.${namespace}-form {
  display: grid;
  grid-template-columns: repeat(4, 1fr);
  gap: 6px 12px;
  padding: 10px 14px;
}
.${namespace}-form--2 { grid-template-columns: repeat(2, 1fr); }
.${namespace}-form--3 { grid-template-columns: repeat(3, 1fr); }

.${namespace}-field {
  display: flex;
  align-items: center;
  gap: 6px;
  font-size: 12px;
  min-width: 0;
}

.${namespace}-field--span2 { grid-column: span 2; }
.${namespace}-field--span3 { grid-column: span 3; }
.${namespace}-field--span4 { grid-column: span 4; }

.${namespace}-field-label {
  width: 85px;
  color: var(--${namespace}-text-muted);
  font-weight: 600;
  flex-shrink: 0;
  white-space: nowrap;
}
.${namespace}-field-label--w1 { width: 98px; }
.${namespace}-field-label--w2 { width: 114px; }

.${namespace}-field-label--required::before { 
  content: "* "; 
  color: var(--${namespace}-danger); 
  font-weight: bold;
}

/* 极致拟物灰度边框与聚焦外发光 */
.${namespace}-input,
.${namespace}-select,
.${namespace}-textarea {
  flex: 1;
  height: 26px;
  border: 1px solid var(--${namespace}-border);
  font-size: 12px;
  font-family: var(--${namespace}-font);
  padding: 0 8px;
  background: var(--${namespace}-bg);
  color: var(--${namespace}-text);
  outline: none;
  min-width: 80px;
  border-radius: var(--${namespace}-radius-sm);
  transition: border-color 0.15s, box-shadow 0.15s;
  box-shadow: var(--${namespace}-shadow-inset);
}
.${namespace}-input:focus,
.${namespace}-select:focus,
.${namespace}-textarea:focus  { 
  border-color: var(--${namespace}-primary); 
  box-shadow: var(--${namespace}-shadow-inset), 0 0 0 3px rgba(190,0,0,0.15); 
}

.${namespace}-input--readonly { 
  background: #F4F1EE; 
  color: var(--${namespace}-text-muted); 
  box-shadow: none;
}
.${namespace}-input--mono     { font-family: var(--${namespace}-mono); }
.${namespace}-input--error,
.${namespace}-select--error   { 
  border-color: var(--${namespace}-danger) !important; 
  background: var(--${namespace}-danger-bg) !important; 
}

.${namespace}-field-unit {
  font-size: 11px;
  color: var(--${namespace}-text-muted);
  margin-left: 4px;
}

.${namespace}-textarea {
  height: auto;
  padding: 5px 8px;
  resize: vertical;
}

.${namespace}-input::placeholder,
.${namespace}-textarea::placeholder {
  color: var(--${namespace}-text-disabled);
  opacity: 1;
}

.${namespace}-field:has(.${namespace}-textarea) {
  align-items: flex-start;
}
.${namespace}-field:has(.${namespace}-textarea) .${namespace}-field-label {
  margin-top: 5px;
}

/* Form section subheading (左红条小标题) */
.${namespace}-form-section {
  grid-column: 1 / -1;
  font-size: 12px;
  font-weight: bold;
  color: var(--${namespace}-primary-dark);
  padding: 4px 0 3px 8px;
  border-left: 4px solid var(--${namespace}-primary);
  margin: 6px 0 2px;
  background-color: var(--${namespace}-primary-bg);
}

.${namespace}-form-divider {
  grid-column: 1 / -1;
  border: none;
  border-top: 1px dashed var(--${namespace}-border-light);
  margin: 4px 0;
}

/* Edit mode hint bar (黄色提示语) */
.${namespace}-edit-bar {
  background: #FFFDE7;
  border: 1px solid var(--${namespace}-gold-dark);
  border-left: 4px solid var(--${namespace}-gold-dark);
  padding: 6px 12px;
  margin: 10px;
  display: flex;
  align-items: center;
  gap: 8px;
  font-size: 12px;
  font-weight: 500;
  color: #7A6000;
  border-radius: 0 var(--${namespace}-radius-sm) var(--${namespace}-radius-sm) 0;
  box-shadow: var(--${namespace}-shadow-sm);
}

.${namespace}-form-footer {
  z-index: 100;
  padding: 10px 14px; 
  background: #fff; 
  border-top: 2px solid var(--${namespace}-primary); 
  box-shadow: 0 -2px 8px rgba(0,0,0,.08); 
  display: flex;
  height: 50px;
}

/* ══════════════════════════════════════════════
   12. Buttons (微立体高拟物度按钮)
   ══════════════════════════════════════════════ */
.${namespace}-btn {
  height: 26px;
  padding: 0 12px;
  font-size: 12px;
  font-weight: 500;
  font-family: var(--${namespace}-font);
  border: 1px solid;
  cursor: pointer;
  display: inline-flex;
  align-items: center;
  gap: 4px;
  white-space: nowrap;
  border-radius: var(--${namespace}-radius-sm);
  transition: all 0.15s ease;
  box-shadow: var(--${namespace}-shadow-sm);
}
.${namespace}-btn:disabled { opacity: .5; cursor: not-allowed; box-shadow: none; }

/* Variants */
.${namespace}-btn--primary {
  background: linear-gradient(180deg, #E60000 0%, var(--${namespace}-primary) 100%);
  color: #fff;
  border-color: var(--${namespace}-primary-dark);
}
.${namespace}-btn--primary:hover { background: var(--${namespace}-primary-dark); }

.${namespace}-btn--success {
  background: linear-gradient(180deg, #239B56 0%, var(--${namespace}-success) 100%);
  color: #fff;
  border-color: var(--${namespace}-success-dark);
}
.${namespace}-btn--success:hover { background: var(--${namespace}-success-dark); }

.${namespace}-btn--warning {
  background: linear-gradient(180deg, #E59866 0%, var(--${namespace}-warning) 100%);
  color: #fff;
  border-color: #B25900;
}
.${namespace}-btn--warning:hover { background: #A04000; }

.${namespace}-btn--danger {
  background: linear-gradient(180deg, #EC7063 0%, var(--${namespace}-danger) 100%);
  color: #fff;
  border-color: var(--${namespace}-danger-dark);
}
.${namespace}-btn--danger:hover { background: var(--${namespace}-danger-dark); }

.${namespace}-btn--default {
  background: linear-gradient(180deg, #FFFFFF 0%, #F5EFEB 100%);
  color: var(--${namespace}-text);
  border-color: var(--${namespace}-border);
}
.${namespace}-btn--default:hover { 
  background: var(--${namespace}-primary-bg); 
  border-color: var(--${namespace}-primary-border);
  color: var(--${namespace}-primary-dark);
}

.${namespace}-btn--purple {
  background: linear-gradient(180deg, #AF7AC5 0%, var(--${namespace}-purple) 100%);
  color: #fff;
  border-color: #5B2C6F;
}

/* Sizes */
.${namespace}-btn--sm { height: 22px; padding: 0 8px; font-size: 11px; }
.${namespace}-btn--lg { height: 32px; padding: 0 16px; font-size: 13px; font-weight: bold; }

.${namespace}-btn-gap {
  margin-left: 8px;
}

/* ══════════════════════════════════════════════
   13. Badge / Tag (高饱和度标签)
   ══════════════════════════════════════════════ */
.${namespace}-tag {
  display: inline-block;
  padding: 2px 6px;
  font-size: 10px;
  font-weight: bold;
  border-radius: var(--${namespace}-radius-sm);
  border: 1px solid;
  white-space: nowrap;
  line-height: 1.2;
}

.${namespace}-tag--success { background: var(--${namespace}-success-bg); color: var(--${namespace}-success-dark); border-color: var(--${namespace}-success-border); }
.${namespace}-tag--danger  { background: var(--${namespace}-danger-bg);  color: var(--${namespace}-danger-dark);  border-color: var(--${namespace}-danger-border);  }
.${namespace}-tag--warning { background: var(--${namespace}-warning-bg); color: #9A5B00;                  border-color: var(--${namespace}-warning-border); }
.${namespace}-tag--primary { background: var(--${namespace}-primary-bg); color: var(--${namespace}-primary-dark);  border-color: var(--${namespace}-primary-border); }
.${namespace}-tag--neutral { background: #F5EFEB;               color: var(--${namespace}-text-muted);   border-color: var(--${namespace}-border); }
.${namespace}-tag--purple  { background: var(--${namespace}-purple-bg);  color: #512E5F;                border-color: var(--${namespace}-purple-border);  }
.${namespace}-tag--teal    { background: var(--${namespace}-teal-bg);    color: #0B5345;                border-color: var(--${namespace}-teal-border);    }

/* ══════════════════════════════════════════════
   14. Table (数据列表/表格)
   ══════════════════════════════════════════════ */
.${namespace}-table {
  width: 100%;
  border-collapse: collapse;
  font-size: 12px;
  table-layout: fixed;
}
.${namespace}-table thead th {
  padding: 7px 8px;
  font-weight: 700;
  color: var(--${namespace}-primary-dark);
  border: 1px solid var(--${namespace}-primary-border);
  text-align: center;
  background-color: var(--${namespace}-primary-bg);
  white-space: nowrap;
}
.${namespace}-table tbody td {
  padding: 6px 8px;
  border: 1px solid var(--${namespace}-border-light);
  white-space: nowrap;
  overflow: hidden;
  text-overflow: ellipsis;
  color: var(--${namespace}-text);
  transition: background-color 0.15s;
}
/* 条纹背景 */
.${namespace}-table tbody tr:nth-child(even) { background-color: #FAF8F5; }
.${namespace}-table tbody tr:hover           { background-color: #FFF3F3; }
.${namespace}-table tbody tr.${namespace}-row-selected { background-color: #FCDADA; }

.${namespace}-cell-center { text-align: center; }
.${namespace}-cell-right  { text-align: right; font-family: var(--${namespace}-mono); }

/* ══════════════════════════════════════════════
   15. Alert / Notice (通知公告)
   ══════════════════════════════════════════════ */
.${namespace}-alert {
  padding: 6px 14px;
  font-size: 11px;
  font-weight: 500;
  display: flex;
  align-items: center;
  gap: 8px;
  flex-shrink: 0;
  border-bottom: 1px solid;
}
.${namespace}-alert--warning {
  background: #FFFDE7;
  color: #7A6000;
  border-color: var(--${namespace}-gold);
  border-left: 4px solid var(--${namespace}-gold-dark);
}
.${namespace}-alert--danger {
  background: var(--${namespace}-danger-bg);
  color: var(--${namespace}-danger-dark);
  border-color: var(--${namespace}-danger-border);
  border-left: 4px solid var(--${namespace}-danger);
}
.${namespace}-alert--success {
  background: var(--${namespace}-success-bg);
  color: var(--${namespace}-success-dark);
  border-color: var(--${namespace}-success-border);
  border-left: 4px solid var(--${namespace}-success);
}

/* ── 公告栏 ── */
.${namespace}-notice {
  background: #FFFDE7;
  border: 1px solid var(--${namespace}-gold-dark);
  border-left: 4px solid var(--${namespace}-gold-dark);
  padding: 10px 16px;
  margin: var(--${namespace}-sp-lg);
  font-size: 12px;
  font-weight: 500;
  color: #7A6000;
  display: flex;
  align-items: center;
  gap: 10px;
  border-radius: 0 var(--${namespace}-radius-sm) var(--${namespace}-radius-sm) 0;
  box-shadow: var(--${namespace}-shadow-sm);
}

/* ══════════════════════════════════════════════
   16. Status Bar
   ══════════════════════════════════════════════ */
.${namespace}-statusbar {
  background: var(--${namespace}-primary-bg);
  border-top: 1px solid var(--${namespace}-primary-border);
  padding: 4px 14px;
  font-size: 11px;
  color: var(--${namespace}-text-muted);
  display: flex;
  gap: 16px;
  align-items: center;
  flex-shrink: 0;
}
.${namespace}-status-dot {
  width: 8px;
  height: 8px;
  border-radius: 50%;
  display: inline-block;
  margin-right: 4px;
  vertical-align: middle;
}

/* ══════════════════════════════════════════════
   17. Timeline (发展历程/审批流时间轴)
   ══════════════════════════════════════════════ */
.${namespace}-timeline { padding: 10px 14px; }

.${namespace}-tl-item {
  display: flex;
  gap: 12px;
  position: relative;
  padding-bottom: 12px;
}
.${namespace}-tl-item::before {
  content: '';
  position: absolute;
  left: 7px;
  top: 18px;
  bottom: 0;
  width: 2px;
  background: var(--${namespace}-primary-border);
}
.${namespace}-tl-item:last-child::before { display: none; }

.${namespace}-tl-dot {
  width: 16px;
  height: 16px;
  border-radius: 50%;
  border: 3px solid #fff;
  box-shadow: var(--${namespace}-shadow-sm);
  flex-shrink: 0;
  margin-top: 2px;
  position: relative;
  z-index: 1;
}
.${namespace}-tl-dot--primary { background: var(--${namespace}-primary); }
.${namespace}-tl-dot--success { background: var(--${namespace}-success); }
.${namespace}-tl-dot--danger  { background: var(--${namespace}-danger);  }
.${namespace}-tl-dot--warning { background: var(--${namespace}-warning); }
.${namespace}-tl-dot--neutral { background: var(--${namespace}-text-disabled); }

.${namespace}-tl-body  { flex: 1; min-width: 0; }
.${namespace}-tl-head  { display: flex; align-items: baseline; gap: 8px; margin-bottom: 3px; }
.${namespace}-tl-title { font-size: 12px; font-weight: 700; color: var(--${namespace}-text-title); }
.${namespace}-tl-by    { font-size: 11px; color: var(--${namespace}-text-muted); }
.${namespace}-tl-time  { font-size: 11px; color: var(--${namespace}-text-light); flex-shrink: 0; white-space: nowrap; font-family: var(--${namespace}-mono); }
.${namespace}-tl-desc  { font-size: 11px; color: var(--${namespace}-text-muted); line-height: 1.8; }

/* ══════════════════════════════════════════════
   18. Map Placeholder
   ══════════════════════════════════════════════ */
.${namespace}-map-placeholder {
  background: linear-gradient(135deg, #FFF3F3 0%, #FFF5F5 40%, #FFF9F9 100%);
  border: 1px solid var(--${namespace}-primary-border);
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  gap: 8px;
  color: var(--${namespace}-primary-dark);
  font-size: 12px;
  position: relative;
  overflow: hidden;
}
.${namespace}-map-placeholder::before {
  content: '';
  position: absolute;
  inset: 0;
  background:
    repeating-linear-gradient(0deg, transparent, transparent 30px, rgba(190,0,0,.03) 30px, rgba(190,0,0,.03) 31px),
    repeating-linear-gradient(90deg, transparent, transparent 30px, rgba(190,0,0,.03) 30px, rgba(190,0,0,.03) 31px);
}
.${namespace}-map-pin-icon  { font-size: 32px; position: relative; z-index: 1; filter: drop-shadow(0 2px 4px rgba(138,0,0,0.3)); }
.${namespace}-map-addr      { font-weight: bold; position: relative; z-index: 1; color: var(--${namespace}-primary-dark); }
.${namespace}-map-pin-dot {
  width: 14px;
  height: 14px;
  border-radius: 50%;
  background: var(--${namespace}-primary);
  border: 3px solid #fff;
  box-shadow: 0 0 0 4px rgba(190,0,0,0.25);
  position: absolute;
  top: 45%;
  left: 55%;
  z-index: 2;
}

/* ══════════════════════════════════════════════
   19. Tooltip Mark
   ══════════════════════════════════════════════ */
.${namespace}-tooltip-mark {
  display: inline-block;
  width: 15px;
  height: 15px;
  border-radius: 50%;
  background: var(--${namespace}-primary);
  color: #fff;
  font-size: 10px;
  font-weight: bold;
  text-align: center;
  line-height: 15px;
  cursor: help;
  margin-left: 4px;
  flex-shrink: 0;
  box-shadow: var(--${namespace}-shadow-sm);
}
