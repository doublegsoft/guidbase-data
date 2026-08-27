<#import "/$/guidbase.ftl" as guidbase>

<#--
 ###############################################################################
 ### 瓦片猜测器 - 根据 widget.children 的 slot 集合特征匹配最佳瓦片样式
 ###############################################################################
-->
<#function guess_tile widget vertical=false>
  <#-- 1. 收集当前 widget 中实际拥有的 Slot 列表 -->
  <#local active_slots = []>
  <#if guidbase.has_child_widget(widget, "primary")><#local active_slots = active_slots + ["primary"]></#if>
  <#if guidbase.has_child_widget(widget, "secondary")><#local active_slots = active_slots + ["secondary"]></#if>
  <#if guidbase.has_child_widget(widget, "tertiary")><#local active_slots = active_slots + ["tertiary"]></#if>
  <#if guidbase.has_child_widget(widget, "image")><#local active_slots = active_slots + ["image"]></#if>
  <#if guidbase.has_child_widget(widget, "avatar")><#local active_slots = active_slots + ["avatar"]></#if>
  <#if guidbase.has_child_widget(widget, "avatars")><#local active_slots = active_slots + ["avatars"]></#if>
  <#if guidbase.has_child_widget(widget, "tags")><#local active_slots = active_slots + ["tags"]></#if>
  <#if guidbase.has_child_widget(widget, "status")><#local active_slots = active_slots + ["status"]></#if>
  <#if guidbase.has_child_widget(widget, "start_time")><#local active_slots = active_slots + ["start_time"]></#if>
  <#if guidbase.has_child_widget(widget, "end_time")><#local active_slots = active_slots + ["end_time"]></#if>
  <#if guidbase.has_child_widget(widget, "background")><#local active_slots = active_slots + ["background"]></#if>
  <#if guidbase.has_child_widget(widget, "icon")><#local active_slots = active_slots + ["icon"]></#if>

  <#local best_name = "meeting_event">
  <#local best_score = -999>

  <#-- 2. 236 种瓦片的标准 Slot 匹配特征表 -->
  <#local tile_definitions = [
    {"name": "meeting_event", "slots": ["start_time", "end_time", "status", "primary", "secondary", "avatars"]},
    {"name": "media_article", "slots": ["image", "tags", "primary", "secondary", "tertiary"]},
    {"name": "user_profile", "slots": ["avatar", "primary", "secondary", "status"]},
    {"name": "task_board", "slots": ["tags", "status", "primary", "avatars", "end_time"]},
    {"name": "promo_banner", "slots": ["background", "tags", "primary", "secondary", "tertiary"]},
    {"name": "compact_list", "slots": ["status", "primary", "secondary", "start_time"]},
    {"name": "split_content", "slots": ["image", "tags", "primary", "avatars", "start_time"]},
    {"name": "notification", "slots": ["status", "primary", "tertiary"]},
    {"name": "hero_profile", "slots": ["background", "avatar", "primary", "secondary"]},
    {"name": "timeline_node", "slots": ["start_time", "end_time", "primary", "secondary", "tertiary", "tags"]},
    {"name": "message", "slots": ["avatar", "primary", "secondary", "tertiary", "start_time"]},
    {"name": "ticket", "slots": ["background", "primary", "status", "start_time", "end_time"]},
    {"name": "dense_detail_list", "slots": ["image", "primary", "secondary", "tertiary", "tags", "status"]},
    {"name": "vertical_poster", "slots": ["image", "primary", "secondary", "start_time", "end_time", "avatars"]},
    {"name": "issue_detail", "slots": ["tags", "status", "primary", "secondary", "tertiary", "avatar", "end_time"]},
    {"name": "team_directory", "slots": ["primary", "secondary", "avatars", "tags"]},
    {"name": "immersive_highlight", "slots": ["background", "status", "primary"]},
    {"name": "mini_status", "slots": ["status", "end_time", "primary", "tags"]},
    {"name": "dual_column_content", "slots": ["primary", "secondary", "tertiary", "tags", "avatar", "avatars"]},
    {"name": "gallery", "slots": ["image", "primary", "avatars", "status"]},
    {"name": "key_metric", "slots": ["tags", "primary", "secondary", "status"]},
    {"name": "overlay_avatar", "slots": ["image", "avatar", "primary", "secondary"]},
    {"name": "audit_log", "slots": ["avatar", "primary", "secondary", "start_time", "status"]},
    {"name": "calendar_cell", "slots": ["start_time", "status", "primary", "avatars"]},
    {"name": "side_status", "slots": ["status", "primary", "secondary", "start_time"]},
    {"name": "multi_tag", "slots": ["tags", "primary", "secondary", "end_time"]},
    {"name": "shift_planner", "slots": ["start_time", "end_time", "status", "primary", "avatars"]},
    {"name": "social_post_feed", "slots": ["avatar", "primary", "start_time", "tertiary", "image", "avatars", "tags"]},
    {"name": "product", "slots": ["image", "tags", "primary", "secondary", "status", "end_time"]},
    {"name": "dual_profile_comparison", "slots": ["avatar", "status", "primary", "secondary", "start_time", "end_time"]},
    {"name": "left_feature_image", "slots": ["image", "tags", "primary", "secondary", "tertiary", "status", "avatars"]},
    {"name": "workflow_strip", "slots": ["start_time", "avatars", "status", "end_time", "primary"]},
    {"name": "text_over_background", "slots": ["background", "tags", "primary", "avatar", "secondary"]},
    {"name": "micro_badge", "slots": ["avatar", "primary", "status"]},
    {"name": "stepped_process", "slots": ["status", "primary", "secondary", "start_time", "end_time"]},
    {"name": "stacked_overlay", "slots": ["image", "primary", "secondary", "status"]},
    {"name": "group_hub", "slots": ["avatars", "primary", "tertiary", "tags", "status"]},
    {"name": "tall_sidebar", "slots": ["status", "image", "primary", "secondary", "tags", "avatars"]},
    {"name": "justified_meta", "slots": ["primary", "secondary", "start_time", "end_time", "avatar", "status"]},
    {"name": "multidimensional_board", "slots": ["status", "start_time", "primary", "tertiary", "secondary", "tags", "avatars"]},
    {"name": "media_player", "slots": ["image", "primary", "secondary", "start_time", "end_time", "avatar", "status"]},
    {"name": "left_anchor_time", "slots": ["start_time", "status", "primary", "secondary", "avatar"]},
    {"name": "duration_span", "slots": ["start_time", "end_time", "status", "primary", "avatars"]},
    {"name": "media_history", "slots": ["start_time", "image", "primary", "secondary", "tags"]},
    {"name": "status_transition", "slots": ["start_time", "status", "primary", "avatar", "secondary"]},
    {"name": "compact_time", "slots": ["start_time", "status", "primary", "tags"]},
    {"name": "horizontal_flow", "slots": ["start_time", "primary", "status"]},
    {"name": "right_biased_node", "slots": ["start_time", "primary", "tags"]},
    {"name": "left_biased_node", "slots": ["start_time", "primary", "tags"]},
    {"name": "internal_chronology", "slots": ["start_time", "primary", "end_time", "secondary", "status"]},
    {"name": "three_stage_segment", "slots": ["start_time", "tags", "end_time", "primary", "secondary", "status"]},
    {"name": "horizontal_log", "slots": ["avatar", "start_time", "primary", "status"]},
    {"name": "bulletin", "slots": ["tags", "primary", "tertiary", "avatars", "start_time"]},
    {"name": "timestamp_stamp", "slots": ["background", "start_time", "primary", "status"]},
    {"name": "compact_chat", "slots": ["avatar", "primary", "secondary", "start_time"]},
    {"name": "side_image_time_capsule", "slots": ["start_time", "primary", "secondary", "image", "status"]},
    {"name": "multi_tag_end_node", "slots": ["tags", "end_time", "primary", "avatars", "status"]},
    {"name": "kpi_dashboard", "slots": ["primary", "secondary", "status", "tags", "start_time"]},
    {"name": "stat_comparison", "slots": ["primary", "secondary", "tertiary", "status", "avatars"]},
    {"name": "progress_meter", "slots": ["primary", "status", "start_time", "end_time", "tags"]},
    {"name": "ranking_row", "slots": ["avatars", "primary", "secondary", "status"]},
    {"name": "leaderboard", "slots": ["tags", "primary", "secondary", "tertiary", "avatars"]},
    {"name": "price_plan", "slots": ["image", "primary", "secondary", "status", "tags"]},
    {"name": "checkout_summary", "slots": ["image", "primary", "secondary", "status", "end_time"]},
    {"name": "order_tracking", "slots": ["status", "start_time", "end_time", "primary", "secondary"]},
    {"name": "shipping_event", "slots": ["status", "primary", "secondary", "start_time", "avatar"]},
    {"name": "invoice_summary", "slots": ["primary", "secondary", "tertiary", "status", "end_time"]},
    {"name": "payment_method", "slots": ["avatar", "primary", "secondary", "status"]},
    {"name": "account_balance", "slots": ["background", "primary", "secondary", "status"]},
    {"name": "wallet_card", "slots": ["background", "primary", "status", "end_time"]},
    {"name": "coupon_card", "slots": ["background", "tags", "primary", "end_time"]},
    {"name": "deal_card", "slots": ["image", "tags", "primary", "secondary", "status"]},
    {"name": "property_listing", "slots": ["image", "tags", "primary", "secondary", "tertiary", "status"]},
    {"name": "travel_destination", "slots": ["image", "primary", "secondary", "tags", "avatars"]},
    {"name": "flight_segment", "slots": ["start_time", "end_time", "primary", "secondary", "status"]},
    {"name": "hotel_booking", "slots": ["image", "primary", "secondary", "start_time", "end_time", "status"]},
    {"name": "restaurant_reservation", "slots": ["image", "primary", "secondary", "start_time", "status"]},
    {"name": "event_ticket", "slots": ["background", "primary", "secondary", "start_time", "end_time", "status"]},
    {"name": "speaker_profile", "slots": ["background", "avatar", "primary", "secondary", "tags"]},
    {"name": "course_card", "slots": ["image", "primary", "secondary", "status", "avatars"]},
    {"name": "lesson_progress", "slots": ["primary", "secondary", "status", "start_time", "tags"]},
    {"name": "quiz_result", "slots": ["primary", "secondary", "tertiary", "status"]},
    {"name": "certificate_card", "slots": ["background", "avatar", "primary", "end_time"]},
    {"name": "article_quote", "slots": ["image", "primary", "secondary", "avatar"]},
    {"name": "comment_thread", "slots": ["avatar", "primary", "secondary", "start_time", "status"]},
    {"name": "reply_item", "slots": ["avatar", "primary", "secondary", "tertiary", "start_time"]},
    {"name": "reaction_summary", "slots": ["avatars", "primary", "tags", "status"]},
    {"name": "notification_group", "slots": ["avatar", "primary", "tertiary", "status", "start_time"]},
    {"name": "inbox_thread", "slots": ["avatar", "primary", "secondary", "status", "end_time"]},
    {"name": "email_preview", "slots": ["avatar", "primary", "secondary", "tertiary", "tags"]},
    {"name": "calendar_agenda", "slots": ["start_time", "end_time", "primary", "secondary", "status", "avatars"]},
    {"name": "calendar_month_event", "slots": ["start_time", "primary", "status", "tags"]},
    {"name": "date_range_picker", "slots": ["start_time", "end_time", "primary", "status"]},
    {"name": "milestone_card", "slots": ["status", "primary", "secondary", "start_time", "avatars"]},
    {"name": "roadmap_item", "slots": ["status", "primary", "secondary", "tertiary", "end_time"]},
    {"name": "sprint_summary", "slots": ["primary", "secondary", "status", "avatars", "tags"]},
    {"name": "kanban_card", "slots": ["tags", "primary", "secondary", "avatars", "end_time"]},
    {"name": "kanban_swimlane", "slots": ["primary", "status", "avatars", "tags"]},
    {"name": "project_health", "slots": ["background", "status", "primary", "secondary", "tags"]},
    {"name": "team_presence", "slots": ["avatars", "primary", "secondary", "status", "start_time"]},
    {"name": "org_chart_node", "slots": ["avatar", "primary", "secondary", "tertiary"]},
    {"name": "contact_card", "slots": ["avatar", "primary", "secondary", "status", "tags"]},
    {"name": "user_activity", "slots": ["avatar", "primary", "start_time", "tertiary", "status"]},
    {"name": "access_log", "slots": ["avatar", "primary", "secondary", "start_time", "end_time", "status"]},
    {"name": "security_alert", "slots": ["background", "status", "primary", "secondary"]},
    {"name": "system_health", "slots": ["background", "primary", "status", "start_time"]},
    {"name": "service_status", "slots": ["status", "primary", "secondary", "tertiary"]},
    {"name": "api_endpoint", "slots": ["primary", "secondary", "status", "end_time", "tags"]},
    {"name": "release_note", "slots": ["image", "tags", "primary", "secondary", "start_time"]},
    {"name": "version_badge", "slots": ["status", "primary", "secondary", "start_time"]},
    {"name": "deployment_event", "slots": ["status", "primary", "secondary", "start_time", "end_time", "avatars"]},
    {"name": "commit_item", "slots": ["avatar", "primary", "secondary", "start_time", "tags"]},
    {"name": "build_result", "slots": ["status", "primary", "secondary", "end_time"]},
    {"name": "file_preview", "slots": ["image", "primary", "secondary", "status"]},
    {"name": "folder_summary", "slots": ["image", "primary", "secondary", "avatars", "status"]},
    {"name": "media_collection", "slots": ["image", "primary", "avatars", "tags", "status"]},
    {"name": "playlist_item", "slots": ["image", "primary", "secondary", "end_time"]},
    {"name": "podcast_episode", "slots": ["image", "primary", "secondary", "start_time", "status"]},
    {"name": "gallery_mosaic", "slots": ["image", "tags", "primary", "avatars"]},
    {"name": "message_compose", "slots": ["avatar", "primary", "secondary", "tags", "status"]},
    {"name": "chat_room_header", "slots": ["background", "avatar", "primary", "secondary", "status"]},
    {"name": "chat_attachment", "slots": ["image", "primary", "secondary", "status"]},
    {"name": "voice_message", "slots": ["avatar", "primary", "start_time", "end_time", "status"]},
    {"name": "call_history", "slots": ["avatar", "primary", "secondary", "start_time", "end_time"]},
    {"name": "video_call", "slots": ["background", "avatars", "primary", "status", "start_time"]},
    {"name": "contact_merge", "slots": ["avatar", "primary", "secondary", "tertiary", "status"]},
    {"name": "address_book_group", "slots": ["avatars", "primary", "secondary", "tags"]},
    {"name": "favorite_item", "slots": ["image", "primary", "secondary", "tags"]},
    {"name": "saved_search", "slots": ["primary", "secondary", "status", "tags"]},
    {"name": "filter_summary", "slots": ["tags", "primary", "secondary", "status"]},
    {"name": "sort_option", "slots": ["primary", "secondary", "status"]},
    {"name": "search_result", "slots": ["image", "primary", "secondary", "tertiary", "tags"]},
    {"name": "search_suggestion", "slots": ["primary", "secondary", "tags"]},
    {"name": "empty_state_panel", "slots": ["background", "primary", "secondary", "status"]},
    {"name": "error_state_panel", "slots": ["background", "primary", "secondary", "status", "tags"]},
    {"name": "maintenance_notice", "slots": ["background", "status", "primary", "start_time", "end_time"]},
    {"name": "feature_flag", "slots": ["status", "primary", "secondary", "start_time"]},
    {"name": "experiment_variant", "slots": ["tags", "primary", "secondary", "status", "avatars"]},
    {"name": "ab_test_result", "slots": ["primary", "secondary", "tertiary", "status", "start_time"]},
    {"name": "analytics_event", "slots": ["start_time", "primary", "secondary", "status", "tags"]},
    {"name": "funnel_step", "slots": ["primary", "secondary", "status", "avatars", "end_time"]},
    {"name": "conversion_metric", "slots": ["background", "primary", "secondary", "status"]},
    {"name": "chart_summary", "slots": ["image", "primary", "secondary", "tertiary", "status"]},
    {"name": "report_header", "slots": ["background", "primary", "secondary", "start_time", "end_time"]},
    {"name": "report_row", "slots": ["primary", "secondary", "tertiary", "status", "tags"]},
    {"name": "data_source", "slots": ["avatar", "primary", "secondary", "status", "end_time"]},
    {"name": "dataset_card", "slots": ["image", "primary", "secondary", "tags", "status"]},
    {"name": "query_history", "slots": ["start_time", "primary", "secondary", "status"]},
    {"name": "export_job", "slots": ["status", "primary", "secondary", "start_time", "end_time"]},
    {"name": "import_job", "slots": ["status", "primary", "secondary", "start_time", "end_time", "avatars"]},
    {"name": "sync_status", "slots": ["status", "primary", "secondary", "start_time"]},
    {"name": "backup_snapshot", "slots": ["background", "primary", "secondary", "status", "end_time"]},
    {"name": "restore_point", "slots": ["background", "primary", "status", "start_time", "end_time"]},
    {"name": "storage_usage", "slots": ["primary", "secondary", "status", "tags", "avatars"]},
    {"name": "quota_meter", "slots": ["primary", "status", "secondary", "end_time"]},
    {"name": "license_summary", "slots": ["background", "primary", "secondary", "status", "end_time"]},
    {"name": "subscription_plan", "slots": ["image", "primary", "secondary", "status", "tags"]},
    {"name": "billing_cycle", "slots": ["start_time", "end_time", "primary", "secondary", "status"]},
    {"name": "tax_invoice", "slots": ["image", "primary", "secondary", "tertiary", "status"]},
    {"name": "refund_case", "slots": ["status", "primary", "secondary", "start_time", "end_time"]},
    {"name": "support_ticket", "slots": ["avatar", "primary", "secondary", "status", "start_time"]},
    {"name": "support_agent", "slots": ["avatar", "primary", "secondary", "status", "tags"]},
    {"name": "faq_item", "slots": ["primary", "secondary", "tags"]},
    {"name": "knowledge_article", "slots": ["image", "primary", "secondary", "tertiary", "tags"]},
    {"name": "documentation_section", "slots": ["primary", "secondary", "tertiary", "status"]},
    {"name": "release_channel", "slots": ["status", "primary", "secondary", "avatars"]},
    {"name": "roadmap_milestone", "slots": ["background", "primary", "secondary", "status", "start_time"]},
    {"name": "feedback_card", "slots": ["avatar", "primary", "secondary", "tags", "start_time"]},
    {"name": "survey_question", "slots": ["primary", "secondary", "status", "tags"]},
    {"name": "survey_response", "slots": ["avatar", "primary", "secondary", "tertiary", "status"]},
    {"name": "rating_summary", "slots": ["avatars", "primary", "secondary", "status"]},
    {"name": "review_card", "slots": ["avatar", "primary", "secondary", "image", "start_time"]},
    {"name": "moderation_case", "slots": ["status", "primary", "secondary", "avatar", "end_time"]},
    {"name": "content_flag", "slots": ["status", "primary", "tertiary", "start_time"]},
    {"name": "approval_request", "slots": ["avatar", "primary", "secondary", "status", "end_time"]},
    {"name": "approval_step", "slots": ["status", "primary", "secondary", "start_time", "avatars"]},
    {"name": "signature_request", "slots": ["background", "primary", "secondary", "status", "end_time"]},
    {"name": "document_version", "slots": ["image", "primary", "secondary", "start_time", "status"]},
    {"name": "document_collaborator", "slots": ["avatars", "primary", "secondary", "status", "tags"]},
    {"name": "folder_item", "slots": ["image", "primary", "secondary", "end_time"]},
    {"name": "permission_rule", "slots": ["avatar", "primary", "secondary", "tertiary", "status"]},
    {"name": "role_assignment", "slots": ["avatar", "primary", "secondary", "tags", "status"]},
    {"name": "audit_event_detail", "slots": ["background", "avatar", "primary", "secondary", "start_time", "status"]},
    {"name": "incident_summary", "slots": ["background", "status", "primary", "secondary", "start_time", "end_time"]},
    {"name": "incident_timeline", "slots": ["start_time", "primary", "secondary", "status", "avatars"]},
    {"name": "on_call_shift", "slots": ["start_time", "end_time", "avatar", "primary", "status"]},
    {"name": "escalation_rule", "slots": ["status", "primary", "secondary", "tags"]},
    {"name": "runbook_step", "slots": ["status", "primary", "secondary", "start_time", "end_time"]},
    {"name": "monitor_check", "slots": ["status", "primary", "secondary", "start_time"]},
    {"name": "alert_group", "slots": ["background", "status", "primary", "avatars", "tags"]},
    {"name": "log_entry", "slots": ["start_time", "primary", "secondary", "status", "tags"]},
    {"name": "trace_span", "slots": ["start_time", "end_time", "primary", "secondary", "status"]},
    {"name": "request_detail", "slots": ["status", "primary", "secondary", "tertiary", "start_time"]},
    {"name": "server_card", "slots": ["image", "primary", "secondary", "status", "tags"]},
    {"name": "container_card", "slots": ["image", "primary", "secondary", "status", "avatars"]},
    {"name": "cloud_region", "slots": ["background", "primary", "secondary", "status", "tags"]},
    {"name": "integration_card", "slots": ["image", "primary", "secondary", "status", "start_time"]},
    {"name": "webhook_event", "slots": ["status", "primary", "secondary", "start_time", "end_time"]},
    {"name": "automation_rule", "slots": ["status", "primary", "secondary", "tags", "avatars"]},
    {"name": "workflow_run", "slots": ["start_time", "end_time", "primary", "status", "avatars"]},
    {"name": "queue_item", "slots": ["status", "primary", "secondary", "start_time"]},
    {"name": "job_detail", "slots": ["status", "primary", "secondary", "tertiary", "end_time"]},
    {"name": "schedule_rule", "slots": ["start_time", "end_time", "primary", "secondary", "status"]},
    {"name": "recurring_task", "slots": ["start_time", "primary", "secondary", "tags", "avatars"]},
    {"name": "approval_inbox", "slots": ["avatar", "primary", "secondary", "status", "end_time"]},
    {"name": "draft_item", "slots": ["image", "primary", "secondary", "status"]},
    {"name": "publish_item", "slots": ["image", "primary", "secondary", "start_time", "status"]},
    {"name": "campaign_card", "slots": ["background", "primary", "secondary", "tags", "status"]},
    {"name": "audience_segment", "slots": ["avatars", "primary", "secondary", "tags", "status"]},
    {"name": "channel_summary", "slots": ["image", "primary", "secondary", "tertiary", "status"]},
    {"name": "social_account", "slots": ["avatar", "primary", "secondary", "status", "tags"]},
    {"name": "post_scheduler", "slots": ["image", "primary", "start_time", "end_time", "status"]},
    {"name": "content_calendar", "slots": ["start_time", "primary", "secondary", "status", "tags"]},
    {"name": "brand_asset", "slots": ["image", "primary", "secondary", "tags"]},
    {"name": "theme_preview", "slots": ["background", "primary", "secondary", "status"]},
    {"name": "component_variant", "slots": ["image", "primary", "secondary", "tertiary", "tags"]},
    {"name": "design_token", "slots": ["primary", "secondary", "status", "tags"]},
    {"name": "ui_pattern", "slots": ["image", "primary", "secondary", "status"]},
    {"name": "prototype_screen", "slots": ["image", "primary", "secondary", "avatars"]},
    {"name": "handoff_item", "slots": ["avatar", "primary", "secondary", "status", "start_time"]},
    {"name": "accessibility_check", "slots": ["status", "primary", "secondary", "tags"]},
    {"name": "translation_item", "slots": ["primary", "secondary", "tertiary", "status", "tags"]},
    {"name": "localization_status", "slots": ["status", "primary", "secondary", "start_time"]},
    {"name": "language_pack", "slots": ["image", "primary", "secondary", "status", "avatars"]},
    {"name": "release_calendar", "slots": ["start_time", "end_time", "primary", "status", "tags"]},
    {"name": "change_request", "slots": ["avatar", "primary", "secondary", "status", "end_time"]},
    {"name": "risk_register", "slots": ["status", "primary", "secondary", "tertiary", "tags"]},
    {"name": "dependency_item", "slots": ["primary", "secondary", "status", "avatars"]},
    {"name": "decision_log", "slots": ["avatar", "primary", "secondary", "start_time", "tags"]},
    {"name": "meeting_notes", "slots": ["avatar", "primary", "secondary", "tertiary", "start_time"]},
    {"name": "action_item", "slots": ["status", "primary", "secondary", "end_time", "avatars"]},
    {"name": "okr_objective", "slots": ["background", "primary", "secondary", "status", "tags"]},
    {"name": "key_result", "slots": ["primary", "secondary", "status", "start_time", "end_time"]},
    {"name": "goal_progress", "slots": ["primary", "status", "secondary", "avatars"]},
    {"name": "personal_dashboard", "slots": ["background", "primary", "secondary", "tertiary", "status"]},
    {"name": "quick_action", "slots": ["icon", "primary", "secondary", "status"]}
  ]>

  <#-- 3. 相似度评分算法打分并取最高者 -->
  <#list tile_definitions as td>
    <#local score = 0>
    <#list td.slots as s>
      <#if active_slots?seq_contains(s)>
        <#local score = score + 2>
      </#if>
    </#list>
    <#list active_slots as slot>
      <#if !td.slots?seq_contains(slot)>
        <#local score = score - 1>
      </#if>
    </#list>
    
    <#-- 针对垂直排版倾向性做打分加权修正 -->
    <#if vertical>
      <#local vertical_oriented_tiles = [
        "vertical_poster", "tall_sidebar", "course_card", "product", 
        "property_listing", "deal_card", "gallery", "gallery_mosaic", 
        "hero_profile", "user_profile"
      ]>
      <#if vertical_oriented_tiles?seq_contains(td.name)>
        <#local score = score + 3>
      </#if>
    </#if>

    <#if score gt best_score>
      <#local best_score = score>
      <#local best_name = td.name>
    </#if>
  </#list>

  <#return best_name>
