<#import "/$/guidbase.ftl" as guidbase>

<!----------------------------------------------------------------------------->
<!--                                    ROW                                  -->
<!----------------------------------------------------------------------------->
<#macro print_row_variables row indent=0>
</#macro>

<!----------------------------------------------------------------------------->
<!--                                   TABS                                  -->
<!----------------------------------------------------------------------------->
<#macro print_tabs_variables tabs indent=0>
</#macro>

<!----------------------------------------------------------------------------->
<!--                                ENTRY FORM                               -->
<!----------------------------------------------------------------------------->
<#macro print_entry_form_variables form indent=0>
  <#list form.inputs as input>
    <#if input.type == "date">
${""?left_pad(indent)}/*
${""?left_pad(indent)}** ${input.title!""}
${""?left_pad(indent)}*/    
${""?left_pad(indent)}${namespace}::DatePicker input${cpp.nameType(input.id)};
    </#if>
  </#list>
</#macro>

<!----------------------------------------------------------------------------->
<!--                              OFFICIAL FORM                              -->
<!----------------------------------------------------------------------------->
<#macro print_official_form_variables form indent=0>
</#macro>

<!----------------------------------------------------------------------------->
<!--                               LETTER FORM                               -->
<!----------------------------------------------------------------------------->
<#macro print_letter_form_variables form indent=0>
</#macro>

<!----------------------------------------------------------------------------->
<!--                                EXCEL FORM                               -->
<!----------------------------------------------------------------------------->
<#macro print_excel_form_variables form indent=0>
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

<!----------------------------------------------------------------------------->
<!--                               PAGED TABLE                               -->
<!----------------------------------------------------------------------------->
<#macro print_paged_table_variables table indent=0>
</#macro>

<!----------------------------------------------------------------------------->
<!--                                DATA TABLE                               -->
<!----------------------------------------------------------------------------->
<#macro print_data_table_variables table indent=0>
</#macro>

<!----------------------------------------------------------------------------->
<!--                               FIXED TABLE                               -->
<!----------------------------------------------------------------------------->
<#macro print_fixed_table_variables table indent=0>
</#macro>

<!----------------------------------------------------------------------------->
<!--                               PAGED GRID                                -->
<!----------------------------------------------------------------------------->
<#macro print_paged_grid_variables grid indent=0>
</#macro>

<!----------------------------------------------------------------------------->
<!--                                 TIME GRID                               -->
<!----------------------------------------------------------------------------->
<#macro print_time_grid_variables grid indent=0>
</#macro>

<!----------------------------------------------------------------------------->
<!--                                LIST VIEW                                -->
<!----------------------------------------------------------------------------->
<#macro print_list_view_variables list indent=0>
</#macro>

<!----------------------------------------------------------------------------->
<!--                                MAP VIEW                                 -->
<!----------------------------------------------------------------------------->
<#macro print_map_view_variables map indent=0>
</#macro>

<!----------------------------------------------------------------------------->
<!--                                HERO CARD                                -->
<!----------------------------------------------------------------------------->
<#macro print_hero_card_variables hero indent=0>
</#macro>

<!----------------------------------------------------------------------------->
<!--                                  CHART                                  -->
<!----------------------------------------------------------------------------->
<#macro print_chart_variables chart indent=0>
</#macro>

<!----------------------------------------------------------------------------->
<!--                                KPI CHART                                -->
<!----------------------------------------------------------------------------->
<#macro print_kpi_chart_variables kpi indent=0>
</#macro>

<!----------------------------------------------------------------------------->
<!--                                   TILE                                  -->
<!----------------------------------------------------------------------------->
<#macro print_tile_variables widget indent=0>
</#macro>

<!----------------------------------------------------------------------------->
<!--                                 BUTTONS                                 -->
<!----------------------------------------------------------------------------->
<#macro print_buttons_variables buttons indent=0>
</#macro>

<!----------------------------------------------------------------------------->
<!--                                  INPUT                                  -->
<!----------------------------------------------------------------------------->
<#macro print_input_variables input plain=false indent=0>
  <#if input.type == "select">
<@print_input_select_variables input=input plain=plain indent=indent />
  <#elseif input.type == "switch">
<@print_input_switch_variables input=input plain=plain indent=indent />
  <#elseif input.type == "date">
<@print_input_date_variables input=input plain=plain indent=indent />
  <#elseif input.type == "time">
<@print_input_time_variables input=input plain=plain indent=indent />
  <#elseif input.type == "cascade">
<@print_input_cascade_variables input=input plain=plain indent=indent />
  <#elseif input.type == "multiselect">
<@print_input_multiselect_variables input=input plain=plain indent=indent />
  <#elseif input.type == "avatar">
<@print_input_avatar_variables input=input plain=plain indent=indent />
  <#elseif input.type == "tags">
<@print_input_tags_variables input=input plain=plain indent=indent />
  <#elseif input.type == "images">
<@print_input_images_variables input=input plain=plain indent=indent />
  <#elseif input.type == "videos">
<@print_input_videos_variables input=input plain=plain indent=indent />
  <#elseif input.type == "files">
<@print_input_files_variables input=input plain=plain indent=indent />
  <#else>
<@print_unsupported_widget_variables widget=input indent=indent />
  </#if>
