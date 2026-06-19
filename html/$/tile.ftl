<#import "/$/guidbase.ftl" as guidbase>

<#--
 ###############################################################################
 ### 瓦片猜测器 - 根据 widget.children 的 level 匹配最合适的瓦片样式
 ###############################################################################
-->
<#function guess_tile widget>
  <#-- 收集当前 widget 中存在哪些 level -->
  <#local has_primary = guidbase.has_child_widget(widget, "primary")>
  <#local has_secondary = guidbase.has_child_widget(widget, "secondary")>
  <#local has_tertiary = guidbase.has_child_widget(widget, "tertiary")>
  <#local has_image = guidbase.has_child_widget(widget, "image")>
  <#local has_avatar = guidbase.has_child_widget(widget, "avatar")>
  <#local has_avatars = guidbase.has_child_widget(widget, "avatars")>
  <#local has_tags = guidbase.has_child_widget(widget, "tags")>
  <#local has_status = guidbase.has_child_widget(widget, "status")>
  <#local has_start_time = guidbase.has_child_widget(widget, "start_time")>
  <#local has_end_time = guidbase.has_child_widget(widget, "end_time")>
  <#local has_background = guidbase.has_child_widget(widget, "background")>

  <#-- 对每个瓦片模式评分: 期望slot存在+2, 多余slot存在-1 -->
  <#local bestName = "meeting_event">
  <#local bestScore = -999>

  <#-- meeting_event: [start_time, end_time, status, primary, secondary, avatars] -->
  <#local s = ((has_start_time?then(2, 0)) + (has_end_time?then(2, 0)) + (has_status?then(2, 0)) + (has_primary?then(2, 0)) + (has_secondary?then(2, 0)) + (has_avatars?then(2, 0))) - ((has_tertiary?then(1, 0)) + (has_image?then(1, 0)) + (has_avatar?then(1, 0)) + (has_tags?then(1, 0)) + (has_background?then(1, 0)))>
  <#if s > bestScore>
    <#local bestScore = s>
    <#local bestName = "meeting_event">
  </#if>
  <#-- media_article: [image, tags, primary, secondary, tertiary] -->
  <#local s = ((has_image?then(2, 0)) + (has_tags?then(2, 0)) + (has_primary?then(2, 0)) + (has_secondary?then(2, 0)) + (has_tertiary?then(2, 0))) - ((has_avatar?then(1, 0)) + (has_avatars?then(1, 0)) + (has_status?then(1, 0)) + (has_start_time?then(1, 0)) + (has_end_time?then(1, 0)) + (has_background?then(1, 0)))>
  <#if s > bestScore>
    <#local bestScore = s>
    <#local bestName = "media_article">
  </#if>
  <#-- user_profile: [avatar, primary, secondary, status] -->
  <#local s = ((has_avatar?then(2, 0)) + (has_primary?then(2, 0)) + (has_secondary?then(2, 0)) + (has_status?then(2, 0))) - ((has_tertiary?then(1, 0)) + (has_image?then(1, 0)) + (has_avatars?then(1, 0)) + (has_tags?then(1, 0)) + (has_start_time?then(1, 0)) + (has_end_time?then(1, 0)) + (has_background?then(1, 0)))>
  <#if s > bestScore>
    <#local bestScore = s>
    <#local bestName = "user_profile">
  </#if>
  <#-- task_board: [tags, status, primary, avatars, end_time] -->
  <#local s = ((has_tags?then(2, 0)) + (has_status?then(2, 0)) + (has_primary?then(2, 0)) + (has_avatars?then(2, 0)) + (has_end_time?then(2, 0))) - ((has_secondary?then(1, 0)) + (has_tertiary?then(1, 0)) + (has_image?then(1, 0)) + (has_avatar?then(1, 0)) + (has_start_time?then(1, 0)) + (has_background?then(1, 0)))>
  <#if s > bestScore>
    <#local bestScore = s>
    <#local bestName = "task_board">
  </#if>
  <#-- promo_banner: [background, tags, primary, secondary, tertiary] -->
  <#local s = ((has_background?then(2, 0)) + (has_tags?then(2, 0)) + (has_primary?then(2, 0)) + (has_secondary?then(2, 0)) + (has_tertiary?then(2, 0))) - ((has_image?then(1, 0)) + (has_avatar?then(1, 0)) + (has_avatars?then(1, 0)) + (has_status?then(1, 0)) + (has_start_time?then(1, 0)) + (has_end_time?then(1, 0)))>
  <#if s > bestScore>
    <#local bestScore = s>
    <#local bestName = "promo_banner">
  </#if>
  <#-- compact_list: [status, primary, secondary, start_time] -->
  <#local s = ((has_status?then(2, 0)) + (has_primary?then(2, 0)) + (has_secondary?then(2, 0)) + (has_start_time?then(2, 0))) - ((has_tertiary?then(1, 0)) + (has_image?then(1, 0)) + (has_avatar?then(1, 0)) + (has_avatars?then(1, 0)) + (has_tags?then(1, 0)) + (has_end_time?then(1, 0)) + (has_background?then(1, 0)))>
  <#if s > bestScore>
    <#local bestScore = s>
    <#local bestName = "compact_list">
  </#if>
  <#-- split_content: [image, tags, primary, avatars, start_time] -->
  <#local s = ((has_image?then(2, 0)) + (has_tags?then(2, 0)) + (has_primary?then(2, 0)) + (has_avatars?then(2, 0)) + (has_start_time?then(2, 0))) - ((has_secondary?then(1, 0)) + (has_tertiary?then(1, 0)) + (has_avatar?then(1, 0)) + (has_status?then(1, 0)) + (has_end_time?then(1, 0)) + (has_background?then(1, 0)))>
  <#if s > bestScore>
    <#local bestScore = s>
    <#local bestName = "split_content">
  </#if>
  <#-- notification: [status, primary, tertiary] -->
  <#local s = ((has_status?then(2, 0)) + (has_primary?then(2, 0)) + (has_tertiary?then(2, 0))) - ((has_secondary?then(1, 0)) + (has_image?then(1, 0)) + (has_avatar?then(1, 0)) + (has_avatars?then(1, 0)) + (has_tags?then(1, 0)) + (has_start_time?then(1, 0)) + (has_end_time?then(1, 0)) + (has_background?then(1, 0)))>
  <#if s > bestScore>
    <#local bestScore = s>
    <#local bestName = "notification">
  </#if>
  <#-- hero_profile: [background, avatar, primary, secondary] -->
  <#local s = ((has_background?then(2, 0)) + (has_avatar?then(2, 0)) + (has_primary?then(2, 0)) + (has_secondary?then(2, 0))) - ((has_tertiary?then(1, 0)) + (has_image?then(1, 0)) + (has_avatars?then(1, 0)) + (has_tags?then(1, 0)) + (has_status?then(1, 0)) + (has_start_time?then(1, 0)) + (has_end_time?then(1, 0)))>
  <#if s > bestScore>
    <#local bestScore = s>
    <#local bestName = "hero_profile">
  </#if>
  <#-- timeline_node: [start_time, end_time, primary, secondary, tertiary, tags] -->
  <#local s = ((has_start_time?then(2, 0)) + (has_end_time?then(2, 0)) + (has_primary?then(2, 0)) + (has_secondary?then(2, 0)) + (has_tertiary?then(2, 0)) + (has_tags?then(2, 0))) - ((has_image?then(1, 0)) + (has_avatar?then(1, 0)) + (has_avatars?then(1, 0)) + (has_status?then(1, 0)) + (has_background?then(1, 0)))>
  <#if s > bestScore>
    <#local bestScore = s>
    <#local bestName = "timeline_node">
  </#if>
  <#-- message: [avatar, primary, secondary, tertiary, start_time] -->
  <#local s = ((has_avatar?then(2, 0)) + (has_primary?then(2, 0)) + (has_secondary?then(2, 0)) + (has_tertiary?then(2, 0)) + (has_start_time?then(2, 0))) - ((has_image?then(1, 0)) + (has_avatars?then(1, 0)) + (has_tags?then(1, 0)) + (has_status?then(1, 0)) + (has_end_time?then(1, 0)) + (has_background?then(1, 0)))>
  <#if s > bestScore>
    <#local bestScore = s>
    <#local bestName = "message">
  </#if>
  <#-- ticket: [background, primary, status, start_time, end_time] -->
  <#local s = ((has_background?then(2, 0)) + (has_primary?then(2, 0)) + (has_status?then(2, 0)) + (has_start_time?then(2, 0)) + (has_end_time?then(2, 0))) - ((has_secondary?then(1, 0)) + (has_tertiary?then(1, 0)) + (has_image?then(1, 0)) + (has_avatar?then(1, 0)) + (has_avatars?then(1, 0)) + (has_tags?then(1, 0)))>
  <#if s > bestScore>
    <#local bestScore = s>
    <#local bestName = "ticket">
  </#if>
  <#-- dense_detail_list: [image, primary, secondary, tertiary, tags, status] -->
  <#local s = ((has_image?then(2, 0)) + (has_primary?then(2, 0)) + (has_secondary?then(2, 0)) + (has_tertiary?then(2, 0)) + (has_tags?then(2, 0)) + (has_status?then(2, 0))) - ((has_avatar?then(1, 0)) + (has_avatars?then(1, 0)) + (has_start_time?then(1, 0)) + (has_end_time?then(1, 0)) + (has_background?then(1, 0)))>
  <#if s > bestScore>
    <#local bestScore = s>
    <#local bestName = "dense_detail_list">
  </#if>
  <#-- vertical_poster: [image, primary, secondary, start_time, end_time, avatars] -->
  <#local s = ((has_image?then(2, 0)) + (has_primary?then(2, 0)) + (has_secondary?then(2, 0)) + (has_start_time?then(2, 0)) + (has_end_time?then(2, 0)) + (has_avatars?then(2, 0))) - ((has_tertiary?then(1, 0)) + (has_avatar?then(1, 0)) + (has_tags?then(1, 0)) + (has_status?then(1, 0)) + (has_background?then(1, 0)))>
  <#if s > bestScore>
    <#local bestScore = s>
    <#local bestName = "vertical_poster">
  </#if>
  <#-- issue_detail: [tags, status, primary, secondary, tertiary, avatar, end_time] -->
  <#local s = ((has_tags?then(2, 0)) + (has_status?then(2, 0)) + (has_primary?then(2, 0)) + (has_secondary?then(2, 0)) + (has_tertiary?then(2, 0)) + (has_avatar?then(2, 0)) + (has_end_time?then(2, 0))) - ((has_image?then(1, 0)) + (has_avatars?then(1, 0)) + (has_start_time?then(1, 0)) + (has_background?then(1, 0)))>
  <#if s > bestScore>
    <#local bestScore = s>
    <#local bestName = "issue_detail">
  </#if>
  <#-- team_directory: [primary, secondary, avatars, tags] -->
  <#local s = ((has_primary?then(2, 0)) + (has_secondary?then(2, 0)) + (has_avatars?then(2, 0)) + (has_tags?then(2, 0))) - ((has_tertiary?then(1, 0)) + (has_image?then(1, 0)) + (has_avatar?then(1, 0)) + (has_status?then(1, 0)) + (has_start_time?then(1, 0)) + (has_end_time?then(1, 0)) + (has_background?then(1, 0)))>
  <#if s > bestScore>
    <#local bestScore = s>
    <#local bestName = "team_directory">
  </#if>
  <#-- immersive_highlight: [background, status, primary] -->
  <#local s = ((has_background?then(2, 0)) + (has_status?then(2, 0)) + (has_primary?then(2, 0))) - ((has_secondary?then(1, 0)) + (has_tertiary?then(1, 0)) + (has_image?then(1, 0)) + (has_avatar?then(1, 0)) + (has_avatars?then(1, 0)) + (has_tags?then(1, 0)) + (has_start_time?then(1, 0)) + (has_end_time?then(1, 0)))>
  <#if s > bestScore>
    <#local bestScore = s>
    <#local bestName = "immersive_highlight">
  </#if>
  <#-- mini_status: [status, end_time, primary, tags] -->
  <#local s = ((has_status?then(2, 0)) + (has_end_time?then(2, 0)) + (has_primary?then(2, 0)) + (has_tags?then(2, 0))) - ((has_secondary?then(1, 0)) + (has_tertiary?then(1, 0)) + (has_image?then(1, 0)) + (has_avatar?then(1, 0)) + (has_avatars?then(1, 0)) + (has_start_time?then(1, 0)) + (has_background?then(1, 0)))>
  <#if s > bestScore>
    <#local bestScore = s>
    <#local bestName = "mini_status">
  </#if>
  <#-- dual_column_content: [primary, secondary, tertiary, tags, avatar, avatars] -->
  <#local s = ((has_primary?then(2, 0)) + (has_secondary?then(2, 0)) + (has_tertiary?then(2, 0)) + (has_tags?then(2, 0)) + (has_avatar?then(2, 0)) + (has_avatars?then(2, 0))) - ((has_image?then(1, 0)) + (has_status?then(1, 0)) + (has_start_time?then(1, 0)) + (has_end_time?then(1, 0)) + (has_background?then(1, 0)))>
  <#if s > bestScore>
    <#local bestScore = s>
    <#local bestName = "dual_column_content">
  </#if>
  <#-- gallery: [image, primary, avatars, status] -->
  <#local s = ((has_image?then(2, 0)) + (has_primary?then(2, 0)) + (has_avatars?then(2, 0)) + (has_status?then(2, 0))) - ((has_secondary?then(1, 0)) + (has_tertiary?then(1, 0)) + (has_avatar?then(1, 0)) + (has_tags?then(1, 0)) + (has_start_time?then(1, 0)) + (has_end_time?then(1, 0)) + (has_background?then(1, 0)))>
  <#if s > bestScore>
    <#local bestScore = s>
    <#local bestName = "gallery">
  </#if>
  <#-- key_metric: [tags, primary, secondary, status] -->
  <#local s = ((has_tags?then(2, 0)) + (has_primary?then(2, 0)) + (has_secondary?then(2, 0)) + (has_status?then(2, 0))) - ((has_tertiary?then(1, 0)) + (has_image?then(1, 0)) + (has_avatar?then(1, 0)) + (has_avatars?then(1, 0)) + (has_start_time?then(1, 0)) + (has_end_time?then(1, 0)) + (has_background?then(1, 0)))>
  <#if s > bestScore>
    <#local bestScore = s>
    <#local bestName = "key_metric">
  </#if>
  <#-- overlay_avatar: [image, avatar, primary, secondary] -->
  <#local s = ((has_image?then(2, 0)) + (has_avatar?then(2, 0)) + (has_primary?then(2, 0)) + (has_secondary?then(2, 0))) - ((has_tertiary?then(1, 0)) + (has_avatars?then(1, 0)) + (has_tags?then(1, 0)) + (has_status?then(1, 0)) + (has_start_time?then(1, 0)) + (has_end_time?then(1, 0)) + (has_background?then(1, 0)))>
  <#if s > bestScore>
    <#local bestScore = s>
    <#local bestName = "overlay_avatar">
  </#if>
  <#-- audit_log: [avatar, primary, secondary, start_time, status] -->
  <#local s = ((has_avatar?then(2, 0)) + (has_primary?then(2, 0)) + (has_secondary?then(2, 0)) + (has_start_time?then(2, 0)) + (has_status?then(2, 0))) - ((has_tertiary?then(1, 0)) + (has_image?then(1, 0)) + (has_avatars?then(1, 0)) + (has_tags?then(1, 0)) + (has_end_time?then(1, 0)) + (has_background?then(1, 0)))>
  <#if s > bestScore>
    <#local bestScore = s>
    <#local bestName = "audit_log">
  </#if>
  <#-- calendar_cell: [start_time, status, primary, avatars] -->
  <#local s = ((has_start_time?then(2, 0)) + (has_status?then(2, 0)) + (has_primary?then(2, 0)) + (has_avatars?then(2, 0))) - ((has_secondary?then(1, 0)) + (has_tertiary?then(1, 0)) + (has_image?then(1, 0)) + (has_avatar?then(1, 0)) + (has_tags?then(1, 0)) + (has_end_time?then(1, 0)) + (has_background?then(1, 0)))>
  <#if s > bestScore>
    <#local bestScore = s>
    <#local bestName = "calendar_cell">
  </#if>
  <#-- side_status: [status, primary, secondary, start_time] -->
  <#local s = ((has_status?then(2, 0)) + (has_primary?then(2, 0)) + (has_secondary?then(2, 0)) + (has_start_time?then(2, 0))) - ((has_tertiary?then(1, 0)) + (has_image?then(1, 0)) + (has_avatar?then(1, 0)) + (has_avatars?then(1, 0)) + (has_tags?then(1, 0)) + (has_end_time?then(1, 0)) + (has_background?then(1, 0)))>
  <#if s > bestScore>
    <#local bestScore = s>
    <#local bestName = "side_status">
  </#if>
  <#-- multi_tag: [tags, primary, secondary, end_time] -->
  <#local s = ((has_tags?then(2, 0)) + (has_primary?then(2, 0)) + (has_secondary?then(2, 0)) + (has_end_time?then(2, 0))) - ((has_tertiary?then(1, 0)) + (has_image?then(1, 0)) + (has_avatar?then(1, 0)) + (has_avatars?then(1, 0)) + (has_status?then(1, 0)) + (has_start_time?then(1, 0)) + (has_background?then(1, 0)))>
  <#if s > bestScore>
    <#local bestScore = s>
    <#local bestName = "multi_tag">
  </#if>
  <#-- shift_planner: [start_time, end_time, status, primary, avatars] -->
  <#local s = ((has_start_time?then(2, 0)) + (has_end_time?then(2, 0)) + (has_status?then(2, 0)) + (has_primary?then(2, 0)) + (has_avatars?then(2, 0))) - ((has_secondary?then(1, 0)) + (has_tertiary?then(1, 0)) + (has_image?then(1, 0)) + (has_avatar?then(1, 0)) + (has_tags?then(1, 0)) + (has_background?then(1, 0)))>
  <#if s > bestScore>
    <#local bestScore = s>
    <#local bestName = "shift_planner">
  </#if>
  <#-- social_post_feed: [avatar, primary, start_time, tertiary, image, avatars, tags] -->
  <#local s = ((has_avatar?then(2, 0)) + (has_primary?then(2, 0)) + (has_start_time?then(2, 0)) + (has_tertiary?then(2, 0)) + (has_image?then(2, 0)) + (has_avatars?then(2, 0)) + (has_tags?then(2, 0))) - ((has_secondary?then(1, 0)) + (has_status?then(1, 0)) + (has_end_time?then(1, 0)) + (has_background?then(1, 0)))>
  <#if s > bestScore>
    <#local bestScore = s>
    <#local bestName = "social_post_feed">
  </#if>
  <#-- product: [image, tags, primary, secondary, status, end_time] -->
  <#local s = ((has_image?then(2, 0)) + (has_tags?then(2, 0)) + (has_primary?then(2, 0)) + (has_secondary?then(2, 0)) + (has_status?then(2, 0)) + (has_end_time?then(2, 0))) - ((has_tertiary?then(1, 0)) + (has_avatar?then(1, 0)) + (has_avatars?then(1, 0)) + (has_start_time?then(1, 0)) + (has_background?then(1, 0)))>
  <#if s > bestScore>
    <#local bestScore = s>
    <#local bestName = "product">
  </#if>
  <#-- dual_profile_comparison: [avatar, status, primary, secondary, start_time, end_time] -->
  <#local s = ((has_avatar?then(2, 0)) + (has_status?then(2, 0)) + (has_primary?then(2, 0)) + (has_secondary?then(2, 0)) + (has_start_time?then(2, 0)) + (has_end_time?then(2, 0))) - ((has_tertiary?then(1, 0)) + (has_image?then(1, 0)) + (has_avatars?then(1, 0)) + (has_tags?then(1, 0)) + (has_background?then(1, 0)))>
  <#if s > bestScore>
    <#local bestScore = s>
    <#local bestName = "dual_profile_comparison">
  </#if>
  <#-- left_feature_image: [image, tags, primary, secondary, tertiary, status, avatars] -->
  <#local s = ((has_image?then(2, 0)) + (has_tags?then(2, 0)) + (has_primary?then(2, 0)) + (has_secondary?then(2, 0)) + (has_tertiary?then(2, 0)) + (has_status?then(2, 0)) + (has_avatars?then(2, 0))) - ((has_avatar?then(1, 0)) + (has_start_time?then(1, 0)) + (has_end_time?then(1, 0)) + (has_background?then(1, 0)))>
  <#if s > bestScore>
    <#local bestScore = s>
    <#local bestName = "left_feature_image">
  </#if>
  <#-- workflow_strip: [start_time, avatars, status, end_time, primary] -->
  <#local s = ((has_start_time?then(2, 0)) + (has_avatars?then(2, 0)) + (has_status?then(2, 0)) + (has_end_time?then(2, 0)) + (has_primary?then(2, 0))) - ((has_secondary?then(1, 0)) + (has_tertiary?then(1, 0)) + (has_image?then(1, 0)) + (has_avatar?then(1, 0)) + (has_tags?then(1, 0)) + (has_background?then(1, 0)))>
  <#if s > bestScore>
    <#local bestScore = s>
    <#local bestName = "workflow_strip">
  </#if>
  <#-- text_over_background: [background, tags, primary, avatar, secondary] -->
  <#local s = ((has_background?then(2, 0)) + (has_tags?then(2, 0)) + (has_primary?then(2, 0)) + (has_avatar?then(2, 0)) + (has_secondary?then(2, 0))) - ((has_tertiary?then(1, 0)) + (has_image?then(1, 0)) + (has_avatars?then(1, 0)) + (has_status?then(1, 0)) + (has_start_time?then(1, 0)) + (has_end_time?then(1, 0)))>
  <#if s > bestScore>
    <#local bestScore = s>
    <#local bestName = "text_over_background">
  </#if>
  <#-- micro_badge: [avatar, primary, status] -->
  <#local s = ((has_avatar?then(2, 0)) + (has_primary?then(2, 0)) + (has_status?then(2, 0))) - ((has_secondary?then(1, 0)) + (has_tertiary?then(1, 0)) + (has_image?then(1, 0)) + (has_avatars?then(1, 0)) + (has_tags?then(1, 0)) + (has_start_time?then(1, 0)) + (has_end_time?then(1, 0)) + (has_background?then(1, 0)))>
  <#if s > bestScore>
    <#local bestScore = s>
    <#local bestName = "micro_badge">
  </#if>
  <#-- stepped_process: [status, primary, secondary, start_time, end_time] -->
  <#local s = ((has_status?then(2, 0)) + (has_primary?then(2, 0)) + (has_secondary?then(2, 0)) + (has_start_time?then(2, 0)) + (has_end_time?then(2, 0))) - ((has_tertiary?then(1, 0)) + (has_image?then(1, 0)) + (has_avatar?then(1, 0)) + (has_avatars?then(1, 0)) + (has_tags?then(1, 0)) + (has_background?then(1, 0)))>
  <#if s > bestScore>
    <#local bestScore = s>
    <#local bestName = "stepped_process">
  </#if>
  <#-- stacked_overlay: [image, primary, secondary, status] -->
  <#local s = ((has_image?then(2, 0)) + (has_primary?then(2, 0)) + (has_secondary?then(2, 0)) + (has_status?then(2, 0))) - ((has_tertiary?then(1, 0)) + (has_avatar?then(1, 0)) + (has_avatars?then(1, 0)) + (has_tags?then(1, 0)) + (has_start_time?then(1, 0)) + (has_end_time?then(1, 0)) + (has_background?then(1, 0)))>
  <#if s > bestScore>
    <#local bestScore = s>
    <#local bestName = "stacked_overlay">
  </#if>
  <#-- group_hub: [avatars, primary, tertiary, tags, status] -->
  <#local s = ((has_avatars?then(2, 0)) + (has_primary?then(2, 0)) + (has_tertiary?then(2, 0)) + (has_tags?then(2, 0)) + (has_status?then(2, 0))) - ((has_secondary?then(1, 0)) + (has_image?then(1, 0)) + (has_avatar?then(1, 0)) + (has_start_time?then(1, 0)) + (has_end_time?then(1, 0)) + (has_background?then(1, 0)))>
  <#if s > bestScore>
    <#local bestScore = s>
    <#local bestName = "group_hub">
  </#if>
  <#-- tall_sidebar: [status, image, primary, secondary, tags, avatars] -->
  <#local s = ((has_status?then(2, 0)) + (has_image?then(2, 0)) + (has_primary?then(2, 0)) + (has_secondary?then(2, 0)) + (has_tags?then(2, 0)) + (has_avatars?then(2, 0))) - ((has_tertiary?then(1, 0)) + (has_avatar?then(1, 0)) + (has_start_time?then(1, 0)) + (has_end_time?then(1, 0)) + (has_background?then(1, 0)))>
  <#if s > bestScore>
    <#local bestScore = s>
    <#local bestName = "tall_sidebar">
  </#if>
  <#-- justified_meta: [primary, secondary, start_time, end_time, avatar, status] -->
  <#local s = ((has_primary?then(2, 0)) + (has_secondary?then(2, 0)) + (has_start_time?then(2, 0)) + (has_end_time?then(2, 0)) + (has_avatar?then(2, 0)) + (has_status?then(2, 0))) - ((has_tertiary?then(1, 0)) + (has_image?then(1, 0)) + (has_avatars?then(1, 0)) + (has_tags?then(1, 0)) + (has_background?then(1, 0)))>
  <#if s > bestScore>
    <#local bestScore = s>
    <#local bestName = "justified_meta">
  </#if>
  <#-- multidimensional_board: [status, start_time, primary, tertiary, secondary, tags, avatars] -->
  <#local s = ((has_status?then(2, 0)) + (has_start_time?then(2, 0)) + (has_primary?then(2, 0)) + (has_tertiary?then(2, 0)) + (has_secondary?then(2, 0)) + (has_tags?then(2, 0)) + (has_avatars?then(2, 0))) - ((has_image?then(1, 0)) + (has_avatar?then(1, 0)) + (has_end_time?then(1, 0)) + (has_background?then(1, 0)))>
  <#if s > bestScore>
    <#local bestScore = s>
    <#local bestName = "multidimensional_board">
  </#if>
  <#-- media_player: [image, primary, secondary, start_time, end_time, avatar, status] -->
  <#local s = ((has_image?then(2, 0)) + (has_primary?then(2, 0)) + (has_secondary?then(2, 0)) + (has_start_time?then(2, 0)) + (has_end_time?then(2, 0)) + (has_avatar?then(2, 0)) + (has_status?then(2, 0))) - ((has_tertiary?then(1, 0)) + (has_avatars?then(1, 0)) + (has_tags?then(1, 0)) + (has_background?then(1, 0)))>
  <#if s > bestScore>
    <#local bestScore = s>
    <#local bestName = "media_player">
  </#if>
  <#-- left_anchor_time: [start_time, status, primary, secondary, avatar] -->
  <#local s = ((has_start_time?then(2, 0)) + (has_status?then(2, 0)) + (has_primary?then(2, 0)) + (has_secondary?then(2, 0)) + (has_avatar?then(2, 0))) - ((has_tertiary?then(1, 0)) + (has_image?then(1, 0)) + (has_avatars?then(1, 0)) + (has_tags?then(1, 0)) + (has_end_time?then(1, 0)) + (has_background?then(1, 0)))>
  <#if s > bestScore>
    <#local bestScore = s>
    <#local bestName = "left_anchor_time">
  </#if>
  <#-- duration_span: [start_time, end_time, status, primary, avatars] -->
  <#local s = ((has_start_time?then(2, 0)) + (has_end_time?then(2, 0)) + (has_status?then(2, 0)) + (has_primary?then(2, 0)) + (has_avatars?then(2, 0))) - ((has_secondary?then(1, 0)) + (has_tertiary?then(1, 0)) + (has_image?then(1, 0)) + (has_avatar?then(1, 0)) + (has_tags?then(1, 0)) + (has_background?then(1, 0)))>
  <#if s > bestScore>
    <#local bestScore = s>
    <#local bestName = "duration_span">
  </#if>
  <#-- media_history: [start_time, image, primary, secondary, tags] -->
  <#local s = ((has_start_time?then(2, 0)) + (has_image?then(2, 0)) + (has_primary?then(2, 0)) + (has_secondary?then(2, 0)) + (has_tags?then(2, 0))) - ((has_tertiary?then(1, 0)) + (has_avatar?then(1, 0)) + (has_avatars?then(1, 0)) + (has_status?then(1, 0)) + (has_end_time?then(1, 0)) + (has_background?then(1, 0)))>
  <#if s > bestScore>
    <#local bestScore = s>
    <#local bestName = "media_history">
  </#if>
  <#-- status_transition: [start_time, status, primary, avatar, secondary] -->
  <#local s = ((has_start_time?then(2, 0)) + (has_status?then(2, 0)) + (has_primary?then(2, 0)) + (has_avatar?then(2, 0)) + (has_secondary?then(2, 0))) - ((has_tertiary?then(1, 0)) + (has_image?then(1, 0)) + (has_avatars?then(1, 0)) + (has_tags?then(1, 0)) + (has_end_time?then(1, 0)) + (has_background?then(1, 0)))>
  <#if s > bestScore>
    <#local bestScore = s>
    <#local bestName = "status_transition">
  </#if>
  <#-- compact_time: [start_time, status, primary, tags] -->
  <#local s = ((has_start_time?then(2, 0)) + (has_status?then(2, 0)) + (has_primary?then(2, 0)) + (has_tags?then(2, 0))) - ((has_secondary?then(1, 0)) + (has_tertiary?then(1, 0)) + (has_image?then(1, 0)) + (has_avatar?then(1, 0)) + (has_avatars?then(1, 0)) + (has_end_time?then(1, 0)) + (has_background?then(1, 0)))>
  <#if s > bestScore>
    <#local bestScore = s>
    <#local bestName = "compact_time">
  </#if>
  <#-- horizontal_flow: [start_time, primary, status] -->
  <#local s = ((has_start_time?then(2, 0)) + (has_primary?then(2, 0)) + (has_status?then(2, 0))) - ((has_secondary?then(1, 0)) + (has_tertiary?then(1, 0)) + (has_image?then(1, 0)) + (has_avatar?then(1, 0)) + (has_avatars?then(1, 0)) + (has_tags?then(1, 0)) + (has_end_time?then(1, 0)) + (has_background?then(1, 0)))>
  <#if s > bestScore>
    <#local bestScore = s>
    <#local bestName = "horizontal_flow">
  </#if>
  <#-- right_biased_node: [start_time, primary, tags] -->
  <#local s = ((has_start_time?then(2, 0)) + (has_primary?then(2, 0)) + (has_tags?then(2, 0))) - ((has_secondary?then(1, 0)) + (has_tertiary?then(1, 0)) + (has_image?then(1, 0)) + (has_avatar?then(1, 0)) + (has_avatars?then(1, 0)) + (has_status?then(1, 0)) + (has_end_time?then(1, 0)) + (has_background?then(1, 0)))>
  <#if s > bestScore>
    <#local bestScore = s>
    <#local bestName = "right_biased_node">
  </#if>
  <#-- left_biased_node: [start_time, primary, tags] -->
  <#local s = ((has_start_time?then(2, 0)) + (has_primary?then(2, 0)) + (has_tags?then(2, 0))) - ((has_secondary?then(1, 0)) + (has_tertiary?then(1, 0)) + (has_image?then(1, 0)) + (has_avatar?then(1, 0)) + (has_avatars?then(1, 0)) + (has_status?then(1, 0)) + (has_end_time?then(1, 0)) + (has_background?then(1, 0)))>
  <#if s > bestScore>
    <#local bestScore = s>
    <#local bestName = "left_biased_node">
  </#if>
  <#-- internal_chronology: [start_time, primary, end_time, secondary, status] -->
  <#local s = ((has_start_time?then(2, 0)) + (has_primary?then(2, 0)) + (has_end_time?then(2, 0)) + (has_secondary?then(2, 0)) + (has_status?then(2, 0))) - ((has_tertiary?then(1, 0)) + (has_image?then(1, 0)) + (has_avatar?then(1, 0)) + (has_avatars?then(1, 0)) + (has_tags?then(1, 0)) + (has_background?then(1, 0)))>
  <#if s > bestScore>
    <#local bestScore = s>
    <#local bestName = "internal_chronology">
  </#if>
  <#-- three_stage_segment: [start_time, tags, end_time, primary, secondary, status] -->
  <#local s = ((has_start_time?then(2, 0)) + (has_tags?then(2, 0)) + (has_end_time?then(2, 0)) + (has_primary?then(2, 0)) + (has_secondary?then(2, 0)) + (has_status?then(2, 0))) - ((has_tertiary?then(1, 0)) + (has_image?then(1, 0)) + (has_avatar?then(1, 0)) + (has_avatars?then(1, 0)) + (has_background?then(1, 0)))>
  <#if s > bestScore>
    <#local bestScore = s>
    <#local bestName = "three_stage_segment">
  </#if>
  <#-- horizontal_log: [avatar, start_time, primary, status] -->
  <#local s = ((has_avatar?then(2, 0)) + (has_start_time?then(2, 0)) + (has_primary?then(2, 0)) + (has_status?then(2, 0))) - ((has_secondary?then(1, 0)) + (has_tertiary?then(1, 0)) + (has_image?then(1, 0)) + (has_avatars?then(1, 0)) + (has_tags?then(1, 0)) + (has_end_time?then(1, 0)) + (has_background?then(1, 0)))>
  <#if s > bestScore>
    <#local bestScore = s>
    <#local bestName = "horizontal_log">
  </#if>
  <#-- bulletin: [tags, primary, tertiary, avatars, start_time] -->
  <#local s = ((has_tags?then(2, 0)) + (has_primary?then(2, 0)) + (has_tertiary?then(2, 0)) + (has_avatars?then(2, 0)) + (has_start_time?then(2, 0))) - ((has_secondary?then(1, 0)) + (has_image?then(1, 0)) + (has_avatar?then(1, 0)) + (has_status?then(1, 0)) + (has_end_time?then(1, 0)) + (has_background?then(1, 0)))>
  <#if s > bestScore>
    <#local bestScore = s>
    <#local bestName = "bulletin">
  </#if>
  <#-- timestamp_stamp: [background, start_time, primary, status] -->
  <#local s = ((has_background?then(2, 0)) + (has_start_time?then(2, 0)) + (has_primary?then(2, 0)) + (has_status?then(2, 0))) - ((has_secondary?then(1, 0)) + (has_tertiary?then(1, 0)) + (has_image?then(1, 0)) + (has_avatar?then(1, 0)) + (has_avatars?then(1, 0)) + (has_tags?then(1, 0)) + (has_end_time?then(1, 0)))>
  <#if s > bestScore>
    <#local bestScore = s>
    <#local bestName = "timestamp_stamp">
  </#if>
  <#-- compact_chat: [avatar, primary, secondary, start_time] -->
  <#local s = ((has_avatar?then(2, 0)) + (has_primary?then(2, 0)) + (has_secondary?then(2, 0)) + (has_start_time?then(2, 0))) - ((has_tertiary?then(1, 0)) + (has_image?then(1, 0)) + (has_avatars?then(1, 0)) + (has_tags?then(1, 0)) + (has_status?then(1, 0)) + (has_end_time?then(1, 0)) + (has_background?then(1, 0)))>
  <#if s > bestScore>
    <#local bestScore = s>
    <#local bestName = "compact_chat">
  </#if>
  <#-- side_image_time_capsule: [start_time, primary, secondary, image, status] -->
  <#local s = ((has_start_time?then(2, 0)) + (has_primary?then(2, 0)) + (has_secondary?then(2, 0)) + (has_image?then(2, 0)) + (has_status?then(2, 0))) - ((has_tertiary?then(1, 0)) + (has_avatar?then(1, 0)) + (has_avatars?then(1, 0)) + (has_tags?then(1, 0)) + (has_end_time?then(1, 0)) + (has_background?then(1, 0)))>
  <#if s > bestScore>
    <#local bestScore = s>
    <#local bestName = "side_image_time_capsule">
  </#if>
  <#-- multi_tag_end_node: [tags, end_time, primary, avatars, status] -->
  <#local s = ((has_tags?then(2, 0)) + (has_end_time?then(2, 0)) + (has_primary?then(2, 0)) + (has_avatars?then(2, 0)) + (has_status?then(2, 0))) - ((has_secondary?then(1, 0)) + (has_tertiary?then(1, 0)) + (has_image?then(1, 0)) + (has_avatar?then(1, 0)) + (has_start_time?then(1, 0)) + (has_background?then(1, 0)))>
  <#if s > bestScore>
    <#local bestScore = s>
    <#local bestName = "multi_tag_end_node">
  </#if>
  <#return bestName>
