<#import "/$/guidbase-tile.ftl" as guidbase4tile>
<#include "miniprogram.ftl">

<!----------------------------------------------------------------------------->
<!--                            SCROLL NAVIGATOR                             -->
<!----------------------------------------------------------------------------->
<#macro print_scroll_navigator_layout navigator indent=0>
${""?left_pad(indent)}<view class="scroll-navigator">
${""?left_pad(indent)}  <swiper
${""?left_pad(indent)}    class=""
${""?left_pad(indent)}    current="{{currentIndex}}"
${""?left_pad(indent)}    indicator-dots="false"
${""?left_pad(indent)}    autoplay="true"
${""?left_pad(indent)}    interval="3000"
${""?left_pad(indent)}    duration="3000"
${""?left_pad(indent)}    circular="true"
${""?left_pad(indent)}    bindchange="handle${js.nameType(navigator.id)}Change">
  <#list navigator.children as child>
${""?left_pad(indent)}    <swiper-item>
${""?left_pad(indent)}      <image
${""?left_pad(indent)}        class="banner-image"
${""?left_pad(indent)}        src="{{item.url}}"
${""?left_pad(indent)}        mode="aspectFill"
${""?left_pad(indent)}        lazy-load="true"
${""?left_pad(indent)}        data-index="{{index}}"
${""?left_pad(indent)}        bindtap="handle${js.nameType(child.id)}Tap"
${""?left_pad(indent)}      />
${""?left_pad(indent)}    </swiper-item>
  </#list>
${""?left_pad(indent)}  </swiper>
${""?left_pad(indent)}  <view class="indicator-list">
${""?left_pad(indent)}    <view
${""?left_pad(indent)}      wx:for="{{imageList}}"
${""?left_pad(indent)}      wx:key="id"
${""?left_pad(indent)}      class="indicator {{index === currentIndex ? 'indicator-active' : ''}}"
${""?left_pad(indent)}    ></view>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}</view>
</#macro>

<!----------------------------------------------------------------------------->
<!--                             SLIDE NAVIGATOR                             -->
<!----------------------------------------------------------------------------->
<#macro print_slide_navigator_layout navigator indent=0>
${""?left_pad(indent)}<scroll-view
${""?left_pad(indent)}  class="slide-navigator"
${""?left_pad(indent)}  scroll-x="true"
${""?left_pad(indent)}  show-scrollbar="false"
${""?left_pad(indent)}  enhanced="true"
${""?left_pad(indent)}  enable-flex="true">
${""?left_pad(indent)}  <view class="slide-track">
  <#list navigator.children as child>
${""?left_pad(indent)}    <view
${""?left_pad(indent)}      class="slide-card"
${""?left_pad(indent)}      bindtap="handle${js.nameType(child.id)}Tap">
${""?left_pad(indent)}      <view class="card-icon">
${""?left_pad(indent)}        <text class="card-icon-text">{{item.icon}}</text>
${""?left_pad(indent)}      </view>
${""?left_pad(indent)}      <view class="card-content">
${""?left_pad(indent)}        <text class="card-label">{{item.label}}</text>
${""?left_pad(indent)}        <text class="card-title">${child.title}</text>
${""?left_pad(indent)}        <text class="card-description">{{item.description}}</text>
${""?left_pad(indent)}      </view>
${""?left_pad(indent)}    </view>
  </#list>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}</scroll-view>
</#macro>

<!----------------------------------------------------------------------------->
<!--                            BUTTON NAVIGATOR                             -->
<!----------------------------------------------------------------------------->
<#macro print_button_navigator_layout navigator indent=0>
${""?left_pad(indent)}<view class="btn-grid">
  <#list navigator.children as child>
${""?left_pad(indent)}  <view class="btn-grid-item"
${""?left_pad(indent)}    bindtap="handle${js.nameType(child.id)}Tap">
${""?left_pad(indent)}    <view class="btn-grid-icon"></view>
${""?left_pad(indent)}    <text class="btn-grid-label">${child.title}</text>
${""?left_pad(indent)}    <text class="btn-grid-sub {{item.benefitType}}">{{item.benefit}}</text>
${""?left_pad(indent)}  </view>
  </#list>
