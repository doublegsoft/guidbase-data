/**
 * Protocol Explorer Engineering Design System
 * 协议探索器 · 极客工程设计系统 (底部固定操作条重构版)
 * ─────────────────────────────────────────────
 * 目录
 *  1. Reset & Global Base
 *  2. Design Tokens (1:1 原版网络工程变量)
 *  3. Layout — Shell / Main / 高对比度清晰 Sidebar / Content / Page
 *  4. Topbar & Header Dashboard
 *  5. Breadcrumb & Record Navigation
 *  6. Object Header (Protocol Title & Status)
 *  7. Tabs & Filter Pills (带计数胶囊)
 *  8. Panel (直角墨水线框容器)
 *  9. Field View (精细 1px 单边框只读网格)
 * 10. Form Grid & Input Controls (左右两列式表单布局)
 * 11. Buttons & 固定底部操作栏 (Fixed Footer & Right-Aligned Buttons)
 * 12. Badge, Tag & Number Badges
 * 13. Table (协议数据包时序网格)
 * 14. Alert & Toast System (侧边色条弹窗)
 * 15. Status Bar & Telemetry Strip
 * 16. Timeline & Stepper (带虚线连接器的步骤条)
 * 17. Sequence & Network Topology Viewport
 * 18. Tooltip Mark & Hover Hints
 * 19. Official Document & Form
 * 20. Letter Component
 * 21. KPI Card & RTT Bars (微型柱状图与遥测卡)
 * 22. 24-Column Grid System & Responsive
 * 23. Tile Component Library 包含引入
 * ─────────────────────────────────────────────
 */

/* ══════════════════════════════════════════════
   1. Reset & Global Base
   ══════════════════════════════════════════════ */
*, *::before, *::after {
  box-sizing: border-box;
  margin: 0;
  padding: 0;
}

html, body {
  height: 100%;
  font-family: var(--${namespace}-f);
  font-size: 14px;
  line-height: 1.5;
  color: var(--${namespace}-ink);
  background: var(--${namespace}-bg);
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  overflow: hidden;
}

/* ══════════════════════════════════════════════
   2. Design Tokens (1:1 提取自 Protocol Explorer)
   ══════════════════════════════════════════════ */
:root {
  /* 基础底色与墨水线框 */
  --${namespace}-bg:               #f4f6fb;
  --${namespace}-pn:               #ffffff;
  --${namespace}-ink:              #0a2a9a;
  --${namespace}-mu:               #475569;  /* 提高次要文字饱和度与灰阶深度 */
  --${namespace}-ln:               #d3dbef;
  --${namespace}-pri:              #0a2fb5;
  --${namespace}-on:               #ffffff;

  /* 核心协议四色语义 */
  --${namespace}-tcp:              #13a05d;  /* TCP 连接绿 */
  --${namespace}-cmd:              #f0a500;  /* 命令/交互橙黄 */
  --${namespace}-rsp:              #7b5ce5;  /* 应答紫色 */
  --${namespace}-dat:              #2b6af0;  /* 数据/载荷蓝 */

  /* 状态与告警色 */
  --${namespace}-sel:              #fdecee;
  --${namespace}-red:              #d6343e;
  --${namespace}-ok:               #dff4e8;

  /* 字体规范：IBM Plex Mono 优先 */
  --${namespace}-f: "IBM Plex Mono", "Noto Sans Mono CJK SC", "PingFang SC", "Microsoft YaHei", monospace;

  /* 映射回原系统变量，确保业务组件平滑兼容 */
  --${namespace}-primary:          var(--${namespace}-pri);
  --${namespace}-primary-dark:     #081e74;
  --${namespace}-primary-bg:       color-mix(in srgb, var(--${namespace}-pri) 10%, transparent);
  --${namespace}-primary-border:   var(--${namespace}-ln);
  --${namespace}-text:             var(--${namespace}-ink);
  --${namespace}-text-muted:       var(--${namespace}-mu);
  --${namespace}-text-light:       var(--${namespace}-mu);
  --${namespace}-border:           var(--${namespace}-ln);
  --${namespace}-border-light:     var(--${namespace}-ln);
  --${namespace}-success:          var(--${namespace}-tcp);
  --${namespace}-warning:          var(--${namespace}-cmd);
  --${namespace}-danger:           var(--${namespace}-red);
}

/* 暗色主题适配 (Dark Mode) */
:root[data-theme="dark"], body[data-theme="dark"] {
  --${namespace}-bg:  #080d22;
  --${namespace}-pn:  #0f1630;
  --${namespace}-ink: #9db6ff;
  --${namespace}-mu:  #94a3b8;
  --${namespace}-ln:  #26316b;
  --${namespace}-pri: #3d65ff;
  --${namespace}-ok:  #10321f;
  --${namespace}-sel: #2b1420;
  --${namespace}-red: #ff6b74;
}

/* ══════════════════════════════════════════════
   3. Layout — Shell / Main / 高对比度清晰 Sidebar
   ══════════════════════════════════════════════ */
.${namespace}-shell {
  display: flex;
  flex-direction: column;
  height: 100vh;
  background: var(--${namespace}-bg);
}

.${namespace}-main {
  display: flex;
  flex: 1;
  overflow: hidden;
  padding: 14px 16px;
  gap: 14px;
}

/* 侧边栏：340px 稳固仪器控制台 */
.${namespace}-sidebar {
  width: 340px;
  background: var(--${namespace}-pn);
  border: 1px solid var(--${namespace}-ln);
  display: flex;
  flex-direction: column;
  overflow-y: auto;
  overflow-x: hidden;
  flex-shrink: 0;
  box-shadow: 2px 0 8px rgba(10, 42, 154, 0.04);
}

