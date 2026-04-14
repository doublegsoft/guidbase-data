<#import "/$/guidbase.ftl" as guidbase>
<#macro print_wxml_declare_cyclenavigator widget indent>
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

<#macro print_wxml_declare_scrollnavigator widget indent>
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

<#macro print_wxml_declare_columnnavigator widget indent>
${""?left_pad(indent)}<view class="row mx-2 px-1" style="height: 180px;">
${""?left_pad(indent)}  <view class="col-24-12 pr-1">
${""?left_pad(indent)}    <image src="{{items${js.nameType(widget.id)}.primary.image}}" style="width: 100%; height: 100%;"></image>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}  <view class="col-24-12">
${""?left_pad(indent)}    <view class="pl-1 pb-1" style="width: 100%; height: 50%;">
${""?left_pad(indent)}      <image src="{{items${js.nameType(widget.id)}.secondary.image}}" style="width: 100%; height: 100%;"></image>
${""?left_pad(indent)}    </view>
${""?left_pad(indent)}    <view class="pl-1 pt-1" style="width: 100%; height: 50%;">
${""?left_pad(indent)}      <image src="{{items${js.nameType(widget.id)}.tertiary.image}}" style="width: 100%; height: 100%;"></image>
${""?left_pad(indent)}    </view>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}</view>
</#macro>

<#macro print_wxml_declare_gridnavigator widget indent>
${""?left_pad(indent)}<view class="square-menu">
  <#list widget.items as item>
    <#assign url = 'todo'>
    <#assign icon = '/static/image/ic_menu_sort_nor.png'>
    <#if item.url??>
      <#assign url = item.url?substring(item.url?index_of('/') + 1)>
    </#if>
    <#if item.icon?? && item.icon != "">
      <#assign icon = item.icon>
    </#if>
${""?left_pad(indent)}  <navigator url="/page/${url}" class="entry btn" style="width: 24%;">
${""?left_pad(indent)}    <view class="d-flex flex-column">
${""?left_pad(indent)}      <text class="fas fa-monument m-auto font-32"></text>
${""?left_pad(indent)}      <view class="font-14 text-gray mt-2">${item.title!'功能入口'}</view>
${""?left_pad(indent)}    </view>
${""?left_pad(indent)}  </navigator>
  </#list>
${""?left_pad(indent)}</view>
</#macro>

<#macro print_js_methods_gridnavigator widget indent>
  <#list widget.items as item>
${""?left_pad(indent)}/**
${""?left_pad(indent)} * 跳转到【${item.title}】页面。
${""?left_pad(indent)} */
${""?left_pad(indent)}goto${js.nameType(item.url!'todo')}: function() {
${""?left_pad(indent)}  wx.navigateTo({
${""?left_pad(indent)}    url: '/page/${item.url!'todo'}',
${""?left_pad(indent)}  });
${""?left_pad(indent)}},
  </#list>
</#macro>

<#macro print_wxml_declare_listnavigator widget indent>
${""?left_pad(indent)}<view class="gx-mx-8">
  <#list widget.children![] as child>
${""?left_pad(indent)}  <navigator bindtap="goto${js.nameType(child.url!'todo')}" url="#" class="gx-tile gx-pl-20 gx-py-12 gx-fs-16" role="navigator">
${""?left_pad(indent)}    <text class="gx-tile-body">${child.title!'标题'}</text>
${""?left_pad(indent)}    <view class="fas fa-angle-right gx-fs-18 access"></view>
${""?left_pad(indent)}  </navigator>
  </#list>
${""?left_pad(indent)}</view>
</#macro>

<#macro print_js_methods_listnavigator widget indent>
  <#list widget.children![] as child>
    <#if child.url??>
    
${""?left_pad(indent)}/**
${""?left_pad(indent)} * 跳转到【${child.url}】页面。
${""?left_pad(indent)} */
${""?left_pad(indent)}goto${js.nameType(child.url)}() {
${""?left_pad(indent)}  wx.navigateTo({
${""?left_pad(indent)}    url: '/page/${app.name}/${child.url}/index',
${""?left_pad(indent)}  });
${""?left_pad(indent)}},
    </#if>
  </#list>