</#function>

<#--
 ###############################################################################
 ### 渲染布局瓦片组件 (Render Layout Tile Widget)
 ###############################################################################
 -->
<#macro print_tile_layout widget varname="row" vertical=false indent=0>
  <#local tilename = widget.value("tile", guess_tile(widget, vertical))>
  <#if tilename == "meeting_event">
<@tile.print_tile_meeting_event widget=widget varname=varname indent=indent />
  <#elseif tilename == "media_article">
<@tile.print_tile_media_article widget=widget varname=varname indent=indent />
  <#elseif tilename == "user_profile">
<@tile.print_tile_user_profile widget=widget varname=varname indent=indent />
  <#elseif tilename == "task_board">
<@tile.print_tile_task_board widget=widget varname=varname indent=indent />
  <#elseif tilename == "promo_banner">
<@tile.print_tile_promo_banner widget=widget varname=varname indent=indent />
  <#elseif tilename == "compact_list">
<@tile.print_tile_compact_list widget=widget varname=varname indent=indent />
  <#elseif tilename == "split_content">
<@tile.print_tile_split_content widget=widget varname=varname indent=indent />
  <#elseif tilename == "notification">
<@tile.print_tile_notification widget=widget varname=varname indent=indent />
  <#elseif tilename == "hero_profile">
