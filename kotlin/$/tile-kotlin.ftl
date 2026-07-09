<#import "/$/guidbase.ftl" as guidbase>

<#--
 ###############################################################################
 ### 瓦片猜测器 - 根据 widget.children 的 level 匹配最合适的瓦片样式
 ###############################################################################
-->
<#function guess_tile widget>
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
  <#local bestName = "meeting_event">
  <#local bestScore = -999>
  <#-- meeting_event -->
  <#local s = ((has_start_time?then(2,0))+(has_end_time?then(2,0))+(has_status?then(2,0))+(has_primary?then(2,0))+(has_secondary?then(2,0))+(has_avatars?then(2,0)))-((has_tertiary?then(1,0))+(has_image?then(1,0))+(has_avatar?then(1,0))+(has_tags?then(1,0))+(has_background?then(1,0)))>
  <#if (s > bestScore)><#local bestScore = s><#local bestName = "meeting_event"></#if>
  <#-- media_article -->
  <#local s = ((has_image?then(2,0))+(has_tags?then(2,0))+(has_primary?then(2,0))+(has_secondary?then(2,0))+(has_tertiary?then(2,0)))-((has_avatar?then(1,0))+(has_avatars?then(1,0))+(has_status?then(1,0))+(has_start_time?then(1,0))+(has_end_time?then(1,0))+(has_background?then(1,0)))>
  <#if (s > bestScore)><#local bestScore = s><#local bestName = "media_article"></#if>
  <#-- user_profile -->
  <#local s = ((has_avatar?then(2,0))+(has_primary?then(2,0))+(has_secondary?then(2,0))+(has_status?then(2,0)))-((has_tertiary?then(1,0))+(has_image?then(1,0))+(has_avatars?then(1,0))+(has_tags?then(1,0))+(has_start_time?then(1,0))+(has_end_time?then(1,0))+(has_background?then(1,0)))>
  <#if (s > bestScore)><#local bestScore = s><#local bestName = "user_profile"></#if>
  <#-- task_board -->
  <#local s = ((has_tags?then(2,0))+(has_status?then(2,0))+(has_primary?then(2,0))+(has_avatars?then(2,0))+(has_end_time?then(2,0)))-((has_secondary?then(1,0))+(has_tertiary?then(1,0))+(has_image?then(1,0))+(has_avatar?then(1,0))+(has_start_time?then(1,0))+(has_background?then(1,0)))>
  <#if (s > bestScore)><#local bestScore = s><#local bestName = "task_board"></#if>
  <#-- promo_banner -->
  <#local s = ((has_background?then(2,0))+(has_tags?then(2,0))+(has_primary?then(2,0))+(has_secondary?then(2,0))+(has_tertiary?then(2,0)))-((has_image?then(1,0))+(has_avatar?then(1,0))+(has_avatars?then(1,0))+(has_status?then(1,0))+(has_start_time?then(1,0))+(has_end_time?then(1,0)))>
  <#if (s > bestScore)><#local bestScore = s><#local bestName = "promo_banner"></#if>
  <#-- compact_list -->
  <#local s = ((has_status?then(2,0))+(has_primary?then(2,0))+(has_secondary?then(2,0))+(has_start_time?then(2,0)))-((has_tertiary?then(1,0))+(has_image?then(1,0))+(has_avatar?then(1,0))+(has_avatars?then(1,0))+(has_tags?then(1,0))+(has_end_time?then(1,0))+(has_background?then(1,0)))>
  <#if (s > bestScore)><#local bestScore = s><#local bestName = "compact_list"></#if>
  <#-- split_content -->
  <#local s = ((has_image?then(2,0))+(has_tags?then(2,0))+(has_primary?then(2,0))+(has_avatars?then(2,0))+(has_start_time?then(2,0)))-((has_secondary?then(1,0))+(has_tertiary?then(1,0))+(has_avatar?then(1,0))+(has_status?then(1,0))+(has_end_time?then(1,0))+(has_background?then(1,0)))>
  <#if (s > bestScore)><#local bestScore = s><#local bestName = "split_content"></#if>
  <#-- notification -->
  <#local s = ((has_status?then(2,0))+(has_primary?then(2,0))+(has_tertiary?then(2,0)))-((has_secondary?then(1,0))+(has_image?then(1,0))+(has_avatar?then(1,0))+(has_avatars?then(1,0))+(has_tags?then(1,0))+(has_start_time?then(1,0))+(has_end_time?then(1,0))+(has_background?then(1,0)))>
  <#if (s > bestScore)><#local bestScore = s><#local bestName = "notification"></#if>
  <#-- hero_profile -->
  <#local s = ((has_background?then(2,0))+(has_avatar?then(2,0))+(has_primary?then(2,0))+(has_secondary?then(2,0)))-((has_tertiary?then(1,0))+(has_image?then(1,0))+(has_avatars?then(1,0))+(has_tags?then(1,0))+(has_status?then(1,0))+(has_start_time?then(1,0))+(has_end_time?then(1,0)))>
  <#if (s > bestScore)><#local bestScore = s><#local bestName = "hero_profile"></#if>
  <#-- timeline_node -->
  <#local s = ((has_start_time?then(2,0))+(has_end_time?then(2,0))+(has_primary?then(2,0))+(has_secondary?then(2,0))+(has_tertiary?then(2,0))+(has_tags?then(2,0)))-((has_image?then(1,0))+(has_avatar?then(1,0))+(has_avatars?then(1,0))+(has_status?then(1,0))+(has_background?then(1,0)))>
  <#if (s > bestScore)><#local bestScore = s><#local bestName = "timeline_node"></#if>
  <#-- message -->
  <#local s = ((has_avatar?then(2,0))+(has_primary?then(2,0))+(has_secondary?then(2,0))+(has_tertiary?then(2,0))+(has_start_time?then(2,0)))-((has_image?then(1,0))+(has_avatars?then(1,0))+(has_tags?then(1,0))+(has_status?then(1,0))+(has_end_time?then(1,0))+(has_background?then(1,0)))>
  <#if (s > bestScore)><#local bestScore = s><#local bestName = "message"></#if>
  <#-- ticket -->
  <#local s = ((has_background?then(2,0))+(has_primary?then(2,0))+(has_status?then(2,0))+(has_start_time?then(2,0))+(has_end_time?then(2,0)))-((has_secondary?then(1,0))+(has_tertiary?then(1,0))+(has_image?then(1,0))+(has_avatar?then(1,0))+(has_avatars?then(1,0))+(has_tags?then(1,0)))>
  <#if (s > bestScore)><#local bestScore = s><#local bestName = "ticket"></#if>
  <#-- dense_detail_list -->
  <#local s = ((has_image?then(2,0))+(has_primary?then(2,0))+(has_secondary?then(2,0))+(has_tertiary?then(2,0))+(has_tags?then(2,0))+(has_status?then(2,0)))-((has_avatar?then(1,0))+(has_avatars?then(1,0))+(has_start_time?then(1,0))+(has_end_time?then(1,0))+(has_background?then(1,0)))>
  <#if (s > bestScore)><#local bestScore = s><#local bestName = "dense_detail_list"></#if>
  <#-- vertical_poster -->
  <#local s = ((has_image?then(2,0))+(has_primary?then(2,0))+(has_secondary?then(2,0))+(has_start_time?then(2,0))+(has_end_time?then(2,0))+(has_avatars?then(2,0)))-((has_tertiary?then(1,0))+(has_avatar?then(1,0))+(has_tags?then(1,0))+(has_status?then(1,0))+(has_background?then(1,0)))>
  <#if (s > bestScore)><#local bestScore = s><#local bestName = "vertical_poster"></#if>
  <#-- issue_detail -->
  <#local s = ((has_tags?then(2,0))+(has_status?then(2,0))+(has_primary?then(2,0))+(has_secondary?then(2,0))+(has_tertiary?then(2,0))+(has_avatar?then(2,0))+(has_end_time?then(2,0)))-((has_image?then(1,0))+(has_avatars?then(1,0))+(has_start_time?then(1,0))+(has_background?then(1,0)))>
  <#if (s > bestScore)><#local bestScore = s><#local bestName = "issue_detail"></#if>
  <#-- team_directory -->
  <#local s = ((has_primary?then(2,0))+(has_secondary?then(2,0))+(has_avatars?then(2,0))+(has_tags?then(2,0)))-((has_tertiary?then(1,0))+(has_image?then(1,0))+(has_avatar?then(1,0))+(has_status?then(1,0))+(has_start_time?then(1,0))+(has_end_time?then(1,0))+(has_background?then(1,0)))>
  <#if (s > bestScore)><#local bestScore = s><#local bestName = "team_directory"></#if>
  <#-- immersive_highlight -->
  <#local s = ((has_background?then(2,0))+(has_status?then(2,0))+(has_primary?then(2,0)))-((has_secondary?then(1,0))+(has_tertiary?then(1,0))+(has_image?then(1,0))+(has_avatar?then(1,0))+(has_avatars?then(1,0))+(has_tags?then(1,0))+(has_start_time?then(1,0))+(has_end_time?then(1,0)))>
  <#if (s > bestScore)><#local bestScore = s><#local bestName = "immersive_highlight"></#if>
  <#-- mini_status -->
  <#local s = ((has_status?then(2,0))+(has_end_time?then(2,0))+(has_primary?then(2,0))+(has_tags?then(2,0)))-((has_secondary?then(1,0))+(has_tertiary?then(1,0))+(has_image?then(1,0))+(has_avatar?then(1,0))+(has_avatars?then(1,0))+(has_start_time?then(1,0))+(has_background?then(1,0)))>
  <#if (s > bestScore)><#local bestScore = s><#local bestName = "mini_status"></#if>
  <#-- dual_column_content -->
  <#local s = ((has_primary?then(2,0))+(has_secondary?then(2,0))+(has_tertiary?then(2,0))+(has_tags?then(2,0))+(has_avatar?then(2,0))+(has_avatars?then(2,0)))-((has_image?then(1,0))+(has_status?then(1,0))+(has_start_time?then(1,0))+(has_end_time?then(1,0))+(has_background?then(1,0)))>
  <#if (s > bestScore)><#local bestScore = s><#local bestName = "dual_column_content"></#if>
  <#-- gallery -->
  <#local s = ((has_image?then(2,0))+(has_primary?then(2,0))+(has_avatars?then(2,0))+(has_status?then(2,0)))-((has_secondary?then(1,0))+(has_tertiary?then(1,0))+(has_avatar?then(1,0))+(has_tags?then(1,0))+(has_start_time?then(1,0))+(has_end_time?then(1,0))+(has_background?then(1,0)))>
  <#if (s > bestScore)><#local bestScore = s><#local bestName = "gallery"></#if>
  <#-- key_metric -->
  <#local s = ((has_tags?then(2,0))+(has_primary?then(2,0))+(has_secondary?then(2,0))+(has_status?then(2,0)))-((has_tertiary?then(1,0))+(has_image?then(1,0))+(has_avatar?then(1,0))+(has_avatars?then(1,0))+(has_start_time?then(1,0))+(has_end_time?then(1,0))+(has_background?then(1,0)))>
  <#if (s > bestScore)><#local bestScore = s><#local bestName = "key_metric"></#if>
  <#-- overlay_avatar -->
  <#local s = ((has_image?then(2,0))+(has_avatar?then(2,0))+(has_primary?then(2,0))+(has_secondary?then(2,0)))-((has_tertiary?then(1,0))+(has_avatars?then(1,0))+(has_tags?then(1,0))+(has_status?then(1,0))+(has_start_time?then(1,0))+(has_end_time?then(1,0))+(has_background?then(1,0)))>
  <#if (s > bestScore)><#local bestScore = s><#local bestName = "overlay_avatar"></#if>
  <#-- audit_log -->
  <#local s = ((has_avatar?then(2,0))+(has_primary?then(2,0))+(has_secondary?then(2,0))+(has_start_time?then(2,0))+(has_status?then(2,0)))-((has_tertiary?then(1,0))+(has_image?then(1,0))+(has_avatars?then(1,0))+(has_tags?then(1,0))+(has_end_time?then(1,0))+(has_background?then(1,0)))>
  <#if (s > bestScore)><#local bestScore = s><#local bestName = "audit_log"></#if>
  <#-- calendar_cell -->
  <#local s = ((has_start_time?then(2,0))+(has_status?then(2,0))+(has_primary?then(2,0))+(has_avatars?then(2,0)))-((has_secondary?then(1,0))+(has_tertiary?then(1,0))+(has_image?then(1,0))+(has_avatar?then(1,0))+(has_tags?then(1,0))+(has_end_time?then(1,0))+(has_background?then(1,0)))>
  <#if (s > bestScore)><#local bestScore = s><#local bestName = "calendar_cell"></#if>
  <#-- side_status -->
  <#local s = ((has_status?then(2,0))+(has_primary?then(2,0))+(has_secondary?then(2,0))+(has_start_time?then(2,0)))-((has_tertiary?then(1,0))+(has_image?then(1,0))+(has_avatar?then(1,0))+(has_avatars?then(1,0))+(has_tags?then(1,0))+(has_end_time?then(1,0))+(has_background?then(1,0)))>
  <#if (s > bestScore)><#local bestScore = s><#local bestName = "side_status"></#if>
  <#-- multi_tag -->
  <#local s = ((has_tags?then(2,0))+(has_primary?then(2,0))+(has_secondary?then(2,0))+(has_end_time?then(2,0)))-((has_tertiary?then(1,0))+(has_image?then(1,0))+(has_avatar?then(1,0))+(has_avatars?then(1,0))+(has_status?then(1,0))+(has_start_time?then(1,0))+(has_background?then(1,0)))>
  <#if (s > bestScore)><#local bestScore = s><#local bestName = "multi_tag"></#if>
  <#-- shift_planner -->
  <#local s = ((has_start_time?then(2,0))+(has_end_time?then(2,0))+(has_status?then(2,0))+(has_primary?then(2,0))+(has_avatars?then(2,0)))-((has_secondary?then(1,0))+(has_tertiary?then(1,0))+(has_image?then(1,0))+(has_avatar?then(1,0))+(has_tags?then(1,0))+(has_background?then(1,0)))>
  <#if (s > bestScore)><#local bestScore = s><#local bestName = "shift_planner"></#if>
  <#-- social_post_feed -->
  <#local s = ((has_avatar?then(2,0))+(has_primary?then(2,0))+(has_start_time?then(2,0))+(has_tertiary?then(2,0))+(has_image?then(2,0))+(has_avatars?then(2,0))+(has_tags?then(2,0)))-((has_secondary?then(1,0))+(has_status?then(1,0))+(has_end_time?then(1,0))+(has_background?then(1,0)))>
  <#if (s > bestScore)><#local bestScore = s><#local bestName = "social_post_feed"></#if>
  <#-- product -->
  <#local s = ((has_image?then(2,0))+(has_tags?then(2,0))+(has_primary?then(2,0))+(has_secondary?then(2,0))+(has_status?then(2,0))+(has_end_time?then(2,0)))-((has_tertiary?then(1,0))+(has_avatar?then(1,0))+(has_avatars?then(1,0))+(has_start_time?then(1,0))+(has_background?then(1,0)))>
  <#if (s > bestScore)><#local bestScore = s><#local bestName = "product"></#if>
  <#-- dual_profile_comparison -->
  <#local s = ((has_avatar?then(2,0))+(has_status?then(2,0))+(has_primary?then(2,0))+(has_secondary?then(2,0))+(has_start_time?then(2,0))+(has_end_time?then(2,0)))-((has_tertiary?then(1,0))+(has_image?then(1,0))+(has_avatars?then(1,0))+(has_tags?then(1,0))+(has_background?then(1,0)))>
  <#if (s > bestScore)><#local bestScore = s><#local bestName = "dual_profile_comparison"></#if>
  <#-- left_feature_image -->
  <#local s = ((has_image?then(2,0))+(has_tags?then(2,0))+(has_primary?then(2,0))+(has_secondary?then(2,0))+(has_tertiary?then(2,0))+(has_status?then(2,0))+(has_avatars?then(2,0)))-((has_avatar?then(1,0))+(has_start_time?then(1,0))+(has_end_time?then(1,0))+(has_background?then(1,0)))>
  <#if (s > bestScore)><#local bestScore = s><#local bestName = "left_feature_image"></#if>
  <#-- workflow_strip -->
  <#local s = ((has_start_time?then(2,0))+(has_avatars?then(2,0))+(has_status?then(2,0))+(has_end_time?then(2,0))+(has_primary?then(2,0)))-((has_secondary?then(1,0))+(has_tertiary?then(1,0))+(has_image?then(1,0))+(has_avatar?then(1,0))+(has_tags?then(1,0))+(has_background?then(1,0)))>
  <#if (s > bestScore)><#local bestScore = s><#local bestName = "workflow_strip"></#if>
  <#-- text_over_background -->
  <#local s = ((has_background?then(2,0))+(has_tags?then(2,0))+(has_primary?then(2,0))+(has_avatar?then(2,0))+(has_secondary?then(2,0)))-((has_tertiary?then(1,0))+(has_image?then(1,0))+(has_avatars?then(1,0))+(has_status?then(1,0))+(has_start_time?then(1,0))+(has_end_time?then(1,0)))>
  <#if (s > bestScore)><#local bestScore = s><#local bestName = "text_over_background"></#if>
  <#-- micro_badge -->
  <#local s = ((has_avatar?then(2,0))+(has_primary?then(2,0))+(has_status?then(2,0)))-((has_secondary?then(1,0))+(has_tertiary?then(1,0))+(has_image?then(1,0))+(has_avatars?then(1,0))+(has_tags?then(1,0))+(has_start_time?then(1,0))+(has_end_time?then(1,0))+(has_background?then(1,0)))>
  <#if (s > bestScore)><#local bestScore = s><#local bestName = "micro_badge"></#if>
  <#-- stepped_process -->
  <#local s = ((has_status?then(2,0))+(has_primary?then(2,0))+(has_secondary?then(2,0))+(has_start_time?then(2,0))+(has_end_time?then(2,0)))-((has_tertiary?then(1,0))+(has_image?then(1,0))+(has_avatar?then(1,0))+(has_avatars?then(1,0))+(has_tags?then(1,0))+(has_background?then(1,0)))>
  <#if (s > bestScore)><#local bestScore = s><#local bestName = "stepped_process"></#if>
  <#-- stacked_overlay -->
  <#local s = ((has_image?then(2,0))+(has_primary?then(2,0))+(has_secondary?then(2,0))+(has_status?then(2,0)))-((has_tertiary?then(1,0))+(has_avatar?then(1,0))+(has_avatars?then(1,0))+(has_tags?then(1,0))+(has_start_time?then(1,0))+(has_end_time?then(1,0))+(has_background?then(1,0)))>
  <#if (s > bestScore)><#local bestScore = s><#local bestName = "stacked_overlay"></#if>
  <#-- group_hub -->
  <#local s = ((has_avatars?then(2,0))+(has_primary?then(2,0))+(has_tertiary?then(2,0))+(has_tags?then(2,0))+(has_status?then(2,0)))-((has_secondary?then(1,0))+(has_image?then(1,0))+(has_avatar?then(1,0))+(has_start_time?then(1,0))+(has_end_time?then(1,0))+(has_background?then(1,0)))>
  <#if (s > bestScore)><#local bestScore = s><#local bestName = "group_hub"></#if>
  <#-- tall_sidebar -->
  <#local s = ((has_status?then(2,0))+(has_image?then(2,0))+(has_primary?then(2,0))+(has_secondary?then(2,0))+(has_tags?then(2,0))+(has_avatars?then(2,0)))-((has_tertiary?then(1,0))+(has_avatar?then(1,0))+(has_start_time?then(1,0))+(has_end_time?then(1,0))+(has_background?then(1,0)))>
  <#if (s > bestScore)><#local bestScore = s><#local bestName = "tall_sidebar"></#if>
  <#-- justified_meta -->
  <#local s = ((has_primary?then(2,0))+(has_secondary?then(2,0))+(has_start_time?then(2,0))+(has_end_time?then(2,0))+(has_avatar?then(2,0))+(has_status?then(2,0)))-((has_tertiary?then(1,0))+(has_image?then(1,0))+(has_avatars?then(1,0))+(has_tags?then(1,0))+(has_background?then(1,0)))>
  <#if (s > bestScore)><#local bestScore = s><#local bestName = "justified_meta"></#if>
  <#-- multidimensional_board -->
  <#local s = ((has_status?then(2,0))+(has_start_time?then(2,0))+(has_primary?then(2,0))+(has_tertiary?then(2,0))+(has_secondary?then(2,0))+(has_tags?then(2,0))+(has_avatars?then(2,0)))-((has_image?then(1,0))+(has_avatar?then(1,0))+(has_end_time?then(1,0))+(has_background?then(1,0)))>
  <#if (s > bestScore)><#local bestScore = s><#local bestName = "multidimensional_board"></#if>
  <#-- media_player -->
  <#local s = ((has_image?then(2,0))+(has_primary?then(2,0))+(has_secondary?then(2,0))+(has_start_time?then(2,0))+(has_end_time?then(2,0))+(has_avatar?then(2,0))+(has_status?then(2,0)))-((has_tertiary?then(1,0))+(has_avatars?then(1,0))+(has_tags?then(1,0))+(has_background?then(1,0)))>
  <#if (s > bestScore)><#local bestScore = s><#local bestName = "media_player"></#if>
  <#-- left_anchor_time -->
  <#local s = ((has_start_time?then(2,0))+(has_status?then(2,0))+(has_primary?then(2,0))+(has_secondary?then(2,0))+(has_avatar?then(2,0)))-((has_tertiary?then(1,0))+(has_image?then(1,0))+(has_avatars?then(1,0))+(has_tags?then(1,0))+(has_end_time?then(1,0))+(has_background?then(1,0)))>
  <#if (s > bestScore)><#local bestScore = s><#local bestName = "left_anchor_time"></#if>
  <#-- duration_span -->
  <#local s = ((has_start_time?then(2,0))+(has_end_time?then(2,0))+(has_status?then(2,0))+(has_primary?then(2,0))+(has_avatars?then(2,0)))-((has_secondary?then(1,0))+(has_tertiary?then(1,0))+(has_image?then(1,0))+(has_avatar?then(1,0))+(has_tags?then(1,0))+(has_background?then(1,0)))>
  <#if (s > bestScore)><#local bestScore = s><#local bestName = "duration_span"></#if>
  <#-- media_history -->
  <#local s = ((has_start_time?then(2,0))+(has_image?then(2,0))+(has_primary?then(2,0))+(has_secondary?then(2,0))+(has_tags?then(2,0)))-((has_tertiary?then(1,0))+(has_avatar?then(1,0))+(has_avatars?then(1,0))+(has_status?then(1,0))+(has_end_time?then(1,0))+(has_background?then(1,0)))>
  <#if (s > bestScore)><#local bestScore = s><#local bestName = "media_history"></#if>
  <#-- status_transition -->
  <#local s = ((has_start_time?then(2,0))+(has_status?then(2,0))+(has_primary?then(2,0))+(has_avatar?then(2,0))+(has_secondary?then(2,0)))-((has_tertiary?then(1,0))+(has_image?then(1,0))+(has_avatars?then(1,0))+(has_tags?then(1,0))+(has_end_time?then(1,0))+(has_background?then(1,0)))>
  <#if (s > bestScore)><#local bestScore = s><#local bestName = "status_transition"></#if>
  <#-- compact_time -->
  <#local s = ((has_start_time?then(2,0))+(has_status?then(2,0))+(has_primary?then(2,0))+(has_tags?then(2,0)))-((has_secondary?then(1,0))+(has_tertiary?then(1,0))+(has_image?then(1,0))+(has_avatar?then(1,0))+(has_avatars?then(1,0))+(has_end_time?then(1,0))+(has_background?then(1,0)))>
  <#if (s > bestScore)><#local bestScore = s><#local bestName = "compact_time"></#if>
  <#-- horizontal_flow -->
  <#local s = ((has_start_time?then(2,0))+(has_primary?then(2,0))+(has_status?then(2,0)))-((has_secondary?then(1,0))+(has_tertiary?then(1,0))+(has_image?then(1,0))+(has_avatar?then(1,0))+(has_avatars?then(1,0))+(has_tags?then(1,0))+(has_end_time?then(1,0))+(has_background?then(1,0)))>
  <#if (s > bestScore)><#local bestScore = s><#local bestName = "horizontal_flow"></#if>
  <#-- right_biased_node -->
  <#local s = ((has_start_time?then(2,0))+(has_primary?then(2,0))+(has_tags?then(2,0)))-((has_secondary?then(1,0))+(has_tertiary?then(1,0))+(has_image?then(1,0))+(has_avatar?then(1,0))+(has_avatars?then(1,0))+(has_status?then(1,0))+(has_end_time?then(1,0))+(has_background?then(1,0)))>
  <#if (s > bestScore)><#local bestScore = s><#local bestName = "right_biased_node"></#if>
  <#-- left_biased_node -->
  <#local s = ((has_start_time?then(2,0))+(has_primary?then(2,0))+(has_tags?then(2,0)))-((has_secondary?then(1,0))+(has_tertiary?then(1,0))+(has_image?then(1,0))+(has_avatar?then(1,0))+(has_avatars?then(1,0))+(has_status?then(1,0))+(has_end_time?then(1,0))+(has_background?then(1,0)))>
  <#if (s > bestScore)><#local bestScore = s><#local bestName = "left_biased_node"></#if>
  <#-- internal_chronology -->
  <#local s = ((has_start_time?then(2,0))+(has_primary?then(2,0))+(has_end_time?then(2,0))+(has_secondary?then(2,0))+(has_status?then(2,0)))-((has_tertiary?then(1,0))+(has_image?then(1,0))+(has_avatar?then(1,0))+(has_avatars?then(1,0))+(has_tags?then(1,0))+(has_background?then(1,0)))>
  <#if (s > bestScore)><#local bestScore = s><#local bestName = "internal_chronology"></#if>
  <#-- three_stage_segment -->
  <#local s = ((has_start_time?then(2,0))+(has_tags?then(2,0))+(has_end_time?then(2,0))+(has_primary?then(2,0))+(has_secondary?then(2,0))+(has_status?then(2,0)))-((has_tertiary?then(1,0))+(has_image?then(1,0))+(has_avatar?then(1,0))+(has_avatars?then(1,0))+(has_background?then(1,0)))>
  <#if (s > bestScore)><#local bestScore = s><#local bestName = "three_stage_segment"></#if>
  <#-- horizontal_log -->
  <#local s = ((has_avatar?then(2,0))+(has_start_time?then(2,0))+(has_primary?then(2,0))+(has_status?then(2,0)))-((has_secondary?then(1,0))+(has_tertiary?then(1,0))+(has_image?then(1,0))+(has_avatars?then(1,0))+(has_tags?then(1,0))+(has_end_time?then(1,0))+(has_background?then(1,0)))>
  <#if (s > bestScore)><#local bestScore = s><#local bestName = "horizontal_log"></#if>
  <#-- bulletin -->
  <#local s = ((has_tags?then(2,0))+(has_primary?then(2,0))+(has_tertiary?then(2,0))+(has_avatars?then(2,0))+(has_start_time?then(2,0)))-((has_secondary?then(1,0))+(has_image?then(1,0))+(has_avatar?then(1,0))+(has_status?then(1,0))+(has_end_time?then(1,0))+(has_background?then(1,0)))>
  <#if (s > bestScore)><#local bestScore = s><#local bestName = "bulletin"></#if>
  <#-- timestamp_stamp -->
  <#local s = ((has_background?then(2,0))+(has_start_time?then(2,0))+(has_primary?then(2,0))+(has_status?then(2,0)))-((has_secondary?then(1,0))+(has_tertiary?then(1,0))+(has_image?then(1,0))+(has_avatar?then(1,0))+(has_avatars?then(1,0))+(has_tags?then(1,0))+(has_end_time?then(1,0)))>
  <#if (s > bestScore)><#local bestScore = s><#local bestName = "timestamp_stamp"></#if>
  <#-- compact_chat -->
  <#local s = ((has_avatar?then(2,0))+(has_primary?then(2,0))+(has_secondary?then(2,0))+(has_start_time?then(2,0)))-((has_tertiary?then(1,0))+(has_image?then(1,0))+(has_avatars?then(1,0))+(has_tags?then(1,0))+(has_status?then(1,0))+(has_end_time?then(1,0))+(has_background?then(1,0)))>
  <#if (s > bestScore)><#local bestScore = s><#local bestName = "compact_chat"></#if>
  <#-- side_image_time_capsule -->
  <#local s = ((has_start_time?then(2,0))+(has_primary?then(2,0))+(has_secondary?then(2,0))+(has_image?then(2,0))+(has_status?then(2,0)))-((has_tertiary?then(1,0))+(has_avatar?then(1,0))+(has_avatars?then(1,0))+(has_tags?then(1,0))+(has_end_time?then(1,0))+(has_background?then(1,0)))>
  <#if (s > bestScore)><#local bestScore = s><#local bestName = "side_image_time_capsule"></#if>
  <#-- multi_tag_end_node -->
  <#local s = ((has_tags?then(2,0))+(has_end_time?then(2,0))+(has_primary?then(2,0))+(has_avatars?then(2,0))+(has_status?then(2,0)))-((has_secondary?then(1,0))+(has_tertiary?then(1,0))+(has_image?then(1,0))+(has_avatar?then(1,0))+(has_start_time?then(1,0))+(has_background?then(1,0)))>
  <#if (s > bestScore)><#local bestScore = s><#local bestName = "multi_tag_end_node"></#if>
  <#return bestName>
