<#import "/$/modelbase.ftl" as guidbase>
<#import "/$/guidbase.ftl" as guidbase>
<#import "/$/gux.ftl" as gux>
<#macro print_html_declare_widget widget indent>
  <#if !widget.type??><#return></#if>
  <#if widget.type == "row">  
${""?left_pad(indent)}<div class="gx-row">
    <#list widget.widgets![] as child>
<@print_html_declare_widget widget=child indent=indent+2 />    
    </#list>
${""?left_pad(indent)}</div>
  <#elseif widget.type == "col">  
    <#assign width = widget.options["width"]!"24">
    <#if width?length == 1>
      <#assign width = "0" + width>
    </#if>
${""?left_pad(indent)}<div class="gx-24-${width} gx-p-8">
    <#list widget.widgets![] as child>
<@print_html_declare_widget widget=child indent=indent+2 />    
    </#list>
${""?left_pad(indent)}</div>
  <#elseif widget.type == "editable_form">  
<@gux.print_html_declare_editable_form widget=widget indent=indent />
  <#elseif widget.type == "readonly_form">  
<@gux.print_html_declare_readonly_form widget=widget indent=indent />
  <#elseif widget.type == "tabs">  
<@gux.print_html_declare_tabs widget=widget indent=indent />
  <#elseif widget.type == "scroll_notification">  
<@gux.print_html_declare_scroll_notification widget=widget indent=indent />
  <#elseif widget.type == "swiper_navigator">  
<@gux.print_html_declare_swiper_navigator widget=widget indent=indent />
  <#elseif widget.type == "scroll_navigator">  
<@gux.print_html_declare_scroll_navigator widget=widget indent=indent />
  <#elseif widget.type == "list_navigator">  
<@gux.print_html_declare_list_navigator widget=widget indent=indent />
  <#elseif widget.type == "grid_navigator">  
<@gux.print_html_declare_grid_navigator widget=widget indent=indent />
  <#elseif widget.type == "grid_view">  
<@gux.print_wxml_declare_grid_view widget=widget indent=indent />
  <#elseif widget.type == "calendar">  
<@gux.print_html_declare_calendar widget=widget indent=indent />
  <#elseif widget.type == "tree">  
<@gux.print_html_declare_tree widget=widget indent=indent />
  <#elseif widget.type == "list_view">  
<@gux.print_html_declare_list_view widget=widget indent=indent />
  <#elseif widget.type == "grid_view">  
<@gux.print_html_declare_grid_view widget=widget indent=indent />
  <#elseif widget.type == "timeline">  
<@gux.print_html_declare_timeline widget=widget indent=indent />
  <#elseif widget.type == "pagination_table">  
<@gux.print_html_declare_pagination_table widget=widget indent=indent />
  <#elseif widget.type == "pagination_grid">  
<@gux.print_html_declare_pagination_grid widget=widget indent=indent />
  <#elseif widget.type == "spreadsheet">  
<@gux.print_html_declare_spreadsheet widget=widget indent=indent />
  <#elseif widget.type == "kanban">  
<@gux.print_html_declare_kanban widget=widget indent=indent />
  <#elseif widget.type == "chat">  
<@gux.print_html_declare_chat widget=widget indent=indent />
  <#elseif widget.type == "pie_chart">  
<@gux.print_html_declare_pie_chart widget=widget indent=indent />
  <#elseif widget.type == "donut_chart">  
<@gux.print_html_declare_donut_chart widget=widget indent=indent />
  <#elseif widget.type == "bar_chart">  
<@gux.print_html_declare_bar_chart widget=widget indent=indent />
  <#elseif widget.type == "line_chart">  
<@gux.print_html_declare_line_chart widget=widget indent=indent />
  <#elseif widget.type == "stack_chart">  
<@gux.print_html_declare_stack_chart widget=widget indent=indent />
  <#elseif widget.type == "radar_chart">  
<@gux.print_html_declare_radar_chart widget=widget indent=indent />
  <#elseif widget.type == "network_topology_diagram">  
<@gux.print_html_declare_network_topology_diagram widget=widget indent=indent />
  <#elseif widget.type == "business_process_diagram">  
<@gux.print_html_declare_business_process_diagram widget=widget indent=indent />
  <#else>
${""?left_pad(indent)}<div widget-id="${js.nameVariable(widget.id!"widget_unknown")}" class="gx-w-full"></div>
  </#if>
</#macro>
<div id="page${js.nameType(guidbase.page_id_to_page_name(pagedef.id))}" class="page">
<#if (pagedef.options["style"]!"VIEW")?upper_case == 'VIEW'>
  <div class="page-header d-flex pl-3 pr-3" >
    <strong>${pagedef.options["title"]!"页面标题"}</strong>
  <#list pagedef.widgets as widget>   
    <#if widget.type == "toolbar">
    <div class="d-flex ms-auto">
<@gux.print_html_declare_toolbar widget=widget indent=6 />    
    </div>
      <#break>
    </#if>  
  </#list>    
  </div>
</#if>  
  <div class="page-body">
<#list pagedef.widgets as widget>
  <#if !widget.type??><#continue></#if>
<@print_html_declare_widget widget=widget indent=4 />  
</#list>
  </div>
</div>
<script>
function Page${js.nameType(guidbase.page_id_to_page_name(pagedef.id))}() {
  this.page = dom.find('#page${js.nameType(guidbase.page_id_to_page_name(pagedef.id))}');
}

