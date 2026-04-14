<#import "/$/guidbase.ftl" as guidbase>
<#import "/$/gux.ftl" as gux>
<#if license??>
${cpp.license(license)}
</#if>
<#assign pageModule = guidbase.page_id_to_module(page.id)>
<#assign pageName = guidbase.page_id_to_page_name(page.id)>
#include <QVBoxLayout>
#include <QHBoxLayout>
#include <QGroupBox>
#include <QtConcurrent/QtConcurrent>

#include "Page${cpp.nameType(pageName)}.hpp"

Page${cpp.nameType(pageName)}::Page${cpp.nameType(pageName)}(QWidget* parent) : QWidget(parent)
{
  QVBoxLayout* layout = new QVBoxLayout(this);
<#list pagedef.widgets as widget>  
  <#if !widget.type??><#continue></#if>
  <#if widget.type == "row">
<@gux.print_cpp_declare_row widget=widget indent=2 />  
  <#elseif widget.type == "toolbar">  
<@gux.print_cpp_declare_toolbar widget=widget indent=2 />
  <#elseif widget.type == "editable_form">  
<@gux.print_cpp_declare_editable_form widget=widget indent=2 />
  <#elseif widget.type == "readonly_form">  
<@gux.print_cpp_declare_readonly_form widget=widget indent=2 />
  <#elseif widget.type == "tabs">  
<@gux.print_cpp_declare_tabs widget=widget indent=2 />
  <#elseif widget.type == "scroll_notification">  
<@gux.print_cpp_declare_scroll_notification widget=widget indent=2 />
  <#elseif widget.type == "swiper_navigator">  
<@gux.print_cpp_declare_swiper_navigator widget=widget indent=2 />
  <#elseif widget.type == "scroll_navigator">  
<@gux.print_cpp_declare_scroll_navigator widget=widget indent=2 />
  <#elseif widget.type == "list_navigator">  
<@gux.print_cpp_declare_list_navigator widget=widget indent=2 />
  <#elseif widget.type == "grid_navigator">  
<@gux.print_cpp_declare_grid_navigator widget=widget indent=2 />
  <#elseif widget.type == "search_bar">  
<@gux.print_cpp_declare_search_bar widget=widget indent=2 />
  <#elseif widget.type == "calendar">  
<@gux.print_cpp_declare_calendar widget=widget indent=2 />
  <#elseif widget.type == "tree">  
<@gux.print_cpp_declare_tree widget=widget indent=2 />
  <#elseif widget.type == "content_editor">  
<@gux.print_cpp_declare_content_editor widget=widget indent=2 />
  <#elseif widget.type == "system_console">  
<@gux.print_cpp_declare_system_console widget=widget indent=2 />
  <#elseif widget.type == "mobile_simulator">  
<@gux.print_cpp_declare_mobile_simulator widget=widget indent=2 />
  <#elseif widget.type == "list_view">  
<@gux.print_cpp_declare_list_view widget=widget indent=2 />
  <#elseif widget.type == "grid_view">  
<@gux.print_cpp_declare_grid_view widget=widget indent=2 />
  <#elseif widget.type == "timeline">  
<@gux.print_cpp_declare_timeline widget=widget indent=2 />
  <#elseif widget.type == "pagination_table">  
<@gux.print_cpp_declare_pagination_table widget=widget indent=2 />
  <#elseif widget.type == "pagination_grid">  
<@gux.print_cpp_declare_pagination_grid widget=widget indent=2 />
  <#elseif widget.type == "spreadsheet">  
<@gux.print_cpp_declare_spreadsheet widget=widget indent=2 />
  <#elseif widget.type == "kanban">  
<@gux.print_cpp_declare_kanban widget=widget indent=2 />
  <#elseif widget.type == "chat">  
<@gux.print_cpp_declare_chat widget=widget indent=2 />
  <#elseif widget.type == "pie_chart">  
<@gux.print_cpp_declare_pie_chart widget=widget indent=2 />
  <#elseif widget.type == "donut_chart">  
<@gux.print_cpp_declare_donut_chart widget=widget indent=2 />
  <#elseif widget.type == "bar_chart">  
<@gux.print_cpp_declare_bar_chart widget=widget indent=2 />
  <#elseif widget.type == "line_chart">  
<@gux.print_cpp_declare_line_chart widget=widget indent=2 />
  <#elseif widget.type == "stack_chart">  
<@gux.print_cpp_declare_stack_chart widget=widget indent=2 />
  <#elseif widget.type == "radar_chart">  
<@gux.print_cpp_declare_radar_chart widget=widget indent=2 />
  <#elseif widget.type == "network_topology_diagram">  
<@gux.print_cpp_declare_network_topology_diagram widget=widget indent=2 />
  <#elseif widget.type == "business_process_diagram">  
<@gux.print_cpp_declare_business_process_diagram widget=widget indent=2 />
  </#if>
</#list>
}

