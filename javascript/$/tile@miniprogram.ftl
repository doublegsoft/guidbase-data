<#import "/$/guidbase.ftl" as guidbase>

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
<#macro print_tile_meeting_event widget varname="row" indent=0>
${""?left_pad(indent)}<view class="tile tile-meeting-event">
${""?left_pad(indent)}  <view class="tile-row tile-header">
  <#if guidbase.has_child_widget(widget, "start_time") || guidbase.has_child_widget(widget, "end_time")>
${""?left_pad(indent)}    <text class="tile-time">
    <#if guidbase.has_child_widget(widget, "start_time")>${""?left_pad(indent)}<text>{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "start_time"))} }}</text></#if>
    <#if guidbase.has_child_widget(widget, "start_time") && guidbase.has_child_widget(widget, "end_time")>${""?left_pad(indent)}<text class="tile-time-sep"> - </text></#if>
    <#if guidbase.has_child_widget(widget, "end_time")>${""?left_pad(indent)}<text>{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "end_time"))} }}</text></#if>
${""?left_pad(indent)}    </text>
  </#if>
  <#if guidbase.has_child_widget(widget, "status")>
${""?left_pad(indent)}    <text class="tile-status">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))} }}</text>
  </#if>
${""?left_pad(indent)}  </view>
  <#if guidbase.has_child_widget(widget, "primary") || guidbase.has_child_widget(widget, "secondary")>
${""?left_pad(indent)}  <view class="tile-body">
    <#if guidbase.has_child_widget(widget, "primary")>
${""?left_pad(indent)}    <view class="tile-primary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))} }}</view>
    </#if>
    <#if guidbase.has_child_widget(widget, "secondary")>
${""?left_pad(indent)}    <view class="tile-secondary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "secondary"))} }}</view>
    </#if>
${""?left_pad(indent)}  </view>
  </#if>
  <#if guidbase.has_child_widget(widget, "avatars")>
${""?left_pad(indent)}  <view class="tile-footer">
${""?left_pad(indent)}    <view class="tile-avatars"><image wx:for="{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "avatars"))} }}" wx:for-item="av" wx:for-index="idx" wx:key="idx" src="{{ av }}" class="tile-avatar-img"></image></view>
${""?left_pad(indent)}  </view>
  </#if>
${""?left_pad(indent)}</view>
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
<#macro print_tile_media_article widget varname="row" indent=0>
${""?left_pad(indent)}<view class="tile tile-media-article">
  <#if guidbase.has_child_widget(widget, "image")>
${""?left_pad(indent)}  <view class="tile-image-wrap">
${""?left_pad(indent)}    <view class="tile-image">
${""?left_pad(indent)}      <image src="{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "image"))} }}"></image>
${""?left_pad(indent)}    </view>
    <#if guidbase.has_child_widget(widget, "tags")>
${""?left_pad(indent)}    <view class="tile-image-tags">
${""?left_pad(indent)}      <text><text wx:for="{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "tags"))} }}" wx:for-item="tag" wx:for-index="idx" wx:key="idx" class="tile-tag">{{ tag }}</text></text>
${""?left_pad(indent)}    </view>
    </#if>
${""?left_pad(indent)}  </view>
  </#if>
  <#if guidbase.has_child_widget(widget, "primary") || guidbase.has_child_widget(widget, "secondary") || guidbase.has_child_widget(widget, "tertiary")>
${""?left_pad(indent)}  <view class="tile-body">
    <#if guidbase.has_child_widget(widget, "primary")>
${""?left_pad(indent)}    <view class="tile-primary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))} }}</view>
    </#if>
    <#if guidbase.has_child_widget(widget, "secondary")>
${""?left_pad(indent)}    <view class="tile-secondary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "secondary"))} }}</view>
    </#if>
    <#if guidbase.has_child_widget(widget, "tertiary")>
${""?left_pad(indent)}    <view class="tile-tertiary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "tertiary"))} }}</view>
    </#if>
${""?left_pad(indent)}  </view>
  </#if>
${""?left_pad(indent)}</view>
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
<#macro print_tile_user_profile widget varname="row" indent=0>
${""?left_pad(indent)}<view class="tile tile-user-profile">
${""?left_pad(indent)}  <view class="tile-row">
  <#if guidbase.has_child_widget(widget, "avatar")>
${""?left_pad(indent)}    <view class="tile-avatar">
${""?left_pad(indent)}      <image src="{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "avatar"))} }}"></image>
${""?left_pad(indent)}    </view>
  </#if>
${""?left_pad(indent)}    <view class="tile-body">
    <#if guidbase.has_child_widget(widget, "primary")>
${""?left_pad(indent)}      <view class="tile-primary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))} }}</view>
    </#if>
    <#if guidbase.has_child_widget(widget, "secondary")>
${""?left_pad(indent)}      <view class="tile-secondary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "secondary"))} }}</view>
    </#if>
${""?left_pad(indent)}    </view>
  <#if guidbase.has_child_widget(widget, "status")>
${""?left_pad(indent)}    <text class="tile-status">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))} }}</text>
  </#if>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}</view>
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
<#macro print_tile_task_board widget varname="row" indent=0>
${""?left_pad(indent)}<view class="tile tile-task-board">
${""?left_pad(indent)}  <view class="tile-row tile-header">
  <#if guidbase.has_child_widget(widget, "tags")>
${""?left_pad(indent)}    <text class="tile-tags"><text wx:for="{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "tags"))} }}" wx:for-item="tag" wx:for-index="idx" wx:key="idx" class="tile-tag">{{ tag }}</text></text>
  </#if>
  <#if guidbase.has_child_widget(widget, "status")>
${""?left_pad(indent)}    <text class="tile-status">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))} }}</text>
  </#if>
${""?left_pad(indent)}  </view>
  <#if guidbase.has_child_widget(widget, "primary")>
${""?left_pad(indent)}  <view class="tile-body">
${""?left_pad(indent)}    <view class="tile-primary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))} }}</view>
${""?left_pad(indent)}  </view>
  </#if>
${""?left_pad(indent)}  <view class="tile-row tile-footer">
  <#if guidbase.has_child_widget(widget, "avatars")>
${""?left_pad(indent)}    <view class="tile-avatars"><image wx:for="{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "avatars"))} }}" wx:for-item="av" wx:for-index="idx" wx:key="idx" src="{{ av }}" class="tile-avatar-img"></image></view>
  </#if>
  <#if guidbase.has_child_widget(widget, "end_time")>
${""?left_pad(indent)}    <text class="tile-end-time">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "end_time"))} }}</text>
  </#if>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}</view>
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
<#macro print_tile_promo_banner widget varname="row" indent=0>
${""?left_pad(indent)}<view class="tile tile-promo-banner">
  <#if guidbase.has_child_widget(widget, "background")>
${""?left_pad(indent)}  <view class="tile-background">
${""?left_pad(indent)}    <image src="{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "background"))} }}"></image>
${""?left_pad(indent)}  </view>
  </#if>
${""?left_pad(indent)}  <view class="tile-overlay">
  <#if guidbase.has_child_widget(widget, "tags")>
${""?left_pad(indent)}    <view class="tile-tags"><text wx:for="{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "tags"))} }}" wx:for-item="tag" wx:for-index="idx" wx:key="idx" class="tile-tag">{{ tag }}</text></view>
  </#if>
  <#if guidbase.has_child_widget(widget, "primary")>
${""?left_pad(indent)}    <view class="tile-primary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))} }}</view>
  </#if>
  <#if guidbase.has_child_widget(widget, "secondary")>
${""?left_pad(indent)}    <view class="tile-secondary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "secondary"))} }}</view>
  </#if>
  <#if guidbase.has_child_widget(widget, "tertiary")>
${""?left_pad(indent)}    <view class="tile-tertiary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "tertiary"))} }}</view>
  </#if>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}</view>
</#macro>

<#--
紧凑列表 (Compact List)
+-----------------------------------------------+
| [status]  [primary]  [secondary]  [start time]|
+-----------------------------------------------+
-->
<#macro print_tile_compact_list widget varname="row" indent=0>
${""?left_pad(indent)}<view class="tile tile-compact-list">
${""?left_pad(indent)}  <view class="tile-row tile-inline">
  <#if guidbase.has_child_widget(widget, "status")>
${""?left_pad(indent)}    <text class="tile-status">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))} }}</text>
  </#if>
  <#if guidbase.has_child_widget(widget, "primary")>
${""?left_pad(indent)}    <text class="tile-primary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))} }}</text>
  </#if>
  <#if guidbase.has_child_widget(widget, "secondary")>
${""?left_pad(indent)}    <text class="tile-secondary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "secondary"))} }}</text>
  </#if>
  <#if guidbase.has_child_widget(widget, "start_time")>
${""?left_pad(indent)}    <text class="tile-start-time">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "start_time"))} }}</text>
  </#if>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}</view>
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
<#macro print_tile_split_content widget varname="row" indent=0>
${""?left_pad(indent)}<view class="tile tile-split-content">
${""?left_pad(indent)}  <view class="tile-row">
  <#if guidbase.has_child_widget(widget, "image")>
${""?left_pad(indent)}    <view class="tile-image">
${""?left_pad(indent)}      <image src="{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "image"))} }}"></image>
${""?left_pad(indent)}    </view>
  </#if>
${""?left_pad(indent)}    <view class="tile-body">
    <#if guidbase.has_child_widget(widget, "tags")>
${""?left_pad(indent)}      <view class="tile-tags"><text wx:for="{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "tags"))} }}" wx:for-item="tag" wx:for-index="idx" wx:key="idx" class="tile-tag">{{ tag }}</text></view>
    </#if>
    <#if guidbase.has_child_widget(widget, "primary")>
${""?left_pad(indent)}      <view class="tile-primary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))} }}</view>
    </#if>
    <#if guidbase.has_child_widget(widget, "avatars")>
${""?left_pad(indent)}      <view class="tile-avatars"><image wx:for="{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "avatars"))} }}" wx:for-item="av" wx:for-index="idx" wx:key="idx" src="{{ av }}" class="tile-avatar-img"></image></view>
    </#if>
    <#if guidbase.has_child_widget(widget, "start_time")>
${""?left_pad(indent)}      <text class="tile-start-time">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "start_time"))} }}</text>
    </#if>
${""?left_pad(indent)}    </view>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}</view>
</#macro>

<#--
简易状态 (Notification)
+-----------------------------------------------+
|  [status]   [primary]                         |
|             [tertiary]                        |
+-----------------------------------------------+
-->
<#macro print_tile_notification widget varname="row" indent=0>
${""?left_pad(indent)}<view class="tile tile-notification">
${""?left_pad(indent)}  <view class="tile-row">
  <#if guidbase.has_child_widget(widget, "status")>
${""?left_pad(indent)}    <text class="tile-status">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))} }}</text>
  </#if>
${""?left_pad(indent)}    <view class="tile-body">
    <#if guidbase.has_child_widget(widget, "primary")>
${""?left_pad(indent)}      <view class="tile-primary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))} }}</view>
    </#if>
    <#if guidbase.has_child_widget(widget, "tertiary")>
${""?left_pad(indent)}      <view class="tile-tertiary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "tertiary"))} }}</view>
    </#if>
${""?left_pad(indent)}    </view>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}</view>
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
<#macro print_tile_hero_profile widget varname="row" indent=0>
${""?left_pad(indent)}<view class="tile tile-hero-profile">
  <#if guidbase.has_child_widget(widget, "background")>
${""?left_pad(indent)}  <view class="tile-background">
${""?left_pad(indent)}    <image src="{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "background"))} }}"></image>
${""?left_pad(indent)}  </view>
  </#if>
${""?left_pad(indent)}  <view class="tile-overlay">
  <#if guidbase.has_child_widget(widget, "avatar")>
${""?left_pad(indent)}    <view class="tile-avatar">
${""?left_pad(indent)}      <image src="{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "avatar"))} }}"></image>
${""?left_pad(indent)}    </view>
  </#if>
  <#if guidbase.has_child_widget(widget, "primary")>
${""?left_pad(indent)}    <view class="tile-primary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))} }}</view>
  </#if>
  <#if guidbase.has_child_widget(widget, "secondary")>
${""?left_pad(indent)}    <view class="tile-secondary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "secondary"))} }}</view>
  </#if>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}</view>
</#macro>

<#--
时间轴节点 (Timeline Node)
+-----------------------------------------------+
| [start time] | [primary]               [tags] |
|      |       | [secondary]                    |
| [end time]   | [tertiary]                     |
+-----------------------------------------------+
-->
<#macro print_tile_timeline_node widget varname="row" indent=0>
${""?left_pad(indent)}<view class="tile tile-timeline-node">
${""?left_pad(indent)}  <view class="tile-row">
${""?left_pad(indent)}    <view class="tile-timeline">
    <#if guidbase.has_child_widget(widget, "start_time")>
${""?left_pad(indent)}      <text class="tile-start-time">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "start_time"))} }}</text>
    </#if>
${""?left_pad(indent)}      <text class="tile-timeline-dot"></text>
    <#if guidbase.has_child_widget(widget, "end_time")>
${""?left_pad(indent)}      <text class="tile-end-time">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "end_time"))} }}</text>
    </#if>
${""?left_pad(indent)}    </view>
${""?left_pad(indent)}    <view class="tile-body">
    <#if guidbase.has_child_widget(widget, "primary")>
${""?left_pad(indent)}      <view class="tile-primary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))} }}</view>
    </#if>
    <#if guidbase.has_child_widget(widget, "secondary")>
${""?left_pad(indent)}      <view class="tile-secondary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "secondary"))} }}</view>
    </#if>
    <#if guidbase.has_child_widget(widget, "tertiary")>
${""?left_pad(indent)}      <view class="tile-tertiary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "tertiary"))} }}</view>
    </#if>
${""?left_pad(indent)}    </view>
  <#if guidbase.has_child_widget(widget, "tags")>
${""?left_pad(indent)}    <text class="tile-tags"><text wx:for="{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "tags"))} }}" wx:for-item="tag" wx:for-index="idx" wx:key="idx" class="tile-tag">{{ tag }}</text></text>
  </#if>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}</view>
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
<#macro print_tile_message widget varname="row" indent=0>
${""?left_pad(indent)}<view class="tile tile-message">
${""?left_pad(indent)}  <view class="tile-row">
  <#if guidbase.has_child_widget(widget, "avatar")>
${""?left_pad(indent)}    <view class="tile-avatar">
${""?left_pad(indent)}      <image src="{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "avatar"))} }}"></image>
${""?left_pad(indent)}    </view>
  </#if>
${""?left_pad(indent)}    <view class="tile-body">
${""?left_pad(indent)}      <view class="tile-row tile-header">
    <#if guidbase.has_child_widget(widget, "primary")>
${""?left_pad(indent)}        <view class="tile-primary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))} }}</view>
    </#if>
    <#if guidbase.has_child_widget(widget, "start_time")>
${""?left_pad(indent)}        <text class="tile-start-time">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "start_time"))} }}</text>
    </#if>
${""?left_pad(indent)}      </view>
    <#if guidbase.has_child_widget(widget, "secondary")>
${""?left_pad(indent)}      <view class="tile-secondary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "secondary"))} }}</view>
    </#if>
    <#if guidbase.has_child_widget(widget, "tertiary")>
${""?left_pad(indent)}      <view class="tile-tertiary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "tertiary"))} }}</view>
    </#if>
${""?left_pad(indent)}    </view>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}</view>
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
<#macro print_tile_ticket widget varname="row" indent=0>
${""?left_pad(indent)}<view class="tile tile-ticket">
  <#if guidbase.has_child_widget(widget, "background")>
${""?left_pad(indent)}  <view class="tile-background">
${""?left_pad(indent)}    <image src="{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "background"))} }}"></image>
${""?left_pad(indent)}  </view>
  </#if>
${""?left_pad(indent)}  <view class="tile-overlay">
${""?left_pad(indent)}    <view class="tile-row tile-header">
    <#if guidbase.has_child_widget(widget, "primary")>
${""?left_pad(indent)}      <view class="tile-primary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))} }}</view>
    </#if>
    <#if guidbase.has_child_widget(widget, "status")>
${""?left_pad(indent)}      <text class="tile-status">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))} }}</text>
    </#if>
${""?left_pad(indent)}    </view>
    <#if guidbase.has_child_widget(widget, "start_time") || guidbase.has_child_widget(widget, "end_time")>
${""?left_pad(indent)}    <view class="tile-time">
    <#if guidbase.has_child_widget(widget, "start_time")><text>{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "start_time"))} }}</text></#if>
    <#if guidbase.has_child_widget(widget, "start_time") && guidbase.has_child_widget(widget, "end_time")> ~ </#if>
    <#if guidbase.has_child_widget(widget, "end_time")><text>{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "end_time"))} }}</text></#if>
${""?left_pad(indent)}    </view>
    </#if>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}</view>
</#macro>

<#--
密集信息列表 (Dense Detail List)
+-----------------------------------------------+
| +-------+  [primary]                          |
| | image |  [secondary]                 [tags] |
| +-------+  [tertiary]                [status] |
+-----------------------------------------------+
-->
<#macro print_tile_dense_detail_list widget varname="row" indent=0>
${""?left_pad(indent)}<view class="tile tile-dense-detail-list">
${""?left_pad(indent)}  <view class="tile-row">
  <#if guidbase.has_child_widget(widget, "image")>
${""?left_pad(indent)}    <view class="tile-image">
${""?left_pad(indent)}      <image src="{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "image"))} }}"></image>
${""?left_pad(indent)}    </view>
  </#if>
${""?left_pad(indent)}    <view class="tile-body">
    <#if guidbase.has_child_widget(widget, "primary")>
${""?left_pad(indent)}      <view class="tile-primary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))} }}</view>
    </#if>
${""?left_pad(indent)}      <view class="tile-row">
    <#if guidbase.has_child_widget(widget, "secondary")>
${""?left_pad(indent)}        <text class="tile-secondary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "secondary"))} }}</text>
    </#if>
    <#if guidbase.has_child_widget(widget, "tags")>
${""?left_pad(indent)}        <text class="tile-tags"><text wx:for="{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "tags"))} }}" wx:for-item="tag" wx:for-index="idx" wx:key="idx" class="tile-tag">{{ tag }}</text></text>
    </#if>
${""?left_pad(indent)}      </view>
${""?left_pad(indent)}      <view class="tile-row">
    <#if guidbase.has_child_widget(widget, "tertiary")>
${""?left_pad(indent)}        <text class="tile-tertiary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "tertiary"))} }}</text>
    </#if>
    <#if guidbase.has_child_widget(widget, "status")>
${""?left_pad(indent)}        <text class="tile-status">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))} }}</text>
    </#if>
${""?left_pad(indent)}      </view>
${""?left_pad(indent)}    </view>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}</view>
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
<#macro print_tile_vertical_poster widget varname="row" indent=0>
${""?left_pad(indent)}<view class="tile tile-vertical-poster">
  <#if guidbase.has_child_widget(widget, "image")>
${""?left_pad(indent)}  <view class="tile-image">
${""?left_pad(indent)}    <image src="{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "image"))} }}"></image>
${""?left_pad(indent)}  </view>
  </#if>
  <#if guidbase.has_child_widget(widget, "primary") || guidbase.has_child_widget(widget, "secondary") || guidbase.has_child_widget(widget, "start_time") || guidbase.has_child_widget(widget, "end_time") || guidbase.has_child_widget(widget, "avatars")>
${""?left_pad(indent)}  <view class="tile-body">
    <#if guidbase.has_child_widget(widget, "primary")>
${""?left_pad(indent)}    <view class="tile-primary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))} }}</view>
    </#if>
    <#if guidbase.has_child_widget(widget, "secondary")>
${""?left_pad(indent)}    <view class="tile-secondary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "secondary"))} }}</view>
    </#if>
    <#if guidbase.has_child_widget(widget, "start_time")>
${""?left_pad(indent)}    <view class="tile-start-time">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "start_time"))} }}</view>
    </#if>
    <#if guidbase.has_child_widget(widget, "end_time")>
${""?left_pad(indent)}    <view class="tile-end-time">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "end_time"))} }}</view>
    </#if>
    <#if guidbase.has_child_widget(widget, "avatars")>
${""?left_pad(indent)}    <view class="tile-avatars"><image wx:for="{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "avatars"))} }}" wx:for-item="av" wx:for-index="idx" wx:key="idx" src="{{ av }}" class="tile-avatar-img"></image></view>
    </#if>
${""?left_pad(indent)}  </view>
  </#if>
${""?left_pad(indent)}</view>
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
<#macro print_tile_issue_detail widget varname="row" indent=0>
${""?left_pad(indent)}<view class="tile tile-issue-detail">
${""?left_pad(indent)}  <view class="tile-row tile-header">
  <#if guidbase.has_child_widget(widget, "tags")>
${""?left_pad(indent)}    <text class="tile-tags"><text wx:for="{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "tags"))} }}" wx:for-item="tag" wx:for-index="idx" wx:key="idx" class="tile-tag">{{ tag }}</text></text>
  </#if>
  <#if guidbase.has_child_widget(widget, "status")>
${""?left_pad(indent)}    <text class="tile-status">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))} }}</text>
  </#if>
${""?left_pad(indent)}  </view>
  <#if guidbase.has_child_widget(widget, "primary") || guidbase.has_child_widget(widget, "secondary") || guidbase.has_child_widget(widget, "tertiary")>
${""?left_pad(indent)}  <view class="tile-body">
    <#if guidbase.has_child_widget(widget, "primary")>
${""?left_pad(indent)}    <view class="tile-primary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))} }}</view>
    </#if>
    <#if guidbase.has_child_widget(widget, "secondary")>
${""?left_pad(indent)}    <view class="tile-secondary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "secondary"))} }}</view>
    </#if>
    <#if guidbase.has_child_widget(widget, "tertiary")>
${""?left_pad(indent)}    <view class="tile-tertiary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "tertiary"))} }}</view>
    </#if>
${""?left_pad(indent)}  </view>
  </#if>
${""?left_pad(indent)}  <view class="tile-row tile-footer">
  <#if guidbase.has_child_widget(widget, "avatar")>
${""?left_pad(indent)}    <view class="tile-avatar">
${""?left_pad(indent)}      <image src="{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "avatar"))} }}"></image>
${""?left_pad(indent)}    </view>
  </#if>
  <#if guidbase.has_child_widget(widget, "end_time")>
${""?left_pad(indent)}    <text class="tile-end-time">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "end_time"))} }}</text>
  </#if>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}</view>
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
<#macro print_tile_team_directory widget varname="row" indent=0>
${""?left_pad(indent)}<view class="tile tile-team-directory">
${""?left_pad(indent)}  <view class="tile-body">
  <#if guidbase.has_child_widget(widget, "primary")>
${""?left_pad(indent)}    <view class="tile-primary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))} }}</view>
  </#if>
  <#if guidbase.has_child_widget(widget, "secondary")>
${""?left_pad(indent)}    <view class="tile-secondary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "secondary"))} }}</view>
  </#if>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}  <view class="tile-row tile-footer">
  <#if guidbase.has_child_widget(widget, "avatars")>
${""?left_pad(indent)}    <view class="tile-avatars"><image wx:for="{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "avatars"))} }}" wx:for-item="av" wx:for-index="idx" wx:key="idx" src="{{ av }}" class="tile-avatar-img"></image></view>
  </#if>
  <#if guidbase.has_child_widget(widget, "tags")>
${""?left_pad(indent)}    <text class="tile-tags"><text wx:for="{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "tags"))} }}" wx:for-item="tag" wx:for-index="idx" wx:key="idx" class="tile-tag">{{ tag }}</text></text>
  </#if>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}</view>
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
<#macro print_tile_immersive_highlight widget varname="row" indent=0>
${""?left_pad(indent)}<view class="tile tile-immersive-highlight">
  <#if guidbase.has_child_widget(widget, "background")>
${""?left_pad(indent)}  <view class="tile-background">
${""?left_pad(indent)}    <image src="{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "background"))} }}"></image>
${""?left_pad(indent)}  </view>
  </#if>
${""?left_pad(indent)}  <view class="tile-overlay">
  <#if guidbase.has_child_widget(widget, "status")>
${""?left_pad(indent)}    <text class="tile-status">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))} }}</text>
  </#if>
  <#if guidbase.has_child_widget(widget, "primary")>
${""?left_pad(indent)}    <view class="tile-primary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))} }}</view>
  </#if>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}</view>
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
<#macro print_tile_mini_status widget varname="row" indent=0>
${""?left_pad(indent)}<view class="tile tile-mini-status">
${""?left_pad(indent)}  <view class="tile-row tile-header">
  <#if guidbase.has_child_widget(widget, "status")>
${""?left_pad(indent)}    <text class="tile-status">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))} }}</text>
  </#if>
  <#if guidbase.has_child_widget(widget, "end_time")>
${""?left_pad(indent)}    <text class="tile-end-time">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "end_time"))} }}</text>
  </#if>
${""?left_pad(indent)}  </view>
  <#if guidbase.has_child_widget(widget, "primary")>
${""?left_pad(indent)}  <view class="tile-primary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))} }}</view>
  </#if>
  <#if guidbase.has_child_widget(widget, "tags")>
${""?left_pad(indent)}  <view class="tile-tags"><text wx:for="{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "tags"))} }}" wx:for-item="tag" wx:for-index="idx" wx:key="idx" class="tile-tag">{{ tag }}</text></view>
  </#if>
${""?left_pad(indent)}</view>
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
<#macro print_tile_dual_column_content widget varname="row" indent=0>
${""?left_pad(indent)}<view class="tile tile-dual-column-content">
${""?left_pad(indent)}  <view class="tile-row">
${""?left_pad(indent)}    <view class="tile-col tile-col-left">
    <#if guidbase.has_child_widget(widget, "primary")>
${""?left_pad(indent)}      <view class="tile-primary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))} }}</view>
    </#if>
    <#if guidbase.has_child_widget(widget, "tertiary")>
${""?left_pad(indent)}      <view class="tile-tertiary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "tertiary"))} }}</view>
    </#if>
    <#if guidbase.has_child_widget(widget, "avatar")>
${""?left_pad(indent)}      <view class="tile-avatar">
${""?left_pad(indent)}        <image src="{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "avatar"))} }}"></image>
${""?left_pad(indent)}      </view>
    </#if>
${""?left_pad(indent)}    </view>
${""?left_pad(indent)}    <view class="tile-col tile-col-right">
    <#if guidbase.has_child_widget(widget, "secondary")>
${""?left_pad(indent)}      <view class="tile-secondary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "secondary"))} }}</view>
    </#if>
    <#if guidbase.has_child_widget(widget, "tags")>
${""?left_pad(indent)}      <view class="tile-tags"><text wx:for="{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "tags"))} }}" wx:for-item="tag" wx:for-index="idx" wx:key="idx" class="tile-tag">{{ tag }}</text></view>
    </#if>
    <#if guidbase.has_child_widget(widget, "avatars")>
${""?left_pad(indent)}      <view class="tile-avatars"><image wx:for="{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "avatars"))} }}" wx:for-item="av" wx:for-index="idx" wx:key="idx" src="{{ av }}" class="tile-avatar-img"></image></view>
    </#if>
${""?left_pad(indent)}    </view>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}</view>
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
<#macro print_tile_gallery widget varname="row" indent=0>
${""?left_pad(indent)}<view class="tile tile-gallery">
  <#if guidbase.has_child_widget(widget, "image")>
${""?left_pad(indent)}  <view class="tile-image-wrap">
${""?left_pad(indent)}    <view class="tile-image">
${""?left_pad(indent)}      <image src="{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "image"))} }}"></image>
${""?left_pad(indent)}    </view>
${""?left_pad(indent)}  </view>
  </#if>
  <#if guidbase.has_child_widget(widget, "primary")>
${""?left_pad(indent)}  <view class="tile-primary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))} }}</view>
  </#if>
${""?left_pad(indent)}  <view class="tile-row tile-footer">
  <#if guidbase.has_child_widget(widget, "avatars")>
${""?left_pad(indent)}    <view class="tile-avatars"><image wx:for="{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "avatars"))} }}" wx:for-item="av" wx:for-index="idx" wx:key="idx" src="{{ av }}" class="tile-avatar-img"></image></view>
  </#if>
  <#if guidbase.has_child_widget(widget, "status")>
${""?left_pad(indent)}    <text class="tile-status">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))} }}</text>
  </#if>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}</view>
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
<#macro print_tile_key_metric widget varname="row" indent=0>
${""?left_pad(indent)}<view class="tile tile-key-metric">
  <#if guidbase.has_child_widget(widget, "tags")>
${""?left_pad(indent)}  <view class="tile-tags"><text wx:for="{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "tags"))} }}" wx:for-item="tag" wx:for-index="idx" wx:key="idx" class="tile-tag">{{ tag }}</text></view>
  </#if>
  <#if guidbase.has_child_widget(widget, "primary")>
${""?left_pad(indent)}  <view class="tile-primary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))} }}</view>
  </#if>
${""?left_pad(indent)}  <view class="tile-row tile-footer">
  <#if guidbase.has_child_widget(widget, "secondary")>
${""?left_pad(indent)}    <text class="tile-secondary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "secondary"))} }}</text>
  </#if>
  <#if guidbase.has_child_widget(widget, "status")>
${""?left_pad(indent)}    <text class="tile-status">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))} }}</text>
  </#if>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}</view>
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
<#macro print_tile_overlay_avatar widget varname="row" indent=0>
${""?left_pad(indent)}<view class="tile tile-overlay-avatar">
  <#if guidbase.has_child_widget(widget, "image")>
${""?left_pad(indent)}  <view class="tile-image-wrap">
${""?left_pad(indent)}    <view class="tile-image">
${""?left_pad(indent)}      <image src="{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "image"))} }}"></image>
${""?left_pad(indent)}    </view>
${""?left_pad(indent)}  </view>
  </#if>
${""?left_pad(indent)}  <view class="tile-row tile-overlay-content">
  <#if guidbase.has_child_widget(widget, "avatar")>
${""?left_pad(indent)}    <view class="tile-avatar">
${""?left_pad(indent)}      <image src="{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "avatar"))} }}"></image>
${""?left_pad(indent)}    </view>
  </#if>
${""?left_pad(indent)}    <view class="tile-body">
    <#if guidbase.has_child_widget(widget, "primary")>
${""?left_pad(indent)}      <view class="tile-primary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))} }}</view>
    </#if>
    <#if guidbase.has_child_widget(widget, "secondary")>
${""?left_pad(indent)}      <view class="tile-secondary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "secondary"))} }}</view>
    </#if>
${""?left_pad(indent)}    </view>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}</view>
</#macro>

<#--
审计记录 (Audit Log)
+-----------------------------------------------+
| [avatar]  [primary]                  [status] |
|           [secondary]                         |
|           [start time]                        |
+-----------------------------------------------+
-->
<#macro print_tile_audit_log widget varname="row" indent=0>
${""?left_pad(indent)}<view class="tile tile-audit-log">
${""?left_pad(indent)}  <view class="tile-row">
  <#if guidbase.has_child_widget(widget, "avatar")>
${""?left_pad(indent)}    <view class="tile-avatar">
${""?left_pad(indent)}      <image src="{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "avatar"))} }}"></image>
${""?left_pad(indent)}    </view>
  </#if>
${""?left_pad(indent)}    <view class="tile-body">
${""?left_pad(indent)}      <view class="tile-row">
    <#if guidbase.has_child_widget(widget, "primary")>
${""?left_pad(indent)}        <view class="tile-primary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))} }}</view>
    </#if>
    <#if guidbase.has_child_widget(widget, "status")>
${""?left_pad(indent)}        <text class="tile-status">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))} }}</text>
    </#if>
${""?left_pad(indent)}      </view>
    <#if guidbase.has_child_widget(widget, "secondary")>
${""?left_pad(indent)}      <view class="tile-secondary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "secondary"))} }}</view>
    </#if>
    <#if guidbase.has_child_widget(widget, "start_time")>
${""?left_pad(indent)}      <view class="tile-start-time">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "start_time"))} }}</view>
    </#if>
${""?left_pad(indent)}    </view>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}</view>
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
<#macro print_tile_calendar_cell widget varname="row" indent=0>
${""?left_pad(indent)}<view class="tile tile-calendar-cell">
${""?left_pad(indent)}  <view class="tile-row tile-header">
  <#if guidbase.has_child_widget(widget, "start_time")>
${""?left_pad(indent)}    <text class="tile-start-time">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "start_time"))} }}</text>
  </#if>
  <#if guidbase.has_child_widget(widget, "status")>
${""?left_pad(indent)}    <text class="tile-status">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))} }}</text>
  </#if>
${""?left_pad(indent)}  </view>
  <#if guidbase.has_child_widget(widget, "primary")>
${""?left_pad(indent)}  <view class="tile-primary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))} }}</view>
  </#if>
  <#if guidbase.has_child_widget(widget, "avatars")>
${""?left_pad(indent)}  <view class="tile-avatars"><image wx:for="{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "avatars"))} }}" wx:for-item="av" wx:for-index="idx" wx:key="idx" src="{{ av }}" class="tile-avatar-img"></image></view>
  </#if>
${""?left_pad(indent)}</view>
</#macro>

<#--
侧边状态卡 (Side Status Card)
+----------+------------------------------------+
|          | [primary]                          |
| [status] | [secondary]                        |
|          | [start time]                       |
+----------+------------------------------------+
-->
<#macro print_tile_side_status widget varname="row" indent=0>
${""?left_pad(indent)}<view class="tile tile-side-status">
${""?left_pad(indent)}  <view class="tile-row">
  <#if guidbase.has_child_widget(widget, "status")>
${""?left_pad(indent)}    <view class="tile-status-col">
${""?left_pad(indent)}      <text class="tile-status">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))} }}</text>
${""?left_pad(indent)}    </view>
  </#if>
${""?left_pad(indent)}    <view class="tile-body">
    <#if guidbase.has_child_widget(widget, "primary")>
${""?left_pad(indent)}      <view class="tile-primary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))} }}</view>
    </#if>
    <#if guidbase.has_child_widget(widget, "secondary")>
${""?left_pad(indent)}      <view class="tile-secondary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "secondary"))} }}</view>
    </#if>
    <#if guidbase.has_child_widget(widget, "start_time")>
${""?left_pad(indent)}      <view class="tile-start-time">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "start_time"))} }}</view>
    </#if>
${""?left_pad(indent)}    </view>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}</view>
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
<#macro print_tile_multi_tag widget varname="row" indent=0>
${""?left_pad(indent)}<view class="tile tile-multi-tag">
${""?left_pad(indent)}  <view class="tile-tags-row">
  <#if guidbase.has_child_widget(widget, "tags")>
${""?left_pad(indent)}    <text class="tile-tags"><text wx:for="{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "tags"))} }}" wx:for-item="tag" wx:for-index="idx" wx:key="idx" class="tile-tag">{{ tag }}</text></text>
  </#if>
${""?left_pad(indent)}  </view>
  <#if guidbase.has_child_widget(widget, "primary")>
${""?left_pad(indent)}  <view class="tile-primary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))} }}</view>
  </#if>
${""?left_pad(indent)}  <view class="tile-row tile-footer">
  <#if guidbase.has_child_widget(widget, "secondary")>
${""?left_pad(indent)}    <text class="tile-secondary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "secondary"))} }}</text>
  </#if>
  <#if guidbase.has_child_widget(widget, "end_time")>
${""?left_pad(indent)}    <text class="tile-end-time">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "end_time"))} }}</text>
  </#if>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}</view>
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
<#macro print_tile_shift_planner widget varname="row" indent=0>
${""?left_pad(indent)}<view class="tile tile-shift-planner">
${""?left_pad(indent)}  <view class="tile-row tile-header">
    <#if guidbase.has_child_widget(widget, "start_time") || guidbase.has_child_widget(widget, "end_time")>
${""?left_pad(indent)}    <text class="tile-time">
      <#if guidbase.has_child_widget(widget, "start_time")><text>{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "start_time"))} }}</text></#if>
      <#if guidbase.has_child_widget(widget, "start_time") && guidbase.has_child_widget(widget, "end_time")> - </#if>
      <#if guidbase.has_child_widget(widget, "end_time")><text>{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "end_time"))} }}</text></#if>
${""?left_pad(indent)}    </text>
    </#if>
  <#if guidbase.has_child_widget(widget, "status")>
${""?left_pad(indent)}    <text class="tile-status">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))} }}</text>
  </#if>
${""?left_pad(indent)}  </view>
  <#if guidbase.has_child_widget(widget, "primary")>
${""?left_pad(indent)}  <view class="tile-primary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))} }}</view>
  </#if>
  <#if guidbase.has_child_widget(widget, "avatars")>
