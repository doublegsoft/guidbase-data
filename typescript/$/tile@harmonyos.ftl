<#include "/$/guidbase-tile.ftl">
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
${""?left_pad(indent)}Column() {
${""?left_pad(indent)}  Row() {
  <#if guidbase.has_child_widget(widget, "start_time") || guidbase.has_child_widget(widget, "end_time")>
${""?left_pad(indent)}    Row() {
    <#if guidbase.has_child_widget(widget, "start_time")>${""?left_pad(indent)}      Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "start_time"))}).fontSize(12).fontColor($r('app.color.text_muted'))</#if>
    <#if guidbase.has_child_widget(widget, "start_time") && guidbase.has_child_widget(widget, "end_time")>${""?left_pad(indent)}      Text(" - ").fontSize(12).fontColor($r('app.color.text_muted'))</#if>
    <#if guidbase.has_child_widget(widget, "end_time")>${""?left_pad(indent)}      Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "end_time"))}).fontSize(12).fontColor($r('app.color.text_muted'))</#if>
${""?left_pad(indent)}    }
  </#if>
  <#if guidbase.has_child_widget(widget, "status")>
${""?left_pad(indent)}    Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))}).fontSize(12).fontColor($r('app.color.primary'))
  </#if>
${""?left_pad(indent)}  }.width('100%').justifyContent(FlexAlign.SpaceBetween).margin({ bottom: 8 })
  <#if guidbase.has_child_widget(widget, "primary") || guidbase.has_child_widget(widget, "secondary")>
${""?left_pad(indent)}  Column() {
    <#if guidbase.has_child_widget(widget, "primary")>
${""?left_pad(indent)}    Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))}).fontSize(16).fontColor($r('app.color.text')).fontWeight(FontWeight.Bold).margin({ bottom: 4 })
    </#if>
    <#if guidbase.has_child_widget(widget, "secondary")>
${""?left_pad(indent)}    Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "secondary"))}).fontSize(14).fontColor($r('app.color.text_muted'))
    </#if>
${""?left_pad(indent)}  }.width('100%').alignItems(HorizontalAlign.Start).margin({ bottom: 8 })
  </#if>
  <#if guidbase.has_child_widget(widget, "avatars")>
${""?left_pad(indent)}  Row() {
${""?left_pad(indent)}    ForEach(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "avatars"))}, (av: string) => {
${""?left_pad(indent)}      Image(av).width(24).height(24).borderRadius(12).margin({ right: 4 })
${""?left_pad(indent)}    })
${""?left_pad(indent)}  }.width('100%')
  </#if>
${""?left_pad(indent)}}.padding(12).backgroundColor($r('app.color.bg')).borderRadius(8)
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
${""?left_pad(indent)}Column() {
  <#if guidbase.has_child_widget(widget, "image")>
${""?left_pad(indent)}  Stack({ alignContent: Alignment.BottomStart }) {
${""?left_pad(indent)}    Image(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "image"))}).width('100%').height(150).borderRadius(4).objectFit(ImageFit.Cover)
    <#if guidbase.has_child_widget(widget, "tags")>
${""?left_pad(indent)}    Row() {
${""?left_pad(indent)}      ForEach(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "tags"))}, (tag: string) => {
${""?left_pad(indent)}        Text(tag).fontSize(10).fontColor($r('app.color.bg')).backgroundColor($r('app.color.primary')).padding({ left: 6, right: 6, top: 2, bottom: 2 }).borderRadius(4).margin({ right: 4 })
${""?left_pad(indent)}      })
${""?left_pad(indent)}    }.margin(8)
    </#if>
${""?left_pad(indent)}  }.width('100%').margin({ bottom: 8 })
  </#if>
  <#if guidbase.has_child_widget(widget, "primary") || guidbase.has_child_widget(widget, "secondary") || guidbase.has_child_widget(widget, "tertiary")>
${""?left_pad(indent)}  Column() {
    <#if guidbase.has_child_widget(widget, "primary")>
${""?left_pad(indent)}    Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))}).fontSize(16).fontColor($r('app.color.text')).fontWeight(FontWeight.Bold).margin({ bottom: 4 })
    </#if>
    <#if guidbase.has_child_widget(widget, "secondary")>
${""?left_pad(indent)}    Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "secondary"))}).fontSize(14).fontColor($r('app.color.text_muted')).margin({ bottom: 2 })
    </#if>
    <#if guidbase.has_child_widget(widget, "tertiary")>
${""?left_pad(indent)}    Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "tertiary"))}).fontSize(12).fontColor($r('app.color.text_light'))
    </#if>
${""?left_pad(indent)}  }.width('100%').alignItems(HorizontalAlign.Start)
  </#if>
${""?left_pad(indent)}}.padding(12).backgroundColor($r('app.color.bg')).borderRadius(8)
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
${""?left_pad(indent)}Row() {
  <#if guidbase.has_child_widget(widget, "avatar")>
${""?left_pad(indent)}  Image(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "avatar"))}).width(48).height(48).borderRadius(24).margin({ right: 12 })
  </#if>
${""?left_pad(indent)}  Column() {
    <#if guidbase.has_child_widget(widget, "primary")>
${""?left_pad(indent)}    Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))}).fontSize(16).fontColor($r('app.color.text')).fontWeight(FontWeight.Bold).margin({ bottom: 4 })
    </#if>
    <#if guidbase.has_child_widget(widget, "secondary")>
${""?left_pad(indent)}    Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "secondary"))}).fontSize(14).fontColor($r('app.color.text_muted'))
    </#if>
${""?left_pad(indent)}  }.layoutWeight(1).alignItems(HorizontalAlign.Start)
  <#if guidbase.has_child_widget(widget, "status")>
${""?left_pad(indent)}  Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))}).fontSize(12).fontColor($r('app.color.primary'))
  </#if>
${""?left_pad(indent)}}.width('100%').padding(12).backgroundColor($r('app.color.bg')).borderRadius(8)
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
${""?left_pad(indent)}Column() {
${""?left_pad(indent)}  Row() {
    <#if guidbase.has_child_widget(widget, "tags")>
${""?left_pad(indent)}    Row() {
${""?left_pad(indent)}      ForEach(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "tags"))}, (tag: string) => {
${""?left_pad(indent)}        Text(tag).fontSize(10).fontColor($r('app.color.primary')).backgroundColor($r('app.color.primary_bg')).padding({ left: 6, right: 6, top: 2, bottom: 2 }).borderRadius(4).margin({ right: 4 })
${""?left_pad(indent)}      })
${""?left_pad(indent)}    }
    </#if>
    <#if guidbase.has_child_widget(widget, "status")>
${""?left_pad(indent)}    Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))}).fontSize(12).fontColor($r('app.color.primary'))
    </#if>
${""?left_pad(indent)}  }.width('100%').justifyContent(FlexAlign.SpaceBetween).margin({ bottom: 8 })
  <#if guidbase.has_child_widget(widget, "primary")>
${""?left_pad(indent)}  Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))}).fontSize(16).fontColor($r('app.color.text')).fontWeight(FontWeight.Bold).margin({ bottom: 8 }).width('100%')
  </#if>
${""?left_pad(indent)}  Row() {
    <#if guidbase.has_child_widget(widget, "avatars")>
${""?left_pad(indent)}    Row() {
${""?left_pad(indent)}      ForEach(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "avatars"))}, (av: string) => {
${""?left_pad(indent)}        Image(av).width(24).height(24).borderRadius(12).margin({ right: 4 })
${""?left_pad(indent)}      })
${""?left_pad(indent)}    }
    </#if>
    <#if guidbase.has_child_widget(widget, "end_time")>
${""?left_pad(indent)}    Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "end_time"))}).fontSize(12).fontColor($r('app.color.text_muted'))
    </#if>
${""?left_pad(indent)}  }.width('100%').justifyContent(FlexAlign.SpaceBetween)
${""?left_pad(indent)}}.padding(12).backgroundColor($r('app.color.bg')).borderRadius(8)
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
${""?left_pad(indent)}Stack({ alignContent: Alignment.BottomStart }) {
  <#if guidbase.has_child_widget(widget, "background")>
${""?left_pad(indent)}  Image(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "background"))}).width('100%').height(180).borderRadius(8).objectFit(ImageFit.Cover)
  </#if>
${""?left_pad(indent)}  Column() {
    <#if guidbase.has_child_widget(widget, "tags")>
${""?left_pad(indent)}    Row() {
${""?left_pad(indent)}      ForEach(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "tags"))}, (tag: string) => {
${""?left_pad(indent)}        Text(tag).fontSize(10).fontColor($r('app.color.bg')).backgroundColor($r('app.color.primary')).padding({ left: 6, right: 6, top: 2, bottom: 2 }).borderRadius(4).margin({ right: 4 })
${""?left_pad(indent)}      })
${""?left_pad(indent)}    }.margin({ bottom: 8 })
    </#if>
    <#if guidbase.has_child_widget(widget, "primary")>
${""?left_pad(indent)}    Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))}).fontSize(18).fontColor($r('app.color.bg')).fontWeight(FontWeight.Bold).margin({ bottom: 4 })
    </#if>
    <#if guidbase.has_child_widget(widget, "secondary")>
${""?left_pad(indent)}    Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "secondary"))}).fontSize(14).fontColor($r('app.color.border_light')).margin({ bottom: 2 })
    </#if>
    <#if guidbase.has_child_widget(widget, "tertiary")>
${""?left_pad(indent)}    Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "tertiary"))}).fontSize(12).fontColor($r('app.color.border_light'))
    </#if>
${""?left_pad(indent)}  }.alignItems(HorizontalAlign.Start).padding(12).width('100%')
${""?left_pad(indent)}}.borderRadius(8)
</#macro>

<#--
紧凑列表 (Compact List)
+-----------------------------------------------+
| [status]  [primary]  [secondary]  [start time]|
+-----------------------------------------------+
-->
<#macro print_tile_compact_list widget indent=0>
${""?left_pad(indent)}Row() {
  <#if guidbase.has_child_widget(widget, "status")>
${""?left_pad(indent)}  Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))}).fontSize(14).fontColor($r('app.color.primary')).margin({ right: 8 })
  </#if>
  <#if guidbase.has_child_widget(widget, "primary")>
${""?left_pad(indent)}  Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))}).fontSize(14).fontWeight(FontWeight.Medium).fontColor($r('app.color.text')).layoutWeight(1)
  </#if>
  <#if guidbase.has_child_widget(widget, "secondary")>
${""?left_pad(indent)}  Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "secondary"))}).fontSize(12).fontColor($r('app.color.text_muted')).margin({ right: 8 })
  </#if>
  <#if guidbase.has_child_widget(widget, "start_time")>
${""?left_pad(indent)}  Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "start_time"))}).fontSize(12).fontColor($r('app.color.text_light'))
  </#if>
${""?left_pad(indent)}}.width('100%').padding({ top: 10, bottom: 10, left: 12, right: 12 }).backgroundColor($r('app.color.bg')).border({ width: { bottom: 1 }, color: $r('app.color.border_light') })
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
${""?left_pad(indent)}Row() {
  <#if guidbase.has_child_widget(widget, "image")>
${""?left_pad(indent)}  Image(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "image"))}).width(80).height(80).borderRadius(4).margin({ right: 12 }).objectFit(ImageFit.Cover)
  </#if>
${""?left_pad(indent)}  Column() {
    <#if guidbase.has_child_widget(widget, "tags")>
${""?left_pad(indent)}    Row() {
${""?left_pad(indent)}      ForEach(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "tags"))}, (tag: string) => {
${""?left_pad(indent)}        Text(tag).fontSize(10).fontColor($r('app.color.primary')).backgroundColor($r('app.color.primary_bg')).padding({ left: 6, right: 6, top: 2, bottom: 2 }).borderRadius(4).margin({ right: 4 })
${""?left_pad(indent)}      })
${""?left_pad(indent)}    }.margin({ bottom: 4 })
    </#if>
    <#if guidbase.has_child_widget(widget, "primary")>
${""?left_pad(indent)}    Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))}).fontSize(16).fontColor($r('app.color.text')).fontWeight(FontWeight.Bold).margin({ bottom: 4 })
    </#if>
    <#if guidbase.has_child_widget(widget, "avatars")>
${""?left_pad(indent)}    Row() {
${""?left_pad(indent)}      ForEach(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "avatars"))}, (av: string) => {
${""?left_pad(indent)}        Image(av).width(20).height(20).borderRadius(10).margin({ right: 4 })
${""?left_pad(indent)}      })
${""?left_pad(indent)}    }.margin({ bottom: 4 })
    </#if>
    <#if guidbase.has_child_widget(widget, "start_time")>
${""?left_pad(indent)}    Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "start_time"))}).fontSize(12).fontColor($r('app.color.text_muted'))
    </#if>