</#macro>

<#macro print_wxml_declare_tabsnavigator widget indent>
${""?left_pad(indent)}<tabs tabsList="{{tabs${js.nameType(widget.id!'todo')}}}" bind:change="doChange${js.nameType(widget.id!'todo')}">
  <#list widget.items![] as item>
${""?left_pad(indent)}  <view slot="tab-cont-${item?index}" style="width: 100%;">
${""?left_pad(indent)}    <page-${(item.url!'todo')?substring((item.url!'todo')?index_of("/") + 1)?replace("/", "-")}></page-${(item.url!'todo')?substring((item.url!'todo')?index_of("/") + 1)?replace("/", "-")}>
${""?left_pad(indent)}  </view>
  </#list>
${""?left_pad(indent)}</tabs>
</#macro>

<#macro print_js_fields_tabsnavigator widget indent>
${""?left_pad(indent)}tabs${js.nameType(widget.id!'todo')}: [<#list widget.items as item>"${item.title}",</#list>],
${""?left_pad(indent)}tabIndex: 0,
</#macro>

<#macro print_js_methods_tabsnavigator widget indent>
${""?left_pad(indent)}doChange${js.nameType(widget.id!'todo')}(ev) {
${""?left_pad(indent)}  //
${""?left_pad(indent)}},
</#macro>

<#macro print_wxml_declare_themetitle widget indent>
${""?left_pad(indent)}<view class="d-flex px-3 py-3">
${""?left_pad(indent)}  <strong>${widget.title!'主题标题'}</strong>
  <#if widget.more>
${""?left_pad(indent)}  <navigator url="/page/${widget.url!""}" class="btn-link ml-auto small">更多...</navigator>
  </#if>
${""?left_pad(indent)}</view>
</#macro>

<#macro print_wxml_declare_avatarheader widget indent>
${""?left_pad(indent)}<view class="avatar-header">
${""?left_pad(indent)}  <image src="/static/image/userbg.png" class="avatar-header-background"></image>
${""?left_pad(indent)}  <view class="avatar-header-body">
${""?left_pad(indent)}    <image src="{{user.avatar}}" class="avatar-header-image" bindtap=""></image>
${""?left_pad(indent)}    <view class="avatar-header-text" wx:if="{{user.socialMediaAccountName}}">{{user.socialMediaAccountName || '立即登录'}}</view>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}</view>
</#macro>

<#macro print_wxml_declare_listview widget indent>
${""?left_pad(indent)}<list-view class="list${js.nameType(widget.id)}" limit="{{limit}}" height="{{contentHeight}}"
${""?left_pad(indent)}           url="{{url}}" local="{{items${js.nameType(widget.id)}}}"
${""?left_pad(indent)}           getParameters="{{getParameters}}">
${""?left_pad(indent)}  <view class="d-flex align-items-center list-group-item" style="padding: 8px 16px;"
${""?left_pad(indent)}        wx:for="{{items${js.nameType(widget.id)}}}" wx:for-item="item" data-${widget.id?replace('_', '-')}="{{item}}" >
<#--@modelbase.indent_formatted_text text=widget.tile.html indent=indent+4 /-->
  <#local grid = helper.layout(widget)>
  <#list grid.rows as row>
${""?left_pad(indent)}    <view class="gx-row">  
    <#list row.cells as cell>
      <#if cell.value??>
${""?left_pad(indent)}      <view class="gx-24-12">{{${js.nameVariable(cell.value.id)}}}</view>
      <#else>
${""?left_pad(indent)}      <view class="gx-24-12">
        <#list cell.rows as innerRow>
${""?left_pad(indent)}        <view>{{${js.nameVariable(innerRow.cells[0].value.id)}}}</view>
        </#list>
${""?left_pad(indent)}      </view>      
      </#if>
    </#list>
${""?left_pad(indent)}    </view>  
  </#list>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}</list-view>
</#macro>