<@tile.print_tile_hero_profile widget=widget varname=varname indent=indent />
  <#elseif tilename == "timeline_node">
<@tile.print_tile_timeline_node widget=widget varname=varname indent=indent />
  <#elseif tilename == "message">
<@tile.print_tile_message widget=widget varname=varname indent=indent />
  <#elseif tilename == "ticket">
<@tile.print_tile_ticket widget=widget varname=varname indent=indent />
  <#elseif tilename == "dense_detail_list">
<@tile.print_tile_dense_detail_list widget=widget varname=varname indent=indent />
  <#elseif tilename == "vertical_poster">
<@tile.print_tile_vertical_poster widget=widget varname=varname indent=indent />
  <#elseif tilename == "issue_detail">
<@tile.print_tile_issue_detail widget=widget varname=varname indent=indent />
  <#elseif tilename == "team_directory">
<@tile.print_tile_team_directory widget=widget varname=varname indent=indent />
  <#elseif tilename == "immersive_highlight">
<@tile.print_tile_immersive_highlight widget=widget varname=varname indent=indent />
  <#elseif tilename == "mini_status">
<@tile.print_tile_mini_status widget=widget varname=varname indent=indent />
  <#elseif tilename == "dual_column_content">
<@tile.print_tile_dual_column_content widget=widget varname=varname indent=indent />
  <#elseif tilename == "gallery">
