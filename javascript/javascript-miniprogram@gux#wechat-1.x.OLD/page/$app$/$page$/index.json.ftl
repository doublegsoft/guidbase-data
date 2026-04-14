{
  "navigationBarTitleText": "${page.title!'页面标题'}",
  "usingComponents": {
    "gx-navigation-bar": "/vendor/gux/widget/gx-navigation-bar/index",
    "gx-two-column-form": "/vendor/gux/widget/gx-two-column-form/index"
  <#--
    "editable-form": "/component/editable-form/index",
    "list-view": "/component/list-view/list-view",
<#list page.widgets![] as widget>
  <#if !widget.widgetType??><#continue></#if>
  <#if widget.widgetType != '页签导航'><#continue></#if>
  <#list widget.items as item>
    <#if !item.url??><#continue></#if>
    "page-${(item.url!'todo')?substring((item.url!'todo')?indexOf("/") + 1)?replace("/", "-")}": "/page/${(item.url!'todo')?substring((item.url!'todo')?indexOf("/") + 1)}",
  </#list>
</#list>
    "tabs": "/component/tabs/index",
    "calendar": "/component/calendar/calendar",
    "wizard": "/component/wizard/index"
    -->
  }
}