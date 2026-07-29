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
  <#if (s > bestScore)>
    <#local bestScore = s>
    <#local bestName = "meeting_event">
  </#if>
  <#-- media_article: [image, tags, primary, secondary, tertiary] -->
  <#local s = ((has_image?then(2, 0)) + (has_tags?then(2, 0)) + (has_primary?then(2, 0)) + (has_secondary?then(2, 0)) + (has_tertiary?then(2, 0))) - ((has_avatar?then(1, 0)) + (has_avatars?then(1, 0)) + (has_status?then(1, 0)) + (has_start_time?then(1, 0)) + (has_end_time?then(1, 0)) + (has_background?then(1, 0)))>
  <#if (s > bestScore)>
    <#local bestScore = s>
    <#local bestName = "media_article">
  </#if>
  <#-- user_profile: [avatar, primary, secondary, status] -->
  <#local s = ((has_avatar?then(2, 0)) + (has_primary?then(2, 0)) + (has_secondary?then(2, 0)) + (has_status?then(2, 0))) - ((has_tertiary?then(1, 0)) + (has_image?then(1, 0)) + (has_avatars?then(1, 0)) + (has_tags?then(1, 0)) + (has_start_time?then(1, 0)) + (has_end_time?then(1, 0)) + (has_background?then(1, 0)))>
  <#if (s > bestScore)>
    <#local bestScore = s>
    <#local bestName = "user_profile">
  </#if>
  <#-- task_board: [tags, status, primary, avatars, end_time] -->
  <#local s = ((has_tags?then(2, 0)) + (has_status?then(2, 0)) + (has_primary?then(2, 0)) + (has_avatars?then(2, 0)) + (has_end_time?then(2, 0))) - ((has_secondary?then(1, 0)) + (has_tertiary?then(1, 0)) + (has_image?then(1, 0)) + (has_avatar?then(1, 0)) + (has_start_time?then(1, 0)) + (has_background?then(1, 0)))>
  <#if (s > bestScore)>
    <#local bestScore = s>
    <#local bestName = "task_board">
  </#if>
  <#-- promo_banner: [background, tags, primary, secondary, tertiary] -->
  <#local s = ((has_background?then(2, 0)) + (has_tags?then(2, 0)) + (has_primary?then(2, 0)) + (has_secondary?then(2, 0)) + (has_tertiary?then(2, 0))) - ((has_image?then(1, 0)) + (has_avatar?then(1, 0)) + (has_avatars?then(1, 0)) + (has_status?then(1, 0)) + (has_start_time?then(1, 0)) + (has_end_time?then(1, 0)))>
  <#if (s > bestScore)>
    <#local bestScore = s>
    <#local bestName = "promo_banner">
  </#if>
  <#-- compact_list: [status, primary, secondary, start_time] -->
  <#local s = ((has_status?then(2, 0)) + (has_primary?then(2, 0)) + (has_secondary?then(2, 0)) + (has_start_time?then(2, 0))) - ((has_tertiary?then(1, 0)) + (has_image?then(1, 0)) + (has_avatar?then(1, 0)) + (has_avatars?then(1, 0)) + (has_tags?then(1, 0)) + (has_end_time?then(1, 0)) + (has_background?then(1, 0)))>
  <#if (s > bestScore)>
    <#local bestScore = s>
    <#local bestName = "compact_list">
  </#if>
  <#-- split_content: [image, tags, primary, avatars, start_time] -->
  <#local s = ((has_image?then(2, 0)) + (has_tags?then(2, 0)) + (has_primary?then(2, 0)) + (has_avatars?then(2, 0)) + (has_start_time?then(2, 0))) - ((has_secondary?then(1, 0)) + (has_tertiary?then(1, 0)) + (has_avatar?then(1, 0)) + (has_status?then(1, 0)) + (has_end_time?then(1, 0)) + (has_background?then(1, 0)))>
  <#if (s > bestScore)>
    <#local bestScore = s>
    <#local bestName = "split_content">
  </#if>
  <#-- notification: [status, primary, tertiary] -->
  <#local s = ((has_status?then(2, 0)) + (has_primary?then(2, 0)) + (has_tertiary?then(2, 0))) - ((has_secondary?then(1, 0)) + (has_image?then(1, 0)) + (has_avatar?then(1, 0)) + (has_avatars?then(1, 0)) + (has_tags?then(1, 0)) + (has_start_time?then(1, 0)) + (has_end_time?then(1, 0)) + (has_background?then(1, 0)))>
  <#if (s > bestScore)>
    <#local bestScore = s>
    <#local bestName = "notification">
  </#if>
  <#-- hero_profile: [background, avatar, primary, secondary] -->
  <#local s = ((has_background?then(2, 0)) + (has_avatar?then(2, 0)) + (has_primary?then(2, 0)) + (has_secondary?then(2, 0))) - ((has_tertiary?then(1, 0)) + (has_image?then(1, 0)) + (has_avatars?then(1, 0)) + (has_tags?then(1, 0)) + (has_status?then(1, 0)) + (has_start_time?then(1, 0)) + (has_end_time?then(1, 0)))>
  <#if (s > bestScore)>
    <#local bestScore = s>
    <#local bestName = "hero_profile">
  </#if>
  <#-- timeline_node: [start_time, end_time, primary, secondary, tertiary, tags] -->
  <#local s = ((has_start_time?then(2, 0)) + (has_end_time?then(2, 0)) + (has_primary?then(2, 0)) + (has_secondary?then(2, 0)) + (has_tertiary?then(2, 0)) + (has_tags?then(2, 0))) - ((has_image?then(1, 0)) + (has_avatar?then(1, 0)) + (has_avatars?then(1, 0)) + (has_status?then(1, 0)) + (has_background?then(1, 0)))>
  <#if (s > bestScore)>
    <#local bestScore = s>
    <#local bestName = "timeline_node">
  </#if>
  <#-- message: [avatar, primary, secondary, tertiary, start_time] -->
  <#local s = ((has_avatar?then(2, 0)) + (has_primary?then(2, 0)) + (has_secondary?then(2, 0)) + (has_tertiary?then(2, 0)) + (has_start_time?then(2, 0))) - ((has_image?then(1, 0)) + (has_avatars?then(1, 0)) + (has_tags?then(1, 0)) + (has_status?then(1, 0)) + (has_end_time?then(1, 0)) + (has_background?then(1, 0)))>
  <#if (s > bestScore)>
    <#local bestScore = s>
    <#local bestName = "message">
  </#if>
  <#-- ticket: [background, primary, status, start_time, end_time] -->
  <#local s = ((has_background?then(2, 0)) + (has_primary?then(2, 0)) + (has_status?then(2, 0)) + (has_start_time?then(2, 0)) + (has_end_time?then(2, 0))) - ((has_secondary?then(1, 0)) + (has_tertiary?then(1, 0)) + (has_image?then(1, 0)) + (has_avatar?then(1, 0)) + (has_avatars?then(1, 0)) + (has_tags?then(1, 0)))>
  <#if (s > bestScore)>
    <#local bestScore = s>
    <#local bestName = "ticket">
  </#if>
  <#-- dense_detail_list: [image, primary, secondary, tertiary, tags, status] -->
  <#local s = ((has_image?then(2, 0)) + (has_primary?then(2, 0)) + (has_secondary?then(2, 0)) + (has_tertiary?then(2, 0)) + (has_tags?then(2, 0)) + (has_status?then(2, 0))) - ((has_avatar?then(1, 0)) + (has_avatars?then(1, 0)) + (has_start_time?then(1, 0)) + (has_end_time?then(1, 0)) + (has_background?then(1, 0)))>
  <#if (s > bestScore)>
    <#local bestScore = s>
    <#local bestName = "dense_detail_list">
  </#if>
  <#-- vertical_poster: [image, primary, secondary, start_time, end_time, avatars] -->
  <#local s = ((has_image?then(2, 0)) + (has_primary?then(2, 0)) + (has_secondary?then(2, 0)) + (has_start_time?then(2, 0)) + (has_end_time?then(2, 0)) + (has_avatars?then(2, 0))) - ((has_tertiary?then(1, 0)) + (has_avatar?then(1, 0)) + (has_tags?then(1, 0)) + (has_status?then(1, 0)) + (has_background?then(1, 0)))>
  <#if (s > bestScore)>
    <#local bestScore = s>
    <#local bestName = "vertical_poster">
  </#if>
  <#-- issue_detail: [tags, status, primary, secondary, tertiary, avatar, end_time] -->
  <#local s = ((has_tags?then(2, 0)) + (has_status?then(2, 0)) + (has_primary?then(2, 0)) + (has_secondary?then(2, 0)) + (has_tertiary?then(2, 0)) + (has_avatar?then(2, 0)) + (has_end_time?then(2, 0))) - ((has_image?then(1, 0)) + (has_avatars?then(1, 0)) + (has_start_time?then(1, 0)) + (has_background?then(1, 0)))>
  <#if (s > bestScore)>
    <#local bestScore = s>
    <#local bestName = "issue_detail">
  </#if>
  <#-- team_directory: [primary, secondary, avatars, tags] -->
  <#local s = ((has_primary?then(2, 0)) + (has_secondary?then(2, 0)) + (has_avatars?then(2, 0)) + (has_tags?then(2, 0))) - ((has_tertiary?then(1, 0)) + (has_image?then(1, 0)) + (has_avatar?then(1, 0)) + (has_status?then(1, 0)) + (has_start_time?then(1, 0)) + (has_end_time?then(1, 0)) + (has_background?then(1, 0)))>
  <#if (s > bestScore)>
    <#local bestScore = s>
    <#local bestName = "team_directory">
  </#if>
  <#-- immersive_highlight: [background, status, primary] -->
  <#local s = ((has_background?then(2, 0)) + (has_status?then(2, 0)) + (has_primary?then(2, 0))) - ((has_secondary?then(1, 0)) + (has_tertiary?then(1, 0)) + (has_image?then(1, 0)) + (has_avatar?then(1, 0)) + (has_avatars?then(1, 0)) + (has_tags?then(1, 0)) + (has_start_time?then(1, 0)) + (has_end_time?then(1, 0)))>
  <#if (s > bestScore)>
    <#local bestScore = s>
    <#local bestName = "immersive_highlight">
  </#if>
  <#-- mini_status: [status, end_time, primary, tags] -->
  <#local s = ((has_status?then(2, 0)) + (has_end_time?then(2, 0)) + (has_primary?then(2, 0)) + (has_tags?then(2, 0))) - ((has_secondary?then(1, 0)) + (has_tertiary?then(1, 0)) + (has_image?then(1, 0)) + (has_avatar?then(1, 0)) + (has_avatars?then(1, 0)) + (has_start_time?then(1, 0)) + (has_background?then(1, 0)))>
  <#if (s > bestScore)>
    <#local bestScore = s>
    <#local bestName = "mini_status">
  </#if>
  <#-- dual_column_content: [primary, secondary, tertiary, tags, avatar, avatars] -->
  <#local s = ((has_primary?then(2, 0)) + (has_secondary?then(2, 0)) + (has_tertiary?then(2, 0)) + (has_tags?then(2, 0)) + (has_avatar?then(2, 0)) + (has_avatars?then(2, 0))) - ((has_image?then(1, 0)) + (has_status?then(1, 0)) + (has_start_time?then(1, 0)) + (has_end_time?then(1, 0)) + (has_background?then(1, 0)))>
  <#if (s > bestScore)>
    <#local bestScore = s>
    <#local bestName = "dual_column_content">
  </#if>
  <#-- gallery: [image, primary, avatars, status] -->
  <#local s = ((has_image?then(2, 0)) + (has_primary?then(2, 0)) + (has_avatars?then(2, 0)) + (has_status?then(2, 0))) - ((has_secondary?then(1, 0)) + (has_tertiary?then(1, 0)) + (has_avatar?then(1, 0)) + (has_tags?then(1, 0)) + (has_start_time?then(1, 0)) + (has_end_time?then(1, 0)) + (has_background?then(1, 0)))>
  <#if (s > bestScore)>
    <#local bestScore = s>
    <#local bestName = "gallery">
  </#if>
  <#-- key_metric: [tags, primary, secondary, status] -->
  <#local s = ((has_tags?then(2, 0)) + (has_primary?then(2, 0)) + (has_secondary?then(2, 0)) + (has_status?then(2, 0))) - ((has_tertiary?then(1, 0)) + (has_image?then(1, 0)) + (has_avatar?then(1, 0)) + (has_avatars?then(1, 0)) + (has_start_time?then(1, 0)) + (has_end_time?then(1, 0)) + (has_background?then(1, 0)))>
  <#if (s > bestScore)>
    <#local bestScore = s>
    <#local bestName = "key_metric">
  </#if>
  <#-- overlay_avatar: [image, avatar, primary, secondary] -->
  <#local s = ((has_image?then(2, 0)) + (has_avatar?then(2, 0)) + (has_primary?then(2, 0)) + (has_secondary?then(2, 0))) - ((has_tertiary?then(1, 0)) + (has_avatars?then(1, 0)) + (has_tags?then(1, 0)) + (has_status?then(1, 0)) + (has_start_time?then(1, 0)) + (has_end_time?then(1, 0)) + (has_background?then(1, 0)))>
  <#if (s > bestScore)>
    <#local bestScore = s>
    <#local bestName = "overlay_avatar">
  </#if>
  <#-- audit_log: [avatar, primary, secondary, start_time, status] -->
  <#local s = ((has_avatar?then(2, 0)) + (has_primary?then(2, 0)) + (has_secondary?then(2, 0)) + (has_start_time?then(2, 0)) + (has_status?then(2, 0))) - ((has_tertiary?then(1, 0)) + (has_image?then(1, 0)) + (has_avatars?then(1, 0)) + (has_tags?then(1, 0)) + (has_end_time?then(1, 0)) + (has_background?then(1, 0)))>
  <#if (s > bestScore)>
    <#local bestScore = s>
    <#local bestName = "audit_log">
  </#if>
  <#-- calendar_cell: [start_time, status, primary, avatars] -->
  <#local s = ((has_start_time?then(2, 0)) + (has_status?then(2, 0)) + (has_primary?then(2, 0)) + (has_avatars?then(2, 0))) - ((has_secondary?then(1, 0)) + (has_tertiary?then(1, 0)) + (has_image?then(1, 0)) + (has_avatar?then(1, 0)) + (has_tags?then(1, 0)) + (has_end_time?then(1, 0)) + (has_background?then(1, 0)))>
  <#if (s > bestScore)>
    <#local bestScore = s>
    <#local bestName = "calendar_cell">
  </#if>
  <#-- side_status: [status, primary, secondary, start_time] -->
  <#local s = ((has_status?then(2, 0)) + (has_primary?then(2, 0)) + (has_secondary?then(2, 0)) + (has_start_time?then(2, 0))) - ((has_tertiary?then(1, 0)) + (has_image?then(1, 0)) + (has_avatar?then(1, 0)) + (has_avatars?then(1, 0)) + (has_tags?then(1, 0)) + (has_end_time?then(1, 0)) + (has_background?then(1, 0)))>
  <#if (s > bestScore)>
    <#local bestScore = s>
    <#local bestName = "side_status">
  </#if>
  <#-- multi_tag: [tags, primary, secondary, end_time] -->
  <#local s = ((has_tags?then(2, 0)) + (has_primary?then(2, 0)) + (has_secondary?then(2, 0)) + (has_end_time?then(2, 0))) - ((has_tertiary?then(1, 0)) + (has_image?then(1, 0)) + (has_avatar?then(1, 0)) + (has_avatars?then(1, 0)) + (has_status?then(1, 0)) + (has_start_time?then(1, 0)) + (has_background?then(1, 0)))>
  <#if (s > bestScore)>
    <#local bestScore = s>
    <#local bestName = "multi_tag">
  </#if>
  <#-- shift_planner: [start_time, end_time, status, primary, avatars] -->
  <#local s = ((has_start_time?then(2, 0)) + (has_end_time?then(2, 0)) + (has_status?then(2, 0)) + (has_primary?then(2, 0)) + (has_avatars?then(2, 0))) - ((has_secondary?then(1, 0)) + (has_tertiary?then(1, 0)) + (has_image?then(1, 0)) + (has_avatar?then(1, 0)) + (has_tags?then(1, 0)) + (has_background?then(1, 0)))>
  <#if (s > bestScore)>
    <#local bestScore = s>
    <#local bestName = "shift_planner">
  </#if>
  <#-- social_post_feed: [avatar, primary, start_time, tertiary, image, avatars, tags] -->
  <#local s = ((has_avatar?then(2, 0)) + (has_primary?then(2, 0)) + (has_start_time?then(2, 0)) + (has_tertiary?then(2, 0)) + (has_image?then(2, 0)) + (has_avatars?then(2, 0)) + (has_tags?then(2, 0))) - ((has_secondary?then(1, 0)) + (has_status?then(1, 0)) + (has_end_time?then(1, 0)) + (has_background?then(1, 0)))>
  <#if (s > bestScore)>
    <#local bestScore = s>
    <#local bestName = "social_post_feed">
  </#if>
  <#-- product: [image, tags, primary, secondary, status, end_time] -->
  <#local s = ((has_image?then(2, 0)) + (has_tags?then(2, 0)) + (has_primary?then(2, 0)) + (has_secondary?then(2, 0)) + (has_status?then(2, 0)) + (has_end_time?then(2, 0))) - ((has_tertiary?then(1, 0)) + (has_avatar?then(1, 0)) + (has_avatars?then(1, 0)) + (has_start_time?then(1, 0)) + (has_background?then(1, 0)))>
  <#if (s > bestScore)>
    <#local bestScore = s>
    <#local bestName = "product">
  </#if>
  <#-- dual_profile_comparison: [avatar, status, primary, secondary, start_time, end_time] -->
  <#local s = ((has_avatar?then(2, 0)) + (has_status?then(2, 0)) + (has_primary?then(2, 0)) + (has_secondary?then(2, 0)) + (has_start_time?then(2, 0)) + (has_end_time?then(2, 0))) - ((has_tertiary?then(1, 0)) + (has_image?then(1, 0)) + (has_avatars?then(1, 0)) + (has_tags?then(1, 0)) + (has_background?then(1, 0)))>
  <#if (s > bestScore)>
    <#local bestScore = s>
    <#local bestName = "dual_profile_comparison">
  </#if>
  <#-- left_feature_image: [image, tags, primary, secondary, tertiary, status, avatars] -->
  <#local s = ((has_image?then(2, 0)) + (has_tags?then(2, 0)) + (has_primary?then(2, 0)) + (has_secondary?then(2, 0)) + (has_tertiary?then(2, 0)) + (has_status?then(2, 0)) + (has_avatars?then(2, 0))) - ((has_avatar?then(1, 0)) + (has_start_time?then(1, 0)) + (has_end_time?then(1, 0)) + (has_background?then(1, 0)))>
  <#if (s > bestScore)>
    <#local bestScore = s>
    <#local bestName = "left_feature_image">
  </#if>
  <#-- workflow_strip: [start_time, avatars, status, end_time, primary] -->
  <#local s = ((has_start_time?then(2, 0)) + (has_avatars?then(2, 0)) + (has_status?then(2, 0)) + (has_end_time?then(2, 0)) + (has_primary?then(2, 0))) - ((has_secondary?then(1, 0)) + (has_tertiary?then(1, 0)) + (has_image?then(1, 0)) + (has_avatar?then(1, 0)) + (has_tags?then(1, 0)) + (has_background?then(1, 0)))>
  <#if (s > bestScore)>
    <#local bestScore = s>
    <#local bestName = "workflow_strip">
  </#if>
  <#-- text_over_background: [background, tags, primary, avatar, secondary] -->
  <#local s = ((has_background?then(2, 0)) + (has_tags?then(2, 0)) + (has_primary?then(2, 0)) + (has_avatar?then(2, 0)) + (has_secondary?then(2, 0))) - ((has_tertiary?then(1, 0)) + (has_image?then(1, 0)) + (has_avatars?then(1, 0)) + (has_status?then(1, 0)) + (has_start_time?then(1, 0)) + (has_end_time?then(1, 0)))>
  <#if (s > bestScore)>
    <#local bestScore = s>
    <#local bestName = "text_over_background">
  </#if>
  <#-- micro_badge: [avatar, primary, status] -->
  <#local s = ((has_avatar?then(2, 0)) + (has_primary?then(2, 0)) + (has_status?then(2, 0))) - ((has_secondary?then(1, 0)) + (has_tertiary?then(1, 0)) + (has_image?then(1, 0)) + (has_avatars?then(1, 0)) + (has_tags?then(1, 0)) + (has_start_time?then(1, 0)) + (has_end_time?then(1, 0)) + (has_background?then(1, 0)))>
  <#if (s > bestScore)>
    <#local bestScore = s>
    <#local bestName = "micro_badge">
  </#if>
  <#-- stepped_process: [status, primary, secondary, start_time, end_time] -->
  <#local s = ((has_status?then(2, 0)) + (has_primary?then(2, 0)) + (has_secondary?then(2, 0)) + (has_start_time?then(2, 0)) + (has_end_time?then(2, 0))) - ((has_tertiary?then(1, 0)) + (has_image?then(1, 0)) + (has_avatar?then(1, 0)) + (has_avatars?then(1, 0)) + (has_tags?then(1, 0)) + (has_background?then(1, 0)))>
  <#if (s > bestScore)>
    <#local bestScore = s>
    <#local bestName = "stepped_process">
  </#if>
  <#-- stacked_overlay: [image, primary, secondary, status] -->
  <#local s = ((has_image?then(2, 0)) + (has_primary?then(2, 0)) + (has_secondary?then(2, 0)) + (has_status?then(2, 0))) - ((has_tertiary?then(1, 0)) + (has_avatar?then(1, 0)) + (has_avatars?then(1, 0)) + (has_tags?then(1, 0)) + (has_start_time?then(1, 0)) + (has_end_time?then(1, 0)) + (has_background?then(1, 0)))>
  <#if (s > bestScore)>
    <#local bestScore = s>
    <#local bestName = "stacked_overlay">
  </#if>
  <#-- group_hub: [avatars, primary, tertiary, tags, status] -->
  <#local s = ((has_avatars?then(2, 0)) + (has_primary?then(2, 0)) + (has_tertiary?then(2, 0)) + (has_tags?then(2, 0)) + (has_status?then(2, 0))) - ((has_secondary?then(1, 0)) + (has_image?then(1, 0)) + (has_avatar?then(1, 0)) + (has_start_time?then(1, 0)) + (has_end_time?then(1, 0)) + (has_background?then(1, 0)))>
  <#if (s > bestScore)>
    <#local bestScore = s>
    <#local bestName = "group_hub">
  </#if>
  <#-- tall_sidebar: [status, image, primary, secondary, tags, avatars] -->
  <#local s = ((has_status?then(2, 0)) + (has_image?then(2, 0)) + (has_primary?then(2, 0)) + (has_secondary?then(2, 0)) + (has_tags?then(2, 0)) + (has_avatars?then(2, 0))) - ((has_tertiary?then(1, 0)) + (has_avatar?then(1, 0)) + (has_start_time?then(1, 0)) + (has_end_time?then(1, 0)) + (has_background?then(1, 0)))>
  <#if (s > bestScore)>
    <#local bestScore = s>
    <#local bestName = "tall_sidebar">
  </#if>
  <#-- justified_meta: [primary, secondary, start_time, end_time, avatar, status] -->
  <#local s = ((has_primary?then(2, 0)) + (has_secondary?then(2, 0)) + (has_start_time?then(2, 0)) + (has_end_time?then(2, 0)) + (has_avatar?then(2, 0)) + (has_status?then(2, 0))) - ((has_tertiary?then(1, 0)) + (has_image?then(1, 0)) + (has_avatars?then(1, 0)) + (has_tags?then(1, 0)) + (has_background?then(1, 0)))>
  <#if (s > bestScore)>
    <#local bestScore = s>
    <#local bestName = "justified_meta">
  </#if>
  <#-- multidimensional_board: [status, start_time, primary, tertiary, secondary, tags, avatars] -->
  <#local s = ((has_status?then(2, 0)) + (has_start_time?then(2, 0)) + (has_primary?then(2, 0)) + (has_tertiary?then(2, 0)) + (has_secondary?then(2, 0)) + (has_tags?then(2, 0)) + (has_avatars?then(2, 0))) - ((has_image?then(1, 0)) + (has_avatar?then(1, 0)) + (has_end_time?then(1, 0)) + (has_background?then(1, 0)))>
  <#if (s > bestScore)>
    <#local bestScore = s>
    <#local bestName = "multidimensional_board">
  </#if>
  <#-- media_player: [image, primary, secondary, start_time, end_time, avatar, status] -->
  <#local s = ((has_image?then(2, 0)) + (has_primary?then(2, 0)) + (has_secondary?then(2, 0)) + (has_start_time?then(2, 0)) + (has_end_time?then(2, 0)) + (has_avatar?then(2, 0)) + (has_status?then(2, 0))) - ((has_tertiary?then(1, 0)) + (has_avatars?then(1, 0)) + (has_tags?then(1, 0)) + (has_background?then(1, 0)))>
  <#if (s > bestScore)>
    <#local bestScore = s>
    <#local bestName = "media_player">
  </#if>
  <#-- left_anchor_time: [start_time, status, primary, secondary, avatar] -->
  <#local s = ((has_start_time?then(2, 0)) + (has_status?then(2, 0)) + (has_primary?then(2, 0)) + (has_secondary?then(2, 0)) + (has_avatar?then(2, 0))) - ((has_tertiary?then(1, 0)) + (has_image?then(1, 0)) + (has_avatars?then(1, 0)) + (has_tags?then(1, 0)) + (has_end_time?then(1, 0)) + (has_background?then(1, 0)))>
  <#if (s > bestScore)>
    <#local bestScore = s>
    <#local bestName = "left_anchor_time">
  </#if>
  <#-- duration_span: [start_time, end_time, status, primary, avatars] -->
  <#local s = ((has_start_time?then(2, 0)) + (has_end_time?then(2, 0)) + (has_status?then(2, 0)) + (has_primary?then(2, 0)) + (has_avatars?then(2, 0))) - ((has_secondary?then(1, 0)) + (has_tertiary?then(1, 0)) + (has_image?then(1, 0)) + (has_avatar?then(1, 0)) + (has_tags?then(1, 0)) + (has_background?then(1, 0)))>
  <#if (s > bestScore)>
    <#local bestScore = s>
    <#local bestName = "duration_span">
  </#if>
  <#-- media_history: [start_time, image, primary, secondary, tags] -->
  <#local s = ((has_start_time?then(2, 0)) + (has_image?then(2, 0)) + (has_primary?then(2, 0)) + (has_secondary?then(2, 0)) + (has_tags?then(2, 0))) - ((has_tertiary?then(1, 0)) + (has_avatar?then(1, 0)) + (has_avatars?then(1, 0)) + (has_status?then(1, 0)) + (has_end_time?then(1, 0)) + (has_background?then(1, 0)))>
  <#if (s > bestScore)>
    <#local bestScore = s>
    <#local bestName = "media_history">
  </#if>
  <#-- status_transition: [start_time, status, primary, avatar, secondary] -->
  <#local s = ((has_start_time?then(2, 0)) + (has_status?then(2, 0)) + (has_primary?then(2, 0)) + (has_avatar?then(2, 0)) + (has_secondary?then(2, 0))) - ((has_tertiary?then(1, 0)) + (has_image?then(1, 0)) + (has_avatars?then(1, 0)) + (has_tags?then(1, 0)) + (has_end_time?then(1, 0)) + (has_background?then(1, 0)))>
  <#if (s > bestScore)>
    <#local bestScore = s>
    <#local bestName = "status_transition">
  </#if>
  <#-- compact_time: [start_time, status, primary, tags] -->
  <#local s = ((has_start_time?then(2, 0)) + (has_status?then(2, 0)) + (has_primary?then(2, 0)) + (has_tags?then(2, 0))) - ((has_secondary?then(1, 0)) + (has_tertiary?then(1, 0)) + (has_image?then(1, 0)) + (has_avatar?then(1, 0)) + (has_avatars?then(1, 0)) + (has_end_time?then(1, 0)) + (has_background?then(1, 0)))>
  <#if (s > bestScore)>
    <#local bestScore = s>
    <#local bestName = "compact_time">
  </#if>
  <#-- horizontal_flow: [start_time, primary, status] -->
  <#local s = ((has_start_time?then(2, 0)) + (has_primary?then(2, 0)) + (has_status?then(2, 0))) - ((has_secondary?then(1, 0)) + (has_tertiary?then(1, 0)) + (has_image?then(1, 0)) + (has_avatar?then(1, 0)) + (has_avatars?then(1, 0)) + (has_tags?then(1, 0)) + (has_end_time?then(1, 0)) + (has_background?then(1, 0)))>
  <#if (s > bestScore)>
    <#local bestScore = s>
    <#local bestName = "horizontal_flow">
  </#if>
  <#-- right_biased_node: [start_time, primary, tags] -->
  <#local s = ((has_start_time?then(2, 0)) + (has_primary?then(2, 0)) + (has_tags?then(2, 0))) - ((has_secondary?then(1, 0)) + (has_tertiary?then(1, 0)) + (has_image?then(1, 0)) + (has_avatar?then(1, 0)) + (has_avatars?then(1, 0)) + (has_status?then(1, 0)) + (has_end_time?then(1, 0)) + (has_background?then(1, 0)))>
  <#if (s > bestScore)>
    <#local bestScore = s>
    <#local bestName = "right_biased_node">
  </#if>
  <#-- left_biased_node: [start_time, primary, tags] -->
  <#local s = ((has_start_time?then(2, 0)) + (has_primary?then(2, 0)) + (has_tags?then(2, 0))) - ((has_secondary?then(1, 0)) + (has_tertiary?then(1, 0)) + (has_image?then(1, 0)) + (has_avatar?then(1, 0)) + (has_avatars?then(1, 0)) + (has_status?then(1, 0)) + (has_end_time?then(1, 0)) + (has_background?then(1, 0)))>
  <#if (s > bestScore)>
    <#local bestScore = s>
    <#local bestName = "left_biased_node">
  </#if>
  <#-- internal_chronology: [start_time, primary, end_time, secondary, status] -->
  <#local s = ((has_start_time?then(2, 0)) + (has_primary?then(2, 0)) + (has_end_time?then(2, 0)) + (has_secondary?then(2, 0)) + (has_status?then(2, 0))) - ((has_tertiary?then(1, 0)) + (has_image?then(1, 0)) + (has_avatar?then(1, 0)) + (has_avatars?then(1, 0)) + (has_tags?then(1, 0)) + (has_background?then(1, 0)))>
  <#if (s > bestScore)>
    <#local bestScore = s>
    <#local bestName = "internal_chronology">
  </#if>
  <#-- three_stage_segment: [start_time, tags, end_time, primary, secondary, status] -->
  <#local s = ((has_start_time?then(2, 0)) + (has_tags?then(2, 0)) + (has_end_time?then(2, 0)) + (has_primary?then(2, 0)) + (has_secondary?then(2, 0)) + (has_status?then(2, 0))) - ((has_tertiary?then(1, 0)) + (has_image?then(1, 0)) + (has_avatar?then(1, 0)) + (has_avatars?then(1, 0)) + (has_background?then(1, 0)))>
  <#if (s > bestScore)>
    <#local bestScore = s>
    <#local bestName = "three_stage_segment">
  </#if>
  <#-- horizontal_log: [avatar, start_time, primary, status] -->
  <#local s = ((has_avatar?then(2, 0)) + (has_start_time?then(2, 0)) + (has_primary?then(2, 0)) + (has_status?then(2, 0))) - ((has_secondary?then(1, 0)) + (has_tertiary?then(1, 0)) + (has_image?then(1, 0)) + (has_avatars?then(1, 0)) + (has_tags?then(1, 0)) + (has_end_time?then(1, 0)) + (has_background?then(1, 0)))>
  <#if (s > bestScore)>
    <#local bestScore = s>
    <#local bestName = "horizontal_log">
  </#if>
  <#-- bulletin: [tags, primary, tertiary, avatars, start_time] -->
  <#local s = ((has_tags?then(2, 0)) + (has_primary?then(2, 0)) + (has_tertiary?then(2, 0)) + (has_avatars?then(2, 0)) + (has_start_time?then(2, 0))) - ((has_secondary?then(1, 0)) + (has_image?then(1, 0)) + (has_avatar?then(1, 0)) + (has_status?then(1, 0)) + (has_end_time?then(1, 0)) + (has_background?then(1, 0)))>
  <#if (s > bestScore)>
    <#local bestScore = s>
    <#local bestName = "bulletin">
  </#if>
  <#-- timestamp_stamp: [background, start_time, primary, status] -->
  <#local s = ((has_background?then(2, 0)) + (has_start_time?then(2, 0)) + (has_primary?then(2, 0)) + (has_status?then(2, 0))) - ((has_secondary?then(1, 0)) + (has_tertiary?then(1, 0)) + (has_image?then(1, 0)) + (has_avatar?then(1, 0)) + (has_avatars?then(1, 0)) + (has_tags?then(1, 0)) + (has_end_time?then(1, 0)))>
  <#if (s > bestScore)>
    <#local bestScore = s>
    <#local bestName = "timestamp_stamp">
  </#if>
  <#-- compact_chat: [avatar, primary, secondary, start_time] -->
  <#local s = ((has_avatar?then(2, 0)) + (has_primary?then(2, 0)) + (has_secondary?then(2, 0)) + (has_start_time?then(2, 0))) - ((has_tertiary?then(1, 0)) + (has_image?then(1, 0)) + (has_avatars?then(1, 0)) + (has_tags?then(1, 0)) + (has_status?then(1, 0)) + (has_end_time?then(1, 0)) + (has_background?then(1, 0)))>
  <#if (s > bestScore)>
    <#local bestScore = s>
    <#local bestName = "compact_chat">
  </#if>
  <#-- side_image_time_capsule: [start_time, primary, secondary, image, status] -->
  <#local s = ((has_start_time?then(2, 0)) + (has_primary?then(2, 0)) + (has_secondary?then(2, 0)) + (has_image?then(2, 0)) + (has_status?then(2, 0))) - ((has_tertiary?then(1, 0)) + (has_avatar?then(1, 0)) + (has_avatars?then(1, 0)) + (has_tags?then(1, 0)) + (has_end_time?then(1, 0)) + (has_background?then(1, 0)))>
  <#if (s > bestScore)>
    <#local bestScore = s>
    <#local bestName = "side_image_time_capsule">
  </#if>
  <#-- multi_tag_end_node: [tags, end_time, primary, avatars, status] -->
  <#local s = ((has_tags?then(2, 0)) + (has_end_time?then(2, 0)) + (has_primary?then(2, 0)) + (has_avatars?then(2, 0)) + (has_status?then(2, 0))) - ((has_secondary?then(1, 0)) + (has_tertiary?then(1, 0)) + (has_image?then(1, 0)) + (has_avatar?then(1, 0)) + (has_start_time?then(1, 0)) + (has_background?then(1, 0)))>
  <#if (s > bestScore)>
    <#local bestScore = s>
    <#local bestName = "multi_tag_end_node">
  </#if>
  <#return bestName>
