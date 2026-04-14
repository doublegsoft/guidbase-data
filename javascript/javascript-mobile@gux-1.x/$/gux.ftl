<#import "/$/guidbase.ftl" as guidbase>

<#function is_in_bottom_sheet widget>
  <#local container = widget>
  <#list 0..1000 as index>
    <#if widget.container??>
      <#local container = widget.container>
      <#if container.type == "bottom_sheet">
        <#return true>
      </#if>
    <#else>
      <#break>
    </#if>
  </#list>
  <#return false>
</#function>

<#macro print_method_body_by_url url indent>
  <#local pagepath = guidbase.url_to_page_path(url)>
  <#local params = guidbase.get_params_from_url(url)>
  <#if url?starts_with("$")>
    <#if pagepath?starts_with("common")>
${""?left_pad(indent)}gux.navigateTo(`/mhtml/${pagepath}.html${guidbase.state_params_with_values_in_url(params, "model")}`,{
    <#else>
${""?left_pad(indent)}gux.navigateTo(`/mhtml/${app.name}/${pagepath}.html${guidbase.state_params_with_values_in_url(params, "model")}`,{
    </#if>
${""?left_pad(indent)}});
  <#else>
${""?left_pad(indent)}console.log(model);
  </#if>
</#macro>

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
${""?left_pad(indent)}<div class="gx-24-${guidbase.remake_column_width(width)} gx-p-8">
    <#list widget.widgets![] as child>
<@print_html_declare_widget widget=child indent=indent+2 />    
    </#list>
${""?left_pad(indent)}</div>
  <#elseif widget.type == "text">  
${""?left_pad(indent)}<div class="gx-fs-24 gx-fb gx-px-16 gx-my-8">${widget.options["title"]!"标题"}</div>
  <#elseif widget.type == "image">  
${""?left_pad(indent)}<img src="${widget.options["image"]!""}" style="width:100%;height:100%;">
  <#elseif widget.type == "toolbar">  
${""?left_pad(indent)}<div class="gx-px-16 gx-my-8">    
<@print_html_declare_toolbar widget=widget indent=indent+2 />  
${""?left_pad(indent)}</div>
  <#elseif widget.type == "editable_form">  
<@print_html_declare_editable_form widget=widget indent=indent />
  <#elseif widget.type == "readonly_form">  
<@print_html_declare_readonly_form widget=widget indent=indent />
  <#elseif widget.type == "tabs">  
<@print_html_declare_tabs widget=widget indent=indent />
  <#elseif widget.type == "scroll_notification">  
<@print_html_declare_scroll_notification widget=widget indent=indent />
  <#elseif widget.type == "swiper_navigator">  
<@print_html_declare_swiper_navigator widget=widget indent=indent />
  <#elseif widget.type == "scroll_navigator">  
<@print_html_declare_scroll_navigator widget=widget indent=indent />
  <#elseif widget.type == "list_navigator">  
<@print_html_declare_list_navigator widget=widget indent=indent />
  <#elseif widget.type == "grid_navigator">  
<@print_html_declare_grid_navigator widget=widget indent=indent />
  <#elseif widget.type == "calendar">  
<@print_html_declare_calendar widget=widget indent=indent />
  <#elseif widget.type == "tree">  
<@print_html_declare_tree widget=widget indent=indent />
  <#elseif widget.type == "list_view">  
<@print_html_declare_list_view widget=widget indent=indent />
  <#elseif widget.type == "grid_view">  
<@print_html_declare_grid_view widget=widget indent=indent />
  <#elseif widget.type == "timeline">  
<@print_html_declare_timeline widget=widget indent=indent />
  <#elseif widget.type == "pagination_table">  
<@print_html_declare_pagination_table widget=widget indent=indent />
  <#elseif widget.type == "pagination_grid">  
<@print_html_declare_pagination_grid widget=widget indent=indent />
  <#elseif widget.type == "spreadsheet">  
<@print_html_declare_spreadsheet widget=widget indent=indent />
  <#elseif widget.type == "kanban">  
<@print_html_declare_kanban widget=widget indent=indent />
  <#elseif widget.type == "chat">  
<@print_html_declare_chat widget=widget indent=indent />
  <#elseif widget.type == "pie_chart">  
<@print_html_declare_pie_chart widget=widget indent=indent />
  <#elseif widget.type == "donut_chart">  
<@print_html_declare_donut_chart widget=widget indent=indent />
  <#elseif widget.type == "bar_chart">  
<@print_html_declare_bar_chart widget=widget indent=indent />
  <#elseif widget.type == "line_chart">  
<@print_html_declare_line_chart widget=widget indent=indent />
  <#elseif widget.type == "stack_chart">  
<@print_html_declare_stack_chart widget=widget indent=indent />
  <#elseif widget.type == "radar_chart">  
<@print_html_declare_radar_chart widget=widget indent=indent />
  <#elseif widget.type == "network_topology_diagram">  
<@print_html_declare_network_topology_diagram widget=widget indent=indent />
  <#elseif widget.type == "business_process_diagram">  
<@print_html_declare_business_process_diagram widget=widget indent=indent />
  </#if>
</#macro>

<#macro print_js_declare_widget widget indent>
  <#if widget.type == "toolbar">  
<@gux.print_js_declare_toolbar widget=widget indent=indent />
  <#elseif widget.type == "editable_form">  
<@gux.print_js_declare_editable_form widget=widget indent=indent />
  <#elseif widget.type == "readonly_form">  
<@gux.print_js_declare_readonly_form widget=widget indent=indent />
  <#elseif widget.type == "tabs">  
<@gux.print_js_declare_tabs widget=widget indent=indent />
  <#elseif widget.type == "scroll_notification">  
<@gux.print_js_declare_scroll_notification widget=widget indent=indent />
  <#elseif widget.type == "swiper_navigator">  
<@gux.print_js_declare_swiper_navigator widget=widget indent=indent />
  <#elseif widget.type == "scroll_navigator">  
<@gux.print_js_declare_scroll_navigator widget=widget indent=indent />
  <#elseif widget.type == "list_navigator">  
<@gux.print_js_declare_list_navigator widget=widget indent=indent />
  <#elseif widget.type == "grid_navigator">  
<@gux.print_js_declare_grid_navigator widget=widget indent=indent />
  <#elseif widget.type == "calendar">  
<@gux.print_js_declare_calendar widget=widget indent=indent />
  <#elseif widget.type == "tree">  
<@gux.print_js_declare_tree widget=widget indent=indent />
  <#elseif widget.type == "list_view">  
<@gux.print_js_declare_list_view widget=widget indent=indent />
  <#elseif widget.type == "grid_view">  
<@gux.print_js_declare_grid_view widget=widget indent=indent />
  <#elseif widget.type == "timeline">  
<@gux.print_js_declare_timeline widget=widget indent=indent />
  <#elseif widget.type == "pagination_table">  
<@gux.print_js_declare_pagination_table widget=widget indent=indent />
  <#elseif widget.type == "pagination_grid">  
<@gux.print_js_declare_pagination_grid widget=widget indent=indent />
  <#elseif widget.type == "spreadsheet">  
<@gux.print_js_declare_spreadsheet widget=widget indent=indent />
  <#elseif widget.type == "kanban">  
<@gux.print_js_declare_kanban widget=widget indent=indent />
  <#elseif widget.type == "chat">  
<@gux.print_js_declare_chat widget=widget indent=indent />
  <#elseif widget.type == "pie_chart">  
<@gux.print_js_declare_pie_chart widget=widget indent=indent />
  <#elseif widget.type == "donut_chart">  
<@gux.print_js_declare_donut_chart widget=widget indent=indent />
  <#elseif widget.type == "bar_chart">  
<@gux.print_js_declare_bar_chart widget=widget indent=indent />
  <#elseif widget.type == "line_chart">  
<@gux.print_js_declare_line_chart widget=widget indent=indent />
  <#elseif widget.type == "stack_chart">  
<@gux.print_js_declare_stack_chart widget=widget indent=indent />
  <#elseif widget.type == "radar_chart">  
<@gux.print_js_declare_radar_chart widget=widget indent=indent />
  <#elseif widget.type == "network_topology_diagram">  
<@gux.print_js_declare_network_topology_diagram widget=widget indent=indent />
  <#elseif widget.type == "business_process_diagram">  
<@gux.print_js_declare_business_process_diagram widget=widget indent=indent />
  </#if>
</#macro>

<#--
 ###############################################################################
 ### 【编辑表单】字段中options配置项的一致的输出函数
 ###############################################################################
 -->
<#macro print_js_declare_editable_form_field_options widget indent>
  <#if widget.type == "select">
${""?left_pad(indent)}options: {
    <#if widget.id?ends_with("_id")>
${""?left_pad(indent)}  url: '', 
${""?left_pad(indent)}  fields: {text: '${js.nameVariable(widget.id)?replace("Id", "Name")}', vallue: '${js.nameVariable(widget.id)}'},
    <#else>
${""?left_pad(indent)}  values: [{
${""?left_pad(indent)}    text: '选项A', value: 'A',
${""?left_pad(indent)}  },{
${""?left_pad(indent)}    text: '选项B', value: 'B',
${""?left_pad(indent)}  },{
${""?left_pad(indent)}    text: '选项C', value: 'C',
${""?left_pad(indent)}  }],     
    </#if>
${""?left_pad(indent)}},  
  <#elseif widget.type == "segment">
    <#local values = widget.options["values"]!"[]">
    <#local vals = guidbase.values_to_options_values(values)>
${""?left_pad(indent)}options: {
${""?left_pad(indent)}  values: [{
  <#list vals as val>
    <#if val?index != 0>
${""?left_pad(indent)}  },{
    </#if>
${""?left_pad(indent)}    text: '${val.text}', value: '${val.value}',
  </#list>
${""?left_pad(indent)}  }],  
${""?left_pad(indent)}},    
  </#if>
</#macro>

<#--
 ###############################################################################
 ### 【分页表格】列中display方法的一致的输出函数
 ###############################################################################
 -->
<#macro print_js_declare_pagination_table_column_display widget indent>
  <#if widget.type == 'text'>
${""?left_pad(indent)}td.innerHTML = row.${js.nameVariable(widget.id)};  
  <#elseif widget.type == 'date'>
${""?left_pad(indent)}td.innerHTML = moment(row.${js.nameVariable(widget.id)}).format('YYYY年MM月DD日');  
  </#if>
  <#list widget.widgets as child>
    <#local url = child.options["url"]!"">
    <#if child.type == "button">
${""?left_pad(indent)}/*!
${""?left_pad(indent)}** ${child.options["title"]!"未定义"}
${""?left_pad(indent)}*/
${""?left_pad(indent)}let ${js.nameVariable(child.id!"Unknown")} = dom.templatize(`
${""?left_pad(indent)}  <a class="btn-sm btn-link">${child.options["title"]!"标题"}</a>
${""?left_pad(indent)}`, row);
${""?left_pad(indent)}dom.bind(${js.nameVariable(child.id!"Unknown")}, 'click', ev => {
      <#if url?contains("/delete") || url?contains("/remove")>
${""?left_pad(indent)}  dialog.confirm('确定删除该条信息？', () => {
${""?left_pad(indent)}    this.${js.nameVariable(guidbase.url_to_method_name(url))}(model);
${""?left_pad(indent)}  });      
      <#else>
${""?left_pad(indent)}  this.${js.nameVariable(guidbase.url_to_method_name(url))}(model);
      </#if>
${""?left_pad(indent)}}); 
${""?left_pad(indent)}td.appendChild(${js.nameVariable(child.id!"Unknown")});
    </#if>
  </#list>
</#macro>

<#--
 ###############################################################################
 ### 【数据瓦片】构造方法
 ###############################################################################
 -->
<#macro print_js_declare_tile widget indent>
  <#local hasQuaternarySection = false>
  <#local rows = 1>
  <#list widget.widgets as child>
    <#if (child.options["level"]!"") == "quinary" ||  
         (child.options["level"]!"") == "senary" ||
         (child.options["level"]!"") == "septenary">
      <#local rows = rows + 1>   
    </#if>     
  </#list>
  <#list widget.widgets as child>
    <#if (child.options["level"]!"") == "quaternary">
      <#local hasQuaternarySection = true>
    </#if>
  </#list>
${""?left_pad(indent)}let ret = dom.templatize(`
  <#if rows == 1>
${""?left_pad(indent)}  <div class="d-flex">
<@print_js_declare_tile_first_row widget=widget indent=indent+4 />
${""?left_pad(indent)}  </div>
  <#else>
${""?left_pad(indent)}  <div>
${""?left_pad(indent)}    <div class="gx-d-flex">
<@print_js_declare_tile_first_row widget=widget indent=indent+6 />
${""?left_pad(indent)}    </div>
  <#if hasQuaternarySection>
  <#list widget.widgets as child>
    <#if (child.options["level"]!"") != "quaternary"><#continue></#if>
${""?left_pad(indent)}    <div class="gx-text-secondary gx-fs-10">{{${js.nameVariable(child.id)}}}</div>    
  </#list>  
  </#if>
${""?left_pad(indent)}    <div class="gx-d-flex">
<@print_js_declare_tile_second_row widget=widget indent=indent+6 />
${""?left_pad(indent)}    </div>
${""?left_pad(indent)}  </div>
  </#if>
${""?left_pad(indent)}`, row);
${""?left_pad(indent)}return ret;
</#macro>

<#macro print_js_declare_tile_first_row widget indent>
  <#local hasPrimarySection = false>
  <#list widget.widgets as child>
    <#if (child.options["level"]!"") == "image" || (child.options["level"]!"") == "avatar">
${""?left_pad(indent)}<div style="width: 72px;">
${""?left_pad(indent)}  <image src="{{${js.nameVariable(child.id)}}}" class="gx-wh-64">
${""?left_pad(indent)}</div>  
    </#if>
    <#if (child.options["level"]!"") == "primary" || 
         (child.options["level"]!"") == "secondary" ||
         (child.options["level"]!"") == "tertiary">
      <#local hasPrimarySection = true>   
    </#if>     
  </#list>
  <#if hasPrimarySection>   
${""?left_pad(indent)}<div>  
  <#list widget.widgets as child>
    <#if (child.options["level"]!"") == "primary">
${""?left_pad(indent)}  <div class="gx-text-primary">{{${js.nameVariable(child.id)}}}</div>
    <#elseif (child.options["level"]!"") == "secondary">
${""?left_pad(indent)}  <div class="gx-text-secondary">{{${js.nameVariable(child.id)}}}</div>
    <#elseif (child.options["level"]!"") == "tertiary">
${""?left_pad(indent)}  <div class="gx-text-secondary gx-fs-12">{{${js.nameVariable(child.id)}}}</div>
    </#if>
  </#list>
${""?left_pad(indent)}</div>  
  </#if>
  <#list widget.widgets as child>
    <#if (child.options["level"]!"") == "accent">
${""?left_pad(indent)}<div class="gx-ml-auto gx-d-flex" style="align-items:center;">
${""?left_pad(indent)}  <div class="gx-fs-16 gx-fb">{{${js.nameVariable(child.id)}}}</div>
${""?left_pad(indent)}</div>  
    </#if>
  </#list>
</#macro>

<#macro print_js_declare_tile_second_row widget indent> 
  <#list widget.widgets as child>
    <#if (child.options["level"]!"") == "quinary">
${""?left_pad(indent)}<div class="d-flex">
${""?left_pad(indent)}  <i class="fas fa-star"></i>
${""?left_pad(indent)}  <span class="ms-auto">{{${js.nameVariable(child.id)}}}</span>
${""?left_pad(indent)}</div>
    <#elseif (child.options["level"]!"") == "senary">
${""?left_pad(indent)}<div class="d-flex">
${""?left_pad(indent)}  <i class="fas fa-star"></i>
${""?left_pad(indent)}  <span class="ms-auto">{{${js.nameVariable(child.id)}}}</span>
${""?left_pad(indent)}</div>
    <#elseif (child.options["level"]!"") == "septenary">
${""?left_pad(indent)}<div class="d-flex">
${""?left_pad(indent)}  <i class="fas fa-star"></i>
${""?left_pad(indent)}  <span class="ms-auto">{{${js.nameVariable(child.id)}}}</span>
${""?left_pad(indent)}</div>
    </#if>
  </#list>
</#macro>

<#macro print_html_declare_tile widget indent>
  <#local rows = 1>
  <#list widget.widgets as child>
    <#if (child.options["level"]!"") == "quinary" ||  
         (child.options["level"]!"") == "senary" ||
         (child.options["level"]!"") == "septenary">
      <#local rows = rows + 1>   
    </#if>     
  </#list>
  <#if rows == 1>
${""?left_pad(indent)}<div class="gx-d-flex">
<@print_html_declare_tile_first_row widget=widget indent=indent+2 />
${""?left_pad(indent)}</div>
  <#else>
${""?left_pad(indent)}<div>
${""?left_pad(indent)}  <div class="gx-d-flex">
<@print_html_declare_tile_first_row widget=widget indent=indent+4 />
${""?left_pad(indent)}  </div>
${""?left_pad(indent)}  <div class="gx-d-flex">
<@print_html_declare_tile_second_row widget=widget indent=indent+4 />
${""?left_pad(indent)}  </div>
${""?left_pad(indent)}</div>
  </#if>
</#macro>

<#macro print_html_declare_tile_first_row widget indent>
  <#local hasPrimarySection = false>
  <#list widget.widgets as child>
    <#if (child.options["level"]!"") == "image" || (child.options["level"]!"") == "avatar">
${""?left_pad(indent)}<div style="width: 72px;">
${""?left_pad(indent)}  <image src="${child.options["image"]!""}" class="gx-wh-64">
${""?left_pad(indent)}</div>  
    </#if>
    <#if (child.options["level"]!"") == "primary" || 
         (child.options["level"]!"") == "secondary" ||
         (child.options["level"]!"") == "tertiary">
      <#local hasPrimarySection = true>   
    </#if>     
  </#list>
  <#if hasPrimarySection>   
${""?left_pad(indent)}<div>  
  <#list widget.widgets as child>
    <#if (child.options["level"]!"") == "primary">
${""?left_pad(indent)}  <div class="gx-text-primary">${child.options["title"]!"标题"}</div>
    <#elseif (child.options["level"]!"") == "secondary">
${""?left_pad(indent)}  <div class="gx-text-secondary">${child.options["title"]!"标题"}</div>
    <#elseif (child.options["level"]!"") == "tertiary">
${""?left_pad(indent)}  <div class="gx-text-secondary gx-fs-12">${child.options["title"]!"标题"}</div>
    <#elseif (child.options["level"]!"") == "quaternary">
${""?left_pad(indent)}  <div class="gx-text-secondary gx-fs-12">${child.options["title"]!"标题"}</div>
    </#if>
  </#list>
${""?left_pad(indent)}</div>  
  </#if>
  <#list widget.widgets as child>
    <#if (child.options["level"]!"") == "accent">
${""?left_pad(indent)}<div <#if child.id??>widget-id="${js.nameVariable(child.id)}" </#if>class="gx-ml-auto gx-d-flex" style="align-items:center;">
${""?left_pad(indent)}  <div class="gx-fs-16 gx-fb">${child.options["title"]!"标题"}</div>
${""?left_pad(indent)}</div>  
    </#if>
  </#list>
</#macro>

<#macro print_html_declare_tile_second_row widget indent> 
  <#list widget.widgets as child>
    <#if (child.options["level"]!"") == "quinary">
${""?left_pad(indent)}<div class="d-flex">
${""?left_pad(indent)}  <i class="fas fa-star"></i>
${""?left_pad(indent)}  <span class="ms-auto">${child.options["title"]!"标题"}</span>
${""?left_pad(indent)}</div>
    <#elseif (child.options["level"]!"") == "senary">
${""?left_pad(indent)}<div class="d-flex">
${""?left_pad(indent)}  <i class="fas fa-star"></i>
${""?left_pad(indent)}  <span class="ms-auto">${child.options["title"]!"标题"}</span>
${""?left_pad(indent)}</div>
    <#elseif (child.options["level"]!"") == "septenary">
${""?left_pad(indent)}<div class="d-flex">
${""?left_pad(indent)}  <i class="fas fa-star"></i>
${""?left_pad(indent)}  <span class="ms-auto">${child.options["title"]!"标题"}</span>
${""?left_pad(indent)}</div>
    </#if>
  </#list>
</#macro>

<#--
 ###############################################################################
 ### 【工具栏位】
 ###############################################################################
 -->
<#macro print_js_declare_toolbar widget indent>
  <#list widget.widgets as child>
${""?left_pad(indent)}/*!
${""?left_pad(indent)}** 点击【${child.options["title"]!"标题"}】响应事件。
${""?left_pad(indent)}*/
${""?left_pad(indent)}dom.bind(this.${js.nameVariable(child.id)}, 'click', ev => {
    <#local url = child.options["url"]!"module/object/action">
${""?left_pad(indent)}  this.${js.nameVariable(guidbase.url_to_method_name(url))}({});
${""?left_pad(indent)}});
  </#list>
</#macro>

<#macro print_js_fields_toolbar widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_js_methods_toolbar widget indent>
  <#list widget.widgets as child>
    <#if !child.options["url"]??><#continue></#if>
    <#local url = child.options["url"]>
    <#local method = guidbase.url_to_method_name(url)>
    <#local container = guidbase.url_to_container(url)>
    <#local pagepath = guidbase.url_to_page_path(url)>
    <#local pagename = guidbase.url_to_page_name(url)>
    <#local params = guidbase.get_params_from_url(url)>
      
/*!
** 点击【${child.options["title"]!"标题"}】的处理逻辑。
*/
Page${js.nameType(guidbase.page_id_to_page_name(pagedef.id))}.prototype.${js.nameVariable(method)} = function (model) {
    <#if url?substring(0,1) == "$">   
<@print_method_body_by_url url=url indent=2 />
    </#if>
};
  </#list>
</#macro>

<#macro print_html_declare_toolbar widget indent>
  <#list widget.widgets as child>
${""?left_pad(indent)}<a widget-id="${js.nameVariable(child.id)}" class="btn btn-sm btn-outline-primary mr-2">${child.options["title"]!"未定义"}</a>
  </#list>
</#macro>

<#--
 ###############################################################################
 ### 【编辑表单】
 ###############################################################################
 -->
<#macro print_js_declare_editable_form widget indent>
  <#if widget.options["columns"]?? && widget.options["columns"] == "1">
${""?left_pad(indent)}this.${js.nameVariable(widget.id)} = new SingleColumnForm({
  <#else>
${""?left_pad(indent)}this.${js.nameVariable(widget.id)} = new TwoColumnForm({  
  </#if>
${""?left_pad(indent)}  fields:[{
  <#list widget.widgets![] as child>
    <#if child?index != 0>
${""?left_pad(indent)}  },{
    </#if>   
${""?left_pad(indent)}    name: '${js.nameVariable(child.id)}',     
${""?left_pad(indent)}    title: '${child.options["title"]!""}', 
${""?left_pad(indent)}    input: '${child.type}',
<@print_js_declare_editable_form_field_options widget=child indent=indent+4 />
  </#list>
${""?left_pad(indent)}  }],
${""?left_pad(indent)}});
${""?left_pad(indent)}this.${js.nameVariable(widget.id)}.render(this.widget${js.nameType(widget.id)});
</#macro>

<#macro print_js_fields_editable_form widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_js_methods_editable_form widget indent>
${""?left_pad(indent)}
</#macro>

<#macro print_html_declare_editable_form widget indent>
${""?left_pad(indent)}<div widget-id="widget${js.nameType(widget.id)}"></div>
</#macro>

<#--
 ###############################################################################
 ### 【只读表单】
 ###############################################################################
 -->
<#macro print_js_declare_readonly_form widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_js_fields_readonly_form widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_js_methods_readonly_form widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_html_declare_readonly_form widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#--
 ###############################################################################
 ### 【分页页签】
 ###############################################################################
 -->
<#macro print_js_declare_tabs widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_js_fields_tabs widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_js_methods_tabs widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_html_declare_tabs widget indent>
${""?left_pad(indent)}<div class="gx-d-flex">
  <#if (widget.widgets?size > 0)>
    <#list widget.widgets as child>
    </#list>
  <#else>
  </#if>
${""?left_pad(indent)}
${""?left_pad(indent)}</div>
</#macro>

<#--
 ###############################################################################
 ### 【通知公告】
 ###############################################################################
 -->
<#macro print_js_declare_scroll_notification widget indent>
${""?left_pad(indent)}new Swiper(this.widget${js.nameType(widget.id)}, {
${""?left_pad(indent)}  direction: 'vertical',
${""?left_pad(indent)}  loop: true,
${""?left_pad(indent)}  autoplay: {
${""?left_pad(indent)}    duration: 2000,
${""?left_pad(indent)}  },
${""?left_pad(indent)}});
</#macro>

<#macro print_js_fields_scroll_notification widget indent>

</#macro>

<#macro print_js_methods_scroll_notification widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_html_declare_scroll_notification widget indent>
${""?left_pad(indent)}<div class="gx-d-flex gx-px-16 gx-py-8" 
${""?left_pad(indent)}     style="align-items:center;">
${""?left_pad(indent)}  <div class="gx-i gx-i-broadcast"></div>
${""?left_pad(indent)}  <div widget-id="widget${js.nameType(widget.id)}" class="swiper gx-h-32 gx-lh-32 gx-ml-12">
${""?left_pad(indent)}    <div class="swiper-wrapper">
${""?left_pad(indent)}      <div class="swiper-slide">这是一条重要通知</div>
${""?left_pad(indent)}      <div class="swiper-slide">这是另一条重要通知</div>
${""?left_pad(indent)}    </div>
${""?left_pad(indent)}  </div>
${""?left_pad(indent)}</div>
</#macro>

<#--
 ###############################################################################
 ### 【滚动导航】
 ###############################################################################
 -->
<#macro print_js_declare_swiper_navigator widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_js_fields_swiper_navigator widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_js_methods_swiper_navigator widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_html_declare_swiper_navigator widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#--
 ###############################################################################
 ### 【滑动导航】
 ###############################################################################
 -->
<#macro print_js_declare_scroll_navigator widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_js_fields_scroll_navigator widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_js_methods_scroll_navigator widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_html_declare_scroll_navigator widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#--
 ###############################################################################
 ### 【列表导航】
 ###############################################################################
 -->
<#macro print_js_declare_list_navigator widget indent>
  <#list widget.widgets as child>
    <#local url = guidbase.get_url_from_tile(child)>
    <#if url == ""><#continue></#if>
    <#local method = guidbase.url_to_method_name(url)>
    <#local clickable = guidbase.get_clickable_from_tile(child)>
${""?left_pad(indent)}    
${""?left_pad(indent)}/*!
${""?left_pad(indent)}** 点击【${child.options["title"]!"标题"}】响应事件。
${""?left_pad(indent)}*/
${""?left_pad(indent)}dom.bind(this.${js.nameVariable(clickable.id)}, 'click', ev => {
${""?left_pad(indent)}  let model = dom.model(this.${js.nameVariable(clickable.id)});
${""?left_pad(indent)}  this.${js.nameVariable(method)}(model);
${""?left_pad(indent)}});
  </#list>
</#macro>

<#macro print_js_fields_list_navigator widget indent>
</#macro>

<#macro print_js_methods_list_navigator widget indent>
  <#list widget.widgets as child>
    <#local url = guidbase.get_url_from_tile(child)>
    <#if url == ""><#continue></#if>
    <#if url?starts_with("^")><#continue></#if>
    <#local method = guidbase.url_to_method_name(url)>
    <#local container = guidbase.url_to_container(url)>
    <#local pagepath = guidbase.url_to_page_path(url)>
    <#local pagename = guidbase.url_to_page_name(url)>
    <#local params = guidbase.get_params_from_url(url)>
${""?left_pad(indent)}    
${""?left_pad(indent)}/*!
${""?left_pad(indent)}** 调用【${child.options["title"]!"标题"}】页面。
${""?left_pad(indent)}*/
${""?left_pad(indent)}Page${js.nameType(guidbase.page_id_to_page_name(widget.page.id))}.prototype.${js.nameVariable(method)} = function (model) {
<@print_method_body_by_url url=url indent=indent+2 />
${""?left_pad(indent)}};
  </#list>
</#macro>

<#macro print_html_declare_list_navigator widget indent>
${""?left_pad(indent)}<div class="gx-p-8<#if widget.options["width"]??> gx-24-${guidbase.remake_column_width(widget.options["width"])}</#if>">
${""?left_pad(indent)}  <div class="card">
  <#if widget.options["title"]?? || guidbase.has_toolbar_of_widget(widget)>
${""?left_pad(indent)}    <div class="card-header gx-d-flex">
${""?left_pad(indent)}      <strong>${widget.options["title"]!""}</strong>
    <#if guidbase.has_toolbar_of_widget(widget)>
      <#assign toolbar = guidbase.get_toolbar_of_widget(widget)>
${""?left_pad(indent)}      <div class="gx-d-flex gx-ml-auto">     
      <#list toolbar.widgets as child> 
${""?left_pad(indent)}        <a widget-id="${js.nameVariable(child.id)}" class="btn-sm btn-link">${child.options["title"]!"未定义"}</a>
      </#list>
${""?left_pad(indent)}      </div>
    </#if>
${""?left_pad(indent)}    </div>
  </#if>
${""?left_pad(indent)}    <div widget-id="widget${js.nameType(widget.id)}" class="card-body">
  <#-- 如果没有定义url属性，则说明是静态渲染的，这是一个规则 -->
${""?left_pad(indent)}      <ul class="list-group">
  <#list widget.widgets as child>
    <#if child.type != "tile"><#continue></#if>
${""?left_pad(indent)}        <li class="list-group-item">
<@print_html_declare_tile widget=child indent=indent+8 />
${""?left_pad(indent)}        </li>    
  </#list>
${""?left_pad(indent)}      </ul>  
${""?left_pad(indent)}    </div>
${""?left_pad(indent)}  </div>
${""?left_pad(indent)}</div>
</#macro>

<#--
 ###############################################################################
 ### 【栅格导航】
 ###############################################################################
 -->
<#macro print_js_declare_grid_navigator widget indent>
  <#list widget.widgets as child>
    <#local url = guidbase.get_url_from_tile(child)>
    <#if url == ""><#continue></#if>
    <#local method = guidbase.url_to_method_name(url)>
    <#local clickable = guidbase.get_clickable_from_tile(child)>
${""?left_pad(indent)}    
${""?left_pad(indent)}/*!
${""?left_pad(indent)}** 点击【${child.options["title"]!"标题"}】响应事件。
${""?left_pad(indent)}*/
${""?left_pad(indent)}dom.bind(this.${js.nameVariable(clickable.id)}, 'click', ev => {
${""?left_pad(indent)}  let model = dom.model(this.${js.nameVariable(clickable.id)});
${""?left_pad(indent)}  this.${js.nameVariable(method)}(model);
${""?left_pad(indent)}});
  </#list>
</#macro>

<#macro print_js_fields_grid_navigator widget indent>
</#macro>

<#macro print_js_methods_grid_navigator widget indent>
  <#list widget.widgets as child>
    <#local url = guidbase.get_url_from_tile(child)>
    <#if url == ""><#continue></#if>
    <#if url?starts_with("^")><#continue></#if>
    <#local method = guidbase.url_to_method_name(url)>
    <#local container = guidbase.url_to_container(url)>
    <#local pagepath = guidbase.url_to_page_path(url)>
    <#local pagename = guidbase.url_to_page_name(url)>
    <#local params = guidbase.get_params_from_url(url)>
${""?left_pad(indent)}    
${""?left_pad(indent)}/*!
${""?left_pad(indent)}** 调用【${child.options["title"]!"标题"}】页面。
${""?left_pad(indent)}*/
${""?left_pad(indent)}Page${js.nameType(guidbase.page_id_to_page_name(widget.page.id))}.prototype.${js.nameVariable(method)} = function (model) {
<@print_method_body_by_url url=url indent=indent+2 />
${""?left_pad(indent)}};
  </#list>
</#macro>

<#macro print_html_declare_grid_navigator widget indent>
  <#local columns = widget.options["columns"]!"3">
  <#local childWidth = "33.33% - 12px">
  <#if columns == "2">
    <#local childWidth = "50% - 8px">
  <#elseif columns == "4">
    <#local childWidth = "25% - 15px">
  <#elseif columns == "5">
    <#local childWidth = "20% - 18px">
  </#if>
${""?left_pad(indent)}<div class="gx-p-8<#if widget.options["width"]??> gx-24-${guidbase.remake_column_width(widget.options["width"])}</#if>">
${""?left_pad(indent)}  <div class="card">
  <#if widget.options["title"]?? || guidbase.has_toolbar_of_widget(widget)>
${""?left_pad(indent)}    <div class="card-header gx-d-flex">
${""?left_pad(indent)}      <strong>${widget.options["title"]!""}</strong>
    <#if guidbase.has_toolbar_of_widget(widget)>
      <#assign toolbar = guidbase.get_toolbar_of_widget(widget)>
${""?left_pad(indent)}      <div class="gx-d-flex gx-ml-auto">     
      <#list toolbar.widgets as child> 
${""?left_pad(indent)}        <a widget-id="${js.nameVariable(child.id)}" class="btn-sm btn-link">${child.options["title"]!"未定义"}</a>
      </#list>
${""?left_pad(indent)}      </div>
    </#if>
${""?left_pad(indent)}    </div>
  </#if>
${""?left_pad(indent)}    <div widget-id="widget${js.nameType(widget.id)}" class="card-body">
${""?left_pad(indent)}      <div class="gx-d-flex" style="gap: 16px; flex-wrap: wrap;">
  <#list widget.widgets as child>
    <#if child.type != "tile"><#continue></#if>
${""?left_pad(indent)}        <div widget-id="${js.nameVariable(child.id)}" 
${""?left_pad(indent)}             class="gx-b-1 gx-p-8 gx-pointer" 
${""?left_pad(indent)}             style="flex: 0 0 calc(${childWidth}); max-width: calc(${childWidth});">
<@print_html_declare_tile widget=child indent=indent+8 />
${""?left_pad(indent)}        </div>
  </#list>
${""?left_pad(indent)}      </div>  
${""?left_pad(indent)}    </div>
${""?left_pad(indent)}  </div>
${""?left_pad(indent)}</div>
</#macro>

<#--
 ###############################################################################
 ### 【事件日历】
 ###############################################################################
 -->
<#macro print_js_declare_calendar widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_js_fields_calendar widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_js_methods_calendar widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_html_declare_calendar widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#--
 ###############################################################################
 ### 【树型结构】
 ###############################################################################
 -->
<#macro print_js_declare_tree widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_js_fields_tree widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_js_methods_tree widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_html_declare_tree widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#--
 ###############################################################################
 ### 【传统列表】
 ###############################################################################
 -->
<#macro print_js_declare_list_view widget indent>
${""?left_pad(indent)}this.${js.nameVariable(widget.id)} = new ListView({
${""?left_pad(indent)}  doCreate: (idx, row) => {
${""?left_pad(indent)}    let ret = this.buildTile4${js.nameType(widget.id)}(row);
  <#list widget.widgets as child>
    <#if child.type != "tile"><#continue></#if>
    <#if !child.options["url"]??><#continue></#if>
    <#local url = child.options["url"]>
    <#if url?starts_with("^")><#continue></#if>
    <#local method = guidbase.url_to_method_name(url)>
    <#local container = guidbase.url_to_container(url)>
    <#local pagepath = guidbase.url_to_page_path(url)>
    <#local pagename = guidbase.url_to_page_name(url)>
    <#local params = guidbase.get_params_from_url(url)>
${""?left_pad(indent)}    dom.bind(ret, 'click', ev => {
${""?left_pad(indent)}      let model = dom.model(ret);
${""?left_pad(indent)}      this.${js.nameVariable(method)}(model);
${""?left_pad(indent)}    });    
    <#break>
  </#list>
${""?left_pad(indent)}    return ret;
${""?left_pad(indent)}  },
${""?left_pad(indent)}});
${""?left_pad(indent)}this.${js.nameVariable(widget.id)}.render(this.widget${js.nameType(widget.id)});
${""?left_pad(indent)}sdk.fetch${js.nameType(guidbase.pluralize_widget_object(widget))}({
  <#if widget.options["top"]??>
${""?left_pad(indent)}  limit: ${widget.options["top"]},  
  </#if>
${""?left_pad(indent)}}).then(resp => {
${""?left_pad(indent)}  this.${js.nameVariable(widget.id)}.setLocal(resp);
${""?left_pad(indent)}});
</#macro>

<#macro print_js_fields_list_view widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_js_methods_list_view widget indent>

/*!
** 创建【${widget.options["title"]!"标题"}】的瓦片。
*/
Page${js.nameType(guidbase.page_id_to_page_name(widget.page.id))}.prototype.buildTile4${js.nameType(widget.id)} = function (row) {
  <#list widget.widgets as child>
    <#if child.type == "tile">
<@print_js_declare_tile widget=child indent=2 />
      <#break>
    </#if>
  </#list>
};
  <#list widget.widgets as child>
    <#if child.type != "tile"><#continue></#if>
    <#if !child.options["url"]??><#continue></#if>
    <#local url = child.options["url"]>
    <#local method = guidbase.url_to_method_name(url)>
    <#local container = guidbase.url_to_container(url)>
    <#local pagepath = guidbase.url_to_page_path(url)>
    <#local pagename = guidbase.url_to_page_name(url)>
    <#local params = guidbase.get_params_from_url(url)>
      
/*!
** 点击【${widget.options["title"]!"标题"}】列表瓦片的处理逻辑。
*/
Page${js.nameType(guidbase.page_id_to_page_name(pagedef.id))}.prototype.${js.nameVariable(method)} = function (model) {
    <#if url?substring(0,1) == "$">   
<@print_method_body_by_url url=url indent=indent+2 />
    </#if>
};
  </#list>
</#macro>

<#macro print_html_declare_list_view widget indent>
${""?left_pad(indent)}<div class="gx-p-8<#if widget.options["width"]??> gx-24-${guidbase.remake_column_width(widget.options["width"])}</#if>">
${""?left_pad(indent)}  <div class="card">
  <#if widget.options["title"]?? || guidbase.has_toolbar_of_widget(widget)>
${""?left_pad(indent)}    <div class="card-header gx-d-flex">
${""?left_pad(indent)}      <strong>${widget.options["title"]!""}</strong>
    <#if guidbase.has_toolbar_of_widget(widget)>
      <#assign toolbar = guidbase.get_toolbar_of_widget(widget)>
${""?left_pad(indent)}      <div class="gx-d-flex gx-ml-auto">     
      <#list toolbar.widgets as child> 
${""?left_pad(indent)}        <a widget-id="${js.nameVariable(child.id)}" class="btn-sm btn-link">${child.options["title"]!"未定义"}</a>
      </#list>
${""?left_pad(indent)}      </div>
    </#if>
${""?left_pad(indent)}    </div>
  </#if>
${""?left_pad(indent)}    <div widget-id="widget${js.nameType(widget.id)}" class="card-body"></div>
${""?left_pad(indent)}  </div>
${""?left_pad(indent)}</div>
</#macro>

<#--
 ###############################################################################
 ### 【栅格列表】
 ###############################################################################
 -->
<#macro print_js_declare_grid_view widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_js_fields_grid_view widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_js_methods_grid_view widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_html_declare_grid_view widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#--
 ###############################################################################
 ### 【时间线条】
 ###############################################################################
 -->
<#macro print_js_declare_timeline widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_js_fields_timeline widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_js_methods_timeline widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_html_declare_timeline widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#--
 ###############################################################################
 ### 【分页表格】
 ###############################################################################
 -->
<#macro print_js_declare_pagination_table widget indent>
${""?left_pad(indent)}this.${js.nameVariable(widget.id)} = new PaginationTable({
${""?left_pad(indent)}  columns:[{
  <#list widget.widgets![] as child>
    <#if !child.type??><#continue></#if>
    <#if child?index != 0>
${""?left_pad(indent)}  },{
    </#if>    
${""?left_pad(indent)}    title: '${child.options["title"]!""}', 
${""?left_pad(indent)}    style: 'text-align:center;', 
${""?left_pad(indent)}    display: (row, td, colidx, rowidx) => {
<@print_js_declare_pagination_table_column_display widget=child indent=indent+6 />   
${""?left_pad(indent)}    },
  </#list>
${""?left_pad(indent)}  }],
${""?left_pad(indent)}});
${""?left_pad(indent)}this.${js.nameVariable(widget.id)}.render(this.widget${js.nameType(widget.id)});
</#macro>

<#macro print_js_fields_pagination_table widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_js_methods_pagination_table widget indent>
  <#list widget.widgets as child>
    <#if !child.type??><#continue></#if>
    <#if child.type == "button">
      <#if !child.options??><#continue></#if>
      <#if !child.options["url"]??><#continue></#if>
      <#local url = child.options["url"]>
      <#local params = guidbase.get_params_from_url(url)>
      
/*!
** ${child.options["note"]!"TODO：添加你的注释"}
*/
Page${js.nameType(guidbase.page_id_to_page_name(pagedef.id))}.prototype.${js.nameVariable(guidbase.url_to_method_name(url))} = function (model) {
      <#if url?substring(0,1) == "#">
  ajax.overlay({
    url: 'html/${guidbase.get_uri_from_url(url)}.html',
    title: model.${js.nameVariable(guidbase.get_object_from_url(url))}Name + '详情',
    success: () => {
      ${js.nameVariable(guidbase.url_to_page_name(url))}.show({
      <#list params as param>
        <#if param?index != 0>
      },{    
        </#if>
        ${param.name}: model.${param.name},
      </#list>
      });
    },
  });    
      <#elseif url?substring(0,1) == "%">
  ajax.sidebar({
    url: 'html/${guidbase.get_uri_from_url(url)}.html',
    title: (model.${js.nameVariable(guidbase.get_object_from_url(url))}Name || '新增') + '信息',
    actions: [{
      title: '保存',
      classes: 'btn btn-sm btn-primary',
      onClick: ev => {
        
      },
    },{
      title: '关闭',
      classes: 'btn btn-sm btn-success',
      onClick: ev => { dom.close('sidebar'); },
    }],
    success: () => {
      ${js.nameVariable(guidbase.url_to_page_name(url))}.show({
      <#list params as param>
        <#if param?index != 0>
      },{    
        </#if>
        ${param.name}: model.${param.name},
      </#list>
      });
    },
  });     
      <#elseif url?substring(0,1) == "^">
  ajax.dialog({
    url: 'html/${guidbase.get_uri_from_url(url)}.html',
    success: () => {
      ${js.nameVariable(guidbase.url_to_page_name(url))}.show({
      <#list params as param>
        <#if param?index != 0>
      },{    
        </#if>
        ${param.name}: model.${param.name},
      </#list>
      });
    },
  });     
      <#else>
  xhr.post({
    url: '${guidbase.get_uri_from_url(url)}',
    params: {
      <#list params as param>
        <#if param?index != 0>
    },{    
        </#if>
      ${param.name}: model.${param.name},
      </#list>
    },
  }).then(data => {
  
  });    
      </#if>
};
    <#else>
<@print_js_methods_pagination_table widget=child indent=indent />
    </#if>
  </#list>
</#macro>

<#macro print_html_declare_pagination_table widget indent>
${""?left_pad(indent)}<div widget-id="widget${js.nameType(widget.id)}"></div>
</#macro>

<#--
 ###############################################################################
 ### 【分页栅格】
 ###############################################################################
 -->
<#macro print_js_declare_pagination_grid widget indent>
${""?left_pad(indent)}this.${js.nameVariable(widget.id)} = new PaginationGrid({
${""?left_pad(indent)}  colspan: 6,
${""?left_pad(indent)}  onRender: (container, row, index) => {
${""?left_pad(indent)}    let tile = this.buildTile4${js.nameType(widget.page.id)}(model);
${""?left_pad(indent)}    container.appendChild(tile);
${""?left_pad(indent)}  },
${""?left_pad(indent)}});
${""?left_pad(indent)}this.${js.nameVariable(widget.id)}.render(this.widget${js.nameType(widget.id)});
</#macro>

<#macro print_js_fields_pagination_grid widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_js_methods_pagination_grid widget indent>
${""?left_pad(indent)}/*!
${""?left_pad(indent)}** Builds view for tile item.
${""?left_pad(indent)}*/
${""?left_pad(indent)}Page${js.nameType(guidbase.page_id_to_page_name(pagedef.id))}.prototype.buildTile4${js.nameType(widget.page.id)} = function (model) {
<@print_js_declare_tile widget=child indent=indent+2 />
${""?left_pad(indent)}};
</#macro>

<#macro print_html_declare_pagination_grid widget indent>
${""?left_pad(indent)}<div widget-id="widget${js.nameType(widget.id)}"></div>
</#macro>

<#--
 ###############################################################################
 ### 【广义表格】
 ###############################################################################
 -->
<#macro print_js_declare_spreadsheet widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_js_fields_spreadsheet widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_js_methods_spreadsheet widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_html_declare_spreadsheet widget indent>
${""?left_pad(indent)}<div widget-id="widget${js.nameType(widget.id)}"></div>
</#macro>

<#--
 ###############################################################################
 ### 【看板列表】
 ###############################################################################
 -->
<#macro print_js_declare_kanban widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_js_fields_kanban widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_js_methods_kanban widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_html_declare_kanban widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#--
 ###############################################################################
 ### 【聊天列表】
 ###############################################################################
 -->
<#macro print_js_declare_chat widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_js_fields_chat widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_js_methods_chat widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_html_declare_chat widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#--
 ###############################################################################
 ### 【饼状图】
 ###############################################################################
 -->
<#macro print_js_declare_pie_chart widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_js_fields_pie_chart widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_js_methods_pie_chart widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_html_declare_pie_chart widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#--
 ###############################################################################
 ### 【圈状图】
 ###############################################################################
 -->
<#macro print_js_declare_donut_chart widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_js_fields_donut_chart widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_js_methods_donut_chart widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_html_declare_donut_chart widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#--
 ###############################################################################
 ### 【柱状图】
 ###############################################################################
 -->
<#macro print_js_declare_bar_chart widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_js_fields_bar_chart widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_js_methods_bar_chart widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_html_declare_bar_chart widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#--
 ###############################################################################
 ### 【折线图】
 ###############################################################################
 -->
<#macro print_js_declare_line_chart widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_js_fields_line_chart widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_js_methods_line_chart widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_html_declare_line_chart widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#--
 ###############################################################################
 ### 【堆栈图】
 ###############################################################################
 -->
<#macro print_js_declare_stack_chart widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_js_fields_stack_chart widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_js_methods_stack_chart widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_html_declare_stack_chart widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#--
 ###############################################################################
 ### 【雷达图】
 ###############################################################################
 -->
<#macro print_js_declare_radar_chart widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_js_fields_radar_chart widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_js_methods_radar_chart widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_html_declare_radar_chart widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#--
 ###############################################################################
 ### 【网络拓扑图】
 ###############################################################################
 -->
<#macro print_js_declare_network_topology_diagram widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_js_fields_network_topology_diagram widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_js_methods_network_topology_diagram widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_html_declare_network_topology_diagram widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#--
 ###############################################################################
 ### 【业务流程图】
 ###############################################################################
 -->
<#macro print_js_declare_business_process_diagram widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_js_fields_business_process_diagram widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_js_methods_business_process_diagram widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_html_declare_business_process_diagram widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#--
 ###############################################################################
 ### 【底部弹框】
 ###############################################################################
 -->
<#macro print_js_declare_bottom_sheet widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_js_fields_bottom_sheet widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_js_methods_bottom_sheet widget indent>
${""?left_pad(indent)}    
${""?left_pad(indent)}/*!
${""?left_pad(indent)}** 打开【${widget.options["title"]!"标题"}】底部弹窗。
${""?left_pad(indent)}*/
${""?left_pad(indent)}Page${js.nameType(guidbase.page_id_to_page_name(widget.page.id))}.prototype.open${js.nameType(widget.id)} = function (model) {
${""?left_pad(indent)}  let content = dom.element(`
<@print_html_declare_bottom_sheet widget=widget indent=4 />
${""?left_pad(indent)}  `);
  <#list widget.widgets as child>
    <#if !child.id??><#continue></#if>
${""?left_pad(indent)}  this.widget${js.nameType(child.id)} = dom.find('[widget-id=widget${js.nameType(child.id)}]', content);  
  </#list>
  <#list widget.widgets as child>
    <#if !child.id??><#continue></#if>
<@print_js_declare_widget widget=child indent=indent+2 />
  </#list>
${""?left_pad(indent)}  gux.popup({
${""?left_pad(indent)}    content: content,
${""?left_pad(indent)}    height: ${widget.options["height"]!"200"},
${""?left_pad(indent)}  });
${""?left_pad(indent)}};
</#macro>

<#macro print_html_declare_bottom_sheet widget indent>
${""?left_pad(indent)}<div class="gx-w-full gx-h-full">
  <#list widget.widgets as child>
<@print_html_declare_widget widget=child indent=indent+2 />
  </#list>
${""?left_pad(indent)}</div>
</#macro>

