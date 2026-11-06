<#import "/$/guidbase.ftl" as guidbase>
<#include "qt6.ftl">
<!----------------------------------------------------------------------------->
<!--                                    ROW                                  -->
<!----------------------------------------------------------------------------->
<#macro print_row_layout row indent=0>
</#macro>

<!----------------------------------------------------------------------------->
<!--                                   TABS                                  -->
<!----------------------------------------------------------------------------->
<#macro print_tabs_layout tabs indent=0>
</#macro>

<!----------------------------------------------------------------------------->
<!--                                ENTRY FORM                               -->
<!----------------------------------------------------------------------------->
<#macro print_entry_form_layout form indent=0>
</#macro>

<!----------------------------------------------------------------------------->
<!--                              OFFICIAL FORM                              -->
<!----------------------------------------------------------------------------->
<#macro print_official_form_layout form indent=0>
</#macro>

<!----------------------------------------------------------------------------->
<!--                               LETTER FORM                               -->
<!----------------------------------------------------------------------------->
<#macro print_letter_form_layout form indent=0>
</#macro>

<!----------------------------------------------------------------------------->
<!--                                EXCEL FORM                               -->
<!----------------------------------------------------------------------------->
<#macro print_excel_form_layout form indent=0>
</#macro>

<!----------------------------------------------------------------------------->
<!--                              CRITERIA FORM                              -->
<!----------------------------------------------------------------------------->
<#macro print_criteria_form_layout form indent=0>
</#macro>

<!----------------------------------------------------------------------------->
<!--                               DISPLAY FORM                              -->
<!----------------------------------------------------------------------------->
<#macro print_display_form_layout form indent=0>
</#macro>

<!----------------------------------------------------------------------------->
<!--                               PAGED TABLE                               -->
<!----------------------------------------------------------------------------->
<#macro print_paged_table_layout table indent=0>
</#macro>

<!----------------------------------------------------------------------------->
<!--                                DATA TABLE                               -->
<!----------------------------------------------------------------------------->
<#macro print_data_table_layout table indent=0>
</#macro>

<!----------------------------------------------------------------------------->
<!--                               FIXED TABLE                               -->
<!----------------------------------------------------------------------------->
<#macro print_fixed_table_layout table indent=0>
</#macro>

<!----------------------------------------------------------------------------->
<!--                               PAGED GRID                                -->
<!----------------------------------------------------------------------------->
<#macro print_paged_grid_layout grid indent=0>
</#macro>

<!----------------------------------------------------------------------------->
<!--                                 TIME GRID                               -->
<!----------------------------------------------------------------------------->
<#macro print_time_grid_layout grid indent=0>
</#macro>

<!----------------------------------------------------------------------------->
<!--                                LIST VIEW                                -->
<!----------------------------------------------------------------------------->
<#macro print_list_view_layout list indent=0>
</#macro>

<!----------------------------------------------------------------------------->
<!--                                MAP VIEW                                 -->
<!----------------------------------------------------------------------------->
<#macro print_map_view_layout map indent=0>
</#macro>

<!----------------------------------------------------------------------------->
<!--                                HERO CARD                                -->
<!----------------------------------------------------------------------------->
<#macro print_hero_card_layout hero indent=0>
</#macro>

<!----------------------------------------------------------------------------->
<!--                                  CHART                                  -->
<!----------------------------------------------------------------------------->
<#macro print_chart_layout chart indent=0>
</#macro>

<!----------------------------------------------------------------------------->
<!--                                KPI CHART                                -->
<!----------------------------------------------------------------------------->
<#macro print_kpi_chart_layout kpi indent=0>
</#macro>

<!----------------------------------------------------------------------------->
<!--                                   TILE                                  -->
<!----------------------------------------------------------------------------->
<#macro print_tile_layout widget indent=0>
</#macro>

<!----------------------------------------------------------------------------->
<!--                                 BUTTONS                                 -->
<!----------------------------------------------------------------------------->
<#macro print_buttons_layout buttons indent=0>
</#macro>

<!----------------------------------------------------------------------------->
<!--                                  INPUT                                  -->
<!----------------------------------------------------------------------------->
<#macro print_input_layout input plain=false indent=0>
  <#if input.type == "select">
