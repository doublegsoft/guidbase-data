<#--
 ###############################################################################
 ### 瓦片通用样式 · Tile Universal CSS
 ### 覆盖 tile.ftl 中所有 57 种瓦片布局的全部 class
 ###############################################################################
-->
<#--
 ============================================================
 1. 基础容器 · Tile Base
 ============================================================
-->
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

<#--
 ============================================================
 2. 布局行/列 · Row & Column
 ============================================================
-->
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

<#--
 ============================================================
 3. 文本插槽 · Text Slots (primary/secondary/tertiary)
 ============================================================
-->
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

<#--
 ============================================================
 4. 图片 · Image
 ============================================================
-->
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

<#--
 ============================================================
 5. 头像 · Avatar (single & group)
 ============================================================
-->
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

<#--
 ============================================================
 6. 标签 · Tags
 ============================================================
-->
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

<#--
 ============================================================
 7. 状态 · Status
 ============================================================
-->
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

<#--
 ============================================================
 8. 时间 · Time
 ============================================================
-->
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

<#--
 ============================================================
 9. 背景与遮罩 · Background & Overlay
 ============================================================
-->
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

<#--
 ============================================================
 10. 时间轴 · Timeline
 ============================================================
-->
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

<#--
 ============================================================
 11. 工作流 · Workflow
 ============================================================
-->
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

<#--
 ============================================================
 12. 进度条 · Progress
 ============================================================
-->
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

<#--
 ============================================================
 13. 分段步骤 · Stepped Process
 ============================================================
-->
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

<#--
 ============================================================
 14. 三段分步 · Three-Stage Segment
 ============================================================
-->
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

<#--
 ============================================================
 15. 悬浮叠层 · Stacked Overlay
 ============================================================