</#function>

<#macro print_tile_layout widget indent=0>
  <#local tile = widget.value("tile")!guess_tile(widget)>
  <#if tile == "meeting_event">
<@print_tile_meeting_event widget=widget indent=indent />
  <#elseif tile == "media_article">
<@print_tile_media_article widget=widget indent=indent />
  <#elseif tile == "user_profile">
<@print_tile_user_profile widget=widget indent=indent />
  <#elseif tile == "task_board">
<@print_tile_task_board widget=widget indent=indent />
  <#elseif tile == "promo_banner">
<@print_tile_promo_banner widget=widget indent=indent />
  <#elseif tile == "compact_list">
<@print_tile_compact_list widget=widget indent=indent />
  <#elseif tile == "split_content">
<@print_tile_split_content widget=widget indent=indent />
  <#elseif tile == "notification">
<@print_tile_notification widget=widget indent=indent />
  <#elseif tile == "hero_profile">
<@print_tile_hero_profile widget=widget indent=indent />
  <#elseif tile == "timeline_node">
<@print_tile_timeline_node widget=widget indent=indent />
  <#elseif tile == "message">
<@print_tile_message widget=widget indent=indent />
  <#elseif tile == "ticket">
<@print_tile_ticket widget=widget indent=indent />
  <#elseif tile == "dense_detail_list">
