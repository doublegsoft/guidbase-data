/**
 * Protocol Explorer Engineering Design System
 * 协议探索器 · 新拟态工程设计系统 (Neumorphism Redesign)
 * ─────────────────────────────────────────────
 * 特性：双向柔和光影、大圆角、内凹刻槽、按压触感反馈、无实体硬边框
 * 目录
 *  1. Reset & Global Base
 *  2. Design Tokens (新拟态核心光源与阴影体系)
 *  3. Layout — Shell / Main / 浮雕圆角 Sidebar / Content / Page
 *  4. Topbar & Header Dashboard
 *  5. Breadcrumb & Record Navigation
 *  6. Object Header (Protocol Title & Status)
 *  7. Tabs & Filter Pills (内凹底槽与凸起按键)
 *  8. Panel (新拟态柔和浮雕卡片)
 *  9. Field View (内嵌柔光只读展示网格)
 * 10. Form Grid & Input Controls (内凹槽体输入控件)
 * 11. Buttons & 底部悬浮操作栏 (浮雕按钮与拟态悬浮条)
 * 12. Switch, Badge, Tag & Packet Circle Numbers
 * 13. Table (内凹时序数据视口网格)
 * 14. Alert & Toast System (悬浮发光实体弹窗)
 * 15. Status Bar & Telemetry Strip
 * 16. Timeline & Stepper (发光与内嵌凹轨步骤条)
 * 17. Sequence & Network Topology Viewport (柔光接线端)
 * 18. Tooltip Mark & Hover Hints
 * 19. Official Document & Form
 * 20. Letter Component
 * 21. KPI Card & RTT Bars (内凹槽柱状图)
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
   2. Design Tokens (新拟态双向光影规范)
   ══════════════════════════════════════════════ */
:root {
  /* 新拟态同质底色基准 */
  --${namespace}-bg:               #e0e5ec;
  --${namespace}-pn:               #e0e5ec;
  
  /* 拟态光影双极基元：高光与暗影 */
  --${namespace}-sl:               #ffffff;
  --${namespace}-sd:               #a3b1c6;
  
  /* 文字与细线语义 */
  --${namespace}-ink:              #4a5568;
  --${namespace}-mu:               #8390a6;
  --${namespace}-ln:               rgba(131, 144, 166, 0.28);
  --${namespace}-pri:              #4d7cfe;
  --${namespace}-on:               #ffffff;

  /* 核心协议四色语义 */
  --${namespace}-tcp:              #2dbd6e;  /* 连接绿 */
  --${namespace}-cmd:              #f5a623;  /* 交互橙 */
  --${namespace}-rsp:              #8b6cf0;  /* 应答紫 */
  --${namespace}-dat:              #4d8cff;  /* 载荷蓝 */

  /* 状态与告警色 */
  --${namespace}-sel:              #fdecee;
  --${namespace}-red:              #ec5b62;
  --${namespace}-ok:               #dff4e8;

  /* 核心新拟态阴影阶梯 (Neumorphic Elevations) */
  --${namespace}-sp:  9px 9px 18px var(--${namespace}-sd), -9px -9px 18px var(--${namespace}-sl); /* 大卡片凸起 */
  --${namespace}-su:  6px 6px 13px var(--${namespace}-sd), -6px -6px 13px var(--${namespace}-sl); /* 中凸起 */
  --${namespace}-ss:  3px 3px 7px var(--${namespace}-sd),  -3px -3px 7px var(--${namespace}-sl);  /* 小凸起(按钮/微卡) */
  --${namespace}-si:  inset 5px 5px 10px var(--${namespace}-sd), inset -5px -5px 10px var(--${namespace}-sl); /* 大面积内凹槽 */
  --${namespace}-sis: inset 2px 2px 5px var(--${namespace}-sd),  inset -2px -2px 5px var(--${namespace}-sl);  /* 控件内凹微槽 */

  /* 字体规范 */
  --${namespace}-f: -apple-system, "PingFang SC", "Helvetica Neue", "Microsoft YaHei", sans-serif;
  --${namespace}-m: "IBM Plex Mono", "Noto Sans Mono CJK SC", monospace;

  /* 系统映射兼容变量 */
  --${namespace}-primary:          var(--${namespace}-pri);
  --${namespace}-primary-dark:     #3b62cc;
  --${namespace}-primary-bg:       rgba(77, 124, 254, 0.12);
  --${namespace}-primary-border:   transparent;
  --${namespace}-text:             var(--${namespace}-ink);
  --${namespace}-text-muted:       var(--${namespace}-mu);
  --${namespace}-text-light:       var(--${namespace}-mu);
  --${namespace}-border:           var(--${namespace}-ln);
  --${namespace}-border-light:     var(--${namespace}-ln);
  --${namespace}-success:          var(--${namespace}-tcp);
  --${namespace}-warning:          var(--${namespace}-cmd);
  --${namespace}-danger:           var(--${namespace}-red);
}

/* 暗色主题适配 (Dark Neumorphism) */
:root[data-theme="dark"], body[data-theme="dark"] {
  --${namespace}-bg:  #2a2e38;
  --${namespace}-pn:  #2a2e38;
  --${namespace}-sl:  #363b48;
  --${namespace}-sd:  #1b1e25;
  --${namespace}-ink: #c9d1e0;
  --${namespace}-mu:  #8b95aa;
  --${namespace}-ln:  rgba(255, 255, 255, 0.08);
  --${namespace}-pri: #4d7cfe;
  --${namespace}-ok:  #173a28;
  --${namespace}-sel: #3a2328;
  --${namespace}-red: #ec5b62;
}

