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
@Composable
private fun ${java.nameType(form.id)}(
  groups: List<EventType>,
  activeGroupId: Int?,
  events: List<ScheduleEvent>,
  isEmpty: Boolean,
  activeEventTypeName: String,
  onGroupTap: (Int) -> Unit,
  onShowAll: () -> Unit,
  onEventTap: (ScheduleEvent) -> Unit,
  modifier: Modifier = Modifier
) {
  Row(modifier = modifier.fillMaxWidth()) {
    GroupListPanel(
      groups = groups, activeGroupId = activeGroupId,
      onGroupTap = onGroupTap, onShowAll = onShowAll,
      modifier = Modifier.width(80.dp).fillMaxHeight()
    )
    EventListPanel(
      events = events, isEmpty = isEmpty,
      activeEventTypeName = activeEventTypeName,
      onEventTap = onEventTap,
      modifier = Modifier.weight(1f).fillMaxHeight()
    )
  }
}
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
  <#list page.widgets as widget>
    <#if widget.type == 'entry_form' || widget.type == 'official_form' || widget.type == "excel_form">
import { useAsyncLock } from '@/composables/useAsyncLock'
import { useFieldValidation } from '@/composables/useFieldValidation'
      <#break>
    </#if>
  </#list>  
  <#list page.widgets as widget>
    <#if visited_types[widget.type]??><#continue></#if>
    <#if widget.type == "excel_form">
import ${js.nameType(namespace)}Excelform from '@/components/${namespace}-excelform.vue'
    <#elseif widget.type == "paged_table">
import ${js.nameType(namespace)}Pagedtable from '@/components/${namespace}-pagedtable.vue'
    <#elseif widget.type == "fixed_table">
import ${js.nameType(namespace)}Fixedtable from '@/components/${namespace}-fixedtable.vue'
    <#elseif widget.type == "paged_grid">
import ${js.nameType(namespace)}Pagedgrid from '@/components/${namespace}-pagedgrid.vue'      
    <#elseif widget.type == "week_grid">
import ${js.nameType(namespace)}Weekgrid from '@/components/${namespace}-weekgrid.vue'
    <#elseif widget.type == "chart">
import ${js.nameType(namespace)}Chart from '@/components/${namespace}-chart.vue'    
import { createChart } from '@/sdk/charts'    
    <#elseif widget.type == "select">
import ${js.nameType(namespace)}Dropdown from '@/components/${namespace}-dropdown.vue'  
    <#elseif widget.type == "date">
import ${js.nameType(namespace)}Datepicker from '@/components/${namespace}-datepicker.vue'  
    <#elseif widget.type == "time">
import ${js.nameType(namespace)}Timepicker from '@/components/${namespace}-timepicker.vue'  
    <#elseif widget.type == "cascade">
import ${js.nameType(namespace)}Cascadepicker from '@/components/${namespace}-cascadepicker.vue'    
    <#elseif widget.type == "multiselect">
import ${js.nameType(namespace)}Multiselect from '@/components/${namespace}-multiselect.vue'   
    <#elseif widget.type == "avatar">
import ${js.nameType(namespace)}Avatarupload from '@/components/${namespace}-avatarupload.vue' 
    <#elseif widget.type == "tags">
import ${js.nameType(namespace)}Tagsinput from '@/components/${namespace}-tagsinput.vue' 
    <#elseif widget.type == "files">
import ${js.nameType(namespace)}Fileupload from '@/components/${namespace}-fileupload.vue' 
    <#elseif widget.type == "images">
import ${js.nameType(namespace)}Imageupload from '@/components/${namespace}-imageupload.vue' 
    <#elseif widget.type == "videos">
import ${js.nameType(namespace)}Videoupload from '@/components/${namespace}-videoupload.vue' 
    </#if>
    <#local visited_types += {widget.type: widget} />
  </#list>
  <#local drawerImported = false>
  <#local dialogImported = false>
  <#-- drawer and dialog -->
  <#list page.widgets as widget>
    <#if widget.value("action") == ""><#continue></#if>
    <#local action = valuebase.action(widget.value("action"))>
    <#if action.type.name() == "DRAWER" && !drawerImported>
      <#local drawerImported = true>
import ${js.nameType(namespace)}Drawer from '@/components/${namespace}-drawer.vue'  
      <#local dialogImported = true>
    <#elseif action.type.name() == "DIALOG" && !dialogImported>   
import ${js.nameType(namespace)}Dialog from '@/components/${namespace}-dialog.vue'       
    </#if>
  </#list>
  <#-- pages -->
  <#list page.widgets as widget>
    <#if widget.value("action") == ""><#continue></#if>
    <#local action = valuebase.action(widget.value("action"))>
    <#if action.type.name() == "DRAWER" || action.type.name() == "DIALOG">
import ${js.nameType(namespace + "_" + action.resource)} from '@/pages/${js.nameFile(action.path)}.vue'      
    </#if>
  </#list>
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