${""?left_pad(indent)}</view>
</#macro>

<!----------------------------------------------------------------------------->
<!--                             LIST NAVIGATOR                              -->
<!----------------------------------------------------------------------------->
<#macro print_list_navigator_layout navigator indent=0>
${""?left_pad(indent)}<view class="list-view">
  <#list navigator.children as child>
${""?left_pad(indent)}  <view class="list-item" bindtap="handle${js.nameType(child.id)}Tap">
${""?left_pad(indent)}    <view class="list-content">
${""?left_pad(indent)}      <text class="list-title">${child.title}</text>
${""?left_pad(indent)}    </view>
${""?left_pad(indent)}    <text class="list-arrow">›</text>
${""?left_pad(indent)}  </view>
  </#list>
${""?left_pad(indent)}</view>
</#macro>

<!----------------------------------------------------------------------------->
<!--                                  INPUT                                  -->
<!----------------------------------------------------------------------------->
<#macro print_input_variables input indent=0>
${""?left_pad(indent)}${js.nameVariable(input.id)}: ${guidbase4js.get_primitive_default_value(input)},
  <#if input.type == "select">
${""?left_pad(indent)}${js.nameVariable(input.id)}Index: null,
${""?left_pad(indent)}${js.nameVariable(input.id)}Label: null,
  <#elseif input.type == "multiselect">
${""?left_pad(indent)}${js.nameVariable(input.id)}Indexes: [],
${""?left_pad(indent)}${js.nameVariable(input.id)}Labels: [],  
  <#elseif input.type == "cascade">
${""?left_pad(indent)}${js.nameVariable(input.id)}Indexes: [],
${""?left_pad(indent)}${js.nameVariable(input.id)}Labels: [],
  </#if>
  <#if guidbase.get_widget_enum_ref(input)??>
${""?left_pad(indent)}${js.nameVariable(input.id)}Options: [],
  <#elseif guidbase.get_widget_enum_vals(input)?size != 0>
${""?left_pad(indent)}${js.nameVariable(input.id)}Options: sdk.${js.nameVariable(input.id)}Options,
  </#if>
</#macro>

<#macro print_input_layout input indent=0>
  <#local isReadonly = input.value("readonly")>
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
${""?left_pad(indent)}<input class="field-input<#if isReadonly == "true"> field-input-ro</#if>" <#if input.type == "number">type="digit"</#if> placeholder="请输入${input.title}" value="{{ ${js.nameVariable(input.id)} }}" bindinput="handle${js.nameType(input.id)}Change"<#if isReadonly == "true"> disabled="true"</#if> />
    </#if>
  <#elseif input.type == "select">
    <#if guidbase.get_widget_enum_ref(input)??>
      <#assign opt = guidbase.get_widget_enum_ref(input)>
${""?left_pad(indent)}<picker range="{{ ${js.nameVariable(input.id)}Options }}" range-key="${js.nameVariable(opt.text)}" 
${""?left_pad(indent)}        value="{{ ${js.nameVariable(input.id)}Index }}" 
${""?left_pad(indent)}        bindchange="handle${js.nameType(input.id)}Change">
${""?left_pad(indent)}  <view class="field-control">
${""?left_pad(indent)}    <text class="{{ ${js.nameVariable(input.id)} ? 'field-value' : 'field-placeholder' }}">{{ ${js.nameVariable(input.id)}Label || '请选择' }}</text>
${""?left_pad(indent)}    <text class="field-arrow">▾</text>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}</picker>
    <#else>
