<#--
 ###############################################################################
 ### 【编辑表单】
 ###############################################################################
 -->
<#macro print_js_declare_editable_form widget indent>
${""?left_pad(indent)}<gx-two-column-form fields="{{fields${js.nameType(widget.id)}}}" 
${""?left_pad(indent)}                    data="{{values${js.nameType(widget.id)}}}" 
${""?left_pad(indent)}                    id="form${js.nameType(widget.id)}"
${""?left_pad(indent)}                    bind:onSubmit="doSaveForm${js.nameType(widget.id)}" 
${""?left_pad(indent)}                    labelWidth="150" />
</#macro>

<#macro print_js_fields_editable_form widget indent>
${""?left_pad(indent)}values${js.nameType(widget.id)}: {},
  <#assign fieldIndex = 0>
${""?left_pad(indent)}fields${js.nameType(widget.id)}: [{
  <#list widget.children as field>
    <#assign input = field['input']!'text'>
    <#if input == 'none' || input == 'constant' || input == 'id'><#continue></#if>
    <#assign name = field.id!"unset">
    <#if name?starts_with('meta_')>
      <#assign name = field['title']>
    <#else>
      <#assign name = field.id>
    </#if>
    <#if fieldIndex != 0>
${""?left_pad(indent)}},{
    </#if>
${""?left_pad(indent)}  title: "${field['title']}",
    <#if input == 'select'>
      <#if field['local']??>
        <#assign strs = field['local']?replace('[',"")?replace(']',"")?split(',')>
${""?left_pad(indent)}  name: '${name}',
${""?left_pad(indent)}  input: 'select',
${""?left_pad(indent)}  options: {
${""?left_pad(indent)}    values: [
        <#list strs as str>
${""?left_pad(indent)}      {value: '${str?substring(0, str?index_of(':'))?trim}', text: '${str?substring(str?index_of(':') + 1)?trim}', <#if str?index == 0>checked: true,</#if>},
        </#list>
${""?left_pad(indent)}    ],
${""?left_pad(indent)}  },
      <#elseif field.domainType?? && field.domainType?starts_with("&")>
        <#assign objname = field.domainType?substring(1, field.domainType?index_of('('))>
        <#assign attrname = field.domainType?substring(field.domainType?index_of('(') + 1, field.domainType?index_of(')'))>
${""?left_pad(indent)}  input: "select",
        <#if field.variant == js.nameVariable(objname)>
${""?left_pad(indent)}  name: "${js.nameVariable(objname) + js.nameType(attrname)}",
        <#else>
${""?left_pad(indent)}  name: "${field.variant}${js.nameType(objname)}${js.nameType(attrname)}",
        </#if>
${""?left_pad(indent)}  options: {
        <#if field['remote']??>
${""?left_pad(indent)}    url: '${field['remote']}',
        <#else>
${""?left_pad(indent)}    url: '/api/v3/common/script/${'stdbiz/' + field.parentPersistenceName?split('_')[1] + '/' + objname + '/find'}',
        </#if>
${""?left_pad(indent)}    fields: {
${""?left_pad(indent)}      value: "${js.nameVariable(objname)}${js.nameType(attrname)}",
${""?left_pad(indent)}      text: "${js.nameVariable(objname)}Name",
${""?left_pad(indent)}    },
${""?left_pad(indent)}  },
      <#else>
${""?left_pad(indent)}  name: '${name}',
${""?left_pad(indent)}  input: 'select',
${""?left_pad(indent)}  options: sdk.options['${name}'],
      </#if>
    <#elseif input == 'radio'>
${""?left_pad(indent)}  name: '${name}',
${""?left_pad(indent)}  input: 'radio',
${""?left_pad(indent)}  options: ${app.name}.options['${name}'],
    <#elseif input == 'check'>
${""?left_pad(indent)}  name: '${name}',
${""?left_pad(indent)}  input: 'check',
${""?left_pad(indent)}  options: ${app.name}.options['${name}'],
    <#else>
${""?left_pad(indent)}  name: '${name}',
${""?left_pad(indent)}  input: '${field.input!'text'}',
    </#if>
    <#if field['required']!false == true>
${""?left_pad(indent)}  required: true,
    </#if>
    <#if field.unit?? && field.unit != "">
${""?left_pad(indent)}  unit: '${field.unit}',
    </#if>
    <#assign fieldIndex = fieldIndex + 1>
  </#list>
${""?left_pad(indent)}}],
</#macro>

<#macro print_js_methods_editable_form widget indent>
  <#assign fieldIds = []>
  <#assign pageName = page.id>
${""?left_pad(indent)}/**
${""?left_pad(indent)} * 提交【${widget.id}】表单。
${""?left_pad(indent)} */
${""?left_pad(indent)}doSaveForm${js.nameType(widget.id)}: async function () {
${""?left_pad(indent)}  try {
${""?left_pad(indent)}    let data = await ${app.name}.${'save' + js.nameType(widget.id) + '4' + js.nameType(pageName)}(this.data.values${js.nameType(widget.id)});
${""?left_pad(indent)}    wx.showToast({title: '数据保存成功！', icon: 'success'});
${""?left_pad(indent)}  } catch (err) {
${""?left_pad(indent)}    wx.showToast({title: err, icon: 'error'});
${""?left_pad(indent)}  }
${""?left_pad(indent)}},

${""?left_pad(indent)}/**
${""?left_pad(indent)} * 加载【${widget.id}】数据到表单。
${""?left_pad(indent)} */
${""?left_pad(indent)}doReadForm${js.nameType(widget.id)}: async function (id) {
${""?left_pad(indent)}  let data = await ${app.name}.${'read' + js.nameType(widget.id) + '4' + js.nameType(pageName)}(id);
${""?left_pad(indent)}
${""?left_pad(indent)}  if (data.error) {
${""?left_pad(indent)}    wx.showToast({
${""?left_pad(indent)}      icon: "error",
${""?left_pad(indent)}      title: "程序出错啦！",
${""?left_pad(indent)}    });
${""?left_pad(indent)}    return;
${""?left_pad(indent)}  }
${""?left_pad(indent)}
${""?left_pad(indent)}  this.form${js.nameType(widget.id)} = this.selectComponent('#form${js.nameType(widget.id)}');
${""?left_pad(indent)}  this.form${js.nameType(widget.id)}.setValues(data);
${""?left_pad(indent)}},
</#macro>

<#macro print_wxml_declare_editable_form widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_json_declare_editable_form widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#--
 ###############################################################################
 ### 【只读表单】
 ###############################################################################
 -->
<#macro print_js_declare_readonly_form widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_js_fields_readonly_form widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_js_methods_readonly_form widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_wxml_declare_readonly_form widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_json_declare_readonly_form widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#--
 ###############################################################################
 ### 【分页页签】
 ###############################################################################
 -->
<#macro print_js_declare_tabs widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_js_fields_tabs widget indent>
${""?left_pad(indent)}tabs${js.nameType(widget.id!'todo')}: [<#list widget.items as item>"${item.title}",</#list>],
${""?left_pad(indent)}tabIndex: 0,
</#macro>

<#macro print_js_methods_tabs widget indent>
${""?left_pad(indent)}doChange${js.nameType(widget.id!'todo')}(ev) {
${""?left_pad(indent)}  //
${""?left_pad(indent)}},
</#macro>

<#macro print_wxml_declare_tabs widget indent>
${""?left_pad(indent)}<tabs tabsList="{{tabs${js.nameType(widget.id!'todo')}}}" bind:change="doChange${js.nameType(widget.id!'todo')}">
  <#list widget.items![] as item>
${""?left_pad(indent)}  <view slot="tab-cont-${item?index}" style="width: 100%;">
${""?left_pad(indent)}    <page-${(item.url!'todo')?substring((item.url!'todo')?index_of("/") + 1)?replace("/", "-")}></page-${(item.url!'todo')?substring((item.url!'todo')?index_of("/") + 1)?replace("/", "-")}>
${""?left_pad(indent)}  </view>
  </#list>
${""?left_pad(indent)}</tabs>
</#macro>

<#macro print_json_declare_tabs widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#--
 ###############################################################################
 ### 【通知公告】
 ###############################################################################
 -->
<#macro print_js_declare_scroll_notification widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_js_fields_scroll_notification widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_js_methods_scroll_notification widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_wxml_declare_scroll_notification widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_json_declare_scroll_notification widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#--
 ###############################################################################
 ### 【滚动导航】
 ###############################################################################
 -->
<#macro print_js_declare_swiper_navigator widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_js_fields_swiper_navigator widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_js_methods_swiper_navigator widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_wxml_declare_swiper_navigator widget indent>
${""?left_pad(indent)}<view class="px-2" style="height: 120px;">
${""?left_pad(indent)}  <swiper indicator-dots="{{false}}" autoplay="{{true}}" interval="{{3000}}" duration="{{500}}" circular="{{true}}" indicator-color="#D8D8D8" indicator-active-color="#3F86FF">
${""?left_pad(indent)}    <swiper-item wx:for="{{items${js.nameType(widget.id)}}}">
${""?left_pad(indent)}      <navigator url="/page/{{item.url}}" class="swiper-item">
${""?left_pad(indent)}        <image class="banner-img" src="{{item.image}}" mode="widthFix" style="width: 100%;"></image>
${""?left_pad(indent)}      </navigator>
${""?left_pad(indent)}    </swiper-item>
${""?left_pad(indent)}  </swiper>
${""?left_pad(indent)}</view>
</#macro>

<#macro print_json_declare_swiper_navigator widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#--
 ###############################################################################
 ### 【滑动导航】
 ###############################################################################
 -->
<#macro print_js_declare_scroll_navigator widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_js_fields_scroll_navigator widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_js_methods_scroll_navigator widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_wxml_declare_scroll_navigator widget indent>
${""?left_pad(indent)}<view class="px-2" style="height: 80px;">
${""?left_pad(indent)}  <swiper display-multiple-items="3" indicator-dots="{{false}}" autoplay="{{false}}" circular="{{true}}" indicator-color="#D8D8D8" indicator-active-color="#3F86FF">
${""?left_pad(indent)}    <swiper-item wx:for="{{items${js.nameType(widget.id)}}}">
${""?left_pad(indent)}      <navigator url="/page/{{item.url}}" class="swiper-item mx-1">
${""?left_pad(indent)}        <image class="banner-img" src="{{item.image}}" mode="widthFix" style="width: 100%;"></image>
${""?left_pad(indent)}      </navigator>
${""?left_pad(indent)}    </swiper-item>
${""?left_pad(indent)}  </swiper>
${""?left_pad(indent)}</view>
</#macro>

<#macro print_json_declare_scroll_navigator widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#--
 ###############################################################################
 ### 【列表导航】
 ###############################################################################
 -->
<#macro print_js_declare_list_navigator widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_js_fields_list_navigator widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_js_methods_list_navigator widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_wxml_declare_list_navigator widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_json_declare_list_navigator widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#--
 ###############################################################################
 ### 【事件日历】
 ###############################################################################
 -->
<#macro print_js_declare_calendar widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_js_fields_calendar widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_js_methods_calendar widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_wxml_declare_calendar widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_json_declare_calendar widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#--
 ###############################################################################
 ### 【树型结构】
 ###############################################################################
 -->
<#macro print_js_declare_tree widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_js_fields_tree widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_js_methods_tree widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_wxml_declare_tree widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_json_declare_tree widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#--
 ###############################################################################
 ### 【传统列表】
 ###############################################################################
 -->
<#macro print_js_declare_list_view widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_js_fields_list_view widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_js_methods_list_view widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_wxml_declare_list_view widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_json_declare_list_view widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#--
 ###############################################################################
 ### 【栅格列表】
 ###############################################################################
 -->
<#macro print_js_declare_grid_view widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_js_fields_grid_view widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_js_methods_grid_view widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_wxml_declare_grid_view widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_json_declare_grid_view widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#--
 ###############################################################################
 ### 【时间线条】
 ###############################################################################
 -->
<#macro print_js_declare_timeline widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_js_fields_timeline widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_js_methods_timeline widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_wxml_declare_timeline widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_json_declare_timeline widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#--
 ###############################################################################
 ### 【分页表格】
 ###############################################################################
 -->
<#macro print_js_declare_pagination_table widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_js_fields_pagination_table widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_js_methods_pagination_table widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_wxml_declare_pagination_table widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_json_declare_pagination_table widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#--
 ###############################################################################
 ### 【分页栅格】
 ###############################################################################
 -->
<#macro print_js_declare_pagination_grid widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_js_fields_pagination_grid widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_js_methods_pagination_grid widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_wxml_declare_pagination_grid widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_json_declare_pagination_grid widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#--
 ###############################################################################
 ### 【广义表格】
 ###############################################################################
 -->
<#macro print_js_declare_spreadsheet widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_js_fields_spreadsheet widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_js_methods_spreadsheet widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_wxml_declare_spreadsheet widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_json_declare_spreadsheet widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#--
 ###############################################################################
 ### 【看板列表】
 ###############################################################################
 -->
<#macro print_js_declare_kanban widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_js_fields_kanban widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_js_methods_kanban widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_wxml_declare_kanban widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_json_declare_kanban widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#--
 ###############################################################################
 ### 【聊天列表】
 ###############################################################################
 -->
<#macro print_js_declare_chat widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_js_fields_chat widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_js_methods_chat widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_wxml_declare_chat widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_json_declare_chat widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#--
 ###############################################################################
 ### 【饼状图】
 ###############################################################################
 -->
<#macro print_js_declare_pie_chart widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_js_fields_pie_chart widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_js_methods_pie_chart widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_wxml_declare_pie_chart widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_json_declare_pie_chart widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#--
 ###############################################################################
 ### 【圈状图】
 ###############################################################################
 -->
<#macro print_js_declare_donut_chart widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_js_fields_donut_chart widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_js_methods_donut_chart widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_wxml_declare_donut_chart widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_json_declare_donut_chart widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#--
 ###############################################################################
 ### 【柱状图】
 ###############################################################################
 -->
<#macro print_js_declare_bar_chart widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_js_fields_bar_chart widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_js_methods_bar_chart widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_wxml_declare_bar_chart widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_json_declare_bar_chart widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#--
 ###############################################################################
 ### 【折线图】
 ###############################################################################
 -->
<#macro print_js_declare_line_chart widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_js_fields_line_chart widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_js_methods_line_chart widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_wxml_declare_line_chart widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_json_declare_line_chart widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#--
 ###############################################################################
 ### 【堆栈图】
 ###############################################################################
 -->
<#macro print_js_declare_stack_chart widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_js_fields_stack_chart widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_js_methods_stack_chart widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_wxml_declare_stack_chart widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_json_declare_stack_chart widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#--
 ###############################################################################
 ### 【雷达图】
 ###############################################################################
 -->
<#macro print_js_declare_radar_chart widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_js_fields_radar_chart widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_js_methods_radar_chart widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_wxml_declare_radar_chart widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_json_declare_radar_chart widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#--
 ###############################################################################
 ### 【网络拓扑图】
 ###############################################################################
 -->
<#macro print_js_declare_network_topology_diagram widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_js_fields_network_topology_diagram widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_js_methods_network_topology_diagram widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_wxml_declare_network_topology_diagram widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_json_declare_network_topology_diagram widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#--
 ###############################################################################
 ### 【业务流程图】
 ###############################################################################
 -->
<#macro print_js_declare_business_process_diagram widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_js_fields_business_process_diagram widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_js_methods_business_process_diagram widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_wxml_declare_business_process_diagram widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_json_declare_business_process_diagram widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>