<#-- 主题列表 -->
<#macro print_wxml_declare_listtheme widget indent>
${""?left_pad(indent)}<view class="mx-3">
${""?left_pad(indent)}  <div class="d-flex align-items-center list-group-item"
${""?left_pad(indent)}       wx:for="{{${js.nameVariable(widget.managedObject.name)}Items}}" wx:for-index="index">
${""?left_pad(indent)}    <div class="bg-gradient-primary mr-2" wx:if="{{index % 2 == 0}}">
${""?left_pad(indent)}      <image src="{{item.${js.nameVariable(widget.image!'image')}}}" style="width:56px; height: 56px"></image>
${""?left_pad(indent)}    </div>
${""?left_pad(indent)}    <div wx:if="{{index % 2 == 0}}">
${""?left_pad(indent)}      <div class="text-primary" style="display: block;">{{item.${js.nameVariable(widget.primary!'primary')}}}</div>
${""?left_pad(indent)}      <div class="text-muted font-weight-bold small">{{item.${js.nameVariable(widget.secondary!'secondary')}}}</div>
${""?left_pad(indent)}    </div>
${""?left_pad(indent)}    <div wx:if="{{index % 2 == 1}}">
${""?left_pad(indent)}      <div class="text-primary" style="display: block;">{{item.${js.nameVariable(widget.primary!'primary')}}}</div>
${""?left_pad(indent)}      <div class="text-muted font-weight-bold small">{{item.${js.nameVariable(widget.secondary!'secondary')}}}</div>
${""?left_pad(indent)}    </div>
${""?left_pad(indent)}    <div class="ml-auto" wx:if="{{index % 2 == 1}}">
${""?left_pad(indent)}      <image src="{{item.${js.nameVariable(widget.image!'image')}}}" style="width:56px; height: 56px"></image>
${""?left_pad(indent)}    </div>
${""?left_pad(indent)}  </div>
${""?left_pad(indent)}</view>
</#macro>

<#--
 ###
 ### 向导导航。
 ###
 -->
<#macro print_wxml_declare_wizard widget indent>
${""?left_pad(indent)}<wizard steps="{{steps}}"></wizard>
</#macro>

<#macro print_js_fields_wizard widget indent>
${""?left_pad(indent)}steps: [{
${""?left_pad(indent)}}],
</#macro>

<#--
 ###
 ### 时间线条。
 ###
 -->
<#macro print_wxml_declare_timeline widget indent>
${""?left_pad(indent)}<view>
${""?left_pad(indent)}  <ul class="timeline">
${""?left_pad(indent)}    <li wx:for="${js.nameVariable(widget.id)}Items" wx:for-index="index" wx:for-item="item" class="timeline-item">
${""?left_pad(indent)}      <div class="time">
${""?left_pad(indent)}        <span class="mr10">{{item.date}}</span>
${""?left_pad(indent)}        <span class="mr10">{{item.primary}}</span>
${""?left_pad(indent)}      </div>
${""?left_pad(indent)}      <p>${item.secondary}</p>
${""?left_pad(indent)}    </li>
${""?left_pad(indent)}  </ul>
${""?left_pad(indent)}</view>
</#macro>

<#--
 ###
 ### 日历导航。
 ###
 -->
<#macro print_wxml_declare_calendar widget indent>
${""?left_pad(indent)}<calendar id="${js.nameVariable(widget.id)}" isOpen="{{true}}" selected="{{selectedDays}}" lockDay="{{lockday}}" bind:select="cmfclick" bind:getdate="getdate" bind:checkall="checkall" bind:clear="clear"></calendar>
</#macro>

<#macro print_wxml_declare_staticimage widget indent>
  <#local pos = widget.position>
${""?left_pad(indent)}<view class="gx-w-full gx-d-flex">
${""?left_pad(indent)}  <image src="{{${js.nameVariable(widget.id!"todo")}}}" 
${""?left_pad(indent)}         class="<#if pos.rowIndex == 0 && pos.cellIndex == 0>gx-m-auto </#if><#if (widget.mode!"") == "avatar">gx-b-round </#if>" 
${""?left_pad(indent)}         style="<#if pos.size.width == 0>width:100%;<#else>width:${pos.size.width}px;</#if><#if pos.size.height == 0>height:100%;<#else>height:${pos.size.height}px;</#if>"></image>
${""?left_pad(indent)}</view>
</#macro>

