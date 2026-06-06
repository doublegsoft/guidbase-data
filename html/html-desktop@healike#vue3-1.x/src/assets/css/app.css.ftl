/* ============================================================
   Cura Design System  v1.0
   ──────────────────────────────────────────────
   A clinical-grade CSS design system crafted for healthcare
   interfaces. Calm, precise, and deeply humane.

   "Cura" — Latin for care, cure, healing.
   Every token, every spacing unit, every shadow is chosen
   to bring clarity to complexity and warmth to data-dense
   medical workflows.

   Derived from hospital information system design patterns.
   ============================================================

   TABLE OF CONTENTS
   ─────────────────
   1.  Design Tokens
       1.1  Colors
       1.2  Typography
       1.3  Spacing
       1.4  Border Radius
       1.5  Shadows
       1.6  Z-Index Scale
   2.  Reset & Base
   3.  Layout Primitives
   4.  Typography Utilities
   5.  Component: Buttons
   6.  Component: Badges & Tags
   7.  Component: Status Indicators
   8.  Component: Forms
   9.  Component: Data Table
   10. Component: Cards
   11. Component: Panel & Header
   12. Component: Tabs
   13. Component: Navigation Bar
   14. Component: Toolbar
   15. Component: Modal
   16. Component: Timeline
   17. Component: Vital Signs (Mini Metrics)
   18. Component: Patient List Item
   19. Component: Drug Suggestion
   20. Utility Classes
   ============================================================ */

/* =============================================================
   1. DESIGN TOKENS
   ============================================================= */

:root {
  /* ── 1.1 Colors ────────────────────────────────────────── */

  /* Primary — Teal. The voice of care and trust. */
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

  /* Secondary — Navy. The anchor of authority. */
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

  /* Accent — Crimson. The urgency signal. */
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

  /* Accent — Amber. The caution note. */
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

  /* Accent — Sage. The reassurance of recovery. */
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

  /* Accent — Azure. The data whisper. */
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

  /* Accent — Violet. The quiet specialist. */
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

  /* Neutral — Surface & Structure */
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

  /* Semantic Aliases */
  --${namespace}-color-primary:       var(--${namespace}-teal-800);
  --${namespace}-color-primary-hover: var(--${namespace}-teal-700);
  --${namespace}-color-primary-light: var(--${namespace}-teal-50);
  --${namespace}-color-primary-mid:   var(--${namespace}-teal-200);
  --${namespace}-color-secondary:     var(--${namespace}-navy-800);
  --${namespace}-color-danger:        var(--${namespace}-red-700);
  --${namespace}-color-danger-light:  var(--${namespace}-red-50);
  --${namespace}-color-warning:       var(--${namespace}-amber-700);
  --${namespace}-color-warning-light: var(--${namespace}-amber-100);
  --${namespace}-color-success:       var(--${namespace}-green-800);
  --${namespace}-color-success-light: var(--${namespace}-green-100);
  --${namespace}-color-info:          var(--${namespace}-blue-800);
  --${namespace}-color-info-light:    var(--${namespace}-blue-100);

  --${namespace}-bg-page:           var(--${namespace}-gray-100);
  --${namespace}-bg-surface:        var(--${namespace}-gray-50);
  --${namespace}-bg-elevated:       var(--${namespace}-white);
  --${namespace}-bg-selection:      #d0f0e8;
  --${namespace}-bg-row-alt:        var(--${namespace}-gray-75);

  --${namespace}-border-default:    var(--${namespace}-gray-300);
  --${namespace}-border-light:      var(--${namespace}-gray-200);
  --${namespace}-border-hairline:   1px solid rgba(255, 255, 255, 0.07);

  --${namespace}-text-primary:      var(--${namespace}-gray-800);
  --${namespace}-text-secondary:    var(--${namespace}-gray-700);
  --${namespace}-text-tertiary:     var(--${namespace}-gray-600);
  --${namespace}-text-inverse:      var(--${namespace}-white);
  --${namespace}-text-disabled:     var(--${namespace}-gray-400);

  --${namespace}-shadow-sm:  0 1px 4px rgba(0, 80, 60, 0.06);
  --${namespace}-shadow-md:  0 2px 8px rgba(0, 80, 60, 0.08);
  --${namespace}-shadow-lg:  0 4px 20px rgba(0, 80, 60, 0.12);
  --${namespace}-shadow-xl:  0 8px 40px rgba(0, 0, 0, 0.24);
  --${namespace}-shadow-modal: 0 8px 40px rgba(0, 0, 0, 0.30);

  /* ── 1.2 Typography ───────────────────────────────────── */

  --${namespace}-font-family:      'Noto Sans SC', -apple-system, BlinkMacSystemFont, 'Segoe UI', sans-serif;
  --${namespace}-font-mono:        'SF Mono', 'Cascadia Code', 'Fira Code', monospace;

  --${namespace}-font-size-2xs:    9px;
  --${namespace}-font-size-xs:     10px;
  --${namespace}-font-size-sm:     11px;
  --${namespace}-font-size-md:     12px;
  --${namespace}-font-size-lg:     13px;
  --${namespace}-font-size-xl:     14px;
  --${namespace}-font-size-2xl:    16px;
  --${namespace}-font-size-3xl:    18px;
  --${namespace}-font-size-4xl:    20px;

  --${namespace}-font-weight-light:  300;
  --${namespace}-font-weight-normal: 400;
  --${namespace}-font-weight-medium: 500;
  --${namespace}-font-weight-semibold: 600;
  --${namespace}-font-weight-bold:   700;

  --${namespace}-line-height-tight:  1.2;
  --${namespace}-line-height-normal: 1.5;
  --${namespace}-line-height-relaxed: 1.6;

  --${namespace}-letter-spacing-tight: -0.3px;
  --${namespace}-letter-spacing-normal: 0;
  --${namespace}-letter-spacing-wide: 0.5px;
  --${namespace}-letter-spacing-wider: 1px;
  --${namespace}-letter-spacing-widest: 2px;

  /* ── 1.3 Spacing Scale (4px base) ─────────────────────── */

  --${namespace}-space-0:    0;
  --${namespace}-space-px:   1px;
  --${namespace}-space-0_5:  2px;
  --${namespace}-space-1:    3px;
  --${namespace}-space-1_5:  4px;
  --${namespace}-space-2:    5px;
  --${namespace}-space-2_5:  6px;
  --${namespace}-space-3:    7px;
  --${namespace}-space-3_5:  8px;
  --${namespace}-space-4:    10px;
  --${namespace}-space-5:    12px;
  --${namespace}-space-6:    14px;
  --${namespace}-space-7:    16px;
  --${namespace}-space-8:    20px;
  --${namespace}-space-10:   24px;
  --${namespace}-space-12:   32px;
  --${namespace}-space-16:   40px;

  /* ── 1.4 Border Radius ────────────────────────────────── */

  --${namespace}-radius-none:  0;
  --${namespace}-radius-sm:    2px;
  --${namespace}-radius-md:    3px;
  --${namespace}-radius-lg:    4px;
  --${namespace}-radius-xl:    6px;
  --${namespace}-radius-2xl:   8px;
  --${namespace}-radius-3xl:   10px;
  --${namespace}-radius-full:  9999px;

  /* ── 1.5 Shadows ──────────────────────────────────────── */

  /* (defined with semantic aliases above) */

  /* ── 1.6 Z-Index Scale ────────────────────────────────── */

  --${namespace}-z-base:     0;
  --${namespace}-z-dropdown: 100;
  --${namespace}-z-sticky:   200;
  --${namespace}-z-overlay:  500;
  --${namespace}-z-modal:    600;
  --${namespace}-z-toast:    700;

  /* ── 1.7 Transitions ──────────────────────────────────── */

  --${namespace}-transition-fast:   120ms ease;
  --${namespace}-transition-normal: 200ms ease;
  --${namespace}-transition-slow:   300ms ease;
}


