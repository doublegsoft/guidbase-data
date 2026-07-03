<#import "/$/guidbase4kotlin.ftl" as guidbase4kotlin>
package ${namespace}.${java.nameNamespace(app.name)}.sdk.assembler

import ${namespace}.${java.nameNamespace(app.name)}.util.*
import ${namespace}.${java.nameNamespace(app.name)}.sdk.payload.*


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
    </#if>

object ${java.nameType(objname)}Assembler {

  fun assemble(rawMap: Map<String, Any?>?): ${java.nameType(objname)} {
    if (rawMap == null) return createEmpty()

    return ${java.nameType(objname)}(
    <#list container.inputs as input>
      <#if input.type == "hidden" || input.type == "text" || input.type == "longtext" >
      ${java.nameVariable(input.id)} = Safe.string(rawMap["${java.nameVariable(input.id)}"]),
      <#elseif input.type == "number">
      ${java.nameVariable(input.id)} = Safe.decimal(rawMap["${java.nameVariable(input.id)}"]),
      <#elseif input.type == "int" || input.type == "integer">
      ${java.nameVariable(input.id)} = Safe.int(rawMap["${java.nameVariable(input.id)}"]),
      <#elseif input.type == "bool">
      ${java.nameVariable(input.id)} = Safe.bool(rawMap["${java.nameVariable(input.id)}"]),
      <#elseif input.type == "select" || input.type == "image" || input.type == "avatar">
      ${java.nameVariable(input.id)} = Safe.option(rawMap["${java.nameVariable(input.id)}"]),
      <#elseif input.type == "date" || input.type == "time" || input.type == "datetime">
      ${java.nameVariable(input.id)} = Safe.date(rawMap["${java.nameVariable(input.id)}"]),
      <#elseif input.type == "tags">
      ${java.nameVariable(input.id)} = Safe.strings(rawMap["${java.nameVariable(input.id)}"]),
      <#elseif input.type == "multiselect" || input.type == "files" || input.type == "images" || input.type == "videos" || input.type == "cascade">
      ${java.nameVariable(input.id)} = Safe.options(rawMap["${java.nameVariable(input.id)}"]),
      <#else>
      ${java.nameVariable(input.id)} = Safe.string(rawMap["${java.nameVariable(input.id)}"]),
      </#if>
    </#list>
    )
  }

  private fun createEmpty(): ${java.nameType(objname)} = ${java.nameType(objname)}(
    <#list container.inputs as input>
    ${java.nameVariable(input.id)} = ${guidbase4kotlin.get_primitive_default_value(input)},
    </#list>
  )
}
  </#list>
</#list>