/* ══════════════════════════════════════════════
   3. Layout — Shell / Main / 浮雕圆角 Sidebar
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
  padding: 18px 24px;
  gap: 22px;
}

.${namespace}-divider {
  height: 16px;
}

/* 侧边栏：大圆角新拟态悬浮容器 */
.${namespace}-sidebar {
  width: 330px;
  background: var(--${namespace}-pn);
  border-radius: 26px;
  box-shadow: var(--${namespace}-sp);
  border: 0;
  display: flex;
  flex-direction: column;
  overflow: hidden;
  flex-shrink: 0;
}

.${namespace}-sidebar-head {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 20px 24px 14px;
  background: transparent;
  flex-shrink: 0;
}
.${namespace}-sidebar-head h2 {
  font-size: 18px;
  font-weight: 700;
  letter-spacing: .06em;
  color: var(--${namespace}-ink);
  margin: 0;
}
.${namespace}-sidebar-head .${namespace}-dots {
  color: var(--${namespace}-mu);
  letter-spacing: 2px;
  font-size: 14px;
  cursor: pointer;
}

/* 侧栏选项卡内凹槽 */
.${namespace}-sidebar-tabs {
  display: flex;
  padding: 5px;
  gap: 4px;
  margin: 0 20px 14px;
  background: var(--${namespace}-pn);
  border-radius: 16px;
  box-shadow: var(--${namespace}-sis);
  border: 0;
  flex-shrink: 0;
}
.${namespace}-sidebar-tabs b {
  flex: 1;
  text-align: center;
  padding: 7px 8px;
  cursor: pointer;
  border: 0;
  border-radius: 12px;
  font-weight: 600;
  font-size: 12px;
  white-space: nowrap;
  color: var(--${namespace}-mu);
  transition: .15s;
}
.${namespace}-sidebar-tabs b:hover {
  color: var(--${namespace}-ink);
}
.${namespace}-sidebar-tabs b.on {
  color: var(--${namespace}-pri);
  box-shadow: var(--${namespace}-ss);
  background: var(--${namespace}-pn);
}
.${namespace}-sidebar-tabs .cnt {
  font-style: normal;
  font-size: 11px;
  padding: 1px 7px;
  margin-left: 5px;
  border-radius: 10px;
  color: var(--${namespace}-mu);
  box-shadow: var(--${namespace}-sis);
}
.${namespace}-sidebar-tabs b.on .cnt {
  color: var(--${namespace}-pri);
}

.${namespace}-nav-section {
  font-size: 11px;
  font-weight: 700;
  letter-spacing: .12em;
  color: var(--${namespace}-mu);
  text-transform: uppercase;
  padding: 10px 24px 4px;
}

/* 侧边栏列表内凹槽池 */
.${namespace}-nav-list,
.${namespace}-sidebar-list {
  flex: 1;
  overflow-y: auto;
  margin: 0 18px 20px;
  padding: 8px;
  border-radius: 20px;
  box-shadow: var(--${namespace}-si);
}

.${namespace}-nav-item {
  display: flex;
  align-items: center;
  gap: 14px;
  padding: 10px 14px;
  margin: 4px 0;
  border-radius: 14px;
  color: var(--${namespace}-ink);
  cursor: pointer;
  border: 0;
  transition: all .15s ease;
  position: relative;
}
.${namespace}-nav-item:hover {
  box-shadow: var(--${namespace}-ss);
}
.${namespace}-nav-item.${namespace}-active {
  box-shadow: var(--${namespace}-ss);
  color: var(--${namespace}-pri);
}

.${namespace}-nav-item-content {
  flex: 1;
  min-width: 0;
}
.${namespace}-nav-item strong {
  display: block;
  font-size: 14px;
  font-weight: 700;
  font-family: var(--${namespace}-m);
  letter-spacing: .08em;
  line-height: 1.3;
}
.${namespace}-nav-item span {
  display: block;
  color: var(--${namespace}-mu);
  font-size: 12px;
  white-space: nowrap;
  overflow: hidden;
  text-overflow: ellipsis;
}

.${namespace}-nav-item .${namespace}-rd {
  width: 18px;
  height: 18px;
  border-radius: 50%;
  flex-shrink: 0;
  box-shadow: var(--${namespace}-sis);
  transition: .2s;
  background: transparent;
}
.${namespace}-nav-item.${namespace}-active .${namespace}-rd {
  background: var(--${namespace}-tcp);
  box-shadow: 0 0 10px rgba(45, 189, 110, .65);
}

.${namespace}-nav-item .${namespace}-arrow {
  text-decoration: none;
  font-size: 20px;
  color: var(--${namespace}-mu);
  transition: transform .2s ease, color .2s ease;
  line-height: 1;
}
.${namespace}-nav-item.${namespace}-active .${namespace}-arrow {
  transform: rotate(90deg);
  color: var(--${namespace}-pri);
}