/* =============================================================
   2. RESET & BASE
   ============================================================= */

*,
*::before,
*::after {
  box-sizing: border-box;
  margin: 0;
  padding: 0;
}

html, body {
  height: 100%;
  overflow: hidden;
  font-family: var(--${namespace}-font-family);
  font-size: var(--${namespace}-font-size-md);
  line-height: var(--${namespace}-line-height-normal);
  color: var(--${namespace}-text-primary);
  background: var(--${namespace}-bg-page);
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}

a {
  color: var(--${namespace}-color-primary);
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
  background: var(--${namespace}-color-primary-mid);
  border-radius: var(--${namespace}-radius-sm);
}


/* =============================================================
   3. LAYOUT PRIMITIVES
   ============================================================= */

/* Full-height app shell */
.${namespace}-app {
  display: flex;
  flex-direction: column;
  height: 100vh;
}

/* Horizontal split: sidebar + content + detail */
.${namespace}-layout-3col {
  display: flex;
  flex: 1;
  overflow: hidden;
}

.${namespace}-col-left {
  width: 210px;
  flex-shrink: 0;
  display: flex;
  flex-direction: column;
  border-right: 1px solid var(--${namespace}-border-default);
  background: var(--${namespace}-bg-surface);
}

.${namespace}-col-main {
  flex: 1;
  display: flex;
  flex-direction: column;
  overflow: hidden;
  min-width: 0;
}

.${namespace}-col-right {
  width: 240px;
  flex-shrink: 0;
  display: flex;
  flex-direction: column;
  border-left: 1px solid var(--${namespace}-border-default);
  background: var(--${namespace}-bg-surface);
}

/* Vertical stack */
.${namespace}-stack { display: flex; flex-direction: column; }
.${namespace}-stack--flex { flex: 1; overflow: hidden; }

/* Inline row */
.${namespace}-row {
  display: flex;
  align-items: center;
  gap: var(--${namespace}-space-3_5);
}
.${namespace}-row--start { align-items: flex-start; }
.${namespace}-row--end   { align-items: flex-end; }
.${namespace}-row--wrap  { flex-wrap: wrap; }

/* Spacer — pushes siblings apart */
.${namespace}-spacer { margin-left: auto; }


/* =============================================================
   4. TYPOGRAPHY UTILITIES
   ============================================================= */

.${namespace}-text-2xs  { font-size: var(--${namespace}-font-size-2xs); }
.${namespace}-text-xs   { font-size: var(--${namespace}-font-size-xs); }
.${namespace}-text-sm   { font-size: var(--${namespace}-font-size-sm); }
.${namespace}-text-md   { font-size: var(--${namespace}-font-size-md); }
.${namespace}-text-lg   { font-size: var(--${namespace}-font-size-lg); }
.${namespace}-text-xl   { font-size: var(--${namespace}-font-size-xl); }
.${namespace}-text-2xl  { font-size: var(--${namespace}-font-size-2xl); }

.${namespace}-text-primary   { color: var(--${namespace}-text-primary); }
.${namespace}-text-secondary { color: var(--${namespace}-text-secondary); }
.${namespace}-text-tertiary  { color: var(--${namespace}-text-tertiary); }
.${namespace}-text-inverse   { color: var(--${namespace}-text-inverse); }

.${namespace}-font-light    { font-weight: var(--${namespace}-font-weight-light); }
.${namespace}-font-normal   { font-weight: var(--${namespace}-font-weight-normal); }
.${namespace}-font-medium   { font-weight: var(--${namespace}-font-weight-medium); }
.${namespace}-font-semibold { font-weight: var(--${namespace}-font-weight-semibold); }
.${namespace}-font-bold     { font-weight: var(--${namespace}-font-weight-bold); }

.${namespace}-leading-tight   { line-height: var(--${namespace}-line-height-tight); }
.${namespace}-leading-normal  { line-height: var(--${namespace}-line-height-normal); }
.${namespace}-leading-relaxed { line-height: var(--${namespace}-line-height-relaxed); }

.${namespace}-tracking-wide  { letter-spacing: var(--${namespace}-letter-spacing-wide); }
.${namespace}-tracking-wider { letter-spacing: var(--${namespace}-letter-spacing-wider); }

.${namespace}-text-ellipsis {
  overflow: hidden;
  text-overflow: ellipsis;
  white-space: nowrap;
}

.${namespace}-text-mono {
  font-family: var(--${namespace}-font-mono);
  font-variant-numeric: tabular-nums;
}


/* =============================================================
   5. COMPONENT: BUTTONS
   ============================================================= */

.${namespace}-btn {
  display: inline-flex;
  align-items: center;
  gap: var(--${namespace}-space-1);
  padding: var(--${namespace}-space-1) var(--${namespace}-space-3);
  border: 1px solid transparent;
  border-radius: var(--${namespace}-radius-sm);
  font-size: var(--${namespace}-font-size-sm);
  font-family: var(--${namespace}-font-family);
  color: var(--${namespace}-text-secondary);
  background: transparent;
  white-space: nowrap;
  cursor: pointer;
  transition: background var(--${namespace}-transition-fast),
              border-color var(--${namespace}-transition-fast),
              color var(--${namespace}-transition-fast);
}

.${namespace}-btn:hover {
  background: #deeee8;
  border-color: var(--${namespace}-border-default);
}

/* Primary — Teal fill */
.${namespace}-btn--primary {
  background: var(--${namespace}-teal-800);
  color: var(--${namespace}-white);
  border-color: var(--${namespace}-teal-700);
}
.${namespace}-btn--primary:hover {
  background: var(--${namespace}-teal-700);
}

/* Danger — Red fill */
.${namespace}-btn--danger {
  background: var(--${namespace}-red-700);
  color: var(--${namespace}-white);
  border-color: var(--${namespace}-red-800);
}
.${namespace}-btn--danger:hover {
  background: var(--${namespace}-red-800);
}

/* Success — Green fill */
.${namespace}-btn--success {
  background: var(--${namespace}-green-800);
  color: var(--${namespace}-white);
  border-color: var(--${namespace}-green-700);
}
.${namespace}-btn--success:hover {
  background: var(--${namespace}-green-700);
}

