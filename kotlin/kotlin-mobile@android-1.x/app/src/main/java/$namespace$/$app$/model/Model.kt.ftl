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
<#assign visited_containers = {}>
<#list app.pages as page>
  <#list page.containers as container>
    <#if visited_containers[container.id]??><#continue></#if>
    <#if container.value("data") == ""><#continue></#if>
    <#assign visited_containers += { (container.id): container }>
    <#assign url = valuebase.url(container.value("data"))>

/**
 * 【${container.title!""}】使用的“${url.resource}” 
 */ 
data class ${java.nameType(url.resource)}For${java.nameType(container.id)}(
    <#list container.inputs as input>
  val ${java.nameVariable(input.id)}: ${guidbase4kotlin.type_input_primitive(input)}?<#if input?index != input?size - 1>,</#if>
    </#list>
)
  </#list>
</#list>