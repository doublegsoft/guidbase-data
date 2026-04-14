<#import "/$/guidbase.ftl" as guidbase>
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

const { sdk } = require('@/sdk/' + app.sdk);
const { gux } = require('@/vendor/gux/common/gux');
const { xhr } = require('@/vendor/gux/common/xhr');
const { util } = require("@/vendor/gux/common/util");
<#list pagedef.pageWidgets as widget>
  <#if widget.type?? && widget.type?ends_with("_chart")>
const Charts = require('@/vendor/gcharts/gcharts-min');
    <#break>
  </#if>
</#list>

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
    ** 当前登录用户。
    */
    user: app.user,
<#list pagedef.pageWidgets as widget>    
  <#if !widget.type??><#continue></#if>
  <#if widget.type == "editable_form">  
<@gux.print_js_fields_editable_form widget=widget indent=4 />
  <#elseif widget.type == "readonly_form">  
<@gux.print_js_fields_readonly_form widget=widget indent=4 />
  <#elseif widget.type == "tabs">  
<@gux.print_js_fields_tabs widget=widget indent=4 />
  <#elseif widget.type == "scroll_notification">  
<@gux.print_js_fields_scroll_notification widget=widget indent=4 />
  <#elseif widget.type == "swiper_navigator">  
<@gux.print_js_fields_swiper_navigator widget=widget indent=4 />
  <#elseif widget.type == "scroll_navigator">  
<@gux.print_js_fields_scroll_navigator widget=widget indent=4 />
  <#elseif widget.type == "list_navigator">  
<@gux.print_js_fields_list_navigator widget=widget indent=4 />
  <#elseif widget.type == "grid_navigator">  
<@gux.print_js_fields_grid_navigator widget=widget indent=4 />
  <#elseif widget.type == "calendar">  
<@gux.print_js_fields_calendar widget=widget indent=4 />
  <#elseif widget.type == "tree">  
<@gux.print_js_fields_tree widget=widget indent=4 />
  <#elseif widget.type == "search_bar">  
<@gux.print_js_fields_search_bar widget=widget indent=4 />
  <#elseif widget.type == "list_view">  
<@gux.print_js_fields_list_view widget=widget indent=4 />
  <#elseif widget.type == "grid_view">  
<@gux.print_js_fields_grid_view widget=widget indent=4 />
  <#elseif widget.type == "timeline">  
<@gux.print_js_fields_timeline widget=widget indent=4 />
  <#elseif widget.type == "pagination_table">  
<@gux.print_js_fields_pagination_table widget=widget indent=4 />
  <#elseif widget.type == "pagination_grid">  
<@gux.print_js_fields_pagination_grid widget=widget indent=4 />
  <#elseif widget.type == "spreadsheet">  
<@gux.print_js_fields_spreadsheet widget=widget indent=4 />
  <#elseif widget.type == "kanban">  
<@gux.print_js_fields_kanban widget=widget indent=4 />
  <#elseif widget.type == "chat">  
<@gux.print_js_fields_chat widget=widget indent=4 />
  <#elseif widget.type == "pie_chart">  
<@gux.print_js_fields_pie_chart widget=widget indent=4 />
  <#elseif widget.type == "donut_chart">  
<@gux.print_js_fields_donut_chart widget=widget indent=4 />
  <#elseif widget.type == "bar_chart">  
<@gux.print_js_fields_bar_chart widget=widget indent=4 />
  <#elseif widget.type == "line_chart">  
<@gux.print_js_fields_line_chart widget=widget indent=4 />
  <#elseif widget.type == "stack_chart">  
<@gux.print_js_fields_stack_chart widget=widget indent=4 />
  <#elseif widget.type == "radar_chart">  
<@gux.print_js_fields_radar_chart widget=widget indent=4 />
  <#elseif widget.type == "network_topology_diagram">  
<@gux.print_js_fields_network_topology_diagram widget=widget indent=4 />
  <#elseif widget.type == "business_process_diagram">  
<@gux.print_js_fields_business_process_diagram widget=widget indent=4 />
  </#if>
