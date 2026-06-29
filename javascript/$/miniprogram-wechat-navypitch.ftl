<#import "tile-miniprogram.ftl" as tile>
<#include "miniprogram.ftl">
<!----------------------------------------------------------------------------->
<!--                                  INPUT                                  -->
<!----------------------------------------------------------------------------->
<#macro print_layout_input input indent=0>
  <#if input.type == "avatar">
${""?left_pad(indent)}<view class="avatar-upload" bindtap="handle${js.nameType(input.id)}Upload">
${""?left_pad(indent)}  <view class="avatar avatar-teal avatar-xl" wx:if="{{ !${js.nameVariable(input.id)} }}">
${""?left_pad(indent)}    <text>👤</text>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}  <image wx:else class="avatar avatar-xl" src="{{ ${js.nameVariable(input.id)} }}" mode="aspectFill" style="object-fit:cover;" />
${""?left_pad(indent)}  <text class="mt-6 color-teal text-sm" style="font-weight:var(--weight-semibold);">{{ avatar ? '点击更换头像' : '点击上传头像' }}</text>
${""?left_pad(indent)}</view>
  <#elseif input.type == "date">
${""?left_pad(indent)}<picker mode="date" value="{{ ${js.nameVariable(input.id)} }}" 
                              bindchange="handle${js.nameType(input.id)}Change">
${""?left_pad(indent)}  <view class="field-control">
${""?left_pad(indent)}    <text class="{{ ${js.nameVariable(input.id)} ? 'field-value' : 'field-placeholder' }}">{{ ${js.nameVariable(input.id)} || '请选择日期' }}</text>
${""?left_pad(indent)}    <text class="field-arrow">▾</text>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}</picker>
  <#elseif input.type == "time">
${""?left_pad(indent)}<picker mode="time" value="{{ ${js.nameVariable(input.id)} }}" bindchange="handle${js.nameType(input.id)}Change">
${""?left_pad(indent)}  <view class="field-control">
${""?left_pad(indent)}    <text class="{{ ${js.nameVariable(input.id)} ? 'field-value' : 'field-placeholder' }}">{{ ${js.nameVariable(input.id)} || '请选择时间' }}</text>
${""?left_pad(indent)}    <text class="field-arrow">▾</text>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}</picker>
  <#elseif input.type == "text" || input.type == "number">
    <#local suffix = input.value("suffix", "")>
    <#if suffix != "">
${""?left_pad(indent)}<view class="field-with-suffix">
${""?left_pad(indent)}  <input class="field-input field-input-suffix<#if isReadonly == "true"> field-input-ro</#if>" <#if input.type == "number">type="digit"</#if> placeholder="请输入${input.title}" value="{{ ${js.nameVariable(input.id)} }}" bindinput="handle${js.nameType(input.id)}Change"<#if isReadonly == "true"> disabled="true"</#if> />
${""?left_pad(indent)}  <text class="field-suffix<#if isReadonly == "true"> field-suffix-ro</#if>">${suffix}</text>
${""?left_pad(indent)}</view>
    <#else>
${""?left_pad(indent)}<input class="field-input<#if isReadonly == "true"> field-input-ro</#if>${stateClasses}" <#if input.type == "number">type="digit"</#if> placeholder="请输入${input.title}" value="{{ ${js.nameVariable(input.id)} }}" bindinput="handle${js.nameType(input.id)}Change"<#if isReadonly == "true"> disabled="true"</#if> />
    </#if>
  <#elseif input.type == "select">
${""?left_pad(indent)}<picker range="{{ ${js.nameVariable(input.id)}Options }}" range-key="value" value="{{ ${js.nameVariable(input.id)} }}" bindchange="handle${js.nameType(input.id)}Change">
${""?left_pad(indent)}  <view class="field-control">
${""?left_pad(indent)}    <text class="{{ ${js.nameVariable(input.id)} ? 'field-value' : 'field-placeholder' }}">{{ ${js.nameVariable(input.id)}Label || '请选择' }}</text>
${""?left_pad(indent)}    <text class="field-arrow">▾</text>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}</picker>
  <#elseif input.type == "cascade">