</#macro>

<!----------------------------------------------------------------------------->
<!--                              INPUT (SELECT)                             -->
<!----------------------------------------------------------------------------->
<#macro print_input_select_variables input plain=false indent=0>
</#macro>

<!----------------------------------------------------------------------------->
<!--                              INPUT (SWITCH)                             -->
<!----------------------------------------------------------------------------->
<#macro print_input_switch_variables input plain=false indent=0>
</#macro>

<!----------------------------------------------------------------------------->
<!--                               INPUT (DATE)                              -->
<!----------------------------------------------------------------------------->
<#macro print_input_date_variables input plain=false indent=0>
</#macro>

<!----------------------------------------------------------------------------->
<!--                               INPUT (TIME)                              -->
<!----------------------------------------------------------------------------->
<#macro print_input_time_variables input plain=false indent=0>
</#macro>

<!----------------------------------------------------------------------------->
<!--                             INPUT (CASCADE)                             -->
<!----------------------------------------------------------------------------->
<#macro print_input_cascade_variables input plain=false indent=0>
</#macro>

<!----------------------------------------------------------------------------->
<!--                           INPUT (MULTISELECT)                           -->
<!----------------------------------------------------------------------------->
<#macro print_input_multiselect_variables input plain=false indent=0>
</#macro>

<!----------------------------------------------------------------------------->
<!--                              INPUT (AVATAR)                             -->
<!----------------------------------------------------------------------------->
<#macro print_input_avatar_variables input plain=false indent=0>
</#macro>

<!----------------------------------------------------------------------------->
<!--                               INPUT (TAGS)                              -->
<!----------------------------------------------------------------------------->
<#macro print_input_tags_variables input plain=false indent=0>
</#macro>

<!----------------------------------------------------------------------------->
<!--                              INPUT (IMAGES)                             -->
<!----------------------------------------------------------------------------->
<#macro print_input_images_variables input plain=false indent=0>
</#macro>

<!----------------------------------------------------------------------------->
<!--                              INPUT (VIDEOS)                             -->
<!----------------------------------------------------------------------------->
<#macro print_input_videos_variables input plain=false indent=0>
</#macro>

<!----------------------------------------------------------------------------->
<!--                              INPUT (FILES)                              -->
<!----------------------------------------------------------------------------->
<#macro print_input_files_variables input plain=false indent=0>
</#macro>

<!----------------------------------------------------------------------------->
<!--                                   PAGE                                  -->
<!----------------------------------------------------------------------------->
<#macro print_page_variables page indent=0>
  <#list page.widgets as widget>
    <#if widget.type == "tabs">
<@print_tabs_variables tabs=widget indent=indent />
    <#elseif widget.type == "entry_form">
<@print_entry_form_variables form=widget indent=indent />
    <#elseif widget.type == "official_form">
<@print_official_form_variables form=widget indent=indent />
    <#elseif widget.type == "excel_form">
<@print_excel_form_variables form=widget indent=indent />
    <#elseif widget.type == "criteria_form">
<@print_criteria_form_variables form=widget indent=indent />
    <#elseif widget.type == "display_form">
<@print_display_form_variables form=widget indent=indent />
    <#elseif widget.type == "paged_table">
<@print_paged_table_variables table=widget indent=indent />
    <#elseif widget.type == "data_table">
<@print_data_table_variables table=widget indent=indent />
    <#elseif widget.type == "fixed_table">
<@print_fixed_table_variables table=widget indent=indent />
    <#elseif widget.type == "paged_grid">
<@print_paged_grid_variables grid=widget indent=indent />
    <#elseif widget.type == "time_grid">
<@print_time_grid_variables grid=widget indent=indent />
    <#elseif widget.type == "list_view">
<@print_list_view_variables list=widget indent=indent />
    <#elseif widget.type == "map_view">
<@print_map_view_variables map=widget indent=indent />
    <#elseif widget.type == "hero_card">
<@print_hero_card_variables hero=widget indent=indent />
    <#elseif widget.type == "kpi_chart">
<@print_kpi_chart_variables kpi=widget indent=indent />
    <#elseif widget.type == "chart">
<@print_chart_variables chart=widget indent=indent />
    <#elseif widget.type == "button">
<@print_button_variables button=widget indent=indent />
    </#if>
  </#list>
</#macro>

<#macro print_page_layout page indent=0>
  <#local children = []>
  <#list page.children as child>
    <#if child.type != "dialog" && child.type != "drawer" && 
         child.type != "buttons" && child.type != "entry_form" && 
         child.value("viewport") == "" >
<@print_container_layout widget=child indent=indent />       
    <#elseif child.value("viewport") == "">
<@print_widget_layout widget=child indent=indent />        
    </#if>
    <#if child?index != page.children?size - 1>
<@print_divider_layout indent=indent />    
    </#if>
  </#list>
  <#-- 集中处理action定义 -->
  <#list page.widgets as widget>
    <#if widget.value("action") == ""><#continue></#if>
    <#local action = valuebase.action(widget.value("action"))>
    <#if !action.type??><#continue></#if>
  </#list>
</#macro>

<!----------------------------------------------------------------------------->
<!--                                  WIDGET                                 -->
<!----------------------------------------------------------------------------->
