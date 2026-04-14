<#import "/$/guidbase.ftl" as guidbase>
<#import "/$/gux.ftl" as gux>
<#assign hasNavigationBar = false>
<#assign hasCustomNavigationBar = false>
<#-- 存不存在自定义导航栏 -->
<#list pagedef.widgets![] as widget>
  <#if !widget.type??><#continue></#if>
  <#if widget.type != "navigation_bar"><#continue></#if>
  <#assign hasNavigationBar = true>
  <#assign hasCustomNavigationBar = true>
<gx-navigation-bar id="navigationBar" custom="{{true}}">
<@gux.print_wxml_declare_navigation_bar widget=widget indent=2 />
</gx-navigation-bar>
</#list>
<#if hasNavigationBar == false>
  <#assign hasNavigationBar = ((pagedef.options["headless"]!"") != "true")>
</#if>
<#-- 页面正文 -->
<#if hasNavigationBar>
  <#if hasCustomNavigationBar == false>
<gx-navigation-bar id="navigationBar" title="${pagedef.options["title"]!"页面标题"}"></gx-navigation-bar>
  </#if>
<view class="page" style="top:{{top}}px;">
<#else>
<view class="page">
</#if>
<#list pagedef.widgets![] as widget>
  <#if !widget.type??><#continue></#if>
  <#if widget.type == "navigation_bar"><#continue></#if>
<@gux.print_wxml_declare_widget widget=widget indent=2 />  
</#list>
</view>