Page${js.nameType(guidbase.page_id_to_page_name(pagedef.id))}.prototype.initialize = async function (params) {
  dom.init(this, this.page);
  dom.autoheight(this.page);
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
  <#if widget.type == "toolbar">  
<@gux.print_js_declare_toolbar widget=widget indent=2 />
  <#elseif widget.type == "editable_form">  
<@gux.print_js_declare_editable_form widget=widget indent=2 />
  <#elseif widget.type == "readonly_form">  
<@gux.print_js_declare_readonly_form widget=widget indent=2 />
  <#elseif widget.type == "tabs">  
<@gux.print_js_declare_tabs widget=widget indent=2 />
  <#elseif widget.type == "scroll_notification">  
<@gux.print_js_declare_scroll_notification widget=widget indent=2 />
  <#elseif widget.type == "swiper_navigator">  
<@gux.print_js_declare_swiper_navigator widget=widget indent=2 />
  <#elseif widget.type == "scroll_navigator">  
<@gux.print_js_declare_scroll_navigator widget=widget indent=2 />
  <#elseif widget.type == "list_navigator">  
<@gux.print_js_declare_list_navigator widget=widget indent=2 />
  <#elseif widget.type == "grid_navigator">  
<@gux.print_js_declare_grid_navigator widget=widget indent=2 />
  <#elseif widget.type == "calendar">  
<@gux.print_js_declare_calendar widget=widget indent=2 />
  <#elseif widget.type == "tree">  
<@gux.print_js_declare_tree widget=widget indent=2 />
  <#elseif widget.type == "list_view">  
<@gux.print_js_declare_list_view widget=widget indent=2 />
  <#elseif widget.type == "grid_view">  
<@gux.print_js_declare_grid_view widget=widget indent=2 />
  <#elseif widget.type == "timeline">  
<@gux.print_js_declare_timeline widget=widget indent=2 />
  <#elseif widget.type == "pagination_table">  
<@gux.print_js_declare_pagination_table widget=widget indent=2 />
  <#elseif widget.type == "pagination_grid">  
<@gux.print_js_declare_pagination_grid widget=widget indent=2 />
  <#elseif widget.type == "spreadsheet">  
<@gux.print_js_declare_spreadsheet widget=widget indent=2 />
  <#elseif widget.type == "kanban">  
<@gux.print_js_declare_kanban widget=widget indent=2 />
  <#elseif widget.type == "chat">  
<@gux.print_js_declare_chat widget=widget indent=2 />
  <#elseif widget.type == "pie_chart">  
<@gux.print_js_declare_pie_chart widget=widget indent=2 />
  <#elseif widget.type == "donut_chart">  
<@gux.print_js_declare_donut_chart widget=widget indent=2 />
  <#elseif widget.type == "bar_chart">  
<@gux.print_js_declare_bar_chart widget=widget indent=2 />
  <#elseif widget.type == "line_chart">  
<@gux.print_js_declare_line_chart widget=widget indent=2 />
  <#elseif widget.type == "stack_chart">  
<@gux.print_js_declare_stack_chart widget=widget indent=2 />
  <#elseif widget.type == "radar_chart">  
<@gux.print_js_declare_radar_chart widget=widget indent=2 />
  <#elseif widget.type == "network_topology_diagram">  
<@gux.print_js_declare_network_topology_diagram widget=widget indent=2 />
  <#elseif widget.type == "business_process_diagram">  
<@gux.print_js_declare_business_process_diagram widget=widget indent=2 />
  </#if>
</#list>
<#-- 放置在此处，优化代码顺序 -->
<#list page.widgets![] as widget>
  <#if widget.widgetType == 'TitleBar'>
<@gux.print_js_methods_titlebar widget=widget indent=2 />
  <#elseif widget.widgetType == 'Separator'>
<@gux.print_js_methods_separator widget=widget indent=2 />
  </#if>
</#list>
<#-- 固定按钮 -->
<#if (page.style!"") == 'OVERLAY'>

  dom.bind(this.buttonClose, 'click', ev => {
    this.page.parentElement.remove();
  });
<#elseif (page.style!"") == 'DIALOG'>

  this.layerIndex = layer.index;

  dom.bind(this.buttonClose, 'click', ev => {
    layer.close(this.layerIndex);
  });

  dom.bind(this.buttonConfirm, 'click', ev => {
    if (this.confirm() === true) {
      layer.close(this.layerIndex);
    }
  });
</#if>
};
<#if (page.style!"") == 'VIEW'>
<#elseif (page.style!"") == 'DIALOG'>

Page${js.nameType(guidbase.page_id_to_page_name(pagedef.id))}.prototype.confirm = function () {
  /*!
  ** 封装弹出页的数据
  */
  <#list page.widgets as widget>
    <#if widget.widgetType == 'ListView' && widget.checkable?? && widget.checkable == true>
  let data = this.list${js.nameType(widget.variable!'todo')}.getCheckedValues();
    <#elseif widget.widgetType == "FormLayout">
  let errors = Validation.validate(this.widget${js.nameType(widget.variable!'todo')});
  if (errors.length > 0) {
    dialog.error(utils.message(errors));
    return false;
  }
  let data = this.form${js.nameType(widget.variable!'todo')}.getData();
    </#if>
  </#list>
  // 调用调用页面的API返回数据
  if (this.onSave) {
    this.onSave(data);
  }
  return true;
};
</#if>
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