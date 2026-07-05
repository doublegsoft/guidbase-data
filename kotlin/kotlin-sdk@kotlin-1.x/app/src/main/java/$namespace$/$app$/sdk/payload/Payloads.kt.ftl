<#import "/$/guidbase4kotlin.ftl" as guidbase4kotlin>
package ${namespace}.${java.nameNamespace(app.name)}.sdk.payload

import java.util.Date
import java.math.BigDecimal
import ${namespace}.${java.nameNamespace(app.name)}.model.*
<#assign visited_containers = {}>
<#list app.pages as page>
  <#list page.containers as container>
    <#if visited_containers[container.id]??><#continue></#if>
    <#assign visited_containers += { (container.id): container }>
    <#if container.type == "entry_form" || container.type == "display_form" || container.type == "official_form">
      <#assign objname = container.id + "_data">
    <#elseif container.type == "criteria_form">
      <#assign objname = container.id + "_crit">
    <#elseif container.type == "excel_form" || container.type == "paged_table" || 
             container.type == "paged_grid" || container.type == "list_view">
      <#assign objname = container.id + "_row">
    <#else>
      <#continue>  
    </#if>

/**
 * 【${container.title!""}】
 */ 
data class ${java.nameType(objname)}(
    <#list container.inputs as input>
  val ${java.nameVariable(input.id)}: ${guidbase4kotlin.type_input_primitive(input)}?,
    </#list>
)
  </#list>
</#list>

<#list app.pages as page>
  <#if page.value("params") == ""><#continue></#if>
  <#assign params = page.value("params")?split(",")>

data class ${java.nameType(page.name)}Crit(
  <#list params as param>
  val ${java.nameVariable(param)}: String?,
  </#list>
  <#list page.containers as container>
    <#if container.value("variable") == ""><#continue></#if>
  val ${java.nameVariable(container.value("variable"))}: String?,
  </#list>
)
</#list>