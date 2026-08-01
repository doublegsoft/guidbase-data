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
${""?left_pad(indent)}VStack(alignment: .leading, spacing: 0) {
${""?left_pad(indent)}  HStack {
  <#if guidbase.has_child_widget(widget, "start_time") || guidbase.has_child_widget(widget, "end_time")>
${""?left_pad(indent)}    HStack(spacing: 4) {
    <#if guidbase.has_child_widget(widget, "start_time")>${""?left_pad(indent)}      Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "start_time"))}).font(.system(size: 12)).foregroundColor(Color("text_muted"))</#if>
    <#if guidbase.has_child_widget(widget, "start_time") && guidbase.has_child_widget(widget, "end_time")>${""?left_pad(indent)}      Text(" - ").font(.system(size: 12)).foregroundColor(Color("text_muted"))</#if>
    <#if guidbase.has_child_widget(widget, "end_time")>${""?left_pad(indent)}      Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "end_time"))}).font(.system(size: 12)).foregroundColor(Color("text_muted"))</#if>
${""?left_pad(indent)}    }
  </#if>
${""?left_pad(indent)}    Spacer()
  <#if guidbase.has_child_widget(widget, "status")>
${""?left_pad(indent)}    Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))}).font(.system(size: 12)).foregroundColor(Color("primary"))
  </#if>
${""?left_pad(indent)}  }
${""?left_pad(indent)}  .frame(maxWidth: .infinity)
${""?left_pad(indent)}  .padding(.bottom, 8)
  <#if guidbase.has_child_widget(widget, "primary") || guidbase.has_child_widget(widget, "secondary")>
${""?left_pad(indent)}  VStack(alignment: .leading, spacing: 4) {
    <#if guidbase.has_child_widget(widget, "primary")>
${""?left_pad(indent)}    Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))}).font(.system(size: 16)).fontWeight(.bold).foregroundColor(Color("text"))
    </#if>
    <#if guidbase.has_child_widget(widget, "secondary")>
${""?left_pad(indent)}    Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "secondary"))}).font(.system(size: 14)).foregroundColor(Color("text_muted"))
    </#if>
${""?left_pad(indent)}  }
${""?left_pad(indent)}  .frame(maxWidth: .infinity, alignment: .leading)
${""?left_pad(indent)}  .padding(.bottom, 8)
  </#if>
  <#if guidbase.has_child_widget(widget, "avatars")>
${""?left_pad(indent)}  HStack(spacing: 4) {
${""?left_pad(indent)}    ForEach(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "avatars"))}, id: \.self) { av in
${""?left_pad(indent)}      Image(av)
${""?left_pad(indent)}        .resizable()
${""?left_pad(indent)}        .aspectRatio(contentMode: .fill)
${""?left_pad(indent)}        .frame(width: 24, height: 24)
${""?left_pad(indent)}        .cornerRadius(12)
${""?left_pad(indent)}        .padding(.trailing, 4)
${""?left_pad(indent)}    }
${""?left_pad(indent)}  }
${""?left_pad(indent)}  .frame(maxWidth: .infinity, alignment: .leading)
  </#if>
${""?left_pad(indent)}}
${""?left_pad(indent)}.padding(12)
${""?left_pad(indent)}.background(Color("bg"))
${""?left_pad(indent)}.cornerRadius(8)
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
${""?left_pad(indent)}VStack(alignment: .leading, spacing: 0) {
  <#if guidbase.has_child_widget(widget, "image")>
${""?left_pad(indent)}  ZStack(alignment: .bottomLeading) {
${""?left_pad(indent)}    Image(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "image"))})
${""?left_pad(indent)}      .resizable()
${""?left_pad(indent)}      .aspectRatio(contentMode: .fill)
${""?left_pad(indent)}      .frame(height: 150)
${""?left_pad(indent)}      .frame(maxWidth: .infinity)
${""?left_pad(indent)}      .cornerRadius(4)
    <#if guidbase.has_child_widget(widget, "tags")>
${""?left_pad(indent)}    HStack(spacing: 4) {
${""?left_pad(indent)}      ForEach(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "tags"))}, id: \.self) { tag in
${""?left_pad(indent)}        Text(tag)
${""?left_pad(indent)}          .font(.system(size: 10))
${""?left_pad(indent)}          .foregroundColor(Color("bg"))
${""?left_pad(indent)}          .padding(.horizontal, 6)
${""?left_pad(indent)}          .padding(.vertical, 2)
${""?left_pad(indent)}          .background(Color("primary"))
${""?left_pad(indent)}          .cornerRadius(4)
${""?left_pad(indent)}          .padding(.trailing, 4)
${""?left_pad(indent)}      }
${""?left_pad(indent)}    }
${""?left_pad(indent)}    .padding(8)
    </#if>
${""?left_pad(indent)}  }
${""?left_pad(indent)}  .frame(maxWidth: .infinity)
${""?left_pad(indent)}  .padding(.bottom, 8)
  </#if>
  <#if guidbase.has_child_widget(widget, "primary") || guidbase.has_child_widget(widget, "secondary") || guidbase.has_child_widget(widget, "tertiary")>
${""?left_pad(indent)}  VStack(alignment: .leading, spacing: 4) {
    <#if guidbase.has_child_widget(widget, "primary")>
${""?left_pad(indent)}    Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))}).font(.system(size: 16)).fontWeight(.bold).foregroundColor(Color("text"))
    </#if>
    <#if guidbase.has_child_widget(widget, "secondary")>
${""?left_pad(indent)}    Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "secondary"))}).font(.system(size: 14)).foregroundColor(Color("text_muted"))
    </#if>
    <#if guidbase.has_child_widget(widget, "tertiary")>
${""?left_pad(indent)}    Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "tertiary"))}).font(.system(size: 12)).foregroundColor(Color("text_light"))
    </#if>
${""?left_pad(indent)}  }
${""?left_pad(indent)}  .frame(maxWidth: .infinity, alignment: .leading)
  </#if>
${""?left_pad(indent)}}
${""?left_pad(indent)}.padding(12)
${""?left_pad(indent)}.background(Color("bg"))
${""?left_pad(indent)}.cornerRadius(8)
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
${""?left_pad(indent)}HStack(alignment: .center, spacing: 12) {
  <#if guidbase.has_child_widget(widget, "avatar")>
${""?left_pad(indent)}  Image(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "avatar"))})
${""?left_pad(indent)}    .resizable()
${""?left_pad(indent)}    .aspectRatio(contentMode: .fill)
${""?left_pad(indent)}    .frame(width: 48, height: 48)
${""?left_pad(indent)}    .cornerRadius(24)
  </#if>
${""?left_pad(indent)}  VStack(alignment: .leading, spacing: 4) {
    <#if guidbase.has_child_widget(widget, "primary")>
${""?left_pad(indent)}    Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))}).font(.system(size: 16)).fontWeight(.bold).foregroundColor(Color("text"))
    </#if>
    <#if guidbase.has_child_widget(widget, "secondary")>
${""?left_pad(indent)}    Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "secondary"))}).font(.system(size: 14)).foregroundColor(Color("text_muted"))
    </#if>
${""?left_pad(indent)}  }
${""?left_pad(indent)}  Spacer()
  <#if guidbase.has_child_widget(widget, "status")>
${""?left_pad(indent)}  Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))}).font(.system(size: 12)).foregroundColor(Color("primary"))
  </#if>
${""?left_pad(indent)}}
${""?left_pad(indent)}.frame(maxWidth: .infinity)
${""?left_pad(indent)}.padding(12)
${""?left_pad(indent)}.background(Color("bg"))
${""?left_pad(indent)}.cornerRadius(8)
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
${""?left_pad(indent)}VStack(alignment: .leading, spacing: 0) {
${""?left_pad(indent)}  HStack {
    <#if guidbase.has_child_widget(widget, "tags")>
${""?left_pad(indent)}    HStack(spacing: 4) {
${""?left_pad(indent)}      ForEach(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "tags"))}, id: \.self) { tag in
${""?left_pad(indent)}        Text(tag)
${""?left_pad(indent)}          .font(.system(size: 10))
${""?left_pad(indent)}          .foregroundColor(Color("primary"))
${""?left_pad(indent)}          .padding(.horizontal, 6)
${""?left_pad(indent)}          .padding(.vertical, 2)
${""?left_pad(indent)}          .background(Color("primary_bg"))
${""?left_pad(indent)}          .cornerRadius(4)
${""?left_pad(indent)}          .padding(.trailing, 4)
${""?left_pad(indent)}      }
${""?left_pad(indent)}    }
    </#if>
    <#if guidbase.has_child_widget(widget, "status")>
${""?left_pad(indent)}    Spacer()
${""?left_pad(indent)}    Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))}).font(.system(size: 12)).foregroundColor(Color("primary"))
    </#if>
${""?left_pad(indent)}  }
${""?left_pad(indent)}  .frame(maxWidth: .infinity)
${""?left_pad(indent)}  .padding(.bottom, 8)
  <#if guidbase.has_child_widget(widget, "primary")>
${""?left_pad(indent)}  Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))}).font(.system(size: 16)).fontWeight(.bold).foregroundColor(Color("text")).padding(.bottom, 8).frame(maxWidth: .infinity, alignment: .leading)
  </#if>
${""?left_pad(indent)}  HStack {
    <#if guidbase.has_child_widget(widget, "avatars")>
${""?left_pad(indent)}    HStack(spacing: 4) {
${""?left_pad(indent)}      ForEach(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "avatars"))}, id: \.self) { av in
${""?left_pad(indent)}        Image(av)
${""?left_pad(indent)}          .resizable()
${""?left_pad(indent)}          .aspectRatio(contentMode: .fill)
${""?left_pad(indent)}          .frame(width: 24, height: 24)
${""?left_pad(indent)}          .cornerRadius(12)
${""?left_pad(indent)}          .padding(.trailing, 4)
${""?left_pad(indent)}      }
${""?left_pad(indent)}    }
    </#if>
    <#if guidbase.has_child_widget(widget, "end_time")>
${""?left_pad(indent)}    Spacer()
${""?left_pad(indent)}    Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "end_time"))}).font(.system(size: 12)).foregroundColor(Color("text_muted"))
    </#if>
${""?left_pad(indent)}  }
${""?left_pad(indent)}  .frame(maxWidth: .infinity)
${""?left_pad(indent)}}
${""?left_pad(indent)}.padding(12)
${""?left_pad(indent)}.background(Color("bg"))
${""?left_pad(indent)}.cornerRadius(8)
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
${""?left_pad(indent)}ZStack(alignment: .bottomLeading) {
  <#if guidbase.has_child_widget(widget, "background")>
${""?left_pad(indent)}  Image(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "background"))})
${""?left_pad(indent)}    .resizable()
${""?left_pad(indent)}    .aspectRatio(contentMode: .fill)
${""?left_pad(indent)}    .frame(height: 180)
${""?left_pad(indent)}    .frame(maxWidth: .infinity)
  </#if>
${""?left_pad(indent)}  VStack(alignment: .leading, spacing: 4) {
    <#if guidbase.has_child_widget(widget, "tags")>
${""?left_pad(indent)}    HStack(spacing: 4) {
${""?left_pad(indent)}      ForEach(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "tags"))}, id: \.self) { tag in
${""?left_pad(indent)}        Text(tag)
${""?left_pad(indent)}          .font(.system(size: 10))
${""?left_pad(indent)}          .foregroundColor(Color("bg"))
${""?left_pad(indent)}          .padding(.horizontal, 6)
${""?left_pad(indent)}          .padding(.vertical, 2)
${""?left_pad(indent)}          .background(Color("primary"))
${""?left_pad(indent)}          .cornerRadius(4)
${""?left_pad(indent)}          .padding(.trailing, 4)
${""?left_pad(indent)}      }
${""?left_pad(indent)}    }
${""?left_pad(indent)}    .padding(.bottom, 8)
    </#if>
    <#if guidbase.has_child_widget(widget, "primary")>
${""?left_pad(indent)}    Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))}).font(.system(size: 18)).fontWeight(.bold).foregroundColor(Color("bg"))
    </#if>
    <#if guidbase.has_child_widget(widget, "secondary")>
${""?left_pad(indent)}    Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "secondary"))}).font(.system(size: 14)).foregroundColor(Color("border_light"))
    </#if>
    <#if guidbase.has_child_widget(widget, "tertiary")>
${""?left_pad(indent)}    Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "tertiary"))}).font(.system(size: 12)).foregroundColor(Color("border_light"))
    </#if>
${""?left_pad(indent)}  }
${""?left_pad(indent)}  .padding(12)
${""?left_pad(indent)}  .frame(maxWidth: .infinity, alignment: .leading)
${""?left_pad(indent)}}
${""?left_pad(indent)}.cornerRadius(8)
</#macro>

<#--
紧凑列表 (Compact List)
+-----------------------------------------------+
| [status]  [primary]  [secondary]  [start time]|
+-----------------------------------------------+
-->
<#macro print_tile_compact_list widget indent=0>
${""?left_pad(indent)}HStack(alignment: .center, spacing: 8) {
  <#if guidbase.has_child_widget(widget, "status")>
${""?left_pad(indent)}  Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))}).font(.system(size: 14)).foregroundColor(Color("primary"))
  </#if>
  <#if guidbase.has_child_widget(widget, "primary")>
${""?left_pad(indent)}  Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))}).font(.system(size: 14)).fontWeight(.medium).foregroundColor(Color("text"))
  </#if>
${""?left_pad(indent)}  Spacer()
  <#if guidbase.has_child_widget(widget, "secondary")>
${""?left_pad(indent)}  Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "secondary"))}).font(.system(size: 12)).foregroundColor(Color("text_muted"))
  </#if>
  <#if guidbase.has_child_widget(widget, "start_time")>
${""?left_pad(indent)}  Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "start_time"))}).font(.system(size: 12)).foregroundColor(Color("text_light"))
  </#if>
${""?left_pad(indent)}}
${""?left_pad(indent)}.frame(maxWidth: .infinity)
${""?left_pad(indent)}.padding(.vertical, 10)
${""?left_pad(indent)}.padding(.horizontal, 12)
${""?left_pad(indent)}.background(Color("bg"))
${""?left_pad(indent)}.overlay(Rectangle().frame(height: 1).foregroundColor(Color("border_light")), alignment: .bottom)
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
${""?left_pad(indent)}HStack(alignment: .top, spacing: 12) {
  <#if guidbase.has_child_widget(widget, "image")>
${""?left_pad(indent)}  Image(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "image"))})
${""?left_pad(indent)}    .resizable()
${""?left_pad(indent)}    .aspectRatio(contentMode: .fill)
${""?left_pad(indent)}    .frame(width: 80, height: 80)
${""?left_pad(indent)}    .cornerRadius(4)
  </#if>
${""?left_pad(indent)}  VStack(alignment: .leading, spacing: 4) {
    <#if guidbase.has_child_widget(widget, "tags")>
${""?left_pad(indent)}    HStack(spacing: 4) {
${""?left_pad(indent)}      ForEach(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "tags"))}, id: \.self) { tag in
${""?left_pad(indent)}        Text(tag)
${""?left_pad(indent)}          .font(.system(size: 10))
${""?left_pad(indent)}          .foregroundColor(Color("primary"))
${""?left_pad(indent)}          .padding(.horizontal, 6)
${""?left_pad(indent)}          .padding(.vertical, 2)
${""?left_pad(indent)}          .background(Color("primary_bg"))
${""?left_pad(indent)}          .cornerRadius(4)
${""?left_pad(indent)}          .padding(.trailing, 4)
${""?left_pad(indent)}      }
${""?left_pad(indent)}    }
${""?left_pad(indent)}    .padding(.bottom, 4)
    </#if>
    <#if guidbase.has_child_widget(widget, "primary")>
${""?left_pad(indent)}    Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))}).font(.system(size: 16)).fontWeight(.bold).foregroundColor(Color("text"))
    </#if>
    <#if guidbase.has_child_widget(widget, "avatars")>
${""?left_pad(indent)}    HStack(spacing: 4) {
${""?left_pad(indent)}      ForEach(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "avatars"))}, id: \.self) { av in
${""?left_pad(indent)}        Image(av)
${""?left_pad(indent)}          .resizable()
${""?left_pad(indent)}          .aspectRatio(contentMode: .fill)
${""?left_pad(indent)}          .frame(width: 20, height: 20)
${""?left_pad(indent)}          .cornerRadius(10)
${""?left_pad(indent)}          .padding(.trailing, 4)
${""?left_pad(indent)}      }
${""?left_pad(indent)}    }
${""?left_pad(indent)}    .padding(.bottom, 4)
    </#if>
    <#if guidbase.has_child_widget(widget, "start_time")>
${""?left_pad(indent)}    Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "start_time"))}).font(.system(size: 12)).foregroundColor(Color("text_muted"))
    </#if>
