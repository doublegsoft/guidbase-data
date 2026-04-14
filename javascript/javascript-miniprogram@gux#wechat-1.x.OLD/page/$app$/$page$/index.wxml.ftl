<#import "/$/gux.ftl" as gux>
<#--<wxs src="/page/common/tool.wxs" module="tool" />-->
<gx-navigation-bar id="navigationBar" title="${page.title!""}" />
<view class="page" style="margin-top: {{marginTop}}px;">
<#list page.pageWidgets![] as widget>
  <#if (widget.widgetType!"") == "按钮导航" || (widget.type!"") == "buttonnavigator">
<@gux.print_wxml_declare_gridnavigator widget=widget indent=2 />
  <#elseif (widget.widgetType!"") == "滚动导航" || (widget.type!"") == "cyclenavigator">
<@gux.print_wxml_declare_cyclenavigator widget=widget indent=2 />
  <#elseif (widget.widgetType!"") == "滑动导航" || (widget.type!"") == "scrollnavigator">
<@gux.print_wxml_declare_scrollnavigator widget=widget indent=2 />
  <#elseif (widget.widgetType!"") == "栏位导航" || (widget.type!"") == "columnnavigator">
<@gux.print_wxml_declare_columnnavigator widget=widget indent=2 />
  <#elseif (widget.widgetType!"") == "列表导航" || (widget.type!"") == "listnavigator">
<@gux.print_wxml_declare_listnavigator widget=widget indent=2 />
  <#elseif (widget.widgetType!"") == "页签导航" || (widget.type!"") == "tabs">
<@gux.print_wxml_declare_tabsnavigator widget=widget indent=2 />
  <#elseif (widget.widgetType!"") == "日历导航" || (widget.type!"") == "calendar">
<@gux.print_wxml_declare_calendar widget=widget indent=2 />
  <#elseif (widget.widgetType!"") == "传统列表" || (widget.type!"") == "listview">
<@gux.print_wxml_declare_listview widget=widget indent=2 />
  <#elseif (widget.widgetType!"") == "主题列表">
<@gux.print_wxml_declare_listtheme widget=widget indent=2 />
  <#elseif (widget.widgetType!"") == "主题标题">
<@gux.print_wxml_declare_themetitle widget=widget indent=2 />
  <#elseif (widget.widgetType!"") == "编辑表单" || (widget.type!"") == "twocolumnform">
<@gux.print_wxml_declare_formlayout widget=widget indent=2 />
  <#elseif (widget.widgetType!"") == "只读表单">
<@gux.print_wxml_declare_readonlyform widget=widget indent=2 />
  <#elseif (widget.widgetType!"") == "花式表单">
<@gux.print_wxml_declare_styledform widget=widget indent=2 />
  <#elseif (widget.widgetType!"") == "主题肖像">
<@gux.print_wxml_declare_avatarheader widget=widget indent=2 />
  <#elseif (widget.widgetType!"") == "向导导航">
<@gux.print_wxml_declare_wizard widget=widget indent=2 />
  <#elseif (widget.widgetType!"") == "搜索输入">
<@gux.print_wxml_declare_searchbar widget=widget indent=2 />
  <#elseif (widget.widgetType!"") == "文本按钮">
<@gux.print_wxml_declare_textbuttons widget=widget indent=2 />
  <#elseif (widget.widgetType!"") == "静态图片" || (widget.type!"") == "image">
<@gux.print_wxml_declare_staticimage widget=widget indent=2 />
  </#if>
</#list>
</view>