.${namespace}-sidebar-head {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 14px 16px 10px;
  background: var(--${namespace}-pn);
  flex-shrink: 0;
}
.${namespace}-sidebar-head h2 {
  font-size: 16px;
  font-weight: 800;
  letter-spacing: .12em;
  color: var(--${namespace}-ink);
  text-transform: uppercase;
  margin: 0;
}
.${namespace}-sidebar-head .${namespace}-dots {
  color: var(--${namespace}-ink);
  letter-spacing: 2px;
  font-size: 14px;
  font-weight: bold;
  cursor: pointer;
}

.${namespace}-sidebar-tabs {
  display: flex;
  border: 1px solid var(--${namespace}-ln);
  margin: 0 14px 10px;
  background: var(--${namespace}-pn);
  flex-shrink: 0;
}
.${namespace}-sidebar-tabs b {
  flex: 1;
  text-align: center;
  padding: 8px 4px;
  cursor: pointer;
  border-bottom: 3px solid transparent;
  font-weight: 700;
  font-size: 12px;
  white-space: nowrap;
  color: var(--${namespace}-mu);
  transition: .15s;
}
.${namespace}-sidebar-tabs b:hover {
  color: var(--${namespace}-ink);
  background: color-mix(in srgb, var(--${namespace}-ln) 30%, transparent);
}
.${namespace}-sidebar-tabs b.on {
  color: var(--${namespace}-pri);
  border-bottom-color: var(--${namespace}-pri);
}
.${namespace}-sidebar-tabs .cnt {
  font-style: normal;
  font-size: 11px;
  font-weight: 700;
  background: var(--${namespace}-ln);
  color: var(--${namespace}-ink);
  padding: 0 6px;
  margin-left: 4px;
  border-radius: 9px;
}
.${namespace}-sidebar-tabs b.on .cnt {
  background: var(--${namespace}-pri);
  color: var(--${namespace}-on);
}