${""?left_pad(indent)}<picker range="{{ ${js.nameVariable(input.id)}Options }}" range-key="label" 
${""?left_pad(indent)}        value="{{ ${js.nameVariable(input.id)}Index }}" 
${""?left_pad(indent)}        bindchange="handle${js.nameType(input.id)}Change">
${""?left_pad(indent)}  <view class="field-control">
${""?left_pad(indent)}    <text class="{{ ${js.nameVariable(input.id)} ? 'field-value' : 'field-placeholder' }}">{{ ${js.nameVariable(input.id)}Label || '请选择' }}</text>
${""?left_pad(indent)}    <text class="field-arrow">▾</text>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}</picker>
    </#if>
  <#elseif input.type == "cascade">
    <#assign opt = guidbase.get_widget_enum_ref(input)>
${""?left_pad(indent)}<${namespace}-cascade-picker
${""?left_pad(indent)}  title="请选择${input.label!'地区'}"
${""?left_pad(indent)}  fieldText="${js.nameVariable(opt.text)}"
${""?left_pad(indent)}  fieldValue="${js.nameVariable(opt.code)}"
${""?left_pad(indent)}  valueText="{{ ${js.nameVariable(input.id)}Label }}"
${""?left_pad(indent)}  bind:load="handle${js.nameType(input.id)}Load"
${""?left_pad(indent)}  bind:change="handle${js.nameType(input.id)}Change">
${""?left_pad(indent)}  <view class="field-control">
${""?left_pad(indent)}    <text class="{{ ${js.nameVariable(input.id)} ? 'field-value' : 'field-placeholder' }}">{{ ${js.nameVariable(input.id)} || '请选择级联'}}</text>
${""?left_pad(indent)}    <text class="field-arrow">▾</text>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}</${namespace}-cascade-picker>
  <#elseif input.type == "multiselect">
${""?left_pad(indent)}<view class="field-chips">
${""?left_pad(indent)}  <view class="field-chip {{ h.has(${js.nameVariable(input.id)}, item.value) ? 'active' : '' }}" 
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
${""?left_pad(indent)}<view class="field-uploader">
${""?left_pad(indent)}  <view class="field-uploader-item" wx:for="{{ ${js.nameVariable(input.id)} }}" wx:key="*this">
${""?left_pad(indent)}    <image class="field-uploader-img" src="{{ item.url }}" mode="aspectFill" 
${""?left_pad(indent)}           bindtap="handle${js.nameType(input.id)}Preview" 
${""?left_pad(indent)}           data-url="{{ item.url }}" data-id="{{ item.id }}"/>
${""?left_pad(indent)}    <view class="field-uploader-del" bindtap="handle${js.nameType(input.id)}Remove">✕</view>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}  <view class="field-uploader-item field-uploader-add" bindtap="handle${js.nameType(input.id)}Add">
${""?left_pad(indent)}    <text class="field-uploader-plus">+</text>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}</view>
  <#elseif input.type == "videos">
${""?left_pad(indent)}<view class="field-uploader">
${""?left_pad(indent)}  <view class="field-uploader-item field-uploader-wide" wx:for="{{formData.${js.nameVariable(input.id)}}}" wx:key="*this">
${""?left_pad(indent)}    <view class="field-uploader-video">
${""?left_pad(indent)}      <text style="font-size:48rpx;">▶</text>
${""?left_pad(indent)}    </view>
${""?left_pad(indent)}    <view class="field-uploader-del" bindtap="handle${js.nameType(input.id)}Remove" data-idx="{{index}}">✕</view>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}  <view class="field-uploader-item field-uploader-add" bindtap="handle${js.nameType(input.id)}Add">
${""?left_pad(indent)}    <text class="field-uploader-plus">+</text>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}</view>
  <#elseif input.type == "files">
${""?left_pad(indent)}<view class="field-files">
${""?left_pad(indent)}  <view class="field-file-item" wx:for="{{formData.${js.nameVariable(input.id)}}}" wx:key="name">
${""?left_pad(indent)}    <text class="field-file-icon">📄</text>
${""?left_pad(indent)}    <text class="field-file-name">{{item.name}}</text>
${""?left_pad(indent)}    <text class="field-file-del" bindtap="handle${js.nameType(input.id)}Remove" data-idx="{{index}}">✕</text>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}  <view class="field-file-add" bindtap="handle${js.nameType(input.id)}Add">+ 添加文件</view>
${""?left_pad(indent)}</view>
  </#if>
