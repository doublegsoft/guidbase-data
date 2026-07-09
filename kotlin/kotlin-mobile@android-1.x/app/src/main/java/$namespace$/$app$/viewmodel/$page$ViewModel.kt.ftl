<#import "/$/guidbase.ftl" as guidbase>
<#import "/$/guidbase4kotlin.ftl" as guidbase4kotlin>
<#assign pageParams = guidbase.get_page_params(page)>
package ${namespace}.${java.nameNamespace(app.name)}.viewmodel 

import androidx.lifecycle.SavedStateHandle
import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.flow.StateFlow
import kotlinx.coroutines.flow.asStateFlow
import kotlinx.coroutines.launch

import ${namespace}.${java.nameNamespace(app.name)}.sdk.repository.*; 
import ${namespace}.${java.nameNamespace(app.name)}.sdk.payload.*; 
import ${namespace}.${java.nameNamespace(app.name)}.model.*; 
import ${namespace}.${java.nameNamespace(app.name)}.util.*; 

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
  <#elseif container.type == "paged_table" || container.type == "paged_grid" || 
           container.type == "excel_form">
    val ${java.nameVariable(container.id)}Rows: List<${java.nameType(url.resource)}>,
  <#elseif container.type == "list_view">
    val ${java.nameVariable(container.id)}Rows: List<${java.nameType(url.resource)}>,
    val isLoadingMore: Boolean = false,
    val hasMore: Boolean = false,
  </#if>
</#list>
  ) : ${java.nameType(page.name)}ViewState
  
  data class Error(
    val message: String
  ) : ${java.nameType(page.name)}ViewState
}

class ${java.nameType(page.name)}ViewModel(
  private val repository: Repository,
  private val savedStateHandle: SavedStateHandle
) : ViewModel() {
    
  private val _viewState = MutableStateFlow<${java.nameType(page.name)}ViewState>(${java.nameType(page.name)}ViewState.Loading)
  val viewState: StateFlow<${java.nameType(page.name)}ViewState> = _viewState.asStateFlow()
<#-- 页面传参 -->  
<#list pageParams as param>

  private val ${java.nameVariable(param)}: String? = savedStateHandle["${java.nameVariable(param)}"]
</#list>
<#-- 【加载更多】特性需要的变量 -->
<#if guidbase.has_loading_more(page)>
  <#assign objname = guidbase.get_page_object(page)>

  private var ${java.nameVariable(objname)}Total = 0
  private val ${java.nameVariable(objname)}Rows = mutableListOf<${java.nameType(objname)}>()
  private val ${java.nameVariable(objname)}Params = ${java.nameType(objname)}Query()
</#if>

  /**
   * 页面加载后，加载加载所有业务数据。
   */
  fun refresh() {    
    viewModelScope.launch {
      _viewState.value = ${java.nameType(page.name)}ViewState.Loading   
<#if guidbase.has_loading_more(page)>
      ${java.nameVariable(objname)}Total = 0
      ${java.nameVariable(objname)}Rows.clear()
</#if>     
      try {
<#-- 从服务器获取数据 -->        
<#list page.containers as container>
  <#if container.value("data") == ""><#continue></#if>
  <#assign url = valuebase.url(container.value("data"))>
  <#if container.type == "entry_form" || container.type == "display_form" || container.type == "official_form">
        val ${java.nameVariable(container.id)}Data: ${java.nameType(url.resource)}? = repository.fetch${java.nameType(url.resource)}(${java.nameVariable(objname)}Params)
  <#elseif container.type == "paged_table" || container.type == "paged_grid" || container.type == "excel_form">
        val page: Pagination<${java.nameType(url.resource)}> = repository.fetch${java.nameType(inflector.pluralize(url.resource))}(${java.nameVariable(objname)}Params)
        val ${java.nameVariable(container.id)}  = page.data
  <#elseif container.type == "list_view">
        val page: Pagination<${java.nameType(url.resource)}> = repository.fetch${java.nameType(inflector.pluralize(url.resource))}(${java.nameVariable(objname)}Params, start = ${java.nameVariable(url.resource)}Rows.size, limit = PAGE_SIZE)
        ${java.nameVariable(url.resource)}Total = page.total
        ${java.nameVariable(url.resource)}Rows.addAll(page.data)
  <#elseif container.type == "calendar">
        val page: Pagination<${java.nameType(url.resource)}> = repository.fetch${java.nameType(inflector.pluralize(url.resource))}(${java.nameVariable(objname)}Params)
        val ${java.nameVariable(container.id)}Cells = page.data
  </#if>
</#list>        
<#-- 转换为成功状态 -->
        _viewState.value = ${java.nameType(page.name)}ViewState.Success(
<#list page.containers as container>
  <#if container.value("data") == ""><#continue></#if>
  <#assign url = valuebase.url(container.value("data"))>    
  <#if container.type == "entry_form" || container.type == "display_form" || container.type == "official_form">
          ${java.nameVariable(container.id)}Data = ${java.nameVariable(container.id)}Data,
  <#elseif container.type == "paged_grid" || container.type == "list_view">
          ${java.nameVariable(container.id)}Rows = ${java.nameVariable(url.resource)}Rows.toList(),
          isLoadingMore = false,
          hasMore = ${java.nameVariable(objname)}Rows.size < ${java.nameVariable(objname)}Total,
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
<#-- 单独处理加载更多方法 -->
<#if guidbase.has_loading_more(page)>
  <#assign objname = guidbase.get_page_object(page)>

  /**
   * 加载更多方法
   */
  fun loadMore() {
    val current = _viewState.value
    if (current !is ListFormPageViewState.Success || current.isLoadingMore || !current.hasMore) return

    viewModelScope.launch {
      _viewState.value = current.copy(isLoadingMore = true)
      try {
        val page: Pagination<${java.nameType(objname)}> = repository.fetchDemos(${java.nameVariable(objname)}Params, start = ${java.nameVariable(objname)}Rows.size, limit = PAGE_SIZE)
        ${java.nameVariable(objname)}Total = page.total
        ${java.nameVariable(objname)}Rows.addAll(page.data)
        _viewState.value = ListFormPageViewState.Success(
          ${java.nameVariable(guidbase.get_loading_more_widget(page).id)}Rows = ${java.nameVariable(objname)}Rows.toList(),
          isLoadingMore = false,
          hasMore = ${java.nameVariable(objname)}Rows.size < ${java.nameVariable(objname)}Total,
        )
      } catch (e: Exception) {
        // 加载更多失败时保持现有数据，仅重置 loading 状态
        _viewState.value = current.copy(isLoadingMore = false)
      }
    }
  }  
</#if>
}