${""?left_pad(indent)}  }.alignItems(HorizontalAlign.Start).layoutWeight(1)
${""?left_pad(indent)}}.padding(12).backgroundColor($r('app.color.bg')).borderRadius(8)
</#macro>

<#--
简易状态 (Notification)
+-----------------------------------------------+
|  [status]   [primary]                         |
|             [tertiary]                        |
+-----------------------------------------------+
-->
<#macro print_tile_notification widget indent=0>
${""?left_pad(indent)}Row() {
  <#if guidbase.has_child_widget(widget, "status")>
${""?left_pad(indent)}  Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))}).fontSize(14).fontColor($r('app.color.primary')).margin({ right: 12 })
  </#if>
${""?left_pad(indent)}  Column() {
    <#if guidbase.has_child_widget(widget, "primary")>
${""?left_pad(indent)}    Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))}).fontSize(16).fontColor($r('app.color.text')).fontWeight(FontWeight.Medium).margin({ bottom: 4 })
    </#if>
    <#if guidbase.has_child_widget(widget, "tertiary")>
${""?left_pad(indent)}    Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "tertiary"))}).fontSize(12).fontColor($r('app.color.text_light'))
    </#if>
${""?left_pad(indent)}  }.alignItems(HorizontalAlign.Start).layoutWeight(1)
${""?left_pad(indent)}}.width('100%').padding(12).backgroundColor($r('app.color.bg')).borderRadius(8)
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
${""?left_pad(indent)}Stack({ alignContent: Alignment.TopStart }) {
  <#if guidbase.has_child_widget(widget, "background")>
${""?left_pad(indent)}  Image(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "background"))}).width('100%').height(200).borderRadius(8).objectFit(ImageFit.Cover)
  </#if>
${""?left_pad(indent)}  Column() {
    <#if guidbase.has_child_widget(widget, "avatar")>
${""?left_pad(indent)}    Image(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "avatar"))}).width(64).height(64).borderRadius(32).border({ width: 2, color: $r('app.color.bg') }).margin({ bottom: 8 })
    </#if>
    <#if guidbase.has_child_widget(widget, "primary")>
${""?left_pad(indent)}    Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))}).fontSize(18).fontColor($r('app.color.bg')).fontWeight(FontWeight.Bold).margin({ bottom: 4 })
    </#if>
    <#if guidbase.has_child_widget(widget, "secondary")>
${""?left_pad(indent)}    Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "secondary"))}).fontSize(14).fontColor($r('app.color.border_light'))
    </#if>
${""?left_pad(indent)}  }.width('100%').alignItems(HorizontalAlign.Center).padding({ top: 40 })
${""?left_pad(indent)}}.borderRadius(8)
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
${""?left_pad(indent) }Row() {
${""?left_pad(indent) }  Column() {
    <#if guidbase.has_child_widget(widget, "start_time")>
${""?left_pad(indent) }    Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "start_time"))}).fontSize(12).fontColor($r('app.color.text_muted'))
    </#if>
${""?left_pad(indent) }    Column().width(8).height(8).borderRadius(4).backgroundColor($r('app.color.primary')).margin({ top: 4, bottom: 4 })
    <#if guidbase.has_child_widget(widget, "end_time")>
${""?left_pad(indent) }    Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "end_time"))}).fontSize(12).fontColor($r('app.color.text_muted'))
    </#if>
${""?left_pad(indent) }  }.width(60).alignItems(HorizontalAlign.Center).margin({ right: 12 })
${""?left_pad(indent) }  Column() {
    <#if guidbase.has_child_widget(widget, "primary")>
${""?left_pad(indent) }    Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))}).fontSize(16).fontColor($r('app.color.text')).fontWeight(FontWeight.Bold).margin({ bottom: 4 })
    </#if>
    <#if guidbase.has_child_widget(widget, "secondary")>
${""?left_pad(indent) }    Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "secondary"))}).fontSize(14).fontColor($r('app.color.text_muted')).margin({ bottom: 2 })
    </#if>
    <#if guidbase.has_child_widget(widget, "tertiary")>
${""?left_pad(indent) }    Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "tertiary"))}).fontSize(12).fontColor($r('app.color.text_light'))
    </#if>
${""?left_pad(indent) }  }.layoutWeight(1).alignItems(HorizontalAlign.Start)
  <#if guidbase.has_child_widget(widget, "tags")>
${""?left_pad(indent) }  Row() {
${""?left_pad(indent) }    ForEach(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "tags"))}, (tag: string) => {
${""?left_pad(indent) }      Text(tag).fontSize(10).fontColor($r('app.color.primary')).backgroundColor($r('app.color.primary_bg')).padding({ left: 6, right: 6, top: 2, bottom: 2 }).borderRadius(4).margin({ left: 4 })
${""?left_pad(indent) }    })
${""?left_pad(indent) }  }
  </#if>
${""?left_pad(indent) }}.width('100%').padding(12).backgroundColor($r('app.color.bg')).borderRadius(8)
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
${""?left_pad(indent)}Column() {
${""?left_pad(indent)}  Row() {
    <#if guidbase.has_child_widget(widget, "avatar")>
${""?left_pad(indent)}    Image(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "avatar"))}).width(40).height(40).borderRadius(20).margin({ right: 12 })
    </#if>
${""?left_pad(indent)}    Column() {
${""?left_pad(indent)}      Row() {
        <#if guidbase.has_child_widget(widget, "primary")>
${""?left_pad(indent)}        Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))}).fontSize(14).fontColor($r('app.color.text')).fontWeight(FontWeight.Bold)
        </#if>
        <#if guidbase.has_child_widget(widget, "start_time")>
${""?left_pad(indent)}        Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "start_time"))}).fontSize(12).fontColor($r('app.color.text_muted'))
        </#if>
${""?left_pad(indent)}      }.width('100%').justifyContent(FlexAlign.SpaceBetween)
      <#if guidbase.has_child_widget(widget, "secondary")>
${""?left_pad(indent)}      Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "secondary"))}).fontSize(12).fontColor($r('app.color.text_muted')).margin({ top: 4 })
      </#if>
${""?left_pad(indent)}    }.layoutWeight(1).alignItems(HorizontalAlign.Start)
${""?left_pad(indent)}  }.width('100%').margin({ bottom: 8 })
  <#if guidbase.has_child_widget(widget, "tertiary")>
${""?left_pad(indent)}  Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "tertiary"))}).fontSize(14).fontColor($r('app.color.text')).margin({ left: 52 }).width('100%')
  </#if>
${""?left_pad(indent)}}.padding(12).backgroundColor($r('app.color.bg')).borderRadius(8)
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
${""?left_pad(indent)}Stack({ alignContent: Alignment.BottomStart }) {
  <#if guidbase.has_child_widget(widget, "background")>
${""?left_pad(indent)}  Image(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "background"))}).width('100%').height(120).borderRadius(8).objectFit(ImageFit.Cover)
  </#if>
${""?left_pad(indent)}  Column() {
${""?left_pad(indent)}    Row() {
      <#if guidbase.has_child_widget(widget, "primary")>
${""?left_pad(indent)}      Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))}).fontSize(16).fontColor($r('app.color.bg')).fontWeight(FontWeight.Bold)
      </#if>
      <#if guidbase.has_child_widget(widget, "status")>
${""?left_pad(indent)}      Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))}).fontSize(12).fontColor($r('app.color.primary')).backgroundColor($r('app.color.bg')).padding({ left: 6, right: 6, top: 2, bottom: 2 }).borderRadius(4)
      </#if>
${""?left_pad(indent)}    }.width('100%').justifyContent(FlexAlign.SpaceBetween).margin({ bottom: 8 })
    <#if guidbase.has_child_widget(widget, "start_time") || guidbase.has_child_widget(widget, "end_time")>
${""?left_pad(indent)}    Row() {
      <#if guidbase.has_child_widget(widget, "start_time")>${""?left_pad(indent)}      Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "start_time"))}).fontSize(12).fontColor($r('app.color.border_light'))</#if>
      <#if guidbase.has_child_widget(widget, "start_time") && guidbase.has_child_widget(widget, "end_time")>${""?left_pad(indent)}      Text(" ~ ").fontSize(12).fontColor($r('app.color.border_light'))</#if>
      <#if guidbase.has_child_widget(widget, "end_time")>${""?left_pad(indent)}      Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "end_time"))}).fontSize(12).fontColor($r('app.color.border_light'))</#if>
${""?left_pad(indent)}    }
    </#if>
${""?left_pad(indent)}  }.padding(12).width('100%')
${""?left_pad(indent)}}.borderRadius(8)
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
${""?left_pad(indent)}Row() {
  <#if guidbase.has_child_widget(widget, "image")>
${""?left_pad(indent)}  Image(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "image"))}).width(60).height(60).borderRadius(4).margin({ right: 12 }).objectFit(ImageFit.Cover)
  </#if>
${""?left_pad(indent)}  Column() {
    <#if guidbase.has_child_widget(widget, "primary")>
${""?left_pad(indent)}    Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))}).fontSize(16).fontColor($r('app.color.text')).fontWeight(FontWeight.Bold).margin({ bottom: 4 }).width('100%')
    </#if>
${""?left_pad(indent)}    Row() {
      <#if guidbase.has_child_widget(widget, "secondary")>
${""?left_pad(indent)}      Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "secondary"))}).fontSize(12).fontColor($r('app.color.text_muted')).layoutWeight(1)
      </#if>
      <#if guidbase.has_child_widget(widget, "tags")>
${""?left_pad(indent)}      Row() {
${""?left_pad(indent)}        ForEach(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "tags"))}, (tag: string) => {
${""?left_pad(indent)}          Text(tag).fontSize(10).fontColor($r('app.color.primary')).backgroundColor($r('app.color.primary_bg')).padding({ left: 6, right: 6, top: 2, bottom: 2 }).borderRadius(4).margin({ left: 4 })
${""?left_pad(indent)}        })
${""?left_pad(indent)}      }
      </#if>
${""?left_pad(indent)}    }.width('100%').margin({ bottom: 4 })
${""?left_pad(indent)}    Row() {
      <#if guidbase.has_child_widget(widget, "tertiary")>
${""?left_pad(indent)}      Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "tertiary"))}).fontSize(12).fontColor($r('app.color.text_light')).layoutWeight(1)
      </#if>
      <#if guidbase.has_child_widget(widget, "status")>
${""?left_pad(indent)}      Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))}).fontSize(12).fontColor($r('app.color.primary'))
      </#if>
${""?left_pad(indent)}    }.width('100%')
${""?left_pad(indent)}  }.layoutWeight(1)
${""?left_pad(indent)}}.padding(12).backgroundColor($r('app.color.bg')).borderRadius(8)
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
${""?left_pad(indent)}Column() {
  <#if guidbase.has_child_widget(widget, "image")>
${""?left_pad(indent)}  Image(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "image"))}).width('100%').height(200).borderRadius({ topLeft: 8, topRight: 8 }).objectFit(ImageFit.Cover)
  </#if>
  <#if guidbase.has_child_widget(widget, "primary") || guidbase.has_child_widget(widget, "secondary") || guidbase.has_child_widget(widget, "start_time") || guidbase.has_child_widget(widget, "end_time") || guidbase.has_child_widget(widget, "avatars")>
${""?left_pad(indent)}  Column() {
    <#if guidbase.has_child_widget(widget, "primary")>
${""?left_pad(indent)}    Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))}).fontSize(16).fontColor($r('app.color.text')).fontWeight(FontWeight.Bold).margin({ bottom: 4 })
    </#if>
    <#if guidbase.has_child_widget(widget, "secondary")>
${""?left_pad(indent)}    Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "secondary"))}).fontSize(14).fontColor($r('app.color.text_muted')).margin({ bottom: 4 })
    </#if>
    <#if guidbase.has_child_widget(widget, "start_time")>
${""?left_pad(indent)}    Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "start_time"))}).fontSize(12).fontColor($r('app.color.text_light')).margin({ bottom: 2 })
    </#if>
    <#if guidbase.has_child_widget(widget, "end_time")>
${""?left_pad(indent)}    Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "end_time"))}).fontSize(12).fontColor($r('app.color.text_light')).margin({ bottom: 4 })
    </#if>
    <#if guidbase.has_child_widget(widget, "avatars")>
${""?left_pad(indent)}    Row() {
${""?left_pad(indent)}      ForEach(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "avatars"))}, (av: string) => {
${""?left_pad(indent)}        Image(av).width(20).height(20).borderRadius(10).margin({ right: 4 })
${""?left_pad(indent)}      })
${""?left_pad(indent)}    }
    </#if>
${""?left_pad(indent)}  }.width('100%').alignItems(HorizontalAlign.Start).padding(12)
  </#if>
