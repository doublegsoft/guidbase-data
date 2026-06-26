<#import "tile-miniprogram.ftl" as tile>
<#include "miniprogram.ftl">

<!----------------------------------------------------------------------------->
<!--                                ENTRY FORM                               -->
<!----------------------------------------------------------------------------->
<#macro print_layout_entry_form form indent=0>
  <#local cols = form.value("cols","2")>
  <#local groups = form.groups()>
  <#list groups as group>
${""?left_pad(indent)}<view class="card">  
${""?left_pad(indent)}  <view id="entry${js.nameType(form.id)}" class="card-body">
    <#local rows = form.rows(group, cols?number)>
    <#list rows as row>
      <#list row as input>
${""?left_pad(indent)}    <view class="field<#if input.value("required") == "true"> field-required</#if>">
${""?left_pad(indent)}      <text class="field-label">${input.title}</text>
<@print_layout_widget widget=input indent=indent+8 />
${""?left_pad(indent)}    </view>
      </#list>
    </#list>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}</view>
    <#if group?index != groups?size - 1>
<#--  <@print_layout_viewider indent=indent />    -->
    </#if>
  </#list>
</#macro>

<!----------------------------------------------------------------------------->
<!--                               DISPLAY FORM                              -->
<!----------------------------------------------------------------------------->
<#macro print_layout_display_form form indent=0>
  <#local cols = form.value("cols", "3")>
  <#list form.groups() as group>
${""?left_pad(indent)}<view class="card">
${""?left_pad(indent)}  <view class="card-header">
${""?left_pad(indent)}    <view class="flex items-center gap-8">
${""?left_pad(indent)}      <view class="section-dot"></view>
${""?left_pad(indent)}      <text class="card-title"><#if group == "">${form.title}<#else>${group}</#if></text>
${""?left_pad(indent)}    </view>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}  <view class="card-body  card-body-flush">
    <#local rows = form.rows(group, cols?number)>
    <#list rows as row>
      <#list row as input>
${""?left_pad(indent)}    <view class="disp-row">
${""?left_pad(indent)}      <view class="disp-row-left">
${""?left_pad(indent)}        <text class="disp-label">${input.title}</text>
${""?left_pad(indent)}      </view>
${""?left_pad(indent)}      <view class="disp-row-right">
        <#if input.type == "select">
${""?left_pad(indent)}        <view class="tag tag-blue">{{ ${js.nameVariable(input.id)} || '' }}</view>    
        <#elseif input.type == "multiselect">
${""?left_pad(indent)}        <view class="flex flex-wrap" style="gap:10rpx;">
${""?left_pad(indent)}          <view class="tag tag-blue" wx:for="{{ ${js.nameVariable(input.id)} }}" wx:key="*this">{{ item.label }}</view>
${""?left_pad(indent)}        </view>  
        <#elseif input.type == "tags">
${""?left_pad(indent)}        <view class="flex flex-wrap" style="gap:10rpx;">
${""?left_pad(indent)}          <view class="tag tag-teal" wx:for="{{ ${js.nameVariable(input.id)} }}" wx:key="*this">{{ item }}</view>
${""?left_pad(indent)}        </view>        
        <#elseif input.type == "images">
        <#elseif input.type == "videos">
        <#elseif input.type == "files">
        <#elseif input.type == "longtext">
${""?left_pad(indent)}        <text class="disp-value disp-value-longtext">{{ ${js.nameVariable(input.id)} || '' }}</text>        
        <#else>
${""?left_pad(indent)}        <text class="disp-value">{{ ${js.nameVariable(input.id)} || '' }}</text>
        </#if>
        <#if input.value("unit") != "">
${""?left_pad(indent)}        <text class="disp-unit"> ${input.value("unit")}</text>        
        </#if>
${""?left_pad(indent)}      </view>
${""?left_pad(indent)}    </view>
      </#list>
    </#list>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}</view>
  </#list>
</#macro>

<!----------------------------------------------------------------------------->
<!--                                LIST VIEW                                -->
<!----------------------------------------------------------------------------->
<#macro print_layout_list_view list indent=0>
  <#local url = valuebase.url(list.value("data"))>
${""?left_pad(indent)}<view class="card">
${""?left_pad(indent)}  <view class="card-body">
${""?left_pad(indent)}    <scroll-view wx:if="{{ ${js.nameVariable(list.id)}Has${js.nameType(inflector.pluralize(url.resource))} }}" 
${""?left_pad(indent)}                 scroll-y enhanced show-scrollbar="{{ false }}" class="card-body-flush">
${""?left_pad(indent)}      <view wx:for="{{ ${js.nameVariable(list.id)}${js.nameType(inflector.pluralize(url.resource))} }}"
${""?left_pad(indent)}            wx:for-item="row" class="mt-8">
<@tile.print_tile_layout widget=list indent=8 />
${""?left_pad(indent)}      </view>
${""?left_pad(indent)}    </scroll-view>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}</view>
</#macro>