</#function>

<#--
 ###############################################################################
 ### 渲染布局瓦片组件 (Render Layout Tile Widget)
 ### 
 ### 根据组件的瓦片类型（tile name），动态路由并调用对应的具体瓦片渲染宏。
 ### 
 ### 路由与渲染规则：
 ### - 首先尝试从传入的 widget 中获取 "tile" 属性值，若不存在则调用 guess_tile(widget) 进行推断。
 ### - 根据解析出的瓦片类型名称（tilename），通过多重条件分支（if-elseif）进行分发。
 ### - 最终调用 @tile 命名空间下对应的具体渲染宏，并传递 widget 对象与缩进层级。
 ### 
 ### @param widget  瓦片组件对象 (Widget Object)
 ### @param indent  缩进层级，默认值为 0 (Indentation Level, Integer, Default: 0)
 ###############################################################################
 -->
<#macro print_tile_layout widget indent=0>
  <#local tilename = widget.value("tile", guess_tile(widget))>
  <#if tilename == "meeting_event">
<@tile.print_tile_meeting_event widget=widget indent=indent />
  <#elseif tilename == "media_article">
<@tile.print_tile_media_article widget=widget indent=indent />
  <#elseif tilename == "user_profile">
<@tile.print_tile_user_profile widget=widget indent=indent />
  <#elseif tilename == "task_board">
