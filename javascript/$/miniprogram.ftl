<#include "tile.ftl">
<#include "util.ftl">
<!----------------------------------------------------------------------------->
<!--                                ENTRY FORM                               -->
<!----------------------------------------------------------------------------->
<#macro print_entry_form_variables form indent=0>
${""?left_pad(indent)}
${""?left_pad(indent)}/**
${""?left_pad(indent)} * ${js.nameVariable(form.id)} 【${form.title!""}】编辑表单相关变量
${""?left_pad(indent)} */
${""?left_pad(indent)}// 表单数据载体
  <#list form.inputs as input>
${""?left_pad(indent)}  ${js.nameVariable(input.id)}: ${guidbase4js.get_primitive_default_value(input)},
  </#list>
${""?left_pad(indent)}// 表单选项数据  
  <#list form.inputs as input>
    <#if (input.type == "select" || input.type == "multiselect")>
      <#if (input.value("data")!"")?starts_with("enum[")>
${""?left_pad(indent)}${js.nameVariable(input.id)}Options: sdk.${js.nameVariable(input.id)}Options,
      <#else>
${""?left_pad(indent)}${js.nameVariable(input.id)}Options: [],    
      </#if>
    </#if>
  </#list>
</#macro>

<#macro print_entry_form_methods form indent=0>
  <#local objname = form.value("object", form.id)>
${""?left_pad(indent)}  
${""?left_pad(indent)}/**
${""?left_pad(indent)} * 加载【${form.title!""}】编辑表单数据的界面函数
${""?left_pad(indent)} */
${""?left_pad(indent)}load${js.nameType(form.id)}Data: async function () {
${""?left_pad(indent)}  try {
${""?left_pad(indent)}    const data = await sdk.fetch${js.nameType(objname)}()
${""?left_pad(indent)}    this.setData({ 
  <#list form.inputs as input>
${""?left_pad(indent)}      ${js.nameVariable(input.id)}: data.${js.nameVariable(input.id)},   
  </#list>
  <#list form.inputs as input>
    <#if input.type == "select">
${""?left_pad(indent)}      ${js.nameVariable(input.id)}Label: null,   
    </#if>
  </#list>
${""?left_pad(indent)}    });
${""?left_pad(indent)}  } catch (error) {
${""?left_pad(indent)}    fb.error('发生错误', error)
${""?left_pad(indent)}  } finally {
${""?left_pad(indent)}    
${""?left_pad(indent)}  }
${""?left_pad(indent)}},
${""?left_pad(indent)}
${""?left_pad(indent)}/**
${""?left_pad(indent)} * 保存【${form.title!""}】编辑表单数据
${""?left_pad(indent)} */
${""?left_pad(indent)}save${js.nameType(form.id)}Data: async function () {
${""?left_pad(indent)}  if (!validate${js.nameType(form.id)}(${js.nameVariable(form.id)}Data)) {
${""?left_pad(indent)}    const msgs = Object.entries(${js.nameVariable(form.id)}Errors)
${""?left_pad(indent)}      .filter(([, msg]) => msg)
${""?left_pad(indent)}      .map(([, msg]) => `· ${r"${msg}"}`)
${""?left_pad(indent)}    ${js.nameVariable(form.id)}ErrorMessage.value = msgs.join('\n')
${""?left_pad(indent)}    ${js.nameVariable(form.id)}ErrorShow.value = true
${""?left_pad(indent)}    return
${""?left_pad(indent)}  }
${""?left_pad(indent)}  is${js.nameType(form.id)}Submitting.value = true
${""?left_pad(indent)}  try {
${""?left_pad(indent)}    const result = await sdk.save${js.nameType(form.value("object",form.id))}(${js.nameVariable(form.id)}Data)
${""?left_pad(indent)}    if (result.success) {
${""?left_pad(indent)}      fb.success('成功', '保存成功');
${""?left_pad(indent)}    }
${""?left_pad(indent)}  } catch (error) {
${""?left_pad(indent)}    fb.error('发生错误', error)
${""?left_pad(indent)}  } finally {
${""?left_pad(indent)}    is${js.nameType(form.id)}Submitting.value = false
${""?left_pad(indent)}  }
${""?left_pad(indent)}},
  <#list form.inputs as input>