</#function>

<#--
 ###############################################################################
 ### 通用布局辅助宏 - 供各瓦片宏调用
 ###############################################################################
-->

<#-- 获取数据变量名: item.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, level))} -->
<#function slot_var widget level>
  <#return "item." + guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, level))>
</#function>

<#-- 根据 child.type 返回类型感知的格式化表达式:
     date/time/datetime → Dates.format()
     number            → Numbers.format()
     else              → 无格式化 (bare ?: "") -->
<#function format_slot widget level>
  <#local child = guidbase.get_child_from_tile(widget, level)>
  <#local expr = "item." + guidbase.name_widget_variable(child)>
  <#if child.type == "date" || child.type == "time" || child.type == "datetime">
    <#return expr + '?.let { Dates.format(it) } ?: ""'>
  <#elseif child.type == "number">
    <#return 'Numbers.format(' + expr + ')'>
  <#else>
    <#return expr + ' ?: ""'>
  </#if>
</#function>

<#--
 ###############################################################################
 ### 内联基础元素辅助宏 - 用 Kotlin 基本 Compose 元素替代自定义组件
 ### 每个宏生成纯 Box/Text/Row/Column 代码，不依赖任何自定义 @Composable 函数
 ###############################################################################
-->

<#-- StatusBadge → 彩色圆角药丸 (pill) -->
<#macro status_pill text modifier="" indent=0>
${""?left_pad(indent)}Box(modifier = Modifier${modifier}.clip(RoundedCornerShape(Radii.Pill)).background(Colors.AccentDim).padding(horizontal = Spacings.s3, vertical = Spacings.s1)) {
${""?left_pad(indent)}  Text(${text}, fontSize = Types.Text2xs, fontWeight = FontWeight.SemiBold, color = Colors.AccentText)
${""?left_pad(indent)}}
</#macro>

<#-- TileAvatar → 圆形头像占位符 -->
<#macro avatar_circle uri size="40.dp" indent=0>
${""?left_pad(indent)}Box(modifier = Modifier.size(${size}).clip(CircleShape).background(Colors.AccentDim), contentAlignment = Alignment.Center) {
${""?left_pad(indent)}  Text("👤", fontSize = 18.sp)
${""?left_pad(indent)}}
</#macro>