${""?left_pad(indent)}  <view class="tile-avatars-wrap">
${""?left_pad(indent)}    <view class="tile-avatars"><image wx:for="{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "avatars"))} }}" wx:for-item="av" wx:for-index="idx" wx:key="idx" src="{{ av }}" class="tile-avatar-img"></image></view>
  </#if>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}</view>
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
<#macro print_tile_social_post_feed widget varname="row" indent=0>
${""?left_pad(indent)}<view class="tile tile-social-post-feed">
${""?left_pad(indent)}  <view class="tile-row">
  <#if guidbase.has_child_widget(widget, "avatar")>
${""?left_pad(indent)}    <view class="tile-avatar">
${""?left_pad(indent)}      <image src="{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "avatar"))} }}"></image>
${""?left_pad(indent)}    </view>
  </#if>
${""?left_pad(indent)}    <view class="tile-body">
    <#if guidbase.has_child_widget(widget, "primary")>
${""?left_pad(indent)}      <view class="tile-primary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))} }}</view>
    </#if>
    <#if guidbase.has_child_widget(widget, "start_time")>
${""?left_pad(indent)}      <text class="tile-start-time">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "start_time"))} }}</text>
    </#if>
${""?left_pad(indent)}    </view>
${""?left_pad(indent)}  </view>
  <#if guidbase.has_child_widget(widget, "tertiary")>
${""?left_pad(indent)}  <view class="tile-tertiary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "tertiary"))} }}</view>
  </#if>
  <#if guidbase.has_child_widget(widget, "image")>
${""?left_pad(indent)}  <view class="tile-image-wrap">
${""?left_pad(indent)}    <view class="tile-image">
${""?left_pad(indent)}      <image src="{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "image"))} }}"></image>
${""?left_pad(indent)}    </view>
${""?left_pad(indent)}  </view>
  </#if>
${""?left_pad(indent)}  <view class="tile-row tile-footer">
  <#if guidbase.has_child_widget(widget, "avatars")>
${""?left_pad(indent)}    <view class="tile-avatars"><image wx:for="{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "avatars"))} }}" wx:for-item="av" wx:for-index="idx" wx:key="idx" src="{{ av }}" class="tile-avatar-img"></image></view>
  </#if>
  <#if guidbase.has_child_widget(widget, "tags")>
${""?left_pad(indent)}    <text class="tile-tags"><text wx:for="{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "tags"))} }}" wx:for-item="tag" wx:for-index="idx" wx:key="idx" class="tile-tag">{{ tag }}</text></text>
  </#if>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}</view>
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
<#macro print_tile_product widget varname="row" indent=0>
${""?left_pad(indent)}<view class="tile tile-product">
  <#if guidbase.has_child_widget(widget, "image")>
${""?left_pad(indent)}  <view class="tile-image-wrap">
${""?left_pad(indent)}    <view class="tile-image">
${""?left_pad(indent)}      <image src="{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "image"))} }}"></image>
${""?left_pad(indent)}    </view>
${""?left_pad(indent)}  </view>
  </#if>
  <#if guidbase.has_child_widget(widget, "tags")>
${""?left_pad(indent)}  <view class="tile-tags"><text wx:for="{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "tags"))} }}" wx:for-item="tag" wx:for-index="idx" wx:key="idx" class="tile-tag">{{ tag }}</text></view>
  </#if>
  <#if guidbase.has_child_widget(widget, "primary")>
${""?left_pad(indent)}  <view class="tile-primary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))} }}</view>
  </#if>
  <#if guidbase.has_child_widget(widget, "secondary")>
${""?left_pad(indent)}  <view class="tile-secondary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "secondary"))} }}</view>
  </#if>
${""?left_pad(indent)}  <view class="tile-row tile-footer">
  <#if guidbase.has_child_widget(widget, "status")>
${""?left_pad(indent)}    <text class="tile-status">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))} }}</text>
  </#if>
  <#if guidbase.has_child_widget(widget, "end_time")>
${""?left_pad(indent)}    <text class="tile-end-time">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "end_time"))} }}</text>
  </#if>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}</view>
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
<#macro print_tile_dual_profile_comparison widget varname="row" indent=0>
${""?left_pad(indent)}<view class="tile tile-dual-profile-comparison">
${""?left_pad(indent)}  <view class="tile-row tile-header">
  <#if guidbase.has_child_widget(widget, "avatar")>
${""?left_pad(indent)}    <view class="tile-avatar">
${""?left_pad(indent)}      <image src="{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "avatar"))} }}"></image>
${""?left_pad(indent)}    </view>
  </#if>
  <#if guidbase.has_child_widget(widget, "status")>
${""?left_pad(indent)}    <text class="tile-status">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))} }}</text>
  </#if>
  <#if guidbase.has_child_widget(widget, "avatar2")>
${""?left_pad(indent)}    <view class="tile-avatar">
${""?left_pad(indent)}      <image src="{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "avatar2"))} }}"></image>
${""?left_pad(indent)}    </view>
  </#if>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}  <view class="tile-row tile-footer">
  <#if guidbase.has_child_widget(widget, "primary")>
${""?left_pad(indent)}    <text class="tile-primary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))} }}</text>
  </#if>
  <#if guidbase.has_child_widget(widget, "secondary")>
${""?left_pad(indent)}    <text class="tile-secondary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "secondary"))} }}</text>
  </#if>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}  <view class="tile-row">
  <#if guidbase.has_child_widget(widget, "start_time")>
${""?left_pad(indent)}    <text class="tile-start-time">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "start_time"))} }}</text>
  </#if>
  <#if guidbase.has_child_widget(widget, "end_time")>
${""?left_pad(indent)}    <text class="tile-end-time">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "end_time"))} }}</text>
  </#if>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}</view>
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
<#macro print_tile_left_feature_image widget varname="row" indent=0>
${""?left_pad(indent)}<view class="tile tile-left-feature-image">
${""?left_pad(indent)}  <view class="tile-row">
  <#if guidbase.has_child_widget(widget, "image")>
${""?left_pad(indent)}    <view class="tile-image">
${""?left_pad(indent)}      <image src="{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "image"))} }}"></image>
${""?left_pad(indent)}    </view>
  </#if>
${""?left_pad(indent)}    <view class="tile-body">
    <#if guidbase.has_child_widget(widget, "tags")>
${""?left_pad(indent)}      <view class="tile-tags"><text wx:for="{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "tags"))} }}" wx:for-item="tag" wx:for-index="idx" wx:key="idx" class="tile-tag">{{ tag }}</text></view>
    </#if>
    <#if guidbase.has_child_widget(widget, "primary")>
${""?left_pad(indent)}      <view class="tile-primary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))} }}</view>
    </#if>
    <#if guidbase.has_child_widget(widget, "secondary")>
${""?left_pad(indent)}      <view class="tile-secondary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "secondary"))} }}</view>
    </#if>
    <#if guidbase.has_child_widget(widget, "tertiary")>
${""?left_pad(indent)}      <view class="tile-tertiary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "tertiary"))} }}</view>
    </#if>
${""?left_pad(indent)}      <view class="tile-row tile-inline">
    <#if guidbase.has_child_widget(widget, "status")>
${""?left_pad(indent)}        <text class="tile-status">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))} }}</text>
    </#if>
    <#if guidbase.has_child_widget(widget, "avatars")>
${""?left_pad(indent)}        <text class="tile-avatars"><image wx:for="{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "avatars"))} }}" wx:for-item="av" wx:for-index="idx" wx:key="idx" src="{{ av }}" class="tile-avatar-img"></image></text>
    </#if>
${""?left_pad(indent)}      </view>
${""?left_pad(indent)}    </view>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}</view>
</#macro>

<#--
宽版工作流 (Workflow Strip)
+-----------------------------------------------+
| [start time] > [avatars] > [status] > [end time] |
|                                               |
| [primary]                                     |
+-----------------------------------------------+
-->
<#macro print_tile_workflow_strip widget varname="row" indent=0>
${""?left_pad(indent)}<view class="tile tile-workflow-strip">
${""?left_pad(indent)}  <view class="tile-row tile-workflow-chain">
  <#if guidbase.has_child_widget(widget, "start_time")>
${""?left_pad(indent)}    <text class="tile-start-time">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "start_time"))} }}</text>
${""?left_pad(indent)}    <text class="tile-workflow-arrow"> > </text>
  </#if>
  <#if guidbase.has_child_widget(widget, "avatars")>
${""?left_pad(indent)}    <text class="tile-avatars"><image wx:for="{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "avatars"))} }}" wx:for-item="av" wx:for-index="idx" wx:key="idx" src="{{ av }}" class="tile-avatar-img"></image></text>
${""?left_pad(indent)}    <text class="tile-workflow-arrow"> > </text>
  </#if>
  <#if guidbase.has_child_widget(widget, "status")>
${""?left_pad(indent)}    <text class="tile-status">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))} }}</text>
${""?left_pad(indent)}    <text class="tile-workflow-arrow"> > </text>
  </#if>
  <#if guidbase.has_child_widget(widget, "end_time")>
${""?left_pad(indent)}    <text class="tile-end-time">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "end_time"))} }}</text>
  </#if>
${""?left_pad(indent)}  </view>
  <#if guidbase.has_child_widget(widget, "primary")>
${""?left_pad(indent)}  <view class="tile-primary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))} }}</view>
  </#if>
${""?left_pad(indent)}</view>
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
<#macro print_tile_text_over_background widget varname="row" indent=0>
${""?left_pad(indent)}<view class="tile tile-text-over-background">
  <#if guidbase.has_child_widget(widget, "background")>
${""?left_pad(indent)}  <view class="tile-background">
${""?left_pad(indent)}    <image src="{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "background"))} }}"></image>
${""?left_pad(indent)}  </view>
  </#if>
${""?left_pad(indent)}  <view class="tile-overlay">
  <#if guidbase.has_child_widget(widget, "tags")>
${""?left_pad(indent)}    <view class="tile-tags"><text wx:for="{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "tags"))} }}" wx:for-item="tag" wx:for-index="idx" wx:key="idx" class="tile-tag">{{ tag }}</text></view>
  </#if>
  <#if guidbase.has_child_widget(widget, "primary")>
${""?left_pad(indent)}    <view class="tile-primary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))} }}</view>
  </#if>
${""?left_pad(indent)}    <view class="tile-row">
    <#if guidbase.has_child_widget(widget, "avatar")>
${""?left_pad(indent)}      <view class="tile-avatar">
${""?left_pad(indent)}        <image src="{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "avatar"))} }}"></image>
${""?left_pad(indent)}      </view>
    </#if>
    <#if guidbase.has_child_widget(widget, "secondary")>
${""?left_pad(indent)}      <text class="tile-secondary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "secondary"))} }}</text>
    </#if>
${""?left_pad(indent)}    </view>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}</view>
</#macro>

<#--
微型标记 (Micro Badge)
+----------------------------------+
| [avatar]  [primary]     [status] |
+----------------------------------+
-->
<#macro print_tile_micro_badge widget varname="row" indent=0>
${""?left_pad(indent)}<view class="tile tile-micro-badge">
${""?left_pad(indent)}  <view class="tile-row tile-inline">
  <#if guidbase.has_child_widget(widget, "avatar")>
${""?left_pad(indent)}    <view class="tile-avatar">
${""?left_pad(indent)}      <image src="{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "avatar"))} }}"></image>
${""?left_pad(indent)}    </view>
  </#if>
  <#if guidbase.has_child_widget(widget, "primary")>
${""?left_pad(indent)}    <text class="tile-primary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))} }}</text>
  </#if>
  <#if guidbase.has_child_widget(widget, "status")>
${""?left_pad(indent)}    <text class="tile-status">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))} }}</text>
  </#if>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}</view>
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
<#macro print_tile_stepped_process widget varname="row" indent=0>
${""?left_pad(indent)}<view class="tile tile-stepped-process">
${""?left_pad(indent)}  <view class="tile-row">
  <#if guidbase.has_child_widget(widget, "status")>
${""?left_pad(indent)}    <text class="tile-status">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))} }}</text>
  </#if>
${""?left_pad(indent)}    <view class="tile-body">
    <#if guidbase.has_child_widget(widget, "primary")>
${""?left_pad(indent)}      <view class="tile-primary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))} }}</view>
    </#if>
${""?left_pad(indent)}      <view class="tile-step-line">
${""?left_pad(indent)}        <text class="tile-step-branch">├─</text>
    <#if guidbase.has_child_widget(widget, "secondary")>
${""?left_pad(indent)}        <text class="tile-secondary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "secondary"))} }}</text>
    </#if>
${""?left_pad(indent)}      </view>
${""?left_pad(indent)}      <view class="tile-step-line">
${""?left_pad(indent)}        <text class="tile-step-branch">├─</text>
    <#if guidbase.has_child_widget(widget, "start_time") || guidbase.has_child_widget(widget, "end_time")>
    <#if guidbase.has_child_widget(widget, "start_time")><text>{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "start_time"))} }}</text></#if>
    <#if guidbase.has_child_widget(widget, "start_time") && guidbase.has_child_widget(widget, "end_time")> - </#if>
    <#if guidbase.has_child_widget(widget, "end_time")><text>{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "end_time"))} }}</text></#if>
    </#if>
${""?left_pad(indent)}      </view>
${""?left_pad(indent)}    </view>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}</view>
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
<#macro print_tile_stacked_overlay widget varname="row" indent=0>
${""?left_pad(indent)}<view class="tile tile-stacked-overlay">
  <#if guidbase.has_child_widget(widget, "image")>
${""?left_pad(indent)}  <view class="tile-image-wrap">
${""?left_pad(indent)}    <view class="tile-image">
${""?left_pad(indent)}      <image src="{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "image"))} }}"></image>
${""?left_pad(indent)}    </view>
${""?left_pad(indent)}  </view>
  </#if>
${""?left_pad(indent)}  <view class="tile-stacked-card">
    <#if guidbase.has_child_widget(widget, "primary")>
${""?left_pad(indent)}    <view class="tile-primary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))} }}</view>
    </#if>
${""?left_pad(indent)}    <view class="tile-row">
    <#if guidbase.has_child_widget(widget, "secondary")>
${""?left_pad(indent)}      <text class="tile-secondary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "secondary"))} }}</text>
    </#if>
    <#if guidbase.has_child_widget(widget, "status")>
${""?left_pad(indent)}      <text class="tile-status">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))} }}</text>
    </#if>
${""?left_pad(indent)}    </view>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}</view>
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
<#macro print_tile_group_hub widget varname="row" indent=0>
${""?left_pad(indent)}<view class="tile tile-group-hub">
  <#if guidbase.has_child_widget(widget, "avatars")>
${""?left_pad(indent)}  <view class="tile-avatars"><image wx:for="{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "avatars"))} }}" wx:for-item="av" wx:for-index="idx" wx:key="idx" src="{{ av }}" class="tile-avatar-img"></image></view>
  </#if>
  <#if guidbase.has_child_widget(widget, "primary")>
${""?left_pad(indent)}  <view class="tile-primary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))} }}</view>
  </#if>
  <#if guidbase.has_child_widget(widget, "tertiary")>
${""?left_pad(indent)}  <view class="tile-tertiary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "tertiary"))} }}</view>
  </#if>
${""?left_pad(indent)}  <view class="tile-row tile-footer">
  <#if guidbase.has_child_widget(widget, "tags")>
${""?left_pad(indent)}    <text class="tile-tags"><text wx:for="{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "tags"))} }}" wx:for-item="tag" wx:for-index="idx" wx:key="idx" class="tile-tag">{{ tag }}</text></text>
  </#if>
  <#if guidbase.has_child_widget(widget, "status")>
${""?left_pad(indent)}    <text class="tile-status">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))} }}</text>
  </#if>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}</view>
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
<#macro print_tile_tall_sidebar widget varname="row" indent=0>
${""?left_pad(indent)}<view class="tile tile-tall-sidebar">
  <#if guidbase.has_child_widget(widget, "status")>
${""?left_pad(indent)}  <view class="tile-status">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))} }}</view>
  </#if>
  <#if guidbase.has_child_widget(widget, "image")>
${""?left_pad(indent)}  <view class="tile-image-wrap">
${""?left_pad(indent)}    <view class="tile-image">
${""?left_pad(indent)}      <image src="{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "image"))} }}"></image>
${""?left_pad(indent)}    </view>
${""?left_pad(indent)}  </view>
  </#if>
  <#if guidbase.has_child_widget(widget, "primary")>
${""?left_pad(indent)}  <view class="tile-primary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))} }}</view>
  </#if>
  <#if guidbase.has_child_widget(widget, "secondary")>
${""?left_pad(indent)}  <view class="tile-secondary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "secondary"))} }}</view>
  </#if>
  <#if guidbase.has_child_widget(widget, "tags")>
${""?left_pad(indent)}  <view class="tile-tags"><text wx:for="{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "tags"))} }}" wx:for-item="tag" wx:for-index="idx" wx:key="idx" class="tile-tag">{{ tag }}</text></view>
  </#if>
  <#if guidbase.has_child_widget(widget, "avatars")>
${""?left_pad(indent)}  <view class="tile-avatars"><image wx:for="{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "avatars"))} }}" wx:for-item="av" wx:for-index="idx" wx:key="idx" src="{{ av }}" class="tile-avatar-img"></image></view>
  </#if>
${""?left_pad(indent)}</view>
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
<#macro print_tile_justified_meta widget varname="row" indent=0>
${""?left_pad(indent)}<view class="tile tile-justified-meta">
${""?left_pad(indent)}  <view class="tile-row tile-justified">
  <#if guidbase.has_child_widget(widget, "primary")>
${""?left_pad(indent)}    <text class="tile-primary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))} }}</text>
  </#if>
  <#if guidbase.has_child_widget(widget, "start_time")>
${""?left_pad(indent)}    <text class="tile-start-time">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "start_time"))} }}</text>
  </#if>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}  <view class="tile-row tile-justified">
  <#if guidbase.has_child_widget(widget, "secondary")>
${""?left_pad(indent)}    <text class="tile-secondary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "secondary"))} }}</text>
  </#if>
  <#if guidbase.has_child_widget(widget, "end_time")>
${""?left_pad(indent)}    <text class="tile-end-time">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "end_time"))} }}</text>
  </#if>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}  <view class="tile-row tile-justified">
  <#if guidbase.has_child_widget(widget, "avatar")>
${""?left_pad(indent)}    <view class="tile-avatar">
${""?left_pad(indent)}      <image src="{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "avatar"))} }}"></image>
${""?left_pad(indent)}    </view>
  </#if>
  <#if guidbase.has_child_widget(widget, "status")>
${""?left_pad(indent)}    <text class="tile-status">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))} }}</text>
  </#if>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}</view>
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
<#macro print_tile_multidimensional_board widget varname="row" indent=0>
${""?left_pad(indent)}<view class="tile tile-multidimensional-board">
${""?left_pad(indent)}  <view class="tile-row tile-header">
  <#if guidbase.has_child_widget(widget, "status")>
${""?left_pad(indent)}    <text class="tile-status">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))} }}</text>
  </#if>
  <#if guidbase.has_child_widget(widget, "start_time")>
${""?left_pad(indent)}    <text class="tile-start-time">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "start_time"))} }}</text>
  </#if>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}  <view class="tile-row tile-cols">
${""?left_pad(indent)}    <view class="tile-col">
    <#if guidbase.has_child_widget(widget, "primary")>
${""?left_pad(indent)}      <view class="tile-primary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))} }}</view>
    </#if>
    <#if guidbase.has_child_widget(widget, "tertiary")>
${""?left_pad(indent)}      <view class="tile-tertiary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "tertiary"))} }}</view>
    </#if>
${""?left_pad(indent)}    </view>
${""?left_pad(indent)}    <view class="tile-col">
    <#if guidbase.has_child_widget(widget, "secondary")>
${""?left_pad(indent)}      <view class="tile-secondary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "secondary"))} }}</view>
    </#if>
    <#if guidbase.has_child_widget(widget, "tags")>
${""?left_pad(indent)}      <view class="tile-tags"><text wx:for="{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "tags"))} }}" wx:for-item="tag" wx:for-index="idx" wx:key="idx" class="tile-tag">{{ tag }}</text></view>
    </#if>
${""?left_pad(indent)}    </view>
${""?left_pad(indent)}  </view>
  <#if guidbase.has_child_widget(widget, "avatars")>
${""?left_pad(indent)}  <view class="tile-avatars"><image wx:for="{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "avatars"))} }}" wx:for-item="av" wx:for-index="idx" wx:key="idx" src="{{ av }}" class="tile-avatar-img"></image></view>
  </#if>
${""?left_pad(indent)}</view>
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
<#macro print_tile_media_player widget varname="row" indent=0>
${""?left_pad(indent)}<view class="tile tile-media-player">
${""?left_pad(indent)}  <view class="tile-row">
  <#if guidbase.has_child_widget(widget, "image")>
${""?left_pad(indent)}    <view class="tile-image">
${""?left_pad(indent)}      <image src="{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "image"))} }}"></image>
${""?left_pad(indent)}    </view>
  </#if>
${""?left_pad(indent)}    <view class="tile-body">
    <#if guidbase.has_child_widget(widget, "primary")>
${""?left_pad(indent)}      <view class="tile-primary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))} }}</view>
    </#if>
    <#if guidbase.has_child_widget(widget, "secondary")>
${""?left_pad(indent)}      <view class="tile-secondary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "secondary"))} }}</view>
    </#if>
    <#if guidbase.has_child_widget(widget, "start_time") || guidbase.has_child_widget(widget, "end_time")>
${""?left_pad(indent)}      <view class="tile-progress">
      <#if guidbase.has_child_widget(widget, "start_time")><text>{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "start_time"))} }}</text></#if>
${""?left_pad(indent)}      <text class="tile-progress-bar">──────────</text>
      <#if guidbase.has_child_widget(widget, "end_time")><text>{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "end_time"))} }}</text></#if>
${""?left_pad(indent)}      </view>
    </#if>
${""?left_pad(indent)}    </view>
${""?left_pad(indent)}  </view>
  <#if guidbase.has_child_widget(widget, "avatar") || guidbase.has_child_widget(widget, "status")>
${""?left_pad(indent)}  <view class="tile-row tile-footer">
  <#if guidbase.has_child_widget(widget, "avatar")>
${""?left_pad(indent)}    <view class="tile-avatar">
${""?left_pad(indent)}      <image src="{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "avatar"))} }}"></image>
${""?left_pad(indent)}    </view>
  </#if>
  <#if guidbase.has_child_widget(widget, "status")>
${""?left_pad(indent)}    <text class="tile-status">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))} }}</text>
  </#if>
${""?left_pad(indent)}  </view>
  </#if>
${""?left_pad(indent)}</view>
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
<#macro print_tile_left_anchor_time widget varname="row" indent=0>
${""?left_pad(indent)}<view class="tile tile-left-anchor-time">
${""?left_pad(indent)}  <view class="tile-row tile-header">
  <#if guidbase.has_child_widget(widget, "start_time")>
${""?left_pad(indent)}    <text class="tile-start-time">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "start_time"))} }}</text>
  </#if>
  <#if guidbase.has_child_widget(widget, "status")>
${""?left_pad(indent)}    <text class="tile-status">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))} }}</text>
  </#if>
${""?left_pad(indent)}  </view>
  <#if guidbase.has_child_widget(widget, "primary")>
${""?left_pad(indent)}  <view class="tile-primary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))} }}</view>
  </#if>
  <#if guidbase.has_child_widget(widget, "secondary")>
${""?left_pad(indent)}  <view class="tile-secondary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "secondary"))} }}</view>
  </#if>
  <#if guidbase.has_child_widget(widget, "avatar")>
${""?left_pad(indent)}  <view class="tile-avatar">
${""?left_pad(indent)}    <image src="{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "avatar"))} }}"></image>
${""?left_pad(indent)}  </view>
  </#if>
${""?left_pad(indent)}</view>
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
<#macro print_tile_duration_span widget varname="row" indent=0>
${""?left_pad(indent)}<view class="tile tile-duration-span">
${""?left_pad(indent)}  <view class="tile-row tile-header">
  <#if guidbase.has_child_widget(widget, "start_time") || guidbase.has_child_widget(widget, "end_time")>
${""?left_pad(indent)}    <text class="tile-time">
    <#if guidbase.has_child_widget(widget, "start_time")><text>{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "start_time"))} }}</text></#if>
    <#if guidbase.has_child_widget(widget, "start_time") && guidbase.has_child_widget(widget, "end_time")> - </#if>
    <#if guidbase.has_child_widget(widget, "end_time")><text>{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "end_time"))} }}</text></#if>
${""?left_pad(indent)}    </text>
  </#if>
  <#if guidbase.has_child_widget(widget, "status")>
${""?left_pad(indent)}    <text class="tile-status">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))} }}</text>
  </#if>
${""?left_pad(indent)}  </view>
  <#if guidbase.has_child_widget(widget, "primary")>
${""?left_pad(indent)}  <view class="tile-primary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))} }}</view>
  </#if>
  <#if guidbase.has_child_widget(widget, "avatars")>
${""?left_pad(indent)}  <view class="tile-avatars"><image wx:for="{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "avatars"))} }}" wx:for-item="av" wx:for-index="idx" wx:key="idx" src="{{ av }}" class="tile-avatar-img"></image></view>
  </#if>
${""?left_pad(indent)}</view>
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
<#macro print_tile_media_history widget varname="row" indent=0>
${""?left_pad(indent)}<view class="tile tile-media-history">
  <#if guidbase.has_child_widget(widget, "start_time")>
${""?left_pad(indent)}  <view class="tile-start-time">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "start_time"))} }}</view>
  </#if>
${""?left_pad(indent)}  <view class="tile-row">
  <#if guidbase.has_child_widget(widget, "image")>
${""?left_pad(indent)}    <view class="tile-image">
${""?left_pad(indent)}      <image src="{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "image"))} }}"></image>
${""?left_pad(indent)}    </view>
  </#if>
${""?left_pad(indent)}    <view class="tile-body">
    <#if guidbase.has_child_widget(widget, "primary")>
${""?left_pad(indent)}      <view class="tile-primary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))} }}</view>
    </#if>
    <#if guidbase.has_child_widget(widget, "secondary")>
${""?left_pad(indent)}      <view class="tile-secondary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "secondary"))} }}</view>
    </#if>
    <#if guidbase.has_child_widget(widget, "tags")>
${""?left_pad(indent)}      <view class="tile-tags"><text wx:for="{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "tags"))} }}" wx:for-item="tag" wx:for-index="idx" wx:key="idx" class="tile-tag">{{ tag }}</text></view>
    </#if>
${""?left_pad(indent)}    </view>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}</view>
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
<#macro print_tile_status_transition widget varname="row" indent=0>
${""?left_pad(indent)}<view class="tile tile-status-transition">
${""?left_pad(indent)}  <view class="tile-row tile-header">
  <#if guidbase.has_child_widget(widget, "start_time")>
${""?left_pad(indent)}    <text class="tile-start-time">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "start_time"))} }}</text>
  </#if>
  <#if guidbase.has_child_widget(widget, "status")>
${""?left_pad(indent)}    <text class="tile-status">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))} }}</text>
  </#if>
${""?left_pad(indent)}  </view>
  <#if guidbase.has_child_widget(widget, "primary")>
${""?left_pad(indent)}  <view class="tile-primary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))} }}</view>
  </#if>
${""?left_pad(indent)}  <view class="tile-row">
  <#if guidbase.has_child_widget(widget, "avatar")>
${""?left_pad(indent)}    <view class="tile-avatar">
${""?left_pad(indent)}      <image src="{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "avatar"))} }}"></image>
${""?left_pad(indent)}    </view>
  </#if>
  <#if guidbase.has_child_widget(widget, "secondary")>
${""?left_pad(indent)}    <text class="tile-secondary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "secondary"))} }}</text>
  </#if>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}</view>
</#macro>

<#--
极简时间单元 (Compact Time Tile)
+-----------------------------------------------+
| [start time]  |  [status]  |  [primary]       |
| [tags]                                        |
+-----------------------------------------------+
-->
<#macro print_tile_compact_time widget varname="row" indent=0>
${""?left_pad(indent)}<view class="tile tile-compact-time">
${""?left_pad(indent)}  <view class="tile-row tile-inline">
  <#if guidbase.has_child_widget(widget, "start_time")>
${""?left_pad(indent)}    <text class="tile-start-time">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "start_time"))} }}</text>
${""?left_pad(indent)}    <text class="tile-sep">|</text>
  </#if>
  <#if guidbase.has_child_widget(widget, "status")>
${""?left_pad(indent)}    <text class="tile-status">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))} }}</text>
${""?left_pad(indent)}    <text class="tile-sep">|</text>
  </#if>
  <#if guidbase.has_child_widget(widget, "primary")>
${""?left_pad(indent)}    <text class="tile-primary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))} }}</text>
  </#if>
${""?left_pad(indent)}  </view>
  <#if guidbase.has_child_widget(widget, "tags")>
${""?left_pad(indent)}  <view class="tile-tags"><text wx:for="{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "tags"))} }}" wx:for-item="tag" wx:for-index="idx" wx:key="idx" class="tile-tag">{{ tag }}</text></view>
  </#if>
${""?left_pad(indent)}</view>
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
<#macro print_tile_horizontal_flow widget varname="row" indent=0>
${""?left_pad(indent)}<view class="tile tile-horizontal-flow">
  <#if guidbase.has_child_widget(widget, "start_time")>
${""?left_pad(indent)}  <view class="tile-start-time">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "start_time"))} }}</view>
  </#if>
  <#if guidbase.has_child_widget(widget, "primary")>
${""?left_pad(indent)}  <view class="tile-primary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))} }}</view>
  </#if>
  <#if guidbase.has_child_widget(widget, "status")>
${""?left_pad(indent)}  <text class="tile-status">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))} }}</text>
  </#if>
${""?left_pad(indent)}</view>
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
<#macro print_tile_right_biased_node widget varname="row" indent=0>
${""?left_pad(indent)}<view class="tile tile-right-biased-node">
${""?left_pad(indent)}  <view class="tile-row tile-header tile-right">
  <#if guidbase.has_child_widget(widget, "start_time")>
${""?left_pad(indent)}    <text class="tile-start-time">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "start_time"))} }}</text>
  </#if>
${""?left_pad(indent)}  </view>
  <#if guidbase.has_child_widget(widget, "primary")>
${""?left_pad(indent)}  <view class="tile-primary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))} }}</view>
  </#if>
  <#if guidbase.has_child_widget(widget, "tags")>
${""?left_pad(indent)}  <view class="tile-tags"><text wx:for="{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "tags"))} }}" wx:for-item="tag" wx:for-index="idx" wx:key="idx" class="tile-tag">{{ tag }}</text></view>
  </#if>
${""?left_pad(indent)}</view>
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
<#macro print_tile_left_biased_node widget varname="row" indent=0>
${""?left_pad(indent)}<view class="tile tile-left-biased-node">
${""?left_pad(indent)}  <view class="tile-row tile-header tile-left">
  <#if guidbase.has_child_widget(widget, "start_time")>
${""?left_pad(indent)}    <text class="tile-start-time">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "start_time"))} }}</text>
  </#if>
${""?left_pad(indent)}  </view>
  <#if guidbase.has_child_widget(widget, "primary")>
${""?left_pad(indent)}  <view class="tile-primary tile-right">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))} }}</view>
  </#if>
  <#if guidbase.has_child_widget(widget, "tags")>
${""?left_pad(indent)}  <view class="tile-tags tile-right"><text wx:for="{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "tags"))} }}" wx:for-item="tag" wx:for-index="idx" wx:key="idx" class="tile-tag">{{ tag }}</text></view>
  </#if>
${""?left_pad(indent)}</view>
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
<#macro print_tile_internal_chronology widget varname="row" indent=0>
${""?left_pad(indent)}<view class="tile tile-internal-chronology">
  <#if guidbase.has_child_widget(widget, "start_time")>
${""?left_pad(indent)}  <view class="tile-start-time">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "start_time"))} }}</view>
  </#if>
  <#if guidbase.has_child_widget(widget, "primary")>
${""?left_pad(indent)}  <view class="tile-primary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))} }}</view>
  </#if>
${""?left_pad(indent)}  <view class="tile-timeline-line">
${""?left_pad(indent)}    <text class="tile-timeline-indent">│</text>
  </view>
  <#if guidbase.has_child_widget(widget, "end_time")>
${""?left_pad(indent)}  <view class="tile-end-time">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "end_time"))} }}</view>
  </#if>
${""?left_pad(indent)}  <view class="tile-row">
  <#if guidbase.has_child_widget(widget, "secondary")>
${""?left_pad(indent)}    <text class="tile-secondary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "secondary"))} }}</text>
  </#if>
  <#if guidbase.has_child_widget(widget, "status")>
${""?left_pad(indent)}    <text class="tile-status">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))} }}</text>
  </#if>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}</view>
</#macro>

<#--
三段分步 (Three-Stage Segment)
+-----------------------------------------------+
| [start time]     >> [tags]       >> [end time] |
|                                               |
| [primary]        >> [secondary]  >> [status]   |
+-----------------------------------------------+
-->
<#macro print_tile_three_stage_segment widget varname="row" indent=0>
${""?left_pad(indent)}<view class="tile tile-three-stage-segment">
${""?left_pad(indent)}  <view class="tile-row tile-three-stage">
  <#if guidbase.has_child_widget(widget, "start_time")>
${""?left_pad(indent)}    <text class="tile-start-time">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "start_time"))} }}</text>
${""?left_pad(indent)}    <text class="tile-stage-arrow">>></text>
  </#if>
  <#if guidbase.has_child_widget(widget, "tags")>
${""?left_pad(indent)}    <text class="tile-tags"><text wx:for="{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "tags"))} }}" wx:for-item="tag" wx:for-index="idx" wx:key="idx" class="tile-tag">{{ tag }}</text></text>
${""?left_pad(indent)}    <text class="tile-stage-arrow">>></text>
  </#if>
  <#if guidbase.has_child_widget(widget, "end_time")>
${""?left_pad(indent)}    <text class="tile-end-time">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "end_time"))} }}</text>
  </#if>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}  <view class="tile-row tile-three-stage">
  <#if guidbase.has_child_widget(widget, "primary")>
${""?left_pad(indent)}    <text class="tile-primary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))} }}</text>
${""?left_pad(indent)}    <text class="tile-stage-arrow">>></text>
  </#if>
  <#if guidbase.has_child_widget(widget, "secondary")>
${""?left_pad(indent)}    <text class="tile-secondary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "secondary"))} }}</text>
${""?left_pad(indent)}    <text class="tile-stage-arrow">>></text>
  </#if>
  <#if guidbase.has_child_widget(widget, "status")>
${""?left_pad(indent)}    <text class="tile-status">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))} }}</text>
  </#if>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}</view>
</#macro>

<#--
行式日志 (Horizontal Log)
+-----------------------------------------------+
| [avatar] | [start time] | [primary] | [status] |
+-----------------------------------------------+
-->
<#macro print_tile_horizontal_log widget varname="row" indent=0>
${""?left_pad(indent)}<view class="tile tile-horizontal-log">
${""?left_pad(indent)}  <view class="tile-row tile-inline">
  <#if guidbase.has_child_widget(widget, "avatar")>
${""?left_pad(indent)}    <view class="tile-avatar">
${""?left_pad(indent)}      <image src="{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "avatar"))} }}"></image>
${""?left_pad(indent)}    </view>
${""?left_pad(indent)}    <text class="tile-sep">|</text>
  </#if>
  <#if guidbase.has_child_widget(widget, "start_time")>
${""?left_pad(indent)}    <text class="tile-start-time">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "start_time"))} }}</text>
${""?left_pad(indent)}    <text class="tile-sep">|</text>
  </#if>
  <#if guidbase.has_child_widget(widget, "primary")>
${""?left_pad(indent)}    <text class="tile-primary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))} }}</text>
${""?left_pad(indent)}    <text class="tile-sep">|</text>
  </#if>
  <#if guidbase.has_child_widget(widget, "status")>
${""?left_pad(indent)}    <text class="tile-status">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))} }}</text>
  </#if>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}</view>
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
<#macro print_tile_bulletin widget varname="row" indent=0>
${""?left_pad(indent)}<view class="tile tile-bulletin">
  <#if guidbase.has_child_widget(widget, "tags")>
${""?left_pad(indent)}  <view class="tile-tags"><text wx:for="{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "tags"))} }}" wx:for-item="tag" wx:for-index="idx" wx:key="idx" class="tile-tag">{{ tag }}</text></view>
  </#if>
  <#if guidbase.has_child_widget(widget, "primary")>
${""?left_pad(indent)}  <view class="tile-primary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))} }}</view>
  </#if>
  <#if guidbase.has_child_widget(widget, "tertiary")>
${""?left_pad(indent)}  <view class="tile-tertiary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "tertiary"))} }}</view>
  </#if>
${""?left_pad(indent)}  <view class="tile-row tile-footer">
  <#if guidbase.has_child_widget(widget, "avatars")>
${""?left_pad(indent)}    <view class="tile-avatars"><image wx:for="{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "avatars"))} }}" wx:for-item="av" wx:for-index="idx" wx:key="idx" src="{{ av }}" class="tile-avatar-img"></image></view>
  </#if>
  <#if guidbase.has_child_widget(widget, "start_time")>