${""?left_pad(indent)}}.backgroundColor($r('app.color.bg')).borderRadius(8)
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
${""?left_pad(indent)}Column() {
${""?left_pad(indent)}  Row() {
    <#if guidbase.has_child_widget(widget, "tags")>
${""?left_pad(indent)}    Row() {
${""?left_pad(indent)}      ForEach(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "tags"))}, (tag: string) => {
${""?left_pad(indent)}        Text(tag).fontSize(10).fontColor($r('app.color.primary')).backgroundColor($r('app.color.primary_bg')).padding({ left: 6, right: 6, top: 2, bottom: 2 }).borderRadius(4).margin({ right: 4 })
${""?left_pad(indent)}      })
${""?left_pad(indent)}    }
    </#if>
    <#if guidbase.has_child_widget(widget, "status")>
${""?left_pad(indent)}    Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))}).fontSize(12).fontColor($r('app.color.primary'))
    </#if>
${""?left_pad(indent)}  }.width('100%').justifyContent(FlexAlign.SpaceBetween).margin({ bottom: 8 })
  <#if guidbase.has_child_widget(widget, "primary") || guidbase.has_child_widget(widget, "secondary") || guidbase.has_child_widget(widget, "tertiary")>
${""?left_pad(indent)}  Column() {
    <#if guidbase.has_child_widget(widget, "primary")>
${""?left_pad(indent)}    Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))}).fontSize(16).fontColor($r('app.color.text')).fontWeight(FontWeight.Bold).margin({ bottom: 4 })
    </#if>
    <#if guidbase.has_child_widget(widget, "secondary")>
${""?left_pad(indent)}    Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "secondary"))}).fontSize(14).fontColor($r('app.color.text_muted')).margin({ bottom: 2 })
    </#if>
    <#if guidbase.has_child_widget(widget, "tertiary")>
${""?left_pad(indent)}    Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "tertiary"))}).fontSize(12).fontColor($r('app.color.text_light'))
    </#if>
${""?left_pad(indent)}  }.width('100%').alignItems(HorizontalAlign.Start).margin({ bottom: 8 })
  </#if>
${""?left_pad(indent)}  Row() {
    <#if guidbase.has_child_widget(widget, "avatar")>
${""?left_pad(indent)}    Image(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "avatar"))}).width(24).height(24).borderRadius(12)
    </#if>
    <#if guidbase.has_child_widget(widget, "end_time")>
${""?left_pad(indent)}    Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "end_time"))}).fontSize(12).fontColor($r('app.color.text_muted'))
    </#if>
${""?left_pad(indent)}  }.width('100%').justifyContent(FlexAlign.SpaceBetween)
${""?left_pad(indent)}}.padding(12).backgroundColor($r('app.color.bg')).borderRadius(8)
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
${""?left_pad(indent)}Column() {
${""?left_pad(indent)}  Column() {
    <#if guidbase.has_child_widget(widget, "primary")>
${""?left_pad(indent)}    Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))}).fontSize(16).fontColor($r('app.color.text')).fontWeight(FontWeight.Bold).margin({ bottom: 4 })
    </#if>
    <#if guidbase.has_child_widget(widget, "secondary")>
${""?left_pad(indent)}    Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "secondary"))}).fontSize(14).fontColor($r('app.color.text_muted'))
    </#if>
${""?left_pad(indent)}  }.width('100%').alignItems(HorizontalAlign.Start).margin({ bottom: 8 })
${""?left_pad(indent)}  Row() {
    <#if guidbase.has_child_widget(widget, "avatars")>
${""?left_pad(indent)}    Row() {
${""?left_pad(indent)}      ForEach(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "avatars"))}, (av: string) => {
${""?left_pad(indent)}        Image(av).width(24).height(24).borderRadius(12).margin({ right: 4 })
${""?left_pad(indent)}      })
${""?left_pad(indent)}    }
    </#if>
    <#if guidbase.has_child_widget(widget, "tags")>
${""?left_pad(indent)}    Row() {
${""?left_pad(indent)}      ForEach(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "tags"))}, (tag: string) => {
${""?left_pad(indent)}        Text(tag).fontSize(10).fontColor($r('app.color.primary')).backgroundColor($r('app.color.primary_bg')).padding({ left: 6, right: 6, top: 2, bottom: 2 }).borderRadius(4).margin({ left: 4 })
${""?left_pad(indent)}      })
${""?left_pad(indent)}    }
    </#if>
${""?left_pad(indent)}  }.width('100%').justifyContent(FlexAlign.SpaceBetween)
${""?left_pad(indent)}}.padding(12).backgroundColor($r('app.color.bg')).borderRadius(8)
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
${""?left_pad(indent)}Stack({ alignContent: Alignment.BottomStart }) {
  <#if guidbase.has_child_widget(widget, "background")>
${""?left_pad(indent)}  Image(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "background"))}).width('100%').height(200).borderRadius(8).objectFit(ImageFit.Cover)
  </#if>
${""?left_pad(indent)}  Column() {
    <#if guidbase.has_child_widget(widget, "status")>
${""?left_pad(indent)}    Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))}).fontSize(12).fontColor($r('app.color.primary')).backgroundColor($r('app.color.bg')).padding({ left: 6, right: 6, top: 2, bottom: 2 }).borderRadius(4).margin({ bottom: 6 })
    </#if>
    <#if guidbase.has_child_widget(widget, "primary")>
${""?left_pad(indent)}    Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))}).fontSize(18).fontColor($r('app.color.bg')).fontWeight(FontWeight.Bold)
    </#if>
${""?left_pad(indent)}  }.alignItems(HorizontalAlign.Start).padding(12).width('100%')
${""?left_pad(indent)}}.borderRadius(8)
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
${""?left_pad(indent)}Column() {
${""?left_pad(indent)}  Row() {
    <#if guidbase.has_child_widget(widget, "status")>
${""?left_pad(indent)}    Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))}).fontSize(12).fontColor($r('app.color.primary'))
    </#if>
    <#if guidbase.has_child_widget(widget, "end_time")>
${""?left_pad(indent)}    Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "end_time"))}).fontSize(12).fontColor($r('app.color.text_muted'))
    </#if>
${""?left_pad(indent)}  }.width('100%').justifyContent(FlexAlign.SpaceBetween).margin({ bottom: 8 })
  <#if guidbase.has_child_widget(widget, "primary")>
${""?left_pad(indent)}  Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))}).fontSize(16).fontColor($r('app.color.text')).fontWeight(FontWeight.Bold).margin({ bottom: 8 }).width('100%')
  </#if>
  <#if guidbase.has_child_widget(widget, "tags")>
${""?left_pad(indent)}  Row() {
${""?left_pad(indent)}    ForEach(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "tags"))}, (tag: string) => {
${""?left_pad(indent)}      Text(tag).fontSize(10).fontColor($r('app.color.primary')).backgroundColor($r('app.color.primary_bg')).padding({ left: 6, right: 6, top: 2, bottom: 2 }).borderRadius(4).margin({ right: 4 })
${""?left_pad(indent)}    })
${""?left_pad(indent)}  }.width('100%')
  </#if>
${""?left_pad(indent)}}.padding(12).backgroundColor($r('app.color.bg')).borderRadius(8)
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
${""?left_pad(indent)}Row() {
${""?left_pad(indent)}  Column() {
    <#if guidbase.has_child_widget(widget, "primary")>
${""?left_pad(indent)}    Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))}).fontSize(16).fontColor($r('app.color.text')).fontWeight(FontWeight.Bold).margin({ bottom: 4 })
    </#if>
    <#if guidbase.has_child_widget(widget, "tertiary")>
${""?left_pad(indent)}    Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "tertiary"))}).fontSize(12).fontColor($r('app.color.text_light')).margin({ bottom: 8 })
    </#if>
    <#if guidbase.has_child_widget(widget, "avatar")>
${""?left_pad(indent)}    Image(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "avatar"))}).width(32).height(32).borderRadius(16)
    </#if>
${""?left_pad(indent)}  }.layoutWeight(1).alignItems(HorizontalAlign.Start).margin({ right: 12 })
${""?left_pad(indent)}  Column() {
    <#if guidbase.has_child_widget(widget, "secondary")>
${""?left_pad(indent)}    Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "secondary"))}).fontSize(14).fontColor($r('app.color.text_muted')).margin({ bottom: 4 })
    </#if>
    <#if guidbase.has_child_widget(widget, "tags")>
${""?left_pad(indent)}    Row() {
${""?left_pad(indent)}      ForEach(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "tags"))}, (tag: string) => {
${""?left_pad(indent)}        Text(tag).fontSize(10).fontColor($r('app.color.primary')).backgroundColor($r('app.color.primary_bg')).padding({ left: 6, right: 6, top: 2, bottom: 2 }).borderRadius(4).margin({ right: 4 })
${""?left_pad(indent)}      })
${""?left_pad(indent)}    }.margin({ bottom: 8 })
    </#if>
    <#if guidbase.has_child_widget(widget, "avatars")>
${""?left_pad(indent)}    Row() {
${""?left_pad(indent)}      ForEach(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "avatars"))}, (av: string) => {
${""?left_pad(indent)}        Image(av).width(20).height(20).borderRadius(10).margin({ right: 4 })
${""?left_pad(indent)}      })
${""?left_pad(indent)}    }
    </#if>
${""?left_pad(indent)}  }.layoutWeight(1).alignItems(HorizontalAlign.Start)
${""?left_pad(indent)}}.width('100%').padding(12).backgroundColor($r('app.color.bg')).borderRadius(8)
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
${""?left_pad(indent)}Column() {
  <#if guidbase.has_child_widget(widget, "image")>
${""?left_pad(indent)}  Image(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "image"))}).width('100%').height(150).borderRadius(4).objectFit(ImageFit.Cover).margin({ bottom: 8 })
  </#if>
  <#if guidbase.has_child_widget(widget, "primary")>
${""?left_pad(indent)}  Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))}).fontSize(16).fontColor($r('app.color.text')).fontWeight(FontWeight.Bold).margin({ bottom: 8 }).width('100%')
  </#if>
${""?left_pad(indent)}  Row() {
    <#if guidbase.has_child_widget(widget, "avatars")>
${""?left_pad(indent)}    Row() {
${""?left_pad(indent)}      ForEach(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "avatars"))}, (av: string) => {
${""?left_pad(indent)}        Image(av).width(24).height(24).borderRadius(12).margin({ right: 4 })
${""?left_pad(indent)}      })
${""?left_pad(indent)}    }
    </#if>
    <#if guidbase.has_child_widget(widget, "status")>
${""?left_pad(indent)}    Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))}).fontSize(12).fontColor($r('app.color.primary'))
    </#if>
${""?left_pad(indent)}  }.width('100%').justifyContent(FlexAlign.SpaceBetween)
${""?left_pad(indent)}}.padding(12).backgroundColor($r('app.color.bg')).borderRadius(8)
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
${""?left_pad(indent)}Column() {
  <#if guidbase.has_child_widget(widget, "tags")>
${""?left_pad(indent)}  Row() {
${""?left_pad(indent)}    ForEach(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "tags"))}, (tag: string) => {
${""?left_pad(indent)}      Text(tag).fontSize(10).fontColor($r('app.color.primary')).backgroundColor($r('app.color.primary_bg')).padding({ left: 6, right: 6, top: 2, bottom: 2 }).borderRadius(4).margin({ right: 4 })
${""?left_pad(indent)}    })
${""?left_pad(indent)}  }.width('100%').margin({ bottom: 8 })
  </#if>
  <#if guidbase.has_child_widget(widget, "primary")>
${""?left_pad(indent)}  Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))}).fontSize(24).fontColor($r('app.color.primary')).fontWeight(FontWeight.Bold).margin({ bottom: 8 }).width('100%')
  </#if>
${""?left_pad(indent)}  Row() {
    <#if guidbase.has_child_widget(widget, "secondary")>
${""?left_pad(indent)}    Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "secondary"))}).fontSize(12).fontColor($r('app.color.text_muted'))
    </#if>
    <#if guidbase.has_child_widget(widget, "status")>
${""?left_pad(indent)}    Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))}).fontSize(12).fontColor($r('app.color.primary'))
    </#if>
${""?left_pad(indent)}  }.width('100%').justifyContent(FlexAlign.SpaceBetween)
${""?left_pad(indent)}}.padding(12).backgroundColor($r('app.color.bg')).borderRadius(8)
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
${""?left_pad(indent)}Column() {
  <#if guidbase.has_child_widget(widget, "image")>
${""?left_pad(indent)}  Image(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "image"))}).width('100%').height(120).borderRadius({ topLeft: 8, topRight: 8 }).objectFit(ImageFit.Cover)
  </#if>
