<#macro print_axml_declare_cyclenavigator widget indent>
${''?left_pad(indent)}<view class="px-2" style="height: 120px;">
${''?left_pad(indent)}  <swiper indicator-dots="{{false}}" autoplay="{{true}}" interval="{{3000}}" duration="{{500}}" circular="{{true}}" indicator-color="#D8D8D8" indicator-active-color="#3F86FF">
${''?left_pad(indent)}    <swiper-item a:for="{{items${js.nameType(widget.variable)}}}">
${''?left_pad(indent)}      <navigator url="/page/{{item.url}}" class="swiper-item">
${''?left_pad(indent)}        <image class="banner-img" src="{{item.image}}" mode="widthFix" style="width: 100%;"></image>
${''?left_pad(indent)}      </navigator>
${''?left_pad(indent)}    </swiper-item>
${''?left_pad(indent)}  </swiper>
${''?left_pad(indent)}</view>
</#macro>

<#macro print_axml_declare_scrollnavigator widget indent>
${''?left_pad(indent)}<view class="px-2" style="height: 80px;">
${''?left_pad(indent)}  <swiper display-multiple-items="3" indicator-dots="{{false}}" autoplay="{{false}}" circular="{{true}}" indicator-color="#D8D8D8" indicator-active-color="#3F86FF">
${''?left_pad(indent)}    <swiper-item a:for="{{items${js.nameType(widget.variable)}}}">
${''?left_pad(indent)}      <navigator url="/page/{{item.url}}" class="swiper-item mx-1">
${''?left_pad(indent)}        <image class="banner-img" src="{{item.image}}" mode="widthFix" style="width: 100%;"></image>
${''?left_pad(indent)}      </navigator>
${''?left_pad(indent)}    </swiper-item>
${''?left_pad(indent)}  </swiper>
${''?left_pad(indent)}</view>
</#macro>

<#macro print_axml_declare_columnnavigator widget indent>
${''?left_pad(indent)}<view class="row mx-2 px-1" style="height: 180px;">
${''?left_pad(indent)}  <view class="col-24-12 pr-1">
${''?left_pad(indent)}    <image src="{{items${js.nameType(widget.variable)}.primary.image}}" style="width: 100%; height: 100%;"></image>
${''?left_pad(indent)}  </view>
${''?left_pad(indent)}  <view class="col-24-12">
${''?left_pad(indent)}    <view class="pl-1 pb-1" style="width: 100%; height: 50%;">
${''?left_pad(indent)}      <image src="{{items${js.nameType(widget.variable)}.secondary.image}}" style="width: 100%; height: 100%;"></image>
${''?left_pad(indent)}    </view>
${''?left_pad(indent)}    <view class="pl-1 pt-1" style="width: 100%; height: 50%;">
${''?left_pad(indent)}      <image src="{{items${js.nameType(widget.variable)}.tertiary.image}}" style="width: 100%; height: 100%;"></image>
${''?left_pad(indent)}    </view>
${''?left_pad(indent)}  </view>
${''?left_pad(indent)}</view>
</#macro>

<#macro print_axml_declare_gridnavigator widget indent>
${''?left_pad(indent)}<view class="square-menu">
  <#list widget.items as item>
    <#assign url = 'todo'>
    <#assign icon = '/static/image/ic_menu_sort_nor.png'>
    <#if item.url??>
      <#assign url = item.url?substring(item.url?index_of('/') + 1)>
    </#if>
    <#if item.icon?? && item.icon != ''>
      <#assign icon = item.icon>
    </#if>
${''?left_pad(indent)}  <navigator url="/page/${url}" class="entry btn" style="width: 24%;">
${''?left_pad(indent)}    <view class="d-flex flex-column">
${''?left_pad(indent)}      <text class="fas fa-monument m-auto font-32"></text>
${''?left_pad(indent)}      <view class="font-14 text-gray mt-2">${item.title!'功能入口'}</view>
${''?left_pad(indent)}    </view>
${''?left_pad(indent)}  </navigator>
  </#list>
${''?left_pad(indent)}</view>
</#macro>

<#macro print_js_methods_gridnavigator widget indent>
  <#list widget.items as item>
${''?left_pad(indent)}/**
${''?left_pad(indent)} * 跳转到【${item.title}】页面。
${''?left_pad(indent)} */
${''?left_pad(indent)}goto${js.nameType(item.url!'todo')}: function() {
${''?left_pad(indent)}  wx.navigateTo({
${''?left_pad(indent)}    url: '/page/${item.url!'todo'}',
${''?left_pad(indent)}  });
${''?left_pad(indent)}},
  </#list>
</#macro>

<#macro print_axml_declare_listnavigator widget indent>
${''?left_pad(indent)}<view>
  <#list widget.items as item>
${''?left_pad(indent)}  <navigator url="/page/${modelbase.url_to_page_url(item.url!'todo')}" class="weui-cell weui-cell_access" open-type="navigate">
${''?left_pad(indent)}    <text class="weui-cell__bd">${item.title!'标题'}</text>
${''?left_pad(indent)}    <view class="weui-cell__ft weui-cell__ft_in-access"></view>
${''?left_pad(indent)}  </navigator>
  </#list>
