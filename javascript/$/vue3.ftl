<!----------------------------------------------------------------------------->
<!--                                ENTRY FORM                               -->
<!----------------------------------------------------------------------------->
<#macro print_entry_form_variables form indent=0>
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
    <#elseif input.type == "cascade">
${""?left_pad(indent)}const ${js.nameVariable(input.id)}Options = ref([])
    </#if>
  </#list>
</#macro>

<#macro print_entry_form_methods form indent=0>
/**
 * 加载数据的界面函数
 */
const load${js.nameType(form.id)}Data = async () => {
  isLoading.value = true
  try {
    const data = await fetchUserDataApi()
    Object.assign(${js.nameVariable(form.id)}Data, data)
  } catch (error) {
    // TODO: 这里可以添加错误处理逻辑，例如显示错误消息
  } finally {
    isLoading.value = false
  }
}

/**
 * 保存数据的界面函数
 */
const save${js.nameType(form.id)}Data = async () => {
  isSubmitting.value = true
  try {
    const result = await saveUserDataApi(${js.nameVariable(form.id)}Data)
    if (result.success) {
      alert('用户信息保存成功！')
    }
  } catch (error) {
    // TODO: 这里可以添加错误处理逻辑，例如显示错误消息
  } finally {
    isSubmitting.value = false
  }
}

const { loading: isSubmitting, run: handleSubmit } = useAsyncLock(save${js.nameType(form.id)}Data)
</#macro>

<#macro print_layout_entry_form widget indent=0>
  <#local cols = widget.value("cols")!"3">
  <#local groups = widget.groups()>
${""?left_pad(indent)}<div id="form${js.nameType(widget.id)}">
  <#list groups as group>
    <#local rows = widget.rows(group, cols?number)>
${""?left_pad(indent)}  <div class="${namespace}-panel">
${""?left_pad(indent)}    <div class="${namespace}-panel-head">${group}</div>
${""?left_pad(indent)}    <div class="${namespace}-form ${namespace}-form--${cols}">
    <#list rows as row>
      <#list row as child>
${""?left_pad(indent)}      <div class="${namespace}-field<#if child.value("span")??> ${namespace}-field--span${child.value("span")}</#if>">
${""?left_pad(indent)}        <label class="${namespace}-field-label">${child.title}</label>
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
<!--                               PAGED TABLE                               -->
<!----------------------------------------------------------------------------->
<#macro print_paged_table_variables table indent=0>
${""?left_pad(indent)}// ${js.nameVariable(table.id)}表格相关变量
${""?left_pad(indent)}const ${js.nameVariable(table.id)}Ref = ref(null)
${""?left_pad(indent)}const ${js.nameVariable(table.id)}Cols = ref([{
  <#list table.children as column>
    <#if column?index != 0>
${""?left_pad(indent)}},{    
    </#if>
${""?left_pad(indent)}  key:'${js.nameVariable(column.id)}',
${""?left_pad(indent)}  title:'${column.title}',      
${""?left_pad(indent)}  width:'${column.value("width")!"100"}px', 
${""?left_pad(indent)}  render: v => `<span style="font-family:Consolas,monospace;color:#5d6d7e">${r"${v}"}</span>`,
  </#list>
${""?left_pad(indent)}}])
${""?left_pad(indent)}const ${js.nameVariable(table.id)}Rows = ref([])
</#macro>

<#macro print_paged_table_methods table indent=0>

/**
 * 加载数据的界面函数
 */
const load${js.nameType(table.id)}Rows = async () => {
  isLoading.value = true
  try {
    const data = await fetchUserDataApi()
  } catch (error) {
    // TODO: 这里可以添加错误处理逻辑，例如显示错误消息
  } finally {
    isLoading.value = false
  }
}
</#macro>

<#macro print_layout_paged_table widget indent=0>
${""?left_pad(indent)}<${namespace}-pagedtable
${""?left_pad(indent)}  ref="${js.nameVariable(widget.id)}Ref"
${""?left_pad(indent)}  style="flex:1"
${""?left_pad(indent)}  :data="filteredData"
${""?left_pad(indent)}  :columns="${js.nameVariable(widget.id)}Cols"
${""?left_pad(indent)}  id-key="personId"
${""?left_pad(indent)}  :row-class-name="getRowClass"
${""?left_pad(indent)}  @selection-change="handleSelection" />
</#macro>

<!----------------------------------------------------------------------------->
<!--                                   PAGE                                  -->
<!----------------------------------------------------------------------------->

<#macro print_page_variables page indent=0>
  <#list page.widgets as widget>
    <#if widget.type == 'entry_form'>
<@print_entry_form_variables form=widget indent=indent />
    <#elseif widget.type == 'paged_table'>
<@print_paged_table_variables table=widget indent=indent />
    </#if>
  </#list>
</#macro>

<#macro print_page_methods page indent=0>
  <#list page.widgets as widget>
    <#if widget.type == 'entry_form'>
<@print_entry_form_methods form=widget indent=indent />
    <#elseif widget.type == 'paged_table'>
<@print_paged_table_methods table=widget indent=indent />
    </#if>
  </#list>
</#macro>

<#macro print_page_imports page indent=0>
  <#local visited_types = {}>
  <#list page.widgets as widget>
    <#if visited_types[widget.type]??><#continue></#if>
    <#if widget.type == 'entry_form'>
import { useAsyncLock } from '@/composables/useAsyncLock'
    <#elseif widget.type == "paged_table">