<#-- AvatarRow → 重叠圆形头像行 -->
<#macro avatar_strip avatars modifier="" indent=0>
${""?left_pad(indent)}Row(modifier = Modifier${modifier}, horizontalArrangement = Arrangement.spacedBy((-6).dp)) {
${""?left_pad(indent)}  (${avatars} ?: emptyList()).take(3).forEach { av ->
${""?left_pad(indent)}    Box(modifier = Modifier.size(28.dp).clip(CircleShape).background(Colors.AccentDim).border(1.5.dp, Colors.Surface, CircleShape), contentAlignment = Alignment.Center) {
${""?left_pad(indent)}      Text("👤", fontSize = 14.sp)
${""?left_pad(indent)}    }
${""?left_pad(indent)}  }
${""?left_pad(indent)}}
</#macro>

<#-- TagsRow → 流式标签 chips -->
<#macro tag_chips tags modifier="" indent=0>
${""?left_pad(indent)}FlowRow(modifier = Modifier${modifier}, horizontalArrangement = Arrangement.spacedBy(Spacings.s2)) {
${""?left_pad(indent)}  (${tags} ?: emptyList()).forEach { tag ->
${""?left_pad(indent)}    Box(modifier = Modifier.clip(RoundedCornerShape(Radii.Pill)).background(Colors.AccentDim).padding(horizontal = Spacings.s3, vertical = Spacings.s1)) {
${""?left_pad(indent)}      Text(tag, fontSize = Types.Text2xs, color = Colors.AccentText, fontWeight = FontWeight.Medium)
${""?left_pad(indent)}    }
${""?left_pad(indent)}  }
${""?left_pad(indent)}}
</#macro>

<#-- Card wrapper → Box with surface styling, replaces Card(...) calls -->
<#macro card_open modifier=".padding(horizontal = Spacings.s5)" indent=0>
${""?left_pad(indent)}Box(modifier = Modifier${modifier}.clip(RoundedCornerShape(Radii.Md)).background(Colors.Surface).border(1.dp, Colors.Border, RoundedCornerShape(Radii.Md))) {
</#macro>

<#macro card_close indent=0>
${""?left_pad(indent)}}
</#macro>

<#-- TileImage → 图片占位符 -->
<#macro image_placeholder uri modifier="" indent=0>
${""?left_pad(indent)}Box(modifier = Modifier${modifier}.background(Colors.SurfaceDim), contentAlignment = Alignment.Center) {
${""?left_pad(indent)}  Text("🖼", fontSize = 28.sp)
${""?left_pad(indent)}}
</#macro>

<#-- 瓦片调度器 -->
<#macro print_tile_layout widget indent=0>
  <#local tile = widget.value("tile",guess_tile(widget))>
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
 ###############################################################################
 ### 瓦片宏 - 每个生成独立的 Kotlin Compose 布局
 ###############################################################################
-->

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
<@card_open indent=indent />
  <#if guidbase.has_child_widget(widget, "start_time") || guidbase.has_child_widget(widget, "end_time") || guidbase.has_child_widget(widget, "status")>
${""?left_pad(indent)}  Row(Modifier.fillMaxWidth().padding(Spacings.s3), verticalAlignment = Alignment.CenterVertically) {
    <#if guidbase.has_child_widget(widget, "start_time") && guidbase.has_child_widget(widget, "end_time")>
${""?left_pad(indent)}    Text(listOf(${format_slot(widget,"start_time")}, ${format_slot(widget,"end_time")}).filter { it.isNotEmpty() }.joinToString(" - "), fontSize = Types.TextXs, color = Colors.TextSecondary)
    <#elseif guidbase.has_child_widget(widget, "start_time")>
${""?left_pad(indent)}    Text(${format_slot(widget,"start_time")}, fontSize = Types.TextXs, color = Colors.TextSecondary)
    <#elseif guidbase.has_child_widget(widget, "end_time")>
${""?left_pad(indent)}    Text(${format_slot(widget,"end_time")}, fontSize = Types.TextXs, color = Colors.TextSecondary)
    </#if>
    <#if guidbase.has_child_widget(widget, "status")>
${""?left_pad(indent)}    Spacer(Modifier.weight(1f))
<@status_pill text=format_slot(widget,"status") indent=indent+4 />
    </#if>
${""?left_pad(indent)}  }
  </#if>
  <#if guidbase.has_child_widget(widget, "primary") || guidbase.has_child_widget(widget, "secondary")>
${""?left_pad(indent)}  Column(Modifier.fillMaxWidth().padding(Spacings.s3)) {
    <#if guidbase.has_child_widget(widget, "primary")>
${""?left_pad(indent)}    Text(${format_slot(widget,"primary")}, fontWeight = FontWeight.Bold, fontSize = Types.TextMd, color = Colors.TextMain)
    </#if>
    <#if guidbase.has_child_widget(widget, "secondary")>
${""?left_pad(indent)}    Text(${format_slot(widget,"secondary")}, fontSize = Types.TextSm, color = Colors.TextSecondary)
    </#if>
${""?left_pad(indent)}  }
  </#if>
  <#if guidbase.has_child_widget(widget, "avatars")>
${""?left_pad(indent)}  Row(Modifier.fillMaxWidth().padding(Spacings.s3)) {
<@avatar_strip avatars=slot_var(widget,"avatars") indent=indent+4 />
${""?left_pad(indent)}  }
  </#if>
<@card_close indent=indent />
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
<@card_open indent=indent />
  <#if guidbase.has_child_widget(widget, "image")>
${""?left_pad(indent)}  Box(Modifier.fillMaxWidth().height(160.dp).clip(RoundedCornerShape(topStart = 8.dp, topEnd = 8.dp))) {
<@image_placeholder uri=slot_var(widget,"image") modifier=".fillMaxSize()" indent=indent+4 />
    <#if guidbase.has_child_widget(widget, "tags")>
<@tag_chips tags=slot_var(widget,"tags") modifier=".align(Alignment.BottomStart).padding(Spacings.s2)" indent=indent+4 />
    </#if>
${""?left_pad(indent)}  }
  </#if>
  <#if guidbase.has_child_widget(widget, "primary") || guidbase.has_child_widget(widget, "secondary") || guidbase.has_child_widget(widget, "tertiary")>
${""?left_pad(indent)}  Column(Modifier.fillMaxWidth().padding(Spacings.s3)) {
    <#if guidbase.has_child_widget(widget, "primary")>
${""?left_pad(indent)}    Text(${format_slot(widget,"primary")}, fontWeight = FontWeight.Bold, fontSize = Types.TextMd, color = Colors.TextMain)
    </#if>
    <#if guidbase.has_child_widget(widget, "secondary")>
${""?left_pad(indent)}    Text(${format_slot(widget,"secondary")}, fontSize = Types.TextSm, color = Colors.TextSecondary)
    </#if>
    <#if guidbase.has_child_widget(widget, "tertiary")>
${""?left_pad(indent)}    Text(${format_slot(widget,"tertiary")}, fontSize = Types.TextXs, color = Colors.TextTertiary)
    </#if>
${""?left_pad(indent)}  }
  </#if>
<@card_close indent=indent />
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
<@card_open indent=indent />
${""?left_pad(indent)}  Row(Modifier.fillMaxWidth().padding(Spacings.s3), verticalAlignment = Alignment.CenterVertically) {
    <#if guidbase.has_child_widget(widget, "avatar")>
<@avatar_circle uri=slot_var(widget,"avatar") size="40.dp" indent=indent+4 />
${""?left_pad(indent)}    Spacer(Modifier.width(Spacings.s3))
    </#if>
${""?left_pad(indent)}    Column(Modifier.weight(1f)) {
    <#if guidbase.has_child_widget(widget, "primary")>
${""?left_pad(indent)}      Text(${format_slot(widget,"primary")}, fontWeight = FontWeight.Bold, fontSize = Types.TextMd, color = Colors.TextMain)
    </#if>
    <#if guidbase.has_child_widget(widget, "secondary")>
${""?left_pad(indent)}      Text(${format_slot(widget,"secondary")}, fontSize = Types.TextSm, color = Colors.TextSecondary)
    </#if>
${""?left_pad(indent)}    }
    <#if guidbase.has_child_widget(widget, "status")>
<@status_pill text=format_slot(widget,"status") indent=indent+4 />
    </#if>
${""?left_pad(indent)}  }
<@card_close indent=indent />
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
<@card_open indent=indent />
  <#if guidbase.has_child_widget(widget, "tags") || guidbase.has_child_widget(widget, "status")>
${""?left_pad(indent)}  Row(Modifier.fillMaxWidth().padding(Spacings.s3), verticalAlignment = Alignment.CenterVertically) {
    <#if guidbase.has_child_widget(widget, "tags")>
<@tag_chips tags=slot_var(widget,"tags") modifier=".weight(1f)" indent=indent+4 />
    </#if>
    <#if guidbase.has_child_widget(widget, "status")>
<@status_pill text=format_slot(widget,"status") indent=indent+4 />
    </#if>
${""?left_pad(indent)}  }
  </#if>
  <#if guidbase.has_child_widget(widget, "primary")>
${""?left_pad(indent)}  Column(Modifier.fillMaxWidth().padding(horizontal = Spacings.s3)) {
${""?left_pad(indent)}    Text(${format_slot(widget,"primary")}, fontWeight = FontWeight.Bold, fontSize = Types.TextMd, color = Colors.TextMain)
${""?left_pad(indent)}  }
  </#if>
  <#if guidbase.has_child_widget(widget, "avatars") || guidbase.has_child_widget(widget, "end_time")>
${""?left_pad(indent)}  Row(Modifier.fillMaxWidth().padding(Spacings.s3), verticalAlignment = Alignment.CenterVertically) {
    <#if guidbase.has_child_widget(widget, "avatars")>
<@avatar_strip avatars=slot_var(widget,"avatars") modifier=".weight(1f)" indent=indent+4 />
    </#if>
    <#if guidbase.has_child_widget(widget, "end_time")>
${""?left_pad(indent)}    Text(${format_slot(widget,"end_time")}, fontSize = Types.TextXs, color = Colors.TextSecondary)
    </#if>
${""?left_pad(indent)}  }
  </#if>
<@card_close indent=indent />
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
<@card_open indent=indent />
  <#if guidbase.has_child_widget(widget, "background")>
${""?left_pad(indent)}  Box(Modifier.fillMaxWidth().height(160.dp)) {
<@image_placeholder uri=slot_var(widget,"background") modifier=".fillMaxSize()" indent=indent+4 />
${""?left_pad(indent)}  }
  </#if>
${""?left_pad(indent)}  Box(Modifier.fillMaxSize(), contentAlignment = Alignment.Center) {
${""?left_pad(indent)}    Column(horizontalAlignment = Alignment.CenterHorizontally) {
    <#if guidbase.has_child_widget(widget, "tags")>
<@tag_chips tags=slot_var(widget,"tags") indent=indent+4 />
    </#if>
    <#if guidbase.has_child_widget(widget, "primary")>
${""?left_pad(indent)}      Text(${format_slot(widget,"primary")}, fontWeight = FontWeight.Bold, fontSize = Types.TextMd, color = Colors.TextMain)
    </#if>
    <#if guidbase.has_child_widget(widget, "secondary")>
${""?left_pad(indent)}      Text(${format_slot(widget,"secondary")}, fontSize = Types.TextSm, color = Colors.TextSecondary)
    </#if>
    <#if guidbase.has_child_widget(widget, "tertiary")>
${""?left_pad(indent)}      Text(${format_slot(widget,"tertiary")}, fontSize = Types.TextXs, color = Colors.TextTertiary)
    </#if>
${""?left_pad(indent)}    }
${""?left_pad(indent)}  }
<@card_close indent=indent />
</#macro>

<#--
紧凑列表 (Compact List)
+-----------------------------------------------+
| [status]  [primary]  [secondary]  [start time]|
+-----------------------------------------------+
-->
<#macro print_tile_compact_list widget indent=0>
<@card_open indent=indent />
${""?left_pad(indent)}  Row(Modifier.fillMaxWidth().padding(Spacings.s3), verticalAlignment = Alignment.CenterVertically) {
    <#if guidbase.has_child_widget(widget, "status")>
<@status_pill text=format_slot(widget,"status") indent=indent+4 />
${""?left_pad(indent)}    Spacer(Modifier.width(Spacings.s2))
    </#if>
    <#if guidbase.has_child_widget(widget, "primary")>
${""?left_pad(indent)}    Text(${format_slot(widget,"primary")}, fontWeight = FontWeight.Bold, fontSize = Types.TextMd, color = Colors.TextMain, modifier = Modifier.weight(1f))
    </#if>
    <#if guidbase.has_child_widget(widget, "secondary")>
${""?left_pad(indent)}    Text(${format_slot(widget,"secondary")}, fontSize = Types.TextSm, color = Colors.TextSecondary)
${""?left_pad(indent)}    Spacer(Modifier.width(Spacings.s2))
    </#if>
    <#if guidbase.has_child_widget(widget, "start_time")>
${""?left_pad(indent)}    Text(${format_slot(widget,"start_time")}, fontSize = Types.TextXs, color = Colors.TextSecondary)
    </#if>
${""?left_pad(indent)}  }
<@card_close indent=indent />
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
<@card_open indent=indent />
${""?left_pad(indent)}  Row(Modifier.fillMaxWidth().padding(Spacings.s3), verticalAlignment = Alignment.Top) {
    <#if guidbase.has_child_widget(widget, "image")>
<@image_placeholder uri=slot_var(widget,"image") modifier=".size(80.dp).clip(RoundedCornerShape(8.dp))" indent=indent+4 />
${""?left_pad(indent)}    Spacer(Modifier.width(Spacings.s3))
    </#if>
${""?left_pad(indent)}    Column(Modifier.weight(1f)) {
    <#if guidbase.has_child_widget(widget, "tags")>
<@tag_chips tags=slot_var(widget,"tags") indent=indent+4 />
    </#if>
    <#if guidbase.has_child_widget(widget, "primary")>
${""?left_pad(indent)}      Text(${format_slot(widget,"primary")}, fontWeight = FontWeight.Bold, fontSize = Types.TextMd, color = Colors.TextMain)
    </#if>
    <#if guidbase.has_child_widget(widget, "avatars")>
<@avatar_strip avatars=slot_var(widget,"avatars") indent=indent+4 />
    </#if>
    <#if guidbase.has_child_widget(widget, "start_time")>
${""?left_pad(indent)}      Text(${format_slot(widget,"start_time")}, fontSize = Types.TextXs, color = Colors.TextSecondary)
    </#if>
${""?left_pad(indent)}    }
${""?left_pad(indent)}  }
<@card_close indent=indent />
</#macro>

<#--
简易状态 (Notification)
+-----------------------------------------------+
|  [status]   [primary]                         |
|             [tertiary]                        |
+-----------------------------------------------+
-->
<#macro print_tile_notification widget indent=0>
<@card_open indent=indent />
${""?left_pad(indent)}  Row(Modifier.fillMaxWidth().padding(Spacings.s3), verticalAlignment = Alignment.CenterVertically) {
    <#if guidbase.has_child_widget(widget, "status")>
<@status_pill text=format_slot(widget,"status") indent=indent+4 />
${""?left_pad(indent)}    Spacer(Modifier.width(Spacings.s3))
    </#if>
${""?left_pad(indent)}    Column(Modifier.weight(1f)) {
    <#if guidbase.has_child_widget(widget, "primary")>
${""?left_pad(indent)}      Text(${format_slot(widget,"primary")}, fontWeight = FontWeight.Bold, fontSize = Types.TextMd, color = Colors.TextMain)
    </#if>
    <#if guidbase.has_child_widget(widget, "tertiary")>
${""?left_pad(indent)}      Text(${format_slot(widget,"tertiary")}, fontSize = Types.TextXs, color = Colors.TextTertiary)
    </#if>
${""?left_pad(indent)}    }
${""?left_pad(indent)}  }
<@card_close indent=indent />
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
<@card_open indent=indent />
  <#if guidbase.has_child_widget(widget, "background")>