${""?left_pad(indent)}  }
${""?left_pad(indent)}  .frame(maxWidth: .infinity, alignment: .leading)
${""?left_pad(indent)}}
${""?left_pad(indent)}.padding(12)
${""?left_pad(indent)}.background(Color("bg"))
${""?left_pad(indent)}.cornerRadius(8)
</#macro>

<#--
简易状态 (Notification)
+-----------------------------------------------+
|  [status]   [primary]                         |
|             [tertiary]                        |
+-----------------------------------------------+
-->
<#macro print_tile_notification widget indent=0>
${""?left_pad(indent)}HStack(alignment: .top, spacing: 12) {
  <#if guidbase.has_child_widget(widget, "status")>
${""?left_pad(indent)}  Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))}).font(.system(size: 14)).foregroundColor(Color("primary"))
  </#if>
${""?left_pad(indent)}  VStack(alignment: .leading, spacing: 4) {
    <#if guidbase.has_child_widget(widget, "primary")>
${""?left_pad(indent)}    Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))}).font(.system(size: 16)).fontWeight(.medium).foregroundColor(Color("text"))
    </#if>
    <#if guidbase.has_child_widget(widget, "tertiary")>
${""?left_pad(indent)}    Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "tertiary"))}).font(.system(size: 12)).foregroundColor(Color("text_light"))
    </#if>
${""?left_pad(indent)}  }
${""?left_pad(indent)}  Spacer()
${""?left_pad(indent)}}
${""?left_pad(indent)}.frame(maxWidth: .infinity)
${""?left_pad(indent)}.padding(12)
${""?left_pad(indent)}.background(Color("bg"))
${""?left_pad(indent)}.cornerRadius(8)
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
${""?left_pad(indent)}ZStack(alignment: .topLeading) {
  <#if guidbase.has_child_widget(widget, "background")>
${""?left_pad(indent)}  Image(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "background"))})
${""?left_pad(indent)}    .resizable()
${""?left_pad(indent)}    .aspectRatio(contentMode: .fill)
${""?left_pad(indent)}    .frame(height: 200)
${""?left_pad(indent)}    .frame(maxWidth: .infinity)
  </#if>
${""?left_pad(indent)}  VStack(alignment: .center, spacing: 8) {
    <#if guidbase.has_child_widget(widget, "avatar")>
${""?left_pad(indent)}    Image(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "avatar"))})
${""?left_pad(indent)}      .resizable()
${""?left_pad(indent)}      .aspectRatio(contentMode: .fill)
${""?left_pad(indent)}      .frame(width: 64, height: 64)
${""?left_pad(indent)}      .cornerRadius(32)
${""?left_pad(indent)}      .overlay(RoundedRectangle(cornerRadius: 32).stroke(Color("bg"), lineWidth: 2))
${""?left_pad(indent)}      .padding(.bottom, 8)
    </#if>
    <#if guidbase.has_child_widget(widget, "primary")>
${""?left_pad(indent)}    Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))}).font(.system(size: 18)).fontWeight(.bold).foregroundColor(Color("bg"))
    </#if>
    <#if guidbase.has_child_widget(widget, "secondary")>
${""?left_pad(indent)}    Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "secondary"))}).font(.system(size: 14)).foregroundColor(Color("border_light"))
    </#if>
${""?left_pad(indent)}  }
${""?left_pad(indent)}  .frame(maxWidth: .infinity)
${""?left_pad(indent)}  .padding(.top, 40)
${""?left_pad(indent)}}
${""?left_pad(indent)}.cornerRadius(8)
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
${""?left_pad(indent) }HStack(alignment: .top, spacing: 12) {
${""?left_pad(indent) }  VStack(alignment: .center, spacing: 4) {
    <#if guidbase.has_child_widget(widget, "start_time")>
${""?left_pad(indent) }    Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "start_time"))}).font(.system(size: 12)).foregroundColor(Color("text_muted"))
    </#if>
${""?left_pad(indent) }    Circle().fill(Color("primary")).frame(width: 8, height: 8).padding(.vertical, 4)
    <#if guidbase.has_child_widget(widget, "end_time")>
${""?left_pad(indent) }    Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "end_time"))}).font(.system(size: 12)).foregroundColor(Color("text_muted"))
    </#if>
${""?left_pad(indent) }  }
${""?left_pad(indent) }  .frame(width: 60)
${""?left_pad(indent) }  VStack(alignment: .leading, spacing: 4) {
    <#if guidbase.has_child_widget(widget, "primary")>
${""?left_pad(indent) }    Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))}).font(.system(size: 16)).fontWeight(.bold).foregroundColor(Color("text"))
    </#if>
    <#if guidbase.has_child_widget(widget, "secondary")>
${""?left_pad(indent) }    Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "secondary"))}).font(.system(size: 14)).foregroundColor(Color("text_muted"))
    </#if>
    <#if guidbase.has_child_widget(widget, "tertiary")>
${""?left_pad(indent) }    Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "tertiary"))}).font(.system(size: 12)).foregroundColor(Color("text_light"))
    </#if>
${""?left_pad(indent) }  }
${""?left_pad(indent) }  Spacer()
  <#if guidbase.has_child_widget(widget, "tags")>
${""?left_pad(indent) }  HStack(spacing: 4) {
${""?left_pad(indent) }    ForEach(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "tags"))}, id: \.self) { tag in
${""?left_pad(indent) }      Text(tag)
${""?left_pad(indent) }        .font(.system(size: 10))
${""?left_pad(indent) }        .foregroundColor(Color("primary"))
${""?left_pad(indent) }        .padding(.horizontal, 6)
${""?left_pad(indent) }        .padding(.vertical, 2)
${""?left_pad(indent) }        .background(Color("primary_bg"))
${""?left_pad(indent) }        .cornerRadius(4)
${""?left_pad(indent) }        .padding(.leading, 4)
${""?left_pad(indent) }    }
${""?left_pad(indent) }  }
  </#if>
${""?left_pad(indent) }}
${""?left_pad(indent)}.frame(maxWidth: .infinity)
${""?left_pad(indent)}.padding(12)
${""?left_pad(indent)}.background(Color("bg"))
${""?left_pad(indent)}.cornerRadius(8)
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
${""?left_pad(indent)}VStack(alignment: .leading, spacing: 8) {
${""?left_pad(indent)}  HStack(alignment: .top, spacing: 12) {
    <#if guidbase.has_child_widget(widget, "avatar")>
${""?left_pad(indent)}    Image(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "avatar"))})
${""?left_pad(indent)}      .resizable()
${""?left_pad(indent)}      .aspectRatio(contentMode: .fill)
${""?left_pad(indent)}      .frame(width: 40, height: 40)
${""?left_pad(indent)}      .cornerRadius(20)
    </#if>
${""?left_pad(indent)}    VStack(alignment: .leading, spacing: 4) {
${""?left_pad(indent)}      HStack {
        <#if guidbase.has_child_widget(widget, "primary")>
${""?left_pad(indent)}        Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))}).font(.system(size: 14)).fontWeight(.bold).foregroundColor(Color("text"))
        </#if>
        <#if guidbase.has_child_widget(widget, "start_time")>
${""?left_pad(indent)}        Spacer()
${""?left_pad(indent)}        Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "start_time"))}).font(.system(size: 12)).foregroundColor(Color("text_muted"))
        </#if>
${""?left_pad(indent)}      }
${""?left_pad(indent)}      .frame(maxWidth: .infinity)
      <#if guidbase.has_child_widget(widget, "secondary")>
${""?left_pad(indent)}      Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "secondary"))}).font(.system(size: 12)).foregroundColor(Color("text_muted"))
      </#if>
${""?left_pad(indent)}    }
${""?left_pad(indent)}  }
${""?left_pad(indent)}  .frame(maxWidth: .infinity)
  <#if guidbase.has_child_widget(widget, "tertiary")>
${""?left_pad(indent)}  Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "tertiary"))})
${""?left_pad(indent)}    .font(.system(size: 14))
${""?left_pad(indent)}    .foregroundColor(Color("text"))
${""?left_pad(indent)}    .padding(.leading, 52)
${""?left_pad(indent)}    .frame(maxWidth: .infinity, alignment: .leading)
  </#if>
${""?left_pad(indent)}}
${""?left_pad(indent)}.padding(12)
${""?left_pad(indent)}.background(Color("bg"))
${""?left_pad(indent)}.cornerRadius(8)
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
${""?left_pad(indent)}ZStack(alignment: .bottomLeading) {
  <#if guidbase.has_child_widget(widget, "background")>
${""?left_pad(indent)}  Image(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "background"))})
${""?left_pad(indent)}    .resizable()
${""?left_pad(indent)}    .aspectRatio(contentMode: .fill)
${""?left_pad(indent)}    .frame(height: 120)
${""?left_pad(indent)}    .frame(maxWidth: .infinity)
  </#if>
${""?left_pad(indent)}  VStack(alignment: .leading, spacing: 8) {
${""?left_pad(indent)}    HStack {
      <#if guidbase.has_child_widget(widget, "primary")>
${""?left_pad(indent)}      Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))}).font(.system(size: 16)).fontWeight(.bold).foregroundColor(Color("bg"))
      </#if>
      <#if guidbase.has_child_widget(widget, "status")>
${""?left_pad(indent)}      Spacer()
${""?left_pad(indent)}      Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))})
${""?left_pad(indent)}        .font(.system(size: 12))
${""?left_pad(indent)}        .foregroundColor(Color("primary"))
${""?left_pad(indent)}        .padding(.horizontal, 6)
${""?left_pad(indent)}        .padding(.vertical, 2)
${""?left_pad(indent)}        .background(Color("bg"))
${""?left_pad(indent)}        .cornerRadius(4)
      </#if>
${""?left_pad(indent)}    }
${""?left_pad(indent)}    .frame(maxWidth: .infinity)
    <#if guidbase.has_child_widget(widget, "start_time") || guidbase.has_child_widget(widget, "end_time")>
${""?left_pad(indent)}    HStack(spacing: 4) {
      <#if guidbase.has_child_widget(widget, "start_time")>${""?left_pad(indent)}      Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "start_time"))}).font(.system(size: 12)).foregroundColor(Color("border_light"))</#if>
      <#if guidbase.has_child_widget(widget, "start_time") && guidbase.has_child_widget(widget, "end_time")>${""?left_pad(indent)}      Text(" ~ ").font(.system(size: 12)).foregroundColor(Color("border_light"))</#if>
      <#if guidbase.has_child_widget(widget, "end_time")>${""?left_pad(indent)}      Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "end_time"))}).font(.system(size: 12)).foregroundColor(Color("border_light"))</#if>
${""?left_pad(indent)}    }
    </#if>
${""?left_pad(indent)}  }
${""?left_pad(indent)}  .padding(12)
${""?left_pad(indent)}  .frame(maxWidth: .infinity, alignment: .leading)
${""?left_pad(indent)}}
${""?left_pad(indent)}.cornerRadius(8)
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
${""?left_pad(indent)}HStack(alignment: .top, spacing: 12) {
  <#if guidbase.has_child_widget(widget, "image")>
${""?left_pad(indent)}  Image(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "image"))})
${""?left_pad(indent)}    .resizable()
${""?left_pad(indent)}    .aspectRatio(contentMode: .fill)
${""?left_pad(indent)}    .frame(width: 60, height: 60)
${""?left_pad(indent)}    .cornerRadius(4)
  </#if>
${""?left_pad(indent)}  VStack(alignment: .leading, spacing: 4) {
    <#if guidbase.has_child_widget(widget, "primary")>
${""?left_pad(indent)}    Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))}).font(.system(size: 16)).fontWeight(.bold).foregroundColor(Color("text")).frame(maxWidth: .infinity, alignment: .leading)
    </#if>
${""?left_pad(indent)}    HStack {
      <#if guidbase.has_child_widget(widget, "secondary")>
${""?left_pad(indent)}      Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "secondary"))}).font(.system(size: 12)).foregroundColor(Color("text_muted"))
      </#if>
      <#if guidbase.has_child_widget(widget, "tags")>
${""?left_pad(indent)}      Spacer()
${""?left_pad(indent)}      HStack(spacing: 4) {
${""?left_pad(indent)}        ForEach(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "tags"))}, id: \.self) { tag in
${""?left_pad(indent)}          Text(tag)
${""?left_pad(indent)}            .font(.system(size: 10))
${""?left_pad(indent)}            .foregroundColor(Color("primary"))
${""?left_pad(indent)}            .padding(.horizontal, 6)
${""?left_pad(indent)}            .padding(.vertical, 2)
${""?left_pad(indent)}            .background(Color("primary_bg"))
${""?left_pad(indent)}            .cornerRadius(4)
${""?left_pad(indent)}            .padding(.leading, 4)
${""?left_pad(indent)}        }
${""?left_pad(indent)}      }
      </#if>
${""?left_pad(indent)}    }
${""?left_pad(indent)}    .frame(maxWidth: .infinity)
${""?left_pad(indent)}    HStack {
      <#if guidbase.has_child_widget(widget, "tertiary")>
${""?left_pad(indent)}      Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "tertiary"))}).font(.system(size: 12)).foregroundColor(Color("text_light"))
      </#if>
      <#if guidbase.has_child_widget(widget, "status")>
${""?left_pad(indent)}      Spacer()
${""?left_pad(indent)}      Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))}).font(.system(size: 12)).foregroundColor(Color("primary"))
      </#if>
${""?left_pad(indent)}    }
${""?left_pad(indent)}    .frame(maxWidth: .infinity)
${""?left_pad(indent)}  }
${""?left_pad(indent)}  .layoutWeight(1)
${""?left_pad(indent)}}
${""?left_pad(indent)}.padding(12)
${""?left_pad(indent)}.background(Color("bg"))
${""?left_pad(indent)}.cornerRadius(8)
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
${""?left_pad(indent)}VStack(alignment: .leading, spacing: 0) {
  <#if guidbase.has_child_widget(widget, "image")>
${""?left_pad(indent)}  Image(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "image"))})
${""?left_pad(indent)}    .resizable()
${""?left_pad(indent)}    .aspectRatio(contentMode: .fill)
${""?left_pad(indent)}    .frame(height: 200)
${""?left_pad(indent)}    .frame(maxWidth: .infinity)
${""?left_pad(indent)}    .clipShape(RoundedCorner(radius: 8, corners: [.topLeft, .topRight]))
  </#if>
  <#if guidbase.has_child_widget(widget, "primary") || guidbase.has_child_widget(widget, "secondary") || guidbase.has_child_widget(widget, "start_time") || guidbase.has_child_widget(widget, "end_time") || guidbase.has_child_widget(widget, "avatars")>
${""?left_pad(indent)}  VStack(alignment: .leading, spacing: 4) {
    <#if guidbase.has_child_widget(widget, "primary")>
${""?left_pad(indent)}    Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))}).font(.system(size: 16)).fontWeight(.bold).foregroundColor(Color("text"))
    </#if>
    <#if guidbase.has_child_widget(widget, "secondary")>
${""?left_pad(indent)}    Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "secondary"))}).font(.system(size: 14)).foregroundColor(Color("text_muted"))
    </#if>
    <#if guidbase.has_child_widget(widget, "start_time")>
${""?left_pad(indent)}    Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "start_time"))}).font(.system(size: 12)).foregroundColor(Color("text_light"))
    </#if>
    <#if guidbase.has_child_widget(widget, "end_time")>
${""?left_pad(indent)}    Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "end_time"))}).font(.system(size: 12)).foregroundColor(Color("text_light"))
    </#if>
    <#if guidbase.has_child_widget(widget, "avatars")>
${""?left_pad(indent)}    HStack(spacing: 4) {
${""?left_pad(indent)}      ForEach(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "avatars"))}, id: \.self) { av in
${""?left_pad(indent)}        Image(av)
${""?left_pad(indent)}          .resizable()
${""?left_pad(indent)}          .aspectRatio(contentMode: .fill)
${""?left_pad(indent)}          .frame(width: 20, height: 20)
${""?left_pad(indent)}          .cornerRadius(10)
${""?left_pad(indent)}          .padding(.trailing, 4)
${""?left_pad(indent)}      }
${""?left_pad(indent)}    }
    </#if>
${""?left_pad(indent)}  }
${""?left_pad(indent)}  .frame(maxWidth: .infinity, alignment: .leading)
${""?left_pad(indent)}  .padding(12)
  </#if>
${""?left_pad(indent)}}
${""?left_pad(indent)}.background(Color("bg"))
${""?left_pad(indent)}.cornerRadius(8)
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
${""?left_pad(indent)}VStack(alignment: .leading, spacing: 8) {
${""?left_pad(indent)}  HStack {
    <#if guidbase.has_child_widget(widget, "tags")>
${""?left_pad(indent)}    HStack(spacing: 4) {
${""?left_pad(indent)}      ForEach(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "tags"))}, id: \.self) { tag in
${""?left_pad(indent)}        Text(tag)
${""?left_pad(indent)}          .font(.system(size: 10))
${""?left_pad(indent)}          .foregroundColor(Color("primary"))
${""?left_pad(indent)}          .padding(.horizontal, 6)
${""?left_pad(indent)}          .padding(.vertical, 2)
${""?left_pad(indent)}          .background(Color("primary_bg"))
${""?left_pad(indent)}          .cornerRadius(4)
${""?left_pad(indent)}          .padding(.trailing, 4)
${""?left_pad(indent)}      }
${""?left_pad(indent)}    }
    </#if>
    <#if guidbase.has_child_widget(widget, "status")>
