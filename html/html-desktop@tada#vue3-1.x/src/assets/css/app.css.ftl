/**
 * TADA Design System — 治愈系微目标与萌宠交互设计规范
 * 基于 tada-ui-styles 风格提炼，融合软萌果冻质感、微启动减压心理学与精致卡片视觉
 * ─────────────────────────────────────────────
 * 目录
 *  1. Reset & Base
 *  2. Design Tokens (重构薄荷绿、奶黄、果冻阴影与软糯圆角体系)
 *  3. Layout (三栏流式布局与侧边微徽章)
 *  4. Topbar (薄荷奶绿渐变顶栏与桌面小宠互动)
 *  5. Sub Nav (糖果次级功能带)
 *  6. Breadcrumb & Record Nav (胶囊面包屑与翻页圆钮)
 *  7. Object Header (目标状态卡片与徽章插画头)
 *  8. Tabs (果冻高光标签栏)
 *  9. Panel (左侧薄荷指示条经典贴纸面板)
 * 10. Field View (微凸数据展示网格)
 * 11. Form Grid (高亲和力表单与微启动滑块)
 * 12. Buttons (3D 下压果冻按钮体系)
 * 13. Badge / Tag (贴纸马卡龙胶囊标签)
 * 14. Table (数据台账与微进度条)
 * 15. Alert / Notice (伴随提示气泡与复盘公告)
 * 16. Status Bar (萌宠饱腹度与连接状态栏)
 * 17. Timeline (小步慢跑足迹时间轴)
 * 18. Map / Canvas Placeholder (习惯原野插画占位)
 * 19. Tooltip Mark (小爪印提示气泡)
 * 20. OfficialForm (目标承诺与里程碑公文单)
 * 21. Grid System (响应式 24 栅格系统)
 * ─────────────────────────────────────────────
 */

/* ══════════════════════════════════════════════
   1. Reset & Base
   ══════════════════════════════════════════════ */
*, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }

html, body {
  height: 100%;
  font-family: var(--${namespace}-font);
  font-size: 13px;
  color: var(--${namespace}-text);
  background: var(--${namespace}-bg-page);
  background-image: 
    radial-gradient(var(--${namespace}-dot-color) 1.5px, transparent 1.5px), 
    radial-gradient(var(--${namespace}-dot-color) 1.5px, var(--${namespace}-bg-page) 1.5px);
  background-size: 28px 28px;
  background-position: 0 0, 14px 14px;
  overflow: hidden;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}

/* ══════════════════════════════════════════════
   2. Design Tokens
   ══════════════════════════════════════════════ */
