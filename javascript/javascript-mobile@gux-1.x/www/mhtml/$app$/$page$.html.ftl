<#import "/$/modelbase.ftl" as guidbase>
<#import "/$/guidbase.ftl" as guidbase>
<#import "/$/gux.ftl" as gux>
<#assign hasNavigationBar = false>
<#list pagedef.widgets as widget>
  <#if !widget.type??><#continue></#if>
  <#if widget.type == "navigation_bar">
    <#assign hasNavigationBar = true>
    <#break>
  </#if>
</#list>
<div id="page${js.nameType(guidbase.page_id_to_page_name(pagedef.id))}" class="page">
  <div class="page-body">
<#list pagedef.widgets as widget>
  <#if !widget.type??><#continue></#if>
<@gux.print_html_declare_widget widget=widget indent=4 />  
</#list>
  </div>
</div>
<script>
function Page${js.nameType(guidbase.page_id_to_page_name(pagedef.id))}() {
  this.page = dom.find('#page${js.nameType(guidbase.page_id_to_page_name(pagedef.id))}');
<#if hasNavigationBar>
  this.navigationBar = dom.element(`
    <div class="gx-w-full">
  <#list pagedef.widgets as widget>
    <#if widget.type?? && widget.type != "navigation_bar"><#continue></#if>
    <#list widget.widgets as child>
<@gux.print_html_declare_widget widget=child indent=6 />      
    </#list>
    <#break>
  </#list>
    </div>
  `);
<#else>
  this.title = '${pagedef.options["title"]!"页面标题"}';
  <#if pagedef.id == "home">
  this.icon = '<i class="gx-i gx-i-home gx-pos-relative gx-text-inverse gx-fs-28 gx-fb" style="bottom: -50%;left: 18px;"></i>';
  </#if>
</#if>  
}

Page${js.nameType(guidbase.page_id_to_page_name(pagedef.id))}.prototype.initialize = async function (params) {
  dom.init(this, this.page);
<#if pagedef.id == "home">
  dom.autoheight(this.page, document.body, 88);
<#else>
  dom.autoheight(this.page);
</#if>  
<#if (page.style!"") == 'DIALOG'>
  // 高度调整
  let layerContent = document.querySelector('.layui-layer-content');
  <#list page.widgets as widget>
    <#if widget.widgetType == 'Row'><#continue></#if>
  dom.autoheight(this.widget${js.nameType(widget.variable)}, layerContent, 64);
  </#list>
<#elseif (page.style!"") == 'SIDEBAR'>
  // 页面高度设置
  dom.autoheight(this.page/*, document.body, 64*/);
<#elseif (page.style!"") == 'OVERLAY'>
  // 页面高度设置
  dom.autoheight(this.page.children[1], document.body, 64);
</#if>
<#if (page.style!"") == 'DIALOG'>
  this.onSave = params.onSave;
</#if>
<#list pagedef.pageWidgets![] as widget>
  <#if !widget.type??><#continue></#if>
  <#-- 如果祖先容器是底部弹窗，则忽略 -->
  <#if gux.is_in_bottom_sheet(widget)><#continue></#if>
<@gux.print_js_declare_widget widget=widget indent=2 />  
</#list>
<#-- 放置在此处，优化代码顺序 -->
<#list page.widgets![] as widget>
  <#if widget.widgetType == 'TitleBar'>
<@gux.print_js_methods_titlebar widget=widget indent=2 />
  <#elseif widget.widgetType == 'Separator'>
<@gux.print_js_methods_separator widget=widget indent=2 />
  </#if>
</#list>
};
<#list pagedef.pageWidgets![] as widget>
  <#if !widget.type??><#continue></#if>
  <#if widget.type == "toolbar">  
<@gux.print_js_methods_toolbar widget=widget indent=0 />
  <#elseif widget.type == "editable_form">  
<@gux.print_js_methods_editable_form widget=widget indent=0 />
  <#elseif widget.type == "readonly_form">  
<@gux.print_js_methods_readonly_form widget=widget indent=0 />
  <#elseif widget.type == "tabs">  