</#list>
  },

  onLoad: async function (options) {
<#if pagedef.options["object"]??>
  <#assign objname = pagedef.options["object"]>
    this.data.${js.nameVariable(guidbase.get_widget_id_attribute(pagedef))} = options.${js.nameVariable(guidbase.get_widget_id_attribute(pagedef))};
    let ${js.nameVariable(objname)} = await sdk.fetch${js.nameType(objname)}({
      ${js.nameVariable(guidbase.get_widget_id_attribute(pagedef))}: this.data.${js.nameVariable(guidbase.get_widget_id_attribute(pagedef))},
    });
</#if>  
    this.setData({
      user: app.user,
<#if pagedef.options["object"]??>
  <#assign objname = pagedef.options["object"]>
      ...${js.nameVariable(objname)},
</#if>        
    });
<#list pagedef.pageWidgets![] as widget>
  <#if !widget.type??><#continue></#if>
  <#if widget.type == "tile">  
<@gux.print_js_declare_tile widget=widget indent=4 />  
  <#elseif widget.type == "toolbar">  
<@gux.print_js_declare_toolbar widget=widget indent=4 />
  <#elseif widget.type == "editable_form">  
<@gux.print_js_declare_editable_form widget=widget indent=4 />
  <#elseif widget.type == "readonly_form">  
<@gux.print_js_declare_readonly_form widget=widget indent=4 />
  <#elseif widget.type == "tabs">  
<@gux.print_js_declare_tabs widget=widget indent=4 />
  <#elseif widget.type == "scroll_notification">  
<@gux.print_js_declare_scroll_notification widget=widget indent=4 />
  <#elseif widget.type == "swiper_navigator">  
<@gux.print_js_declare_swiper_navigator widget=widget indent=4 />
  <#elseif widget.type == "scroll_navigator">  
<@gux.print_js_declare_scroll_navigator widget=widget indent=4 />
  <#elseif widget.type == "list_navigator">  
<@gux.print_js_declare_list_navigator widget=widget indent=4 />
  <#elseif widget.type == "grid_navigator">  
<@gux.print_js_declare_grid_navigator widget=widget indent=4 />
  <#elseif widget.type == "calendar">  
<@gux.print_js_declare_calendar widget=widget indent=4 />
  <#elseif widget.type == "tree">  
<@gux.print_js_declare_tree widget=widget indent=4 />
  <#elseif widget.type == "search_bar">  
<@gux.print_js_declare_search_bar widget=widget indent=4 />
  <#elseif widget.type == "list_view">  
<@gux.print_js_declare_list_view widget=widget indent=4 />
  <#elseif widget.type == "grid_view">  
<@gux.print_js_declare_grid_view widget=widget indent=4 />
  <#elseif widget.type == "timeline">  
<@gux.print_js_declare_timeline widget=widget indent=4 />
  <#elseif widget.type == "pagination_table">  
<@gux.print_js_declare_pagination_table widget=widget indent=4 />
  <#elseif widget.type == "pagination_grid">  
<@gux.print_js_declare_pagination_grid widget=widget indent=4 />
  <#elseif widget.type == "spreadsheet">  
<@gux.print_js_declare_spreadsheet widget=widget indent=4 />
  <#elseif widget.type == "kanban">  
<@gux.print_js_declare_kanban widget=widget indent=4 />
  <#elseif widget.type == "chat">  
<@gux.print_js_declare_chat widget=widget indent=4 />
  <#elseif widget.type == "pie_chart">  
<@gux.print_js_declare_pie_chart widget=widget indent=4 />
  <#elseif widget.type == "donut_chart">  
<@gux.print_js_declare_donut_chart widget=widget indent=4 />
  <#elseif widget.type == "bar_chart">  
<@gux.print_js_declare_bar_chart widget=widget indent=4 />
  <#elseif widget.type == "line_chart">  
<@gux.print_js_declare_line_chart widget=widget indent=4 />
  <#elseif widget.type == "stack_chart">  
<@gux.print_js_declare_stack_chart widget=widget indent=4 />
  <#elseif widget.type == "radar_chart">  
<@gux.print_js_declare_radar_chart widget=widget indent=4 />
  <#elseif widget.type == "network_topology_diagram">  
<@gux.print_js_declare_network_topology_diagram widget=widget indent=4 />
  <#elseif widget.type == "business_process_diagram">  
<@gux.print_js_declare_business_process_diagram widget=widget indent=4 />
  </#if>
</#list>
  },
  
  onShow() {
    app.onShowPage(this);
  },