.${namespace}-nav-section {
  font-size: 11px;
  font-weight: 800;
  letter-spacing: .12em;
  color: var(--${namespace}-ink);
  text-transform: uppercase;
  padding: 9px 16px 5px;
  background: color-mix(in srgb, var(--${namespace}-ln) 25%, #ffffff);
  border-top: 1px solid var(--${namespace}-ln);
  border-bottom: 1px solid var(--${namespace}-ln);
}

.${namespace}-nav-item {
  display: flex;
  align-items: center;
  gap: 12px;
  padding: 12px 16px;
  border: 1px solid transparent;
  border-bottom: 1px solid var(--${namespace}-ln);
  color: var(--${namespace}-ink);
  cursor: pointer;
  transition: all .12s ease;
  position: relative;
}
.${namespace}-nav-item:hover {
  background: color-mix(in srgb, var(--${namespace}-ln) 40%, transparent);
}
.${namespace}-nav-item.${namespace}-active {
  background: var(--${namespace}-sel);
  border-color: var(--${namespace}-red);
}

.${namespace}-nav-item-content {
  flex: 1;
  min-width: 0;
}
.${namespace}-nav-item strong {
  display: block;
  font-size: 15px;
  font-weight: 800;
  letter-spacing: .1em;
  color: var(--${namespace}-ink);
  line-height: 1.3;
  margin-bottom: 3px;
}
.${namespace}-nav-item.${namespace}-active strong {
  color: var(--${namespace}-red);
}

.${namespace}-nav-item span {
  display: block;
  color: #334155;
  font-size: 12px;
  font-weight: 500;
  letter-spacing: .02em;
  overflow: hidden;
  text-overflow: ellipsis;
  white-space: nowrap;
}
.${namespace}-nav-item.${namespace}-active span {
  color: color-mix(in srgb, var(--${namespace}-red) 85%, #000);
}

.${namespace}-nav-item .${namespace}-rd {
  width: 20px;
  height: 20px;
  border: 2px solid var(--${namespace}-ink);
  border-radius: 50%;
  flex-shrink: 0;
  transition: .15s;
  background: transparent;
  opacity: .7;
}
.${namespace}-nav-item:hover .${namespace}-rd {
  opacity: 1;
}
.${namespace}-nav-item.${namespace}-active .${namespace}-rd {
  background: var(--${namespace}-tcp);
  border-color: var(--${namespace}-tcp);
  opacity: 1;
}

.${namespace}-nav-item .${namespace}-arrow {
  text-decoration: none;
  font-size: 20px;
  font-weight: 800;
  color: var(--${namespace}-ink);
  transition: transform .2s ease, color .2s ease;
  line-height: 1;
  user-select: none;
}
.${namespace}-nav-item.${namespace}-active .${namespace}-arrow {
  transform: rotate(90deg);
  color: var(--${namespace}-red);
}

.${namespace}-nav-sub {
  display: flex;
  gap: 12px;
  padding: 8px 20px 8px 40px;
  align-items: center;
  background: color-mix(in srgb, var(--${namespace}-sel) 60%, #ffffff);
  border-bottom: 1px dashed var(--${namespace}-ln);
  cursor: pointer;
  transition: .12s;
}
.${namespace}-nav-sub:hover {
  background: color-mix(in srgb, var(--${namespace}-ln) 30%, transparent);
}
.${namespace}-nav-sub b {
  width: 24px;
  height: 24px;
  border-radius: 50%;
  background: var(--${namespace}-ink);
  color: var(--${namespace}-pn);
  display: grid;
  place-items: center;
  font-size: 11px;
  font-weight: 800;
  flex-shrink: 0;
}
.${namespace}-nav-sub strong {
  display: block;
  font-size: 13px;
  font-weight: 700;
  color: var(--${namespace}-ink);
}
.${namespace}-nav-sub span {
  display: block;
  font-size: 11px;
  font-weight: 500;
  color: #475569;
}

/* 内容主区域：预留 64px 底部空间给固定操作栏 */
.${namespace}-content {
  flex: 1;
  overflow: hidden;
  display: flex;
  flex-direction: column;
  gap: 12px;
  position: relative;
}

.${namespace}-page {
  flex: 1;
  overflow: hidden;
  display: flex;
  flex-direction: column;
  background: transparent;
}

.${namespace}-page-body {
  flex: 1;
  overflow-y: auto;
  min-height: 0;
  padding: 0 0 64px 0; /* 预留给底部操作条的安全距离 */
  display: flex;
  flex-direction: column;
  gap: 12px;
}

/* ══════════════════════════════════════════════
   4. Topbar & Header Dashboard
   ══════════════════════════════════════════════ */
.${namespace}-topbar {
  background: var(--${namespace}-pn);
  border-bottom: 1px solid var(--${namespace}-ln);
  height: 58px;
  display: flex;
  align-items: center;
  padding: 0 16px;
  gap: 28px;
  flex-shrink: 0;
}

.${namespace}-logo {
  display: flex;
  align-items: center;
  gap: 12px;
  white-space: nowrap;
}
.${namespace}-logo h1 {
  margin: 0;
  font-size: 20px;
  letter-spacing: .2em;
  color: var(--${namespace}-ink);
}
.${namespace}-logo em {
  font-style: italic;
  color: var(--${namespace}-pri);
}

.${namespace}-tnav {
  padding: 0 12px;
  height: 58px;
  display: flex;
  align-items: center;
  font-size: 13px;
  font-weight: 700;
  cursor: pointer;
  color: var(--${namespace}-mu);
  border-bottom: 3px solid transparent;
  transition: .15s;
}
.${namespace}-tnav:hover {
  color: var(--${namespace}-ink);
}
.${namespace}-tnav.${namespace}-active {
  color: var(--${namespace}-pri);
  border-bottom-color: var(--${namespace}-pri);
}

.${namespace}-topbar-right {
  margin-left: auto;
  display: flex;
  align-items: center;
  gap: 12px;
  font-size: 12px;
}

.${namespace}-cells {
  display: flex;
  gap: 3px;
}
.${namespace}-cells i {
  width: 12px;
  height: 10px;
  background: var(--${namespace}-ln);
}
.${namespace}-cells i.f {
  background: var(--${namespace}-pri);
}

.${namespace}-th {
  display: flex;
}
.${namespace}-th button {
  width: 36px;
  height: 32px;
  border: 1px solid var(--${namespace}-ln);
  background: var(--${namespace}-pn);
  color: var(--${namespace}-ink);
  cursor: pointer;
  font: inherit;
}
.${namespace}-th button.on {
  background: var(--${namespace}-pri);
  color: var(--${namespace}-on);
}

/* ══════════════════════════════════════════════
   5. Breadcrumb & Record Navigation
   ══════════════════════════════════════════════ */
.${namespace}-breadcrumb {
  background: var(--${namespace}-pn);
  border: 1px solid var(--${namespace}-ln);
  padding: 0 12px;
  height: 32px;
  display: flex;
  align-items: center;
  gap: 6px;
  font-size: 12px;
  color: var(--${namespace}-mu);
  flex-shrink: 0;
}
.${namespace}-breadcrumb a {
  color: var(--${namespace}-ink);
  text-decoration: none;
  font-weight: 700;
}
.${namespace}-breadcrumb a:hover {
  color: var(--${namespace}-pri);
}

.${namespace}-record-nav {
  margin-left: auto;
  display: flex;
  align-items: center;
}
.${namespace}-rn-btn {
  display: inline-flex;
  align-items: center;
  gap: 4px;
  height: 24px;
  padding: 0 8px;
  border: 1px solid var(--${namespace}-ln);
  background: var(--${namespace}-pn);
  color: var(--${namespace}-ink);
  font: inherit;
  font-size: 11px;
  font-weight: 700;
  cursor: pointer;
  transition: .12s;
}
.${namespace}-rn-btn:hover:not(:disabled) {
  background: var(--${namespace}-pri);
  color: var(--${namespace}-on);
}
.${namespace}-rn-btn:disabled {
  opacity: .4;
  cursor: not-allowed;
}
.${namespace}-rn-idx {
  display: flex;
  align-items: center;
  justify-content: center;
  height: 24px;
  padding: 0 8px;
  font-size: 11px;
  font-weight: 700;
  color: var(--${namespace}-ink);
  background: var(--${namespace}-bg);
  border-top: 1px solid var(--${namespace}-ln);
  border-bottom: 1px solid var(--${namespace}-ln);
}

/* ══════════════════════════════════════════════
   6. Object Header (Protocol Title & Status)
   ══════════════════════════════════════════════ */
.${namespace}-obj-head {
  background: var(--${namespace}-pn);
  border: 1px solid var(--${namespace}-ln);
  padding: 14px 16px;
  display: flex;
  align-items: center;
  gap: 14px;
  flex-shrink: 0;
}
.${namespace}-obj-title {
  font-size: 26px;
  letter-spacing: .1em;
  font-weight: 700;
  color: var(--${namespace}-ink);
}
.${namespace}-obj-meta {
  font-size: 12px;
  color: #475569;
  display: flex;
  gap: 12px;
  margin-top: 4px;
}

/* ══════════════════════════════════════════════
   7. Tabs & Filter Pills (参考 .tabs 与 .seg2)
   ══════════════════════════════════════════════ */
.${namespace}-tabs {
  display: flex;
  border: 1px solid var(--${namespace}-ln);
  background: var(--${namespace}-pn);
  margin: 0;
}
.${namespace}-tab {
  flex: 1;
  text-align: center;
  padding: 8px 12px;
  cursor: pointer;
  border-bottom: 3px solid transparent;
  font-weight: 700;
  white-space: nowrap;
  color: var(--${namespace}-ink);
  transition: .15s;
}
.${namespace}-tab:hover {
  background: color-mix(in srgb, var(--${namespace}-ln) 25%, transparent);
}
.${namespace}-tab.${namespace}-active {
  border-bottom-color: var(--${namespace}-pri);
}

.${namespace}-tab-badge {
  font-style: normal;
  font-size: 11px;
  background: var(--${namespace}-ln);
  color: var(--${namespace}-ink);
  padding: 0 7px;
  margin-left: 6px;
  border-radius: 9px;
  font-weight: 700;
}
.${namespace}-tab.${namespace}-active .${namespace}-tab-badge {
  background: var(--${namespace}-pri);
  color: var(--${namespace}-on);
}

.${namespace}-seg {
  display: inline-flex;
  border: 1px solid var(--${namespace}-ln);
}
.${namespace}-seg b {
  padding: 6px 14px;
  cursor: pointer;
  color: var(--${namespace}-mu);
  font-weight: 700;
}
.${namespace}-seg b.on {
  background: var(--${namespace}-pri);
  color: var(--${namespace}-on);
}

/* ══════════════════════════════════════════════
   8. Panel (直角墨水线框容器)
   ══════════════════════════════════════════════ */
.${namespace}-panel {
  background: var(--${namespace}-pn);
  border: 1px solid var(--${namespace}-ln);
  display: flex;
  flex-direction: column;
  overflow: hidden;
}

.${namespace}-panel-head {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 12px 16px;
  gap: 12px;
  border-bottom: 1px solid var(--${namespace}-ln);
  background: var(--${namespace}-pn);
}
.${namespace}-panel-head h2,
.${namespace}-panel-head h3 {
  font-size: 18px;
  letter-spacing: .05em;
  margin: 0;
  color: var(--${namespace}-ink);
  font-weight: 800;
}

/* ══════════════════════════════════════════════
   9. Field View (精细 1px 单边框只读网格)
   ══════════════════════════════════════════════ */
/* ══════════════════════════════════════════════
   9. Field View (精细 1px 单边框只读网格)
   ══════════════════════════════════════════════ */
.${namespace}-fview {
  display: grid;
  grid-template-columns: repeat(4, 1fr);
  gap: 0;
  background: var(--${namespace}-pn, #ffffff);
  font-family: var(--${namespace}-f, "IBM Plex Mono", monospace);
  box-sizing: border-box;
}
.${namespace}-fview--1 { grid-template-columns: repeat(1, 1fr); }
.${namespace}-fview--2 { grid-template-columns: repeat(2, 1fr); }
.${namespace}-fview--3 { grid-template-columns: repeat(3, 1fr); }
.${namespace}-fview--6 { grid-template-columns: repeat(6, 1fr); }

.${namespace}-fv {
  display: flex;
  align-items: stretch; /* 确保子列高度始终等高拉伸 */
  border-bottom: 1px solid var(--${namespace}-ln, #d3dbef);
  border-right: 1px solid var(--${namespace}-ln, #d3dbef);
  min-height: 34px;
  background: var(--${namespace}-pn, #ffffff);
  box-sizing: border-box;
  transition: background .12s;
}
.${namespace}-fv:hover {
  background: color-mix(in srgb, var(--${namespace}-ln, #d3dbef) 15%, transparent);
}

.${namespace}-fv--span2 { grid-column: span 2; }
.${namespace}-fv--span3 { grid-column: span 3; }
.${namespace}-fv--span4 { grid-column: span 4; }

.${namespace}-fv-label {
  width: 100px;
  min-width: 100px;
  flex-shrink: 0;
  align-self: stretch; /* ★ 核心修复：强制 Label 自身高度 100% 铺满整个 cell，背景色不再断层 */
  background: color-mix(in srgb, var(--${namespace}-pri, #0a2fb5) 5%, var(--${namespace}-bg, #f4f6fb));
  color: var(--${namespace}-ink, #0a2a9a);
  font-size: 12px;
  font-weight: 700;
  letter-spacing: .05em;
  padding: 7px 10px;
  border-right: 1px solid var(--${namespace}-ln, #d3dbef);
  display: flex;
  align-items: center;
  line-height: 1.4;
  user-select: none;
  box-sizing: border-box;
}

.${namespace}-fv-val {
  flex: 1;
  padding: 7px 12px;
  font-size: 13px;
  color: var(--${namespace}-ink, #0a2a9a);
  display: flex;
  align-items: center;
  min-width: 0;
  word-break: break-all;
  line-height: 1.5;
  box-sizing: border-box;
}

.${namespace}-fv-val--mono    { font-family: var(--${namespace}-f, "IBM Plex Mono", monospace); font-weight: 600; }
.${namespace}-fv-val--bold    { font-weight: 800; color: var(--${namespace}-ink, #0a2a9a); }
.${namespace}-fv-val--success { color: var(--${namespace}-tcp, #13a05d); font-weight: 700; }
.${namespace}-fv-val--danger  { color: var(--${namespace}-red, #d6343e); font-weight: 700; }
.${namespace}-fv-val--link    { color: var(--${namespace}-pri, #0a2fb5); cursor: pointer; text-decoration: underline; font-weight: 600; }
.${namespace}-fv-val--link:hover { color: var(--${namespace}-ink, #0a2a9a); }

.${namespace}-fv-val--files {
  display: flex;
  flex-direction: column;
  align-items: flex-start !important;
  gap: 4px;
  width: 100%;
  padding: 4px 0;
}

.${namespace}-fv-file-item {
  display: inline-flex;
  align-items: center;
  gap: 8px;
  padding: 2px 8px;
  background: var(--${namespace}-bg, #f4f6fb);
  border-radius: 0;
  color: var(--${namespace}-ink, #0a2a9a);
  text-decoration: none;
  font-size: 12px;
  font-weight: 600;
  height: 24px;
  box-sizing: border-box;
  max-width: 100%;
  transition: .12s;
}
.${namespace}-fv-file-item:hover {
  background: var(--${namespace}-pn, #ffffff);
  border-color: var(--${namespace}-pri, #0a2fb5);
  color: var(--${namespace}-pri, #0a2fb5);
  transform: translate(-1px, -1px);
  box-shadow: 2px 2px 0 var(--${namespace}-ink, #0a2a9a);
}

.${namespace}-fv-file-icon {
  font-size: 13px;
  color: var(--${namespace}-mu, #475569);
  line-height: 1;
}
.${namespace}-fv-file-item:hover .${namespace}-fv-file-icon {
  color: var(--${namespace}-pri, #0a2fb5);
}

.${namespace}-fv-file-name {
  white-space: nowrap;
  overflow: hidden;
  text-overflow: ellipsis;
  letter-spacing: .02em;
}

.${namespace}-fv-file-size {
  font-size: 11px;
  font-weight: normal;
  color: var(--${namespace}-mu, #475569);
  margin-left: 2px;
}

.${namespace}-fv-file-down {
  font-size: 12px;
  font-weight: 800;
  color: var(--${namespace}-pri, #0a2fb5);
  margin-left: 4px;
}

/* ★ 核心修复：多行/富媒体内容置顶对齐，同时保证 Label 高度依然铺满整行 */
.${namespace}-fv--top {
  align-items: stretch !important;
}
.${namespace}-fv--top .${namespace}-fv-label,
.${namespace}-fv-label--top {
  align-items: flex-start;
  padding-top: 8px;
  line-height: 1.3;
}
.${namespace}-fv--top .${namespace}-fv-val {
  align-items: flex-start;
  padding-top: 7px;
}

.${namespace}-fv-empty {
  color: var(--${namespace}-mu, #475569);
  font-weight: 500;
  letter-spacing: .05em;
}

.${namespace}-fv-val--pre {
  white-space: pre-wrap;
  word-break: break-all;
  line-height: 1.5;
  font-family: var(--${namespace}-f, "IBM Plex Mono", monospace);
  background: color-mix(in srgb, var(--${namespace}-ln, #d3dbef) 15%, transparent);
  padding: 6px 8px;
  border: 1px dashed var(--${namespace}-ln, #d3dbef);
}

.${namespace}-fv-val--media {
  display: flex;
  flex-wrap: wrap;
  gap: 6px;
  align-items: center;
  padding: 4px 0;
}

.${namespace}-fv-img-box {
  width: 64px;
  height: 64px;
  border: 1px solid var(--${namespace}-ln, #d3dbef);
  border-radius: 0;
  overflow: hidden;
  display: block;
  background: var(--${namespace}-bg, #f4f6fb);
  transition: .12s;
  flex-shrink: 0;
}
.${namespace}-fv-img-box:hover {
  transform: translate(-1px, -1px);
  box-shadow: 2px 2px 0 var(--${namespace}-ink, #0a2a9a);
  border-color: var(--${namespace}-pri, #0a2fb5);
}
.${namespace}-fv-img {
  width: 100%;
  height: 100%;
  object-fit: cover;
  display: block;
}

.${namespace}-fv-vid-box {
  width: 130px;
  aspect-ratio: 16 / 9;
  border: 1px solid var(--${namespace}-ln, #d3dbef);
  border-radius: 0;
  overflow: hidden;
  background: #080d22;
  display: flex;
  align-items: center;
  justify-content: center;
  flex-shrink: 0;
}
.${namespace}-fv-vid {
  width: 100%;
  height: 100%;
  object-fit: contain;
  display: block;
  outline: none;
}

/* ══════════════════════════════════════════════
   10. Form Grid & Input Controls (左右两列式表单布局)
   ══════════════════════════════════════════════ */
.${namespace}-form {
  display: grid;
  grid-template-columns: repeat(2, 1fr);
  gap: 12px 24px;
  padding: 16px 16px 64px 16px; /* 预留底部操作条安全高度 */
}
.${namespace}-form--1 { grid-template-columns: 1fr; }
.${namespace}-form--3 { grid-template-columns: repeat(3, 1fr); }
.${namespace}-form--4 { grid-template-columns: repeat(4, 1fr); }

.${namespace}-field {
  display: flex;
  flex-direction: row;
  align-items: center;
  gap: 10px;
  min-width: 0;
  font-size: 13px;
}

.${namespace}-field--span2 { grid-column: span 2; }
.${namespace}-field--span3 { grid-column: span 3; }
.${namespace}-field--span4,
.${namespace}-field.full     { grid-column: 1 / -1; }

.${namespace}-field > label,
.${namespace}-field-label {
  width: 90px;
  min-width: 90px;
  flex-shrink: 0;
  font-size: 12px;
  font-weight: 700;
  letter-spacing: .08em;
  color: var(--${namespace}-ink);
  text-align: right;
  line-height: 1.4;
  user-select: none;
  transition: .15s;
}
.${namespace}-field:focus-within > label,
.${namespace}-field:focus-within .${namespace}-field-label {
  color: var(--${namespace}-pri);
}

.${namespace}-field-label--w1 { width: 110px; min-width: 110px; }
.${namespace}-field-label--w2 { width: 130px; min-width: 130px; }
.${namespace}-field-label--left { text-align: left; }

.${namespace}-field-label--required::before,
.${namespace}-field > label.required::before {
  content: "* ";
  color: var(--${namespace}-red);
}

.${namespace}-field:has(textarea),
.${namespace}-field--top {
  align-items: flex-start;
}
.${namespace}-field:has(textarea) > label,
.${namespace}-field:has(textarea) .${namespace}-field-label,
.${namespace}-field--top > label,
.${namespace}-field--top .${namespace}-field-label {
  padding-top: 8px;
}

.${namespace}-field-control {
  flex: 1;
  display: flex;
  flex-direction: column;
  gap: 4px;
  min-width: 0;
}

.${namespace}-input,
.${namespace}-select,
.${namespace}-textarea {
  flex: 1;
  height: 34px;
  font: inherit;
  font-size: 13px;
  color: var(--${namespace}-ink);
  background: var(--${namespace}-pn);
  border: 1px solid var(--${namespace}-ln);
  border-radius: 0;
  padding: 0 10px;
  width: 100%;
  outline: 0;
  transition: .15s;
}
.${namespace}-textarea {
  height: auto;
  min-height: 72px;
  padding: 8px 10px;
  resize: vertical;
}
.${namespace}-input:focus,
.${namespace}-select:focus,
.${namespace}-textarea:focus {
  border-color: var(--${namespace}-pri);
  box-shadow: 3px 3px 0 color-mix(in srgb, var(--${namespace}-pri) 30%, transparent);
  transform: translate(-1px, -1px);
}

.${namespace}-input:disabled,
.${namespace}-select:disabled,
.${namespace}-textarea:disabled,
.${namespace}-input--readonly {
  background: var(--${namespace}-bg);
  color: var(--${namespace}-mu);
  cursor: not-allowed;
  transform: none;
  box-shadow: none;
}

.${namespace}-field.err .${namespace}-input,
.${namespace}-field.err .${namespace}-select,
.${namespace}-field.err .${namespace}-textarea {
  border-color: var(--${namespace}-red);
}
.${namespace}-field.err > label,
.${namespace}-field.err .${namespace}-field-label {
  color: var(--${namespace}-red);
}

.${namespace}-field-help,
.${namespace}-field .hp {
  font-size: 11px;
  color: #475569;
}
.${namespace}-field.err .hp { color: var(--${namespace}-red); }
.${namespace}-field.ok .hp  { color: var(--${namespace}-tcp); }

.${namespace}-num {
  flex: 1;
  display: flex;
}
.${namespace}-num .${namespace}-input {
  text-align: center;
  border-left: 0;
  border-right: 0;
}
.${namespace}-num button {
  width: 36px;
  border: 1px solid var(--${namespace}-ln);
  background: var(--${namespace}-pn);
  color: var(--${namespace}-ink);
  font: inherit;
  font-size: 16px;
  cursor: pointer;
  border-radius: 0;
  transition: .12s;
}
.${namespace}-num button:hover {
  background: var(--${namespace}-pri);
  color: var(--${namespace}-on);
  border-color: var(--${namespace}-pri);
}

.${namespace}-sel {
  position: relative;
  flex: 1;
  display: flex;
}
.${namespace}-sel::after {
  content: "▾";
  position: absolute;
  right: 12px;
  top: 50%;
  transform: translateY(-50%);
  pointer-events: none;
  color: var(--${namespace}-ink);
  font-size: 12px;
}
.${namespace}-sel select {
  appearance: none;
  padding-right: 28px;
  cursor: pointer;
}

.${namespace}-form-section {
  grid-column: 1 / -1;
  font-size: 12px;
  font-weight: 800;
  letter-spacing: .08em;
  color: var(--${namespace}-ink);
  padding: 8px 0 4px;
  border-bottom: 1px solid var(--${namespace}-ln);
  margin: 6px 0 4px;
}

/* ══════════════════════════════════════════════
   11. Buttons & 固定底部操作栏 (Fixed Footer & Right-Aligned Buttons)
   ══════════════════════════════════════════════ */
/* 按钮容器：默认整行靠右排列 */
.${namespace}-btns,
.${namespace}-form-actions {
  display: flex;
  align-items: center;
  justify-content: flex-end; /* 全部按钮靠右对齐 */
  gap: 8px;
  width: 100%;
}

/* 核心：固定在视口底部的工程操作栏 (Fixed Footer) */
.${namespace}-form-footer {
  position: fixed;
  bottom: 0;
  left: 0;
  right: 0;
  height: 48px;
  background: var(--${namespace}-pn);
  border-top: 2px solid var(--${namespace}-pri); /* 醒目的 2px 蓝图墨水控制线 */
  box-shadow: 0 -4px 12px rgba(10, 42, 154, 0.06);
  padding: 0 20px;
  display: flex;
  align-items: center;
  justify-content: flex-end; /* 按钮靠右 */
  gap: 8px;
  z-index: 100;
  box-sizing: border-box;
}

/* 当 footer 位于 Drawer 或 Dialog 内部时，自适应变为内嵌沉底 */
.${namespace}-drawer .${namespace}-form-footer,
.${namespace}-dialog .${namespace}-form-footer {
  position: static;
  margin-top: auto;
  border-top: 1px solid var(--${namespace}-ln);
  box-shadow: none;
  padding: 10px 14px;
  height: auto;
}

/* 物理压平按钮基础样式 */
.${namespace}-btn {
  font: 700 13px var(--${namespace}-f);
  color: var(--${namespace}-ink);
  background: var(--${namespace}-pn);
  border: 1px solid var(--${namespace}-ink);
  border-radius: 0;
  padding: 8px 16px;
  cursor: pointer;
  transition: .12s;
  display: inline-flex;
  align-items: center;
  justify-content: center;
  gap: 4px;
  white-space: nowrap;
}
.${namespace}-btn:hover {
  transform: translate(-2px, -2px);
  box-shadow: 3px 3px 0 var(--${namespace}-ink);
}
.${namespace}-btn:active {
  transform: translate(1px, 1px);
  box-shadow: none;
}

/* 变体按钮 */
.${namespace}-btn--primary {
  background: var(--${namespace}-pri);
  color: var(--${namespace}-on);
  border-color: var(--${namespace}-pri);
}
.${namespace}-btn--primary:hover {
  box-shadow: 3px 3px 0 color-mix(in srgb, var(--${namespace}-pri) 45%, transparent);
}

.${namespace}-btn--danger {
  color: var(--${namespace}-red);
  border-color: var(--${namespace}-red);
}
.${namespace}-btn--danger:hover {
  box-shadow: 3px 3px 0 var(--${namespace}-red);
}

.${namespace}-btn--ghost {
  border-color: transparent;
  background: none;
}
.${namespace}-btn:disabled {
  opacity: .4;
  pointer-events: none;
}

.${namespace}-btn--sm { height: 26px; padding: 0 10px; font-size: 11px; }
.${namespace}-btn--lg { height: 40px; padding: 0 20px; font-size: 14px; }

/* ══════════════════════════════════════════════
   12. Badge, Tag & Packet Circle Numbers
   ══════════════════════════════════════════════ */
.${namespace}-pill,
.${namespace}-tag {
  display: inline-flex;
  gap: 8px;
  align-items: center;
  padding: 3px 12px;
  background: color-mix(in srgb, var(--c, var(--${namespace}-tcp)) 16%, transparent);
  color: var(--c, var(--${namespace}-tcp));
  font-weight: 700;
  font-size: 12px;
  border-radius: 0;
}
.${namespace}-pill i {
  width: 8px;
  height: 8px;
  border-radius: 50%;
  background: currentColor;
}
.${namespace}-pill.live i {
  animation: pu 1.6s infinite;
}
@keyframes pu {
  50% { box-shadow: 0 0 0 5px color-mix(in srgb, currentColor 20%, transparent); }
}

.${namespace}-bd,
.${namespace}-pkt-no {
  width: 26px;
  height: 26px;
  border-radius: 50%;
  background: var(--c, var(--${namespace}-tcp));
  color: #fff;
  display: inline-grid;
  place-items: center;
  font-weight: 700;
  font-size: 12px;
  flex-shrink: 0;
}

/* ══════════════════════════════════════════════
   13. Table (协议数据包时序网格)
   ══════════════════════════════════════════════ */
.${namespace}-table {
  border-collapse: collapse;
  width: 100%;
  white-space: nowrap;
  font-size: 13px;
}
.${namespace}-table th {
  position: sticky;
  top: 0;
  background: var(--${namespace}-pn);
  text-align: left;
  padding: 8px 12px;
  color: var(--${namespace}-ink);
  font-weight: 700;
  border-bottom: 1px solid var(--${namespace}-ln);
}
.${namespace}-table td {
  padding: 6px 12px;
  border-top: 1px solid var(--${namespace}-ln);
  color: var(--${namespace}-ink);
}
.${namespace}-table tr:hover {
  background: color-mix(in srgb, var(--${namespace}-ln) 20%, transparent);
}
.${namespace}-table tr.cur {
  background: color-mix(in srgb, var(--${namespace}-pri) 10%, transparent);
  outline: 1px solid var(--${namespace}-pri);
  outline-offset: -1px;
}

/* ══════════════════════════════════════════════
   14. Alert & Toast System (侧边色条实体投影弹窗)
   ══════════════════════════════════════════════ */
.${namespace}-toast-wrap {
  position: fixed;
  right: 16px;
  bottom: 16px;
  display: flex;
  flex-direction: column;
  gap: 8px;
  z-index: 9999;
}
.${namespace}-toast,
.${namespace}-alert {
  background: var(--${namespace}-pn);
  border: 1px solid var(--${namespace}-ln);
  border-left: 5px solid var(--c, var(--${namespace}-tcp));
  padding: 10px 16px;
  min-width: 240px;
  box-shadow: 4px 4px 0 var(--${namespace}-ln);
}
.${namespace}-toast b {
  color: var(--c, var(--${namespace}-tcp));
}

/* ══════════════════════════════════════════════
   15. Status Bar & Telemetry Strip
   ══════════════════════════════════════════════ */
.${namespace}-statusbar {
  background: var(--${namespace}-pn);
  border-top: 1px solid var(--${namespace}-ln);
  padding: 4px 14px;
  font-size: 12px;
  color: var(--${namespace}-ink);
  display: flex;
  align-items: center;
  gap: 16px;
}
.${namespace}-clock {
  font-family: var(--${namespace}-f);
  color: var(--${namespace}-ink);
  font-weight: 700;
}

/* ══════════════════════════════════════════════
   16. Timeline & Stepper (步骤条，参考 .stp)
   ══════════════════════════════════════════════ */
.${namespace}-timeline,
.${namespace}-stp {
  list-style: none;
  margin: 0;
  padding: 0;
}
.${namespace}-stp li {
  display: flex;
  gap: 12px;
  padding-bottom: 14px;
  position: relative;
}
.${namespace}-stp li:not(:last-child)::before {
  content: "";
  position: absolute;
  left: 14px;
  top: 30px;
  bottom: 2px;
  border-left: 1px dashed var(--${namespace}-ink);
}
.${namespace}-stp b {
  flex: none;
  width: 28px;
  height: 28px;
  border-radius: 50%;
  background: #334155;
  color: var(--${namespace}-pn);
  display: grid;
  place-items: center;
  cursor: pointer;
  font-size: 12px;
}
.${namespace}-stp .ok b {
  background: var(--${namespace}-tcp);
}
.${namespace}-stp .on b {
  background: var(--${namespace}-pri);
  animation: pu 1.6s infinite;
}
.${namespace}-stp span {
  display: block;
  color: #334155;
  font-size: 12px;
}

/* ══════════════════════════════════════════════
   17. Sequence & Network Viewport (时序与传输视口)
   ══════════════════════════════════════════════ */
.${namespace}-tr {
  position: relative;
  height: 120px;
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin: 8px 14px;
}
.${namespace}-nd {
  width: 110px;
  border: 1px solid var(--${namespace}-ink);
  background: var(--${namespace}-pn);
  padding: 8px 6px;
  font-weight: 700;
  text-align: center;
  z-index: 1;
}
.${namespace}-nd small {
  display: block;
  color: #334155;
  font-weight: 500;
  font-size: 10.5px;
}
.${namespace}-wire {
  position: absolute;
  left: 110px;
  right: 110px;
  top: 50%;
  border-top: 1px dashed #334155;
}

/* ══════════════════════════════════════════════
   18. Tooltip Mark & Hover Hints (参考 .tp)
   ══════════════════════════════════════════════ */
.${namespace}-tooltip-mark,
.${namespace}-tp {
  position: relative;
  border-bottom: 1px dotted var(--${namespace}-ink);
  cursor: help;
}
.${namespace}-tp::after {
  content: attr(data-t);
  position: absolute;
  left: 50%;
  bottom: 140%;
  transform: translate(-50%, 6px);
  background: var(--${namespace}-ink);
  color: var(--${namespace}-pn);
  padding: 6px 10px;
  white-space: nowrap;
  font-size: 12px;
  opacity: 0;
  pointer-events: none;
  transition: .15s;
}
.${namespace}-tp:hover::after {
  opacity: 1;
  transform: translate(-50%, 0);
}

/* ══════════════════════════════════════════════
   19. Official Document & Form
   ══════════════════════════════════════════════ */
.${namespace}-of__container {
  width: 860px;
  margin: 0 auto;
  background: var(--${namespace}-pn);
  border: 1px solid var(--${namespace}-ink);
  padding: 24px 32px;
  box-shadow: 4px 4px 0 var(--${namespace}-ln);
}
.${namespace}-of__table {
  width: 100%;
  border-collapse: collapse;
  border: 2px solid var(--${namespace}-ink);
}
.${namespace}-of__table td {
  border: 1px solid var(--${namespace}-ln);
  height: 32px;
  padding: 4px 8px;
}
.${namespace}-of__label {
  background: color-mix(in srgb, var(--${namespace}-pri) 8%, transparent);
  font-weight: 700;
  color: var(--${namespace}-ink);
  text-align: center;
}

/* ══════════════════════════════════════════════
   20. Letter Component
   ══════════════════════════════════════════════ */
.${namespace}-lt__paper {
  width: 820px;
  margin: 0 auto;
  background: var(--${namespace}-pn);
  padding: 40px;
  border: 1px solid var(--${namespace}-ln);
  box-shadow: 4px 4px 0 var(--${namespace}-ln);
}

/* ══════════════════════════════════════════════
   21. KPI Card & RTT Bars (微型柱状图与遥测卡)
   ══════════════════════════════════════════════ */
.${namespace}-kpi-card {
  background: var(--${namespace}-pn);
  border: 1px solid var(--${namespace}-ln);
  padding: 14px 16px;
  display: flex;
  flex-direction: column;
  gap: 8px;
}
.${namespace}-kpi-num {
  font-size: 32px;
  font-weight: 700;
  letter-spacing: .08em;
  color: var(--${namespace}-ink);
}
.${namespace}-bars {
  display: flex;
  gap: 3px;
  align-items: flex-end;
  height: 60px;
}
.${namespace}-bars i {
  flex: 1;
  background: var(--${namespace}-tcp);
  transition: height .3s;
}
.${namespace}-bars i.w { background: var(--${namespace}-cmd); }
.${namespace}-bars i.h { background: var(--${namespace}-red); }

/* ══════════════════════════════════════════════
   22. 24-Column Grid System & Responsive
   ══════════════════════════════════════════════ */
.${namespace}-row {
  display: flex;
  flex-wrap: wrap;
}
.${namespace}-row--gap { margin-left: -6px; margin-right: -6px; }
.${namespace}-row--gap > [class*="${namespace}-col-"] { padding-left: 6px; padding-right: 6px; }

.${namespace}-col-1  { flex: 0 0 4.16666667%; max-width: 4.16666667%; }
.${namespace}-col-2  { flex: 0 0 8.33333333%; max-width: 8.33333333%; }
.${namespace}-col-3  { flex: 0 0 12.5%;       max-width: 12.5%;       }
.${namespace}-col-4  { flex: 0 0 16.66666667%; max-width: 16.66666667%; }
.${namespace}-col-6  { flex: 0 0 25%;          max-width: 25%;          }
.${namespace}-col-8  { flex: 0 0 33.33333333%; max-width: 33.33333333%; }
.${namespace}-col-12 { flex: 0 0 50%;          max-width: 50%;          }
.${namespace}-col-16 { flex: 0 0 66.66666667%; max-width: 66.66666667%; }
.${namespace}-col-18 { flex: 0 0 75%;          max-width: 75%;          }
.${namespace}-col-24 { flex: 0 0 100%;         max-width: 100%;         }

.${namespace}-col-offset-1  { margin-left: 4.16666667%; }
.${namespace}-col-offset-2  { margin-left: 8.33333333%; }
.${namespace}-col-offset-3  { margin-left: 12.5%;       }
.${namespace}-col-offset-4  { margin-left: 16.66666667%; }
.${namespace}-col-offset-6  { margin-left: 25%;          }
.${namespace}-col-offset-8  { margin-left: 33.33333333%; }
.${namespace}-col-offset-12 { margin-left: 50%;          }

/* 响应式断点 */
@media (max-width: 768px) {
  .${namespace}-sidebar { width: 100%; }
  .${namespace}-main { flex-direction: column; }
  .${namespace}-form { grid-template-columns: 1fr; }
  .${namespace}-field > label, .${namespace}-field-label { width: 80px; min-width: 80px; }
  .${namespace}-col-sm-24 { flex: 0 0 100%; max-width: 100%; }
}

/* ══════════════════════════════════════════════
   23. Tile Component Library 包含引入
   ══════════════════════════════════════════════ */
<#include "/$/tile.css.ftl">