${""?left_pad(indent)}    <text class="tile-start-time">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "start_time"))} }}</text>
  </#if>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}</view>
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
<#macro print_tile_timestamp_stamp widget varname="row" indent=0>
${""?left_pad(indent)}<view class="tile tile-timestamp-stamp">
  <#if guidbase.has_child_widget(widget, "background")>
${""?left_pad(indent)}  <view class="tile-background">
${""?left_pad(indent)}    <image src="{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "background"))} }}"></image>
${""?left_pad(indent)}  </view>
  </#if>
${""?left_pad(indent)}  <view class="tile-overlay">
  <#if guidbase.has_child_widget(widget, "start_time")>
${""?left_pad(indent)}    <view class="tile-start-time tile-right">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "start_time"))} }}</view>
  </#if>
  <#if guidbase.has_child_widget(widget, "primary")>
${""?left_pad(indent)}    <view class="tile-primary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))} }}</view>
  </#if>
  <#if guidbase.has_child_widget(widget, "status")>
${""?left_pad(indent)}    <text class="tile-status">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))} }}</text>
  </#if>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}</view>
</#macro>

<#--
精简对话 (Compact Chat)
+-----------------------------------------------+
| +--------+  [primary]            [start time] |
| | avatar |  [secondary]                       |
| +--------+                                    |
+-----------------------------------------------+
-->
<#macro print_tile_compact_chat widget varname="row" indent=0>
${""?left_pad(indent)}<view class="tile tile-compact-chat">
${""?left_pad(indent)}  <view class="tile-row">
  <#if guidbase.has_child_widget(widget, "avatar")>
${""?left_pad(indent)}    <view class="tile-avatar">
${""?left_pad(indent)}      <image src="{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "avatar"))} }}"></image>
${""?left_pad(indent)}    </view>
  </#if>
${""?left_pad(indent)}    <view class="tile-body">
${""?left_pad(indent)}      <view class="tile-row tile-header">
    <#if guidbase.has_child_widget(widget, "primary")>
${""?left_pad(indent)}        <text class="tile-primary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))} }}</text>
    </#if>
    <#if guidbase.has_child_widget(widget, "start_time")>
${""?left_pad(indent)}        <text class="tile-start-time">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "start_time"))} }}</text>
    </#if>
${""?left_pad(indent)}      </view>
    <#if guidbase.has_child_widget(widget, "secondary")>
${""?left_pad(indent)}      <view class="tile-secondary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "secondary"))} }}</view>
    </#if>
${""?left_pad(indent)}    </view>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}</view>
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
<#macro print_tile_side_image_time_capsule widget varname="row" indent=0>
${""?left_pad(indent)}<view class="tile tile-side-image-time-capsule">
  <#if guidbase.has_child_widget(widget, "start_time")>
${""?left_pad(indent)}  <view class="tile-start-time">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "start_time"))} }}</view>
  </#if>
${""?left_pad(indent)}  <view class="tile-row tile-cols">
${""?left_pad(indent)}    <view class="tile-col">
    <#if guidbase.has_child_widget(widget, "primary")>
${""?left_pad(indent)}      <view class="tile-primary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))} }}</view>
    </#if>
    <#if guidbase.has_child_widget(widget, "secondary")>
${""?left_pad(indent)}      <view class="tile-secondary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "secondary"))} }}</view>
    </#if>
${""?left_pad(indent)}    </view>
${""?left_pad(indent)}    <view class="tile-col">
    <#if guidbase.has_child_widget(widget, "image")>
${""?left_pad(indent)}      <view class="tile-image">
${""?left_pad(indent)}        <image src="{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "image"))} }}"></image>
${""?left_pad(indent)}      </view>
    </#if>
${""?left_pad(indent)}    </view>
${""?left_pad(indent)}  </view>
  <#if guidbase.has_child_widget(widget, "status")>
${""?left_pad(indent)}  <view class="tile-row tile-right">
${""?left_pad(indent)}    <text class="tile-status">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))} }}</text>
${""?left_pad(indent)}  </view>
  </#if>
${""?left_pad(indent)}</view>
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
<#macro print_tile_multi_tag_end_node widget varname="row" indent=0>
${""?left_pad(indent)}<view class="tile tile-multi-tag-end-node">
${""?left_pad(indent)}  <view class="tile-row tile-header">
  <#if guidbase.has_child_widget(widget, "tags")>
${""?left_pad(indent)}    <text class="tile-tags"><text wx:for="{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "tags"))} }}" wx:for-item="tag" wx:for-index="idx" wx:key="idx" class="tile-tag">{{ tag }}</text></text>
  </#if>
  <#if guidbase.has_child_widget(widget, "end_time")>
${""?left_pad(indent)}    <text class="tile-end-time">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "end_time"))} }}</text>
  </#if>
${""?left_pad(indent)}  </view>
  <#if guidbase.has_child_widget(widget, "primary")>
${""?left_pad(indent)}  <view class="tile-primary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))} }}</view>
  </#if>
${""?left_pad(indent)}  <view class="tile-row tile-footer">
  <#if guidbase.has_child_widget(widget, "avatars")>
${""?left_pad(indent)}    <view class="tile-avatars"><image wx:for="{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "avatars"))} }}" wx:for-item="av" wx:for-index="idx" wx:key="idx" src="{{ av }}" class="tile-avatar-img"></image></view>
  </#if>
  <#if guidbase.has_child_widget(widget, "status")>
${""?left_pad(indent)}    <text class="tile-status">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))} }}</text>
  </#if>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}</view>
</#macro>

<#--
58. kpi_dashboard (KPI 仪表盘)
+-----------------------------------------------+
| [start_time]                         [status] |
|                                               |
| [primary]                                     |
| [secondary]                                   |
|                                               |
| [tags]                                        |
+-----------------------------------------------+
-->
<#macro print_tile_kpi_dashboard widget varname="row" indent=0>
${""?left_pad(indent)}<view class="tile tile-kpi-dashboard layout-timeline">
${""?left_pad(indent)}  <view class="tile-row tile-header">
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "start_time")><text class="tile-start-time">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "start_time"))} }}</text></#if>
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "status")><text class="tile-status">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))} }}</text></#if>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}  <view class="tile-body">
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "primary")><view class="tile-primary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))} }}</view></#if>
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "secondary")><view class="tile-secondary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "secondary"))} }}</view></#if>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}  <#if guidbase.has_child_widget(widget, "tags")>
${""?left_pad(indent)}  <view class="tile-footer">
${""?left_pad(indent)}    <view class="tile-tags"><text wx:for="{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "tags"))} }}" wx:for-item="tag" wx:key="*this" class="tile-tag">{{ tag }}</text></view>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}  </#if>
${""?left_pad(indent)}</view>
</#macro>

<#--
59. stat_comparison (统计对比)
+-----------------------------------------------+
|                                      [status] |
| [primary]                                     |
| [secondary]                                   |
| [tertiary]                                    |
|                                               |
| [avatars]                                     |
+-----------------------------------------------+
-->
<#macro print_tile_stat_comparison widget varname="row" indent=0>
${""?left_pad(indent)}<view class="tile tile-stat-comparison layout-profile">
${""?left_pad(indent)}  <view class="tile-row tile-header">
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "status")><text class="tile-status">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))} }}</text></#if>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}  <view class="tile-body">
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "primary")><view class="tile-primary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))} }}</view></#if>
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "secondary")><view class="tile-secondary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "secondary"))} }}</view></#if>
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "tertiary")><view class="tile-tertiary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "tertiary"))} }}</view></#if>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}  <#if guidbase.has_child_widget(widget, "avatars")>
${""?left_pad(indent)}  <view class="tile-footer">
${""?left_pad(indent)}    <view class="tile-avatars"><image wx:for="{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "avatars"))} }}" wx:for-item="av" wx:key="*this" src="{{ av }}" class="tile-avatar-img"></image></view>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}  </#if>
${""?left_pad(indent)}</view>
</#macro>

<#--
60. progress_meter (进度表)
+-----------------------------------------------+
| [start_time]                       [end_time] |
|                                               |
| [primary]                                     |
| [status]                                      |
|                                               |
| [tags]                                        |
+-----------------------------------------------+
-->
<#macro print_tile_progress_meter widget varname="row" indent=0>
${""?left_pad(indent)}<view class="tile tile-progress-meter layout-timeline">
${""?left_pad(indent)}  <view class="tile-row tile-header">
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "start_time")><text class="tile-start-time">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "start_time"))} }}</text></#if>
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "end_time")><text class="tile-end-time">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "end_time"))} }}</text></#if>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}  <view class="tile-body">
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "primary")><view class="tile-primary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))} }}</view></#if>
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "status")><view class="tile-status">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))} }}</view></#if>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}  <#if guidbase.has_child_widget(widget, "tags")>
${""?left_pad(indent)}  <view class="tile-footer">
${""?left_pad(indent)}    <view class="tile-tags"><text wx:for="{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "tags"))} }}" wx:for-item="tag" wx:key="*this" class="tile-tag">{{ tag }}</text></view>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}  </#if>
${""?left_pad(indent)}</view>
</#macro>

<#--
61. ranking_row (排名行)
+-----------------------------------------------+
| [avatars]  [primary]                 [status] |
|            [secondary]                        |
+-----------------------------------------------+
-->
<#macro print_tile_ranking_row widget varname="row" indent=0>
${""?left_pad(indent)}<view class="tile tile-ranking-row layout-profile">
${""?left_pad(indent)}  <view class="tile-row">
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "avatars")>
${""?left_pad(indent)}    <view class="tile-avatars"><image wx:for="{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "avatars"))} }}" wx:for-item="av" wx:key="*this" src="{{ av }}" class="tile-avatar-img"></image></view>
${""?left_pad(indent)}    </#if>
${""?left_pad(indent)}    <view class="tile-body">
${""?left_pad(indent)}      <#if guidbase.has_child_widget(widget, "primary")><view class="tile-primary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))} }}</view></#if>
${""?left_pad(indent)}      <#if guidbase.has_child_widget(widget, "secondary")><view class="tile-secondary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "secondary"))} }}</view></#if>
${""?left_pad(indent)}    </view>
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "status")><text class="tile-status">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))} }}</text></#if>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}</view>
</#macro>

<#--
62. leaderboard (排行榜)
+-----------------------------------------------+
| [tags]                                        |
|                                               |
| [primary]                                     |
| [secondary]                                   |
| [tertiary]                                    |
|                                               |
| [avatars]                                     |
+-----------------------------------------------+
-->
<#macro print_tile_leaderboard widget varname="row" indent=0>
${""?left_pad(indent)}<view class="tile tile-leaderboard layout-profile">
${""?left_pad(indent)}  <view class="tile-row tile-header">
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "tags")>
${""?left_pad(indent)}    <view class="tile-tags"><text wx:for="{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "tags"))} }}" wx:for-item="tag" wx:key="*this" class="tile-tag">{{ tag }}</text></view>
${""?left_pad(indent)}    </#if>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}  <view class="tile-body">
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "primary")><view class="tile-primary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))} }}</view></#if>
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "secondary")><view class="tile-secondary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "secondary"))} }}</view></#if>
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "tertiary")><view class="tile-tertiary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "tertiary"))} }}</view></#if>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}  <#if guidbase.has_child_widget(widget, "avatars")>
${""?left_pad(indent)}  <view class="tile-footer">
${""?left_pad(indent)}    <view class="tile-avatars"><image wx:for="{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "avatars"))} }}" wx:for-item="av" wx:key="*this" src="{{ av }}" class="tile-avatar-img"></image></view>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}  </#if>
${""?left_pad(indent)}</view>
</#macro>

<#--
63. price_plan (价格方案)
+-----------------------------------------------+
| +-------------------------------------------+ |
| |                  [image]                  | |
| +-------------------------------------------+ |
| [primary]                                     |
| [secondary]                                   |
|                                               |
| [tags]                               [status] |
+-----------------------------------------------+
-->
<#macro print_tile_price_plan widget varname="row" indent=0>
${""?left_pad(indent)}<view class="tile tile-price-plan layout-media">
${""?left_pad(indent)}  <#if guidbase.has_child_widget(widget, "image")>
${""?left_pad(indent)}  <view class="tile-image"><image src="{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "image"))} }}"></image></view>
${""?left_pad(indent)}  </#if>
${""?left_pad(indent)}  <view class="tile-body">
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "primary")><view class="tile-primary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))} }}</view></#if>
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "secondary")><view class="tile-secondary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "secondary"))} }}</view></#if>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}  <view class="tile-footer">
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "tags")>
${""?left_pad(indent)}    <view class="tile-tags"><text wx:for="{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "tags"))} }}" wx:for-item="tag" wx:key="*this" class="tile-tag">{{ tag }}</text></view>
${""?left_pad(indent)}    </#if>
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "status")><text class="tile-status">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))} }}</text></#if>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}</view>
</#macro>

<#--
64. checkout_summary (结账摘要)
+-----------------------------------------------+
| +-------------------------------------------+ |
| |                  [image]                  | |
| +-------------------------------------------+ |
| [primary]                                     |
| [secondary]                                   |
|                                               |
| [status]                           [end_time] |
+-----------------------------------------------+
-->
<#macro print_tile_checkout_summary widget varname="row" indent=0>
${""?left_pad(indent)}<view class="tile tile-checkout-summary layout-media">
${""?left_pad(indent)}  <#if guidbase.has_child_widget(widget, "image")>
${""?left_pad(indent)}  <view class="tile-image"><image src="{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "image"))} }}"></image></view>
${""?left_pad(indent)}  </#if>
${""?left_pad(indent)}  <view class="tile-body">
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "primary")><view class="tile-primary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))} }}</view></#if>
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "secondary")><view class="tile-secondary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "secondary"))} }}</view></#if>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}  <view class="tile-footer">
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "status")><text class="tile-status">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))} }}</text></#if>
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "end_time")><text class="tile-end-time">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "end_time"))} }}</text></#if>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}</view>
</#macro>

<#--
65. order_tracking (订单追踪)
+-----------------------------------------------+
| [status]                                      |
|                                               |
| [primary]                                     |
| [secondary]                                   |
|                                               |
| [start_time]                       [end_time] |
+-----------------------------------------------+
-->
<#macro print_tile_order_tracking widget varname="row" indent=0>
${""?left_pad(indent)}<view class="tile tile-order-tracking layout-timeline">
${""?left_pad(indent)}  <view class="tile-row tile-header">
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "status")><text class="tile-status">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))} }}</text></#if>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}  <view class="tile-body">
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "primary")><view class="tile-primary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))} }}</view></#if>
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "secondary")><view class="tile-secondary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "secondary"))} }}</view></#if>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}  <view class="tile-footer">
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "start_time")><text class="tile-start-time">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "start_time"))} }}</text></#if>
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "end_time")><text class="tile-end-time">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "end_time"))} }}</text></#if>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}</view>
</#macro>

<#--
66. shipping_event (配送事件)
+-----------------------------------------------+
| +-------+  [primary]                          |
| |avatar |  [secondary]                        |
| +-------+                                     |
| [start_time]                         [status] |
+-----------------------------------------------+
-->
<#macro print_tile_shipping_event widget varname="row" indent=0>
${""?left_pad(indent)}<view class="tile tile-shipping-event layout-timeline">
${""?left_pad(indent)}  <view class="tile-row">
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "avatar")><view class="tile-avatar"><image src="{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "avatar"))} }}"></image></view></#if>
${""?left_pad(indent)}    <view class="tile-body">
${""?left_pad(indent)}      <#if guidbase.has_child_widget(widget, "primary")><view class="tile-primary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))} }}</view></#if>
${""?left_pad(indent)}      <#if guidbase.has_child_widget(widget, "secondary")><view class="tile-secondary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "secondary"))} }}</view></#if>
${""?left_pad(indent)}    </view>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}  <view class="tile-footer">
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "start_time")><text class="tile-start-time">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "start_time"))} }}</text></#if>
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "status")><text class="tile-status">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))} }}</text></#if>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}</view>
</#macro>

<#--
67. invoice_summary (发票摘要)
+-----------------------------------------------+
|                                      [status] |
| [primary]                                     |
| [secondary]                                   |
| [tertiary]                                    |
|                                               |
|                                    [end_time] |
+-----------------------------------------------+
-->
<#macro print_tile_invoice_summary widget varname="row" indent=0>
${""?left_pad(indent)}<view class="tile tile-invoice-summary layout-timeline">
${""?left_pad(indent)}  <view class="tile-row tile-header">
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "status")><text class="tile-status">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))} }}</text></#if>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}  <view class="tile-body">
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "primary")><view class="tile-primary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))} }}</view></#if>
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "secondary")><view class="tile-secondary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "secondary"))} }}</view></#if>
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "tertiary")><view class="tile-tertiary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "tertiary"))} }}</view></#if>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}  <view class="tile-footer">
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "end_time")><text class="tile-end-time">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "end_time"))} }}</text></#if>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}</view>
</#macro>

<#--
68. payment_method (支付方式)
+-----------------------------------------------+
| +-------+  [primary]                 [status] |
| |avatar |  [secondary]                        |
| +-------+                                     |
+-----------------------------------------------+
-->
<#macro print_tile_payment_method widget varname="row" indent=0>
${""?left_pad(indent)}<view class="tile tile-payment-method layout-profile">
${""?left_pad(indent)}  <view class="tile-row">
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "avatar")><view class="tile-avatar"><image src="{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "avatar"))} }}"></image></view></#if>
${""?left_pad(indent)}    <view class="tile-body">
${""?left_pad(indent)}      <#if guidbase.has_child_widget(widget, "primary")><view class="tile-primary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))} }}</view></#if>
${""?left_pad(indent)}      <#if guidbase.has_child_widget(widget, "secondary")><view class="tile-secondary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "secondary"))} }}</view></#if>
${""?left_pad(indent)}    </view>
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "status")><text class="tile-status">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))} }}</text></#if>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}</view>
</#macro>

<#--
69. account_balance (账户余额)
+===============================================+
|                 [background]                  |
|                                               |
|  [primary]                           [status] |
|  [secondary]                                  |
+===============================================+
-->
<#macro print_tile_account_balance widget varname="row" indent=0>
${""?left_pad(indent)}<view class="tile tile-account-balance layout-background">
${""?left_pad(indent)}  <#if guidbase.has_child_widget(widget, "background")>
${""?left_pad(indent)}  <view class="tile-background"><image src="{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "background"))} }}"></image></view>
${""?left_pad(indent)}  </#if>
${""?left_pad(indent)}  <view class="tile-overlay">
${""?left_pad(indent)}    <view class="tile-row tile-header">
${""?left_pad(indent)}      <#if guidbase.has_child_widget(widget, "status")><text class="tile-status">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))} }}</text></#if>
${""?left_pad(indent)}    </view>
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "primary")><view class="tile-primary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))} }}</view></#if>
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "secondary")><view class="tile-secondary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "secondary"))} }}</view></#if>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}</view>
</#macro>

<#--
70. wallet_card (钱包卡片)
+===============================================+
|                 [background]                  |
|                                               |
|  [primary]                                    |
|                                               |
|  [status]                          [end_time] |
+===============================================+
-->
<#macro print_tile_wallet_card widget varname="row" indent=0>
${""?left_pad(indent)}<view class="tile tile-wallet-card layout-background">
${""?left_pad(indent)}  <#if guidbase.has_child_widget(widget, "background")>
${""?left_pad(indent)}  <view class="tile-background"><image src="{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "background"))} }}"></image></view>
${""?left_pad(indent)}  </#if>
${""?left_pad(indent)}  <view class="tile-overlay">
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "primary")><view class="tile-primary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))} }}</view></#if>
${""?left_pad(indent)}    <view class="tile-footer">
${""?left_pad(indent)}      <#if guidbase.has_child_widget(widget, "status")><text class="tile-status">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))} }}</text></#if>
${""?left_pad(indent)}      <#if guidbase.has_child_widget(widget, "end_time")><text class="tile-end-time">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "end_time"))} }}</text></#if>
${""?left_pad(indent)}    </view>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}</view>
</#macro>

<#--
71. coupon_card (优惠券卡片)
+===============================================+
|                 [background]                  |
|                                               |
|  [tags]                                       |
|  [primary]                                    |
|                                               |
|                                    [end_time] |
+===============================================+
-->
<#macro print_tile_coupon_card widget varname="row" indent=0>
${""?left_pad(indent)}<view class="tile tile-coupon-card layout-background">
${""?left_pad(indent)}  <#if guidbase.has_child_widget(widget, "background")>
${""?left_pad(indent)}  <view class="tile-background"><image src="{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "background"))} }}"></image></view>
${""?left_pad(indent)}  </#if>
${""?left_pad(indent)}  <view class="tile-overlay">
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "tags")>
${""?left_pad(indent)}    <view class="tile-tags"><text wx:for="{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "tags"))} }}" wx:for-item="tag" wx:key="*this" class="tile-tag">{{ tag }}</text></view>
${""?left_pad(indent)}    </#if>
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "primary")><view class="tile-primary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))} }}</view></#if>
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "end_time")><view class="tile-end-time">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "end_time"))} }}</view></#if>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}</view>
</#macro>

<#--
72. deal_card (交易卡片)
+-----------------------------------------------+
| +-------------------------------------------+ |
| |                  [image]                  | |
| +-------------------------------------------+ |
| [tags]                                        |
| [primary]                                     |
| [secondary]                                   |
|                                               |
|                                      [status] |
+-----------------------------------------------+
-->
<#macro print_tile_deal_card widget varname="row" indent=0>
${""?left_pad(indent)}<view class="tile tile-deal-card layout-media">
${""?left_pad(indent)}  <#if guidbase.has_child_widget(widget, "image")>
${""?left_pad(indent)}  <view class="tile-image"><image src="{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "image"))} }}"></image></view>
${""?left_pad(indent)}  </#if>
${""?left_pad(indent)}  <view class="tile-body">
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "tags")>
${""?left_pad(indent)}    <view class="tile-tags"><text wx:for="{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "tags"))} }}" wx:for-item="tag" wx:key="*this" class="tile-tag">{{ tag }}</text></view>
${""?left_pad(indent)}    </#if>
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "primary")><view class="tile-primary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))} }}</view></#if>
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "secondary")><view class="tile-secondary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "secondary"))} }}</view></#if>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}  <view class="tile-footer">
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "status")><text class="tile-status">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))} }}</text></#if>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}</view>
</#macro>

<#--
73. property_listing (房产房源)
+-----------------------------------------------+
| +-------------------------------------------+ |
| |                  [image]                  | |
| +-------------------------------------------+ |
| [tags]                                        |
| [primary]                                     |
| [secondary]                                   |
| [tertiary]                                    |
|                                               |
|                                      [status] |
+-----------------------------------------------+
-->
<#macro print_tile_property_listing widget varname="row" indent=0>
${""?left_pad(indent)}<view class="tile tile-property-listing layout-media">
${""?left_pad(indent)}  <#if guidbase.has_child_widget(widget, "image")>
${""?left_pad(indent)}  <view class="tile-image"><image src="{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "image"))} }}"></image></view>
${""?left_pad(indent)}  </#if>
${""?left_pad(indent)}  <view class="tile-body">
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "tags")>
${""?left_pad(indent)}    <view class="tile-tags"><text wx:for="{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "tags"))} }}" wx:for-item="tag" wx:key="*this" class="tile-tag">{{ tag }}</text></view>
${""?left_pad(indent)}    </#if>
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "primary")><view class="tile-primary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))} }}</view></#if>
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "secondary")><view class="tile-secondary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "secondary"))} }}</view></#if>
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "tertiary")><view class="tile-tertiary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "tertiary"))} }}</view></#if>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}  <view class="tile-footer">
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "status")><text class="tile-status">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))} }}</text></#if>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}</view>
</#macro>

<#--
74. travel_destination (旅游目的地)
+-----------------------------------------------+
| +-------------------------------------------+ |
| |                  [image]                  | |
| +-------------------------------------------+ |
| [primary]                                     |
| [secondary]                                   |
|                                               |
| [tags]                               [avatars] |
+-----------------------------------------------+
-->
<#macro print_tile_travel_destination widget varname="row" indent=0>
${""?left_pad(indent)}<view class="tile tile-travel-destination layout-media">
${""?left_pad(indent)}  <#if guidbase.has_child_widget(widget, "image")>
${""?left_pad(indent)}  <view class="tile-image"><image src="{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "image"))} }}"></image></view>
${""?left_pad(indent)}  </#if>
${""?left_pad(indent)}  <view class="tile-body">
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "primary")><view class="tile-primary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))} }}</view></#if>
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "secondary")><view class="tile-secondary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "secondary"))} }}</view></#if>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}  <view class="tile-footer">
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "tags")>
${""?left_pad(indent)}    <view class="tile-tags"><text wx:for="{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "tags"))} }}" wx:for-item="tag" wx:key="*this" class="tile-tag">{{ tag }}</text></view>
${""?left_pad(indent)}    </#if>
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "avatars")>
${""?left_pad(indent)}    <view class="tile-avatars"><image wx:for="{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "avatars"))} }}" wx:for-item="av" wx:key="*this" src="{{ av }}" class="tile-avatar-img"></image></view>
${""?left_pad(indent)}    </#if>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}</view>
</#macro>

<#--
75. flight_segment (航段信息)
+-----------------------------------------------+
| [start_time]                       [end_time] |
|                                               |
| [primary]                                     |
| [secondary]                                   |
|                                               |
|                                      [status] |
+-----------------------------------------------+
-->
<#macro print_tile_flight_segment widget varname="row" indent=0>
${""?left_pad(indent)}<view class="tile tile-flight-segment layout-timeline">
${""?left_pad(indent)}  <view class="tile-row tile-header">
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "start_time")><text class="tile-start-time">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "start_time"))} }}</text></#if>
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "end_time")><text class="tile-end-time">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "end_time"))} }}</text></#if>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}  <view class="tile-body">
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "primary")><view class="tile-primary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))} }}</view></#if>
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "secondary")><view class="tile-secondary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "secondary"))} }}</view></#if>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}  <view class="tile-footer">
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "status")><text class="tile-status">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))} }}</text></#if>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}</view>
</#macro>

<#--
76. hotel_booking (酒店预订)
+-----------------------------------------------+
| +-------------------------------------------+ |
| |                  [image]                  | |
| +-------------------------------------------+ |
| [primary]                                     |
| [secondary]                                   |
|                                               |
| [start_time] - [end_time]            [status] |
+-----------------------------------------------+
-->
<#macro print_tile_hotel_booking widget varname="row" indent=0>
${""?left_pad(indent)}<view class="tile tile-hotel-booking layout-media">
${""?left_pad(indent)}  <#if guidbase.has_child_widget(widget, "image")>
${""?left_pad(indent)}  <view class="tile-image"><image src="{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "image"))} }}"></image></view>
${""?left_pad(indent)}  </#if>
${""?left_pad(indent)}  <view class="tile-body">
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "primary")><view class="tile-primary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))} }}</view></#if>
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "secondary")><view class="tile-secondary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "secondary"))} }}</view></#if>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}  <view class="tile-footer">
${""?left_pad(indent)}    <text class="tile-time">
${""?left_pad(indent)}      <#if guidbase.has_child_widget(widget, "start_time")><text>{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "start_time"))} }}</text></#if>
${""?left_pad(indent)}      <#if guidbase.has_child_widget(widget, "start_time") && guidbase.has_child_widget(widget, "end_time")><text> - </text></#if>
${""?left_pad(indent)}      <#if guidbase.has_child_widget(widget, "end_time")><text>{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "end_time"))} }}</text></#if>
${""?left_pad(indent)}    </text>
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "status")><text class="tile-status">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))} }}</text></#if>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}</view>
</#macro>

<#--
77. restaurant_reservation (餐厅预订)
+-----------------------------------------------+
| +-------------------------------------------+ |
| |                  [image]                  | |
| +-------------------------------------------+ |
| [primary]                                     |
| [secondary]                                   |
|                                               |
| [start_time]                         [status] |
+-----------------------------------------------+
-->
<#macro print_tile_restaurant_reservation widget varname="row" indent=0>
${""?left_pad(indent)}<view class="tile tile-restaurant-reservation layout-media">
${""?left_pad(indent)}  <#if guidbase.has_child_widget(widget, "image")>
${""?left_pad(indent)}  <view class="tile-image"><image src="{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "image"))} }}"></image></view>
${""?left_pad(indent)}  </#if>
${""?left_pad(indent)}  <view class="tile-body">
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "primary")><view class="tile-primary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))} }}</view></#if>
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "secondary")><view class="tile-secondary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "secondary"))} }}</view></#if>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}  <view class="tile-footer">
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "start_time")><text class="tile-start-time">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "start_time"))} }}</text></#if>
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "status")><text class="tile-status">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))} }}</text></#if>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}</view>
</#macro>

<#--
78. event_ticket (活动门票)
+===============================================+
|                 [background]                  |
|                                               |
|  [primary]                           [status] |
|  [secondary]                                  |
|                                               |
|  [start_time] - [end_time]                    |
+===============================================+
-->
<#macro print_tile_event_ticket widget varname="row" indent=0>
${""?left_pad(indent)}<view class="tile tile-event-ticket layout-background">
${""?left_pad(indent)}  <#if guidbase.has_child_widget(widget, "background")>
${""?left_pad(indent)}  <view class="tile-background"><image src="{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "background"))} }}"></image></view>
${""?left_pad(indent)}  </#if>
${""?left_pad(indent)}  <view class="tile-overlay">
${""?left_pad(indent)}    <view class="tile-row tile-header">
${""?left_pad(indent)}      <#if guidbase.has_child_widget(widget, "status")><text class="tile-status">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))} }}</text></#if>
${""?left_pad(indent)}    </view>
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "primary")><view class="tile-primary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))} }}</view></#if>
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "secondary")><view class="tile-secondary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "secondary"))} }}</view></#if>
${""?left_pad(indent)}    <view class="tile-footer">
${""?left_pad(indent)}      <text class="tile-time">
${""?left_pad(indent)}        <#if guidbase.has_child_widget(widget, "start_time")><text>{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "start_time"))} }}</text></#if>
${""?left_pad(indent)}        <#if guidbase.has_child_widget(widget, "start_time") && guidbase.has_child_widget(widget, "end_time")><text> - </text></#if>
${""?left_pad(indent)}        <#if guidbase.has_child_widget(widget, "end_time")><text>{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "end_time"))} }}</text></#if>
${""?left_pad(indent)}      </text>
${""?left_pad(indent)}    </view>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}</view>
</#macro>

<#--
79. speaker_profile (演讲嘉宾资料)
+===============================================+
|                 [background]                  |
|                                               |
|  +-------+                                    |
|  |avatar |                                    |
|  +-------+                                    |
|  [primary]                                    |
|  [secondary]                                  |
|  [tags]                                       |
+===============================================+
-->
<#macro print_tile_speaker_profile widget varname="row" indent=0>
${""?left_pad(indent)}<view class="tile tile-speaker-profile layout-background">
${""?left_pad(indent)}  <#if guidbase.has_child_widget(widget, "background")>
${""?left_pad(indent)}  <view class="tile-background"><image src="{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "background"))} }}"></image></view>
${""?left_pad(indent)}  </#if>
${""?left_pad(indent)}  <view class="tile-overlay">
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "avatar")><view class="tile-avatar"><image src="{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "avatar"))} }}"></image></view></#if>
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "primary")><view class="tile-primary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))} }}</view></#if>
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "secondary")><view class="tile-secondary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "secondary"))} }}</view></#if>
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "tags")>
${""?left_pad(indent)}    <view class="tile-tags"><text wx:for="{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "tags"))} }}" wx:for-item="tag" wx:key="*this" class="tile-tag">{{ tag }}</text></view>
${""?left_pad(indent)}    </#if>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}</view>
</#macro>

<#--
80. course_card (课程卡片)
+-----------------------------------------------+
| +-------------------------------------------+ |
| |                  [image]                  | |
| +-------------------------------------------+ |
| [primary]                                     |
| [secondary]                                   |
|                                               |
| [avatars]                            [status] |
+-----------------------------------------------+
-->
<#macro print_tile_course_card widget varname="row" indent=0>
${""?left_pad(indent)}<view class="tile tile-course-card layout-media">
${""?left_pad(indent)}  <#if guidbase.has_child_widget(widget, "image")>
${""?left_pad(indent)}  <view class="tile-image"><image src="{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "image"))} }}"></image></view>
${""?left_pad(indent)}  </#if>
${""?left_pad(indent)}  <view class="tile-body">
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "primary")><view class="tile-primary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))} }}</view></#if>
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "secondary")><view class="tile-secondary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "secondary"))} }}</view></#if>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}  <view class="tile-footer">
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "avatars")>
${""?left_pad(indent)}    <view class="tile-avatars"><image wx:for="{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "avatars"))} }}" wx:for-item="av" wx:key="*this" src="{{ av }}" class="tile-avatar-img"></image></view>
${""?left_pad(indent)}    </#if>
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "status")><text class="tile-status">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))} }}</text></#if>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}</view>
</#macro>

<#--
81. lesson_progress (课时进度)
+-----------------------------------------------+
| [start_time]                                  |
|                                               |
| [primary]                                     |
| [secondary]                                   |
|                                               |
| [tags]                               [status] |
+-----------------------------------------------+
-->
<#macro print_tile_lesson_progress widget varname="row" indent=0>
${""?left_pad(indent)}<view class="tile tile-lesson-progress layout-timeline">
${""?left_pad(indent)}  <view class="tile-row tile-header">
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "start_time")><text class="tile-start-time">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "start_time"))} }}</text></#if>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}  <view class="tile-body">
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "primary")><view class="tile-primary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))} }}</view></#if>
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "secondary")><view class="tile-secondary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "secondary"))} }}</view></#if>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}  <view class="tile-footer">
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "tags")>
${""?left_pad(indent)}    <view class="tile-tags"><text wx:for="{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "tags"))} }}" wx:for-item="tag" wx:key="*this" class="tile-tag">{{ tag }}</text></view>
${""?left_pad(indent)}    </#if>
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "status")><text class="tile-status">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))} }}</text></#if>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}</view>
</#macro>

<#--
82. quiz_result (测试结果)
+-----------------------------------------------+
|                                      [status] |
| [primary]                                     |
| [secondary]                                   |
| [tertiary]                                    |
+-----------------------------------------------+
-->
<#macro print_tile_quiz_result widget varname="row" indent=0>
${""?left_pad(indent)}<view class="tile tile-quiz-result layout-content">
${""?left_pad(indent)}  <view class="tile-row tile-header">
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "status")><text class="tile-status">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))} }}</text></#if>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}  <view class="tile-body">
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "primary")><view class="tile-primary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))} }}</view></#if>
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "secondary")><view class="tile-secondary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "secondary"))} }}</view></#if>
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "tertiary")><view class="tile-tertiary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "tertiary"))} }}</view></#if>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}</view>
</#macro>

<#--
83. certificate_card (证书卡片)
+===============================================+
|                 [background]                  |
|                                               |
|  +-------+                                    |
|  |avatar |                                    |
|  +-------+                                    |
|  [primary]                                    |
|                                               |
|                                    [end_time] |
+===============================================+
-->
<#macro print_tile_certificate_card widget varname="row" indent=0>
${""?left_pad(indent)}<view class="tile tile-certificate-card layout-background">
${""?left_pad(indent)}  <#if guidbase.has_child_widget(widget, "background")>
${""?left_pad(indent)}  <view class="tile-background"><image src="{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "background"))} }}"></image></view>
${""?left_pad(indent)}  </#if>
${""?left_pad(indent)}  <view class="tile-overlay">
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "avatar")><view class="tile-avatar"><image src="{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "avatar"))} }}"></image></view></#if>
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "primary")><view class="tile-primary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))} }}</view></#if>
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "end_time")><view class="tile-end-time">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "end_time"))} }}</view></#if>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}</view>
</#macro>

<#--
84. article_quote (文章引用)
+-----------------------------------------------+
| +-------------------------------------------+ |
| |                  [image]                  | |
| +-------------------------------------------+ |
| [primary]                                     |
| [secondary]                                   |
|                                               |
| [avatar]                                      |
+-----------------------------------------------+
-->
<#macro print_tile_article_quote widget varname="row" indent=0>
${""?left_pad(indent)}<view class="tile tile-article-quote layout-media">
${""?left_pad(indent)}  <#if guidbase.has_child_widget(widget, "image")>
${""?left_pad(indent)}  <view class="tile-image"><image src="{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "image"))} }}"></image></view>
${""?left_pad(indent)}  </#if>
${""?left_pad(indent)}  <view class="tile-body">
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "primary")><view class="tile-primary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))} }}</view></#if>
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "secondary")><view class="tile-secondary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "secondary"))} }}</view></#if>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}  <#if guidbase.has_child_widget(widget, "avatar")>
${""?left_pad(indent)}  <view class="tile-footer">
${""?left_pad(indent)}    <view class="tile-avatar"><image src="{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "avatar"))} }}"></image></view>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}  </#if>
${""?left_pad(indent)}</view>
</#macro>