<#list pagedef.pageWidgets![] as widget>
  <#if !widget.type??><#continue></#if>
  <#if widget.type == "tile">
<@gux.print_js_methods_tile widget=widget indent=2 />
  <#elseif widget.type == "button">  
<@gux.print_js_methods_button widget=widget indent=2 />
  <#elseif widget.type == "toolbar">  
<@gux.print_js_methods_toolbar widget=widget indent=2 />
  <#elseif widget.type == "editable_form"> 
<@gux.print_js_methods_editable_form widget=widget indent=2 />
  <#elseif widget.type == "readonly_form"> 
<@gux.print_js_methods_readonly_form widget=widget indent=2 />
  <#elseif widget.type == "tabs"> 
<@gux.print_js_methods_tabs widget=widget indent=2 />
  <#elseif widget.type == "scroll_notification"> 
<@gux.print_js_methods_scroll_notification widget=widget indent=2 />
  <#elseif widget.type == "swiper_navigator"> 
<@gux.print_js_methods_swiper_navigator widget=widget indent=2 />
  <#elseif widget.type == "scroll_navigator"> 
<@gux.print_js_methods_scroll_navigator widget=widget indent=2 />
  <#elseif widget.type == "list_navigator"> 
<@gux.print_js_methods_list_navigator widget=widget indent=2 />
  <#elseif widget.type == "grid_navigator"> 
<@gux.print_js_methods_grid_navigator widget=widget indent=2 />
  <#elseif widget.type == "calendar"> 
<@gux.print_js_methods_calendar widget=widget indent=2 />
  <#elseif widget.type == "tree"> 
<@gux.print_js_methods_tree widget=widget indent=2 />
  <#elseif widget.type == "search_bar"> 
<@gux.print_js_methods_search_bar widget=widget indent=2 />
  <#elseif widget.type == "list_view"> 
<@gux.print_js_methods_list_view widget=widget indent=2 />
  <#elseif widget.type == "grid_view"> 
<@gux.print_js_methods_grid_view widget=widget indent=2 />
  <#elseif widget.type == "timeline"> 
<@gux.print_js_methods_timeline widget=widget indent=2 />
  <#elseif widget.type == "pagination_table"> 
<@gux.print_js_methods_pagination_table widget=widget indent=2 />
  <#elseif widget.type == "pagination_grid"> 
<@gux.print_js_methods_pagination_grid widget=widget indent=2 />
  <#elseif widget.type == "spreadsheet"> 
<@gux.print_js_methods_spreadsheet widget=widget indent=2 />
  <#elseif widget.type == "kanban"> 
<@gux.print_js_methods_kanban widget=widget indent=2 />
  <#elseif widget.type == "chat"> 
<@gux.print_js_methods_chat widget=widget indent=2 />
  <#elseif widget.type == "pie_chart"> 
<@gux.print_js_methods_pie_chart widget=widget indent=2 />
  <#elseif widget.type == "donut_chart"> 
<@gux.print_js_methods_donut_chart widget=widget indent=2 />
  <#elseif widget.type == "bar_chart"> 
<@gux.print_js_methods_bar_chart widget=widget indent=2 />
  <#elseif widget.type == "line_chart"> 
<@gux.print_js_methods_line_chart widget=widget indent=2 />
  <#elseif widget.type == "stack_chart"> 
<@gux.print_js_methods_stack_chart widget=widget indent=2 />
  <#elseif widget.type == "radar_chart"> 
<@gux.print_js_methods_radar_chart widget=widget indent=2 />
  <#elseif widget.type == "network_topology_diagram"> 
<@gux.print_js_methods_network_topology_diagram widget=widget indent=2 />
  <#elseif widget.type == "business_process_diagram"> 
<@gux.print_js_methods_business_process_diagram widget=widget indent=2 />
  </#if>
</#list>
});