${""?left_pad(indent)}    Spacer()
${""?left_pad(indent)}    Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))}).font(.system(size: 12)).foregroundColor(Color("primary"))
    </#if>
${""?left_pad(indent)}  }
${""?left_pad(indent)}  .frame(maxWidth: .infinity)
  <#if guidbase.has_child_widget(widget, "primary") || guidbase.has_child_widget(widget, "secondary") || guidbase.has_child_widget(widget, "tertiary")>
${""?left_pad(indent)}  VStack(alignment: .leading, spacing: 4) {
    <#if guidbase.has_child_widget(widget, "primary")>
${""?left_pad(indent)}    Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))}).font(.system(size: 16)).fontWeight(.bold).foregroundColor(Color("text"))
    </#if>
    <#if guidbase.has_child_widget(widget, "secondary")>
${""?left_pad(indent)}    Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "secondary"))}).font(.system(size: 14)).foregroundColor(Color("text_muted"))
    </#if>
    <#if guidbase.has_child_widget(widget, "tertiary")>
${""?left_pad(indent)}    Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "tertiary"))}).font(.system(size: 12)).foregroundColor(Color("text_light"))
    </#if>
${""?left_pad(indent)}  }
${""?left_pad(indent)}  .frame(maxWidth: .infinity, alignment: .leading)
  </#if>
${""?left_pad(indent)}  HStack {
    <#if guidbase.has_child_widget(widget, "avatar")>
${""?left_pad(indent)}    Image(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "avatar"))})
${""?left_pad(indent)}      .resizable()
${""?left_pad(indent)}      .aspectRatio(contentMode: .fill)
${""?left_pad(indent)}      .frame(width: 24, height: 24)
${""?left_pad(indent)}      .cornerRadius(12)
    </#if>
    <#if guidbase.has_child_widget(widget, "end_time")>
${""?left_pad(indent)}    Spacer()
${""?left_pad(indent)}    Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "end_time"))}).font(.system(size: 12)).foregroundColor(Color("text_muted"))
    </#if>
${""?left_pad(indent)}  }
${""?left_pad(indent)}  .frame(maxWidth: .infinity)
${""?left_pad(indent)}}
${""?left_pad(indent)}.padding(12)
${""?left_pad(indent)}.background(Color("bg"))
${""?left_pad(indent)}.cornerRadius(8)
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
${""?left_pad(indent)}VStack(alignment: .leading, spacing: 8) {
${""?left_pad(indent)}  VStack(alignment: .leading, spacing: 4) {
    <#if guidbase.has_child_widget(widget, "primary")>
${""?left_pad(indent)}    Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))}).font(.system(size: 16)).fontWeight(.bold).foregroundColor(Color("text"))
    </#if>
    <#if guidbase.has_child_widget(widget, "secondary")>
${""?left_pad(indent)}    Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "secondary"))}).font(.system(size: 14)).foregroundColor(Color("text_muted"))
    </#if>
${""?left_pad(indent)}  }
${""?left_pad(indent)}  .frame(maxWidth: .infinity, alignment: .leading)
${""?left_pad(indent)}  HStack {
    <#if guidbase.has_child_widget(widget, "avatars")>
${""?left_pad(indent)}    HStack(spacing: 4) {
${""?left_pad(indent)}      ForEach(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "avatars"))}, id: \.self) { av in
${""?left_pad(indent)}        Image(av)
${""?left_pad(indent)}          .resizable()
${""?left_pad(indent)}          .aspectRatio(contentMode: .fill)
${""?left_pad(indent)}          .frame(width: 24, height: 24)
${""?left_pad(indent)}          .cornerRadius(12)
${""?left_pad(indent)}          .padding(.trailing, 4)
${""?left_pad(indent)}      }
${""?left_pad(indent)}    }
    </#if>
    <#if guidbase.has_child_widget(widget, "tags")>
${""?left_pad(indent)}    Spacer()
${""?left_pad(indent)}    HStack(spacing: 4) {
${""?left_pad(indent)}      ForEach(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "tags"))}, id: \.self) { tag in
${""?left_pad(indent)}        Text(tag)
${""?left_pad(indent)}          .font(.system(size: 10))
${""?left_pad(indent)}          .foregroundColor(Color("primary"))
${""?left_pad(indent)}          .padding(.horizontal, 6)
${""?left_pad(indent)}          .padding(.vertical, 2)
${""?left_pad(indent)}          .background(Color("primary_bg"))
${""?left_pad(indent)}          .cornerRadius(4)
${""?left_pad(indent)}          .padding(.leading, 4)
${""?left_pad(indent)}      }
${""?left_pad(indent)}    }
    </#if>
${""?left_pad(indent)}  }
${""?left_pad(indent)}  .frame(maxWidth: .infinity)
${""?left_pad(indent)}}
${""?left_pad(indent)}.padding(12)
${""?left_pad(indent)}.background(Color("bg"))
${""?left_pad(indent)}.cornerRadius(8)
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
${""?left_pad(indent)}ZStack(alignment: .bottomLeading) {
  <#if guidbase.has_child_widget(widget, "background")>
${""?left_pad(indent)}  Image(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "background"))})
${""?left_pad(indent)}    .resizable()
${""?left_pad(indent)}    .aspectRatio(contentMode: .fill)
${""?left_pad(indent)}    .frame(height: 200)
${""?left_pad(indent)}    .frame(maxWidth: .infinity)
  </#if>
${""?left_pad(indent)}  VStack(alignment: .leading, spacing: 6) {
    <#if guidbase.has_child_widget(widget, "status")>
${""?left_pad(indent)}    Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))})
${""?left_pad(indent)}      .font(.system(size: 12))
${""?left_pad(indent)}      .foregroundColor(Color("primary"))
${""?left_pad(indent)}      .padding(.horizontal, 6)
${""?left_pad(indent)}      .padding(.vertical, 2)
${""?left_pad(indent)}      .background(Color("bg"))
${""?left_pad(indent)}      .cornerRadius(4)
${""?left_pad(indent)}      .padding(.bottom, 6)
    </#if>
    <#if guidbase.has_child_widget(widget, "primary")>
${""?left_pad(indent)}    Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))}).font(.system(size: 18)).fontWeight(.bold).foregroundColor(Color("bg"))
    </#if>
${""?left_pad(indent)}  }
${""?left_pad(indent)}  .padding(12)
${""?left_pad(indent)}  .frame(maxWidth: .infinity, alignment: .leading)
${""?left_pad(indent)}}
${""?left_pad(indent)}.cornerRadius(8)
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
${""?left_pad(indent)}VStack(alignment: .leading, spacing: 8) {
${""?left_pad(indent)}  HStack {
    <#if guidbase.has_child_widget(widget, "status")>
${""?left_pad(indent)}    Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))}).font(.system(size: 12)).foregroundColor(Color("primary"))
    </#if>
    <#if guidbase.has_child_widget(widget, "end_time")>
${""?left_pad(indent)}    Spacer()
${""?left_pad(indent)}    Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "end_time"))}).font(.system(size: 12)).foregroundColor(Color("text_muted"))
    </#if>
${""?left_pad(indent)}  }
${""?left_pad(indent)}  .frame(maxWidth: .infinity)
  <#if guidbase.has_child_widget(widget, "primary")>
${""?left_pad(indent)}  Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))}).font(.system(size: 16)).fontWeight(.bold).foregroundColor(Color("text")).frame(maxWidth: .infinity, alignment: .leading)
  </#if>
  <#if guidbase.has_child_widget(widget, "tags")>
${""?left_pad(indent)}  HStack(spacing: 4) {
${""?left_pad(indent)}    ForEach(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "tags"))}, id: \.self) { tag in
${""?left_pad(indent)}      Text(tag)
${""?left_pad(indent)}        .font(.system(size: 10))
${""?left_pad(indent)}        .foregroundColor(Color("primary"))
${""?left_pad(indent)}        .padding(.horizontal, 6)
${""?left_pad(indent)}        .padding(.vertical, 2)
${""?left_pad(indent)}        .background(Color("primary_bg"))
${""?left_pad(indent)}        .cornerRadius(4)
${""?left_pad(indent)}        .padding(.trailing, 4)
${""?left_pad(indent)}    }
${""?left_pad(indent)}  }
  </#if>
${""?left_pad(indent)}}
${""?left_pad(indent)}.padding(12)
${""?left_pad(indent)}.background(Color("bg"))
${""?left_pad(indent)}.cornerRadius(8)
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
${""?left_pad(indent)}HStack(alignment: .top, spacing: 12) {
${""?left_pad(indent)}  VStack(alignment: .leading, spacing: 4) {
    <#if guidbase.has_child_widget(widget, "primary")>
${""?left_pad(indent)}    Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))}).font(.system(size: 16)).fontWeight(.bold).foregroundColor(Color("text"))
    </#if>
    <#if guidbase.has_child_widget(widget, "tertiary")>
${""?left_pad(indent)}    Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "tertiary"))}).font(.system(size: 12)).foregroundColor(Color("text_light"))
    </#if>
    <#if guidbase.has_child_widget(widget, "avatar")>
${""?left_pad(indent)}    Image(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "avatar"))})
${""?left_pad(indent)}      .resizable()
${""?left_pad(indent)}      .aspectRatio(contentMode: .fill)
${""?left_pad(indent)}      .frame(width: 32, height: 32)
${""?left_pad(indent)}      .cornerRadius(16)
    </#if>
${""?left_pad(indent)}  }
${""?left_pad(indent)}  .frame(maxWidth: .infinity, alignment: .leading)
${""?left_pad(indent)}  VStack(alignment: .leading, spacing: 4) {
    <#if guidbase.has_child_widget(widget, "secondary")>
${""?left_pad(indent)}    Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "secondary"))}).font(.system(size: 14)).foregroundColor(Color("text_muted"))
    </#if>
    <#if guidbase.has_child_widget(widget, "tags")>
${""?left_pad(indent)}    HStack(spacing: 4) {
${""?left_pad(indent)}      ForEach(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "tags"))}, id: \.self) { tag in
${""?left_pad(indent)}        Text(tag)
${""?left_pad(indent)}          .font(.system(size: 10))
${""?left_pad(indent)}          .foregroundColor(Color("primary"))
${""?left_pad(indent)}          .padding(.horizontal, 6)
${""?left_pad(indent)}          .padding(.vertical, 2)
${""?left_pad(indent)}          .background(Color("primary_bg"))
${""?left_pad(indent)}          .cornerRadius(4)
${""?left_pad(indent)}          .padding(.trailing, 4)
${""?left_pad(indent)}      }
${""?left_pad(indent)}    }
${""?left_pad(indent)}    .padding(.bottom, 8)
    </#if>
    <#if guidbase.has_child_widget(widget, "avatars")>
${""?left_pad(indent)}    HStack(spacing: 4) {
${""?left_pad(indent)}      ForEach(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "avatars"))}, id: \.self) { av in
${""?left_pad(indent)}        Image(av)
${""?left_pad(indent)}          .resizable()
${""?left_pad(indent)}          .aspectRatio(contentMode: .fill)
${""?left_pad(indent)}          .frame(width: 20, height: 20)
${""?left_pad(indent)}          .cornerRadius(10)
${""?left_pad(indent)}          .padding(.trailing, 4)
${""?left_pad(indent)}      }
${""?left_pad(indent)}    }
    </#if>
${""?left_pad(indent)}  }
${""?left_pad(indent)}  .frame(maxWidth: .infinity, alignment: .leading)
${""?left_pad(indent)}}
${""?left_pad(indent)}.frame(maxWidth: .infinity)
${""?left_pad(indent)}.padding(12)
${""?left_pad(indent)}.background(Color("bg"))
${""?left_pad(indent)}.cornerRadius(8)
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
${""?left_pad(indent)}VStack(alignment: .leading, spacing: 8) {
  <#if guidbase.has_child_widget(widget, "image")>
${""?left_pad(indent)}  Image(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "image"))})
${""?left_pad(indent)}    .resizable()
${""?left_pad(indent)}    .aspectRatio(contentMode: .fill)
${""?left_pad(indent)}    .frame(height: 150)
${""?left_pad(indent)}    .frame(maxWidth: .infinity)
${""?left_pad(indent)}    .cornerRadius(4)
  </#if>
  <#if guidbase.has_child_widget(widget, "primary")>
${""?left_pad(indent)}  Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))}).font(.system(size: 16)).fontWeight(.bold).foregroundColor(Color("text")).frame(maxWidth: .infinity, alignment: .leading)
  </#if>
${""?left_pad(indent)}  HStack {
    <#if guidbase.has_child_widget(widget, "avatars")>
${""?left_pad(indent)}    HStack(spacing: 4) {
${""?left_pad(indent)}      ForEach(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "avatars"))}, id: \.self) { av in
${""?left_pad(indent)}        Image(av)
${""?left_pad(indent)}          .resizable()
${""?left_pad(indent)}          .aspectRatio(contentMode: .fill)
${""?left_pad(indent)}          .frame(width: 24, height: 24)
${""?left_pad(indent)}          .cornerRadius(12)
${""?left_pad(indent)}          .padding(.trailing, 4)
${""?left_pad(indent)}      }
${""?left_pad(indent)}    }
    </#if>
    <#if guidbase.has_child_widget(widget, "status")>
${""?left_pad(indent)}    Spacer()
${""?left_pad(indent)}    Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))}).font(.system(size: 12)).foregroundColor(Color("primary"))
    </#if>
${""?left_pad(indent)}  }
${""?left_pad(indent)}  .frame(maxWidth: .infinity)
${""?left_pad(indent)}}
${""?left_pad(indent)}.padding(12)
${""?left_pad(indent)}.background(Color("bg"))
${""?left_pad(indent)}.cornerRadius(8)
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
${""?left_pad(indent)}VStack(alignment: .leading, spacing: 8) {
  <#if guidbase.has_child_widget(widget, "tags")>
${""?left_pad(indent)}  HStack(spacing: 4) {
${""?left_pad(indent)}    ForEach(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "tags"))}, id: \.self) { tag in
${""?left_pad(indent)}      Text(tag)
${""?left_pad(indent)}        .font(.system(size: 10))
${""?left_pad(indent)}        .foregroundColor(Color("primary"))
${""?left_pad(indent)}        .padding(.horizontal, 6)
${""?left_pad(indent)}        .padding(.vertical, 2)
${""?left_pad(indent)}        .background(Color("primary_bg"))
${""?left_pad(indent)}        .cornerRadius(4)
${""?left_pad(indent)}        .padding(.trailing, 4)
${""?left_pad(indent)}    }
${""?left_pad(indent)}  }
${""?left_pad(indent)}  .frame(maxWidth: .infinity)
  </#if>
  <#if guidbase.has_child_widget(widget, "primary")>
${""?left_pad(indent)}  Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))}).font(.system(size: 24)).fontWeight(.bold).foregroundColor(Color("primary")).frame(maxWidth: .infinity, alignment: .leading)
  </#if>
${""?left_pad(indent)}  HStack {
    <#if guidbase.has_child_widget(widget, "secondary")>
${""?left_pad(indent)}    Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "secondary"))}).font(.system(size: 12)).foregroundColor(Color("text_muted"))
    </#if>
    <#if guidbase.has_child_widget(widget, "status")>
${""?left_pad(indent)}    Spacer()
${""?left_pad(indent)}    Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))}).font(.system(size: 12)).foregroundColor(Color("primary"))
    </#if>
${""?left_pad(indent)}  }
${""?left_pad(indent)}  .frame(maxWidth: .infinity)
${""?left_pad(indent)}}
${""?left_pad(indent)}.padding(12)
${""?left_pad(indent)}.background(Color("bg"))
${""?left_pad(indent)}.cornerRadius(8)
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
${""?left_pad(indent)}VStack(alignment: .leading, spacing: 0) {
  <#if guidbase.has_child_widget(widget, "image")>
${""?left_pad(indent)}  Image(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "image"))})
${""?left_pad(indent)}    .resizable()
${""?left_pad(indent)}    .aspectRatio(contentMode: .fill)
${""?left_pad(indent)}    .frame(height: 120)
${""?left_pad(indent)}    .frame(maxWidth: .infinity)
${""?left_pad(indent)}    .clipShape(RoundedCorner(radius: 8, corners: [.topLeft, .topRight]))
  </#if>