<#--
85. comment_thread (评论线程)
+-----------------------------------------------+
| +-------+  [primary]                          |
| |avatar |  [secondary]                        |
| +-------+                                     |
| [start_time]                         [status] |
+-----------------------------------------------+
-->
<#macro print_tile_comment_thread widget varname="row" indent=0>
${""?left_pad(indent)}<view class="tile tile-comment-thread layout-timeline">
${""?left_pad(indent)}  <view class="tile-row">
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "avatar")><view class="tile-avatar"><image src="{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "avatar"))} }}"></image></view></#if>
${""?left_pad(indent)}    <view class="tile-body">
${""?left_pad(indent)}      <#if guidbase.has_child_widget(widget, "primary")><view class="tile-primary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))} }}</view></#if>
${""?left_pad(indent)}      <#if guidbase.has_child_widget(widget, "secondary")><view class="tile-secondary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "secondary"))} }}</view></#if>
${""?left_pad(indent)}    </view>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}  <view class="tile-footer">
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "start_time")><text class="tile-start-time">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "start_time"))} }}</text></#if>
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "status")><text class="tile-status">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))} }}</text></#if>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}</view>
</#macro>

<#--
86. reply_item (回复单项)
+-----------------------------------------------+
| +-------+  [primary]                          |
| |avatar |  [secondary]                        |
| +-------+  [tertiary]                         |
|                                               |
| [start_time]                                  |
+-----------------------------------------------+
-->
<#macro print_tile_reply_item widget varname="row" indent=0>
${""?left_pad(indent)}<view class="tile tile-reply-item layout-timeline">
${""?left_pad(indent)}  <view class="tile-row">
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "avatar")><view class="tile-avatar"><image src="{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "avatar"))} }}"></image></view></#if>
${""?left_pad(indent)}    <view class="tile-body">
${""?left_pad(indent)}      <#if guidbase.has_child_widget(widget, "primary")><view class="tile-primary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))} }}</view></#if>
${""?left_pad(indent)}      <#if guidbase.has_child_widget(widget, "secondary")><view class="tile-secondary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "secondary"))} }}</view></#if>
${""?left_pad(indent)}      <#if guidbase.has_child_widget(widget, "tertiary")><view class="tile-tertiary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "tertiary"))} }}</view></#if>
${""?left_pad(indent)}    </view>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}  <view class="tile-footer">
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "start_time")><text class="tile-start-time">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "start_time"))} }}</text></#if>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}</view>
</#macro>

<#--
87. reaction_summary (反应小结)
+-----------------------------------------------+
| [avatars]                                     |
| [primary]                            [status] |
|                                               |
| [tags]                                        |
+-----------------------------------------------+
-->
<#macro print_tile_reaction_summary widget varname="row" indent=0>
${""?left_pad(indent)}<view class="tile tile-reaction-summary layout-profile">
${""?left_pad(indent)}  <#if guidbase.has_child_widget(widget, "avatars")>
${""?left_pad(indent)}  <view class="tile-avatars">
${""?left_pad(indent)}    <image wx:for="{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "avatars"))} }}" wx:for-item="av" wx:key="*this" src="{{ av }}" class="tile-avatar-img"></image>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}  </#if>
${""?left_pad(indent)}  <view class="tile-row tile-body">
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "primary")><view class="tile-primary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))} }}</view></#if>
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "status")><view class="tile-status">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))} }}</view></#if>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}  <#if guidbase.has_child_widget(widget, "tags")>
${""?left_pad(indent)}  <view class="tile-footer">
${""?left_pad(indent)}    <view class="tile-tags"><text wx:for="{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "tags"))} }}" wx:for-item="tag" wx:key="*this" class="tile-tag">{{ tag }}</text></view>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}  </#if>
${""?left_pad(indent)}</view>
</#macro>

<#--
88. notification_group (通知组卡)
+-----------------------------------------------+
| +-------+  [primary]                          |
| |avatar |  [tertiary]                         |
| +-------+                                     |
| [start_time]                         [status] |
+-----------------------------------------------+
-->
<#macro print_tile_notification_group widget varname="row" indent=0>
${""?left_pad(indent)}<view class="tile tile-notification-group layout-timeline">
${""?left_pad(indent)}  <view class="tile-row">
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "avatar")><view class="tile-avatar"><image src="{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "avatar"))} }}"></image></view></#if>
${""?left_pad(indent)}    <view class="tile-body">
${""?left_pad(indent)}      <#if guidbase.has_child_widget(widget, "primary")><view class="tile-primary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))} }}</view></#if>
${""?left_pad(indent)}      <#if guidbase.has_child_widget(widget, "tertiary")><view class="tile-tertiary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "tertiary"))} }}</view></#if>
${""?left_pad(indent)}    </view>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}  <view class="tile-footer">
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "start_time")><text class="tile-start-time">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "start_time"))} }}</text></#if>
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "status")><text class="tile-status">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))} }}</text></#if>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}</view>
</#macro>

<#--
89. inbox_thread (收件箱线程)
+-----------------------------------------------+
| +-------+  [primary]                 [status] |
| |avatar |  [secondary]                        |
| +-------+                          [end_time] |
+-----------------------------------------------+
-->
<#macro print_tile_inbox_thread widget varname="row" indent=0>
${""?left_pad(indent)}<view class="tile tile-inbox-thread layout-timeline">
${""?left_pad(indent)}  <view class="tile-row">
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "avatar")><view class="tile-avatar"><image src="{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "avatar"))} }}"></image></view></#if>
${""?left_pad(indent)}    <view class="tile-body">
${""?left_pad(indent)}      <view class="tile-row">
${""?left_pad(indent)}        <#if guidbase.has_child_widget(widget, "primary")><view class="tile-primary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))} }}</view></#if>
${""?left_pad(indent)}        <#if guidbase.has_child_widget(widget, "status")><view class="tile-status">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))} }}</view></#if>
${""?left_pad(indent)}      </view>
${""?left_pad(indent)}      <#if guidbase.has_child_widget(widget, "secondary")><view class="tile-secondary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "secondary"))} }}</view></#if>
${""?left_pad(indent)}      <#if guidbase.has_child_widget(widget, "end_time")><view class="tile-end-time">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "end_time"))} }}</view></#if>
${""?left_pad(indent)}    </view>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}</view>
</#macro>

<#--
90. email_preview (邮件预览)
+-----------------------------------------------+
| +-------+  [primary]                          |
| |avatar |  [secondary]                        |
| +-------+  [tertiary]                         |
|                                               |
| [tags]                                        |
+-----------------------------------------------+
-->
<#macro print_tile_email_preview widget varname="row" indent=0>
${""?left_pad(indent)}<view class="tile tile-email-preview layout-profile">
${""?left_pad(indent)}  <view class="tile-row">
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "avatar")><view class="tile-avatar"><image src="{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "avatar"))} }}"></image></view></#if>
${""?left_pad(indent)}    <view class="tile-body">
${""?left_pad(indent)}      <#if guidbase.has_child_widget(widget, "primary")><view class="tile-primary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))} }}</view></#if>
${""?left_pad(indent)}      <#if guidbase.has_child_widget(widget, "secondary")><view class="tile-secondary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "secondary"))} }}</view></#if>
${""?left_pad(indent)}      <#if guidbase.has_child_widget(widget, "tertiary")><view class="tile-tertiary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "tertiary"))} }}</view></#if>
${""?left_pad(indent)}    </view>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}  <#if guidbase.has_child_widget(widget, "tags")>
${""?left_pad(indent)}  <view class="tile-footer">
${""?left_pad(indent)}    <view class="tile-tags"><text wx:for="{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "tags"))} }}" wx:for-item="tag" wx:key="*this" class="tile-tag">{{ tag }}</text></view>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}  </#if>
${""?left_pad(indent)}</view>
</#macro>

<#--
91. calendar_agenda (日历议程)
+-----------------------------------------------+
| [start_time] - [end_time]                     |
|                                               |
| [primary]                                     |
| [secondary]                                   |
|                                               |
| [avatars]                            [status] |
+-----------------------------------------------+
-->
<#macro print_tile_calendar_agenda widget varname="row" indent=0>
${""?left_pad(indent)}<view class="tile tile-calendar-agenda layout-timeline">
${""?left_pad(indent)}  <view class="tile-row tile-header">
${""?left_pad(indent)}    <text class="tile-time">
${""?left_pad(indent)}      <#if guidbase.has_child_widget(widget, "start_time")><text>{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "start_time"))} }}</text></#if>
${""?left_pad(indent)}      <#if guidbase.has_child_widget(widget, "start_time") && guidbase.has_child_widget(widget, "end_time")><text> - </text></#if>
${""?left_pad(indent)}      <#if guidbase.has_child_widget(widget, "end_time")><text>{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "end_time"))} }}</text></#if>
${""?left_pad(indent)}    </text>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}  <view class="tile-body">
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "primary")><view class="tile-primary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))} }}</view></#if>
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "secondary")><view class="tile-secondary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "secondary"))} }}</view></#if>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}  <view class="tile-footer">
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "avatars")>
${""?left_pad(indent)}    <view class="tile-avatars"><image wx:for="{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "avatars"))} }}" wx:for-item="av" wx:key="*this" src="{{ av }}" class="tile-avatar-img"></image></view>
${""?left_pad(indent)}    </#if>
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "status")><text class="tile-status">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))} }}</text></#if>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}</view>
</#macro>

<#--
92. calendar_month_event (日历月度事件)
+-----------------------------------------------+
| [start_time]                         [status] |
| [primary]                                     |
|                                               |
| [tags]                                        |
+-----------------------------------------------+
-->
<#macro print_tile_calendar_month_event widget varname="row" indent=0>
${""?left_pad(indent)}<view class="tile tile-calendar-month-event layout-timeline">
${""?left_pad(indent)}  <view class="tile-row tile-header">
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "start_time")><text class="tile-start-time">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "start_time"))} }}</text></#if>
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "status")><text class="tile-status">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))} }}</text></#if>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}  <view class="tile-body">
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "primary")><view class="tile-primary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))} }}</view></#if>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}  <#if guidbase.has_child_widget(widget, "tags")>
${""?left_pad(indent)}  <view class="tile-footer">
${""?left_pad(indent)}    <view class="tile-tags"><text wx:for="{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "tags"))} }}" wx:for-item="tag" wx:key="*this" class="tile-tag">{{ tag }}</text></view>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}  </#if>
${""?left_pad(indent)}</view>
</#macro>

<#--
93. date_range_picker (日期范围选择)
+-----------------------------------------------+
| [start_time] - [end_time]                     |
|                                               |
| [primary]                            [status] |
+-----------------------------------------------+
-->
<#macro print_tile_date_range_picker widget varname="row" indent=0>
${""?left_pad(indent)}<view class="tile tile-date-range-picker layout-timeline">
${""?left_pad(indent)}  <view class="tile-row tile-header">
${""?left_pad(indent)}    <text class="tile-time">
${""?left_pad(indent)}      <#if guidbase.has_child_widget(widget, "start_time")><text>{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "start_time"))} }}</text></#if>
${""?left_pad(indent)}      <#if guidbase.has_child_widget(widget, "start_time") && guidbase.has_child_widget(widget, "end_time")><text> - </text></#if>
${""?left_pad(indent)}      <#if guidbase.has_child_widget(widget, "end_time")><text>{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "end_time"))} }}</text></#if>
${""?left_pad(indent)}    </text>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}  <view class="tile-body tile-row">
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "primary")><view class="tile-primary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))} }}</view></#if>
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "status")><view class="tile-status">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))} }}</view></#if>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}</view>
</#macro>

<#--
94. milestone_card (里程碑卡片)
+-----------------------------------------------+
| [status]                           [start_time]|
|                                               |
| [primary]                                     |
| [secondary]                                   |
|                                               |
| [avatars]                                     |
+-----------------------------------------------+
-->
<#macro print_tile_milestone_card widget varname="row" indent=0>
${""?left_pad(indent)}<view class="tile tile-milestone-card layout-timeline">
${""?left_pad(indent)}  <view class="tile-row tile-header">
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "status")><text class="tile-status">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))} }}</text></#if>
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "start_time")><text class="tile-start-time">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "start_time"))} }}</text></#if>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}  <view class="tile-body">
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "primary")><view class="tile-primary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))} }}</view></#if>
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "secondary")><view class="tile-secondary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "secondary"))} }}</view></#if>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}  <#if guidbase.has_child_widget(widget, "avatars")>
${""?left_pad(indent)}  <view class="tile-footer">
${""?left_pad(indent)}    <view class="tile-avatars"><image wx:for="{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "avatars"))} }}" wx:for-item="av" wx:key="*this" src="{{ av }}" class="tile-avatar-img"></image></view>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}  </#if>
${""?left_pad(indent)}</view>
</#macro>

<#--
95. roadmap_item (路线图单项)
+-----------------------------------------------+
| [status]                                      |
|                                               |
| [primary]                                     |
| [secondary]                                   |
| [tertiary]                                    |
|                                               |
|                                    [end_time] |
+-----------------------------------------------+
-->
<#macro print_tile_roadmap_item widget varname="row" indent=0>
${""?left_pad(indent)}<view class="tile tile-roadmap-item layout-timeline">
${""?left_pad(indent)}  <view class="tile-row tile-header">
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "status")><text class="tile-status">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))} }}</text></#if>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}  <view class="tile-body">
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "primary")><view class="tile-primary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))} }}</view></#if>
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "secondary")><view class="tile-secondary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "secondary"))} }}</view></#if>
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "tertiary")><view class="tile-tertiary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "tertiary"))} }}</view></#if>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}  <view class="tile-footer">
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "end_time")><text class="tile-end-time">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "end_time"))} }}</text></#if>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}</view>
</#macro>

<#--
96. sprint_summary (冲刺摘要)
+-----------------------------------------------+
| [primary]                            [status] |
| [secondary]                                   |
|                                               |
| [avatars]                              [tags] |
+-----------------------------------------------+
-->
<#macro print_tile_sprint_summary widget varname="row" indent=0>
${""?left_pad(indent)}<view class="tile tile-sprint-summary layout-profile">
${""?left_pad(indent)}  <view class="tile-row tile-header">
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "primary")><view class="tile-primary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))} }}</view></#if>
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "status")><view class="tile-status">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))} }}</view></#if>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}  <view class="tile-body">
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "secondary")><view class="tile-secondary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "secondary"))} }}</view></#if>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}  <view class="tile-footer">
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "avatars")>
${""?left_pad(indent)}    <view class="tile-avatars"><image wx:for="{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "avatars"))} }}" wx:for-item="av" wx:key="*this" src="{{ av }}" class="tile-avatar-img"></image></view>
${""?left_pad(indent)}    </#if>
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "tags")>
${""?left_pad(indent)}    <view class="tile-tags"><text wx:for="{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "tags"))} }}" wx:for-item="tag" wx:key="*this" class="tile-tag">{{ tag }}</text></view>
${""?left_pad(indent)}    </#if>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}</view>
</#macro>

<#--
97. kanban_card (看板卡片)
+-----------------------------------------------+
| [tags]                                        |
|                                               |
| [primary]                                     |
| [secondary]                                   |
|                                               |
| [avatars]                          [end_time] |
+-----------------------------------------------+
-->
<#macro print_tile_kanban_card widget varname="row" indent=0>
${""?left_pad(indent)}<view class="tile tile-kanban-card layout-timeline">
${""?left_pad(indent)}  <view class="tile-row tile-header">
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "tags")>
${""?left_pad(indent)}    <view class="tile-tags"><text wx:for="{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "tags"))} }}" wx:for-item="tag" wx:key="*this" class="tile-tag">{{ tag }}</text></view>
${""?left_pad(indent)}    </#if>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}  <view class="tile-body">
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "primary")><view class="tile-primary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))} }}</view></#if>
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "secondary")><view class="tile-secondary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "secondary"))} }}</view></#if>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}  <view class="tile-footer">
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "avatars")>
${""?left_pad(indent)}    <view class="tile-avatars"><image wx:for="{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "avatars"))} }}" wx:for-item="av" wx:key="*this" src="{{ av }}" class="tile-avatar-img"></image></view>
${""?left_pad(indent)}    </#if>
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "end_time")><text class="tile-end-time">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "end_time"))} }}</text></#if>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}</view>
</#macro>

<#--
98. kanban_swimlane (看板泳道)
+-----------------------------------------------+
| [primary]                            [status] |
|                                               |
| [avatars]                              [tags] |
+-----------------------------------------------+
-->
<#macro print_tile_kanban_swimlane widget varname="row" indent=0>
${""?left_pad(indent)}<view class="tile tile-kanban-swimlane layout-profile">
${""?left_pad(indent)}  <view class="tile-row tile-header">
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "primary")><view class="tile-primary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))} }}</view></#if>
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "status")><view class="tile-status">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))} }}</view></#if>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}  <view class="tile-footer">
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "avatars")>
${""?left_pad(indent)}    <view class="tile-avatars"><image wx:for="{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "avatars"))} }}" wx:for-item="av" wx:key="*this" src="{{ av }}" class="tile-avatar-img"></image></view>
${""?left_pad(indent)}    </#if>
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "tags")>
${""?left_pad(indent)}    <view class="tile-tags"><text wx:for="{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "tags"))} }}" wx:for-item="tag" wx:key="*this" class="tile-tag">{{ tag }}</text></view>
${""?left_pad(indent)}    </#if>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}</view>
</#macro>

<#--
99. project_health (项目健康度)
+===============================================+
|                 [background]                  |
|                                               |
|  [status]                                     |
|  [primary]                                    |
|  [secondary]                                  |
|  [tags]                                       |
+===============================================+
-->
<#macro print_tile_project_health widget varname="row" indent=0>
${""?left_pad(indent)}<view class="tile tile-project-health layout-background">
${""?left_pad(indent)}  <#if guidbase.has_child_widget(widget, "background")>
${""?left_pad(indent)}  <view class="tile-background"><image src="{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "background"))} }}"></image></view>
${""?left_pad(indent)}  </#if>
${""?left_pad(indent)}  <view class="tile-overlay">
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "status")><view class="tile-status">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))} }}</view></#if>
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "primary")><view class="tile-primary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))} }}</view></#if>
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "secondary")><view class="tile-secondary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "secondary"))} }}</view></#if>
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "tags")>
${""?left_pad(indent)}    <view class="tile-tags"><text wx:for="{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "tags"))} }}" wx:for-item="tag" wx:key="*this" class="tile-tag">{{ tag }}</text></view>
${""?left_pad(indent)}    </#if>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}</view>
</#macro>

<#--
100. team_presence (团队在线状态)
+-----------------------------------------------+
| [avatars]                                     |
|                                               |
| [primary]                                     |
| [secondary]                                   |
|                                               |
| [start_time]                         [status] |
+-----------------------------------------------+
-->
<#macro print_tile_team_presence widget varname="row" indent=0>
${""?left_pad(indent)}<view class="tile tile-team-presence layout-timeline">
${""?left_pad(indent)}  <view class="tile-row tile-header">
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "avatars")>
${""?left_pad(indent)}    <view class="tile-avatars"><image wx:for="{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "avatars"))} }}" wx:for-item="av" wx:key="*this" src="{{ av }}" class="tile-avatar-img"></image></view>
${""?left_pad(indent)}    </#if>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}  <view class="tile-body">
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "primary")><view class="tile-primary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))} }}</view></#if>
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "secondary")><view class="tile-secondary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "secondary"))} }}</view></#if>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}  <view class="tile-footer">
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "start_time")><text class="tile-start-time">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "start_time"))} }}</text></#if>
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "status")><text class="tile-status">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))} }}</text></#if>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}</view>
</#macro>
```

---

### WXML 瓦片模板设计 (101 至 140)

```xml
<#--
 ###############################################################################
 ### 瓦片模板定义 101 至 140
 ###############################################################################
-->

<#--
101. org_chart_node (组织架构节点)
+-----------------------------------------------+
| +-------+  [primary]                          |
| |avatar |  [secondary]                        |
| +-------+  [tertiary]                         |
+-----------------------------------------------+
-->
<#macro print_tile_org_chart_node widget varname="row" indent=0>
${""?left_pad(indent)}<view class="tile tile-org-chart-node layout-profile">
${""?left_pad(indent)}  <view class="tile-row">
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "avatar")><view class="tile-avatar"><image src="{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "avatar"))} }}"></image></view></#if>
${""?left_pad(indent)}    <view class="tile-body">
${""?left_pad(indent)}      <#if guidbase.has_child_widget(widget, "primary")><view class="tile-primary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))} }}</view></#if>
${""?left_pad(indent)}      <#if guidbase.has_child_widget(widget, "secondary")><view class="tile-secondary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "secondary"))} }}</view></#if>
${""?left_pad(indent)}      <#if guidbase.has_child_widget(widget, "tertiary")><view class="tile-tertiary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "tertiary"))} }}</view></#if>
${""?left_pad(indent)}    </view>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}</view>
</#macro>

<#--
102. contact_card (联系人卡片)
+-----------------------------------------------+
| +-------+  [primary]                          |
| |avatar |  [secondary]                        |
| +-------+                                     |
| [tags]                               [status] |
+-----------------------------------------------+
-->
<#macro print_tile_contact_card widget varname="row" indent=0>
${""?left_pad(indent)}<view class="tile tile-contact-card layout-profile">
${""?left_pad(indent)}  <view class="tile-row">
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "avatar")><view class="tile-avatar"><image src="{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "avatar"))} }}"></image></view></#if>
${""?left_pad(indent)}    <view class="tile-body">
${""?left_pad(indent)}      <#if guidbase.has_child_widget(widget, "primary")><view class="tile-primary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))} }}</view></#if>
${""?left_pad(indent)}      <#if guidbase.has_child_widget(widget, "secondary")><view class="tile-secondary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "secondary"))} }}</view></#if>
${""?left_pad(indent)}    </view>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}  <view class="tile-footer">
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "tags")>
${""?left_pad(indent)}    <view class="tile-tags"><text wx:for="{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "tags"))} }}" wx:for-item="tag" wx:key="*this" class="tile-tag">{{ tag }}</text></view>
${""?left_pad(indent)}    </#if>
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "status")><text class="tile-status">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))} }}</text></#if>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}</view>
</#macro>

<#--
103. user_activity (用户动态)
+-----------------------------------------------+
| +-------+  [primary]             [start_time] |
| |avatar |  [tertiary]                         |
| +-------+                                     |
|                                      [status] |
+-----------------------------------------------+
-->
<#macro print_tile_user_activity widget varname="row" indent=0>
${""?left_pad(indent)}<view class="tile tile-user-activity layout-timeline">
${""?left_pad(indent)}  <view class="tile-row">
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "avatar")><view class="tile-avatar"><image src="{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "avatar"))} }}"></image></view></#if>
${""?left_pad(indent)}    <view class="tile-body">
${""?left_pad(indent)}      <view class="tile-row tile-header">
${""?left_pad(indent)}        <#if guidbase.has_child_widget(widget, "primary")><view class="tile-primary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))} }}</view></#if>
${""?left_pad(indent)}        <#if guidbase.has_child_widget(widget, "start_time")><text class="tile-start-time">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "start_time"))} }}</text></#if>
${""?left_pad(indent)}      </view>
${""?left_pad(indent)}      <#if guidbase.has_child_widget(widget, "tertiary")><view class="tile-tertiary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "tertiary"))} }}</view></#if>
${""?left_pad(indent)}    </view>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}  <view class="tile-footer">
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "status")><text class="tile-status">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))} }}</text></#if>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}</view>
</#macro>

<#--
104. access_log (访问日志)
+-----------------------------------------------+
| +-------+  [primary]                          |
| |avatar |  [secondary]                        |
| +-------+                                     |
| [start_time] - [end_time]            [status] |
+-----------------------------------------------+
-->
<#macro print_tile_access_log widget varname="row" indent=0>
${""?left_pad(indent)}<view class="tile tile-access-log layout-timeline">
${""?left_pad(indent)}  <view class="tile-row">
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "avatar")><view class="tile-avatar"><image src="{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "avatar"))} }}"></image></view></#if>
${""?left_pad(indent)}    <view class="tile-body">
${""?left_pad(indent)}      <#if guidbase.has_child_widget(widget, "primary")><view class="tile-primary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))} }}</view></#if>
${""?left_pad(indent)}      <#if guidbase.has_child_widget(widget, "secondary")><view class="tile-secondary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "secondary"))} }}</view></#if>
${""?left_pad(indent)}    </view>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}  <view class="tile-footer">
${""?left_pad(indent)}    <text class="tile-time">
${""?left_pad(indent)}      <#if guidbase.has_child_widget(widget, "start_time")><text>{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "start_time"))} }}</text></#if>
${""?left_pad(indent)}      <#if guidbase.has_child_widget(widget, "start_time") && guidbase.has_child_widget(widget, "end_time")><text> - </text></#if>
${""?left_pad(indent)}      <#if guidbase.has_child_widget(widget, "end_time")><text>{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "end_time"))} }}</text></#if>
${""?left_pad(indent)}    </text>
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "status")><text class="tile-status">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))} }}</text></#if>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}</view>
</#macro>

<#--
105. security_alert (安全警报)
+===============================================+
|                 [background]                  |
|                                               |
|  [status]                                     |
|  [primary]                                    |
|  [secondary]                                  |
+===============================================+
-->
<#macro print_tile_security_alert widget varname="row" indent=0>
${""?left_pad(indent)}<view class="tile tile-security-alert layout-background">
${""?left_pad(indent)}  <#if guidbase.has_child_widget(widget, "background")>
${""?left_pad(indent)}  <view class="tile-background"><image src="{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "background"))} }}"></image></view>
${""?left_pad(indent)}  </#if>
${""?left_pad(indent)}  <view class="tile-overlay">
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "status")><view class="tile-status">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))} }}</view></#if>
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "primary")><view class="tile-primary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))} }}</view></#if>
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "secondary")><view class="tile-secondary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "secondary"))} }}</view></#if>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}</view>
</#macro>

<#--
106. system_health (系统状态)
+===============================================+
|                 [background]                  |
|                                               |
|  [primary]                                    |
|                                               |
|  [start_time]                        [status] |
+===============================================+
-->
<#macro print_tile_system_health widget varname="row" indent=0>
${""?left_pad(indent)}<view class="tile tile-system-health layout-background">
${""?left_pad(indent)}  <#if guidbase.has_child_widget(widget, "background")>
${""?left_pad(indent)}  <view class="tile-background"><image src="{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "background"))} }}"></image></view>
${""?left_pad(indent)}  </#if>
${""?left_pad(indent)}  <view class="tile-overlay">
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "primary")><view class="tile-primary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))} }}</view></#if>
${""?left_pad(indent)}    <view class="tile-footer">
${""?left_pad(indent)}      <#if guidbase.has_child_widget(widget, "start_time")><text class="tile-start-time">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "start_time"))} }}</text></#if>
${""?left_pad(indent)}      <#if guidbase.has_child_widget(widget, "status")><text class="tile-status">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))} }}</text></#if>
${""?left_pad(indent)}    </view>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}</view>
</#macro>

<#--
107. service_status (服务状态)
+-----------------------------------------------+
| [status]                                      |
|                                               |
| [primary]                                     |
| [secondary]                                   |
| [tertiary]                                    |
+-----------------------------------------------+
-->
<#macro print_tile_service_status widget varname="row" indent=0>
${""?left_pad(indent)}<view class="tile tile-service-status layout-content">
${""?left_pad(indent)}  <view class="tile-row tile-header">
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "status")><text class="tile-status">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))} }}</text></#if>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}  <view class="tile-body">
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "primary")><view class="tile-primary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))} }}</view></#if>
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "secondary")><view class="tile-secondary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "secondary"))} }}</view></#if>
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "tertiary")><view class="tile-tertiary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "tertiary"))} }}</view></#if>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}</view>
</#macro>

<#--
108. api_endpoint (接口终端)
+-----------------------------------------------+
| [primary]                            [status] |
| [secondary]                                   |
|                                               |
| [tags]                             [end_time] |
+-----------------------------------------------+
-->
<#macro print_tile_api_endpoint widget varname="row" indent=0>
${""?left_pad(indent)}<view class="tile tile-api-endpoint layout-timeline">
${""?left_pad(indent)}  <view class="tile-row tile-header">
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "primary")><view class="tile-primary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))} }}</view></#if>
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "status")><view class="tile-status">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))} }}</view></#if>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}  <view class="tile-body">
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "secondary")><view class="tile-secondary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "secondary"))} }}</view></#if>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}  <view class="tile-footer">
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "tags")>
${""?left_pad(indent)}    <view class="tile-tags"><text wx:for="{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "tags"))} }}" wx:for-item="tag" wx:key="*this" class="tile-tag">{{ tag }}</text></view>
${""?left_pad(indent)}    </#if>
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "end_time")><text class="tile-end-time">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "end_time"))} }}</text></#if>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}</view>
</#macro>

<#--
109. release_note (版本说明)
+-----------------------------------------------+
| +-------------------------------------------+ |
| |                  [image]                  | |
| +-------------------------------------------+ |
| [primary]                                     |
| [secondary]                                   |
|                                               |
| [tags]                           [start_time] |
+-----------------------------------------------+
-->
<#macro print_tile_release_note widget varname="row" indent=0>
${""?left_pad(indent)}<view class="tile tile-release-note layout-media">
${""?left_pad(indent)}  <#if guidbase.has_child_widget(widget, "image")>
${""?left_pad(indent)}  <view class="tile-image"><image src="{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "image"))} }}"></image></view>
${""?left_pad(indent)}  </#if>
${""?left_pad(indent)}  <view class="tile-body">
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "primary")><view class="tile-primary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))} }}</view></#if>
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "secondary")><view class="tile-secondary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "secondary"))} }}</view></#if>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}  <view class="tile-footer">
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "tags")>
${""?left_pad(indent)}    <view class="tile-tags"><text wx:for="{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "tags"))} }}" wx:for-item="tag" wx:key="*this" class="tile-tag">{{ tag }}</text></view>
${""?left_pad(indent)}    </#if>
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "start_time")><text class="tile-start-time">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "start_time"))} }}</text></#if>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}</view>
</#macro>

<#--
110. version_badge (版本徽章)
+-----------------------------------------------+
| [status]                         [start_time] |
|                                               |
| [primary]                                     |
| [secondary]                                   |
+-----------------------------------------------+
-->
<#macro print_tile_version_badge widget varname="row" indent=0>
${""?left_pad(indent)}<view class="tile tile-version-badge layout-timeline">
${""?left_pad(indent)}  <view class="tile-row tile-header">
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "status")><text class="tile-status">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))} }}</text></#if>
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "start_time")><text class="tile-start-time">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "start_time"))} }}</text></#if>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}  <view class="tile-body">
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "primary")><view class="tile-primary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))} }}</view></#if>
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "secondary")><view class="tile-secondary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "secondary"))} }}</view></#if>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}</view>
</#macro>

<#--
111. deployment_event (部署事件)
+-----------------------------------------------+
| [status]                                      |
| [primary]                                     |
| [secondary]                                   |
|                                               |
| [start_time] - [end_time]            [avatars]|
+-----------------------------------------------+
-->
<#macro print_tile_deployment_event widget varname="row" indent=0>
${""?left_pad(indent)}<view class="tile tile-deployment-event layout-timeline">
${""?left_pad(indent)}  <view class="tile-row tile-header">
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "status")><text class="tile-status">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))} }}</text></#if>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}  <view class="tile-body">
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "primary")><view class="tile-primary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))} }}</view></#if>
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "secondary")><view class="tile-secondary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "secondary"))} }}</view></#if>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}  <view class="tile-footer">
${""?left_pad(indent)}    <text class="tile-time">
${""?left_pad(indent)}      <#if guidbase.has_child_widget(widget, "start_time")><text>{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "start_time"))} }}</text></#if>
${""?left_pad(indent)}      <#if guidbase.has_child_widget(widget, "start_time") && guidbase.has_child_widget(widget, "end_time")><text> - </text></#if>
${""?left_pad(indent)}      <#if guidbase.has_child_widget(widget, "end_time")><text>{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "end_time"))} }}</text></#if>
${""?left_pad(indent)}    </text>
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "avatars")>
${""?left_pad(indent)}    <view class="tile-avatars"><image wx:for="{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "avatars"))} }}" wx:for-item="av" wx:key="*this" src="{{ av }}" class="tile-avatar-img"></image></view>
${""?left_pad(indent)}    </#if>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}</view>
</#macro>

<#--
112. commit_item (提交纪录)
+-----------------------------------------------+
| +-------+  [primary]             [start_time] |
| |avatar |  [secondary]                        |
| +-------+                                     |
| [tags]                                        |
+-----------------------------------------------+
-->
<#macro print_tile_commit_item widget varname="row" indent=0>
${""?left_pad(indent)}<view class="tile tile-commit-item layout-timeline">
${""?left_pad(indent)}  <view class="tile-row">
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "avatar")><view class="tile-avatar"><image src="{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "avatar"))} }}"></image></view></#if>
${""?left_pad(indent)}    <view class="tile-body">
${""?left_pad(indent)}      <view class="tile-row tile-header">
${""?left_pad(indent)}        <#if guidbase.has_child_widget(widget, "primary")><view class="tile-primary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))} }}</view></#if>
${""?left_pad(indent)}        <#if guidbase.has_child_widget(widget, "start_time")><text class="tile-start-time">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "start_time"))} }}</text></#if>
${""?left_pad(indent)}      </view>
${""?left_pad(indent)}      <#if guidbase.has_child_widget(widget, "secondary")><view class="tile-secondary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "secondary"))} }}</view></#if>
${""?left_pad(indent)}    </view>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}  <#if guidbase.has_child_widget(widget, "tags")>
${""?left_pad(indent)}  <view class="tile-footer">
${""?left_pad(indent)}    <view class="tile-tags"><text wx:for="{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "tags"))} }}" wx:for-item="tag" wx:key="*this" class="tile-tag">{{ tag }}</text></view>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}  </#if>
${""?left_pad(indent)}</view>
</#macro>

<#--
113. build_result (编译结果)
+-----------------------------------------------+
| [status]                           [end_time] |
|                                               |
| [primary]                                     |
| [secondary]                                   |
+-----------------------------------------------+
-->
<#macro print_tile_build_result widget varname="row" indent=0>
${""?left_pad(indent)}<view class="tile tile-build-result layout-timeline">
${""?left_pad(indent)}  <view class="tile-row tile-header">
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "status")><text class="tile-status">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))} }}</text></#if>
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "end_time")><text class="tile-end-time">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "end_time"))} }}</text></#if>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}  <view class="tile-body">
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "primary")><view class="tile-primary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))} }}</view></#if>
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "secondary")><view class="tile-secondary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "secondary"))} }}</view></#if>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}</view>
</#macro>

<#--
114. file_preview (文件预览)
+-----------------------------------------------+
| +-------------------------------------------+ |
| |                  [image]                  | |
| +-------------------------------------------+ |
| [primary]                                     |
| [secondary]                                   |
|                                               |
|                                      [status] |
+-----------------------------------------------+
-->
<#macro print_tile_file_preview widget varname="row" indent=0>
${""?left_pad(indent)}<view class="tile tile-file-preview layout-media">
${""?left_pad(indent)}  <#if guidbase.has_child_widget(widget, "image")>
${""?left_pad(indent)}  <view class="tile-image"><image src="{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "image"))} }}"></image></view>
${""?left_pad(indent)}  </#if>
${""?left_pad(indent)}  <view class="tile-body">
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "primary")><view class="tile-primary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))} }}</view></#if>
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "secondary")><view class="tile-secondary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "secondary"))} }}</view></#if>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}  <view class="tile-footer">
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "status")><text class="tile-status">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))} }}</text></#if>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}</view>
</#macro>

<#--
115. folder_summary (文件夹摘要)
+-----------------------------------------------+
| +-------------------------------------------+ |
| |                  [image]                  | |
| +-------------------------------------------+ |
| [primary]                                     |
| [secondary]                                   |
|                                               |
| [avatars]                            [status] |
+-----------------------------------------------+
-->
<#macro print_tile_folder_summary widget varname="row" indent=0>
${""?left_pad(indent)}<view class="tile tile-folder-summary layout-media">
${""?left_pad(indent)}  <#if guidbase.has_child_widget(widget, "image")>
${""?left_pad(indent)}  <view class="tile-image"><image src="{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "image"))} }}"></image></view>
${""?left_pad(indent)}  </#if>
${""?left_pad(indent)}  <view class="tile-body">
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "primary")><view class="tile-primary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))} }}</view></#if>
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "secondary")><view class="tile-secondary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "secondary"))} }}</view></#if>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}  <view class="tile-footer">
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "avatars")>
${""?left_pad(indent)}    <view class="tile-avatars"><image wx:for="{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "avatars"))} }}" wx:for-item="av" wx:key="*this" src="{{ av }}" class="tile-avatar-img"></image></view>
${""?left_pad(indent)}    </#if>
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "status")><text class="tile-status">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))} }}</text></#if>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}</view>
</#macro>

