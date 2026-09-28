<#import "/$/modelbase.ftl" as modelbase>
<#import "/$/guidbase.ftl" as guidbase>
<#import "/$/guidbase4js.ftl" as guidbase4js>
<#if designSystem?? && designSystem == "navypitch">
<#import "/$/miniprogram-wechat-navypitch.ftl" as mp>
</#if>
<#assign page = pageDef>
import { safeNavigateTo } from '@/utils/router.js';
const fb = require('@/utils/feedback');
const sys = require('@/utils/system');
const sdk = require('@/sdk/sdk').default;

Page({

  data: {
<@mp.print_page_variables page=page indent=4 />
<#if page.value("data") != "">
  <#assign url = valuebase.url(page.value("data"))>
    ${js.nameVariable(url.resource)}: {},
</#if>
  },

  onLoad: async function (options) {
<#if page.value("data") != "">
  <#assign url = valuebase.url(page.value("data"))>
  <#list url.params as param>
    this.data.${js.nameVariable(param.name)} = options.${js.nameVariable(param.name)};
  </#list>
    this.load${js.nameType(url.resource)}();
</#if>
<#assign visited_widgets = {}>      
<#list page.widgets as widget>
  <#if !widget.id?? || visited_widgets[widget.id]??><#continue></#if>
  <#if (widget.type == "select" || widget.type == "multiselect" || widget.type == "cascade") && 
       guidbase.get_widget_enum_ref(widget)??>
    <#if widget.ancestor("entry_form")?? || widget.ancestor("criteria_form")??>
      <#assign opt = guidbase.get_widget_enum_ref(widget)>
    this.setData({
      ${js.nameVariable(widget.id)}Options: await sdk.fetch${js.nameType(inflector.pluralize(opt.name))}AsOptions(),
    });
    </#if>
  <#elseif widget.type == "split_list">
    const heights = sys.getSystemHeights();
    this.setData({
      ${js.nameVariable(widget.id)}Height: heights.windowHeightRpx
    });  
    this.load${js.nameType(widget.id)}Groups();
    this.load${js.nameType(widget.id)}Rows();
  <#elseif widget.type == "list_view" || widget.type == "grid_view">
    this.load${js.nameType(widget.id)}Rows();
  <#elseif widget.type == "display_form" || widget.type == "entry_form">
    this.load${js.nameType(widget.id)}Data();
  </#if>
</#list>
<#--  <#list page.widgets as widget>
  <#assign init = widget.value("init")>
  <#if init == ""><#continue></#if>
  <#assign url = valuebase.url(init)>
    this.setData({
  <#list url.params as param>
      ${js.nameVariable(param.name)}: options.${guidbase4js.get_param_value(param)},
  </#list>    
    });
    this.${guidbase.name_widget_method_load(widget)}();
</#list>    -->
  },
<@mp.print_page_methods page=page indent=2 />
<#if page.value("data") != "">
  <#assign url = valuebase.url(page.value("data"))>
      
  load${js.nameType(url.resource)}: async function () {
    let params = {};    
    <#list url.params as param>
    params.${js.nameVariable(param.name)} = this.data.${js.nameVariable(param.name)};
    </#list>
    try {    
      let ${js.nameVariable(url.resource)} = await sdk.fetch${js.nameType(url.resource)}(params);
      this.setData({
        ${js.nameVariable(url.resource)}: ${js.nameVariable(url.resource)},
      });
    } catch (error) {
      fb.error('发生错误', error.message || String(error))
    }
  }
</#if>  
});
