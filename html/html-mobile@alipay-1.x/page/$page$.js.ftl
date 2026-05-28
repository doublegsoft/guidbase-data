<#import "/$/modelbase.ftl" as modelbase>
<#import "/$/appbase.ftl" as appbase>
const app = getApp();
<#assign relpath = ''>
<#assign strs = page.uri?split("/")>
<#list strs as str>
  <#if str?index == 0><#continue></#if>
  <#assign relpath = relpath + "../">
</#list>
const { ${app.name} } = require('${relpath}sdk/' + app.sdk + '.js');
const { util } = require('${relpath}common/util.js');

<#if page.options.isComponent?? && page.options.isComponent == 'T'>
Component({
  props: {},
<#else>
Page({
</#if>
  data: {
    user: app.user,
<#list page.widgets![] as widget>
  <#if !widget.widgetType??><#continue></#if>
  <#if widget.widgetType == '滚动导航'>
    // 滚动导航
    items${js.nameType(widget.variable)}: [],
  <#elseif widget.widgetType == '滑动导航'>
    // 滑动导航
    items${js.nameType(widget.variable)}: [],
  <#elseif widget.widgetType == '栏位导航'>
    // 栏位导航
    items${js.nameType(widget.variable)}: {},
  <#elseif widget.widgetType == '编辑表单'>
<@appbase.print_js_fields_formlayout widget=widget indent=4 />
  <#elseif widget.widgetType == '只读表单'>
<@appbase.print_js_fields_readonlyform widget=widget indent=4 />
  <#elseif widget.widgetType == '传统列表'>
<@appbase.print_js_fields_listview widget=widget indent=4 />
  <#elseif widget.widgetType == '页签导航'>
<@appbase.print_js_fields_tabsnavigator widget=widget indent=4 />
  <#elseif widget.widgetType == '向导导航'>
<@appbase.print_js_fields_wizard widget=widget indent=2 />
  <#elseif widget.widgetType == '搜索输入'>
<@appbase.print_js_fields_searchbar widget=widget indent=4 />
  <#elseif widget.widgetType == '传统列表'>
    ${js.nameVariable(widget.variable)}Items: [{
      ${js.nameVariable(widget.image!'image')}: '/static/image/placeholder/64.png',
      ${js.nameVariable(widget.primary!'primary')}: '主要文本',
      ${js.nameVariable(widget.secondary!'secondary')}: '次要文本',
      ${js.nameVariable(widget.teriary!'tertiary')}: '再次文本',
      ${js.nameVariable(widget.teriary!'quaternary')}: '最次文本',
    },{
      ${js.nameVariable(widget.image!'image')}: '/static/image/placeholder/64.png',
      ${js.nameVariable(widget.primary!'primary')}: '主要文本',
      ${js.nameVariable(widget.secondary!'secondary')}: '次要文本',
      ${js.nameVariable(widget.teriary!'tertiary')}: '再次文本',
      ${js.nameVariable(widget.teriary!'quaternary')}: '最次文本',
    },{
      ${js.nameVariable(widget.image!'image')}: '/static/image/placeholder/64.png',
      ${js.nameVariable(widget.primary!'primary')}: '主要文本',
      ${js.nameVariable(widget.secondary!'secondary')}: '次要文本',
      ${js.nameVariable(widget.teriary!'tertiary')}: '再次文本',
      ${js.nameVariable(widget.teriary!'quaternary')}: '最次文本',
    }],
  </#if>
</#list>
  },

  onLoad: async function (options) {
    this.setData({
      user: app.user,
    });
<#list page.widgets![] as widget>
  <#if !widget.widgetType??><#continue></#if>
  <#if widget.widgetType == '滚动导航'>
    let items${js.nameType(widget.variable)} = await ${app.name}.load${js.nameType(widget.variable)}4${js.nameType(widget.pageName)}({});
    this.setData({
      items${js.nameType(widget.variable)}: items${js.nameType(widget.variable)},
    });
  <#elseif widget.widgetType == '滑动导航'>
    let items${js.nameType(widget.variable)} = await ${app.name}.load${js.nameType(widget.variable)}4${js.nameType(widget.pageName)}({});
    this.setData({
      items${js.nameType(widget.variable)}: items${js.nameType(widget.variable)},
    });
  <#elseif widget.widgetType == '栏位导航'>
    let items${js.nameType(widget.variable)} = await ${app.name}.load${js.nameType(widget.variable)}4${js.nameType(widget.pageName)}({});
    this.setData({
      items${js.nameType(widget.variable)}: items${js.nameType(widget.variable)},
    });
  <#elseif widget.widgetType == '传统列表'>
<@appbase.print_js_init_listview widget=widget indent=4 />
  <#elseif widget.widgetType == '只读表单'>
    this.doReadReadonly${js.nameType(widget.variable)}(options);
  <#elseif widget.widgetType == '编辑表单'>
    this.doReadForm${js.nameType(widget.variable)}(options);
  <#elseif widget.widgetType == '花式表单'>
    this.doReadStyled${js.nameType(widget.variable)}(options);
  </#if>
</#list>
  },

<#list page.widgets![] as widget>
  <#if !widget.widgetType??><#continue></#if>
  <#if widget.widgetType == '编辑表单'>
<@appbase.print_js_methods_formlayout widget=widget indent=2 />
  <#elseif widget.widgetType == '只读表单'>
<@appbase.print_js_methods_readonlyform widget=widget indent=2 />
  <#elseif widget.widgetType == '花式表单'>
<@appbase.print_js_methods_styledform widget=widget indent=2 />
  <#elseif widget.widgetType == '传统列表'>
<@appbase.print_js_methods_listview widget=widget indent=2 />
  <#elseif widget.widgetType == '列表导航'>
<@appbase.print_js_methods_listnavigator widget=widget indent=2 />
  <#elseif widget.widgetType == '栅格导航'>
<@appbase.print_js_methods_gridnavigator widget=widget indent=2 />
  <#elseif widget.widgetType == '页签导航'>
<@appbase.print_js_methods_tabsnavigator widget=widget indent=2 />
  <#elseif widget.widgetType == '搜索输入'>
<@appbase.print_js_methods_searchbar widget=widget indent=2 />
  </#if>
</#list>
});