${""?left_pad(indent)}  Row() {
    <#if guidbase.has_child_widget(widget, "avatar")>
${""?left_pad(indent)}    Image(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "avatar"))}).width(48).height(48).borderRadius(24).border({ width: 2, color: $r('app.color.bg') }).margin({ right: 12, top: -24 })
    </#if>
${""?left_pad(indent)}    Column() {
      <#if guidbase.has_child_widget(widget, "primary")>
${""?left_pad(indent)}      Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))}).fontSize(16).fontColor($r('app.color.text')).fontWeight(FontWeight.Bold).margin({ bottom: 4 })
      </#if>
      <#if guidbase.has_child_widget(widget, "secondary")>
${""?left_pad(indent)}      Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "secondary"))}).fontSize(14).fontColor($r('app.color.text_muted'))
      </#if>
${""?left_pad(indent)}    }.layoutWeight(1).alignItems(HorizontalAlign.Start)
${""?left_pad(indent)}  }.width('100%').padding(12)
${""?left_pad(indent)}}.backgroundColor($r('app.color.bg')).borderRadius(8)
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
${""?left_pad(indent)}Row() {
  <#if guidbase.has_child_widget(widget, "avatar")>
${""?left_pad(indent)}  Image(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "avatar"))}).width(40).height(40).borderRadius(20).margin({ right: 12 })
  </#if>
${""?left_pad(indent)}  Column() {
${""?left_pad(indent)}    Row() {
      <#if guidbase.has_child_widget(widget, "primary")>
${""?left_pad(indent)}      Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))}).fontSize(14).fontColor($r('app.color.text')).fontWeight(FontWeight.Bold)
      </#if>
      <#if guidbase.has_child_widget(widget, "status")>
${""?left_pad(indent)}      Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))}).fontSize(12).fontColor($r('app.color.primary'))
      </#if>
${""?left_pad(indent)}    }.width('100%').justifyContent(FlexAlign.SpaceBetween).margin({ bottom: 4 })
    <#if guidbase.has_child_widget(widget, "secondary")>
${""?left_pad(indent)}    Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "secondary"))}).fontSize(12).fontColor($r('app.color.text_muted')).margin({ bottom: 2 })
    </#if>
    <#if guidbase.has_child_widget(widget, "start_time")>
${""?left_pad(indent)}    Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "start_time"))}).fontSize(12).fontColor($r('app.color.text_light'))
    </#if>
${""?left_pad(indent)}  }.layoutWeight(1).alignItems(HorizontalAlign.Start)
${""?left_pad(indent)}}.width('100%').padding(12).backgroundColor($r('app.color.bg')).borderRadius(8)
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
${""?left_pad(indent)}Column() {
${""?left_pad(indent)}  Row() {
    <#if guidbase.has_child_widget(widget, "start_time")>
${""?left_pad(indent)}    Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "start_time"))}).fontSize(12).fontColor($r('app.color.text_muted'))
    </#if>
    <#if guidbase.has_child_widget(widget, "status")>
${""?left_pad(indent)}    Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))}).fontSize(12).fontColor($r('app.color.primary'))
    </#if>
${""?left_pad(indent)}  }.width('100%').justifyContent(FlexAlign.SpaceBetween).margin({ bottom: 8 })
  <#if guidbase.has_child_widget(widget, "primary")>
${""?left_pad(indent)}  Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))}).fontSize(14).fontColor($r('app.color.text')).fontWeight(FontWeight.Medium).margin({ bottom: 8 }).width('100%')
  </#if>
  <#if guidbase.has_child_widget(widget, "avatars")>
${""?left_pad(indent)}  Row() {
${""?left_pad(indent)}    ForEach(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "avatars"))}, (av: string) => {
${""?left_pad(indent)}      Image(av).width(16).height(16).borderRadius(8).margin({ right: 2 })
${""?left_pad(indent)}    })
${""?left_pad(indent)}  }.width('100%')
  </#if>
${""?left_pad(indent)}}.padding(8).backgroundColor($r('app.color.bg')).borderRadius(4)
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
${""?left_pad(indent)}Row() {
  <#if guidbase.has_child_widget(widget, "status")>
${""?left_pad(indent)}  Column() {
${""?left_pad(indent)}    Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))}).fontSize(12).fontColor($r('app.color.primary'))
${""?left_pad(indent)}  }.width(40).justifyContent(FlexAlign.Center).margin({ right: 12 })
  </#if>
${""?left_pad(indent)}  Column() {
    <#if guidbase.has_child_widget(widget, "primary")>
${""?left_pad(indent)}    Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))}).fontSize(16).fontColor($r('app.color.text')).fontWeight(FontWeight.Bold).margin({ bottom: 4 })
    </#if>
    <#if guidbase.has_child_widget(widget, "secondary")>
${""?left_pad(indent)}    Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "secondary"))}).fontSize(14).fontColor($r('app.color.text_muted')).margin({ bottom: 2 })
    </#if>
    <#if guidbase.has_child_widget(widget, "start_time")>
${""?left_pad(indent)}    Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "start_time"))}).fontSize(12).fontColor($r('app.color.text_light'))
    </#if>
${""?left_pad(indent)}  }.layoutWeight(1).alignItems(HorizontalAlign.Start)
${""?left_pad(indent)}}.width('100%').padding(12).backgroundColor($r('app.color.bg')).borderRadius(8)
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
${""?left_pad(indent)}Column() {
  <#if guidbase.has_child_widget(widget, "tags")>
${""?left_pad(indent)}  Row() {
${""?left_pad(indent)}    ForEach(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "tags"))}, (tag: string) => {
${""?left_pad(indent)}      Text(tag).fontSize(10).fontColor($r('app.color.primary')).backgroundColor($r('app.color.primary_bg')).padding({ left: 6, right: 6, top: 2, bottom: 2 }).borderRadius(4).margin({ right: 4 })
${""?left_pad(indent)}    })
${""?left_pad(indent)}  }.width('100%').margin({ bottom: 8 })
  </#if>
  <#if guidbase.has_child_widget(widget, "primary")>
${""?left_pad(indent)}  Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))}).fontSize(16).fontColor($r('app.color.text')).fontWeight(FontWeight.Bold).margin({ bottom: 8 }).width('100%')
  </#if>
${""?left_pad(indent)}  Row() {
    <#if guidbase.has_child_widget(widget, "secondary")>
${""?left_pad(indent)}    Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "secondary"))}).fontSize(12).fontColor($r('app.color.text_muted'))
    </#if>
    <#if guidbase.has_child_widget(widget, "end_time")>
${""?left_pad(indent)}    Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "end_time"))}).fontSize(12).fontColor($r('app.color.text_light'))
    </#if>
${""?left_pad(indent)}  }.width('100%').justifyContent(FlexAlign.SpaceBetween)
${""?left_pad(indent)}}.padding(12).backgroundColor($r('app.color.bg')).borderRadius(8)
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
${""?left_pad(indent)}Column() {
${""?left_pad(indent)}  Row() {
    <#if guidbase.has_child_widget(widget, "start_time") || guidbase.has_child_widget(widget, "end_time")>
${""?left_pad(indent)}    Row() {
      <#if guidbase.has_child_widget(widget, "start_time")>${""?left_pad(indent)}      Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "start_time"))}).fontSize(12).fontColor($r('app.color.text_muted'))</#if>
      <#if guidbase.has_child_widget(widget, "start_time") && guidbase.has_child_widget(widget, "end_time")>${""?left_pad(indent)}      Text(" - ").fontSize(12).fontColor($r('app.color.text_muted'))</#if>
      <#if guidbase.has_child_widget(widget, "end_time")>${""?left_pad(indent)}      Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "end_time"))}).fontSize(12).fontColor($r('app.color.text_muted'))</#if>
${""?left_pad(indent)}    }
    </#if>
    <#if guidbase.has_child_widget(widget, "status")>
${""?left_pad(indent)}    Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))}).fontSize(12).fontColor($r('app.color.primary'))
    </#if>
${""?left_pad(indent)}  }.width('100%').justifyContent(FlexAlign.SpaceBetween).margin({ bottom: 8 })
  <#if guidbase.has_child_widget(widget, "primary")>
${""?left_pad(indent)}  Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))}).fontSize(16).fontColor($r('app.color.text')).fontWeight(FontWeight.Bold).margin({ bottom: 8 }).width('100%')
  </#if>
  <#if guidbase.has_child_widget(widget, "avatars")>
${""?left_pad(indent)}  Row() {
${""?left_pad(indent)}    ForEach(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "avatars"))}, (av: string) => {
${""?left_pad(indent)}      Image(av).width(20).height(20).borderRadius(10).margin({ right: 4 })
${""?left_pad(indent)}    })
${""?left_pad(indent)}  }.width('100%')
  </#if>
${""?left_pad(indent)}}.padding(12).backgroundColor($r('app.color.bg')).borderRadius(8)
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
${""?left_pad(indent)}Column() {
${""?left_pad(indent)}  Row() {
    <#if guidbase.has_child_widget(widget, "avatar")>
${""?left_pad(indent)}    Image(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "avatar"))}).width(40).height(40).borderRadius(20).margin({ right: 12 })
    </#if>
${""?left_pad(indent)}    Column() {
      <#if guidbase.has_child_widget(widget, "primary")>
${""?left_pad(indent)}      Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))}).fontSize(14).fontWeight(FontWeight.Bold).fontColor($r('app.color.text'))
      </#if>
      <#if guidbase.has_child_widget(widget, "start_time")>
${""?left_pad(indent)}      Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "start_time"))}).fontSize(12).fontColor($r('app.color.text_muted')).margin({ top: 2 })
      </#if>
${""?left_pad(indent)}    }.alignItems(HorizontalAlign.Start)
${""?left_pad(indent)}  }.width('100%').margin({ bottom: 8 })
  <#if guidbase.has_child_widget(widget, "tertiary")>
${""?left_pad(indent)}  Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "tertiary"))}).fontSize(14).fontColor($r('app.color.text')).margin({ bottom: 8 }).width('100%')
  </#if>
  <#if guidbase.has_child_widget(widget, "image")>
${""?left_pad(indent)}  Image(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "image"))}).width('100%').height(200).borderRadius(4).objectFit(ImageFit.Cover).margin({ bottom: 8 })
  </#if>
${""?left_pad(indent)}  Row() {
    <#if guidbase.has_child_widget(widget, "avatars")>
${""?left_pad(indent)}    Row() {
${""?left_pad(indent)}      ForEach(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "avatars"))}, (av: string) => {
${""?left_pad(indent)}        Image(av).width(20).height(20).borderRadius(10).margin({ right: 4 })
${""?left_pad(indent)}      })
${""?left_pad(indent)}    }
    </#if>
    <#if guidbase.has_child_widget(widget, "tags")>
${""?left_pad(indent)}    Row() {
${""?left_pad(indent)}      ForEach(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "tags"))}, (tag: string) => {
${""?left_pad(indent)}        Text(tag).fontSize(10).fontColor($r('app.color.primary')).backgroundColor($r('app.color.primary_bg')).padding({ left: 6, right: 6, top: 2, bottom: 2 }).borderRadius(4).margin({ right: 4 })
${""?left_pad(indent)}      })
${""?left_pad(indent)}    }
    </#if>
${""?left_pad(indent)}  }.width('100%').justifyContent(FlexAlign.SpaceBetween)
${""?left_pad(indent)}}.padding(12).backgroundColor($r('app.color.bg')).borderRadius(8)
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
${""?left_pad(indent)}Column() {
  <#if guidbase.has_child_widget(widget, "image")>
${""?left_pad(indent)}  Image(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "image"))}).width('100%').height(150).borderRadius(4).objectFit(ImageFit.Cover).margin({ bottom: 8 })
  </#if>
  <#if guidbase.has_child_widget(widget, "tags")>
${""?left_pad(indent)}  Row() {
${""?left_pad(indent)}    ForEach(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "tags"))}, (tag: string) => {
${""?left_pad(indent)}      Text(tag).fontSize(10).fontColor($r('app.color.primary')).backgroundColor($r('app.color.primary_bg')).padding({ left: 6, right: 6, top: 2, bottom: 2 }).borderRadius(4).margin({ right: 4 })
${""?left_pad(indent)}    })
${""?left_pad(indent)}  }.width('100%').margin({ bottom: 8 })
  </#if>
  <#if guidbase.has_child_widget(widget, "primary")>
${""?left_pad(indent)}  Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))}).fontSize(16).fontColor($r('app.color.text')).fontWeight(FontWeight.Bold).margin({ bottom: 4 }).width('100%')
  </#if>
  <#if guidbase.has_child_widget(widget, "secondary")>
${""?left_pad(indent)}  Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "secondary"))}).fontSize(14).fontColor($r('app.color.text_muted')).margin({ bottom: 8 }).width('100%')
  </#if>
