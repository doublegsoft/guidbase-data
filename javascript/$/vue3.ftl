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

<#macro print_page_layout widget indent=0>
  <#list widget.widgets as child>
    <#if child.type == "entry_form">
    <#elseif child.type == "view_form">
    <#elseif child.type == "select" && !child.readonly>
${""?left_pad(indent)}<${namespace}-dropdown />
    <#elseif child.type == "date" && !child.readonly>
${""?left_pad(indent)}<${namespace}-datepicker />    
    </#if>
  </#list>
</#macro>