-->
.tile-stacked-card {
  position: relative;
  z-index: 2;
  margin-top: -20px;
  background: var(--tile-bg, #fff);
  border-radius: 8px;
  padding: 10px;
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
}

<#--
 ============================================================
 16. 各瓦片个性化样式 · Per-Tile Specific Styles
 ============================================================
-->

<#-- 01 会议与日程 -->
.tile-meeting-event .tile-time {
  font-size: 12px;
  font-weight: 500;
}

<#-- 02 媒体与资讯 -->
.tile-media-article .tile-image {
  min-height: 120px;
}
.tile-media-article .tile-image img {
  width: 100%;
  height: 100%;
  object-fit: cover;
}

<#-- 03 个人资料 -->
.tile-user-profile .tile-avatar {
  width: 40px;
  height: 40px;
  font-size: 16px;
}

<#-- 04 任务看板 -->
.tile-task-board .tile-header {
  margin-bottom: 4px;
}

<#-- 05 推广横幅 (背景型) -->
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

<#-- 06 紧凑列表 -->
.tile-compact-list .tile-inline {
  flex-wrap: nowrap;
}

<#-- 07 图文卡片 -->
.tile-split-content .tile-image {
  width: 80px;
  min-height: 80px;
}

<#-- 08 简易状态 -->
.tile-notification .tile-primary {
  font-size: 13px;
}

<#-- 09 背景封面 (背景型) -->
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

<#-- 10 时间轴节点 -->
.tile-timeline-node .tile-row {
  align-items: stretch;
}
.tile-timeline-node .tile-body {
  padding-left: 8px;
  border-left: 1px dashed var(--tile-border, #ddd);
}

<#-- 11 消息留言 -->
.tile-message .tile-avatar {
  width: 40px;
  height: 40px;
}
.tile-message .tile-header .tile-time {
  margin-left: auto;
}

<#-- 12 电子票务 (背景型) -->
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

<#-- 13 密集信息列表 -->
.tile-dense-detail-list .tile-image {
  width: 48px;
  height: 48px;
  border-radius: 6px;
}
.tile-dense-detail-list .tile-body > .tile-row {
  font-size: 11px;
}

<#-- 14 竖向海报 -->
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

<#-- 15 详情工单 -->
.tile-issue-detail .tile-header {
  margin-bottom: 6px;
}
.tile-issue-detail .tile-footer .tile-avatar {
  width: 28px;
  height: 28px;
  font-size: 12px;
}

<#-- 16 团队目录 -->
.tile-team-directory .tile-body {
  margin-bottom: 8px;
}

<#-- 17 沉浸高光 (背景型) -->
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

<#-- 18 迷你状态 -->
.tile-mini-status {
  max-width: 200px;
  gap: 8px;
}
.tile-mini-status .tile-header {
  margin-bottom: 2px;
}

<#-- 19 双栏内容 -->
.tile-dual-column-content .tile-col-left {
  border-right: 1px solid var(--tile-border, #eee);
  padding-right: 10px;
}

<#-- 20 画廊 -->
.tile-gallery .tile-image-wrap .tile-image {
  min-height: 110px;
}

<#-- 21 核心指标 -->
.tile-key-metric {
  max-width: 200px;
  text-align: center;
}
.tile-key-metric .tile-primary {
  font-size: 28px;
  font-weight: 700;
  line-height: 1.2;
}

<#-- 22 悬浮头像 -->
.tile-overlay-avatar .tile-image-wrap .tile-image {
  min-height: 100px;
}

<#-- 23 审计记录 -->
.tile-audit-log .tile-avatar {
  width: 32px;
  height: 32px;
  font-size: 12px;
}

<#-- 24 日历单元 -->
.tile-calendar-cell {
  max-width: 180px;
  gap: 4px;
}

<#-- 25 侧边状态 -->
.tile-side-status .tile-status-col {
  min-width: 48px;
  padding-right: 8px;
}

<#-- 26 多标签 -->
.tile-multi-tag .tile-tags-row {
  margin-bottom: 6px;
}

<#-- 27 复杂排班 -->
.tile-shift-planner .tile-header {
  margin-bottom: 4px;
}

<#-- 28 社交动态 -->
.tile-social-post-feed .tile-image-wrap .tile-image {
  min-height: 100px;
  border-radius: 6px;
}

<#-- 29 商品 -->
.tile-product {
  max-width: 220px;
}
.tile-product .tile-image-wrap .tile-image {
  min-height: 110px;
}

<#-- 30 对抗与合作 -->
.tile-dual-profile-comparison .tile-header {
  justify-content: space-between;
}
.tile-dual-profile-comparison .tile-header .tile-avatar {
  width: 40px;
  height: 40px;
}

<#-- 31 侧栏大图 -->
.tile-left-feature-image .tile-image {
  width: 120px;
  min-height: 100px;
  border-radius: 6px;
}
.tile-left-feature-image .tile-body {
  padding-left: 4px;
}

<#-- 32 宽版工作流 -->
.tile-workflow-strip .tile-workflow-chain {
  margin-bottom: 4px;
}

<#-- 33 悬浮背景文字 (背景型) -->
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

<#-- 34 微型标记 -->
.tile-micro-badge .tile-inline {
  gap: 6px;
}
.tile-micro-badge .tile-avatar {
  width: 24px;
  height: 24px;
  font-size: 11px;
}

<#-- 35 分段步骤 -->
.tile-stepped-process .tile-body {
  padding-left: 8px;
}

<#-- 36 悬浮叠层 -->
.tile-stacked-overlay .tile-image-wrap .tile-image {
  min-height: 100px;
}

<#-- 37 群组画布 -->
.tile-group-hub .tile-avatars {
  margin-bottom: 4px;
}

<#-- 38 极窄卡片 -->
.tile-tall-sidebar {
  max-width: 180px;
  align-items: stretch;
}
.tile-tall-sidebar .tile-image {
  width: 100%;
  min-height: 80px;
}

<#-- 39 分栏对账 -->
.tile-justified-meta .tile-justified {
  margin-bottom: 2px;
}

<#-- 40 多维仪表 -->
.tile-multidimensional-board .tile-cols .tile-col {
  border: 1px solid var(--tile-border, #eee);
  border-radius: 6px;
  padding: 8px;
}

<#-- 41 播放媒体 -->
.tile-media-player .tile-image {
  width: 56px;
  height: 56px;
}

<#-- 42 左锚点时间 -->
.tile-left-anchor-time .tile-header {
  margin-bottom: 4px;
}

<#-- 43 时间跨度 -->
.tile-duration-span .tile-time {
  font-size: 12px;
  font-weight: 500;
}

<#-- 44 图文记录 -->
.tile-media-history .tile-image {
  width: 56px;
  height: 56px;
}
.tile-media-history .tile-start-time {
  margin-bottom: 4px;
}

<#-- 45 状态追踪 -->
.tile-status-transition .tile-avatar {
  width: 28px;
  height: 28px;
  font-size: 11px;
}

<#-- 46 极简时间单元 -->
.tile-compact-time .tile-inline {
  flex-wrap: nowrap;
  gap: 0;
}

<#-- 47 横向流单元 -->
.tile-horizontal-flow {
  max-width: 160px;
  text-align: center;
  align-items: center;
}

<#-- 48 右偏置节点 -->
.tile-right-biased-node {
  max-width: 180px;
}

<#-- 49 左偏置节点 -->
.tile-left-biased-node {
  max-width: 180px;
}

<#-- 50 内置时间轴 -->
.tile-internal-chronology .tile-timeline-line {
  margin: 2px 0;
}

<#-- 51 三段分步 -->
.tile-three-stage-segment .tile-three-stage {
  margin-bottom: 4px;
}

<#-- 52 行式日志 -->
.tile-horizontal-log .tile-inline {
  flex-wrap: nowrap;
  gap: 0;
}
.tile-horizontal-log .tile-avatar {
  width: 24px;
  height: 24px;
  font-size: 11px;
}

<#-- 53 简讯 -->
.tile-bulletin .tile-tags {
  margin-bottom: 4px;
}

<#-- 54 时间印章 (背景型) -->
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

<#-- 55 精简对话 -->
.tile-compact-chat .tile-avatar {
  width: 32px;
  height: 32px;
  font-size: 13px;
}

<#-- 56 侧图时间舱 -->
.tile-side-image-time-capsule .tile-cols .tile-col:first-child {
  border: 1px solid var(--tile-border, #eee);
  border-radius: 6px;
  padding: 8px;
}
.tile-side-image-time-capsule .tile-image {
  min-height: 60px;
}

<#-- 57 标签终点节点 -->
.tile-multi-tag-end-node .tile-header {
  margin-bottom: 4px;
}