.${namespace}-nav-sub {
  display: flex;
  gap: 12px;
  padding: 8px 16px;
  margin: 4px 6px;
  align-items: center;
  border-radius: 12px;
  cursor: pointer;
  box-shadow: var(--${namespace}-sis);
  transition: .15s;
}
.${namespace}-nav-sub b {
  width: 24px;
  height: 24px;
  border-radius: 50%;
  background: var(--${namespace}-mu);
  color: #fff;
  display: grid;
  place-items: center;
  font-size: 11px;
  font-weight: 700;
  flex-shrink: 0;
  box-shadow: var(--${namespace}-ss);
}
.${namespace}-nav-sub strong {
  display: block;
  font-size: 12.5px;
  color: var(--${namespace}-ink);
}
.${namespace}-nav-sub span {
  display: block;
  font-size: 11px;
  color: var(--${namespace}-mu);
}

/* 内容主区域 */
.${namespace}-content {
  flex: 1;
  overflow: hidden;
  display: flex;
  flex-direction: column;
  gap: 18px;
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
  padding: 0 0 80px 0;
  display: flex;
  flex-direction: column;
  gap: 20px;
}

/* ══════════════════════════════════════════════
   4. Topbar & Header Dashboard
   ══════════════════════════════════════════════ */
.${namespace}-topbar {
  background: var(--${namespace}-pn);
  border-radius: 26px;
  box-shadow: var(--${namespace}-sp);
  height: 72px;
  display: flex;
  align-items: center;
  padding: 0 28px;
  gap: 28px;
  margin-bottom: 4px;
  flex-shrink: 0;
  border: 0;
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
  font-family: var(--${namespace}-m);
  letter-spacing: .18em;
  font-weight: 700;
  color: var(--${namespace}-ink);
}
.${namespace}-logo em {
  font-style: italic;
  color: var(--${namespace}-pri);
}

.${namespace}-tnav {
  padding: 8px 16px;
  border-radius: 14px;
  font-size: 13px;
  font-weight: 600;
  cursor: pointer;
  color: var(--${namespace}-mu);
  transition: .15s;
}
.${namespace}-tnav:hover {
  color: var(--${namespace}-ink);
}
.${namespace}-tnav.${namespace}-active {
  color: var(--${namespace}-pri);
  box-shadow: var(--${namespace}-sis);
}

.${namespace}-topbar-right {
  margin-left: auto;
  display: flex;
  align-items: center;
  gap: 16px;
  font-size: 12px;
}

