<#function get_button_role button>
  <#if (button.value("action")!"") == "save">
    <#return "primary">
  <#elseif (button.value("action")!"") == "search">
    <#return "primary">  
  <#elseif (button.value("action")!"") == "edit">
    <#return "primary">    
  <#elseif (button.value("action")!"") == "clear">
    <#return "warning">
  <#elseif (button.value("action")!"") == "reset">
    <#return "warning">  
  <#elseif (button.value("action")!"") == "delete">
    <#return "danger">  
  <#elseif (button.value("action")!"") == "cancel">
    <#return "default">
  <#else>
    <#return "default">
  </#if>
</#function>

<#function get_button_method_name button>
  <#local methodName = "handle">
  <#if button.ancestor("entry_form")??>
    <#local ancestor = button.ancestor("entry_form")>
  <#elseif button.ancestor("criteria_form")??>
    <#local ancestor = button.ancestor("criteria_form")>
  <#elseif button.ancestor("paged_table")??>
    <#local ancestor = button.ancestor("paged_table")>  
  <#elseif button.ancestor("paged_grid")??>
    <#local ancestor = button.ancestor("paged_grid")>    
  </#if>
  <#if methodName == "handle">
    <#if ancestor??>
      <#local methodName += js.nameType(ancestor.id)>
    <#else>
      <#local methodName += js.nameType(button.value("ref"))>
      <#local ancestor = button.page.byId(button.value("ref"))>
    </#if>
  </#if>
  <#if button.id??>
    <#local methodName += js.nameType(button.id)>
  <#else>
    <#local methodName += (js.nameType(button.value("action", "custom")))>  
  </#if>
  <#return methodName>
</#function>

<#function get_input_model_name input>
  <#if input.container.type == "criteria_form">
    <#return js.nameVariable(input.container.id) + "Crit." + js.nameVariable(input.id)>
  <#else>
    <#return js.nameVariable(input.container.id) + "Data." + js.nameVariable(input.id)>
  </#if>
</#function>

<#function is_ref_or_ancestor widget typename>
  <#if widget.ancestor(typename)??>
    <#return true>
  </#if>
  <#if widget.page.byId(widget.value("ref"))??>
    <#local ref = widget.page.byId(widget.value("ref"))>
    <#if ref.type == typename>
      <#return true>
    </#if>
  </#if>
  <#return false>
</#function>
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

<#macro print_layout_tabs tabs indent=0>
${""?left_pad(indent)}<div class="${namespace}-tabs">
${""?left_pad(indent)}  <div v-for="tab in tabs${js.nameType(tabs.id)}" :key="tab.key"
${""?left_pad(indent)}       class="${namespace}-tab"
${""?left_pad(indent)}       :class="{ '${namespace}-active': activeTab${js.nameType(tabs.id)} === tab.key }"
${""?left_pad(indent)}       @click="activeTab${js.nameType(tabs.id)} = tab.key">
${""?left_pad(indent)}    <span>{{ tab.label }}</span>
${""?left_pad(indent)}    <span v-if="tab.badge" class="${namespace}-tab-badge">{{ tab.badge }}</span>
${""?left_pad(indent)}  </div>
  <#if tabs.contains("buttons")>
    <#local buttons = tabs.byType("buttons")[0]>
${""?left_pad(indent)}  <div class="${namespace}-tabs-right" v-show="activeTab${js.nameType(tabs.id)} === '${js.nameVariable(buttons.container.id)}'">
    <#list buttons.children as button>
<@print_layout_widget widget=button indent=indent+4 />
    </#list>
${""?left_pad(indent)}  </div>
  </#if>
${""?left_pad(indent)}</div>
${""?left_pad(indent)}<div class="${namespace}-tabs-content" ref="${js.nameVariable(tabs.id)}Ref">
  <#list tabs.children as tab>
${""?left_pad(indent)}  <div v-show="activeTab${js.nameType(tabs.id)} === '${js.nameVariable(tab.id)}'" :style="{ height: ${js.nameType(tabs.id)}Height + 'px' }">
    <#if tab.children?size == 0>