<@tile.print_tile_task_board widget=widget indent=indent />
  <#elseif tilename == "promo_banner">
<@tile.print_tile_promo_banner widget=widget indent=indent />
  <#elseif tilename == "compact_list">
<@tile.print_tile_compact_list widget=widget indent=indent />
  <#elseif tilename == "split_content">
<@tile.print_tile_split_content widget=widget indent=indent />
  <#elseif tilename == "notification">
<@tile.print_tile_notification widget=widget indent=indent />
  <#elseif tilename == "hero_profile">
<@tile.print_tile_hero_profile widget=widget indent=indent />
  <#elseif tilename == "timeline_node">
<@tile.print_tile_timeline_node widget=widget indent=indent />
  <#elseif tilename == "message">
<@tile.print_tile_message widget=widget indent=indent />
  <#elseif tilename == "ticket">
<@tile.print_tile_ticket widget=widget indent=indent />
  <#elseif tilename == "dense_detail_list">
<@tile.print_tile_dense_detail_list widget=widget indent=indent />
  <#elseif tilename == "vertical_poster">
<@tile.print_tile_vertical_poster widget=widget indent=indent />
  <#elseif tilename == "issue_detail">
<@tile.print_tile_issue_detail widget=widget indent=indent />
  <#elseif tilename == "team_directory">