<#macro print_wxml_declare_textbuttons widget indent>
${""?left_pad(indent)}<view class="full-width text-center">
  <#list widget.buttons as button>
${""?left_pad(indent)}  <button class="btn my-1"
${""?left_pad(indent)}          style="background: ${button.backgroundColor!'black'};color: ${widget['fontColor']!'#fff'};font-size: ${widget['fontSize']!'18px'};width: ${widget['buttonWidth']!'300px'};">${button.title!'TODO'}</button>
  </#list>
${""?left_pad(indent)}</view>
</#macro>

<#--
 ###############################################################################
 ### 编辑表单
 ###############################################################################
 -->
<#macro print_wxml_declare_formlayout widget indent>
${""?left_pad(indent)}<gx-two-column-form fields="{{fields${js.nameType(widget.id)}}}" 
${""?left_pad(indent)}                    data="{{values${js.nameType(widget.id)}}}" 
${""?left_pad(indent)}                    id="form${js.nameType(widget.id)}"
${""?left_pad(indent)}                    bind:onSubmit="doSaveForm${js.nameType(widget.id)}" 
${""?left_pad(indent)}                    labelWidth="150" />
</#macro>

<#macro print_js_fields_formlayout widget indent>
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

<#macro print_js_methods_formlayout widget indent>
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

<#--
 ###############################################################################
 ### 只读表单
 ###############################################################################
 -->

<#macro print_wxml_declare_readonlyform widget indent>
${""?left_pad(indent)}<editable-form fields="{{fields${js.nameType(widget.id)}}}" values="{{values${js.nameType(widget.id)}}}"
${""?left_pad(indent)}               id="readonly${js.nameType(widget.id)}"
${""?left_pad(indent)}               readonly="{{true}}" labelWidth="150" mode="horizontal" />
</#macro>

<#macro print_js_fields_readonlyform widget indent>
${""?left_pad(indent)}values${js.nameType(widget.id)}: {},
  <#assign fieldIndex = 0>
${""?left_pad(indent)}fields${js.nameType(widget.id)}: [{
  <#list widget.customReadonly.fields as field>
    <#assign name = field.name!field.title>
    <#if name?starts_with('meta_')>
      <#assign name = field['title']>
    <#else>
      <#assign name = field.name!field.title>
    </#if>
    <#if fieldIndex != 0>
${""?left_pad(indent)}},{
    </#if>
${""?left_pad(indent)}  title: '${field['title']?trim}',
${""?left_pad(indent)}  name: '${name?trim}',
    <#if field.input == 'images'>
${""?left_pad(indent)}  input: 'images',
    <#elseif field.input == 'longtext'>
${""?left_pad(indent)}  input: 'longtext',
    </#if>
    <#assign fieldIndex = fieldIndex + 1>
  </#list>
${""?left_pad(indent)}}],
</#macro>

<#macro print_js_methods_readonlyform widget indent>
  <#assign pageName = page.id>
${""?left_pad(indent)}/**
${""?left_pad(indent)} * 加载【${widget.id}】数据到表单。
${""?left_pad(indent)} */
${""?left_pad(indent)}doReadReadonly${js.nameType(widget.id)}: async function (id) {
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
  <#list widget.customReadonly.fields as field>
    <#assign fieldName = field.name!field.title>
    <#if field.input == 'bool'>
${""?left_pad(indent)}  if (data['${fieldName}'] === 'T') {
${""?left_pad(indent)}    data['${fieldName}'] = '是';
${""?left_pad(indent)}  } else {
${""?left_pad(indent)}    data['${fieldName}'] = '否';
${""?left_pad(indent)}  }
    <#elseif field.input == 'select' || field.input == 'radio' || field.input == 'check'>
${""?left_pad(indent)}  data['${fieldName}'] = ${app.name}.options.getText('${fieldName}', data['${fieldName}']);
    <#elseif field.input == 'district'>
${""?left_pad(indent)}  data['${fieldName}'] = util.convertDistrictName(data['${fieldName}']);
    </#if>
  </#list>
${""?left_pad(indent)}  this.setData({
${""?left_pad(indent)}    values${js.nameType(widget.id)}: data,
${""?left_pad(indent)}  });
${""?left_pad(indent)}},
</#macro>

