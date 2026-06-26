<#import "/$/modelbase.ftl" as modelbase>
<#import "/$/guidbase.ftl" as guidbase>
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
  </#if>
</#list>
<#list page.widgets as widget>
  <#if !widget.id?? || visited_widgets[widget.id]??><#continue></#if>
  <#if guidbase.name_widget_method_load(widget) != "">
    this.${guidbase.name_widget_method_load(widget)}();
  </#if>
</#list>  
  },

<@mp.print_page_methods page=page indent=2 />  
});
