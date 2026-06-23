<#import "/$/modelbase.ftl" as modelbase>
<#import "/$/guidbase4js.ftl" as guidbase4js>
<#if designSystem?? && designSystem == "navypitch">
<#import "/$/miniprogram-wechat-navypitch.ftl" as mp>
</#if>
<#assign page = pageDef>
const fb = require('@/utils/feedback');
const sdk = require('@/sdk/sdk').default;

Page({
  data: {
<@mp.print_page_variables page=page indent=4 />
  },

  onLoad: async function (options) {
<#assign visited_widgets = {}>      
<#list page.widgets as widget>
  <#if !widget.id?? || visited_widgets[widget.id]??><#continue></#if>
  <#if (widget.type == "select" || widget.type == "multiselect") && 
       !(widget.value("data")!"")?starts_with("enum[")>
    <#if widget.ancestor("entry_form")?? || widget.ancestor("criteria_form")??>
  this.setData({
    ${js.nameVariable(widget.id)}Options: await sdk.fetch${js.nameType(inflector.pluralize(widget.value("object",widget.id)))}AsOptions(),
  });
    </#if>
  <#elseif widget.type == "entry_form" || widget.type == "display_form">
  this.load${js.nameType(widget.id)}Data();
  <#elseif widget.type == "excel_form" || widget.type == "list_view">
  this.load${js.nameType(widget.id)}Rows();
  <#elseif widget.type == "chart">
  this.load${js.nameType(widget.id)}Rows();
  </#if>
</#list>
  },

  handleBack: function () {
    wx.navigateBack({
      delta: 1,
      fail: function () {
        wx.showToast({ title: '已是第一页', icon: 'none' });
      }
    });
  },

  handleEdit: function () {
    wx.showToast({ title: '进入编辑模式', icon: 'none' });
  },

<@mp.print_page_methods page=page indent=2 />  
});