<@tile.print_tile_gallery widget=widget varname=varname indent=indent />
  <#elseif tilename == "key_metric">
<@tile.print_tile_key_metric widget=widget varname=varname indent=indent />
  <#elseif tilename == "overlay_avatar">
<@tile.print_tile_overlay_avatar widget=widget varname=varname indent=indent />
  <#elseif tilename == "audit_log">
<@tile.print_tile_audit_log widget=widget varname=varname indent=indent />
  <#elseif tilename == "calendar_cell">
<@tile.print_tile_calendar_cell widget=widget varname=varname indent=indent />
  <#elseif tilename == "side_status">
<@tile.print_tile_side_status widget=widget varname=varname indent=indent />
  <#elseif tilename == "multi_tag">
<@tile.print_tile_multi_tag widget=widget varname=varname indent=indent />
  <#elseif tilename == "shift_planner">
<@tile.print_tile_shift_planner widget=widget varname=varname indent=indent />
  <#elseif tilename == "social_post_feed">
<@tile.print_tile_social_post_feed widget=widget varname=varname indent=indent />
  <#elseif tilename == "product">
<@tile.print_tile_product widget=widget varname=varname indent=indent />
  <#elseif tilename == "dual_profile_comparison">
<@tile.print_tile_dual_profile_comparison widget=widget varname=varname indent=indent />
  <#elseif tilename == "left_feature_image">
