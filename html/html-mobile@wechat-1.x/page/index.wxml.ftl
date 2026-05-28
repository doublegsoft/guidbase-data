<view>
<#list pages as page>
  <#if page.options.isComponent?? && page.options.isComponent == 'T'><#continue></#if>
  <navigator bindtap="goto${js.nameType(page.uri?substring(page.uri?indexOf("/") + 1))}" url="#" class="weui-cell weui-cell_access" role="navigator">
    <text class="weui-cell__bd">${page.title!'标题'}</text>
    <view class="weui-cell__ft weui-cell__ft_in-access"></view>
  </navigator>
</#list>
</view>