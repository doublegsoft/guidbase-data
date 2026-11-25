<#import "/$/guidbase.ftl" as guidbase>
<#include "tile@vue3.ftl">
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
    <#if input.type == "cascade">
${""?left_pad(indent)}  ${js.nameVariable(input.id)}OptionLabels: [],
    </#if>
  </#list>
${""?left_pad(indent)}});
  <#list form.inputs as input>
    <#if pageVars[input.id]??><#continue></#if>
    <#if input.type == "select" || input.type == "multiselect">
${""?left_pad(indent)}const ${js.nameVariable(input.id)}Options = ref([])    
      <#global pageVars += {input.id:input.id}>
    </#if>
  </#list>
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
      .filter(([, msg]) => msg).map(([, msg]) => `· ${r"${msg}"}`)
    fb.error('错误', msgs.join('\n'))
    return
  }
  is${js.nameType(form.id)}Submitting.value = true
  const hideLoading = fb.loading ? fb.loading('正在保存，请稍候...') : null
  try {
    const result = await sdk.save${js.nameType(url.resource)}(${js.nameVariable(form.id)}Data)
    if (result.success) {
      fb.success('成功', '保存成功');
    }
  } catch (error) {
    fb.error('发生错误', error)
  } finally {
    hideLoading?.()
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
${""?left_pad(indent)}
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
    <#if input.type == "cascade">
${""?left_pad(indent)}  ${js.nameVariable(input.id)}OptionLabels: [],
    </#if>
  </#list>
${""?left_pad(indent)}});
  <#list form.inputs as input>
    <#if pageVars[input.id]??><#continue></#if>
    <#if input.type == "select" || input.type == "multiselect" || input.type == "cascade">
${""?left_pad(indent)}const ${js.nameVariable(input.id)}Options = ref([])    
      <#global pageVars += {input.id:input.id}>
    </#if>
  </#list>
</#macro>

<#macro print_official_form_methods form indent=0>
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
      .filter(([, msg]) => msg).map(([, msg]) => `· ${r"${msg}"}`)
    fb.error('错误', msgs.join('\n'))
    return
  }
  is${js.nameType(form.id)}Submitting.value = true
  const hideLoading = fb.loading ? fb.loading('正在保存，请稍候...') : null
  try {
    const result = await sdk.save${js.nameType(url.resource)}(${js.nameVariable(form.id)}Data)
    if (result.success) {
      fb.success('成功', '保存成功');
    }
  } catch (error) {
    fb.error('发生错误', error)
  } finally {
    hideLoading?.()
    is${js.nameType(form.id)}Submitting.value = false
  }
}

// 防止保存【${form.title!""}】编辑表单手抖的变量和函数
const { loading: is${js.nameType(form.id)}Submitting, run: handle${js.nameType(form.id)}Save } = useAsyncLock(save${js.nameType(form.id)}Data)
</#macro>

<!----------------------------------------------------------------------------->
<!--                              CRITERIA FORM                              -->
<!----------------------------------------------------------------------------->
<#macro print_criteria_form_variables form indent=0>
${""?left_pad(indent)}
${""?left_pad(indent)}// 【${form.title!form.id}】查询表单相关变量
${""?left_pad(indent)}const ${js.nameVariable(form.id)}Crit = reactive({
  <#list form.inputs as input>
${""?left_pad(indent)}  ${js.nameVariable(input.id)}: ${guidbase4js.get_primitive_default_value(input)},
  </#list>
${""?left_pad(indent)}});
  <#list form.inputs as input>
    <#if pageVars[input.id]??><#continue></#if>
    <#if input.type == "select" || input.type == "multiselect" || input.type == "cascade"> 
${""?left_pad(indent)}const ${js.nameVariable(input.id)}Options = ref([])    
      <#global pageVars += {input.id:input.id}>
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
    <#if input.type == "cascade">
${""?left_pad(indent)}  ${js.nameVariable(input.id)}OptionLabels: [],
    </#if>
  </#list>
${""?left_pad(indent)}});
  <#list form.inputs as input>
    <#if pageVars[input.id]??><#continue></#if>
    <#if input.type == "select" || input.type == "multiselect">
${""?left_pad(indent)}const ${js.nameVariable(input.id)}Options = ref([])    
      <#global pageVars += {input.id:input.id}>
    </#if>
  </#list>
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
${""?left_pad(indent)}
<#list form.inputs as input>
    <#if pageVars[input.id]??><#continue></#if>
    <#if input.type == "select" || input.type == "multiselect">
${""?left_pad(indent)}const ${js.nameVariable(input.id)}Options = ref([])    
      <#global pageVars += {input.id:input.id}>
    </#if>
  </#list>
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
    <#if column.type == "select" || column.type == "multiselect">
${""?left_pad(indent)}  options: ${js.nameVariable(column.id)}Options,
    <#elseif column.type == "cascade">
      <#assign enumRef = typebase.enumref(guidbase.get_data_from_widget(column))>
${""?left_pad(indent)}  levels: ${column.value("levels","3")},
${""?left_pad(indent)}  fetchParams: function(row, rowIndex, col) {
${""?left_pad(indent)}    return {
${""?left_pad(indent)}      companyId: row.companyId, // 取当前行的另一个字段
${""?left_pad(indent)}      status: 1
${""?left_pad(indent)}    }
${""?left_pad(indent)}  },
${""?left_pad(indent)}  fetchOptions: async function(parentValue, row, rowIndex, col, extraParams) {
${""?left_pad(indent)}    const res = await sdk.fetch${js.nameType(inflector.pluralize(enumRef.name))}AsOptions();
${""?left_pad(indent)}    return res
${""?left_pad(indent)}  },
    </#if>
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
    const res = await sdk.fetch${js.nameType(inflector.pluralize(form.value("data", form.id)))}({}, 0, -1)
    return res
  } catch (error) {
    fb.error('发生错误', error)
  } finally {
    isLoading.value = false
  }
}
</#macro>

<#macro print_excel_form_layout form indent=0>
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
${""?left_pad(indent)}  render: v => `<span style="font-family:var(--${namespace}-mono);color:var(--${namespace}-text-muted)">${r"${v}"}</span>`,
    <#elseif column.type == "number">
${""?left_pad(indent)}  align: 'right',    
${""?left_pad(indent)}  render: v => `<span style="font-family:var(--${namespace}-mono);color:var(--${namespace}-text-muted)">${r"${v}"}</span>`,
    <#elseif column.type == "tags">
${""?left_pad(indent)}  align: 'left',
${""?left_pad(indent)}  render: v => {
${""?left_pad(indent)}    if (!v && v !== 0) return '';
${""?left_pad(indent)}    const list = Array.isArray(v)
${""?left_pad(indent)}      ? v.map(item => (typeof item === 'object' && item !== null ? (item.label ?? item.name ?? item.title ?? item.value ?? '') : item))
${""?left_pad(indent)}      : String(v).split(/[,，]/).map(s => s.trim());
${""?left_pad(indent)}    return list.filter(Boolean).map(t => `<span class="${namespace}-tag ${namespace}-tag--primary" style="margin:1px 4px 1px 0;">${r"${t}"}</span>`).join('');
${""?left_pad(indent)}  },
    <#elseif column.type == "select">
      <#assign dataExpr = guidbase.get_data_from_widget(column)>
${""?left_pad(indent)}  align: 'left',
${""?left_pad(indent)}  render: v => {
${""?left_pad(indent)}    if (!v && v !== 0) return '';
      <#if dataExpr?starts_with("enum[") && dataExpr?contains(":")>
${""?left_pad(indent)}    v = sdk.get${js.nameType(column.id)}OptionLabel(v);      
${""?left_pad(indent)}    return `<span class="${namespace}-tag ${namespace}-tag--primary" style="margin:1px 4px 1px 0;">${r"${v}"}</span>`;
      <#else>
${""?left_pad(indent)}    return `<span class="${namespace}-tag ${namespace}-tag--primary" style="margin:1px 4px 1px 0;">${r"${v}"}</span>`;
      </#if>
${""?left_pad(indent)}  },
    <#elseif column.type == "multiselect">
${""?left_pad(indent)}  align: 'left',
${""?left_pad(indent)}  render: v => {
${""?left_pad(indent)}    if (!v && v !== 0) return '';
${""?left_pad(indent)}    const list = Array.isArray(v)
${""?left_pad(indent)}      ? v.map(item => (typeof item === 'object' && item !== null ? (item.label ?? item.name ?? item.title ?? item.value ?? '') : item))
${""?left_pad(indent)}      : String(v).split(/[,，]/).map(s => s.trim());
${""?left_pad(indent)}    return list.filter(Boolean).map(t => `<span class="${namespace}-tag ${namespace}-tag--primary" style="margin:1px 4px 1px 0;">${r"${t}"}</span>`).join('');
${""?left_pad(indent)}  },
    <#elseif column.type == "buttons">