<@tile.print_tile_left_feature_image widget=widget varname=varname indent=indent />
  <#elseif tilename == "workflow_strip">
<@tile.print_tile_workflow_strip widget=widget varname=varname indent=indent />
  <#elseif tilename == "text_over_background">
<@tile.print_tile_text_over_background widget=widget varname=varname indent=indent />
  <#elseif tilename == "micro_badge">
<@tile.print_tile_micro_badge widget=widget varname=varname indent=indent />
  <#elseif tilename == "stepped_process">
<@tile.print_tile_stepped_process widget=widget varname=varname indent=indent />
  <#elseif tilename == "stacked_overlay">
<@tile.print_tile_stacked_overlay widget=widget varname=varname indent=indent />
  <#elseif tilename == "group_hub">
<@tile.print_tile_group_hub widget=widget varname=varname indent=indent />
  <#elseif tilename == "tall_sidebar">
<@tile.print_tile_tall_sidebar widget=widget varname=varname indent=indent />
  <#elseif tilename == "justified_meta">
<@tile.print_tile_justified_meta widget=widget varname=varname indent=indent />
  <#elseif tilename == "multidimensional_board">
<@tile.print_tile_multidimensional_board widget=widget varname=varname indent=indent />
  <#elseif tilename == "media_player">
<@tile.print_tile_media_player widget=widget varname=varname indent=indent />
  <#elseif tilename == "left_anchor_time">
<@tile.print_tile_left_anchor_time widget=widget varname=varname indent=indent />
  <#elseif tilename == "duration_span">
<@tile.print_tile_duration_span widget=widget varname=varname indent=indent />
  <#elseif tilename == "media_history">
<@tile.print_tile_media_history widget=widget varname=varname indent=indent />
  <#elseif tilename == "status_transition">
<@tile.print_tile_status_transition widget=widget varname=varname indent=indent />
  <#elseif tilename == "compact_time">
<@tile.print_tile_compact_time widget=widget varname=varname indent=indent />
  <#elseif tilename == "horizontal_flow">
<@tile.print_tile_horizontal_flow widget=widget varname=varname indent=indent />
  <#elseif tilename == "right_biased_node">
<@tile.print_tile_right_biased_node widget=widget varname=varname indent=indent />
  <#elseif tilename == "left_biased_node">
<@tile.print_tile_left_biased_node widget=widget varname=varname indent=indent />
  <#elseif tilename == "internal_chronology">
<@tile.print_tile_internal_chronology widget=widget varname=varname indent=indent />
  <#elseif tilename == "three_stage_segment">
<@tile.print_tile_three_stage_segment widget=widget varname=varname indent=indent />
  <#elseif tilename == "horizontal_log">
<@tile.print_tile_horizontal_log widget=widget varname=varname indent=indent />
  <#elseif tilename == "bulletin">
<@tile.print_tile_bulletin widget=widget varname=varname indent=indent />
  <#elseif tilename == "timestamp_stamp">
<@tile.print_tile_timestamp_stamp widget=widget varname=varname indent=indent />
  <#elseif tilename == "compact_chat">
<@tile.print_tile_compact_chat widget=widget varname=varname indent=indent />
  <#elseif tilename == "side_image_time_capsule">
<@tile.print_tile_side_image_time_capsule widget=widget varname=varname indent=indent />
  <#elseif tilename == "multi_tag_end_node">
<@tile.print_tile_multi_tag_end_node widget=widget varname=varname indent=indent />
  <#elseif tilename == "kpi_dashboard">
<@tile.print_tile_kpi_dashboard widget=widget varname=varname indent=indent />
  <#elseif tilename == "stat_comparison">
<@tile.print_tile_stat_comparison widget=widget varname=varname indent=indent />
  <#elseif tilename == "progress_meter">
<@tile.print_tile_progress_meter widget=widget varname=varname indent=indent />
  <#elseif tilename == "ranking_row">
<@tile.print_tile_ranking_row widget=widget varname=varname indent=indent />
  <#elseif tilename == "leaderboard">
<@tile.print_tile_leaderboard widget=widget varname=varname indent=indent />
  <#elseif tilename == "price_plan">
<@tile.print_tile_price_plan widget=widget varname=varname indent=indent />
  <#elseif tilename == "checkout_summary">
<@tile.print_tile_checkout_summary widget=widget varname=varname indent=indent />
  <#elseif tilename == "order_tracking">
<@tile.print_tile_order_tracking widget=widget varname=varname indent=indent />
  <#elseif tilename == "shipping_event">