/* Warning — Amber fill */
.${namespace}-btn--warning {
  background: var(--${namespace}-amber-700);
  color: var(--${namespace}-white);
  border-color: var(--${namespace}-amber-800);
}
.${namespace}-btn--warning:hover {
  background: var(--${namespace}-amber-800);
}

/* Ghost — translucent for dark backgrounds */
.${namespace}-btn--ghost {
  padding: var(--${namespace}-space-1) var(--${namespace}-space-4);
  border: 1px solid rgba(255, 255, 255, 0.2);
  background: rgba(255, 255, 255, 0.08);
  color: rgba(255, 255, 255, 0.75);
  border-radius: var(--${namespace}-radius-md);
}
.${namespace}-btn--ghost:hover {
  background: rgba(255, 255, 255, 0.16);
}

/* Disabled state */
.${namespace}-btn--disabled {
  opacity: 0.4;
  cursor: not-allowed;
  pointer-events: none;
}

/* Sizes */
.${namespace}-btn--sm { padding: var(--${namespace}-space-0_5) var(--${namespace}-space-2); font-size: var(--${namespace}-font-size-xs); }
.${namespace}-btn--lg { padding: var(--${namespace}-space-2_5) var(--${namespace}-space-6); font-size: var(--${namespace}-font-size-lg); }


/* =============================================================
   6. COMPONENT: BADGES & TAGS
   ============================================================= */

/* Inline pill badge */
.${namespace}-badge {
  display: inline-flex;
  align-items: center;
  padding: 1px 5px;
  border-radius: var(--${namespace}-radius-2xl);
  font-size: var(--${namespace}-font-size-2xs);
  font-weight: var(--${namespace}-font-weight-semibold);
  line-height: var(--${namespace}-line-height-normal);
}

.${namespace}-badge--critical {
  background: var(--${namespace}-red-100);
  color: var(--${namespace}-color-danger);
  border: 1px solid var(--${namespace}-red-200);
}

.${namespace}-badge--warning {
  background: var(--${namespace}-amber-100);
  color: var(--${namespace}-color-warning);
  border: 1px solid var(--${namespace}-amber-300);
}

.${namespace}-badge--success {
  background: var(--${namespace}-green-100);
  color: var(--${namespace}-color-success);
  border: 1px solid var(--${namespace}-green-300);
}

.${namespace}-badge--info {
  background: var(--${namespace}-blue-100);
  color: var(--${namespace}-color-info);
  border: 1px solid var(--${namespace}-blue-300);
}

.${namespace}-badge--neutral {
  background: var(--${namespace}-gray-150);
  color: var(--${namespace}-text-secondary);
  border: 1px solid var(--${namespace}-gray-200);
}

/* Translucent tag for dark bg */
.${namespace}-tag {
  display: inline-flex;
  align-items: center;
  padding: var(--${namespace}-space-0_5) var(--${namespace}-space-3);
  border-radius: var(--${namespace}-radius-3xl);
  font-size: var(--${namespace}-font-size-xs);
  font-weight: var(--${namespace}-font-weight-semibold);
  background: rgba(255, 255, 255, 0.2);
  color: var(--${namespace}-white);
}

.${namespace}-tag--danger {
  background: rgba(200, 32, 10, 0.5);
}

.${namespace}-tag--warning {
  background: rgba(180, 96, 0, 0.5);
}

/* Allergy tag — loud and clear */
.${namespace}-allergy-tag {
  display: inline-block;
  margin: var(--${namespace}-space-0_5);
  padding: var(--${namespace}-space-0_5) var(--${namespace}-space-3);
  border-radius: var(--${namespace}-radius-3xl);
  font-size: var(--${namespace}-font-size-xs);
  font-weight: var(--${namespace}-font-weight-semibold);
  background: var(--${namespace}-red-100);
  color: var(--${namespace}-color-danger);
  border: 1px solid #f0b0b0;
}

/* Gender badge */
.${namespace}-gender {
  display: inline-flex;
  align-items: center;
  padding: 0 var(--${namespace}-space-1_5);
  border-radius: var(--${namespace}-radius-sm);
  font-size: var(--${namespace}-font-size-xs);
  font-weight: var(--${namespace}-font-weight-semibold);
}
.${namespace}-gender--male {
  background: #ddeeff;
  color: #0050a0;
}
.${namespace}-gender--female {
  background: #ffdded;
  color: #c0205a;
}


/* =============================================================
   7. COMPONENT: STATUS INDICATORS
   ============================================================= */

.${namespace}-status {
  display: inline-flex;
  align-items: center;
  padding: 1px 5px;
  border-radius: var(--${namespace}-radius-sm);
  font-size: var(--${namespace}-font-size-xs);
  font-weight: var(--${namespace}-font-weight-semibold);
}

.${namespace}-status--active {
  background: var(--${namespace}-green-100);
  color: var(--${namespace}-color-success);
  border: 1px solid var(--${namespace}-green-300);
}

.${namespace}-status--pending {
  background: var(--${namespace}-blue-100);
  color: var(--${namespace}-color-info);
  border: 1px solid var(--${namespace}-blue-300);
}

.${namespace}-status--stopped {
  background: #f4f4f4;
  color: #888888;
  border: 1px solid #cccccc;
  text-decoration: line-through;
}

.${namespace}-status--draft {
  background: var(--${namespace}-amber-100);
  color: #a06000;
  border: 1px solid #e0c060;
}

.${namespace}-status--critical {
  background: var(--${namespace}-red-100);
  color: var(--${namespace}-color-danger);
  border: 1px solid var(--${namespace}-red-200);
}


/* =============================================================
   8. COMPONENT: FORMS
   ============================================================= */

.${namespace}-input {
  border: 1px solid var(--${namespace}-border-default);
  border-radius: var(--${namespace}-radius-sm);
  padding: var(--${namespace}-space-1) var(--${namespace}-space-2_5);
  font-size: var(--${namespace}-font-size-sm);
  font-family: var(--${namespace}-font-family);
  color: var(--${namespace}-text-primary);
  background: var(--${namespace}-bg-elevated);
  outline: none;
  transition: border-color var(--${namespace}-transition-fast);
}
.${namespace}-input:focus {
  border-color: var(--${namespace}-teal-800);
}

.${namespace}-select {
  border: 1px solid var(--${namespace}-border-default);
  border-radius: var(--${namespace}-radius-sm);
  padding: var(--${namespace}-space-1) var(--${namespace}-space-1_5);
  font-size: var(--${namespace}-font-size-sm);
  font-family: var(--${namespace}-font-family);
  color: var(--${namespace}-text-primary);
  background: var(--${namespace}-bg-elevated);
  outline: none;
  cursor: pointer;
  transition: border-color var(--${namespace}-transition-fast);
}
.${namespace}-select:focus {
  border-color: var(--${namespace}-teal-800);
}

.${namespace}-search {
  display: flex;
  align-items: center;
  gap: var(--${namespace}-space-2);
  padding: var(--${namespace}-space-2) var(--${namespace}-space-3_5);
  border-bottom: 1px solid var(--${namespace}-border-light);
}