${""?left_pad(indent)}  align: 'center',
${""?left_pad(indent)}  render: (v, row) => {                                       
${""?left_pad(indent)}    return `
      <#list column.children as button>
<@print_widget_layout widget=button indent=indent+6 />      
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

<#macro print_paged_table_layout table indent=0>
${""?left_pad(indent)}<${namespace}-pagedtable
${""?left_pad(indent)}  ref="${js.nameVariable(table.id)}Ref"
${""?left_pad(indent)}  style="flex:1"
${""?left_pad(indent)}  id-key="${js.nameVariable(table.value("data","object"))}Id"
${""?left_pad(indent)}  :columns="${js.nameVariable(table.id)}Cols"
${""?left_pad(indent)}  :fetch-data="load${js.nameType(table.id)}Rows"
  <#if table.value("data") != "">
    <#local url = valuebase.url(table.value("data"))>
    <#if url.params?size != 0 && url.params[0].type.name() == "OBJECT">
${""?left_pad(indent)}  :fetch-params="${js.nameVariable(url.params[0].name)}Crit"
    </#if>
  </#if>
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
<@print_widget_layout widget=button indent=indent+6 />      
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

<#macro print_fixed_table_layout table indent=0>
${""?left_pad(indent)}<${namespace}-fixedtable
${""?left_pad(indent)}  ref="${js.nameVariable(table.id)}Ref"
${""?left_pad(indent)}  style="flex:1"
${""?left_pad(indent)}  :columns="${js.nameVariable(table.id)}Cols"
${""?left_pad(indent)}  :fetch-data="load${js.nameType(table.id)}Rows"
${""?left_pad(indent)}  :fetch-params="${js.nameVariable(table.value("object", table.id))}Crit"
${""?left_pad(indent)}  id-key="personId"
${""?left_pad(indent)}  :row-class-name="getRowClass"
${""?left_pad(indent)}  @row-action="handle${js.nameType(table.id)}RowAction" />
</#macro>

<!----------------------------------------------------------------------------->
<!--                                DATA TABLE                               -->
<!----------------------------------------------------------------------------->
<#macro print_data_table_variables table indent=0>
${""?left_pad(indent)}
  <#list table.inputs as input>
    <#if pageVars[input.id]??><#continue></#if>
    <#if input.type == "select" || input.type == "multiselect">
${""?left_pad(indent)}const ${js.nameVariable(input.id)}Options = ref([])    
      <#global pageVars += {input.id:input.id}>
    </#if>
  </#list>
${""?left_pad(indent)}// ${js.nameVariable(table.id)}可编辑数据表格相关变量
${""?left_pad(indent)}const ${js.nameVariable(table.id)}Ref = ref(null)
${""?left_pad(indent)}const ${js.nameVariable(table.id)}Cols = ref([{
  <#list table.children as column>
    <#if column?index != 0>
${""?left_pad(indent)}},{    
    </#if>
    <#if column.id??>
${""?left_pad(indent)}  key: '${js.nameVariable(column.id)}',
    </#if>
${""?left_pad(indent)}  title: '${column.title}',      
${""?left_pad(indent)}  width: '${column.value("width","120")}px', 
${""?left_pad(indent)}  type: '${column.type}',
    <#if column.type == "date">
${""?left_pad(indent)}  align: 'center',
    <#elseif column.type == "number">
${""?left_pad(indent)}  align: 'right',    
    <#elseif column.type == "select">
${""?left_pad(indent)}  align: 'left',
${""?left_pad(indent)}  options: ${js.nameVariable(column.id)}Options,
    <#elseif column.type == "tags" || column.type == "multiselect">
      <#if column.type == "multiselect">
${""?left_pad(indent)}  options: ${js.nameVariable(column.id)}Options,
      </#if>
${""?left_pad(indent)}  align: 'left',
${""?left_pad(indent)}  render: function(v) {
${""?left_pad(indent)}    if (v === undefined || v === null || v === '') return '';
${""?left_pad(indent)}    var list = Array.isArray(v)
${""?left_pad(indent)}      ? v.map(function(item) { return (typeof item === 'object' && item !== null ? (item.label || item.name || item.title || item.value || '') : item); })
${""?left_pad(indent)}      : String(v).split(/[,，]/).map(function(s) { return s.trim(); });
${""?left_pad(indent)}    return list.filter(Boolean).map(function(t) {
${""?left_pad(indent)}      return '<span style="display:inline-block;padding:2px 8px;margin:2px 4px 2px 0;font-size:12px;line-height:18px;color:#409eff;background:#ecf5ff;border:1px solid #d9ecff;border-radius:4px;white-space:nowrap;">' + t + '</span>';
${""?left_pad(indent)}    }).join('');
${""?left_pad(indent)}  },
    <#else>
${""?left_pad(indent)}  align: 'left',
    </#if>
  </#list>
${""?left_pad(indent)}}])
</#macro>

<#macro print_data_table_methods table indent=0>
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

<#macro print_data_table_layout table indent=0>
${""?left_pad(indent)}<${namespace}-datatable
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

<#macro print_paged_grid_layout grid indent=0>
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
${""?left_pad(indent)}        <button class="${namespace}-btn ${namespace}-btn--${guidbase.get_button_variant(button)} ${namespace}-btn--sm" @click.stop="${guidbase.name_button_method(button)}(row)">${button.title}</button>
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

<#macro print_list_view_layout list indent=0>
${""?left_pad(indent)}<div id="list_${js.nameVariable(list.id)}" class="${namespace}-list-view">
${""?left_pad(indent)}  <template #default="{ row, index }">
${""?left_pad(indent)}    <div :key="row.id || idx" style="display: flex; flex-direction: column; height: 100%;">
<@print_tile_layout widget=list indent=indent+6 />
${""?left_pad(indent)}    </div>
${""?left_pad(indent)}  </template>
${""?left_pad(indent)}</div>
</#macro>

<!----------------------------------------------------------------------------->
<!--                                MAP VIEW                                 -->
<!----------------------------------------------------------------------------->
<#macro print_map_view_variables map indent=0>
  <#local mapId = js.nameVariable(map.id)>
${""?left_pad(indent)}// ${mapId} 地图相关变量
${""?left_pad(indent)}const ${mapId}Ref = ref(null)
${""?left_pad(indent)}let ${mapId}Map = null
${""?left_pad(indent)}const ${mapId}Layer = ref('vector') // 'vector' | 'satellite'
${""?left_pad(indent)}const ${mapId}ActiveIndex = ref(null)
${""?left_pad(indent)}const ${mapId}ActiveMarker = ref(null)

${""?left_pad(indent)}// 地图标注点示例数据 (x, y 表示视口百分比或经纬度映射)
${""?left_pad(indent)}const ${mapId}Markers = ref([
${""?left_pad(indent)}  { x: 52, y: 38, title: '云栖科技园 A座', valuation: 2800, statusText: '已抵押', statusColor: 'orange', address: '杭州市西湖区云栖小镇1号' },
${""?left_pad(indent)}  { x: 30, y: 62, title: '海晟综合物流园', valuation: 1200, statusText: '正常', statusColor: 'green', address: '宁波市北仑区进港路88号' },
${""?left_pad(indent)}  { x: 74, y: 50, title: '启明智能制造基地', valuation: 3600, statusText: '待评估', statusColor: 'blue', address: '嘉兴市南湖区创新产业带' }
${""?left_pad(indent)}])
</#macro>

<#macro print_map_view_methods map indent=0>
  <#local mapId = js.nameVariable(map.id)>
${""?left_pad(indent)}function flyTo(lat, lng) {
${""?left_pad(indent)}  ${js.nameVariable(map.id)}?.flyTo([lat, lng], 13);
${""?left_pad(indent)}}
${""?left_pad(indent)}
${""?left_pad(indent)}function init${js.nameType(map.id)}Map() {
${""?left_pad(indent)}  ${js.nameVariable(map.id)}Map = L.map(mapRef.value).setView([31.2304, 121.4737], 13);
${""?left_pad(indent)}  L.tileLayer('https://tile.openstreetmap.org/{z}/{x}/{y}.png', {
${""?left_pad(indent)}    maxZoom: 20,
${""?left_pad(indent)}    attribution: '&copy; OpenStreetMap contributors &copy; CARTO',
${""?left_pad(indent)}  }).addTo(${js.nameVariable(map.id)}Map);
${""?left_pad(indent)}  // Initial marker
${""?left_pad(indent)}  L.marker([31.2304, 121.4737])
${""?left_pad(indent)}    .addTo(${js.nameVariable(map.id)}Map)
${""?left_pad(indent)}    .bindPopup('<b>Shanghai</b>')
${""?left_pad(indent)}    .openPopup();
${""?left_pad(indent)}  // Click to add marker & display coordinates
${""?left_pad(indent)}  ${js.nameVariable(map.id)}Map.on('click', (e) => {
${""?left_pad(indent)}    const { lat, lng } = e.latlng;
${""?left_pad(indent)}    clickedCoord.value = { lat, lng };
${""?left_pad(indent)}    L.marker([lat, lng])
${""?left_pad(indent)}      .addTo(${js.nameVariable(map.id)}Map)
${""?left_pad(indent)}      .bindPopup(`Lat: ${r"${lat.toFixed(5)}"}<br>Lng: ${r"${lng.toFixed(5)}"}`)
${""?left_pad(indent)}      .openPopup();
${""?left_pad(indent)}  });
${""?left_pad(indent)}}
</#macro>

<!----------------------------------------------------------------------------->
<!--                               BPMN DIAGRAM                              -->
<!----------------------------------------------------------------------------->
<#macro print_bpmn_diagram_variables bpmn indent=0>
${""?left_pad(indent)}const ${js.nameVariable(bpmn.id)}Xml = ref(`<?xml version="1.0" encoding="UTF-8"?>
${""?left_pad(indent)}<bpmn:definitions xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
${""?left_pad(indent)}  xmlns:bpmn="http://www.omg.org/spec/BPMN/20100524/MODEL"
${""?left_pad(indent)}  xmlns:bpmndi="http://www.omg.org/spec/BPMN/20100524/DI"
${""?left_pad(indent)}  xmlns:dc="http://www.omg.org/spec/DD/20100524/DC"
${""?left_pad(indent)}  xmlns:di="http://www.omg.org/spec/DD/20100524/DI"
${""?left_pad(indent)}  id="Definitions_1"
${""?left_pad(indent)}  targetNamespace="http://bpmn.io/schema/bpmn">
${""?left_pad(indent)}  <bpmn:process id="Process_1" isExecutable="true">
${""?left_pad(indent)}    <bpmn:startEvent id="StartEvent_1" name="开始">
${""?left_pad(indent)}      <bpmn:outgoing>Flow_1</bpmn:outgoing>
${""?left_pad(indent)}    </bpmn:startEvent>
${""?left_pad(indent)}    <bpmn:userTask id="Activity_1" name="部门审批">
${""?left_pad(indent)}      <bpmn:incoming>Flow_1</bpmn:incoming>
${""?left_pad(indent)}      <bpmn:outgoing>Flow_2</bpmn:outgoing>
${""?left_pad(indent)}    </bpmn:userTask>
${""?left_pad(indent)}    <bpmn:endEvent id="EndEvent_1" name="结束">
${""?left_pad(indent)}      <bpmn:incoming>Flow_2</bpmn:incoming>
${""?left_pad(indent)}    </bpmn:endEvent>
${""?left_pad(indent)}    <bpmn:sequenceFlow id="Flow_1" sourceRef="StartEvent_1" targetRef="Activity_1" />
${""?left_pad(indent)}    <bpmn:sequenceFlow id="Flow_2" sourceRef="Activity_1" targetRef="EndEvent_1" />
${""?left_pad(indent)}  </bpmn:process>
${""?left_pad(indent)}  <bpmndi:BPMNDiagram id="BPMNDiagram_1">
${""?left_pad(indent)}    <bpmndi:BPMNPlane id="BPMNPlane_1" bpmnElement="Process_1">
${""?left_pad(indent)}      <bpmndi:BPMNShape id="StartEvent_1_di" bpmnElement="StartEvent_1">
${""?left_pad(indent)}        <dc:Bounds x="160" y="160" width="36" height="36" />
${""?left_pad(indent)}      </bpmndi:BPMNShape>
${""?left_pad(indent)}      <bpmndi:BPMNShape id="Activity_1_di" bpmnElement="Activity_1">
${""?left_pad(indent)}        <dc:Bounds x="260" y="138" width="100" height="80" />
${""?left_pad(indent)}      </bpmndi:BPMNShape>
${""?left_pad(indent)}      <bpmndi:BPMNShape id="EndEvent_1_di" bpmnElement="EndEvent_1">
${""?left_pad(indent)}        <dc:Bounds x="430" y="160" width="36" height="36" />
${""?left_pad(indent)}      </bpmndi:BPMNShape>
${""?left_pad(indent)}      <bpmndi:BPMNEdge id="Flow_1_di" bpmnElement="Flow_1">
${""?left_pad(indent)}        <di:waypoint x="196" y="178" />
${""?left_pad(indent)}        <di:waypoint x="260" y="178" />
${""?left_pad(indent)}      </bpmndi:BPMNEdge>
${""?left_pad(indent)}      <bpmndi:BPMNEdge id="Flow_2_di" bpmnElement="Flow_2">
${""?left_pad(indent)}        <di:waypoint x="360" y="178" />
${""?left_pad(indent)}        <di:waypoint x="430" y="178" />
${""?left_pad(indent)}      </bpmndi:BPMNEdge>
${""?left_pad(indent)}    </bpmndi:BPMNPlane>
${""?left_pad(indent)}  </bpmndi:BPMNDiagram>
${""?left_pad(indent)}</bpmn:definitions>`);
</#macro>

<#macro print_bpmn_diagram_methods bpmn indent=0>
</#macro>

<!----------------------------------------------------------------------------->
<!--                               BPMN EDITOR                               -->
<!----------------------------------------------------------------------------->
<#macro print_bpmn_editor_variables bpmn indent=0>
  <#local varId = js.nameVariable(bpmn.id)>
${""?left_pad(indent)}// 【${bpmn.title!"流程编辑器"}】BPMN 流程编辑器相关变量
${""?left_pad(indent)}const ${varId}Ns = 'xmlns:bpmn="http://www.omg.org/spec/BPMN/20100524/MODEL" xmlns:bpmndi="http://www.omg.org/spec/BPMN/20100524/DI" xmlns:dc="http://www.omg.org/spec/DD/20100524/DC" xmlns:di="http://www.omg.org/spec/DD/20100524/DI"'
${""?left_pad(indent)}const ${varId}Wrap = (b) => '<?xml version="1.0" encoding="UTF-8"?><bpmn:definitions ' + ${varId}Ns + ' id="Defs" targetNamespace="http://bpmn.io/schema/bpmn">' + b + '</bpmn:definitions>'
${""?left_pad(indent)}const ${varId}Sh = (id, x, y, w, h) => '<bpmndi:BPMNShape id="' + id + '_di" bpmnElement="' + id + '"><dc:Bounds x="' + x + '" y="' + y + '" width="' + w + '" height="' + h + '"/></bpmndi:BPMNShape>'
${""?left_pad(indent)}const ${varId}Ed = (id, pts) => '<bpmndi:BPMNEdge id="' + id + '_di" bpmnElement="' + id + '">' + pts.map((p) => '<di:waypoint x="' + p[0] + '" y="' + p[1] + '"/>').join('') + '</bpmndi:BPMNEdge>'
${""?left_pad(indent)}
${""?left_pad(indent)}const ${varId}EmptyXml = ${varId}Wrap('<bpmn:process id="Process_1"><bpmn:startEvent id="S" name="开始"/></bpmn:process><bpmndi:BPMNDiagram id="D"><bpmndi:BPMNPlane id="P" bpmnElement="Process_1">' + ${varId}Sh('S', 200, 180, 36, 36) + '</bpmndi:BPMNPlane></bpmndi:BPMNDiagram>')
${""?left_pad(indent)}const ${varId}DemoXml = ${varId}Wrap([
${""?left_pad(indent)}  '<bpmn:process id="Leave" name="请假审批" isExecutable="false">',
${""?left_pad(indent)}  '<bpmn:startEvent id="s" name="发起请假"/><bpmn:userTask id="t1" name="提交申请"/><bpmn:userTask id="t2" name="部门经理审批"/>',
${""?left_pad(indent)}  '<bpmn:exclusiveGateway id="g" name="天数≥3？"/><bpmn:userTask id="t3" name="总监审批"/><bpmn:serviceTask id="t4" name="归档并通知"/><bpmn:endEvent id="e" name="结束"/>',
${""?left_pad(indent)}  '<bpmn:sequenceFlow id="f1" sourceRef="s" targetRef="t1"/><bpmn:sequenceFlow id="f2" sourceRef="t1" targetRef="t2"/><bpmn:sequenceFlow id="f3" sourceRef="t2" targetRef="g"/>',
${""?left_pad(indent)}  '<bpmn:sequenceFlow id="f4" name="是" sourceRef="g" targetRef="t3"/><bpmn:sequenceFlow id="f5" sourceRef="t3" targetRef="t4"/><bpmn:sequenceFlow id="f6" sourceRef="t4" targetRef="e"/><bpmn:sequenceFlow id="f7" name="否" sourceRef="g" targetRef="t4"/>',
${""?left_pad(indent)}  '</bpmn:process>',
${""?left_pad(indent)}  '<bpmndi:BPMNDiagram id="D"><bpmndi:BPMNPlane id="P" bpmnElement="Leave">',
${""?left_pad(indent)}  ${varId}Sh('s', 152, 102, 36, 36), ${varId}Sh('t1', 240, 80, 100, 80), ${varId}Sh('t2', 390, 80, 100, 80),
${""?left_pad(indent)}  ${varId}Sh('g', 545, 95, 50, 50), ${varId}Sh('t3', 650, 80, 100, 80), ${varId}Sh('t4', 800, 80, 100, 80), ${varId}Sh('e', 952, 102, 36, 36),
${""?left_pad(indent)}  ${varId}Ed('f1', [[188, 120], [240, 120]]), ${varId}Ed('f2', [[340, 120], [390, 120]]), ${varId}Ed('f3', [[490, 120], [545, 120]]),
${""?left_pad(indent)}  ${varId}Ed('f4', [[595, 120], [650, 120]]), ${varId}Ed('f5', [[750, 120], [800, 120]]), ${varId}Ed('f6', [[900, 120], [952, 120]]),
${""?left_pad(indent)}  ${varId}Ed('f7', [[570, 145], [570, 230], [850, 230], [850, 160]]),
${""?left_pad(indent)}  '</bpmndi:BPMNPlane></bpmndi:BPMNDiagram>'
${""?left_pad(indent)}].join(''))
${""?left_pad(indent)}
${""?left_pad(indent)}const ${varId}Dict = {
${""?left_pad(indent)}  'Activate the hand tool': '抓手工具', 'Activate the lasso tool': '套索选择',
${""?left_pad(indent)}  'Activate the create/remove space tool': '调整间距', 'Activate the global connect tool': '全局连线',
${""?left_pad(indent)}  'Create StartEvent': '创建开始事件', 'Create EndEvent': '创建结束事件',
${""?left_pad(indent)}  'Create Intermediate/Boundary Event': '创建中间/边界事件', 'Create Gateway': '创建网关',
${""?left_pad(indent)}  'Create Task': '创建任务', 'Create expanded SubProcess': '创建子流程',
${""?left_pad(indent)}  'Create Pool/Participant': '创建泳池/参与者', 'Create Group': '创建分组',
${""?left_pad(indent)}  'Create DataObjectReference': '创建数据对象', 'Create DataStoreReference': '创建数据存储',
${""?left_pad(indent)}  'Remove': '删除', 'Connect using Sequence/MessageFlow or Association': '连线',
${""?left_pad(indent)}  'Append EndEvent': '追加结束事件', 'Append Gateway': '追加网关',
${""?left_pad(indent)}  'Append Task': '追加任务', 'Append Intermediate/Boundary Event': '追加中间事件',
${""?left_pad(indent)}  'Add Text Annotation': '添加文本注释', 'Change element': '更换类型',
${""?left_pad(indent)}  'Task': '任务', 'User Task': '用户任务', 'Service Task': '服务任务',
${""?left_pad(indent)}  'Script Task': '脚本任务', 'Manual Task': '手工任务', 'Send Task': '发送任务',
${""?left_pad(indent)}  'Receive Task': '接收任务', 'Business Rule Task': '业务规则任务',
${""?left_pad(indent)}  'Call Activity': '调用活动', 'Sub Process (collapsed)': '子流程（折叠）',
${""?left_pad(indent)}  'Sub Process (expanded)': '子流程（展开）', 'Exclusive Gateway': '排他网关',
${""?left_pad(indent)}  'Parallel Gateway': '并行网关', 'Inclusive Gateway': '包容网关',
${""?left_pad(indent)}  'Event based Gateway': '事件网关', 'Start Event': '开始事件', 'End Event': '结束事件',
${""?left_pad(indent)}  'Message Start Event': '消息开始事件', 'Timer Start Event': '定时开始事件',
${""?left_pad(indent)}  'Message End Event': '消息结束事件', 'Terminate End Event': '终止结束事件',
${""?left_pad(indent)}  'Default flow': '默认流', 'Conditional flow': '条件流', 'Sequence flow': '顺序流',
${""?left_pad(indent)}  'Loop': '循环', 'Parallel Multi Instance': '并行多实例',
${""?left_pad(indent)}  'Sequential Multi Instance': '串行多实例', 'Ad-hoc': '临时',
${""?left_pad(indent)}  'Create': '创建', 'Append': '追加', 'Change type': '更换类型', 'Set color': '设置颜色', 'Delete': '删除'
${""?left_pad(indent)}}
${""?left_pad(indent)}const ${varId}Zh = (t, r) => (${varId}Dict[t] || t).replace(/{([^}]+)}/g, (m, k) => (r && r[k] != null ? r[k] : m))
${""?left_pad(indent)}const ${varId}TypeMap = {
${""?left_pad(indent)}  'bpmn:Process': '流程', 'bpmn:Collaboration': '协作', 'bpmn:Participant': '泳池',
${""?left_pad(indent)}  'bpmn:StartEvent': '开始事件', 'bpmn:EndEvent': '结束事件',
${""?left_pad(indent)}  'bpmn:IntermediateCatchEvent': '中间捕获事件', 'bpmn:IntermediateThrowEvent': '中间抛出事件',
${""?left_pad(indent)}  'bpmn:BoundaryEvent': '边界事件', 'bpmn:Task': '任务', 'bpmn:UserTask': '用户任务',
${""?left_pad(indent)}  'bpmn:ServiceTask': '服务任务', 'bpmn:ScriptTask': '脚本任务', 'bpmn:ManualTask': '手工任务',
${""?left_pad(indent)}  'bpmn:SendTask': '发送任务', 'bpmn:ReceiveTask': '接收任务',
${""?left_pad(indent)}  'bpmn:BusinessRuleTask': '业务规则任务', 'bpmn:CallActivity': '调用活动',
${""?left_pad(indent)}  'bpmn:SubProcess': '子流程', 'bpmn:ExclusiveGateway': '排他网关',
${""?left_pad(indent)}  'bpmn:ParallelGateway': '并行网关', 'bpmn:InclusiveGateway': '包容网关',
${""?left_pad(indent)}  'bpmn:EventBasedGateway': '事件网关', 'bpmn:SequenceFlow': '顺序流',
${""?left_pad(indent)}  'bpmn:MessageFlow': '消息流', 'bpmn:Association': '关联',
${""?left_pad(indent)}  'bpmn:TextAnnotation': '文本注释', 'bpmn:DataObjectReference': '数据对象',
${""?left_pad(indent)}  'bpmn:DataStoreReference': '数据存储', 'bpmn:Group': '分组'
${""?left_pad(indent)}}
${""?left_pad(indent)}const ${varId}Colors = [[], ['#2f6fed', '#e8f0ff'], ['#18794e', '#e3f6ec'], ['#b85400', '#fff1e0'], ['#c62828', '#fdeaea'], ['#6a3fc7', '#f0eafd']]
${""?left_pad(indent)}
${""?left_pad(indent)}const ${varId}CanvasRef = ref(null)
${""?left_pad(indent)}const ${varId}PropsRef = ref(null)
${""?left_pad(indent)}let ${varId}Modeler = null
${""?left_pad(indent)}let ${varId}Sel = []
${""?left_pad(indent)}let ${varId}SaveTimer = null
${""?left_pad(indent)}let ${varId}ToastTimer = null
${""?left_pad(indent)}
${""?left_pad(indent)}const ${varId}Xml = ref(${varId}DemoXml)
${""?left_pad(indent)}const ${varId}ActiveTab = ref('props')
${""?left_pad(indent)}const ${varId}SelCount = ref(0)
${""?left_pad(indent)}const ${varId}LintList = ref([])
${""?left_pad(indent)}const ${varId}ToastState = reactive({ show: false, msg: '' })
${""?left_pad(indent)}const ${varId}Props = reactive({
${""?left_pad(indent)}  ready: false,
${""?left_pad(indent)}  isRoot: true,
${""?left_pad(indent)}  isText: false,
${""?left_pad(indent)}  typeLabel: '',
${""?left_pad(indent)}  name: '',
${""?left_pad(indent)}  id: '',
${""?left_pad(indent)}  originId: '',
${""?left_pad(indent)}  doc: ''
${""?left_pad(indent)}})
</#macro>

<#macro print_bpmn_editor_methods bpmn indent=0>
  <#local varId = js.nameVariable(bpmn.id)>
  <#local typeId = js.nameType(bpmn.id)>
  <#local storageKey = "bpmn-editor-xml-" + varId>
${""?left_pad(indent)}const ${varId}Get = (name) => ${varId}Modeler?.get(name)
${""?left_pad(indent)}
${""?left_pad(indent)}const ${varId}ShowToast = (msg) => {
${""?left_pad(indent)}  ${varId}ToastState.msg = msg
${""?left_pad(indent)}  ${varId}ToastState.show = true
${""?left_pad(indent)}  clearTimeout(${varId}ToastTimer)
${""?left_pad(indent)}  ${varId}ToastTimer = setTimeout(() => { ${varId}ToastState.show = false }, 1800)
${""?left_pad(indent)}}
${""?left_pad(indent)}
${""?left_pad(indent)}const ${varId}XmlOf = async () => {
${""?left_pad(indent)}  if (!${varId}Modeler) return ${varId}Xml.value
${""?left_pad(indent)}  return (await ${varId}Modeler.saveXML({ format: true })).xml
${""?left_pad(indent)}}
${""?left_pad(indent)}
${""?left_pad(indent)}const ${varId}SaveStorage = async () => {
${""?left_pad(indent)}  if (!${varId}Modeler) return
${""?left_pad(indent)}  try {
${""?left_pad(indent)}    localStorage.setItem('${storageKey}', await ${varId}XmlOf())
${""?left_pad(indent)}  } catch (e) {}
${""?left_pad(indent)}}
${""?left_pad(indent)}
${""?left_pad(indent)}const ${varId}RunLint = () => {
${""?left_pad(indent)}  const registry = ${varId}Get('elementRegistry')
${""?left_pad(indent)}  if (!registry) return
${""?left_pad(indent)}  const els = registry.filter((e) => !e.labelTarget && e.businessObject && e.businessObject.$instanceOf && e.businessObject.$instanceOf('bpmn:FlowNode'))
${""?left_pad(indent)}  const out = []
${""?left_pad(indent)}  const nm = (e) => '「' + (e.businessObject.name || ${varId}TypeMap[e.type] || e.id) + '」'
${""?left_pad(indent)}  if (!els.some((e) => e.type === 'bpmn:StartEvent')) out.push({ id: '', msg: '缺少开始事件' })
${""?left_pad(indent)}  if (!els.some((e) => e.type === 'bpmn:EndEvent')) out.push({ id: '', msg: '缺少结束事件' })
${""?left_pad(indent)}  els.forEach((e) => {
${""?left_pad(indent)}    const b = e.businessObject
${""?left_pad(indent)}    const i = (b.incoming || []).length
${""?left_pad(indent)}    const o = (b.outgoing || []).length
${""?left_pad(indent)}    if (e.type === 'bpmn:BoundaryEvent') {
${""?left_pad(indent)}      if (!o) out.push({ id: e.id, msg: nm(e) + '没有出口' })
${""?left_pad(indent)}    } else if (e.type === 'bpmn:StartEvent') {
${""?left_pad(indent)}      if (!o) out.push({ id: e.id, msg: nm(e) + '没有出口' })
${""?left_pad(indent)}    } else if (e.type === 'bpmn:EndEvent') {
${""?left_pad(indent)}      if (!i) out.push({ id: e.id, msg: nm(e) + '没有入口' })
${""?left_pad(indent)}    } else if (!i || !o) {
${""?left_pad(indent)}      out.push({ id: e.id, msg: nm(e) + (i ? '没有出口' : o ? '没有入口' : '未连接') })
${""?left_pad(indent)}    } else if (/Gateway$/.test(e.type) && i + o < 3) {
${""?left_pad(indent)}      out.push({ id: e.id, msg: nm(e) + '分支不足' })
${""?left_pad(indent)}    }
${""?left_pad(indent)}  })
${""?left_pad(indent)}  ${varId}LintList.value = out
${""?left_pad(indent)}}
${""?left_pad(indent)}
${""?left_pad(indent)}const ${varId}SyncProps = () => {
${""?left_pad(indent)}  ${varId}SelCount.value = ${varId}Sel.length
${""?left_pad(indent)}  if (${varId}Sel.length > 1) {
${""?left_pad(indent)}    ${varId}Props.ready = false
${""?left_pad(indent)}    return
${""?left_pad(indent)}  }
${""?left_pad(indent)}  const el = ${varId}Sel[0] || ${varId}Get('canvas')?.getRootElement()
${""?left_pad(indent)}  const bo = el && el.businessObject
${""?left_pad(indent)}  if (!bo) {
${""?left_pad(indent)}    ${varId}Props.ready = false
${""?left_pad(indent)}    return
${""?left_pad(indent)}  }
${""?left_pad(indent)}  const isRoot = !${varId}Sel[0]
${""?left_pad(indent)}  const isText = bo.$instanceOf('bpmn:TextAnnotation')
${""?left_pad(indent)}  const doc = (bo.documentation && bo.documentation[0] && bo.documentation[0].text) || ''
${""?left_pad(indent)}  ${varId}Props.ready = true
${""?left_pad(indent)}  ${varId}Props.isRoot = isRoot
${""?left_pad(indent)}  ${varId}Props.isText = isText
${""?left_pad(indent)}  ${varId}Props.typeLabel = (isRoot ? '画布 · ' : '') + (${varId}TypeMap[bo.$type] || bo.$type)
${""?left_pad(indent)}  ${varId}Props.name = (isText ? bo.text : bo.name) || ''
${""?left_pad(indent)}  ${varId}Props.id = bo.id || ''
${""?left_pad(indent)}  ${varId}Props.originId = bo.id || ''
${""?left_pad(indent)}  ${varId}Props.doc = doc
${""?left_pad(indent)}}
${""?left_pad(indent)}
${""?left_pad(indent)}const ${varId}LoadXml = async (xml, fit = true) => {
${""?left_pad(indent)}  if (!${varId}Modeler) {
${""?left_pad(indent)}    ${varId}Xml.value = xml
${""?left_pad(indent)}    return false
${""?left_pad(indent)}  }
${""?left_pad(indent)}  try {
${""?left_pad(indent)}    await ${varId}Modeler.importXML(xml)
${""?left_pad(indent)}    if (fit) ${varId}Get('canvas').zoom('fit-viewport', 'auto')
${""?left_pad(indent)}    ${varId}Sel = []
${""?left_pad(indent)}    ${varId}SyncProps()
${""?left_pad(indent)}    ${varId}RunLint()
${""?left_pad(indent)}    return true
${""?left_pad(indent)}  } catch (e) {
${""?left_pad(indent)}    ${varId}ShowToast('导入失败：' + e.message)
${""?left_pad(indent)}    return false
${""?left_pad(indent)}  }
${""?left_pad(indent)}}
${""?left_pad(indent)}
${""?left_pad(indent)}const ${varId}UpdateProp = (props) => {
${""?left_pad(indent)}  const el = ${varId}Sel[0] || ${varId}Get('canvas')?.getRootElement()
${""?left_pad(indent)}  if (el) ${varId}Get('modeling')?.updateProperties(el, props)
${""?left_pad(indent)}}
${""?left_pad(indent)}
${""?left_pad(indent)}const ${varId}UpdateName = () => {
${""?left_pad(indent)}  ${varId}UpdateProp(${varId}Props.isText ? { text: ${varId}Props.name } : { name: ${varId}Props.name })
${""?left_pad(indent)}}
${""?left_pad(indent)}
${""?left_pad(indent)}const ${varId}UpdateId = () => {
${""?left_pad(indent)}  const v = ${varId}Props.id.trim()
${""?left_pad(indent)}  if (!/^[A-Za-z_][\w.\-]*$/.test(v)) {
${""?left_pad(indent)}    ${varId}ShowToast('ID 需以字母或下划线开头')
${""?left_pad(indent)}    ${varId}Props.id = ${varId}Props.originId
${""?left_pad(indent)}    return
${""?left_pad(indent)}  }
${""?left_pad(indent)}  if (v !== ${varId}Props.originId && ${varId}Get('elementRegistry')?.get(v)) {
${""?left_pad(indent)}    ${varId}ShowToast('ID 已存在')
${""?left_pad(indent)}    ${varId}Props.id = ${varId}Props.originId
${""?left_pad(indent)}    return
${""?left_pad(indent)}  }
${""?left_pad(indent)}  ${varId}Props.originId = v
${""?left_pad(indent)}  ${varId}UpdateProp({ id: v })
${""?left_pad(indent)}}
${""?left_pad(indent)}
${""?left_pad(indent)}const ${varId}UpdateDoc = () => {
${""?left_pad(indent)}  const v = ${varId}Props.doc
${""?left_pad(indent)}  ${varId}UpdateProp({ documentation: v ? [${varId}Get('bpmnFactory').create('bpmn:Documentation', { text: v })] : [] })
${""?left_pad(indent)}}
${""?left_pad(indent)}
${""?left_pad(indent)}const ${varId}SetColor = (c) => {
${""?left_pad(indent)}  if (!${varId}Sel.length || !${varId}Modeler) return
${""?left_pad(indent)}  ${varId}Get('modeling')?.setColor(${varId}Sel, c.length ? { stroke: c[0], fill: c[1] } : { stroke: undefined, fill: undefined })
${""?left_pad(indent)}}
${""?left_pad(indent)}
${""?left_pad(indent)}const ${varId}FocusElement = (id) => {
${""?left_pad(indent)}  const el = id && ${varId}Get('elementRegistry')?.get(id)
${""?left_pad(indent)}  if (el) {
${""?left_pad(indent)}    ${varId}Get('selection')?.select(el)
${""?left_pad(indent)}    ${varId}Get('canvas')?.scrollToElement(el)
${""?left_pad(indent)}  }
${""?left_pad(indent)}}
${""?left_pad(indent)}
${""?left_pad(indent)}const ${varId}Undo = () => ${varId}Get('commandStack')?.undo()
${""?left_pad(indent)}const ${varId}Redo = () => ${varId}Get('commandStack')?.redo()
${""?left_pad(indent)}const ${varId}ZoomFit = () => ${varId}Get('canvas')?.zoom('fit-viewport', 'auto')
${""?left_pad(indent)}const ${varId}ZoomIn = () => {
${""?left_pad(indent)}  const canvas = ${varId}Get('canvas')
${""?left_pad(indent)}  if (canvas) canvas.zoom(canvas.zoom() * 1.25)
${""?left_pad(indent)}}
${""?left_pad(indent)}const ${varId}ZoomOut = () => {
${""?left_pad(indent)}  const canvas = ${varId}Get('canvas')
${""?left_pad(indent)}  if (canvas) canvas.zoom(canvas.zoom() / 1.25)
${""?left_pad(indent)}}
${""?left_pad(indent)}
${""?left_pad(indent)}const ${varId}OnFileChange = (e) => {
${""?left_pad(indent)}  const f = e.target.files?.[0]
${""?left_pad(indent)}  if (!f) return
${""?left_pad(indent)}  const r = new FileReader()
${""?left_pad(indent)}  r.onload = () => ${varId}LoadXml(r.result)
${""?left_pad(indent)}  r.readAsText(f)
${""?left_pad(indent)}  e.target.value = ''
${""?left_pad(indent)}}
${""?left_pad(indent)}
${""?left_pad(indent)}const ${varId}SwitchTab = async (tab) => {
${""?left_pad(indent)}  ${varId}ActiveTab.value = tab
${""?left_pad(indent)}  if (tab === 'xml' && ${varId}Modeler) ${varId}Xml.value = await ${varId}XmlOf()
${""?left_pad(indent)}}
${""?left_pad(indent)}
${""?left_pad(indent)}const ${varId}CopyText = async (text) => {
${""?left_pad(indent)}  try {
${""?left_pad(indent)}    await navigator.clipboard.writeText(text)
${""?left_pad(indent)}    ${varId}ShowToast('已复制')
${""?left_pad(indent)}  } catch (e) {
${""?left_pad(indent)}    ${varId}Xml.value = text
${""?left_pad(indent)}    ${varId}ShowToast('复制失败，请从文本框手动复制')
${""?left_pad(indent)}}
${""?left_pad(indent)}}
${""?left_pad(indent)}
${""?left_pad(indent)}const ${varId}ApplyXml = async () => {
${""?left_pad(indent)}  const ok = await ${varId}LoadXml(${varId}Xml.value, false)
${""?left_pad(indent)}  if (ok) ${varId}ShowToast('已应用')
${""?left_pad(indent)}}
${""?left_pad(indent)}
${""?left_pad(indent)}const ${varId}CopyXml = async () => ${varId}CopyText(await ${varId}XmlOf())
${""?left_pad(indent)}
${""?left_pad(indent)}const ${varId}ExportSvg = async () => {
${""?left_pad(indent)}  if (!${varId}Modeler) return
${""?left_pad(indent)}  const { svg } = await ${varId}Modeler.saveSVG()
${""?left_pad(indent)}  ${varId}Xml.value = svg
${""?left_pad(indent)}  await ${varId}CopyText(svg)
${""?left_pad(indent)}}
${""?left_pad(indent)}
${""?left_pad(indent)}const init${typeId} = () => {
${""?left_pad(indent)}  if (!${varId}CanvasRef.value || ${varId}Modeler) return
${""?left_pad(indent)}  try {
${""?left_pad(indent)}    ${varId}Modeler = new BpmnModeler({
${""?left_pad(indent)}      container: ${varId}CanvasRef.value,
${""?left_pad(indent)}      keyboard: { bindTo: document },
${""?left_pad(indent)}      additionalModules: [{ translate: ['value', ${varId}Zh] }]
${""?left_pad(indent)}    })
${""?left_pad(indent)}    ${varId}Modeler.on('selection.changed', (e) => {
${""?left_pad(indent)}      ${varId}Sel = e.newSelection
${""?left_pad(indent)}      ${varId}SyncProps()
${""?left_pad(indent)}    })
${""?left_pad(indent)}    ${varId}Modeler.on('commandStack.changed', () => {
${""?left_pad(indent)}      ${varId}RunLint()
${""?left_pad(indent)}      clearTimeout(${varId}SaveTimer)
${""?left_pad(indent)}      ${varId}SaveTimer = setTimeout(${varId}SaveStorage, 400)
${""?left_pad(indent)}      if (!${varId}PropsRef.value?.contains(document.activeElement) && ${varId}Sel.length < 2) {
${""?left_pad(indent)}        ${varId}SyncProps()
${""?left_pad(indent)}      }
${""?left_pad(indent)}    })
${""?left_pad(indent)}    let initXml = ${varId}DemoXml
${""?left_pad(indent)}    try {
${""?left_pad(indent)}      initXml = localStorage.getItem('${storageKey}') || ${varId}DemoXml
${""?left_pad(indent)}    } catch (e) {}
${""?left_pad(indent)}    ${varId}LoadXml(initXml)
${""?left_pad(indent)}  } catch (err) {
${""?left_pad(indent)}    console.error('[bpmn-editor] 初始化失败:', err)
${""?left_pad(indent)}    ${varId}ShowToast('流程编辑器初始化失败：' + (err?.message || err))
${""?left_pad(indent)}  }
${""?left_pad(indent)}}
${""?left_pad(indent)}
${""?left_pad(indent)}const ${varId}BindCanvas = (el) => {
${""?left_pad(indent)}  ${varId}CanvasRef.value = el
${""?left_pad(indent)}  if (el && !${varId}Modeler) {
${""?left_pad(indent)}    init${typeId}()
${""?left_pad(indent)}  }
${""?left_pad(indent)}}
<#--  ${""?left_pad(indent)}
${""?left_pad(indent)}onMounted(() => {
${""?left_pad(indent)}  init${typeId}()
${""?left_pad(indent)}})
${""?left_pad(indent)}
${""?left_pad(indent)}onBeforeUnmount(() => {
${""?left_pad(indent)}  clearTimeout(${varId}SaveTimer)
${""?left_pad(indent)}  clearTimeout(${varId}ToastTimer)
${""?left_pad(indent)}  ${varId}Modeler?.destroy()
${""?left_pad(indent)}  ${varId}Modeler = null
${""?left_pad(indent)}})  -->
</#macro>

<!----------------------------------------------------------------------------->
<!--                               RICH EDITOR                               -->
<!----------------------------------------------------------------------------->
<#macro print_rich_editor_variables rich indent=0>
  <#local varId = js.nameVariable(rich.id)>
${""?left_pad(indent)}// 【${rich.title!"富文本编辑器"}】Quill 富文本编辑器相关变量
${""?left_pad(indent)}const ${varId}DemoHtml = [
${""?left_pad(indent)}  '<h2>关于开展年度数字化转型专项工作的通知</h2>',
${""?left_pad(indent)}  '<p>各部门、各分支机构：</p>',
${""?left_pad(indent)}  '<p>为进一步提升企业流程化与业务数字化协同能力，现将相关事项通知如下：</p>',
${""?left_pad(indent)}  '<ol><li><strong>统一规范：</strong>梳理核心业务节点，形成标准化闭环。</li>',
${""?left_pad(indent)}  '<li><strong>系统落地：</strong>结合在线审批、表单与流程引擎提升流转效率。</li></ol>',
${""?left_pad(indent)}  '<blockquote>请各单位于本月底前完成自查并提交书面汇报材料。</blockquote>'
${""?left_pad(indent)}].join('')
${""?left_pad(indent)}
${""?left_pad(indent)}const ${varId}EditorRef = ref(null)
${""?left_pad(indent)}const ${varId}ImageInputRef = ref(null)
${""?left_pad(indent)}let ${varId}Quill = null
${""?left_pad(indent)}let ${varId}InnerUpdate = false
${""?left_pad(indent)}let ${varId}SaveTimer = null
${""?left_pad(indent)}let ${varId}ToastTimer = null
${""?left_pad(indent)}
${""?left_pad(indent)}const ${varId}Html = ref(${varId}DemoHtml)
${""?left_pad(indent)}const ${varId}SourceHtml = ref(${varId}DemoHtml)
${""?left_pad(indent)}const ${varId}Mode = ref('edit') // 'edit' | 'preview' | 'source'
${""?left_pad(indent)}const ${varId}Readonly = ref(${rich.value("readonly", "false")})
${""?left_pad(indent)}const ${varId}Stats = reactive({ chars: 0, words: 0 })
${""?left_pad(indent)}const ${varId}ToastState = reactive({ show: false, msg: '' })
</#macro>

<#macro print_rich_editor_methods rich indent=0>
  <#local varId = js.nameVariable(rich.id)>
  <#local typeId = js.nameType(rich.id)>
  <#local storageKey = "rich-editor-html-" + varId>
  <#local placeholderText = rich.value("placeholder", "请输入正文内容...")>
${""?left_pad(indent)}const ${varId}ShowToast = (msg) => {
${""?left_pad(indent)}  ${varId}ToastState.msg = msg
${""?left_pad(indent)}  ${varId}ToastState.show = true
${""?left_pad(indent)}  clearTimeout(${varId}ToastTimer)
${""?left_pad(indent)}  ${varId}ToastTimer = setTimeout(() => { ${varId}ToastState.show = false }, 1800)
${""?left_pad(indent)}}
${""?left_pad(indent)}
${""?left_pad(indent)}const ${varId}UpdateStats = () => {
${""?left_pad(indent)}  if (!${varId}Quill) return
${""?left_pad(indent)}  const raw = ${varId}Quill.getText() || ''
${""?left_pad(indent)}  const clean = raw.replace(/\n$/, '')
${""?left_pad(indent)}  ${varId}Stats.chars = clean.length
${""?left_pad(indent)}  ${varId}Stats.words = clean.replace(/\s+/g, '').length
${""?left_pad(indent)}}
${""?left_pad(indent)}
${""?left_pad(indent)}const ${varId}SaveStorage = () => {
${""?left_pad(indent)}  try {
${""?left_pad(indent)}    localStorage.setItem('${storageKey}', ${varId}Html.value)
${""?left_pad(indent)}  } catch (e) {}
${""?left_pad(indent)}}
${""?left_pad(indent)}
${""?left_pad(indent)}const ${varId}SetHtml = (html, resetHistory = false) => {
${""?left_pad(indent)}  const next = html || ''
${""?left_pad(indent)}  ${varId}Html.value = next
${""?left_pad(indent)}  ${varId}SourceHtml.value = next
${""?left_pad(indent)}  if (!${varId}Quill) return
${""?left_pad(indent)}  ${varId}InnerUpdate = true
${""?left_pad(indent)}  try {
${""?left_pad(indent)}    if (!next) {
${""?left_pad(indent)}      ${varId}Quill.setContents([], 'silent')
${""?left_pad(indent)}    } else {
${""?left_pad(indent)}      ${varId}Quill.clipboard.dangerouslyPasteHTML(next, 'silent')
${""?left_pad(indent)}    }
${""?left_pad(indent)}    if (resetHistory) ${varId}Quill.history?.clear()
${""?left_pad(indent)}    ${varId}UpdateStats()
${""?left_pad(indent)}    ${varId}SaveStorage()
${""?left_pad(indent)}  } finally {
${""?left_pad(indent)}    ${varId}InnerUpdate = false
${""?left_pad(indent)}  }
${""?left_pad(indent)}}
${""?left_pad(indent)}
${""?left_pad(indent)}const ${varId}Clear = () => {
${""?left_pad(indent)}  ${varId}SetHtml('')
${""?left_pad(indent)}  ${varId}ShowToast('已清空内容')
${""?left_pad(indent)}}
${""?left_pad(indent)}
${""?left_pad(indent)}const ${varId}LoadDemo = () => {
${""?left_pad(indent)}  ${varId}SetHtml(${varId}DemoHtml)
${""?left_pad(indent)}  ${varId}ShowToast('已加载示例文档')
${""?left_pad(indent)}}
${""?left_pad(indent)}
${""?left_pad(indent)}const ${varId}Undo = () => ${varId}Quill?.history?.undo()
${""?left_pad(indent)}const ${varId}Redo = () => ${varId}Quill?.history?.redo()
${""?left_pad(indent)}
${""?left_pad(indent)}const ${varId}SwitchMode = (mode) => {
${""?left_pad(indent)}  if (mode === 'source') {
${""?left_pad(indent)}    ${varId}SourceHtml.value = ${varId}Html.value
${""?left_pad(indent)}  }
${""?left_pad(indent)}  ${varId}Mode.value = mode
${""?left_pad(indent)}}
${""?left_pad(indent)}
${""?left_pad(indent)}const ${varId}ApplySource = () => {
${""?left_pad(indent)}  ${varId}SetHtml(${varId}SourceHtml.value)
${""?left_pad(indent)}  ${varId}Mode.value = 'edit'
${""?left_pad(indent)}  ${varId}ShowToast('已应用 HTML 修改')
${""?left_pad(indent)}}
${""?left_pad(indent)}
${""?left_pad(indent)}const ${varId}CopyHtml = async () => {
${""?left_pad(indent)}  try {
${""?left_pad(indent)}    await navigator.clipboard.writeText(${varId}Html.value)
${""?left_pad(indent)}    ${varId}ShowToast('HTML 已复制')
${""?left_pad(indent)}  } catch (e) {
${""?left_pad(indent)}    ${varId}Mode.value = 'source'
${""?left_pad(indent)}    ${varId}SourceHtml.value = ${varId}Html.value
${""?left_pad(indent)}    ${varId}ShowToast('复制失败，请从源码框手动复制')
${""?left_pad(indent)}  }
${""?left_pad(indent)}}
${""?left_pad(indent)}
${""?left_pad(indent)}const ${varId}ExportHtml = () => {
${""?left_pad(indent)}  const doc = '<!doctype html><html lang="zh-CN"><head><meta charset="utf-8"><title>${rich.title!"文档导出"}</title></head><body>' + ${varId}Html.value + '</body></html>'
${""?left_pad(indent)}  const blob = new Blob([doc], { type: 'text/html;charset=utf-8' })
${""?left_pad(indent)}  const url = URL.createObjectURL(blob)
${""?left_pad(indent)}  const a = document.createElement('a')
${""?left_pad(indent)}  a.href = url
${""?left_pad(indent)}  a.download = '${varId}.html'
${""?left_pad(indent)}  a.click()
${""?left_pad(indent)}  URL.revokeObjectURL(url)
${""?left_pad(indent)}  ${varId}ShowToast('已导出 HTML 文件')
${""?left_pad(indent)}}
${""?left_pad(indent)}
${""?left_pad(indent)}const ${varId}OnImageSelected = (e) => {
${""?left_pad(indent)}  const file = e.target.files?.[0]
${""?left_pad(indent)}  if (!file || !${varId}Quill) return
${""?left_pad(indent)}  const reader = new FileReader()
${""?left_pad(indent)}  reader.onload = () => {
${""?left_pad(indent)}    const range = ${varId}Quill.getSelection(true) || { index: ${varId}Quill.getLength() }
${""?left_pad(indent)}    ${varId}Quill.insertEmbed(range.index, 'image', reader.result, 'user')
${""?left_pad(indent)}    ${varId}Quill.setSelection(range.index + 1, 0, 'silent')
${""?left_pad(indent)}  }
${""?left_pad(indent)}  reader.readAsDataURL(file)
${""?left_pad(indent)}  e.target.value = ''
${""?left_pad(indent)}}
${""?left_pad(indent)}
${""?left_pad(indent)}const init${typeId} = () => {
${""?left_pad(indent)}  if (!${varId}EditorRef.value || ${varId}Quill) return
${""?left_pad(indent)}  try {
${""?left_pad(indent)}    ${varId}Quill = new Quill(${varId}EditorRef.value, {
${""?left_pad(indent)}      theme: 'snow',
${""?left_pad(indent)}      readOnly: ${varId}Readonly.value,
${""?left_pad(indent)}      placeholder: '${placeholderText}',
${""?left_pad(indent)}      modules: {
${""?left_pad(indent)}        history: { delay: 800, maxStack: 100, userOnly: true },
${""?left_pad(indent)}        toolbar: {
${""?left_pad(indent)}          container: [
${""?left_pad(indent)}            [{ header: [1, 2, 3, false] }],
${""?left_pad(indent)}            ['bold', 'italic', 'underline', 'strike'],
${""?left_pad(indent)}            [{ color: [] }, { background: [] }],
${""?left_pad(indent)}            [{ list: 'ordered' }, { list: 'bullet' }],
${""?left_pad(indent)}            [{ indent: '-1' }, { indent: '+1' }, { align: [] }],
${""?left_pad(indent)}            ['blockquote', 'code-block', 'link', 'image'],
${""?left_pad(indent)}            ['clean']
${""?left_pad(indent)}          ],
${""?left_pad(indent)}          handlers: {
${""?left_pad(indent)}            image: () => ${varId}ImageInputRef.value?.click()
${""?left_pad(indent)}          }
${""?left_pad(indent)}        }
${""?left_pad(indent)}      }
${""?left_pad(indent)}    })
${""?left_pad(indent)}    let initHtml = ${varId}DemoHtml
${""?left_pad(indent)}    try {
${""?left_pad(indent)}      const cached = localStorage.getItem('${storageKey}')
${""?left_pad(indent)}      if (cached !== null) initHtml = cached
${""?left_pad(indent)}    } catch (e) {}
${""?left_pad(indent)}    ${varId}SetHtml(initHtml, true)
${""?left_pad(indent)}    ${varId}Quill.on('text-change', () => {
${""?left_pad(indent)}      if (${varId}InnerUpdate || !${varId}Quill) return
${""?left_pad(indent)}      const html = ${varId}Quill.root.innerHTML
${""?left_pad(indent)}      ${varId}Html.value = html === '<p><br></p>' ? '' : html
${""?left_pad(indent)}      ${varId}UpdateStats()
${""?left_pad(indent)}      clearTimeout(${varId}SaveTimer)
${""?left_pad(indent)}      ${varId}SaveTimer = setTimeout(${varId}SaveStorage, 400)
${""?left_pad(indent)}    })
${""?left_pad(indent)}  } catch (err) {
${""?left_pad(indent)}    console.error('[rich-editor] 初始化失败:', err)
${""?left_pad(indent)}    ${varId}ShowToast('富文本编辑器初始化失败：' + (err?.message || err))
${""?left_pad(indent)}  }
${""?left_pad(indent)}}
${""?left_pad(indent)}
${""?left_pad(indent)}const ${varId}BindEditor = (el) => {
${""?left_pad(indent)}  ${varId}EditorRef.value = el
${""?left_pad(indent)}  if (el && !${varId}Quill) {
${""?left_pad(indent)}    init${typeId}()
${""?left_pad(indent)}  }
${""?left_pad(indent)}}
<#--  ${""?left_pad(indent)}
${""?left_pad(indent)}onMounted(() => {
${""?left_pad(indent)}  init${typeId}()
${""?left_pad(indent)}})
${""?left_pad(indent)}
${""?left_pad(indent)}onBeforeUnmount(() => {
${""?left_pad(indent)}  clearTimeout(${varId}SaveTimer)
${""?left_pad(indent)}  clearTimeout(${varId}ToastTimer)
${""?left_pad(indent)}  ${varId}Quill = null
${""?left_pad(indent)}})  -->
</#macro>


<!----------------------------------------------------------------------------->
<!--                                  GANTT                                  -->
<!----------------------------------------------------------------------------->
<#macro print_gantt_variables gantt indent=0>
</#macro>

<#macro print_gantt_methods gantt indent=0>
</#macro>

<!----------------------------------------------------------------------------->
<!--                                HERO CARD                                -->
<!----------------------------------------------------------------------------->
<#macro print_hero_card_variables hero indent=0>
${""?left_pad(indent)}
${""?left_pad(indent)}// ${js.nameVariable(hero.id)}英雄卡片相关变量
${""?left_pad(indent)}const ${js.nameVariable(hero.id)}Data = reactive({
  <#list hero.children as input>
    <#if input.id??>
${""?left_pad(indent)}  ${js.nameVariable(input.id)}: ${guidbase4js.get_primitive_default_value(input)},
    </#if>
  </#list>
${""?left_pad(indent)}});
</#macro>

<#macro print_hero_card_methods hero indent=0>
  <#local url = valuebase.url(hero.value("data"))>
  <#local objname = url.resource>

/**
 * 加载【${hero.title!""}】只读表单数据的界面函数
 */
const load${js.nameType(hero.id)}Data = async () => {
  isLoading.value = true
  try {
    const data = await sdk.fetch${js.nameType(objname)}()
    Object.assign(${js.nameVariable(hero.id)}Data, data)
  } catch (error) {
    fb.error('发生错误', error)
  } finally {
    isLoading.value = false
  }
}
</#macro>

<!----------------------------------------------------------------------------->
<!--                                KPI CHART                                -->
<!----------------------------------------------------------------------------->
<#macro print_kpi_chart_variables kpi indent=0>
  <#local varPrefix = js.nameVariable(kpi.id)>
  <#local statusWidget = guidbase.has_child_widget(kpi, "status")?then(guidbase.get_child_from_tile(kpi, "status"), "")>
  <#local statusTheme = (statusWidget != "")?then(statusWidget.value("theme", "success"), "success")>
  <#local plotType = kpi.value("plot", "line")>
${""?left_pad(indent)}// 【${kpi.title!(kpi.value("title", "KPI指标"))}】卡片业务响应式数据
${""?left_pad(indent)}const ${varPrefix}Data = reactive({
<#list kpi.children as input>
  <#if input.id??>
${""?left_pad(indent)}  ${js.nameVariable(input.id)}: ${guidbase4js.get_primitive_default_value(input)},
  </#if>
</#list>
${""?left_pad(indent)}  trendType: '${statusTheme}',
<#if plotType == "bar">
${""?left_pad(indent)}  plotData: [2100, 3200, 2800, 4500, 3900, 5100, 5600] // 默认柱状走势数据
<#else>
${""?left_pad(indent)}  plotData: [68, 70, 72, 71, 75, 76, 78.4] // 默认折线走势数据
</#if>
${""?left_pad(indent)}});
</#macro>

<#macro print_kpi_chart_methods kpi indent=0>
  <#local typePrefix = js.nameType(kpi.id)>
  <#local varPrefix = js.nameVariable(kpi.id)>
  <#local hasUrl = kpi.value("data")??>

/**
 * 加载【${kpi.title!(kpi.value("title", "KPI指标"))}】业务数据
 */
const load${typePrefix}Data = async () => {
<#if false>
  <#local url = valuebase.url(kpi.value("data"))>
  <#local objname = url.resource>
  isLoading.value = true
  try {
    const data = await sdk.fetch${js.nameType(objname)}()
    Object.assign(${varPrefix}Data, data)
  } catch (error) {
    fb.error('获取【${kpi.title!(kpi.value("title", "KPI指标"))}】数据失败', error)
  } finally {
    isLoading.value = false
  }
<#else>
  // 无远程数据源绑定时，依据配置填充兜底与随机波动走势
  try {
  <#list kpi.children as input>
    <#if input.id?? && input.value("default")??>
    ${varPrefix}Data.${js.nameVariable(input.id)} = ${guidbase4js.get_primitive_default_value(input)}
    </#if>
  </#list>
    // 生成近7项带随机微弱波动的走势数据，驱动图表自然呈现
    const base = Number(${varPrefix}Data.value) || 100
    ${varPrefix}Data.plotData = Array.from({ length: 7 }, (_, i) => {
      const delta = (Math.random() - 0.45) * (base * 0.1)
      return Number((base * 0.85 + (i * (base * 0.025)) + delta).toFixed(1))
    })
  } catch (e) {
    console.warn('[KPI] 初始化本地默认数据异常:', e)
  }
</#if>
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
  <#if chart.value("plot") == "pie">
${""?left_pad(indent)}  createChart(${js.nameVariable(chart.id)}Data.value).pie().x('month').y('amount').sum().build()
  <#elseif chart.value("plot") == "line">
${""?left_pad(indent)}  createChart(${js.nameVariable(chart.id)}Data.value).line().x('month').split('category').y('amount').avg().build()
  <#elseif chart.value("plot") == "bar">
${""?left_pad(indent)}  createChart(${js.nameVariable(chart.id)}Data.value).bar().x('month').split('category').y('amount').sum().build()
  <#elseif chart.value("plot") == "stack">
${""?left_pad(indent)}  createChart(${js.nameVariable(chart.id)}Data.value).bar().x('month').split('category').y('amount').sum().stack().build()
  <#elseif chart.value("plot") == "heat">
${""?left_pad(indent)}  createChart(${js.nameVariable(chart.id)}Data.value).bar().x('month').split('category').y('amount').sum().stack().build()
  <#elseif chart.value("plot") == "scatter">
${""?left_pad(indent)}  createChart(${js.nameVariable(chart.id)}Data.value).bar().x('month').split('category').y('amount').sum().stack().build()
  </#if>
)
</#macro>

<#macro print_chart_methods chart indent=0>
  <#local url = valuebase.url(chart.value("data", chart.id))>
/**
 * 加载数据的界面函数
 */
const load${js.nameType(chart.id)}Rows = async (params, pageNumber, pageSize) => {
  try {
    const res = await sdk.fetch${js.nameType(inflector.pluralize(url.resource))}AsChartData(params, (pageNumber - 1) * pageSize, pageSize)
    ${js.nameVariable(chart.id)}Data.value = res.data
  } catch (error) {
    fb.error('发生错误', error)
  } 
}
</#macro>

<#macro print_chart_layout chart indent=0>
${""?left_pad(indent)}<div class="${namespace}-panel">
  <#if chart.title?? && chart.title != "">
${""?left_pad(indent)}  <div class="${namespace}-panel-head">${chart.title}</div>
  </#if>
${""?left_pad(indent)}  <${namespace}-chart :option="${js.nameVariable(chart.id)}Conf" height="320px" />
${""?left_pad(indent)}</div>
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
    <#elseif action.type.name() == "GOTO">
  navigateWithCrumb({
    label: '${button.title}',
    path: '/${action.path?replace("_","-")}',
    query: {
      id: row?.id,              
      code: row?.code
    },
    currentRoute: route
  })
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
  await nextTick()  
  await ${js.nameVariable(widget.id)}Ref.value?.refresh()
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
<#macro print_buttons_layout buttons indent=0>
  <#-- bnrlike 模式下，按钮在tab页的右侧 -->
  <#if buttons.ancestor("tabs")??>
    <#return>
  </#if>
${""?left_pad(indent)}<div class="${namespace}-form-footer">
${""?left_pad(indent)}  <div style="margin-left: auto;">
  <#list buttons.children as child>
<@print_widget_layout widget=child indent=indent+4 />
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
    <#elseif widget.type == "data_table">
import ${js.nameType(namespace)}Datatable from '@/components/${namespace}-datatable.vue'
    <#elseif widget.type == "fixed_table">
import ${js.nameType(namespace)}Fixedtable from '@/components/${namespace}-fixedtable.vue'
    <#elseif widget.type == "gantt_table">
import ${js.nameType(namespace)}Gantttable from '@/components/${namespace}-gantttable.vue' 
    <#elseif widget.type == "paged_grid">
import ${js.nameType(namespace)}Pagedgrid from '@/components/${namespace}-pagedgrid.vue'      
    <#elseif widget.type == "week_grid">
import ${js.nameType(namespace)}Weekgrid from '@/components/${namespace}-weekgrid.vue'
    <#elseif widget.type == "map_view">
import L from 'leaflet';
import 'leaflet/dist/leaflet.css';
import markerIcon2x from 'leaflet/dist/images/marker-icon-2x.png';
import markerIcon from 'leaflet/dist/images/marker-icon.png';
import markerShadow from 'leaflet/dist/images/marker-shadow.png';
    <#elseif widget.type == "bpmn_diagram">
import ${js.nameType(namespace)}Bpmndiagram from '@/components/${namespace}-bpmndiagram.vue' 
    <#elseif widget.type == "bpmn_editor">
import BpmnModeler from 'bpmn-js/lib/Modeler';
import BpmnViewer from 'bpmn-js/lib/NavigatedViewer';
import 'bpmn-js/dist/assets/diagram-js.css'
import 'bpmn-js/dist/assets/bpmn-js.css'
import 'bpmn-js/dist/assets/bpmn-font/css/bpmn.css'
    <#elseif widget.type == "rich_editor">
import Quill from 'quill'
import 'quill/dist/quill.snow.css'
    <#elseif widget.type == "kpi_chart">
import ${js.nameType(namespace)}Sparkline from '@/components/${namespace}-sparkline.vue' 
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
    <#if !action.type??><#continue></#if>
    <#if action.type.name() == "DRAWER" && !drawerImported>
      <#local drawerImported = true>
import ${js.nameType(namespace)}Drawer from '@/components/${namespace}-drawer.vue'  
    <#elseif action.type.name() == "DIALOG" && !dialogImported>   
      <#local dialogImported = true>
import ${js.nameType(namespace)}Dialog from '@/components/${namespace}-dialog.vue'       
    </#if>
  </#list>
  <#-- pages -->
  <#list page.widgets as widget>
    <#if widget.value("action") == ""><#continue></#if>
    <#local action = valuebase.action(widget.value("action"))>
    <#if action.type.name() == "DRAWER" || action.type.name() == "DIALOG">
      <#if visited_types[action.path]??><#continue></#if>
import ${js.nameType(namespace + "_" + action.resource)} from '@/pages/${js.nameFile(action.path)}.vue'
      <#local visited_types += {action.path: widget} />
    </#if>
  </#list>
</#macro>

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
    <#elseif widget.type == "bpmn_diagram">
<@print_bpmn_diagram_variables bpmn=widget indent=indent />
    <#elseif widget.type == "bpmn_editor">
<@print_bpmn_editor_variables bpmn=widget indent=indent />
    <#elseif widget.type == "rich_editor">
<@print_rich_editor_variables rich=widget indent=indent />
    <#elseif widget.type == "gantt">
<@print_gantt_variables gantt=widget indent=indent />
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
  <#-- 集中处理action定义 -->
  <#local visited_pages = {}>
  <#list page.widgets as widget>
    <#if widget.value("action") == ""><#continue></#if>
    <#local action = valuebase.action(widget.value("action"))>
    <#if action.type.name() == "DRAWER" || action.type.name() == "DIALOG">
      <#if visited_pages[action.path]??><#continue></#if>
${""?left_pad(indent)}const ${js.nameVariable(action.resource)}Open = ref(false) 
      <#local visited_pages += {action.path:widget}>
    </#if>
  </#list>
</#macro>

<#macro print_page_methods page indent=0>
  <#list page.widgets as widget>
    <#if widget.type == "tabs">
<@print_tabs_methods tabs=widget indent=indent />
    <#elseif widget.type == "entry_form">
<@print_entry_form_methods form=widget indent=indent />
    <#elseif widget.type == "official_form">
<@print_official_form_methods form=widget indent=indent />
    <#elseif widget.type == "display_form">
<@print_display_form_methods form=widget indent=indent />
    <#elseif widget.type == "excel_form">
<@print_excel_form_methods form=widget indent=indent />
    <#elseif widget.type == "paged_table">
<@print_paged_table_methods table=widget indent=indent />
    <#elseif widget.type == "data_table">
<@print_data_table_methods table=widget indent=indent />
    <#elseif widget.type == "fixed_table">
<@print_fixed_table_methods table=widget indent=indent />
    <#elseif widget.type == "paged_grid">
<@print_paged_grid_methods grid=widget indent=indent />
    <#elseif widget.type == "time_grid">
<@print_time_grid_methods grid=widget indent=indent />
    <#elseif widget.type == "list_view">
<@print_list_view_methods list=widget indent=indent />
    <#elseif widget.type == "map_view">
<@print_map_view_methods map=widget indent=indent />
    <#elseif widget.type == "hero_card">
<@print_hero_card_methods hero=widget indent=indent />
    <#elseif widget.type == "bpmn_diagram">
<@print_bpmn_diagram_methods bpmn=widget indent=indent />
    <#elseif widget.type == "bpmn_editor">
<@print_bpmn_editor_methods bpmn=widget indent=indent />
    <#elseif widget.type == "rich_editor">
<@print_rich_editor_methods rich=widget indent=indent />
    <#elseif widget.type == "kpi_chart">
<@print_kpi_chart_methods kpi=widget indent=indent />
    <#elseif widget.type == "chart">
<@print_chart_methods chart=widget indent=indent />
    <#elseif widget.type == "button">
<@print_button_methods button=widget indent=indent />
    </#if>
  </#list>
  <#list page.widgets as widget>
    <#if widget.type != "paged_table" && widget.type != "fixed_table"><#continue></#if>
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
    <#if action.type.name() == "DRAWER">
${""?left_pad(indent)}<${namespace}-drawer v-model="${js.nameVariable(action.resource)}Open" title="" size="lg">  
${""?left_pad(indent)}  <${namespace}-${action.resource?replace("_","-")} />
${""?left_pad(indent)}</${namespace}-drawer>
    <#elseif action.type.name() == "DIALOG">
${""?left_pad(indent)}<${namespace}-dialog v-model="${js.nameVariable(action.resource)}Open" title="" size="lg">  
${""?left_pad(indent)}  <${namespace}-${action.resource?replace("_","-")} />
${""?left_pad(indent)}</${namespace}-dialog>
    </#if>
  </#list>
</#macro>