<#--
116. media_collection (媒体集合)
+-----------------------------------------------+
| +-------------------------------------------+ |
| |                  [image]                  | |
| +-------------------------------------------+ |
| [primary]                                     |
|                                               |
| [tags]                               [status] |
| [avatars]                                     |
+-----------------------------------------------+
-->
<#macro print_tile_media_collection widget varname="row" indent=0>
${""?left_pad(indent)}<view class="tile tile-media-collection layout-media">
${""?left_pad(indent)}  <#if guidbase.has_child_widget(widget, "image")>
${""?left_pad(indent)}  <view class="tile-image"><image src="{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "image"))} }}"></image></view>
${""?left_pad(indent)}  </#if>
${""?left_pad(indent)}  <view class="tile-body">
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "primary")><view class="tile-primary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))} }}</view></#if>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}  <view class="tile-footer">
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "tags")>
${""?left_pad(indent)}    <view class="tile-tags"><text wx:for="{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "tags"))} }}" wx:for-item="tag" wx:key="*this" class="tile-tag">{{ tag }}</text></view>
${""?left_pad(indent)}    </#if>
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "status")><text class="tile-status">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))} }}</text></#if>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}  <#if guidbase.has_child_widget(widget, "avatars")>
${""?left_pad(indent)}  <view class="tile-avatars-row">
${""?left_pad(indent)}    <view class="tile-avatars"><image wx:for="{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "avatars"))} }}" wx:for-item="av" wx:key="*this" src="{{ av }}" class="tile-avatar-img"></image></view>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}  </#if>
${""?left_pad(indent)}</view>
</#macro>

<#--
117. playlist_item (播放列表单项)
+-----------------------------------------------+
| +-------------------------------------------+ |
| |                  [image]                  | |
| +-------------------------------------------+ |
| [primary]                                     |
| [secondary]                                   |
|                                               |
|                                    [end_time] |
+-----------------------------------------------+
-->
<#macro print_tile_playlist_item widget varname="row" indent=0>
${""?left_pad(indent)}<view class="tile tile-playlist-item layout-media">
${""?left_pad(indent)}  <#if guidbase.has_child_widget(widget, "image")>
${""?left_pad(indent)}  <view class="tile-image"><image src="{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "image"))} }}"></image></view>
${""?left_pad(indent)}  </#if>
${""?left_pad(indent)}  <view class="tile-body">
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "primary")><view class="tile-primary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))} }}</view></#if>
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "secondary")><view class="tile-secondary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "secondary"))} }}</view></#if>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}  <view class="tile-footer">
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "end_time")><text class="tile-end-time">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "end_time"))} }}</text></#if>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}</view>
</#macro>

<#--
118. podcast_episode (播客单集)
+-----------------------------------------------+
| +-------------------------------------------+ |
| |                  [image]                  | |
| +-------------------------------------------+ |
| [primary]                                     |
| [secondary]                                   |
|                                               |
| [start_time]                         [status] |
+-----------------------------------------------+
-->
<#macro print_tile_podcast_episode widget varname="row" indent=0>
${""?left_pad(indent)}<view class="tile tile-podcast-episode layout-media">
${""?left_pad(indent)}  <#if guidbase.has_child_widget(widget, "image")>
${""?left_pad(indent)}  <view class="tile-image"><image src="{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "image"))} }}"></image></view>
${""?left_pad(indent)}  </#if>
${""?left_pad(indent)}  <view class="tile-body">
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "primary")><view class="tile-primary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))} }}</view></#if>
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "secondary")><view class="tile-secondary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "secondary"))} }}</view></#if>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}  <view class="tile-footer">
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "start_time")><text class="tile-start-time">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "start_time"))} }}</text></#if>
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "status")><text class="tile-status">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))} }}</text></#if>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}</view>
</#macro>

<#--
119. gallery_mosaic (画廊镶嵌)
+-----------------------------------------------+
| +-------------------------------------------+ |
| |                  [image]                  | |
| +-------------------------------------------+ |
| [primary]                                     |
|                                               |
| [tags]                               [avatars]|
+-----------------------------------------------+
-->
<#macro print_tile_gallery_mosaic widget varname="row" indent=0>
${""?left_pad(indent)}<view class="tile tile-gallery-mosaic layout-media">
${""?left_pad(indent)}  <#if guidbase.has_child_widget(widget, "image")>
${""?left_pad(indent)}  <view class="tile-image"><image src="{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "image"))} }}"></image></view>
${""?left_pad(indent)}  </#if>
${""?left_pad(indent)}  <view class="tile-body">
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "primary")><view class="tile-primary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))} }}</view></#if>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}  <view class="tile-footer">
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "tags")>
${""?left_pad(indent)}    <view class="tile-tags"><text wx:for="{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "tags"))} }}" wx:for-item="tag" wx:key="*this" class="tile-tag">{{ tag }}</text></view>
${""?left_pad(indent)}    </#if>
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "avatars")>
${""?left_pad(indent)}    <view class="tile-avatars"><image wx:for="{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "avatars"))} }}" wx:for-item="av" wx:key="*this" src="{{ av }}" class="tile-avatar-img"></image></view>
${""?left_pad(indent)}    </#if>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}</view>
</#macro>

<#--
120. message_compose (撰写消息)
+-----------------------------------------------+
| +-------+  [primary]                 [status] |
| |avatar |  [secondary]                        |
| +-------+                                     |
| [tags]                                        |
+-----------------------------------------------+
-->
<#macro print_tile_message_compose widget varname="row" indent=0>
${""?left_pad(indent)}<view class="tile tile-message-compose layout-profile">
${""?left_pad(indent)}  <view class="tile-row">
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "avatar")><view class="tile-avatar"><image src="{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "avatar"))} }}"></image></view></#if>
${""?left_pad(indent)}    <view class="tile-body">
${""?left_pad(indent)}      <view class="tile-row">
${""?left_pad(indent)}        <#if guidbase.has_child_widget(widget, "primary")><view class="tile-primary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))} }}</view></#if>
${""?left_pad(indent)}        <#if guidbase.has_child_widget(widget, "status")><view class="tile-status">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))} }}</view></#if>
${""?left_pad(indent)}      </view>
${""?left_pad(indent)}      <#if guidbase.has_child_widget(widget, "secondary")><view class="tile-secondary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "secondary"))} }}</view></#if>
${""?left_pad(indent)}    </view>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}  <#if guidbase.has_child_widget(widget, "tags")>
${""?left_pad(indent)}  <view class="tile-footer">
${""?left_pad(indent)}    <view class="tile-tags"><text wx:for="{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "tags"))} }}" wx:for-item="tag" wx:key="*this" class="tile-tag">{{ tag }}</text></view>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}  </#if>
${""?left_pad(indent)}</view>
</#macro>

<#--
121. chat_room_header (聊天室头部)
+===============================================+
|                 [background]                  |
|                                               |
|  +-------+  [primary]                [status] |
|  |avatar |  [secondary]                       |
|  +-------+                                    |
+===============================================+
-->
<#macro print_tile_chat_room_header widget varname="row" indent=0>
${""?left_pad(indent)}<view class="tile tile-chat-room-header layout-background">
${""?left_pad(indent)}  <#if guidbase.has_child_widget(widget, "background")>
${""?left_pad(indent)}  <view class="tile-background"><image src="{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "background"))} }}"></image></view>
${""?left_pad(indent)}  </#if>
${""?left_pad(indent)}  <view class="tile-overlay">
${""?left_pad(indent)}    <view class="tile-row">
${""?left_pad(indent)}      <#if guidbase.has_child_widget(widget, "avatar")><view class="tile-avatar"><image src="{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "avatar"))} }}"></image></view></#if>
${""?left_pad(indent)}      <view class="tile-body">
${""?left_pad(indent)}        <#if guidbase.has_child_widget(widget, "primary")><view class="tile-primary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))} }}</view></#if>
${""?left_pad(indent)}        <#if guidbase.has_child_widget(widget, "secondary")><view class="tile-secondary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "secondary"))} }}</view></#if>
${""?left_pad(indent)}      </view>
${""?left_pad(indent)}      <#if guidbase.has_child_widget(widget, "status")><text class="tile-status">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))} }}</text></#if>
${""?left_pad(indent)}    </view>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}</view>
</#macro>

<#--
122. chat_attachment (聊天附件)
+-----------------------------------------------+
| +-------------------------------------------+ |
| |                  [image]                  | |
| +-------------------------------------------+ |
| [primary]                                     |
| [secondary]                          [status] |
+-----------------------------------------------+
-->
<#macro print_tile_chat_attachment widget varname="row" indent=0>
${""?left_pad(indent)}<view class="tile tile-chat-attachment layout-media">
${""?left_pad(indent)}  <#if guidbase.has_child_widget(widget, "image")>
${""?left_pad(indent)}  <view class="tile-image"><image src="{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "image"))} }}"></image></view>
${""?left_pad(indent)}  </#if>
${""?left_pad(indent)}  <view class="tile-body">
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "primary")><view class="tile-primary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))} }}</view></#if>
${""?left_pad(indent)}    <view class="tile-row">
${""?left_pad(indent)}      <#if guidbase.has_child_widget(widget, "secondary")><text class="tile-secondary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "secondary"))} }}</text></#if>
${""?left_pad(indent)}      <#if guidbase.has_child_widget(widget, "status")><text class="tile-status">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))} }}</text></#if>
${""?left_pad(indent)}    </view>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}</view>
</#macro>

<#--
123. voice_message (语音消息)
+-----------------------------------------------+
| +-------+  [primary]                          |
| |avatar |  [start_time] ---------- [end_time] |
| +-------+                                     |
|                                      [status] |
+-----------------------------------------------+
-->
<#macro print_tile_voice_message widget varname="row" indent=0>
${""?left_pad(indent)}<view class="tile tile-voice-message layout-timeline">
${""?left_pad(indent)}  <view class="tile-row">
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "avatar")><view class="tile-avatar"><image src="{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "avatar"))} }}"></image></view></#if>
${""?left_pad(indent)}    <view class="tile-body">
${""?left_pad(indent)}      <#if guidbase.has_child_widget(widget, "primary")><view class="tile-primary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))} }}</view></#if>
${""?left_pad(indent)}      <view class="tile-progress">
${""?left_pad(indent)}        <#if guidbase.has_child_widget(widget, "start_time")><text class="tile-start-time">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "start_time"))} }}</text></#if>
${""?left_pad(indent)}        <text class="tile-progress-line">──</text>
${""?left_pad(indent)}        <#if guidbase.has_child_widget(widget, "end_time")><text class="tile-end-time">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "end_time"))} }}</text></#if>
${""?left_pad(indent)}      </view>
${""?left_pad(indent)}    </view>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}  <view class="tile-footer">
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "status")><text class="tile-status">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))} }}</text></#if>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}</view>
</#macro>

<#--
124. call_history (通话历史)
+-----------------------------------------------+
| +-------+  [primary]             [start_time] |
| |avatar |  [secondary]                        |
| +-------+                          [end_time] |
+-----------------------------------------------+
-->
<#macro print_tile_call_history widget varname="row" indent=0>
${""?left_pad(indent)}<view class="tile tile-call-history layout-timeline">
${""?left_pad(indent)}  <view class="tile-row">
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "avatar")><view class="tile-avatar"><image src="{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "avatar"))} }}"></image></view></#if>
${""?left_pad(indent)}    <view class="tile-body">
${""?left_pad(indent)}      <view class="tile-row tile-header">
${""?left_pad(indent)}        <#if guidbase.has_child_widget(widget, "primary")><view class="tile-primary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))} }}</view></#if>
${""?left_pad(indent)}        <#if guidbase.has_child_widget(widget, "start_time")><text class="tile-start-time">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "start_time"))} }}</text></#if>
${""?left_pad(indent)}      </view>
${""?left_pad(indent)}      <#if guidbase.has_child_widget(widget, "secondary")><view class="tile-secondary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "secondary"))} }}</view></#if>
${""?left_pad(indent)}      <#if guidbase.has_child_widget(widget, "end_time")><view class="tile-end-time">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "end_time"))} }}</view></#if>
${""?left_pad(indent)}    </view>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}</view>
</#macro>

<#--
125. video_call (视频通话)
+===============================================+
|                 [background]                  |
|                                               |
|  [avatars]                                    |
|                                               |
|  [primary]                           [status] |
|  [start_time]                                 |
+===============================================+
-->
<#macro print_tile_video_call widget varname="row" indent=0>
${""?left_pad(indent)}<view class="tile tile-video-call layout-background">
${""?left_pad(indent)}  <#if guidbase.has_child_widget(widget, "background")>
${""?left_pad(indent)}  <view class="tile-background"><image src="{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "background"))} }}"></image></view>
${""?left_pad(indent)}  </#if>
${""?left_pad(indent)}  <view class="tile-overlay">
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "avatars")>
${""?left_pad(indent)}    <view class="tile-avatars"><image wx:for="{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "avatars"))} }}" wx:for-item="av" wx:key="*this" src="{{ av }}" class="tile-avatar-img"></image></view>
${""?left_pad(indent)}    </#if>
${""?left_pad(indent)}    <view class="tile-footer">
${""?left_pad(indent)}      <#if guidbase.has_child_widget(widget, "primary")><view class="tile-primary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))} }}</view></#if>
${""?left_pad(indent)}      <#if guidbase.has_child_widget(widget, "start_time")><text class="tile-start-time">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "start_time"))} }}</text></#if>
${""?left_pad(indent)}      <#if guidbase.has_child_widget(widget, "status")><text class="tile-status">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))} }}</text></#if>
${""?left_pad(indent)}    </view>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}</view>
</#macro>

<#--
126. contact_merge (合并联系人)
+-----------------------------------------------+
| +-------+  [primary]                 [status] |
| |avatar |  [secondary]                        |
| +-------+  [tertiary]                         |
+-----------------------------------------------+
-->
<#macro print_tile_contact_merge widget varname="row" indent=0>
${""?left_pad(indent)}<view class="tile tile-contact-merge layout-profile">
${""?left_pad(indent)}  <view class="tile-row">
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "avatar")><view class="tile-avatar"><image src="{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "avatar"))} }}"></image></view></#if>
${""?left_pad(indent)}    <view class="tile-body">
${""?left_pad(indent)}      <view class="tile-row">
${""?left_pad(indent)}        <#if guidbase.has_child_widget(widget, "primary")><view class="tile-primary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))} }}</view></#if>
${""?left_pad(indent)}        <#if guidbase.has_child_widget(widget, "status")><view class="tile-status">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))} }}</view></#if>
${""?left_pad(indent)}      </view>
${""?left_pad(indent)}      <#if guidbase.has_child_widget(widget, "secondary")><view class="tile-secondary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "secondary"))} }}</view></#if>
${""?left_pad(indent)}      <#if guidbase.has_child_widget(widget, "tertiary")><view class="tile-tertiary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "tertiary"))} }}</view></#if>
${""?left_pad(indent)}    </view>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}</view>
</#macro>

<#--
127. address_book_group (通讯录分组)
+-----------------------------------------------+
| [avatars]                                     |
| [primary]                                     |
| [secondary]                                   |
|                                               |
| [tags]                                        |
+-----------------------------------------------+
-->
<#macro print_tile_address_book_group widget varname="row" indent=0>
${""?left_pad(indent)}<view class="tile tile-address-book-group layout-profile">
${""?left_pad(indent)}  <#if guidbase.has_child_widget(widget, "avatars")>
${""?left_pad(indent)}  <view class="tile-avatars-row">
${""?left_pad(indent)}    <view class="tile-avatars"><image wx:for="{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "avatars"))} }}" wx:for-item="av" wx:key="*this" src="{{ av }}" class="tile-avatar-img"></image></view>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}  </#if>
${""?left_pad(indent)}  <view class="tile-body">
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "primary")><view class="tile-primary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))} }}</view></#if>
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "secondary")><view class="tile-secondary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "secondary"))} }}</view></#if>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}  <#if guidbase.has_child_widget(widget, "tags")>
${""?left_pad(indent)}  <view class="tile-footer">
${""?left_pad(indent)}    <view class="tile-tags"><text wx:for="{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "tags"))} }}" wx:for-item="tag" wx:key="*this" class="tile-tag">{{ tag }}</text></view>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}  </#if>
${""?left_pad(indent)}</view>
</#macro>

<#--
128. favorite_item (收藏项)
+-----------------------------------------------+
| +-------------------------------------------+ |
| |                  [image]                  | |
| +-------------------------------------------+ |
| [primary]                                     |
| [secondary]                                   |
|                                               |
| [tags]                                        |
+-----------------------------------------------+
-->
<#macro print_tile_favorite_item widget varname="row" indent=0>
${""?left_pad(indent)}<view class="tile tile-favorite-item layout-media">
${""?left_pad(indent)}  <#if guidbase.has_child_widget(widget, "image")>
${""?left_pad(indent)}  <view class="tile-image"><image src="{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "image"))} }}"></image></view>
${""?left_pad(indent)}  </#if>
${""?left_pad(indent)}  <view class="tile-body">
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "primary")><view class="tile-primary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))} }}</view></#if>
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "secondary")><view class="tile-secondary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "secondary"))} }}</view></#if>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}  <#if guidbase.has_child_widget(widget, "tags")>
${""?left_pad(indent)}  <view class="tile-footer">
${""?left_pad(indent)}    <view class="tile-tags"><text wx:for="{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "tags"))} }}" wx:for-item="tag" wx:key="*this" class="tile-tag">{{ tag }}</text></view>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}  </#if>
${""?left_pad(indent)}</view>
</#macro>

<#--
129. saved_search (保存的搜索)
+-----------------------------------------------+
| [primary]                            [status] |
| [secondary]                                   |
|                                               |
| [tags]                                        |
+-----------------------------------------------+
-->
<#macro print_tile_saved_search widget varname="row" indent=0>
${""?left_pad(indent)}<view class="tile tile-saved-search layout-content">
${""?left_pad(indent)}  <view class="tile-row tile-header">
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "primary")><view class="tile-primary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))} }}</view></#if>
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "status")><view class="tile-status">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))} }}</view></#if>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}  <view class="tile-body">
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "secondary")><view class="tile-secondary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "secondary"))} }}</view></#if>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}  <#if guidbase.has_child_widget(widget, "tags")>
${""?left_pad(indent)}  <view class="tile-footer">
${""?left_pad(indent)}    <view class="tile-tags"><text wx:for="{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "tags"))} }}" wx:for-item="tag" wx:key="*this" class="tile-tag">{{ tag }}</text></view>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}  </#if>
${""?left_pad(indent)}</view>
</#macro>

<#--
130. filter_summary (筛选小结)
+-----------------------------------------------+
| [tags]                               [status] |
|                                               |
| [primary]                                     |
| [secondary]                                   |
+-----------------------------------------------+
-->
<#macro print_tile_filter_summary widget varname="row" indent=0>
${""?left_pad(indent)}<view class="tile tile-filter-summary layout-content">
${""?left_pad(indent)}  <view class="tile-row tile-header">
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "tags")>
${""?left_pad(indent)}    <view class="tile-tags"><text wx:for="{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "tags"))} }}" wx:for-item="tag" wx:key="*this" class="tile-tag">{{ tag }}</text></view>
${""?left_pad(indent)}    </#if>
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "status")><view class="tile-status">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))} }}</view></#if>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}  <view class="tile-body">
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "primary")><view class="tile-primary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))} }}</view></#if>
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "secondary")><view class="tile-secondary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "secondary"))} }}</view></#if>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}</view>
</#macro>

<#--
131. sort_option (排序选项)
+-----------------------------------------------+
| [primary]                            [status] |
| [secondary]                                   |
+-----------------------------------------------+
-->
<#macro print_tile_sort_option widget varname="row" indent=0>
${""?left_pad(indent)}<view class="tile tile-sort-option layout-content">
${""?left_pad(indent)}  <view class="tile-row tile-header">
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "primary")><view class="tile-primary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))} }}</view></#if>
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "status")><view class="tile-status">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))} }}</view></#if>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}  <view class="tile-body">
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "secondary")><view class="tile-secondary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "secondary"))} }}</view></#if>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}</view>
</#macro>

<#--
132. search_result (搜索结果)
+-----------------------------------------------+
| +-------------------------------------------+ |
| |                  [image]                  | |
| +-------------------------------------------+ |
| [primary]                                     |
| [secondary]                                   |
| [tertiary]                                    |
|                                               |
| [tags]                                        |
+-----------------------------------------------+
-->
<#macro print_tile_search_result widget varname="row" indent=0>
${""?left_pad(indent)}<view class="tile tile-search-result layout-media">
${""?left_pad(indent)}  <#if guidbase.has_child_widget(widget, "image")>
${""?left_pad(indent)}  <view class="tile-image"><image src="{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "image"))} }}"></image></view>
${""?left_pad(indent)}  </#if>
${""?left_pad(indent)}  <view class="tile-body">
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "primary")><view class="tile-primary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))} }}</view></#if>
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "secondary")><view class="tile-secondary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "secondary"))} }}</view></#if>
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "tertiary")><view class="tile-tertiary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "tertiary"))} }}</view></#if>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}  <#if guidbase.has_child_widget(widget, "tags")>
${""?left_pad(indent)}  <view class="tile-footer">
${""?left_pad(indent)}    <view class="tile-tags"><text wx:for="{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "tags"))} }}" wx:for-item="tag" wx:key="*this" class="tile-tag">{{ tag }}</text></view>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}  </#if>
${""?left_pad(indent)}</view>
</#macro>

<#--
133. search_suggestion (搜索推荐)
+-----------------------------------------------+
| [primary]                                     |
| [secondary]                                   |
|                                               |
| [tags]                                        |
+-----------------------------------------------+
-->
<#macro print_tile_search_suggestion widget varname="row" indent=0>
${""?left_pad(indent)}<view class="tile tile-search-suggestion layout-content">
${""?left_pad(indent)}  <view class="tile-body">
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "primary")><view class="tile-primary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))} }}</view></#if>
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "secondary")><view class="tile-secondary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "secondary"))} }}</view></#if>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}  <#if guidbase.has_child_widget(widget, "tags")>
${""?left_pad(indent)}  <view class="tile-footer">
${""?left_pad(indent)}    <view class="tile-tags"><text wx:for="{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "tags"))} }}" wx:for-item="tag" wx:key="*this" class="tile-tag">{{ tag }}</text></view>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}  </#if>
${""?left_pad(indent)}</view>
</#macro>

<#--
134. empty_state_panel (空白状态面板)
+===============================================+
|                 [background]                  |
|                                               |
|  [primary]                                    |
|  [secondary]                                  |
|                                               |
|  [status]                                     |
+===============================================+
-->
<#macro print_tile_empty_state_panel widget varname="row" indent=0>
${""?left_pad(indent)}<view class="tile tile-empty-state-panel layout-background">
${""?left_pad(indent)}  <#if guidbase.has_child_widget(widget, "background")>
${""?left_pad(indent)}  <view class="tile-background"><image src="{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "background"))} }}"></image></view>
${""?left_pad(indent)}  </#if>
${""?left_pad(indent)}  <view class="tile-overlay">
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "primary")><view class="tile-primary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))} }}</view></#if>
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "secondary")><view class="tile-secondary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "secondary"))} }}</view></#if>
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "status")><view class="tile-status">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))} }}</view></#if>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}</view>
</#macro>

<#--
135. error_state_panel (异常状态面板)
+===============================================+
|                 [background]                  |
|                                               |
|  [status]                                     |
|  [primary]                                    |
|  [secondary]                                  |
|  [tags]                                       |
+===============================================+
-->
<#macro print_tile_error_state_panel widget varname="row" indent=0>
${""?left_pad(indent)}<view class="tile tile-error-state-panel layout-background">
${""?left_pad(indent)}  <#if guidbase.has_child_widget(widget, "background")>
${""?left_pad(indent)}  <view class="tile-background"><image src="{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "background"))} }}"></image></view>
${""?left_pad(indent)}  </#if>
${""?left_pad(indent)}  <view class="tile-overlay">
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "status")><view class="tile-status">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))} }}</view></#if>
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "primary")><view class="tile-primary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))} }}</view></#if>
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "secondary")><view class="tile-secondary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "secondary"))} }}</view></#if>
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "tags")>
${""?left_pad(indent)}    <view class="tile-tags"><text wx:for="{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "tags"))} }}" wx:for-item="tag" wx:key="*this" class="tile-tag">{{ tag }}</text></view>
${""?left_pad(indent)}    </#if>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}</view>
</#macro>

<#--
136. maintenance_notice (维护公告)
+===============================================+
|                 [background]                  |
|                                               |
|  [status]                                     |
|  [primary]                                    |
|                                               |
|  [start_time] - [end_time]                    |
+===============================================+
-->
<#macro print_tile_maintenance_notice widget varname="row" indent=0>
${""?left_pad(indent)}<view class="tile tile-maintenance-notice layout-background">
${""?left_pad(indent)}  <#if guidbase.has_child_widget(widget, "background")>
${""?left_pad(indent)}  <view class="tile-background"><image src="{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "background"))} }}"></image></view>
${""?left_pad(indent)}  </#if>
${""?left_pad(indent)}  <view class="tile-overlay">
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "status")><view class="tile-status">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))} }}</view></#if>
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "primary")><view class="tile-primary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))} }}</view></#if>
${""?left_pad(indent)}    <view class="tile-footer">
${""?left_pad(indent)}      <text class="tile-time">
${""?left_pad(indent)}        <#if guidbase.has_child_widget(widget, "start_time")><text>{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "start_time"))} }}</text></#if>
${""?left_pad(indent)}        <#if guidbase.has_child_widget(widget, "start_time") && guidbase.has_child_widget(widget, "end_time")><text> - </text></#if>
${""?left_pad(indent)}        <#if guidbase.has_child_widget(widget, "end_time")><text>{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "end_time"))} }}</text></#if>
${""?left_pad(indent)}      </text>
${""?left_pad(indent)}    </view>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}</view>
</#macro>

<#--
137. feature_flag (功能开关)
+-----------------------------------------------+
| [status]                         [start_time] |
|                                               |
| [primary]                                     |
| [secondary]                                   |
+-----------------------------------------------+
-->
<#macro print_tile_feature_flag widget varname="row" indent=0>
${""?left_pad(indent)}<view class="tile tile-feature-flag layout-timeline">
${""?left_pad(indent)}  <view class="tile-row tile-header">
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "status")><text class="tile-status">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))} }}</text></#if>
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "start_time")><text class="tile-start-time">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "start_time"))} }}</text></#if>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}  <view class="tile-body">
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "primary")><view class="tile-primary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))} }}</view></#if>
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "secondary")><view class="tile-secondary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "secondary"))} }}</view></#if>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}</view>
</#macro>

<#--
138. experiment_variant (实验变量)
+-----------------------------------------------+
| [tags]                               [status] |
|                                               |
| [primary]                                     |
| [secondary]                                   |
|                                               |
| [avatars]                                     |
+-----------------------------------------------+
-->
<#macro print_tile_experiment_variant widget varname="row" indent=0>
${""?left_pad(indent)}<view class="tile tile-experiment-variant layout-profile">
${""?left_pad(indent)}  <view class="tile-row tile-header">
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "tags")>
${""?left_pad(indent)}    <view class="tile-tags"><text wx:for="{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "tags"))} }}" wx:for-item="tag" wx:key="*this" class="tile-tag">{{ tag }}</text></view>
${""?left_pad(indent)}    </#if>
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "status")><view class="tile-status">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))} }}</view></#if>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}  <view class="tile-body">
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "primary")><view class="tile-primary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))} }}</view></#if>
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "secondary")><view class="tile-secondary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "secondary"))} }}</view></#if>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}  <#if guidbase.has_child_widget(widget, "avatars")>
${""?left_pad(indent)}  <view class="tile-footer">
${""?left_pad(indent)}    <view class="tile-avatars"><image wx:for="{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "avatars"))} }}" wx:for-item="av" wx:key="*this" src="{{ av }}" class="tile-avatar-img"></image></view>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}  </#if>
${""?left_pad(indent)}</view>
</#macro>

<#--
139. ab_test_result (A/B 测试结果)
+-----------------------------------------------+
| [status]                         [start_time] |
|                                               |
| [primary]                                     |
| [secondary]                                   |
| [tertiary]                                    |
+-----------------------------------------------+
-->
<#macro print_tile_ab_test_result widget varname="row" indent=0>
${""?left_pad(indent)}<view class="tile tile-ab-test-result layout-timeline">
${""?left_pad(indent)}  <view class="tile-row tile-header">
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "status")><text class="tile-status">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))} }}</text></#if>
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "start_time")><text class="tile-start-time">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "start_time"))} }}</text></#if>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}  <view class="tile-body">
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "primary")><view class="tile-primary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))} }}</view></#if>
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "secondary")><view class="tile-secondary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "secondary"))} }}</view></#if>
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "tertiary")><view class="tile-tertiary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "tertiary"))} }}</view></#if>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}</view>
</#macro>

<#--
140. analytics_event (分析事件)
+-----------------------------------------------+
| [start_time]                         [status] |
|                                               |
| [primary]                                     |
| [secondary]                                   |
|                                               |
| [tags]                                        |
+-----------------------------------------------+
-->
<#macro print_tile_analytics_event widget varname="row" indent=0>
${""?left_pad(indent)}<view class="tile tile-analytics-event layout-timeline">
${""?left_pad(indent)}  <view class="tile-row tile-header">
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "start_time")><text class="tile-start-time">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "start_time"))} }}</text></#if>
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "status")><text class="tile-status">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))} }}</text></#if>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}  <view class="tile-body">
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "primary")><view class="tile-primary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))} }}</view></#if>
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "secondary")><view class="tile-secondary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "secondary"))} }}</view></#if>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}  <#if guidbase.has_child_widget(widget, "tags")>
${""?left_pad(indent)}  <view class="tile-footer">
${""?left_pad(indent)}    <view class="tile-tags"><text wx:for="{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "tags"))} }}" wx:for-item="tag" wx:key="*this" class="tile-tag">{{ tag }}</text></view>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}  </#if>
${""?left_pad(indent)}</view>
</#macro>
```

---

### WXML 瓦片模板设计 (141 至 180)

```xml
<#--
 ###############################################################################
 ### 瓦片模板定义 141 至 180
 ###############################################################################
-->

<#--
141. funnel_step (漏斗步骤)
+-----------------------------------------------+
| [primary]                            [status] |
| [secondary]                                   |
|                                               |
| [avatars]                          [end_time] |
+-----------------------------------------------+
-->
<#macro print_tile_funnel_step widget varname="row" indent=0>
${""?left_pad(indent)}<view class="tile tile-funnel-step layout-timeline">
${""?left_pad(indent)}  <view class="tile-row tile-header">
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "primary")><view class="tile-primary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))} }}</view></#if>
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "status")><view class="tile-status">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))} }}</view></#if>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}  <view class="tile-body">
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "secondary")><view class="tile-secondary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "secondary"))} }}</view></#if>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}  <view class="tile-footer">
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "avatars")>
${""?left_pad(indent)}    <view class="tile-avatars"><image wx:for="{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "avatars"))} }}" wx:for-item="av" wx:key="*this" src="{{ av }}" class="tile-avatar-img"></image></view>
${""?left_pad(indent)}    </#if>
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "end_time")><text class="tile-end-time">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "end_time"))} }}</text></#if>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}</view>
</#macro>

<#--
142. conversion_metric (转化率指标)
+===============================================+
|                 [background]                  |
|                                               |
|  [primary]                           [status] |
|  [secondary]                                  |
+===============================================+
-->
<#macro print_tile_conversion_metric widget varname="row" indent=0>
${""?left_pad(indent)}<view class="tile tile-conversion-metric layout-background">
${""?left_pad(indent)}  <#if guidbase.has_child_widget(widget, "background")>
${""?left_pad(indent)}  <view class="tile-background"><image src="{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "background"))} }}"></image></view>
${""?left_pad(indent)}  </#if>
${""?left_pad(indent)}  <view class="tile-overlay">
${""?left_pad(indent)}    <view class="tile-row tile-header">
${""?left_pad(indent)}      <#if guidbase.has_child_widget(widget, "status")><text class="tile-status">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))} }}</text></#if>
${""?left_pad(indent)}    </view>
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "primary")><view class="tile-primary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))} }}</view></#if>
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "secondary")><view class="tile-secondary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "secondary"))} }}</view></#if>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}</view>
</#macro>

<#--
143. chart_summary (图表摘要)
+-----------------------------------------------+
| +-------------------------------------------+ |
| |                  [image]                  | |
| +-------------------------------------------+ |
| [primary]                            [status] |
| [secondary]                                   |
| [tertiary]                                    |
+-----------------------------------------------+
-->
<#macro print_tile_chart_summary widget varname="row" indent=0>
${""?left_pad(indent)}<view class="tile tile-chart-summary layout-media">
${""?left_pad(indent)}  <#if guidbase.has_child_widget(widget, "image")>
${""?left_pad(indent)}  <view class="tile-image"><image src="{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "image"))} }}"></image></view>
${""?left_pad(indent)}  </#if>
${""?left_pad(indent)}  <view class="tile-body">
${""?left_pad(indent)}    <view class="tile-row tile-header">
${""?left_pad(indent)}      <#if guidbase.has_child_widget(widget, "primary")><view class="tile-primary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))} }}</view></#if>
${""?left_pad(indent)}      <#if guidbase.has_child_widget(widget, "status")><view class="tile-status">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))} }}</view></#if>
${""?left_pad(indent)}    </view>
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "secondary")><view class="tile-secondary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "secondary"))} }}</view></#if>
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "tertiary")><view class="tile-tertiary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "tertiary"))} }}</view></#if>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}</view>
</#macro>

<#--
144. report_header (报表头部)
+===============================================+
|                 [background]                  |
|                                               |
|  [primary]                                    |
|  [secondary]                                  |
|                                               |
|  [start_time] - [end_time]                    |
+===============================================+
-->
<#macro print_tile_report_header widget varname="row" indent=0>
${""?left_pad(indent)}<view class="tile tile-report-header layout-background">
${""?left_pad(indent)}  <#if guidbase.has_child_widget(widget, "background")>
${""?left_pad(indent)}  <view class="tile-background"><image src="{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "background"))} }}"></image></view>
${""?left_pad(indent)}  </#if>
${""?left_pad(indent)}  <view class="tile-overlay">
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "primary")><view class="tile-primary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))} }}</view></#if>
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "secondary")><view class="tile-secondary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "secondary"))} }}</view></#if>
${""?left_pad(indent)}    <view class="tile-footer">
${""?left_pad(indent)}      <text class="tile-time">
${""?left_pad(indent)}        <#if guidbase.has_child_widget(widget, "start_time")><text>{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "start_time"))} }}</text></#if>
${""?left_pad(indent)}        <#if guidbase.has_child_widget(widget, "start_time") && guidbase.has_child_widget(widget, "end_time")><text> - </text></#if>
${""?left_pad(indent)}        <#if guidbase.has_child_widget(widget, "end_time")><text>{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "end_time"))} }}</text></#if>
${""?left_pad(indent)}      </text>
${""?left_pad(indent)}    </view>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}</view>
</#macro>

<#--
145. report_row (数据报表行)
+-----------------------------------------------+
| [primary]                            [status] |
| [secondary]                                   |
| [tertiary]                                    |
|                                               |
| [tags]                                        |
+-----------------------------------------------+
-->
<#macro print_tile_report_row widget varname="row" indent=0>
${""?left_pad(indent)}<view class="tile tile-report-row layout-content">
${""?left_pad(indent)}  <view class="tile-row tile-header">
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "primary")><view class="tile-primary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))} }}</view></#if>
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "status")><view class="tile-status">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))} }}</view></#if>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}  <view class="tile-body">
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "secondary")><view class="tile-secondary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "secondary"))} }}</view></#if>
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "tertiary")><view class="tile-tertiary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "tertiary"))} }}</view></#if>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}  <#if guidbase.has_child_widget(widget, "tags")>
${""?left_pad(indent)}  <view class="tile-footer">
${""?left_pad(indent)}    <view class="tile-tags"><text wx:for="{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "tags"))} }}" wx:for-item="tag" wx:key="*this" class="tile-tag">{{ tag }}</text></view>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}  </#if>
${""?left_pad(indent)}</view>
</#macro>

<#--
146. data_source (数据源卡片)
+-----------------------------------------------+
| +-------+  [primary]                          |
| |avatar |  [secondary]                        |
| +-------+                                     |
| [status]                           [end_time] |
+-----------------------------------------------+
-->
<#macro print_tile_data_source widget varname="row" indent=0>
${""?left_pad(indent)}<view class="tile tile-data-source layout-timeline">
${""?left_pad(indent)}  <view class="tile-row">
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "avatar")><view class="tile-avatar"><image src="{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "avatar"))} }}"></image></view></#if>
${""?left_pad(indent)}    <view class="tile-body">
${""?left_pad(indent)}      <#if guidbase.has_child_widget(widget, "primary")><view class="tile-primary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))} }}</view></#if>
${""?left_pad(indent)}      <#if guidbase.has_child_widget(widget, "secondary")><view class="tile-secondary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "secondary"))} }}</view></#if>
${""?left_pad(indent)}    </view>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}  <view class="tile-footer">
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "status")><text class="tile-status">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))} }}</text></#if>
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "end_time")><text class="tile-end-time">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "end_time"))} }}</text></#if>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}</view>
</#macro>