${""?left_pad(indent)}  Row() {
    <#if guidbase.has_child_widget(widget, "status")>
${""?left_pad(indent)}    Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))}).fontSize(12).fontColor($r('app.color.primary'))
    </#if>
    <#if guidbase.has_child_widget(widget, "end_time")>
${""?left_pad(indent)}    Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "end_time"))}).fontSize(12).fontColor($r('app.color.text_light'))
    </#if>
${""?left_pad(indent)}  }.width('100%').justifyContent(FlexAlign.SpaceBetween)
${""?left_pad(indent)}}.padding(12).backgroundColor($r('app.color.bg')).borderRadius(8)
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
${""?left_pad(indent)}Column() {
${""?left_pad(indent)}  Row() {
    <#if guidbase.has_child_widget(widget, "avatar")>
${""?left_pad(indent)}    Image(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "avatar"))}).width(40).height(40).borderRadius(20)
    </#if>
    <#if guidbase.has_child_widget(widget, "status")>
${""?left_pad(indent)}    Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))}).fontSize(14).fontWeight(FontWeight.Bold).fontColor($r('app.color.primary'))
    </#if>
    <#if guidbase.has_child_widget(widget, "secondary")>
${""?left_pad(indent)}    Image(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "secondary"))}).width(40).height(40).borderRadius(20)
    </#if>
${""?left_pad(indent)}  }.width('100%').justifyContent(FlexAlign.SpaceBetween).margin({ bottom: 8 })
${""?left_pad(indent)}  Row() {
    <#if guidbase.has_child_widget(widget, "primary")>
${""?left_pad(indent)}    Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))}).fontSize(14).fontColor($r('app.color.text'))
    </#if>
    <#if guidbase.has_child_widget(widget, "secondary")>
${""?left_pad(indent)}    Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "secondary"))}).fontSize(14).fontColor($r('app.color.text'))
    </#if>
${""?left_pad(indent)}  }.width('100%').justifyContent(FlexAlign.SpaceBetween).margin({ bottom: 8 })
${""?left_pad(indent)}  Row() {
    <#if guidbase.has_child_widget(widget, "start_time")>
${""?left_pad(indent)}    Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "start_time"))}).fontSize(12).fontColor($r('app.color.text_muted'))
    </#if>
    <#if guidbase.has_child_widget(widget, "end_time")>
${""?left_pad(indent)}    Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "end_time"))}).fontSize(12).fontColor($r('app.color.text_muted'))
    </#if>
${""?left_pad(indent)}  }.width('100%').justifyContent(FlexAlign.SpaceBetween)
${""?left_pad(indent)}}.padding(12).backgroundColor($r('app.color.bg')).borderRadius(8)
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
${""?left_pad(indent)}Row() {
  <#if guidbase.has_child_widget(widget, "image")>
${""?left_pad(indent)}  Image(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "image"))}).width(100).height(100).borderRadius(4).margin({ right: 12 }).objectFit(ImageFit.Cover)
  </#if>
${""?left_pad(indent)}  Column() {
    <#if guidbase.has_child_widget(widget, "tags")>
${""?left_pad(indent)}    Row() {
${""?left_pad(indent)}      ForEach(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "tags"))}, (tag: string) => {
${""?left_pad(indent)}        Text(tag).fontSize(10).fontColor($r('app.color.primary')).backgroundColor($r('app.color.primary_bg')).padding({ left: 6, right: 6, top: 2, bottom: 2 }).borderRadius(4).margin({ right: 4 })
${""?left_pad(indent)}      })
${""?left_pad(indent)}    }.margin({ bottom: 4 })
    </#if>
    <#if guidbase.has_child_widget(widget, "primary")>
${""?left_pad(indent)}    Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))}).fontSize(16).fontColor($r('app.color.text')).fontWeight(FontWeight.Bold).margin({ bottom: 4 })
    </#if>
    <#if guidbase.has_child_widget(widget, "secondary")>
${""?left_pad(indent)}    Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "secondary"))}).fontSize(14).fontColor($r('app.color.text_muted')).margin({ bottom: 2 })
    </#if>
    <#if guidbase.has_child_widget(widget, "tertiary")>
${""?left_pad(indent)}    Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "tertiary"))}).fontSize(12).fontColor($r('app.color.text_light')).margin({ bottom: 4 })
    </#if>
${""?left_pad(indent)}    Row() {
      <#if guidbase.has_child_widget(widget, "status")>
${""?left_pad(indent)}      Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))}).fontSize(12).fontColor($r('app.color.primary')).margin({ right: 8 })
      </#if>
      <#if guidbase.has_child_widget(widget, "avatars")>
${""?left_pad(indent)}      Row() {
${""?left_pad(indent)}        ForEach(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "avatars"))}, (av: string) => {
${""?left_pad(indent)}          Image(av).width(16).height(16).borderRadius(8).margin({ right: 2 })
${""?left_pad(indent)}        })
${""?left_pad(indent)}      }
      </#if>
${""?left_pad(indent)}    }.width('100%')
${""?left_pad(indent)}  }.layoutWeight(1).alignItems(HorizontalAlign.Start)
${""?left_pad(indent)}}.width('100%').padding(12).backgroundColor($r('app.color.bg')).borderRadius(8)
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
${""?left_pad(indent)}Column() {
${""?left_pad(indent)}  Row() {
    <#if guidbase.has_child_widget(widget, "start_time")>
${""?left_pad(indent)}    Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "start_time"))}).fontSize(12).fontColor($r('app.color.text_muted'))
${""?left_pad(indent)}    Text(" > ").fontSize(12).fontColor($r('app.color.text_light'))
    </#if>
    <#if guidbase.has_child_widget(widget, "avatars")>
${""?left_pad(indent)}    Row() {
${""?left_pad(indent)}      ForEach(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "avatars"))}, (av: string) => {
${""?left_pad(indent)}        Image(av).width(20).height(20).borderRadius(10).margin({ right: 4 })
${""?left_pad(indent)}      })
${""?left_pad(indent)}    }
${""?left_pad(indent)}    Text(" > ").fontSize(12).fontColor($r('app.color.text_light'))
    </#if>
    <#if guidbase.has_child_widget(widget, "status")>
${""?left_pad(indent)}    Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))}).fontSize(12).fontColor($r('app.color.primary'))
${""?left_pad(indent)}    Text(" > ").fontSize(12).fontColor($r('app.color.text_light'))
    </#if>
    <#if guidbase.has_child_widget(widget, "end_time")>
${""?left_pad(indent)}    Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "end_time"))}).fontSize(12).fontColor($r('app.color.text_muted'))
    </#if>
${""?left_pad(indent)}  }.width('100%').margin({ bottom: 8 })
  <#if guidbase.has_child_widget(widget, "primary")>
${""?left_pad(indent)}  Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))}).fontSize(16).fontColor($r('app.color.text')).fontWeight(FontWeight.Bold).width('100%')
  </#if>
${""?left_pad(indent)}}.padding(12).backgroundColor($r('app.color.bg')).borderRadius(8)
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
${""?left_pad(indent)}Stack({ alignContent: Alignment.BottomStart }) {
  <#if guidbase.has_child_widget(widget, "background")>
${""?left_pad(indent)}  Image(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "background"))}).width('100%').height(200).borderRadius(8).objectFit(ImageFit.Cover)
  </#if>
${""?left_pad(indent)}  Column() {
    <#if guidbase.has_child_widget(widget, "tags")>
${""?left_pad(indent)}    Row() {
${""?left_pad(indent)}      ForEach(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "tags"))}, (tag: string) => {
${""?left_pad(indent)}        Text(tag).fontSize(10).fontColor($r('app.color.bg')).backgroundColor($r('app.color.primary')).padding({ left: 6, right: 6, top: 2, bottom: 2 }).borderRadius(4).margin({ right: 4 })
${""?left_pad(indent)}      })
${""?left_pad(indent)}    }.margin({ bottom: 8 })
    </#if>
    <#if guidbase.has_child_widget(widget, "primary")>
${""?left_pad(indent)}    Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))}).fontSize(18).fontColor($r('app.color.bg')).fontWeight(FontWeight.Bold).margin({ bottom: 8 })
    </#if>
${""?left_pad(indent)}    Row() {
      <#if guidbase.has_child_widget(widget, "avatar")>
${""?left_pad(indent)}      Image(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "avatar"))}).width(24).height(24).borderRadius(12).margin({ right: 8 })
      </#if>
      <#if guidbase.has_child_widget(widget, "secondary")>
${""?left_pad(indent)}      Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "secondary"))}).fontSize(12).fontColor($r('app.color.border_light'))
      </#if>
${""?left_pad(indent)}    }.width('100%')
${""?left_pad(indent)}  }.alignItems(HorizontalAlign.Start).padding(12).width('100%')
${""?left_pad(indent)}}.borderRadius(8)
</#macro>

<#--
微型标记 (Micro Badge)
+----------------------------------+
| [avatar]  [primary]     [status] |
+----------------------------------+
-->
<#macro print_tile_micro_badge widget indent=0>
${""?left_pad(indent)}Row() {
  <#if guidbase.has_child_widget(widget, "avatar")>
${""?left_pad(indent)}  Image(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "avatar"))}).width(24).height(24).borderRadius(12).margin({ right: 8 })
  </#if>
  <#if guidbase.has_child_widget(widget, "primary")>
${""?left_pad(indent)}  Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))}).fontSize(14).fontWeight(FontWeight.Medium).fontColor($r('app.color.text')).layoutWeight(1)
  </#if>
  <#if guidbase.has_child_widget(widget, "status")>
${""?left_pad(indent)}  Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))}).fontSize(12).fontColor($r('app.color.primary'))
  </#if>
${""?left_pad(indent)}}.width('100%').padding({ top: 8, bottom: 8, left: 12, right: 12 }).backgroundColor($r('app.color.bg')).borderRadius(4)
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
${""?left_pad(indent)}Row() {
  <#if guidbase.has_child_widget(widget, "status")>
${""?left_pad(indent)}  Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))}).fontSize(14).fontColor($r('app.color.primary')).margin({ right: 12 })
  </#if>
${""?left_pad(indent)}  Column() {
    <#if guidbase.has_child_widget(widget, "primary")>
${""?left_pad(indent)}    Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))}).fontSize(16).fontColor($r('app.color.text')).fontWeight(FontWeight.Bold).margin({ bottom: 4 })
    </#if>
    <#if guidbase.has_child_widget(widget, "secondary")>
${""?left_pad(indent)}    Row() {
${""?left_pad(indent)}      Text("├─ ").fontSize(12).fontColor($r('app.color.text_light'))
${""?left_pad(indent)}      Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "secondary"))}).fontSize(12).fontColor($r('app.color.text_muted'))
${""?left_pad(indent)}    }.margin({ bottom: 2 })
    </#if>
    <#if guidbase.has_child_widget(widget, "start_time") || guidbase.has_child_widget(widget, "end_time")>
${""?left_pad(indent)}    Row() {
${""?left_pad(indent)}      Text("├─ ").fontSize(12).fontColor($r('app.color.text_light'))
      <#if guidbase.has_child_widget(widget, "start_time")>${""?left_pad(indent)}      Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "start_time"))}).fontSize(12).fontColor($r('app.color.text_light'))</#if>
      <#if guidbase.has_child_widget(widget, "start_time") && guidbase.has_child_widget(widget, "end_time")>${""?left_pad(indent)}      Text(" - ").fontSize(12).fontColor($r('app.color.text_light'))</#if>
      <#if guidbase.has_child_widget(widget, "end_time")>${""?left_pad(indent)}      Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "end_time"))}).fontSize(12).fontColor($r('app.color.text_light'))</#if>
${""?left_pad(indent)}    }
    </#if>
${""?left_pad(indent)}  }.layoutWeight(1).alignItems(HorizontalAlign.Start)
${""?left_pad(indent)}}.width('100%').padding(12).backgroundColor($r('app.color.bg')).borderRadius(8)
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
${""?left_pad(indent)}Stack({ alignContent: Alignment.Bottom }) {
  <#if guidbase.has_child_widget(widget, "image")>
${""?left_pad(indent)}  Image(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "image"))}).width('100%').height(160).borderRadius(8).objectFit(ImageFit.Cover)
  </#if>
${""?left_pad(indent)}  Column() {
    <#if guidbase.has_child_widget(widget, "primary")>
${""?left_pad(indent)}    Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))}).fontSize(14).fontColor($r('app.color.text')).fontWeight(FontWeight.Bold).margin({ bottom: 4 })
    </#if>
${""?left_pad(indent)}    Row() {
    <#if guidbase.has_child_widget(widget, "secondary")>
${""?left_pad(indent)}      Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "secondary"))}).fontSize(12).fontColor($r('app.color.text_muted'))
    </#if>
    <#if guidbase.has_child_widget(widget, "status")>