<#--
 ###############################################################################
 ### 花式表单
 ###############################################################################
 -->

<#macro print_wxml_declare_styledform widget indent>
  <#if !widget.customStyled??><#return></#if>
${""?left_pad(indent)}<ul class="list-group">
  <#list widget.customStyled.fields as field>
    <#local fieldName = field.name!field.title>
    <#if !field.input??>
      <#assign field = field + {'input': 'single', 'title': '标题'}>
    </#if>
${""?left_pad(indent)}  <li class="list-group-item">
    <#if field.input?? && field.input == 'bool'>
${""?left_pad(indent)}    <div class="full-width d-flex" style="margin-bottom: -9px; margin-top: -3px;">
${""?left_pad(indent)}      <strong class="font-16" style="line-height: 34px;">${field.title}</strong>
${""?left_pad(indent)}      <div class="switch-item ml-auto">
${""?left_pad(indent)}        <switch checked="{{values${js.nameType(widget.id)}['${fieldName}'] === true || values${js.nameType(widget.id)}['${fieldName}'] == 'T'}}" bindchange=""/>
${""?left_pad(indent)}      </div>
${""?left_pad(indent)}    </div>
    <#elseif field.input?? && field.input == 'successive'>
${""?left_pad(indent)}    <div class="full-width d-flex">
${""?left_pad(indent)}      <strong class="font-16">${field.title!'标题'}</strong>
${""?left_pad(indent)}      <div widget-id="${field.title!'标题'}" class="ml-auto position-relative" style="top: 2px;">
${""?left_pad(indent)}        <i data-name="${fieldName}" data-value="A" bindtap="onBuild${js.nameType(widget.id)}"
${""?left_pad(indent)}           class="fas fa-star mx-1 font-22 {{values${js.nameType(widget.id)}['${fieldName}'] >= 'A' ? 'text-warning-light' : 'text-light'}}"></i>
${""?left_pad(indent)}        <i data-name="${fieldName}" data-value="B" bindtap="onBuild${js.nameType(widget.id)}"
${""?left_pad(indent)}          class="fas fa-star mx-1 font-22 {{values${js.nameType(widget.id)}['${fieldName}'] >= 'B' ? 'text-warning-light' : 'text-light'}}"></i>
${""?left_pad(indent)}        <i data-name="${fieldName}" data-value="C" bindtap="onBuild${js.nameType(widget.id)}"
${""?left_pad(indent)}           class="fas fa-star mx-1 font-22 {{values${js.nameType(widget.id)}['${fieldName}'] >= 'C' ? 'text-warning-light' : 'text-light'}}"></i>
${""?left_pad(indent)}        <i data-name="${fieldName}" data-value="D" bindtap="onBuild${js.nameType(widget.id)}"
${""?left_pad(indent)}           class="fas fa-star mx-1 font-22 {{values${js.nameType(widget.id)}['${fieldName}'] >= 'D' ? 'text-warning-light' : 'text-light'}}"></i>
${""?left_pad(indent)}        <i data-name="${fieldName}" data-value="E" bindtap="onBuild${js.nameType(widget.id)}"
${""?left_pad(indent)}           class="fas fa-star mx-1 font-22 {{values${js.nameType(widget.id)}['${fieldName}'] >= 'E' ? 'text-warning-light' : 'text-light'}}"></i>
${""?left_pad(indent)}      </div>
${""?left_pad(indent)}    </div>
    <#elseif field.input?? && field.input == 'multiple'>
