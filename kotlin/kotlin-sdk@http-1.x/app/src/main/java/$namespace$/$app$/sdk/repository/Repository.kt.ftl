package ${namespace}.${java.nameNamespace(app.name)}.sdk.repository

import ${namespace}.${java.nameNamespace(app.name)}.model.*
import ${namespace}.${java.nameNamespace(app.name)}.sdk.payload.*

interface Repository {
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
  suspend fun fetch${java.nameType(url.resource)}(params: ${java.nameType(url.resource)}Query?): ${java.nameType(url.resource)}?;

  /**
   * 获取【${url.resource?upper_case}】集合数据。
   */  
  suspend fun fetch${java.nameType(inflector.pluralize(url.resource))}(params: ${java.nameType(url.resource)}Query?, start: Int = 0, limit: Int = -1): Pagination<${java.nameType(url.resource)}>;
  </#list>
  <#list page.inputs as input>
    <#if input.value("data") == "" || input.value("data")?starts_with("enum[")><#continue></#if>
    <#assign url = valuebase.url(input.value("data"))>

  /**
   * 获取${url.resource?upper_case}】选项数据。
   */
  suspend fun fetch${java.nameType(url.resource)}AsOptions(): List<Option>;  
  </#list>
</#list>
}