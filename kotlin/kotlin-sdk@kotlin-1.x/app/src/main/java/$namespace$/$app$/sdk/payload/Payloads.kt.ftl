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

/**
 * 【${container.title!""}】
 */ 
    <#if container.type == "entry_form" || container.type == "display_form" || container.type == "official_form">
data class ${java.nameType(container.id)}Data(
    <#elseif container.type == "criteria_form">
data class ${java.nameType(container.id)}Crit(
    <#elseif container.type == "excel_form" || container.type == "paged_table" || 
             container.type == "paged_grid" || container.type == "list_view">
data class ${java.nameType(container.id)}Row(
    </#if>
    <#list container.inputs as input>
  val ${java.nameVariable(input.id)}: ${guidbase4kotlin.type_input_primitive(input)}?,
    </#list>
)
  </#list>
</#list>