import ${js.nameType(namespace)}Pagedtable from '@/components/${namespace}-pagedtable.vue'
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

<#macro print_page_layout page indent=0>
  <#list page.children as child>
<@print_layout_widget widget=child indent=indent />
  </#list>
</#macro>

<#macro print_layout_widget widget indent=0>
  <#if widget.type == "entry_form">
<@print_layout_entry_form widget=widget indent=indent+2 />    
  <#elseif widget.type == "view_form">
  <#elseif widget.type == "paged_table">
<@print_layout_paged_table widget=widget indent=indent+2 />    
  <#elseif widget.type == "buttons">
<@print_layout_buttons widget=widget indent=indent+2 />  
  <#elseif widget.type == "select">
    <#if (widget.value("data")!"")?starts_with("enum[")>
${""?left_pad(indent)}<${namespace}-dropdown data-test="${js.nameVariable(widget.id)}" :options="sdk.${js.nameVariable(widget.id)}Options" v-model="${js.nameVariable(widget.container.id)}Data.${js.nameVariable(widget.id)}" />    
    <#else>
${""?left_pad(indent)}<${namespace}-dropdown data-test="${js.nameVariable(widget.id)}" :options="${js.nameVariable(widget.id)}Options" v-model="${js.nameVariable(widget.container.id)}Data.${js.nameVariable(widget.id)}" />
    </#if>
  <#elseif widget.type == "date">
${""?left_pad(indent)}<${namespace}-datepicker data-test="${js.nameVariable(widget.id)}" v-model="${js.nameVariable(widget.container.id)}Data.${js.nameVariable(widget.id)}" />    
  <#elseif widget.type == "time">
${""?left_pad(indent)}<${namespace}-timepicker data-test="${js.nameVariable(widget.id)}" v-model="${js.nameVariable(widget.container.id)}Data.${js.nameVariable(widget.id)}" />
  <#elseif widget.type == "cascade">
${""?left_pad(indent)}<${namespace}-cascadepicker data-test="${js.nameVariable(widget.id)}" :options="${js.nameVariable(widget.id)}Options" v-model="${js.nameVariable(widget.container.id)}Data.${js.nameVariable(widget.id)}" />
  <#elseif widget.type == "multiselect">
${""?left_pad(indent)}<${namespace}-multiselect data-test="${js.nameVariable(widget.id)}" :options="${js.nameVariable(widget.id)}Options" v-model="${js.nameVariable(widget.container.id)}Data.${js.nameVariable(widget.id)}" />
  <#elseif widget.type == "tags">
${""?left_pad(indent)}<${namespace}-tagsinput data-test="${js.nameVariable(widget.id)}" v-model="${js.nameVariable(widget.container.id)}Data.${js.nameVariable(widget.id)}" />
  <#elseif widget.type == "longtext">
${""?left_pad(indent)}<textarea class="${namespace}-textarea" data-test="${js.nameVariable(widget.id)}" placeholder="请输入${widget.title}"></textarea>  
  <#elseif widget.type == "text">
${""?left_pad(indent)}<input class="${namespace}-input" data-test="${js.nameVariable(widget.id)}" 
${""?left_pad(indent)}       v-model="${js.nameVariable(widget.container.id)}Data.${js.nameVariable(widget.id)}" 
    <#if (widget.value("readonly")!"") == "true">
${""?left_pad(indent)}       :class="{ '${namespace}-input--readonly': true }" :disabled="true">
    <#else>
${""?left_pad(indent)}       placeholder="请输入${widget.title}">
    </#if>
  <#elseif widget.type == "number">
${""?left_pad(indent)}<input class="${namespace}-input" data-test="${js.nameVariable(widget.id)}" 
${""?left_pad(indent)}       v-model="${js.nameVariable(widget.container.id)}Data.${js.nameVariable(widget.id)}" 
    <#if (widget.value("readonly")!"") == "true">
${""?left_pad(indent)}       :class="{ '${namespace}-input--readonly': true }" :disabled="true">
    <#else>
${""?left_pad(indent)}       placeholder="请输入${widget.title}">
    </#if>
  </#if>
  <#if widget.value("unit")??>
${""?left_pad(indent)}<span class="${namespace}-field-unit">${widget.value("unit")}</span>
  </#if>
</#macro>

<#macro print_layout_buttons widget indent=0>
${""?left_pad(indent)}<div class="${namespace}-form-footer">
${""?left_pad(indent)}  <div style="margin-left: auto;">
  <#list widget.children as child>
    <#if (child.value("action")!"") == "save">
${""?left_pad(indent)}    <button class="${namespace}-btn ${namespace}-btn--primary ${namespace}-btn-gap" @click="">${child.title}</button>
    <#elseif (child.value("action")!"") == "clear">
${""?left_pad(indent)}    <button class="${namespace}-btn ${namespace}-btn--danger ${namespace}-btn-gap" @click="">${child.title}</button>    
    <#elseif (child.value("action")!"") == "cancel">
${""?left_pad(indent)}    <button class="${namespace}-btn ${namespace}-btn--default ${namespace}-btn-gap" @click="">${child.title}</button>
    <#else>
${""?left_pad(indent)}    <button class="${namespace}-btn ${namespace}-btn--default ${namespace}-btn-gap" @click="">${child.title}</button>
    </#if>
  </#list>    
${""?left_pad(indent)}  </div>
${""?left_pad(indent)}</div>
</#macro>