${""?left_pad(indent)}  Box(Modifier.fillMaxWidth().height(140.dp)) {
<@image_placeholder uri=slot_var(widget,"background") modifier=".fillMaxSize()" indent=indent+4 />
${""?left_pad(indent)}  }
  </#if>
${""?left_pad(indent)}  Box(Modifier.fillMaxSize(), contentAlignment = Alignment.Center) {
${""?left_pad(indent)}    Column(horizontalAlignment = Alignment.CenterHorizontally) {
    <#if guidbase.has_child_widget(widget, "avatar")>
<@avatar_circle uri=slot_var(widget,"avatar") size="56.dp" indent=indent+4 />
${""?left_pad(indent)}      Spacer(Modifier.height(Spacings.s2))
    </#if>
    <#if guidbase.has_child_widget(widget, "primary")>
${""?left_pad(indent)}      Text(${format_slot(widget,"primary")}, fontWeight = FontWeight.Bold, fontSize = Types.TextMd, color = Colors.TextMain)
    </#if>
    <#if guidbase.has_child_widget(widget, "secondary")>
${""?left_pad(indent)}      Text(${format_slot(widget,"secondary")}, fontSize = Types.TextSm, color = Colors.TextSecondary)
    </#if>
${""?left_pad(indent)}    }
${""?left_pad(indent)}  }
<@card_close indent=indent />
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
<@card_open indent=indent />
${""?left_pad(indent)}  Row(Modifier.fillMaxWidth().padding(Spacings.s3)) {
${""?left_pad(indent)}    Column(horizontalAlignment = Alignment.CenterHorizontally, modifier = Modifier.width(40.dp)) {
    <#if guidbase.has_child_widget(widget, "start_time")>
${""?left_pad(indent)}      Text(${format_slot(widget,"start_time")}, fontSize = Types.TextXs, color = Colors.TextSecondary)
    </#if>
${""?left_pad(indent)}      Box(Modifier.size(8.dp).background(Colors.Accent, CircleShape))
    <#if guidbase.has_child_widget(widget, "end_time")>
${""?left_pad(indent)}      Text(${format_slot(widget,"end_time")}, fontSize = Types.TextXs, color = Colors.TextSecondary)
    </#if>
${""?left_pad(indent)}    }
${""?left_pad(indent)}    Column(Modifier.weight(1f).padding(start = Spacings.s3)) {
    <#if guidbase.has_child_widget(widget, "primary")>
${""?left_pad(indent)}      Text(${format_slot(widget,"primary")}, fontWeight = FontWeight.Bold, fontSize = Types.TextMd, color = Colors.TextMain)
    </#if>
    <#if guidbase.has_child_widget(widget, "secondary")>
${""?left_pad(indent)}      Text(${format_slot(widget,"secondary")}, fontSize = Types.TextSm, color = Colors.TextSecondary)
    </#if>
    <#if guidbase.has_child_widget(widget, "tertiary")>
${""?left_pad(indent)}      Text(${format_slot(widget,"tertiary")}, fontSize = Types.TextXs, color = Colors.TextTertiary)
    </#if>
${""?left_pad(indent)}    }
    <#if guidbase.has_child_widget(widget, "tags")>
<@tag_chips tags=slot_var(widget,"tags") indent=indent+4 />
    </#if>
${""?left_pad(indent)}  }
<@card_close indent=indent />
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
<@card_open indent=indent />
${""?left_pad(indent)}  Row(Modifier.fillMaxWidth().padding(Spacings.s3)) {
    <#if guidbase.has_child_widget(widget, "avatar")>
<@avatar_circle uri=slot_var(widget,"avatar") size="40.dp" indent=indent+4 />
${""?left_pad(indent)}    Spacer(Modifier.width(Spacings.s3))
    </#if>
${""?left_pad(indent)}    Column(Modifier.weight(1f)) {
${""?left_pad(indent)}      Row(Modifier.fillMaxWidth(), verticalAlignment = Alignment.CenterVertically) {
    <#if guidbase.has_child_widget(widget, "primary")>
${""?left_pad(indent)}        Text(${format_slot(widget,"primary")}, fontWeight = FontWeight.Bold, fontSize = Types.TextMd, color = Colors.TextMain, modifier = Modifier.weight(1f))
    </#if>
    <#if guidbase.has_child_widget(widget, "start_time")>
${""?left_pad(indent)}        Text(${format_slot(widget,"start_time")}, fontSize = Types.TextXs, color = Colors.TextSecondary)
    </#if>
${""?left_pad(indent)}      }
    <#if guidbase.has_child_widget(widget, "secondary")>
${""?left_pad(indent)}      Text(${format_slot(widget,"secondary")}, fontSize = Types.TextSm, color = Colors.TextSecondary)
    </#if>
    <#if guidbase.has_child_widget(widget, "tertiary")>
${""?left_pad(indent)}      Text(${format_slot(widget,"tertiary")}, fontSize = Types.TextXs, color = Colors.TextTertiary)
    </#if>
${""?left_pad(indent)}    }
${""?left_pad(indent)}  }
<@card_close indent=indent />
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
<@card_open indent=indent />
  <#if guidbase.has_child_widget(widget, "background")>
${""?left_pad(indent)}  Box(Modifier.fillMaxWidth().height(120.dp)) {
<@image_placeholder uri=slot_var(widget,"background") modifier=".fillMaxSize()" indent=indent+4 />
${""?left_pad(indent)}  }
  </#if>
${""?left_pad(indent)}  Box(Modifier.fillMaxSize(), contentAlignment = Alignment.Center) {
${""?left_pad(indent)}    Column(Modifier.fillMaxWidth().padding(Spacings.s3)) {
${""?left_pad(indent)}      Row(Modifier.fillMaxWidth(), verticalAlignment = Alignment.CenterVertically) {
    <#if guidbase.has_child_widget(widget, "primary")>
${""?left_pad(indent)}        Text(${format_slot(widget,"primary")}, fontWeight = FontWeight.Bold, fontSize = Types.TextMd, color = Colors.TextMain, modifier = Modifier.weight(1f))
    </#if>
    <#if guidbase.has_child_widget(widget, "status")>
<@status_pill text=format_slot(widget,"status") indent=indent+4 />
    </#if>
${""?left_pad(indent)}      }
    <#if guidbase.has_child_widget(widget, "start_time") || guidbase.has_child_widget(widget, "end_time")>
${""?left_pad(indent)}      Row(Modifier.fillMaxWidth()) {
    <#if guidbase.has_child_widget(widget, "start_time")>
${""?left_pad(indent)}        Text(${format_slot(widget,"start_time")}, fontSize = Types.TextXs, color = Colors.TextSecondary)
    </#if>
    <#if guidbase.has_child_widget(widget, "start_time") && guidbase.has_child_widget(widget, "end_time")>
${""?left_pad(indent)}        Text(" ~ ", fontSize = Types.TextXs, color = Colors.TextSecondary)
    </#if>
    <#if guidbase.has_child_widget(widget, "end_time")>
${""?left_pad(indent)}        Text(${format_slot(widget,"end_time")}, fontSize = Types.TextXs, color = Colors.TextSecondary)
    </#if>
${""?left_pad(indent)}      }
    </#if>
${""?left_pad(indent)}    }
${""?left_pad(indent)}  }
<@card_close indent=indent />
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
<@card_open indent=indent />
${""?left_pad(indent)}  Row(Modifier.fillMaxWidth().padding(Spacings.s3)) {
    <#if guidbase.has_child_widget(widget, "image")>
<@image_placeholder uri=slot_var(widget,"image") modifier=".size(64.dp).clip(RoundedCornerShape(8.dp))" indent=indent+4 />
${""?left_pad(indent)}    Spacer(Modifier.width(Spacings.s3))
    </#if>
${""?left_pad(indent)}    Column(Modifier.weight(1f)) {
    <#if guidbase.has_child_widget(widget, "primary")>
${""?left_pad(indent)}      Text(${format_slot(widget,"primary")}, fontWeight = FontWeight.Bold, fontSize = Types.TextMd, color = Colors.TextMain)
    </#if>
${""?left_pad(indent)}      Row(Modifier.fillMaxWidth(), horizontalArrangement = Arrangement.SpaceBetween) {
    <#if guidbase.has_child_widget(widget, "secondary")>
${""?left_pad(indent)}        Text(${format_slot(widget,"secondary")}, fontSize = Types.TextSm, color = Colors.TextSecondary)
    </#if>
    <#if guidbase.has_child_widget(widget, "tags")>
<@tag_chips tags=slot_var(widget,"tags") indent=indent+4 />
    </#if>
${""?left_pad(indent)}      }
${""?left_pad(indent)}      Row(Modifier.fillMaxWidth(), horizontalArrangement = Arrangement.SpaceBetween) {
    <#if guidbase.has_child_widget(widget, "tertiary")>
${""?left_pad(indent)}        Text(${format_slot(widget,"tertiary")}, fontSize = Types.TextXs, color = Colors.TextTertiary)
    </#if>
    <#if guidbase.has_child_widget(widget, "status")>
<@status_pill text=format_slot(widget,"status") indent=indent+4 />
    </#if>
${""?left_pad(indent)}      }
${""?left_pad(indent)}    }
${""?left_pad(indent)}  }
<@card_close indent=indent />
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
<@card_open modifier=".width(200.dp).padding(horizontal = Spacings.s5)" indent=indent />
  <#if guidbase.has_child_widget(widget, "image")>
<@image_placeholder uri=slot_var(widget,"image") modifier=".fillMaxWidth().height(200.dp).clip(RoundedCornerShape(topStart = 8.dp, topEnd = 8.dp))" indent=indent+4 />
  </#if>
  <#if guidbase.has_child_widget(widget, "primary") || guidbase.has_child_widget(widget, "secondary") || guidbase.has_child_widget(widget, "start_time") || guidbase.has_child_widget(widget, "end_time") || guidbase.has_child_widget(widget, "avatars")>
${""?left_pad(indent)}  Column(Modifier.fillMaxWidth().padding(Spacings.s3)) {
    <#if guidbase.has_child_widget(widget, "primary")>
${""?left_pad(indent)}    Text(${format_slot(widget,"primary")}, fontWeight = FontWeight.Bold, fontSize = Types.TextMd, color = Colors.TextMain)
    </#if>
    <#if guidbase.has_child_widget(widget, "secondary")>
${""?left_pad(indent)}    Text(${format_slot(widget,"secondary")}, fontSize = Types.TextSm, color = Colors.TextSecondary)
    </#if>
    <#if guidbase.has_child_widget(widget, "start_time")>
${""?left_pad(indent)}    Text(${format_slot(widget,"start_time")}, fontSize = Types.TextXs, color = Colors.TextSecondary)
    </#if>
    <#if guidbase.has_child_widget(widget, "end_time")>
${""?left_pad(indent)}    Text(${format_slot(widget,"end_time")}, fontSize = Types.TextXs, color = Colors.TextSecondary)
    </#if>
    <#if guidbase.has_child_widget(widget, "avatars")>
<@avatar_strip avatars=slot_var(widget,"avatars") indent=indent+4 />
    </#if>
${""?left_pad(indent)}  }
  </#if>
<@card_close indent=indent />
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
<@card_open indent=indent />
${""?left_pad(indent)}  Row(Modifier.fillMaxWidth().padding(Spacings.s3), verticalAlignment = Alignment.CenterVertically) {
    <#if guidbase.has_child_widget(widget, "tags")>
<@tag_chips tags=slot_var(widget,"tags") modifier=".weight(1f)" indent=indent+4 />
    </#if>
    <#if guidbase.has_child_widget(widget, "status")>
<@status_pill text=format_slot(widget,"status") indent=indent+4 />
    </#if>
${""?left_pad(indent)}  }
${""?left_pad(indent)}  Column(Modifier.fillMaxWidth().padding(horizontal = Spacings.s3)) {
    <#if guidbase.has_child_widget(widget, "primary")>
${""?left_pad(indent)}    Text(${format_slot(widget,"primary")}, fontWeight = FontWeight.Bold, fontSize = Types.TextMd, color = Colors.TextMain)
    </#if>
    <#if guidbase.has_child_widget(widget, "secondary")>
${""?left_pad(indent)}    Text(${format_slot(widget,"secondary")}, fontSize = Types.TextSm, color = Colors.TextSecondary)
    </#if>
    <#if guidbase.has_child_widget(widget, "tertiary")>
${""?left_pad(indent)}    Text(${format_slot(widget,"tertiary")}, fontSize = Types.TextXs, color = Colors.TextTertiary)
    </#if>
${""?left_pad(indent)}  }
${""?left_pad(indent)}  Row(Modifier.fillMaxWidth().padding(Spacings.s3), verticalAlignment = Alignment.CenterVertically) {
    <#if guidbase.has_child_widget(widget, "avatar")>
<@avatar_circle uri=slot_var(widget,"avatar") size="32.dp" indent=indent+4 />
    </#if>
    <#if guidbase.has_child_widget(widget, "end_time")>
${""?left_pad(indent)}    Spacer(Modifier.weight(1f))
${""?left_pad(indent)}    Text(${format_slot(widget,"end_time")}, fontSize = Types.TextXs, color = Colors.TextSecondary)
    </#if>
${""?left_pad(indent)}  }
<@card_close indent=indent />
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
<@card_open indent=indent />
${""?left_pad(indent)}  Column(Modifier.fillMaxWidth().padding(Spacings.s3)) {
    <#if guidbase.has_child_widget(widget, "primary")>
${""?left_pad(indent)}    Text(${format_slot(widget,"primary")}, fontWeight = FontWeight.Bold, fontSize = Types.TextMd, color = Colors.TextMain)
    </#if>
    <#if guidbase.has_child_widget(widget, "secondary")>
${""?left_pad(indent)}    Text(${format_slot(widget,"secondary")}, fontSize = Types.TextSm, color = Colors.TextSecondary)
    </#if>
${""?left_pad(indent)}  }
${""?left_pad(indent)}  Row(Modifier.fillMaxWidth().padding(Spacings.s3), verticalAlignment = Alignment.CenterVertically) {
    <#if guidbase.has_child_widget(widget, "avatars")>
<@avatar_strip avatars=slot_var(widget,"avatars") modifier=".weight(1f)" indent=indent+4 />
    </#if>
    <#if guidbase.has_child_widget(widget, "tags")>
<@tag_chips tags=slot_var(widget,"tags") indent=indent+4 />
    </#if>
${""?left_pad(indent)}  }
<@card_close indent=indent />
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
<@card_open indent=indent />
  <#if guidbase.has_child_widget(widget, "background")>
${""?left_pad(indent)}  Box(Modifier.fillMaxWidth().height(140.dp)) {
<@image_placeholder uri=slot_var(widget,"background") modifier=".fillMaxSize()" indent=indent+4 />
${""?left_pad(indent)}  }
  </#if>
${""?left_pad(indent)}  Box(Modifier.fillMaxSize(), contentAlignment = Alignment.Center) {
${""?left_pad(indent)}    Column(horizontalAlignment = Alignment.CenterHorizontally) {
    <#if guidbase.has_child_widget(widget, "status")>
<@status_pill text=format_slot(widget,"status") indent=indent+4 />
${""?left_pad(indent)}      Spacer(Modifier.height(Spacings.s2))
    </#if>
    <#if guidbase.has_child_widget(widget, "primary")>
${""?left_pad(indent)}      Text(${format_slot(widget,"primary")}, fontWeight = FontWeight.Bold, fontSize = Types.TextMd, color = Colors.TextMain)
    </#if>
${""?left_pad(indent)}    }
${""?left_pad(indent)}  }
<@card_close indent=indent />
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
<@card_open indent=indent />
${""?left_pad(indent)}  Row(Modifier.fillMaxWidth().padding(Spacings.s3), verticalAlignment = Alignment.CenterVertically) {
    <#if guidbase.has_child_widget(widget, "status")>
<@status_pill text=format_slot(widget,"status") indent=indent+4 />
${""?left_pad(indent)}    Spacer(Modifier.weight(1f))
    </#if>
    <#if guidbase.has_child_widget(widget, "end_time")>
${""?left_pad(indent)}    Text(${format_slot(widget,"end_time")}, fontSize = Types.TextXs, color = Colors.TextSecondary)
    </#if>
${""?left_pad(indent)}  }
    <#if guidbase.has_child_widget(widget, "primary")>