<@print_tile_dense_detail_list widget=widget indent=indent />
  <#elseif tile == "vertical_poster">
<@print_tile_vertical_poster widget=widget indent=indent />
  <#elseif tile == "issue_detail">
<@print_tile_issue_detail widget=widget indent=indent />
  <#elseif tile == "team_directory">
<@print_tile_team_directory widget=widget indent=indent />
  <#elseif tile == "immersive_highlight">
<@print_tile_immersive_highlight widget=widget indent=indent />
  <#elseif tile == "mini_status">
<@print_tile_mini_status widget=widget indent=indent />
  <#elseif tile == "dual_column_content">
<@print_tile_dual_column_content widget=widget indent=indent />
  <#elseif tile == "gallery">
<@print_tile_gallery widget=widget indent=indent />
  <#elseif tile == "key_metric">
<@print_tile_key_metric widget=widget indent=indent />
  <#elseif tile == "overlay_avatar">
<@print_tile_overlay_avatar widget=widget indent=indent />
  <#elseif tile == "audit_log">
<@print_tile_audit_log widget=widget indent=indent />
  <#elseif tile == "calendar_cell">
<@print_tile_calendar_cell widget=widget indent=indent />
  <#elseif tile == "side_status">
<@print_tile_side_status widget=widget indent=indent />
  <#elseif tile == "multi_tag">
<@print_tile_multi_tag widget=widget indent=indent />
  <#elseif tile == "shift_planner">
<@print_tile_shift_planner widget=widget indent=indent />
  <#elseif tile == "social_post_feed">
<@print_tile_social_post_feed widget=widget indent=indent />
  <#elseif tile == "product">
<@print_tile_product widget=widget indent=indent />
  <#elseif tile == "dual_profile_comparison">
<@print_tile_dual_profile_comparison widget=widget indent=indent />
  <#elseif tile == "left_feature_image">
<@print_tile_left_feature_image widget=widget indent=indent />
  <#elseif tile == "workflow_strip">
<@print_tile_workflow_strip widget=widget indent=indent />
  <#elseif tile == "text_over_background">
<@print_tile_text_over_background widget=widget indent=indent />
  <#elseif tile == "micro_badge">
<@print_tile_micro_badge widget=widget indent=indent />
  <#elseif tile == "stepped_process">
<@print_tile_stepped_process widget=widget indent=indent />
  <#elseif tile == "stacked_overlay">
<@print_tile_stacked_overlay widget=widget indent=indent />
  <#elseif tile == "group_hub">
<@print_tile_group_hub widget=widget indent=indent />
  <#elseif tile == "tall_sidebar">
<@print_tile_tall_sidebar widget=widget indent=indent />
  <#elseif tile == "justified_meta">
<@print_tile_justified_meta widget=widget indent=indent />
  <#elseif tile == "multidimensional_board">
<@print_tile_multidimensional_board widget=widget indent=indent />
  <#elseif tile == "media_player">
<@print_tile_media_player widget=widget indent=indent />
  <#elseif tile == "left_anchor_time">
<@print_tile_left_anchor_time widget=widget indent=indent />
  <#elseif tile == "duration_span">
<@print_tile_duration_span widget=widget indent=indent />
  <#elseif tile == "media_history">
<@print_tile_media_history widget=widget indent=indent />
  <#elseif tile == "status_transition">
<@print_tile_status_transition widget=widget indent=indent />
  <#elseif tile == "compact_time">
<@print_tile_compact_time widget=widget indent=indent />
  <#elseif tile == "horizontal_flow">
<@print_tile_horizontal_flow widget=widget indent=indent />
  <#elseif tile == "right_biased_node">
<@print_tile_right_biased_node widget=widget indent=indent />
  <#elseif tile == "left_biased_node">
<@print_tile_left_biased_node widget=widget indent=indent />
  <#elseif tile == "internal_chronology">
<@print_tile_internal_chronology widget=widget indent=indent />
  <#elseif tile == "three_stage_segment">
<@print_tile_three_stage_segment widget=widget indent=indent />
  <#elseif tile == "horizontal_log">
<@print_tile_horizontal_log widget=widget indent=indent />
  <#elseif tile == "bulletin">
<@print_tile_bulletin widget=widget indent=indent />
  <#elseif tile == "timestamp_stamp">
<@print_tile_timestamp_stamp widget=widget indent=indent />
  <#elseif tile == "compact_chat">
<@print_tile_compact_chat widget=widget indent=indent />
  <#elseif tile == "side_image_time_capsule">
<@print_tile_side_image_time_capsule widget=widget indent=indent />
  <#elseif tile == "multi_tag_end_node">
<@print_tile_multi_tag_end_node widget=widget indent=indent />
  </#if>
</#macro>

<#--
会议与日程 (Meeting & Event)
+-----------------------------------------------+
| [start time] - [end time]            [status] |
|                                               |
| [primary]                                     |
| [secondary]                                   |
|                                               |
| [avatars]                                     |
+-----------------------------------------------+
-->
<#macro print_tile_meeting_event widget indent=0>
${""?left_pad(indent)}<div class="tile tile-meeting-event">
${""?left_pad(indent)}  <div class="tile-row tile-header">
  <#if guidbase.has_child_widget(widget, "start_time") || guidbase.has_child_widget(widget, "end_time")>
${""?left_pad(indent)}    <span class="tile-time">
    <#if guidbase.has_child_widget(widget, "start_time")>${""?left_pad(indent)}<span>{{ ${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "start_time"))} }}</span></#if>
    <#if guidbase.has_child_widget(widget, "start_time") && guidbase.has_child_widget(widget, "end_time")>${""?left_pad(indent)}<span class="tile-time-sep"> - </span></#if>
    <#if guidbase.has_child_widget(widget, "end_time")>${""?left_pad(indent)}<span>{{ ${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "end_time"))} }}</span></#if>
${""?left_pad(indent)}    </span>
  </#if>
  <#if guidbase.has_child_widget(widget, "status")>
${""?left_pad(indent)}    <span class="tile-status">{{ ${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))} }}</span>
  </#if>
${""?left_pad(indent)}  </div>
  <#if guidbase.has_child_widget(widget, "primary") || guidbase.has_child_widget(widget, "secondary")>
${""?left_pad(indent)}  <div class="tile-body">
    <#if guidbase.has_child_widget(widget, "primary")>
${""?left_pad(indent)}    <div class="tile-primary">{{ ${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))} }}</div>
    </#if>
    <#if guidbase.has_child_widget(widget, "secondary")>
${""?left_pad(indent)}    <div class="tile-secondary">{{ ${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "secondary"))} }}</div>
    </#if>
${""?left_pad(indent)}  </div>
  </#if>
  <#if guidbase.has_child_widget(widget, "avatars")>
${""?left_pad(indent)}  <div class="tile-footer">
${""?left_pad(indent)}    <div class="tile-avatars"><img v-for="(av, idx) in ${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "avatars"))}" :key="idx" :src="av" class="tile-avatar-img" /></div>
${""?left_pad(indent)}  </div>
  </#if>
${""?left_pad(indent)}</div>
</#macro>

<#--
媒体与资讯 (Media & Article)
+-----------------------------------------------+
| +-------------------------------------------+ |
| |                                           | |
| |                 [image]                   | |
| |                                           | |
| |  [tags]                                   | |
| +-------------------------------------------+ |
|                                               |
| [primary]                                     |
| [secondary]                                   |
| [tertiary]                                    |
+-----------------------------------------------+
-->
<#macro print_tile_media_article widget indent=0>
${""?left_pad(indent)}<div class="tile tile-media-article">
  <#if guidbase.has_child_widget(widget, "image")>
${""?left_pad(indent)}  <div class="tile-image-wrap">
${""?left_pad(indent)}    <div class="tile-image">
${""?left_pad(indent)}      <img :src="${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "image"))}" alt="" />
${""?left_pad(indent)}    </div>
    <#if guidbase.has_child_widget(widget, "tags")>
${""?left_pad(indent)}    <div class="tile-image-tags">
${""?left_pad(indent)}      <span><span v-for="(tag, idx) in ${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "tags"))}" :key="idx" class="tile-tag">{{ tag }}</span></span>
${""?left_pad(indent)}    </div>
    </#if>
${""?left_pad(indent)}  </div>
  </#if>
  <#if guidbase.has_child_widget(widget, "primary") || guidbase.has_child_widget(widget, "secondary") || guidbase.has_child_widget(widget, "tertiary")>
${""?left_pad(indent)}  <div class="tile-body">
    <#if guidbase.has_child_widget(widget, "primary")>
${""?left_pad(indent)}    <div class="tile-primary">{{ ${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))} }}</div>
    </#if>
    <#if guidbase.has_child_widget(widget, "secondary")>
${""?left_pad(indent)}    <div class="tile-secondary">{{ ${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "secondary"))} }}</div>
    </#if>
    <#if guidbase.has_child_widget(widget, "tertiary")>
${""?left_pad(indent)}    <div class="tile-tertiary">{{ ${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "tertiary"))} }}</div>
    </#if>
${""?left_pad(indent)}  </div>
  </#if>
${""?left_pad(indent)}</div>
</#macro>

<#--
个人资料 (User Profile)
+-----------------------------------------------+
|  +----------+                                 |
|  |          |   [primary]                     |
|  | [avatar] |   [secondary]                   |
|  |          |                                 |
|  +----------+                      [status]   |
+-----------------------------------------------+
-->
<#macro print_tile_user_profile widget indent=0>
${""?left_pad(indent)}<div class="tile tile-user-profile">
${""?left_pad(indent)}  <div class="tile-row">
  <#if guidbase.has_child_widget(widget, "avatar")>
${""?left_pad(indent)}    <div class="tile-avatar">
${""?left_pad(indent)}      <img :src="${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "avatar"))}" alt="" />
${""?left_pad(indent)}    </div>
  </#if>
${""?left_pad(indent)}    <div class="tile-body">
    <#if guidbase.has_child_widget(widget, "primary")>
${""?left_pad(indent)}      <div class="tile-primary">{{ ${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))} }}</div>
    </#if>
    <#if guidbase.has_child_widget(widget, "secondary")>
${""?left_pad(indent)}      <div class="tile-secondary">{{ ${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "secondary"))} }}</div>
    </#if>
${""?left_pad(indent)}    </div>
  <#if guidbase.has_child_widget(widget, "status")>
${""?left_pad(indent)}    <span class="tile-status">{{ ${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))} }}</span>
  </#if>
${""?left_pad(indent)}  </div>
${""?left_pad(indent)}</div>
</#macro>

<#--
任务看板 (Task Board)
+-----------------------------------------------+
| [tags]                               [status] |
|                                               |
| [primary]                                     |
|                                               |
| [avatars]                          [end time] |
+-----------------------------------------------+
-->
<#macro print_tile_task_board widget indent=0>
${""?left_pad(indent)}<div class="tile tile-task-board">
${""?left_pad(indent)}  <div class="tile-row tile-header">
  <#if guidbase.has_child_widget(widget, "tags")>
${""?left_pad(indent)}    <span class="tile-tags"><span v-for="(tag, idx) in ${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "tags"))}" :key="idx" class="tile-tag">{{ tag }}</span></span>
  </#if>
  <#if guidbase.has_child_widget(widget, "status")>
${""?left_pad(indent)}    <span class="tile-status">{{ ${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))} }}</span>
  </#if>
${""?left_pad(indent)}  </div>
  <#if guidbase.has_child_widget(widget, "primary")>
${""?left_pad(indent)}  <div class="tile-body">
${""?left_pad(indent)}    <div class="tile-primary">{{ ${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))} }}</div>
${""?left_pad(indent)}  </div>
  </#if>
${""?left_pad(indent)}  <div class="tile-row tile-footer">
  <#if guidbase.has_child_widget(widget, "avatars")>
${""?left_pad(indent)}    <div class="tile-avatars"><img v-for="(av, idx) in ${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "avatars"))}" :key="idx" :src="av" class="tile-avatar-img" /></div>
  </#if>
  <#if guidbase.has_child_widget(widget, "end_time")>
${""?left_pad(indent)}    <span class="tile-end-time">{{ ${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "end_time"))} }}</span>
  </#if>
${""?left_pad(indent)}  </div>
${""?left_pad(indent)}</div>
</#macro>

<#--
推广横幅 (Promo Banner)
+===============================================+
|                 [background]                  |
|                                               |
|  [tags]                                       |
|                                               |
|  [primary]                                    |
|  [secondary]                                  |
|  [tertiary]                                   |
+===============================================+
-->
<#macro print_tile_promo_banner widget indent=0>
${""?left_pad(indent)}<div class="tile tile-promo-banner">
  <#if guidbase.has_child_widget(widget, "background")>
${""?left_pad(indent)}  <div class="tile-background">
${""?left_pad(indent)}    <img :src="${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "background"))}" alt="" />
${""?left_pad(indent)}  </div>
  </#if>
${""?left_pad(indent)}  <div class="tile-overlay">
  <#if guidbase.has_child_widget(widget, "tags")>
${""?left_pad(indent)}    <div class="tile-tags"><span v-for="(tag, idx) in ${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "tags"))}" :key="idx" class="tile-tag">{{ tag }}</span></div>
  </#if>
  <#if guidbase.has_child_widget(widget, "primary")>
${""?left_pad(indent)}    <div class="tile-primary">{{ ${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))} }}</div>
  </#if>
  <#if guidbase.has_child_widget(widget, "secondary")>
${""?left_pad(indent)}    <div class="tile-secondary">{{ ${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "secondary"))} }}</div>
  </#if>
  <#if guidbase.has_child_widget(widget, "tertiary")>
