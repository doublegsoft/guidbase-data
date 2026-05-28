<#macro print_entry_form_variables form indent=0>
${""?left_pad(indent)}const ${js.nameVariable(form.id)}Data = reactive({
  <#list form.inputs as input>
${""?left_pad(indent)}  ${js.nameVariable(input.id)}: ${guidbase4js.get_primitive_default_value(input)},
  </#list>
${""?left_pad(indent)}});
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

<#macro print_page_variables page indent=0>
  <#list page.widgets as widget>
    <#if widget.type == 'entry_form'>
<@print_entry_form_variables form=widget indent=indent />
    </#if>
  </#list>
</#macro>

<#macro print_page_methods page indent=0>
  <#list page.widgets as widget>
    <#if widget.type == 'entry_form'>
<@print_entry_form_methods form=widget indent=indent />
    </#if>
  </#list>
</#macro>

<#macro print_page_imports page indent=0>
  <#local visited_types = {}>
  <#list page.widgets as widget>
    <#if visited_types[widget.type]??><#continue></#if>
    <#if widget.type == 'entry_form'>
import { useAsyncLock } from '@/composables/useAsyncLock'
    <#elseif widget.type == "select" && !widget.readonly>
import ${js.nameType(namespace)}Dropdown from '@/components/${namespace}-dropdown.vue'  
    <#elseif widget.type == "date" && !widget.readonly>
import ${js.nameType(namespace)}Datepicker from '@/components/${namespace}-datepicker.vue'  
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
  <#elseif widget.type == "group">
<@print_layout_group widget=widget indent=indent+2 />
  <#elseif widget.type == "select" && !widget.readonly>
${""?left_pad(indent)}<${namespace}-dropdown />
  <#elseif widget.type == "date" && !widget.readonly>
${""?left_pad(indent)}<${namespace}-datepicker />    
  <#elseif widget.type == "date" && !widget.readonly>
${""?left_pad(indent)}<${namespace}-datepicker />    
  <#else>
${""?left_pad(indent)}<input class="${namespace}-input" placeholder="请输入${widget.title}">
  </#if>
</#macro>

<#macro print_layout_entry_form widget indent=0>
${""?left_pad(indent)}<div id="form${js.nameType(widget.id)}">
  <#list widget.children as child>
<@print_layout_widget widget=child indent=indent+2 />  
  </#list>
${""?left_pad(indent)}</div>
</#macro>

<#macro print_layout_group widget indent=0>
  <#if widget.container.type == "entry_form">
${""?left_pad(indent)}<div class="${namespace}-panel">
${""?left_pad(indent)}  <div class="${namespace}-panel-head">${widget.title!"标题"}</div>
${""?left_pad(indent)}  <div class="${namespace}-form">
    <#list widget.children as child>
${""?left_pad(indent)}    <div class="${namespace}-field">
${""?left_pad(indent)}      <label class="${namespace}-field-label">${widget.title!"biaoti"}</label>
<@print_layout_widget widget=child indent=indent+6 />
${""?left_pad(indent)}    </div>
    </#list>
${""?left_pad(indent)}  </div>      
${""?left_pad(indent)}</div>  
  </#if>
</#macro>