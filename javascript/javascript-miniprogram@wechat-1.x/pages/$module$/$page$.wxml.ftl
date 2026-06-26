<#import "/$/miniprogram-wechat-navypitch.ftl" as mp>
<#assign page = pageDef>
<#assign children = page.children>
<wxs module="h" src="../helper.wxs"></wxs>
<view class="page-shell">
<#if children[0].value("placement","") != "top">
  <view class="page-header">
    <text class="page-header-title"></text>
    <text class="page-header-sub"></text>
  </view>
</#if>  
<#list children as child>
  <#if child?index != 0>
  <view class="widget-divider" />  
  </#if>
<@mp.print_layout_widget widget=child indent=2 />
</#list>
</view>