${""?left_pad(indent)}    <div class="tile-tertiary">{{ ${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "tertiary"))} }}</div>
  </#if>
${""?left_pad(indent)}  </div>
${""?left_pad(indent)}</div>
</#macro>

<#--
紧凑列表 (Compact List)
+-----------------------------------------------+
| [status]  [primary]  [secondary]  [start time]|
+-----------------------------------------------+
-->
<#macro print_tile_compact_list widget indent=0>
${""?left_pad(indent)}<div class="tile tile-compact-list">
${""?left_pad(indent)}  <div class="tile-row tile-inline">
  <#if guidbase.has_child_widget(widget, "status")>
${""?left_pad(indent)}    <span class="tile-status">{{ ${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))} }}</span>
  </#if>
  <#if guidbase.has_child_widget(widget, "primary")>
${""?left_pad(indent)}    <span class="tile-primary">{{ ${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))} }}</span>
  </#if>
  <#if guidbase.has_child_widget(widget, "secondary")>
${""?left_pad(indent)}    <span class="tile-secondary">{{ ${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "secondary"))} }}</span>
  </#if>
  <#if guidbase.has_child_widget(widget, "start_time")>
${""?left_pad(indent)}    <span class="tile-start-time">{{ ${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "start_time"))} }}</span>
  </#if>
${""?left_pad(indent)}  </div>
${""?left_pad(indent)}</div>
</#macro>

<#--
图文卡片 (Split Content)
+-----------------------------------------------+
| +------------+  [tags]                        |
| |            |  [primary]                     |
| |  [image]   |  [avatars]                     |
| |            |                                |
| +------------+  [start time]                  |
+-----------------------------------------------+
-->
<#macro print_tile_split_content widget indent=0>
${""?left_pad(indent)}<div class="tile tile-split-content">
${""?left_pad(indent)}  <div class="tile-row">
  <#if guidbase.has_child_widget(widget, "image")>
${""?left_pad(indent)}    <div class="tile-image">
${""?left_pad(indent)}      <img :src="${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "image"))}" alt="" />
${""?left_pad(indent)}    </div>
  </#if>
${""?left_pad(indent)}    <div class="tile-body">
    <#if guidbase.has_child_widget(widget, "tags")>
${""?left_pad(indent)}      <div class="tile-tags"><span v-for="(tag, idx) in ${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "tags"))}" :key="idx" class="tile-tag">{{ tag }}</span></div>
    </#if>
    <#if guidbase.has_child_widget(widget, "primary")>
${""?left_pad(indent)}      <div class="tile-primary">{{ ${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))} }}</div>
    </#if>
    <#if guidbase.has_child_widget(widget, "avatars")>
${""?left_pad(indent)}      <div class="tile-avatars"><img v-for="(av, idx) in ${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "avatars"))}" :key="idx" :src="av" class="tile-avatar-img" /></div>
    </#if>
    <#if guidbase.has_child_widget(widget, "start_time")>
${""?left_pad(indent)}      <span class="tile-start-time">{{ ${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "start_time"))} }}</span>
    </#if>
${""?left_pad(indent)}    </div>
${""?left_pad(indent)}  </div>
${""?left_pad(indent)}</div>
</#macro>

<#--
简易状态 (Notification)
+-----------------------------------------------+
|  [status]   [primary]                         |
|             [tertiary]                        |
+-----------------------------------------------+
-->
<#macro print_tile_notification widget indent=0>
${""?left_pad(indent)}<div class="tile tile-notification">
${""?left_pad(indent)}  <div class="tile-row">
  <#if guidbase.has_child_widget(widget, "status")>
${""?left_pad(indent)}    <span class="tile-status">{{ ${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))} }}</span>
  </#if>
${""?left_pad(indent)}    <div class="tile-body">
    <#if guidbase.has_child_widget(widget, "primary")>
${""?left_pad(indent)}      <div class="tile-primary">{{ ${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))} }}</div>
    </#if>
    <#if guidbase.has_child_widget(widget, "tertiary")>
${""?left_pad(indent)}      <div class="tile-tertiary">{{ ${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "tertiary"))} }}</div>
    </#if>
${""?left_pad(indent)}    </div>
${""?left_pad(indent)}  </div>
${""?left_pad(indent)}</div>
</#macro>

<#--
背景封面 (Hero Profile)
+===============================================+
|                 [background]                  |
|                                               |
|     +------+                                  |
|     |avatar|                                  |
|     +------+                                  |
|                                               |
|  [primary]                                    |
|  [secondary]                                  |
+===============================================+
-->
<#macro print_tile_hero_profile widget indent=0>
${""?left_pad(indent)}<div class="tile tile-hero-profile">
  <#if guidbase.has_child_widget(widget, "background")>
${""?left_pad(indent)}  <div class="tile-background">
${""?left_pad(indent)}    <img :src="${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "background"))}" alt="" />
${""?left_pad(indent)}  </div>
  </#if>
${""?left_pad(indent)}  <div class="tile-overlay">
  <#if guidbase.has_child_widget(widget, "avatar")>
${""?left_pad(indent)}    <div class="tile-avatar">
${""?left_pad(indent)}      <img :src="${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "avatar"))}" alt="" />
${""?left_pad(indent)}    </div>
  </#if>
  <#if guidbase.has_child_widget(widget, "primary")>
${""?left_pad(indent)}    <div class="tile-primary">{{ ${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))} }}</div>
  </#if>
  <#if guidbase.has_child_widget(widget, "secondary")>
${""?left_pad(indent)}    <div class="tile-secondary">{{ ${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "secondary"))} }}</div>
  </#if>
${""?left_pad(indent)}  </div>
${""?left_pad(indent)}</div>
</#macro>

<#--
时间轴节点 (Timeline Node)
+-----------------------------------------------+
| [start time] | [primary]               [tags] |
|      |       | [secondary]                    |
| [end time]   | [tertiary]                     |
+-----------------------------------------------+
-->
<#macro print_tile_timeline_node widget indent=0>
${""?left_pad(indent)}<div class="tile tile-timeline-node">
${""?left_pad(indent)}  <div class="tile-row">
${""?left_pad(indent)}    <div class="tile-timeline">
    <#if guidbase.has_child_widget(widget, "start_time")>
${""?left_pad(indent)}      <span class="tile-start-time">{{ ${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "start_time"))} }}</span>
    </#if>
${""?left_pad(indent)}      <span class="tile-timeline-dot"></span>
    <#if guidbase.has_child_widget(widget, "end_time")>
${""?left_pad(indent)}      <span class="tile-end-time">{{ ${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "end_time"))} }}</span>
    </#if>
${""?left_pad(indent)}    </div>
${""?left_pad(indent)}    <div class="tile-body">
    <#if guidbase.has_child_widget(widget, "primary")>
${""?left_pad(indent)}      <div class="tile-primary">{{ ${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))} }}</div>
    </#if>
    <#if guidbase.has_child_widget(widget, "secondary")>
${""?left_pad(indent)}      <div class="tile-secondary">{{ ${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "secondary"))} }}</div>
    </#if>
    <#if guidbase.has_child_widget(widget, "tertiary")>
${""?left_pad(indent)}      <div class="tile-tertiary">{{ ${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "tertiary"))} }}</div>
    </#if>
${""?left_pad(indent)}    </div>
  <#if guidbase.has_child_widget(widget, "tags")>
${""?left_pad(indent)}    <span class="tile-tags"><span v-for="(tag, idx) in ${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "tags"))}" :key="idx" class="tile-tag">{{ tag }}</span></span>
  </#if>
${""?left_pad(indent)}  </div>
${""?left_pad(indent)}</div>
</#macro>

<#--
消息留言 (Message Card)
+-----------------------------------------------+
| +--------+  [primary]            [start time] |
| | avatar |  [secondary]                       |
| +--------+                                    |
|             [tertiary]                        |
+-----------------------------------------------+
-->
<#macro print_tile_message widget indent=0>
${""?left_pad(indent)}<div class="tile tile-message">
${""?left_pad(indent)}  <div class="tile-row">
  <#if guidbase.has_child_widget(widget, "avatar")>
${""?left_pad(indent)}    <div class="tile-avatar">
${""?left_pad(indent)}      <img :src="${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "avatar"))}" alt="" />
${""?left_pad(indent)}    </div>
  </#if>
${""?left_pad(indent)}    <div class="tile-body">
${""?left_pad(indent)}      <div class="tile-row tile-header">
    <#if guidbase.has_child_widget(widget, "primary")>
${""?left_pad(indent)}        <div class="tile-primary">{{ ${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))} }}</div>
    </#if>
    <#if guidbase.has_child_widget(widget, "start_time")>
${""?left_pad(indent)}        <span class="tile-start-time">{{ ${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "start_time"))} }}</span>
    </#if>
${""?left_pad(indent)}      </div>
    <#if guidbase.has_child_widget(widget, "secondary")>
${""?left_pad(indent)}      <div class="tile-secondary">{{ ${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "secondary"))} }}</div>
    </#if>
    <#if guidbase.has_child_widget(widget, "tertiary")>
${""?left_pad(indent)}      <div class="tile-tertiary">{{ ${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "tertiary"))} }}</div>
    </#if>
${""?left_pad(indent)}    </div>
${""?left_pad(indent)}  </div>
${""?left_pad(indent)}</div>
</#macro>

<#--
电子票务 (Ticket)
+===============================================+
| [background]                                  |
|                                               |
| [primary]                          [status]   |
|                                               |
| [start time] ~ [end time]                     |
+===============================================+
-->
<#macro print_tile_ticket widget indent=0>
${""?left_pad(indent)}<div class="tile tile-ticket">
  <#if guidbase.has_child_widget(widget, "background")>
${""?left_pad(indent)}  <div class="tile-background">
${""?left_pad(indent)}    <img :src="${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "background"))}" alt="" />
${""?left_pad(indent)}  </div>
  </#if>
${""?left_pad(indent)}  <div class="tile-overlay">
${""?left_pad(indent)}    <div class="tile-row tile-header">
    <#if guidbase.has_child_widget(widget, "primary")>
${""?left_pad(indent)}      <div class="tile-primary">{{ ${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))} }}</div>
    </#if>
    <#if guidbase.has_child_widget(widget, "status")>
${""?left_pad(indent)}      <span class="tile-status">{{ ${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))} }}</span>
    </#if>
${""?left_pad(indent)}    </div>
    <#if guidbase.has_child_widget(widget, "start_time") || guidbase.has_child_widget(widget, "end_time")>
${""?left_pad(indent)}    <div class="tile-time">
    <#if guidbase.has_child_widget(widget, "start_time")><span>{{ ${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "start_time"))} }}</span></#if>
    <#if guidbase.has_child_widget(widget, "start_time") && guidbase.has_child_widget(widget, "end_time")> ~ </#if>
    <#if guidbase.has_child_widget(widget, "end_time")><span>{{ ${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "end_time"))} }}</span></#if>
${""?left_pad(indent)}    </div>
    </#if>
${""?left_pad(indent)}  </div>
${""?left_pad(indent)}</div>
</#macro>

<#--
密集信息列表 (Dense Detail List)
+-----------------------------------------------+
| +-------+  [primary]                          |
| | image |  [secondary]                 [tags] |
| +-------+  [tertiary]                [status] |
+-----------------------------------------------+
-->
<#macro print_tile_dense_detail_list widget indent=0>
${""?left_pad(indent)}<div class="tile tile-dense-detail-list">
${""?left_pad(indent)}  <div class="tile-row">
  <#if guidbase.has_child_widget(widget, "image")>
${""?left_pad(indent)}    <div class="tile-image">
${""?left_pad(indent)}      <img :src="${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "image"))}" alt="" />
${""?left_pad(indent)}    </div>
  </#if>
${""?left_pad(indent)}    <div class="tile-body">
    <#if guidbase.has_child_widget(widget, "primary")>
${""?left_pad(indent)}      <div class="tile-primary">{{ ${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))} }}</div>
    </#if>
${""?left_pad(indent)}      <div class="tile-row">
    <#if guidbase.has_child_widget(widget, "secondary")>
${""?left_pad(indent)}        <span class="tile-secondary">{{ ${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "secondary"))} }}</span>
    </#if>
    <#if guidbase.has_child_widget(widget, "tags")>
${""?left_pad(indent)}        <span class="tile-tags"><span v-for="(tag, idx) in ${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "tags"))}" :key="idx" class="tile-tag">{{ tag }}</span></span>
    </#if>
${""?left_pad(indent)}      </div>
${""?left_pad(indent)}      <div class="tile-row">
    <#if guidbase.has_child_widget(widget, "tertiary")>
${""?left_pad(indent)}        <span class="tile-tertiary">{{ ${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "tertiary"))} }}</span>
    </#if>
    <#if guidbase.has_child_widget(widget, "status")>
${""?left_pad(indent)}        <span class="tile-status">{{ ${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))} }}</span>
    </#if>
${""?left_pad(indent)}      </div>
${""?left_pad(indent)}    </div>
${""?left_pad(indent)}  </div>
${""?left_pad(indent)}</div>
</#macro>

<#--
竖向海报 (Vertical Poster)
+-----------------------+
|                       |
|       [image]         |
|                       |
+-----------------------+
| [primary]             |
| [secondary]           |
|                       |
| [start time]          |
| [end time]            |
|                       |
| [avatars]             |
+-----------------------+
-->
<#macro print_tile_vertical_poster widget indent=0>
${""?left_pad(indent)}<div class="tile tile-vertical-poster">
  <#if guidbase.has_child_widget(widget, "image")>
${""?left_pad(indent)}  <div class="tile-image">
${""?left_pad(indent)}    <img :src="${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "image"))}" alt="" />
${""?left_pad(indent)}  </div>
  </#if>
  <#if guidbase.has_child_widget(widget, "primary") || guidbase.has_child_widget(widget, "secondary") || guidbase.has_child_widget(widget, "start_time") || guidbase.has_child_widget(widget, "end_time") || guidbase.has_child_widget(widget, "avatars")>
${""?left_pad(indent)}  <div class="tile-body">
    <#if guidbase.has_child_widget(widget, "primary")>
${""?left_pad(indent)}    <div class="tile-primary">{{ ${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))} }}</div>
    </#if>
    <#if guidbase.has_child_widget(widget, "secondary")>
${""?left_pad(indent)}    <div class="tile-secondary">{{ ${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "secondary"))} }}</div>
    </#if>
    <#if guidbase.has_child_widget(widget, "start_time")>
${""?left_pad(indent)}    <div class="tile-start-time">{{ ${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "start_time"))} }}</div>
    </#if>
    <#if guidbase.has_child_widget(widget, "end_time")>
${""?left_pad(indent)}    <div class="tile-end-time">{{ ${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "end_time"))} }}</div>
    </#if>
    <#if guidbase.has_child_widget(widget, "avatars")>
${""?left_pad(indent)}    <div class="tile-avatars"><img v-for="(av, idx) in ${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "avatars"))}" :key="idx" :src="av" class="tile-avatar-img" /></div>
    </#if>
${""?left_pad(indent)}  </div>
  </#if>
${""?left_pad(indent)}</div>
</#macro>

<#--
详情工单 (Issue / Ticket Detail)
+-----------------------------------------------+
| [tags]                               [status] |
|                                               |
| [primary]                                     |
| [secondary]                                   |
| [tertiary]                                    |
|                                               |
| [avatar]                           [end time] |
+-----------------------------------------------+
-->
<#macro print_tile_issue_detail widget indent=0>
${""?left_pad(indent)}<div class="tile tile-issue-detail">
${""?left_pad(indent)}  <div class="tile-row tile-header">
  <#if guidbase.has_child_widget(widget, "tags")>
${""?left_pad(indent)}    <span class="tile-tags"><span v-for="(tag, idx) in ${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "tags"))}" :key="idx" class="tile-tag">{{ tag }}</span></span>
  </#if>
  <#if guidbase.has_child_widget(widget, "status")>
${""?left_pad(indent)}    <span class="tile-status">{{ ${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))} }}</span>
  </#if>
${""?left_pad(indent)}  </div>
  <#if guidbase.has_child_widget(widget, "primary") || guidbase.has_child_widget(widget, "secondary") || guidbase.has_child_widget(widget, "tertiary")>
${""?left_pad(indent)}  <div class="tile-body">
    <#if guidbase.has_child_widget(widget, "primary")>
${""?left_pad(indent)}    <div class="tile-primary">{{ ${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))} }}</div>
    </#if>
    <#if guidbase.has_child_widget(widget, "secondary")>
${""?left_pad(indent)}    <div class="tile-secondary">{{ ${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "secondary"))} }}</div>
    </#if>
    <#if guidbase.has_child_widget(widget, "tertiary")>
${""?left_pad(indent)}    <div class="tile-tertiary">{{ ${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "tertiary"))} }}</div>
    </#if>
${""?left_pad(indent)}  </div>
  </#if>
${""?left_pad(indent)}  <div class="tile-row tile-footer">
  <#if guidbase.has_child_widget(widget, "avatar")>
${""?left_pad(indent)}    <div class="tile-avatar">
${""?left_pad(indent)}      <img :src="${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "avatar"))}" alt="" />
${""?left_pad(indent)}    </div>
  </#if>
  <#if guidbase.has_child_widget(widget, "end_time")>