</#macro>

<!----------------------------------------------------------------------------->
<!--                                 BUTTON                                  -->
<!----------------------------------------------------------------------------->
<#macro print_buttons_layout buttons indent=0>
${""?left_pad(indent)}<view class="page-footer">
  <#list buttons.children as button>
${""?left_pad(indent)}  <view class="btn btn-${guidbase.get_button_variant(button)} btn-action" bindtap="handle${js.nameType(button.id)}Tap">
${""?left_pad(indent)}    <text>${button.title}</text>
${""?left_pad(indent)}  </view>
  </#list>
${""?left_pad(indent)}</view>
</#macro>

<#macro print_button_layout button indent=0>
${""?left_pad(indent)}<view class="btn btn-${guidbase.get_button_variant(button)} btn-action" bindtap="handle${js.nameType(button.id)}Tap">
${""?left_pad(indent)}  <text>${button.title}</text>
${""?left_pad(indent)}</view>
</#macro>
<!----------------------------------------------------------------------------->
<!--                                ENTRY FORM                               -->
<!----------------------------------------------------------------------------->
<#macro print_entry_form_layout form indent=0>
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
<@print_widget_layout widget=input indent=indent+6 />
${""?left_pad(indent)}    </view>
      </#list>
    </#list>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}</view>
    <#if group?index != groups?size - 1>
<#--  <@print_viewider_layout indent=indent />    -->
    </#if>
  </#list>
</#macro>

<!----------------------------------------------------------------------------->
<!--                               DISPLAY FORM                              -->
<!----------------------------------------------------------------------------->
<#macro print_display_form_layout form indent=0>
  <#local cols = form.value("cols", "3")>
  <#list form.groups() as group>
${""?left_pad(indent)}<view class="card">
${""?left_pad(indent)}  <view class="card-header">
${""?left_pad(indent)}    <view class="flex items-center gap-2">
${""?left_pad(indent)}      <view class="cell-group-dot"></view>
${""?left_pad(indent)}      <text class="card-title"><#if group == "">${form.title}<#else>${group}</#if></text>
${""?left_pad(indent)}    </view>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}  <view class="card-body card-body-flush">
    <#local rows = form.rows(group, cols?number)>
    <#list rows as row>
      <#list row as input>
${""?left_pad(indent)}    <view class="cell<#if input.type == 'longtext' || input.type == 'images'> cell-multiline</#if>">
${""?left_pad(indent)}      <text class="cell-label">${input.title}</text>
${""?left_pad(indent)}      <view class="cell-value">
        <#if input.type == "avatar">
${""?left_pad(indent)}        <view class="avatar avatar-md avatar-round avatar-primary" bindtap="handle${js.nameType(input.id)}Preview" data-url="{{ ${js.nameVariable(input.id)} }}">
${""?left_pad(indent)}          <image wx:if="{{ ${js.nameVariable(input.id)} }}" class="avatar-img" src="{{ ${js.nameVariable(input.id)} }}" mode="aspectFill" />
${""?left_pad(indent)}          <text wx:else class="avatar-text">头</text>
${""?left_pad(indent)}        </view>
        <#elseif input.type == "image">
${""?left_pad(indent)}        <image class="cell-img-cover" src="{{ ${js.nameVariable(input.id)} }}" mode="aspectFill"
${""?left_pad(indent)}               bindtap="handle${js.nameType(input.id)}Preview" data-url="{{ ${js.nameVariable(input.id)} }}" />
        <#elseif input.type == "images">
${""?left_pad(indent)}        <view class="cell-images">
${""?left_pad(indent)}          <image class="cell-img-thumb" wx:for="{{ ${js.nameVariable(input.id)} }}" wx:key="*this"
${""?left_pad(indent)}                 src="{{ item.url || item }}" mode="aspectFill"
${""?left_pad(indent)}                 bindtap="handle${js.nameType(input.id)}Preview" data-url="{{ item.url || item }}" />
${""?left_pad(indent)}        </view>
        <#elseif input.type == "select">