/* 拟态进度方格 */
.${namespace}-cells {
  display: flex;
  gap: 4px;
  padding: 5px;
  border-radius: 10px;
  box-shadow: var(--${namespace}-sis);
  width: max-content;
}
.${namespace}-cells i {
  width: 12px;
  height: 12px;
  border-radius: 4px;
  background: var(--${namespace}-ln);
  transition: .2s;
}
.${namespace}-cells i.f {
  background: linear-gradient(145deg, #7aa0ff, #4d7cfe);
  box-shadow: 0 0 6px rgba(77, 124, 254, .6);
}

/* 主题切换开关组 */
.${namespace}-th {
  display: flex;
  gap: 8px;
}
.${namespace}-th button {
  width: 42px;
  height: 38px;
  border: 0;
  border-radius: 12px;
  background: var(--${namespace}-pn);
  color: var(--${namespace}-ink);
  box-shadow: var(--${namespace}-ss);
  cursor: pointer;
  transition: .15s;
}
.${namespace}-th button:hover {
  color: var(--${namespace}-pri);
}
.${namespace}-th button.on {
  box-shadow: var(--${namespace}-sis);
  color: var(--${namespace}-pri);
}

/* ══════════════════════════════════════════════
   5. Breadcrumb & Record Navigation
   ══════════════════════════════════════════════ */
.${namespace}-breadcrumb {
  background: var(--${namespace}-pn);
  border-radius: 14px;
  box-shadow: var(--${namespace}-ss);
  padding: 0 16px;
  height: 38px;
  display: flex;
  align-items: center;
  gap: 8px;
  font-size: 12px;
  color: var(--${namespace}-mu);
  flex-shrink: 0;
}
.${namespace}-breadcrumb a {
  color: var(--${namespace}-ink);
  text-decoration: none;
  font-weight: 600;
}
.${namespace}-breadcrumb a:hover {
  color: var(--${namespace}-pri);
}

.${namespace}-record-nav {
  margin-left: auto;
  display: flex;
  align-items: center;
  gap: 6px;
}
.${namespace}-rn-btn {
  display: inline-flex;
  align-items: center;
  justify-content: center;
  height: 28px;
  padding: 0 10px;
  border: 0;
  border-radius: 10px;
  background: var(--${namespace}-pn);
  box-shadow: var(--${namespace}-ss);
  color: var(--${namespace}-ink);
  font-size: 11px;
  font-weight: 600;
  cursor: pointer;
  transition: .15s;
}
.${namespace}-rn-btn:hover:not(:disabled) {
  color: var(--${namespace}-pri);
}
.${namespace}-rn-btn:active:not(:disabled) {
  box-shadow: var(--${namespace}-sis);
}
.${namespace}-rn-btn:disabled {
  opacity: .4;
  box-shadow: none;
  cursor: not-allowed;
}
.${namespace}-rn-idx {
  height: 28px;
  padding: 0 10px;
  font-size: 11px;
  font-weight: 700;
  color: var(--${namespace}-mu);
  border-radius: 10px;
  box-shadow: var(--${namespace}-sis);
  display: inline-flex;
  align-items: center;
}

/* ══════════════════════════════════════════════
   6. Object Header (Protocol Title & Status)
   ══════════════════════════════════════════════ */
.${namespace}-obj-head {
  background: var(--${namespace}-pn);
  border-radius: 22px;
  box-shadow: var(--${namespace}-su);
  padding: 18px 24px;
  display: flex;
  align-items: center;
  gap: 16px;
  flex-shrink: 0;
}
.${namespace}-obj-title {
  font-size: 26px;
  font-family: var(--${namespace}-m);
  letter-spacing: .08em;
  font-weight: 700;
  color: var(--${namespace}-ink);
}
.${namespace}-obj-meta {
  font-size: 12px;
  color: var(--${namespace}-mu);
  display: flex;
  gap: 14px;
  margin-top: 4px;
}

/* ══════════════════════════════════════════════
   7. Tabs & Filter Pills (内凹槽与段控制器)
   ══════════════════════════════════════════════ */
.${namespace}-tabs {
  display: flex;
  padding: 5px;
  gap: 4px;
  border-radius: 16px;
  background: var(--${namespace}-pn);
  box-shadow: var(--${namespace}-sis);
  margin: 0;
}
.${namespace}-tab {
  flex: 1;
  text-align: center;
  padding: 7px 14px;
  cursor: pointer;
  font-weight: 600;
  white-space: nowrap;
  border-radius: 12px;
  color: var(--${namespace}-mu);
  transition: .15s;
}
.${namespace}-tab:hover {
  color: var(--${namespace}-ink);
}
.${namespace}-tab.${namespace}-active {
  color: var(--${namespace}-pri);
  box-shadow: var(--${namespace}-ss);
  background: var(--${namespace}-pn);
}

.${namespace}-tab-badge {
  font-style: normal;
  font-size: 11px;
  padding: 0 8px;
  margin-left: 6px;
  border-radius: 10px;
  color: var(--${namespace}-mu);
  box-shadow: var(--${namespace}-sis);
}
.${namespace}-tab.${namespace}-active .${namespace}-tab-badge {
  color: var(--${namespace}-pri);
}

.${namespace}-seg {
  display: inline-flex;
  padding: 5px;
  gap: 4px;
  border-radius: 16px;
  background: var(--${namespace}-pn);
  box-shadow: var(--${namespace}-sis);
}
.${namespace}-seg b {
  flex: 1;
  text-align: center;
  padding: 7px 14px;
  cursor: pointer;
  font-weight: 600;
  white-space: nowrap;
  border-radius: 12px;
  color: var(--${namespace}-mu);
  transition: .15s;
}
.${namespace}-seg b.on {
  color: var(--${namespace}-pri);
  box-shadow: var(--${namespace}-ss);
  background: var(--${namespace}-pn);
}

/* ══════════════════════════════════════════════
   8. Panel (新拟态柔和浮雕卡片)
   ══════════════════════════════════════════════ */
.${namespace}-panel {
  background: var(--${namespace}-pn, #e0e5ec);
  border-radius: 24px;

  /* 
     暗部依然向右下外部投射；
     高光改用两层：
     1. 外层只给极微弱、不占空间的 2px~3px 漫射；
     2. 内层（inset）沿左上内壁打出一道纯净柔和的高光弧线！
  */
  box-shadow: 
    /* 右下暗部（外部空间足够） */
    8px 8px 18px rgba(163, 177, 198, 0.7),
    
    /* 左上外高光：大幅收敛范围，仅 2px，绝不溢出到上方组件 */
    -2px -2px 6px rgba(255, 255, 255, 0.5),

    /* ★ 核心：左上内高光，把立体感锁在圆弧内部，永不破损截断 */
    inset 2px 2px 4px rgba(255, 255, 255, 0.9),
    inset -1px -1px 3px rgba(163, 177, 198, 0.2);

  /* 取消任何硬边框 */
  border: 0;
}

.${namespace}-panel-head {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 20px 28px 14px;
  gap: 14px;
  background: transparent;
}
.${namespace}-panel-head h2,
.${namespace}-panel-head h3 {
  font-size: 19px;
  letter-spacing: .04em;
  margin: 0;
  color: var(--${namespace}-ink);
  font-weight: 700;
}

/* ══════════════════════════════════════════════
   9. Field View (内嵌柔光只读展示网格)
   ══════════════════════════════════════════════ */
.${namespace}-fview {
  display: grid;
  grid-template-columns: repeat(4, 1fr);
  gap: 12px;
  padding: 16px 24px;
  background: transparent;
  font-family: var(--${namespace}-f);
}
.${namespace}-fview--1 { grid-template-columns: repeat(1, 1fr); }
.${namespace}-fview--2 { grid-template-columns: repeat(2, 1fr); }
.${namespace}-fview--3 { grid-template-columns: repeat(3, 1fr); }
.${namespace}-fview--6 { grid-template-columns: repeat(6, 1fr); }

.${namespace}-fv {
  display: flex;
  align-items: center;
  border-radius: 14px;
  box-shadow: var(--${namespace}-sis);
  min-height: 40px;
  background: var(--${namespace}-pn);
  padding: 4px;
  transition: box-shadow .15s;
}

.${namespace}-fv--span2 { grid-column: span 2; }
.${namespace}-fv--span3 { grid-column: span 3; }
.${namespace}-fv--span4 { grid-column: span 4; }

.${namespace}-fv-label {
  min-width: 86px;
  flex-shrink: 0;
  color: var(--${namespace}-mu);
  font-size: 12px;
  font-weight: 700;
  letter-spacing: .05em;
  padding: 6px 10px;
  border-radius: 10px;
  line-height: 1.3;
}

.${namespace}-fv-val {
  flex: 1;
  padding: 6px 12px;
  font-size: 13px;
  color: var(--${namespace}-ink);
  display: flex;
  align-items: center;
  min-width: 0;
  word-break: break-all;
}

.${namespace}-fv-val--mono    { font-family: var(--${namespace}-m); font-weight: 600; }
.${namespace}-fv-val--bold    { font-weight: 700; }
.${namespace}-fv-val--success { color: var(--${namespace}-tcp); font-weight: 700; }
.${namespace}-fv-val--danger  { color: var(--${namespace}-red); font-weight: 700; }
.${namespace}-fv-val--link    { color: var(--${namespace}-pri); cursor: pointer; text-decoration: none; }
.${namespace}-fv-val--link:hover { text-decoration: underline; }

.${namespace}-fv-file-item {
  display: inline-flex;
  align-items: center;
  gap: 8px;
  padding: 4px 12px;
  background: var(--${namespace}-pn);
  border-radius: 10px;
  box-shadow: var(--${namespace}-ss);
  color: var(--${namespace}-ink);
  text-decoration: none;
  font-size: 12px;
  transition: .15s;
}
.${namespace}-fv-file-item:hover {
  box-shadow: var(--${namespace}-su);
  color: var(--${namespace}-pri);
}

.${namespace}-fv--top {
  align-items: flex-start;
}
.${namespace}-fv-val--pre {
  white-space: pre-wrap;
  word-break: break-all;
  font-family: var(--${namespace}-m);
  padding: 8px 12px;
  border-radius: 12px;
  box-shadow: var(--${namespace}-sis);
  width: 100%;
}

/* ══════════════════════════════════════════════
   10. Form Grid & Input Controls (内凹槽体输入控件)
   ══════════════════════════════════════════════ */
.${namespace}-form {
  display: grid;
  grid-template-columns: repeat(2, 1fr);
  gap: 18px 24px;
  padding: 24px 28px;
}
.${namespace}-form--1 { grid-template-columns: 1fr; }
.${namespace}-form--3 { grid-template-columns: repeat(3, 1fr); }
.${namespace}-form--4 { grid-template-columns: repeat(4, 1fr); }

.${namespace}-field {
  display: grid;
  grid-template-columns: 92px 1fr;
  gap: 4px 14px;
  align-items: start;
  min-width: 0;
}

.${namespace}-field--span2 { grid-column: span 2; }
.${namespace}-field--span3 { grid-column: span 3; }
.${namespace}-field--span4,
.${namespace}-field.full   { grid-column: 1 / -1; }

.${namespace}-field > label,
.${namespace}-field-label {
  font-size: 12px;
  font-weight: 700;
  letter-spacing: .08em;
  color: var(--${namespace}-mu);
  text-align: right;
  line-height: 1.35;
  padding-top: 11px;
  user-select: none;
  transition: .15s;
}
.${namespace}-field:focus-within > label,
.${namespace}-field:focus-within .${namespace}-field-label {
  color: var(--${namespace}-pri);
}

.${namespace}-field-label--required::before,
.${namespace}-field > label.required::before {
  content: "* ";
  color: var(--${namespace}-red);
}

.${namespace}-field-control {
  grid-column: 2;
  display: flex;
  flex-direction: column;
  gap: 4px;
  min-width: 0;
}

/* 拟态核心：内凹微槽输入控件 */
.${namespace}-input,
.${namespace}-select,
.${namespace}-textarea,
.${namespace}-chips {
  font: inherit;
  font-size: 13.5px;
  color: var(--${namespace}-ink);
  background: var(--${namespace}-pn);
  border: 0;
  border-radius: 14px;
  box-shadow: var(--${namespace}-sis);
  padding: 10px 14px;
  width: 100%;
  outline: 0;
  transition: box-shadow .15s;
}
.${namespace}-textarea {
  resize: vertical;
  min-height: 80px;
}
.${namespace}-input:focus,
.${namespace}-select:focus,
.${namespace}-textarea:focus,
.${namespace}-chips:focus-within {
  box-shadow: var(--${namespace}-sis), 0 0 0 2px rgba(77, 124, 254, .55);
}

.${namespace}-input:disabled,
.${namespace}-select:disabled,
.${namespace}-textarea:disabled {
  opacity: .5;
  box-shadow: none;
  cursor: not-allowed;
}

/* 错误与合法验证状态 */
.${namespace}-field.err .${namespace}-input,
.${namespace}-field.err .${namespace}-select,
.${namespace}-field.err .${namespace}-textarea {
  box-shadow: var(--${namespace}-sis), 0 0 0 2px var(--${namespace}-red);
}
.${namespace}-field.err > label,
.${namespace}-field.err .${namespace}-field-label,
.${namespace}-field.err .hp {
  color: var(--${namespace}-red);
}
.${namespace}-field.err {
  animation: sk .3s;
}
@keyframes sk {
  25% { transform: translateX(-4px); }
  75% { transform: translateX(4px); }
}

.${namespace}-field.ok .${namespace}-input {
  box-shadow: var(--${namespace}-sis), 0 0 0 2px var(--${namespace}-tcp);
}
.${namespace}-field.ok .hp {
  color: var(--${namespace}-tcp);
}

.${namespace}-field-help,
.${namespace}-field .hp {
  font-size: 11.5px;
  color: var(--${namespace}-mu);
  min-height: 18px;
}

/* 数字步进器 */
.${namespace}-num {
  display: flex;
  gap: 10px;
  align-items: center;
}
.${namespace}-num button {
  width: 38px;
  height: 38px;
  flex: none;
  padding: 0;
  font-size: 18px;
  border-radius: 50%;
  border: 0;
  background: var(--${namespace}-pn);
  box-shadow: var(--${namespace}-ss);
  color: var(--${namespace}-ink);
  cursor: pointer;
  transition: .15s;
}
.${namespace}-num button:hover {
  color: var(--${namespace}-pri);
}
.${namespace}-num button:active {
  box-shadow: var(--${namespace}-sis);
  color: var(--${namespace}-pri);
}
.${namespace}-num .${namespace}-input {
  text-align: center;
}

/* 仿下拉组件 */
.${namespace}-sel {
  position: relative;
  display: flex;
}
.${namespace}-sel::after {
  content: "▾";
  position: absolute;
  right: 16px;
  top: 50%;
  transform: translateY(-50%);
  pointer-events: none;
  color: var(--${namespace}-mu);
  font-size: 12px;
}
.${namespace}-sel select {
  appearance: none;
  padding-right: 36px;
  cursor: pointer;
}

.${namespace}-form-section {
  grid-column: 1 / -1;
  font-size: 13px;
  font-weight: 700;
  letter-spacing: .08em;
  color: var(--${namespace}-mu);
  padding: 12px 0 4px;
  border-bottom: 1px solid var(--${namespace}-ln);
  margin-top: 8px;
}

/* ══════════════════════════════════════════════
   11. Buttons & 底部悬浮操作栏
   ══════════════════════════════════════════════ */
.${namespace}-btns,
.${namespace}-form-actions {
  display: flex;
  align-items: center;
  justify-content: flex-end;
  gap: 12px;
  width: 100%;
}

/* 拟态悬浮操作条 */
.${namespace}-form-footer {
  position: fixed;
  bottom: calc(16px + env(safe-area-inset-bottom, 0px));
  left: 32px;
  right: 32px;
  height: 60px;
  background: var(--${namespace}-pn);
  border-radius: 20px;
  box-shadow: var(--${namespace}-sp);
  padding: 0 24px;
  display: flex;
  align-items: center;
  justify-content: flex-end;
  gap: 12px;
  z-index: 100;
  border: 0;
}

.${namespace}-drawer .${namespace}-form-footer,
.${namespace}-dialog .${namespace}-form-footer {
  position: static;
  margin-top: auto;
  box-shadow: none;
  padding: 12px 0 0;
  border-radius: 0;
}

/* 实体按压按钮规范 */
.${namespace}-btn {
  font: 600 14px var(--${namespace}-f);
  color: var(--${namespace}-ink);
  cursor: pointer;
  border: 0;
  border-radius: 14px;
  padding: 10px 20px;
  background: var(--${namespace}-pn);
  box-shadow: var(--${namespace}-ss);
  transition: box-shadow .15s, color .15s, transform .15s;
  display: inline-flex;
  align-items: center;
  justify-content: center;
  gap: 6px;
  white-space: nowrap;
}
.${namespace}-btn:hover {
  color: var(--${namespace}-pri);
}
.${namespace}-btn:active {
  box-shadow: var(--${namespace}-sis);
  color: var(--${namespace}-pri);
  transform: scale(0.98);
}

/* 渐变发光主要按钮 */
.${namespace}-btn--primary {
  color: #ffffff;
  background: linear-gradient(145deg, #6b93ff, #3f6df0);
  box-shadow: 5px 5px 12px rgba(63, 109, 240, .35), -4px -4px 10px var(--${namespace}-sl);
}
.${namespace}-btn--primary:hover {
  color: #ffffff;
  filter: brightness(1.07);
}
.${namespace}-btn--primary:active {
  color: #ffffff;
  box-shadow: inset 3px 3px 8px rgba(20, 50, 160, .55);
}

.${namespace}-btn--danger {
  color: var(--${namespace}-red);
}
.${namespace}-btn--ghost {
  box-shadow: none;
}
.${namespace}-btn--ghost:hover {
  box-shadow: var(--${namespace}-ss);
}
.${namespace}-btn:disabled {
  opacity: .45;
  pointer-events: none;
}

.${namespace}-btn--sm { height: 32px; padding: 0 12px; font-size: 12px; border-radius: 10px; }
.${namespace}-btn--lg { height: 46px; padding: 0 26px; font-size: 15px; border-radius: 16px; }

/* ══════════════════════════════════════════════
   12. Switch, Badge, Tag & Packet Circle Numbers
   ══════════════════════════════════════════════ */
.${namespace}-pill,
.${namespace}-tag {
  --c: var(--${namespace}-tcp);
  display: inline-flex;
  gap: 8px;
  align-items: center;
  padding: 4px 14px 4px 10px;
  border-radius: 16px;
  font-weight: 600;
  font-size: 12px;
  color: var(--${namespace}-ink);
  box-shadow: var(--${namespace}-sis);
}
.${namespace}-pill i {
  width: 10px;
  height: 10px;
  border-radius: 50%;
  background: var(--c);
  box-shadow: 0 0 8px var(--c);
}
.${namespace}-pill.live i {
  animation: pu 1.6s infinite;
}
@keyframes pu {
  50% { box-shadow: 0 0 14px 4px var(--c); }
}

.${namespace}-bd,
.${namespace}-pkt-no {
  --c: var(--${namespace}-mu);
  width: 28px;
  height: 28px;
  border-radius: 50%;
  color: #ffffff;
  font-weight: 700;
  font-size: 13px;
  background: var(--c);
  box-shadow: 3px 3px 7px var(--${namespace}-sd), -3px -3px 7px var(--${namespace}-sl);
  display: inline-grid;
  place-items: center;
  flex-shrink: 0;
}

/* 拟态弧形开关 */
.${namespace}-switch-wrap {
  display: inline-flex;
  align-items: center;
  gap: 10px;
  cursor: pointer;
  user-select: none;
}
.${namespace}-switch-input {
  position: absolute;
  opacity: 0;
  pointer-events: none;
}
.${namespace}-switch-track {
  position: relative;
  width: 52px;
  height: 28px;
  border-radius: 14px;
  background: var(--${namespace}-pn);
  box-shadow: var(--${namespace}-sis);
  transition: .2s;
  flex-shrink: 0;
  display: block;
}
.${namespace}-switch-track::after {
  content: "";
  position: absolute;
  left: 3px;
  top: 3px;
  width: 22px;
  height: 22px;
  border-radius: 50%;
  background: var(--${namespace}-pn);
  box-shadow: var(--${namespace}-ss);
  transition: .2s;
}
.${namespace}-switch-input:checked + .${namespace}-switch-track::after {
  left: 27px;
  background: var(--${namespace}-pri);
  box-shadow: 3px 3px 7px var(--${namespace}-sd), 0 0 10px rgba(77, 124, 254, .6);
}

/* ══════════════════════════════════════════════
   13. Table (内凹时序数据视口网格)
   ══════════════════════════════════════════════ */
.${namespace}-table-wrap {
  overflow: auto;
  border-radius: 20px;
  box-shadow: var(--${namespace}-si);
  padding: 6px;
  margin: 0 24px 24px;
}
.${namespace}-table {
  border-collapse: collapse;
  width: 100%;
  white-space: nowrap;
  font: 13px var(--${namespace}-m);
}
.${namespace}-table th {
  position: sticky;
  top: 0;
  background: var(--${namespace}-pn);
  text-align: left;
  padding: 10px 14px;
  color: var(--${namespace}-mu);
  font-weight: 600;
  border-bottom: 1px solid var(--${namespace}-ln);
}
.${namespace}-table td {
  padding: 8px 14px;
  border-top: 1px solid var(--${namespace}-ln);
  color: var(--${namespace}-ink);
}
.${namespace}-table tr.cur {
  background: rgba(77, 124, 254, .12);
}
.${namespace}-table tr.cur td:first-child {
  box-shadow: inset 3px 0 0 var(--${namespace}-pri);
}

/* ══════════════════════════════════════════════
   14. Alert & Toast System (悬浮发光实体弹窗)
   ══════════════════════════════════════════════ */
.${namespace}-toast-wrap {
  position: fixed;
  right: 20px;
  bottom: calc(20px + env(safe-area-inset-bottom, 0px));
  display: flex;
  flex-direction: column;
  gap: 12px;
  z-index: 9999;
}
.${namespace}-toast,
.${namespace}-alert {
  --c: var(--${namespace}-tcp);
  position: relative;
  min-width: 250px;
  padding: 14px 20px 14px 40px;
  border-radius: 16px;
  background: var(--${namespace}-pn);
  box-shadow: var(--${namespace}-sp);
  border: 0;
  color: var(--${namespace}-ink);
  animation: tin .3s both;
}
.${namespace}-toast::before,
.${namespace}-alert::before {
  content: "";
  position: absolute;
  left: 18px;
  top: 20px;
  width: 10px;
  height: 10px;
  border-radius: 50%;
  background: var(--c);
  box-shadow: 0 0 8px var(--c);
}
.${namespace}-toast b,
.${namespace}-alert b {
  color: var(--c);
}
@keyframes tin {
  from { opacity: 0; transform: translateX(30px); }
}

/* ══════════════════════════════════════════════
   15. Status Bar & Telemetry Strip
   ══════════════════════════════════════════════ */
.${namespace}-statusbar {
  background: var(--${namespace}-pn);
  border-radius: 14px;
  box-shadow: var(--${namespace}-ss);
  padding: 6px 18px;
  font-size: 12px;
  color: var(--${namespace}-mu);
  display: flex;
  align-items: center;
  gap: 16px;
  margin: 0 24px 12px;
}
.${namespace}-clock {
  font-family: var(--${namespace}-m);
  color: var(--${namespace}-ink);
  font-weight: 700;
}

/* ══════════════════════════════════════════════
   16. Timeline & Stepper (发光与内嵌凹轨步骤条)
   ══════════════════════════════════════════════ */
.${namespace}-timeline,
.${namespace}-stp {
  list-style: none;
  margin: 0;
  padding: 0;
}
.${namespace}-stp li {
  display: flex;
  gap: 14px;
  padding-bottom: 16px;
  position: relative;
}
.${namespace}-stp li:not(:last-child)::before {
  content: "";
  position: absolute;
  left: 13px;
  top: 34px;
  bottom: 2px;
  width: 4px;
  border-radius: 2px;
  box-shadow: var(--${namespace}-sis);
}
.${namespace}-stp b {
  --c: var(--${namespace}-mu);
  flex: none;
  width: 30px;
  height: 30px;
  border-radius: 50%;
  color: #ffffff;
  font-weight: 700;
  background: var(--c);
  box-shadow: var(--${namespace}-ss);
  display: grid;
  place-items: center;
  cursor: pointer;
  font-size: 13px;
  transition: .2s;
}
.${namespace}-stp .ok b {
  --c: var(--${namespace}-tcp);
}
.${namespace}-stp .on b {
  --c: var(--${namespace}-pri);
  animation: pu 1.6s infinite;
}
.${namespace}-stp span {
  display: block;
  color: var(--${namespace}-mu);
  font-size: 12.5px;
}

/* ══════════════════════════════════════════════
   17. Sequence & Network Viewport (柔光接线端)
   ══════════════════════════════════════════════ */
.${namespace}-tr {
  position: relative;
  height: 130px;
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 0 20px;
  border-radius: 20px;
  box-shadow: var(--${namespace}-si);
}
.${namespace}-nd {
  width: 104px;
  padding: 10px 6px;
  text-align: center;
  font-weight: 700;
  z-index: 1;
  border-radius: 16px;
  background: var(--${namespace}-pn);
  box-shadow: var(--${namespace}-su);
  border: 0;
}
.${namespace}-nd small {
  display: block;
  color: var(--${namespace}-mu);
  font: 400 10.5px var(--${namespace}-m);
}
.${namespace}-wire {
  position: absolute;
  left: 122px;
  right: 122px;
  top: 50%;
  height: 8px;
  margin-top: -4px;
  border-radius: 4px;
  box-shadow: var(--${namespace}-sis);
}

/* ══════════════════════════════════════════════
   18. Tooltip Mark & Hover Hints
   ══════════════════════════════════════════════ */
.${namespace}-tooltip-mark,
.${namespace}-tp {
  position: relative;
  border-bottom: 1px dotted var(--${namespace}-mu);
  cursor: help;
}
.${namespace}-tp::after {
  content: attr(data-t);
  position: absolute;
  left: 50%;
  bottom: 140%;
  transform: translate(-50%, 6px);
  padding: 6px 12px;
  white-space: nowrap;
  font-size: 12px;
  border-radius: 12px;
  background: var(--${namespace}-pn);
  box-shadow: var(--${namespace}-su);
  color: var(--${namespace}-ink);
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
  border-radius: 26px;
  box-shadow: var(--${namespace}-sp);
  padding: 32px;
  border: 0;
}
.${namespace}-of__table {
  width: 100%;
  border-collapse: separate;
  border-spacing: 4px;
}
.${namespace}-of__table td {
  border-radius: 10px;
  box-shadow: var(--${namespace}-sis);
  height: 36px;
  padding: 6px 12px;
  border: 0;
}
.${namespace}-of__label {
  background: var(--${namespace}-pn);
  box-shadow: var(--${namespace}-ss);
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
  border-radius: 26px;
  box-shadow: var(--${namespace}-sp);
  border: 0;
}

/* ══════════════════════════════════════════════
   21. KPI Card & RTT Bars (内凹槽微型柱状图)
   ══════════════════════════════════════════════ */
.${namespace}-kpi-card {
  background: var(--${namespace}-pn);
  border-radius: 20px;
  box-shadow: var(--${namespace}-su);
  padding: 20px;
  display: flex;
  flex-direction: column;
  gap: 10px;
}
.${namespace}-kpi-num {
  font-size: 32px;
  font-weight: 700;
  font-family: var(--${namespace}-m);
  letter-spacing: .08em;
  color: var(--${namespace}-ink);
}
.${namespace}-bars {
  display: flex;
  gap: 4px;
  align-items: flex-end;
  height: 80px;
  padding: 10px;
  border-radius: 16px;
  box-shadow: var(--${namespace}-si);
}
.${namespace}-bars i {
  flex: 1;
  border-radius: 4px;
  background: var(--${namespace}-tcp);
  box-shadow: 2px 2px 4px var(--${namespace}-sd);
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
.${namespace}-row--gap { margin-left: -8px; margin-right: -8px; }
.${namespace}-row--gap > [class*="${namespace}-col-"] { padding-left: 8px; padding-right: 8px; }

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

@media (max-width: 768px) {
  .${namespace}-sidebar { width: 100%; }
  .${namespace}-main { flex-direction: column; }
  .${namespace}-form { grid-template-columns: 1fr; }
  .${namespace}-field { grid-template-columns: 1fr; }
  .${namespace}-field > label { text-align: left; padding-top: 0; }
  .${namespace}-field-control { grid-column: 1; }
  .${namespace}-form-footer { left: 16px; right: 16px; }
  .${namespace}-col-sm-24 { flex: 0 0 100%; max-width: 100%; }
}

/* ══════════════════════════════════════════════
   23. Tile Component Library 包含引入
   ══════════════════════════════════════════════ */
<#include "/$/tile.css.ftl">