${""?left_pad(indent)}    <span class="tile-end-time">{{ ${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "end_time"))} }}</span>
  </#if>
${""?left_pad(indent)}  </div>
${""?left_pad(indent)}</div>
</#macro>
<#--
团队目录 (Team Directory)
+-----------------------------------------------+
| [primary]                                     |
| [secondary]                                   |
|                                               |
| [avatars]                              [tags] |
+-----------------------------------------------+
-->
<#macro print_tile_team_directory widget indent=0>
${""?left_pad(indent)}<div class="tile tile-team-directory">
${""?left_pad(indent)}  <div class="tile-body">
  <#if guidbase.has_child_widget(widget, "primary")>
${""?left_pad(indent)}    <div class="tile-primary">{{ ${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))} }}</div>
  </#if>
  <#if guidbase.has_child_widget(widget, "secondary")>
${""?left_pad(indent)}    <div class="tile-secondary">{{ ${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "secondary"))} }}</div>
  </#if>
${""?left_pad(indent)}  </div>
${""?left_pad(indent)}  <div class="tile-row tile-footer">
  <#if guidbase.has_child_widget(widget, "avatars")>
${""?left_pad(indent)}    <div class="tile-avatars"><img v-for="(av, idx) in ${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "avatars"))}" :key="idx" :src="av" class="tile-avatar-img" /></div>
  </#if>
  <#if guidbase.has_child_widget(widget, "tags")>
${""?left_pad(indent)}    <span class="tile-tags"><span v-for="(tag, idx) in ${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "tags"))}" :key="idx" class="tile-tag">{{ tag }}</span></span>
  </#if>
${""?left_pad(indent)}  </div>
${""?left_pad(indent)}</div>
</#macro>

<#--
沉浸高光 (Immersive Highlight)
+===============================================+
|                 [background]                  |
|                                               |
|                                               |
|  [status]                                     |
|  [primary]                                    |
+===============================================+
-->
<#macro print_tile_immersive_highlight widget indent=0>
${""?left_pad(indent)}<div class="tile tile-immersive-highlight">
  <#if guidbase.has_child_widget(widget, "background")>
${""?left_pad(indent)}  <div class="tile-background">
${""?left_pad(indent)}    <img :src="${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "background"))}" alt="" />
${""?left_pad(indent)}  </div>
  </#if>
${""?left_pad(indent)}  <div class="tile-overlay">
  <#if guidbase.has_child_widget(widget, "status")>
${""?left_pad(indent)}    <span class="tile-status">{{ ${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))} }}</span>
  </#if>
  <#if guidbase.has_child_widget(widget, "primary")>
${""?left_pad(indent)}    <div class="tile-primary">{{ ${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))} }}</div>
  </#if>
${""?left_pad(indent)}  </div>
${""?left_pad(indent)}</div>
</#macro>

<#--
迷你状态 (Mini Status)
+-----------------------+
| [status]   [end time] |
|                       |
| [primary]             |
| [tags]                |
+-----------------------+
-->
<#macro print_tile_mini_status widget indent=0>
${""?left_pad(indent)}<div class="tile tile-mini-status">
${""?left_pad(indent)}  <div class="tile-row tile-header">
  <#if guidbase.has_child_widget(widget, "status")>
${""?left_pad(indent)}    <span class="tile-status">{{ ${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))} }}</span>
  </#if>
  <#if guidbase.has_child_widget(widget, "end_time")>
${""?left_pad(indent)}    <span class="tile-end-time">{{ ${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "end_time"))} }}</span>
  </#if>
${""?left_pad(indent)}  </div>
  <#if guidbase.has_child_widget(widget, "primary")>
${""?left_pad(indent)}  <div class="tile-primary">{{ ${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))} }}</div>
  </#if>
  <#if guidbase.has_child_widget(widget, "tags")>
${""?left_pad(indent)}  <div class="tile-tags"><span v-for="(tag, idx) in ${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "tags"))}" :key="idx" class="tile-tag">{{ tag }}</span></div>
  </#if>
${""?left_pad(indent)}</div>
</#macro>

<#--
双栏内容 (Dual Column Content)
+-----------------------------------------------+
| [primary]          | [secondary]              |
| [tertiary]         | [tags]                   |
|                    |                          |
| [avatar]           | [avatars]                |
+-----------------------------------------------+
-->
<#macro print_tile_dual_column_content widget indent=0>
${""?left_pad(indent)}<div class="tile tile-dual-column-content">
${""?left_pad(indent)}  <div class="tile-row">
${""?left_pad(indent)}    <div class="tile-col tile-col-left">
    <#if guidbase.has_child_widget(widget, "primary")>
${""?left_pad(indent)}      <div class="tile-primary">{{ ${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))} }}</div>
    </#if>
    <#if guidbase.has_child_widget(widget, "tertiary")>
${""?left_pad(indent)}      <div class="tile-tertiary">{{ ${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "tertiary"))} }}</div>
    </#if>
    <#if guidbase.has_child_widget(widget, "avatar")>
${""?left_pad(indent)}      <div class="tile-avatar">
${""?left_pad(indent)}        <img :src="${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "avatar"))}" alt="" />
${""?left_pad(indent)}      </div>
    </#if>
${""?left_pad(indent)}    </div>
${""?left_pad(indent)}    <div class="tile-col tile-col-right">
    <#if guidbase.has_child_widget(widget, "secondary")>
${""?left_pad(indent)}      <div class="tile-secondary">{{ ${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "secondary"))} }}</div>
    </#if>
    <#if guidbase.has_child_widget(widget, "tags")>
${""?left_pad(indent)}      <div class="tile-tags"><span v-for="(tag, idx) in ${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "tags"))}" :key="idx" class="tile-tag">{{ tag }}</span></div>
    </#if>
    <#if guidbase.has_child_widget(widget, "avatars")>
${""?left_pad(indent)}      <div class="tile-avatars"><img v-for="(av, idx) in ${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "avatars"))}" :key="idx" :src="av" class="tile-avatar-img" /></div>
    </#if>
${""?left_pad(indent)}    </div>
${""?left_pad(indent)}  </div>
${""?left_pad(indent)}</div>
</#macro>

<#--
画廊卡片 (Gallery Card)
+-----------------------------------------------+
| +-------------------------------------------+ |
| |                 [image]                   | |
| +-------------------------------------------+ |
| [primary]                                     |
| [avatars]                            [status] |
+-----------------------------------------------+
-->
<#macro print_tile_gallery widget indent=0>
${""?left_pad(indent)}<div class="tile tile-gallery">
  <#if guidbase.has_child_widget(widget, "image")>
${""?left_pad(indent)}  <div class="tile-image-wrap">
${""?left_pad(indent)}    <div class="tile-image">
${""?left_pad(indent)}      <img :src="${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "image"))}" alt="" />
${""?left_pad(indent)}    </div>
${""?left_pad(indent)}  </div>
  </#if>
  <#if guidbase.has_child_widget(widget, "primary")>
${""?left_pad(indent)}  <div class="tile-primary">{{ ${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))} }}</div>
  </#if>
${""?left_pad(indent)}  <div class="tile-row tile-footer">
  <#if guidbase.has_child_widget(widget, "avatars")>
${""?left_pad(indent)}    <div class="tile-avatars"><img v-for="(av, idx) in ${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "avatars"))}" :key="idx" :src="av" class="tile-avatar-img" /></div>
  </#if>
  <#if guidbase.has_child_widget(widget, "status")>
${""?left_pad(indent)}    <span class="tile-status">{{ ${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))} }}</span>
  </#if>
${""?left_pad(indent)}  </div>
${""?left_pad(indent)}</div>
</#macro>

<#--
核心指标 (Key Metric)
+-----------------------+
| [tags]                |
|                       |
| [primary]             |
|                       |
| [secondary]  [status] |
+-----------------------+
-->
<#macro print_tile_key_metric widget indent=0>
${""?left_pad(indent)}<div class="tile tile-key-metric">
  <#if guidbase.has_child_widget(widget, "tags")>
${""?left_pad(indent)}  <div class="tile-tags"><span v-for="(tag, idx) in ${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "tags"))}" :key="idx" class="tile-tag">{{ tag }}</span></div>
  </#if>
  <#if guidbase.has_child_widget(widget, "primary")>
${""?left_pad(indent)}  <div class="tile-primary">{{ ${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))} }}</div>
  </#if>
${""?left_pad(indent)}  <div class="tile-row tile-footer">
  <#if guidbase.has_child_widget(widget, "secondary")>
${""?left_pad(indent)}    <span class="tile-secondary">{{ ${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "secondary"))} }}</span>
  </#if>
  <#if guidbase.has_child_widget(widget, "status")>
${""?left_pad(indent)}    <span class="tile-status">{{ ${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))} }}</span>
  </#if>
${""?left_pad(indent)}  </div>
${""?left_pad(indent)}</div>
</#macro>

<#--
悬浮头像卡 (Overlay Avatar Card)
+-----------------------------------------------+
| +-------------------------------------------+ |
| |                 [image]                   | |
| +-------------------------------------------+ |
|    +--------+                                 |
|    | avatar |      [primary]                  |
|    +--------+      [secondary]                |
+-----------------------------------------------+
-->
<#macro print_tile_overlay_avatar widget indent=0>
${""?left_pad(indent)}<div class="tile tile-overlay-avatar">
  <#if guidbase.has_child_widget(widget, "image")>
${""?left_pad(indent)}  <div class="tile-image-wrap">
${""?left_pad(indent)}    <div class="tile-image">
${""?left_pad(indent)}      <img :src="${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "image"))}" alt="" />
${""?left_pad(indent)}    </div>
${""?left_pad(indent)}  </div>
  </#if>
${""?left_pad(indent)}  <div class="tile-row tile-overlay-content">
  <#if guidbase.has_child_widget(widget, "avatar")>
${""?left_pad(indent)}    <div class="tile-avatar">
${""?left_pad(indent)}      <img :src="${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "avatar"))}" alt="" />
${""?left_pad(indent)}    </div>
  </#if>
${""?left_pad(indent)}    <div class="tile-body">
    <#if guidbase.has_child_widget(widget, "primary")>
${""?left_pad(indent)}      <div class="tile-primary">{{ ${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))} }}</div>
    </#if>
    <#if guidbase.has_child_widget(widget, "secondary")>
${""?left_pad(indent)}      <div class="tile-secondary">{{ ${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "secondary"))} }}</div>
    </#if>
${""?left_pad(indent)}    </div>
${""?left_pad(indent)}  </div>
${""?left_pad(indent)}</div>
</#macro>

<#--
审计记录 (Audit Log)
+-----------------------------------------------+
| [avatar]  [primary]                  [status] |
|           [secondary]                         |
|           [start time]                        |
+-----------------------------------------------+
-->
<#macro print_tile_audit_log widget indent=0>
${""?left_pad(indent)}<div class="tile tile-audit-log">
${""?left_pad(indent)}  <div class="tile-row">
  <#if guidbase.has_child_widget(widget, "avatar")>
${""?left_pad(indent)}    <div class="tile-avatar">
${""?left_pad(indent)}      <img :src="${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "avatar"))}" alt="" />
${""?left_pad(indent)}    </div>
  </#if>
${""?left_pad(indent)}    <div class="tile-body">
${""?left_pad(indent)}      <div class="tile-row">
    <#if guidbase.has_child_widget(widget, "primary")>
${""?left_pad(indent)}        <div class="tile-primary">{{ ${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))} }}</div>
    </#if>
    <#if guidbase.has_child_widget(widget, "status")>
${""?left_pad(indent)}        <span class="tile-status">{{ ${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))} }}</span>
    </#if>
${""?left_pad(indent)}      </div>
    <#if guidbase.has_child_widget(widget, "secondary")>
${""?left_pad(indent)}      <div class="tile-secondary">{{ ${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "secondary"))} }}</div>
    </#if>
    <#if guidbase.has_child_widget(widget, "start_time")>
${""?left_pad(indent)}      <div class="tile-start-time">{{ ${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "start_time"))} }}</div>
    </#if>
${""?left_pad(indent)}    </div>
${""?left_pad(indent)}  </div>
${""?left_pad(indent)}</div>
</#macro>

<#--
日历单元 (Calendar Cell)
+-----------------------+
| [start time] [status] |
|                       |
| [primary]             |
|                       |
| [avatars]             |
+-----------------------+
-->
<#macro print_tile_calendar_cell widget indent=0>
${""?left_pad(indent)}<div class="tile tile-calendar-cell">
${""?left_pad(indent)}  <div class="tile-row tile-header">
  <#if guidbase.has_child_widget(widget, "start_time")>
${""?left_pad(indent)}    <span class="tile-start-time">{{ ${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "start_time"))} }}</span>
  </#if>
  <#if guidbase.has_child_widget(widget, "status")>
${""?left_pad(indent)}    <span class="tile-status">{{ ${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))} }}</span>
  </#if>
${""?left_pad(indent)}  </div>
  <#if guidbase.has_child_widget(widget, "primary")>
${""?left_pad(indent)}  <div class="tile-primary">{{ ${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))} }}</div>
  </#if>
  <#if guidbase.has_child_widget(widget, "avatars")>
${""?left_pad(indent)}  <div class="tile-avatars"><img v-for="(av, idx) in ${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "avatars"))}" :key="idx" :src="av" class="tile-avatar-img" /></div>
  </#if>
${""?left_pad(indent)}</div>
</#macro>

<#--
侧边状态卡 (Side Status Card)
+----------+------------------------------------+
|          | [primary]                          |
| [status] | [secondary]                        |
|          | [start time]                       |
+----------+------------------------------------+
-->
<#macro print_tile_side_status widget indent=0>
${""?left_pad(indent)}<div class="tile tile-side-status">
${""?left_pad(indent)}  <div class="tile-row">
  <#if guidbase.has_child_widget(widget, "status")>
${""?left_pad(indent)}    <div class="tile-status-col">
${""?left_pad(indent)}      <span class="tile-status">{{ ${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))} }}</span>
${""?left_pad(indent)}    </div>
  </#if>
${""?left_pad(indent)}    <div class="tile-body">
    <#if guidbase.has_child_widget(widget, "primary")>
${""?left_pad(indent)}      <div class="tile-primary">{{ ${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))} }}</div>
    </#if>
    <#if guidbase.has_child_widget(widget, "secondary")>
${""?left_pad(indent)}      <div class="tile-secondary">{{ ${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "secondary"))} }}</div>
    </#if>
    <#if guidbase.has_child_widget(widget, "start_time")>
${""?left_pad(indent)}      <div class="tile-start-time">{{ ${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "start_time"))} }}</div>
    </#if>
${""?left_pad(indent)}    </div>
${""?left_pad(indent)}  </div>
${""?left_pad(indent)}</div>
</#macro>

<#--
多标签分类 (Multi-Tag Card)
+-----------------------------------------------+
| [tags] [tags] [tags]                          |
|                                               |
| [primary]                                     |
| [secondary]                        [end time] |
+-----------------------------------------------+
-->
<#macro print_tile_multi_tag widget indent=0>
${""?left_pad(indent)}<div class="tile tile-multi-tag">
${""?left_pad(indent)}  <div class="tile-tags-row">
  <#if guidbase.has_child_widget(widget, "tags")>
${""?left_pad(indent)}    <span class="tile-tags"><span v-for="(tag, idx) in ${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "tags"))}" :key="idx" class="tile-tag">{{ tag }}</span></span>
  </#if>
${""?left_pad(indent)}  </div>
  <#if guidbase.has_child_widget(widget, "primary")>
${""?left_pad(indent)}  <div class="tile-primary">{{ ${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))} }}</div>
  </#if>
${""?left_pad(indent)}  <div class="tile-row tile-footer">
  <#if guidbase.has_child_widget(widget, "secondary")>
${""?left_pad(indent)}    <span class="tile-secondary">{{ ${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "secondary"))} }}</span>
  </#if>
  <#if guidbase.has_child_widget(widget, "end_time")>
${""?left_pad(indent)}    <span class="tile-end-time">{{ ${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "end_time"))} }}</span>
  </#if>
${""?left_pad(indent)}  </div>
${""?left_pad(indent)}</div>
</#macro>

<#--
复杂排班 (Shift/Schedule Planner)
+-----------------------------------------------+
| [start time] - [end time]            [status] |
|                                               |
| [primary]                                     |
| +-------------------------------------------+ |
| | [avatars]                                 | |
| +-------------------------------------------+ |
+-----------------------------------------------+
-->
<#macro print_tile_shift_planner widget indent=0>
${""?left_pad(indent)}<div class="tile tile-shift-planner">
${""?left_pad(indent)}  <div class="tile-row tile-header">
    <#if guidbase.has_child_widget(widget, "start_time") || guidbase.has_child_widget(widget, "end_time")>
${""?left_pad(indent)}    <span class="tile-time">
      <#if guidbase.has_child_widget(widget, "start_time")><span>{{ ${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "start_time"))} }}</span></#if>
      <#if guidbase.has_child_widget(widget, "start_time") && guidbase.has_child_widget(widget, "end_time")> - </#if>
      <#if guidbase.has_child_widget(widget, "end_time")><span>{{ ${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "end_time"))} }}</span></#if>