${''?left_pad(indent)}</view>
</#macro>

<#macro print_js_methods_listnavigator widget indent>
  <#list widget.items as item>
<#--${''?left_pad(indent)}/**-->
<#--${''?left_pad(indent)} * 跳转到【${item.title!'标题'}】页面。-->
<#--${''?left_pad(indent)} */-->
<#--${''?left_pad(indent)}goto${js.nameType(item.url!'todo')}: function() {-->
<#--${''?left_pad(indent)}  wx.navigateTo({-->
<#--${''?left_pad(indent)}    url: '${item.url!'todo'}',-->
<#--${''?left_pad(indent)}  });-->
<#--${''?left_pad(indent)}},-->
  </#list>
</#macro>

<#macro print_axml_declare_tabsnavigator widget indent>
${''?left_pad(indent)}<tabs tabsList="{{tabs${js.nameType(widget.variable!'todo')}}}" bind:change="doChange${js.nameType(widget.variable!'todo')}">
  <#list widget.items as item>
${''?left_pad(indent)}  <view slot="tab-cont-${item?index}" style="width: 100%;">
${''?left_pad(indent)}    <page-${(item.url!'todo')?substring((item.url!'todo')?index_of("/") + 1)?replace("/", "-")}></page-${(item.url!'todo')?substring((item.url!'todo')?index_of("/") + 1)?replace("/", "-")}>
${''?left_pad(indent)}  </view>
  </#list>
${''?left_pad(indent)}</tabs>
</#macro>