${""?left_pad(indent)}  HStack(alignment: .top, spacing: 12) {
    <#if guidbase.has_child_widget(widget, "avatar")>
${""?left_pad(indent)}    Image(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "avatar"))})
${""?left_pad(indent)}      .resizable()
${""?left_pad(indent)}      .aspectRatio(contentMode: .fill)
${""?left_pad(indent)}      .frame(width: 48, height: 48)
${""?left_pad(indent)}      .cornerRadius(24)
${""?left_pad(indent)}      .overlay(RoundedRectangle(cornerRadius: 24).stroke(Color("bg"), lineWidth: 2))
${""?left_pad(indent)}      .offset(y: -24)
${""?left_pad(indent)}      .padding(.trailing, 12)
    </#if>
${""?left_pad(indent)}    VStack(alignment: .leading, spacing: 4) {
      <#if guidbase.has_child_widget(widget, "primary")>
${""?left_pad(indent)}      Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))}).font(.system(size: 16)).fontWeight(.bold).foregroundColor(Color("text"))
      </#if>
      <#if guidbase.has_child_widget(widget, "secondary")>
${""?left_pad(indent)}      Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "secondary"))}).font(.system(size: 14)).foregroundColor(Color("text_muted"))
      </#if>
${""?left_pad(indent)}    }
${""?left_pad(indent)}  }
${""?left_pad(indent)}  .padding(.horizontal, 12)
${""?left_pad(indent)}  .padding(.bottom, 12)
${""?left_pad(indent)}}
${""?left_pad(indent)}.background(Color("bg"))
${""?left_pad(indent)}.cornerRadius(8)
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
${""?left_pad(indent)}HStack(alignment: .top, spacing: 12) {
  <#if guidbase.has_child_widget(widget, "avatar")>
${""?left_pad(indent)}  Image(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "avatar"))})
${""?left_pad(indent)}    .resizable()
${""?left_pad(indent)}    .aspectRatio(contentMode: .fill)
${""?left_pad(indent)}    .frame(width: 40, height: 40)
${""?left_pad(indent)}    .cornerRadius(20)
  </#if>
${""?left_pad(indent)}  VStack(alignment: .leading, spacing: 4) {
${""?left_pad(indent)}    HStack {
      <#if guidbase.has_child_widget(widget, "primary")>
${""?left_pad(indent)}      Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))}).font(.system(size: 14)).fontWeight(.bold).foregroundColor(Color("text"))
      </#if>
      <#if guidbase.has_child_widget(widget, "status")>
${""?left_pad(indent)}      Spacer()
${""?left_pad(indent)}      Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))}).font(.system(size: 12)).foregroundColor(Color("primary"))
      </#if>
${""?left_pad(indent)}    }
${""?left_pad(indent)}    .frame(maxWidth: .infinity)
    <#if guidbase.has_child_widget(widget, "secondary")>
${""?left_pad(indent)}    Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "secondary"))}).font(.system(size: 12)).foregroundColor(Color("text_muted"))
    </#if>
    <#if guidbase.has_child_widget(widget, "start_time")>
${""?left_pad(indent)}    Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "start_time"))}).font(.system(size: 12)).foregroundColor(Color("text_light"))
    </#if>
${""?left_pad(indent)}  }
${""?left_pad(indent)}}
${""?left_pad(indent)}.frame(maxWidth: .infinity)
${""?left_pad(indent)}.padding(12)
${""?left_pad(indent)}.background(Color("bg"))
${""?left_pad(indent)}.cornerRadius(8)
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
${""?left_pad(indent)}VStack(alignment: .leading, spacing: 8) {
${""?left_pad(indent)}  HStack {
    <#if guidbase.has_child_widget(widget, "start_time")>
${""?left_pad(indent)}    Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "start_time"))}).font(.system(size: 12)).foregroundColor(Color("text_muted"))
    </#if>
    <#if guidbase.has_child_widget(widget, "status")>
${""?left_pad(indent)}    Spacer()
${""?left_pad(indent)}    Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))}).font(.system(size: 12)).foregroundColor(Color("primary"))
    </#if>
${""?left_pad(indent)}  }
${""?left_pad(indent)}  .frame(maxWidth: .infinity)
  <#if guidbase.has_child_widget(widget, "primary")>
${""?left_pad(indent)}  Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))}).font(.system(size: 14)).fontWeight(.medium).foregroundColor(Color("text")).frame(maxWidth: .infinity, alignment: .leading)
  </#if>
  <#if guidbase.has_child_widget(widget, "avatars")>
${""?left_pad(indent)}  HStack(spacing: 2) {
${""?left_pad(indent)}    ForEach(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "avatars"))}, id: \.self) { av in
${""?left_pad(indent)}      Image(av)
${""?left_pad(indent)}        .resizable()
${""?left_pad(indent)}        .aspectRatio(contentMode: .fill)
${""?left_pad(indent)}        .frame(width: 16, height: 16)
${""?left_pad(indent)}        .cornerRadius(8)
${""?left_pad(indent)}        .padding(.trailing, 2)
${""?left_pad(indent)}    }
${""?left_pad(indent)}  }
${""?left_pad(indent)}  .frame(maxWidth: .infinity, alignment: .leading)
  </#if>
${""?left_pad(indent)}}
${""?left_pad(indent)}.padding(8)
${""?left_pad(indent)}.background(Color("bg"))
${""?left_pad(indent)}.cornerRadius(4)
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
${""?left_pad(indent)}HStack(alignment: .center, spacing: 12) {
  <#if guidbase.has_child_widget(widget, "status")>
${""?left_pad(indent)}  VStack {
${""?left_pad(indent)}    Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))}).font(.system(size: 12)).foregroundColor(Color("primary"))
${""?left_pad(indent)}  }
${""?left_pad(indent)}  .frame(width: 40)
  </#if>
${""?left_pad(indent)}  VStack(alignment: .leading, spacing: 4) {
    <#if guidbase.has_child_widget(widget, "primary")>
${""?left_pad(indent)}    Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))}).font(.system(size: 16)).fontWeight(.bold).foregroundColor(Color("text"))
    </#if>
    <#if guidbase.has_child_widget(widget, "secondary")>
${""?left_pad(indent)}    Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "secondary"))}).font(.system(size: 14)).foregroundColor(Color("text_muted"))
    </#if>
    <#if guidbase.has_child_widget(widget, "start_time")>
${""?left_pad(indent)}    Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "start_time"))}).font(.system(size: 12)).foregroundColor(Color("text_light"))
    </#if>
${""?left_pad(indent)}  }
${""?left_pad(indent)}}
${""?left_pad(indent)}.frame(maxWidth: .infinity)
${""?left_pad(indent)}.padding(12)
${""?left_pad(indent)}.background(Color("bg"))
${""?left_pad(indent)}.cornerRadius(8)
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
${""?left_pad(indent)}VStack(alignment: .leading, spacing: 8) {
  <#if guidbase.has_child_widget(widget, "tags")>
${""?left_pad(indent)}  HStack(spacing: 4) {
${""?left_pad(indent)}    ForEach(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "tags"))}, id: \.self) { tag in
${""?left_pad(indent)}      Text(tag)
${""?left_pad(indent)}        .font(.system(size: 10))
${""?left_pad(indent)}        .foregroundColor(Color("primary"))
${""?left_pad(indent)}        .padding(.horizontal, 6)
${""?left_pad(indent)}        .padding(.vertical, 2)
${""?left_pad(indent)}        .background(Color("primary_bg"))
${""?left_pad(indent)}        .cornerRadius(4)
${""?left_pad(indent)}        .padding(.trailing, 4)
${""?left_pad(indent)}    }
${""?left_pad(indent)}  }
${""?left_pad(indent)}  .frame(maxWidth: .infinity)
  </#if>
  <#if guidbase.has_child_widget(widget, "primary")>
${""?left_pad(indent)}  Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))}).font(.system(size: 16)).fontWeight(.bold).foregroundColor(Color("text")).frame(maxWidth: .infinity, alignment: .leading)
  </#if>
${""?left_pad(indent)}  HStack {
    <#if guidbase.has_child_widget(widget, "secondary")>
${""?left_pad(indent)}    Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "secondary"))}).font(.system(size: 12)).foregroundColor(Color("text_muted"))
    </#if>
    <#if guidbase.has_child_widget(widget, "end_time")>
${""?left_pad(indent)}    Spacer()
${""?left_pad(indent)}    Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "end_time"))}).font(.system(size: 12)).foregroundColor(Color("text_light"))
    </#if>
${""?left_pad(indent)}  }
${""?left_pad(indent)}  .frame(maxWidth: .infinity)
${""?left_pad(indent)}}
${""?left_pad(indent)}.padding(12)
${""?left_pad(indent)}.background(Color("bg"))
${""?left_pad(indent)}.cornerRadius(8)
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
${""?left_pad(indent)}VStack(alignment: .leading, spacing: 8) {
${""?left_pad(indent)}  HStack {
    <#if guidbase.has_child_widget(widget, "start_time") || guidbase.has_child_widget(widget, "end_time")>
${""?left_pad(indent)}    HStack(spacing: 4) {
      <#if guidbase.has_child_widget(widget, "start_time")>${""?left_pad(indent)}      Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "start_time"))}).font(.system(size: 12)).foregroundColor(Color("text_muted"))</#if>
      <#if guidbase.has_child_widget(widget, "start_time") && guidbase.has_child_widget(widget, "end_time")>${""?left_pad(indent)}      Text(" - ").font(.system(size: 12)).foregroundColor(Color("text_muted"))</#if>
      <#if guidbase.has_child_widget(widget, "end_time")>${""?left_pad(indent)}      Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "end_time"))}).font(.system(size: 12)).foregroundColor(Color("text_muted"))</#if>
${""?left_pad(indent)}    }
    </#if>
    <#if guidbase.has_child_widget(widget, "status")>
${""?left_pad(indent)}    Spacer()
${""?left_pad(indent)}    Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))}).font(.system(size: 12)).foregroundColor(Color("primary"))
    </#if>
${""?left_pad(indent)}  }
${""?left_pad(indent)}  .frame(maxWidth: .infinity)
  <#if guidbase.has_child_widget(widget, "primary")>
${""?left_pad(indent)}  Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))}).font(.system(size: 16)).fontWeight(.bold).foregroundColor(Color("text")).frame(maxWidth: .infinity, alignment: .leading)
  </#if>
  <#if guidbase.has_child_widget(widget, "avatars")>
${""?left_pad(indent)}  HStack(spacing: 4) {
${""?left_pad(indent)}    ForEach(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "avatars"))}, id: \.self) { av in
${""?left_pad(indent)}      Image(av)
${""?left_pad(indent)}        .resizable()
${""?left_pad(indent)}        .aspectRatio(contentMode: .fill)
${""?left_pad(indent)}        .frame(width: 20, height: 20)
${""?left_pad(indent)}        .cornerRadius(10)
${""?left_pad(indent)}        .padding(.trailing, 4)
${""?left_pad(indent)}    }
${""?left_pad(indent)}  }
${""?left_pad(indent)}  .frame(maxWidth: .infinity, alignment: .leading)
  </#if>
${""?left_pad(indent)}}
${""?left_pad(indent)}.padding(12)
${""?left_pad(indent)}.background(Color("bg"))
${""?left_pad(indent)}.cornerRadius(8)
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
${""?left_pad(indent)}VStack(alignment: .leading, spacing: 8) {
${""?left_pad(indent)}  HStack(alignment: .center, spacing: 12) {
    <#if guidbase.has_child_widget(widget, "avatar")>
${""?left_pad(indent)}    Image(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "avatar"))})
${""?left_pad(indent)}      .resizable()
${""?left_pad(indent)}      .aspectRatio(contentMode: .fill)
${""?left_pad(indent)}      .frame(width: 40, height: 40)
${""?left_pad(indent)}      .cornerRadius(20)
    </#if>
${""?left_pad(indent)}    VStack(alignment: .leading, spacing: 4) {
      <#if guidbase.has_child_widget(widget, "primary")>
${""?left_pad(indent)}      Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))}).font(.system(size: 14)).fontWeight(.bold).foregroundColor(Color("text"))
      </#if>
      <#if guidbase.has_child_widget(widget, "start_time")>
${""?left_pad(indent)}      Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "start_time"))}).font(.system(size: 12)).foregroundColor(Color("text_muted"))
      </#if>
${""?left_pad(indent)}    }
${""?left_pad(indent)}  }
${""?left_pad(indent)}  .frame(maxWidth: .infinity, alignment: .leading)
  <#if guidbase.has_child_widget(widget, "tertiary")>
${""?left_pad(indent)}  Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "tertiary"))}).font(.system(size: 14)).foregroundColor(Color("text")).frame(maxWidth: .infinity, alignment: .leading)
  </#if>
  <#if guidbase.has_child_widget(widget, "image")>
${""?left_pad(indent)}  Image(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "image"))})
${""?left_pad(indent)}    .resizable()
${""?left_pad(indent)}    .aspectRatio(contentMode: .fill)
${""?left_pad(indent)}    .frame(height: 200)
${""?left_pad(indent)}    .frame(maxWidth: .infinity)
${""?left_pad(indent)}    .cornerRadius(4)
  </#if>
${""?left_pad(indent)}  HStack {
    <#if guidbase.has_child_widget(widget, "avatars")>
${""?left_pad(indent)}    HStack(spacing: 4) {
${""?left_pad(indent)}      ForEach(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "avatars"))}, id: \.self) { av in
${""?left_pad(indent)}        Image(av)
${""?left_pad(indent)}          .resizable()
${""?left_pad(indent)}          .aspectRatio(contentMode: .fill)
${""?left_pad(indent)}          .frame(width: 20, height: 20)
${""?left_pad(indent)}          .cornerRadius(10)
${""?left_pad(indent)}          .padding(.trailing, 4)
${""?left_pad(indent)}      }
${""?left_pad(indent)}    }
    </#if>
    <#if guidbase.has_child_widget(widget, "tags")>
${""?left_pad(indent)}    Spacer()
${""?left_pad(indent)}    HStack(spacing: 4) {
${""?left_pad(indent)}      ForEach(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "tags"))}, id: \.self) { tag in
${""?left_pad(indent)}        Text(tag)
${""?left_pad(indent)}          .font(.system(size: 10))
${""?left_pad(indent)}          .foregroundColor(Color("primary"))
${""?left_pad(indent)}          .padding(.horizontal, 6)
${""?left_pad(indent)}          .padding(.vertical, 2)
${""?left_pad(indent)}          .background(Color("primary_bg"))
${""?left_pad(indent)}          .cornerRadius(4)
${""?left_pad(indent)}          .padding(.leading, 4)
${""?left_pad(indent)}      }
${""?left_pad(indent)}    }
    </#if>
${""?left_pad(indent)}  }
${""?left_pad(indent)}  .frame(maxWidth: .infinity)
${""?left_pad(indent)}}
${""?left_pad(indent)}.padding(12)
${""?left_pad(indent)}.background(Color("bg"))
${""?left_pad(indent)}.cornerRadius(8)
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
${""?left_pad(indent)}VStack(alignment: .leading, spacing: 8) {
  <#if guidbase.has_child_widget(widget, "image")>
${""?left_pad(indent)}  Image(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "image"))})
${""?left_pad(indent)}    .resizable()
${""?left_pad(indent)}    .aspectRatio(contentMode: .fill)
${""?left_pad(indent)}    .frame(height: 150)
${""?left_pad(indent)}    .frame(maxWidth: .infinity)
${""?left_pad(indent)}    .cornerRadius(4)
  </#if>
  <#if guidbase.has_child_widget(widget, "tags")>
${""?left_pad(indent)}  HStack(spacing: 4) {
${""?left_pad(indent)}    ForEach(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "tags"))}, id: \.self) { tag in
${""?left_pad(indent)}      Text(tag)
${""?left_pad(indent)}        .font(.system(size: 10))
${""?left_pad(indent)}        .foregroundColor(Color("primary"))
${""?left_pad(indent)}        .padding(.horizontal, 6)
${""?left_pad(indent)}        .padding(.vertical, 2)
${""?left_pad(indent)}        .background(Color("primary_bg"))
${""?left_pad(indent)}        .cornerRadius(4)
${""?left_pad(indent)}        .padding(.trailing, 4)
${""?left_pad(indent)}    }
${""?left_pad(indent)}  }
${""?left_pad(indent)}  .frame(maxWidth: .infinity, alignment: .leading)
  </#if>
  <#if guidbase.has_child_widget(widget, "primary")>
${""?left_pad(indent)}  Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))}).font(.system(size: 16)).fontWeight(.bold).foregroundColor(Color("text")).frame(maxWidth: .infinity, alignment: .leading)
  </#if>
  <#if guidbase.has_child_widget(widget, "secondary")>
${""?left_pad(indent)}  Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "secondary"))}).font(.system(size: 14)).foregroundColor(Color("text_muted")).frame(maxWidth: .infinity, alignment: .leading)
  </#if>
${""?left_pad(indent)}  HStack {
    <#if guidbase.has_child_widget(widget, "status")>
${""?left_pad(indent)}    Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))}).font(.system(size: 12)).foregroundColor(Color("primary"))
    </#if>
    <#if guidbase.has_child_widget(widget, "end_time")>