Page${cpp.nameType(pageName)}::~Page${cpp.nameType(pageName)}()
{
}

<#list pagedef.widgets as widget>  
  <#if !widget.type??><#continue></#if>
  <#if widget.type == "row">  
<@gux.print_cpp_methods_row widget=widget indent=0 />
  <#elseif widget.type == "toolbar">  
<@gux.print_cpp_methods_toolbar widget=widget indent=0 />
  <#elseif widget.type == "editable_form">  
<@gux.print_cpp_methods_editable_form widget=widget indent=0 />
  <#elseif widget.type == "readonly_form">  
<@gux.print_cpp_methods_readonly_form widget=widget indent=0 />
  <#elseif widget.type == "tabs">  
<@gux.print_cpp_methods_tabs widget=widget indent=0 />
  <#elseif widget.type == "scroll_notification">  
<@gux.print_cpp_methods_scroll_notification widget=widget indent=0 />
  <#elseif widget.type == "swiper_navigator">  
<@gux.print_cpp_methods_swiper_navigator widget=widget indent=0 />
  <#elseif widget.type == "scroll_navigator">  
<@gux.print_cpp_methods_scroll_navigator widget=widget indent=0 />
  <#elseif widget.type == "list_navigator">  
<@gux.print_cpp_methods_list_navigator widget=widget indent=0 />
  <#elseif widget.type == "grid_navigator">  
<@gux.print_cpp_methods_grid_navigator widget=widget indent=0 />
  <#elseif widget.type == "search_bar">  
<@gux.print_cpp_methods_search_bar widget=widget indent=0 />
  <#elseif widget.type == "calendar">  
<@gux.print_cpp_methods_calendar widget=widget indent=0 />
  <#elseif widget.type == "tree">  
<@gux.print_cpp_methods_tree widget=widget indent=0 />
  <#elseif widget.type == "content_editor"> 
<@gux.print_cpp_methods_content_editor widget=widget indent=0 />
  <#elseif widget.type == "system_console"> 
<@gux.print_cpp_methods_system_console widget=widget indent=0 />
  <#elseif widget.type == "mobile_simulator"> 
<@gux.print_cpp_methods_mobile_simulator widget=widget indent=0 />
  <#elseif widget.type == "list_view">  
<@gux.print_cpp_methods_list_view widget=widget indent=0 />
  <#elseif widget.type == "grid_view">  
<@gux.print_cpp_methods_grid_view widget=widget indent=0 />
  <#elseif widget.type == "timeline">  
<@gux.print_cpp_methods_timeline widget=widget indent=0 />
  <#elseif widget.type == "pagination_table">  
<@gux.print_cpp_methods_pagination_table widget=widget indent=0 />
  <#elseif widget.type == "pagination_grid">  
<@gux.print_cpp_methods_pagination_grid widget=widget indent=0 />
  <#elseif widget.type == "spreadsheet">  
<@gux.print_cpp_methods_spreadsheet widget=widget indent=0 />
  <#elseif widget.type == "kanban">  
<@gux.print_cpp_methods_kanban widget=widget indent=0 />
  <#elseif widget.type == "chat">  
<@gux.print_cpp_methods_chat widget=widget indent=0 />
  <#elseif widget.type == "pie_chart">  
<@gux.print_cpp_methods_pie_chart widget=widget indent=0 />
  <#elseif widget.type == "donut_chart">  
<@gux.print_cpp_methods_donut_chart widget=widget indent=0 />
  <#elseif widget.type == "bar_chart">  
<@gux.print_cpp_methods_bar_chart widget=widget indent=0 />
  <#elseif widget.type == "line_chart">  
<@gux.print_cpp_methods_line_chart widget=widget indent=0 />
  <#elseif widget.type == "stack_chart">  
<@gux.print_cpp_methods_stack_chart widget=widget indent=0 />
  <#elseif widget.type == "radar_chart">  
<@gux.print_cpp_methods_radar_chart widget=widget indent=0 />
  <#elseif widget.type == "network_topology_diagram">  
<@gux.print_cpp_methods_network_topology_diagram widget=widget indent=0 />
  <#elseif widget.type == "business_process_diagram">  
<@gux.print_cpp_methods_business_process_diagram widget=widget indent=0 />
  </#if>
</#list>