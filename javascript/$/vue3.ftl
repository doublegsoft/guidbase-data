<#import "/$/guidbase.ftl" as guidbase>
<#include "tile-vue3.ftl">
<!----------------------------------------------------------------------------->
<!--                                   TABS                                  -->
<!----------------------------------------------------------------------------->
<#macro print_tabs_variables tabs indent=0>

// 【${tabs.title!tabs.id}】分页标签变量
${""?left_pad(indent)}const tabs${js.nameType(tabs.id)} = [
  <#list tabs.children as tab>
${""?left_pad(indent)}  { key: '${js.nameVariable(tab.id)}',  label: '${tab.title}', badge: '' },
  </#list>
${""?left_pad(indent)}]
${""?left_pad(indent)}const activeTab${js.nameType(tabs.id)} = ref('${js.nameVariable(tabs.children[0].id)}')
</#macro>

<#macro print_tabs_methods tabs indent=0>
</#macro>

<!----------------------------------------------------------------------------->
<!--                                ENTRY FORM                               -->
<!----------------------------------------------------------------------------->
<#macro print_entry_form_variables form indent=0>
${""?left_pad(indent)}/**
${""?left_pad(indent)} * ${js.nameVariable(form.id)} 【${form.title!""}】表单相关变量
${""?left_pad(indent)} */
${""?left_pad(indent)} // 表单校验规则
const ${js.nameVariable(form.id)}Rules = [
  <#list form.inputs as input>  
    <#if input.value("readonly") == "true"><#continue></#if>
  {name: '${js.nameVariable(input.id)}',rules: [<#if input.value("required") == "true">{ type: 'required', message: '${input.title}必须填写！' },</#if><#if input.type == "number">{ type: 'number', message: '请正确输入${input.title}！' }</#if>]},
  </#list>
]
${""?left_pad(indent)}// 独立设置各个表单的校验对象
const { 
  errors: ${js.nameVariable(form.id)}Errors, 
  validate: validate${js.nameType(form.id)}, 
  clearErrors: clear${js.nameType(form.id)}Errors, 
} = useFieldValidation(${js.nameVariable(form.id)}Rules)
${""?left_pad(indent)}// 表单数据载体
${""?left_pad(indent)}const ${js.nameVariable(form.id)}Data = reactive({
  <#list form.inputs as input>
${""?left_pad(indent)}  ${js.nameVariable(input.id)}: ${guidbase4js.get_primitive_default_value(input)},
  </#list>
${""?left_pad(indent)}});
  <#list form.inputs as input>
    <#if (input.type == "select" || input.type == "multiselect") && !(input.value("data")!"")?starts_with("enum[")>
${""?left_pad(indent)}const ${js.nameVariable(input.id)}Options = ref([])    
    <#elseif input.type == "select">
${""?left_pad(indent)}const ${js.nameVariable(input.id)}Options = ref([])
    </#if>
  </#list>
${""?left_pad(indent)}// 表单错误相关
const ${js.nameVariable(form.id)}Error = ref(false)
const ${js.nameVariable(form.id)}ErrorMessage = ref('')
</#macro>

<#macro print_entry_form_methods form indent=0>
  <#local url = valuebase.url(form.value("data"))>
  <#local objname = url.resource>
/**
 * 加载【${form.title!""}】编辑表单数据的界面函数
 */
const load${js.nameType(form.id)}Data = async (params) => {
  isLoading.value = true
  try {
    const data = await sdk.fetch${js.nameType(objname)}(params)
    Object.assign(${js.nameVariable(form.id)}Data, data)
  } catch (error) {
    fb.error('发生错误', error)
  } finally {
    isLoading.value = false
  }
}

/**
 * 保存【${form.title!""}】编辑表单数据
 */
const save${js.nameType(form.id)}Data = async () => {
  if (!validate${js.nameType(form.id)}(${js.nameVariable(form.id)}Data)) {
    const msgs = Object.entries(${js.nameVariable(form.id)}Errors)
      .filter(([, msg]) => msg)
      .map(([, msg]) => `· ${r"${msg}"}`)
    ${js.nameVariable(form.id)}ErrorMessage.value = msgs.join('\n')
    ${js.nameVariable(form.id)}ErrorShow.value = true
    return
  }
  is${js.nameType(form.id)}Submitting.value = true
  try {
    const result = await sdk.save${js.nameType(form.value("object",form.id))}(${js.nameVariable(form.id)}Data)
    if (result.success) {
      fb.success('成功', '保存成功');
    }
  } catch (error) {
    fb.error('发生错误', error)
  } finally {
    is${js.nameType(form.id)}Submitting.value = false
  }
}

// 防止保存【${form.title!""}】编辑表单手抖的变量和函数
const { loading: is${js.nameType(form.id)}Submitting, run: handle${js.nameType(form.id)}Save } = useAsyncLock(save${js.nameType(form.id)}Data)
</#macro>

<!----------------------------------------------------------------------------->
<!--                              OFFICIAL FORM                              -->
<!----------------------------------------------------------------------------->
<#macro print_official_form_variables form indent=0>
${""?left_pad(indent)}// ${js.nameVariable(form.id)}表单校验规则
const ${js.nameVariable(form.id)}Rules = [
  <#list form.inputs as input>  
    <#if input.value("readonly") == "true"><#continue></#if>
  {name: '${js.nameVariable(input.id)}',rules: [<#if input.value("required") == "true">{ type: 'required', message: '${input.title}必须填写！' },</#if><#if input.type == "number">{ type: 'number', message: '请正确输入${input.title}！' }</#if>]},
  </#list>
]
const { ${js.nameVariable(form.id)}Errors, validate${js.nameType(form.id)}, clear${js.nameType(form.id)}Errors } = useFieldValidation(${js.nameVariable(form.id)}Rules)
${""?left_pad(indent)}// ${js.nameVariable(form.id)}表单相关变量
${""?left_pad(indent)}const ${js.nameVariable(form.id)}Data = reactive({
  <#list form.inputs as input>
${""?left_pad(indent)}  ${js.nameVariable(input.id)}: ${guidbase4js.get_primitive_default_value(input)},
  </#list>
${""?left_pad(indent)}});
  <#list form.inputs as input>
    <#if (input.type == "select" || input.type == "multiselect") && !(input.value("data")!"")?starts_with("enum[")>
${""?left_pad(indent)}const ${js.nameVariable(input.id)}Options = ref([])    
    <#elseif input.type == "select">
${""?left_pad(indent)}const ${js.nameVariable(input.id)}Options = ref([])
    </#if>
  </#list>
const ${js.nameVariable(form.id)}ErrorShow = ref(false)
const ${js.nameVariable(form.id)}ErrorMessage = ref('')
</#macro>

<!----------------------------------------------------------------------------->
<!--                              CRITERIA FORM                              -->
<!----------------------------------------------------------------------------->
<#macro print_criteria_form_variables form indent=0>

${""?left_pad(indent)}// 【${form.title!form.id}】查询表单相关变量
${""?left_pad(indent)}const ${js.nameVariable(form.id)}Crit = reactive({
  <#list form.inputs as input>
${""?left_pad(indent)}  ${js.nameVariable(input.id)}: ${guidbase4js.get_primitive_default_value(input)},
  </#list>
${""?left_pad(indent)}});
  <#list form.inputs as input>
    <#if (input.type == "select" || input.type == "multiselect")>
      <#if !(input.value("data")!"")?starts_with("enum[")>    
${""?left_pad(indent)}const ${js.nameVariable(input.id)}Options = ref([])    
      </#if>
    </#if>
  </#list>
</#macro>

<!----------------------------------------------------------------------------->
<!--                               DISPLAY FORM                              -->
<!----------------------------------------------------------------------------->
<#macro print_display_form_variables form indent=0>

${""?left_pad(indent)}// ${js.nameVariable(form.id)}只读表单相关变量
${""?left_pad(indent)}const ${js.nameVariable(form.id)}Data = reactive({
  <#list form.inputs as input>
${""?left_pad(indent)}  ${js.nameVariable(input.id)}: ${guidbase4js.get_primitive_default_value(input)},
  </#list>
${""?left_pad(indent)}});
</#macro>

<#macro print_display_form_methods form indent=0>
  <#local url = valuebase.url(form.value("data"))>
  <#local objname = url.resource>

/**
 * 加载【${form.title!""}】只读表单数据的界面函数
 */
const load${js.nameType(form.id)}Data = async () => {
  isLoading.value = true
  try {
    const data = await sdk.fetch${js.nameType(objname)}()
    Object.assign(${js.nameVariable(form.id)}Data, data)
  } catch (error) {
    fb.error('发生错误', error)
  } finally {
    isLoading.value = false
  }
}
</#macro>

<!----------------------------------------------------------------------------->
<!--                                EXCEL FORM                               -->
<!----------------------------------------------------------------------------->
<#macro print_excel_form_variables form indent=0>

// ${form.title!form.id}所需变量
${""?left_pad(indent)}const ${js.nameVariable(form.id)}Cols = ref([{
  <#list form.children as column>
    <#if column?index != 0>
${""?left_pad(indent)}},{    
    </#if>
    <#if column.id??>
${""?left_pad(indent)}  key:'${js.nameVariable(column.id)}',
    </#if>
${""?left_pad(indent)}  label:'${column.title}',
${""?left_pad(indent)}  type:'${column.type}',      
${""?left_pad(indent)}  width:${column.value("width","120")},
  </#list>
${""?left_pad(indent)}}])
${""?left_pad(indent)}const ${js.nameVariable(form.id)}Rows = ref([])
</#macro>

<#macro print_excel_form_methods form indent=0>

/**
 * 加载数据的界面函数
 */
const load${js.nameType(form.id)}Rows = async () => {
  isLoading.value = true
  try {
    const res = await sdk.fetch${js.nameType(inflector.pluralize(form.value("object", form.id)))}({}, 0, -1)
    return res
  } catch (error) {
    fb.error('发生错误', error)
  } finally {
    isLoading.value = false
  }
}
</#macro>

<#macro print_layout_excel_form form indent=0>
${""?left_pad(indent)}<${namespace}-excelform style="flex:1;"
${""?left_pad(indent)}  :columns="${js.nameVariable(form.id)}Cols"
${""?left_pad(indent)}  :fetch-data="load${js.nameType(form.id)}Rows"
${""?left_pad(indent)}  @cell-change="handle${js.nameType(form.id)}CellChange" />
</#macro>

<!----------------------------------------------------------------------------->
<!--                               PAGED TABLE                               -->
<!----------------------------------------------------------------------------->
<#macro print_paged_table_variables table indent=0>
${""?left_pad(indent)}
${""?left_pad(indent)}// ${js.nameVariable(table.id)}分页表格相关变量
${""?left_pad(indent)}const ${js.nameVariable(table.id)}Ref = ref(null)
${""?left_pad(indent)}const ${js.nameVariable(table.id)}Cols = ref([{
  <#list table.children as column>
    <#if column?index != 0>
${""?left_pad(indent)}},{    
    </#if>
    <#if column.id??>
${""?left_pad(indent)}  key:'${js.nameVariable(column.id)}',
    </#if>
${""?left_pad(indent)}  title:'${column.title}',      
${""?left_pad(indent)}  width:'${column.value("width","120")}px', 
    <#if column.type == "date">
${""?left_pad(indent)}  align: 'center',
${""?left_pad(indent)}  render: v => `<span style="font-family:Consolas,monospace;color:#5d6d7e">${r"${v}"}</span>`,
    <#elseif column.type == "number">
${""?left_pad(indent)}  align: 'right',    
${""?left_pad(indent)}  render: v => `<span style="font-family:Consolas,monospace;color:#5d6d7e">${r"${v}"}</span>`,
    <#elseif column.type == "buttons">
${""?left_pad(indent)}  align: 'center',
${""?left_pad(indent)}  render: (v, row) => {                                       
${""?left_pad(indent)}    return `
      <#list column.children as button>
<@print_layout_widget widget=button indent=indent+6 />      
      </#list>
${""?left_pad(indent)}    `   
${""?left_pad(indent)}  },    
    <#else>
${""?left_pad(indent)}  render: v => `<span style="font-family:Consolas,monospace;color:#5d6d7e">${r"${v}"}</span>`,
    </#if>
  </#list>
${""?left_pad(indent)}}])
</#macro>

<#macro print_paged_table_methods table indent=0>
  <#local url = valuebase.url(table.value("data"))>

/**
 * 加载【${table.title!""}】分页表格数据的界面函数
 */
const load${js.nameType(table.id)}Rows = async (params, pageNumber, pageSize) => {
  isLoading.value = true
  try {
    const res = await sdk.fetch${js.nameType(inflector.pluralize(url.resource))}(params, (pageNumber - 1) * pageSize, pageSize)
    return res;
  } catch (error) {
    fb.error('发生错误', error)
  } finally {
    isLoading.value = false
  }
}
</#macro>

<#macro print_layout_paged_table table indent=0>
${""?left_pad(indent)}<${namespace}-pagedtable
${""?left_pad(indent)}  ref="${js.nameVariable(table.id)}Ref"
${""?left_pad(indent)}  style="flex:1"
${""?left_pad(indent)}  id-key="${js.nameVariable(table.value("object","object"))}Id"
${""?left_pad(indent)}  :columns="${js.nameVariable(table.id)}Cols"
${""?left_pad(indent)}  :fetch-data="load${js.nameType(table.id)}Rows"
${""?left_pad(indent)}  :fetch-params="${js.nameVariable(table.value("object", table.id))}Crit"
${""?left_pad(indent)}  :row-class-name="getRowClass"
${""?left_pad(indent)}  @selection-change="handle${js.nameType(table.id)}RowSelection" 
${""?left_pad(indent)}  @row-action="handle${js.nameType(table.id)}RowAction" />
</#macro>

<!----------------------------------------------------------------------------->
<!--                               FIXED TABLE                               -->
<!----------------------------------------------------------------------------->
<#macro print_fixed_table_variables table indent=0>

${""?left_pad(indent)}// ${js.nameVariable(table.id)}固定表格相关变量
${""?left_pad(indent)}const ${js.nameVariable(table.id)}Ref = ref(null)
${""?left_pad(indent)}const ${js.nameVariable(table.id)}Cols = ref([{
  <#list table.children as column>
    <#if column?index != 0>
${""?left_pad(indent)}},{    
    </#if>
    <#if column.id??>
${""?left_pad(indent)}  key:'${js.nameVariable(column.id)}',
    </#if>
${""?left_pad(indent)}  title:'${column.title}',      
${""?left_pad(indent)}  width:'${column.value("width","120")}px', 
    <#if column.value("fixed","") != "">
${""?left_pad(indent)}  fixed:'${column.value("fixed","")}', 
    </#if>
    <#if column.type == "date">
${""?left_pad(indent)}  align: 'center',
${""?left_pad(indent)}  render: v => `<span style="font-family:Consolas,monospace;color:#5d6d7e">${r"${v}"}</span>`,
    <#elseif column.type == "number">
${""?left_pad(indent)}  align: 'right',    
${""?left_pad(indent)}  render: v => `<span style="font-family:Consolas,monospace;color:#5d6d7e">${r"${v}"}</span>`,
    <#elseif column.type == "buttons">
${""?left_pad(indent)}  align: 'center',
${""?left_pad(indent)}  render: (v, row) => {                                       
${""?left_pad(indent)}    return `
      <#list column.children as button>
<@print_layout_widget widget=button indent=indent+6 />      
      </#list>
${""?left_pad(indent)}    `   
${""?left_pad(indent)}  },    
    <#else>
${""?left_pad(indent)}  render: v => `<span style="font-family:Consolas,monospace;color:#5d6d7e">${r"${v}"}</span>`,
    </#if>
  </#list>
${""?left_pad(indent)}}])
</#macro>

<#macro print_fixed_table_methods table indent=0>
  <#local url = valuebase.url(table.value("data"))>

/**
 * 加载数据的界面函数
 */
const load${js.nameType(table.id)}Rows = async (params, pageNumber, pageSize) => {
  isLoading.value = true
  try {
    const res = await sdk.fetch${js.nameType(inflector.pluralize(url.resource))}(params, (pageNumber - 1) * pageSize, pageSize)
    return res
  } catch (error) {
    fb.error('发生错误', error)
  } finally {
    isLoading.value = false
  }
}
</#macro>

<#macro print_layout_fixed_table table indent=0>
${""?left_pad(indent)}<${namespace}-fixedtable
${""?left_pad(indent)}  ref="${js.nameVariable(table.id)}Ref"
${""?left_pad(indent)}  style="flex:1"
${""?left_pad(indent)}  :columns="${js.nameVariable(table.id)}Cols"
${""?left_pad(indent)}  :fetch-data="load${js.nameType(table.id)}Rows"
${""?left_pad(indent)}  :fetch-params="${js.nameVariable(table.value("object", table.id))}Crit"
${""?left_pad(indent)}  id-key="personId"
${""?left_pad(indent)}  :row-class-name="getRowClass"
${""?left_pad(indent)}  @selection-change="handleSelection" />
</#macro>

<!----------------------------------------------------------------------------->
<!--                               PAGED GRID                                -->
<!----------------------------------------------------------------------------->
<#macro print_paged_grid_variables grid indent=0>

${""?left_pad(indent)}/**
${""?left_pad(indent)} * ${js.nameVariable(grid.id)}【分页网格】相关变量
${""?left_pad(indent)} */
${""?left_pad(indent)}const ${js.nameVariable(grid.id)}Ref = ref(null)
</#macro>

<#macro print_paged_grid_methods grid indent=0>
  <#local url = valuebase.url(grid.value("data"))>

/**
 * 加载数据的界面函数
 */
const load${js.nameType(grid.id)}Rows = async (params, pageNumber, pageSize) => {
  isLoading.value = true
  try {
    const res = await sdk.fetch${js.nameType(inflector.pluralize(url.resource))}(params, (pageNumber - 1) * pageSize, pageSize)
    return res;
  } catch (error) {
    fb.error('发生错误', error)
  } finally {
    isLoading.value = false
  }
}
</#macro>

<#macro print_layout_paged_grid grid indent=0>
${""?left_pad(indent)}<${namespace}-pagedgrid
${""?left_pad(indent)}  ref="${js.nameVariable(grid.id)}Ref"
${""?left_pad(indent)}  style="flex:1"
${""?left_pad(indent)}  id-key="${js.nameVariable(grid.value("object","object"))}Id"
${""?left_pad(indent)}  :fetch-data="load${js.nameType(grid.id)}Rows"
${""?left_pad(indent)}  :fetch-params="${js.nameVariable(grid.value("object", grid.id))}Crit">
${""?left_pad(indent)}  <template #default="{ row, index }">
${""?left_pad(indent)}    <div :key="row.id || idx" style="display: flex; flex-direction: column; height: 100%;">
<@print_tile_layout widget=grid indent=indent+6 />
  <#if grid.has("buttons")>
    <#local buttons = grid.byType("buttons")[0]>
${""?left_pad(indent)}      <div class="tile-actions">
      <#list buttons.children as button>
${""?left_pad(indent)}        <button class="pg-btn pg-btn--${guidbase.get_button_variant(button)} pg-btn--sm" @click.stop="${guidbase.name_button_method(button)}(row)">${button.title}</button>
      </#list>
${""?left_pad(indent)}      </div>
  </#if>
${""?left_pad(indent)}    </div>
${""?left_pad(indent)}  </template>
${""?left_pad(indent)}</${namespace}-pagedgrid>
</#macro>

<!----------------------------------------------------------------------------->
<!--                                 TIME GRID                               -->
<!----------------------------------------------------------------------------->
<#macro print_time_grid_variables grid indent=0>

${""?left_pad(indent)}/**
${""?left_pad(indent)} * ${js.nameVariable(grid.id)}【时间网格】相关变量
${""?left_pad(indent)} */
${""?left_pad(indent)}const ${js.nameVariable(grid.id)}Ref = ref(null)
</#macro>

<#macro print_time_grid_methods grid indent=0>
  <#local objname = grid.value("object",grid.id)>

/**
 * 加载数据的界面函数
 */
const load${js.nameType(grid.id)}Rows = async (params, pageNumber, pageSize) => {
  isLoading.value = true
  try {
    const res = await sdk.fetch${js.nameType(inflector.pluralize(objname))}(params, (pageNumber - 1) * pageSize, pageSize)
    return res;
  } catch (error) {
    fb.error('发生错误', error)
  } finally {
    isLoading.value = false
  }
}
</#macro>

<!----------------------------------------------------------------------------->
<!--                               SPLIT LIST                                -->
<!----------------------------------------------------------------------------->
<#macro print_split_list_variables list indent=0>

${""?left_pad(indent)}/**
${""?left_pad(indent)} * ${js.nameVariable(list.id)}【分栏列表】相关变量
${""?left_pad(indent)} */
${""?left_pad(indent)}const ${js.nameVariable(list.id)}Groups = ref([])
${""?left_pad(indent)}const ${js.nameVariable(list.id)}Rows = ref([])
</#macro>

<#macro print_split_list_methods list indent=0>
  <#local urlGroup = valuebase.url(list.value("group"))>
  <#local urlData = valuebase.url(list.value("data"))>

/**
 * 加载数据的界面函数
 */
const load${js.nameType(list.id)}Groups = async (params, pageNumber, pageSize) => {
  isLoading.value = true
  try {
    const res = await sdk.fetch${js.nameType(inflector.pluralize(urlGroup.resource))}(params, 0, -1)
    ${js.nameVariable(list.id)}Groups.value = res.data;
  } catch (error) {
    fb.error('发生错误', error)
  } finally {
    isLoading.value = false
  }
}

const load${js.nameType(list.id)}Rows = async (params, pageNumber, pageSize) => {
  isLoading.value = true
  try {
    const res = await sdk.fetch${js.nameType(inflector.pluralize(urlData.resource))}(params, 0, -1)
    ${js.nameVariable(list.id)}Rows.value = res.data;
  } catch (error) {
    fb.error('发生错误', error)
  } finally {
    isLoading.value = false
  }
}
</#macro>

<!----------------------------------------------------------------------------->
<!--                                LIST VIEW                                -->
<!----------------------------------------------------------------------------->
<#macro print_list_view_variables list indent=0>

${""?left_pad(indent)}/**
${""?left_pad(indent)} * ${js.nameVariable(list.id)}【瓦片列表】相关变量
${""?left_pad(indent)} */
${""?left_pad(indent)}const ${js.nameVariable(list.id)}Rows = ref([])
</#macro>

<#macro print_list_view_methods list indent=0>
  <#local url = valuebase.url(list.value("data"))>

/**
 * 加载数据的界面函数
 */
const load${js.nameType(list.id)}Rows = async (params, pageNumber, pageSize) => {
  isLoading.value = true
  try {
    const res = await sdk.fetch${js.nameType(inflector.pluralize(url.resource))}(params, 0, -1)
    ${js.nameVariable(list.id)}Rows.value = res.data;
  } catch (error) {
    fb.error('发生错误', error)
  } finally {
    isLoading.value = false
  }
}
</#macro>

<!----------------------------------------------------------------------------->
<!--                                  CHART                                  -->
<!----------------------------------------------------------------------------->
<#macro print_chart_variables chart indent=0>

${""?left_pad(indent)}/**
${""?left_pad(indent)} * ${js.nameVariable(chart.id)}【数据图表】相关变量
${""?left_pad(indent)} */
${""?left_pad(indent)}const ${js.nameVariable(chart.id)}Data = ref([])
${""?left_pad(indent)}const ${js.nameVariable(chart.id)}Conf = computed(() =>
  <#if chart.value("chart", "") == "pie">
${""?left_pad(indent)}  createChart(${js.nameVariable(chart.id)}Data.value).pie().x('month').y('amount').sum().build()
  <#elseif chart.value("chart", "") == "line">
${""?left_pad(indent)}  createChart(${js.nameVariable(chart.id)}Data.value).line().x('month').split('category').y('amount').avg().build()
  <#elseif chart.value("chart", "") == "bar">
${""?left_pad(indent)}  createChart(${js.nameVariable(chart.id)}Data.value).bar().x('month').split('category').y('amount').sum().build()
  <#elseif chart.value("chart", "") == "stack">
${""?left_pad(indent)}  createChart(${js.nameVariable(chart.id)}Data.value).bar().x('month').split('category').y('amount').sum().stack().build()
  </#if>
)
</#macro>

<#macro print_chart_methods chart indent=0>

/**
 * 加载数据的界面函数
 */
const load${js.nameType(chart.id)}Rows = async (params, pageNumber, pageSize) => {
  try {
    const res = await sdk.fetch${js.nameType(inflector.pluralize(chart.value("object",chart.id)))}(params, (pageNumber - 1) * pageSize, pageSize)
    ${js.nameVariable(chart.id)}Data.value = res.data
  } catch (error) {
    fb.error('发生错误', error)
  } 
}
</#macro>

<#macro print_layout_chart chart indent=0>
${""?left_pad(indent)}<${namespace}-chart :option="${js.nameVariable(chart.id)}Conf" height="280px" />
</#macro>

<!----------------------------------------------------------------------------->
<!--                                  BUTTON                                 -->
<!----------------------------------------------------------------------------->
<#macro print_button_variables button indent=0>
  <#local action = valuebase.action(button.value("action"))>
  <#local method = action.method!"">
  <#if method == "close">
${""?left_pad(indent)}// 关闭按钮需要注入dialogClose函数  
${""?left_pad(indent)}const dialogClose = inject('dialogClose', () => {})
  </#if>
</#macro>

<#macro print_button_methods button indent=0>
  <#local action = valuebase.action(button.value("action"))>
  <#local method = action.method!"">
  <#if method == "save"><#return></#if>
  <#-- 集合部件和非集合部件的按钮方法头 -->
  <#if button.ancestor("paged_table")?? || button.ancestor("paged_grid")??>
const ${guidbase.name_button_method(button)} = async (row) => {    
  <#else>
const ${guidbase.name_button_method(button)} = async () => {      
  </#if>
  <#if method == "close">
  dialogClose()
  </#if>
  <#if !guidbase.get_action_widget(button)??>
    <#if action.type.name() == "DIALOG" || action.type.name() == "DRAWER">
  ${js.nameVariable(action.resource)}Open.value = true    
    </#if>
  <#else>
    <#local widget = guidbase.get_action_widget(button)>
    <#if widget.type == "dialog"><#-- 编辑 -->
  ${js.nameVariable(widget.id)}Open.value = true  
    <#elseif widget.type == "drawer"><#-- 查看 -->
  ${js.nameVariable(widget.id)}Open.value = true
    <#elseif method == "delete" || method == "remove"><#-- 删除 -->
  const ok = await fb.confirm('询问', '确定要删除该条数据？')
  if (!ok) return;  
    <#elseif method == "reset"><#-- 重置 -->
      <#if widget.type == "entry_form">
  const ok = await fb.confirm('询问', '确定要清空表单数据？')
  if (!ok) return; 
      </#if>
      <#list widget.inputs as input>
  ${guidbase.name_input_variable(input)} = ${guidbase4js.get_primitive_default_value(input)};
      </#list>
    <#elseif method == "search"><#-- 重置 -->
  ${js.nameVariable(widget.id)}Ref.value?.refresh()
    <#elseif method == "save"><#-- 保存 -->
  // TODO: save${js.nameType(widget.id)}Data();
    <#elseif method == "add"><#-- 新增 -->
  ${js.nameVariable(widget.id)}Open.value = true  
    <#elseif method == "edit"><#-- 新增 -->
  ${js.nameVariable(widget.id)}Open.value = true  
    <#elseif method == "view"><#-- 新增 -->
  ${js.nameVariable(widget.id)}Open.value = true  
    <#elseif method == "close"><#-- 关闭 -->
  dialogClose()   
    </#if>
  </#if>
}
</#macro>

<#--
 ### 页面中固定在底部，tabs出现在右侧
 -->
<#macro print_layout_buttons buttons indent=0>
  <#-- bnrlike 模式下，按钮在tab页的右侧 -->
  <#if buttons.ancestor("tabs")??>
    <#return>
  </#if>
${""?left_pad(indent)}<div class="${namespace}-form-footer">
${""?left_pad(indent)}  <div style="margin-left: auto;">
  <#list buttons.children as child>
<@print_layout_widget widget=child indent=indent+4 />
  </#list>    
${""?left_pad(indent)}  </div>
${""?left_pad(indent)}</div>
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
  <#if widget.type == "drawer">
${""?left_pad(indent)}<${namespace}-drawer v-model="${js.nameVariable(widget.id)}Open" title="${widget.title}">
    <#if widget.value("page","") != "">
      <#local pagePath = widget.value("page")>
${""?left_pad(indent)}  <${js.nameFile(pagePath?replace("/", "_"))} />
    <#else>
      <#list widget.children as child>
<@print_layout_widget widget=child indent=indent />    
      </#list>
    </#if>
${""?left_pad(indent)}</${namespace}-drawer>
  <#elseif widget.type == "dialog">
${""?left_pad(indent)}<${namespace}-dialog v-model="${js.nameVariable(widget.id)}Open" title="${widget.title}" size="lg">  
    <#if widget.value("page","") != "">
      <#local pagePath = widget.value("page")>
${""?left_pad(indent)}  <${js.nameFile(pagePath?replace("/", "_"))} />
    <#else>
      <#list widget.children as child>
<@print_layout_widget widget=child indent=indent />    
      </#list>
    </#if>
${""?left_pad(indent)}</${namespace}-dialog>
  <#elseif widget.type == "tabs">
<@print_layout_tabs tabs=widget indent=indent />
  <#elseif widget.type == "entry_form">
<@print_layout_entry_form form=widget indent=indent />    
  <#elseif widget.type == "official_form">
<@print_layout_official_form form=widget indent=indent />   
  <#elseif widget.type == "excel_form">
<@print_layout_excel_form form=widget indent=indent />      
  <#elseif widget.type == "paged_table">
<@print_layout_paged_table table=widget indent=indent />
  <#elseif widget.type == "fixed_table">
<@print_layout_fixed_table table=widget indent=indent />
  <#elseif widget.type == "criteria_form">
<@print_layout_criteria_form form=widget indent=indent />
  <#elseif widget.type == "display_form">
<@print_layout_display_form form=widget indent=indent />
  <#elseif widget.type == "paged_grid">
<@print_layout_paged_grid grid=widget indent=indent />
  <#elseif widget.type == "list_view">
<@print_layout_list_view list=widget indent=indent />
  <#elseif widget.type == "chart">
<@print_layout_chart chart=widget indent=indent />
  <#elseif widget.type == "buttons">
<@print_layout_buttons buttons=widget indent=indent />
  <#elseif widget.type == "select">
    <#if (widget.value("data")!"")?starts_with("enum[")>
${""?left_pad(indent)}<${namespace}-dropdown data-test="${js.nameVariable(widget.id)}" :options="sdk.${js.nameVariable(widget.id)}Options" :clearable="true" v-model="${guidbase.name_input_variable(widget)}" />    
    <#else>
${""?left_pad(indent)}<${namespace}-dropdown data-test="${js.nameVariable(widget.id)}" :options="${js.nameVariable(widget.id)}Options"  :clearable="true" v-model="${guidbase.name_input_variable(widget)}" />
    </#if>
  <#elseif widget.type == "date">
${""?left_pad(indent)}<${namespace}-datepicker data-test="${js.nameVariable(widget.id)}" v-model="${guidbase.name_input_variable(widget)}" />    
  <#elseif widget.type == "time">
${""?left_pad(indent)}<${namespace}-timepicker data-test="${js.nameVariable(widget.id)}" v-model="${guidbase.name_input_variable(widget)}" />
  <#elseif widget.type == "cascade">
${""?left_pad(indent)}<${namespace}-cascadepicker data-test="${js.nameVariable(widget.id)}" :fetch-options="sdk.fetch${js.nameType(widget.value("object",widget.id))}AsOptions" v-model="${guidbase.name_input_variable(widget)}" />
  <#elseif widget.type == "multiselect">
${""?left_pad(indent)}<${namespace}-multiselect data-test="${js.nameVariable(widget.id)}" :options="${js.nameVariable(widget.id)}Options" v-model="${guidbase.name_input_variable(widget)}" />
  <#elseif widget.type == "avatar">
${""?left_pad(indent)}<${namespace}-avatarupload data-test="${js.nameVariable(widget.id)}" v-model="${guidbase.name_input_variable(widget)}" />
  <#elseif widget.type == "tags">
${""?left_pad(indent)}<${namespace}-tagsinput data-test="${js.nameVariable(widget.id)}" v-model="${guidbase.name_input_variable(widget)}" />
<#elseif widget.type == "images">
${""?left_pad(indent)}<${namespace}-imageupload data-test="${js.nameVariable(widget.id)}" v-model="${guidbase.name_input_variable(widget)}" />
<#elseif widget.type == "videos">
${""?left_pad(indent)}<${namespace}-videoupload data-test="${js.nameVariable(widget.id)}" v-model="${guidbase.name_input_variable(widget)}" />
<#elseif widget.type == "files">
${""?left_pad(indent)}<${namespace}-fileupload data-test="${js.nameVariable(widget.id)}" v-model="${guidbase.name_input_variable(widget)}" />
  <#else><#-- 各个Design System的个性化风格 -->
<@print_layout_custom widget=widget indent=indent />  
  </#if>
</#macro>