${""?left_pad(indent)}  Text(${format_slot(widget,"primary")}, fontWeight = FontWeight.Bold, fontSize = Types.TextMd, color = Colors.TextMain, modifier = Modifier.padding(horizontal = Spacings.s3))
    </#if>
    <#if guidbase.has_child_widget(widget, "tags")>
<@tag_chips tags=slot_var(widget,"tags") modifier=".padding(horizontal = Spacings.s3).padding(bottom = Spacings.s3)" indent=indent+4 />
    </#if>
<@card_close indent=indent />
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
<@card_open indent=indent />
${""?left_pad(indent)}  Row(Modifier.fillMaxWidth().padding(Spacings.s3)) {
${""?left_pad(indent)}    Column(Modifier.weight(1f)) {
    <#if guidbase.has_child_widget(widget, "primary")>
${""?left_pad(indent)}      Text(${format_slot(widget,"primary")}, fontWeight = FontWeight.Bold, fontSize = Types.TextMd, color = Colors.TextMain)
    </#if>
    <#if guidbase.has_child_widget(widget, "tertiary")>
${""?left_pad(indent)}      Text(${format_slot(widget,"tertiary")}, fontSize = Types.TextXs, color = Colors.TextTertiary)
    </#if>
    <#if guidbase.has_child_widget(widget, "avatar")>
<@avatar_circle uri=slot_var(widget,"avatar") size="32.dp" indent=indent+4 />
    </#if>
${""?left_pad(indent)}    }
${""?left_pad(indent)}    Column(Modifier.weight(1f)) {
    <#if guidbase.has_child_widget(widget, "secondary")>
${""?left_pad(indent)}      Text(${format_slot(widget,"secondary")}, fontSize = Types.TextSm, color = Colors.TextSecondary)
    </#if>
    <#if guidbase.has_child_widget(widget, "tags")>
<@tag_chips tags=slot_var(widget,"tags") indent=indent+4 />
    </#if>
    <#if guidbase.has_child_widget(widget, "avatars")>
<@avatar_strip avatars=slot_var(widget,"avatars") indent=indent+4 />
    </#if>
${""?left_pad(indent)}    }
${""?left_pad(indent)}  }
<@card_close indent=indent />
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
<@card_open indent=indent />
  <#if guidbase.has_child_widget(widget, "image")>
<@image_placeholder uri=slot_var(widget,"image") modifier=".fillMaxWidth().height(140.dp).clip(RoundedCornerShape(topStart = 8.dp, topEnd = 8.dp))" indent=indent+4 />
  </#if>
  <#if guidbase.has_child_widget(widget, "primary")>
${""?left_pad(indent)}  Text(${format_slot(widget,"primary")}, fontWeight = FontWeight.Bold, fontSize = Types.TextMd, color = Colors.TextMain, modifier = Modifier.padding(Spacings.s3))
  </#if>
  <#if guidbase.has_child_widget(widget, "avatars") || guidbase.has_child_widget(widget, "status")>
${""?left_pad(indent)}  Row(Modifier.fillMaxWidth().padding(Spacings.s3), verticalAlignment = Alignment.CenterVertically) {
    <#if guidbase.has_child_widget(widget, "avatars")>
<@avatar_strip avatars=slot_var(widget,"avatars") modifier=".weight(1f)" indent=indent+4 />
    </#if>
    <#if guidbase.has_child_widget(widget, "status")>
<@status_pill text=format_slot(widget,"status") indent=indent+4 />
    </#if>
${""?left_pad(indent)}  }
  </#if>
<@card_close indent=indent />
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
<@card_open indent=indent />
  <#if guidbase.has_child_widget(widget, "tags")>
<@tag_chips tags=slot_var(widget,"tags") modifier=".padding(start = Spacings.s3, end = Spacings.s3, top = Spacings.s3)" indent=indent+4 />
  </#if>
  <#if guidbase.has_child_widget(widget, "primary")>
${""?left_pad(indent)}  Text(${format_slot(widget,"primary")}, fontWeight = FontWeight.Bold, fontSize = Types.TextLg, color = Colors.TextMain, modifier = Modifier.padding(horizontal = Spacings.s3))
  </#if>
${""?left_pad(indent)}  Row(Modifier.fillMaxWidth().padding(Spacings.s3), verticalAlignment = Alignment.CenterVertically) {
    <#if guidbase.has_child_widget(widget, "secondary")>
${""?left_pad(indent)}    Text(${format_slot(widget,"secondary")}, fontSize = Types.TextSm, color = Colors.TextSecondary, modifier = Modifier.weight(1f))
    </#if>
    <#if guidbase.has_child_widget(widget, "status")>
<@status_pill text=format_slot(widget,"status") indent=indent+4 />
    </#if>
${""?left_pad(indent)}  }
<@card_close indent=indent />
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
<@card_open indent=indent />
  <#if guidbase.has_child_widget(widget, "image")>
<@image_placeholder uri=slot_var(widget,"image") modifier=".fillMaxWidth().height(120.dp).clip(RoundedCornerShape(topStart = 8.dp, topEnd = 8.dp))" indent=indent+4 />
  </#if>
${""?left_pad(indent)}  Row(Modifier.fillMaxWidth().padding(Spacings.s3), verticalAlignment = Alignment.CenterVertically) {
    <#if guidbase.has_child_widget(widget, "avatar")>
<@avatar_circle uri=slot_var(widget,"avatar") size="40.dp" indent=indent+4 />
${""?left_pad(indent)}    Spacer(Modifier.width(Spacings.s3))
    </#if>
${""?left_pad(indent)}    Column(Modifier.weight(1f)) {
    <#if guidbase.has_child_widget(widget, "primary")>
${""?left_pad(indent)}      Text(${format_slot(widget,"primary")}, fontWeight = FontWeight.Bold, fontSize = Types.TextMd, color = Colors.TextMain)
    </#if>
    <#if guidbase.has_child_widget(widget, "secondary")>
${""?left_pad(indent)}      Text(${format_slot(widget,"secondary")}, fontSize = Types.TextSm, color = Colors.TextSecondary)
    </#if>
${""?left_pad(indent)}    }
${""?left_pad(indent)}  }
<@card_close indent=indent />
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
<@card_open indent=indent />
${""?left_pad(indent)}  Row(Modifier.fillMaxWidth().padding(Spacings.s3)) {
    <#if guidbase.has_child_widget(widget, "avatar")>
<@avatar_circle uri=slot_var(widget,"avatar") size="36.dp" indent=indent+4 />
${""?left_pad(indent)}    Spacer(Modifier.width(Spacings.s3))
    </#if>
${""?left_pad(indent)}    Column(Modifier.weight(1f)) {
${""?left_pad(indent)}      Row(Modifier.fillMaxWidth(), verticalAlignment = Alignment.CenterVertically) {
    <#if guidbase.has_child_widget(widget, "primary")>
${""?left_pad(indent)}        Text(${format_slot(widget,"primary")}, fontWeight = FontWeight.Bold, fontSize = Types.TextMd, color = Colors.TextMain, modifier = Modifier.weight(1f))
    </#if>
    <#if guidbase.has_child_widget(widget, "status")>
<@status_pill text=format_slot(widget,"status") indent=indent+4 />
    </#if>
${""?left_pad(indent)}      }
    <#if guidbase.has_child_widget(widget, "secondary")>
${""?left_pad(indent)}      Text(${format_slot(widget,"secondary")}, fontSize = Types.TextSm, color = Colors.TextSecondary)
    </#if>
    <#if guidbase.has_child_widget(widget, "start_time")>
${""?left_pad(indent)}      Text(${format_slot(widget,"start_time")}, fontSize = Types.TextXs, color = Colors.TextSecondary)
    </#if>
${""?left_pad(indent)}    }
${""?left_pad(indent)}  }
<@card_close indent=indent />
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
<@card_open modifier=".width(140.dp).padding(horizontal = Spacings.s5)" indent=indent />
${""?left_pad(indent)}  Row(Modifier.fillMaxWidth().padding(Spacings.s3), verticalAlignment = Alignment.CenterVertically) {
    <#if guidbase.has_child_widget(widget, "start_time")>
${""?left_pad(indent)}    Text(${format_slot(widget,"start_time")}, fontSize = Types.TextXs, color = Colors.TextSecondary, modifier = Modifier.weight(1f))
    </#if>
    <#if guidbase.has_child_widget(widget, "status")>
<@status_pill text=format_slot(widget,"status") indent=indent+4 />
    </#if>
${""?left_pad(indent)}  }
  <#if guidbase.has_child_widget(widget, "primary")>
${""?left_pad(indent)}  Text(${format_slot(widget,"primary")}, fontWeight = FontWeight.Bold, fontSize = Types.TextMd, color = Colors.TextMain, modifier = Modifier.padding(horizontal = Spacings.s3))
  </#if>
  <#if guidbase.has_child_widget(widget, "avatars")>
<@avatar_strip avatars=slot_var(widget,"avatars") modifier=".padding(horizontal = Spacings.s3, vertical = Spacings.s2)" indent=indent+4 />
  </#if>
<@card_close indent=indent />
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
<@card_open indent=indent />
${""?left_pad(indent)}  Row(Modifier.fillMaxWidth().padding(Spacings.s3)) {
    <#if guidbase.has_child_widget(widget, "status")>
${""?left_pad(indent)}    Box(Modifier.padding(end = Spacings.s3), contentAlignment = Alignment.Center) {
<@status_pill text=format_slot(widget,"status") indent=indent+4 />
${""?left_pad(indent)}    }
    </#if>
${""?left_pad(indent)}    Column(Modifier.weight(1f)) {
    <#if guidbase.has_child_widget(widget, "primary")>
${""?left_pad(indent)}      Text(${format_slot(widget,"primary")}, fontWeight = FontWeight.Bold, fontSize = Types.TextMd, color = Colors.TextMain)
    </#if>
    <#if guidbase.has_child_widget(widget, "secondary")>
${""?left_pad(indent)}      Text(${format_slot(widget,"secondary")}, fontSize = Types.TextSm, color = Colors.TextSecondary)
    </#if>
    <#if guidbase.has_child_widget(widget, "start_time")>
${""?left_pad(indent)}      Text(${format_slot(widget,"start_time")}, fontSize = Types.TextXs, color = Colors.TextSecondary)
    </#if>
${""?left_pad(indent)}    }
${""?left_pad(indent)}  }
<@card_close indent=indent />
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
<@card_open indent=indent />
  <#if guidbase.has_child_widget(widget, "tags")>
<@tag_chips tags=slot_var(widget,"tags") modifier=".padding(start = Spacings.s3, end = Spacings.s3, top = Spacings.s3)" indent=indent+4 />
  </#if>
  <#if guidbase.has_child_widget(widget, "primary")>
${""?left_pad(indent)}  Text(${format_slot(widget,"primary")}, fontWeight = FontWeight.Bold, fontSize = Types.TextMd, color = Colors.TextMain, modifier = Modifier.padding(horizontal = Spacings.s3))
  </#if>
${""?left_pad(indent)}  Row(Modifier.fillMaxWidth().padding(Spacings.s3), verticalAlignment = Alignment.CenterVertically) {
    <#if guidbase.has_child_widget(widget, "secondary")>
${""?left_pad(indent)}    Text(${format_slot(widget,"secondary")}, fontSize = Types.TextSm, color = Colors.TextSecondary, modifier = Modifier.weight(1f))
    </#if>
    <#if guidbase.has_child_widget(widget, "end_time")>
${""?left_pad(indent)}    Text(${format_slot(widget,"end_time")}, fontSize = Types.TextXs, color = Colors.TextSecondary)
    </#if>
${""?left_pad(indent)}  }
<@card_close indent=indent />
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
<@card_open indent=indent />
${""?left_pad(indent)}  Row(Modifier.fillMaxWidth().padding(Spacings.s3), verticalAlignment = Alignment.CenterVertically) {
    <#if guidbase.has_child_widget(widget, "start_time") || guidbase.has_child_widget(widget, "end_time")>
${""?left_pad(indent)}    Text(listOf(${format_slot(widget,"start_time")}, ${format_slot(widget,"end_time")}).filter { it.isNotEmpty() }.joinToString(" - "), fontSize = Types.TextXs, color = Colors.TextSecondary, modifier = Modifier.weight(1f))
    </#if>
    <#if guidbase.has_child_widget(widget, "status")>
<@status_pill text=format_slot(widget,"status") indent=indent+4 />
    </#if>
${""?left_pad(indent)}  }
  <#if guidbase.has_child_widget(widget, "primary")>
${""?left_pad(indent)}  Text(${format_slot(widget,"primary")}, fontWeight = FontWeight.Bold, fontSize = Types.TextMd, color = Colors.TextMain, modifier = Modifier.padding(horizontal = Spacings.s3))
  </#if>
  <#if guidbase.has_child_widget(widget, "avatars")>
${""?left_pad(indent)}  Row(Modifier.fillMaxWidth().padding(Spacings.s3)) {
<@avatar_strip avatars=slot_var(widget,"avatars") indent=indent+4 />
${""?left_pad(indent)}  }
  </#if>
<@card_close indent=indent />
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
<@card_open indent=indent />
${""?left_pad(indent)}  Row(Modifier.fillMaxWidth().padding(Spacings.s3)) {
    <#if guidbase.has_child_widget(widget, "avatar")>
<@avatar_circle uri=slot_var(widget,"avatar") size="40.dp" indent=indent+4 />
${""?left_pad(indent)}    Spacer(Modifier.width(Spacings.s3))
    </#if>
${""?left_pad(indent)}    Column(Modifier.weight(1f)) {
    <#if guidbase.has_child_widget(widget, "primary")>
${""?left_pad(indent)}      Text(${format_slot(widget,"primary")}, fontWeight = FontWeight.Bold, fontSize = Types.TextMd, color = Colors.TextMain)
    </#if>
    <#if guidbase.has_child_widget(widget, "start_time")>
${""?left_pad(indent)}      Text(${format_slot(widget,"start_time")}, fontSize = Types.TextXs, color = Colors.TextSecondary)
    </#if>
${""?left_pad(indent)}    }
${""?left_pad(indent)}  }
  <#if guidbase.has_child_widget(widget, "tertiary")>
${""?left_pad(indent)}  Text(${format_slot(widget,"tertiary")}, fontSize = Types.TextXs, color = Colors.TextTertiary, modifier = Modifier.padding(horizontal = Spacings.s3))
  </#if>
  <#if guidbase.has_child_widget(widget, "image")>
<@image_placeholder uri=slot_var(widget,"image") modifier=".fillMaxWidth().height(180.dp).clip(RoundedCornerShape(4.dp)).padding(horizontal = Spacings.s3)" indent=indent+4 />
  </#if>
${""?left_pad(indent)}  Row(Modifier.fillMaxWidth().padding(Spacings.s3), verticalAlignment = Alignment.CenterVertically) {
    <#if guidbase.has_child_widget(widget, "avatars")>
<@avatar_strip avatars=slot_var(widget,"avatars") modifier=".weight(1f)" indent=indent+4 />
    </#if>
    <#if guidbase.has_child_widget(widget, "tags")>
<@tag_chips tags=slot_var(widget,"tags") indent=indent+4 />
    </#if>
${""?left_pad(indent)}  }
<@card_close indent=indent />
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
<@card_open indent=indent />
  <#if guidbase.has_child_widget(widget, "image")>
<@image_placeholder uri=slot_var(widget,"image") modifier=".fillMaxWidth().height(160.dp).clip(RoundedCornerShape(topStart = 8.dp, topEnd = 8.dp))" indent=indent+4 />
  </#if>
  <#if guidbase.has_child_widget(widget, "tags")>
