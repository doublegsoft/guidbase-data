<#import "/$/guidbase4kotlin.ftl" as guidbase4kotlin>
package ${namespace}.${java.nameNamespace(app.name)}.sdk.assembler

import ${namespace}.${java.nameNamespace(app.name)}.util.*
import ${namespace}.${java.nameNamespace(app.name)}.model.*

<#assign visited_objects = {}>
<#list app.pages as page>
  <#list page.containers as container>
    <#if container.value("data") == ""><#continue></#if>
    <#assign url = valuebase.url(container.value("data"))>
    <#if visited_objects[url.resource]??><#continue></#if>
    <#assign visited_objects += { (url.resource): true }>
    

object ${java.nameType(url.resource)}Assembler {

  fun assemble(rawMap: Map<String, Any?>?): ${java.nameType(url.resource)} {
    if (rawMap == null) return createEmpty()

    return ${java.nameType(url.resource)}(
    <#list container.inputs as input>
      <#assign isForm = input.ancestor("entry_form")?? || input.ancestor("official_form")?? || input.ancestor("excel_form")??>
      <#if input.type == "hidden" || input.type == "text" || input.type == "longtext" >
      ${java.nameVariable(input.id)} = Safe.string(rawMap["${java.nameVariable(input.id)}"]),
      <#elseif input.type == "number">
      ${java.nameVariable(input.id)} = Safe.decimal(rawMap["${java.nameVariable(input.id)}"]),
      <#elseif input.type == "int" || input.type == "integer">
      ${java.nameVariable(input.id)} = Safe.int(rawMap["${java.nameVariable(input.id)}"]),
      <#elseif input.type == "bool">
      ${java.nameVariable(input.id)} = Safe.bool(rawMap["${java.nameVariable(input.id)}"]),
      <#elseif input.type == "select">
        <#if isForm>
      ${java.nameVariable(input.id)} = Safe.string(rawMap["${java.nameVariable(input.id)}"]),
        <#else>
      ${java.nameVariable(input.id)} = Safe.option(rawMap["${java.nameVariable(input.id)}"]),
        </#if>
      <#elseif input.type == "image" || input.type == "avatar">
      ${java.nameVariable(input.id)} = Safe.string(rawMap["${java.nameVariable(input.id)}"]),
      <#elseif input.type == "date" || input.type == "time" || input.type == "datetime">
      ${java.nameVariable(input.id)} = Safe.date(rawMap["${java.nameVariable(input.id)}"]),
      <#elseif input.type == "tags">
      ${java.nameVariable(input.id)} = Safe.strings(rawMap["${java.nameVariable(input.id)}"]),
      <#elseif input.type == "multiselect" || input.type == "files" || input.type == "images" || input.type == "videos" || input.type == "cascade">
        <#if isForm>
      ${java.nameVariable(input.id)} = Safe.strings(rawMap["${java.nameVariable(input.id)}"]),
        <#else>
      ${java.nameVariable(input.id)} = Safe.options(rawMap["${java.nameVariable(input.id)}"]),
        </#if>
      <#else>
      ${java.nameVariable(input.id)} = Safe.string(rawMap["${java.nameVariable(input.id)}"]),
      </#if>
    </#list>
    )
  }

  private fun createEmpty(): ${java.nameType(url.resource)} = ${java.nameType(url.resource)}(
    <#list container.inputs as input>
    ${java.nameVariable(input.id)} = ${guidbase4kotlin.get_primitive_default_value(input)},
    </#list>
  )
}
  </#list>
</#list>