${""?left_pad(indent)}
    <#if input.type == "multiselect">
${""?left_pad(indent)}handle${js.nameType(input.id)}Tap: function (event) {
${""?left_pad(indent)}  let values = this.data.${js.nameVariable(input.id)}.slice();
${""?left_pad(indent)}  let value = event.currentTarget.dataset.id;
${""?left_pad(indent)}  const index = values.indexOf(value);
${""?left_pad(indent)}  if (index !== -1) {
${""?left_pad(indent)}    values.splice(index, 1);
${""?left_pad(indent)}  } else {
${""?left_pad(indent)}    values.push(value);
${""?left_pad(indent)}  }
${""?left_pad(indent)}  this.setData({
${""?left_pad(indent)}    ${js.nameVariable(input.id)}: values,
${""?left_pad(indent)}  });
${""?left_pad(indent)}},      
    <#else>
${""?left_pad(indent)}handle${js.nameType(input.id)}Change: function (event) {
${""?left_pad(indent)}  this.setData({
      <#if input.type == "select">   
${""?left_pad(indent)}    ${js.nameVariable(input.id)}: this.data.${js.nameVariable(input.id)}Options[parseInt(event.detail.value)].value,
${""?left_pad(indent)}    ${js.nameVariable(input.id)}Label: this.data.${js.nameVariable(input.id)}Options[parseInt(event.detail.value)].label,
      <#else>
${""?left_pad(indent)}    ${js.nameVariable(input.id)}: event.detail.value
      </#if>   
${""?left_pad(indent)}  });
${""?left_pad(indent)}},  
    </#if>
  </#list>
</#macro>

<!----------------------------------------------------------------------------->
<!--                               DISPLAY FORM                              -->
<!----------------------------------------------------------------------------->
<#macro print_display_form_variables form indent=0>
${""?left_pad(indent)}
${""?left_pad(indent)}/**
${""?left_pad(indent)} * ${js.nameVariable(form.id)} 【${form.title!""}】只读表单相关变量
${""?left_pad(indent)} */
  <#list form.inputs as input>
${""?left_pad(indent)}${js.nameVariable(input.id)}: ${guidbase4js.get_primitive_default_value(input)},
  </#list>
</#macro>

<#macro print_display_form_methods form indent=0>
${""?left_pad(indent)}
${""?left_pad(indent)}/**
${""?left_pad(indent)} * 加载【${form.title!""}】只读表单数据的界面函数
${""?left_pad(indent)} */
${""?left_pad(indent)}load${js.nameType(form.id)}Data: async function () {
${""?left_pad(indent)}  try {
${""?left_pad(indent)}    const data = await sdk.fetch${js.nameType(form.value("object", form.id))}()
${""?left_pad(indent)}    this.setData({ 
  <#list form.inputs as input>
${""?left_pad(indent)}      ${js.nameVariable(input.id)}: data.${js.nameVariable(input.id)},   
  </#list>
${""?left_pad(indent)}    });
${""?left_pad(indent)}  } catch (error) {
${""?left_pad(indent)}    fb.error('发生错误', error.message || String(error))
${""?left_pad(indent)}  } finally {
${""?left_pad(indent)}    
${""?left_pad(indent)}  }
${""?left_pad(indent)}}
</#macro>

<!----------------------------------------------------------------------------->
<!--                                   PAGE                                  -->
<!----------------------------------------------------------------------------->
<#macro print_page_layout page indent=0>
  <#local children = []>
  <#list page.children as child>
<@print_layout_widget widget=child indent=indent />        
  </#list>
</#macro>

<#macro print_page_variables page indent=0>
  <#list page.widgets as widget>
    <#if widget.type == 'drawer'>
${""?left_pad(indent)}const ${java.nameVariable(widget.id)}DrawerOpen = ref(false)        
    <#elseif widget.type == 'dialog'>
${""?left_pad(indent)}const ${java.nameVariable(widget.id)}DialogOpen = ref(false)    
    <#elseif widget.type == 'tabs'>
<@print_tabs_variables tabs=widget indent=indent />
    <#elseif widget.type == 'entry_form'>