${""?left_pad(indent)}        <view class="tag tag-primary">{{ ${js.nameVariable(input.id)} || '' }}</view>    
        <#elseif input.type == "multiselect">
${""?left_pad(indent)}        <view class="cell-tags">
${""?left_pad(indent)}          <view class="tag tag-primary tag-sm" wx:for="{{ ${js.nameVariable(input.id)} }}" wx:key="*this">{{ item.label }}</view>
${""?left_pad(indent)}        </view>  
        <#elseif input.type == "tags">
${""?left_pad(indent)}        <view class="cell-tags">
${""?left_pad(indent)}          <view class="tag tag-success tag-sm" wx:for="{{ ${js.nameVariable(input.id)} }}" wx:key="*this">{{ item }}</view>
${""?left_pad(indent)}        </view>        
        <#elseif input.type == "videos">
        <#elseif input.type == "files">
        <#elseif input.type == "longtext">
${""?left_pad(indent)}        <text>{{ ${js.nameVariable(input.id)} || '' }}</text>        
        <#else>
${""?left_pad(indent)}        <text>{{ ${js.nameVariable(input.id)} || '' }}</text>
        </#if>
        <#if input.value("unit") != "">
${""?left_pad(indent)}        <text class="cell-unit">${input.value("unit")}</text>        
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
<#macro print_criteria_form_layout form indent=0>
${""?left_pad(indent)}<view class="drawer drawer-top px-8 {{ ${js.nameVariable(form.id)}Shown ? 'open' : '' }}" style="top:122rpx;">
  <#list form.inputs as input>
${""?left_pad(indent)}  <view class="field">
${""?left_pad(indent)}    <text class="field-label">${input.title}</text>
<@print_input_layout input=input indent=indent+4 />
${""?left_pad(indent)}  </view>
  </#list>
${""?left_pad(indent)}  <view class="btn-actions">
  <#list form.buttons as button>
<@print_button_layout button=button indent=indent+4 />
  </#list>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}</view>
</#macro>

<!----------------------------------------------------------------------------->
<!--                               SPLIT LIST                                -->
<!----------------------------------------------------------------------------->
<#macro print_split_list_layout list indent=0>
  <#local groupUrl = valuebase.url(list.value("group"))>
  <#local dataUrl = valuebase.url(list.value("data"))>
${""?left_pad(indent)}<view class="split">
${""?left_pad(indent)}  <scroll-view class="split-col-group {{ ${js.nameVariable(list.id)}Groups.length === 0 ? 'split-col-empty' : '' }}" 
${""?left_pad(indent)}               scroll-y enhanced show-scrollbar="{{ false }}" 
${""?left_pad(indent)}               style="height: {{ ${js.nameVariable(list.id)}Height }}rpx">
${""?left_pad(indent)}    <view wx:for="{{ ${js.nameVariable(list.id)}Groups }}" wx:key="${js.nameVariable(groupUrl.resource)}Id"
${""?left_pad(indent)}      class="split-group-item {{ selected${js.nameType(list.id)}Group === item.${js.nameVariable(groupUrl.resource)}Id ? 'split-group-item-active' : '' }}"
${""?left_pad(indent)}      data-id="{{ item.${js.nameVariable(groupUrl.resource)}Id }}"
${""?left_pad(indent)}      bindtap="handle${js.nameType(list.id)}GroupTap">
${""?left_pad(indent)}      <text class="split-group-name">{{ item.${js.nameVariable(groupUrl.resource)}Name }}</text>
${""?left_pad(indent)}    </view>
${""?left_pad(indent)}  </scroll-view>
${""?left_pad(indent)}  <scroll-view class="split-col-tile" scroll-y enhanced show-scrollbar="{{ false }}"
${""?left_pad(indent)}               style="height: {{ ${js.nameVariable(list.id)}Height }}rpx">
${""?left_pad(indent)}    <view class="split-tile-sec-title">{{ activeDeptName }} · 共 {{ activeDoctors.length }} 位医生</view>
${""?left_pad(indent)}    <view class="list-item" wx:for="{{ ${js.nameVariable(list.id)}Rows }}" wx:for-item="row" data-row="{{ row }}"
${""?left_pad(indent)}          bindtap="handle${js.nameType(list.id)}RowTap">
<@guidbase4tile.print_tile_layout widget=list indent=6 />
${""?left_pad(indent)}    </view>
${""?left_pad(indent)}    <${namespace}-empty wx:if="{{ ${js.nameVariable(list.id)}Rows.length == 0 }}" />
${""?left_pad(indent)}  </scroll-view>
${""?left_pad(indent)}</view>
</#macro>