${""?left_pad(indent)}    <div class="full-width d-flex">
${""?left_pad(indent)}      <strong class="font-16">${field.title!'标题'}</strong>
${""?left_pad(indent)}      <div widget-id="${field.title!'标题'}" class="ml-auto position-relative" style="top: 2px;">
${""?left_pad(indent)}        <i data-name="${fieldName}" data-value="A" data-type="[]" bindtap="onBuild${js.nameType(widget.id)}"
${""?left_pad(indent)}           class="fas fa-apple-alt font-24 mx-1 {{tool.contains(values${js.nameType(widget.id)}['${fieldName}'], 'A') ? 'text-warning-light' : 'text-light'}}"></i>
${""?left_pad(indent)}        <i data-name="${fieldName}" data-value="B" data-type="[]" bindtap="onBuild${js.nameType(widget.id)}"
${""?left_pad(indent)}           class="fas fa-baseball-ball font-24 mx-1 {{tool.contains(values${js.nameType(widget.id)}['${fieldName}'], 'B') ? 'text-warning-light' : 'text-light'}}"></i>
${""?left_pad(indent)}        <i data-name="${fieldName}" data-value="C" data-type="[]" bindtap="onBuild${js.nameType(widget.id)}"
${""?left_pad(indent)}           class="fas fa-coffee font-24 mx-1 {{tool.contains(values${js.nameType(widget.id)}['${fieldName}'], 'C') ? 'text-warning-light' : 'text-light'}}"></i>
${""?left_pad(indent)}        <i data-name="${fieldName}" data-value="D" data-type="[]" bindtap="onBuild${js.nameType(widget.id)}"
${""?left_pad(indent)}           class="fas fa-smoking font-24 mx-1 {{tool.contains(values${js.nameType(widget.id)}['${fieldName}'], 'D') ? 'text-warning-light' : 'text-light'}}"></i>
${""?left_pad(indent)}        <i data-name="${fieldName}" data-value="E" data-type="[]" bindtap="onBuild${js.nameType(widget.id)}"
${""?left_pad(indent)}           class="fas fa-bed font-24 mx-1 {{tool.contains(values${js.nameType(widget.id)}['${fieldName}'], 'E') ? 'text-warning-light' : 'text-light'}}"></i>
${""?left_pad(indent)}        <i data-name="${fieldName}" data-value="F" data-type="[]" bindtap="onBuild${js.nameType(widget.id)}"
${""?left_pad(indent)}           class="fas fa-poop font-24 mx-1 {{tool.contains(values${js.nameType(widget.id)}['${fieldName}'], 'F') ? 'text-warning-light' : 'text-light'}}"></i>
${""?left_pad(indent)}      </div>
${""?left_pad(indent)}    </div>
    <#elseif field.input?? && field.input == 'ruler'>
${""?left_pad(indent)}    <div class="full-width d-flex">
${""?left_pad(indent)}      <strong class="font-16">${field.title!'标题'}</strong>
${""?left_pad(indent)}      <div widget-id="${field.title!'标题'}" class="ml-auto position-relative">
${""?left_pad(indent)}        <span style="font-size: 24px; color: var(--color-primary);"></span>
${""?left_pad(indent)}        <span style="font-size: 12px; color: var(--color-primary);">${field.unit!""}</span>
${""?left_pad(indent)}      </div>
${""?left_pad(indent)}    </div>
    <#else>
${""?left_pad(indent)}    <div class="full-width d-flex">
${""?left_pad(indent)}      <strong class="font-16">${field.title!'标题'}</strong>
${""?left_pad(indent)}      <div class="ml-auto position-relative" style="top: 2px;">
${""?left_pad(indent)}        <i data-name="${fieldName}" data-value="A" bindtap="onBuild${js.nameType(widget.id)}"
${""?left_pad(indent)}           class="fas fa-sad-cry font-24 mx-1 {{values${js.nameType(widget.id)}['${fieldName}'] == 'A' ? 'text-warning-light' : 'text-light'}}"></i>
${""?left_pad(indent)}        <i data-name="${fieldName}" data-value="B" bindtap="onBuild${js.nameType(widget.id)}"
${""?left_pad(indent)}           class="fas fa-frown font-24 mx-1 {{values${js.nameType(widget.id)}['${fieldName}'] == 'B' ? 'text-warning-light' : 'text-light'}}"></i>
${""?left_pad(indent)}        <i data-name="${fieldName}" data-value="C" bindtap="onBuild${js.nameType(widget.id)}"
${""?left_pad(indent)}           class="fas fa-meh font-24 mx-1 {{values${js.nameType(widget.id)}['${fieldName}'] == 'C' ? 'text-warning-light' : 'text-light'}}"></i>
${""?left_pad(indent)}        <i data-name="${fieldName}" data-value="D" bindtap="onBuild${js.nameType(widget.id)}"
${""?left_pad(indent)}           class="fas fa-smile font-24 mx-1 {{values${js.nameType(widget.id)}['${fieldName}'] == 'D' ? 'text-warning-light' : 'text-light'}}"></i>
${""?left_pad(indent)}        <i data-name="${fieldName}" data-value="E" bindtap="onBuild${js.nameType(widget.id)}"
${""?left_pad(indent)}           class="fas fa-laugh-beam font-24 mx-1 {{values${js.nameType(widget.id)}['${fieldName}'] == 'E' ? 'text-warning-light' : 'text-light'}}"></i>
${""?left_pad(indent)}      </div>
${""?left_pad(indent)}    </div>
    </#if>
