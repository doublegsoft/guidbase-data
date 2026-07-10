<#import "/$/guidbase.ftl" as guidbase>
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
  <#list form.inputs as input>
    <#if input.type == "date" || input.type == "time" || input.type == "datetime">
${""?left_pad(indent)}var ${java.nameVariable(input.id)} by remember { mutableStateOf(data?.${java.nameVariable(input.id)}?.let { Dates.format(it) } ?: "") }
    <#elseif input.type == "number">
${""?left_pad(indent)}var ${java.nameVariable(input.id)} by remember { mutableStateOf(data?.${java.nameVariable(input.id)}?.toString() ?: "") }
    <#elseif input.type == "select">
${""?left_pad(indent)}var ${java.nameVariable(input.id)} by remember { mutableStateOf((data?.${java.nameVariable(input.id)} as? Option)?.label ?: data?.${java.nameVariable(input.id)}?.toString() ?: "") }
    <#elseif input.type == "cascade" || input.type == "multiselect">
${""?left_pad(indent)}var ${java.nameVariable(input.id)} by remember { mutableStateOf(data?.${java.nameVariable(input.id)} ?: emptyList()) }
    <#elseif input.type == "tags">
${""?left_pad(indent)}var ${java.nameVariable(input.id)} by remember { mutableStateOf(data?.${java.nameVariable(input.id)} ?: emptyList()) }
    <#elseif input.type == "images" || input.type == "videos" || input.type == "files">
${""?left_pad(indent)}var ${java.nameVariable(input.id)} by remember { mutableStateOf(data?.${java.nameVariable(input.id)} ?: emptyList()) }
    <#else>
${""?left_pad(indent)}var ${java.nameVariable(input.id)} by remember { mutableStateOf(data?.${java.nameVariable(input.id)} ?: "") }
    </#if>
  </#list>
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
${""?left_pad(indent)}val ${java.nameVariable(list.id)}State = rememberLazyListState()
${""?left_pad(indent)}val shouldLoadMore by remember {
${""?left_pad(indent)}  derivedStateOf {
${""?left_pad(indent)}    val lastIndex = ${java.nameVariable(list.id)}State.layoutInfo.visibleItemsInfo.lastOrNull()?.index ?: 0
${""?left_pad(indent)}    val total = ${java.nameVariable(list.id)}State.layoutInfo.totalItemsCount
${""?left_pad(indent)}    hasMore && !isLoadingMore && total > 0 && lastIndex >= total - 3
${""?left_pad(indent)}  }
${""?left_pad(indent)}}
${""?left_pad(indent)}LaunchedEffect(shouldLoadMore) {
${""?left_pad(indent)}  if (shouldLoadMore) onLoadMore()
${""?left_pad(indent)}}
</#macro>

<#macro print_list_view_methods list indent=0>
  <#local url = valuebase.url(list.value("data"))>
${""?left_pad(indent)}/**
${""?left_pad(indent)} * 加载更多方法 —— 委托给 PagingBehavior。
${""?left_pad(indent)} */
${""?left_pad(indent)}fun load${java.nameType(conlisttainer.id)}More() {
${""?left_pad(indent)}  val current = _viewState.${java.nameVariable(list.id)}State.value
${""?left_pad(indent)}  if (current !is ${java.nameType(page.name)}ViewState.${java.nameVariable(list.id)}State.Success || 
${""?left_pad(indent)}      current.${java.nameVariable(list.id)}State.isLoadingMore || 
${""?left_pad(indent)}      !current.${java.nameVariable(list.id)}State.hasMore) 
${""?left_pad(indent)}    return
${""?left_pad(indent)}
${""?left_pad(indent)}  viewModelScope.launch {
${""?left_pad(indent)}    _viewState.${java.nameVariable(list.id)}State.value = current.${java.nameVariable(list.id)}State.copy(isLoadingMore = true)
${""?left_pad(indent)}    try {
${""?left_pad(indent)}      ${java.nameVariable(list.id)}Paging.loadMore()
${""?left_pad(indent)}      _viewState.${java.nameVariable(list.id)}State.value = ${java.nameType(page.name)}ViewState.${java.nameVariable(list.id)}State.Success(${java.nameVariable(list.id)}Rows = paging.snapshot)
${""?left_pad(indent)}    } catch (e: Exception) {
${""?left_pad(indent)}      // 加载更多失败时保持现有数据，仅重置 loading 状态
${""?left_pad(indent)}      _viewState.${java.nameVariable(list.id)}State.value = current.copy(isLoadingMore = false)
${""?left_pad(indent)}    }
${""?left_pad(indent)}  }
${""?left_pad(indent)}}
</#macro>

