<#import "/$/guidbase.ftl" as guidbase>
<#include "kotlin.ftl">
<#include "tile-kotlin.ftl">
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
<#macro print_layout_entry_form form indent=0>
  <#list form.groups() as group>
    <#local rows = form.rows(group, 1)>
      <#if group?index != 0>
${""?left_pad(indent)}Spacer(Modifier.height(Spacings.s5))
      </#if>
${""?left_pad(indent)}Card(
${""?left_pad(indent)}  title = "${group}",
${""?left_pad(indent)}  accent = Colors.Accent,
${""?left_pad(indent)}  modifier = Modifier.padding(horizontal = Spacings.s5)
${""?left_pad(indent)}) {
    <#list rows as row>
      <#list row as input>
        <#local required = input.value("required") == "true">
        <#if input.type == "date">
${""?left_pad(indent)}  DateInput(label = "${input.title}", value = ${java.nameVariable(input.id)}, onValueChange = { ${java.nameVariable(input.id)} = it }<#if required>, required = true</#if>)
        <#elseif input.type == "time">
${""?left_pad(indent)}  TimeInput(label = "${input.title}", value = ${java.nameVariable(input.id)}, onValueChange = { ${java.nameVariable(input.id)} = it }<#if required>, required = true</#if>)
        <#elseif input.type == "number">
${""?left_pad(indent)}  NumberInput(label = "${input.title}", value = ${java.nameVariable(input.id)}, onValueChange = { ${java.nameVariable(input.id)} = it }<#if required>, required = true</#if>)
        <#elseif input.type == "select">
          <#if input.value("data")?starts_with("enum[")>
${""?left_pad(indent)}  SelectInput(label = "${input.title}", value = ${java.nameVariable(input.id)}, options = get${java.nameType(input.id)}Options().map { it.label }, onValueChange = { ${java.nameVariable(input.id)} = it }<#if required>, required = true</#if>)
          <#else>
${""?left_pad(indent)}  SelectInput(label = "${input.title}", value = ${java.nameVariable(input.id)}, options = emptyList(), onValueChange = { ${java.nameVariable(input.id)} = it }<#if required>, required = true</#if>)
          </#if>
        <#elseif input.type == "longtext">
${""?left_pad(indent)}  LongTextInput(label = "${input.title}", value = ${java.nameVariable(input.id)}, onValueChange = { ${java.nameVariable(input.id)} = it }<#if required>, required = true</#if>)
        <#elseif input.type == "cascade">
${""?left_pad(indent)}  CascadeSelect(label = "${input.title}", selectedPath = ${java.nameVariable(input.id)}, topOptions = emptyList(), childrenProvider = { emptyList() }, onPathChange = { ${java.nameVariable(input.id)} = it })
        <#elseif input.type == "multiselect">
${""?left_pad(indent)}  MultiSelect(label = "${input.title}", selected = ${java.nameVariable(input.id)}, options = emptyList(), onSelectionChange = { ${java.nameVariable(input.id)} = it })
        <#elseif input.type == "tags">
${""?left_pad(indent)}  TagsInput(label = "${input.title}", tags = ${java.nameVariable(input.id)}, onTagsChange = { ${java.nameVariable(input.id)} = it })
        <#elseif input.type == "avatar">
${""?left_pad(indent)}  AvatarInput(label = "${input.title}", uri = ${java.nameVariable(input.id)}, onUriChange = { ${java.nameVariable(input.id)} = it })        
        <#elseif input.type == "images">
${""?left_pad(indent)}  ImagesInput(label = "${input.title}", options = ${java.nameVariable(input.id)}, onOptionsChange = { ${java.nameVariable(input.id)} = it })
        <#elseif input.type == "videos">
${""?left_pad(indent)}  VideosInput(label = "${input.title}", options = ${java.nameVariable(input.id)}, onOptionsChange = { ${java.nameVariable(input.id)} = it })
        <#elseif input.type == "files">
${""?left_pad(indent)}  FilesInput(label = "${input.title}", options = ${java.nameVariable(input.id)}, onOptionsChange = { ${java.nameVariable(input.id)} = it })
        <#else>
${""?left_pad(indent)}  TextInput(label = "${input.title}", value = ${java.nameVariable(input.id)}, onValueChange = { ${java.nameVariable(input.id)} = it }<#if required>, required = true</#if>)
        </#if>
${""?left_pad(indent)}  Spacer(Modifier.height(Spacings.s5))
      </#list>
    </#list>
${""?left_pad(indent)}}
  </#list>
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
${""?left_pad(indent)}Spacer(Modifier.height(Spacings.s5))
      </#if>
${""?left_pad(indent)}Card(
${""?left_pad(indent)}  title = "${group}",
${""?left_pad(indent)}  accent = Colors.Accent,
${""?left_pad(indent)}  modifier = Modifier.padding(horizontal = Spacings.s5)
${""?left_pad(indent)}) {    
    <#list rows as row>
      <#list row as input>
        <#if input.type == "date">
${""?left_pad(indent)}  DateDisplay(label = "${input.title}", value = data.${java.nameVariable(input.id)}?.let { Dates.format(it) })
        <#elseif input.type == "time">
${""?left_pad(indent)}  TimeDisplay(label = "${input.title}", value = data.${java.nameVariable(input.id)}?.let { Dates.format(it) }) 
        <#elseif input.type == "number">
${""?left_pad(indent)}  NumberDisplay(label = "${input.title}", value = data.${java.nameVariable(input.id)}?.toString()) 
        <#elseif input.type == "select">
${""?left_pad(indent)}  SelectDisplay(label = "${input.title}", value = (data.${java.nameVariable(input.id)} as? Option)?.label ?: data.${java.nameVariable(input.id)}?.toString(), color = Colors.Accent)
        <#elseif input.type == "longtext">
${""?left_pad(indent)}  LongTextDisplay(label = "${input.title}", value = data.${java.nameVariable(input.id)})
        <#elseif input.type == "cascade" || input.type == "multiselect">
${""?left_pad(indent)}  OptionsDisplay(label = "${input.title}", options = (data.${java.nameVariable(input.id)} as? List<*>)?.map { (it as? Option)?.label ?: it.toString() } ?: emptyList())
        <#elseif input.type == "tags">
${""?left_pad(indent)}  TagsDisplay(label = "${input.title}", tags = data.${java.nameVariable(input.id)} ?: emptyList())
        <#else>
${""?left_pad(indent)}  TextDisplay(label = "${input.title}", value = data.${java.nameVariable(input.id)})
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
<#macro print_layout_list_view list indent=0>
${""?left_pad(indent)}items(rows) { item ->
<@print_tile_layout widget=list indent=indent+2 />
${""?left_pad(indent)}  Spacer(Modifier.height(Spacings.s5))
${""?left_pad(indent)}}
${""?left_pad(indent)}item {
${""?left_pad(indent)}  Box(
${""?left_pad(indent)}    modifier = Modifier
${""?left_pad(indent)}      .fillMaxWidth()
${""?left_pad(indent)}      .padding(Spacings.s4),
${""?left_pad(indent)}    contentAlignment = Alignment.Center
${""?left_pad(indent)}  ) {
${""?left_pad(indent)}    when {
${""?left_pad(indent)}      isLoadingMore -> LoadMoreSpinner()
${""?left_pad(indent)}      !hasMore -> Text(
${""?left_pad(indent)}      text = "没有更多数据了",
${""?left_pad(indent)}      fontSize = Types.TextSm,
${""?left_pad(indent)}      color = Colors.TextMuted
${""?left_pad(indent)}      )
${""?left_pad(indent)}    }
${""?left_pad(indent)}  }
${""?left_pad(indent)}}
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
