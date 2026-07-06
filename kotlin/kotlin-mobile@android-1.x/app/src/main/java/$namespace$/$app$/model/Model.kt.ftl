<#import "/$/modelbase.ftl" as modelBase>
<#import "/$/guidbase4kotlin.ftl" as guidbase4kotlin>
package ${namespace}.${java.nameNamespace(app.name)}.model

import com.google.gson.annotations.SerializedName
import java.util.Date
import java.math.BigDecimal

data class Option (
  val value: String,
  val label: String
)

data class Pagination<T> (
  val data: List<T>,
  val total: Int
)
<#assign visited_objects = {}>
<#list app.pages as page>
  <#list page.containers as container>
    <#if container.value("data") == ""><#continue></#if>
    <#assign url = valuebase.url(container.value("data"))>
    <#if visited_objects[url.resource]??><#continue></#if>
    <#assign visited_objects += { (url.resource): url }>

/**
 * 【${url.resource?upper_case}】
 */ 
data class ${java.nameType(url.resource)}(
    <#list container.inputs as input>
  val ${java.nameVariable(input.id)}: ${guidbase4kotlin.type_input_primitive(input)}? = null,
    </#list>
)

  </#list>
</#list>
<#list app.pages as page>
  <#list page.inputs as input>
    <#if input.value("data") == "" || input.value("data")?starts_with("enum[")><#continue></#if>
    <#assign url = valuebase.url(input.value("data"))>
    <#assign valueField = page.value("value", "value")>
    <#assign labelField = page.value("label", "label")>
  
/**
 * 【${url.resource?upper_case}】
 */ 
data class ${java.nameType(url.resource)}(
  val ${java.nameVariable(valueField)}: String? = null,
  val ${java.nameVariable(labelField)}: String? = null,
)
  </#list>
</#list>