${""?left_pad(indent)}    Spacer()
${""?left_pad(indent)}    Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "end_time"))}).font(.system(size: 12)).foregroundColor(Color("text_light"))
    </#if>
${""?left_pad(indent)}  }
${""?left_pad(indent)}  .frame(maxWidth: .infinity)
${""?left_pad(indent)}}
${""?left_pad(indent)}.padding(12)
${""?left_pad(indent)}.background(Color("bg"))
${""?left_pad(indent)}.cornerRadius(8)
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
${""?left_pad(indent)}VStack(alignment: .leading, spacing: 8) {
${""?left_pad(indent)}  HStack {
    <#if guidbase.has_child_widget(widget, "avatar")>
${""?left_pad(indent)}    Image(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "avatar"))})
${""?left_pad(indent)}      .resizable()
${""?left_pad(indent)}      .aspectRatio(contentMode: .fill)
${""?left_pad(indent)}      .frame(width: 40, height: 40)
${""?left_pad(indent)}      .cornerRadius(20)
    </#if>
    <#if guidbase.has_child_widget(widget, "status")>
${""?left_pad(indent)}    Spacer()
${""?left_pad(indent)}    Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))}).font(.system(size: 14)).fontWeight(.bold).foregroundColor(Color("primary"))
${""?left_pad(indent)}    Spacer()
    </#if>
    <#if guidbase.has_child_widget(widget, "secondary")>
${""?left_pad(indent)}    Image(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "secondary"))})
${""?left_pad(indent)}      .resizable()
${""?left_pad(indent)}      .aspectRatio(contentMode: .fill)
${""?left_pad(indent)}      .frame(width: 40, height: 40)
${""?left_pad(indent)}      .cornerRadius(20)
    </#if>
${""?left_pad(indent)}  }
${""?left_pad(indent)}  .frame(maxWidth: .infinity)
${""?left_pad(indent)}  HStack {
    <#if guidbase.has_child_widget(widget, "primary")>
${""?left_pad(indent)}    Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))}).font(.system(size: 14)).foregroundColor(Color("text"))
    </#if>
    <#if guidbase.has_child_widget(widget, "secondary")>
${""?left_pad(indent)}    Spacer()
${""?left_pad(indent)}    Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "secondary"))}).font(.system(size: 14)).foregroundColor(Color("text"))
    </#if>
${""?left_pad(indent)}  }
${""?left_pad(indent)}  .frame(maxWidth: .infinity)
${""?left_pad(indent)}  HStack {
    <#if guidbase.has_child_widget(widget, "start_time")>
${""?left_pad(indent)}    Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "start_time"))}).font(.system(size: 12)).foregroundColor(Color("text_muted"))
    </#if>
    <#if guidbase.has_child_widget(widget, "end_time")>
${""?left_pad(indent)}    Spacer()
${""?left_pad(indent)}    Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "end_time"))}).font(.system(size: 12)).foregroundColor(Color("text_muted"))
    </#if>
${""?left_pad(indent)}  }
${""?left_pad(indent)}  .frame(maxWidth: .infinity)
${""?left_pad(indent)}}
${""?left_pad(indent)}.padding(12)
${""?left_pad(indent)}.background(Color("bg"))
${""?left_pad(indent)}.cornerRadius(8)
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
${""?left_pad(indent)}HStack(alignment: .top, spacing: 12) {
  <#if guidbase.has_child_widget(widget, "image")>
${""?left_pad(indent)}  Image(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "image"))})
${""?left_pad(indent)}    .resizable()
${""?left_pad(indent)}    .aspectRatio(contentMode: .fill)
${""?left_pad(indent)}    .frame(width: 100, height: 100)
${""?left_pad(indent)}    .cornerRadius(4)
  </#if>
${""?left_pad(indent)}  VStack(alignment: .leading, spacing: 4) {
    <#if guidbase.has_child_widget(widget, "tags")>
${""?left_pad(indent)}    HStack(spacing: 4) {
${""?left_pad(indent)}      ForEach(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "tags"))}, id: \.self) { tag in
${""?left_pad(indent)}        Text(tag)
${""?left_pad(indent)}          .font(.system(size: 10))
${""?left_pad(indent)}          .foregroundColor(Color("primary"))
${""?left_pad(indent)}          .padding(.horizontal, 6)
${""?left_pad(indent)}          .padding(.vertical, 2)
${""?left_pad(indent)}          .background(Color("primary_bg"))
${""?left_pad(indent)}          .cornerRadius(4)
${""?left_pad(indent)}          .padding(.trailing, 4)
${""?left_pad(indent)}      }
${""?left_pad(indent)}    }
${""?left_pad(indent)}    .padding(.bottom, 4)
    </#if>
    <#if guidbase.has_child_widget(widget, "primary")>
${""?left_pad(indent)}    Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))}).font(.system(size: 16)).fontWeight(.bold).foregroundColor(Color("text"))
    </#if>
    <#if guidbase.has_child_widget(widget, "secondary")>
${""?left_pad(indent)}    Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "secondary"))}).font(.system(size: 14)).foregroundColor(Color("text_muted"))
    </#if>
    <#if guidbase.has_child_widget(widget, "tertiary")>
${""?left_pad(indent)}    Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "tertiary"))}).font(.system(size: 12)).foregroundColor(Color("text_light"))
    </#if>
${""?left_pad(indent)}    HStack {
      <#if guidbase.has_child_widget(widget, "status")>
${""?left_pad(indent)}      Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))}).font(.system(size: 12)).foregroundColor(Color("primary"))
      </#if>
      <#if guidbase.has_child_widget(widget, "avatars")>
${""?left_pad(indent)}      Spacer()
${""?left_pad(indent)}      HStack(spacing: 2) {
${""?left_pad(indent)}        ForEach(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "avatars"))}, id: \.self) { av in
${""?left_pad(indent)}          Image(av)
${""?left_pad(indent)}            .resizable()
${""?left_pad(indent)}            .aspectRatio(contentMode: .fill)
${""?left_pad(indent)}            .frame(width: 16, height: 16)
${""?left_pad(indent)}            .cornerRadius(8)
${""?left_pad(indent)}            .padding(.trailing, 2)
${""?left_pad(indent)}        }
${""?left_pad(indent)}      }
      </#if>
${""?left_pad(indent)}    }
${""?left_pad(indent)}    .frame(maxWidth: .infinity)
${""?left_pad(indent)}  }
${""?left_pad(indent)}  .layoutWeight(1)
${""?left_pad(indent)}}
${""?left_pad(indent)}.frame(maxWidth: .infinity)
${""?left_pad(indent)}.padding(12)
${""?left_pad(indent)}.background(Color("bg"))
${""?left_pad(indent)}.cornerRadius(8)
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
${""?left_pad(indent)}VStack(alignment: .leading, spacing: 8) {
${""?left_pad(indent)}  HStack(spacing: 4) {
    <#if guidbase.has_child_widget(widget, "start_time")>
${""?left_pad(indent)}    Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "start_time"))}).font(.system(size: 12)).foregroundColor(Color("text_muted"))
${""?left_pad(indent)}    Text(" > ").font(.system(size: 12)).foregroundColor(Color("text_light"))
    </#if>
    <#if guidbase.has_child_widget(widget, "avatars")>
${""?left_pad(indent)}    HStack(spacing: 4) {
${""?left_pad(indent)}      ForEach(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "avatars"))}, id: \.self) { av in
${""?left_pad(indent)}        Image(av)
${""?left_pad(indent)}          .resizable()
${""?left_pad(indent)}          .aspectRatio(contentMode: .fill)
${""?left_pad(indent)}          .frame(width: 20, height: 20)
${""?left_pad(indent)}          .cornerRadius(10)
${""?left_pad(indent)}          .padding(.trailing, 4)
${""?left_pad(indent)}      }
${""?left_pad(indent)}    }
${""?left_pad(indent)}    Text(" > ").font(.system(size: 12)).foregroundColor(Color("text_light"))
    </#if>
    <#if guidbase.has_child_widget(widget, "status")>
${""?left_pad(indent)}    Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))}).font(.system(size: 12)).foregroundColor(Color("primary"))
${""?left_pad(indent)}    Text(" > ").font(.system(size: 12)).foregroundColor(Color("text_light"))
    </#if>
    <#if guidbase.has_child_widget(widget, "end_time")>
${""?left_pad(indent)}    Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "end_time"))}).font(.system(size: 12)).foregroundColor(Color("text_muted"))
    </#if>
${""?left_pad(indent)}  }
${""?left_pad(indent)}  .frame(maxWidth: .infinity, alignment: .leading)
  <#if guidbase.has_child_widget(widget, "primary")>
${""?left_pad(indent)}  Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))}).font(.system(size: 16)).fontWeight(.bold).foregroundColor(Color("text")).frame(maxWidth: .infinity, alignment: .leading)
  </#if>
${""?left_pad(indent)}}
${""?left_pad(indent)}.padding(12)
${""?left_pad(indent)}.background(Color("bg"))
${""?left_pad(indent)}.cornerRadius(8)
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
${""?left_pad(indent)}ZStack(alignment: .bottomLeading) {
  <#if guidbase.has_child_widget(widget, "background")>
${""?left_pad(indent)}  Image(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "background"))})
${""?left_pad(indent)}    .resizable()
${""?left_pad(indent)}    .aspectRatio(contentMode: .fill)
${""?left_pad(indent)}    .frame(height: 200)
${""?left_pad(indent)}    .frame(maxWidth: .infinity)
  </#if>
${""?left_pad(indent)}  VStack(alignment: .leading, spacing: 6) {
    <#if guidbase.has_child_widget(widget, "tags")>
${""?left_pad(indent)}    HStack(spacing: 4) {
${""?left_pad(indent)}      ForEach(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "tags"))}, id: \.self) { tag in
${""?left_pad(indent)}        Text(tag)
${""?left_pad(indent)}          .font(.system(size: 10))
${""?left_pad(indent)}          .foregroundColor(Color("bg"))
${""?left_pad(indent)}          .padding(.horizontal, 6)
${""?left_pad(indent)}          .padding(.vertical, 2)
${""?left_pad(indent)}          .background(Color("primary"))
${""?left_pad(indent)}          .cornerRadius(4)
${""?left_pad(indent)}          .padding(.trailing, 4)
${""?left_pad(indent)}      }
${""?left_pad(indent)}    }
${""?left_pad(indent)}    .padding(.bottom, 8)
    </#if>
    <#if guidbase.has_child_widget(widget, "primary")>
${""?left_pad(indent)}    Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))}).font(.system(size: 18)).fontWeight(.bold).foregroundColor(Color("bg")).padding(.bottom, 8)
    </#if>
${""?left_pad(indent)}    HStack {
      <#if guidbase.has_child_widget(widget, "avatar")>
${""?left_pad(indent)}      Image(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "avatar"))})
${""?left_pad(indent)}        .resizable()
${""?left_pad(indent)}        .aspectRatio(contentMode: .fill)
${""?left_pad(indent)}        .frame(width: 24, height: 24)
${""?left_pad(indent)}        .cornerRadius(12)
${""?left_pad(indent)}        .padding(.trailing, 8)
      </#if>
      <#if guidbase.has_child_widget(widget, "secondary")>
${""?left_pad(indent)}      Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "secondary"))}).font(.system(size: 12)).foregroundColor(Color("border_light"))
      </#if>
${""?left_pad(indent)}    }
${""?left_pad(indent)}    .frame(maxWidth: .infinity, alignment: .leading)
${""?left_pad(indent)}  }
${""?left_pad(indent)}  .padding(12)
${""?left_pad(indent)}}
${""?left_pad(indent)}.cornerRadius(8)
</#macro>

<#--
微型标记 (Micro Badge)
+----------------------------------+
| [avatar]  [primary]     [status] |
+----------------------------------+
-->
<#macro print_tile_micro_badge widget indent=0>
${""?left_pad(indent)}HStack(alignment: .center, spacing: 8) {
  <#if guidbase.has_child_widget(widget, "avatar")>
${""?left_pad(indent)}  Image(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "avatar"))})
${""?left_pad(indent)}    .resizable()
${""?left_pad(indent)}    .aspectRatio(contentMode: .fill)
${""?left_pad(indent)}    .frame(width: 24, height: 24)
${""?left_pad(indent)}    .cornerRadius(12)
  </#if>
  <#if guidbase.has_child_widget(widget, "primary")>
${""?left_pad(indent)}  Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))}).font(.system(size: 14)).fontWeight(.medium).foregroundColor(Color("text"))
  </#if>
${""?left_pad(indent)}  Spacer()
  <#if guidbase.has_child_widget(widget, "status")>
${""?left_pad(indent)}  Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))}).font(.system(size: 12)).foregroundColor(Color("primary"))
  </#if>
${""?left_pad(indent)}}
${""?left_pad(indent)}.frame(maxWidth: .infinity)
${""?left_pad(indent)}.padding(.vertical, 8)
${""?left_pad(indent)}.padding(.horizontal, 12)
${""?left_pad(indent)}.background(Color("bg"))
${""?left_pad(indent)}.cornerRadius(4)
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
${""?left_pad(indent)}HStack(alignment: .top, spacing: 12) {
  <#if guidbase.has_child_widget(widget, "status")>
${""?left_pad(indent)}  Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))}).font(.system(size: 14)).foregroundColor(Color("primary"))
  </#if>
${""?left_pad(indent)}  VStack(alignment: .leading, spacing: 4) {
    <#if guidbase.has_child_widget(widget, "primary")>
${""?left_pad(indent)}    Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))}).font(.system(size: 16)).fontWeight(.bold).foregroundColor(Color("text"))
    </#if>
    <#if guidbase.has_child_widget(widget, "secondary")>
${""?left_pad(indent)}    HStack(spacing: 2) {
${""?left_pad(indent)}      Text("├─ ").font(.system(size: 12)).foregroundColor(Color("text_light"))
${""?left_pad(indent)}      Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "secondary"))}).font(.system(size: 12)).foregroundColor(Color("text_muted"))
${""?left_pad(indent)}    }
${""?left_pad(indent)}    .padding(.bottom, 2)
    </#if>
    <#if guidbase.has_child_widget(widget, "start_time") || guidbase.has_child_widget(widget, "end_time")>
${""?left_pad(indent)}    HStack(spacing: 2) {
${""?left_pad(indent)}      Text("├─ ").font(.system(size: 12)).foregroundColor(Color("text_light"))
      <#if guidbase.has_child_widget(widget, "start_time")>${""?left_pad(indent)}      Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "start_time"))}).font(.system(size: 12)).foregroundColor(Color("text_light"))</#if>
      <#if guidbase.has_child_widget(widget, "start_time") && guidbase.has_child_widget(widget, "end_time")>${""?left_pad(indent)}      Text(" - ").font(.system(size: 12)).foregroundColor(Color("text_light"))</#if>
      <#if guidbase.has_child_widget(widget, "end_time")>${""?left_pad(indent)}      Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "end_time"))}).font(.system(size: 12)).foregroundColor(Color("text_light"))</#if>
${""?left_pad(indent)}    }
    </#if>
${""?left_pad(indent)}  }
${""?left_pad(indent)}  .layoutWeight(1)
${""?left_pad(indent)}}
${""?left_pad(indent)}.frame(maxWidth: .infinity)
${""?left_pad(indent)}.padding(12)
${""?left_pad(indent)}.background(Color("bg"))
${""?left_pad(indent)}.cornerRadius(8)
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
${""?left_pad(indent)}ZStack(alignment: .bottom) {
  <#if guidbase.has_child_widget(widget, "image")>
${""?left_pad(indent)}  Image(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "image"))})
${""?left_pad(indent)}    .resizable()
${""?left_pad(indent)}    .aspectRatio(contentMode: .fill)
${""?left_pad(indent)}    .frame(height: 160)
${""?left_pad(indent)}    .frame(maxWidth: .infinity)
  </#if>
${""?left_pad(indent)}  VStack(alignment: .leading, spacing: 4) {
    <#if guidbase.has_child_widget(widget, "primary")>
${""?left_pad(indent)}    Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))}).font(.system(size: 14)).fontWeight(.bold).foregroundColor(Color("text"))
    </#if>
${""?left_pad(indent)}    HStack {
    <#if guidbase.has_child_widget(widget, "secondary")>
${""?left_pad(indent)}      Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "secondary"))}).font(.system(size: 12)).foregroundColor(Color("text_muted"))
    </#if>
    <#if guidbase.has_child_widget(widget, "status")>
${""?left_pad(indent)}      Spacer()
${""?left_pad(indent)}      Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))}).font(.system(size: 12)).foregroundColor(Color("primary"))
    </#if>