<@tag_chips tags=slot_var(widget,"tags") modifier=".padding(start = Spacings.s3, end = Spacings.s3, top = Spacings.s3)" indent=indent+4 />
  </#if>
  <#if guidbase.has_child_widget(widget, "primary")>
${""?left_pad(indent)}  Text(${format_slot(widget,"primary")}, fontWeight = FontWeight.Bold, fontSize = Types.TextMd, color = Colors.TextMain, modifier = Modifier.padding(horizontal = Spacings.s3))
  </#if>
  <#if guidbase.has_child_widget(widget, "secondary")>
${""?left_pad(indent)}  Text(${format_slot(widget,"secondary")}, fontSize = Types.TextSm, color = Colors.TextSecondary, modifier = Modifier.padding(horizontal = Spacings.s3))
  </#if>
${""?left_pad(indent)}  Row(Modifier.fillMaxWidth().padding(Spacings.s3), verticalAlignment = Alignment.CenterVertically) {
    <#if guidbase.has_child_widget(widget, "status")>
<@status_pill text=format_slot(widget,"status") modifier=".weight(1f)" indent=indent+4 />
    </#if>
    <#if guidbase.has_child_widget(widget, "end_time")>
${""?left_pad(indent)}    Text(${format_slot(widget,"end_time")}, fontSize = Types.TextXs, color = Colors.TextSecondary)
    </#if>
${""?left_pad(indent)}  }
<@card_close indent=indent />
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
<@card_open indent=indent />
${""?left_pad(indent)}  Row(Modifier.fillMaxWidth().padding(Spacings.s3), verticalAlignment = Alignment.CenterVertically) {
    <#if guidbase.has_child_widget(widget, "avatar")>
<@avatar_circle uri=slot_var(widget,"avatar") size="40.dp" indent=indent+4 />
    </#if>
    <#if guidbase.has_child_widget(widget, "status")>
${""?left_pad(indent)}    Spacer(Modifier.weight(1f))
<@status_pill text=format_slot(widget,"status") indent=indent+4 />
${""?left_pad(indent)}    Spacer(Modifier.weight(1f))
    </#if>
    <#if guidbase.has_child_widget(widget, "primary") && guidbase.has_child_widget(widget, "secondary")>
<@avatar_circle uri=slot_var(widget,"secondary") size="40.dp" indent=indent+4 />
    </#if>
${""?left_pad(indent)}  }
${""?left_pad(indent)}  Row(Modifier.fillMaxWidth().padding(horizontal = Spacings.s3), horizontalArrangement = Arrangement.SpaceBetween) {
    <#if guidbase.has_child_widget(widget, "primary")>
${""?left_pad(indent)}    Text(${format_slot(widget,"primary")}, fontWeight = FontWeight.Bold, fontSize = Types.TextSm, color = Colors.TextMain)
    </#if>
    <#if guidbase.has_child_widget(widget, "secondary")>
${""?left_pad(indent)}    Text(${format_slot(widget,"secondary")}, fontSize = Types.TextSm, color = Colors.TextSecondary)
    </#if>
${""?left_pad(indent)}  }
${""?left_pad(indent)}  Row(Modifier.fillMaxWidth().padding(horizontal = Spacings.s3, vertical = Spacings.s2), horizontalArrangement = Arrangement.SpaceBetween) {
    <#if guidbase.has_child_widget(widget, "start_time")>
${""?left_pad(indent)}    Text(${format_slot(widget,"start_time")}, fontSize = Types.TextXs, color = Colors.TextSecondary)
    </#if>
    <#if guidbase.has_child_widget(widget, "end_time")>
${""?left_pad(indent)}    Text(${format_slot(widget,"end_time")}, fontSize = Types.TextXs, color = Colors.TextSecondary)
    </#if>
${""?left_pad(indent)}  }
<@card_close indent=indent />
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
<@card_open indent=indent />
${""?left_pad(indent)}  Row(Modifier.fillMaxWidth().padding(Spacings.s3)) {
    <#if guidbase.has_child_widget(widget, "image")>
<@image_placeholder uri=slot_var(widget,"image") modifier=".size(100.dp).clip(RoundedCornerShape(8.dp))" indent=indent+4 />
${""?left_pad(indent)}    Spacer(Modifier.width(Spacings.s3))
    </#if>
${""?left_pad(indent)}    Column(Modifier.weight(1f)) {
    <#if guidbase.has_child_widget(widget, "tags")>
<@tag_chips tags=slot_var(widget,"tags") indent=indent+4 />
    </#if>
    <#if guidbase.has_child_widget(widget, "primary")>
${""?left_pad(indent)}      Text(${format_slot(widget,"primary")}, fontWeight = FontWeight.Bold, fontSize = Types.TextMd, color = Colors.TextMain)
    </#if>
    <#if guidbase.has_child_widget(widget, "secondary")>
${""?left_pad(indent)}      Text(${format_slot(widget,"secondary")}, fontSize = Types.TextSm, color = Colors.TextSecondary)
    </#if>
    <#if guidbase.has_child_widget(widget, "tertiary")>
${""?left_pad(indent)}      Text(${format_slot(widget,"tertiary")}, fontSize = Types.TextXs, color = Colors.TextTertiary)
    </#if>
${""?left_pad(indent)}      Row(Modifier.fillMaxWidth(), verticalAlignment = Alignment.CenterVertically) {
    <#if guidbase.has_child_widget(widget, "status")>
<@status_pill text=format_slot(widget,"status") modifier=".weight(1f)" indent=indent+4 />
    </#if>
    <#if guidbase.has_child_widget(widget, "avatars")>
<@avatar_strip avatars=slot_var(widget,"avatars") indent=indent+4 />
    </#if>
${""?left_pad(indent)}      }
${""?left_pad(indent)}    }
${""?left_pad(indent)}  }
<@card_close indent=indent />
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
<@card_open indent=indent />
${""?left_pad(indent)}  Row(Modifier.fillMaxWidth().padding(Spacings.s3), verticalAlignment = Alignment.CenterVertically) {
    <#if guidbase.has_child_widget(widget, "start_time")>
${""?left_pad(indent)}    Text(${format_slot(widget,"start_time")}, fontSize = Types.TextXs, color = Colors.TextSecondary)
${""?left_pad(indent)}    Text("  >  ", fontSize = Types.TextSm, color = Colors.Accent)
    </#if>
    <#if guidbase.has_child_widget(widget, "avatars")>
<@avatar_strip avatars=slot_var(widget,"avatars") indent=indent+4 />
${""?left_pad(indent)}    Text("  >  ", fontSize = Types.TextSm, color = Colors.Accent)
    </#if>
    <#if guidbase.has_child_widget(widget, "status")>
<@status_pill text=format_slot(widget,"status") indent=indent+4 />
${""?left_pad(indent)}    Text("  >  ", fontSize = Types.TextSm, color = Colors.Accent)
    </#if>
    <#if guidbase.has_child_widget(widget, "end_time")>
${""?left_pad(indent)}    Text(${format_slot(widget,"end_time")}, fontSize = Types.TextXs, color = Colors.TextSecondary)
    </#if>
${""?left_pad(indent)}  }
  <#if guidbase.has_child_widget(widget, "primary")>
${""?left_pad(indent)}  Text(${format_slot(widget,"primary")}, fontWeight = FontWeight.Bold, fontSize = Types.TextMd, color = Colors.TextMain, modifier = Modifier.padding(horizontal = Spacings.s3, vertical = Spacings.s2))
  </#if>
<@card_close indent=indent />
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
<@card_open indent=indent />
  <#if guidbase.has_child_widget(widget, "background")>
${""?left_pad(indent)}  Box(Modifier.fillMaxWidth().height(140.dp)) {
<@image_placeholder uri=slot_var(widget,"background") modifier=".fillMaxSize()" indent=indent+4 />
${""?left_pad(indent)}  }
  </#if>
${""?left_pad(indent)}  Box(Modifier.fillMaxSize(), contentAlignment = Alignment.Center) {
${""?left_pad(indent)}    Column(Modifier.fillMaxWidth().padding(Spacings.s3)) {
    <#if guidbase.has_child_widget(widget, "tags")>
<@tag_chips tags=slot_var(widget,"tags") indent=indent+4 />
    </#if>
    <#if guidbase.has_child_widget(widget, "primary")>
${""?left_pad(indent)}      Text(${format_slot(widget,"primary")}, fontWeight = FontWeight.Bold, fontSize = Types.TextMd, color = Colors.TextMain)
    </#if>
${""?left_pad(indent)}      Row(Modifier.fillMaxWidth(), verticalAlignment = Alignment.CenterVertically) {
    <#if guidbase.has_child_widget(widget, "avatar")>
<@avatar_circle uri=slot_var(widget,"avatar") size="32.dp" indent=indent+4 />
${""?left_pad(indent)}        Spacer(Modifier.width(Spacings.s2))
    </#if>
    <#if guidbase.has_child_widget(widget, "secondary")>
${""?left_pad(indent)}        Text(${format_slot(widget,"secondary")}, fontSize = Types.TextSm, color = Colors.TextSecondary)
    </#if>
${""?left_pad(indent)}      }
${""?left_pad(indent)}    }
${""?left_pad(indent)}  }
<@card_close indent=indent />
</#macro>

<#--
微型标记 (Micro Badge)
+----------------------------------+
| [avatar]  [primary]     [status] |
+----------------------------------+
-->
<#macro print_tile_micro_badge widget indent=0>
<@card_open indent=indent />
${""?left_pad(indent)}  Row(Modifier.fillMaxWidth().padding(Spacings.s3), verticalAlignment = Alignment.CenterVertically) {
    <#if guidbase.has_child_widget(widget, "avatar")>
<@avatar_circle uri=slot_var(widget,"avatar") size="28.dp" indent=indent+4 />
${""?left_pad(indent)}    Spacer(Modifier.width(Spacings.s2))
    </#if>
    <#if guidbase.has_child_widget(widget, "primary")>
${""?left_pad(indent)}    Text(${format_slot(widget,"primary")}, fontWeight = FontWeight.Bold, fontSize = Types.TextSm, color = Colors.TextMain, modifier = Modifier.weight(1f))
    </#if>
    <#if guidbase.has_child_widget(widget, "status")>
<@status_pill text=format_slot(widget,"status") indent=indent+4 />
    </#if>
${""?left_pad(indent)}  }
<@card_close indent=indent />
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
<@card_open indent=indent />
${""?left_pad(indent)}  Row(Modifier.fillMaxWidth().padding(Spacings.s3)) {
    <#if guidbase.has_child_widget(widget, "status")>
<@status_pill text=format_slot(widget,"status") indent=indent+4 />
${""?left_pad(indent)}    Spacer(Modifier.width(Spacings.s3))
    </#if>
${""?left_pad(indent)}    Column(Modifier.weight(1f)) {
    <#if guidbase.has_child_widget(widget, "primary")>
${""?left_pad(indent)}      Text(${format_slot(widget,"primary")}, fontWeight = FontWeight.Bold, fontSize = Types.TextMd, color = Colors.TextMain)
    </#if>
    <#if guidbase.has_child_widget(widget, "secondary")>
${""?left_pad(indent)}      Row(Modifier.padding(start = Spacings.s3)) {
${""?left_pad(indent)}        Text("├─", fontSize = Types.TextSm, color = Colors.TextTertiary)
${""?left_pad(indent)}        Text(${format_slot(widget,"secondary")}, fontSize = Types.TextSm, color = Colors.TextSecondary)
${""?left_pad(indent)}      }
    </#if>
    <#if guidbase.has_child_widget(widget, "start_time") || guidbase.has_child_widget(widget, "end_time")>
${""?left_pad(indent)}      Row(Modifier.padding(start = Spacings.s3)) {
${""?left_pad(indent)}        Text("├─", fontSize = Types.TextSm, color = Colors.TextTertiary)
${""?left_pad(indent)}        Text(listOf(${format_slot(widget,"start_time")}, ${format_slot(widget,"end_time")}).filter { it.isNotEmpty() }.joinToString(" - "), fontSize = Types.TextXs, color = Colors.TextSecondary)
${""?left_pad(indent)}      }
    </#if>
${""?left_pad(indent)}    }
${""?left_pad(indent)}  }
<@card_close indent=indent />
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
<@card_open indent=indent />
  <#if guidbase.has_child_widget(widget, "image")>
<@image_placeholder uri=slot_var(widget,"image") modifier=".fillMaxWidth().height(120.dp).clip(RoundedCornerShape(topStart = 8.dp, topEnd = 8.dp))" indent=indent+4 />
  </#if>
<@card_open modifier=".padding(Spacings.s5).offset(y = (-16).dp)" indent=indent+2 />
${""?left_pad(indent)}    Column(Modifier.fillMaxWidth().padding(Spacings.s3)) {
    <#if guidbase.has_child_widget(widget, "primary")>
${""?left_pad(indent)}      Text(${format_slot(widget,"primary")}, fontWeight = FontWeight.Bold, fontSize = Types.TextMd, color = Colors.TextMain)
    </#if>
${""?left_pad(indent)}      Row(Modifier.fillMaxWidth(), verticalAlignment = Alignment.CenterVertically) {
    <#if guidbase.has_child_widget(widget, "secondary")>
${""?left_pad(indent)}        Text(${format_slot(widget,"secondary")}, fontSize = Types.TextSm, color = Colors.TextSecondary, modifier = Modifier.weight(1f))
    </#if>
    <#if guidbase.has_child_widget(widget, "status")>
<@status_pill text=format_slot(widget,"status") indent=indent+4 />
    </#if>
${""?left_pad(indent)}      }
${""?left_pad(indent)}    }
<@card_close indent=indent+2 />
<@card_close indent=indent />
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
<@card_open indent=indent />
  <#if guidbase.has_child_widget(widget, "avatars")>
${""?left_pad(indent)}  Row(Modifier.fillMaxWidth().padding(Spacings.s3)) {
<@avatar_strip avatars=slot_var(widget,"avatars") indent=indent+4 />
${""?left_pad(indent)}  }
  </#if>
  <#if guidbase.has_child_widget(widget, "primary")>
${""?left_pad(indent)}  Text(${format_slot(widget,"primary")}, fontWeight = FontWeight.Bold, fontSize = Types.TextMd, color = Colors.TextMain, modifier = Modifier.padding(horizontal = Spacings.s3))
  </#if>
  <#if guidbase.has_child_widget(widget, "tertiary")>
${""?left_pad(indent)}  Text(${format_slot(widget,"tertiary")}, fontSize = Types.TextXs, color = Colors.TextTertiary, modifier = Modifier.padding(horizontal = Spacings.s3))
  </#if>
${""?left_pad(indent)}  Row(Modifier.fillMaxWidth().padding(Spacings.s3), verticalAlignment = Alignment.CenterVertically) {
    <#if guidbase.has_child_widget(widget, "tags")>
<@tag_chips tags=slot_var(widget,"tags") modifier=".weight(1f)" indent=indent+4 />
    </#if>
    <#if guidbase.has_child_widget(widget, "status")>
<@status_pill text=format_slot(widget,"status") indent=indent+4 />
    </#if>
${""?left_pad(indent)}  }
<@card_close indent=indent />
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
<@card_open modifier=".width(160.dp).padding(horizontal = Spacings.s5)" indent=indent />
  <#if guidbase.has_child_widget(widget, "status")>
<@status_pill text=format_slot(widget,"status") modifier=".padding(Spacings.s3)" indent=indent+4 />
  </#if>
  <#if guidbase.has_child_widget(widget, "image")>
<@image_placeholder uri=slot_var(widget,"image") modifier=".fillMaxWidth().height(120.dp).clip(RoundedCornerShape(8.dp)).padding(horizontal = Spacings.s3)" indent=indent+4 />
  </#if>
  <#if guidbase.has_child_widget(widget, "primary")>
