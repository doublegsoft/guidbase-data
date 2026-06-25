<#import "/$/miniprogram-wechat-navypitch.ftl" as mp>
<#assign page = pageDef>
<wxs module="h" src="../helper.wxs"></wxs>
<view class="page-shell">
  <view class="page-header">
    <text class="page-header-title"></text>
    <text class="page-header-sub"></text>
  </view>
<#list page.children as child>
<@mp.print_layout_widget widget=child indent=2 />
</#list>
</view>