<!----------------------------------------------------------------------------->
<!--                                LIST VIEW                                -->
<!----------------------------------------------------------------------------->
<#macro print_list_view_layout list indent=0>
  <#local url = valuebase.url(list.value("data"))>
${""?left_pad(indent)}<view>  
${""?left_pad(indent)}  <scroll-view wx:if="{{ ${js.nameVariable(list.id)}Rows.length != 0 }}" 
${""?left_pad(indent)}               scroll-y enhanced show-scrollbar="{{ false }}"
${""?left_pad(indent)}               bindscrolltolower="onReachBottom">
${""?left_pad(indent)}    <view wx:for="{{ ${js.nameVariable(list.id)}Rows }}"
${""?left_pad(indent)}          wx:for-item="row" class="list-item" data-row = "{{ row }}"
${""?left_pad(indent)}          bindtap="handle${js.nameType(list.id)}RowTap">
<@guidbase4tile.print_tile_layout widget=list indent=8 />
${""?left_pad(indent)}    </view>
${""?left_pad(indent)}    <view class="load-more-status">
${""?left_pad(indent)}      <text wx:if="{{ ${js.nameVariable(list.id)}Loading }}">正在加载更多...</text>
${""?left_pad(indent)}      <text wx:elif="{{ ${js.nameVariable(list.id)}Rows.length == ${js.nameVariable(list.id)}Total }}">没有更多数据了</text>
${""?left_pad(indent)}    </view>
${""?left_pad(indent)}  </scroll-view>
${""?left_pad(indent)}  <${namespace}-empty wx:if="{{ ${js.nameVariable(list.id)}Rows.length == 0 }}" />
${""?left_pad(indent)}</view>
</#macro>

<!----------------------------------------------------------------------------->
<!--                                GRID VIEW                                -->
<!----------------------------------------------------------------------------->
<#macro print_grid_view_layout grid indent=0>
  <#local url = valuebase.url(grid.value("data"))>
${""?left_pad(indent)}<view>  
${""?left_pad(indent)}  <scroll-view wx:if="{{ ${js.nameVariable(grid.id)}Rows.length != 0 }}" 
${""?left_pad(indent)}               scroll-y enhanced show-scrollbar="{{ false }}"
${""?left_pad(indent)}               bindscrolltolower="onReachBottom">
${""?left_pad(indent)}    <view class="waterfall-container">
${""?left_pad(indent)}      <view class="waterfall-column">
${""?left_pad(indent)}        <view wx:for="{{ ${js.nameVariable(grid.id)}Rows }}" wx:for-index="index" wx:for-item="row">
${""?left_pad(indent)}          <view class="waterfall-card" wx:if="{{ index % 2 === 0 }}" data-row = "{{ row }}"
${""?left_pad(indent)}                bindtap="handle${js.nameType(grid.id)}RowTap">
<@guidbase4tile.print_tile_layout widget=grid  vertical=true indent=8 />
${""?left_pad(indent)}          </view>
${""?left_pad(indent)}        </view>
${""?left_pad(indent)}      </view>
${""?left_pad(indent)}      <view class="waterfall-column">
${""?left_pad(indent)}        <view wx:for="{{ ${js.nameVariable(grid.id)}Rows }}" wx:for-index="index" wx:for-item="row">
${""?left_pad(indent)}          <view class="waterfall-card" wx:if="{{ index % 2 === 1 }}" data-row = "{{ row }}"
${""?left_pad(indent)}                bindtap="handle${js.nameType(grid.id)}RowTap">
<@guidbase4tile.print_tile_layout widget=grid vertical=true indent=8 />
${""?left_pad(indent)}          </view>
${""?left_pad(indent)}        </view>
${""?left_pad(indent)}      </view>
${""?left_pad(indent)}    </view>
${""?left_pad(indent)}  </scroll-view>
${""?left_pad(indent)}  <${namespace}-empty wx:if="{{ ${js.nameVariable(grid.id)}Rows.length == 0 }}" />
${""?left_pad(indent)}</view>
</#macro>