${""?left_pad(indent)}      Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))}).fontSize(12).fontColor($r('app.color.primary'))
    </#if>
${""?left_pad(indent)}    }.width('100%').justifyContent(FlexAlign.SpaceBetween)
${""?left_pad(indent)}  }.backgroundColor($r('app.color.bg')).padding(10).borderRadius(6).margin(8)
${""?left_pad(indent)}}.borderRadius(8)
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
${""?left_pad(indent)}Column() {
  <#if guidbase.has_child_widget(widget, "avatars")>
${""?left_pad(indent)}  Row() {
${""?left_pad(indent)}    ForEach(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "avatars"))}, (av: string) => {
${""?left_pad(indent)}      Image(av).width(24).height(24).borderRadius(12).margin({ right: 4 })
${""?left_pad(indent)}    })
${""?left_pad(indent)}  }.width('100%').margin({ bottom: 8 })
  </#if>
  <#if guidbase.has_child_widget(widget, "primary")>
${""?left_pad(indent)}  Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))}).fontSize(16).fontColor($r('app.color.text')).fontWeight(FontWeight.Bold).margin({ bottom: 4 }).width('100%')
  </#if>
  <#if guidbase.has_child_widget(widget, "tertiary")>
${""?left_pad(indent)}  Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "tertiary"))}).fontSize(12).fontColor($r('app.color.text_light')).margin({ bottom: 8 }).width('100%')
  </#if>
${""?left_pad(indent)}  Row() {
    <#if guidbase.has_child_widget(widget, "tags")>
${""?left_pad(indent)}    Row() {
${""?left_pad(indent)}      ForEach(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "tags"))}, (tag: string) => {
${""?left_pad(indent)}        Text(tag).fontSize(10).fontColor($r('app.color.primary')).backgroundColor($r('app.color.primary_bg')).padding({ left: 6, right: 6, top: 2, bottom: 2 }).borderRadius(4).margin({ right: 4 })
${""?left_pad(indent)}      })
${""?left_pad(indent)}    }
    </#if>
    <#if guidbase.has_child_widget(widget, "status")>
${""?left_pad(indent)}    Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))}).fontSize(12).fontColor($r('app.color.primary'))
    </#if>
${""?left_pad(indent)}  }.width('100%').justifyContent(FlexAlign.SpaceBetween)
${""?left_pad(indent)}}.padding(12).backgroundColor($r('app.color.bg')).borderRadius(8)
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
${""?left_pad(indent)}Column() {
  <#if guidbase.has_child_widget(widget, "status")>
${""?left_pad(indent)}  Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))}).fontSize(12).fontColor($r('app.color.primary')).margin({ bottom: 8 })
  </#if>
  <#if guidbase.has_child_widget(widget, "image")>
${""?left_pad(indent)}  Image(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "image"))}).width('100%').height(100).borderRadius(4).objectFit(ImageFit.Cover).margin({ bottom: 8 })
  </#if>
  <#if guidbase.has_child_widget(widget, "primary")>
${""?left_pad(indent)}  Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))}).fontSize(16).fontColor($r('app.color.text')).fontWeight(FontWeight.Bold).margin({ bottom: 4 }).width('100%')
  </#if>
  <#if guidbase.has_child_widget(widget, "secondary")>
${""?left_pad(indent)}  Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "secondary"))}).fontSize(14).fontColor($r('app.color.text_muted')).margin({ bottom: 8 }).width('100%')
  </#if>
  <#if guidbase.has_child_widget(widget, "tags")>
${""?left_pad(indent)}  Row() {
${""?left_pad(indent)}    ForEach(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "tags"))}, (tag: string) => {
${""?left_pad(indent)}      Text(tag).fontSize(10).fontColor($r('app.color.primary')).backgroundColor($r('app.color.primary_bg')).padding({ left: 6, right: 6, top: 2, bottom: 2 }).borderRadius(4).margin({ right: 4 })
${""?left_pad(indent)}    })
${""?left_pad(indent)}  }.width('100%').margin({ bottom: 8 })
  </#if>
  <#if guidbase.has_child_widget(widget, "avatars")>
${""?left_pad(indent)}  Row() {
${""?left_pad(indent)}    ForEach(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "avatars"))}, (av: string) => {
${""?left_pad(indent)}      Image(av).width(20).height(20).borderRadius(10).margin({ right: 4 })
${""?left_pad(indent)}    })
${""?left_pad(indent)}  }.width('100%')
  </#if>
${""?left_pad(indent)}}.padding(12).backgroundColor($r('app.color.bg')).borderRadius(8).width(120)
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
${""?left_pad(indent)}Column() {
${""?left_pad(indent)}  Row() {
    <#if guidbase.has_child_widget(widget, "primary")>
${""?left_pad(indent)}    Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))}).fontSize(14).fontColor($r('app.color.text')).fontWeight(FontWeight.Bold)
    </#if>
    <#if guidbase.has_child_widget(widget, "start_time")>
${""?left_pad(indent)}    Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "start_time"))}).fontSize(12).fontColor($r('app.color.text_muted'))
    </#if>
${""?left_pad(indent)}  }.width('100%').justifyContent(FlexAlign.SpaceBetween).margin({ bottom: 4 })
${""?left_pad(indent)}  Row() {
    <#if guidbase.has_child_widget(widget, "secondary")>
${""?left_pad(indent)}    Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "secondary"))}).fontSize(12).fontColor($r('app.color.text_muted'))
    </#if>
    <#if guidbase.has_child_widget(widget, "end_time")>
${""?left_pad(indent)}    Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "end_time"))}).fontSize(12).fontColor($r('app.color.text_light'))
    </#if>
${""?left_pad(indent)}  }.width('100%').justifyContent(FlexAlign.SpaceBetween).margin({ bottom: 8 })
${""?left_pad(indent)}  Row() {
    <#if guidbase.has_child_widget(widget, "avatar")>
${""?left_pad(indent)}    Image(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "avatar"))}).width(24).height(24).borderRadius(12)
    </#if>
    <#if guidbase.has_child_widget(widget, "status")>
${""?left_pad(indent)}    Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))}).fontSize(12).fontColor($r('app.color.primary'))
    </#if>
${""?left_pad(indent)}  }.width('100%').justifyContent(FlexAlign.SpaceBetween)
${""?left_pad(indent)}}.padding(12).backgroundColor($r('app.color.bg')).borderRadius(8)
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
${""?left_pad(indent)}Column() {
${""?left_pad(indent)}  Row() {
    <#if guidbase.has_child_widget(widget, "status")>
${""?left_pad(indent)}    Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))}).fontSize(12).fontColor($r('app.color.primary'))
    </#if>
    <#if guidbase.has_child_widget(widget, "start_time")>
${""?left_pad(indent)}    Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "start_time"))}).fontSize(12).fontColor($r('app.color.text_muted'))
    </#if>
${""?left_pad(indent)}  }.width('100%').justifyContent(FlexAlign.SpaceBetween).margin({ bottom: 8 })
${""?left_pad(indent)}  Row() {
${""?left_pad(indent)}    Column() {
      <#if guidbase.has_child_widget(widget, "primary")>
${""?left_pad(indent)}      Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))}).fontSize(14).fontColor($r('app.color.text')).fontWeight(FontWeight.Bold).margin({ bottom: 4 })
      </#if>
      <#if guidbase.has_child_widget(widget, "tertiary")>
${""?left_pad(indent)}      Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "tertiary"))}).fontSize(12).fontColor($r('app.color.text_light'))
      </#if>
${""?left_pad(indent)}    }.layoutWeight(1).alignItems(HorizontalAlign.Start)
${""?left_pad(indent)}    Column() {
      <#if guidbase.has_child_widget(widget, "secondary")>
${""?left_pad(indent)}      Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "secondary"))}).fontSize(12).fontColor($r('app.color.text_muted')).margin({ bottom: 4 })
      </#if>
      <#if guidbase.has_child_widget(widget, "tags")>
${""?left_pad(indent)}      Row() {
${""?left_pad(indent)}        ForEach(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "tags"))}, (tag: string) => {
${""?left_pad(indent)}          Text(tag).fontSize(10).fontColor($r('app.color.primary')).backgroundColor($r('app.color.primary_bg')).padding({ left: 6, right: 6, top: 2, bottom: 2 }).borderRadius(4).margin({ right: 4 })
${""?left_pad(indent)}        })
${""?left_pad(indent)}      }
      </#if>
${""?left_pad(indent)}    }.layoutWeight(1).alignItems(HorizontalAlign.Start)
${""?left_pad(indent)}  }.width('100%').margin({ bottom: 8 })
  <#if guidbase.has_child_widget(widget, "avatars")>
${""?left_pad(indent)}  Row() {
${""?left_pad(indent)}    ForEach(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "avatars"))}, (av: string) => {
${""?left_pad(indent)}      Image(av).width(20).height(20).borderRadius(10).margin({ right: 4 })
${""?left_pad(indent)}    })
${""?left_pad(indent)}  }.width('100%')
  </#if>
${""?left_pad(indent)}}.padding(12).backgroundColor($r('app.color.bg')).borderRadius(8)
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
${""?left_pad(indent)}Column() {
${""?left_pad(indent)}  Row() {
    <#if guidbase.has_child_widget(widget, "image")>
${""?left_pad(indent)}    Image(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "image"))}).width(60).height(60).borderRadius(4).margin({ right: 12 }).objectFit(ImageFit.Cover)
    </#if>
${""?left_pad(indent)}    Column() {
      <#if guidbase.has_child_widget(widget, "primary")>
${""?left_pad(indent)}      Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))}).fontSize(16).fontColor($r('app.color.text')).fontWeight(FontWeight.Bold).margin({ bottom: 4 })
      </#if>
      <#if guidbase.has_child_widget(widget, "secondary")>
${""?left_pad(indent)}      Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "secondary"))}).fontSize(12).fontColor($r('app.color.text_muted')).margin({ bottom: 4 })
      </#if>
      <#if guidbase.has_child_widget(widget, "start_time") || guidbase.has_child_widget(widget, "end_time")>
${""?left_pad(indent)}      Row() {
        <#if guidbase.has_child_widget(widget, "start_time")>${""?left_pad(indent)}        Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "start_time"))}).fontSize(10).fontColor($r('app.color.text_light'))</#if>
${""?left_pad(indent)}        Row().height(2).layoutWeight(1).backgroundColor($r('app.color.border_light')).margin({ left: 6, right: 6 })
        <#if guidbase.has_child_widget(widget, "end_time")>${""?left_pad(indent)}        Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "end_time"))}).fontSize(10).fontColor($r('app.color.text_light'))</#if>
${""?left_pad(indent)}      }.width('100%')
      </#if>
${""?left_pad(indent)}    }.layoutWeight(1).alignItems(HorizontalAlign.Start)
${""?left_pad(indent)}  }.width('100%').margin({ bottom: 8 })
${""?left_pad(indent)}  Row() {
    <#if guidbase.has_child_widget(widget, "avatar")>
${""?left_pad(indent)}    Image(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "avatar"))}).width(24).height(24).borderRadius(12)
    </#if>
    <#if guidbase.has_child_widget(widget, "status")>
${""?left_pad(indent)}    Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))}).fontSize(12).fontColor($r('app.color.primary'))
    </#if>
${""?left_pad(indent)}  }.width('100%').justifyContent(FlexAlign.SpaceBetween)
${""?left_pad(indent)}}.padding(12).backgroundColor($r('app.color.bg')).borderRadius(8)
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
${""?left_pad(indent)}Column() {
${""?left_pad(indent)}  Row() {
    <#if guidbase.has_child_widget(widget, "start_time")>
${""?left_pad(indent)}    Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "start_time"))}).fontSize(12).fontColor($r('app.color.text_muted'))
    </#if>
    <#if guidbase.has_child_widget(widget, "status")>
${""?left_pad(indent)}    Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))}).fontSize(12).fontColor($r('app.color.primary'))
    </#if>
${""?left_pad(indent)}  }.width('100%').justifyContent(FlexAlign.SpaceBetween).margin({ bottom: 8 })
  <#if guidbase.has_child_widget(widget, "primary")>
${""?left_pad(indent)}  Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))}).fontSize(16).fontColor($r('app.color.text')).fontWeight(FontWeight.Bold).margin({ bottom: 4 }).width('100%')
  </#if>
  <#if guidbase.has_child_widget(widget, "secondary")>
${""?left_pad(indent)}  Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "secondary"))}).fontSize(14).fontColor($r('app.color.text_muted')).margin({ bottom: 8 }).width('100%')
  </#if>
  <#if guidbase.has_child_widget(widget, "avatar")>
${""?left_pad(indent)}  Image(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "avatar"))}).width(24).height(24).borderRadius(12).margin({ top: 4 })
  </#if>
