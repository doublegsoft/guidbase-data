<#import "/$/guidbase4kotlin.ftl" as guidbase4kotlin>
package ${namespace}.${java.nameNamespace(app.name)}.sdk.repository

import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.delay
import kotlinx.coroutines.withContext

import ${namespace}.${java.nameNamespace(app.name)}.model.*
import ${namespace}.${java.nameNamespace(app.name)}.sdk.payload.*

class MemoryRepository : Repository {
<#assign visited_objects = {}>
<#list app.pages as page>  
  <#list page.containers as container>
    <#if container.value("data") == ""><#continue></#if>
    <#assign url = valuebase.url(container.value("data"))>
    <#if visited_objects[url.resource]??><#continue></#if>
    <#assign visited_objects += { (url.resource): url }>

  /**
   * 获取【${url.resource?upper_case}】唯一数据。
   */  
  override suspend fun fetch${java.nameType(url.resource)}(params: ${java.nameType(url.resource)}Query?): ${java.nameType(url.resource)}? {
    delay(1200)
    return ${java.nameType(url.resource)}(
    <#list container.inputs as input>
      ${java.nameVariable(input.id)} = ${guidbase4kotlin.get_primitive_default_value(input)},
    </#list>      
    )
  }

  /**
   * 获取【${url.resource?upper_case}】集合数据。
   */  
  override suspend fun fetch${java.nameType(inflector.pluralize(url.resource))}(params: ${java.nameType(url.resource)}Query?, start: Int, limit: Int): Pagination<${java.nameType(url.resource)}> {
    delay(1200) 
    return Pagination(emptyList(),0)
  }
  </#list>
  <#-- 页面部件的数据对象 -->
  <#list page.inputs as input>
    <#if input.value("data") == ""><#continue></#if>
  </#list>
</#list>
<#list app.pages as page>
  <#list page.inputs as input>
    <#if input.value("data") == "" || input.value("data")?starts_with("enum[")><#continue></#if>
    <#assign url = valuebase.url(input.value("data"))>
    <#assign valueField = page.value("value", "value")>
    <#assign labelField = page.value("label", "label")>
  
  /**
   * 获取【${input.title}】选项选项。
   */
  override suspend fun fetch${java.nameType(url.resource)}AsOptions(): List<Option> {
    delay(1200) 
    return listOf(
      Option("ABC", "${tatabase.string(10)}"), 
      Option("BCD", "${tatabase.string(10)}"), 
      Option("CDE", "${tatabase.string(10)}"),
      Option("DEF", "${tatabase.string(10)}"),
      Option("EFG", "${tatabase.string(10)}"),
      Option("FGH", "${tatabase.string(10)}"),
      Option("GHI", "${tatabase.string(10)}"),
    )
  }
  </#list>
</#list>
}