${""?left_pad(indent)}    }
${""?left_pad(indent)}    .frame(maxWidth: .infinity)
${""?left_pad(indent)}  }
${""?left_pad(indent)}  .padding(10)
${""?left_pad(indent)}  .background(Color("bg"))
${""?left_pad(indent)}  .cornerRadius(6)
${""?left_pad(indent)}  .padding(8)
${""?left_pad(indent)}}
${""?left_pad(indent)}.cornerRadius(8)
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
${""?left_pad(indent)}VStack(alignment: .leading, spacing: 8) {
  <#if guidbase.has_child_widget(widget, "avatars")>
${""?left_pad(indent)}  HStack(spacing: 4) {
${""?left_pad(indent)}    ForEach(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "avatars"))}, id: \.self) { av in
${""?left_pad(indent)}      Image(av)
${""?left_pad(indent)}        .resizable()
${""?left_pad(indent)}        .aspectRatio(contentMode: .fill)
${""?left_pad(indent)}        .frame(width: 24, height: 24)
${""?left_pad(indent)}        .cornerRadius(12)
${""?left_pad(indent)}        .padding(.trailing, 4)
${""?left_pad(indent)}    }
${""?left_pad(indent)}  }
${""?left_pad(indent)}  .frame(maxWidth: .infinity, alignment: .leading)
${""?left_pad(indent)}  .padding(.bottom, 8)
  </#if>
  <#if guidbase.has_child_widget(widget, "primary")>
${""?left_pad(indent)}  Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))}).font(.system(size: 16)).fontWeight(.bold).foregroundColor(Color("text")).frame(maxWidth: .infinity, alignment: .leading)
  </#if>
  <#if guidbase.has_child_widget(widget, "tertiary")>
${""?left_pad(indent)}  Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "tertiary"))}).font(.system(size: 12)).foregroundColor(Color("text_light")).frame(maxWidth: .infinity, alignment: .leading).padding(.bottom, 8)
  </#if>
${""?left_pad(indent)}  HStack {
    <#if guidbase.has_child_widget(widget, "tags")>
${""?left_pad(indent)}    HStack(spacing: 4) {
${""?left_pad(indent)}      ForEach(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "tags"))}, id: \.self) { tag in
${""?left_pad(indent)}        Text(tag)
${""?left_pad(indent)}          .font(.system(size: 10))
${""?left_pad(indent)}          .foregroundColor(Color("primary"))
${""?left_pad(indent)}          .padding(.horizontal, 6)
${""?left_pad(indent)}          .padding(.vertical, 2)
${""?left_pad(indent)}          .background(Color("primary_bg"))
${""?left_pad(indent)}          .cornerRadius(4)
${""?left_pad(indent)}          .padding(.trailing, 4)
${""?left_pad(indent)}      }
${""?left_pad(indent)}    }
    </#if>
    <#if guidbase.has_child_widget(widget, "status")>
${""?left_pad(indent)}    Spacer()
${""?left_pad(indent)}    Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))}).font(.system(size: 12)).foregroundColor(Color("primary"))
    </#if>
${""?left_pad(indent)}  }
${""?left_pad(indent)}  .frame(maxWidth: .infinity)
${""?left_pad(indent)}}
${""?left_pad(indent)}.padding(12)
${""?left_pad(indent)}.background(Color("bg"))
${""?left_pad(indent)}.cornerRadius(8)
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
${""?left_pad(indent)}VStack(alignment: .leading, spacing: 8) {
  <#if guidbase.has_child_widget(widget, "status")>
${""?left_pad(indent)}  Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))}).font(.system(size: 12)).foregroundColor(Color("primary")).padding(.bottom, 8)
  </#if>
  <#if guidbase.has_child_widget(widget, "image")>
${""?left_pad(indent)}  Image(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "image"))})
${""?left_pad(indent)}    .resizable()
${""?left_pad(indent)}    .aspectRatio(contentMode: .fill)
${""?left_pad(indent)}    .frame(height: 100)
${""?left_pad(indent)}    .frame(maxWidth: .infinity)
${""?left_pad(indent)}    .cornerRadius(4)
${""?left_pad(indent)}    .padding(.bottom, 8)
  </#if>
  <#if guidbase.has_child_widget(widget, "primary")>
${""?left_pad(indent)}  Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))}).font(.system(size: 16)).fontWeight(.bold).foregroundColor(Color("text")).frame(maxWidth: .infinity, alignment: .leading)
  </#if>
  <#if guidbase.has_child_widget(widget, "secondary")>
${""?left_pad(indent)}  Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "secondary"))}).font(.system(size: 14)).foregroundColor(Color("text_muted")).frame(maxWidth: .infinity, alignment: .leading).padding(.bottom, 8)
  </#if>
  <#if guidbase.has_child_widget(widget, "tags")>
${""?left_pad(indent)}  HStack(spacing: 4) {
${""?left_pad(indent)}    ForEach(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "tags"))}, id: \.self) { tag in
${""?left_pad(indent)}      Text(tag)
${""?left_pad(indent)}        .font(.system(size: 10))
${""?left_pad(indent)}        .foregroundColor(Color("primary"))
${""?left_pad(indent)}        .padding(.horizontal, 6)
${""?left_pad(indent)}        .padding(.vertical, 2)
${""?left_pad(indent)}        .background(Color("primary_bg"))
${""?left_pad(indent)}        .cornerRadius(4)
${""?left_pad(indent)}        .padding(.trailing, 4)
${""?left_pad(indent)}    }
${""?left_pad(indent)}  }
${""?left_pad(indent)}  .frame(maxWidth: .infinity, alignment: .leading)
${""?left_pad(indent)}  .padding(.bottom, 8)
  </#if>
  <#if guidbase.has_child_widget(widget, "avatars")>
${""?left_pad(indent)}  HStack(spacing: 4) {
${""?left_pad(indent)}    ForEach(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "avatars"))}, id: \.self) { av in
${""?left_pad(indent)}      Image(av)
${""?left_pad(indent)}        .resizable()
${""?left_pad(indent)}        .aspectRatio(contentMode: .fill)
${""?left_pad(indent)}        .frame(width: 20, height: 20)
${""?left_pad(indent)}        .cornerRadius(10)
${""?left_pad(indent)}        .padding(.trailing, 4)
${""?left_pad(indent)}    }
${""?left_pad(indent)}  }
${""?left_pad(indent)}  .frame(maxWidth: .infinity, alignment: .leading)
  </#if>
${""?left_pad(indent)}}
${""?left_pad(indent)}.padding(12)
${""?left_pad(indent)}.background(Color("bg"))
${""?left_pad(indent)}.cornerRadius(8)
${""?left_pad(indent)}.frame(width: 120)
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
${""?left_pad(indent)}VStack(alignment: .leading, spacing: 8) {
${""?left_pad(indent)}  HStack {
    <#if guidbase.has_child_widget(widget, "primary")>
${""?left_pad(indent)}    Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))}).font(.system(size: 14)).fontWeight(.bold).foregroundColor(Color("text"))
    </#if>
    <#if guidbase.has_child_widget(widget, "start_time")>
${""?left_pad(indent)}    Spacer()
${""?left_pad(indent)}    Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "start_time"))}).font(.system(size: 12)).foregroundColor(Color("text_muted"))
    </#if>
${""?left_pad(indent)}  }
${""?left_pad(indent)}  .frame(maxWidth: .infinity)
${""?left_pad(indent)}  .padding(.bottom, 4)
${""?left_pad(indent)}  HStack {
    <#if guidbase.has_child_widget(widget, "secondary")>
${""?left_pad(indent)}    Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "secondary"))}).font(.system(size: 12)).foregroundColor(Color("text_muted"))
    </#if>
    <#if guidbase.has_child_widget(widget, "end_time")>
${""?left_pad(indent)}    Spacer()
${""?left_pad(indent)}    Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "end_time"))}).font(.system(size: 12)).foregroundColor(Color("text_light"))
    </#if>
${""?left_pad(indent)}  }
${""?left_pad(indent)}  .frame(maxWidth: .infinity)
${""?left_pad(indent)}  .padding(.bottom, 8)
${""?left_pad(indent)}  HStack {
    <#if guidbase.has_child_widget(widget, "avatar")>
${""?left_pad(indent)}    Image(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "avatar"))})
${""?left_pad(indent)}      .resizable()
${""?left_pad(indent)}      .aspectRatio(contentMode: .fill)
${""?left_pad(indent)}      .frame(width: 24, height: 24)
${""?left_pad(indent)}      .cornerRadius(12)
    </#if>
    <#if guidbase.has_child_widget(widget, "status")>
${""?left_pad(indent)}    Spacer()
${""?left_pad(indent)}    Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))}).font(.system(size: 12)).foregroundColor(Color("primary"))
    </#if>
${""?left_pad(indent)}  }
${""?left_pad(indent)}  .frame(maxWidth: .infinity)
${""?left_pad(indent)}}
${""?left_pad(indent)}.padding(12)
${""?left_pad(indent)}.background(Color("bg"))
${""?left_pad(indent)}.cornerRadius(8)
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
${""?left_pad(indent)}VStack(alignment: .leading, spacing: 8) {
${""?left_pad(indent)}  HStack {
    <#if guidbase.has_child_widget(widget, "status")>
${""?left_pad(indent)}    Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))}).font(.system(size: 12)).foregroundColor(Color("primary"))
    </#if>
    <#if guidbase.has_child_widget(widget, "start_time")>
${""?left_pad(indent)}    Spacer()
${""?left_pad(indent)}    Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "start_time"))}).font(.system(size: 12)).foregroundColor(Color("text_muted"))
    </#if>
${""?left_pad(indent)}  }
${""?left_pad(indent)}  .frame(maxWidth: .infinity)
${""?left_pad(indent)}  .padding(.bottom, 8)
${""?left_pad(indent)}  HStack(alignment: .top, spacing: 12) {
${""?left_pad(indent)}    VStack(alignment: .leading, spacing: 4) {
      <#if guidbase.has_child_widget(widget, "primary")>
${""?left_pad(indent)}      Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))}).font(.system(size: 14)).fontWeight(.bold).foregroundColor(Color("text"))
      </#if>
      <#if guidbase.has_child_widget(widget, "tertiary")>
${""?left_pad(indent)}      Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "tertiary"))}).font(.system(size: 12)).foregroundColor(Color("text_light"))
      </#if>
${""?left_pad(indent)}    }
${""?left_pad(indent)}    .frame(maxWidth: .infinity, alignment: .leading)
${""?left_pad(indent)}    VStack(alignment: .leading, spacing: 4) {
      <#if guidbase.has_child_widget(widget, "secondary")>
${""?left_pad(indent)}      Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "secondary"))}).font(.system(size: 12)).foregroundColor(Color("text_muted"))
      </#if>
      <#if guidbase.has_child_widget(widget, "tags")>
${""?left_pad(indent)}      HStack(spacing: 4) {
${""?left_pad(indent)}        ForEach(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "tags"))}, id: \.self) { tag in
${""?left_pad(indent)}          Text(tag)
${""?left_pad(indent)}            .font(.system(size: 10))
${""?left_pad(indent)}            .foregroundColor(Color("primary"))
${""?left_pad(indent)}            .padding(.horizontal, 6)
${""?left_pad(indent)}            .padding(.vertical, 2)
${""?left_pad(indent)}            .background(Color("primary_bg"))
${""?left_pad(indent)}            .cornerRadius(4)
${""?left_pad(indent)}            .padding(.trailing, 4)
${""?left_pad(indent)}        }
${""?left_pad(indent)}      }
      </#if>
${""?left_pad(indent)}    }
${""?left_pad(indent)}    .frame(maxWidth: .infinity, alignment: .leading)
${""?left_pad(indent)}  }
${""?left_pad(indent)}  .frame(maxWidth: .infinity)
${""?left_pad(indent)}  .padding(.bottom, 8)
  <#if guidbase.has_child_widget(widget, "avatars")>
${""?left_pad(indent)}  HStack(spacing: 4) {
${""?left_pad(indent)}    ForEach(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "avatars"))}, id: \.self) { av in
${""?left_pad(indent)}      Image(av)
${""?left_pad(indent)}        .resizable()
${""?left_pad(indent)}        .aspectRatio(contentMode: .fill)
${""?left_pad(indent)}        .frame(width: 20, height: 20)
${""?left_pad(indent)}        .cornerRadius(10)
${""?left_pad(indent)}        .padding(.trailing, 4)
${""?left_pad(indent)}    }
${""?left_pad(indent)}  }
${""?left_pad(indent)}  .frame(maxWidth: .infinity, alignment: .leading)
  </#if>
${""?left_pad(indent)}}
${""?left_pad(indent)}.padding(12)
${""?left_pad(indent)}.background(Color("bg"))
${""?left_pad(indent)}.cornerRadius(8)
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
${""?left_pad(indent)}VStack(alignment: .leading, spacing: 8) {
${""?left_pad(indent)}  HStack(alignment: .top, spacing: 12) {
    <#if guidbase.has_child_widget(widget, "image")>
${""?left_pad(indent)}    Image(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "image"))})
${""?left_pad(indent)}      .resizable()
${""?left_pad(indent)}      .aspectRatio(contentMode: .fill)
${""?left_pad(indent)}      .frame(width: 60, height: 60)
${""?left_pad(indent)}      .cornerRadius(4)
    </#if>
${""?left_pad(indent)}    VStack(alignment: .leading, spacing: 4) {
      <#if guidbase.has_child_widget(widget, "primary")>
${""?left_pad(indent)}      Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))}).font(.system(size: 16)).fontWeight(.bold).foregroundColor(Color("text"))
      </#if>
      <#if guidbase.has_child_widget(widget, "secondary")>
${""?left_pad(indent)}      Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "secondary"))}).font(.system(size: 12)).foregroundColor(Color("text_muted"))
      </#if>
      <#if guidbase.has_child_widget(widget, "start_time") || guidbase.has_child_widget(widget, "end_time")>
${""?left_pad(indent)}      HStack(spacing: 6) {
        <#if guidbase.has_child_widget(widget, "start_time")>${""?left_pad(indent)}        Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "start_time"))}).font(.system(size: 10)).foregroundColor(Color("text_light"))</#if>
${""?left_pad(indent)}        Rectangle().frame(height: 2).foregroundColor(Color("border_light"))
        <#if guidbase.has_child_widget(widget, "end_time")>${""?left_pad(indent)}        Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "end_time"))}).font(.system(size: 10)).foregroundColor(Color("text_light"))</#if>
${""?left_pad(indent)}      }
${""?left_pad(indent)}      .frame(maxWidth: .infinity)
      </#if>
${""?left_pad(indent)}    }
${""?left_pad(indent)}  }
${""?left_pad(indent)}  .frame(maxWidth: .infinity, alignment: .leading)
${""?left_pad(indent)}  .padding(.bottom, 8)
${""?left_pad(indent)}  HStack {
    <#if guidbase.has_child_widget(widget, "avatar")>
${""?left_pad(indent)}    Image(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "avatar"))})
${""?left_pad(indent)}      .resizable()
${""?left_pad(indent)}      .aspectRatio(contentMode: .fill)
${""?left_pad(indent)}      .frame(width: 24, height: 24)
${""?left_pad(indent)}      .cornerRadius(12)
    </#if>
    <#if guidbase.has_child_widget(widget, "status")>
${""?left_pad(indent)}    Spacer()
${""?left_pad(indent)}    Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))}).font(.system(size: 12)).foregroundColor(Color("primary"))
    </#if>
${""?left_pad(indent)}  }
${""?left_pad(indent)}  .frame(maxWidth: .infinity)
${""?left_pad(indent)}}
${""?left_pad(indent)}.padding(12)
${""?left_pad(indent)}.background(Color("bg"))
${""?left_pad(indent)}.cornerRadius(8)
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
${""?left_pad(indent)}VStack(alignment: .leading, spacing: 8) {
${""?left_pad(indent)}  HStack {
    <#if guidbase.has_child_widget(widget, "start_time")>
${""?left_pad(indent)}    Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "start_time"))}).font(.system(size: 12)).foregroundColor(Color("text_muted"))
    </#if>
    <#if guidbase.has_child_widget(widget, "status")>
${""?left_pad(indent)}    Spacer()
${""?left_pad(indent)}    Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))}).font(.system(size: 12)).foregroundColor(Color("primary"))
    </#if>
${""?left_pad(indent)}  }
${""?left_pad(indent)}  .frame(maxWidth: .infinity)
${""?left_pad(indent)}  .padding(.bottom, 8)
  <#if guidbase.has_child_widget(widget, "primary")>
${""?left_pad(indent)}  Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))}).font(.system(size: 16)).fontWeight(.bold).foregroundColor(Color("text")).frame(maxWidth: .infinity, alignment: .leading).padding(.bottom, 4)
  </#if>
  <#if guidbase.has_child_widget(widget, "secondary")>
${""?left_pad(indent)}  Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "secondary"))}).font(.system(size: 14)).foregroundColor(Color("text_muted")).frame(maxWidth: .infinity, alignment: .leading).padding(.bottom, 8)
  </#if>
  <#if guidbase.has_child_widget(widget, "avatar")>
${""?left_pad(indent)}  Image(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "avatar"))})
${""?left_pad(indent)}    .resizable()
${""?left_pad(indent)}    .aspectRatio(contentMode: .fill)
${""?left_pad(indent)}    .frame(width: 24, height: 24)
${""?left_pad(indent)}    .cornerRadius(12)
${""?left_pad(indent)}    .padding(.top, 4)
  </#if>