${""?left_pad(indent)}}.padding(12).backgroundColor($r('app.color.bg')).borderRadius(8).alignItems(HorizontalAlign.Start)
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
${""?left_pad(indent)}Column() {
${""?left_pad(indent)}  Row() {
    <#if guidbase.has_child_widget(widget, "start_time") || guidbase.has_child_widget(widget, "end_time")>
${""?left_pad(indent)}    Row() {
      <#if guidbase.has_child_widget(widget, "start_time")>${""?left_pad(indent)}      Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "start_time"))}).fontSize(12).fontColor($r('app.color.text_muted'))</#if>
      <#if guidbase.has_child_widget(widget, "start_time") && guidbase.has_child_widget(widget, "end_time")>${""?left_pad(indent)}      Text(" - ").fontSize(12).fontColor($r('app.color.text_muted'))</#if>
      <#if guidbase.has_child_widget(widget, "end_time")>${""?left_pad(indent)}      Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "end_time"))}).fontSize(12).fontColor($r('app.color.text_muted'))</#if>
${""?left_pad(indent)}    }
    </#if>
    <#if guidbase.has_child_widget(widget, "status")>
${""?left_pad(indent)}    Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))}).fontSize(12).fontColor($r('app.color.primary'))
    </#if>
${""?left_pad(indent)}  }.width('100%').justifyContent(FlexAlign.SpaceBetween).margin({ bottom: 8 })
  <#if guidbase.has_child_widget(widget, "primary")>
${""?left_pad(indent)}  Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))}).fontSize(16).fontColor($r('app.color.text')).fontWeight(FontWeight.Bold).margin({ bottom: 8 }).width('100%')
  </#if>
  <#if guidbase.has_child_widget(widget, "avatars")>
${""?left_pad(indent)}  Row() {
${""?left_pad(indent)}    ForEach(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "avatars"))}, (av: string) => {
${""?left_pad(indent)}      Image(av).width(20).height(20).borderRadius(10).margin({ right: 4 })
${""?left_pad(indent)}    })
${""?left_pad(indent)}  }.width('100%')
  </#if>
${""?left_pad(indent)}}.padding(12).backgroundColor($r('app.color.bg')).borderRadius(8)
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
${""?left_pad(indent)}Column() {
  <#if guidbase.has_child_widget(widget, "start_time")>
${""?left_pad(indent)}  Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "start_time"))}).fontSize(12).fontColor($r('app.color.text_muted')).margin({ bottom: 8 }).width('100%')
  </#if>
${""?left_pad(indent)}  Row() {
    <#if guidbase.has_child_widget(widget, "image")>
${""?left_pad(indent)}    Image(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "image"))}).width(60).height(60).borderRadius(4).margin({ right: 12 }).objectFit(ImageFit.Cover)
    </#if>
${""?left_pad(indent)}    Column() {
      <#if guidbase.has_child_widget(widget, "primary")>
${""?left_pad(indent)}      Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))}).fontSize(14).fontColor($r('app.color.text')).fontWeight(FontWeight.Bold).margin({ bottom: 4 })
      </#if>
      <#if guidbase.has_child_widget(widget, "secondary")>
${""?left_pad(indent)}      Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "secondary"))}).fontSize(12).fontColor($r('app.color.text_muted')).margin({ bottom: 4 })
      </#if>
      <#if guidbase.has_child_widget(widget, "tags")>
${""?left_pad(indent)}      Row() {
${""?left_pad(indent)}        ForEach(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "tags"))}, (tag: string) => {
${""?left_pad(indent)}          Text(tag).fontSize(10).fontColor($r('app.color.primary')).backgroundColor($r('app.color.primary_bg')).padding({ left: 6, right: 6, top: 2, bottom: 2 }).borderRadius(4).margin({ right: 4 })
${""?left_pad(indent)}        })
${""?left_pad(indent)}      }
      </#if>
${""?left_pad(indent)}    }.layoutWeight(1).alignItems(HorizontalAlign.Start)
${""?left_pad(indent)}  }.width('100%')
${""?left_pad(indent)}}.padding(12).backgroundColor($r('app.color.bg')).borderRadius(8)
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
${""?left_pad(indent)}Column() {
${""?left_pad(indent)}  Row() {
    <#if guidbase.has_child_widget(widget, "start_time")>
${""?left_pad(indent)}    Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "start_time"))}).fontSize(12).fontColor($r('app.color.text_muted'))
    </#if>
    <#if guidbase.has_child_widget(widget, "status")>
${""?left_pad(indent)}    Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))}).fontSize(12).fontColor($r('app.color.primary'))
    </#if>
${""?left_pad(indent)}  }.width('100%').justifyContent(FlexAlign.SpaceBetween).margin({ bottom: 8 })
  <#if guidbase.has_child_widget(widget, "primary")>
${""?left_pad(indent)}  Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))}).fontSize(16).fontColor($r('app.color.text')).fontWeight(FontWeight.Bold).margin({ bottom: 8 }).width('100%')
  </#if>
${""?left_pad(indent)}  Row() {
    <#if guidbase.has_child_widget(widget, "avatar")>
${""?left_pad(indent)}    Image(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "avatar"))}).width(24).height(24).borderRadius(12).margin({ right: 8 })
    </#if>
    <#if guidbase.has_child_widget(widget, "secondary")>
${""?left_pad(indent)}    Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "secondary"))}).fontSize(12).fontColor($r('app.color.text_muted')).layoutWeight(1)
    </#if>
${""?left_pad(indent)}  }.width('100%').alignItems(VerticalAlign.Center)
${""?left_pad(indent)}}.padding(12).backgroundColor($r('app.color.bg')).borderRadius(8)
</#macro>

<#--
极简时间单元 (Compact Time Tile)
+-----------------------------------------------+
| [start time]  |  [status]  |  [primary]       |
| [tags]                                        |
+-----------------------------------------------+
-->
<#macro print_tile_compact_time widget indent=0>
${""?left_pad(indent)}Column() {
${""?left_pad(indent)}  Row() {
    <#if guidbase.has_child_widget(widget, "start_time")>
${""?left_pad(indent)}    Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "start_time"))}).fontSize(12).fontColor($r('app.color.text_muted'))
${""?left_pad(indent)}    Text(" | ").fontSize(12).fontColor($r('app.color.border_light')).margin({ left: 4, right: 4 })
    </#if>
    <#if guidbase.has_child_widget(widget, "status")>
${""?left_pad(indent)}    Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))}).fontSize(12).fontColor($r('app.color.primary'))
${""?left_pad(indent)}    Text(" | ").fontSize(12).fontColor($r('app.color.border_light')).margin({ left: 4, right: 4 })
    </#if>
    <#if guidbase.has_child_widget(widget, "primary")>
${""?left_pad(indent)}    Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))}).fontSize(14).fontColor($r('app.color.text')).fontWeight(FontWeight.Medium)
    </#if>
${""?left_pad(indent)}  }.width('100%').margin({ bottom: 4 })
  <#if guidbase.has_child_widget(widget, "tags")>
${""?left_pad(indent)}  Row() {
${""?left_pad(indent)}    ForEach(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "tags"))}, (tag: string) => {
${""?left_pad(indent)}      Text(tag).fontSize(10).fontColor($r('app.color.primary')).backgroundColor($r('app.color.primary_bg')).padding({ left: 6, right: 6, top: 2, bottom: 2 }).borderRadius(4).margin({ right: 4 })
${""?left_pad(indent)}    })
${""?left_pad(indent)}  }.width('100%')
  </#if>
${""?left_pad(indent)}}.padding(12).backgroundColor($r('app.color.bg')).borderRadius(8)
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
${""?left_pad(indent)}Column() {
  <#if guidbase.has_child_widget(widget, "start_time")>
${""?left_pad(indent)}  Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "start_time"))}).fontSize(12).fontColor($r('app.color.text_muted')).margin({ bottom: 6 })
  </#if>
  <#if guidbase.has_child_widget(widget, "primary")>
${""?left_pad(indent)}  Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))}).fontSize(14).fontColor($r('app.color.text')).fontWeight(FontWeight.Bold).margin({ bottom: 4 })
  </#if>
  <#if guidbase.has_child_widget(widget, "status")>
${""?left_pad(indent)}  Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))}).fontSize(12).fontColor($r('app.color.primary'))
  </#if>
${""?left_pad(indent)}}.padding(8).backgroundColor($r('app.color.bg')).borderRadius(4).alignItems(HorizontalAlign.Start)
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
${""?left_pad(indent)}Column() {
${""?left_pad(indent)}  Row() {
    <#if guidbase.has_child_widget(widget, "start_time")>
${""?left_pad(indent)}    Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "start_time"))}).fontSize(12).fontColor($r('app.color.text_muted'))
    </#if>
${""?left_pad(indent)}  }.width('100%').justifyContent(FlexAlign.End).margin({ bottom: 6 })
  <#if guidbase.has_child_widget(widget, "primary")>
${""?left_pad(indent)}  Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))}).fontSize(14).fontColor($r('app.color.text')).fontWeight(FontWeight.Medium).margin({ bottom: 6 }).width('100%')
  </#if>
  <#if guidbase.has_child_widget(widget, "tags")>
${""?left_pad(indent)}  Row() {
${""?left_pad(indent)}    ForEach(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "tags"))}, (tag: string) => {
${""?left_pad(indent)}      Text(tag).fontSize(10).fontColor($r('app.color.primary')).backgroundColor($r('app.color.primary_bg')).padding({ left: 6, right: 6, top: 2, bottom: 2 }).borderRadius(4).margin({ right: 4 })
${""?left_pad(indent)}    })
${""?left_pad(indent)}  }.width('100%')
  </#if>
${""?left_pad(indent)}}.padding(8).backgroundColor($r('app.color.bg')).borderRadius(4)
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
${""?left_pad(indent)}Column() {
${""?left_pad(indent)}  Row() {
    <#if guidbase.has_child_widget(widget, "start_time")>
${""?left_pad(indent)}    Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "start_time"))}).fontSize(12).fontColor($r('app.color.text_muted'))
    </#if>
${""?left_pad(indent)}  }.width('100%').justifyContent(FlexAlign.Start).margin({ bottom: 6 })
  <#if guidbase.has_child_widget(widget, "primary")>
${""?left_pad(indent)}  Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))}).fontSize(14).fontColor($r('app.color.text')).fontWeight(FontWeight.Medium).margin({ bottom: 6 }).width('100%').textAlign(TextAlign.End)
  </#if>
  <#if guidbase.has_child_widget(widget, "tags")>
${""?left_pad(indent)}  Row() {
${""?left_pad(indent)}    ForEach(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "tags"))}, (tag: string) => {
${""?left_pad(indent)}      Text(tag).fontSize(10).fontColor($r('app.color.primary')).backgroundColor($r('app.color.primary_bg')).padding({ left: 6, right: 6, top: 2, bottom: 2 }).borderRadius(4).margin({ left: 4 })
${""?left_pad(indent)}    })
${""?left_pad(indent)}  }.width('100%').justifyContent(FlexAlign.End)
  </#if>
${""?left_pad(indent)}}.padding(8).backgroundColor($r('app.color.bg')).borderRadius(4)
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
${""?left_pad(indent)}Column() {
  <#if guidbase.has_child_widget(widget, "start_time")>
${""?left_pad(indent)}  Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "start_time"))}).fontSize(12).fontColor($r('app.color.text_light')).margin({ bottom: 2 }).width('100%')
  </#if>
  <#if guidbase.has_child_widget(widget, "primary")>
${""?left_pad(indent)}  Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))}).fontSize(16).fontWeight(FontWeight.Bold).fontColor($r('app.color.text')).margin({ bottom: 4 }).width('100%')
  </#if>
${""?left_pad(indent)}  Row() {
${""?left_pad(indent)}    Text("│").fontSize(14).fontColor($r('app.color.border')).margin({ left: 8, bottom: 4 })
${""?left_pad(indent)}  }.width('100%')
  <#if guidbase.has_child_widget(widget, "end_time")>
${""?left_pad(indent)}  Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "end_time"))}).fontSize(12).fontColor($r('app.color.text_light')).margin({ bottom: 2 }).width('100%')
  </#if>
${""?left_pad(indent)}  Row() {
  <#if guidbase.has_child_widget(widget, "secondary")>
${""?left_pad(indent)}    Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "secondary"))}).fontSize(14).fontColor($r('app.color.text_muted'))
  </#if>
  <#if guidbase.has_child_widget(widget, "status")>
${""?left_pad(indent)}    Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))}).fontSize(12).fontColor($r('app.color.primary'))
  </#if>