<@print_entry_form_variables form=widget indent=indent />
    <#elseif widget.type == 'official_form'>
<@print_official_form_variables form=widget indent=indent />
    <#elseif widget.type == 'excel_form'>
<@print_excel_form_variables form=widget indent=indent />
    <#elseif widget.type == 'criteria_form'>
<@print_criteria_form_variables form=widget indent=indent />
    <#elseif widget.type == 'display_form'>
<@print_display_form_variables form=widget indent=indent />
    <#elseif widget.type == 'paged_table'>
<@print_paged_table_variables table=widget indent=indent />
    <#elseif widget.type == 'fixed_table'>
<@print_fixed_table_variables table=widget indent=indent />
    <#elseif widget.type == 'paged_grid'>
<@print_paged_grid_variables grid=widget indent=indent />
    <#elseif widget.type == 'time_grid'>
<@print_time_grid_variables grid=widget indent=indent />
    <#elseif widget.type == 'list_view'>
<@print_list_view_variables list=widget indent=indent />
    <#elseif widget.type == "chart">
<@print_chart_variables chart=widget indent=indent />
    </#if>
  </#list>
</#macro>

<#macro print_page_methods page indent=0>
  <#list page.widgets as widget>
    <#if widget.type == 'tabs'>
<@print_tabs_methods tabs=widget indent=indent />
    <#elseif widget.type == 'entry_form'>
<@print_entry_form_methods form=widget indent=indent />
    <#elseif widget.type == 'display_form'>
<@print_display_form_methods form=widget indent=indent />
    <#elseif widget.type == 'excel_form'>
<@print_excel_form_methods form=widget indent=indent />
    <#elseif widget.type == 'paged_table'>
<@print_paged_table_methods table=widget indent=indent />
    <#elseif widget.type == 'fixed_table'>
<@print_fixed_table_methods table=widget indent=indent />
    <#elseif widget.type == 'paged_grid'>
<@print_paged_grid_methods grid=widget indent=indent />
    <#elseif widget.type == 'time_grid'>
<@print_time_grid_methods grid=widget indent=indent />
    <#elseif widget.type == 'list_view'>
<@print_list_view_methods list=widget indent=indent />
    <#elseif widget.type == "chart">
<@print_chart_methods chart=widget indent=indent />
    <#elseif widget.type == 'button'>
<#--  <@print_paged_button_methods button=widget indent=indent />  -->
    </#if>
  </#list>
  <#list page.widgets as widget>
    <#if widget.type != "paged_table"><#continue></#if>
${""?left_pad(indent)}const ${js.nameVariable(widget.id)}RowActionHandlers = { 
    <#list widget.widgets as button>     
      <#if button.type != "button"><#continue></#if>
${""?left_pad(indent)}  ${get_button_method_name(button)}, 
    </#list>
${""?left_pad(indent)}}
${""?left_pad(indent)}const handle${js.nameType(widget.id)}RowAction = ({ handler, row, index }) => {
${""?left_pad(indent)}  ${js.nameVariable(widget.id)}RowActionHandlers[handler]?.(row, index)
${""?left_pad(indent)}}    
  </#list>
</#macro>

<#macro print_layout_widget widget indent=0>
  <#local isRequired = widget.value("required", "false")>
  <#local isReadonly = widget.value("readonly", "false")>
  <#local isLast = true>
  <#-- 动态构建控件根节点的辅助类 -->
  <#local stateClasses = "">
  <#if isRequired == "true"><#local stateClasses = stateClasses + " field-required"></#if>
  <#--  <#if isLast><#local stateClasses = stateClasses + " field-last"></#if>  -->
  <#if widget.type == "entry_form">
<@print_layout_entry_form form=widget indent=indent />
  <#elseif widget.type == "display_form">
<@print_layout_display_form form=widget indent=indent />
  <#elseif widget.type == "avatar">
${""?left_pad(indent)}<!-- 头像 — 居中 -->
${""?left_pad(indent)}<view class="avatar-upload${stateClasses}" bindtap="onAvatarUpload" data-field="${widget.id}">
${""?left_pad(indent)}  <view class="avatar avatar-teal avatar-xl">
${""?left_pad(indent)}    <text>👤</text>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}  <text class="mt-6 color-teal text-sm" style="font-weight:var(--weight-semibold);">点击上传头像</text>
${""?left_pad(indent)}</view>
  <#elseif widget.type == "date">