${""?left_pad(indent)}  </li>
  </#list>
${""?left_pad(indent)}</ul>
</#macro>

<#macro print_js_fields_styledform widget indent>
${""?left_pad(indent)}values${js.nameType(widget.id)}: {},
</#macro>

<#macro print_js_methods_styledform widget indent>
  <#assign pageName = modelbase.url_to_page_name(page.uri)>
${""?left_pad(indent)}/**
${""?left_pad(indent)} * 提交【${widget.id}】表单。
${""?left_pad(indent)} */
${""?left_pad(indent)}doSaveStyled${js.nameType(widget.id)}: async function () {
${""?left_pad(indent)}  try {
${""?left_pad(indent)}    let data = await ${app.name}.${'save' + js.nameType(widget.id) + '4' + js.nameType(pageName)}(this.data.values${js.nameType(widget.id)});
${""?left_pad(indent)}    wx.showToast({title: '数据保存成功！', icon: 'success'});
${""?left_pad(indent)}  } catch (err) {
${""?left_pad(indent)}    wx.showToast({title: err, icon: 'error'});
${""?left_pad(indent)}  }
${""?left_pad(indent)}},
${""?left_pad(indent)}
${""?left_pad(indent)}/**
${""?left_pad(indent)} * 加载【${widget.id}】数据到表单。
${""?left_pad(indent)} */
${""?left_pad(indent)}doReadStyled${js.nameType(widget.id)}: async function (id) {
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
${""?left_pad(indent)}  this.setData({
${""?left_pad(indent)}    values${js.nameType(widget.id)}: data,
${""?left_pad(indent)}  });
${""?left_pad(indent)}},
${""?left_pad(indent)}
${""?left_pad(indent)}/**
${""?left_pad(indent)} * 构建【${widget.id}】数据。
${""?left_pad(indent)} */
${""?left_pad(indent)}onBuild${js.nameType(widget.id)}: function (e) {
${""?left_pad(indent)}  let name = e.currentTarget.dataset.name;
${""?left_pad(indent)}  let value = e.currentTarget.dataset.value;
${""?left_pad(indent)}  let type = e.currentTarget.dataset.type;
${""?left_pad(indent)}  if (type === '[]') {
${""?left_pad(indent)}    if (!this.data.valuesHabit[name]) {
${""?left_pad(indent)}      this.data.values${js.nameType(widget.id)}[name] = [];
${""?left_pad(indent)}    }
${""?left_pad(indent)}    const index = this.data.values${js.nameType(widget.id)}[name].indexOf(value);
${""?left_pad(indent)}    if (index > -1) {
${""?left_pad(indent)}      this.data.values${js.nameType(widget.id)}[name].splice(index, 1);
${""?left_pad(indent)}    } else {
${""?left_pad(indent)}      this.data.values${js.nameType(widget.id)}[name].push(value);
${""?left_pad(indent)}    }
${""?left_pad(indent)}  } else {
${""?left_pad(indent)}    if (this.data.values${js.nameType(widget.id)}[name] === value) {
${""?left_pad(indent)}      delete this.data.values${js.nameType(widget.id)}[name];
${""?left_pad(indent)}    } else {
${""?left_pad(indent)}      this.data.values${js.nameType(widget.id)}[name] = value;
${""?left_pad(indent)}    }
${""?left_pad(indent)}  }
${""?left_pad(indent)}  this.setData({
${""?left_pad(indent)}    values${js.nameType(widget.id)}: this.data.values${js.nameType(widget.id)},
${""?left_pad(indent)}  });
${""?left_pad(indent)}},
</#macro>