<@tile.print_tile_shipping_event widget=widget varname=varname indent=indent />
  <#elseif tilename == "invoice_summary">
<@tile.print_tile_invoice_summary widget=widget varname=varname indent=indent />
  <#elseif tilename == "payment_method">
<@tile.print_tile_payment_method widget=widget varname=varname indent=indent />
  <#elseif tilename == "account_balance">
<@tile.print_tile_account_balance widget=widget varname=varname indent=indent />
  <#elseif tilename == "wallet_card">
<@tile.print_tile_wallet_card widget=widget varname=varname indent=indent />
  <#elseif tilename == "coupon_card">
<@tile.print_tile_coupon_card widget=widget varname=varname indent=indent />
  <#elseif tilename == "deal_card">
<@tile.print_tile_deal_card widget=widget varname=varname indent=indent />
  <#elseif tilename == "property_listing">
<@tile.print_tile_property_listing widget=widget varname=varname indent=indent />
  <#elseif tilename == "travel_destination">
<@tile.print_tile_travel_destination widget=widget varname=varname indent=indent />
  <#elseif tilename == "flight_segment">
<@tile.print_tile_flight_segment widget=widget varname=varname indent=indent />
  <#elseif tilename == "hotel_booking">
<@tile.print_tile_hotel_booking widget=widget varname=varname indent=indent />
  <#elseif tilename == "restaurant_reservation">
<@tile.print_tile_restaurant_reservation widget=widget varname=varname indent=indent />
  <#elseif tilename == "event_ticket">
<@tile.print_tile_event_ticket widget=widget varname=varname indent=indent />
  <#elseif tilename == "speaker_profile">
<@tile.print_tile_speaker_profile widget=widget varname=varname indent=indent />
  <#elseif tilename == "course_card">
<@tile.print_tile_course_card widget=widget varname=varname indent=indent />
  <#elseif tilename == "lesson_progress">
<@tile.print_tile_lesson_progress widget=widget varname=varname indent=indent />
  <#elseif tilename == "quiz_result">
<@tile.print_tile_quiz_result widget=widget varname=varname indent=indent />
  <#elseif tilename == "certificate_card">
<@tile.print_tile_certificate_card widget=widget varname=varname indent=indent />
  <#elseif tilename == "article_quote">
<@tile.print_tile_article_quote widget=widget varname=varname indent=indent />
  <#elseif tilename == "comment_thread">
<@tile.print_tile_comment_thread widget=widget varname=varname indent=indent />
  <#elseif tilename == "reply_item">
<@tile.print_tile_reply_item widget=widget varname=varname indent=indent />
  <#elseif tilename == "reaction_summary">
<@tile.print_tile_reaction_summary widget=widget varname=varname indent=indent />
  <#elseif tilename == "notification_group">
<@tile.print_tile_notification_group widget=widget varname=varname indent=indent />
  <#elseif tilename == "inbox_thread">
<@tile.print_tile_inbox_thread widget=widget varname=varname indent=indent />
  <#elseif tilename == "email_preview">
<@tile.print_tile_email_preview widget=widget varname=varname indent=indent />
  <#elseif tilename == "calendar_agenda">
<@tile.print_tile_calendar_agenda widget=widget varname=varname indent=indent />
  <#elseif tilename == "calendar_month_event">
<@tile.print_tile_calendar_month_event widget=widget varname=varname indent=indent />
  <#elseif tilename == "date_range_picker">
<@tile.print_tile_date_range_picker widget=widget varname=varname indent=indent />
  <#elseif tilename == "milestone_card">
<@tile.print_tile_milestone_card widget=widget varname=varname indent=indent />
  <#elseif tilename == "roadmap_item">
<@tile.print_tile_roadmap_item widget=widget varname=varname indent=indent />
  <#elseif tilename == "sprint_summary">
<@tile.print_tile_sprint_summary widget=widget varname=varname indent=indent />
  <#elseif tilename == "kanban_card">
<@tile.print_tile_kanban_card widget=widget varname=varname indent=indent />
  <#elseif tilename == "kanban_swimlane">
<@tile.print_tile_kanban_swimlane widget=widget varname=varname indent=indent />
  <#elseif tilename == "project_health">
<@tile.print_tile_project_health widget=widget varname=varname indent=indent />
  <#elseif tilename == "team_presence">
<@tile.print_tile_team_presence widget=widget varname=varname indent=indent />
  <#elseif tilename == "org_chart_node">
<@tile.print_tile_org_chart_node widget=widget varname=varname indent=indent />
  <#elseif tilename == "contact_card">
<@tile.print_tile_contact_card widget=widget varname=varname indent=indent />
  <#elseif tilename == "user_activity">
<@tile.print_tile_user_activity widget=widget varname=varname indent=indent />
  <#elseif tilename == "access_log">
<@tile.print_tile_access_log widget=widget varname=varname indent=indent />
  <#elseif tilename == "security_alert">
<@tile.print_tile_security_alert widget=widget varname=varname indent=indent />
  <#elseif tilename == "system_health">
<@tile.print_tile_system_health widget=widget varname=varname indent=indent />
  <#elseif tilename == "service_status">
<@tile.print_tile_service_status widget=widget varname=varname indent=indent />
  <#elseif tilename == "api_endpoint">
<@tile.print_tile_api_endpoint widget=widget varname=varname indent=indent />
  <#elseif tilename == "release_note">
<@tile.print_tile_release_note widget=widget varname=varname indent=indent />
  <#elseif tilename == "version_badge">
<@tile.print_tile_version_badge widget=widget varname=varname indent=indent />
  <#elseif tilename == "deployment_event">
<@tile.print_tile_deployment_event widget=widget varname=varname indent=indent />
  <#elseif tilename == "commit_item">
<@tile.print_tile_commit_item widget=widget varname=varname indent=indent />
  <#elseif tilename == "build_result">
<@tile.print_tile_build_result widget=widget varname=varname indent=indent />
  <#elseif tilename == "file_preview">
<@tile.print_tile_file_preview widget=widget varname=varname indent=indent />
  <#elseif tilename == "folder_summary">
<@tile.print_tile_folder_summary widget=widget varname=varname indent=indent />
  <#elseif tilename == "media_collection">
<@tile.print_tile_media_collection widget=widget varname=varname indent=indent />
  <#elseif tilename == "playlist_item">
<@tile.print_tile_playlist_item widget=widget varname=varname indent=indent />
  <#elseif tilename == "podcast_episode">
<@tile.print_tile_podcast_episode widget=widget varname=varname indent=indent />
  <#elseif tilename == "gallery_mosaic">
<@tile.print_tile_gallery_mosaic widget=widget varname=varname indent=indent />
  <#elseif tilename == "message_compose">
<@tile.print_tile_message_compose widget=widget varname=varname indent=indent />
  <#elseif tilename == "chat_room_header">
<@tile.print_tile_chat_room_header widget=widget varname=varname indent=indent />
  <#elseif tilename == "chat_attachment">
<@tile.print_tile_chat_attachment widget=widget varname=varname indent=indent />
  <#elseif tilename == "voice_message">
