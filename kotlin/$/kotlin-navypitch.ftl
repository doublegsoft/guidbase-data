--- START OF FILE Paste July 02, 2026 - 8:22AM ---

<#import "/$/guidbase.ftl" as guidbase>
<#include "tile-vue3.ftl">
<!----------------------------------------------------------------------------->
<!--                                   TABS                                  -->
<!----------------------------------------------------------------------------->
<#macro print_tabs_variables tabs indent=0>
</#macro>

<#macro print_tabs_methods tabs indent=0>
</#macro>

<!----------------------------------------------------------------------------->
<!--                                ENTRY FORM                               -->
<!----------------------------------------------------------------------------->
<#macro print_entry_form_variables form indent=0>
</#macro>

<#macro print_entry_form_methods form indent=0>
</#macro>

<!----------------------------------------------------------------------------->
<!--                              OFFICIAL FORM                              -->
<!----------------------------------------------------------------------------->
<#macro print_official_form_variables form indent=0>
</#macro>

<!----------------------------------------------------------------------------->
<!--                              CRITERIA FORM                              -->
<!----------------------------------------------------------------------------->
<#macro print_criteria_form_variables form indent=0>
</#macro>

<!----------------------------------------------------------------------------->
<!--                               DISPLAY FORM                              -->
<!----------------------------------------------------------------------------->
<#macro print_display_form_variables form indent=0>
</#macro>

<#macro print_display_form_methods form indent=0>
</#macro>

<#macro print_layout_display_form form indent=0>
  <#list form.groups() as group>
    <#local rows = form.rows(group, 1)>
      <#if group?index != 0>
${""?left_pad(indent)}Spacer(Modifier.height(Spacing.s5))
      </#if>
${""?left_pad(indent)}Card(
${""?left_pad(indent)}  title = "${group}",
${""?left_pad(indent)}  accent = Color.Accent,
${""?left_pad(indent)}  modifier = Modifier.padding(horizontal = Spacing.s5)
${""?left_pad(indent)}) {    
    <#list rows as row>
      <#list row as input>
        <#if input.type == "date">
${""?left_pad(indent)}  DateDisplay(label = "${input.title}", value = data.${java.nameVariable(input.id)}?.let { Dates.format(it) })
        <#elseif input.type == "time">
${""?left_pad(indent)}  TimeDisplay(label = "${input.title}", value = data.${java.nameVariable(input.id)}?.fmtStr()) 
        <#elseif input.type == "number">
${""?left_pad(indent)}  NumberDisplay(label = "${input.title}", value = data.${java.nameVariable(input.id)}?.numStr()) 
        <#elseif input.type == "select">
${""?left_pad(indent)}  SelectDisplay(label = "${input.title}", value = data.${java.nameVariable(input.id)}?.label, color = Color.Accent) 
        <#elseif input.type == "longtext">
${""?left_pad(indent)}  LongTextDisplay(label = "${input.title}", value = data.${java.nameVariable(input.id)}?) 
        <#else>
${""?left_pad(indent)}  TextDisplay(label = "${input.title}", value = data.${java.nameVariable(input.id)}?)        
        </#if>
${""?left_pad(indent)}  FieldDivider()      
      </#list>
    </#list>
${""?left_pad(indent)}}    
  </#list>
</#macro>

<!----------------------------------------------------------------------------->
<!--                                EXCEL FORM                               -->
<!----------------------------------------------------------------------------->
<#macro print_excel_form_variables form indent=0>
</#macro>

<#macro print_excel_form_methods form indent=0>
</#macro>

<#macro print_layout_excel_form form indent=0>
</#macro>

<!----------------------------------------------------------------------------->
<!--                               PAGED TABLE                               -->
<!----------------------------------------------------------------------------->
<#macro print_paged_table_variables table indent=0>
</#macro>

<#macro print_paged_table_methods table indent=0>
</#macro>

<#macro print_layout_paged_table table indent=0>
</#macro>

<!----------------------------------------------------------------------------->
<!--                               FIXED TABLE                               -->
<!----------------------------------------------------------------------------->
<#macro print_fixed_table_variables table indent=0>
</#macro>

<#macro print_fixed_table_methods table indent=0>
</#macro>

<#macro print_layout_fixed_table table indent=0>
</#macro>

<!----------------------------------------------------------------------------->
<!--                               PAGED GRID                                -->
<!----------------------------------------------------------------------------->
<#macro print_paged_grid_variables grid indent=0>
</#macro>

<#macro print_paged_grid_methods grid indent=0>
</#macro>

<#macro print_layout_paged_grid grid indent=0>
</#macro>

<!----------------------------------------------------------------------------->
<!--                                 TIME GRID                               -->
<!----------------------------------------------------------------------------->
<#macro print_time_grid_variables grid indent=0>
</#macro>

<#macro print_time_grid_methods grid indent=0>
</#macro>

<!----------------------------------------------------------------------------->
<!--                               SPLIT LIST                                -->
<!----------------------------------------------------------------------------->
<#macro print_split_list_variables list indent=0>
</#macro>

<#macro print_split_list_methods list indent=0>
</#macro>

<!----------------------------------------------------------------------------->
<!--                                LIST VIEW                                -->
<!----------------------------------------------------------------------------->
<#macro print_list_view_variables list indent=0>
</#macro>

<#macro print_list_view_methods list indent=0>
</#macro>

