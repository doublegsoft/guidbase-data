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
  <view class="footer-bar safe-area-bottom">
    <button class="btn btn-secondary" bindtap="handleBack">返回</button>
    <button class="btn btn-primary" bindtap="handleEdit">编辑</button>
  </view>
</view>