${""?left_pad(indent)}<picker class="${stateClasses?trim}" mode="date" value="{{ ${js.nameVariable(widget.id)} }}" bindchange="handle${js.nameType(widget.id)}Change">
${""?left_pad(indent)}  <view class="field-control">
${""?left_pad(indent)}    <text class="{{ ${js.nameVariable(widget.id)} ? 'field-value' : 'field-placeholder' }}">{{ ${js.nameVariable(widget.id)} || '请选择日期' }}</text>
${""?left_pad(indent)}    <text class="field-arrow">▾</text>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}</picker>
  <#elseif widget.type == "time">
${""?left_pad(indent)}<picker class="${stateClasses?trim}" mode="time" value="{{ ${js.nameVariable(widget.id)} }}" bindchange="handle${js.nameType(widget.id)}Change">
${""?left_pad(indent)}  <view class="field-control">
${""?left_pad(indent)}    <text class="{{ ${js.nameVariable(widget.id)} ? 'field-value' : 'field-placeholder' }}">{{ ${js.nameVariable(widget.id)} || '请选择时间' }}</text>
${""?left_pad(indent)}    <text class="field-arrow">▾</text>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}</picker>
  <#elseif widget.type == "text" || widget.type == "number">
    <#local suffix = widget.value("suffix", "")>
    <#if suffix != "">
${""?left_pad(indent)}<view class="field-with-suffix${stateClasses}">
${""?left_pad(indent)}  <input class="field-input field-input-suffix<#if isReadonly == "true"> field-input-ro</#if>" <#if widget.type == "number">type="digit"</#if> placeholder="请输入${widget.title}" value="{{ ${js.nameVariable(widget.id)} }}" bindinput="handle${js.nameType(widget.id)}Change"<#if isReadonly == "true"> disabled="true"</#if> />
${""?left_pad(indent)}  <text class="field-suffix<#if isReadonly == "true"> field-suffix-ro</#if>">${suffix}</text>
${""?left_pad(indent)}</view>
    <#else>
${""?left_pad(indent)}<input class="field-input<#if isReadonly == "true"> field-input-ro</#if>${stateClasses}" <#if widget.type == "number">type="digit"</#if> placeholder="请输入${widget.title}" value="{{ ${js.nameVariable(widget.id)} }}" bindinput="handle${js.nameType(widget.id)}Change"<#if isReadonly == "true"> disabled="true"</#if> />
    </#if>
  <#elseif widget.type == "select">
${""?left_pad(indent)}<picker class="${stateClasses?trim}" range="{{ ${js.nameVariable(widget.id)}Options }}" range-key="label" value="{{ ${js.nameVariable(widget.id)} }}" bindchange="handle${js.nameType(widget.id)}Change">
${""?left_pad(indent)}  <view class="field-control">
${""?left_pad(indent)}    <text class="{{ ${js.nameVariable(widget.id)} ? 'field-value' : 'field-placeholder' }}">{{ ${js.nameVariable(widget.id)}Label || '请选择' }}</text>
${""?left_pad(indent)}    <text class="field-arrow">▾</text>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}</picker>
  <#elseif widget.type == "cascade">
${""?left_pad(indent)}<picker class="${stateClasses?trim}" mode="multiSelector" range="{{cascadeData.${js.nameVariable(widget.id)}}}" value="{{formData.${js.nameVariable(widget.id)}Idx}}" bindchange="handle${js.nameType(widget.id)}Change" bindcolumnchange="onCascadeColumnChange">
${""?left_pad(indent)}  <view class="field-control">
${""?left_pad(indent)}    <text class="{{ ${js.nameVariable(widget.id)} ? 'field-value' : 'field-placeholder' }}">{{formData.${js.nameVariable(widget.id)} || '请选择级联'}}</text>
${""?left_pad(indent)}    <text class="field-arrow">▾</text>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}</picker>
  <#elseif widget.type == "multiselect">