<@tile.print_tile_team_directory widget=widget indent=indent />
  <#elseif tilename == "immersive_highlight">
<@tile.print_tile_immersive_highlight widget=widget indent=indent />
  <#elseif tilename == "mini_status">
<@tile.print_tile_mini_status widget=widget indent=indent />
  <#elseif tilename == "dual_column_content">
<@tile.print_tile_dual_column_content widget=widget indent=indent />
  <#elseif tilename == "gallery">
<@tile.print_tile_gallery widget=widget indent=indent />
  <#elseif tilename == "key_metric">
<@tile.print_tile_key_metric widget=widget indent=indent />
  <#elseif tilename == "overlay_avatar">
<@tile.print_tile_overlay_avatar widget=widget indent=indent />
  <#elseif tilename == "audit_log">
<@tile.print_tile_audit_log widget=widget indent=indent />
  <#elseif tilename == "calendar_cell">
<@tile.print_tile_calendar_cell widget=widget indent=indent />
  <#elseif tilename == "side_status">
<@tile.print_tile_side_status widget=widget indent=indent />
  <#elseif tilename == "multi_tag">
<@tile.print_tile_multi_tag widget=widget indent=indent />
  <#elseif tilename == "shift_planner">
<@tile.print_tile_shift_planner widget=widget indent=indent />
  <#elseif tilename == "social_post_feed">