<!----------------------------------------------------------------------------->
<!--                                  CHART                                  -->
<!----------------------------------------------------------------------------->
<#macro print_chart_variables chart indent=0>
</#macro>

<#macro print_chart_methods chart indent=0>
</#macro>

<#macro print_layout_chart chart indent=0>
</#macro>

<!----------------------------------------------------------------------------->
<!--                                  BUTTON                                 -->
<!----------------------------------------------------------------------------->
<#macro print_button_variables button indent=0>
</#macro>

<#macro print_button_methods button indent=0>
</#macro>

<#macro print_layout_buttons buttons indent=0>
</#macro>

<!----------------------------------------------------------------------------->
<!--                                   PAGE                                  -->
<!----------------------------------------------------------------------------->
<#macro print_page_imports page indent=0>
  <#local visited_types = {}>
</#macro>

<#macro print_page_variables page indent=0>
  <#list page.widgets as widget>
    <#if widget.type == 'tabs'>
<@print_tabs_variables tabs=widget indent=indent />
    <#elseif widget.type == 'entry_form'>
<@print_entry_form_variables form=widget indent=indent />
    <#elseif widget.type == 'official_form'>
<@print_official_form_variables form=widget indent=indent />
    <#elseif widget.type == 'excel_form'>
<@print_excel_form_variables form=widget indent=indent />
    <#elseif widget.type == 'criteria_form'>
<@print_criteria_form_variables form=widget indent=indent />
    <#elseif widget.type == 'display_form'>
<@print_display_form_variables form=widget indent=indent />
    <#elseif widget.type == 'paged_table'>
<@print_paged_table_variables table=widget indent=indent />
    <#elseif widget.type == 'fixed_table'>
<@print_fixed_table_variables table=widget indent=indent />
    <#elseif widget.type == 'paged_grid'>
<@print_paged_grid_variables grid=widget indent=indent />
    <#elseif widget.type == 'time_grid'>
<@print_time_grid_variables grid=widget indent=indent />
    <#elseif widget.type == 'list_view'>
<@print_list_view_variables list=widget indent=indent />
    <#elseif widget.type == "chart">
<@print_chart_variables chart=widget indent=indent />
    <#elseif widget.type == "button">
<@print_button_variables button=widget indent=indent />
    </#if>
  </#list>
  <#list page.widgets as widget>
    <#if widget.value("action") == ""><#continue></#if>
    <#local action = valuebase.action(widget.value("action"))>
    <#if action.type.name() == "DRAWER" || action.type.name() == "DIALOG">
${""?left_pad(indent)}const ${js.nameVariable(action.resource)}Open = ref(false) 
    </#if>
  </#list>
</#macro>

<#macro print_page_methods page indent=0>
  <#list page.widgets as widget>
    <#if widget.type == 'tabs'>
<@print_tabs_methods tabs=widget indent=indent />
    <#elseif widget.type == 'entry_form'>
<@print_entry_form_methods form=widget indent=indent />
    <#elseif widget.type == 'display_form'>
<@print_display_form_methods form=widget indent=indent />
    <#elseif widget.type == 'excel_form'>
<@print_excel_form_methods form=widget indent=indent />
    <#elseif widget.type == 'paged_table'>
<@print_paged_table_methods table=widget indent=indent />
    <#elseif widget.type == 'fixed_table'>
<@print_fixed_table_methods table=widget indent=indent />
    <#elseif widget.type == 'paged_grid'>
<@print_paged_grid_methods grid=widget indent=indent />
    <#elseif widget.type == 'time_grid'>
<@print_time_grid_methods grid=widget indent=indent />
    <#elseif widget.type == 'list_view'>
<@print_list_view_methods list=widget indent=indent />
    <#elseif widget.type == "chart">
<@print_chart_methods chart=widget indent=indent />
    <#elseif widget.type == 'button'>
<@print_button_methods button=widget indent=indent />
    </#if>
  </#list>
  <#list page.widgets as widget>
    <#if widget.type != "paged_table"><#continue></#if>
${""?left_pad(indent)}const ${js.nameVariable(widget.id)}RowActionHandlers = { 
    <#list widget.widgets as button>     
      <#if button.type != "button"><#continue></#if>
${""?left_pad(indent)}  ${guidbase.name_button_method(button)}, 
    </#list>
${""?left_pad(indent)}}
${""?left_pad(indent)}const handle${js.nameType(widget.id)}RowAction = ({ handler, row, index }) => {
${""?left_pad(indent)}  ${js.nameVariable(widget.id)}RowActionHandlers[handler]?.(row, index)
${""?left_pad(indent)}}    
  </#list>
</#macro>

<#macro print_page_layout page indent=0>
  <#local children = []>
  <#list page.children as child>
    <#if child.type != "dialog" && child.type != "drawer" && 
         child.type != "buttons" && child.type != "entry_form" && 
         page.value("viewport") == "" >
<@print_layout_container widget=child indent=indent />       
    <#else>
<@print_layout_widget widget=child indent=indent />        
    </#if>
    <#if child?index != children?size - 1>
<@print_layout_divider indent=indent />    
    </#if>
  </#list>
  <#-- 把带有viewport的显示在最后 -->
  <#list page.children as child>
    <#if child.value("viewport","") != "">
<@print_layout_widget widget=child indent=indent />          
    </#if>
  </#list>
</#macro>

<#macro print_layout_divider indent=0></#macro>

<#macro print_layout_widget widget indent=0>
</#macro>