<@gux.print_js_methods_tabs widget=widget indent=0 />
  <#elseif widget.type == "scroll_notification">  
<@gux.print_js_methods_scroll_notification widget=widget indent=0 />
  <#elseif widget.type == "swiper_navigator">  
<@gux.print_js_methods_swiper_navigator widget=widget indent=0 />
  <#elseif widget.type == "scroll_navigator">  
<@gux.print_js_methods_scroll_navigator widget=widget indent=0 />
  <#elseif widget.type == "list_navigator">  
<@gux.print_js_methods_list_navigator widget=widget indent=0 />
  <#elseif widget.type == "grid_navigator">  
<@gux.print_js_methods_grid_navigator widget=widget indent=0 />
  <#elseif widget.type == "calendar">  
<@gux.print_js_methods_calendar widget=widget indent=0 />
  <#elseif widget.type == "tree">  
<@gux.print_js_methods_tree widget=widget indent=0 />
  <#elseif widget.type == "list_view">  
<@gux.print_js_methods_list_view widget=widget indent=0 />
  <#elseif widget.type == "grid_view">  
<@gux.print_js_methods_grid_view widget=widget indent=0 />
  <#elseif widget.type == "timeline">  
<@gux.print_js_methods_timeline widget=widget indent=0 />
  <#elseif widget.type == "pagination_table">  
<@gux.print_js_methods_pagination_table widget=widget indent=0 />
  <#elseif widget.type == "pagination_grid">  
<@gux.print_js_methods_pagination_grid widget=widget indent=0 />
  <#elseif widget.type == "spreadsheet">  
<@gux.print_js_methods_spreadsheet widget=widget indent=0 />
  <#elseif widget.type == "kanban">  
<@gux.print_js_methods_kanban widget=widget indent=0 />
  <#elseif widget.type == "chat">  
<@gux.print_js_methods_chat widget=widget indent=0 />
  <#elseif widget.type == "pie_chart">  
<@gux.print_js_methods_pie_chart widget=widget indent=0 />
  <#elseif widget.type == "donut_chart">  
<@gux.print_js_methods_donut_chart widget=widget indent=0 />
  <#elseif widget.type == "bar_chart">  
<@gux.print_js_methods_bar_chart widget=widget indent=0 />
  <#elseif widget.type == "line_chart">  
<@gux.print_js_methods_line_chart widget=widget indent=0 />
  <#elseif widget.type == "stack_chart">  
<@gux.print_js_methods_stack_chart widget=widget indent=0 />
  <#elseif widget.type == "radar_chart">  
<@gux.print_js_methods_radar_chart widget=widget indent=0 />
  <#elseif widget.type == "network_topology_diagram">  
<@gux.print_js_methods_network_topology_diagram widget=widget indent=0 />
  <#elseif widget.type == "business_process_diagram">  
<@gux.print_js_methods_business_process_diagram widget=widget indent=0 />
  <#elseif widget.type == "bottom_sheet">  
<@gux.print_js_methods_bottom_sheet widget=widget indent=0 />
  </#if>
</#list>

Page${js.nameType(guidbase.page_id_to_page_name(pagedef.id))}.prototype.destroy = function () {
<#list page.pageWidgets![] as widget>
  <#if (widget.widgetType!"") == "PaginationTable" ||
       (widget.widgetType!"") == "PaginationGrid">
    <#if !widget.rootWrapper??><#continue></#if>
    <#assign rootObj = widget.rootWrapper.object>
  delete PubSub("${page.applicationName}/${rootObj.getLabelledOptions("name")["module"]}/${rootObj.name}/saved");
  </#if>
</#list>
  delete page${js.nameType(guidbase.page_id_to_page_name(pagedef.id))};
};

Page${js.nameType(guidbase.page_id_to_page_name(pagedef.id))}.prototype.show = function (params) {
  params = params || {};
  this.initialize(params);
};

page${js.nameType(guidbase.page_id_to_page_name(pagedef.id))} = new Page${js.nameType(guidbase.page_id_to_page_name(pagedef.id))}();
</script>