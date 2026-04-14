<#--
 ###############################################################################
 ### 【工具栏位】
 ###############################################################################
 -->
<#macro print_cpp_declare_row widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}layout->addWidget(buildRow4${cpp.nameType(widget.id)}());
</#macro>

<#macro print_hpp_fields_row widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_cpp_methods_row widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}QWidget* 
${""?left_pad(indent)}Page${cpp.nameType(widget.page.id)}::buildRow4${cpp.nameType(widget.id)}()
${""?left_pad(indent)}{
${""?left_pad(indent)}  QWidget* ret = new QWidget();
${""?left_pad(indent)}  QHBoxLayout* layout = new QHBoxLayout(ret); 
  <#list widget.widgets as child>  
    <#if child.type == "toolbar">  
<@gux.print_cpp_declare_toolbar widget=child indent=indent+2 />
    <#elseif child.type == "editable_form">  
<@gux.print_cpp_declare_editable_form widget=child indent=indent+2 />
    <#elseif child.type == "readonly_form">  
<@gux.print_cpp_declare_readonly_form widget=child indent=indent+2 />
    <#elseif child.type == "tabs">  
<@gux.print_cpp_declare_tabs widget=child indent=indent+2 />
    <#elseif child.type == "scroll_notification">  
<@gux.print_cpp_declare_scroll_notification widget=child indent=indent+2 />
    <#elseif child.type == "swiper_navigator">  
<@gux.print_cpp_declare_swiper_navigator widget=child indent=indent+2 />
    <#elseif child.type == "scroll_navigator">  
<@gux.print_cpp_declare_scroll_navigator widget=child indent=indent+2 />
    <#elseif child.type == "list_navigator">  
<@gux.print_cpp_declare_list_navigator widget=child indent=indent+2 />
    <#elseif child.type == "grid_navigator">  
<@gux.print_cpp_declare_grid_navigator widget=child indent=indent+2 />
    <#elseif child.type == "search_bar">  
<@gux.print_cpp_declare_search_bar widget=child indent=indent+2 />
    <#elseif child.type == "calendar">  
<@gux.print_cpp_declare_calendar widget=child indent=indent+2 />
    <#elseif child.type == "tree">  
<@gux.print_cpp_declare_tree widget=child indent=indent+2 />
    <#elseif child.type == "content_editor">  
<@gux.print_cpp_declare_content_editor widget=child indent=indent+2 />
    <#elseif child.type == "system_console">  
<@gux.print_cpp_declare_system_console widget=child indent=indent+2 />
    <#elseif child.type == "mobile_simulator">  
<@gux.print_cpp_declare_mobile_simulator widget=child indent=indent+2 />
    <#elseif child.type == "list_view">  
<@gux.print_cpp_declare_list_view widget=child indent=indent+2 />
    <#elseif child.type == "grid_view">  
<@gux.print_cpp_declare_grid_view widget=child indent=indent+2 />
    <#elseif child.type == "timeline">  
<@gux.print_cpp_declare_timeline widget=child indent=indent+2 />
    <#elseif child.type == "pagination_table">  
<@gux.print_cpp_declare_pagination_table widget=child indent=indent+2 />
    <#elseif child.type == "pagination_grid">  
<@gux.print_cpp_declare_pagination_grid widget=child indent=indent+2 />
    <#elseif child.type == "spreadsheet">  
<@gux.print_cpp_declare_spreadsheet widget=child indent=indent+2 />
    <#elseif child.type == "kanban">  
<@gux.print_cpp_declare_kanban widget=child indent=indent+2 />
    <#elseif child.type == "chat">  
<@gux.print_cpp_declare_chat widget=child indent=indent+2 />
    <#elseif child.type == "pie_chart">  
<@gux.print_cpp_declare_pie_chart widget=child indent=indent+2 />
    <#elseif child.type == "donut_chart">  
<@gux.print_cpp_declare_donut_chart widget=child indent=indent+2 />
    <#elseif child.type == "bar_chart">  
<@gux.print_cpp_declare_bar_chart widget=child indent=indent+2 />
    <#elseif child.type == "line_chart">  
<@gux.print_cpp_declare_line_chart widget=child indent=indent+2 />
    <#elseif child.type == "stack_chart">  
<@gux.print_cpp_declare_stack_chart widget=child indent=indent+2 />
    <#elseif child.type == "radar_chart">  
<@gux.print_cpp_declare_radar_chart widget=child indent=indent+2 />
    <#elseif child.type == "network_topology_diagram">  
<@gux.print_cpp_declare_network_topology_diagram widget=child indent=indent+2 />
    <#elseif child.type == "business_process_diagram">  
<@gux.print_cpp_declare_business_process_diagram widget=child indent=indent+2 />
    </#if>
  </#list>
${""?left_pad(indent)}  return ret;
${""?left_pad(indent)}}
</#macro>