<!----------------------------------------------------------------------------->
<!--                                 SEGMENTS                                -->
<!----------------------------------------------------------------------------->
<#macro print_segments_layout segments indent=0>
  <#local variable = segments.value("variable", segments.id)>
  <#if segments.value("placement") == "top">
${""?left_pad(indent)}<view class="page-toolbar">
    <#local indent += 2>  
  </#if>
${""?left_pad(indent)}<view class="segments-bar">
${""?left_pad(indent)}  <view class="segments">
  <#list segments.children as child>
${""?left_pad(indent)}    <view class="seg {{ ${js.nameVariable(variable)} === '${child.title}' ? 'seg-on' : '' }}" data-value="${child.title}"
${""?left_pad(indent)}          bindtap="handle${js.nameType(segments.id)}Tap">${child.title}</view>
  </#list>
  <#if segments.value("data") != "">
    <#local opts = typebase.enumtype(segments.value("data"))>
    <#list opts as opt>
${""?left_pad(indent)}    <view class="seg {{ ${js.nameVariable(variable)} === '${opt.text}' ? 'seg-on' : '' }}" data-value="${opt.text}"
${""?left_pad(indent)}          bindtap="handle${js.nameType(segments.id)}Tap">${opt.text}</view>
    </#list>
  </#if>
${""?left_pad(indent)}  </view>
  <#if segments.page.has("criteria_form")>
    <#local form = segments.page.byType("criteria_form")[0]>
${""?left_pad(indent)}  <view class="segments-btn" bindtap="handle${js.nameType(form.id)}Show">
${""?left_pad(indent)}    <text class="segments-btn-arrow {{ ${js.nameVariable(form.id)}Shown ? 'segments-btn-arrow-up' : '' }}">▼</text>
${""?left_pad(indent)}    <text>查询</text>
${""?left_pad(indent)}  </view>
  </#if>
${""?left_pad(indent)}</view>
  <#if segments.value("placement") == "top">
    <#local indent -= 2>
${""?left_pad(indent)}</view>
  </#if>
</#macro>

<!----------------------------------------------------------------------------->
<!--                                   TABS                                  -->
<!----------------------------------------------------------------------------->
<#macro print_tabs_layout tabs indent=0>
${""?left_pad(indent)}<view class="tabs">
  <#list tabs.children as tab>
${""?left_pad(indent)}  <view 
${""?left_pad(indent)}    class="tab-item {{ selected${js.nameType(tabs.id)}Tab === ${tab?index} ? 'active' : '' }}" 
${""?left_pad(indent)}    bindtap="handle${js.nameType(tab.id)}Tap" data-index="{{ ${tab?index} }}">
${""?left_pad(indent)}    <text class="tab-text">${tab.title}</text>
${""?left_pad(indent)}    <view class="tab-underline" wx:if="{{selected${js.nameType(tabs.id)}Tab === index}}"></view>
${""?left_pad(indent)}  </view>
  </#list>
${""?left_pad(indent)}</view>
<#list tabs.children as tab>
${""?left_pad(indent)}<view wx:if="{{ selected${js.nameType(tabs.id)}Tab === ${tab?index} }}">
<@print_widget_layout widget=tab.children[0] indent=indent+2 />
${""?left_pad(indent)}</view>  
  </#list>
</#macro>