.${namespace}-search__input {
  flex: 1;
  border: 1px solid var(--${namespace}-border-default);
  border-radius: var(--${namespace}-radius-sm);
  padding: var(--${namespace}-space-1) var(--${namespace}-space-2_5);
  font-size: var(--${namespace}-font-size-sm);
  font-family: var(--${namespace}-font-family);
  outline: none;
}
.${namespace}-search__input:focus {
  border-color: var(--${namespace}-teal-800);
}

.${namespace}-search__btn {
  padding: var(--${namespace}-space-1) var(--${namespace}-space-3_5);
  background: var(--${namespace}-teal-800);
  color: var(--${namespace}-white);
  border: none;
  border-radius: var(--${namespace}-radius-sm);
  font-size: var(--${namespace}-font-size-sm);
  cursor: pointer;
}

/* Field group (label + input) */
.${namespace}-field {
  display: flex;
  flex-direction: column;
  gap: var(--${namespace}-space-0_5);
}

.${namespace}-field__label {
  font-size: var(--${namespace}-font-size-xs);
  color: var(--${namespace}-text-tertiary);
}

/* Input sizes */
.${namespace}-input--drug  { width: 160px; }
.${namespace}-input--dose  { width: 70px; }
.${namespace}-input--freq  { width: 80px; }
.${namespace}-input--route { width: 80px; }
.${namespace}-input--days  { width: 50px; }


/* =============================================================
   9. COMPONENT: DATA TABLE
   ============================================================= */

.${namespace}-table {
  width: 100%;
  border-collapse: collapse;
  font-size: var(--${namespace}-font-size-sm);
}