<#macro print_hpp_methods_row widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}/*!
${""?left_pad(indent)}** 构建行部件。
${""?left_pad(indent)}*/
${""?left_pad(indent)}QWidget* buildRow4${cpp.nameType(widget.id)}();
</#macro>

<#--
 ###############################################################################
 ### 【工具栏位】
 ###############################################################################
 -->
<#macro print_cpp_declare_toolbar widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_hpp_fields_toolbar widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_cpp_methods_toolbar widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_hpp_methods_toolbar widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#--
 ###############################################################################
 ### 【编辑表单】
 ###############################################################################
 -->
<#macro print_cpp_declare_editable_form widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_hpp_fields_editable_form widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_cpp_methods_editable_form widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_hpp_methods_editable_form widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#--
 ###############################################################################
 ### 【只读表单】
 ###############################################################################
 -->
<#macro print_cpp_declare_readonly_form widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_hpp_fields_readonly_form widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_cpp_methods_readonly_form widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_hpp_methods_readonly_form widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#--
 ###############################################################################
 ### 【分页页签】
 ###############################################################################
 -->
<#macro print_cpp_declare_tabs widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_hpp_fields_tabs widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_cpp_methods_tabs widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_hpp_methods_tabs widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#--
 ###############################################################################
 ### 【通知公告】
 ###############################################################################
 -->
<#macro print_cpp_declare_scroll_notification widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_hpp_fields_scroll_notification widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_cpp_methods_scroll_notification widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_hpp_methods_scroll_notification widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#--
 ###############################################################################
 ### 【滚动导航】
 ###############################################################################
 -->
<#macro print_cpp_declare_swiper_navigator widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_hpp_fields_swiper_navigator widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_cpp_methods_swiper_navigator widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_hpp_methods_swiper_navigator widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#--
 ###############################################################################
 ### 【滑动导航】
 ###############################################################################
 -->
<#macro print_cpp_declare_scroll_navigator widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_hpp_fields_scroll_navigator widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_cpp_methods_scroll_navigator widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_hpp_methods_scroll_navigator widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#--
 ###############################################################################
 ### 【列表导航】
 ###############################################################################
 -->
<#macro print_cpp_declare_list_navigator widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_hpp_fields_list_navigator widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_cpp_methods_list_navigator widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_hpp_methods_list_navigator widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#--
 ###############################################################################
 ### 【栅格导航】
 ###############################################################################
 -->
<#macro print_cpp_declare_grid_navigator widget indent>
  QGroupBox* ${cpp.nameVariable(widget.id!"todo")}GridNavigator = new QGroupBox("");
  QHBoxLayout* layout4${cpp.nameType(widget.id!"todo")} = new QHBoxLayout(${cpp.nameVariable(widget.id!"todo")}GridNavigator);
  <#list widget.widgets as child>