<@print_input_select_layout input=input plain=plain indent=indent />
  <#elseif input.type == "switch">
<@print_input_switch_layout input=input plain=plain indent=indent />
  <#elseif input.type == "date">
<@print_input_date_layout input=input plain=plain indent=indent />
  <#elseif input.type == "time">
<@print_input_time_layout input=input plain=plain indent=indent />
  <#elseif input.type == "cascade">
<@print_input_cascade_layout input=input plain=plain indent=indent />
  <#elseif input.type == "multiselect">
<@print_input_multiselect_layout input=input plain=plain indent=indent />
  <#elseif input.type == "avatar">
<@print_input_avatar_layout input=input plain=plain indent=indent />
  <#elseif input.type == "tags">
<@print_input_tags_layout input=input plain=plain indent=indent />
  <#elseif input.type == "images">
<@print_input_images_layout input=input plain=plain indent=indent />
  <#elseif input.type == "videos">
<@print_input_videos_layout input=input plain=plain indent=indent />
  <#elseif input.type == "files">
<@print_input_files_layout input=input plain=plain indent=indent />
  <#else>
<@print_unsupported_widget_layout widget=input indent=indent />
  </#if>
</#macro>

<!----------------------------------------------------------------------------->
<!--                              INPUT (SELECT)                             -->
<!----------------------------------------------------------------------------->
<#macro print_input_select_layout input plain=false indent=0>
</#macro>

<!----------------------------------------------------------------------------->
<!--                              INPUT (SWITCH)                             -->
<!----------------------------------------------------------------------------->
<#macro print_input_switch_layout input plain=false indent=0>
</#macro>

<!----------------------------------------------------------------------------->
<!--                               INPUT (DATE)                              -->
<!----------------------------------------------------------------------------->
<#macro print_input_date_layout input plain=false indent=0>
</#macro>

<!----------------------------------------------------------------------------->
<!--                               INPUT (TIME)                              -->
<!----------------------------------------------------------------------------->
<#macro print_input_time_layout input plain=false indent=0>
</#macro>

<!----------------------------------------------------------------------------->
<!--                             INPUT (CASCADE)                             -->
<!----------------------------------------------------------------------------->
<#macro print_input_cascade_layout input plain=false indent=0>
</#macro>

<!----------------------------------------------------------------------------->
<!--                           INPUT (MULTISELECT)                           -->
<!----------------------------------------------------------------------------->
<#macro print_input_multiselect_layout input plain=false indent=0>
</#macro>

<!----------------------------------------------------------------------------->
<!--                              INPUT (AVATAR)                             -->
<!----------------------------------------------------------------------------->
<#macro print_input_avatar_layout input plain=false indent=0>
</#macro>

<!----------------------------------------------------------------------------->
<!--                               INPUT (TAGS)                              -->
<!----------------------------------------------------------------------------->
<#macro print_input_tags_layout input plain=false indent=0>
</#macro>

<!----------------------------------------------------------------------------->
<!--                              INPUT (IMAGES)                             -->
<!----------------------------------------------------------------------------->
<#macro print_input_images_layout input plain=false indent=0>
</#macro>

<!----------------------------------------------------------------------------->
<!--                              INPUT (VIDEOS)                             -->
<!----------------------------------------------------------------------------->
<#macro print_input_videos_layout input plain=false indent=0>
</#macro>

<!----------------------------------------------------------------------------->
<!--                              INPUT (FILES)                              -->
<!----------------------------------------------------------------------------->
<#macro print_input_files_layout input plain=false indent=0>
</#macro>

<!----------------------------------------------------------------------------->
<!--                                   PAGE                                  -->
<!----------------------------------------------------------------------------->
<#macro print_page_layout page indent=0>
</#macro>

<#macro print_container_layout widget indent=0>
</#macro>

<#macro print_divider_layout indent=0>
</#macro>

<#macro print_custom_layout widget indent=0>
</#macro>

<#macro print_unsupported_widget_layout widget indent=0>
</#macro>

<!----------------------------------------------------------------------------->
<!--                                  WIDGET                                 -->
<!----------------------------------------------------------------------------->
<#macro print_widget_layout widget indent=0>
  <#if widget.type == "drawer"><#-- 作废，不要这么定义，虽然可以用 -->