${""?left_pad(indent)}    </span>
    </#if>
  <#if guidbase.has_child_widget(widget, "status")>
${""?left_pad(indent)}    <span class="tile-status">{{ ${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))} }}</span>
  </#if>
${""?left_pad(indent)}  </div>
  <#if guidbase.has_child_widget(widget, "primary")>
${""?left_pad(indent)}  <div class="tile-primary">{{ ${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))} }}</div>
  </#if>
  <#if guidbase.has_child_widget(widget, "avatars")>
${""?left_pad(indent)}  <div class="tile-avatars-wrap">
${""?left_pad(indent)}    <div class="tile-avatars"><img v-for="(av, idx) in ${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "avatars"))}" :key="idx" :src="av" class="tile-avatar-img" /></div>
${""?left_pad(indent)}  </div>
  </#if>
${""?left_pad(indent)}</div>
</#macro>

<#--
社交动态 (Social Post Feed)
+-----------------------------------------------+
| +--------+  [primary]                         |
| | avatar |  [start time]                      |
| +--------+                                    |
| [tertiary]                                    |
| +-------------------------------------------+ |
| |                  [image]                  | |
| +-------------------------------------------+ |
| [avatars]                              [tags] |
+-----------------------------------------------+
-->
<#macro print_tile_social_post_feed widget indent=0>
${""?left_pad(indent)}<div class="tile tile-social-post-feed">
${""?left_pad(indent)}  <div class="tile-row">
  <#if guidbase.has_child_widget(widget, "avatar")>
${""?left_pad(indent)}    <div class="tile-avatar">
${""?left_pad(indent)}      <img :src="${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "avatar"))}" alt="" />
${""?left_pad(indent)}    </div>
  </#if>
${""?left_pad(indent)}    <div class="tile-body">
    <#if guidbase.has_child_widget(widget, "primary")>
${""?left_pad(indent)}      <div class="tile-primary">{{ ${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))} }}</div>
    </#if>
    <#if guidbase.has_child_widget(widget, "start_time")>
${""?left_pad(indent)}      <span class="tile-start-time">{{ ${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "start_time"))} }}</span>
    </#if>
${""?left_pad(indent)}    </div>
${""?left_pad(indent)}  </div>
  <#if guidbase.has_child_widget(widget, "tertiary")>
${""?left_pad(indent)}  <div class="tile-tertiary">{{ ${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "tertiary"))} }}</div>
  </#if>
  <#if guidbase.has_child_widget(widget, "image")>
${""?left_pad(indent)}  <div class="tile-image-wrap">
${""?left_pad(indent)}    <div class="tile-image">
${""?left_pad(indent)}      <img :src="${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "image"))}" alt="" />
${""?left_pad(indent)}    </div>
${""?left_pad(indent)}  </div>
  </#if>
${""?left_pad(indent)}  <div class="tile-row tile-footer">
  <#if guidbase.has_child_widget(widget, "avatars")>
${""?left_pad(indent)}    <div class="tile-avatars"><img v-for="(av, idx) in ${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "avatars"))}" :key="idx" :src="av" class="tile-avatar-img" /></div>
  </#if>
  <#if guidbase.has_child_widget(widget, "tags")>
${""?left_pad(indent)}    <span class="tile-tags"><span v-for="(tag, idx) in ${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "tags"))}" :key="idx" class="tile-tag">{{ tag }}</span></span>
  </#if>
${""?left_pad(indent)}  </div>
${""?left_pad(indent)}</div>
</#macro>

<#--
商品卡片 (Product Card)
+-----------------------+
| +-------------------+ |
| |      [image]      | |
| +-------------------+ |
| [tags]                |
| [primary]             |
| [secondary]           |
| [status]   [end time] |
+-----------------------+
-->
<#macro print_tile_product widget indent=0>
${""?left_pad(indent)}<div class="tile tile-product">
  <#if guidbase.has_child_widget(widget, "image")>
${""?left_pad(indent)}  <div class="tile-image-wrap">
${""?left_pad(indent)}    <div class="tile-image">
${""?left_pad(indent)}      <img :src="${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "image"))}" alt="" />
${""?left_pad(indent)}    </div>
${""?left_pad(indent)}  </div>
  </#if>
  <#if guidbase.has_child_widget(widget, "tags")>
${""?left_pad(indent)}  <div class="tile-tags"><span v-for="(tag, idx) in ${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "tags"))}" :key="idx" class="tile-tag">{{ tag }}</span></div>
  </#if>
  <#if guidbase.has_child_widget(widget, "primary")>
${""?left_pad(indent)}  <div class="tile-primary">{{ ${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))} }}</div>
  </#if>
  <#if guidbase.has_child_widget(widget, "secondary")>
${""?left_pad(indent)}  <div class="tile-secondary">{{ ${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "secondary"))} }}</div>
  </#if>
${""?left_pad(indent)}  <div class="tile-row tile-footer">
  <#if guidbase.has_child_widget(widget, "status")>
${""?left_pad(indent)}    <span class="tile-status">{{ ${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))} }}</span>
  </#if>
  <#if guidbase.has_child_widget(widget, "end_time")>
${""?left_pad(indent)}    <span class="tile-end-time">{{ ${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "end_time"))} }}</span>
  </#if>
${""?left_pad(indent)}  </div>
${""?left_pad(indent)}</div>
</#macro>

<#--
对抗与合作 (Dual Profile Comparison)
+-----------------------------------------------+
| +--------+                         +--------+ |
| | avatar |         [status]        | avatar | |
| +--------+                         +--------+ |
| [primary]                         [secondary] |
| [start time]                       [end time] |
+-----------------------------------------------+
-->
<#macro print_tile_dual_profile_comparison widget indent=0>
${""?left_pad(indent)}<div class="tile tile-dual-profile-comparison">
${""?left_pad(indent)}  <div class="tile-row tile-header">
  <#if guidbase.has_child_widget(widget, "avatar")>
${""?left_pad(indent)}    <div class="tile-avatar">
${""?left_pad(indent)}      <img :src="${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "avatar"))}" alt="" />
${""?left_pad(indent)}    </div>
  </#if>
  <#if guidbase.has_child_widget(widget, "status")>
${""?left_pad(indent)}    <span class="tile-status">{{ ${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))} }}</span>
  </#if>
  <#if guidbase.has_child_widget(widget, "secondary")>
${""?left_pad(indent)}    <div class="tile-avatar">
${""?left_pad(indent)}      <img src="" alt="{{ ${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "secondary"))} }}">
${""?left_pad(indent)}    </div>
  </#if>
${""?left_pad(indent)}  </div>
${""?left_pad(indent)}  <div class="tile-row tile-footer">
  <#if guidbase.has_child_widget(widget, "primary")>
${""?left_pad(indent)}    <span class="tile-primary">{{ ${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))} }}</span>
  </#if>
  <#if guidbase.has_child_widget(widget, "secondary")>
${""?left_pad(indent)}    <span class="tile-secondary">{{ ${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "secondary"))} }}</span>
  </#if>
${""?left_pad(indent)}  </div>
${""?left_pad(indent)}  <div class="tile-row">
  <#if guidbase.has_child_widget(widget, "start_time")>
${""?left_pad(indent)}    <span class="tile-start-time">{{ ${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "start_time"))} }}</span>
  </#if>
  <#if guidbase.has_child_widget(widget, "end_time")>
${""?left_pad(indent)}    <span class="tile-end-time">{{ ${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "end_time"))} }}</span>
  </#if>
${""?left_pad(indent)}  </div>
${""?left_pad(indent)}</div>
</#macro>
<#--
侧栏大图 (Left Feature Image)
+---------------------+-------------------------+
|                     | [tags]                  |
|                     | [primary]               |
|       [image]       | [secondary]             |
|                     | [tertiary]              |
|                     | [status]     [avatars]  |
+---------------------+-------------------------+
-->
<#macro print_tile_left_feature_image widget indent=0>
${""?left_pad(indent)}<div class="tile tile-left-feature-image">
${""?left_pad(indent)}  <div class="tile-row">
  <#if guidbase.has_child_widget(widget, "image")>
${""?left_pad(indent)}    <div class="tile-image">
${""?left_pad(indent)}      <img :src="${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "image"))}" alt="" />
${""?left_pad(indent)}    </div>
  </#if>
${""?left_pad(indent)}    <div class="tile-body">
    <#if guidbase.has_child_widget(widget, "tags")>
${""?left_pad(indent)}      <div class="tile-tags"><span v-for="(tag, idx) in ${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "tags"))}" :key="idx" class="tile-tag">{{ tag }}</span></div>
    </#if>
    <#if guidbase.has_child_widget(widget, "primary")>
${""?left_pad(indent)}      <div class="tile-primary">{{ ${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))} }}</div>
    </#if>
    <#if guidbase.has_child_widget(widget, "secondary")>
${""?left_pad(indent)}      <div class="tile-secondary">{{ ${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "secondary"))} }}</div>
    </#if>
    <#if guidbase.has_child_widget(widget, "tertiary")>
${""?left_pad(indent)}      <div class="tile-tertiary">{{ ${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "tertiary"))} }}</div>
    </#if>
${""?left_pad(indent)}      <div class="tile-row tile-inline">
    <#if guidbase.has_child_widget(widget, "status")>
${""?left_pad(indent)}        <span class="tile-status">{{ ${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))} }}</span>
    </#if>
    <#if guidbase.has_child_widget(widget, "avatars")>
${""?left_pad(indent)}        <span class="tile-avatars"><img v-for="(av, idx) in ${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "avatars"))}" :key="idx" :src="av" class="tile-avatar-img" /></span>
    </#if>
${""?left_pad(indent)}      </div>
${""?left_pad(indent)}    </div>
${""?left_pad(indent)}  </div>
${""?left_pad(indent)}</div>
</#macro>

<#--
宽版工作流 (Workflow Strip)
+-----------------------------------------------+
| [start time] > [avatars] > [status] > [end time] |
|                                               |
| [primary]                                     |
+-----------------------------------------------+
-->
<#macro print_tile_workflow_strip widget indent=0>
${""?left_pad(indent)}<div class="tile tile-workflow-strip">
${""?left_pad(indent)}  <div class="tile-row tile-workflow-chain">
  <#if guidbase.has_child_widget(widget, "start_time")>
${""?left_pad(indent)}    <span class="tile-start-time">{{ ${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "start_time"))} }}</span>
${""?left_pad(indent)}    <span class="tile-workflow-arrow"> > </span>
  </#if>
  <#if guidbase.has_child_widget(widget, "avatars")>
${""?left_pad(indent)}    <span class="tile-avatars"><img v-for="(av, idx) in ${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "avatars"))}" :key="idx" :src="av" class="tile-avatar-img" /></span>
${""?left_pad(indent)}    <span class="tile-workflow-arrow"> > </span>
  </#if>
  <#if guidbase.has_child_widget(widget, "status")>
${""?left_pad(indent)}    <span class="tile-status">{{ ${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))} }}</span>
${""?left_pad(indent)}    <span class="tile-workflow-arrow"> > </span>
  </#if>
  <#if guidbase.has_child_widget(widget, "end_time")>
${""?left_pad(indent)}    <span class="tile-end-time">{{ ${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "end_time"))} }}</span>
  </#if>
${""?left_pad(indent)}  </div>
  <#if guidbase.has_child_widget(widget, "primary")>
${""?left_pad(indent)}  <div class="tile-primary">{{ ${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))} }}</div>
  </#if>
${""?left_pad(indent)}</div>
</#macro>

<#--
悬浮背景文字 (Text Over Background)
+===============================================+
|                 [background]                  |
|                                               |
|    [tags]                                     |
|    [primary]                                  |
|    +--------+                                 |
|    | avatar | [secondary]                     |
|    +--------+                                 |
+===============================================+
-->
<#macro print_tile_text_over_background widget indent=0>
${""?left_pad(indent)}<div class="tile tile-text-over-background">
  <#if guidbase.has_child_widget(widget, "background")>
${""?left_pad(indent)}  <div class="tile-background">
${""?left_pad(indent)}    <img :src="${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "background"))}" alt="" />
${""?left_pad(indent)}  </div>
  </#if>
${""?left_pad(indent)}  <div class="tile-overlay">
  <#if guidbase.has_child_widget(widget, "tags")>
${""?left_pad(indent)}    <div class="tile-tags"><span v-for="(tag, idx) in ${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "tags"))}" :key="idx" class="tile-tag">{{ tag }}</span></div>
  </#if>
  <#if guidbase.has_child_widget(widget, "primary")>
${""?left_pad(indent)}    <div class="tile-primary">{{ ${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))} }}</div>
  </#if>
${""?left_pad(indent)}    <div class="tile-row">
    <#if guidbase.has_child_widget(widget, "avatar")>
${""?left_pad(indent)}      <div class="tile-avatar">
${""?left_pad(indent)}        <img :src="${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "avatar"))}" alt="" />
${""?left_pad(indent)}      </div>
    </#if>
    <#if guidbase.has_child_widget(widget, "secondary")>
${""?left_pad(indent)}      <span class="tile-secondary">{{ ${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "secondary"))} }}</span>
    </#if>
${""?left_pad(indent)}    </div>
${""?left_pad(indent)}  </div>
${""?left_pad(indent)}</div>
</#macro>

<#--
微型标记 (Micro Badge)
+----------------------------------+
| [avatar]  [primary]     [status] |
+----------------------------------+
-->
<#macro print_tile_micro_badge widget indent=0>
${""?left_pad(indent)}<div class="tile tile-micro-badge">
${""?left_pad(indent)}  <div class="tile-row tile-inline">
  <#if guidbase.has_child_widget(widget, "avatar")>
${""?left_pad(indent)}    <div class="tile-avatar">
${""?left_pad(indent)}      <img :src="${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "avatar"))}" alt="" />
${""?left_pad(indent)}    </div>
  </#if>
  <#if guidbase.has_child_widget(widget, "primary")>
${""?left_pad(indent)}    <span class="tile-primary">{{ ${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))} }}</span>
  </#if>
  <#if guidbase.has_child_widget(widget, "status")>
${""?left_pad(indent)}    <span class="tile-status">{{ ${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))} }}</span>
  </#if>
${""?left_pad(indent)}  </div>
${""?left_pad(indent)}</div>
</#macro>

<#--
分段步骤 (Stepped Process)
+-----------------------------------------------+
| [status]  [primary]                           |
|    |                                          |
|    +-- [secondary]                            |
|    |                                          |
|    +-- [start time] - [end time]              |
+-----------------------------------------------+
-->
<#macro print_tile_stepped_process widget indent=0>
${""?left_pad(indent)}<div class="tile tile-stepped-process">
${""?left_pad(indent)}  <div class="tile-row">
  <#if guidbase.has_child_widget(widget, "status")>
${""?left_pad(indent)}    <span class="tile-status">{{ ${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))} }}</span>
  </#if>
${""?left_pad(indent)}    <div class="tile-body">
    <#if guidbase.has_child_widget(widget, "primary")>
${""?left_pad(indent)}      <div class="tile-primary">{{ ${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))} }}</div>
    </#if>
${""?left_pad(indent)}      <div class="tile-step-line">
${""?left_pad(indent)}        <span class="tile-step-branch">├─</span>
    <#if guidbase.has_child_widget(widget, "secondary")>
${""?left_pad(indent)}        <span class="tile-secondary">{{ ${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "secondary"))} }}</span>
    </#if>
${""?left_pad(indent)}      </div>
${""?left_pad(indent)}      <div class="tile-step-line">
${""?left_pad(indent)}        <span class="tile-step-branch">├─</span>
    <#if guidbase.has_child_widget(widget, "start_time") || guidbase.has_child_widget(widget, "end_time")>
    <#if guidbase.has_child_widget(widget, "start_time")><span>{{ ${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "start_time"))} }}</span></#if>
    <#if guidbase.has_child_widget(widget, "start_time") && guidbase.has_child_widget(widget, "end_time")> - </#if>
    <#if guidbase.has_child_widget(widget, "end_time")><span>{{ ${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "end_time"))} }}</span></#if>
    </#if>
${""?left_pad(indent)}      </div>
${""?left_pad(indent)}    </div>
${""?left_pad(indent)}  </div>
${""?left_pad(indent)}</div>
</#macro>

<#--
悬浮叠层 (Stacked Overlay)
+-----------------------------------------------+
| +-------------------------------------------+ |
| |                  [image]                  | |
| +-------------------------------------------+ |
|       +-------------------------------+       |
|       | [primary]                     |       |
|       | [secondary]          [status] |       |
|       +-------------------------------+       |
+-----------------------------------------------+
-->
<#macro print_tile_stacked_overlay widget indent=0>
${""?left_pad(indent)}<div class="tile tile-stacked-overlay">
  <#if guidbase.has_child_widget(widget, "image")>
${""?left_pad(indent)}  <div class="tile-image-wrap">
${""?left_pad(indent)}    <div class="tile-image">
${""?left_pad(indent)}      <img :src="${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "image"))}" alt="" />
${""?left_pad(indent)}    </div>
${""?left_pad(indent)}  </div>
  </#if>
${""?left_pad(indent)}  <div class="tile-stacked-card">
    <#if guidbase.has_child_widget(widget, "primary")>
${""?left_pad(indent)}    <div class="tile-primary">{{ ${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))} }}</div>
    </#if>
