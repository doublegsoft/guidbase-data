package ${namespace}.${java.nameNamespace(app.name)}.sdk.repository

import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.delay
import kotlinx.coroutines.withContext

class RemoteRepository {
<#list app.pages as page>  
  <#list page.containers as container>
    <#if container.value("data") == ""><#continue></#if>
    <#assign url = valuebase.url(container.value("data"))>

  /**
   * 获取【${url.resource?upper_case}】集合数据。
   */  
  suspend fun fetch${java.nameType(inflector.pluralize(url.resource))}(start: Int, limit: Int): List<Map<String, Any>> {
    delay(2000) 
    return emptyList()
  }
  </#list>
</#list>
}