${""?left_pad(indent)}
${""?left_pad(indent)}this->button${cpp.nameType(child.id)} = new QPushButton("${child.options["title"]!"标题"}");
${""?left_pad(indent)}this->button${cpp.nameType(child.id)}->setFixedSize(QSize(180, 36));
${""?left_pad(indent)}QObject::connect(this->button${cpp.nameType(child.id)}, &QPushButton::clicked, [&](){
${""?left_pad(indent)}
${""?left_pad(indent)}});
${""?left_pad(indent)}layout4${cpp.nameType(widget.id!"todo")}->addWidget(this->button${cpp.nameType(child.id)});
  </#list>
  layout->addWidget(${cpp.nameVariable(widget.id!"todo")}GridNavigator);
</#macro>

<#macro print_hpp_fields_grid_navigator widget indent>
  <#list widget.widgets as child>
${""?left_pad(indent)}  
${""?left_pad(indent)}QPushButton* button${cpp.nameType(child.id)};
  </#list>
</#macro>

<#macro print_cpp_methods_grid_navigator widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_hpp_methods_grid_navigator widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#--
 ###############################################################################
 ### 【搜索栏位】
 ###############################################################################
 -->
<#macro print_cpp_declare_search_bar widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_hpp_fields_search_bar widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_cpp_methods_search_bar widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_hpp_methods_search_bar widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#--
 ###############################################################################
 ### 【事件日历】
 ###############################################################################
 -->
<#macro print_cpp_declare_calendar widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_hpp_fields_calendar widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_cpp_methods_calendar widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_hpp_methods_calendar widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#--
 ###############################################################################
 ### 【树型结构】
 ###############################################################################
 -->
<#macro print_cpp_declare_tree widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_hpp_fields_tree widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_cpp_methods_tree widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_hpp_methods_tree widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#--
 ###############################################################################
 ### 【内容编辑】
 ###############################################################################
 -->
<#macro print_hpp_declare_content_editor widget indent>
${""?left_pad(indent)}
</#macro>

<#macro print_hpp_fields_content_editor widget indent>
${""?left_pad(indent)}
  <#if widget.options["drop"]??>
${""?left_pad(indent)}GXDroppableTextEdit* editor${cpp.nameType(widget.id)};  
  <#else>
${""?left_pad(indent)}QTextEdit* editor${cpp.nameType(widget.id)};
  </#if>
</#macro>

<#macro print_hpp_methods_content_editor widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_cpp_declare_content_editor widget indent>
${""?left_pad(indent)}
  <#if widget.options["drop"]??>
${""?left_pad(indent)}this->editor${cpp.nameType(widget.id)} = new GXDroppableTextEdit();  
${""?left_pad(indent)}QObject::connect(this->editor${cpp.nameType(widget.id)}, &GXDroppableTextEdit::fileDropped, [](const QString& filepath) {
${""?left_pad(indent)}  // TODO
${""?left_pad(indent)}});
  <#else>
${""?left_pad(indent)}this->editor${cpp.nameType(widget.id)} = new QTextEdit();
  </#if>
${""?left_pad(indent)}layout->addWidget(this->editor${cpp.nameType(widget.id)});
</#macro>

<#macro print_cpp_methods_content_editor widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#--
 ###############################################################################
 ### 【系统输出】
 ###############################################################################
 -->
<#macro print_hpp_fields_system_console widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}QTextEdit* console${cpp.nameType(widget.id)};
</#macro>

<#macro print_hpp_methods_system_console widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_cpp_declare_system_console widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}this->console${cpp.nameType(widget.id)} = new QTextEdit();
${""?left_pad(indent)}this->console${cpp.nameType(widget.id)}->setReadOnly(true);
${""?left_pad(indent)}layout->addWidget(this->console${cpp.nameType(widget.id)});
</#macro>

<#macro print_cpp_methods_system_console widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#--
 ###############################################################################
 ### 【手机模拟】
 ###############################################################################
 -->
<#macro print_hpp_declare_mobile_simulator widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_hpp_fields_mobile_simulator widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_hpp_methods_mobile_simulator widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_cpp_declare_mobile_simulator widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#--
 ###############################################################################
 ### 【传统列表】
 ###############################################################################
 -->