${""?left_pad(indent)}  Text(${format_slot(widget,"primary")}, fontWeight = FontWeight.Bold, fontSize = Types.TextSm, color = Colors.TextMain, modifier = Modifier.padding(horizontal = Spacings.s3, vertical = Spacings.s1))
  </#if>
  <#if guidbase.has_child_widget(widget, "secondary")>
${""?left_pad(indent)}  Text(${format_slot(widget,"secondary")}, fontSize = Types.TextXs, color = Colors.TextSecondary, modifier = Modifier.padding(horizontal = Spacings.s3))
  </#if>
  <#if guidbase.has_child_widget(widget, "tags")>
<@tag_chips tags=slot_var(widget,"tags") modifier=".padding(horizontal = Spacings.s3, vertical = Spacings.s1)" indent=indent+4 />
  </#if>
  <#if guidbase.has_child_widget(widget, "avatars")>
<@avatar_strip avatars=slot_var(widget,"avatars") modifier=".padding(horizontal = Spacings.s3, vertical = Spacings.s2)" indent=indent+4 />
  </#if>
<@card_close indent=indent />
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
<@card_open indent=indent />
${""?left_pad(indent)}  Row(Modifier.fillMaxWidth().padding(Spacings.s3), horizontalArrangement = Arrangement.SpaceBetween) {
    <#if guidbase.has_child_widget(widget, "primary")>
${""?left_pad(indent)}    Text(${format_slot(widget,"primary")}, fontWeight = FontWeight.Bold, fontSize = Types.TextSm, color = Colors.TextMain)
    </#if>
    <#if guidbase.has_child_widget(widget, "start_time")>
${""?left_pad(indent)}    Text(${format_slot(widget,"start_time")}, fontSize = Types.TextXs, color = Colors.TextSecondary)
    </#if>
${""?left_pad(indent)}  }
${""?left_pad(indent)}  Row(Modifier.fillMaxWidth().padding(horizontal = Spacings.s3), horizontalArrangement = Arrangement.SpaceBetween) {
    <#if guidbase.has_child_widget(widget, "secondary")>
${""?left_pad(indent)}    Text(${format_slot(widget,"secondary")}, fontSize = Types.TextXs, color = Colors.TextSecondary)
    </#if>
    <#if guidbase.has_child_widget(widget, "end_time")>
${""?left_pad(indent)}    Text(${format_slot(widget,"end_time")}, fontSize = Types.TextXs, color = Colors.TextSecondary)
    </#if>
${""?left_pad(indent)}  }
${""?left_pad(indent)}  Row(Modifier.fillMaxWidth().padding(Spacings.s3), horizontalArrangement = Arrangement.SpaceBetween, verticalAlignment = Alignment.CenterVertically) {
    <#if guidbase.has_child_widget(widget, "avatar")>
<@avatar_circle uri=slot_var(widget,"avatar") size="32.dp" indent=indent+4 />
    </#if>
    <#if guidbase.has_child_widget(widget, "status")>
<@status_pill text=format_slot(widget,"status") indent=indent+4 />
    </#if>
${""?left_pad(indent)}  }
<@card_close indent=indent />
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
<@card_open indent=indent />
${""?left_pad(indent)}  Row(Modifier.fillMaxWidth().padding(Spacings.s3), horizontalArrangement = Arrangement.SpaceBetween) {
    <#if guidbase.has_child_widget(widget, "status")>
<@status_pill text=format_slot(widget,"status") indent=indent+4 />
    </#if>
    <#if guidbase.has_child_widget(widget, "start_time")>
${""?left_pad(indent)}    Text(${format_slot(widget,"start_time")}, fontSize = Types.TextXs, color = Colors.TextSecondary)
    </#if>
${""?left_pad(indent)}  }
${""?left_pad(indent)}  Row(Modifier.fillMaxWidth().padding(horizontal = Spacings.s3)) {
${""?left_pad(indent)}    Column(Modifier.weight(1f)) {
    <#if guidbase.has_child_widget(widget, "primary")>
${""?left_pad(indent)}      Text(${format_slot(widget,"primary")}, fontWeight = FontWeight.Bold, fontSize = Types.TextSm, color = Colors.TextMain)
    </#if>
    <#if guidbase.has_child_widget(widget, "tertiary")>
${""?left_pad(indent)}      Text(${format_slot(widget,"tertiary")}, fontSize = Types.TextXs, color = Colors.TextTertiary)
    </#if>
${""?left_pad(indent)}    }
${""?left_pad(indent)}    Column(Modifier.weight(1f)) {
    <#if guidbase.has_child_widget(widget, "secondary")>
${""?left_pad(indent)}      Text(${format_slot(widget,"secondary")}, fontSize = Types.TextSm, color = Colors.TextSecondary)
    </#if>
    <#if guidbase.has_child_widget(widget, "tags")>
<@tag_chips tags=slot_var(widget,"tags") indent=indent+4 />
    </#if>
${""?left_pad(indent)}    }
${""?left_pad(indent)}  }
  <#if guidbase.has_child_widget(widget, "avatars")>
<@avatar_strip avatars=slot_var(widget,"avatars") modifier=".padding(horizontal = Spacings.s3, vertical = Spacings.s2)" indent=indent+4 />
  </#if>
<@card_close indent=indent />
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
<@card_open indent=indent />
${""?left_pad(indent)}  Row(Modifier.fillMaxWidth().padding(Spacings.s3)) {
    <#if guidbase.has_child_widget(widget, "image")>
<@image_placeholder uri=slot_var(widget,"image") modifier=".size(56.dp).clip(RoundedCornerShape(8.dp))" indent=indent+4 />
${""?left_pad(indent)}    Spacer(Modifier.width(Spacings.s3))
    </#if>
${""?left_pad(indent)}    Column(Modifier.weight(1f)) {
    <#if guidbase.has_child_widget(widget, "primary")>
${""?left_pad(indent)}      Text(${format_slot(widget,"primary")}, fontWeight = FontWeight.Bold, fontSize = Types.TextMd, color = Colors.TextMain)
    </#if>
    <#if guidbase.has_child_widget(widget, "secondary")>
${""?left_pad(indent)}      Text(${format_slot(widget,"secondary")}, fontSize = Types.TextSm, color = Colors.TextSecondary)
    </#if>
    <#if guidbase.has_child_widget(widget, "start_time") || guidbase.has_child_widget(widget, "end_time")>
${""?left_pad(indent)}      Row(Modifier.fillMaxWidth(), verticalAlignment = Alignment.CenterVertically) {
    <#if guidbase.has_child_widget(widget, "start_time")>
${""?left_pad(indent)}        Text(${format_slot(widget,"start_time")}, fontSize = Types.TextXs, color = Colors.TextSecondary)
    </#if>
${""?left_pad(indent)}        Box(Modifier.weight(1f).height(2.dp).padding(horizontal = Spacings.s2).background(Colors.Accent, RoundedCornerShape(1.dp)))
    <#if guidbase.has_child_widget(widget, "end_time")>
${""?left_pad(indent)}        Text(${format_slot(widget,"end_time")}, fontSize = Types.TextXs, color = Colors.TextSecondary)
    </#if>
${""?left_pad(indent)}      }
    </#if>
${""?left_pad(indent)}    }
${""?left_pad(indent)}  }
${""?left_pad(indent)}  Row(Modifier.fillMaxWidth().padding(Spacings.s3), verticalAlignment = Alignment.CenterVertically) {
    <#if guidbase.has_child_widget(widget, "avatar")>
<@avatar_circle uri=slot_var(widget,"avatar") size="28.dp" indent=indent+4 />
    </#if>
    <#if guidbase.has_child_widget(widget, "status")>
${""?left_pad(indent)}    Spacer(Modifier.weight(1f))
<@status_pill text=format_slot(widget,"status") indent=indent+4 />
    </#if>
${""?left_pad(indent)}  }
<@card_close indent=indent />
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
<@card_open indent=indent />
${""?left_pad(indent)}  Row(Modifier.fillMaxWidth().padding(Spacings.s3), verticalAlignment = Alignment.CenterVertically) {
    <#if guidbase.has_child_widget(widget, "start_time")>
${""?left_pad(indent)}    Text(${format_slot(widget,"start_time")}, fontSize = Types.TextXs, color = Colors.TextSecondary, modifier = Modifier.weight(1f))
    </#if>
    <#if guidbase.has_child_widget(widget, "status")>
<@status_pill text=format_slot(widget,"status") indent=indent+4 />
    </#if>
${""?left_pad(indent)}  }
  <#if guidbase.has_child_widget(widget, "primary")>
${""?left_pad(indent)}  Text(${format_slot(widget,"primary")}, fontWeight = FontWeight.Bold, fontSize = Types.TextMd, color = Colors.TextMain, modifier = Modifier.padding(horizontal = Spacings.s3))
  </#if>
  <#if guidbase.has_child_widget(widget, "secondary")>
${""?left_pad(indent)}  Text(${format_slot(widget,"secondary")}, fontSize = Types.TextSm, color = Colors.TextSecondary, modifier = Modifier.padding(horizontal = Spacings.s3))
  </#if>
  <#if guidbase.has_child_widget(widget, "avatar")>
<@avatar_circle uri=slot_var(widget,"avatar") size="32.dp" indent=indent+4 />
  </#if>
<@card_close indent=indent />
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
<@card_open indent=indent />
${""?left_pad(indent)}  Row(Modifier.fillMaxWidth().padding(Spacings.s3), verticalAlignment = Alignment.CenterVertically) {
    <#if guidbase.has_child_widget(widget, "start_time") || guidbase.has_child_widget(widget, "end_time")>
${""?left_pad(indent)}    Text(listOf(${format_slot(widget,"start_time")}, ${format_slot(widget,"end_time")}).filter { it.isNotEmpty() }.joinToString(" - "), fontSize = Types.TextXs, color = Colors.TextSecondary, modifier = Modifier.weight(1f))
    </#if>
    <#if guidbase.has_child_widget(widget, "status")>
<@status_pill text=format_slot(widget,"status") indent=indent+4 />
    </#if>
${""?left_pad(indent)}  }
  <#if guidbase.has_child_widget(widget, "primary")>
${""?left_pad(indent)}  Text(${format_slot(widget,"primary")}, fontWeight = FontWeight.Bold, fontSize = Types.TextMd, color = Colors.TextMain, modifier = Modifier.padding(horizontal = Spacings.s3))
  </#if>
  <#if guidbase.has_child_widget(widget, "avatars")>
<@avatar_strip avatars=slot_var(widget,"avatars") modifier=".padding(horizontal = Spacings.s3, vertical = Spacings.s2)" indent=indent+4 />
  </#if>
<@card_close indent=indent />
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
<@card_open indent=indent />
  <#if guidbase.has_child_widget(widget, "start_time")>
${""?left_pad(indent)}  Text(${format_slot(widget,"start_time")}, fontSize = Types.TextXs, color = Colors.TextSecondary, modifier = Modifier.padding(start = Spacings.s3, top = Spacings.s3))
  </#if>
${""?left_pad(indent)}  Row(Modifier.fillMaxWidth().padding(Spacings.s3)) {
    <#if guidbase.has_child_widget(widget, "image")>
<@image_placeholder uri=slot_var(widget,"image") modifier=".size(64.dp).clip(RoundedCornerShape(8.dp))" indent=indent+4 />
${""?left_pad(indent)}    Spacer(Modifier.width(Spacings.s3))
    </#if>
${""?left_pad(indent)}    Column(Modifier.weight(1f)) {
    <#if guidbase.has_child_widget(widget, "primary")>
${""?left_pad(indent)}      Text(${format_slot(widget,"primary")}, fontWeight = FontWeight.Bold, fontSize = Types.TextMd, color = Colors.TextMain)
    </#if>
    <#if guidbase.has_child_widget(widget, "secondary")>
${""?left_pad(indent)}      Text(${format_slot(widget,"secondary")}, fontSize = Types.TextSm, color = Colors.TextSecondary)
    </#if>
    <#if guidbase.has_child_widget(widget, "tags")>
<@tag_chips tags=slot_var(widget,"tags") indent=indent+4 />
    </#if>
${""?left_pad(indent)}    }
${""?left_pad(indent)}  }
<@card_close indent=indent />
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
<@card_open indent=indent />
${""?left_pad(indent)}  Row(Modifier.fillMaxWidth().padding(Spacings.s3), verticalAlignment = Alignment.CenterVertically) {
    <#if guidbase.has_child_widget(widget, "start_time")>
${""?left_pad(indent)}    Text(${format_slot(widget,"start_time")}, fontSize = Types.TextXs, color = Colors.TextSecondary, modifier = Modifier.weight(1f))
    </#if>
    <#if guidbase.has_child_widget(widget, "status")>
<@status_pill text=format_slot(widget,"status") indent=indent+4 />
    </#if>
${""?left_pad(indent)}  }
  <#if guidbase.has_child_widget(widget, "primary")>
${""?left_pad(indent)}  Text(${format_slot(widget,"primary")}, fontWeight = FontWeight.Bold, fontSize = Types.TextMd, color = Colors.TextMain, modifier = Modifier.padding(horizontal = Spacings.s3))
  </#if>
${""?left_pad(indent)}  Row(Modifier.fillMaxWidth().padding(Spacings.s3), verticalAlignment = Alignment.CenterVertically) {
    <#if guidbase.has_child_widget(widget, "avatar")>
<@avatar_circle uri=slot_var(widget,"avatar") size="28.dp" indent=indent+4 />
${""?left_pad(indent)}    Spacer(Modifier.width(Spacings.s2))
    </#if>
    <#if guidbase.has_child_widget(widget, "secondary")>
${""?left_pad(indent)}    Text(${format_slot(widget,"secondary")}, fontSize = Types.TextSm, color = Colors.TextSecondary)
    </#if>
${""?left_pad(indent)}  }
<@card_close indent=indent />
</#macro>

<#--
极简时间单元 (Compact Time Tile)
+-----------------------------------------------+
| [start time]  |  [status]  |  [primary]       |
| [tags]                                        |
+-----------------------------------------------+
-->
<#macro print_tile_compact_time widget indent=0>
<@card_open indent=indent />
${""?left_pad(indent)}  Row(Modifier.fillMaxWidth().padding(Spacings.s3), verticalAlignment = Alignment.CenterVertically) {
    <#if guidbase.has_child_widget(widget, "start_time")>
${""?left_pad(indent)}    Text(${format_slot(widget,"start_time")}, fontSize = Types.TextXs, color = Colors.TextSecondary)
${""?left_pad(indent)}    Text(" | ", fontSize = Types.TextSm, color = Colors.TextTertiary)
    </#if>
    <#if guidbase.has_child_widget(widget, "status")>
<@status_pill text=format_slot(widget,"status") indent=indent+4 />
${""?left_pad(indent)}    Text(" | ", fontSize = Types.TextSm, color = Colors.TextTertiary)
    </#if>
    <#if guidbase.has_child_widget(widget, "primary")>
${""?left_pad(indent)}    Text(${format_slot(widget,"primary")}, fontWeight = FontWeight.Bold, fontSize = Types.TextSm, color = Colors.TextMain, modifier = Modifier.weight(1f))
    </#if>
${""?left_pad(indent)}  }
  <#if guidbase.has_child_widget(widget, "tags")>
<@tag_chips tags=slot_var(widget,"tags") modifier=".padding(horizontal = Spacings.s3, vertical = Spacings.s2)" indent=indent+4 />
  </#if>
<@card_close indent=indent />
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
<@card_open indent=indent />
  <#if guidbase.has_child_widget(widget, "start_time")>
${""?left_pad(indent)}  Text(${format_slot(widget,"start_time")}, fontSize = Types.TextXs, color = Colors.TextSecondary, modifier = Modifier.padding(start = Spacings.s3, top = Spacings.s3))
  </#if>
  <#if guidbase.has_child_widget(widget, "primary")>
${""?left_pad(indent)}  Text(${format_slot(widget,"primary")}, fontWeight = FontWeight.Bold, fontSize = Types.TextMd, color = Colors.TextMain, modifier = Modifier.padding(horizontal = Spacings.s3))
  </#if>
  <#if guidbase.has_child_widget(widget, "status")>
