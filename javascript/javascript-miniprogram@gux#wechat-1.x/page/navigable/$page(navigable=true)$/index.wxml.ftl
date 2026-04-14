<#import "/$/guidbase.ftl" as guidbase>
<#import "/$/gux.ftl" as gux>
<#assign hasNavigationBar = false>
<#-- 存不存在自定义导航栏 -->
<#list pagedef.widgets![] as widget>
  <#if widget.type?? && widget.type != "navigation_bar"><#continue></#if>
  <#assign hasNavigationBar = true>
<gx-navigation-bar id="navigationBar" custom="{{true}}">
<@gux.print_wxml_declare_navigation_bar widget=widget indent=2 />
</gx-navigation-bar>
</#list>
<#if hasNavigationBar == false>
  <#assign hasNavigationBar = ((pagedef.options["headless"]!"") != "true")>
</#if>
<#if hasNavigationBar>
<view class="page navigable" style="top:{{top}}px;">
<#else>
<view class="page navigable">
</#if>
<#list pagedef.widgets![] as widget>
  <#if widget.type?? && widget.type == "navigation_bar" || widget.type == "bottom_sheet"><#continue></#if>
<@gux.print_wxml_declare_widget widget=widget indent=2 />  
</#list>
</view>
<#list pagedef.widgets![] as widget>
  <#if widget.type?? && widget.type != "bottom_sheet"><#continue></#if>
<gx-bottom-sheet id="widget${js.nameType(widget.id)}" height="{{${widget.options["height"]!"300"}}}">
<@gux.print_wxml_declare_bottom_sheet widget=widget indent=2 />
</gx-bottom-sheet>
</#list>