${""?left_pad(indent)}<view class="option-chips${stateClasses}">
${""?left_pad(indent)}  <view class="option-chip {{ h.has(${js.nameVariable(widget.id)}, item.value) ? 'option-chip-on' : '' }}" 
${""?left_pad(indent)}        wx:for="{{ ${js.nameVariable(widget.id)}Options }}" wx:key="value" 
${""?left_pad(indent)}        bindtap="handle${js.nameType(widget.id)}Tap" data-id="{{ item.value }}">
${""?left_pad(indent)}    <text wx:if="{{ h.has(${js.nameVariable(widget.id)}, item.value) }}" class="option-chip-check">✓</text>
${""?left_pad(indent)}    <text>{{ item.label }}</text>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}</view>
  <#elseif widget.type == "tags">
${""?left_pad(indent)}<view class="flex flex-wrap${stateClasses}" style="gap:10rpx;">
${""?left_pad(indent)}  <view class="tag tag-teal" wx:for="{{formData.${js.nameVariable(widget.id)}}}" wx:key="*this" bindtap="handle${js.nameType(widget.id)}Remove" data-idx="{{ index }}">
${""?left_pad(indent)}    {{item}} <text style="font-weight:var(--weight-bold);opacity:0.5;">×</text>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}  <view class="tag tag-gray tag-add" bindtap="handle${js.nameType(widget.id)}Add">+ 添加</view>
${""?left_pad(indent)}</view>
  <#elseif widget.type == "longtext">
${""?left_pad(indent)}<textarea class="field-textarea${stateClasses}" placeholder="请输入${widget.title}内容" value="{{formData.${js.nameVariable(widget.id)}}}" bindinput="handle${js.nameType(widget.id)}Change" maxlength="${widget.value("maxlength", "300")}" />
  <#elseif widget.type == "images">
${""?left_pad(indent)}<view class="upload-row${stateClasses}">
${""?left_pad(indent)}  <view class="upload-card" wx:for="{{formData.${js.nameVariable(widget.id)}}}" wx:key="*this">
${""?left_pad(indent)}    <image class="upload-card-img" src="{{item}}" mode="aspectFill" />
${""?left_pad(indent)}    <view class="upload-card-del" bindtap="handle${js.nameType(widget.id)}Remove" data-idx="{{index}}">✕</view>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}  <view class="upload-card upload-card-add" bindtap="handle${js.nameType(widget.id)}Add">
${""?left_pad(indent)}    <text class="upload-card-plus">+</text>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}</view>
  <#elseif widget.type == "videos">
${""?left_pad(indent)}<view class="upload-row${stateClasses}">
${""?left_pad(indent)}  <view class="upload-card upload-card-wide" wx:for="{{formData.${js.nameVariable(widget.id)}}}" wx:key="*this">
${""?left_pad(indent)}    <view class="upload-card-video">
${""?left_pad(indent)}      <text style="font-size:48rpx;">▶</text>
${""?left_pad(indent)}    </view>
${""?left_pad(indent)}    <view class="upload-card-del" bindtap="handle${js.nameType(widget.id)}Remove" data-idx="{{index}}">✕</view>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}  <view class="upload-card upload-card-add" bindtap="handle${js.nameType(widget.id)}Add">
${""?left_pad(indent)}    <text class="upload-card-plus">+</text>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}</view>
  <#elseif widget.type == "files">
${""?left_pad(indent)}<view class="file-list${stateClasses}">
${""?left_pad(indent)}  <view class="file-row" wx:for="{{formData.${js.nameVariable(widget.id)}}}" wx:key="name">
${""?left_pad(indent)}    <text class="file-row-icon">📄</text>
${""?left_pad(indent)}    <text class="file-row-name">{{item.name}}</text>
${""?left_pad(indent)}    <text class="file-row-del" bindtap="handle${js.nameType(widget.id)}Remove" data-idx="{{index}}">✕</text>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}  <view class="file-add" bindtap="handle${js.nameType(widget.id)}Add">+ 添加文件</view>
${""?left_pad(indent)}</view>
  <#else>
<#--  <@print_layout_custom widget=widget indent=indent />    -->
  </#if>
</#macro>