${""?left_pad(indent)}<picker mode="multiSelector" range="{{cascadeData.${js.nameVariable(input.id)}}}" value="{{formData.${js.nameVariable(input.id)}Idx}}" bindchange="handle${js.nameType(input.id)}Change" bindcolumnchange="onCascadeColumnChange">
${""?left_pad(indent)}  <view class="field-control">
${""?left_pad(indent)}    <text class="{{ ${js.nameVariable(input.id)} ? 'field-value' : 'field-placeholder' }}">{{formData.${js.nameVariable(input.id)} || '请选择级联'}}</text>
${""?left_pad(indent)}    <text class="field-arrow">▾</text>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}</picker>
  <#elseif input.type == "multiselect">
${""?left_pad(indent)}<view class="option-chips">
${""?left_pad(indent)}  <view class="option-chip {{ h.has(${js.nameVariable(input.id)}, item.value) ? 'option-chip-on' : '' }}" 
${""?left_pad(indent)}        wx:for="{{ ${js.nameVariable(input.id)}Options }}" wx:key="value" 
${""?left_pad(indent)}        bindtap="handle${js.nameType(input.id)}Tap" data-id="{{ item.value }}">
${""?left_pad(indent)}    <text wx:if="{{ h.has(${js.nameVariable(input.id)}, item.value) }}" class="option-chip-check">✓</text>
${""?left_pad(indent)}    <text>{{ item.label }}</text>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}</view>
  <#elseif input.type == "tags">
${""?left_pad(indent)}<view class="flex flex-wrap" style="gap:10rpx;">
${""?left_pad(indent)}  <view class="tag tag-teal" wx:for="{{ ${js.nameVariable(input.id)} }}" wx:key="*this" 
${""?left_pad(indent)}        bindtap="handle${js.nameType(input.id)}Remove" data-idx="{{ index }}">
${""?left_pad(indent)}    {{item}} <text style="font-weight:var(--weight-bold);opacity:0.5;">×</text>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}  <view class="tag tag-gray tag-add" bindtap="handle${js.nameType(input.id)}Add">+ 添加</view>
${""?left_pad(indent)}</view>
  <#elseif input.type == "longtext">
${""?left_pad(indent)}<textarea class="field-textarea" placeholder="请输入${input.title}内容" value="{{formData.${js.nameVariable(input.id)}}}" bindinput="handle${js.nameType(input.id)}Change" maxlength="${input.value("maxlength", "300")}" />
  <#elseif input.type == "images">
${""?left_pad(indent)}<view class="upload-row">
${""?left_pad(indent)}  <view class="upload-card" wx:for="{{ ${js.nameVariable(input.id)} }}" wx:key="*this">
${""?left_pad(indent)}    <image class="upload-card-img" src="{{ item.url }}" mode="aspectFill" 
${""?left_pad(indent)}           bindtap="handle${js.nameType(input.id)}Preview" 
${""?left_pad(indent)}           data-url="{{ item.url }}" data-id="{{ item.id }}"/>
${""?left_pad(indent)}    <view class="upload-card-del" bindtap="handle${js.nameType(input.id)}Remove">✕</view>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}  <view class="upload-card upload-card-add" bindtap="handle${js.nameType(input.id)}Add">
${""?left_pad(indent)}    <text class="upload-card-plus">+</text>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}</view>
  <#elseif input.type == "videos">
${""?left_pad(indent)}<view class="upload-row">
${""?left_pad(indent)}  <view class="upload-card upload-card-wide" wx:for="{{formData.${js.nameVariable(input.id)}}}" wx:key="*this">
${""?left_pad(indent)}    <view class="upload-card-video">
${""?left_pad(indent)}      <text style="font-size:48rpx;">▶</text>
${""?left_pad(indent)}    </view>
${""?left_pad(indent)}    <view class="upload-card-del" bindtap="handle${js.nameType(input.id)}Remove" data-idx="{{index}}">✕</view>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}  <view class="upload-card upload-card-add" bindtap="handle${js.nameType(input.id)}Add">
${""?left_pad(indent)}    <text class="upload-card-plus">+</text>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}</view>
  <#elseif input.type == "files">