<@status_pill text=format_slot(widget,"status") modifier=".padding(horizontal = Spacings.s3, vertical = Spacings.s2)" indent=indent+4 />
  </#if>
<@card_close indent=indent />
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
<@card_open indent=indent />
  <#if guidbase.has_child_widget(widget, "start_time")>
${""?left_pad(indent)}  Row(Modifier.fillMaxWidth().padding(Spacings.s3), horizontalArrangement = Arrangement.End) {
${""?left_pad(indent)}    Text(${format_slot(widget,"start_time")}, fontSize = Types.TextXs, color = Colors.TextSecondary)
${""?left_pad(indent)}  }
  </#if>
  <#if guidbase.has_child_widget(widget, "primary")>
${""?left_pad(indent)}  Text(${format_slot(widget,"primary")}, fontWeight = FontWeight.Bold, fontSize = Types.TextMd, color = Colors.TextMain, modifier = Modifier.padding(horizontal = Spacings.s3))
  </#if>
  <#if guidbase.has_child_widget(widget, "tags")>
<@tag_chips tags=slot_var(widget,"tags") modifier=".padding(horizontal = Spacings.s3, vertical = Spacings.s2)" indent=indent+4 />
  </#if>
<@card_close indent=indent />
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
<@card_open indent=indent />
  <#if guidbase.has_child_widget(widget, "start_time")>
${""?left_pad(indent)}  Row(Modifier.fillMaxWidth().padding(Spacings.s3), horizontalArrangement = Arrangement.Start) {
${""?left_pad(indent)}    Text(${format_slot(widget,"start_time")}, fontSize = Types.TextXs, color = Colors.TextSecondary)
${""?left_pad(indent)}  }
  </#if>
  <#if guidbase.has_child_widget(widget, "primary")>
${""?left_pad(indent)}  Row(Modifier.fillMaxWidth().padding(horizontal = Spacings.s3), horizontalArrangement = Arrangement.End) {
${""?left_pad(indent)}    Text(${format_slot(widget,"primary")}, fontWeight = FontWeight.Bold, fontSize = Types.TextMd, color = Colors.TextMain)
${""?left_pad(indent)}  }
  </#if>
  <#if guidbase.has_child_widget(widget, "tags")>
${""?left_pad(indent)}  Row(Modifier.fillMaxWidth().padding(horizontal = Spacings.s3, vertical = Spacings.s2), horizontalArrangement = Arrangement.End) {
<@tag_chips tags=slot_var(widget,"tags") indent=indent+4 />
${""?left_pad(indent)}  }
  </#if>
<@card_close indent=indent />
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
<@card_open indent=indent />
  <#if guidbase.has_child_widget(widget, "start_time")>
${""?left_pad(indent)}  Text(${format_slot(widget,"start_time")}, fontSize = Types.TextXs, color = Colors.TextSecondary, modifier = Modifier.padding(start = Spacings.s3, top = Spacings.s3))
  </#if>
  <#if guidbase.has_child_widget(widget, "primary")>
${""?left_pad(indent)}  Text(${format_slot(widget,"primary")}, fontWeight = FontWeight.Bold, fontSize = Types.TextMd, color = Colors.TextMain, modifier = Modifier.padding(horizontal = Spacings.s3))
  </#if>
${""?left_pad(indent)}  Text("│", fontSize = Types.TextSm, color = Colors.TextTertiary, modifier = Modifier.padding(start = Spacings.s5))
  <#if guidbase.has_child_widget(widget, "end_time")>
${""?left_pad(indent)}  Text(${format_slot(widget,"end_time")}, fontSize = Types.TextXs, color = Colors.TextSecondary, modifier = Modifier.padding(horizontal = Spacings.s3))
  </#if>
  <#if guidbase.has_child_widget(widget, "secondary") || guidbase.has_child_widget(widget, "status")>
${""?left_pad(indent)}  Row(Modifier.fillMaxWidth().padding(Spacings.s3), verticalAlignment = Alignment.CenterVertically) {
    <#if guidbase.has_child_widget(widget, "secondary")>
${""?left_pad(indent)}    Text(${format_slot(widget,"secondary")}, fontSize = Types.TextSm, color = Colors.TextSecondary, modifier = Modifier.weight(1f))
    </#if>
    <#if guidbase.has_child_widget(widget, "status")>
<@status_pill text=format_slot(widget,"status") indent=indent+4 />
    </#if>
${""?left_pad(indent)}  }
  </#if>
<@card_close indent=indent />
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
<@card_open indent=indent />
${""?left_pad(indent)}  Row(Modifier.fillMaxWidth().padding(Spacings.s3), horizontalArrangement = Arrangement.SpaceEvenly, verticalAlignment = Alignment.CenterVertically) {
    <#if guidbase.has_child_widget(widget, "start_time")>
${""?left_pad(indent)}    Text(${format_slot(widget,"start_time")}, fontSize = Types.TextXs, color = Colors.TextSecondary)
${""?left_pad(indent)}    Text("  >  ", fontSize = Types.TextSm, color = Colors.Accent)
    </#if>
    <#if guidbase.has_child_widget(widget, "tags")>
<@tag_chips tags=slot_var(widget,"tags") indent=indent+4 />
${""?left_pad(indent)}    Text("  >  ", fontSize = Types.TextSm, color = Colors.Accent)
    </#if>
    <#if guidbase.has_child_widget(widget, "end_time")>
${""?left_pad(indent)}    Text(${format_slot(widget,"end_time")}, fontSize = Types.TextXs, color = Colors.TextSecondary)
    </#if>
${""?left_pad(indent)}  }
${""?left_pad(indent)}  Row(Modifier.fillMaxWidth().padding(horizontal = Spacings.s3, vertical = Spacings.s2), horizontalArrangement = Arrangement.SpaceEvenly) {
    <#if guidbase.has_child_widget(widget, "primary")>
${""?left_pad(indent)}    Text(${format_slot(widget,"primary")}, fontWeight = FontWeight.Bold, fontSize = Types.TextSm, color = Colors.TextMain)
${""?left_pad(indent)}    Text("  >  ", fontSize = Types.TextSm, color = Colors.Accent)
    </#if>
    <#if guidbase.has_child_widget(widget, "secondary")>
${""?left_pad(indent)}    Text(${format_slot(widget,"secondary")}, fontSize = Types.TextSm, color = Colors.TextSecondary)
${""?left_pad(indent)}    Text("  >  ", fontSize = Types.TextSm, color = Colors.Accent)
    </#if>
    <#if guidbase.has_child_widget(widget, "status")>
<@status_pill text=format_slot(widget,"status") indent=indent+4 />
    </#if>
${""?left_pad(indent)}  }
<@card_close indent=indent />
</#macro>

<#--
行式日志 (Horizontal Log)
+-----------------------------------------------+
| [avatar] | [start time] | [primary] | [status] |
+-----------------------------------------------+
-->
<#macro print_tile_horizontal_log widget indent=0>
<@card_open indent=indent />
${""?left_pad(indent)}  Row(Modifier.fillMaxWidth().padding(Spacings.s3), verticalAlignment = Alignment.CenterVertically) {
    <#if guidbase.has_child_widget(widget, "avatar")>
<@avatar_circle uri=slot_var(widget,"avatar") size="28.dp" indent=indent+4 />
${""?left_pad(indent)}    Text(" | ", fontSize = Types.TextSm, color = Colors.TextTertiary)
    </#if>
    <#if guidbase.has_child_widget(widget, "start_time")>
${""?left_pad(indent)}    Text(${format_slot(widget,"start_time")}, fontSize = Types.TextXs, color = Colors.TextSecondary)
${""?left_pad(indent)}    Text(" | ", fontSize = Types.TextSm, color = Colors.TextTertiary)
    </#if>
    <#if guidbase.has_child_widget(widget, "primary")>
${""?left_pad(indent)}    Text(${format_slot(widget,"primary")}, fontWeight = FontWeight.Bold, fontSize = Types.TextSm, color = Colors.TextMain, modifier = Modifier.weight(1f))
${""?left_pad(indent)}    Text(" | ", fontSize = Types.TextSm, color = Colors.TextTertiary)
    </#if>
    <#if guidbase.has_child_widget(widget, "status")>
<@status_pill text=format_slot(widget,"status") indent=indent+4 />
    </#if>
${""?left_pad(indent)}  }
<@card_close indent=indent />
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
<@card_open indent=indent />
  <#if guidbase.has_child_widget(widget, "tags")>
<@tag_chips tags=slot_var(widget,"tags") modifier=".padding(start = Spacings.s3, end = Spacings.s3, top = Spacings.s3)" indent=indent+4 />
  </#if>
  <#if guidbase.has_child_widget(widget, "primary")>
${""?left_pad(indent)}  Text(${format_slot(widget,"primary")}, fontWeight = FontWeight.Bold, fontSize = Types.TextMd, color = Colors.TextMain, modifier = Modifier.padding(horizontal = Spacings.s3))
  </#if>
  <#if guidbase.has_child_widget(widget, "tertiary")>
${""?left_pad(indent)}  Text(${format_slot(widget,"tertiary")}, fontSize = Types.TextXs, color = Colors.TextTertiary, modifier = Modifier.padding(horizontal = Spacings.s3))
  </#if>
${""?left_pad(indent)}  Row(Modifier.fillMaxWidth().padding(Spacings.s3), verticalAlignment = Alignment.CenterVertically) {
    <#if guidbase.has_child_widget(widget, "avatars")>
<@avatar_strip avatars=slot_var(widget,"avatars") modifier=".weight(1f)" indent=indent+4 />
    </#if>
    <#if guidbase.has_child_widget(widget, "start_time")>
${""?left_pad(indent)}    Text(${format_slot(widget,"start_time")}, fontSize = Types.TextXs, color = Colors.TextSecondary)
    </#if>
${""?left_pad(indent)}  }
<@card_close indent=indent />
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
<@card_open indent=indent />
  <#if guidbase.has_child_widget(widget, "background")>
${""?left_pad(indent)}  Box(Modifier.fillMaxWidth().height(120.dp)) {
<@image_placeholder uri=slot_var(widget,"background") modifier=".fillMaxSize()" indent=indent+4 />
${""?left_pad(indent)}  }
  </#if>
${""?left_pad(indent)}  Box(Modifier.fillMaxSize(), contentAlignment = Alignment.Center) {
${""?left_pad(indent)}    Column(Modifier.fillMaxWidth().padding(Spacings.s3)) {
    <#if guidbase.has_child_widget(widget, "start_time")>
${""?left_pad(indent)}      Row(Modifier.fillMaxWidth(), horizontalArrangement = Arrangement.End) {
${""?left_pad(indent)}        Text(${format_slot(widget,"start_time")}, fontSize = Types.TextXs, color = Colors.TextSecondary)
${""?left_pad(indent)}      }
    </#if>
    <#if guidbase.has_child_widget(widget, "primary")>
${""?left_pad(indent)}      Text(${format_slot(widget,"primary")}, fontWeight = FontWeight.Bold, fontSize = Types.TextMd, color = Colors.TextMain)
    </#if>
    <#if guidbase.has_child_widget(widget, "status")>
<@status_pill text=format_slot(widget,"status") indent=indent+4 />
    </#if>
${""?left_pad(indent)}    }
${""?left_pad(indent)}  }
<@card_close indent=indent />
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
<@card_open indent=indent />
${""?left_pad(indent)}  Row(Modifier.fillMaxWidth().padding(Spacings.s3)) {
    <#if guidbase.has_child_widget(widget, "avatar")>
<@avatar_circle uri=slot_var(widget,"avatar") size="36.dp" indent=indent+4 />
${""?left_pad(indent)}    Spacer(Modifier.width(Spacings.s3))
    </#if>
${""?left_pad(indent)}    Column(Modifier.weight(1f)) {
${""?left_pad(indent)}      Row(Modifier.fillMaxWidth(), verticalAlignment = Alignment.CenterVertically) {
    <#if guidbase.has_child_widget(widget, "primary")>
${""?left_pad(indent)}        Text(${format_slot(widget,"primary")}, fontWeight = FontWeight.Bold, fontSize = Types.TextSm, color = Colors.TextMain, modifier = Modifier.weight(1f))
    </#if>
    <#if guidbase.has_child_widget(widget, "start_time")>
${""?left_pad(indent)}        Text(${format_slot(widget,"start_time")}, fontSize = Types.TextXs, color = Colors.TextSecondary)
    </#if>
${""?left_pad(indent)}      }
    <#if guidbase.has_child_widget(widget, "secondary")>
${""?left_pad(indent)}      Text(${format_slot(widget,"secondary")}, fontSize = Types.TextSm, color = Colors.TextSecondary)
    </#if>
${""?left_pad(indent)}    }
${""?left_pad(indent)}  }
<@card_close indent=indent />
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
<@card_open indent=indent />
  <#if guidbase.has_child_widget(widget, "start_time")>
${""?left_pad(indent)}  Text(${format_slot(widget,"start_time")}, fontSize = Types.TextXs, color = Colors.TextSecondary, modifier = Modifier.padding(start = Spacings.s3, top = Spacings.s3))
  </#if>
${""?left_pad(indent)}  Row(Modifier.fillMaxWidth().padding(Spacings.s3)) {
${""?left_pad(indent)}    Column(Modifier.weight(1f)) {
    <#if guidbase.has_child_widget(widget, "primary")>
${""?left_pad(indent)}      Text(${format_slot(widget,"primary")}, fontWeight = FontWeight.Bold, fontSize = Types.TextMd, color = Colors.TextMain)
    </#if>
    <#if guidbase.has_child_widget(widget, "secondary")>
${""?left_pad(indent)}      Text(${format_slot(widget,"secondary")}, fontSize = Types.TextSm, color = Colors.TextSecondary)
    </#if>
${""?left_pad(indent)}    }
    <#if guidbase.has_child_widget(widget, "image")>
<@image_placeholder uri=slot_var(widget,"image") modifier=".size(80.dp).clip(RoundedCornerShape(8.dp))" indent=indent+4 />
    </#if>
${""?left_pad(indent)}  }
  <#if guidbase.has_child_widget(widget, "status")>
${""?left_pad(indent)}  Row(Modifier.fillMaxWidth().padding(horizontal = Spacings.s3, vertical = Spacings.s2), horizontalArrangement = Arrangement.End) {
<@status_pill text=format_slot(widget,"status") indent=indent+4 />
${""?left_pad(indent)}  }
  </#if>
<@card_close indent=indent />
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
<@card_open indent=indent />
${""?left_pad(indent)}  Row(Modifier.fillMaxWidth().padding(Spacings.s3), verticalAlignment = Alignment.CenterVertically) {
    <#if guidbase.has_child_widget(widget, "tags")>
<@tag_chips tags=slot_var(widget,"tags") modifier=".weight(1f)" indent=indent+4 />
    </#if>
    <#if guidbase.has_child_widget(widget, "end_time")>
${""?left_pad(indent)}    Text(${format_slot(widget,"end_time")}, fontSize = Types.TextXs, color = Colors.TextSecondary)
    </#if>
${""?left_pad(indent)}  }
  <#if guidbase.has_child_widget(widget, "primary")>
${""?left_pad(indent)}  Text(${format_slot(widget,"primary")}, fontWeight = FontWeight.Bold, fontSize = Types.TextMd, color = Colors.TextMain, modifier = Modifier.padding(horizontal = Spacings.s3))
  </#if>
${""?left_pad(indent)}  Row(Modifier.fillMaxWidth().padding(Spacings.s3), verticalAlignment = Alignment.CenterVertically) {
    <#if guidbase.has_child_widget(widget, "avatars")>
<@avatar_strip avatars=slot_var(widget,"avatars") modifier=".weight(1f)" indent=indent+4 />
    </#if>
    <#if guidbase.has_child_widget(widget, "status")>
<@status_pill text=format_slot(widget,"status") indent=indent+4 />
    </#if>
${""?left_pad(indent)}  }
<@card_close indent=indent />
</#macro>
