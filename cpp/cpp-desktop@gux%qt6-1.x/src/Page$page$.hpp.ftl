<#import "/$/guidbase.ftl" as guidbase>
<#import "/$/gux.ftl" as gux>
<#if license??>
${cpp.license(license)}
</#if>
#pragma once

#include <QWidget>
#include <QTextEdit>
#include <QPushButton>

#include "gux/gux.hpp"

class Page${cpp.nameType(guidbase.page_id_to_page_name(pagedef.id))} : public QWidget
{
  
public:
  
  /*!
  ** 【${pagedef.options["title"]!"未命名"}页面】构造函数。
  */
  Page${cpp.nameType(guidbase.page_id_to_page_name(pagedef.id))}(QWidget* parent = nullptr);
  
  /*!
  ** 【${pagedef.options["title"]!"未命名"}页面】析构函数。
  */
  ~Page${cpp.nameType(guidbase.page_id_to_page_name(pagedef.id))}();
<#list pagedef.pageWidgets as widget>  
  <#if !widget.type??><#continue></#if>
  <#if widget.type == "row">
<@gux.print_hpp_methods_row widget=widget indent=2 />
  <#elseif widget.type == "toolbar">  
<@gux.print_hpp_methods_row widget=widget indent=2 />
  <#elseif widget.type == "toolbar">  
<@gux.print_hpp_methods_toolbar widget=widget indent=2 />
  <#elseif widget.type == "editable_form">  
<@gux.print_hpp_methods_editable_form widget=widget indent=2 />
  <#elseif widget.type == "readonly_form">  
<@gux.print_hpp_methods_readonly_form widget=widget indent=2 />
  <#elseif widget.type == "tabs">  
<@gux.print_hpp_methods_tabs widget=widget indent=2 />
  <#elseif widget.type == "scroll_notification">  
<@gux.print_hpp_methods_scroll_notification widget=widget indent=2 />
  <#elseif widget.type == "swiper_navigator">  
<@gux.print_hpp_methods_swiper_navigator widget=widget indent=2 />
  <#elseif widget.type == "scroll_navigator">  
<@gux.print_hpp_methods_scroll_navigator widget=widget indent=2 />
  <#elseif widget.type == "list_navigator">  
<@gux.print_hpp_methods_list_navigator widget=widget indent=2 />
  <#elseif widget.type == "grid_navigator">  
<@gux.print_hpp_methods_grid_navigator widget=widget indent=2 />
  <#elseif widget.type == "search_bar">  
<@gux.print_hpp_methods_search_bar widget=widget indent=2 />
  <#elseif widget.type == "calendar">  
<@gux.print_hpp_methods_calendar widget=widget indent=2 />
  <#elseif widget.type == "tree">  
<@gux.print_hpp_methods_tree widget=widget indent=2 />
  <#elseif widget.type == "content_editor"> 
<@gux.print_hpp_methods_content_editor widget=widget indent=2 />
  <#elseif widget.type == "system_console"> 
<@gux.print_hpp_methods_system_console widget=widget indent=2 />
  <#elseif widget.type == "mobile_simulator"> 
<@gux.print_hpp_methods_mobile_simulator widget=widget indent=2 />
  <#elseif widget.type == "list_view">  
<@gux.print_hpp_methods_list_view widget=widget indent=2 />
  <#elseif widget.type == "grid_view">  
<@gux.print_hpp_methods_grid_view widget=widget indent=2 />
  <#elseif widget.type == "timeline">  
<@gux.print_hpp_methods_timeline widget=widget indent=2 />
  <#elseif widget.type == "pagination_table">  
<@gux.print_hpp_methods_pagination_table widget=widget indent=2 />
  <#elseif widget.type == "pagination_grid">  
<@gux.print_hpp_methods_pagination_grid widget=widget indent=2 />
  <#elseif widget.type == "spreadsheet">  
<@gux.print_hpp_methods_spreadsheet widget=widget indent=2 />
  <#elseif widget.type == "kanban">  
<@gux.print_hpp_methods_kanban widget=widget indent=2 />
  <#elseif widget.type == "chat">  
<@gux.print_hpp_methods_chat widget=widget indent=2 />
  <#elseif widget.type == "pie_chart">  
<@gux.print_hpp_methods_pie_chart widget=widget indent=2 />
  <#elseif widget.type == "donut_chart">  
<@gux.print_hpp_methods_donut_chart widget=widget indent=2 />
  <#elseif widget.type == "bar_chart">  
<@gux.print_hpp_methods_bar_chart widget=widget indent=2 />
  <#elseif widget.type == "line_chart">  
<@gux.print_hpp_methods_line_chart widget=widget indent=2 />
  <#elseif widget.type == "stack_chart">  
<@gux.print_hpp_methods_stack_chart widget=widget indent=2 />
  <#elseif widget.type == "radar_chart">  
<@gux.print_hpp_methods_radar_chart widget=widget indent=2 />
  <#elseif widget.type == "network_topology_diagram">  
<@gux.print_hpp_methods_network_topology_diagram widget=widget indent=2 />
  <#elseif widget.type == "business_process_diagram">  
<@gux.print_hpp_methods_business_process_diagram widget=widget indent=2 />
  </#if>
</#list>

private:
<#list pagedef.pageWidgets as widget>  
  <#if !widget.type??><#continue></#if>
  <#if widget.type == "toolbar">  
<@gux.print_hpp_fields_toolbar widget=widget indent=2 />
  <#elseif widget.type == "editable_form">  
<@gux.print_hpp_fields_editable_form widget=widget indent=2 />
  <#elseif widget.type == "readonly_form">  
<@gux.print_hpp_fields_readonly_form widget=widget indent=2 />
  <#elseif widget.type == "tabs">  
<@gux.print_hpp_fields_tabs widget=widget indent=2 />
  <#elseif widget.type == "scroll_notification">  
<@gux.print_hpp_fields_scroll_notification widget=widget indent=2 />
  <#elseif widget.type == "swiper_navigator">  
<@gux.print_hpp_fields_swiper_navigator widget=widget indent=2 />
  <#elseif widget.type == "scroll_navigator">  
<@gux.print_hpp_fields_scroll_navigator widget=widget indent=2 />
  <#elseif widget.type == "list_navigator">  
<@gux.print_hpp_fields_list_navigator widget=widget indent=2 />
  <#elseif widget.type == "grid_navigator">  
<@gux.print_hpp_fields_grid_navigator widget=widget indent=2 />
  <#elseif widget.type == "search_bar">  
<@gux.print_hpp_fields_search_bar widget=widget indent=2 />
  <#elseif widget.type == "calendar">  
<@gux.print_hpp_fields_calendar widget=widget indent=2 />
  <#elseif widget.type == "tree">  
<@gux.print_hpp_fields_tree widget=widget indent=2 />
  <#elseif widget.type == "content_editor">  
<@gux.print_hpp_fields_content_editor widget=widget indent=2 />
  <#elseif widget.type == "system_console">  
<@gux.print_hpp_fields_system_console widget=widget indent=2 />
  <#elseif widget.type == "mobile_simulator">  
<@gux.print_hpp_fields_mobile_simulator widget=widget indent=2 />
  <#elseif widget.type == "list_view">  
<@gux.print_hpp_fields_list_view widget=widget indent=2 />
  <#elseif widget.type == "grid_view">  
<@gux.print_hpp_fields_grid_view widget=widget indent=2 />
  <#elseif widget.type == "timeline">  
<@gux.print_hpp_fields_timeline widget=widget indent=2 />
  <#elseif widget.type == "pagination_table">  
<@gux.print_hpp_fields_pagination_table widget=widget indent=2 />
  <#elseif widget.type == "pagination_grid">  
<@gux.print_hpp_fields_pagination_grid widget=widget indent=2 />
  <#elseif widget.type == "spreadsheet">  
<@gux.print_hpp_fields_spreadsheet widget=widget indent=2 />
  <#elseif widget.type == "kanban">  
<@gux.print_hpp_fields_kanban widget=widget indent=2 />
  <#elseif widget.type == "chat">  
<@gux.print_hpp_fields_chat widget=widget indent=2 />
  <#elseif widget.type == "pie_chart">  
<@gux.print_hpp_fields_pie_chart widget=widget indent=2 />
  <#elseif widget.type == "donut_chart">  
<@gux.print_hpp_fields_donut_chart widget=widget indent=2 />
  <#elseif widget.type == "bar_chart">  
<@gux.print_hpp_fields_bar_chart widget=widget indent=2 />
  <#elseif widget.type == "line_chart">  
<@gux.print_hpp_fields_line_chart widget=widget indent=2 />
  <#elseif widget.type == "stack_chart">  
<@gux.print_hpp_fields_stack_chart widget=widget indent=2 />
  <#elseif widget.type == "radar_chart">  
<@gux.print_hpp_fields_radar_chart widget=widget indent=2 />
  <#elseif widget.type == "network_topology_diagram">  
<@gux.print_hpp_fields_network_topology_diagram widget=widget indent=2 />
  <#elseif widget.type == "business_process_diagram">  
<@gux.print_hpp_fields_business_process_diagram widget=widget indent=2 />
  </#if>
</#list>  
};