${""?left_pad(indent)}}
${""?left_pad(indent)}.padding(12)
${""?left_pad(indent)}.background(Color("bg"))
${""?left_pad(indent)}.cornerRadius(8)
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
${""?left_pad(indent)}VStack(alignment: .leading, spacing: 8) {
${""?left_pad(indent)}  HStack {
    <#if guidbase.has_child_widget(widget, "start_time") || guidbase.has_child_widget(widget, "end_time")>
${""?left_pad(indent)}    HStack(spacing: 4) {
      <#if guidbase.has_child_widget(widget, "start_time")>${""?left_pad(indent)}      Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "start_time"))}).font(.system(size: 12)).foregroundColor(Color("text_muted"))</#if>
      <#if guidbase.has_child_widget(widget, "start_time") && guidbase.has_child_widget(widget, "end_time")>${""?left_pad(indent)}      Text(" - ").font(.system(size: 12)).foregroundColor(Color("text_muted"))</#if>
      <#if guidbase.has_child_widget(widget, "end_time")>${""?left_pad(indent)}      Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "end_time"))}).font(.system(size: 12)).foregroundColor(Color("text_muted"))</#if>
${""?left_pad(indent)}    }
    </#if>
    <#if guidbase.has_child_widget(widget, "status")>
${""?left_pad(indent)}    Spacer()
${""?left_pad(indent)}    Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))}).font(.system(size: 12)).foregroundColor(Color("primary"))
    </#if>
${""?left_pad(indent)}  }
${""?left_pad(indent)}  .frame(maxWidth: .infinity)
${""?left_pad(indent)}  .padding(.bottom, 8)
  <#if guidbase.has_child_widget(widget, "primary")>
${""?left_pad(indent)}  Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))}).font(.system(size: 16)).fontWeight(.bold).foregroundColor(Color("text")).frame(maxWidth: .infinity, alignment: .leading).padding(.bottom, 8)
  </#if>
  <#if guidbase.has_child_widget(widget, "avatars")>
${""?left_pad(indent)}  HStack(spacing: 4) {
${""?left_pad(indent)}    ForEach(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "avatars"))}, id: \.self) { av in
${""?left_pad(indent)}      Image(av)
${""?left_pad(indent)}        .resizable()
${""?left_pad(indent)}        .aspectRatio(contentMode: .fill)
${""?left_pad(indent)}        .frame(width: 20, height: 20)
${""?left_pad(indent)}        .cornerRadius(10)
${""?left_pad(indent)}        .padding(.trailing, 4)
${""?left_pad(indent)}    }
${""?left_pad(indent)}  }
${""?left_pad(indent)}  .frame(maxWidth: .infinity, alignment: .leading)
  </#if>
${""?left_pad(indent)}}
${""?left_pad(indent)}.padding(12)
${""?left_pad(indent)}.background(Color("bg"))
${""?left_pad(indent)}.cornerRadius(8)
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
${""?left_pad(indent)}VStack(alignment: .leading, spacing: 8) {
  <#if guidbase.has_child_widget(widget, "start_time")>
${""?left_pad(indent)}  Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "start_time"))}).font(.system(size: 12)).foregroundColor(Color("text_muted")).frame(maxWidth: .infinity, alignment: .leading).padding(.bottom, 8)
  </#if>
${""?left_pad(indent)}  HStack(alignment: .top, spacing: 12) {
    <#if guidbase.has_child_widget(widget, "image")>
${""?left_pad(indent)}    Image(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "image"))})
${""?left_pad(indent)}      .resizable()
${""?left_pad(indent)}      .aspectRatio(contentMode: .fill)
${""?left_pad(indent)}      .frame(width: 60, height: 60)
${""?left_pad(indent)}      .cornerRadius(4)
    </#if>
${""?left_pad(indent)}    VStack(alignment: .leading, spacing: 4) {
      <#if guidbase.has_child_widget(widget, "primary")>
${""?left_pad(indent)}      Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))}).font(.system(size: 14)).fontWeight(.bold).foregroundColor(Color("text"))
      </#if>
      <#if guidbase.has_child_widget(widget, "secondary")>
${""?left_pad(indent)}      Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "secondary"))}).font(.system(size: 12)).foregroundColor(Color("text_muted"))
      </#if>
      <#if guidbase.has_child_widget(widget, "tags")>
${""?left_pad(indent)}      HStack(spacing: 4) {
${""?left_pad(indent)}        ForEach(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "tags"))}, id: \.self) { tag in
${""?left_pad(indent)}          Text(tag)
${""?left_pad(indent)}            .font(.system(size: 10))
${""?left_pad(indent)}            .foregroundColor(Color("primary"))
${""?left_pad(indent)}            .padding(.horizontal, 6)
${""?left_pad(indent)}            .padding(.vertical, 2)
${""?left_pad(indent)}            .background(Color("primary_bg"))
${""?left_pad(indent)}            .cornerRadius(4)
${""?left_pad(indent)}            .padding(.trailing, 4)
${""?left_pad(indent)}        }
${""?left_pad(indent)}      }
      </#if>
${""?left_pad(indent)}    }
${""?left_pad(indent)}    .frame(maxWidth: .infinity, alignment: .leading)
${""?left_pad(indent)}  }
${""?left_pad(indent)}  .frame(maxWidth: .infinity)
${""?left_pad(indent)}}
${""?left_pad(indent)}.padding(12)
${""?left_pad(indent)}.background(Color("bg"))
${""?left_pad(indent)}.cornerRadius(8)
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
${""?left_pad(indent)}VStack(alignment: .leading, spacing: 8) {
${""?left_pad(indent)}  HStack {
    <#if guidbase.has_child_widget(widget, "start_time")>
${""?left_pad(indent)}    Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "start_time"))}).font(.system(size: 12)).foregroundColor(Color("text_muted"))
    </#if>
    <#if guidbase.has_child_widget(widget, "status")>
${""?left_pad(indent)}    Spacer()
${""?left_pad(indent)}    Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))}).font(.system(size: 12)).foregroundColor(Color("primary"))
    </#if>
${""?left_pad(indent)}  }
${""?left_pad(indent)}  .frame(maxWidth: .infinity)
${""?left_pad(indent)}  .padding(.bottom, 8)
  <#if guidbase.has_child_widget(widget, "primary")>
${""?left_pad(indent)}  Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))}).font(.system(size: 16)).fontWeight(.bold).foregroundColor(Color("text")).frame(maxWidth: .infinity, alignment: .leading).padding(.bottom, 8)
  </#if>
${""?left_pad(indent)}  HStack(alignment: .center, spacing: 8) {
    <#if guidbase.has_child_widget(widget, "avatar")>
${""?left_pad(indent)}    Image(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "avatar"))})
${""?left_pad(indent)}      .resizable()
${""?left_pad(indent)}      .aspectRatio(contentMode: .fill)
${""?left_pad(indent)}      .frame(width: 24, height: 24)
${""?left_pad(indent)}      .cornerRadius(12)
    </#if>
    <#if guidbase.has_child_widget(widget, "secondary")>
${""?left_pad(indent)}    Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "secondary"))}).font(.system(size: 12)).foregroundColor(Color("text_muted"))
    </#if>
${""?left_pad(indent)}  }
${""?left_pad(indent)}  .frame(maxWidth: .infinity, alignment: .leading)
${""?left_pad(indent)}}
${""?left_pad(indent)}.padding(12)
${""?left_pad(indent)}.background(Color("bg"))
${""?left_pad(indent)}.cornerRadius(8)
</#macro>

<#--
极简时间单元 (Compact Time Tile)
+-----------------------------------------------+
| [start time]  |  [status]  |  [primary]       |
| [tags]                                        |
+-----------------------------------------------+
-->
<#macro print_tile_compact_time widget indent=0>
${""?left_pad(indent)}VStack(alignment: .leading, spacing: 6) {
${""?left_pad(indent)}  HStack(spacing: 4) {
    <#if guidbase.has_child_widget(widget, "start_time")>
${""?left_pad(indent)}    Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "start_time"))}).font(.system(size: 12)).foregroundColor(Color("text_muted"))
${""?left_pad(indent)}    Text(" | ").font(.system(size: 12)).foregroundColor(Color("border_light"))
    </#if>
    <#if guidbase.has_child_widget(widget, "status")>
${""?left_pad(indent)}    Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))}).font(.system(size: 12)).foregroundColor(Color("primary"))
${""?left_pad(indent)}    Text(" | ").font(.system(size: 12)).foregroundColor(Color("border_light"))
    </#if>
    <#if guidbase.has_child_widget(widget, "primary")>
${""?left_pad(indent)}    Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))}).font(.system(size: 14)).fontWeight(.medium).foregroundColor(Color("text"))
    </#if>
${""?left_pad(indent)}  }
${""?left_pad(indent)}  .frame(maxWidth: .infinity, alignment: .leading)
${""?left_pad(indent)}  .padding(.bottom, 4)
  <#if guidbase.has_child_widget(widget, "tags")>
${""?left_pad(indent)}  HStack(spacing: 4) {
${""?left_pad(indent)}    ForEach(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "tags"))}, id: \.self) { tag in
${""?left_pad(indent)}      Text(tag)
${""?left_pad(indent)}        .font(.system(size: 10))
${""?left_pad(indent)}        .foregroundColor(Color("primary"))
${""?left_pad(indent)}        .padding(.horizontal, 6)
${""?left_pad(indent)}        .padding(.vertical, 2)
${""?left_pad(indent)}        .background(Color("primary_bg"))
${""?left_pad(indent)}        .cornerRadius(4)
${""?left_pad(indent)}        .padding(.trailing, 4)
${""?left_pad(indent)}    }
${""?left_pad(indent)}  }
${""?left_pad(indent)}  .frame(maxWidth: .infinity)
  </#if>
${""?left_pad(indent)}}
${""?left_pad(indent)}.padding(12)
${""?left_pad(indent)}.background(Color("bg"))
${""?left_pad(indent)}.cornerRadius(8)
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
${""?left_pad(indent)}VStack(alignment: .leading, spacing: 4) {
  <#if guidbase.has_child_widget(widget, "start_time")>
${""?left_pad(indent)}  Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "start_time"))}).font(.system(size: 12)).foregroundColor(Color("text_muted")).padding(.bottom, 6)
  </#if>
  <#if guidbase.has_child_widget(widget, "primary")>
${""?left_pad(indent)}  Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))}).font(.system(size: 14)).fontWeight(.bold).foregroundColor(Color("text")).padding(.bottom, 4)
  </#if>
  <#if guidbase.has_child_widget(widget, "status")>
${""?left_pad(indent)}  Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))}).font(.system(size: 12)).foregroundColor(Color("primary"))
  </#if>
${""?left_pad(indent)}}
${""?left_pad(indent)}.padding(8)
${""?left_pad(indent)}.background(Color("bg"))
${""?left_pad(indent)}.cornerRadius(4)
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
${""?left_pad(indent)}VStack(alignment: .leading, spacing: 6) {
${""?left_pad(indent)}  HStack {
    <#if guidbase.has_child_widget(widget, "start_time")>
${""?left_pad(indent)}    Spacer()
${""?left_pad(indent)}    Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "start_time"))}).font(.system(size: 12)).foregroundColor(Color("text_muted"))
    </#if>
${""?left_pad(indent)}  }
${""?left_pad(indent)}  .frame(maxWidth: .infinity)
${""?left_pad(indent)}  .padding(.bottom, 6)
  <#if guidbase.has_child_widget(widget, "primary")>
${""?left_pad(indent)}  Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))}).font(.system(size: 14)).fontWeight(.medium).foregroundColor(Color("text")).padding(.bottom, 6).frame(maxWidth: .infinity, alignment: .leading)
  </#if>
  <#if guidbase.has_child_widget(widget, "tags")>
${""?left_pad(indent)}  HStack(spacing: 4) {
${""?left_pad(indent)}    ForEach(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "tags"))}, id: \.self) { tag in
${""?left_pad(indent)}      Text(tag)
${""?left_pad(indent)}        .font(.system(size: 10))
${""?left_pad(indent)}        .foregroundColor(Color("primary"))
${""?left_pad(indent)}        .padding(.horizontal, 6)
${""?left_pad(indent)}        .padding(.vertical, 2)
${""?left_pad(indent)}        .background(Color("primary_bg"))
${""?left_pad(indent)}        .cornerRadius(4)
${""?left_pad(indent)}        .padding(.trailing, 4)
${""?left_pad(indent)}    }
${""?left_pad(indent)}  }
${""?left_pad(indent)}  .frame(maxWidth: .infinity)
  </#if>
${""?left_pad(indent)}}
${""?left_pad(indent)}.padding(8)
${""?left_pad(indent)}.background(Color("bg"))
${""?left_pad(indent)}.cornerRadius(4)
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
${""?left_pad(indent)}VStack(alignment: .leading, spacing: 6) {
${""?left_pad(indent)}  HStack {
    <#if guidbase.has_child_widget(widget, "start_time")>
${""?left_pad(indent)}    Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "start_time"))}).font(.system(size: 12)).foregroundColor(Color("text_muted"))
${""?left_pad(indent)}    Spacer()
    </#if>
${""?left_pad(indent)}  }
${""?left_pad(indent)}  .frame(maxWidth: .infinity)
${""?left_pad(indent)}  .padding(.bottom, 6)
  <#if guidbase.has_child_widget(widget, "primary")>
${""?left_pad(indent)}  Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))})
${""?left_pad(indent)}    .font(.system(size: 14))
${""?left_pad(indent)}    .fontWeight(.medium)
${""?left_pad(indent)}    .multilineTextAlignment(.trailing)
${""?left_pad(indent)}    .padding(.bottom, 6)
${""?left_pad(indent)}    .frame(maxWidth: .infinity, alignment: .trailing)
  </#if>
  <#if guidbase.has_child_widget(widget, "tags")>
${""?left_pad(indent)}  HStack {
${""?left_pad(indent)}    Spacer()
${""?left_pad(indent)}    HStack(spacing: 4) {
${""?left_pad(indent)}      ForEach(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "tags"))}, id: \.self) { tag in
${""?left_pad(indent)}        Text(tag)
${""?left_pad(indent)}          .font(.system(size: 10))
${""?left_pad(indent)}          .foregroundColor(Color("primary"))
${""?left_pad(indent)}          .padding(.horizontal, 6)
${""?left_pad(indent)}          .padding(.vertical, 2)
${""?left_pad(indent)}          .background(Color("primary_bg"))
${""?left_pad(indent)}          .cornerRadius(4)
${""?left_pad(indent)}          .padding(.leading, 4)
${""?left_pad(indent)}      }
${""?left_pad(indent)}    }
${""?left_pad(indent)}  }
${""?left_pad(indent)}  .frame(maxWidth: .infinity)
  </#if>
${""?left_pad(indent)}}
${""?left_pad(indent)}.padding(8)
${""?left_pad(indent)}.background(Color("bg"))
${""?left_pad(indent)}.cornerRadius(4)
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
${""?left_pad(indent)}VStack(alignment: .leading, spacing: 4) {
  <#if guidbase.has_child_widget(widget, "start_time")>
${""?left_pad(indent)}  Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "start_time"))}).font(.system(size: 12)).foregroundColor(Color("text_light")).padding(.bottom, 2).frame(maxWidth: .infinity, alignment: .leading)
  </#if>
  <#if guidbase.has_child_widget(widget, "primary")>
${""?left_pad(indent)}  Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))}).font(.system(size: 16)).fontWeight(.bold).foregroundColor(Color("text")).frame(maxWidth: .infinity, alignment: .leading).padding(.bottom, 4)
  </#if>
${""?left_pad(indent)}  Text("│")
${""?left_pad(indent)}    .padding(.leading, 8)
${""?left_pad(indent)}    .padding(.bottom, 4)
  <#if guidbase.has_child_widget(widget, "end_time")>
${""?left_pad(indent)}  Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "end_time"))}).font(.system(size: 12)).foregroundColor(Color("text_light")).padding(.bottom, 2).frame(maxWidth: .infinity, alignment: .leading)
  </#if>
${""?left_pad(indent)}  HStack {
  <#if guidbase.has_child_widget(widget, "secondary")>
${""?left_pad(indent)}    Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "secondary"))}).font(.system(size: 14)).foregroundColor(Color("text_muted"))
  </#if>
  <#if guidbase.has_child_widget(widget, "status")>
${""?left_pad(indent)}    Spacer()
${""?left_pad(indent)}    Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))}).font(.system(size: 12)).foregroundColor(Color("primary"))
  </#if>
