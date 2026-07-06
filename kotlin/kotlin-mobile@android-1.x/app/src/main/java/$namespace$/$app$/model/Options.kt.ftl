package ${namespace}.${java.nameNamespace(app.name)}.model

import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.delay
import kotlinx.coroutines.withContext

import ${namespace}.${java.nameNamespace(app.name)}.model.Option
<#assign visited_widgets = {}>
<#list app.pages as page>  
  <#list page.inputs as input>
    <#if visited_widgets[input.id]??><#continue></#if>
    <#if !input.value("data")?starts_with("enum[")><#continue></#if>
    <#assign visited_widgets += { (input.id): input }>
    <#assign vals = typebase.enumtype(input.value("data"))>

/**
  * 获取【${input.title}】选项数据。
  */  
fun get${java.nameType(input.id)}Options(): List<Option> {
  return listOf(
  <#list vals as val>  
    Option("${val.code}", "${val.text}"),
  </#list>  
  )
}
  </#list>
</#list>