<#--
147. dataset_card (数据集卡片)
+-----------------------------------------------+
| +-------------------------------------------+ |
| |                  [image]                  | |
| +-------------------------------------------+ |
| [primary]                                     |
| [secondary]                                   |
|                                               |
| [tags]                               [status] |
+-----------------------------------------------+
-->
<#macro print_tile_dataset_card widget varname="row" indent=0>
${""?left_pad(indent)}<view class="tile tile-dataset-card layout-media">
${""?left_pad(indent)}  <#if guidbase.has_child_widget(widget, "image")>
${""?left_pad(indent)}  <view class="tile-image"><image src="{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "image"))} }}"></image></view>
${""?left_pad(indent)}  </#if>
${""?left_pad(indent)}  <view class="tile-body">
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "primary")><view class="tile-primary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))} }}</view></#if>
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "secondary")><view class="tile-secondary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "secondary"))} }}</view></#if>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}  <view class="tile-footer">
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "tags")>
${""?left_pad(indent)}    <view class="tile-tags"><text wx:for="{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "tags"))} }}" wx:for-item="tag" wx:key="*this" class="tile-tag">{{ tag }}</text></view>
${""?left_pad(indent)}    </#if>
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "status")><text class="tile-status">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))} }}</text></#if>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}</view>
</#macro>

<#--
148. query_history (查询历史)
+-----------------------------------------------+
| [start_time]                         [status] |
|                                               |
| [primary]                                     |
| [secondary]                                   |
+-----------------------------------------------+
-->
<#macro print_tile_query_history widget varname="row" indent=0>
${""?left_pad(indent)}<view class="tile tile-query-history layout-timeline">
${""?left_pad(indent)}  <view class="tile-row tile-header">
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "start_time")><text class="tile-start-time">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "start_time"))} }}</text></#if>
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "status")><text class="tile-status">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))} }}</text></#if>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}  <view class="tile-body">
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "primary")><view class="tile-primary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))} }}</view></#if>
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "secondary")><view class="tile-secondary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "secondary"))} }}</view></#if>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}</view>
</#macro>

<#--
149. export_job (导出任务)
+-----------------------------------------------+
| [status]                                      |
|                                               |
| [primary]                                     |
| [secondary]                                   |
|                                               |
| [start_time] - [end_time]                     |
+-----------------------------------------------+
-->
<#macro print_tile_export_job widget varname="row" indent=0>
${""?left_pad(indent)}<view class="tile tile-export-job layout-timeline">
${""?left_pad(indent)}  <view class="tile-row tile-header">
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "status")><text class="tile-status">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))} }}</text></#if>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}  <view class="tile-body">
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "primary")><view class="tile-primary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))} }}</view></#if>
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "secondary")><view class="tile-secondary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "secondary"))} }}</view></#if>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}  <view class="tile-footer">
${""?left_pad(indent)}    <text class="tile-time">
${""?left_pad(indent)}      <#if guidbase.has_child_widget(widget, "start_time")><text>{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "start_time"))} }}</text></#if>
${""?left_pad(indent)}      <#if guidbase.has_child_widget(widget, "start_time") && guidbase.has_child_widget(widget, "end_time")><text> - </text></#if>
${""?left_pad(indent)}      <#if guidbase.has_child_widget(widget, "end_time")><text>{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "end_time"))} }}</text></#if>
${""?left_pad(indent)}    </text>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}</view>
</#macro>

<#--
150. import_job (导入任务)
+-----------------------------------------------+
| [status]                                      |
|                                               |
| [primary]                                     |
| [secondary]                                   |
|                                               |
| [start_time] - [end_time]            [avatars]|
+-----------------------------------------------+
-->
<#macro print_tile_import_job widget varname="row" indent=0>
${""?left_pad(indent)}<view class="tile tile-import-job layout-timeline">
${""?left_pad(indent)}  <view class="tile-row tile-header">
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "status")><text class="tile-status">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))} }}</text></#if>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}  <view class="tile-body">
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "primary")><view class="tile-primary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))} }}</view></#if>
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "secondary")><view class="tile-secondary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "secondary"))} }}</view></#if>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}  <view class="tile-footer">
${""?left_pad(indent)}    <text class="tile-time">
${""?left_pad(indent)}      <#if guidbase.has_child_widget(widget, "start_time")><text>{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "start_time"))} }}</text></#if>
${""?left_pad(indent)}      <#if guidbase.has_child_widget(widget, "start_time") && guidbase.has_child_widget(widget, "end_time")><text> - </text></#if>
${""?left_pad(indent)}      <#if guidbase.has_child_widget(widget, "end_time")><text>{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "end_time"))} }}</text></#if>
${""?left_pad(indent)}    </text>
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "avatars")>
${""?left_pad(indent)}    <view class="tile-avatars"><image wx:for="{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "avatars"))} }}" wx:for-item="av" wx:key="*this" src="{{ av }}" class="tile-avatar-img"></image></view>
${""?left_pad(indent)}    </#if>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}</view>
</#macro>

<#--
151. sync_status (同步状态)
+-----------------------------------------------+
| [status]                         [start_time] |
|                                               |
| [primary]                                     |
| [secondary]                                   |
+-----------------------------------------------+
-->
<#macro print_tile_sync_status widget varname="row" indent=0>
${""?left_pad(indent)}<view class="tile tile-sync-status layout-timeline">
${""?left_pad(indent)}  <view class="tile-row tile-header">
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "status")><text class="tile-status">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))} }}</text></#if>
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "start_time")><text class="tile-start-time">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "start_time"))} }}</text></#if>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}  <view class="tile-body">
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "primary")><view class="tile-primary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))} }}</view></#if>
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "secondary")><view class="tile-secondary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "secondary"))} }}</view></#if>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}</view>
</#macro>

以下为您提供从 152 开始，一直到 236 结束的完整 FTL 宏定义。每个宏都配有对应的 ASCII 结构设计图，并严格适配微信小程序 WXML 结构。

WXML 瓦片模板设计 (152 至 190)

<#--
 ###############################################################################
 ### 瓦片模板定义 152 至 190
 ###############################################################################
-->

<#--
152. backup_snapshot (备份快照)
+===============================================+
|                 [background]                  |
|                                               |
|  [primary]                           [status] |
|  [secondary]                                  |
|                                    [end_time] |
+===============================================+
-->
<#macro print_tile_backup_snapshot widget varname="row" indent=0>
${""?left_pad(indent)}<view class="tile tile-backup-snapshot layout-background">
${""?left_pad(indent)}  <#if guidbase.has_child_widget(widget, "background")>
${""?left_pad(indent)}  <view class="tile-background"><image src="{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "background"))} }}"></image></view>
${""?left_pad(indent)}  </#if>
${""?left_pad(indent)}  <view class="tile-overlay">
${""?left_pad(indent)}    <view class="tile-row tile-header">
${""?left_pad(indent)}      <#if guidbase.has_child_widget(widget, "status")><text class="tile-status">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))} }}</text></#if>
${""?left_pad(indent)}    </view>
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "primary")><view class="tile-primary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))} }}</view></#if>
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "secondary")><view class="tile-secondary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "secondary"))} }}</view></#if>
${""?left_pad(indent)}    <view class="tile-footer">
${""?left_pad(indent)}      <#if guidbase.has_child_widget(widget, "end_time")><text class="tile-end-time">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "end_time"))} }}</text></#if>
${""?left_pad(indent)}    </view>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}</view>
</#macro>

<#--
153. restore_point (还原点)
+===============================================+
|                 [background]                  |
|                                               |
|  [primary]                           [status] |
|                                               |
|  [start_time] - [end_time]                    |
+===============================================+
-->
<#macro print_tile_restore_point widget varname="row" indent=0>
${""?left_pad(indent)}<view class="tile tile-restore-point layout-background">
${""?left_pad(indent)}  <#if guidbase.has_child_widget(widget, "background")>
${""?left_pad(indent)}  <view class="tile-background"><image src="{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "background"))} }}"></image></view>
${""?left_pad(indent)}  </#if>
${""?left_pad(indent)}  <view class="tile-overlay">
${""?left_pad(indent)}    <view class="tile-row tile-header">
${""?left_pad(indent)}      <#if guidbase.has_child_widget(widget, "status")><text class="tile-status">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))} }}</text></#if>
${""?left_pad(indent)}    </view>
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "primary")><view class="tile-primary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))} }}</view></#if>
${""?left_pad(indent)}    <view class="tile-footer">
${""?left_pad(indent)}      <text class="tile-time">
${""?left_pad(indent)}        <#if guidbase.has_child_widget(widget, "start_time")><text>{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "start_time"))} }}</text></#if>
${""?left_pad(indent)}        <#if guidbase.has_child_widget(widget, "start_time") && guidbase.has_child_widget(widget, "end_time")><text> - </text></#if>
${""?left_pad(indent)}        <#if guidbase.has_child_widget(widget, "end_time")><text>{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "end_time"))} }}</text></#if>
${""?left_pad(indent)}      </text>
${""?left_pad(indent)}    </view>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}</view>
</#macro>

<#--
154. storage_usage (存储用量)
+-----------------------------------------------+
| [primary]                            [status] |
| [secondary]                                   |
|                                               |
| [avatars]                              [tags] |
+-----------------------------------------------+
-->
<#macro print_tile_storage_usage widget varname="row" indent=0>
${""?left_pad(indent)}<view class="tile tile-storage-usage layout-profile">
${""?left_pad(indent)}  <view class="tile-row tile-header">
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "primary")><view class="tile-primary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))} }}</view></#if>
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "status")><view class="tile-status">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))} }}</view></#if>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}  <view class="tile-body">
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "secondary")><view class="tile-secondary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "secondary"))} }}</view></#if>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}  <view class="tile-footer">
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "avatars")>
${""?left_pad(indent)}    <view class="tile-avatars"><image wx:for="{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "avatars"))} }}" wx:for-item="av" wx:key="*this" src="{{ av }}" class="tile-avatar-img"></image></view>
${""?left_pad(indent)}    </#if>
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "tags")>
${""?left_pad(indent)}    <view class="tile-tags"><text wx:for="{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "tags"))} }}" wx:for-item="tag" wx:key="*this" class="tile-tag">{{ tag }}</text></view>
${""?left_pad(indent)}    </#if>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}</view>
</#macro>

<#--
155. quota_meter (限额测量)
+-----------------------------------------------+
| [primary]                            [status] |
| [secondary]                                   |
|                                               |
|                                    [end_time] |
+-----------------------------------------------+
-->
<#macro print_tile_quota_meter widget varname="row" indent=0>
${""?left_pad(indent)}<view class="tile tile-quota-meter layout-timeline">
${""?left_pad(indent)}  <view class="tile-row tile-header">
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "primary")><view class="tile-primary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))} }}</view></#if>
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "status")><view class="tile-status">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))} }}</view></#if>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}  <view class="tile-body">
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "secondary")><view class="tile-secondary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "secondary"))} }}</view></#if>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}  <view class="tile-footer">
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "end_time")><text class="tile-end-time">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "end_time"))} }}</text></#if>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}</view>
</#macro>

<#--
156. license_summary (执照摘要)
+===============================================+
|                 [background]                  |
|                                               |
|  [primary]                           [status] |
|  [secondary]                                  |
|                                    [end_time] |
+===============================================+
-->
<#macro print_tile_license_summary widget varname="row" indent=0>
${""?left_pad(indent)}<view class="tile tile-license-summary layout-background">
${""?left_pad(indent)}  <#if guidbase.has_child_widget(widget, "background")>
${""?left_pad(indent)}  <view class="tile-background"><image src="{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "background"))} }}"></image></view>
${""?left_pad(indent)}  </#if>
${""?left_pad(indent)}  <view class="tile-overlay">
${""?left_pad(indent)}    <view class="tile-row tile-header">
${""?left_pad(indent)}      <#if guidbase.has_child_widget(widget, "status")><text class="tile-status">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))} }}</text></#if>
${""?left_pad(indent)}    </view>
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "primary")><view class="tile-primary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))} }}</view></#if>
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "secondary")><view class="tile-secondary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "secondary"))} }}</view></#if>
${""?left_pad(indent)}    <view class="tile-footer">
${""?left_pad(indent)}      <#if guidbase.has_child_widget(widget, "end_time")><text class="tile-end-time">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "end_time"))} }}</text></#if>
${""?left_pad(indent)}    </view>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}</view>
</#macro>

<#--
157. subscription_plan (订阅方案)
+-----------------------------------------------+
| +-------------------------------------------+ |
| |                  [image]                  | |
| +-------------------------------------------+ |
| [primary]                                     |
| [secondary]                                   |
|                                               |
| [tags]                               [status] |
+-----------------------------------------------+
-->
<#macro print_tile_subscription_plan widget varname="row" indent=0>
${""?left_pad(indent)}<view class="tile tile-subscription-plan layout-media">
${""?left_pad(indent)}  <#if guidbase.has_child_widget(widget, "image")>
${""?left_pad(indent)}  <view class="tile-image"><image src="{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "image"))} }}"></image></view>
${""?left_pad(indent)}  </#if>
${""?left_pad(indent)}  <view class="tile-body">
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "primary")><view class="tile-primary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))} }}</view></#if>
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "secondary")><view class="tile-secondary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "secondary"))} }}</view></#if>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}  <view class="tile-footer">
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "tags")>
${""?left_pad(indent)}    <view class="tile-tags"><text wx:for="{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "tags"))} }}" wx:for-item="tag" wx:key="*this" class="tile-tag">{{ tag }}</text></view>
${""?left_pad(indent)}    </#if>
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "status")><text class="tile-status">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))} }}</text></#if>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}</view>
</#macro>

<#--
158. billing_cycle (账单周期)
+-----------------------------------------------+
| [start_time] - [end_time]                     |
|                                               |
| [primary]                                     |
| [secondary]                                   |
|                                               |
|                                      [status] |
+-----------------------------------------------+
-->
<#macro print_tile_billing_cycle widget varname="row" indent=0>
${""?left_pad(indent)}<view class="tile tile-billing-cycle layout-timeline">
${""?left_pad(indent)}  <view class="tile-row tile-header">
${""?left_pad(indent)}    <text class="tile-time">
${""?left_pad(indent)}      <#if guidbase.has_child_widget(widget, "start_time")><text>{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "start_time"))} }}</text></#if>
${""?left_pad(indent)}      <#if guidbase.has_child_widget(widget, "start_time") && guidbase.has_child_widget(widget, "end_time")><text> - </text></#if>
${""?left_pad(indent)}      <#if guidbase.has_child_widget(widget, "end_time")><text>{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "end_time"))} }}</text></#if>
${""?left_pad(indent)}    </text>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}  <view class="tile-body">
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "primary")><view class="tile-primary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))} }}</view></#if>
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "secondary")><view class="tile-secondary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "secondary"))} }}</view></#if>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}  <view class="tile-footer">
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "status")><text class="tile-status">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))} }}</text></#if>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}</view>
</#macro>

<#--
159. tax_invoice (税务发票)
+-----------------------------------------------+
| +-------------------------------------------+ |
| |                  [image]                  | |
| +-------------------------------------------+ |
| [primary]                            [status] |
| [secondary]                                   |
| [tertiary]                                    |
+-----------------------------------------------+
-->
<#macro print_tile_tax_invoice widget varname="row" indent=0>
${""?left_pad(indent)}<view class="tile tile-tax-invoice layout-media">
${""?left_pad(indent)}  <#if guidbase.has_child_widget(widget, "image")>
${""?left_pad(indent)}  <view class="tile-image"><image src="{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "image"))} }}"></image></view>
${""?left_pad(indent)}  </#if>
${""?left_pad(indent)}  <view class="tile-body">
${""?left_pad(indent)}    <view class="tile-row tile-header">
${""?left_pad(indent)}      <#if guidbase.has_child_widget(widget, "primary")><view class="tile-primary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))} }}</view></#if>
${""?left_pad(indent)}      <#if guidbase.has_child_widget(widget, "status")><view class="tile-status">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))} }}</view></#if>
${""?left_pad(indent)}    </view>
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "secondary")><view class="tile-secondary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "secondary"))} }}</view></#if>
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "tertiary")><view class="tile-tertiary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "tertiary"))} }}</view></#if>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}</view>
</#macro>

<#--
160. refund_case (退款案件)
+-----------------------------------------------+
| [status]                                      |
|                                               |
| [primary]                                     |
| [secondary]                                   |
|                                               |
| [start_time] - [end_time]                     |
+-----------------------------------------------+
-->
<#macro print_tile_refund_case widget varname="row" indent=0>
${""?left_pad(indent)}<view class="tile tile-refund-case layout-timeline">
${""?left_pad(indent)}  <view class="tile-row tile-header">
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "status")><text class="tile-status">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))} }}</text></#if>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}  <view class="tile-body">
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "primary")><view class="tile-primary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))} }}</view></#if>
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "secondary")><view class="tile-secondary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "secondary"))} }}</view></#if>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}  <view class="tile-footer">
${""?left_pad(indent)}    <text class="tile-time">
${""?left_pad(indent)}      <#if guidbase.has_child_widget(widget, "start_time")><text>{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "start_time"))} }}</text></#if>
${""?left_pad(indent)}      <#if guidbase.has_child_widget(widget, "start_time") && guidbase.has_child_widget(widget, "end_time")><text> - </text></#if>
${""?left_pad(indent)}      <#if guidbase.has_child_widget(widget, "end_time")><text>{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "end_time"))} }}</text></#if>
${""?left_pad(indent)}    </text>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}</view>
</#macro>

<#--
161. support_ticket (工单服务)
+-----------------------------------------------+
| +-------+  [primary]                          |
| |avatar |  [secondary]                        |
| +-------+                                     |
| [start_time]                         [status] |
+-----------------------------------------------+
-->
<#macro print_tile_support_ticket widget varname="row" indent=0>
${""?left_pad(indent)}<view class="tile tile-support-ticket layout-timeline">
${""?left_pad(indent)}  <view class="tile-row">
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "avatar")><view class="tile-avatar"><image src="{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "avatar"))} }}"></image></view></#if>
${""?left_pad(indent)}    <view class="tile-body">
${""?left_pad(indent)}      <#if guidbase.has_child_widget(widget, "primary")><view class="tile-primary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))} }}</view></#if>
${""?left_pad(indent)}      <#if guidbase.has_child_widget(widget, "secondary")><view class="tile-secondary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "secondary"))} }}</view></#if>
${""?left_pad(indent)}    </view>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}  <view class="tile-footer">
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "start_time")><text class="tile-start-time">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "start_time"))} }}</text></#if>
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "status")><text class="tile-status">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))} }}</text></#if>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}</view>
</#macro>

<#--
162. support_agent (技术客服)
+-----------------------------------------------+
| +-------+  [primary]                 [status] |
| |avatar |  [secondary]                        |
| +-------+                                     |
| [tags]                                        |
+-----------------------------------------------+
-->
<#macro print_tile_support_agent widget varname="row" indent=0>
${""?left_pad(indent)}<view class="tile tile-support-agent layout-profile">
${""?left_pad(indent)}  <view class="tile-row">
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "avatar")><view class="tile-avatar"><image src="{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "avatar"))} }}"></image></view></#if>
${""?left_pad(indent)}    <view class="tile-body">
${""?left_pad(indent)}      <view class="tile-row">
${""?left_pad(indent)}        <#if guidbase.has_child_widget(widget, "primary")><view class="tile-primary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))} }}</view></#if>
${""?left_pad(indent)}        <#if guidbase.has_child_widget(widget, "status")><view class="tile-status">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))} }}</view></#if>
${""?left_pad(indent)}      </view>
${""?left_pad(indent)}      <#if guidbase.has_child_widget(widget, "secondary")><view class="tile-secondary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "secondary"))} }}</view></#if>
${""?left_pad(indent)}    </view>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}  <#if guidbase.has_child_widget(widget, "tags")>
${""?left_pad(indent)}  <view class="tile-footer">
${""?left_pad(indent)}    <view class="tile-tags"><text wx:for="{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "tags"))} }}" wx:for-item="tag" wx:key="*this" class="tile-tag">{{ tag }}</text></view>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}  </#if>
${""?left_pad(indent)}</view>
</#macro>

<#--
163. faq_item (常见问题项)
+-----------------------------------------------+
| [primary]                                     |
| [secondary]                                   |
|                                               |
| [tags]                                        |
+-----------------------------------------------+
-->
<#macro print_tile_faq_item widget varname="row" indent=0>
${""?left_pad(indent)}<view class="tile tile-faq-item layout-content">
${""?left_pad(indent)}  <view class="tile-body">
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "primary")><view class="tile-primary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))} }}</view></#if>
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "secondary")><view class="tile-secondary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "secondary"))} }}</view></#if>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}  <#if guidbase.has_child_widget(widget, "tags")>
${""?left_pad(indent)}  <view class="tile-footer">
${""?left_pad(indent)}    <view class="tile-tags"><text wx:for="{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "tags"))} }}" wx:for-item="tag" wx:key="*this" class="tile-tag">{{ tag }}</text></view>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}  </#if>
${""?left_pad(indent)}</view>
</#macro>

<#--
164. knowledge_article (知识库文章)
+-----------------------------------------------+
| +-------------------------------------------+ |
| |                  [image]                  | |
| +-------------------------------------------+ |
| [primary]                                     |
| [secondary]                                   |
| [tertiary]                                    |
|                                               |
| [tags]                                        |
+-----------------------------------------------+
-->
<#macro print_tile_knowledge_article widget varname="row" indent=0>
${""?left_pad(indent)}<view class="tile tile-knowledge-article layout-media">
${""?left_pad(indent)}  <#if guidbase.has_child_widget(widget, "image")>
${""?left_pad(indent)}  <view class="tile-image"><image src="{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "image"))} }}"></image></view>
${""?left_pad(indent)}  </#if>
${""?left_pad(indent)}  <view class="tile-body">
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "primary")><view class="tile-primary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))} }}</view></#if>
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "secondary")><view class="tile-secondary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "secondary"))} }}</view></#if>
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "tertiary")><view class="tile-tertiary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "tertiary"))} }}</view></#if>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}  <#if guidbase.has_child_widget(widget, "tags")>
${""?left_pad(indent)}  <view class="tile-footer">
${""?left_pad(indent)}    <view class="tile-tags"><text wx:for="{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "tags"))} }}" wx:for-item="tag" wx:key="*this" class="tile-tag">{{ tag }}</text></view>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}  </#if>
${""?left_pad(indent)}</view>
</#macro>

<#--
165. documentation_section (文档章节)
+-----------------------------------------------+
| [primary]                            [status] |
| [secondary]                                   |
| [tertiary]                                    |
+-----------------------------------------------+
-->
<#macro print_tile_documentation_section widget varname="row" indent=0>
${""?left_pad(indent)}<view class="tile tile-documentation-section layout-content">
${""?left_pad(indent)}  <view class="tile-row tile-header">
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "primary")><view class="tile-primary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))} }}</view></#if>
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "status")><view class="tile-status">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))} }}</view></#if>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}  <view class="tile-body">
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "secondary")><view class="tile-secondary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "secondary"))} }}</view></#if>
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "tertiary")><view class="tile-tertiary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "tertiary"))} }}</view></#if>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}</view>
</#macro>

<#--
166. release_channel (发布频道)
+-----------------------------------------------+
| [primary]                            [status] |
| [secondary]                                   |
|                                               |
| [avatars]                                     |
+-----------------------------------------------+
-->
<#macro print_tile_release_channel widget varname="row" indent=0>
${""?left_pad(indent)}<view class="tile tile-release-channel layout-profile">
${""?left_pad(indent)}  <view class="tile-row tile-header">
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "primary")><view class="tile-primary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))} }}</view></#if>
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "status")><view class="tile-status">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))} }}</view></#if>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}  <view class="tile-body">
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "secondary")><view class="tile-secondary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "secondary"))} }}</view></#if>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}  <#if guidbase.has_child_widget(widget, "avatars")>
${""?left_pad(indent)}  <view class="tile-footer">
${""?left_pad(indent)}    <view class="tile-avatars"><image wx:for="{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "avatars"))} }}" wx:for-item="av" wx:key="*this" src="{{ av }}" class="tile-avatar-img"></image></view>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}  </#if>
${""?left_pad(indent)}</view>
</#macro>

<#--
167. roadmap_milestone (路线图里程碑)
+===============================================+
|                 [background]                  |
|                                               |
|  [primary]                           [status] |
|  [secondary]                                  |
|                                               |
|  [start_time]                                 |
+===============================================+
-->
<#macro print_tile_roadmap_milestone widget varname="row" indent=0>
${""?left_pad(indent)}<view class="tile tile-roadmap-milestone layout-background">
${""?left_pad(indent)}  <#if guidbase.has_child_widget(widget, "background")>
${""?left_pad(indent)}  <view class="tile-background"><image src="{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "background"))} }}"></image></view>
${""?left_pad(indent)}  </#if>
${""?left_pad(indent)}  <view class="tile-overlay">
${""?left_pad(indent)}    <view class="tile-row tile-header">
${""?left_pad(indent)}      <#if guidbase.has_child_widget(widget, "status")><text class="tile-status">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))} }}</text></#if>
${""?left_pad(indent)}    </view>
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "primary")><view class="tile-primary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))} }}</view></#if>
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "secondary")><view class="tile-secondary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "secondary"))} }}</view></#if>
${""?left_pad(indent)}    <view class="tile-footer">
${""?left_pad(indent)}      <#if guidbase.has_child_widget(widget, "start_time")><text class="tile-start-time">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "start_time"))} }}</text></#if>
${""?left_pad(indent)}    </view>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}</view>
</#macro>

<#--
168. feedback_card (反馈卡片)
+-----------------------------------------------+
| +-------+  [primary]             [start_time] |
| |avatar |  [secondary]                        |
| +-------+                                     |
| [tags]                                        |
+-----------------------------------------------+
-->
<#macro print_tile_feedback_card widget varname="row" indent=0>
${""?left_pad(indent)}<view class="tile tile-feedback-card layout-timeline">
${""?left_pad(indent)}  <view class="tile-row">
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "avatar")><view class="tile-avatar"><image src="{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "avatar"))} }}"></image></view></#if>
${""?left_pad(indent)}    <view class="tile-body">
${""?left_pad(indent)}      <view class="tile-row tile-header">
${""?left_pad(indent)}        <#if guidbase.has_child_widget(widget, "primary")><view class="tile-primary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))} }}</view></#if>
${""?left_pad(indent)}        <#if guidbase.has_child_widget(widget, "start_time")><text class="tile-start-time">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "start_time"))} }}</text></#if>
${""?left_pad(indent)}      </view>
${""?left_pad(indent)}      <#if guidbase.has_child_widget(widget, "secondary")><view class="tile-secondary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "secondary"))} }}</view></#if>
${""?left_pad(indent)}    </view>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}  <#if guidbase.has_child_widget(widget, "tags")>
${""?left_pad(indent)}  <view class="tile-footer">
${""?left_pad(indent)}    <view class="tile-tags"><text wx:for="{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "tags"))} }}" wx:for-item="tag" wx:key="*this" class="tile-tag">{{ tag }}</text></view>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}  </#if>
${""?left_pad(indent)}</view>
</#macro>

<#--
169. survey_question (问卷问题)
+-----------------------------------------------+
| [primary]                            [status] |
| [secondary]                                   |
|                                               |
| [tags]                                        |
+-----------------------------------------------+
-->
<#macro print_tile_survey_question widget varname="row" indent=0>
${""?left_pad(indent)}<view class="tile tile-survey-question layout-content">
${""?left_pad(indent)}  <view class="tile-row tile-header">
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "primary")><view class="tile-primary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))} }}</view></#if>
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "status")><view class="tile-status">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))} }}</view></#if>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}  <view class="tile-body">
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "secondary")><view class="tile-secondary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "secondary"))} }}</view></#if>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}  <#if guidbase.has_child_widget(widget, "tags")>
${""?left_pad(indent)}  <view class="tile-footer">
${""?left_pad(indent)}    <view class="tile-tags"><text wx:for="{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "tags"))} }}" wx:for-item="tag" wx:key="*this" class="tile-tag">{{ tag }}</text></view>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}  </#if>
${""?left_pad(indent)}</view>
</#macro>

<#--
170. survey_response (问卷回复)
+-----------------------------------------------+
| +-------+  [primary]                 [status] |
| |avatar |  [secondary]                        |
| +-------+  [tertiary]                         |
+-----------------------------------------------+
-->
<#macro print_tile_survey_response widget varname="row" indent=0>
${""?left_pad(indent)}<view class="tile tile-survey-response layout-profile">
${""?left_pad(indent)}  <view class="tile-row">
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "avatar")><view class="tile-avatar"><image src="{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "avatar"))} }}"></image></view></#if>
${""?left_pad(indent)}    <view class="tile-body">
${""?left_pad(indent)}      <view class="tile-row">
${""?left_pad(indent)}        <#if guidbase.has_child_widget(widget, "primary")><view class="tile-primary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))} }}</view></#if>
${""?left_pad(indent)}        <#if guidbase.has_child_widget(widget, "status")><view class="tile-status">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))} }}</view></#if>
${""?left_pad(indent)}      </view>
${""?left_pad(indent)}      <#if guidbase.has_child_widget(widget, "secondary")><view class="tile-secondary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "secondary"))} }}</view></#if>
${""?left_pad(indent)}      <#if guidbase.has_child_widget(widget, "tertiary")><view class="tile-tertiary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "tertiary"))} }}</view></#if>
${""?left_pad(indent)}    </view>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}</view>
</#macro>

<#--
171. rating_summary (评级汇总)
+-----------------------------------------------+
| [primary]                            [status] |
| [secondary]                                   |
|                                               |
| [avatars]                                     |
+-----------------------------------------------+
-->
<#macro print_tile_rating_summary widget varname="row" indent=0>
${""?left_pad(indent)}<view class="tile tile-rating-summary layout-profile">
${""?left_pad(indent)}  <view class="tile-row tile-header">
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "primary")><view class="tile-primary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))} }}</view></#if>
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "status")><view class="tile-status">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))} }}</view></#if>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}  <view class="tile-body">
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "secondary")><view class="tile-secondary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "secondary"))} }}</view></#if>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}  <#if guidbase.has_child_widget(widget, "avatars")>
${""?left_pad(indent)}  <view class="tile-footer">
${""?left_pad(indent)}    <view class="tile-avatars"><image wx:for="{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "avatars"))} }}" wx:for-item="av" wx:key="*this" src="{{ av }}" class="tile-avatar-img"></image></view>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}  </#if>
${""?left_pad(indent)}</view>
</#macro>

<#--
172. review_card (评价卡片)
+-----------------------------------------------+
| +-------+  [primary]                          |
| |avatar |  [secondary]                        |
| +-------+                                     |
| +-------------------------------------------+ |
| |                  [image]                  | |
| +-------------------------------------------+ |
| [start_time]                                  |
+-----------------------------------------------+
-->
<#macro print_tile_review_card widget varname="row" indent=0>
${""?left_pad(indent)}<view class="tile tile-review-card layout-media">
${""?left_pad(indent)}  <view class="tile-row">
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "avatar")><view class="tile-avatar"><image src="{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "avatar"))} }}"></image></view></#if>
${""?left_pad(indent)}    <view class="tile-body">
${""?left_pad(indent)}      <#if guidbase.has_child_widget(widget, "primary")><view class="tile-primary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))} }}</view></#if>
${""?left_pad(indent)}      <#if guidbase.has_child_widget(widget, "secondary")><view class="tile-secondary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "secondary"))} }}</view></#if>
${""?left_pad(indent)}    </view>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}  <#if guidbase.has_child_widget(widget, "image")>
${""?left_pad(indent)}  <view class="tile-image"><image src="{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "image"))} }}"></image></view>
${""?left_pad(indent)}  </#if>
${""?left_pad(indent)}  <view class="tile-footer">
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "start_time")><text class="tile-start-time">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "start_time"))} }}</text></#if>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}</view>
</#macro>

<#--
173. moderation_case (内容审核案件)
+-----------------------------------------------+
| [status]                                      |
|                                               |
| [primary]                                     |
| [secondary]                                   |
|                                               |
| [avatar]                           [end_time] |
+-----------------------------------------------+
-->
<#macro print_tile_moderation_case widget varname="row" indent=0>
${""?left_pad(indent)}<view class="tile tile-moderation-case layout-timeline">
${""?left_pad(indent)}  <view class="tile-row tile-header">
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "status")><text class="tile-status">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))} }}</text></#if>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}  <view class="tile-body">
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "primary")><view class="tile-primary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))} }}</view></#if>
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "secondary")><view class="tile-secondary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "secondary"))} }}</view></#if>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}  <view class="tile-footer">
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "avatar")><view class="tile-avatar"><image src="{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "avatar"))} }}"></image></view></#if>
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "end_time")><text class="tile-end-time">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "end_time"))} }}</text></#if>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}</view>
</#macro>

<#--
174. content_flag (内容标记)
+-----------------------------------------------+
| [status]                         [start_time] |
|                                               |
| [primary]                                     |
| [tertiary]                                    |
+-----------------------------------------------+
-->
<#macro print_tile_content_flag widget varname="row" indent=0>
${""?left_pad(indent)}<view class="tile tile-content-flag layout-timeline">
${""?left_pad(indent)}  <view class="tile-row tile-header">
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "status")><text class="tile-status">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))} }}</text></#if>
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "start_time")><text class="tile-start-time">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "start_time"))} }}</text></#if>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}  <view class="tile-body">
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "primary")><view class="tile-primary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))} }}</view></#if>
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "tertiary")><view class="tile-tertiary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "tertiary"))} }}</view></#if>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}</view>
</#macro>

<#--
175. approval_request (审批申请)
+-----------------------------------------------+
| +-------+  [primary]                          |
| |avatar |  [secondary]                        |
| +-------+                                     |
| [status]                           [end_time] |
+-----------------------------------------------+
-->
<#macro print_tile_approval_request widget varname="row" indent=0>
${""?left_pad(indent)}<view class="tile tile-approval-request layout-timeline">
${""?left_pad(indent)}  <view class="tile-row">
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "avatar")><view class="tile-avatar"><image src="{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "avatar"))} }}"></image></view></#if>
${""?left_pad(indent)}    <view class="tile-body">
${""?left_pad(indent)}      <#if guidbase.has_child_widget(widget, "primary")><view class="tile-primary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))} }}</view></#if>
${""?left_pad(indent)}      <#if guidbase.has_child_widget(widget, "secondary")><view class="tile-secondary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "secondary"))} }}</view></#if>
${""?left_pad(indent)}    </view>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}  <view class="tile-footer">
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "status")><text class="tile-status">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))} }}</text></#if>
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "end_time")><text class="tile-end-time">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "end_time"))} }}</text></#if>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}</view>
</#macro>

<#--
176. approval_step (审批步骤)
+-----------------------------------------------+
| [status]                           [start_time]|
|                                               |
| [primary]                                     |
| [secondary]                                   |
|                                               |
| [avatars]                                     |
+-----------------------------------------------+
-->
<#macro print_tile_approval_step widget varname="row" indent=0>
${""?left_pad(indent)}<view class="tile tile-approval-step layout-timeline">
${""?left_pad(indent)}  <view class="tile-row tile-header">
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "status")><text class="tile-status">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))} }}</text></#if>
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "start_time")><text class="tile-start-time">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "start_time"))} }}</text></#if>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}  <view class="tile-body">
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "primary")><view class="tile-primary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))} }}</view></#if>
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "secondary")><view class="tile-secondary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "secondary"))} }}</view></#if>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}  <#if guidbase.has_child_widget(widget, "avatars")>
${""?left_pad(indent)}  <view class="tile-footer">
${""?left_pad(indent)}    <view class="tile-avatars"><image wx:for="{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "avatars"))} }}" wx:for-item="av" wx:key="*this" src="{{ av }}" class="tile-avatar-img"></image></view>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}  </#if>
${""?left_pad(indent)}</view>
</#macro>