${""?left_pad(indent)}    <div class="tile-row">
    <#if guidbase.has_child_widget(widget, "secondary")>
${""?left_pad(indent)}      <span class="tile-secondary">{{ ${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "secondary"))} }}</span>
    </#if>
    <#if guidbase.has_child_widget(widget, "status")>
${""?left_pad(indent)}      <span class="tile-status">{{ ${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))} }}</span>
    </#if>
${""?left_pad(indent)}    </div>
${""?left_pad(indent)}  </div>
${""?left_pad(indent)}</div>
</#macro>

<#--
群组画布 (Group Hub)
+-----------------------------------------------+
| [avatars]                                     |
|                                               |
| [primary]                                     |
| [tertiary]                                    |
|                                               |
| [tags]                               [status] |
+-----------------------------------------------+
-->
<#macro print_tile_group_hub widget indent=0>
${""?left_pad(indent)}<div class="tile tile-group-hub">
  <#if guidbase.has_child_widget(widget, "avatars")>
${""?left_pad(indent)}  <div class="tile-avatars"><img v-for="(av, idx) in ${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "avatars"))}" :key="idx" :src="av" class="tile-avatar-img" /></div>
  </#if>
  <#if guidbase.has_child_widget(widget, "primary")>
${""?left_pad(indent)}  <div class="tile-primary">{{ ${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))} }}</div>
  </#if>
  <#if guidbase.has_child_widget(widget, "tertiary")>
${""?left_pad(indent)}  <div class="tile-tertiary">{{ ${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "tertiary"))} }}</div>
  </#if>
${""?left_pad(indent)}  <div class="tile-row tile-footer">
  <#if guidbase.has_child_widget(widget, "tags")>
${""?left_pad(indent)}    <span class="tile-tags"><span v-for="(tag, idx) in ${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "tags"))}" :key="idx" class="tile-tag">{{ tag }}</span></span>
  </#if>
  <#if guidbase.has_child_widget(widget, "status")>
${""?left_pad(indent)}    <span class="tile-status">{{ ${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))} }}</span>
  </#if>
${""?left_pad(indent)}  </div>
${""?left_pad(indent)}</div>
</#macro>

<#--
极窄卡片 (Tall Sidebar Tile)
+-------------------+
| [status]          |
|                   |
| +---------------+ |
| |    [image]    | |
| +---------------+ |
|                   |
| [primary]         |
| [secondary]       |
|                   |
| [tags]            |
|                   |
| [avatars]         |
+-------------------+
-->
<#macro print_tile_tall_sidebar widget indent=0>
${""?left_pad(indent)}<div class="tile tile-tall-sidebar">
  <#if guidbase.has_child_widget(widget, "status")>
${""?left_pad(indent)}  <div class="tile-status">{{ ${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))} }}</div>
  </#if>
  <#if guidbase.has_child_widget(widget, "image")>
${""?left_pad(indent)}  <div class="tile-image-wrap">
${""?left_pad(indent)}    <div class="tile-image">
${""?left_pad(indent)}      <img :src="${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "image"))}" alt="" />
${""?left_pad(indent)}    </div>
${""?left_pad(indent)}  </div>
  </#if>
  <#if guidbase.has_child_widget(widget, "primary")>
${""?left_pad(indent)}  <div class="tile-primary">{{ ${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))} }}</div>
  </#if>
  <#if guidbase.has_child_widget(widget, "secondary")>
${""?left_pad(indent)}  <div class="tile-secondary">{{ ${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "secondary"))} }}</div>
  </#if>
  <#if guidbase.has_child_widget(widget, "tags")>
${""?left_pad(indent)}  <div class="tile-tags"><span v-for="(tag, idx) in ${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "tags"))}" :key="idx" class="tile-tag">{{ tag }}</span></div>
  </#if>
  <#if guidbase.has_child_widget(widget, "avatars")>
${""?left_pad(indent)}  <div class="tile-avatars"><img v-for="(av, idx) in ${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "avatars"))}" :key="idx" :src="av" class="tile-avatar-img" /></div>
  </#if>
${""?left_pad(indent)}</div>
</#macro>

<#--
分栏对账 (Justified Meta Card)
+-----------------------------------------------+
| [primary]                        [start time] |
| [secondary]                        [end time] |
|                                               |
| [avatar]                             [status] |
+-----------------------------------------------+
-->
<#macro print_tile_justified_meta widget indent=0>
${""?left_pad(indent)}<div class="tile tile-justified-meta">
${""?left_pad(indent)}  <div class="tile-row tile-justified">
  <#if guidbase.has_child_widget(widget, "primary")>
${""?left_pad(indent)}    <span class="tile-primary">{{ ${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))} }}</span>
  </#if>
  <#if guidbase.has_child_widget(widget, "start_time")>
${""?left_pad(indent)}    <span class="tile-start-time">{{ ${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "start_time"))} }}</span>
  </#if>
${""?left_pad(indent)}  </div>
${""?left_pad(indent)}  <div class="tile-row tile-justified">
  <#if guidbase.has_child_widget(widget, "secondary")>
${""?left_pad(indent)}    <span class="tile-secondary">{{ ${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "secondary"))} }}</span>
  </#if>
  <#if guidbase.has_child_widget(widget, "end_time")>
${""?left_pad(indent)}    <span class="tile-end-time">{{ ${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "end_time"))} }}</span>
  </#if>
${""?left_pad(indent)}  </div>
${""?left_pad(indent)}  <div class="tile-row tile-justified">
  <#if guidbase.has_child_widget(widget, "avatar")>
${""?left_pad(indent)}    <div class="tile-avatar">
${""?left_pad(indent)}      <img :src="${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "avatar"))}" alt="" />
${""?left_pad(indent)}    </div>
  </#if>
  <#if guidbase.has_child_widget(widget, "status")>
${""?left_pad(indent)}    <span class="tile-status">{{ ${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))} }}</span>
  </#if>
${""?left_pad(indent)}  </div>
${""?left_pad(indent)}</div>
</#macro>

<#--
多维仪表 (Multidimensional Board)
+-----------------------------------------------+
| [status]                 [start time]         |
| +--------------------+   +------------------+ |
| | [primary]          |   | [secondary]      | |
| | [tertiary]         |   | [tags]           | |
| +--------------------+   +------------------+ |
| [avatars]                                     |
+-----------------------------------------------+
-->
<#macro print_tile_multidimensional_board widget indent=0>
${""?left_pad(indent)}<div class="tile tile-multidimensional-board">
${""?left_pad(indent)}  <div class="tile-row tile-header">
  <#if guidbase.has_child_widget(widget, "status")>
${""?left_pad(indent)}    <span class="tile-status">{{ ${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))} }}</span>
  </#if>
  <#if guidbase.has_child_widget(widget, "start_time")>
${""?left_pad(indent)}    <span class="tile-start-time">{{ ${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "start_time"))} }}</span>
  </#if>
${""?left_pad(indent)}  </div>
${""?left_pad(indent)}  <div class="tile-row tile-cols">
${""?left_pad(indent)}    <div class="tile-col">
    <#if guidbase.has_child_widget(widget, "primary")>
${""?left_pad(indent)}      <div class="tile-primary">{{ ${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))} }}</div>
    </#if>
    <#if guidbase.has_child_widget(widget, "tertiary")>
${""?left_pad(indent)}      <div class="tile-tertiary">{{ ${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "tertiary"))} }}</div>
    </#if>
${""?left_pad(indent)}    </div>
${""?left_pad(indent)}    <div class="tile-col">
    <#if guidbase.has_child_widget(widget, "secondary")>
${""?left_pad(indent)}      <div class="tile-secondary">{{ ${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "secondary"))} }}</div>
    </#if>
    <#if guidbase.has_child_widget(widget, "tags")>
${""?left_pad(indent)}      <div class="tile-tags"><span v-for="(tag, idx) in ${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "tags"))}" :key="idx" class="tile-tag">{{ tag }}</span></div>
    </#if>
${""?left_pad(indent)}    </div>
${""?left_pad(indent)}  </div>
  <#if guidbase.has_child_widget(widget, "avatars")>
${""?left_pad(indent)}  <div class="tile-avatars"><img v-for="(av, idx) in ${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "avatars"))}" :key="idx" :src="av" class="tile-avatar-img" /></div>
  </#if>
${""?left_pad(indent)}</div>
</#macro>

<#--
播放媒体 (Media Player Tile)
+-----------------------------------------------+
| +-------+  [primary]                          |
| | image |  [secondary]                        |
| +-------+  [start time] ---------- [end time] |
|                                               |
| [avatar]                             [status] |
+-----------------------------------------------+
-->
<#macro print_tile_media_player widget indent=0>
${""?left_pad(indent)}<div class="tile tile-media-player">
${""?left_pad(indent)}  <div class="tile-row">
  <#if guidbase.has_child_widget(widget, "image")>
${""?left_pad(indent)}    <div class="tile-image">
${""?left_pad(indent)}      <img :src="${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "image"))}" alt="" />
${""?left_pad(indent)}    </div>
  </#if>
${""?left_pad(indent)}    <div class="tile-body">
    <#if guidbase.has_child_widget(widget, "primary")>
${""?left_pad(indent)}      <div class="tile-primary">{{ ${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))} }}</div>
    </#if>
    <#if guidbase.has_child_widget(widget, "secondary")>
${""?left_pad(indent)}      <div class="tile-secondary">{{ ${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "secondary"))} }}</div>
    </#if>
    <#if guidbase.has_child_widget(widget, "start_time") || guidbase.has_child_widget(widget, "end_time")>
${""?left_pad(indent)}      <div class="tile-progress">
      <#if guidbase.has_child_widget(widget, "start_time")><span>{{ ${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "start_time"))} }}</span></#if>
${""?left_pad(indent)}      <span class="tile-progress-bar">──────────</span>
      <#if guidbase.has_child_widget(widget, "end_time")><span>{{ ${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "end_time"))} }}</span></#if>
${""?left_pad(indent)}      </div>
    </#if>
${""?left_pad(indent)}    </div>
${""?left_pad(indent)}  </div>
${""?left_pad(indent)}  <div class="tile-row tile-footer">
  <#if guidbase.has_child_widget(widget, "avatar")>
${""?left_pad(indent)}    <div class="tile-avatar">
${""?left_pad(indent)}      <img :src="${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "avatar"))}" alt="" />
${""?left_pad(indent)}    </div>
  </#if>
  <#if guidbase.has_child_widget(widget, "status")>
${""?left_pad(indent)}    <span class="tile-status">{{ ${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))} }}</span>
  </#if>
${""?left_pad(indent)}  </div>
${""?left_pad(indent)}</div>
</#macro>

<#--
左锚点时间卡 (Left-Anchor Time Tile)
+-----------------------------------------------+
| [start time]                         [status] |
|                                               |
| [primary]                                     |
| [secondary]                                   |
| [avatar]                                      |
+-----------------------------------------------+
-->
<#macro print_tile_left_anchor_time widget indent=0>
${""?left_pad(indent)}<div class="tile tile-left-anchor-time">
${""?left_pad(indent)}  <div class="tile-row tile-header">
  <#if guidbase.has_child_widget(widget, "start_time")>
${""?left_pad(indent)}    <span class="tile-start-time">{{ ${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "start_time"))} }}</span>
  </#if>
  <#if guidbase.has_child_widget(widget, "status")>
${""?left_pad(indent)}    <span class="tile-status">{{ ${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))} }}</span>
  </#if>
${""?left_pad(indent)}  </div>
  <#if guidbase.has_child_widget(widget, "primary")>
${""?left_pad(indent)}  <div class="tile-primary">{{ ${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))} }}</div>
  </#if>
  <#if guidbase.has_child_widget(widget, "secondary")>
${""?left_pad(indent)}  <div class="tile-secondary">{{ ${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "secondary"))} }}</div>
  </#if>
  <#if guidbase.has_child_widget(widget, "avatar")>
${""?left_pad(indent)}  <div class="tile-avatar">
${""?left_pad(indent)}    <img :src="${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "avatar"))}" alt="" />
${""?left_pad(indent)}  </div>
  </#if>
${""?left_pad(indent)}</div>
</#macro>

<#--
时间跨度卡 (Duration Span Tile)
+-----------------------------------------------+
| [start time] - [end time]                     |
|                                      [status] |
| [primary]                                     |
| [avatars]                                     |
+-----------------------------------------------+
-->
<#macro print_tile_duration_span widget indent=0>
${""?left_pad(indent)}<div class="tile tile-duration-span">
${""?left_pad(indent)}  <div class="tile-row tile-header">
  <#if guidbase.has_child_widget(widget, "start_time") || guidbase.has_child_widget(widget, "end_time")>
${""?left_pad(indent)}    <span class="tile-time">
    <#if guidbase.has_child_widget(widget, "start_time")><span>{{ ${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "start_time"))} }}</span></#if>
    <#if guidbase.has_child_widget(widget, "start_time") && guidbase.has_child_widget(widget, "end_time")> - </#if>
    <#if guidbase.has_child_widget(widget, "end_time")><span>{{ ${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "end_time"))} }}</span></#if>
${""?left_pad(indent)}    </span>
  </#if>
  <#if guidbase.has_child_widget(widget, "status")>
${""?left_pad(indent)}    <span class="tile-status">{{ ${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))} }}</span>
  </#if>
${""?left_pad(indent)}  </div>
  <#if guidbase.has_child_widget(widget, "primary")>
${""?left_pad(indent)}  <div class="tile-primary">{{ ${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))} }}</div>
  </#if>
  <#if guidbase.has_child_widget(widget, "avatars")>
${""?left_pad(indent)}  <div class="tile-avatars"><img v-for="(av, idx) in ${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "avatars"))}" :key="idx" :src="av" class="tile-avatar-img" /></div>
  </#if>
${""?left_pad(indent)}</div>
</#macro>

<#--
图文记录卡 (Media History Tile)
+-----------------------------------------------+
| [start time]                                  |
|                                               |
| +---------+  [primary]                        |
| |  image  |  [secondary]                      |
| +---------+  [tags]                           |
+-----------------------------------------------+
-->
<#macro print_tile_media_history widget indent=0>
${""?left_pad(indent)}<div class="tile tile-media-history">
  <#if guidbase.has_child_widget(widget, "start_time")>
${""?left_pad(indent)}  <div class="tile-start-time">{{ ${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "start_time"))} }}</div>
  </#if>
${""?left_pad(indent)}  <div class="tile-row">
  <#if guidbase.has_child_widget(widget, "image")>
${""?left_pad(indent)}    <div class="tile-image">
${""?left_pad(indent)}      <img :src="${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "image"))}" alt="" />
${""?left_pad(indent)}    </div>
  </#if>
${""?left_pad(indent)}    <div class="tile-body">
    <#if guidbase.has_child_widget(widget, "primary")>
${""?left_pad(indent)}      <div class="tile-primary">{{ ${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))} }}</div>
    </#if>
    <#if guidbase.has_child_widget(widget, "secondary")>
${""?left_pad(indent)}      <div class="tile-secondary">{{ ${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "secondary"))} }}</div>
    </#if>
    <#if guidbase.has_child_widget(widget, "tags")>
${""?left_pad(indent)}      <div class="tile-tags"><span v-for="(tag, idx) in ${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "tags"))}" :key="idx" class="tile-tag">{{ tag }}</span></div>
    </#if>
${""?left_pad(indent)}    </div>
${""?left_pad(indent)}  </div>
${""?left_pad(indent)}</div>
</#macro>

<#--
状态追踪卡 (Status Transition Tile)
+-----------------------------------------------+
| [start time]                         [status] |
|                                               |
| [primary]                                     |
| [avatar]     [secondary]                      |
+-----------------------------------------------+
-->
<#macro print_tile_status_transition widget indent=0>
${""?left_pad(indent)}<div class="tile tile-status-transition">
${""?left_pad(indent)}  <div class="tile-row tile-header">
  <#if guidbase.has_child_widget(widget, "start_time")>
${""?left_pad(indent)}    <span class="tile-start-time">{{ ${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "start_time"))} }}</span>
  </#if>
  <#if guidbase.has_child_widget(widget, "status")>
${""?left_pad(indent)}    <span class="tile-status">{{ ${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))} }}</span>
  </#if>
${""?left_pad(indent)}  </div>
  <#if guidbase.has_child_widget(widget, "primary")>
${""?left_pad(indent)}  <div class="tile-primary">{{ ${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))} }}</div>
  </#if>
${""?left_pad(indent)}  <div class="tile-row">
  <#if guidbase.has_child_widget(widget, "avatar")>
${""?left_pad(indent)}    <div class="tile-avatar">
${""?left_pad(indent)}      <img :src="${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "avatar"))}" alt="" />
${""?left_pad(indent)}    </div>
  </#if>
  <#if guidbase.has_child_widget(widget, "secondary")>
${""?left_pad(indent)}    <span class="tile-secondary">{{ ${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "secondary"))} }}</span>
  </#if>
${""?left_pad(indent)}  </div>
${""?left_pad(indent)}</div>
</#macro>
<#--
极简时间单元 (Compact Time Tile)
+-----------------------------------------------+
| [start time]  |  [status]  |  [primary]       |
| [tags]                                        |
+-----------------------------------------------+
-->
<#macro print_tile_compact_time widget indent=0>
${""?left_pad(indent)}<div class="tile tile-compact-time">
${""?left_pad(indent)}  <div class="tile-row tile-inline">
  <#if guidbase.has_child_widget(widget, "start_time")>