:root {
  /* -- Primary / 薄荷奶绿核心色 (主品牌色，治愈低压力) -- */
  --${namespace}-primary:          #10B981;
  --${namespace}-primary-dark:     #059669;
  --${namespace}-primary-deep:     #047857;
  --${namespace}-primary-bg:       #ECFDF5;
  --${namespace}-primary-border:   #A7F3D0;
  --${namespace}-primary-hover:    #D1FAE5;

  /* -- Gold & Honey / 奶酪暖黄 (小柴陪伴与里程碑成就) -- */
  --${namespace}-gold:             #FBBF24;
  --${namespace}-gold-dark:        #D97706;
  --${namespace}-gold-bg:          #FFFBEB;
  --${namespace}-gold-border:      #FDE68A;

  /* -- Success (元气绿) -- */
  --${namespace}-success:          #10B981;
  --${namespace}-success-dark:     #047857;
  --${namespace}-success-bg:       #F0FDF4;
  --${namespace}-success-border:   #BBF7D0;

  /* -- Danger (蜜桃柔红 - 弱化刺眼感) -- */
  --${namespace}-danger:           #F43F5E;
  --${namespace}-danger-dark:      #BE123C;
  --${namespace}-danger-bg:        #FFF1F2;
  --${namespace}-danger-border:    #FECDD3;

  /* -- Warning (香橙日落) -- */
  --${namespace}-warning:          #F97316;
  --${namespace}-warning-bg:       #FFF7ED;
  --${namespace}-warning-border:   #FFEDD5;

  /* -- Purple & Lavender (灵感紫) -- */
  --${namespace}-purple:           #8B5CF6;
  --${namespace}-purple-bg:        #F5F3FF;
  --${namespace}-purple-border:    #DDD6FE;

  /* -- Teal (深海蓝绿) -- */
  --${namespace}-teal:             #14B8A6;
  --${namespace}-teal-bg:          #F0FDFA;
  --${namespace}-teal-border:      #CCFBF1;

  /* -- Neutral text (深森暖棕色，比死黑更亲和柔和) -- */
  --${namespace}-text:             #1E293B;
  --${namespace}-text-muted:       #475569;
  --${namespace}-text-light:       #94A3B8;
  --${namespace}-text-disabled:    #CBD5E1;

  /* -- Neutral surface (奶油象牙白，减轻长时间工作眼疲劳) -- */
  --${namespace}-border:           #E2EFE8;
  --${namespace}-border-light:     #EEF5F1;
  --${namespace}-bg:               #FFFFFF;
  --${namespace}-bg-page:          #EDF5F1;
  --${namespace}-dot-color:        #CCE7DA;
  --${namespace}-bg-hover:         #F3FAF6;

  /* -- Typography (圆润软萌字体) -- */
  --${namespace}-font:   "Nunito", -apple-system, BlinkMacSystemFont, "PingFang SC", "Hiragino Sans GB", "Microsoft YaHei", sans-serif;
  --${namespace}-mono:   "SF Mono", Consolas, Menlo, Monaco, monospace;

  /* -- Spacing -- */
  --${namespace}-sp-xs:  4px;
  --${namespace}-sp-sm:  8px;
  --${namespace}-sp-md:  14px;
  --${namespace}-sp-lg:  20px;

  /* -- Radius (超大软糖圆角) -- */
  --${namespace}-radius-sm: 8px;
  --${namespace}-radius-md: 16px;
  --${namespace}-radius-lg: 24px;
  --${namespace}-radius-pill: 9999px;

  /* -- 3D Jelly Shadow (立体果冻拟物投影) -- */
  --${namespace}-shadow-inset: inset 0 2px 4px rgba(16, 185, 129, 0.06);
  --${namespace}-shadow-sm: 0 4px 0 #D2E7DC, 0 6px 12px rgba(45, 74, 62, 0.04);
  --${namespace}-shadow-md: 0 8px 24px -4px rgba(16, 185, 129, 0.12), 0 4px 8px -2px rgba(0, 0, 0, 0.03);
  --${namespace}-shadow-jelly: 0 4px 0 var(--${namespace}-primary-deep), 0 8px 16px rgba(5, 150, 105, 0.25);

  /* Shortcuts / Aliases */
  --${namespace}-p: #10B981; --${namespace}-pd: #059669; --${namespace}-ph: #D1FAE5;
  --${namespace}-pb: #ECFDF5; --${namespace}-pbd: #A7F3D0;
  --${namespace}-bl: #EEF5F1; --${namespace}-bd: #E2EFE8; --${namespace}-bg: #fff; --${namespace}-bgp: #EDF5F1;
  --${namespace}-t: #1E293B; --${namespace}-tm: #475569; --${namespace}-tl: #94A3B8;
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

/* Sidebar (奶油贴纸抽屉风格) */
.${namespace}-sidebar {
  width: 220px;
  background: var(--${namespace}-bg);
  border-right: 3px solid var(--${namespace}-border);
  overflow-y: auto;
  flex-shrink: 0;
  display: flex;
  flex-direction: column;
  justify-content: space-between;
  padding: 12px 0;
}

.${namespace}-toolbar {
  flex-shrink: 0;
  display: flex;
  align-items: center;
  gap: 10px;
  padding: 12px 18px;
  background: var(--${namespace}-bg);
  border-bottom: 2px solid var(--${namespace}-border);
  border: 3px solid var(--${namespace}-border);
  border-radius: var(--${namespace}-radius-lg);
  box-shadow: var(--${namespace}-shadow-sm);
}

.${namespace}-nav-section {
  font-size: 11px;
  font-weight: 900;
  color: var(--${namespace}-text-light);
  letter-spacing: .08em;
  padding: 12px 18px 6px;
  background: transparent;
  display: flex;
  align-items: center;
  gap: 4px;
}

.${namespace}-nav-item {
  margin: 4px 12px;
  padding: 10px 14px;
  font-size: 13px;
  font-weight: 800;
  cursor: pointer;
  border-radius: var(--${namespace}-radius-md);
  border: 2px solid transparent;
  color: var(--${namespace}-text-muted);
  display: flex;
  align-items: center;
  justify-content: space-between;
  transition: all 0.2s cubic-bezier(0.34, 1.56, 0.64, 1);
}
.${namespace}-nav-item:hover { 
  background: var(--${namespace}-primary-bg); 
  color: var(--${namespace}-primary-dark);
  transform: translateX(3px);
}
.${namespace}-nav-item.${namespace}-active {
  background: linear-gradient(135deg, var(--${namespace}-primary) 0%, var(--${namespace}-primary-dark) 100%);
  color: #fff;
  border-color: var(--${namespace}-primary-deep);
  box-shadow: 0 4px 10px rgba(5, 150, 105, 0.2);
  transform: scale(1.02);
}
.${namespace}-nav-item.${namespace}-active .${namespace}-tag {
  background: #ffffff;
  color: var(--${namespace}-primary-dark);
  border-color: transparent;
}

/* Content Area */
.${namespace}-content {
  flex: 1;
  overflow: hidden;
  display: flex;
  flex-direction: column;
}

.${namespace}-page {
  flex: 1;
  overflow-y: auto;
  padding: var(--${namespace}-sp-md);
  display: flex;
  flex-direction: column;
  gap: 14px;
}
.${namespace}-page.${namespace}-hidden { display: none; }

/* ══════════════════════════════════════════════
   4. Topbar (薄荷奶绿萌系顶栏)
   ══════════════════════════════════════════════ */
.${namespace}-topbar {
  background: rgba(255, 255, 255, 0.95);
  backdrop-filter: blur(8px);
  display: flex;
  align-items: center;
  padding: 0 24px;
  height: 64px;
  flex-shrink: 0;
  border-bottom: 3px solid var(--${namespace}-border);
  position: relative;
}

.${namespace}-logo {
  font-size: 18px;
  font-weight: 900;
  color: var(--${namespace}-text);
  display: flex;
  align-items: center;
  gap: 10px;
  margin-right: 24px;
  white-space: nowrap;
  flex-shrink: 0;
}
.${namespace}-logo-badge {
  width: 38px;
  height: 38px;
  border-radius: var(--${namespace}-radius-md);
  background: linear-gradient(135deg, #34D399 0%, var(--${namespace}-primary) 100%);
  color: #fff;
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 20px;
  box-shadow: 0 4px 10px rgba(16, 185, 129, 0.3);
  transform: rotate(-3deg);
}
.${namespace}-logo em {
  font-style: normal;
  font-size: 11px;
  background: var(--${namespace}-primary-bg);
  border: 1.5px solid var(--${namespace}-primary-border);
  color: var(--${namespace}-primary-dark);
  padding: 2px 8px;
  border-radius: var(--${namespace}-radius-pill);
  margin-left: 6px;
}

/* Top Navigation Pills */
.${namespace}-tnav {
  padding: 8px 16px;
  border-radius: var(--${namespace}-radius-pill);
  font-size: 13px;
  font-weight: 800;
  cursor: pointer;
  color: var(--${namespace}-text-muted);
  transition: all 0.2s ease;
  white-space: nowrap;
}
.${namespace}-tnav:hover { 
  background: var(--${namespace}-primary-bg); 
  color: var(--${namespace}-primary);
}
.${namespace}-tnav.${namespace}-active {
  background: var(--${namespace}-primary-bg);
  color: var(--${namespace}-primary-dark);
  border: 1.5px solid var(--${namespace}-primary-border);
}

.${namespace}-topbar-right {
  margin-left: auto;
  display: flex;
  align-items: center;
  gap: 12px;
}

/* 萌宠陪伴胶囊 (小柴桌宠互动) */
.${namespace}-pet-capsule {
  display: flex;
  align-items: center;
  gap: 8px;
  background: var(--${namespace}-gold-bg);
  border: 2px solid var(--${namespace}-gold-border);
  padding: 4px 12px;
  border-radius: var(--${namespace}-radius-pill);
  cursor: pointer;
  transition: transform 0.2s cubic-bezier(0.34, 1.56, 0.64, 1);
}
.${namespace}-pet-capsule:hover {
  transform: scale(1.05);
}
.${namespace}-pet-avatar {
  font-size: 20px;
  animation: tadaPetWiggle 3.5s ease-in-out infinite;
  transform-origin: bottom center;
}
@keyframes tadaPetWiggle {
  0%, 100% { transform: rotate(0deg); }
  25% { transform: rotate(-8deg) scale(1.08); }
  75% { transform: rotate(8deg) scale(1.08); }
}

/* ══════════════════════════════════════════════
   5. Sub Nav (糖果次级功能带)
   ══════════════════════════════════════════════ */
.${namespace}-sub-nav {
  background: #FFFFFF;
  display: flex;
  align-items: center;
  padding: 0 16px;
  border-bottom: 2px solid var(--${namespace}-border-light);
  gap: 6px;
}
.${namespace}-sub-nav-item {
  padding: 10px 18px;
  font-size: 13px;
  font-weight: 800;
  color: var(--${namespace}-text-muted);
  cursor: pointer;
  border-bottom: 3px solid transparent;
  transition: all 0.2s;
}
.${namespace}-sub-nav-item:hover,
.${namespace}-sub-nav-item.${namespace}-active {
  color: var(--${namespace}-primary-dark);
  border-bottom-color: var(--${namespace}-primary);
}

/* ══════════════════════════════════════════════
   6. Breadcrumb & Record Navigation
   ══════════════════════════════════════════════ */
.${namespace}-breadcrumb {
  background: transparent;
  padding: 4px 10px;
  display: flex;
  align-items: center;
  gap: 8px;
  font-size: 12px;
  font-weight: 700;
  color: var(--${namespace}-text-light);
}
.${namespace}-breadcrumb a { 
  color: var(--${namespace}-text-muted); 
  text-decoration: none; 
}
.${namespace}-breadcrumb a:hover { 
  color: var(--${namespace}-primary); 
}

/* 胶囊翻页按钮组 */
.${namespace}-record-nav {
  margin-left: auto;
  display: flex;
  align-items: center;
  gap: 4px;
}
.${namespace}-rn-btn {
  display: inline-flex;
  align-items: center;
  justify-content: center;
  height: 30px;
  padding: 0 12px;
  border-radius: var(--${namespace}-radius-sm);
  border: 2px solid var(--${namespace}-border);
  background: #FFFFFF;
  color: var(--${namespace}-text-muted);
  font-size: 12px;
  font-weight: 800;
  cursor: pointer;
  box-shadow: 0 2px 0 var(--${namespace}-border);
  transition: all 0.1s ease;
}
.${namespace}-rn-btn:hover:not(:disabled) {
  border-color: var(--${namespace}-primary);
  color: var(--${namespace}-primary-dark);
}
.${namespace}-rn-btn:active:not(:disabled) {
  transform: translateY(2px);
  box-shadow: none;
}
.${namespace}-rn-btn:disabled {
  opacity: 0.4;
  cursor: not-allowed;
  box-shadow: none;
}
.${namespace}-rn-idx {
  font-family: var(--${namespace}-font);
  font-weight: 900;
  color: var(--${namespace}-primary-dark);
  background: var(--${namespace}-primary-bg);
  border: 1.5px solid var(--${namespace}-primary-border);
  border-radius: var(--${namespace}-radius-sm);
  padding: 4px 10px;
  font-size: 12px;
}

/* ══════════════════════════════════════════════
   7. Object Header (目标状态卡片与插画头)
   ══════════════════════════════════════════════ */
.${namespace}-obj-head {
  background: #FFFFFF;
  border: 3px solid var(--${namespace}-border);
  border-radius: var(--${namespace}-radius-lg);
  padding: 16px 20px;
  display: flex;
  align-items: center;
  gap: 16px;
  box-shadow: var(--${namespace}-shadow-sm);
  position: relative;
  overflow: hidden;
}
.${namespace}-obj-icon {
  width: 52px;
  height: 52px;
  border-radius: var(--${namespace}-radius-md);
  background: var(--${namespace}-primary-bg);
  color: var(--${namespace}-primary);
  border: 2px solid var(--${namespace}-primary-border);
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 26px;
  flex-shrink: 0;
}
.${namespace}-obj-title {
  font-size: 18px;
  font-weight: 900;
  color: var(--${namespace}-text);
}
.${namespace}-obj-meta {
  font-size: 12px;
  font-weight: 700;
  color: var(--${namespace}-text-light);
  margin-top: 4px;
  display: flex;
  gap: 12px;
}

/* ══════════════════════════════════════════════
   8. Tabs (果冻高光标签栏)
   ══════════════════════════════════════════════ */
.${namespace}-tabs {
  display: flex;
  background: #E4F0EA;
  padding: 4px;
  border-radius: var(--${namespace}-radius-pill);
  gap: 4px;
  width: fit-content;
}
.${namespace}-tab {
  padding: 6px 18px;
  font-size: 12px;
  font-weight: 900;
  cursor: pointer;
  color: var(--${namespace}-text-muted);
  border-radius: var(--${namespace}-radius-pill);
  transition: all 0.2s cubic-bezier(0.34, 1.56, 0.64, 1);
}
.${namespace}-tab:hover {
  color: var(--${namespace}-primary-dark);
}
.${namespace}-tab.${namespace}-active {
  background: #FFFFFF;
  color: var(--${namespace}-primary-dark);
  box-shadow: 0 2px 6px rgba(0, 0, 0, 0.06);
}

/* ══════════════════════════════════════════════
   9. Panel (软萌奶油微凸面板)
   ══════════════════════════════════════════════ */
.${namespace}-panel {
  background: var(--${namespace}-bg);
  border: 3px solid var(--${namespace}-border);
  border-radius: var(--${namespace}-radius-lg);
  box-shadow: var(--${namespace}-shadow-sm);
  overflow: hidden;
}
.${namespace}-panel-head {
  padding: 14px 18px;
  font-size: 14px;
  font-weight: 900;
  color: var(--${namespace}-text);
  border-bottom: 2px solid var(--${namespace}-border-light);
  display: flex;
  align-items: center;
  gap: 8px;
}
.${namespace}-panel-head::before {
  content: '';
  width: 6px;
  height: 16px;
  background: var(--${namespace}-primary);
  border-radius: var(--${namespace}-radius-pill);
}

/* ══════════════════════════════════════════════
   10. Field View (微凸数据展示网格)
   ══════════════════════════════════════════════ */
.${namespace}-fview {
  display: grid;
  grid-template-columns: repeat(4, 1fr);
  gap: 1px;
  background: var(--${namespace}-border-light);
  border-top: 1px solid var(--${namespace}-border-light);
}

.${namespace}-fview--1 {
  grid-template-columns: repeat(1, 1fr);
}

.${namespace}-fview--2 {
  grid-template-columns: repeat(2, 1fr);
}

.${namespace}-fview--3 {
  grid-template-columns: repeat(3, 1fr);
}

.${namespace}-fview--4 {
  grid-template-columns: repeat(4, 1fr);
}

.${namespace}-fv {
  display: flex;
  background: var(--${namespace}-bg);
  min-height: 40px;
}

.${namespace}-fv--span2 { grid-column: span 2; }
.${namespace}-fv--span3 { grid-column: span 3; }
.${namespace}-fv--span4 { grid-column: span 4; }

.${namespace}-fv-label {
  width: 100px;
  background: #F9FCFA;
  color: var(--${namespace}-text-muted);
  font-size: 12px;
  font-weight: 800;
  padding: 10px 12px;
  display: flex;
  align-items: center;
}
.${namespace}-fv-val {
  flex: 1;
  padding: 10px 14px;
  font-size: 13px;
  font-weight: 800;
  color: var(--${namespace}-text);
  display: flex;
  align-items: center;
}

/* ══════════════════════════════════════════════
   11. Form Grid (微启动表单网格)
   ══════════════════════════════════════════════ */
.${namespace}-form {
  display: grid;
  grid-template-columns: repeat(4, 1fr);
  gap: 12px 16px;
  padding: 18px 20px;
}

.${namespace}-form--2 { grid-template-columns: repeat(2, 1fr); }
.${namespace}-form--3 { grid-template-columns: repeat(3, 1fr); }

.${namespace}-field {
  display: flex;
  flex-direction: column;
  gap: 6px;
}
.${namespace}-field--span2 { grid-column: span 2; }
.${namespace}-field--span3 { grid-column: span 3; }
.${namespace}-field--span4 { grid-column: span 4; }

.${namespace}-field-label {
  font-size: 12px;
  font-weight: 900;
  color: var(--${namespace}-text);
}
.${namespace}-field-label--required::after {
  content: " *";
  color: var(--${namespace}-danger);
}

.${namespace}-input,
.${namespace}-select,
.${namespace}-textarea {
  height: 38px;
  border: 2px solid var(--${namespace}-border);
  background: #F8FCFA;
  border-radius: var(--${namespace}-radius-md);
  padding: 0 14px;
  font-family: var(--${namespace}-font);
  font-size: 13px;
  font-weight: 800;
  color: var(--${namespace}-text);
  outline: none;
  transition: all 0.2s ease;
}
.${namespace}-input:focus,
.${namespace}-select:focus,
.${namespace}-textarea:focus {
  background: #FFFFFF;
  border-color: var(--${namespace}-primary);
  box-shadow: 0 0 0 4px rgba(16, 185, 129, 0.15);
}

/* 5分钟微启动滑块 */
.${namespace}-slider {
  width: 100%;
  accent-color: var(--${namespace}-primary);
  cursor: pointer;
}

/* ══════════════════════════════════════════════
   12. Buttons (3D 果冻物理按键)
   ══════════════════════════════════════════════ */
   
.${namespace}-btns {
  width: 100%; 
  display: flex; 
  justify-content: 
  flex-end; gap: 8px;
}

.${namespace}-btn {
  height: 36px;
  padding: 0 16px;
  font-size: 13px;
  font-weight: 900;
  font-family: var(--${namespace}-font);
  border: 2px solid transparent;
  cursor: pointer;
  display: inline-flex;
  align-items: center;
  justify-content: center;
  gap: 6px;
  border-radius: var(--${namespace}-radius-md);
  transition: all 0.1s ease;
  user-select: none;
}

/* 果冻主按键 (薄荷绿) */
.${namespace}-btn--primary {
  background: linear-gradient(180deg, #34D399 0%, var(--${namespace}-primary-dark) 100%);
  color: #FFFFFF;
  border-color: var(--${namespace}-primary-deep);
  box-shadow: 0 4px 0 var(--${namespace}-primary-deep), 0 8px 14px rgba(5, 150, 105, 0.25);
}
.${namespace}-btn--primary:active {
  transform: translateY(3px);
  box-shadow: 0 1px 0 var(--${namespace}-primary-deep);
}

/* 果冻元气绿 (Success) */
.${namespace}-btn--success {
  background: linear-gradient(180deg, #34D399 0%, var(--${namespace}-success-dark) 100%);
  color: #FFFFFF;
  border-color: #065F46;
  box-shadow: 0 4px 0 #065F46, 0 8px 14px rgba(16, 185, 129, 0.25);
}
.${namespace}-btn--success:active {
  transform: translateY(3px);
  box-shadow: 0 1px 0 #065F46;
}

/* 果冻暖橙日落 (Warning) */
.${namespace}-btn--warning {
  background: linear-gradient(180deg, #FB923C 0%, var(--${namespace}-warning) 100%);
  color: #FFFFFF;
  border-color: #C2410C;
  box-shadow: 0 4px 0 #C2410C, 0 8px 14px rgba(249, 115, 22, 0.28);
}
.${namespace}-btn--warning:active {
  transform: translateY(3px);
  box-shadow: 0 1px 0 #C2410C;
}

/* 果冻蜜桃柔红 (Danger) */
.${namespace}-btn--danger {
  background: linear-gradient(180deg, #FB7185 0%, var(--${namespace}-danger-dark) 100%);
  color: #FFFFFF;
  border-color: #9F1239;
  box-shadow: 0 4px 0 #9F1239, 0 8px 14px rgba(244, 63, 94, 0.28);
}
.${namespace}-btn--danger:active {
  transform: translateY(3px);
  box-shadow: 0 1px 0 #9F1239;
}

/* 果冻灵感紫 (Purple) */
.${namespace}-btn--purple {
  background: linear-gradient(180deg, #A78BFA 0%, var(--${namespace}-purple) 100%);
  color: #FFFFFF;
  border-color: #5B21B6;
  box-shadow: 0 4px 0 #5B21B6, 0 8px 14px rgba(139, 92, 246, 0.28);
}
.${namespace}-btn--purple:active {
  transform: translateY(3px);
  box-shadow: 0 1px 0 #5B21B6;
}

/* 贴纸白按键 */
.${namespace}-btn--default {
  background: #FFFFFF;
  color: var(--${namespace}-text);
  border-color: var(--${namespace}-border);
  box-shadow: 0 3px 0 #D1E3D9;
}
.${namespace}-btn--default:hover {
  border-color: var(--${namespace}-primary);
  color: var(--${namespace}-primary-dark);
}
.${namespace}-btn--default:active {
  transform: translateY(2px);
  box-shadow: none;
}

.${namespace}-btn--sm {
  height: 28px;
  padding: 0 10px;
  font-size: 11px;
  border-radius: var(--${namespace}-radius-sm);
}

/* ══════════════════════════════════════════════
   13. Badge / Tag (贴纸马卡龙胶囊标签)
   ══════════════════════════════════════════════ */
.${namespace}-tag {
  display: inline-flex;
  align-items: center;
  padding: 2px 8px;
  font-size: 11px;
  font-weight: 900;
  border-radius: var(--${namespace}-radius-pill);
  border: 1.5px solid;
  line-height: 1.4;
}
.${namespace}-tag--primary { background: var(--${namespace}-primary-bg); color: var(--${namespace}-primary-dark); border-color: var(--${namespace}-primary-border); }
.${namespace}-tag--warning { background: var(--${namespace}-gold-bg); color: var(--${namespace}-gold-dark); border-color: var(--${namespace}-gold-border); }
.${namespace}-tag--danger  { background: var(--${namespace}-danger-bg); color: var(--${namespace}-danger-dark); border-color: var(--${namespace}-danger-border); }
.${namespace}-tag--neutral { background: #F1F5F3; color: var(--${namespace}-text-muted); border-color: var(--${namespace}-border); }

/* ══════════════════════════════════════════════
   14. Table (数据台账与微进度条)
   ══════════════════════════════════════════════ */
.${namespace}-table-wrap {
  background: var(--${namespace}-bg);
  border: 3px solid var(--${namespace}-border);
  border-radius: var(--${namespace}-radius-lg);
  box-shadow: var(--${namespace}-shadow-sm);
  overflow: hidden;
}
.${namespace}-table {
  width: 100%;
  border-collapse: collapse;
  font-size: 13px;
  table-layout: fixed;
}
.${namespace}-table thead th {
  padding: 12px 14px;
  font-weight: 900;
  color: var(--${namespace}-text-light);
  border-bottom: 2px solid var(--${namespace}-border);
  background-color: #F8FCFA;
  text-align: left;
}
.${namespace}-table tbody td {
  padding: 12px 14px;
  border-bottom: 2px solid var(--${namespace}-border-light);
  color: var(--${namespace}-text);
  font-weight: 700;
  transition: background 0.15s ease;
}
.${namespace}-table tbody tr:hover {
  background-color: #F3FAF6;
}

/* 行内细致进度条 */
.${namespace}-progress-bar {
  background: #E8F5EF;
  border: 1.5px solid #D6EBE0;
  height: 8px;
  border-radius: var(--${namespace}-radius-pill);
  overflow: hidden;
}
.${namespace}-progress-fill {
  height: 100%;
  background: linear-gradient(90deg, #6EE7B7 0%, var(--${namespace}-primary) 100%);
  border-radius: var(--${namespace}-radius-pill);
}

/* ══════════════════════════════════════════════
   15. Alert / Notice (伴随提示与复盘卡)
   ══════════════════════════════════════════════ */
.${namespace}-alert {
  padding: 12px 18px;
  border-radius: var(--${namespace}-radius-md);
  border: 2px solid var(--${namespace}-primary-border);
  background: var(--${namespace}-primary-bg);
  color: var(--${namespace}-primary-dark);
  font-weight: 800;
  display: flex;
  align-items: center;
  gap: 10px;
}
.${namespace}-alert--warning {
  border-color: var(--${namespace}-gold-border);
  background: var(--${namespace}-gold-bg);
  color: var(--${namespace}-gold-dark);
}

/* ══════════════════════════════════════════════
   16. Status Bar (萌宠饱腹度与系统状态栏)
   ══════════════════════════════════════════════ */
.${namespace}-statusbar {
  background: #FFFFFF;
  border-top: 2px solid var(--${namespace}-border);
  padding: 6px 18px;
  font-size: 11px;
  font-weight: 800;
  color: var(--${namespace}-text-muted);
  display: flex;
  align-items: center;
  justify-content: space-between;
}

/* ══════════════════════════════════════════════
   17. Timeline (小步慢跑足迹时间轴)
   ══════════════════════════════════════════════ */
.${namespace}-timeline {
  padding: 16px;
}
.${namespace}-tl-item {
  display: flex;
  gap: 14px;
  position: relative;
  padding-bottom: 18px;
}
.${namespace}-tl-item::before {
  content: '';
  position: absolute;
  left: 9px;
  top: 22px;
  bottom: 0;
  width: 2px;
  background: var(--${namespace}-primary-border);
}
.${namespace}-tl-item:last-child::before { display: none; }
.${namespace}-tl-dot {
  width: 20px;
  height: 20px;
  border-radius: var(--${namespace}-radius-pill);
  background: #FFFFFF;
  border: 3px solid var(--${namespace}-primary);
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 10px;
  z-index: 1;
}

/* ══════════════════════════════════════════════
   18. Map / Canvas Placeholder (原野插画占位)
   ══════════════════════════════════════════════ */
.${namespace}-map-placeholder {
  height: 180px;
  background: #E8F5EF;
  border: 3px dashed var(--${namespace}-primary-border);
  border-radius: var(--${namespace}-radius-lg);
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  color: var(--${namespace}-primary-dark);
  font-weight: 800;
  gap: 8px;
}

/* ══════════════════════════════════════════════
   19. Tooltip Mark
   ══════════════════════════════════════════════ */
.${namespace}-tooltip-mark {
  display: inline-flex;
  align-items: center;
  justify-content: center;
  width: 18px;
  height: 18px;
  border-radius: var(--${namespace}-radius-pill);
  background: var(--${namespace}-primary-bg);
  border: 1px solid var(--${namespace}-primary-border);
  color: var(--${namespace}-primary-dark);
  font-size: 11px;
  font-weight: 900;
  cursor: help;
}

/* ══════════════════════════════════════════════
   20. OfficialForm — 目标立项与战略履约单
   Namespace: ${namespace}-of
   ══════════════════════════════════════════════ */
.${namespace}-of__container {
  width: 820px;
  margin: 0 auto;
  background-color: var(--${namespace}-bg);
  border: 3px solid var(--${namespace}-border);
  border-radius: var(--${namespace}-radius-lg);
  padding: 36px 44px;
  box-shadow: var(--${namespace}-shadow-md);
}

.${namespace}-of__header {
  text-align: center;
  margin-bottom: 24px;
}
.${namespace}-of__header h1 {
  font-size: 24px;
  font-weight: 900;
  color: var(--${namespace}-text);
  letter-spacing: 1px;
}

.${namespace}-of__table {
  width: 100%;
  border-collapse: collapse;
  border: 2px solid var(--${namespace}-border);
  border-radius: var(--${namespace}-radius-md);
  overflow: hidden;
}
.${namespace}-of__table td {
  border: 1px solid var(--${namespace}-border-light);
  height: 38px;
  padding: 6px 12px;
  vertical-align: middle;
}
.${namespace}-of__label {
  background-color: var(--${namespace}-primary-bg);
  font-weight: 900;
  text-align: center;
  width: 15%;
  color: var(--${namespace}-primary-dark);
}

.${namespace}-divider {
  height: 12px;
}

/* ══════════════════════════════════════════════
   21. Grid System (响应式 24 栅格系统)
   ══════════════════════════════════════════════ */
.${namespace}-row {
  display: flex;
  flex-wrap: wrap;
  margin-left: -8px;
  margin-right: -8px;
}
.${namespace}-row > [class*="${namespace}-col-"] {
  padding-left: 8px;
  padding-right: 8px;
}

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

/* 响应式断点 md (≥ 768px) */
@media (min-width: 768px) {
  .${namespace}-col-md-6  { flex: 0 0 25%;  max-width: 25%; }
  .${namespace}-col-md-12 { flex: 0 0 50%;  max-width: 50%; }
  .${namespace}-col-md-24 { flex: 0 0 100%; max-width: 100%; }
}