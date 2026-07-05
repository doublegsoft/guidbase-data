<#import "/$/guidbase4kotlin.ftl" as guidbase4kotlin>
package ${namespace}.${java.nameNamespace(app.name)}.viewmodel 

import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.flow.StateFlow
import kotlinx.coroutines.flow.asStateFlow
import kotlinx.coroutines.launch

import ${namespace}.${java.nameNamespace(app.name)}.sdk.repository.*; 
import ${namespace}.${java.nameNamespace(app.name)}.sdk.payload.*; 
import ${namespace}.${java.nameNamespace(app.name)}.model.*; 

sealed interface ${java.nameType(page.name)}ViewState {

  data object Loading : ${java.nameType(page.name)}ViewState
  
  data class Success(
<#list page.containers as container>
  <#if container.value("data") == ""><#continue></#if>
  <#assign url = valuebase.url(container.value("data"))>
  <#if container.type == "entry_form" || container.type == "display_form" || container.type == "official_form">
    val ${java.nameVariable(container.id)}Data: ${java.nameType(url.resource)}?,
  <#elseif container.type == "criteria_form">
    val ${java.nameVariable(container.id)}Crit: ${java.nameType(container.id)}Crit?,
  <#elseif container.type == "paged_table" || container.type == "paged_grid" || conatiner.type == "list_view" || 
           container.type == "excel_form">
    val ${java.nameVariable(container.id)}Rows: List<${java.nameType(url.resource)}>,
  </#if>
</#list>
  ) : ${java.nameType(page.name)}ViewState
  
  data class Error(
    val message: String
  ) : ${java.nameType(page.name)}ViewState
}

class ${java.nameType(page.name)}ViewModel(
  private val repository: Repository
) : ViewModel() {
    
  private val _viewState = MutableStateFlow<${java.nameType(page.name)}ViewState>(${java.nameType(page.name)}ViewState.Loading)
  val viewState: StateFlow<${java.nameType(page.name)}ViewState> = _viewState.asStateFlow()

  /**
   * 页面加载后，加载加载所有业务数据。
   */
  fun loadData() {
    viewModelScope.launch {
      _viewState.value = ${java.nameType(page.name)}ViewState.Loading
      try {
<#list page.containers as container>
  <#if container.value("data") == ""><#continue></#if>
  <#assign url = valuebase.url(container.value("data"))>
        var params = ${java.nameType(url.resource)}Query(null)
  <#if container.type == "entry_form" || container.type == "display_form" || container.type == "official_form">
        val ${java.nameVariable(container.id)}Data: ${java.nameType(url.resource)}? = repository.fetch${java.nameType(url.resource)}(params)
  <#elseif container.type == "paged_table" || container.type == "paged_grid" || container.type == "list_view" || container.type == "excel_form">
        val ${java.nameVariable(container.id)}Rows: List<${java.nameType(url.resource)}> = repository.fetch${java.nameType(inflector.pluralize(url.resource))}(params)
  <#elseif container.type == "calendar">
        val ${java.nameVariable(container.id)}Cells: List<${java.nameType(url.resource)}> = repository.fetch${java.nameType(inflector.pluralize(url.resource))}(params)
  </#if>
</#list>        
        _viewState.value = ${java.nameType(page.name)}ViewState.Success(
<#list page.containers as container>
  <#if container.value("data") == ""><#continue></#if>
  <#assign url = valuebase.url(container.value("data"))>    
  <#if container.type == "entry_form" || container.type == "display_form" || container.type == "official_form">
          ${java.nameVariable(container.id)}Data = ${java.nameVariable(container.id)}Data,
  <#elseif container.type == "paged_table" || container.type == "paged_grid" || container.type == "list_view" || container.type == "excel_form">
          ${java.nameVariable(container.id)}Rows = ${java.nameVariable(container.id)}Rows,
  <#elseif container.type == "calendar">   
          ${java.nameVariable(container.id)}Cells = ${java.nameVariable(container.id)}Cells, 
  </#if>  
</#list>
        )
      } catch (e: Exception) {
        _viewState.value = ${java.nameType(page.name)}ViewState.Error(
          message = e.message ?: "An unexpected error occurred"
        )
      }
    }
  }
}