${""?left_pad(indent)}<${namespace}-drawer v-model="${js.nameVariable(widget.id)}Open" title="${widget.title}">
    <#if widget.value("page","") != "">
      <#local pagePath = widget.value("page")>
${""?left_pad(indent)}  <${js.nameFile(pagePath?replace("/", "_"))} />
    <#else>
      <#list widget.children as child>
<@print_widget_layout widget=child indent=indent+2 />    
      </#list>
    </#if>
${""?left_pad(indent)}</${namespace}-drawer>
  <#elseif widget.type == "dialog"><#-- 作废，不要这么定义，虽然可以用 -->
${""?left_pad(indent)}<${namespace}-dialog v-model="${js.nameVariable(widget.id)}Open" title="${widget.title}" size="lg">  
    <#if widget.value("page","") != "">
      <#local pagePath = widget.value("page")>
${""?left_pad(indent)}  <${js.nameFile(pagePath?replace("/", "_"))} />
    <#else>
      <#list widget.children as child>
<@print_widget_layout widget=child indent=indent+2 />    
      </#list>
    </#if>
${""?left_pad(indent)}</${namespace}-dialog>
  <#elseif widget.type == "row">
<@print_row_layout row=widget indent=indent />
  <#elseif widget.type == "tabs">
<@print_tabs_layout tabs=widget indent=indent />
  <#elseif widget.type == "entry_form">
<@print_entry_form_layout form=widget indent=indent />    
  <#elseif widget.type == "official_form">
<@print_official_form_layout form=widget indent=indent />   
  <#elseif widget.type == "letter_form">
<@print_letter_form_layout form=widget indent=indent />   
  <#elseif widget.type == "excel_form">
<@print_excel_form_layout form=widget indent=indent />      
  <#elseif widget.type == "paged_table">
<@print_paged_table_layout table=widget indent=indent />
  <#elseif widget.type == "data_table">
<@print_data_table_layout table=widget indent=indent />
  <#elseif widget.type == "fixed_table">
<@print_fixed_table_layout table=widget indent=indent />
  <#elseif widget.type == "criteria_form">
<@print_criteria_form_layout form=widget indent=indent />
  <#elseif widget.type == "display_form">
<@print_display_form_layout form=widget indent=indent />
  <#elseif widget.type == "paged_grid">
<@print_paged_grid_layout grid=widget indent=indent />
  <#elseif widget.type == "list_view">
<@print_list_view_layout list=widget indent=indent />
  <#elseif widget.type == "map_view">
<@print_map_view_layout map=widget indent=indent />
  <#elseif widget.type == "hero_card">
<@print_hero_card_layout hero=widget indent=indent />
  <#elseif widget.type == "chart">
<@print_chart_layout chart=widget indent=indent />
  <#elseif widget.type == "kpi_chart">
<@print_kpi_chart_layout kpi=widget indent=indent />
  <#elseif widget.type == "buttons">
<@print_buttons_layout buttons=widget indent=indent />
  <#elseif widget.type == "select">
<@print_input_select_layout input=widget indent=indent />
  <#elseif widget.type == "switch">
<@print_input_switch_layout input=widget indent=indent />
  <#elseif widget.type == "date">
<@print_input_date_layout input=widget indent=indent />
  <#elseif widget.type == "time">
<@print_input_time_layout input=widget indent=indent />
  <#elseif widget.type == "cascade">
<@print_input_cascade_layout input=widget indent=indent />
  <#elseif widget.type == "multiselect">
<@print_input_multiselect_layout input=widget indent=indent />
  <#elseif widget.type == "avatar">
<@print_input_avatar_layout input=widget indent=indent />
  <#elseif widget.type == "tags">
<@print_input_tags_layout input=widget indent=indent />
  <#elseif widget.type == "images">
<@print_input_images_layout input=widget indent=indent />
  <#elseif widget.type == "videos">
<@print_input_videos_layout input=widget indent=indent />
  <#elseif widget.type == "files">
<@print_input_files_layout input=widget indent=indent />
  <#else><#-- 各个Design System的个性化风格 -->
<@print_custom_layout widget=widget indent=indent />  
  </#if>
</#macro>