<#--
177. signature_request (签署请求)
+===============================================+
|                 [background]                  |
|                                               |
|  [primary]                           [status] |
|  [secondary]                                  |
|                                    [end_time] |
+===============================================+
-->
<#macro print_tile_signature_request widget varname="row" indent=0>
${""?left_pad(indent)}<view class="tile tile-signature-request layout-background">
${""?left_pad(indent)}  <#if guidbase.has_child_widget(widget, "background")>
${""?left_pad(indent)}  <view class="tile-background"><image src="{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "background"))} }}"></image></view>
${""?left_pad(indent)}  </#if>
${""?left_pad(indent)}  <view class="tile-overlay">
${""?left_pad(indent)}    <view class="tile-row tile-header">
${""?left_pad(indent)}      <#if guidbase.has_child_widget(widget, "status")><text class="tile-status">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))} }}</text></#if>
${""?left_pad(indent)}    </view>
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "primary")><view class="tile-primary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))} }}</view></#if>
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "secondary")><view class="tile-secondary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "secondary"))} }}</view></#if>
${""?left_pad(indent)}    <view class="tile-footer">
${""?left_pad(indent)}      <#if guidbase.has_child_widget(widget, "end_time")><text class="tile-end-time">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "end_time"))} }}</text></#if>
${""?left_pad(indent)}    </view>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}</view>
</#macro>

<#--
178. document_version (文档版本)
+-----------------------------------------------+
| +-------------------------------------------+ |
| |                  [image]                  | |
| +-------------------------------------------+ |
| [primary]                                     |
| [secondary]                                   |
|                                               |
| [start_time]                         [status] |
+-----------------------------------------------+
-->
<#macro print_tile_document_version widget varname="row" indent=0>
${""?left_pad(indent)}<view class="tile tile-document-version layout-media">
${""?left_pad(indent)}  <#if guidbase.has_child_widget(widget, "image")>
${""?left_pad(indent)}  <view class="tile-image"><image src="{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "image"))} }}"></image></view>
${""?left_pad(indent)}  </#if>
${""?left_pad(indent)}  <view class="tile-body">
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "primary")><view class="tile-primary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))} }}</view></#if>
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "secondary")><view class="tile-secondary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "secondary"))} }}</view></#if>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}  <view class="tile-footer">
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "start_time")><text class="tile-start-time">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "start_time"))} }}</text></#if>
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "status")><text class="tile-status">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))} }}</text></#if>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}</view>
</#macro>

<#--
179. document_collaborator (文档协作者)
+-----------------------------------------------+
| [primary]                            [status] |
| [secondary]                                   |
|                                               |
| [avatars]                              [tags] |
+-----------------------------------------------+
-->
<#macro print_tile_document_collaborator widget varname="row" indent=0>
${""?left_pad(indent)}<view class="tile tile-document-collaborator layout-profile">
${""?left_pad(indent)}  <view class="tile-row tile-header">
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "primary")><view class="tile-primary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))} }}</view></#if>
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "status")><view class="tile-status">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))} }}</view></#if>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}  <view class="tile-body">
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "secondary")><view class="tile-secondary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "secondary"))} }}</view></#if>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}  <view class="tile-footer">
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "avatars")>
${""?left_pad(indent)}    <view class="tile-avatars"><image wx:for="{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "avatars"))} }}" wx:for-item="av" wx:key="*this" src="{{ av }}" class="tile-avatar-img"></image></view>
${""?left_pad(indent)}    </#if>
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "tags")>
${""?left_pad(indent)}    <view class="tile-tags"><text wx:for="{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "tags"))} }}" wx:for-item="tag" wx:key="*this" class="tile-tag">{{ tag }}</text></view>
${""?left_pad(indent)}    </#if>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}</view>
</#macro>

<#--
180. folder_item (文件夹项目)
+-----------------------------------------------+
| +-------------------------------------------+ |
| |                  [image]                  | |
| +-------------------------------------------+ |
| [primary]                                     |
| [secondary]                                   |
|                                               |
|                                    [end_time] |
+-----------------------------------------------+
-->
<#macro print_tile_folder_item widget varname="row" indent=0>
${""?left_pad(indent)}<view class="tile tile-folder-item layout-media">
${""?left_pad(indent)}  <#if guidbase.has_child_widget(widget, "image")>
${""?left_pad(indent)}  <view class="tile-image"><image src="{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "image"))} }}"></image></view>
${""?left_pad(indent)}  </#if>
${""?left_pad(indent)}  <view class="tile-body">
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "primary")><view class="tile-primary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))} }}</view></#if>
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "secondary")><view class="tile-secondary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "secondary"))} }}</view></#if>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}  <view class="tile-footer">
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "end_time")><text class="tile-end-time">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "end_time"))} }}</text></#if>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}</view>
</#macro>

<#--
181. permission_rule (权限规则)
+-----------------------------------------------+
| +-------+  [primary]                 [status] |
| |avatar |  [secondary]                        |
| +-------+  [tertiary]                         |
+-----------------------------------------------+
-->
<#macro print_tile_permission_rule widget varname="row" indent=0>
${""?left_pad(indent)}<view class="tile tile-permission-rule layout-profile">
${""?left_pad(indent)}  <view class="tile-row">
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "avatar")><view class="tile-avatar"><image src="{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "avatar"))} }}"></image></view></#if>
${""?left_pad(indent)}    <view class="tile-body">
${""?left_pad(indent)}      <view class="tile-row">
${""?left_pad(indent)}        <#if guidbase.has_child_widget(widget, "primary")><view class="tile-primary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))} }}</view></#if>
${""?left_pad(indent)}        <#if guidbase.has_child_widget(widget, "status")><view class="tile-status">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))} }}</view></#if>
${""?left_pad(indent)}      </view>
${""?left_pad(indent)}      <#if guidbase.has_child_widget(widget, "secondary")><view class="tile-secondary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "secondary"))} }}</view></#if>
${""?left_pad(indent)}      <#if guidbase.has_child_widget(widget, "tertiary")><view class="tile-tertiary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "tertiary"))} }}</view></#if>
${""?left_pad(indent)}    </view>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}</view>
</#macro>

<#--
182. role_assignment (角色分配)
+-----------------------------------------------+
| +-------+  [primary]                 [status] |
| |avatar |  [secondary]                        |
| +-------+                                     |
| [tags]                                        |
+-----------------------------------------------+
-->
<#macro print_tile_role_assignment widget varname="row" indent=0>
${""?left_pad(indent)}<view class="tile tile-role-assignment layout-profile">
${""?left_pad(indent)}  <view class="tile-row">
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "avatar")><view class="tile-avatar"><image src="{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "avatar"))} }}"></image></view></#if>
${""?left_pad(indent)}    <view class="tile-body">
${""?left_pad(indent)}      <view class="tile-row">
${""?left_pad(indent)}        <#if guidbase.has_child_widget(widget, "primary")><view class="tile-primary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))} }}</view></#if>
${""?left_pad(indent)}        <#if guidbase.has_child_widget(widget, "status")><view class="tile-status">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))} }}</view></#if>
${""?left_pad(indent)}      </view>
${""?left_pad(indent)}      <#if guidbase.has_child_widget(widget, "secondary")><view class="tile-secondary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "secondary"))} }}</view></#if>
${""?left_pad(indent)}    </view>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}  <#if guidbase.has_child_widget(widget, "tags")>
${""?left_pad(indent)}  <view class="tile-footer">
${""?left_pad(indent)}    <view class="tile-tags"><text wx:for="{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "tags"))} }}" wx:for-item="tag" wx:key="*this" class="tile-tag">{{ tag }}</text></view>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}  </#if>
${""?left_pad(indent)}</view>
</#macro>

<#--
183. audit_event_detail (审核事件明细)
+===============================================+
|                 [background]                  |
|                                               |
|  +-------+  [primary]                         |
|  |avatar |  [secondary]                       |
|  +-------+                                    |
|  [start_time]                        [status] |
+===============================================+
-->
<#macro print_tile_audit_event_detail widget varname="row" indent=0>
${""?left_pad(indent)}<view class="tile tile-audit-event-detail layout-background">
${""?left_pad(indent)}  <#if guidbase.has_child_widget(widget, "background")>
${""?left_pad(indent)}  <view class="tile-background"><image src="{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "background"))} }}"></image></view>
${""?left_pad(indent)}  </#if>
${""?left_pad(indent)}  <view class="tile-overlay">
${""?left_pad(indent)}    <view class="tile-row">
${""?left_pad(indent)}      <#if guidbase.has_child_widget(widget, "avatar")><view class="tile-avatar"><image src="{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "avatar"))} }}"></image></view></#if>
${""?left_pad(indent)}      <view class="tile-body">
${""?left_pad(indent)}        <#if guidbase.has_child_widget(widget, "primary")><view class="tile-primary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))} }}</view></#if>
${""?left_pad(indent)}        <#if guidbase.has_child_widget(widget, "secondary")><view class="tile-secondary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "secondary"))} }}</view></#if>
${""?left_pad(indent)}      </view>
${""?left_pad(indent)}    </view>
${""?left_pad(indent)}    <view class="tile-footer">
${""?left_pad(indent)}      <#if guidbase.has_child_widget(widget, "start_time")><text class="tile-start-time">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "start_time"))} }}</text></#if>
${""?left_pad(indent)}      <#if guidbase.has_child_widget(widget, "status")><text class="tile-status">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))} }}</text></#if>
${""?left_pad(indent)}    </view>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}</view>
</#macro>

<#--
184. incident_summary (突发事件摘要)
+===============================================+
|                 [background]                  |
|                                               |
|  [status]                                     |
|  [primary]                                    |
|  [secondary]                                  |
|                                               |
|  [start_time] - [end_time]                    |
+===============================================+
-->
<#macro print_tile_incident_summary widget varname="row" indent=0>
${""?left_pad(indent)}<view class="tile tile-incident-summary layout-background">
${""?left_pad(indent)}  <#if guidbase.has_child_widget(widget, "background")>
${""?left_pad(indent)}  <view class="tile-background"><image src="{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "background"))} }}"></image></view>
${""?left_pad(indent)}  </#if>
${""?left_pad(indent)}  <view class="tile-overlay">
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "status")><view class="tile-status">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))} }}</view></#if>
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "primary")><view class="tile-primary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))} }}</view></#if>
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "secondary")><view class="tile-secondary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "secondary"))} }}</view></#if>
${""?left_pad(indent)}    <view class="tile-footer">
${""?left_pad(indent)}      <text class="tile-time">
${""?left_pad(indent)}        <#if guidbase.has_child_widget(widget, "start_time")><text>{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "start_time"))} }}</text></#if>
${""?left_pad(indent)}        <#if guidbase.has_child_widget(widget, "start_time") && guidbase.has_child_widget(widget, "end_time")><text> - </text></#if>
${""?left_pad(indent)}        <#if guidbase.has_child_widget(widget, "end_time")><text>{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "end_time"))} }}</text></#if>
${""?left_pad(indent)}      </text>
${""?left_pad(indent)}    </view>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}</view>
</#macro>

<#--
185. incident_timeline (事件时间轴)
+-----------------------------------------------+
| [start_time]                         [status] |
|                                               |
| [primary]                                     |
| [secondary]                                   |
|                                               |
| [avatars]                                     |
+-----------------------------------------------+
-->
<#macro print_tile_incident_timeline widget varname="row" indent=0>
${""?left_pad(indent)}<view class="tile tile-incident-timeline layout-timeline">
${""?left_pad(indent)}  <view class="tile-row tile-header">
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "start_time")><text class="tile-start-time">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "start_time"))} }}</text></#if>
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "status")><text class="tile-status">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))} }}</text></#if>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}  <view class="tile-body">
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "primary")><view class="tile-primary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))} }}</view></#if>
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "secondary")><view class="tile-secondary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "secondary"))} }}</view></#if>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}  <#if guidbase.has_child_widget(widget, "avatars")>
${""?left_pad(indent)}  <view class="tile-footer">
${""?left_pad(indent)}    <view class="tile-avatars"><image wx:for="{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "avatars"))} }}" wx:for-item="av" wx:key="*this" src="{{ av }}" class="tile-avatar-img"></image></view>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}  </#if>
${""?left_pad(indent)}</view>
</#macro>

<#--
186. on_call_shift (值班排班)
+-----------------------------------------------+
| [start_time] - [end_time]            [status] |
|                                               |
| +-------+  [primary]                          |
| |avatar |                                     |
| +-------+                                     |
+-----------------------------------------------+
-->
<#macro print_tile_on_call_shift widget varname="row" indent=0>
${""?left_pad(indent)}<view class="tile tile-on-call-shift layout-timeline">
${""?left_pad(indent)}  <view class="tile-row tile-header">
${""?left_pad(indent)}    <text class="tile-time">
${""?left_pad(indent)}      <#if guidbase.has_child_widget(widget, "start_time")><text>{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "start_time"))} }}</text></#if>
${""?left_pad(indent)}      <#if guidbase.has_child_widget(widget, "start_time") && guidbase.has_child_widget(widget, "end_time")><text> - </text></#if>
${""?left_pad(indent)}      <#if guidbase.has_child_widget(widget, "end_time")><text>{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "end_time"))} }}</text></#if>
${""?left_pad(indent)}    </text>
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "status")><text class="tile-status">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))} }}</text></#if>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}  <view class="tile-row tile-body">
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "avatar")><view class="tile-avatar"><image src="{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "avatar"))} }}"></image></view></#if>
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "primary")><view class="tile-primary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))} }}</view></#if>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}</view>
</#macro>

<#--
187. escalation_rule (升级规则)
+-----------------------------------------------+
| [status]                                      |
|                                               |
| [primary]                                     |
| [secondary]                                   |
|                                               |
| [tags]                                        |
+-----------------------------------------------+
-->
<#macro print_tile_escalation_rule widget varname="row" indent=0>
${""?left_pad(indent)}<view class="tile tile-escalation-rule layout-content">
${""?left_pad(indent)}  <view class="tile-row tile-header">
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "status")><text class="tile-status">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))} }}</text></#if>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}  <view class="tile-body">
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "primary")><view class="tile-primary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))} }}</view></#if>
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "secondary")><view class="tile-secondary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "secondary"))} }}</view></#if>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}  <#if guidbase.has_child_widget(widget, "tags")>
${""?left_pad(indent)}  <view class="tile-footer">
${""?left_pad(indent)}    <view class="tile-tags"><text wx:for="{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "tags"))} }}" wx:for-item="tag" wx:key="*this" class="tile-tag">{{ tag }}</text></view>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}  </#if>
${""?left_pad(indent)}</view>
</#macro>

<#--
188. runbook_step (运行手册步骤)
+-----------------------------------------------+
| [status]                           [start_time]|
|                                               |
| [primary]                                     |
| [secondary]                                   |
|                                               |
|                                    [end_time] |
+-----------------------------------------------+
-->
<#macro print_tile_runbook_step widget varname="row" indent=0>
${""?left_pad(indent)}<view class="tile tile-runbook-step layout-timeline">
${""?left_pad(indent)}  <view class="tile-row tile-header">
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "status")><text class="tile-status">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))} }}</text></#if>
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "start_time")><text class="tile-start-time">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "start_time"))} }}</text></#if>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}  <view class="tile-body">
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "primary")><view class="tile-primary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))} }}</view></#if>
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "secondary")><view class="tile-secondary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "secondary"))} }}</view></#if>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}  <view class="tile-footer">
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "end_time")><text class="tile-end-time">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "end_time"))} }}</text></#if>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}</view>
</#macro>

<#--
189. monitor_check (监控检查)
+-----------------------------------------------+
| [status]                         [start_time] |
|                                               |
| [primary]                                     |
| [secondary]                                   |
+-----------------------------------------------+
-->
<#macro print_tile_monitor_check widget varname="row" indent=0>
${""?left_pad(indent)}<view class="tile tile-monitor-check layout-timeline">
${""?left_pad(indent)}  <view class="tile-row tile-header">
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "status")><text class="tile-status">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))} }}</text></#if>
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "start_time")><text class="tile-start-time">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "start_time"))} }}</text></#if>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}  <view class="tile-body">
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "primary")><view class="tile-primary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))} }}</view></#if>
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "secondary")><view class="tile-secondary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "secondary"))} }}</view></#if>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}</view>
</#macro>

<#--
190. alert_group (警报组)
+===============================================+
|                 [background]                  |
|                                               |
|  [status]                                     |
|  [primary]                                    |
|                                               |
|  [avatars]                             [tags] |
+===============================================+
-->
<#macro print_tile_alert_group widget varname="row" indent=0>
${""?left_pad(indent)}<view class="tile tile-alert-group layout-background">
${""?left_pad(indent)}  <#if guidbase.has_child_widget(widget, "background")>
${""?left_pad(indent)}  <view class="tile-background"><image src="{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "background"))} }}"></image></view>
${""?left_pad(indent)}  </#if>
${""?left_pad(indent)}  <view class="tile-overlay">
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "status")><view class="tile-status">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))} }}</view></#if>
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "primary")><view class="tile-primary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))} }}</view></#if>
${""?left_pad(indent)}    <view class="tile-footer">
${""?left_pad(indent)}      <#if guidbase.has_child_widget(widget, "avatars")>
${""?left_pad(indent)}      <view class="tile-avatars"><image wx:for="{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "avatars"))} }}" wx:for-item="av" wx:key="*this" src="{{ av }}" class="tile-avatar-img"></image></view>
${""?left_pad(indent)}      </#if>
${""?left_pad(indent)}      <#if guidbase.has_child_widget(widget, "tags")>
${""?left_pad(indent)}      <view class="tile-tags"><text wx:for="{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "tags"))} }}" wx:for-item="tag" wx:key="*this" class="tile-tag">{{ tag }}</text></view>
${""?left_pad(indent)}      </#if>
${""?left_pad(indent)}    </view>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}</view>
</#macro>

WXML 瓦片模板设计 (191 至 215)

<#--
 ###############################################################################
 ### 瓦片模板定义 191 至 215
 ###############################################################################
-->

<#--
191. log_entry (日志条目)
+-----------------------------------------------+
| [start_time]                         [status] |
|                                               |
| [primary]                                     |
| [secondary]                                   |
|                                               |
| [tags]                                        |
+-----------------------------------------------+
-->
<#macro print_tile_log_entry widget varname="row" indent=0>
${""?left_pad(indent)}<view class="tile tile-log-entry layout-timeline">
${""?left_pad(indent)}  <view class="tile-row tile-header">
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "start_time")><text class="tile-start-time">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "start_time"))} }}</text></#if>
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "status")><text class="tile-status">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))} }}</text></#if>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}  <view class="tile-body">
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "primary")><view class="tile-primary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))} }}</view></#if>
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "secondary")><view class="tile-secondary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "secondary"))} }}</view></#if>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}  <#if guidbase.has_child_widget(widget, "tags")>
${""?left_pad(indent)}  <view class="tile-footer">
${""?left_pad(indent)}    <view class="tile-tags"><text wx:for="{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "tags"))} }}" wx:for-item="tag" wx:key="*this" class="tile-tag">{{ tag }}</text></view>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}  </#if>
${""?left_pad(indent)}</view>
</#macro>

<#--
192. trace_span (追踪跨度)
+-----------------------------------------------+
| [start_time] - [end_time]                     |
|                                               |
| [primary]                                     |
| [secondary]                                   |
|                                               |
|                                      [status] |
+-----------------------------------------------+
-->
<#macro print_tile_trace_span widget varname="row" indent=0>
${""?left_pad(indent)}<view class="tile tile-trace-span layout-timeline">
${""?left_pad(indent)}  <view class="tile-row tile-header">
${""?left_pad(indent)}    <text class="tile-time">
${""?left_pad(indent)}      <#if guidbase.has_child_widget(widget, "start_time")><text>{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "start_time"))} }}</text></#if>
${""?left_pad(indent)}      <#if guidbase.has_child_widget(widget, "start_time") && guidbase.has_child_widget(widget, "end_time")><text> - </text></#if>
${""?left_pad(indent)}      <#if guidbase.has_child_widget(widget, "end_time")><text>{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "end_time"))} }}</text></#if>
${""?left_pad(indent)}    </text>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}  <view class="tile-body">
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "primary")><view class="tile-primary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))} }}</view></#if>
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "secondary")><view class="tile-secondary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "secondary"))} }}</view></#if>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}  <view class="tile-footer">
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "status")><text class="tile-status">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))} }}</text></#if>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}</view>
</#macro>

<#--
193. request_detail (请求明细)
+-----------------------------------------------+
| [status]                         [start_time] |
|                                               |
| [primary]                                     |
| [secondary]                                   |
| [tertiary]                                    |
+-----------------------------------------------+
-->
<#macro print_tile_request_detail widget varname="row" indent=0>
${""?left_pad(indent)}<view class="tile tile-request-detail layout-timeline">
${""?left_pad(indent)}  <view class="tile-row tile-header">
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "status")><text class="tile-status">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))} }}</text></#if>
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "start_time")><text class="tile-start-time">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "start_time"))} }}</text></#if>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}  <view class="tile-body">
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "primary")><view class="tile-primary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))} }}</view></#if>
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "secondary")><view class="tile-secondary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "secondary"))} }}</view></#if>
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "tertiary")><view class="tile-tertiary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "tertiary"))} }}</view></#if>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}</view>
</#macro>

<#--
194. server_card (服务器卡片)
+-----------------------------------------------+
| +-------------------------------------------+ |
| |                  [image]                  | |
| +-------------------------------------------+ |
| [primary]                                     |
| [secondary]                                   |
|                                               |
| [tags]                               [status] |
+-----------------------------------------------+
-->
<#macro print_tile_server_card widget varname="row" indent=0>
${""?left_pad(indent)}<view class="tile tile-server-card layout-media">
${""?left_pad(indent)}  <#if guidbase.has_child_widget(widget, "image")>
${""?left_pad(indent)}  <view class="tile-image"><image src="{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "image"))} }}"></image></view>
${""?left_pad(indent)}  </#if>
${""?left_pad(indent)}  <view class="tile-body">
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "primary")><view class="tile-primary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))} }}</view></#if>
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "secondary")><view class="tile-secondary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "secondary"))} }}</view></#if>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}  <view class="tile-footer">
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "tags")>
${""?left_pad(indent)}    <view class="tile-tags"><text wx:for="{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "tags"))} }}" wx:for-item="tag" wx:key="*this" class="tile-tag">{{ tag }}</text></view>
${""?left_pad(indent)}    </#if>
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "status")><text class="tile-status">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))} }}</text></#if>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}</view>
</#macro>

<#--
195. container_card (容器卡片)
+-----------------------------------------------+
| +-------------------------------------------+ |
| |                  [image]                  | |
| +-------------------------------------------+ |
| [primary]                                     |
| [secondary]                                   |
|                                               |
| [avatars]                            [status] |
+-----------------------------------------------+
-->
<#macro print_tile_container_card widget varname="row" indent=0>
${""?left_pad(indent)}<view class="tile tile-container-card layout-media">
${""?left_pad(indent)}  <#if guidbase.has_child_widget(widget, "image")>
${""?left_pad(indent)}  <view class="tile-image"><image src="{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "image"))} }}"></image></view>
${""?left_pad(indent)}  </#if>
${""?left_pad(indent)}  <view class="tile-body">
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "primary")><view class="tile-primary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))} }}</view></#if>
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "secondary")><view class="tile-secondary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "secondary"))} }}</view></#if>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}  <view class="tile-footer">
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "avatars")>
${""?left_pad(indent)}    <view class="tile-avatars"><image wx:for="{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "avatars"))} }}" wx:for-item="av" wx:key="*this" src="{{ av }}" class="tile-avatar-img"></image></view>
${""?left_pad(indent)}    </#if>
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "status")><text class="tile-status">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))} }}</text></#if>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}</view>
</#macro>

<#--
196. cloud_region (云服务区域)
+===============================================+
|                 [background]                  |
|                                               |
|  [primary]                           [status] |
|  [secondary]                                  |
|                                               |
|  [tags]                                       |
+===============================================+
-->
<#macro print_tile_cloud_region widget varname="row" indent=0>
${""?left_pad(indent)}<view class="tile tile-cloud-region layout-background">
${""?left_pad(indent)}  <#if guidbase.has_child_widget(widget, "background")>
${""?left_pad(indent)}  <view class="tile-background"><image src="{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "background"))} }}"></image></view>
${""?left_pad(indent)}  </#if>
${""?left_pad(indent)}  <view class="tile-overlay">
${""?left_pad(indent)}    <view class="tile-row tile-header">
${""?left_pad(indent)}      <#if guidbase.has_child_widget(widget, "status")><text class="tile-status">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))} }}</text></#if>
${""?left_pad(indent)}    </view>
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "primary")><view class="tile-primary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))} }}</view></#if>
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "secondary")><view class="tile-secondary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "secondary"))} }}</view></#if>
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "tags")>
${""?left_pad(indent)}    <view class="tile-footer">
${""?left_pad(indent)}      <view class="tile-tags"><text wx:for="{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "tags"))} }}" wx:for-item="tag" wx:key="*this" class="tile-tag">{{ tag }}</text></view>
${""?left_pad(indent)}    </view>
${""?left_pad(indent)}    </#if>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}</view>
</#macro>

<#--
197. integration_card (集成卡片)
+-----------------------------------------------+
| +-------------------------------------------+ |
| |                  [image]                  | |
| +-------------------------------------------+ |
| [primary]                                     |
| [secondary]                                   |
|                                               |
| [start_time]                         [status] |
+-----------------------------------------------+
-->
<#macro print_tile_integration_card widget varname="row" indent=0>
${""?left_pad(indent)}<view class="tile tile-integration-card layout-media">
${""?left_pad(indent)}  <#if guidbase.has_child_widget(widget, "image")>
${""?left_pad(indent)}  <view class="tile-image"><image src="{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "image"))} }}"></image></view>
${""?left_pad(indent)}  </#if>
${""?left_pad(indent)}  <view class="tile-body">
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "primary")><view class="tile-primary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))} }}</view></#if>
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "secondary")><view class="tile-secondary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "secondary"))} }}</view></#if>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}  <view class="tile-footer">
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "start_time")><text class="tile-start-time">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "start_time"))} }}</text></#if>
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "status")><text class="tile-status">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))} }}</text></#if>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}</view>
</#macro>

<#--
198. webhook_event (网络钩子事件)
+-----------------------------------------------+
| [status]                                      |
|                                               |
| [primary]                                     |
| [secondary]                                   |
|                                               |
| [start_time] - [end_time]                     |
+-----------------------------------------------+
-->
<#macro print_tile_webhook_event widget varname="row" indent=0>
${""?left_pad(indent)}<view class="tile tile-webhook-event layout-timeline">
${""?left_pad(indent)}  <view class="tile-row tile-header">
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "status")><text class="tile-status">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))} }}</text></#if>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}  <view class="tile-body">
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "primary")><view class="tile-primary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))} }}</view></#if>
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "secondary")><view class="tile-secondary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "secondary"))} }}</view></#if>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}  <view class="tile-footer">
${""?left_pad(indent)}    <text class="tile-time">
${""?left_pad(indent)}      <#if guidbase.has_child_widget(widget, "start_time")><text>{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "start_time"))} }}</text></#if>
${""?left_pad(indent)}      <#if guidbase.has_child_widget(widget, "start_time") && guidbase.has_child_widget(widget, "end_time")><text> - </text></#if>
${""?left_pad(indent)}      <#if guidbase.has_child_widget(widget, "end_time")><text>{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "end_time"))} }}</text></#if>
${""?left_pad(indent)}    </text>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}</view>
</#macro>

<#--
199. automation_rule (自动化规则)
+-----------------------------------------------+
| [status]                                      |
|                                               |
| [primary]                                     |
| [secondary]                                   |
|                                               |
| [avatars]                              [tags] |
+-----------------------------------------------+
-->
<#macro print_tile_automation_rule widget varname="row" indent=0>
${""?left_pad(indent)}<view class="tile tile-automation-rule layout-profile">
${""?left_pad(indent)}  <view class="tile-row tile-header">
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "status")><text class="tile-status">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))} }}</text></#if>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}  <view class="tile-body">
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "primary")><view class="tile-primary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))} }}</view></#if>
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "secondary")><view class="tile-secondary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "secondary"))} }}</view></#if>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}  <view class="tile-footer">
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "avatars")>
${""?left_pad(indent)}    <view class="tile-avatars"><image wx:for="{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "avatars"))} }}" wx:for-item="av" wx:key="*this" src="{{ av }}" class="tile-avatar-img"></image></view>
${""?left_pad(indent)}    </#if>
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "tags")>
${""?left_pad(indent)}    <view class="tile-tags"><text wx:for="{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "tags"))} }}" wx:for-item="tag" wx:key="*this" class="tile-tag">{{ tag }}</text></view>
${""?left_pad(indent)}    </#if>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}</view>
</#macro>

<#--
200. workflow_run (工作流运行)
+-----------------------------------------------+
| [start_time] - [end_time]            [status] |
|                                               |
| [primary]                                     |
|                                               |
| [avatars]                                     |
+-----------------------------------------------+
-->
<#macro print_tile_workflow_run widget varname="row" indent=0>
${""?left_pad(indent)}<view class="tile tile-workflow-run layout-timeline">
${""?left_pad(indent)}  <view class="tile-row tile-header">
${""?left_pad(indent)}    <text class="tile-time">
${""?left_pad(indent)}      <#if guidbase.has_child_widget(widget, "start_time")><text>{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "start_time"))} }}</text></#if>
${""?left_pad(indent)}      <#if guidbase.has_child_widget(widget, "start_time") && guidbase.has_child_widget(widget, "end_time")><text> - </text></#if>
${""?left_pad(indent)}      <#if guidbase.has_child_widget(widget, "end_time")><text>{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "end_time"))} }}</text></#if>
${""?left_pad(indent)}    </text>
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "status")><text class="tile-status">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))} }}</text></#if>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}  <view class="tile-body">
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "primary")><view class="tile-primary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))} }}</view></#if>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}  <#if guidbase.has_child_widget(widget, "avatars")>
${""?left_pad(indent)}  <view class="tile-footer">
${""?left_pad(indent)}    <view class="tile-avatars"><image wx:for="{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "avatars"))} }}" wx:for-item="av" wx:key="*this" src="{{ av }}" class="tile-avatar-img"></image></view>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}  </#if>
${""?left_pad(indent)}</view>
</#macro>

<#--
201. queue_item (队列项目)
+-----------------------------------------------+
| [status]                         [start_time] |
|                                               |
| [primary]                                     |
| [secondary]                                   |
+-----------------------------------------------+
-->
<#macro print_tile_queue_item widget varname="row" indent=0>
${""?left_pad(indent)}<view class="tile tile-queue-item layout-timeline">
${""?left_pad(indent)}  <view class="tile-row tile-header">
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "status")><text class="tile-status">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))} }}</text></#if>
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "start_time")><text class="tile-start-time">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "start_time"))} }}</text></#if>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}  <view class="tile-body">
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "primary")><view class="tile-primary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))} }}</view></#if>
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "secondary")><view class="tile-secondary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "secondary"))} }}</view></#if>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}</view>
</#macro>

<#--
202. job_detail (工作明细)
+-----------------------------------------------+
| [status]                                      |
|                                               |
| [primary]                                     |
| [secondary]                                   |
| [tertiary]                                    |
|                                               |
|                                    [end_time] |
+-----------------------------------------------+
-->
<#macro print_tile_job_detail widget varname="row" indent=0>
${""?left_pad(indent)}<view class="tile tile-job-detail layout-timeline">
${""?left_pad(indent)}  <view class="tile-row tile-header">
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "status")><text class="tile-status">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))} }}</text></#if>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}  <view class="tile-body">
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "primary")><view class="tile-primary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))} }}</view></#if>
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "secondary")><view class="tile-secondary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "secondary"))} }}</view></#if>
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "tertiary")><view class="tile-tertiary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "tertiary"))} }}</view></#if>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}  <view class="tile-footer">
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "end_time")><text class="tile-end-time">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "end_time"))} }}</text></#if>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}</view>
</#macro>

<#--
203. schedule_rule (排程规则)
+-----------------------------------------------+
| [start_time] - [end_time]            [status] |
|                                               |
| [primary]                                     |
| [secondary]                                   |
+-----------------------------------------------+
-->
<#macro print_tile_schedule_rule widget varname="row" indent=0>
${""?left_pad(indent)}<view class="tile tile-schedule-rule layout-timeline">
${""?left_pad(indent)}  <view class="tile-row tile-header">
${""?left_pad(indent)}    <text class="tile-time">
${""?left_pad(indent)}      <#if guidbase.has_child_widget(widget, "start_time")><text>{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "start_time"))} }}</text></#if>
${""?left_pad(indent)}      <#if guidbase.has_child_widget(widget, "start_time") && guidbase.has_child_widget(widget, "end_time")><text> - </text></#if>
${""?left_pad(indent)}      <#if guidbase.has_child_widget(widget, "end_time")><text>{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "end_time"))} }}</text></#if>
${""?left_pad(indent)}    </text>
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "status")><text class="tile-status">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))} }}</text></#if>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}  <view class="tile-body">
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "primary")><view class="tile-primary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))} }}</view></#if>
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "secondary")><view class="tile-secondary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "secondary"))} }}</view></#if>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}</view>
</#macro>

<#--
204. recurring_task (循环任务)
+-----------------------------------------------+
| [start_time]                                  |
|                                               |
| [primary]                                     |
| [secondary]                                   |
|                                               |
| [avatars]                              [tags] |
+-----------------------------------------------+
-->
<#macro print_tile_recurring_task widget varname="row" indent=0>
${""?left_pad(indent)}<view class="tile tile-recurring-task layout-timeline">
${""?left_pad(indent)}  <view class="tile-row tile-header">
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "start_time")><text class="tile-start-time">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "start_time"))} }}</text></#if>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}  <view class="tile-body">
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "primary")><view class="tile-primary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))} }}</view></#if>
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "secondary")><view class="tile-secondary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "secondary"))} }}</view></#if>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}  <view class="tile-footer">
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "avatars")>
${""?left_pad(indent)}    <view class="tile-avatars"><image wx:for="{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "avatars"))} }}" wx:for-item="av" wx:key="*this" src="{{ av }}" class="tile-avatar-img"></image></view>
${""?left_pad(indent)}    </#if>
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "tags")>
${""?left_pad(indent)}    <view class="tile-tags"><text wx:for="{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "tags"))} }}" wx:for-item="tag" wx:key="*this" class="tile-tag">{{ tag }}</text></view>
${""?left_pad(indent)}    </#if>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}</view>
</#macro>

<#--
205. approval_inbox (审批收件箱)
+-----------------------------------------------+
| +-------+  [primary]                 [status] |
| |avatar |  [secondary]                        |
| +-------+                          [end_time] |
+-----------------------------------------------+
-->
<#macro print_tile_approval_inbox widget varname="row" indent=0>
${""?left_pad(indent)}<view class="tile tile-approval-inbox layout-timeline">
${""?left_pad(indent)}  <view class="tile-row">
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "avatar")><view class="tile-avatar"><image src="{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "avatar"))} }}"></image></view></#if>
${""?left_pad(indent)}    <view class="tile-body">
${""?left_pad(indent)}      <view class="tile-row">
${""?left_pad(indent)}        <#if guidbase.has_child_widget(widget, "primary")><view class="tile-primary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))} }}</view></#if>
${""?left_pad(indent)}        <#if guidbase.has_child_widget(widget, "status")><view class="tile-status">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))} }}</view></#if>
${""?left_pad(indent)}      </view>
${""?left_pad(indent)}      <#if guidbase.has_child_widget(widget, "secondary")><view class="tile-secondary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "secondary"))} }}</view></#if>
${""?left_pad(indent)}      <#if guidbase.has_child_widget(widget, "end_time")><view class="tile-end-time">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "end_time"))} }}</view></#if>
${""?left_pad(indent)}    </view>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}</view>
</#macro>

<#--
206. draft_item (草稿项目)
+-----------------------------------------------+
| +-------------------------------------------+ |
| |                  [image]                  | |
| +-------------------------------------------+ |
| [primary]                                     |
| [secondary]                          [status] |
+-----------------------------------------------+
-->
<#macro print_tile_draft_item widget varname="row" indent=0>
${""?left_pad(indent)}<view class="tile tile-draft-item layout-media">
${""?left_pad(indent)}  <#if guidbase.has_child_widget(widget, "image")>
${""?left_pad(indent)}  <view class="tile-image"><image src="{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "image"))} }}"></image></view>
${""?left_pad(indent)}  </#if>
${""?left_pad(indent)}  <view class="tile-body">
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "primary")><view class="tile-primary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))} }}</view></#if>
${""?left_pad(indent)}    <view class="tile-row">
${""?left_pad(indent)}      <#if guidbase.has_child_widget(widget, "secondary")><text class="tile-secondary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "secondary"))} }}</text></#if>
${""?left_pad(indent)}      <#if guidbase.has_child_widget(widget, "status")><text class="tile-status">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))} }}</text></#if>
${""?left_pad(indent)}    </view>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}</view>
</#macro>