<@tile.print_tile_voice_message widget=widget varname=varname indent=indent />
  <#elseif tilename == "call_history">
<@tile.print_tile_call_history widget=widget varname=varname indent=indent />
  <#elseif tilename == "video_call">
<@tile.print_tile_video_call widget=widget varname=varname indent=indent />
  <#elseif tilename == "contact_merge">
<@tile.print_tile_contact_merge widget=widget varname=varname indent=indent />
  <#elseif tilename == "address_book_group">
<@tile.print_tile_address_book_group widget=widget varname=varname indent=indent />
  <#elseif tilename == "favorite_item">
<@tile.print_tile_favorite_item widget=widget varname=varname indent=indent />
  <#elseif tilename == "saved_search">
<@tile.print_tile_saved_search widget=widget varname=varname indent=indent />
  <#elseif tilename == "filter_summary">
<@tile.print_tile_filter_summary widget=widget varname=varname indent=indent />
  <#elseif tilename == "sort_option">
<@tile.print_tile_sort_option widget=widget varname=varname indent=indent />
  <#elseif tilename == "search_result">
<@tile.print_tile_search_result widget=widget varname=varname indent=indent />
  <#elseif tilename == "search_suggestion">
<@tile.print_tile_search_suggestion widget=widget varname=varname indent=indent />
  <#elseif tilename == "empty_state_panel">
<@tile.print_tile_empty_state_panel widget=widget varname=varname indent=indent />
  <#elseif tilename == "error_state_panel">
<@tile.print_tile_error_state_panel widget=widget varname=varname indent=indent />
  <#elseif tilename == "maintenance_notice">
<@tile.print_tile_maintenance_notice widget=widget varname=varname indent=indent />
  <#elseif tilename == "feature_flag">
<@tile.print_tile_feature_flag widget=widget varname=varname indent=indent />
  <#elseif tilename == "experiment_variant">
<@tile.print_tile_experiment_variant widget=widget varname=varname indent=indent />
  <#elseif tilename == "ab_test_result">
<@tile.print_tile_ab_test_result widget=widget varname=varname indent=indent />
  <#elseif tilename == "analytics_event">
<@tile.print_tile_analytics_event widget=widget varname=varname indent=indent />
  <#elseif tilename == "funnel_step">
<@tile.print_tile_funnel_step widget=widget varname=varname indent=indent />
  <#elseif tilename == "conversion_metric">
<@tile.print_tile_conversion_metric widget=widget varname=varname indent=indent />
  <#elseif tilename == "chart_summary">
<@tile.print_tile_chart_summary widget=widget varname=varname indent=indent />
  <#elseif tilename == "report_header">
<@tile.print_tile_report_header widget=widget varname=varname indent=indent />
  <#elseif tilename == "report_row">
<@tile.print_tile_report_row widget=widget varname=varname indent=indent />
  <#elseif tilename == "data_source">
<@tile.print_tile_data_source widget=widget varname=varname indent=indent />
  <#elseif tilename == "dataset_card">
<@tile.print_tile_dataset_card widget=widget varname=varname indent=indent />
  <#elseif tilename == "query_history">
<@tile.print_tile_query_history widget=widget varname=varname indent=indent />
  <#elseif tilename == "export_job">
<@tile.print_tile_export_job widget=widget varname=varname indent=indent />
  <#elseif tilename == "import_job">
<@tile.print_tile_import_job widget=widget varname=varname indent=indent />
  <#elseif tilename == "sync_status">
<@tile.print_tile_sync_status widget=widget varname=varname indent=indent />
  <#elseif tilename == "backup_snapshot">
<@tile.print_tile_backup_snapshot widget=widget varname=varname indent=indent />
  <#elseif tilename == "restore_point">
<@tile.print_tile_restore_point widget=widget varname=varname indent=indent />
  <#elseif tilename == "storage_usage">
<@tile.print_tile_storage_usage widget=widget varname=varname indent=indent />
  <#elseif tilename == "quota_meter">
<@tile.print_tile_quota_meter widget=widget varname=varname indent=indent />
  <#elseif tilename == "license_summary">
<@tile.print_tile_license_summary widget=widget varname=varname indent=indent />
  <#elseif tilename == "subscription_plan">
<@tile.print_tile_subscription_plan widget=widget varname=varname indent=indent />
  <#elseif tilename == "billing_cycle">
<@tile.print_tile_billing_cycle widget=widget varname=varname indent=indent />
  <#elseif tilename == "tax_invoice">
<@tile.print_tile_tax_invoice widget=widget varname=varname indent=indent />
  <#elseif tilename == "refund_case">
<@tile.print_tile_refund_case widget=widget varname=varname indent=indent />
  <#elseif tilename == "support_ticket">
<@tile.print_tile_support_ticket widget=widget varname=varname indent=indent />
  <#elseif tilename == "support_agent">
<@tile.print_tile_support_agent widget=widget varname=varname indent=indent />
  <#elseif tilename == "faq_item">
<@tile.print_tile_faq_item widget=widget varname=varname indent=indent />
  <#elseif tilename == "knowledge_article">
<@tile.print_tile_knowledge_article widget=widget varname=varname indent=indent />
  <#elseif tilename == "documentation_section">
<@tile.print_tile_documentation_section widget=widget varname=varname indent=indent />
  <#elseif tilename == "release_channel">
<@tile.print_tile_release_channel widget=widget varname=varname indent=indent />
  <#elseif tilename == "roadmap_milestone">
<@tile.print_tile_roadmap_milestone widget=widget varname=varname indent=indent />
  <#elseif tilename == "feedback_card">
<@tile.print_tile_feedback_card widget=widget varname=varname indent=indent />
  <#elseif tilename == "survey_question">
<@tile.print_tile_survey_question widget=widget varname=varname indent=indent />
  <#elseif tilename == "survey_response">
<@tile.print_tile_survey_response widget=widget varname=varname indent=indent />
  <#elseif tilename == "rating_summary">
<@tile.print_tile_rating_summary widget=widget varname=varname indent=indent />
  <#elseif tilename == "review_card">
<@tile.print_tile_review_card widget=widget varname=varname indent=indent />
  <#elseif tilename == "moderation_case">
<@tile.print_tile_moderation_case widget=widget varname=varname indent=indent />
  <#elseif tilename == "content_flag">
<@tile.print_tile_content_flag widget=widget varname=varname indent=indent />
  <#elseif tilename == "approval_request">
<@tile.print_tile_approval_request widget=widget varname=varname indent=indent />
  <#elseif tilename == "approval_step">
<@tile.print_tile_approval_step widget=widget varname=varname indent=indent />
  <#elseif tilename == "signature_request">
<@tile.print_tile_signature_request widget=widget varname=varname indent=indent />
  <#elseif tilename == "document_version">
<@tile.print_tile_document_version widget=widget varname=varname indent=indent />
  <#elseif tilename == "document_collaborator">
<@tile.print_tile_document_collaborator widget=widget varname=varname indent=indent />
  <#elseif tilename == "folder_item">