<#macro print_js_fields_tabsnavigator widget indent>
${''?left_pad(indent)}tabs${js.nameType(widget.variable!'todo')}: [<#list widget.items as item>"${item.title}",</#list>],
${''?left_pad(indent)}tabIndex: 0,
</#macro>

<#macro print_js_methods_tabsnavigator widget indent>
${''?left_pad(indent)}doChange${js.nameType(widget.variable!'todo')}(ev) {
${''?left_pad(indent)}  //
${''?left_pad(indent)}},
</#macro>

<#macro print_axml_declare_themetitle widget indent>
${''?left_pad(indent)}<view class="d-flex px-3 py-3">
${''?left_pad(indent)}  <text>${widget.title!'主题标题'}</text>
  <#if widget.more>
${''?left_pad(indent)}  <navigator url="/page/${widget.url!''}" class="btn-link ml-auto small">更多...</navigator>
  </#if>
${''?left_pad(indent)}</view>
</#macro>

<#macro print_axml_declare_avatarheader widget indent>
${''?left_pad(indent)}<view class="avatar-header">
${''?left_pad(indent)}  <image src="/static/image/userbg.png" class="avatar-header-background"></image>
${''?left_pad(indent)}  <view class="avatar-header-body">
${''?left_pad(indent)}    <image src="{{user.avatar}}" class="avatar-header-image" bindtap=""></image>
${''?left_pad(indent)}    <view class="avatar-header-text" a:if="{{user.socialMediaAccountName}}">{{user.socialMediaAccountName || '立即登录'}}</view>
${''?left_pad(indent)}  </view>
${''?left_pad(indent)}</view>
</#macro>

<#macro print_axml_declare_listview widget indent>
${''?left_pad(indent)}<list-view class="list${js.nameType(widget.variable)}" limit="{{limit}}" height="{{contentHeight}}"
${''?left_pad(indent)}           url="{{url}}" local="{{items${js.nameType(widget.variable)}}}"
${''?left_pad(indent)}           ref="doSet${js.nameType(widget.variable)}Ref"
${''?left_pad(indent)}           getParameters="{{getParameters}}">
${''?left_pad(indent)}  <view class="d-flex align-items-center list-group-item" style="padding: 8px 16px;"
${''?left_pad(indent)}        a:for="{{items${js.nameType(widget.variable)}}}" a:for-item="item" data-${widget.variable?replace('_', '-')}="{{item}}" >
<@modelbase.indent_formatted_text text=widget.tile.html indent=indent+4 />
${''?left_pad(indent)}  </view>
${''?left_pad(indent)}</list-view>
</#macro>

<#-- 主题列表 -->
<#macro print_axml_declare_listtheme widget indent>
${''?left_pad(indent)}<view class="mx-3">
${''?left_pad(indent)}  <view class="d-flex align-items-center list-group-item"
${''?left_pad(indent)}       a:for="items{{${js.nameType(widget.managedObject.name)}}}" a:for-index="index">
${''?left_pad(indent)}    <view class="bg-gradient-primary mr-2" a:if="{{index % 2 == 0}}">
${''?left_pad(indent)}      <image src="{{item.${js.nameVariable(widget.image!'image')}}}" style="width:56px; height: 56px"></image>
${''?left_pad(indent)}    </view>
${''?left_pad(indent)}    <view a:if="{{index % 2 == 0}}">
${''?left_pad(indent)}      <view class="text-primary" style="display: block;">{{item.${js.nameVariable(widget.primary!'primary')}}}</view>
${''?left_pad(indent)}      <view class="text-muted font-weight-bold small">{{item.${js.nameVariable(widget.secondary!'secondary')}}}</view>
${''?left_pad(indent)}    </view>
${''?left_pad(indent)}    <view a:if="{{index % 2 == 1}}">
${''?left_pad(indent)}      <view class="text-primary" style="display: block;">{{item.${js.nameVariable(widget.primary!'primary')}}}</view>
${''?left_pad(indent)}      <view class="text-muted font-weight-bold small">{{item.${js.nameVariable(widget.secondary!'secondary')}}}</view>
${''?left_pad(indent)}    </view>
${''?left_pad(indent)}    <view class="ml-auto" a:if="{{index % 2 == 1}}">
${''?left_pad(indent)}      <image src="{{item.${js.nameVariable(widget.image!'image')}}}" style="width:56px; height: 56px"></image>
${''?left_pad(indent)}    </view>
${''?left_pad(indent)}  </view>
${''?left_pad(indent)}</view>
</#macro>

<#--
 ###
 ### 向导导航。
 ###
 -->
<#macro print_axml_declare_wizard widget indent>
${''?left_pad(indent)}<wizard steps="{{steps}}"></wizard>
</#macro>

<#macro print_js_fields_wizard widget indent>
${''?left_pad(indent)}steps: [{
${''?left_pad(indent)}}],
</#macro>

<#--
 ###
 ### 时间线条。
 ###
 -->
<#macro print_axml_declare_timeline widget indent>
${''?left_pad(indent)}<view>
${''?left_pad(indent)}  <ul class="timeline">
${''?left_pad(indent)}    <view a:for="${js.nameVariable(widget.variable)}Items" a:for-index="index" a:for-item="item" class="timeline-item">
${''?left_pad(indent)}      <view class="time">
${''?left_pad(indent)}        <span class="mr10">{{item.date}}</span>
${''?left_pad(indent)}        <span class="mr10">{{item.primary}}</span>
${''?left_pad(indent)}      </view>
${''?left_pad(indent)}      <p>${item.secondary}</p>
${''?left_pad(indent)}    </li>
${''?left_pad(indent)}  </ul>
${''?left_pad(indent)}</view>
</#macro>

<#--
 ###
 ### 日历导航。
 ###
 -->
<#macro print_axml_declare_calendar widget indent>
${''?left_pad(indent)}<calendar id="${js.nameVariable(widget.variable)}" isOpen="{{true}}" selected="{{selectedDays}}" lockDay="{{lockday}}" bind:select="cmfclick" bind:getdate="getdate" bind:checkall="checkall" bind:clear="clear"></calendar>
</#macro>

<#--
 ###############################################################################
 ### 表单
 ###############################################################################
 -->
<#macro print_axml_declare_formlayout widget indent>
${''?left_pad(indent)}<editable-form id="form${js.nameType(widget.variable)}" ref="doSetForm${js.nameType(widget.variable)}"
${''?left_pad(indent)}               fields="{{fields${js.nameType(widget.variable)}}}" />
</#macro>

<#macro print_js_fields_formlayout widget indent>
${''?left_pad(indent)}values${js.nameType(widget.variable)}: {},
  <#assign fieldIndex = 0>
${''?left_pad(indent)}fields${js.nameType(widget.variable)}: [{
  <#list widget.customForm.fields as field>
    <#assign input = field['input']!'text'>
    <#if input == 'none' || input == 'constant' || input == 'id'><#continue></#if>
    <#assign name = field.name!field.title>
    <#if name?starts_with('meta_')>
      <#assign name = field['title']>
    <#else>
      <#assign name = field.name!field.title>
    </#if>
    <#if fieldIndex != 0>
${''?left_pad(indent)}},{
    </#if>
${''?left_pad(indent)}  title: "${field['title']}",
    <#if input == 'select'>
      <#if field['local']??>
        <#assign strs = field['local']?replace('[','')?replace(']','')?split(',')>
${''?left_pad(indent)}  name: '${name}',
${''?left_pad(indent)}  input: 'radio',
${''?left_pad(indent)}  options: {
${''?left_pad(indent)}    values: [
        <#list strs as str>
${''?left_pad(indent)}      {value: '${str?substring(0, str?index_of(':'))?trim}', text: '${str?substring(str?index_of(':') + 1)?trim}', <#if str?index == 0>checked: true,</#if>},
        </#list>
${''?left_pad(indent)}    ],
${''?left_pad(indent)}  },
      <#elseif field.domainType?? && field.domainType?starts_with("&")>
        <#assign objname = field.domainType?substring(1, field.domainType?index_of('('))>
        <#assign attrname = field.domainType?substring(field.domainType?index_of('(') + 1, field.domainType?index_of(')'))>
${''?left_pad(indent)}  input: "select",
        <#if field.variant == js.nameVariable(objname)>
${''?left_pad(indent)}  name: "${js.nameVariable(objname) + js.nameType(attrname)}",
        <#else>
${''?left_pad(indent)}  name: "${field.variant}${js.nameType(objname)}${js.nameType(attrname)}",
        </#if>
${''?left_pad(indent)}  options: {
        <#if field['remote']??>
${''?left_pad(indent)}    url: '${field['remote']}',
        <#else>
${''?left_pad(indent)}    url: '/api/v3/common/script/${'stdbiz/' + field.parentPersistenceName?split('_')[1] + '/' + objname + '/find'}',
        </#if>
${''?left_pad(indent)}    fields: {
${''?left_pad(indent)}      value: "${js.nameVariable(objname)}${js.nameType(attrname)}",
${''?left_pad(indent)}      text: "${js.nameVariable(objname)}Name",
${''?left_pad(indent)}    },
${''?left_pad(indent)}  },
      <#else>
${''?left_pad(indent)}  name: '${name}',
${''?left_pad(indent)}  input: 'select',
${''?left_pad(indent)}  options: ${app.name}.options['${name}'],
      </#if>
    <#elseif input == 'radio'>
${''?left_pad(indent)}  name: '${name}',
${''?left_pad(indent)}  input: 'radio',
${''?left_pad(indent)}  options: ${app.name}.options['${name}'],
    <#elseif input == 'check'>
${''?left_pad(indent)}  name: '${name}',
${''?left_pad(indent)}  input: 'check',
${''?left_pad(indent)}  options: ${app.name}.options['${name}'],
    <#else>
${''?left_pad(indent)}  name: '${name}',
${''?left_pad(indent)}  input: '${input}',
    </#if>
    <#if field['required']!false == true>
${''?left_pad(indent)}  required: true,
    </#if>
    <#if field.unit?? && field.unit != ''>
${''?left_pad(indent)}  unit: '${field.unit}',
    </#if>
    <#assign fieldIndex = fieldIndex + 1>
  </#list>
${''?left_pad(indent)}}],
</#macro>

<#macro print_js_methods_formlayout widget indent>
  <#assign fieldIds = []>
  <#assign pageName = modelbase.url_to_page_name(page.uri)>
${''?left_pad(indent)}/**
${''?left_pad(indent)} * 设置【${widget.variable}】表单实例。
${''?left_pad(indent)} */
${''?left_pad(indent)}doSetForm${js.nameType(widget.variable)}: function (ref) {
${''?left_pad(indent)}  this.form${js.nameType(widget.variable)} = ref;
${''?left_pad(indent)}},
${''?left_pad(indent)}
${''?left_pad(indent)}/**
${''?left_pad(indent)} * 提交【${widget.variable}】表单。
${''?left_pad(indent)} */
${''?left_pad(indent)}doSaveForm${js.nameType(widget.variable)}: async function () {
${''?left_pad(indent)}  try {
${''?left_pad(indent)}    let data = await ${app.name}.${'save' + js.nameType(widget.variable) + '4' + js.nameType(pageName)}(this.data.values${js.nameType(widget.variable)});
${''?left_pad(indent)}    my.showToast({content: '数据保存成功！', type: 'success'});
${''?left_pad(indent)}  } catch (err) {
${''?left_pad(indent)}    my.showToast({content: err, type: 'error'});
${''?left_pad(indent)}  }
${''?left_pad(indent)}},

${''?left_pad(indent)}/**
${''?left_pad(indent)} * 加载【${widget.variable}】数据到表单。
${''?left_pad(indent)} */
${''?left_pad(indent)}doReadForm${js.nameType(widget.variable)}: async function (id) {
${''?left_pad(indent)}  if (!id) {
${''?left_pad(indent)}    this.form${js.nameType(widget.variable)}.setValues({});
${''?left_pad(indent)}    return;
${''?left_pad(indent)}  }
${''?left_pad(indent)}  let data = await ${app.name}.${'read' + js.nameType(widget.variable) + '4' + js.nameType(pageName)}(id);
${''?left_pad(indent)}
${''?left_pad(indent)}  if (data.error) {
${''?left_pad(indent)}    my.showToast({type: "error", content: "程序出错啦！",});
${''?left_pad(indent)}    return;
${''?left_pad(indent)}  }
${''?left_pad(indent)}
${''?left_pad(indent)}  this.form${js.nameType(widget.variable)}.setValues(data);
${''?left_pad(indent)}},
</#macro>

<#macro print_axml_declare_readonlyform widget indent>
${''?left_pad(indent)}<editable-form id="form${js.nameType(widget.variable)}" ref="doSetReadonly${js.nameType(widget.variable)}"
${''?left_pad(indent)}               readonly="{{true}}" fields="{{fields${js.nameType(widget.variable)}}}"/>
</#macro>

<#macro print_js_fields_readonlyform widget indent>
${''?left_pad(indent)}values${js.nameType(widget.variable)}: {},
  <#assign fieldIndex = 0>
${''?left_pad(indent)}fields${js.nameType(widget.variable)}: [{
  <#list widget.customReadonly.fields as field>
    <#assign name = field.name!field.title>
    <#if name?starts_with('meta_')>
      <#assign name = field['title']>
    <#else>
      <#assign name = field.name!field.title>
    </#if>
    <#if fieldIndex != 0>
${''?left_pad(indent)}},{
    </#if>
${''?left_pad(indent)}  title: '${field['title']?trim}',
${''?left_pad(indent)}  name: '${name?trim}',
    <#if field.input == 'images'>
${''?left_pad(indent)}  input: 'images',
    <#elseif field.input == 'longtext'>
${''?left_pad(indent)}  input: 'longtext',
    </#if>
    <#assign fieldIndex = fieldIndex + 1>
  </#list>
${''?left_pad(indent)}}],
</#macro>

<#macro print_js_methods_readonlyform widget indent>
  <#assign fieldIds = []>
  <#assign pageName = modelbase.url_to_page_name(page.uri)>
${''?left_pad(indent)}/**
${''?left_pad(indent)} * 初始化【${widget.variable}】表单。
${''?left_pad(indent)} */
${''?left_pad(indent)}doSetReadonly${js.nameType(widget.variable)}: function (ref) {
${''?left_pad(indent)}  this.readonly${js.nameType(widget.variable)} = ref;
${''?left_pad(indent)}},

${''?left_pad(indent)}/**
${''?left_pad(indent)} * 加载【${widget.variable}】数据到表单。
${''?left_pad(indent)} */
${''?left_pad(indent)}doReadReadonly${js.nameType(widget.variable)}: async function (id) {
${''?left_pad(indent)}  if (!id) {
${''?left_pad(indent)}    this.readonly${js.nameType(widget.variable)}.setValues({});
${''?left_pad(indent)}    return;
${''?left_pad(indent)}  }
${''?left_pad(indent)}  let data = await ${app.name}.${'read' + js.nameType(widget.variable) + '4' + js.nameType(pageName)}(id);
${''?left_pad(indent)}  if (data.error) {
${''?left_pad(indent)}    my.showToast({type: "error", content: "程序出错啦！",});
${''?left_pad(indent)}    return;
${''?left_pad(indent)}  }
${''?left_pad(indent)}
  <#list widget.customReadonly.fields as field>
    <#assign fieldName = field.name!field.title>
    <#if field.input == 'bool'>
${''?left_pad(indent)}  if (data['${fieldName}'] === 'T') {
${''?left_pad(indent)}    data['${fieldName}'] = '是';
${''?left_pad(indent)}  } else {
${''?left_pad(indent)}    data['${fieldName}'] = '否';
${''?left_pad(indent)}  }
    <#elseif field.input == 'select' || field.input == 'radio' || field.input == 'check'>
${''?left_pad(indent)}  data['${fieldName}'] = ${app.name}.options.getText('${fieldName}', data['${fieldName}']);
    <#elseif field.input == 'district'>
${''?left_pad(indent)}  data['${fieldName}'] = util.convertDistrictName(data['${fieldName}']);
    </#if>
  </#list>
${''?left_pad(indent)}  this.readonly${js.nameType(widget.variable)}.setValues(data);
${''?left_pad(indent)}},
</#macro>

<#macro print_axml_declare_styledform widget indent>
  <#if !widget.customStyled??><#return></#if>
${''?left_pad(indent)}<view class="list-group">
  <#list widget.customStyled.fields as field>
    <#if !field.input??>
      <#assign field = field + {'input': 'single', 'title': '标题'}>
    </#if>
    <#assign fieldName = field.name!field.title>
${''?left_pad(indent)}  <view class="list-group-item">
    <#if field.input?? && field.input == 'bool'>
${''?left_pad(indent)}    <view class="full-width d-flex" style="margin-bottom: -9px; margin-top: -3px;">
${''?left_pad(indent)}      <text class="font-16" style="line-height: 34px;">${field.title}</text>
${''?left_pad(indent)}      <view class="switch-item ml-auto">
${''?left_pad(indent)}        <switch checked="{{${field.name!'todo'}}}" bindchange=""/>
${''?left_pad(indent)}      </view>
${''?left_pad(indent)}    </view>
    <#elseif field.input?? && field.input == 'successive'>
${''?left_pad(indent)}    <view class="full-width d-flex">
${''?left_pad(indent)}      <text class="font-16">${field.title!'标题'}</text>
${''?left_pad(indent)}      <view widget-id="${field.title!'标题'}" class="ml-auto position-relative" style="top: 2px;">
${''?left_pad(indent)}        <text class="far fa-star mx-1 {{values${js.nameType(widget.variable)}['${fieldName}'] >= 'A' ? 'text-warning-light' : 'text-light'}}" style="font-size: 22px;"
${''?left_pad(indent)}              data-name="${fieldName}" data-value="A"
${''?left_pad(indent)}              onTap="onBuild${js.nameType(widget.variable)}"></text>
${''?left_pad(indent)}        <text class="far fa-star mx-1 {{values${js.nameType(widget.variable)}['${fieldName}'] >= 'B' ? 'text-warning-light' : 'text-light'}}" style="font-size: 22px;"
${''?left_pad(indent)}              data-name="${fieldName}" data-value="B"
${''?left_pad(indent)}              onTap="onBuild${js.nameType(widget.variable)}"></text>
${''?left_pad(indent)}        <text class="far fa-star mx-1 {{values${js.nameType(widget.variable)}['${fieldName}'] >= 'C' ? 'text-warning-light' : 'text-light'}}" style="font-size: 22px;"
${''?left_pad(indent)}              data-name="${fieldName}" data-value="C"
${''?left_pad(indent)}              onTap="onBuild${js.nameType(widget.variable)}"></text>
${''?left_pad(indent)}        <text class="far fa-star mx-1 {{values${js.nameType(widget.variable)}['${fieldName}'] >= 'D' ? 'text-warning-light' : 'text-light'}}" style="font-size: 22px;"
${''?left_pad(indent)}              data-name="${fieldName}" data-value="D"
${''?left_pad(indent)}              onTap="onBuild${js.nameType(widget.variable)}"></text>
${''?left_pad(indent)}        <text class="far fa-star mx-1 {{values${js.nameType(widget.variable)}['${fieldName}'] >= 'E' ? 'text-warning-light' : 'text-light'}}" style="font-size: 22px;"
${''?left_pad(indent)}              data-name="${fieldName}" data-value="E"
${''?left_pad(indent)}              onTap="onBuild${js.nameType(widget.variable)}"></text>
${''?left_pad(indent)}      </view>
${''?left_pad(indent)}    </view>
    <#elseif field.input?? && field.input == 'multiple'>
${''?left_pad(indent)}    <view class="full-width d-flex">
${''?left_pad(indent)}      <text class="font-16">${field.title!'标题'}</text>
${''?left_pad(indent)}      <view widget-id="${field.title!'标题'}" class="ml-auto position-relative" style="top: 2px;">
${''?left_pad(indent)}        <text data-name="${fieldName}" data-value="A" data-type="[]" onTap="onBuild${js.nameType(widget.variable)}"
${''?left_pad(indent)}           class="fas fa-apple-alt font-24 mx-1 {{values${js.nameType(widget.variable)}['${fieldName}'].includes('A') ? 'text-warning-light' : 'text-light'}}"></text>
${''?left_pad(indent)}        <text data-name="${fieldName}" data-value="B" data-type="[]" onTap="onBuild${js.nameType(widget.variable)}"
${''?left_pad(indent)}           class="fas fa-baseball-ball font-24 mx-1 {{values${js.nameType(widget.variable)}['${fieldName}'].includes('B') ? 'text-warning-light' : 'text-light'}}"></text>
${''?left_pad(indent)}        <text data-name="${fieldName}" data-value="C" data-type="[]" onTap="onBuild${js.nameType(widget.variable)}"
${''?left_pad(indent)}           class="fas fa-coffee font-24 mx-1 {{values${js.nameType(widget.variable)}['${fieldName}'].includes('C') ? 'text-warning-light' : 'text-light'}}"></text>
${''?left_pad(indent)}        <text data-name="${fieldName}" data-value="D" data-type="[]" onTap="onBuild${js.nameType(widget.variable)}"
${''?left_pad(indent)}           class="fas fa-smoking font-24 mx-1 {{values${js.nameType(widget.variable)}['${fieldName}'].includes('D') ? 'text-warning-light' : 'text-light'}}"></text>
${''?left_pad(indent)}        <text data-name="${fieldName}" data-value="E" data-type="[]" onTap="onBuild${js.nameType(widget.variable)}"
${''?left_pad(indent)}           class="fas fa-bed font-24 mx-1 {{values${js.nameType(widget.variable)}['${fieldName}'].includes('E') ? 'text-warning-light' : 'text-light'}}"></text>
${''?left_pad(indent)}        <text data-name="${fieldName}" data-value="F" data-type="[]" onTap="onBuild${js.nameType(widget.variable)}"
${''?left_pad(indent)}           class="fas fa-poop font-24 mx-1 {{values${js.nameType(widget.variable)}['${fieldName}'].includes('F') ? 'text-warning-light' : 'text-light'}}"></text>
${''?left_pad(indent)}      </view>
${''?left_pad(indent)}    </view>
    <#elseif field.input?? && field.input == 'ruler'>
${''?left_pad(indent)}    <view class="full-width d-flex">
${''?left_pad(indent)}      <text class="font-16">${field.title!'标题'}</text>
${''?left_pad(indent)}      <view widget-id="${field.title!'标题'}" class="ml-auto position-relative">
${''?left_pad(indent)}        <text style="font-size: 24px; color: var(--color-primary);"></text>
${''?left_pad(indent)}        <text style="font-size: 12px; color: var(--color-primary);">${field.unit!''}</text>
${''?left_pad(indent)}      </view>
${''?left_pad(indent)}    </view>
    <#else>
${''?left_pad(indent)}    <view class="full-width d-flex">
${''?left_pad(indent)}      <text class="font-16">${field.title!'标题'}</text>
${''?left_pad(indent)}      <view widget-id="${field.title!'标题'}" class="ml-auto position-relative" style="top: 2px;">
${''?left_pad(indent)}        <text class="fas fa-sad-cry font-24 mx-1 {{values${js.nameType(widget.variable)}['${fieldName}'] == 'A' ? 'text-warning-light' : 'text-light'}}" style="font-size: 22px;"
${''?left_pad(indent)}              data-name="${fieldName}" data-value="A"
${''?left_pad(indent)}              onTap="onBuild${js.nameType(widget.variable)}"></text>
${''?left_pad(indent)}        <text class="fas fa-frown font-24 mx-1 {{values${js.nameType(widget.variable)}['${fieldName}'] == 'B' ? 'text-warning-light' : 'text-light'}}" style="font-size: 22px;"
${''?left_pad(indent)}              data-name="${fieldName}" data-value="B"
${''?left_pad(indent)}              onTap="onBuild${js.nameType(widget.variable)}"></text>
${''?left_pad(indent)}        <text class="fas fa-meh font-24 mx-1 {{values${js.nameType(widget.variable)}['${fieldName}'] == 'C' ? 'text-warning-light' : 'text-light'}}" style="font-size: 22px;"
${''?left_pad(indent)}              data-name="${fieldName}" data-value="C"
${''?left_pad(indent)}              onTap="onBuild${js.nameType(widget.variable)}"></text>
${''?left_pad(indent)}        <text class="fas fa-smile font-24 mx-1 {{values${js.nameType(widget.variable)}['${fieldName}'] == 'D' ? 'text-warning-light' : 'text-light'}}" style="font-size: 22px;"
${''?left_pad(indent)}              data-name="${fieldName}" data-value="D"
${''?left_pad(indent)}              onTap="onBuild${js.nameType(widget.variable)}"></text>
${''?left_pad(indent)}        <text class="fas fa-laugh-beam font-24 mx-1 {{values${js.nameType(widget.variable)}['${fieldName}'] == 'E' ? 'text-warning-light' : 'text-light'}}" style="font-size: 22px;"
${''?left_pad(indent)}              data-name="${fieldName}" data-value="E"
${''?left_pad(indent)}              onTap="onBuild${js.nameType(widget.variable)}"></text>
${''?left_pad(indent)}      </view>
${''?left_pad(indent)}    </view>
    </#if>
${''?left_pad(indent)}  </view>
  </#list>
${''?left_pad(indent)}</view>
</#macro>

<#macro print_js_methods_styledform widget indent>
  <#assign pageName = modelbase.url_to_page_name(page.uri)>
${''?left_pad(indent)}/**
${''?left_pad(indent)} * 提交【${widget.variable}】表单。
${''?left_pad(indent)} */
${''?left_pad(indent)}doSaveStyled${js.nameType(widget.variable)}: async function () {
${''?left_pad(indent)}  try {
${''?left_pad(indent)}    let data = await ${app.name}.${'save' + js.nameType(widget.variable) + '4' + js.nameType(pageName)}(this.data.values${js.nameType(widget.variable)});
${''?left_pad(indent)}    wx.showToast({title: '数据保存成功！', icon: 'success'});
${''?left_pad(indent)}  } catch (err) {
${''?left_pad(indent)}    wx.showToast({title: err, icon: 'error'});
${''?left_pad(indent)}  }
${''?left_pad(indent)}},
${''?left_pad(indent)}
${''?left_pad(indent)}/**
${''?left_pad(indent)} * 加载【${widget.variable}】数据到表单。
${''?left_pad(indent)} */
${''?left_pad(indent)}doReadStyled${js.nameType(widget.variable)}: async function (id) {
${''?left_pad(indent)}  let data = await ${app.name}.${'read' + js.nameType(widget.variable) + '4' + js.nameType(pageName)}(id);
${''?left_pad(indent)}
${''?left_pad(indent)}  if (data.error) {
${''?left_pad(indent)}    wx.showToast({
${''?left_pad(indent)}      icon: "error",
${''?left_pad(indent)}      title: "程序出错啦！",
${''?left_pad(indent)}    });
${''?left_pad(indent)}    return;
${''?left_pad(indent)}  }
${''?left_pad(indent)}
${''?left_pad(indent)}  this.setData({
${''?left_pad(indent)}    values${js.nameType(widget.variable)}: data,
${''?left_pad(indent)}  });
${''?left_pad(indent)}},
${''?left_pad(indent)}
${''?left_pad(indent)}/**
${''?left_pad(indent)} * 构建【${widget.variable}】数据。
${''?left_pad(indent)} */
${''?left_pad(indent)}onBuild${js.nameType(widget.variable)}: function (e) {
${''?left_pad(indent)}  let name = e.currentTarget.dataset.name;
${''?left_pad(indent)}  let value = e.currentTarget.dataset.value;
${''?left_pad(indent)}  let type = e.currentTarget.dataset.type;
${''?left_pad(indent)}  if (type === '[]') {
${''?left_pad(indent)}    if (!this.data.valuesHabit[name]) {
${''?left_pad(indent)}      this.data.values${js.nameType(widget.variable)}[name] = [];
${''?left_pad(indent)}    }
${''?left_pad(indent)}    const index = this.data.values${js.nameType(widget.variable)}[name].indexOf(value);
${''?left_pad(indent)}    if (index > -1) {
${''?left_pad(indent)}      this.data.values${js.nameType(widget.variable)}[name].splice(index, 1);
${''?left_pad(indent)}    } else {
${''?left_pad(indent)}      this.data.values${js.nameType(widget.variable)}[name].push(value);
${''?left_pad(indent)}    }
${''?left_pad(indent)}  } else {
${''?left_pad(indent)}    if (this.data.values${js.nameType(widget.variable)}[name] === value) {
${''?left_pad(indent)}      delete this.data.values${js.nameType(widget.variable)}[name];
${''?left_pad(indent)}    } else {
${''?left_pad(indent)}      this.data.values${js.nameType(widget.variable)}[name] = value;
${''?left_pad(indent)}    }
${''?left_pad(indent)}  }
${''?left_pad(indent)}  this.setData({
${''?left_pad(indent)}    values${js.nameType(widget.variable)}: this.data.values${js.nameType(widget.variable)},
${''?left_pad(indent)}  });
${''?left_pad(indent)}},
</#macro>


<#macro print_js_fields_listview widget indent>
${''?left_pad(indent)}items${js.nameType(widget.variable)}: [],
${''?left_pad(indent)}limit: 15,
${''?left_pad(indent)}contentHeight: 100,
${''?left_pad(indent)}url: '${widget.remote!''}',
${''?left_pad(indent)}getParameters: () => {
${''?left_pad(indent)}  return {};
${''?left_pad(indent)}},
</#macro>

<#macro print_js_init_listview widget indent>
${''?left_pad(indent)}this.doInitList${js.nameType(widget.variable)}();
</#macro>

<#macro print_js_methods_listview widget indent>
${''?left_pad(indent)}/**
${''?left_pad(indent)} * 设置【${widget.variable}】列表实例。
${''?left_pad(indent)} */
${''?left_pad(indent)}doSet${js.nameType(widget.variable)}Ref: function (ref) {
${''?left_pad(indent)}  this.ref${js.nameType(widget.variable)} = ref;
${''?left_pad(indent)}},

${''?left_pad(indent)}/**
${''?left_pad(indent)} * 初始化【${widget.variable}】列表。
${''?left_pad(indent)} */
${''?left_pad(indent)}doInitList${js.nameType(widget.variable)}: async function() {
<#--  <#if widget.autoHeight!false == true>-->
${''?left_pad(indent)}  // 设置ListView的高度
${''?left_pad(indent)}  this.setData({
${''?left_pad(indent)}    contentHeight: util.height(0),
${''?left_pad(indent)}  });
<#--  </#if>-->
${''?left_pad(indent)}  this.doLoadList${js.nameType(widget.variable)}Items();
${''?left_pad(indent)}},

${''?left_pad(indent)}/**
${''?left_pad(indent)} * 加载【${widget.variable}】数据到列表显示。
${''?left_pad(indent)} */
${''?left_pad(indent)}doLoadList${js.nameType(widget.variable)}Items: async function() {
${''?left_pad(indent)}  let data = await ${app.name}.load${js.nameType(widget.variable)}4${js.nameType(widget.pageName)}({});
${''?left_pad(indent)}  this.ref${js.nameType(widget.variable)}.setOnDataLoaded((items) => {
${''?left_pad(indent)}    if (!items) return;
${''?left_pad(indent)}    let convertedItems = items.map((item) => {
${''?left_pad(indent)}      return item;
${''?left_pad(indent)}    });
${''?left_pad(indent)}    this.setData({
${''?left_pad(indent)}      items${js.nameType(widget.variable)}: convertedItems,
${''?left_pad(indent)}    });
${''?left_pad(indent)}  });
${''?left_pad(indent)}  this.setData({
${''?left_pad(indent)}    items${js.nameType(widget.variable)}: data,
${''?left_pad(indent)}  });
${''?left_pad(indent)}  this.ref${js.nameType(widget.variable)}.refresh();
${''?left_pad(indent)}},
</#macro>

<#--
 ###
 ### 【搜索输入】
 ###
 -->
<#macro print_axml_declare_searchbar widget indent>
${''?left_pad(indent)}<view class="weui-search-bar">
${''?left_pad(indent)}  <view class="weui-search-bar__form">
${''?left_pad(indent)}    <view class="weui-search-bar__box">
${''?left_pad(indent)}      <icon class="weui-icon-search" type="search" size="17" color="#0C98C5"></icon>
${''?left_pad(indent)}      <input type="text" value="{{keyword}}" bindtap="gotoSearch"  class="weui-search-bar__input" placeholder="输入关键字搜索"  placeholder-style="color:#2EA7E0;font-size:26rpx;"/>
${''?left_pad(indent)}    </view>
${''?left_pad(indent)}  </view>
${''?left_pad(indent)}</view>
</#macro>

<#macro print_js_fields_searchbar widget indent>
${''?left_pad(indent)}keyword: '',
</#macro>

<#macro print_js_methods_searchbar widget indent>
${''?left_pad(indent)}gotoSearch(ev) {
${''?left_pad(indent)}  wx.navigateTo({
${''?left_pad(indent)}    url: '/page/common/search',
${''?left_pad(indent)}  });
${''?left_pad(indent)}},
</#macro>