<#--
207. publish_item (发布项目)
+-----------------------------------------------+
| +-------------------------------------------+ |
| |                  [image]                  | |
| +-------------------------------------------+ |
| [primary]                                     |
| [secondary]                                   |
|                                               |
| [start_time]                         [status] |
+-----------------------------------------------+
-->
<#macro print_tile_publish_item widget varname="row" indent=0>
${""?left_pad(indent)}<view class="tile tile-publish-item layout-media">
${""?left_pad(indent)}  <#if guidbase.has_child_widget(widget, "image")>
${""?left_pad(indent)}  <view class="tile-image"><image src="{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "image"))} }}"></image></view>
${""?left_pad(indent)}  </#if>
${""?left_pad(indent)}  <view class="tile-body">
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "primary")><view class="tile-primary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))} }}</view></#if>
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "secondary")><view class="tile-secondary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "secondary"))} }}</view></#if>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}  <view class="tile-footer">
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "start_time")><text class="tile-start-time">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "start_time"))} }}</text></#if>
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "status")><text class="tile-status">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))} }}</text></#if>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}</view>
</#macro>

<#--
208. campaign_card (活动卡片)
+===============================================+
|                 [background]                  |
|                                               |
|  [primary]                           [status] |
|  [secondary]                                  |
|                                               |
|  [tags]                                       |
+===============================================+
-->
<#macro print_tile_campaign_card widget varname="row" indent=0>
${""?left_pad(indent)}<view class="tile tile-campaign-card layout-background">
${""?left_pad(indent)}  <#if guidbase.has_child_widget(widget, "background")>
${""?left_pad(indent)}  <view class="tile-background"><image src="{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "background"))} }}"></image></view>
${""?left_pad(indent)}  </#if>
${""?left_pad(indent)}  <view class="tile-overlay">
${""?left_pad(indent)}    <view class="tile-row tile-header">
${""?left_pad(indent)}      <#if guidbase.has_child_widget(widget, "status")><text class="tile-status">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))} }}</text></#if>
${""?left_pad(indent)}    </view>
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "primary")><view class="tile-primary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))} }}</view></#if>
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "secondary")><view class="tile-secondary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "secondary"))} }}</view></#if>
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "tags")>
${""?left_pad(indent)}    <view class="tile-footer">
${""?left_pad(indent)}      <view class="tile-tags"><text wx:for="{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "tags"))} }}" wx:for-item="tag" wx:key="*this" class="tile-tag">{{ tag }}</text></view>
${""?left_pad(indent)}    </view>
${""?left_pad(indent)}    </#if>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}</view>
</#macro>

<#--
209. audience_segment (受众细分)
+-----------------------------------------------+
| [primary]                            [status] |
| [secondary]                                   |
|                                               |
| [avatars]                              [tags] |
+-----------------------------------------------+
-->
<#macro print_tile_audience_segment widget varname="row" indent=0>
${""?left_pad(indent)}<view class="tile tile-audience-segment layout-profile">
${""?left_pad(indent)}  <view class="tile-row tile-header">
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "primary")><view class="tile-primary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))} }}</view></#if>
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "status")><view class="tile-status">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))} }}</view></#if>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}  <view class="tile-body">
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "secondary")><view class="tile-secondary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "secondary"))} }}</view></#if>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}  <view class="tile-footer">
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "avatars")>
${""?left_pad(indent)}    <view class="tile-avatars"><image wx:for="{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "avatars"))} }}" wx:for-item="av" wx:key="*this" src="{{ av }}" class="tile-avatar-img"></image></view>
${""?left_pad(indent)}    </#if>
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "tags")>
${""?left_pad(indent)}    <view class="tile-tags"><text wx:for="{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "tags"))} }}" wx:for-item="tag" wx:key="*this" class="tile-tag">{{ tag }}</text></view>
${""?left_pad(indent)}    </#if>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}</view>
</#macro>

<#--
210. channel_summary (渠道摘要)
+-----------------------------------------------+
| +-------------------------------------------+ |
| |                  [image]                  | |
| +-------------------------------------------+ |
| [primary]                            [status] |
| [secondary]                                   |
| [tertiary]                                    |
+-----------------------------------------------+
-->
<#macro print_tile_channel_summary widget varname="row" indent=0>
${""?left_pad(indent)}<view class="tile tile-channel-summary layout-media">
${""?left_pad(indent)}  <#if guidbase.has_child_widget(widget, "image")>
${""?left_pad(indent)}  <view class="tile-image"><image src="{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "image"))} }}"></image></view>
${""?left_pad(indent)}  </#if>
${""?left_pad(indent)}  <view class="tile-body">
${""?left_pad(indent)}    <view class="tile-row tile-header">
${""?left_pad(indent)}      <#if guidbase.has_child_widget(widget, "primary")><view class="tile-primary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))} }}</view></#if>
${""?left_pad(indent)}      <#if guidbase.has_child_widget(widget, "status")><view class="tile-status">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))} }}</view></#if>
${""?left_pad(indent)}    </view>
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "secondary")><view class="tile-secondary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "secondary"))} }}</view></#if>
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "tertiary")><view class="tile-tertiary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "tertiary"))} }}</view></#if>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}</view>
</#macro>

<#--
211. social_account (社交账户)
+-----------------------------------------------+
| +-------+  [primary]                 [status] |
| |avatar |  [secondary]                        |
| +-------+                                     |
| [tags]                                        |
+-----------------------------------------------+
-->
<#macro print_tile_social_account widget varname="row" indent=0>
${""?left_pad(indent)}<view class="tile tile-social-account layout-profile">
${""?left_pad(indent)}  <view class="tile-row">
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "avatar")><view class="tile-avatar"><image src="{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "avatar"))} }}"></image></view></#if>
${""?left_pad(indent)}    <view class="tile-body">
${""?left_pad(indent)}      <view class="tile-row">
${""?left_pad(indent)}        <#if guidbase.has_child_widget(widget, "primary")><view class="tile-primary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))} }}</view></#if>
${""?left_pad(indent)}        <#if guidbase.has_child_widget(widget, "status")><view class="tile-status">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))} }}</view></#if>
${""?left_pad(indent)}      </view>
${""?left_pad(indent)}      <#if guidbase.has_child_widget(widget, "secondary")><view class="tile-secondary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "secondary"))} }}</view></#if>
${""?left_pad(indent)}    </view>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}  <#if guidbase.has_child_widget(widget, "tags")>
${""?left_pad(indent)}  <view class="tile-footer">
${""?left_pad(indent)}    <view class="tile-tags"><text wx:for="{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "tags"))} }}" wx:for-item="tag" wx:key="*this" class="tile-tag">{{ tag }}</text></view>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}  </#if>
${""?left_pad(indent)}</view>
</#macro>

<#--
212. post_scheduler (贴文排程)
+-----------------------------------------------+
| +-------------------------------------------+ |
| |                  [image]                  | |
| +-------------------------------------------+ |
| [primary]                                     |
|                                               |
| [start_time] - [end_time]            [status] |
+-----------------------------------------------+
-->
<#macro print_tile_post_scheduler widget varname="row" indent=0>
${""?left_pad(indent)}<view class="tile tile-post-scheduler layout-media">
${""?left_pad(indent)}  <#if guidbase.has_child_widget(widget, "image")>
${""?left_pad(indent)}  <view class="tile-image"><image src="{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "image"))} }}"></image></view>
${""?left_pad(indent)}  </#if>
${""?left_pad(indent)}  <view class="tile-body">
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "primary")><view class="tile-primary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))} }}</view></#if>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}  <view class="tile-footer">
${""?left_pad(indent)}    <text class="tile-time">
${""?left_pad(indent)}      <#if guidbase.has_child_widget(widget, "start_time")><text>{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "start_time"))} }}</text></#if>
${""?left_pad(indent)}      <#if guidbase.has_child_widget(widget, "start_time") && guidbase.has_child_widget(widget, "end_time")><text> - </text></#if>
${""?left_pad(indent)}      <#if guidbase.has_child_widget(widget, "end_time")><text>{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "end_time"))} }}</text></#if>
${""?left_pad(indent)}    </text>
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "status")><text class="tile-status">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))} }}</text></#if>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}</view>
</#macro>

<#--
213. content_calendar (内容日历)
+-----------------------------------------------+
| [start_time]                         [status] |
|                                               |
| [primary]                                     |
| [secondary]                                   |
|                                               |
| [tags]                                        |
+-----------------------------------------------+
-->
<#macro print_tile_content_calendar widget varname="row" indent=0>
${""?left_pad(indent)}<view class="tile tile-content-calendar layout-timeline">
${""?left_pad(indent)}  <view class="tile-row tile-header">
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "start_time")><text class="tile-start-time">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "start_time"))} }}</text></#if>
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "status")><text class="tile-status">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))} }}</text></#if>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}  <view class="tile-body">
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "primary")><view class="tile-primary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))} }}</view></#if>
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "secondary")><view class="tile-secondary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "secondary"))} }}</view></#if>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}  <#if guidbase.has_child_widget(widget, "tags")>
${""?left_pad(indent)}  <view class="tile-footer">
${""?left_pad(indent)}    <view class="tile-tags"><text wx:for="{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "tags"))} }}" wx:for-item="tag" wx:key="*this" class="tile-tag">{{ tag }}</text></view>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}  </#if>
${""?left_pad(indent)}</view>
</#macro>

<#--
214. brand_asset (品牌资产)
+-----------------------------------------------+
| +-------------------------------------------+ |
| |                  [image]                  | |
| +-------------------------------------------+ |
| [primary]                                     |
| [secondary]                                   |
|                                               |
| [tags]                                        |
+-----------------------------------------------+
-->
<#macro print_tile_brand_asset widget varname="row" indent=0>
${""?left_pad(indent)}<view class="tile tile-brand-asset layout-media">
${""?left_pad(indent)}  <#if guidbase.has_child_widget(widget, "image")>
${""?left_pad(indent)}  <view class="tile-image"><image src="{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "image"))} }}"></image></view>
${""?left_pad(indent)}  </#if>
${""?left_pad(indent)}  <view class="tile-body">
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "primary")><view class="tile-primary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))} }}</view></#if>
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "secondary")><view class="tile-secondary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "secondary"))} }}</view></#if>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}  <#if guidbase.has_child_widget(widget, "tags")>
${""?left_pad(indent)}  <view class="tile-footer">
${""?left_pad(indent)}    <view class="tile-tags"><text wx:for="{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "tags"))} }}" wx:for-item="tag" wx:key="*this" class="tile-tag">{{ tag }}</text></view>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}  </#if>
${""?left_pad(indent)}</view>
</#macro>

<#--
215. theme_preview (主题预览)
+===============================================+
|                 [background]                  |
|                                               |
|  [primary]                           [status] |
|  [secondary]                                  |
+===============================================+
-->
<#macro print_tile_theme_preview widget varname="row" indent=0>
${""?left_pad(indent)}<view class="tile tile-theme-preview layout-background">
${""?left_pad(indent)}  <#if guidbase.has_child_widget(widget, "background")>
${""?left_pad(indent)}  <view class="tile-background"><image src="{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "background"))} }}"></image></view>
${""?left_pad(indent)}  </#if>
${""?left_pad(indent)}  <view class="tile-overlay">
${""?left_pad(indent)}    <view class="tile-row tile-header">
${""?left_pad(indent)}      <#if guidbase.has_child_widget(widget, "status")><text class="tile-status">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))} }}</text></#if>
${""?left_pad(indent)}    </view>
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "primary")><view class="tile-primary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))} }}</view></#if>
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "secondary")><view class="tile-secondary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "secondary"))} }}</view></#if>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}</view>
</#macro>

WXML 瓦片模板设计 (216 至 236)

<#--
 ###############################################################################
 ### 瓦片模板定义 216 至 236
 ###############################################################################
-->

<#--
216. component_variant (组件变量)
+-----------------------------------------------+
| +-------------------------------------------+ |
| |                  [image]                  | |
| +-------------------------------------------+ |
| [primary]                                     |
| [secondary]                                   |
| [tertiary]                                    |
|                                               |
| [tags]                                        |
+-----------------------------------------------+
-->
<#macro print_tile_component_variant widget varname="row" indent=0>
${""?left_pad(indent)}<view class="tile tile-component-variant layout-media">
${""?left_pad(indent)}  <#if guidbase.has_child_widget(widget, "image")>
${""?left_pad(indent)}  <view class="tile-image"><image src="{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "image"))} }}"></image></view>
${""?left_pad(indent)}  </#if>
${""?left_pad(indent)}  <view class="tile-body">
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "primary")><view class="tile-primary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))} }}</view></#if>
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "secondary")><view class="tile-secondary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "secondary"))} }}</view></#if>
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "tertiary")><view class="tile-tertiary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "tertiary"))} }}</view></#if>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}  <#if guidbase.has_child_widget(widget, "tags")>
${""?left_pad(indent)}  <view class="tile-footer">
${""?left_pad(indent)}    <view class="tile-tags"><text wx:for="{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "tags"))} }}" wx:for-item="tag" wx:key="*this" class="tile-tag">{{ tag }}</text></view>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}  </#if>
${""?left_pad(indent)}</view>
</#macro>

<#--
217. design_token (设计令牌)
+-----------------------------------------------+
| [primary]                            [status] |
| [secondary]                                   |
|                                               |
| [tags]                                        |
+-----------------------------------------------+
-->
<#macro print_tile_design_token widget varname="row" indent=0>
${""?left_pad(indent)}<view class="tile tile-design-token layout-content">
${""?left_pad(indent)}  <view class="tile-row tile-header">
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "primary")><view class="tile-primary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))} }}</view></#if>
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "status")><view class="tile-status">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))} }}</view></#if>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}  <view class="tile-body">
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "secondary")><view class="tile-secondary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "secondary"))} }}</view></#if>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}  <#if guidbase.has_child_widget(widget, "tags")>
${""?left_pad(indent)}  <view class="tile-footer">
${""?left_pad(indent)}    <view class="tile-tags"><text wx:for="{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "tags"))} }}" wx:for-item="tag" wx:key="*this" class="tile-tag">{{ tag }}</text></view>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}  </#if>
${""?left_pad(indent)}</view>
</#macro>

<#--
218. ui_pattern (UI 模式)
+-----------------------------------------------+
| +-------------------------------------------+ |
| |                  [image]                  | |
| +-------------------------------------------+ |
| [primary]                                     |
| [secondary]                          [status] |
+-----------------------------------------------+
-->
<#macro print_tile_ui_pattern widget varname="row" indent=0>
${""?left_pad(indent)}<view class="tile tile-ui-pattern layout-media">
${""?left_pad(indent)}  <#if guidbase.has_child_widget(widget, "image")>
${""?left_pad(indent)}  <view class="tile-image"><image src="{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "image"))} }}"></image></view>
${""?left_pad(indent)}  </#if>
${""?left_pad(indent)}  <view class="tile-body">
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "primary")><view class="tile-primary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))} }}</view></#if>
${""?left_pad(indent)}    <view class="tile-row">
${""?left_pad(indent)}      <#if guidbase.has_child_widget(widget, "secondary")><text class="tile-secondary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "secondary"))} }}</text></#if>
${""?left_pad(indent)}      <#if guidbase.has_child_widget(widget, "status")><text class="tile-status">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))} }}</text></#if>
${""?left_pad(indent)}    </view>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}</view>
</#macro>

<#--
219. prototype_screen (原型屏幕)
+-----------------------------------------------+
| +-------------------------------------------+ |
| |                  [image]                  | |
| +-------------------------------------------+ |
| [primary]                                     |
| [secondary]                                   |
|                                               |
| [avatars]                                     |
+-----------------------------------------------+
-->
<#macro print_tile_prototype_screen widget varname="row" indent=0>
${""?left_pad(indent)}<view class="tile tile-prototype-screen layout-media">
${""?left_pad(indent)}  <#if guidbase.has_child_widget(widget, "image")>
${""?left_pad(indent)}  <view class="tile-image"><image src="{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "image"))} }}"></image></view>
${""?left_pad(indent)}  </#if>
${""?left_pad(indent)}  <view class="tile-body">
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "primary")><view class="tile-primary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))} }}</view></#if>
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "secondary")><view class="tile-secondary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "secondary"))} }}</view></#if>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}  <#if guidbase.has_child_widget(widget, "avatars")>
${""?left_pad(indent)}  <view class="tile-footer">
${""?left_pad(indent)}    <view class="tile-avatars"><image wx:for="{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "avatars"))} }}" wx:for-item="av" wx:key="*this" src="{{ av }}" class="tile-avatar-img"></image></view>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}  </#if>
${""?left_pad(indent)}</view>
</#macro>

<#--
220. handoff_item (对接项目)
+-----------------------------------------------+
| +-------+  [primary]                          |
| |avatar |  [secondary]                        |
| +-------+                                     |
| [start_time]                         [status] |
+-----------------------------------------------+
-->
<#macro print_tile_handoff_item widget varname="row" indent=0>
${""?left_pad(indent)}<view class="tile tile-handoff-item layout-timeline">
${""?left_pad(indent)}  <view class="tile-row">
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "avatar")><view class="tile-avatar"><image src="{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "avatar"))} }}"></image></view></#if>
${""?left_pad(indent)}    <view class="tile-body">
${""?left_pad(indent)}      <#if guidbase.has_child_widget(widget, "primary")><view class="tile-primary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))} }}</view></#if>
${""?left_pad(indent)}      <#if guidbase.has_child_widget(widget, "secondary")><view class="tile-secondary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "secondary"))} }}</view></#if>
${""?left_pad(indent)}    </view>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}  <view class="tile-footer">
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "start_time")><text class="tile-start-time">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "start_time"))} }}</text></#if>
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "status")><text class="tile-status">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))} }}</text></#if>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}</view>
</#macro>

<#--
221. accessibility_check (无障碍检查)
+-----------------------------------------------+
| [status]                                      |
|                                               |
| [primary]                                     |
| [secondary]                                   |
|                                               |
| [tags]                                        |
+-----------------------------------------------+
-->
<#macro print_tile_accessibility_check widget varname="row" indent=0>
${""?left_pad(indent)}<view class="tile tile-accessibility-check layout-content">
${""?left_pad(indent)}  <view class="tile-row tile-header">
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "status")><text class="tile-status">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))} }}</text></#if>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}  <view class="tile-body">
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "primary")><view class="tile-primary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))} }}</view></#if>
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "secondary")><view class="tile-secondary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "secondary"))} }}</view></#if>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}  <#if guidbase.has_child_widget(widget, "tags")>
${""?left_pad(indent)}  <view class="tile-footer">
${""?left_pad(indent)}    <view class="tile-tags"><text wx:for="{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "tags"))} }}" wx:for-item="tag" wx:key="*this" class="tile-tag">{{ tag }}</text></view>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}  </#if>
${""?left_pad(indent)}</view>
</#macro>

<#--
222. translation_item (翻译项目)
+-----------------------------------------------+
| [primary]                            [status] |
| [secondary]                                   |
| [tertiary]                                    |
|                                               |
| [tags]                                        |
+-----------------------------------------------+
-->
<#macro print_tile_translation_item widget varname="row" indent=0>
${""?left_pad(indent)}<view class="tile tile-translation-item layout-content">
${""?left_pad(indent)}  <view class="tile-row tile-header">
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "primary")><view class="tile-primary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))} }}</view></#if>
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "status")><view class="tile-status">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))} }}</view></#if>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}  <view class="tile-body">
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "secondary")><view class="tile-secondary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "secondary"))} }}</view></#if>
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "tertiary")><view class="tile-tertiary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "tertiary"))} }}</view></#if>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}  <#if guidbase.has_child_widget(widget, "tags")>
${""?left_pad(indent)}  <view class="tile-footer">
${""?left_pad(indent)}    <view class="tile-tags"><text wx:for="{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "tags"))} }}" wx:for-item="tag" wx:key="*this" class="tile-tag">{{ tag }}</text></view>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}  </#if>
${""?left_pad(indent)}</view>
</#macro>

<#--
223. localization_status (本地化状态)
+-----------------------------------------------+
| [status]                         [start_time] |
|                                               |
| [primary]                                     |
| [secondary]                                   |
+-----------------------------------------------+
-->
<#macro print_tile_localization_status widget varname="row" indent=0>
${""?left_pad(indent)}<view class="tile tile-localization-status layout-timeline">
${""?left_pad(indent)}  <view class="tile-row tile-header">
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "status")><text class="tile-status">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))} }}</text></#if>
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "start_time")><text class="tile-start-time">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "start_time"))} }}</text></#if>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}  <view class="tile-body">
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "primary")><view class="tile-primary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))} }}</view></#if>
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "secondary")><view class="tile-secondary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "secondary"))} }}</view></#if>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}</view>
</#macro>

<#--
224. language_pack (语言包)
+-----------------------------------------------+
| +-------------------------------------------+ |
| |                  [image]                  | |
| +-------------------------------------------+ |
| [primary]                                     |
| [secondary]                                   |
|                                               |
| [avatars]                            [status] |
+-----------------------------------------------+
-->
<#macro print_tile_language_pack widget varname="row" indent=0>
${""?left_pad(indent)}<view class="tile tile-language-pack layout-media">
${""?left_pad(indent)}  <#if guidbase.has_child_widget(widget, "image")>
${""?left_pad(indent)}  <view class="tile-image"><image src="{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "image"))} }}"></image></view>
${""?left_pad(indent)}  </#if>
${""?left_pad(indent)}  <view class="tile-body">
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "primary")><view class="tile-primary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))} }}</view></#if>
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "secondary")><view class="tile-secondary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "secondary"))} }}</view></#if>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}  <view class="tile-footer">
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "avatars")>
${""?left_pad(indent)}    <view class="tile-avatars"><image wx:for="{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "avatars"))} }}" wx:for-item="av" wx:key="*this" src="{{ av }}" class="tile-avatar-img"></image></view>
${""?left_pad(indent)}    </#if>
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "status")><text class="tile-status">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))} }}</text></#if>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}</view>
</#macro>

<#--
225. release_calendar (发布日历)
+-----------------------------------------------+
| [start_time] - [end_time]            [status] |
|                                               |
| [primary]                                     |
|                                               |
| [tags]                                        |
+-----------------------------------------------+
-->
<#macro print_tile_release_calendar widget varname="row" indent=0>
${""?left_pad(indent)}<view class="tile tile-release-calendar layout-timeline">
${""?left_pad(indent)}  <view class="tile-row tile-header">
${""?left_pad(indent)}    <text class="tile-time">
${""?left_pad(indent)}      <#if guidbase.has_child_widget(widget, "start_time")><text>{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "start_time"))} }}</text></#if>
${""?left_pad(indent)}      <#if guidbase.has_child_widget(widget, "start_time") && guidbase.has_child_widget(widget, "end_time")><text> - </text></#if>
${""?left_pad(indent)}      <#if guidbase.has_child_widget(widget, "end_time")><text>{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "end_time"))} }}</text></#if>
${""?left_pad(indent)}    </text>
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "status")><text class="tile-status">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))} }}</text></#if>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}  <view class="tile-body">
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "primary")><view class="tile-primary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))} }}</view></#if>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}  <#if guidbase.has_child_widget(widget, "tags")>
${""?left_pad(indent)}  <view class="tile-footer">
${""?left_pad(indent)}    <view class="tile-tags"><text wx:for="{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "tags"))} }}" wx:for-item="tag" wx:key="*this" class="tile-tag">{{ tag }}</text></view>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}  </#if>
${""?left_pad(indent)}</view>
</#macro>

<#--
226. change_request (变更申请)
+-----------------------------------------------+
| +-------+  [primary]                 [status] |
| |avatar |  [secondary]                        |
| +-------+                          [end_time] |
+-----------------------------------------------+
-->
<#macro print_tile_change_request widget varname="row" indent=0>
${""?left_pad(indent)}<view class="tile tile-change-request layout-timeline">
${""?left_pad(indent)}  <view class="tile-row">
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "avatar")><view class="tile-avatar"><image src="{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "avatar"))} }}"></image></view></#if>
${""?left_pad(indent)}    <view class="tile-body">
${""?left_pad(indent)}      <view class="tile-row">
${""?left_pad(indent)}        <#if guidbase.has_child_widget(widget, "primary")><view class="tile-primary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))} }}</view></#if>
${""?left_pad(indent)}        <#if guidbase.has_child_widget(widget, "status")><view class="tile-status">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))} }}</view></#if>
${""?left_pad(indent)}      </view>
${""?left_pad(indent)}      <#if guidbase.has_child_widget(widget, "secondary")><view class="tile-secondary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "secondary"))} }}</view></#if>
${""?left_pad(indent)}      <#if guidbase.has_child_widget(widget, "end_time")><view class="tile-end-time">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "end_time"))} }}</view></#if>
${""?left_pad(indent)}    </view>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}</view>
</#macro>

<#--
227. risk_register (风险登记册)
+-----------------------------------------------+
| [status]                                      |
|                                               |
| [primary]                                     |
| [secondary]                                   |
| [tertiary]                                    |
|                                               |
| [tags]                                        |
+-----------------------------------------------+
-->
<#macro print_tile_risk_register widget varname="row" indent=0>
${""?left_pad(indent)}<view class="tile tile-risk-register layout-content">
${""?left_pad(indent)}  <view class="tile-row tile-header">
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "status")><text class="tile-status">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))} }}</text></#if>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}  <view class="tile-body">
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "primary")><view class="tile-primary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))} }}</view></#if>
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "secondary")><view class="tile-secondary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "secondary"))} }}</view></#if>
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "tertiary")><view class="tile-tertiary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "tertiary"))} }}</view></#if>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}  <#if guidbase.has_child_widget(widget, "tags")>
${""?left_pad(indent)}  <view class="tile-footer">
${""?left_pad(indent)}    <view class="tile-tags"><text wx:for="{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "tags"))} }}" wx:for-item="tag" wx:key="*this" class="tile-tag">{{ tag }}</text></view>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}  </#if>
${""?left_pad(indent)}</view>
</#macro>

<#--
228. dependency_item (依赖项)
+-----------------------------------------------+
| [primary]                            [status] |
| [secondary]                                   |
|                                               |
| [avatars]                                     |
+-----------------------------------------------+
-->
<#macro print_tile_dependency_item widget varname="row" indent=0>
${""?left_pad(indent)}<view class="tile tile-dependency-item layout-profile">
${""?left_pad(indent)}  <view class="tile-row tile-header">
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "primary")><view class="tile-primary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))} }}</view></#if>
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "status")><view class="tile-status">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))} }}</view></#if>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}  <view class="tile-body">
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "secondary")><view class="tile-secondary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "secondary"))} }}</view></#if>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}  <#if guidbase.has_child_widget(widget, "avatars")>
${""?left_pad(indent)}  <view class="tile-footer">
${""?left_pad(indent)}    <view class="tile-avatars"><image wx:for="{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "avatars"))} }}" wx:for-item="av" wx:key="*this" src="{{ av }}" class="tile-avatar-img"></image></view>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}  </#if>
${""?left_pad(indent)}</view>
</#macro>

<#--
229. decision_log (决策日志)
+-----------------------------------------------+
| +-------+  [primary]             [start_time] |
| |avatar |  [secondary]                        |
| +-------+                                     |
| [tags]                                        |
+-----------------------------------------------+
-->
<#macro print_tile_decision_log widget varname="row" indent=0>
${""?left_pad(indent)}<view class="tile tile-decision-log layout-timeline">
${""?left_pad(indent)}  <view class="tile-row">
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "avatar")><view class="tile-avatar"><image src="{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "avatar"))} }}"></image></view></#if>
${""?left_pad(indent)}    <view class="tile-body">
${""?left_pad(indent)}      <view class="tile-row tile-header">
${""?left_pad(indent)}        <#if guidbase.has_child_widget(widget, "primary")><view class="tile-primary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))} }}</view></#if>
${""?left_pad(indent)}        <#if guidbase.has_child_widget(widget, "start_time")><text class="tile-start-time">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "start_time"))} }}</text></#if>
${""?left_pad(indent)}      </view>
${""?left_pad(indent)}      <#if guidbase.has_child_widget(widget, "secondary")><view class="tile-secondary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "secondary"))} }}</view></#if>
${""?left_pad(indent)}    </view>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}  <#if guidbase.has_child_widget(widget, "tags")>
${""?left_pad(indent)}  <view class="tile-footer">
${""?left_pad(indent)}    <view class="tile-tags"><text wx:for="{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "tags"))} }}" wx:for-item="tag" wx:key="*this" class="tile-tag">{{ tag }}</text></view>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}  </#if>
${""?left_pad(indent)}</view>
</#macro>

<#--
230. meeting_notes (会议纪要)
+-----------------------------------------------+
| +-------+  [primary]             [start_time] |
| |avatar |  [secondary]                        |
| +-------+  [tertiary]                         |
+-----------------------------------------------+
-->
<#macro print_tile_meeting_notes widget varname="row" indent=0>
${""?left_pad(indent)}<view class="tile tile-meeting-notes layout-timeline">
${""?left_pad(indent)}  <view class="tile-row">
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "avatar")><view class="tile-avatar"><image src="{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "avatar"))} }}"></image></view></#if>
${""?left_pad(indent)}    <view class="tile-body">
${""?left_pad(indent)}      <view class="tile-row tile-header">
${""?left_pad(indent)}        <#if guidbase.has_child_widget(widget, "primary")><view class="tile-primary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))} }}</view></#if>
${""?left_pad(indent)}        <#if guidbase.has_child_widget(widget, "start_time")><text class="tile-start-time">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "start_time"))} }}</text></#if>
${""?left_pad(indent)}      </view>
${""?left_pad(indent)}      <#if guidbase.has_child_widget(widget, "secondary")><view class="tile-secondary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "secondary"))} }}</view></#if>
${""?left_pad(indent)}      <#if guidbase.has_child_widget(widget, "tertiary")><view class="tile-tertiary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "tertiary"))} }}</view></#if>
${""?left_pad(indent)}    </view>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}</view>
</#macro>

<#--
231. action_item (行动项)
+-----------------------------------------------+
| [status]                                      |
|                                               |
| [primary]                                     |
| [secondary]                                   |
|                                               |
| [avatars]                          [end_time] |
+-----------------------------------------------+
-->
<#macro print_tile_action_item widget varname="row" indent=0>
${""?left_pad(indent)}<view class="tile tile-action-item layout-timeline">
${""?left_pad(indent)}  <view class="tile-row tile-header">
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "status")><text class="tile-status">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))} }}</text></#if>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}  <view class="tile-body">
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "primary")><view class="tile-primary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))} }}</view></#if>
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "secondary")><view class="tile-secondary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "secondary"))} }}</view></#if>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}  <view class="tile-footer">
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "avatars")>
${""?left_pad(indent)}    <view class="tile-avatars"><image wx:for="{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "avatars"))} }}" wx:for-item="av" wx:key="*this" src="{{ av }}" class="tile-avatar-img"></image></view>
${""?left_pad(indent)}    </#if>
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "end_time")><text class="tile-end-time">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "end_time"))} }}</text></#if>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}</view>
</#macro>

<#--
232. okr_objective (OKR 目标)
+===============================================+
|                 [background]                  |
|                                               |
|  [primary]                           [status] |
|  [secondary]                                  |
|                                               |
|  [tags]                                       |
+===============================================+
-->
<#macro print_tile_okr_objective widget varname="row" indent=0>
${""?left_pad(indent)}<view class="tile tile-okr-objective layout-background">
${""?left_pad(indent)}  <#if guidbase.has_child_widget(widget, "background")>
${""?left_pad(indent)}  <view class="tile-background"><image src="{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "background"))} }}"></image></view>
${""?left_pad(indent)}  </#if>
${""?left_pad(indent)}  <view class="tile-overlay">
${""?left_pad(indent)}    <view class="tile-row tile-header">
${""?left_pad(indent)}      <#if guidbase.has_child_widget(widget, "status")><text class="tile-status">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))} }}</text></#if>
${""?left_pad(indent)}    </view>
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "primary")><view class="tile-primary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))} }}</view></#if>
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "secondary")><view class="tile-secondary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "secondary"))} }}</view></#if>
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "tags")>
${""?left_pad(indent)}    <view class="tile-footer">
${""?left_pad(indent)}      <view class="tile-tags"><text wx:for="{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "tags"))} }}" wx:for-item="tag" wx:key="*this" class="tile-tag">{{ tag }}</text></view>
${""?left_pad(indent)}    </view>
${""?left_pad(indent)}    </#if>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}</view>
</#macro>

<#--
233. key_result (关键结果)
+-----------------------------------------------+
| [start_time] - [end_time]                     |
|                                               |
| [primary]                            [status] |
| [secondary]                                   |
+-----------------------------------------------+
-->
<#macro print_tile_key_result widget varname="row" indent=0>
${""?left_pad(indent)}<view class="tile tile-key-result layout-timeline">
${""?left_pad(indent)}  <view class="tile-row tile-header">
${""?left_pad(indent)}    <text class="tile-time">
${""?left_pad(indent)}      <#if guidbase.has_child_widget(widget, "start_time")><text>{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "start_time"))} }}</text></#if>
${""?left_pad(indent)}      <#if guidbase.has_child_widget(widget, "start_time") && guidbase.has_child_widget(widget, "end_time")><text> - </text></#if>
${""?left_pad(indent)}      <#if guidbase.has_child_widget(widget, "end_time")><text>{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "end_time"))} }}</text></#if>
${""?left_pad(indent)}    </text>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}  <view class="tile-body">
${""?left_pad(indent)}    <view class="tile-row">
${""?left_pad(indent)}      <#if guidbase.has_child_widget(widget, "primary")><view class="tile-primary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))} }}</view></#if>
${""?left_pad(indent)}      <#if guidbase.has_child_widget(widget, "status")><view class="tile-status">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))} }}</view></#if>
${""?left_pad(indent)}    </view>
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "secondary")><view class="tile-secondary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "secondary"))} }}</view></#if>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}</view>
</#macro>

<#--
234. goal_progress (目标进度)
+-----------------------------------------------+
| [primary]                            [status] |
| [secondary]                                   |
|                                               |
| [avatars]                                     |
+-----------------------------------------------+
-->
<#macro print_tile_goal_progress widget varname="row" indent=0>
${""?left_pad(indent)}<view class="tile tile-goal-progress layout-profile">
${""?left_pad(indent)}  <view class="tile-row tile-header">
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "primary")><view class="tile-primary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))} }}</view></#if>
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "status")><view class="tile-status">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))} }}</view></#if>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}  <view class="tile-body">
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "secondary")><view class="tile-secondary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "secondary"))} }}</view></#if>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}  <#if guidbase.has_child_widget(widget, "avatars")>
${""?left_pad(indent)}  <view class="tile-footer">
${""?left_pad(indent)}    <view class="tile-avatars"><image wx:for="{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "avatars"))} }}" wx:for-item="av" wx:key="*this" src="{{ av }}" class="tile-avatar-img"></image></view>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}  </#if>
${""?left_pad(indent)}</view>
</#macro>

<#--
235. personal_dashboard (个人仪表盘)
+===============================================+
|                 [background]                  |
|                                               |
|  [primary]                           [status] |
|  [secondary]                                  |
|  [tertiary]                                   |
+===============================================+
-->
<#macro print_tile_personal_dashboard widget varname="row" indent=0>
${""?left_pad(indent)}<view class="tile tile-personal-dashboard layout-background">
${""?left_pad(indent)}  <#if guidbase.has_child_widget(widget, "background")>
${""?left_pad(indent)}  <view class="tile-background"><image src="{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "background"))} }}"></image></view>
${""?left_pad(indent)}  </#if>
${""?left_pad(indent)}  <view class="tile-overlay">
${""?left_pad(indent)}    <view class="tile-row tile-header">
${""?left_pad(indent)}      <#if guidbase.has_child_widget(widget, "status")><text class="tile-status">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))} }}</text></#if>
${""?left_pad(indent)}    </view>
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "primary")><view class="tile-primary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))} }}</view></#if>
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "secondary")><view class="tile-secondary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "secondary"))} }}</view></#if>
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "tertiary")><view class="tile-tertiary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "tertiary"))} }}</view></#if>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}</view>
</#macro>

<#--
236. quick_action (快速操作)
+-----------------------------------------------+
| [*icon]                                       |
|                                               |
| [primary]                            [status] |
| [secondary]                                   |
+-----------------------------------------------+
-->
<#macro print_tile_quick_action widget varname="row" indent=0>
${""?left_pad(indent)}<view class="tile tile-quick-action layout-content">
${""?left_pad(indent)}  <view class="tile-row tile-header">
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "icon")>
${""?left_pad(indent)}    <view class="tile-icon">
${""?left_pad(indent)}      <image src="{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "icon"))} }}"></image>
${""?left_pad(indent)}    </view>
${""?left_pad(indent)}    </#if>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}  <view class="tile-body">
${""?left_pad(indent)}    <view class="tile-row">
${""?left_pad(indent)}      <#if guidbase.has_child_widget(widget, "primary")><view class="tile-primary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))} }}</view></#if>
${""?left_pad(indent)}      <#if guidbase.has_child_widget(widget, "status")><view class="tile-status">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))} }}</view></#if>
${""?left_pad(indent)}    </view>
${""?left_pad(indent)}    <#if guidbase.has_child_widget(widget, "secondary")><view class="tile-secondary">{{ ${varname}.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "secondary"))} }}</view></#if>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}</view>
</#macro>