<@tile.print_tile_social_post_feed widget=widget indent=indent />
  <#elseif tilename == "product">
<@tile.print_tile_product widget=widget indent=indent />
  <#elseif tilename == "dual_profile_comparison">
<@tile.print_tile_dual_profile_comparison widget=widget indent=indent />
  <#elseif tilename == "left_feature_image">
<@tile.print_tile_left_feature_image widget=widget indent=indent />
  <#elseif tilename == "workflow_strip">
<@tile.print_tile_workflow_strip widget=widget indent=indent />
  <#elseif tilename == "text_over_background">
<@tile.print_tile_text_over_background widget=widget indent=indent />
  <#elseif tilename == "micro_badge">
<@tile.print_tile_micro_badge widget=widget indent=indent />
  <#elseif tilename == "stepped_process">
<@tile.print_tile_stepped_process widget=widget indent=indent />
  <#elseif tilename == "stacked_overlay">
<@tile.print_tile_stacked_overlay widget=widget indent=indent />
  <#elseif tilename == "group_hub">
<@tile.print_tile_group_hub widget=widget indent=indent />
  <#elseif tilename == "tall_sidebar">
<@tile.print_tile_tall_sidebar widget=widget indent=indent />
  <#elseif tilename == "justified_meta">
<@tile.print_tile_justified_meta widget=widget indent=indent />
  <#elseif tilename == "multidimensional_board">
