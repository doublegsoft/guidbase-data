<#import "/$/gux.ftl" as gux>
<#if license??>
${js.license(license)}
</#if>
<#assign relpath = "">
<#assign strs = (page.uri!(page.id!""))?split("/")>
<#list strs as str>
  <#if str?index == 0><#continue></#if>
  <#assign relpath = relpath + "../">
</#list>
const app = getApp();
<#--
const { sdk } = require('${relpath}../../../sdk/' + app.sdk);
const { gx } = require('${relpath}../../../vendor/gux/common/gx');
-->
const { sdk } = app.require('sdk/' + app.sdk);
const { gx } = app.require('vendor/gux/common/gx');
const { xhr } = app.require('vendor/gux/common/xhr');

<#if !page.options??>
  <#assign page = page + {"options":{}}>
</#if>  
<#if page.options.isComponent?? && page.options.isComponent == "T">
Component({
  properties: {},
<#else>
Page({
</#if>
  data: {
    /*!
    ** 在存在自定义导航栏的情况下，页面正文的起始位置。
    */
    marginTop: 0,
    
    user: app.user,
<#list page.pageWidgets![] as widget>
  <#if widget.widgetType!"" == "滚动导航">
    // 滚动导航
    items${js.nameType(widget.variable)}: [],
  <#elseif widget.widgetType!"" == "滑动导航">
    // 滑动导航
    items${js.nameType(widget.variable)}: [],
  <#elseif widget.widgetType!"" == "栏位导航">
    // 栏位导航
    items${js.nameType(widget.variable)}: {},
  <#elseif widget.widgetType!"" == "编辑表单" || (widget.type!"") == "twocolumnform">
    // 编辑表单
<@gux.print_js_fields_formlayout widget=widget indent=4 />
  <#elseif widget.widgetType!"" == "只读表单">
<@gux.print_js_fields_readonlyform widget=widget indent=4 />
  <#elseif widget.widgetType!"" == "花式表单">
<@gux.print_js_fields_styledform widget=widget indent=4 />
  <#elseif (widget.widgetType!"") == "传统列表" || (widget.type!"") == "listview">
<@gux.print_js_fields_listview widget=widget indent=4 />
  <#elseif widget.widgetType!"" == "页签导航">
<@gux.print_js_fields_tabsnavigator widget=widget indent=4 />
  <#elseif widget.widgetType!"" == "向导导航">
<@gux.print_js_fields_wizard widget=widget indent=2 />
  <#elseif widget.widgetType!"" == "搜索输入">
<@gux.print_js_fields_searchbar widget=widget indent=4 />
  <#elseif (widget.widgetType!"") == "静态图片" || (widget.type!"") == "image">
    <#if (widget.mode!"") == "avatar">
    ${js.nameVariable(widget.id!"TODO")}: '/asset/image/round.png',
    <#else>
    ${js.nameVariable(widget.id!"TODO")}: '/asset/image/rect.png',
    </#if>
  </#if>
</#list>
  },

<#if page.options.isComponent?? && page.options.isComponent == "T">
  ready: async function (options) {
<#else>
  onLoad: async function (options) {
</#if>
    this.setData({
      user: app.user,
    });
<#list page.pageWidgets![] as widget>
  <#if widget.widgetType!"" == "滚动导航">
    let items${js.nameType(widget.variable)} = await ${app.name}.load${js.nameType(widget.variable)}4${js.nameType(widget.pageName)}({});
    this.setData({
      items${js.nameType(widget.variable)}: items${js.nameType(widget.variable)},
    });
  <#elseif widget.widgetType!"" == "滑动导航">
    let items${js.nameType(widget.variable)} = await ${app.name}.load${js.nameType(widget.variable)}4${js.nameType(widget.pageName)}({});
    this.setData({
      items${js.nameType(widget.variable)}: items${js.nameType(widget.variable)},
    });
  <#elseif widget.widgetType!"" == "栏位导航">
    let items${js.nameType(widget.variable)} = await ${app.name}.load${js.nameType(widget.variable)}4${js.nameType(widget.pageName)}({});
    this.setData({
      items${js.nameType(widget.variable)}: items${js.nameType(widget.variable)},
    });
  <#elseif widget.widgetType!"" == "传统列表">
<@gux.print_js_init_listview widget=widget indent=4 />
  <#elseif widget.widgetType!"" == "只读表单">
    this.doReadReadonly${js.nameType(widget.variable)}(options);
  <#elseif widget.widgetType!"" == "编辑表单">
    this.doReadForm${js.nameType(widget.variable)}(options);
  <#elseif widget.widgetType!"" == "花式表单">
    this.doReadStyled${js.nameType(widget.variable)}(options);
  </#if>
</#list>

  },
  
  onShow() {
    let navbar = this.selectComponent('#navigationBar');
    if (navbar != null) {
      this.setData({
        marginTop: navbar.getHeight(),
      });
    }
  },

<#list page.pageWidgets![] as widget>
  <#if widget.widgetType!"" == "编辑表单" || (widget.type!"") == "twocolumnform">
<@gux.print_js_methods_formlayout widget=widget indent=2 />
  <#elseif widget.widgetType!"" == "只读表单">
<@gux.print_js_methods_readonlyform widget=widget indent=2 />
  <#elseif widget.widgetType!"" == "花式表单">
<@gux.print_js_methods_styledform widget=widget indent=2 />
  <#elseif widget.widgetType!"" == "传统列表">
<@gux.print_js_methods_listview widget=widget indent=2 />
  <#elseif (widget.widgetType!"") == "列表导航" || (widget.type!"") == "listnavigator">
<@gux.print_js_methods_listnavigator widget=widget indent=2 />
  <#elseif widget.widgetType!"" == "栅格导航">
<@gux.print_js_methods_gridnavigator widget=widget indent=2 />
  <#elseif widget.widgetType!"" == "页签导航">
<@gux.print_js_methods_tabsnavigator widget=widget indent=2 />
  <#elseif widget.widgetType!"" == "搜索输入">
<@gux.print_js_methods_searchbar widget=widget indent=2 />
  </#if>
</#list>
});