<#--
 ###############################################################################
 ### 传统列表
 ###############################################################################
 -->
<#macro print_js_fields_listview widget indent>
${""?left_pad(indent)}items4${js.nameType(widget.id)}: [],
${""?left_pad(indent)}limit: 15,
${""?left_pad(indent)}contentHeight: 100,
${""?left_pad(indent)}url4${js.nameType(widget.id)}: '${widget.remote!""}',
${""?left_pad(indent)}getParameters: () => {
${""?left_pad(indent)}  return {};
${""?left_pad(indent)}},
</#macro>

<#macro print_js_init_listview widget indent>
${""?left_pad(indent)}this.doInitList${js.nameType(widget.id)}();
</#macro>

<#macro print_js_methods_listview widget indent>
${""?left_pad(indent)}/**
${""?left_pad(indent)} * 初始化【${widget.id}】列表。
${""?left_pad(indent)} */
${""?left_pad(indent)}doInitList${js.nameType(widget.id)}: async function() {
<#--  <#if widget.autoHeight!false == true>-->
${""?left_pad(indent)}  // 设置ListView的高度
${""?left_pad(indent)}  this.setData({
${""?left_pad(indent)}    contentHeight: util.height(0),
${""?left_pad(indent)}  });
<#--  </#if>-->
${""?left_pad(indent)}  this.doLoadList${js.nameType(widget.id)}Items();
${""?left_pad(indent)}},

${""?left_pad(indent)}/**
${""?left_pad(indent)} * 加载【${widget.id}】数据到列表显示。
${""?left_pad(indent)} */
${""?left_pad(indent)}doLoadList${js.nameType(widget.id)}Items: async function() {
${""?left_pad(indent)}  let list = this.selectComponent(".list${js.nameType(widget.id)}");
${""?left_pad(indent)}  let data = await ${app.name}.load${js.nameType(widget.id)}4${js.nameType(widget.pageName)}({});
${""?left_pad(indent)}  list.setOnDataLoaded((items) => {
${""?left_pad(indent)}    if (!items) return;
${""?left_pad(indent)}    let convertedItems = items.map((item) => {
${""?left_pad(indent)}      return item;
${""?left_pad(indent)}    });
${""?left_pad(indent)}    this.setData({
${""?left_pad(indent)}      items${js.nameType(widget.id)}: convertedItems,
${""?left_pad(indent)}    });
${""?left_pad(indent)}  });
${""?left_pad(indent)}  this.setData({
${""?left_pad(indent)}    items${js.nameType(widget.id)}: data,
${""?left_pad(indent)}  });
${""?left_pad(indent)}  list.refresh();
${""?left_pad(indent)}},
</#macro>

<#--
 ###
 ### 【搜索输入】
 ###
 -->
<#macro print_wxml_declare_searchbar widget indent>
${""?left_pad(indent)}<view class="weui-search-bar">
${""?left_pad(indent)}  <view class="weui-search-bar__form">
${""?left_pad(indent)}    <view class="weui-search-bar__box">
${""?left_pad(indent)}      <icon class="weui-icon-search" type="search" size="17" color="#0C98C5"></icon>
${""?left_pad(indent)}      <input type="text" value="{{keyword}}" bindtap="gotoSearch"  class="weui-search-bar__input" placeholder="输入关键字搜索"  placeholder-style="color:#2EA7E0;font-size:26rpx;"/>
${""?left_pad(indent)}    </view>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}</view>
</#macro>

<#macro print_js_fields_searchbar widget indent>
${""?left_pad(indent)}keyword: "",
</#macro>

<#macro print_js_methods_searchbar widget indent>
${""?left_pad(indent)}gotoSearch(ev) {
${""?left_pad(indent)}  wx.navigateTo({
${""?left_pad(indent)}    url: '/page/common/search',
${""?left_pad(indent)}  });
${""?left_pad(indent)}},
</#macro>

<#macro print_source_code snippet language widget indent>
  <@modelbase.print_source_code platform="MOBILE" framework="wechat" language=language snippet=snippet
  component=widget.widgetType widget=widget indent=indent />
</#macro>