${""?left_pad(indent)}<view class="file-list">
${""?left_pad(indent)}  <view class="file-row" wx:for="{{formData.${js.nameVariable(input.id)}}}" wx:key="name">
${""?left_pad(indent)}    <text class="file-row-icon">📄</text>
${""?left_pad(indent)}    <text class="file-row-name">{{item.name}}</text>
${""?left_pad(indent)}    <text class="file-row-del" bindtap="handle${js.nameType(input.id)}Remove" data-idx="{{index}}">✕</text>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}  <view class="file-add" bindtap="handle${js.nameType(input.id)}Add">+ 添加文件</view>
${""?left_pad(indent)}</view>
  </#if>
</#macro>

<!----------------------------------------------------------------------------->
<!--                                 BUTTON                                  -->
<!----------------------------------------------------------------------------->
<#macro print_layout_buttons buttons indent=0>
${""?left_pad(indent)}<view class="footer-bar footer-bar-fixed">
  <#list buttons.children as button>
${""?left_pad(indent)}  <view class="btn btn-${guidbase.get_button_variant(button)} btn-action" bindtap="handle${js.nameType(button.id)}Tap">
${""?left_pad(indent)}    <text>${button.title}</text>
${""?left_pad(indent)}  </view>
  </#list>
${""?left_pad(indent)}</view>
</#macro>

    <view class="btn btn-default" bindtap="handleResetTap">重置</view>
    <view class="btn btn-primary" bindtap="handleSaveTap">保存</view>
  </view>
<#macro print_layout_button button indent=0>
${""?left_pad(indent)}<view class="btn btn-${guidbase.get_button_variant(button)} btn-action" bindtap="handle${js.nameType(button.id)}Tap">
${""?left_pad(indent)}  <text>${button.title}</text>
${""?left_pad(indent)}</view>
</#macro>
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
<!--                              CRITERIA FORM                              -->
<!----------------------------------------------------------------------------->
<#macro print_layout_criteria_form form indent=0>
${""?left_pad(indent)}<view class="filter-drawer {{ ${js.nameVariable(form.id)}Shown ? 'filter-drawer-open' : '' }}"
${""?left_pad(indent)}        style="top: 80rpx;">
  <#list form.inputs as input>
${""?left_pad(indent)}  <view class="filter-row">
${""?left_pad(indent)}    <text class="filter-label">${input.title}</text>
<@print_layout_input input=input indent=indent+6 />
${""?left_pad(indent)}  </view>
  </#list>
${""?left_pad(indent)}  <view class="btn-actions">
  <#list form.buttons as button>
<@print_layout_button button=button indent=indent+4 />
  </#list>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}</view>
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

<!----------------------------------------------------------------------------->
<!--                                 SEGMENT                                 -->
<!----------------------------------------------------------------------------->
<#macro print_layout_segment segment indent=0>
  <#local variable = segment.value("variable", segment.id)>
  <#if segment.value("placement") == "top">
${""?left_pad(indent)}<view class="top-fixed">
    <#local indent += 2>  
  </#if>
${""?left_pad(indent)}<view class="filter-bar">
${""?left_pad(indent)}  <view class="segments">
${""?left_pad(indent)}    <view wx:for="{{ ${js.nameVariable(segment.id)}Options }}" wx:key="*this"
${""?left_pad(indent)}          class="seg {{ ${js.nameVariable(variable)} === item.value ? 'seg-on' : '' }}"
${""?left_pad(indent)}          data-value="{{ item.value }}" bindtap="handle${js.nameType(segment.id)}Tap">
${""?left_pad(indent)}      {{ item.label }}
${""?left_pad(indent)}    </view>
${""?left_pad(indent)}  </view>
  <#if segment.page.has("criteria_form")>
    <#local form = segment.page.byType("criteria_form")[0]>
${""?left_pad(indent)}  <view class="filter-btn" bindtap="handle${js.nameType(form.id)}Show">
${""?left_pad(indent)}    <text class="filter-btn-arrow {{ ${js.nameVariable(form.id)}Shown ? 'filter-btn-arrow-up' : '' }}">▼</text>
${""?left_pad(indent)}    <text>查询</text>
${""?left_pad(indent)}  </view>
  </#if>
${""?left_pad(indent)}</view>
  <#if segment.value("placement") == "top">
    <#local indent -= 2>
${""?left_pad(indent)}</view>
  </#if>
</#macro>