<#macro print_layout_list_view_methods list indent=0>
  <#local url = valuebase.url(list.value("data"))>
${""?left_pad(indent)}/**
${""?left_pad(indent)} * 【${list.title}】布局
${""?left_pad(indent)} */  
${""?left_pad(indent)}@Composable
${""?left_pad(indent)}private fun ${java.nameType(list.id)}Body(
${""?left_pad(indent)}  paging: PagingBehavior<${java.nameType(url.resource)}, ${java.nameType(url.resource)}Query>,
${""?left_pad(indent)}) {
${""?left_pad(indent)}  // 用 Compose State 镜像 paging 的普通字段，使 Compose 能感知变化
${""?left_pad(indent)}  val snapshot by paging.snapshotFlow.collectAsState()
${""?left_pad(indent)}
${""?left_pad(indent)}  if (paging.snapshot.rows.isNullOrEmpty()) {
${""?left_pad(indent)}    Empty()
${""?left_pad(indent)}    return
${""?left_pad(indent)}  }
${""?left_pad(indent)}  val ${java.nameVariable(list.id)}State = rememberLazyListState()
${""?left_pad(indent)}  // snapshotFlow 追踪本地 State 变化，collect 顺序执行不取消，天然解耦检测与执行
${""?left_pad(indent)}  LaunchedEffect(Unit) {
${""?left_pad(indent)}    snapshotFlow {
${""?left_pad(indent)}      val lastIndex = demoListState.layoutInfo.visibleItemsInfo.lastOrNull()?.index ?: 0
${""?left_pad(indent)}      val total = demoListState.layoutInfo.totalItemsCount
${""?left_pad(indent)}      snapshot.hasMore && !snapshot.isLoading && total > 0 && lastIndex >= total - 3
${""?left_pad(indent)}    }.collect { shouldLoad ->
${""?left_pad(indent)}      if (shouldLoad) {
${""?left_pad(indent)}        paging.loadMore()
${""?left_pad(indent)}      }
${""?left_pad(indent)}    }
${""?left_pad(indent)}  }
${""?left_pad(indent)}  LazyColumn(
${""?left_pad(indent)}    state = ${java.nameVariable(list.id)}State,
${""?left_pad(indent)}    modifier = Modifier
${""?left_pad(indent)}      .fillMaxSize()
${""?left_pad(indent)}      .padding(top = Spacings.s5)
${""?left_pad(indent)}  ) {
<@print_layout_list_view list=list indent=4 />
${""?left_pad(indent)}  }
${""?left_pad(indent)}} 
${""?left_pad(indent)}
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

<#macro print_layout_page_methods page indent=0>
  <#list page.widgets as widget>
    <#if widget.type == 'list_view'>
<@print_layout_list_view_methods list=widget indent=indent />    
    </#if>
  </#list>
</#macro>

<#macro print_page_layout page indent=0>
  <#list page.children as child>
<@print_layout_widget widget=child indent=indent />          
  </#list>
</#macro>

<#macro print_layout_divider indent=0></#macro>

<#macro print_layout_widget widget indent=0>
  <#if widget.type == "display_form">
<@print_layout_display_form form=widget indent=indent />
  <#elseif widget.type == "entry_form">
<@print_layout_entry_form form=widget indent=indent />
  <#elseif widget.type == "list_view">
<@print_layout_list_view list=widget indent=indent />
  </#if>
</#macro>