${""?left_pad(indent)}  }.width('100%').justifyContent(FlexAlign.SpaceBetween)
${""?left_pad(indent)}}.padding(12).backgroundColor($r('app.color.bg')).borderRadius(8)
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
${""?left_pad(indent)}Column() {
${""?left_pad(indent)}  Row() {
  <#if guidbase.has_child_widget(widget, "start_time")>
${""?left_pad(indent)}    Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "start_time"))}).fontSize(12).fontColor($r('app.color.text_muted'))
${""?left_pad(indent)}    Text(" >> ").fontSize(12).fontColor($r('app.color.text_light'))
  </#if>
  <#if guidbase.has_child_widget(widget, "tags")>
${""?left_pad(indent)}    Row() {
${""?left_pad(indent)}      ForEach(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "tags"))}, (tag: string) => {
${""?left_pad(indent)}        Text(tag).fontSize(10).fontColor($r('app.color.primary')).backgroundColor($r('app.color.primary_bg')).padding({ left: 6, right: 6, top: 2, bottom: 2 }).borderRadius(4).margin({ right: 4 })
${""?left_pad(indent)}      })
${""?left_pad(indent)}    }
${""?left_pad(indent)}    Text(" >> ").fontSize(12).fontColor($r('app.color.text_light'))
  </#if>
  <#if guidbase.has_child_widget(widget, "end_time")>
${""?left_pad(indent)}    Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "end_time"))}).fontSize(12).fontColor($r('app.color.text_muted'))
  </#if>
${""?left_pad(indent)}  }.width('100%').justifyContent(FlexAlign.SpaceBetween).margin({ bottom: 8 })
${""?left_pad(indent)}  Row() {
  <#if guidbase.has_child_widget(widget, "primary")>
${""?left_pad(indent)}    Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))}).fontSize(14).fontWeight(FontWeight.Bold).fontColor($r('app.color.text'))
${""?left_pad(indent)}    Text(" >> ").fontSize(12).fontColor($r('app.color.text_light'))
  </#if>
  <#if guidbase.has_child_widget(widget, "secondary")>
${""?left_pad(indent)}    Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "secondary"))}).fontSize(12).fontColor($r('app.color.text_muted'))
${""?left_pad(indent)}    Text(" >> ").fontSize(12).fontColor($r('app.color.text_light'))
  </#if>
  <#if guidbase.has_child_widget(widget, "status")>
${""?left_pad(indent)}    Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))}).fontSize(12).fontColor($r('app.color.primary'))
  </#if>
${""?left_pad(indent)}  }.width('100%').justifyContent(FlexAlign.SpaceBetween)
${""?left_pad(indent)}}.padding(12).backgroundColor($r('app.color.bg')).borderRadius(8)
</#macro>

<#--
行式日志 (Horizontal Log)
+-----------------------------------------------+
| [avatar] | [start time] | [primary] | [status] |
+-----------------------------------------------+
-->
<#macro print_tile_horizontal_log widget indent=0>
${""?left_pad(indent)}Row() {
  <#if guidbase.has_child_widget(widget, "avatar")>
${""?left_pad(indent)}  Image(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "avatar"))}).width(24).height(24).borderRadius(12)
${""?left_pad(indent)}  Text(" | ").fontSize(12).fontColor($r('app.color.border_light')).margin({ left: 4, right: 4 })
  </#if>
  <#if guidbase.has_child_widget(widget, "start_time")>
${""?left_pad(indent)}  Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "start_time"))}).fontSize(12).fontColor($r('app.color.text_muted'))
${""?left_pad(indent)}  Text(" | ").fontSize(12).fontColor($r('app.color.border_light')).margin({ left: 4, right: 4 })
  </#if>
  <#if guidbase.has_child_widget(widget, "primary")>
${""?left_pad(indent)}  Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))}).fontSize(14).fontWeight(FontWeight.Medium).fontColor($r('app.color.text')).layoutWeight(1)
${""?left_pad(indent)}  Text(" | ").fontSize(12).fontColor($r('app.color.border_light')).margin({ left: 4, right: 4 })
  </#if>
  <#if guidbase.has_child_widget(widget, "status")>
${""?left_pad(indent)}  Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))}).fontSize(12).fontColor($r('app.color.primary'))
  </#if>
${""?left_pad(indent)}}.width('100%').padding({ top: 8, bottom: 8, left: 12, right: 12 }).backgroundColor($r('app.color.bg')).borderRadius(6)
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
${""?left_pad(indent)}Column() {
  <#if guidbase.has_child_widget(widget, "tags")>
${""?left_pad(indent)}  Row() {
${""?left_pad(indent)}    ForEach(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "tags"))}, (tag: string) => {
${""?left_pad(indent)}      Text(tag).fontSize(10).fontColor($r('app.color.primary')).backgroundColor($r('app.color.primary_bg')).padding({ left: 6, right: 6, top: 2, bottom: 2 }).borderRadius(4).margin({ right: 4 })
${""?left_pad(indent)}    })
${""?left_pad(indent)}  }.width('100%').margin({ bottom: 8 })
  </#if>
  <#if guidbase.has_child_widget(widget, "primary")>
${""?left_pad(indent)}  Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))}).fontSize(16).fontWeight(FontWeight.Bold).fontColor($r('app.color.text')).margin({ bottom: 4 }).width('100%')
  </#if>
  <#if guidbase.has_child_widget(widget, "tertiary")>
${""?left_pad(indent)}  Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "tertiary"))}).fontSize(12).fontColor($r('app.color.text_light')).margin({ bottom: 8 }).width('100%')
  </#if>
${""?left_pad(indent)}  Row() {
  <#if guidbase.has_child_widget(widget, "avatars")>
${""?left_pad(indent)}    Row() {
${""?left_pad(indent)}      ForEach(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "avatars"))}, (av: string) => {
${""?left_pad(indent)}        Image(av).width(20).height(20).borderRadius(10).margin({ right: 4 })
${""?left_pad(indent)}      })
${""?left_pad(indent)}    }
  </#if>
  <#if guidbase.has_child_widget(widget, "start_time")>
${""?left_pad(indent)}    Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "start_time"))}).fontSize(12).fontColor($r('app.color.text_muted'))
  </#if>
${""?left_pad(indent)}  }.width('100%').justifyContent(FlexAlign.SpaceBetween)
${""?left_pad(indent)}}.padding(12).backgroundColor($r('app.color.bg')).borderRadius(8)
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
${""?left_pad(indent)}Stack({ alignContent: Alignment.BottomStart }) {
  <#if guidbase.has_child_widget(widget, "background")>
${""?left_pad(indent)}  Image(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "background"))}).width('100%').height(150).borderRadius(8).objectFit(ImageFit.Cover)
  </#if>
${""?left_pad(indent)}  Column() {
    <#if guidbase.has_child_widget(widget, "start_time")>
${""?left_pad(indent)}    Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "start_time"))}).fontSize(12).fontColor($r('app.color.border_light')).margin({ bottom: 4 }).width('100%').textAlign(TextAlign.End)
    </#if>
    <#if guidbase.has_child_widget(widget, "primary")>
${""?left_pad(indent)}    Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))}).fontSize(16).fontWeight(FontWeight.Bold).fontColor($r('app.color.bg')).margin({ bottom: 4 })
    </#if>
    <#if guidbase.has_child_widget(widget, "status")>
${""?left_pad(indent)}    Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))}).fontSize(12).fontColor($r('app.color.primary')).backgroundColor($r('app.color.bg')).padding({ left: 6, right: 6, top: 2, bottom: 2 }).borderRadius(4)
    </#if>
${""?left_pad(indent)}  }.alignItems(HorizontalAlign.Start).padding(12).width('100%')
${""?left_pad(indent)}}.borderRadius(8)
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
${""?left_pad(indent)}Row() {
  <#if guidbase.has_child_widget(widget, "avatar")>
${""?left_pad(indent)}  Image(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "avatar"))}).width(32).height(32).borderRadius(16).margin({ right: 12 })
  </#if>
${""?left_pad(indent)}  Column() {
${""?left_pad(indent)}    Row() {
        <#if guidbase.has_child_widget(widget, "primary")>
${""?left_pad(indent)}      Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))}).fontSize(14).fontWeight(FontWeight.Bold).fontColor($r('app.color.text'))
        </#if>
        <#if guidbase.has_child_widget(widget, "start_time")>
${""?left_pad(indent)}      Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "start_time"))}).fontSize(12).fontColor($r('app.color.text_light'))
        </#if>
${""?left_pad(indent)}    }.width('100%').justifyContent(FlexAlign.SpaceBetween).margin({ bottom: 4 })
    <#if guidbase.has_child_widget(widget, "secondary")>
${""?left_pad(indent)}    Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "secondary"))}).fontSize(12).fontColor($r('app.color.text_muted'))
    </#if>
${""?left_pad(indent)}  }.layoutWeight(1).alignItems(HorizontalAlign.Start)
${""?left_pad(indent)}}.width('100%').padding(12).backgroundColor($r('app.color.bg')).borderRadius(8)
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
${""?left_pad(indent)}Column() {
  <#if guidbase.has_child_widget(widget, "start_time")>
${""?left_pad(indent)}  Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "start_time"))}).fontSize(12).fontColor($r('app.color.text_muted')).margin({ bottom: 8 }).width('100%')
  </#if>
${""?left_pad(indent)}  Row() {
${""?left_pad(indent)}    Column() {
        <#if guidbase.has_child_widget(widget, "primary")>
${""?left_pad(indent)}      Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))}).fontSize(16).fontWeight(FontWeight.Bold).fontColor($r('app.color.text')).margin({ bottom: 4 })
        </#if>
        <#if guidbase.has_child_widget(widget, "secondary")>
${""?left_pad(indent)}      Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "secondary"))}).fontSize(14).fontColor($r('app.color.text_muted'))
        </#if>
${""?left_pad(indent)}    }.layoutWeight(1).alignItems(HorizontalAlign.Start).margin({ right: 12 })
${""?left_pad(indent)}    Row() {
        <#if guidbase.has_child_widget(widget, "image")>
${""?left_pad(indent)}      Image(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "image"))}).width(60).height(60).borderRadius(4).objectFit(ImageFit.Cover)
        </#if>
${""?left_pad(indent)}    }
${""?left_pad(indent)}  }.width('100%').margin({ bottom: 8 })
  <#if guidbase.has_child_widget(widget, "status")>
${""?left_pad(indent)}  Row() {
${""?left_pad(indent)}    Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))}).fontSize(12).fontColor($r('app.color.primary'))
${""?left_pad(indent)}  }.width('100%').justifyContent(FlexAlign.End)
  </#if>
${""?left_pad(indent)}}.padding(12).backgroundColor($r('app.color.bg')).borderRadius(8)
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
${""?left_pad(indent)}Column() {
${""?left_pad(indent)}  Row() {
    <#if guidbase.has_child_widget(widget, "tags")>
${""?left_pad(indent)}    Row() {
${""?left_pad(indent)}      ForEach(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "tags"))}, (tag: string) => {
${""?left_pad(indent)}        Text(tag).fontSize(10).fontColor($r('app.color.primary')).backgroundColor($r('app.color.primary_bg')).padding({ left: 6, right: 6, top: 2, bottom: 2 }).borderRadius(4).margin({ right: 4 })
${""?left_pad(indent)}      })
${""?left_pad(indent)}    }
    </#if>
    <#if guidbase.has_child_widget(widget, "end_time")>
${""?left_pad(indent)}    Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "end_time"))}).fontSize(12).fontColor($r('app.color.text_muted'))
    </#if>
${""?left_pad(indent)}  }.width('100%').justifyContent(FlexAlign.SpaceBetween).margin({ bottom: 8 })
  <#if guidbase.has_child_widget(widget, "primary")>
${""?left_pad(indent)}  Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "primary"))}).fontSize(16).fontWeight(FontWeight.Bold).fontColor($r('app.color.text')).margin({ bottom: 8 }).width('100%')
  </#if>
${""?left_pad(indent)}  Row() {
  <#if guidbase.has_child_widget(widget, "avatars")>
${""?left_pad(indent)}    Row() {
${""?left_pad(indent)}      ForEach(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "avatars"))}, (av: string) => {
${""?left_pad(indent)}        Image(av).width(20).height(20).borderRadius(10).margin({ right: 4 })
${""?left_pad(indent)}      })
${""?left_pad(indent)}    }
  </#if>
  <#if guidbase.has_child_widget(widget, "status")>
${""?left_pad(indent)}    Text(row.${guidbase.name_widget_variable(guidbase.get_child_from_tile(widget, "status"))}).fontSize(12).fontColor($r('app.color.primary'))
  </#if>
${""?left_pad(indent)}  }.width('100%').justifyContent(FlexAlign.SpaceBetween)
${""?left_pad(indent)}}.padding(12).backgroundColor($r('app.color.bg')).borderRadius(8)
</#macro>