${""?left_pad(indent)}    <span class="tile-start-time">{{ ${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "start_time"))} }}</span>
${""?left_pad(indent)}    <span class="tile-sep">|</span>
  </#if>
  <#if guidbase.has_child_widget(widget, "status")>
${""?left_pad(indent)}    <span class="tile-status">{{ ${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))} }}</span>
${""?left_pad(indent)}    <span class="tile-sep">|</span>
  </#if>
  <#if guidbase.has_child_widget(widget, "primary")>
${""?left_pad(indent)}    <span class="tile-primary">{{ ${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))} }}</span>
  </#if>
${""?left_pad(indent)}  </div>
  <#if guidbase.has_child_widget(widget, "tags")>
${""?left_pad(indent)}  <div class="tile-tags"><span v-for="(tag, idx) in ${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "tags"))}" :key="idx" class="tile-tag">{{ tag }}</span></div>
  </#if>
${""?left_pad(indent)}</div>
</#macro>

<#--
横向流单元 (Horizontal Flow Tile)
+-----------------------------------+
| [start time]                      |
|                                   |
| [primary]                         |
| [status]                          |
+-----------------------------------+
-->
<#macro print_tile_horizontal_flow widget indent=0>
${""?left_pad(indent)}<div class="tile tile-horizontal-flow">
  <#if guidbase.has_child_widget(widget, "start_time")>
${""?left_pad(indent)}  <div class="tile-start-time">{{ ${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "start_time"))} }}</div>
  </#if>
  <#if guidbase.has_child_widget(widget, "primary")>
${""?left_pad(indent)}  <div class="tile-primary">{{ ${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))} }}</div>
  </#if>
  <#if guidbase.has_child_widget(widget, "status")>
${""?left_pad(indent)}  <span class="tile-status">{{ ${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))} }}</span>
  </#if>
${""?left_pad(indent)}</div>
</#macro>

<#--
右偏置节点 (Right-Biased Node Tile)
+-----------------------------------+
|                      [start time] |
|                                   |
| [primary]                         |
| [tags]                            |
+-----------------------------------+
-->
<#macro print_tile_right_biased_node widget indent=0>
${""?left_pad(indent)}<div class="tile tile-right-biased-node">
${""?left_pad(indent)}  <div class="tile-row tile-header tile-right">
  <#if guidbase.has_child_widget(widget, "start_time")>
${""?left_pad(indent)}    <span class="tile-start-time">{{ ${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "start_time"))} }}</span>
  </#if>
${""?left_pad(indent)}  </div>
  <#if guidbase.has_child_widget(widget, "primary")>
${""?left_pad(indent)}  <div class="tile-primary">{{ ${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))} }}</div>
  </#if>
  <#if guidbase.has_child_widget(widget, "tags")>
${""?left_pad(indent)}  <div class="tile-tags"><span v-for="(tag, idx) in ${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "tags"))}" :key="idx" class="tile-tag">{{ tag }}</span></div>
  </#if>
${""?left_pad(indent)}</div>
</#macro>

<#--
左偏置节点 (Left-Biased Node Tile)
+-----------------------------------+
| [start time]                      |
|                                   |
|                       [primary]   |
|                            [tags] |
+-----------------------------------+
-->
<#macro print_tile_left_biased_node widget indent=0>
${""?left_pad(indent)}<div class="tile tile-left-biased-node">
${""?left_pad(indent)}  <div class="tile-row tile-header tile-left">
  <#if guidbase.has_child_widget(widget, "start_time")>
${""?left_pad(indent)}    <span class="tile-start-time">{{ ${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "start_time"))} }}</span>
  </#if>
${""?left_pad(indent)}  </div>
  <#if guidbase.has_child_widget(widget, "primary")>
${""?left_pad(indent)}  <div class="tile-primary tile-right">{{ ${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))} }}</div>
  </#if>
  <#if guidbase.has_child_widget(widget, "tags")>
${""?left_pad(indent)}  <div class="tile-tags tile-right"><span v-for="(tag, idx) in ${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "tags"))}" :key="idx" class="tile-tag">{{ tag }}</span></div>
  </#if>
${""?left_pad(indent)}</div>
</#macro>

<#--
内置时间轴 (Internal Chronology)
+-----------------------------------------------+
| [start time]                                  |
| [primary]                                     |
|   |                                           |
| [end time]                                    |
| [secondary]                          [status] |
+-----------------------------------------------+
-->
<#macro print_tile_internal_chronology widget indent=0>
${""?left_pad(indent)}<div class="tile tile-internal-chronology">
  <#if guidbase.has_child_widget(widget, "start_time")>
${""?left_pad(indent)}  <div class="tile-start-time">{{ ${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "start_time"))} }}</div>
  </#if>
  <#if guidbase.has_child_widget(widget, "primary")>
${""?left_pad(indent)}  <div class="tile-primary">{{ ${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))} }}</div>
  </#if>
${""?left_pad(indent)}  <div class="tile-timeline-line">
${""?left_pad(indent)}    <span class="tile-timeline-indent">│</span>
  </div>
  <#if guidbase.has_child_widget(widget, "end_time")>
${""?left_pad(indent)}  <div class="tile-end-time">{{ ${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "end_time"))} }}</div>
  </#if>
${""?left_pad(indent)}  <div class="tile-row">
  <#if guidbase.has_child_widget(widget, "secondary")>
${""?left_pad(indent)}    <span class="tile-secondary">{{ ${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "secondary"))} }}</span>
  </#if>
  <#if guidbase.has_child_widget(widget, "status")>
${""?left_pad(indent)}    <span class="tile-status">{{ ${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))} }}</span>
  </#if>
${""?left_pad(indent)}  </div>
${""?left_pad(indent)}</div>
</#macro>

<#--
三段分步 (Three-Stage Segment)
+-----------------------------------------------+
| [start time]     >> [tags]       >> [end time] |
|                                               |
| [primary]        >> [secondary]  >> [status]   |
+-----------------------------------------------+
-->
<#macro print_tile_three_stage_segment widget indent=0>
${""?left_pad(indent)}<div class="tile tile-three-stage-segment">
${""?left_pad(indent)}  <div class="tile-row tile-three-stage">
  <#if guidbase.has_child_widget(widget, "start_time")>
${""?left_pad(indent)}    <span class="tile-start-time">{{ ${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "start_time"))} }}</span>
${""?left_pad(indent)}    <span class="tile-stage-arrow">>></span>
  </#if>
  <#if guidbase.has_child_widget(widget, "tags")>
${""?left_pad(indent)}    <span class="tile-tags"><span v-for="(tag, idx) in ${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "tags"))}" :key="idx" class="tile-tag">{{ tag }}</span></span>
${""?left_pad(indent)}    <span class="tile-stage-arrow">>></span>
  </#if>
  <#if guidbase.has_child_widget(widget, "end_time")>
${""?left_pad(indent)}    <span class="tile-end-time">{{ ${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "end_time"))} }}</span>
  </#if>
${""?left_pad(indent)}  </div>
${""?left_pad(indent)}  <div class="tile-row tile-three-stage">
  <#if guidbase.has_child_widget(widget, "primary")>
${""?left_pad(indent)}    <span class="tile-primary">{{ ${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))} }}</span>
${""?left_pad(indent)}    <span class="tile-stage-arrow">>></span>
  </#if>
  <#if guidbase.has_child_widget(widget, "secondary")>
${""?left_pad(indent)}    <span class="tile-secondary">{{ ${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "secondary"))} }}</span>
${""?left_pad(indent)}    <span class="tile-stage-arrow">>></span>
  </#if>
  <#if guidbase.has_child_widget(widget, "status")>
${""?left_pad(indent)}    <span class="tile-status">{{ ${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))} }}</span>
  </#if>
${""?left_pad(indent)}  </div>
${""?left_pad(indent)}</div>
</#macro>

<#--
行式日志 (Horizontal Log)
+-----------------------------------------------+
| [avatar] | [start time] | [primary] | [status] |
+-----------------------------------------------+
-->
<#macro print_tile_horizontal_log widget indent=0>
${""?left_pad(indent)}<div class="tile tile-horizontal-log">
${""?left_pad(indent)}  <div class="tile-row tile-inline">
  <#if guidbase.has_child_widget(widget, "avatar")>
${""?left_pad(indent)}    <div class="tile-avatar">
${""?left_pad(indent)}      <img :src="${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "avatar"))}" alt="" />
${""?left_pad(indent)}    </div>
${""?left_pad(indent)}    <span class="tile-sep">|</span>
  </#if>
  <#if guidbase.has_child_widget(widget, "start_time")>
${""?left_pad(indent)}    <span class="tile-start-time">{{ ${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "start_time"))} }}</span>
${""?left_pad(indent)}    <span class="tile-sep">|</span>
  </#if>
  <#if guidbase.has_child_widget(widget, "primary")>
${""?left_pad(indent)}    <span class="tile-primary">{{ ${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))} }}</span>
${""?left_pad(indent)}    <span class="tile-sep">|</span>
  </#if>
  <#if guidbase.has_child_widget(widget, "status")>
${""?left_pad(indent)}    <span class="tile-status">{{ ${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))} }}</span>
  </#if>
${""?left_pad(indent)}  </div>
${""?left_pad(indent)}</div>
</#macro>

<#--
卡片式简讯 (Card Bulletin)
+-----------------------------------------------+
| [tags]                                        |
|                                               |
| [primary]                                     |
| [tertiary]                                    |
|                                               |
| [avatars]                        [start time] |
+-----------------------------------------------+
-->
<#macro print_tile_bulletin widget indent=0>
${""?left_pad(indent)}<div class="tile tile-bulletin">
  <#if guidbase.has_child_widget(widget, "tags")>
${""?left_pad(indent)}  <div class="tile-tags"><span v-for="(tag, idx) in ${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "tags"))}" :key="idx" class="tile-tag">{{ tag }}</span></div>
  </#if>
  <#if guidbase.has_child_widget(widget, "primary")>
${""?left_pad(indent)}  <div class="tile-primary">{{ ${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))} }}</div>
  </#if>
  <#if guidbase.has_child_widget(widget, "tertiary")>
${""?left_pad(indent)}  <div class="tile-tertiary">{{ ${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "tertiary"))} }}</div>
  </#if>
${""?left_pad(indent)}  <div class="tile-row tile-footer">
  <#if guidbase.has_child_widget(widget, "avatars")>
${""?left_pad(indent)}    <div class="tile-avatars"><img v-for="(av, idx) in ${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "avatars"))}" :key="idx" :src="av" class="tile-avatar-img" /></div>
  </#if>
  <#if guidbase.has_child_widget(widget, "start_time")>
${""?left_pad(indent)}    <span class="tile-start-time">{{ ${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "start_time"))} }}</span>
  </#if>
${""?left_pad(indent)}  </div>
${""?left_pad(indent)}</div>
</#macro>

<#--
时间印章 (Timestamp Stamp)
+===============================================+
| [background]                                  |
|                                  [start time] |
| [primary]                                     |
| [status]                                      |
+===============================================+
-->
<#macro print_tile_timestamp_stamp widget indent=0>
${""?left_pad(indent)}<div class="tile tile-timestamp-stamp">
  <#if guidbase.has_child_widget(widget, "background")>
${""?left_pad(indent)}  <div class="tile-background">
${""?left_pad(indent)}    <img :src="${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "background"))}" alt="" />
${""?left_pad(indent)}  </div>
  </#if>
${""?left_pad(indent)}  <div class="tile-overlay">
  <#if guidbase.has_child_widget(widget, "start_time")>
${""?left_pad(indent)}    <div class="tile-start-time tile-right">{{ ${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "start_time"))} }}</div>
  </#if>
  <#if guidbase.has_child_widget(widget, "primary")>
${""?left_pad(indent)}    <div class="tile-primary">{{ ${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))} }}</div>
  </#if>
  <#if guidbase.has_child_widget(widget, "status")>
${""?left_pad(indent)}    <span class="tile-status">{{ ${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))} }}</span>
  </#if>
${""?left_pad(indent)}  </div>
${""?left_pad(indent)}</div>
</#macro>

<#--
精简对话 (Compact Chat)
+-----------------------------------------------+
| +--------+  [primary]            [start time] |
| | avatar |  [secondary]                       |
| +--------+                                    |
+-----------------------------------------------+
-->
<#macro print_tile_compact_chat widget indent=0>
${""?left_pad(indent)}<div class="tile tile-compact-chat">
${""?left_pad(indent)}  <div class="tile-row">
  <#if guidbase.has_child_widget(widget, "avatar")>
${""?left_pad(indent)}    <div class="tile-avatar">
${""?left_pad(indent)}      <img :src="${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "avatar"))}" alt="" />
${""?left_pad(indent)}    </div>
  </#if>
${""?left_pad(indent)}    <div class="tile-body">
${""?left_pad(indent)}      <div class="tile-row tile-header">
    <#if guidbase.has_child_widget(widget, "primary")>
${""?left_pad(indent)}        <span class="tile-primary">{{ ${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))} }}</span>
    </#if>
    <#if guidbase.has_child_widget(widget, "start_time")>
${""?left_pad(indent)}        <span class="tile-start-time">{{ ${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "start_time"))} }}</span>
    </#if>
${""?left_pad(indent)}      </div>
    <#if guidbase.has_child_widget(widget, "secondary")>
${""?left_pad(indent)}      <div class="tile-secondary">{{ ${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "secondary"))} }}</div>
    </#if>
${""?left_pad(indent)}    </div>
${""?left_pad(indent)}  </div>
${""?left_pad(indent)}</div>
</#macro>

<#--
侧图时间舱 (Side-Image Time Capsule)
+-----------------------------------------------+
| [start time]                                  |
| +--------------------+   +------------------+ |
| | [primary]          |   | [image]          | |
| | [secondary]        |   |                  | |
| +--------------------+   +------------------+ |
|                                      [status] |
+-----------------------------------------------+
-->
<#macro print_tile_side_image_time_capsule widget indent=0>
${""?left_pad(indent)}<div class="tile tile-side-image-time-capsule">
  <#if guidbase.has_child_widget(widget, "start_time")>
${""?left_pad(indent)}  <div class="tile-start-time">{{ ${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "start_time"))} }}</div>
  </#if>
${""?left_pad(indent)}  <div class="tile-row tile-cols">
${""?left_pad(indent)}    <div class="tile-col">
    <#if guidbase.has_child_widget(widget, "primary")>
${""?left_pad(indent)}      <div class="tile-primary">{{ ${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))} }}</div>
    </#if>
    <#if guidbase.has_child_widget(widget, "secondary")>
${""?left_pad(indent)}      <div class="tile-secondary">{{ ${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "secondary"))} }}</div>
    </#if>
${""?left_pad(indent)}    </div>
${""?left_pad(indent)}    <div class="tile-col">
    <#if guidbase.has_child_widget(widget, "image")>
${""?left_pad(indent)}      <div class="tile-image">
${""?left_pad(indent)}        <img :src="${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "image"))}" alt="" />
${""?left_pad(indent)}      </div>
    </#if>
${""?left_pad(indent)}    </div>
${""?left_pad(indent)}  </div>
  <#if guidbase.has_child_widget(widget, "status")>
${""?left_pad(indent)}  <div class="tile-row tile-right">
${""?left_pad(indent)}    <span class="tile-status">{{ ${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))} }}</span>
${""?left_pad(indent)}  </div>
  </#if>
${""?left_pad(indent)}</div>
</#macro>

<#--
标签终点节点 (Multi-Tag End Node)
+-----------------------------------------------+
| [tags] [tags]                      [end time] |
|                                               |
| [primary]                                     |
| [avatars]                            [status] |
+-----------------------------------------------+
-->
<#macro print_tile_multi_tag_end_node widget indent=0>
${""?left_pad(indent)}<div class="tile tile-multi-tag-end-node">
${""?left_pad(indent)}  <div class="tile-row tile-header">
  <#if guidbase.has_child_widget(widget, "tags")>
${""?left_pad(indent)}    <span class="tile-tags"><span v-for="(tag, idx) in ${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "tags"))}" :key="idx" class="tile-tag">{{ tag }}</span></span>
  </#if>
  <#if guidbase.has_child_widget(widget, "end_time")>
${""?left_pad(indent)}    <span class="tile-end-time">{{ ${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "end_time"))} }}</span>
  </#if>
${""?left_pad(indent)}  </div>
  <#if guidbase.has_child_widget(widget, "primary")>
${""?left_pad(indent)}  <div class="tile-primary">{{ ${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))} }}</div>
  </#if>
${""?left_pad(indent)}  <div class="tile-row tile-footer">
  <#if guidbase.has_child_widget(widget, "avatars")>
${""?left_pad(indent)}    <div class="tile-avatars"><img v-for="(av, idx) in ${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "avatars"))}" :key="idx" :src="av" class="tile-avatar-img" /></div>
  </#if>
  <#if guidbase.has_child_widget(widget, "status")>
${""?left_pad(indent)}    <span class="tile-status">{{ ${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))} }}</span>
  </#if>
${""?left_pad(indent)}  </div>
${""?left_pad(indent)}</div>
</#macro>
