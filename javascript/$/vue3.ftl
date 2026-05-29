<#macro print_entry_form_variables form indent=0>
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
  <#elseif widget.type == "select" && !widget.readonly>
    <#if (widget.value("data")!"")?starts_with("enum[")>
${""?left_pad(indent)}<${namespace}-dropdown data-test="${js.nameVariable(widget.id)}" :options="sdk.${js.nameVariable(widget.id)}Options" v-model="${js.nameVariable(widget.container.id)}Data.${js.nameVariable(widget.id)}" />    
    <#else>
${""?left_pad(indent)}<${namespace}-dropdown data-test="${js.nameVariable(widget.id)}" :options="${js.nameVariable(widget.id)}Options" v-model="${js.nameVariable(widget.container.id)}Data.${js.nameVariable(widget.id)}" />
    </#if>
  <#elseif widget.type == "date" && !widget.readonly>
${""?left_pad(indent)}<${namespace}-datepicker data-test="${js.nameVariable(widget.id)}" v-model="${js.nameVariable(widget.container.id)}Data.${js.nameVariable(widget.id)}" />    
  <#elseif widget.type == "time" && !widget.readonly>
${""?left_pad(indent)}<${namespace}-timepicker data-test="${js.nameVariable(widget.id)}" v-model="${js.nameVariable(widget.container.id)}Data.${js.nameVariable(widget.id)}" />
  <#elseif widget.type == "cascade" && !widget.readonly>
${""?left_pad(indent)}<${namespace}-cascadepicker data-test="${js.nameVariable(widget.id)}" :options="${js.nameVariable(widget.id)}Options" v-model="${js.nameVariable(widget.container.id)}Data.${js.nameVariable(widget.id)}" />
  <#elseif widget.type == "multiselect" && !widget.readonly>
${""?left_pad(indent)}<${namespace}-multiselect data-test="${js.nameVariable(widget.id)}" :options="${js.nameVariable(widget.id)}Options" v-model="${js.nameVariable(widget.container.id)}Data.${js.nameVariable(widget.id)}" />
  <#elseif widget.type == "tags" && !widget.readonly>
${""?left_pad(indent)}<${namespace}-tagsinput data-test="${js.nameVariable(widget.id)}" v-model="${js.nameVariable(widget.container.id)}Data.${js.nameVariable(widget.id)}" />
  <#elseif widget.type == "longtext" && !widget.readonly>
${""?left_pad(indent)}<textarea class="${namespace}-textarea" data-test="${js.nameVariable(widget.id)}" placeholder="请输入${widget.title}"></textarea>  
  <#elseif widget.type == "text" && !widget.readonly>
${""?left_pad(indent)}<input class="${namespace}-input" data-test="${js.nameVariable(widget.id)}" v-model="${js.nameVariable(widget.container.id)}Data.${js.nameVariable(widget.id)}" placeholder="请输入${widget.title}">
  </#if>
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