<@tile.print_tile_folder_item widget=widget varname=varname indent=indent />
  <#elseif tilename == "permission_rule">
<@tile.print_tile_permission_rule widget=widget varname=varname indent=indent />
  <#elseif tilename == "role_assignment">
<@tile.print_tile_role_assignment widget=widget varname=varname indent=indent />
  <#elseif tilename == "audit_event_detail">
<@tile.print_tile_audit_event_detail widget=widget varname=varname indent=indent />
  <#elseif tilename == "incident_summary">
<@tile.print_tile_incident_summary widget=widget varname=varname indent=indent />
  <#elseif tilename == "incident_timeline">
<@tile.print_tile_incident_timeline widget=widget varname=varname indent=indent />
  <#elseif tilename == "on_call_shift">
<@tile.print_tile_on_call_shift widget=widget varname=varname indent=indent />
  <#elseif tilename == "escalation_rule">
<@tile.print_tile_escalation_rule widget=widget varname=varname indent=indent />
  <#elseif tilename == "runbook_step">
<@tile.print_tile_runbook_step widget=widget varname=varname indent=indent />
  <#elseif tilename == "monitor_check">
<@tile.print_tile_monitor_check widget=widget varname=varname indent=indent />
  <#elseif tilename == "alert_group">
<@tile.print_tile_alert_group widget=widget varname=varname indent=indent />
  <#elseif tilename == "log_entry">
<@tile.print_tile_log_entry widget=widget varname=varname indent=indent />
  <#elseif tilename == "trace_span">
<@tile.print_tile_trace_span widget=widget varname=varname indent=indent />
  <#elseif tilename == "request_detail">
<@tile.print_tile_request_detail widget=widget varname=varname indent=indent />
  <#elseif tilename == "server_card">
<@tile.print_tile_server_card widget=widget varname=varname indent=indent />
  <#elseif tilename == "container_card">
<@tile.print_tile_container_card widget=widget varname=varname indent=indent />
  <#elseif tilename == "cloud_region">
<@tile.print_tile_cloud_region widget=widget varname=varname indent=indent />
  <#elseif tilename == "integration_card">
<@tile.print_tile_integration_card widget=widget varname=varname indent=indent />
  <#elseif tilename == "webhook_event">
<@tile.print_tile_webhook_event widget=widget varname=varname indent=indent />
  <#elseif tilename == "automation_rule">
<@tile.print_tile_automation_rule widget=widget varname=varname indent=indent />
  <#elseif tilename == "workflow_run">
<@tile.print_tile_workflow_run widget=widget varname=varname indent=indent />
  <#elseif tilename == "queue_item">
<@tile.print_tile_queue_item widget=widget varname=varname indent=indent />
  <#elseif tilename == "job_detail">
<@tile.print_tile_job_detail widget=widget varname=varname indent=indent />
  <#elseif tilename == "schedule_rule">
<@tile.print_tile_schedule_rule widget=widget varname=varname indent=indent />
  <#elseif tilename == "recurring_task">
<@tile.print_tile_recurring_task widget=widget varname=varname indent=indent />
  <#elseif tilename == "approval_inbox">
<@tile.print_tile_approval_inbox widget=widget varname=varname indent=indent />
  <#elseif tilename == "draft_item">
<@tile.print_tile_draft_item widget=widget varname=varname indent=indent />
  <#elseif tilename == "publish_item">
<@tile.print_tile_publish_item widget=widget varname=varname indent=indent />
  <#elseif tilename == "campaign_card">
<@tile.print_tile_campaign_card widget=widget varname=varname indent=indent />
  <#elseif tilename == "audience_segment">
<@tile.print_tile_audience_segment widget=widget varname=varname indent=indent />
  <#elseif tilename == "channel_summary">
<@tile.print_tile_channel_summary widget=widget varname=varname indent=indent />
  <#elseif tilename == "social_account">
<@tile.print_tile_social_account widget=widget varname=varname indent=indent />
  <#elseif tilename == "post_scheduler">
<@tile.print_tile_post_scheduler widget=widget varname=varname indent=indent />
  <#elseif tilename == "content_calendar">
<@tile.print_tile_content_calendar widget=widget varname=varname indent=indent />
  <#elseif tilename == "brand_asset">
<@tile.print_tile_brand_asset widget=widget varname=varname indent=indent />
  <#elseif tilename == "theme_preview">
<@tile.print_tile_theme_preview widget=widget varname=varname indent=indent />
  <#elseif tilename == "component_variant">
<@tile.print_tile_component_variant widget=widget varname=varname indent=indent />
  <#elseif tilename == "design_token">
<@tile.print_tile_design_token widget=widget varname=varname indent=indent />
  <#elseif tilename == "ui_pattern">
<@tile.print_tile_ui_pattern widget=widget varname=varname indent=indent />
  <#elseif tilename == "prototype_screen">
<@tile.print_tile_prototype_screen widget=widget varname=varname indent=indent />
  <#elseif tilename == "handoff_item">
<@tile.print_tile_handoff_item widget=widget varname=varname indent=indent />
  <#elseif tilename == "accessibility_check">
<@tile.print_tile_accessibility_check widget=widget varname=varname indent=indent />
  <#elseif tilename == "translation_item">
<@tile.print_tile_translation_item widget=widget varname=varname indent=indent />
  <#elseif tilename == "localization_status">
<@tile.print_tile_localization_status widget=widget varname=varname indent=indent />
  <#elseif tilename == "language_pack">
<@tile.print_tile_language_pack widget=widget varname=varname indent=indent />
  <#elseif tilename == "release_calendar">
<@tile.print_tile_release_calendar widget=widget varname=varname indent=indent />
  <#elseif tilename == "change_request">
<@tile.print_tile_change_request widget=widget varname=varname indent=indent />
  <#elseif tilename == "risk_register">
<@tile.print_tile_risk_register widget=widget varname=varname indent=indent />
  <#elseif tilename == "dependency_item">
<@tile.print_tile_dependency_item widget=widget varname=varname indent=indent />
  <#elseif tilename == "decision_log">
<@tile.print_tile_decision_log widget=widget varname=varname indent=indent />
  <#elseif tilename == "meeting_notes">
<@tile.print_tile_meeting_notes widget=widget varname=varname indent=indent />
  <#elseif tilename == "action_item">
<@tile.print_tile_action_item widget=widget varname=varname indent=indent />
  <#elseif tilename == "okr_objective">
<@tile.print_tile_okr_objective widget=widget varname=varname indent=indent />
  <#elseif tilename == "key_result">
<@tile.print_tile_key_result widget=widget varname=varname indent=indent />
  <#elseif tilename == "goal_progress">
<@tile.print_tile_goal_progress widget=widget varname=varname indent=indent />
  <#elseif tilename == "personal_dashboard">
<@tile.print_tile_personal_dashboard widget=widget varname=varname indent=indent />
  <#elseif tilename == "quick_action">
<@tile.print_tile_quick_action widget=widget varname=varname indent=indent />
  </#if>
</#macro>