${""?left_pad(indent)}    ${tab.title}
    <#else>
      <#list tab.children as child>
<@print_layout_widget widget=child indent=indent+4 />
      </#list>
    </#if>
${""?left_pad(indent)}  </div>
  </#list>
${""?left_pad(indent)}</div>
</#macro>

<!----------------------------------------------------------------------------->
<!--                                ENTRY FORM                               -->
<!----------------------------------------------------------------------------->
<#macro print_entry_form_variables form indent=0>
${""?left_pad(indent)}// ${js.nameVariable(form.id)}表单校验规则
const ${js.nameVariable(form.id)}Rules = [
  <#list form.inputs as input>  
    <#if input.value("readonly") == "true"><#continue></#if>
  {name: '${js.nameVariable(input.id)}',rules: [<#if input.value("required") == "true">{ type: 'required', message: '${input.title}必须填写！' },</#if><#if input.type == "number">{ type: 'number', message: '请正确输入${input.title}！' }</#if>]},
  </#list>
]
const { errors, validate, clearErrors } = useFieldValidation(${js.nameVariable(form.id)}Rules)
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
const ${js.nameVariable(form.id)}Error = ref(false)
const validationErrorMessage = ref('')
</#macro>

<#macro print_entry_form_methods form indent=0>
  <#local objname = form.value("object", form.id)>
/**
 * 加载数据的界面函数
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

/**
 * 保存数据的界面函数
 */
const save${js.nameType(form.id)}Data = async () => {
  if (!validate(demoEntryData)) {
    const msgs = Object.entries(errors)
      .filter(([, msg]) => msg)
      .map(([, msg]) => `· ${r"${msg}"}`)
    validationErrorMessage.value = msgs.join('\n')
    ${js.nameVariable(form.id)}ErrorShow.value = true
    return
  }
  isSubmitting.value = true
  try {
    const result = await sdk.save${js.nameType(form.value("object",form.id))}(${js.nameVariable(form.id)}Data)
    if (result.success) {
      fb.success('成功', '保存成功');
    }
  } catch (error) {
    fb.error('发生错误', error)
  } finally {
    isSubmitting.value = false
  }
}

const { loading: isSubmitting, run: handle${js.nameType(form.id)}Save } = useAsyncLock(save${js.nameType(form.id)}Data)
</#macro>

<#macro print_layout_entry_form form indent=0>
  <#local cols = form.value("cols")!"3">
  <#local groups = form.groups()>
${""?left_pad(indent)}<div id="entry${js.nameType(form.id)}">
  <#list groups as group>
    <#local rows = form.rows(group, cols?number)>
${""?left_pad(indent)}  <div class="${namespace}-panel">
${""?left_pad(indent)}    <div class="${namespace}-panel-head">${group}</div>
${""?left_pad(indent)}    <div class="${namespace}-form ${namespace}-form--${cols}">
    <#list rows as row>
      <#list row as child>
${""?left_pad(indent)}      <div class="${namespace}-field<#if child.value("span")??> ${namespace}-field--span${child.value("span")}</#if>">
${""?left_pad(indent)}        <label class="${namespace}-field-label<#if (child.value("required")!"") == "true"> ${namespace}-field-label--required</#if>">${child.title}</label>
<@print_layout_widget widget=child indent=indent+8 />
${""?left_pad(indent)}      </div>
      </#list>
    </#list>
${""?left_pad(indent)}    </div>    
${""?left_pad(indent)}  </div>  
  </#list>
${""?left_pad(indent)}</div>
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
const { errors, validate, clearErrors } = useFieldValidation(${js.nameVariable(form.id)}Rules)
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
const validationErrorMessage = ref('')
</#macro>

<#macro print_layout_official_form form indent>
  <#local cols = form.value("cols")!"3">
  <#local groups = form.groups()>
${""?left_pad(indent)}<div class="${namespace}-of">
${""?left_pad(indent)}  <div ref="${js.nameVariable(form.id)}Ref" class="${namespace}-of__container">
${""?left_pad(indent)}    <div class="${namespace}-of__header">
${""?left_pad(indent)}      <h1>${form.title}</h1>
${""?left_pad(indent)}      <div class="${namespace}-of__meta">
${""?left_pad(indent)}        <span>机密程度：{{ confidentialLevel }}</span>
${""?left_pad(indent)}        <span>流程编号：{{ flowNo }}</span>
${""?left_pad(indent)}        <span>申请日期：{{ applyDate }}</span>
${""?left_pad(indent)}      </div>
${""?left_pad(indent)}    </div>
${""?left_pad(indent)}
${""?left_pad(indent)}    <table class="${namespace}-of__table">
  <#list groups as group>
    <#local rows = form.rows(group, cols?number)>
    <#list rows as row>
${""?left_pad(indent)}      <tr>
      <#list row as child>
${""?left_pad(indent)}        <td class="${namespace}-of__label<#if child.value("required","") == "true"> ${namespace}-of__required</#if>">${child.title}</td>
${""?left_pad(indent)}        <td colspan="${child.value("span","1")?number * 2 - 1}">
          <#if child.type == "date">
${""?left_pad(indent)}          <${namespace}-datepicker data-test="${js.nameVariable(child.id)}" v-model="${js.nameVariable(form.id)}Data.${js.nameVariable(child.id)}" plain />
          <#elseif child.type == "select">
            <#if (child.value("data")!"")?starts_with("enum[")>
${""?left_pad(indent)}<${namespace}-dropdown data-test="${js.nameVariable(child.id)}" :options="sdk.${js.nameVariable(child.id)}Options" :clearable="true" v-model="${js.nameVariable(child.container.id)}Data.${js.nameVariable(child.id)}" plain />    
            <#else>
${""?left_pad(indent)}<${namespace}-dropdown data-test="${js.nameVariable(child.id)}" :options="${js.nameVariable(child.id)}Options"  :clearable="true" v-model="${js.nameVariable(child.container.id)}Data.${js.nameVariable(child.id)}" plain />
            </#if>
          <#elseif child.type == "multiselect">
${""?left_pad(indent)}<${namespace}-multiselect data-test="${js.nameVariable(child.id)}" :options="${js.nameVariable(child.id)}Options" v-model="${js.nameVariable(child.container.id)}Data.${js.nameVariable(child.id)}" plain />      
          <#elseif child.type == "tags">
${""?left_pad(indent)}<${namespace}-tagsinput data-test="${js.nameVariable(child.id)}" v-model="${js.nameVariable(child.container.id)}Data.${js.nameVariable(child.id)}" plain />      
          <#elseif child.type == "longtext">
${""?left_pad(indent)}          <textarea
${""?left_pad(indent)}            class="${namespace}-of__textarea"
${""?left_pad(indent)}            :class="{ '${namespace}-of__readonly': readonly }"
${""?left_pad(indent)}            :placeholder="${child.value("placeholder", "请填写" + child.title)}"
${""?left_pad(indent)}            :value="${js.nameVariable(form.id)}Data.${js.nameVariable(child.id)}"
${""?left_pad(indent)}            :readonly="readonly || ${child.value("readonly","false")}"
${""?left_pad(indent)}            @input=""></textarea>      
          <#else>
${""?left_pad(indent)}          <input type="text"
${""?left_pad(indent)}            class="${namespace}-of__input"
${""?left_pad(indent)}            :class="{ '${namespace}-of__readonly': readonly  || ${child.value("readonly","false")} }"
${""?left_pad(indent)}            :value="${js.nameVariable(form.id)}Data.${js.nameVariable(child.id)}"
${""?left_pad(indent)}            :readonly="readonly || ${child.value("readonly","false")}"
${""?left_pad(indent)}            @input="">              
          </#if>
${""?left_pad(indent)}        </td>
      </#list>
${""?left_pad(indent)}      </tr>
    </#list>
  </#list>
${""?left_pad(indent)}    </table>
${""?left_pad(indent)}  </div>
${""?left_pad(indent)}</div>
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

<#macro print_layout_criteria_form form indent=0>
${""?left_pad(indent)}<div id="criteria${js.nameType(form.id)}" class="${namespace}-toolbar">
  <#list form.children as widget>
<@print_layout_widget widget=widget indent=indent+2 />
  </#list>
${""?left_pad(indent)}</div>
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

/**
 * 加载数据的界面函数
 */
const load${js.nameType(form.id)}Data = async () => {
  isLoading.value = true
  try {
    const data = await sdk.fetch${js.nameType(form.id)}Data()
    Object.assign(${js.nameVariable(form.id)}Data, data)
  } catch (error) {
    fb.error('发生错误', error)
  } finally {
    isLoading.value = false
  }
}
</#macro>

<#macro print_layout_display_form form indent=0>
  <#list form.groups() as group>
${""?left_pad(indent)}<div class="${namespace}-panel">
${""?left_pad(indent)}  <div class="${namespace}-panel-head">${group}</div>
${""?left_pad(indent)}  <div class="${namespace}-fview ${namespace}-fview--${form.value("cols","3")}">
  <#list form.group(group) as input>
    <#local span = input.value("span","")>
${""?left_pad(indent)}    <div class="${namespace}-fv<#if span != ""> ${namespace}-fv--span${span}</#if>">
${""?left_pad(indent)}      <div class="${namespace}-fv-label">${input.title}</div>
${""?left_pad(indent)}      <div class="${namespace}-fv-val ${namespace}-fv-val--mono">{{ ${js.nameVariable(form.id)}Data.${js.nameVariable(input.id)} }}</div>
${""?left_pad(indent)}    </div>
  </#list>
${""?left_pad(indent)}  </div>
${""?left_pad(indent)}</div>
  </#list>
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
  <#local objname = table.value("object",table.id)>

/**
 * 加载数据的界面函数
 */
const load${js.nameType(table.id)}Rows = async (params, pageNumber, pageSize) => {
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
  <#local objname = table.value("object",table.id)>

/**
 * 加载数据的界面函数
 */
const load${js.nameType(table.id)}Rows = async (params, pageNumber, pageSize) => {
  isLoading.value = true
  try {
    const res = await sdk.fetch${js.nameType(inflector.pluralize(objname))}(params, (pageNumber - 1) * pageSize, pageSize)
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

${""?left_pad(indent)}// ${js.nameVariable(grid.id)}分页表格相关变量
${""?left_pad(indent)}const ${js.nameVariable(grid.id)}Ref = ref(null)
</#macro>

<#macro print_paged_grid_methods grid indent=0>
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

<#macro print_layout_paged_grid grid indent=0>
${""?left_pad(indent)}<${namespace}-pagedgrid
${""?left_pad(indent)}  ref="${js.nameVariable(grid.id)}Ref"
${""?left_pad(indent)}  style="flex:1"
${""?left_pad(indent)}  id-key="${js.nameVariable(grid.value("object","object"))}Id"
${""?left_pad(indent)}  :fetch-data="load${js.nameType(grid.id)}Rows"
${""?left_pad(indent)}  :fetch-params="${js.nameVariable(grid.value("object", grid.id))}Crit">
${""?left_pad(indent)}  <template #default="{ row, index }">
${""?left_pad(indent)}  </template>
${""?left_pad(indent)}</${namespace}-pagedgrid>
</#macro>

<!----------------------------------------------------------------------------->
<!--                                  CHART                                  -->
<!----------------------------------------------------------------------------->
<#macro print_chart_variables chart indent=0>

${""?left_pad(indent)}// 【${chart.title!chart.id}】数据变量和图标设置
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
<#macro print_paged_button_methods button indent=0>
  <#if (button.value("action")!"") == "save">
    <#return>
  </#if>
  <#-- ref优先 -->
  <#if button.page.byId(button.value("ref"))??>
    <#local ancestor = button.page.byId(button.value("ref"))>
  <#elseif button.ancestor("entry_form")??>
    <#local ancestor = button.ancestor("entry_form")>
  <#elseif button.ancestor("criteria_form")??>
    <#local ancestor = button.ancestor("criteria_form")>
  <#elseif button.ancestor("paged_table")??>
    <#local ancestor = button.ancestor("paged_table")>  
  </#if>

  <#if button.ancestor("paged_table")??>
const ${get_button_method_name(button)} = async (row) => {    
    <#if (button.value("action","")) == "edit"><#-- 编辑 -->
  ${js.nameVariable(button.value("ref"))}DialogOpen.value = true  
    <#elseif (button.value("action","")) == "view"><#-- 查看 -->
  ${js.nameVariable(button.value("ref"))}DrawerOpen.value = true
    <#elseif (button.value("action","")) == "delete"><#-- 删除 -->
  const ok = await fb.confirm('询问', '确定要删除该条数据？')
  if (!ok) return;  
    </#if>
  <#else>
const ${get_button_method_name(button)} = async () => {    
    <#if (button.value("action","")) == "reset" && is_ref_or_ancestor(button, "entry_form")><#-- 重置 -->
  const ok = await fb.confirm('询问', '确定要清空表单数据？')
  if (!ok) return;
      <#list ancestor.inputs as input>
  ${get_input_model_name(input)} = '';
      </#list>
    <#elseif (button.value("action","")) == "search"><#-- 重置 -->
  ${js.nameVariable(button.value("ref"))}Ref.value?.refresh()
    <#elseif (button.value("action","")) == "save"><#-- 保存 -->
    </#if>
  </#if>
}
</#macro>

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
    <#if widget.value("viewport","") == "drawer">
import ${js.nameType(namespace)}Drawer from '@/components/${namespace}-drawer.vue'
      <#break>
    </#if>
  </#list>  
  <#list page.widgets as widget>
    <#if widget.value("viewport","") == "dialog">
import ${js.nameType(namespace)}Dialog from '@/components/${namespace}-dialog.vue'
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
    <#elseif widget.type == "tags">
import ${js.nameType(namespace)}Tagsinput from '@/components/${namespace}-tagsinput.vue' 
    </#if>
    <#local visited_types += {widget.type: widget} />
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
    <#elseif widget.type == "chart">
<@print_chart_variables chart=widget indent=indent />
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
    <#elseif widget.type == "chart">
<@print_chart_methods chart=widget indent=indent />
    <#elseif widget.type == 'button'>
<@print_paged_button_methods button=widget indent=indent />
    </#if>
  </#list>
  <#list page.widgets as widget>
    <#if widget.value("viewport","") == "drawer">
${""?left_pad(indent)}const ${js.nameVariable(widget.id)}DrawerOpen = ref(false)      
    <#elseif (widget.value("viewport","") == "dialog")>
${""?left_pad(indent)}const ${js.nameVariable(widget.id)}DialogOpen = ref(false)             
    </#if>
  </#list>
  <#list page.widgets as widget>
    <#if widget.type != "paged_table"><#continue></#if>
const ${js.nameVariable(widget.id)}RowActionHandlers = { 
    <#list widget.widgets as button>     
      <#if button.type != "button"><#continue></#if>
  ${get_button_method_name(button)}, 
    </#list>
}
const handle${js.nameType(widget.id)}RowAction = ({ handler, row, index }) => {
  ${js.nameVariable(widget.id)}RowActionHandlers[handler]?.(row, index)
}    
  </#list>

</#macro>

<#macro print_page_layout page indent=0>
  <#list page.children as child>
    <#if (child.type == "paged_table" || child.type == "entry_form" || child.type == "criteria_form") &&
         child.value("viewport","") == "">
<@print_layout_container widget=child indent=indent />       
    <#else>
<@print_layout_widget widget=child indent=indent />        
    </#if>
  </#list>
</#macro>

<#macro print_layout_widget widget indent=0>
  <#if widget.value("viewport","") == "dialog">
    <#local indent += 2>
${""?left_pad(indent)}<${namespace}-dialog v-model="${js.nameVariable(widget.id)}DialogOpen" title="${widget.title}" size="lg">
  <#elseif widget.value("viewport","") == "drawer">
    <#local indent += 2>
${""?left_pad(indent)}<${namespace}-drawer v-model="${js.nameVariable(widget.id)}DrawerOpen" title="${widget.title}">
  </#if>
  <#if widget.type == "tabs">
<@print_layout_tabs tabs=widget indent=indent+2 />
  <#elseif widget.type == "entry_form">
<@print_layout_entry_form form=widget indent=indent+2 />    
  <#elseif widget.type == "official_form">
<@print_layout_official_form form=widget indent=indent+2 />   
  <#elseif widget.type == "excel_form">
<@print_layout_excel_form form=widget indent=indent+2 />      
  <#elseif widget.type == "paged_table">
<@print_layout_paged_table table=widget indent=indent+2 />
  <#elseif widget.type == "fixed_table">
<@print_layout_fixed_table table=widget indent=indent+2 />
  <#elseif widget.type == "criteria_form">
<@print_layout_criteria_form form=widget indent=indent+2 />
  <#elseif widget.type == "display_form">
<@print_layout_display_form form=widget indent=indent+2 />
  <#elseif widget.type == "paged_grid">
<@print_layout_paged_grid grid=widget indent=indent+2 />
  <#elseif widget.type == "chart">
<@print_layout_chart chart=widget indent=indent+2 />
  <#elseif widget.type == "buttons">
<@print_layout_buttons buttons=widget indent=indent+2 />
  <#elseif widget.type == "select">
    <#if (widget.value("data")!"")?starts_with("enum[")>
${""?left_pad(indent)}<${namespace}-dropdown data-test="${js.nameVariable(widget.id)}" :options="sdk.${js.nameVariable(widget.id)}Options" :clearable="true" v-model="${get_input_model_name(widget)}" />    
    <#else>
${""?left_pad(indent)}<${namespace}-dropdown data-test="${js.nameVariable(widget.id)}" :options="${js.nameVariable(widget.id)}Options"  :clearable="true" v-model="${get_input_model_name(widget)}" />
    </#if>
  <#elseif widget.type == "date">
${""?left_pad(indent)}<${namespace}-datepicker data-test="${js.nameVariable(widget.id)}" v-model="${get_input_model_name(widget)}" />    
  <#elseif widget.type == "time">
${""?left_pad(indent)}<${namespace}-timepicker data-test="${js.nameVariable(widget.id)}" v-model="${get_input_model_name(widget)}" />
  <#elseif widget.type == "cascade">
${""?left_pad(indent)}<${namespace}-cascadepicker data-test="${js.nameVariable(widget.id)}" :fetch-options="sdk.fetch${js.nameType(widget.value("object",widget.id))}AsOptions" v-model="${get_input_model_name(widget)}" />
  <#elseif widget.type == "multiselect">
${""?left_pad(indent)}<${namespace}-multiselect data-test="${js.nameVariable(widget.id)}" :options="${js.nameVariable(widget.id)}Options" v-model="${get_input_model_name(widget)}" />
  <#elseif widget.type == "tags">
${""?left_pad(indent)}<${namespace}-tagsinput data-test="${js.nameVariable(widget.id)}" v-model="${get_input_model_name(widget)}" />
  <#else><#-- 各个Design System的个性化风格 -->
<@print_layout_custom widget=widget indent=indent+2 />  
  </#if>
  <#if widget.value("viewport","") == "dialog">
${""?left_pad(indent)}</${namespace}-dialog>
  <#elseif widget.value("viewport","") == "drawer">
${""?left_pad(indent)}</${namespace}-drawer>  
  </#if>
</#macro>