<!----------------------------------------------------------------------------->
<!--                              MEDIA CAROUSEL                             -->
<!----------------------------------------------------------------------------->
<#macro print_media_carousel_layout carousel indent=0>
  <#local url = valuebase.url(carousel.value("data"))>
${""?left_pad(indent)}<view class="scroll-navigator">
${""?left_pad(indent)}  <swiper
${""?left_pad(indent)}    indicator-dots="true"
${""?left_pad(indent)}    circular="true">
${""?left_pad(indent)}    <swiper-item>
${""?left_pad(indent)}      <image
${""?left_pad(indent)}        class="banner-image"
${""?left_pad(indent)}        src="https://raw.githubusercontent.com/doublegsoft/tatabase-image/main/1024x768/0028.jpg"
${""?left_pad(indent)}        mode="aspectFill"
${""?left_pad(indent)}        lazy-load="true"/>
${""?left_pad(indent)}    </swiper-item>
${""?left_pad(indent)}    <swiper-item>
${""?left_pad(indent)}      <image
${""?left_pad(indent)}        class="banner-image"
${""?left_pad(indent)}        src="https://raw.githubusercontent.com/doublegsoft/tatabase-image/main/1024x768/0027.jpg"
${""?left_pad(indent)}        mode="aspectFill"
${""?left_pad(indent)}        lazy-load="true"/>
${""?left_pad(indent)}    </swiper-item>
${""?left_pad(indent)}    <swiper-item>
${""?left_pad(indent)}      <image
${""?left_pad(indent)}        class="banner-image"
${""?left_pad(indent)}        src="https://raw.githubusercontent.com/doublegsoft/tatabase-image/main/1024x768/0026.jpg"
${""?left_pad(indent)}        mode="aspectFill"
${""?left_pad(indent)}        lazy-load="true"/>
${""?left_pad(indent)}    </swiper-item>
${""?left_pad(indent)}    <swiper-item>
${""?left_pad(indent)}      <image
${""?left_pad(indent)}        class="banner-image"
${""?left_pad(indent)}        src="https://raw.githubusercontent.com/doublegsoft/tatabase-image/main/1024x768/0025.jpg"
${""?left_pad(indent)}        mode="aspectFill"
${""?left_pad(indent)}        lazy-load="true"/>
${""?left_pad(indent)}    </swiper-item>
${""?left_pad(indent)}  </swiper>
${""?left_pad(indent)}</view>
</#macro>

<!----------------------------------------------------------------------------->
<!--                              LIST SELECTOR                              -->
<!----------------------------------------------------------------------------->
<#macro print_list_selector_layout selector indent=0>
  <#local dataExpr = selector.value("data")>
  <#if dataExpr?starts_with("enum")>
  <#else>
  </#if>
</#macro>

<!----------------------------------------------------------------------------->
<!--                              SELECTOR TILE                              -->
<!----------------------------------------------------------------------------->
<#macro print_selector_tile_layout selector indent=0>
  <#local dataExpr = selector.value("data")>
  <#if dataExpr?starts_with("enum")>
    <#local url = valuebase.url(dataExpr)>
  <#else>
    <#local opts = typebase.enumtype(dataExpr)>
  </#if>
  <#if url??>
  </#if>
  <#if opts??>
  </#if>
</#macro>

<!----------------------------------------------------------------------------->
<!--                                   CARD                                  -->
<!----------------------------------------------------------------------------->
<#macro print_card_layout card indent=0>
  <#local url = valuebase.url(card.value("data"))>
<@guidbase4tile.print_tile_layout widget=card varname=js.nameVariable(url.resource) vertical=false indent=indent />
</#macro>

<!----------------------------------------------------------------------------->
<!--                              OBJECT HEADER                              -->
<!----------------------------------------------------------------------------->
<#macro print_object_header_layout header indent=0>
  <#local url = valuebase.url(header.value("data"))>
<@guidbase4tile.print_tile_layout widget=header varname=js.nameVariable(url.resource) vertical=false indent=indent />
</#macro>