${""?left_pad(indent)}  }
${""?left_pad(indent)}  .frame(maxWidth: .infinity)
${""?left_pad(indent)}}
${""?left_pad(indent)}.padding(12)
${""?left_pad(indent)}.background(Color("bg"))
${""?left_pad(indent)}.cornerRadius(8)
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
${""?left_pad(indent)}VStack(alignment: .leading, spacing: 8) {
${""?left_pad(indent)}  HStack(spacing: 4) {
  <#if guidbase.has_child_widget(widget, "start_time")>
${""?left_pad(indent)}    Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "start_time"))}).font(.system(size: 12)).foregroundColor(Color("text_muted"))
${""?left_pad(indent)}    Text(" >> ").font(.system(size: 12)).foregroundColor(Color("text_light"))
  </#if>
  <#if guidbase.has_child_widget(widget, "tags")>
${""?left_pad(indent)}    HStack(spacing: 4) {
${""?left_pad(indent)}      ForEach(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "tags"))}, id: \.self) { tag in
${""?left_pad(indent)}        Text(tag)
${""?left_pad(indent)}          .font(.system(size: 10))
${""?left_pad(indent)}          .foregroundColor(Color("primary"))
${""?left_pad(indent)}          .padding(.horizontal, 6)
${""?left_pad(indent)}          .padding(.vertical, 2)
${""?left_pad(indent)}          .background(Color("primary_bg"))
${""?left_pad(indent)}          .cornerRadius(4)
${""?left_pad(indent)}          .padding(.trailing, 4)
${""?left_pad(indent)}      }
${""?left_pad(indent)}    }
${""?left_pad(indent)}    Text(" >> ").font(.system(size: 12)).foregroundColor(Color("text_light"))
  </#if>
  <#if guidbase.has_child_widget(widget, "end_time")>
${""?left_pad(indent)}    Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "end_time"))}).font(.system(size: 12)).foregroundColor(Color("text_muted"))
  </#if>
${""?left_pad(indent)}  }
${""?left_pad(indent)}  .frame(maxWidth: .infinity, alignment: .leading)
${""?left_pad(indent)}  .padding(.bottom, 8)
${""?left_pad(indent)}  HStack(spacing: 4) {
  <#if guidbase.has_child_widget(widget, "primary")>
${""?left_pad(indent)}    Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))}).font(.system(size: 14)).fontWeight(.bold).foregroundColor(Color("text"))
${""?left_pad(indent)}    Text(" >> ").font(.system(size: 12)).foregroundColor(Color("text_light"))
  </#if>
  <#if guidbase.has_child_widget(widget, "secondary")>
${""?left_pad(indent)}    Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "secondary"))}).font(.system(size: 12)).foregroundColor(Color("text_muted"))
${""?left_pad(indent)}    Text(" >> ").font(.system(size: 12)).foregroundColor(Color("text_light"))
  </#if>
  <#if guidbase.has_child_widget(widget, "status")>
${""?left_pad(indent)}    Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))}).font(.system(size: 12)).foregroundColor(Color("primary"))
  </#if>
${""?left_pad(indent)}  }
${""?left_pad(indent)}  .frame(maxWidth: .infinity, alignment: .leading)
${""?left_pad(indent)}}
${""?left_pad(indent)}.padding(12)
${""?left_pad(indent)}.background(Color("bg"))
${""?left_pad(indent)}.cornerRadius(8)
</#macro>

<#--
行式日志 (Horizontal Log)
+-----------------------------------------------+
| [avatar] | [start time] | [primary] | [status] |
+-----------------------------------------------+
-->
<#macro print_tile_horizontal_log widget indent=0>
${""?left_pad(indent)}HStack(alignment: .center, spacing: 4) {
  <#if guidbase.has_child_widget(widget, "avatar")>
${""?left_pad(indent)}  Image(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "avatar"))})
${""?left_pad(indent)}    .resizable()
${""?left_pad(indent)}    .aspectRatio(contentMode: .fill)
${""?left_pad(indent)}    .frame(width: 24, height: 24)
${""?left_pad(indent)}    .cornerRadius(12)
${""?left_pad(indent)}  Text(" | ").font(.system(size: 12)).foregroundColor(Color("border_light"))
  </#if>
  <#if guidbase.has_child_widget(widget, "start_time")>
${""?left_pad(indent)}  Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "start_time"))}).font(.system(size: 12)).foregroundColor(Color("text_muted"))
${""?left_pad(indent)}  Text(" | ").font(.system(size: 12)).foregroundColor(Color("border_light"))
  </#if>
  <#if guidbase.has_child_widget(widget, "primary")>
${""?left_pad(indent)}  Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))}).font(.system(size: 14)).fontWeight(.medium).foregroundColor(Color("text"))
${""?left_pad(indent)}  Text(" | ").font(.system(size: 12)).foregroundColor(Color("border_light"))
  </#if>
  <#if guidbase.has_child_widget(widget, "status")>
${""?left_pad(indent)}  Spacer()
${""?left_pad(indent)}  Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))}).font(.system(size: 12)).foregroundColor(Color("primary"))
  </#if>
${""?left_pad(indent)}}
${""?left_pad(indent)}.frame(maxWidth: .infinity)
${""?left_pad(indent)}.padding(.vertical, 8)
${""?left_pad(indent)}.padding(.horizontal, 12)
${""?left_pad(indent)}.background(Color("bg"))
${""?left_pad(indent)}.cornerRadius(6)
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
${""?left_pad(indent)}VStack(alignment: .leading, spacing: 8) {
  <#if guidbase.has_child_widget(widget, "tags")>
${""?left_pad(indent)}  HStack(spacing: 4) {
${""?left_pad(indent)}    ForEach(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "tags"))}, id: \.self) { tag in
${""?left_pad(indent)}      Text(tag)
${""?left_pad(indent)}        .font(.system(size: 10))
${""?left_pad(indent)}        .foregroundColor(Color("primary"))
${""?left_pad(indent)}        .padding(.horizontal, 6)
${""?left_pad(indent)}        .padding(.vertical, 2)
${""?left_pad(indent)}        .background(Color("primary_bg"))
${""?left_pad(indent)}        .cornerRadius(4)
${""?left_pad(indent)}        .padding(.trailing, 4)
${""?left_pad(indent)}    }
${""?left_pad(indent)}  }
${""?left_pad(indent)}  .frame(maxWidth: .infinity, alignment: .leading)
${""?left_pad(indent)}  .padding(.bottom, 8)
  </#if>
  <#if guidbase.has_child_widget(widget, "primary")>
${""?left_pad(indent)}  Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))}).font(.system(size: 16)).fontWeight(.bold).foregroundColor(Color("text")).frame(maxWidth: .infinity, alignment: .leading).padding(.bottom, 4)
  </#if>
  <#if guidbase.has_child_widget(widget, "tertiary")>
${""?left_pad(indent)}  Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "tertiary"))}).font(.system(size: 12)).foregroundColor(Color("text_light")).frame(maxWidth: .infinity, alignment: .leading).padding(.bottom, 8)
  </#if>
${""?left_pad(indent)}  HStack {
  <#if guidbase.has_child_widget(widget, "avatars")>
${""?left_pad(indent)}    HStack(spacing: 4) {
${""?left_pad(indent)}      ForEach(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "avatars"))}, id: \.self) { av in
${""?left_pad(indent)}        Image(av)
${""?left_pad(indent)}          .resizable()
${""?left_pad(indent)}          .aspectRatio(contentMode: .fill)
${""?left_pad(indent)}          .frame(width: 20, height: 20)
${""?left_pad(indent)}          .cornerRadius(10)
${""?left_pad(indent)}          .padding(.trailing, 4)
${""?left_pad(indent)}      }
${""?left_pad(indent)}    }
  </#if>
  <#if guidbase.has_child_widget(widget, "start_time")>
${""?left_pad(indent)}    Spacer()
${""?left_pad(indent)}    Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "start_time"))}).font(.system(size: 12)).foregroundColor(Color("text_muted"))
  </#if>
${""?left_pad(indent)}  }
${""?left_pad(indent)}  .frame(maxWidth: .infinity)
${""?left_pad(indent)}}
${""?left_pad(indent)}.padding(12)
${""?left_pad(indent)}.background(Color("bg"))
${""?left_pad(indent)}.cornerRadius(8)
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
${""?left_pad(indent)}ZStack(alignment: .bottomLeading) {
  <#if guidbase.has_child_widget(widget, "background")>
${""?left_pad(indent)}  Image(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "background"))})
${""?left_pad(indent)}    .resizable()
${""?left_pad(indent)}    .aspectRatio(contentMode: .fill)
${""?left_pad(indent)}    .frame(height: 150)
${""?left_pad(indent)}    .frame(maxWidth: .infinity)
  </#if>
${""?left_pad(indent)}  VStack(alignment: .leading, spacing: 6) {
    <#if guidbase.has_child_widget(widget, "start_time")>
${""?left_pad(indent)}    Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "start_time"))})
${""?left_pad(indent)}      .font(.system(size: 12))
${""?left_pad(indent)}      .foregroundColor(Color("border_light"))
${""?left_pad(indent)}      .multilineTextAlignment(.trailing)
${""?left_pad(indent)}      .frame(maxWidth: .infinity, alignment: .trailing)
${""?left_pad(indent)}      .padding(.bottom, 4)
    </#if>
    <#if guidbase.has_child_widget(widget, "primary")>
${""?left_pad(indent)}    Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))}).font(.system(size: 16)).fontWeight(.bold).foregroundColor(Color("bg")).padding(.bottom, 4)
    </#if>
    <#if guidbase.has_child_widget(widget, "status")>
${""?left_pad(indent)}    Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))})
${""?left_pad(indent)}      .font(.system(size: 12))
${""?left_pad(indent)}      .foregroundColor(Color("primary"))
${""?left_pad(indent)}      .padding(.horizontal, 6)
${""?left_pad(indent)}      .padding(.vertical, 2)
${""?left_pad(indent)}      .background(Color("bg"))
${""?left_pad(indent)}      .cornerRadius(4)
    </#if>
${""?left_pad(indent)}  }
${""?left_pad(indent)}  .padding(12)
${""?left_pad(indent)}  .frame(maxWidth: .infinity, alignment: .leading)
${""?left_pad(indent)}}
${""?left_pad(indent)}.cornerRadius(8)
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
${""?left_pad(indent)}HStack(alignment: .center, spacing: 12) {
  <#if guidbase.has_child_widget(widget, "avatar")>
${""?left_pad(indent)}  Image(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "avatar"))})
${""?left_pad(indent)}    .resizable()
${""?left_pad(indent)}    .aspectRatio(contentMode: .fill)
${""?left_pad(indent)}    .frame(width: 32, height: 32)
${""?left_pad(indent)}    .cornerRadius(16)
  </#if>
${""?left_pad(indent)}  VStack(alignment: .leading, spacing: 4) {
${""?left_pad(indent)}    HStack {
        <#if guidbase.has_child_widget(widget, "primary")>
${""?left_pad(indent)}      Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))}).font(.system(size: 14)).fontWeight(.bold).foregroundColor(Color("text"))
        </#if>
        <#if guidbase.has_child_widget(widget, "start_time")>
${""?left_pad(indent)}      Spacer()
${""?left_pad(indent)}      Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "start_time"))}).font(.system(size: 12)).foregroundColor(Color("text_light"))
        </#if>
${""?left_pad(indent)}    }
${""?left_pad(indent)}    .frame(maxWidth: .infinity)
    <#if guidbase.has_child_widget(widget, "secondary")>
${""?left_pad(indent)}    Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "secondary"))}).font(.system(size: 12)).foregroundColor(Color("text_muted"))
    </#if>
${""?left_pad(indent)}  }
${""?left_pad(indent)}}
${""?left_pad(indent)}.frame(maxWidth: .infinity)
${""?left_pad(indent)}.padding(12)
${""?left_pad(indent)}.background(Color("bg"))
${""?left_pad(indent)}.cornerRadius(8)
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
${""?left_pad(indent)}VStack(alignment: .leading, spacing: 8) {
  <#if guidbase.has_child_widget(widget, "start_time")>
${""?left_pad(indent)}  Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "start_time"))}).font(.system(size: 12)).foregroundColor(Color("text_muted")).frame(maxWidth: .infinity, alignment: .leading).padding(.bottom, 8)
  </#if>
${""?left_pad(indent)}  HStack(alignment: .center, spacing: 12) {
${""?left_pad(indent)}    VStack(alignment: .leading, spacing: 4) {
        <#if guidbase.has_child_widget(widget, "primary")>
${""?left_pad(indent)}      Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))}).font(.system(size: 16)).fontWeight(.bold).foregroundColor(Color("text"))
        </#if>
        <#if guidbase.has_child_widget(widget, "secondary")>
${""?left_pad(indent)}      Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "secondary"))}).font(.system(size: 14)).foregroundColor(Color("text_muted"))
        </#if>
${""?left_pad(indent)}    }
${""?left_pad(indent)}    .frame(maxWidth: .infinity, alignment: .leading)
${""?left_pad(indent)}    Spacer()
${""?left_pad(indent)}    HStack {
        <#if guidbase.has_child_widget(widget, "image")>
${""?left_pad(indent)}      Image(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "image"))})
${""?left_pad(indent)}        .resizable()
${""?left_pad(indent)}        .aspectRatio(contentMode: .fill)
${""?left_pad(indent)}        .frame(width: 60, height: 60)
${""?left_pad(indent)}        .cornerRadius(4)
        </#if>
${""?left_pad(indent)}    }
${""?left_pad(indent)}  }
${""?left_pad(indent)}  .frame(maxWidth: .infinity)
${""?left_pad(indent)}  .padding(.bottom, 8)
  <#if guidbase.has_child_widget(widget, "status")>
${""?left_pad(indent)}  HStack {
${""?left_pad(indent)}    Spacer()
${""?left_pad(indent)}    Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))}).font(.system(size: 12)).foregroundColor(Color("primary"))
${""?left_pad(indent)}  }
${""?left_pad(indent)}  .frame(maxWidth: .infinity)
  </#if>
${""?left_pad(indent)}}
${""?left_pad(indent)}.padding(12)
${""?left_pad(indent)}.background(Color("bg"))
${""?left_pad(indent)}.cornerRadius(8)
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
${""?left_pad(indent)}VStack(alignment: .leading, spacing: 8) {
${""?left_pad(indent)}  HStack {
  <#if guidbase.has_child_widget(widget, "tags")>
${""?left_pad(indent)}    HStack(spacing: 4) {
${""?left_pad(indent)}      ForEach(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "tags"))}, id: \.self) { tag in
${""?left_pad(indent)}        Text(tag)
${""?left_pad(indent)}          .font(.system(size: 10))
${""?left_pad(indent)}          .foregroundColor(Color("primary"))
${""?left_pad(indent)}          .padding(.horizontal, 6)
${""?left_pad(indent)}          .padding(.vertical, 2)
${""?left_pad(indent)}          .background(Color("primary_bg"))
${""?left_pad(indent)}          .cornerRadius(4)
${""?left_pad(indent)}          .padding(.trailing, 4)
${""?left_pad(indent)}      }
${""?left_pad(indent)}    }
  </#if>
  <#if guidbase.has_child_widget(widget, "end_time")>
${""?left_pad(indent)}    Spacer()
${""?left_pad(indent)}    Text(
<#if guidbase.has_child_widget(widget, "end_time")>
${""?left_pad(indent)}    Spacer()
${""?left_pad(indent)}    Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "end_time"))}).font(.system(size: 12)).foregroundColor(Color("text_muted"))
    </#if>
${""?left_pad(indent)}  }
${""?left_pad(indent)}  .frame(maxWidth: .infinity)
${""?left_pad(indent)}  .padding(.bottom, 8)
  <#if guidbase.has_child_widget(widget, "primary")>
${""?left_pad(indent)}  Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))}).font(.system(size: 16)).fontWeight(.bold).foregroundColor(Color("text")).frame(maxWidth: .infinity, alignment: .leading).padding(.bottom, 8)
  </#if>
${""?left_pad(indent)}  HStack {
  <#if guidbase.has_child_widget(widget, "avatars")>
${""?left_pad(indent)}    HStack(spacing: 4) {
${""?left_pad(indent)}      ForEach(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "avatars"))}, id: \.self) { av in
${""?left_pad(indent)}        Image(av)
${""?left_pad(indent)}          .resizable()
${""?left_pad(indent)}          .aspectRatio(contentMode: .fill)
${""?left_pad(indent)}          .frame(width: 20, height: 20)
${""?left_pad(indent)}          .cornerRadius(10)
${""?left_pad(indent)}          .padding(.trailing, 4)
${""?left_pad(indent)}      }
${""?left_pad(indent)}    }
  </#if>
  <#if guidbase.has_child_widget(widget, "status")>
${""?left_pad(indent)}    Spacer()
${""?left_pad(indent)}    Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))}).font(.system(size: 12)).foregroundColor(Color("primary"))
  </#if>
${""?left_pad(indent)}  }
${""?left_pad(indent)}  .frame(maxWidth: .infinity)
${""?left_pad(indent)}}
${""?left_pad(indent)}.padding(12)
${""?left_pad(indent)}.background(Color("bg"))
${""?left_pad(indent)}.cornerRadius(8)
</#macro>