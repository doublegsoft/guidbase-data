package ${namespace}.${java.nameNamespace(app.name)}.sdk.repository

import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.delay
import kotlinx.coroutines.withContext

class MemoryRepository {
<#list app.pages as page>  
  <#-- 容器部件的数据对象 -->
  <#list page.containers as container>
    <#if container.value("data") == ""><#continue></#if>
    <#assign url = valuebase.url(container.value("data"))>
  suspend fun fetch${java.nameType(inflector.pluralize(url.resource))}(start: Int, limit: Int): List<Map<String, Any>> {
    delay(2000) 
    return emptyList()
  }
  </#list>
  <#-- 页面部件的数据对象 -->
  <#list page.inputs as input>
    <#if input.value("data") == ""><#continue></#if>
  </#list>
</#list>
}