<#macro print_cpp_declare_list_view widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_hpp_fields_list_view widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_cpp_methods_list_view widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_hpp_methods_list_view widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#--
 ###############################################################################
 ### 【栅格列表】
 ###############################################################################
 -->
<#macro print_cpp_declare_grid_view widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_hpp_fields_grid_view widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_cpp_methods_grid_view widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_hpp_methods_grid_view widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#--
 ###############################################################################
 ### 【时间线条】
 ###############################################################################
 -->
<#macro print_cpp_declare_timeline widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_hpp_fields_timeline widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_cpp_methods_timeline widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_hpp_methods_timeline widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#--
 ###############################################################################
 ### 【分页表格】
 ###############################################################################
 -->
<#macro print_cpp_declare_pagination_table widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_hpp_fields_pagination_table widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_cpp_methods_pagination_table widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_hpp_methods_pagination_table widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#--
 ###############################################################################
 ### 【分页栅格】
 ###############################################################################
 -->
<#macro print_cpp_declare_pagination_grid widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_hpp_fields_pagination_grid widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_cpp_methods_pagination_grid widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_hpp_methods_pagination_grid widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#--
 ###############################################################################
 ### 【广义表格】
 ###############################################################################
 -->
<#macro print_cpp_declare_spreadsheet widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_hpp_fields_spreadsheet widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_cpp_methods_spreadsheet widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_hpp_methods_spreadsheet widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#--
 ###############################################################################
 ### 【看板列表】
 ###############################################################################
 -->
<#macro print_cpp_declare_kanban widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_hpp_fields_kanban widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_cpp_methods_kanban widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_hpp_methods_kanban widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#--
 ###############################################################################
 ### 【聊天列表】
 ###############################################################################
 -->
<#macro print_cpp_declare_chat widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_hpp_fields_chat widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_cpp_methods_chat widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_hpp_methods_chat widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#--
 ###############################################################################
 ### 【饼状图】
 ###############################################################################
 -->
<#macro print_cpp_declare_pie_chart widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_hpp_fields_pie_chart widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_cpp_methods_pie_chart widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_hpp_methods_pie_chart widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#--
 ###############################################################################
 ### 【圈状图】
 ###############################################################################
 -->
<#macro print_cpp_declare_donut_chart widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_hpp_fields_donut_chart widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_cpp_methods_donut_chart widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_hpp_methods_donut_chart widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#--
 ###############################################################################
 ### 【柱状图】
 ###############################################################################
 -->
<#macro print_cpp_declare_bar_chart widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_hpp_fields_bar_chart widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_cpp_methods_bar_chart widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_hpp_methods_bar_chart widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#--
 ###############################################################################
 ### 【折线图】
 ###############################################################################
 -->
<#macro print_cpp_declare_line_chart widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_hpp_fields_line_chart widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_cpp_methods_line_chart widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_hpp_methods_line_chart widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#--
 ###############################################################################
 ### 【堆栈图】
 ###############################################################################
 -->
<#macro print_cpp_declare_stack_chart widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_hpp_fields_stack_chart widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_cpp_methods_stack_chart widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_hpp_methods_stack_chart widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#--
 ###############################################################################
 ### 【雷达图】
 ###############################################################################
 -->
<#macro print_cpp_declare_radar_chart widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_hpp_fields_radar_chart widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_cpp_methods_radar_chart widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_hpp_methods_radar_chart widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#--
 ###############################################################################
 ### 【网络拓扑图】
 ###############################################################################
 -->
<#macro print_cpp_declare_network_topology_diagram widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_hpp_fields_network_topology_diagram widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_cpp_methods_network_topology_diagram widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_hpp_methods_network_topology_diagram widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#--
 ###############################################################################
 ### 【业务流程图】
 ###############################################################################
 -->
<#macro print_cpp_declare_business_process_diagram widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_hpp_fields_business_process_diagram widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_cpp_methods_business_process_diagram widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_hpp_methods_business_process_diagram widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>