.${namespace}-table th {
  background: linear-gradient(180deg, #1a5038, #0d3a28);
  color: rgba(255, 255, 255, 0.85);
  padding: var(--${namespace}-space-2) var(--${namespace}-space-3);
  border: 1px solid rgba(255, 255, 255, 0.08);
  font-weight: var(--${namespace}-font-weight-medium);
  white-space: nowrap;
  position: sticky;
  top: 0;
  z-index: var(--${namespace}-z-sticky);
}

.${namespace}-table td {
  padding: var(--${namespace}-space-1_5) var(--${namespace}-space-3);
  border: 1px solid var(--${namespace}-border-light);
  color: var(--${namespace}-text-primary);
  background: var(--${namespace}-white);
  vertical-align: top;
}

.${namespace}-table tr:nth-child(even) td {
  background: var(--${namespace}-bg-row-alt);
}

.${namespace}-table tr:hover td {
  background: #e4f4ee !important;
}

.${namespace}-table tr.is-selected td {
  background: var(--${namespace}-bg-selection) !important;
}

.${namespace}-table tr.is-group-header td {
  background: #e0f0ea !important;
  font-weight: var(--${namespace}-font-weight-semibold);
  color: var(--${namespace}-teal-800);
}

.${namespace}-table tr.is-new td {
  background: #fffaee !important;
  border-left: 3px solid var(--${namespace}-amber-700) !important;
}

/* Sequence column */
.${namespace}-table .td-seq {
  width: 28px;
  text-align: center;
  font-size: var(--${namespace}-font-size-xs);
  color: var(--${namespace}-text-tertiary);
  background: #f0f6f3 !important;
}


/* =============================================================
   10. COMPONENT: CARDS
   ============================================================= */

/* Exam / lab card */
.${namespace}-exam-card {
  background: var(--${namespace}-bg-elevated);
  border: 1px solid var(--${namespace}-border-light);
  border-radius: var(--${namespace}-radius-lg);
  overflow: hidden;
  cursor: pointer;
  transition: box-shadow var(--${namespace}-transition-fast);
}
.${namespace}-exam-card:hover {
  box-shadow: var(--${namespace}-shadow-md);
}

.${namespace}-exam-card__header {
  background: var(--${namespace}-teal-800);
  color: var(--${namespace}-white);
  padding: var(--${namespace}-space-1_5) var(--${namespace}-space-3_5);
  font-size: var(--${namespace}-font-size-sm);
  font-weight: var(--${namespace}-font-weight-medium);
  display: flex;
  align-items: center;
  justify-content: space-between;
}

.${namespace}-exam-card__timestamp {
  font-size: var(--${namespace}-font-size-2xs);
  background: rgba(255, 255, 255, 0.25);
  padding: 1px 5px;
  border-radius: var(--${namespace}-radius-2xl);
}

.${namespace}-exam-card__item {
  display: flex;
  align-items: center;
  padding: var(--${namespace}-space-1_5) var(--${namespace}-space-3_5);
  border-bottom: 1px solid var(--${namespace}-border-light);
  font-size: var(--${namespace}-font-size-sm);
  gap: var(--${namespace}-space-2_5);
}
.${namespace}-exam-card__item:last-child {
  border-bottom: none;
}

.${namespace}-exam-card__name {
  flex: 1;
  color: var(--${namespace}-text-secondary);
}

.${namespace}-exam-card__value {
  font-weight: var(--${namespace}-font-weight-semibold);
  font-size: var(--${namespace}-font-size-md);
}
.${namespace}-exam-card__value--normal { color: var(--${namespace}-color-success); }
.${namespace}-exam-card__value--high   { color: var(--${namespace}-color-danger); }
.${namespace}-exam-card__value--low    { color: var(--${namespace}-color-info); }

.${namespace}-exam-card__ref {
  font-size: var(--${namespace}-font-size-xs);
  color: var(--${namespace}-text-tertiary);
}

.${namespace}-exam-card__arrow { font-size: var(--${namespace}-font-size-sm); }
.${namespace}-exam-card__arrow--up  { color: var(--${namespace}-color-danger); }
.${namespace}-exam-card__arrow--down { color: var(--${namespace}-color-info); }


/* =============================================================
   11. COMPONENT: PANEL & HEADER
   ============================================================= */

/* Section panel header (teal bar) */
.${namespace}-panel-header {
  background: var(--${namespace}-teal-800);
  color: var(--${namespace}-white);
  padding: var(--${namespace}-space-2) var(--${namespace}-space-4);
  font-size: var(--${namespace}-font-size-sm);
  font-weight: var(--${namespace}-font-weight-medium);
  letter-spacing: var(--${namespace}-letter-spacing-wider);
  display: flex;
  align-items: center;
  justify-content: space-between;
  flex-shrink: 0;
}

.${namespace}-panel-header__action {
  cursor: pointer;
  font-size: var(--${namespace}-font-size-xl);
  font-weight: var(--${namespace}-font-weight-bold);
  color: rgba(255, 255, 255, 0.8);
}
.${namespace}-panel-header__action:hover {
  color: var(--${namespace}-white);
}

/* Collapsible section (right panel) */
.${namespace}-section {
  border-bottom: 1px solid var(--${namespace}-border-light);
}

.${namespace}-section__header {
  background: var(--${namespace}-gray-150);
  padding: var(--${namespace}-space-2) var(--${namespace}-space-4);
  font-size: var(--${namespace}-font-size-sm);
  font-weight: var(--${namespace}-font-weight-semibold);
  color: var(--${namespace}-teal-800);
  display: flex;
  align-items: center;
  gap: var(--${namespace}-space-1_5);
  cursor: pointer;
}
.${namespace}-section__header::before {
  content: '▸';
  font-size: var(--${namespace}-font-size-xs);
}

.${namespace}-section__body {
  padding: var(--${namespace}-space-2_5) var(--${namespace}-space-4);
  font-size: var(--${namespace}-font-size-sm);
  color: var(--${namespace}-text-secondary);
}


/* =============================================================
   12. COMPONENT: TABS
   ============================================================= */

.${namespace}-tabs {
  display: flex;
  background: var(--${namespace}-navy-800);
  flex-shrink: 0;
}

.${namespace}-tab {
  padding: var(--${namespace}-space-2_5) var(--${namespace}-space-6);
  font-size: var(--${namespace}-font-size-md);
  color: rgba(255, 255, 255, 0.6);
  cursor: pointer;
  border-bottom: 2px solid transparent;
  white-space: nowrap;
  transition: color var(--${namespace}-transition-fast),
              background var(--${namespace}-transition-fast),
              border-color var(--${namespace}-transition-fast);
}
.${namespace}-tab:hover {
  color: var(--${namespace}-white);
}
.${namespace}-tab--active {
  color: var(--${namespace}-white);
  border-bottom-color: #80ffe8;
  background: rgba(255, 255, 255, 0.07);
}

/* Counter dot in tab */
.${namespace}-tab__count {
  margin-left: var(--${namespace}-space-1);
  background: rgba(255, 120, 80, 0.85);
  color: var(--${namespace}-white);
  padding: 0 var(--${namespace}-space-1_5);
  border-radius: var(--${namespace}-radius-2xl);
  font-size: var(--${namespace}-font-size-2xs);
}
.${namespace}-tab__count--success {
  background: rgba(80, 200, 120, 0.85);
}


/* =============================================================
   13. COMPONENT: NAVIGATION BAR
   ============================================================= */

/* Top application bar */
.${namespace}-topbar {
  background: linear-gradient(90deg, var(--${namespace}-navy-800) 0%, var(--${namespace}-navy-700) 50%, #104870 100%);
  height: 44px;
  display: flex;
  align-items: center;
  padding: 0 var(--${namespace}-space-6);
  flex-shrink: 0;
  border-bottom: 2px solid var(--${namespace}-teal-600);
  gap: var(--${namespace}-space-5);
}

.${namespace}-topbar__logo {
  display: flex;
  align-items: center;
  gap: var(--${namespace}-space-3_5);
}

.${namespace}-topbar__cross {
  width: 30px;
  height: 30px;
  background: rgba(0, 168, 144, 0.25);
  border-radius: var(--${namespace}-radius-xl);
  border: 1px solid rgba(0, 200, 170, 0.4);
  display: flex;
  align-items: center;
  justify-content: center;
  position: relative;
  flex-shrink: 0;
}
.${namespace}-topbar__cross::before,
.${namespace}-topbar__cross::after {
  content: '';
  position: absolute;
  background: #00e8c8;
  border-radius: 1px;
}
.${namespace}-topbar__cross::before { width: 4px;  height: 16px; }
.${namespace}-topbar__cross::after  { width: 16px; height: 4px; }

.${namespace}-topbar__system-name {
  font-size: var(--${namespace}-font-size-2xl);
  font-weight: var(--${namespace}-font-weight-bold);
  color: #a0f0e0;
  letter-spacing: var(--${namespace}-letter-spacing-widest);
}

.${namespace}-topbar__subtitle {
  font-size: var(--${namespace}-font-size-xs);
  color: rgba(180, 230, 220, 0.5);
  letter-spacing: var(--${namespace}-letter-spacing-wider);
  margin-top: 1px;
}

.${namespace}-topbar__divider {
  width: 1px;
  height: 26px;
  background: rgba(255, 255, 255, 0.12);
}

.${namespace}-topbar__dept {
  font-size: var(--${namespace}-font-size-lg);
  color: rgba(255, 255, 255, 0.8);
  font-weight: var(--${namespace}-font-weight-medium);
}

.${namespace}-topbar__right {
  margin-left: auto;
  display: flex;
  align-items: center;
  gap: var(--${namespace}-space-5);
}

.${namespace}-topbar__user {
  font-size: var(--${namespace}-font-size-sm);
  color: rgba(200, 240, 230, 0.7);
  display: flex;
  align-items: center;
  gap: var(--${namespace}-space-2);
}
.${namespace}-topbar__user strong {
  color: #a0f0e0;
}

.${namespace}-topbar__clock {
  font-size: var(--${namespace}-font-size-xl);
  font-weight: var(--${namespace}-font-weight-bold);
  color: #80ffe8;
  font-variant-numeric: tabular-nums;
  letter-spacing: var(--${namespace}-letter-spacing-wider);
}

/* Alert pill in topbar */
.${namespace}-topbar-alert {
  background: rgba(200, 32, 10, 0.3);
  border: 1px solid rgba(200, 32, 10, 0.5);
  border-radius: var(--${namespace}-radius-md);
  padding: var(--${namespace}-space-1) var(--${namespace}-space-3_5);
  font-size: var(--${namespace}-font-size-sm);
  color: #ffb0a8;
  display: flex;
  align-items: center;
  gap: var(--${namespace}-space-1_5);
  cursor: pointer;
  animation: ${namespace}-blink 2s infinite;
}

@keyframes ${namespace}-blink {
  0%, 100% { opacity: 1; }
  50%      { opacity: 0.7; }
}

/* Menu bar */
.${namespace}-menubar {
  background: #0d3a28;
  height: 26px;
  display: flex;
  align-items: stretch;
  border-bottom: 1px solid #082818;
  flex-shrink: 0;
}

.${namespace}-menuitem {
  display: flex;
  align-items: center;
  padding: 0 var(--${namespace}-space-4);
  font-size: var(--${namespace}-font-size-md);
  color: rgba(255, 255, 255, 0.7);
  cursor: pointer;
  gap: var(--${namespace}-space-1_5);
  border-right: var(--${namespace}-border-hairline);
  white-space: nowrap;
  transition: background var(--${namespace}-transition-fast),
              color var(--${namespace}-transition-fast);
}
.${namespace}-menuitem:hover {
  background: #1a5038;
  color: var(--${namespace}-white);
}
.${namespace}-menuitem--active {
  background: var(--${namespace}-teal-800);
  color: var(--${namespace}-white);
}

/* Status bar */
.${namespace}-statusbar {
  background: #0d3a28;
  height: 20px;
  display: flex;
  align-items: center;
  flex-shrink: 0;
  border-top: 1px solid #081e14;
}

.${namespace}-statusbar__item {
  padding: 0 var(--${namespace}-space-4);
  font-size: var(--${namespace}-font-size-xs);
  color: rgba(255, 255, 255, 0.55);
  border-right: var(--${namespace}-border-hairline);
  height: 100%;
  display: flex;
  align-items: center;
  gap: var(--${namespace}-space-1_5);
}
.${namespace}-statusbar__item strong {
  color: rgba(180, 255, 220, 0.9);
}

.${namespace}-statusbar__right {
  margin-left: auto;
  display: flex;
  align-items: stretch;
}


/* =============================================================
   14. COMPONENT: TOOLBAR
   ============================================================= */

.${namespace}-toolbar {
  background: var(--${namespace}-bg-surface);
  height: 32px;
  display: flex;
  align-items: center;
  padding: 0 var(--${namespace}-space-3_5);
  border-bottom: 1px solid var(--${namespace}-border-default);
  flex-shrink: 0;
  gap: var(--${namespace}-space-1);
}

.${namespace}-toolbar__group {
  display: flex;
  align-items: center;
  gap: var(--${namespace}-space-0_5);
  padding: 0 var(--${namespace}-space-1_5);
  border-right: 1px solid var(--${namespace}-border-light);
}
.${namespace}-toolbar__group:last-child {
  border-right: none;
  margin-left: auto;
}

/* Filter pills */
.${namespace}-filter {
  display: flex;
  align-items: center;
}

.${namespace}-filter__item {
  padding: var(--${namespace}-space-1) var(--${namespace}-space-2);
  border: 1px solid var(--${namespace}-border-default);
  font-size: var(--${namespace}-font-size-sm);
  color: var(--${namespace}-text-secondary);
  cursor: pointer;
  background: var(--${namespace}-bg-elevated);
  transition: background var(--${namespace}-transition-fast),
              color var(--${namespace}-transition-fast);
}
.${namespace}-filter__item:first-child {
  border-radius: var(--${namespace}-radius-sm) 0 0 var(--${namespace}-radius-sm);
}
.${namespace}-filter__item:last-child {
  border-radius: 0 var(--${namespace}-radius-sm) var(--${namespace}-radius-sm) 0;
}
.${namespace}-filter__item--active {
  background: var(--${namespace}-teal-800);
  color: var(--${namespace}-white);
  border-color: var(--${namespace}-teal-800);
}


/* =============================================================
   15. COMPONENT: MODAL
   ============================================================= */

.${namespace}-modal-overlay {
  position: fixed;
  inset: 0;
  background: rgba(0, 0, 0, 0.5);
  z-index: var(--${namespace}-z-overlay);
  display: flex;
  align-items: center;
  justify-content: center;
}

.${namespace}-modal {
  background: var(--${namespace}-bg-elevated);
  border-radius: var(--${namespace}-radius-lg);
  box-shadow: var(--${namespace}-shadow-modal);
  width: 440px;
  max-width: 90vw;
  overflow: hidden;
}

.${namespace}-modal__header {
  background: var(--${namespace}-color-danger);
  color: var(--${namespace}-white);
  padding: var(--${namespace}-space-4) var(--${namespace}-space-7);
  display: flex;
  align-items: center;
  gap: var(--${namespace}-space-3_5);
  font-size: var(--${namespace}-font-size-xl);
  font-weight: var(--${namespace}-font-weight-bold);
}

.${namespace}-modal__body {
  padding: var(--${namespace}-space-7);
}

.${namespace}-modal__footer {
  display: flex;
  justify-content: flex-end;
  gap: var(--${namespace}-space-3_5);
  padding: var(--${namespace}-space-4) var(--${namespace}-space-7);
  background: #f8f8f8;
  border-top: 1px solid #e8e8e8;
}

.${namespace}-modal__btn {
  padding: var(--${namespace}-space-2_5) var(--${namespace}-space-6);
  border-radius: var(--${namespace}-radius-md);
  border: none;
  font-size: var(--${namespace}-font-size-md);
  cursor: pointer;
  font-family: var(--${namespace}-font-family);
}
.${namespace}-modal__btn--primary {
  background: var(--${namespace}-color-danger);
  color: var(--${namespace}-white);
}
.${namespace}-modal__btn--secondary {
  background: #e8e8e8;
  color: #333333;
}


/* =============================================================
   16. COMPONENT: TIMELINE
   ============================================================= */

.${namespace}-timeline {
  padding: var(--${namespace}-space-2_5) var(--${namespace}-space-4);
}

.${namespace}-timeline__item {
  display: flex;
  gap: var(--${namespace}-space-3_5);
  margin-bottom: var(--${namespace}-space-3_5);
  position: relative;
}
.${namespace}-timeline__item::before {
  content: '';
  position: absolute;
  left: 14px;
  top: 18px;
  bottom: -8px;
  width: 1px;
  background: var(--${namespace}-border-light);
}
.${namespace}-timeline__item:last-child::before {
  display: none;
}

.${namespace}-timeline__dot {
  width: 10px;
  height: 10px;
  border-radius: var(--${namespace}-radius-full);
  flex-shrink: 0;
  margin-top: var(--${namespace}-space-1_5);
  background: var(--${namespace}-teal-800);
  border: 2px solid var(--${namespace}-teal-50);
}
.${namespace}-timeline__dot--warning  { background: var(--${namespace}-amber-700); }
.${namespace}-timeline__dot--critical { background: var(--${namespace}-color-danger); }

.${namespace}-timeline__body {
  flex: 1;
}

.${namespace}-timeline__time {
  font-size: var(--${namespace}-font-size-xs);
  color: var(--${namespace}-text-tertiary);
}

.${namespace}-timeline__title {
  font-size: var(--${namespace}-font-size-sm);
  font-weight: var(--${namespace}-font-weight-semibold);
  color: var(--${namespace}-text-primary);
  margin-top: 1px;
}

.${namespace}-timeline__desc {
  font-size: var(--${namespace}-font-size-xs);
  color: var(--${namespace}-text-secondary);
  line-height: var(--${namespace}-line-height-relaxed);
  margin-top: var(--${namespace}-space-0_5);
}

.${namespace}-timeline__doctor {
  font-size: var(--${namespace}-font-size-xs);
  color: var(--${namespace}-teal-800);
  margin-top: var(--${namespace}-space-0_5);
}


/* =============================================================
   17. COMPONENT: VITAL SIGNS (Mini Metrics)
   ============================================================= */

.${namespace}-vitals {
  display: grid;
  grid-template-columns: 1fr 1fr;
  gap: var(--${namespace}-space-1_5);
}

.${namespace}-vital {
  background: var(--${namespace}-bg-surface);
  border: 1px solid var(--${namespace}-border-light);
  border-radius: var(--${namespace}-radius-md);
  padding: var(--${namespace}-space-1_5) var(--${namespace}-space-2_5);
}

.${namespace}-vital__label {
  font-size: var(--${namespace}-font-size-2xs);
  color: var(--${namespace}-text-tertiary);
  display: flex;
  align-items: center;
  justify-content: space-between;
}

.${namespace}-vital__value {
  font-size: var(--${namespace}-font-size-xl);
  font-weight: var(--${namespace}-font-weight-bold);
  color: var(--${namespace}-text-primary);
  line-height: var(--${namespace}-line-height-tight);
}
.${namespace}-vital__value--warning { color: var(--${namespace}-color-warning); }
.${namespace}-vital__value--danger  { color: var(--${namespace}-color-danger); }

.${namespace}-vital__unit {
  font-size: var(--${namespace}-font-size-2xs);
  font-weight: var(--${namespace}-font-weight-normal);
  color: var(--${namespace}-text-tertiary);
}


/* =============================================================
   18. COMPONENT: PATIENT LIST ITEM
   ============================================================= */

.${namespace}-patient-item {
  display: flex;
  flex-direction: column;
  padding: var(--${namespace}-space-3) var(--${namespace}-space-4);
  border-bottom: 1px solid var(--${namespace}-border-light);
  cursor: pointer;
  position: relative;
  transition: background var(--${namespace}-transition-fast);
}
.${namespace}-patient-item:hover {
  background: var(--${namespace}-gray-150);
}

.${namespace}-patient-item--selected {
  background: var(--${namespace}-bg-selection);
  border-left: 3px solid var(--${namespace}-teal-800);
  padding-left: 7px;
}

.${namespace}-patient-item--critical {
  border-left: 3px solid var(--${namespace}-color-danger);
  padding-left: 7px;
}
.${namespace}-patient-item--critical:not(.${namespace}-patient-item--selected) {
  background: rgba(200, 32, 10, 0.04);
}

.${namespace}-patient-item__row {
  display: flex;
  align-items: center;
  gap: var(--${namespace}-space-2);
}

.${namespace}-patient-item__name {
  font-size: var(--${namespace}-font-size-lg);
  font-weight: var(--${namespace}-font-weight-semibold);
  color: var(--${namespace}-text-primary);
}

.${namespace}-patient-item__meta {
  display: flex;
  gap: var(--${namespace}-space-3_5);
  margin-top: var(--${namespace}-space-1);
  font-size: var(--${namespace}-font-size-xs);
  color: var(--${namespace}-text-tertiary);
}

.${namespace}-patient-item__bed {
  font-weight: var(--${namespace}-font-weight-semibold);
  color: var(--${namespace}-teal-800);
}

.${namespace}-patient-item__diagnosis {
  flex: 1;
  overflow: hidden;
  text-overflow: ellipsis;
  white-space: nowrap;
}

/* Patient summary card (gradient header in right column) */
.${namespace}-patient-summary {
  background: linear-gradient(135deg, var(--${namespace}-teal-800), var(--${namespace}-teal-700));
  padding: var(--${namespace}-space-4) var(--${namespace}-space-5);
  flex-shrink: 0;
}

.${namespace}-patient-summary__header {
  display: flex;
  align-items: center;
  gap: var(--${namespace}-space-3_5);
  margin-bottom: var(--${namespace}-space-2_5);
}

.${namespace}-patient-summary__avatar {
  width: 36px;
  height: 36px;
  border-radius: var(--${namespace}-radius-full);
  background: rgba(255, 255, 255, 0.2);
  border: 2px solid rgba(255, 255, 255, 0.4);
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: var(--${namespace}-font-size-3xl);
  font-weight: var(--${namespace}-font-weight-bold);
  color: var(--${namespace}-white);
  flex-shrink: 0;
}

.${namespace}-patient-summary__name {
  font-size: var(--${namespace}-font-size-2xl);
  font-weight: var(--${namespace}-font-weight-bold);
  color: var(--${namespace}-white);
}

.${namespace}-patient-summary__info {
  font-size: var(--${namespace}-font-size-sm);
  color: rgba(255, 255, 255, 0.75);
  margin-top: var(--${namespace}-space-0_5);
}

.${namespace}-patient-summary__info-grid {
  display: grid;
  grid-template-columns: 1fr 1fr 1fr;
  gap: var(--${namespace}-space-1_5);
}

.${namespace}-patient-summary__kv {
  background: rgba(255, 255, 255, 0.12);
  border-radius: var(--${namespace}-radius-md);
  padding: var(--${namespace}-space-1_5) var(--${namespace}-space-2_5);
}

.${namespace}-patient-summary__k {
  font-size: var(--${namespace}-font-size-2xs);
  color: rgba(255, 255, 255, 0.6);
  letter-spacing: var(--${namespace}-letter-spacing-wide);
}

.${namespace}-patient-summary__v {
  font-size: var(--${namespace}-font-size-md);
  font-weight: var(--${namespace}-font-weight-semibold);
  color: var(--${namespace}-white);
  margin-top: 1px;
}
.${namespace}-patient-summary__v--abnormal { color: #ffcc80; }
.${namespace}-patient-summary__v--danger   { color: #ff9080; }


/* =============================================================
   19. COMPONENT: DRUG SUGGESTION DROPDOWN
   ============================================================= */

.${namespace}-drug-suggest {
  position: absolute;
  z-index: var(--${namespace}-z-dropdown);
  background: var(--${namespace}-bg-elevated);
  border: 1px solid var(--${namespace}-border-default);
  border-radius: var(--${namespace}-radius-md);
  box-shadow: var(--${namespace}-shadow-md);
  max-height: 140px;
  overflow-y: auto;
  min-width: 220px;
}

.${namespace}-drug-suggest__item {
  padding: var(--${namespace}-space-2) var(--${namespace}-space-4);
  cursor: pointer;
  font-size: var(--${namespace}-font-size-sm);
  border-bottom: 1px solid var(--${namespace}-border-light);
}
.${namespace}-drug-suggest__item:hover {
  background: var(--${namespace}-teal-50);
}

.${namespace}-drug-suggest__name {
  font-weight: var(--${namespace}-font-weight-semibold);
  color: var(--${namespace}-navy-800);
}

.${namespace}-drug-suggest__spec {
  font-size: var(--${namespace}-font-size-xs);
  color: var(--${namespace}-text-tertiary);
  margin-top: 1px;
}

.${namespace}-drug-suggest__stock {
  float: right;
  font-size: var(--${namespace}-font-size-xs);
  color: var(--${namespace}-color-success);
  font-weight: var(--${namespace}-font-weight-semibold);
}
.${namespace}-drug-suggest__item--oos .${namespace}-drug-suggest__stock {
  color: var(--${namespace}-color-danger);
}


/* =============================================================
   20. COMPONENT: ORDER ENTRY PANEL
   ============================================================= */

.${namespace}-order-panel {
  background: var(--${namespace}-bg-surface);
  border-bottom: 1px solid var(--${namespace}-border-default);
  padding: var(--${namespace}-space-3_5) var(--${namespace}-space-4);
}

.${namespace}-order-panel__title {
  font-size: var(--${namespace}-font-size-sm);
  font-weight: var(--${namespace}-font-weight-semibold);
  color: var(--${namespace}-teal-800);
  margin-bottom: var(--${namespace}-space-2_5);
  display: flex;
  align-items: center;
  gap: var(--${namespace}-space-2);
}
.${namespace}-order-panel__title::before {
  content: 'Rx';
  background: var(--${namespace}-teal-800);
  color: var(--${namespace}-white);
  padding: 0 var(--${namespace}-space-2);
  border-radius: var(--${namespace}-radius-sm);
  font-size: var(--${namespace}-font-size-xs);
  font-weight: var(--${namespace}-font-weight-bold);
}

.${namespace}-order-panel__row {
  display: flex;
  gap: var(--${namespace}-space-1_5);
  flex-wrap: wrap;
  align-items: flex-end;
}

.${namespace}-order-panel__alert {
  font-size: var(--${namespace}-font-size-xs);
  color: var(--${namespace}-color-warning);
  margin-top: var(--${namespace}-space-1);
  background: var(--${namespace}-amber-100);
  padding: var(--${namespace}-space-1) var(--${namespace}-space-2_5);
  border-radius: var(--${namespace}-radius-sm);
}


/* =============================================================
   21. UTILITY CLASSES
   ============================================================= */

/* Display */
.${namespace}-flex         { display: flex; }
.${namespace}-flex-col     { display: flex; flex-direction: column; }
.${namespace}-inline-flex  { display: inline-flex; }
.${namespace}-hidden       { display: none; }

/* Alignment */
.${namespace}-items-center { align-items: center; }
.${namespace}-items-start  { align-items: flex-start; }
.${namespace}-items-end    { align-items: flex-end; }
.${namespace}-justify-between { justify-content: space-between; }
.${namespace}-justify-end  { justify-content: flex-end; }

/* Gap */
.${namespace}-gap-1  { gap: var(--${namespace}-space-1); }
.${namespace}-gap-2  { gap: var(--${namespace}-space-1_5); }
.${namespace}-gap-3  { gap: var(--${namespace}-space-2_5); }
.${namespace}-gap-4  { gap: var(--${namespace}-space-3_5); }
.${namespace}-gap-5  { gap: var(--${namespace}-space-5); }

/* Padding */
.${namespace}-p-1  { padding: var(--${namespace}-space-1_5); }
.${namespace}-p-2  { padding: var(--${namespace}-space-3_5); }
.${namespace}-p-3  { padding: var(--${namespace}-space-4); }
.${namespace}-p-4  { padding: var(--${namespace}-space-7); }
.${namespace}-px-2 { padding-left: var(--${namespace}-space-3_5); padding-right: var(--${namespace}-space-3_5); }
.${namespace}-py-1 { padding-top: var(--${namespace}-space-1_5); padding-bottom: var(--${namespace}-space-1_5); }

/* Margin */
.${namespace}-mt-1 { margin-top: var(--${namespace}-space-1_5); }
.${namespace}-mt-2 { margin-top: var(--${namespace}-space-3_5); }
.${namespace}-mb-1 { margin-bottom: var(--${namespace}-space-1_5); }
.${namespace}-mb-2 { margin-bottom: var(--${namespace}-space-3_5); }
.${namespace}-ml-auto { margin-left: auto; }

/* Overflow */
.${namespace}-overflow-auto  { overflow: auto; }
.${namespace}-overflow-y     { overflow-y: auto; }
.${namespace}-overflow-hidden { overflow: hidden; }

/* Flex */
.${namespace}-flex-1     { flex: 1; }
.${namespace}-flex-shrink-0 { flex-shrink: 0; }

/* Sizing */
.${namespace}-w-full  { width: 100%; }
.${namespace}-h-full  { height: 100%; }
.${namespace}-min-w-0 { min-width: 0; }

/* Background */
.${namespace}-bg-page     { background: var(--${namespace}-bg-page); }
.${namespace}-bg-surface  { background: var(--${namespace}-bg-surface); }
.${namespace}-bg-white    { background: var(--${namespace}-bg-elevated); }

/* Border */
.${namespace}-border-b { border-bottom: 1px solid var(--${namespace}-border-default); }
.${namespace}-border-t { border-top: 1px solid var(--${namespace}-border-default); }

/* Radius */
.${namespace}-rounded-sm  { border-radius: var(--${namespace}-radius-sm); }
.${namespace}-rounded-md  { border-radius: var(--${namespace}-radius-md); }
.${namespace}-rounded-lg  { border-radius: var(--${namespace}-radius-lg); }
.${namespace}-rounded-full { border-radius: var(--${namespace}-radius-full); }

/* Cursor */
.${namespace}-cursor-pointer { cursor: pointer; }
.${namespace}-select-none    { user-select: none; }

/* Animation */
.${namespace}-animate-blink {
  animation: ${namespace}-blink 2s infinite;
}

/* Screen reader only */
.${namespace}-sr-only {
  position: absolute;
  width: 1px;
  height: 1px;
  padding: 0;
  margin: -1px;
  overflow: hidden;
  clip: rect(0, 0, 0, 0);
  white-space: nowrap;
  border: 0;
}


/* =============================================================
   RESPONSIVE ADJUSTMENTS
   ============================================================= */

@media (max-width: 1280px) {
  .${namespace}-col-left  { width: 180px; }
  .${namespace}-col-right { width: 200px; }
}

@media (max-width: 1024px) {
  .${namespace}-col-right { display: none; }
  .${namespace}-col-left  { width: 160px; }
}

@media (max-width: 768px) {
  .${namespace}-col-left { display: none; }
  .${namespace}-topbar__subtitle { display: none; }
  .${namespace}-topbar__dept     { display: none; }
}


/* =============================================================
   Usage quick-ref
   ──────────────────────────────────────────────

   Colors:
     var(--${namespace}-color-primary)         → Primary teal
     var(--${namespace}-color-danger)          → Emergency red
     var(--${namespace}-color-warning)         → Caution amber
     var(--${namespace}-color-success)         → Recovery green
     var(--${namespace}-color-info)            → Data blue
     var(--${namespace}-bg-page)              → Page background
     var(--${namespace}-bg-surface)           → Surface / card bg
     var(--${namespace}-bg-elevated)          → Elevated element bg
     var(--${namespace}-text-primary)          → Primary text
     var(--${namespace}-text-secondary)        → Secondary text
     var(--${namespace}-text-tertiary)         → Tertiary / muted text

   Buttons:
     .${namespace}-btn                        → Default button
     .${namespace}-btn--primary               → Primary action (teal)
     .${namespace}-btn--danger                → Destructive action (red)
     .${namespace}-btn--success               → Confirm action (green)
     .${namespace}-btn--warning               → Caution action (amber)
     .${namespace}-btn--ghost                 → Button on dark backgrounds
     .${namespace}-btn--disabled              → Disabled state
     .${namespace}-btn--sm / --lg             → Size modifiers

   Badges:
     .${namespace}-badge                      → Base badge
     .${namespace}-badge--critical            → Red urgency badge
     .${namespace}-badge--warning             → Amber caution badge
     .${namespace}-badge--success             → Green positive badge
     .${namespace}-badge--info                → Blue informational badge

   Status:
     .${namespace}-status                     → Base status pill
     .${namespace}-status--active             → Active / executing
     .${namespace}-status--pending            → Pending / waiting
     .${namespace}-status--stopped            → Stopped (strikethrough)
     .${namespace}-status--draft              → Draft / new
     .${namespace}-status--critical           → Critical / alert

   Layout:
     .${namespace}-app                        → Full-height app shell
     .${namespace}-layout-3col                → Three-column layout
     .${namespace}-col-left / --main / --right → Column containers

   Typography:
     .${namespace}-text-2xs … .${namespace}-text-2xl  → Font sizes
     .${namespace}-text-primary … inverse     → Text colors
     .${namespace}-font-light … bold          → Font weights

   ============================================================= */