<@tile.print_tile_multidimensional_board widget=widget indent=indent />
  <#elseif tilename == "media_player">
<@tile.print_tile_media_player widget=widget indent=indent />
  <#elseif tilename == "left_anchor_time">
<@tile.print_tile_left_anchor_time widget=widget indent=indent />
  <#elseif tilename == "duration_span">
<@tile.print_tile_duration_span widget=widget indent=indent />
  <#elseif tilename == "media_history">
<@tile.print_tile_media_history widget=widget indent=indent />
  <#elseif tilename == "status_transition">
<@tile.print_tile_status_transition widget=widget indent=indent />
  <#elseif tilename == "compact_time">
<@tile.print_tile_compact_time widget=widget indent=indent />
  <#elseif tilename == "horizontal_flow">
<@tile.print_tile_horizontal_flow widget=widget indent=indent />
  <#elseif tilename == "right_biased_node">
<@tile.print_tile_right_biased_node widget=widget indent=indent />
  <#elseif tilename == "left_biased_node">
<@tile.print_tile_left_biased_node widget=widget indent=indent />
  <#elseif tilename == "internal_chronology">
<@tile.print_tile_internal_chronology widget=widget indent=indent />
  <#elseif tilename == "three_stage_segment">
<@tile.print_tile_three_stage_segment widget=widget indent=indent />
  <#elseif tilename == "horizontal_log">
<@tile.print_tile_horizontal_log widget=widget indent=indent />
  <#elseif tilename == "bulletin">
<@tile.print_tile_bulletin widget=widget indent=indent />
  <#elseif tilename == "timestamp_stamp">
<@tile.print_tile_timestamp_stamp widget=widget indent=indent />
  <#elseif tilename == "compact_chat">
<@tile.print_tile_compact_chat widget=widget indent=indent />
  <#elseif tilename == "side_image_time_capsule">
<@tile.print_tile_side_image_time_capsule widget=widget indent=indent />
  <#elseif tilename == "multi_tag_end_node">
<@tile.print_tile_multi_tag_end_node widget=widget indent=indent />
  </#if>
</#macro>