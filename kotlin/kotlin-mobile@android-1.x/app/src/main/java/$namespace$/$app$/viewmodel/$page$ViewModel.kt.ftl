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
import kotlinx.coroutines.flow.update
import kotlinx.coroutines.launch

import ${namespace}.${java.nameNamespace(app.name)}.sdk.repository.*;
import ${namespace}.${java.nameNamespace(app.name)}.sdk.payload.*;
import ${namespace}.${java.nameNamespace(app.name)}.model.*;
import ${namespace}.${java.nameNamespace(app.name)}.util.*;
import ${namespace}.${java.nameNamespace(app.name)}.behavior.*;
<#list page.containers as container>
  <#if container.value("data") == ""><#continue></#if>
  <#assign url = valuebase.url(container.value("data"))>

/**
 * 【${container.title}】组件状态。
 */
sealed interface ${java.nameType(container.id)}State {
  data object Loading : ${java.nameType(container.id)}State
  data class Success(
  <#if container.type == "entry_form" || container.type == "display_form" || container.type == "official_form">
    val ${java.nameVariable(container.id)}Data: ${java.nameType(url.resource)}?,
  <#elseif container.type == "criteria_form">
    val ${java.nameVariable(container.id)}Crit: ${java.nameType(container.id)}Crit?,
  <#elseif container.type == "paged_table" || container.type == "paged_grid" ||
           container.type == "excel_form">
    val ${java.nameVariable(container.id)}Rows: List<${java.nameType(url.resource)}>,
  <#elseif container.type == "list_view">
    val ${java.nameVariable(container.id)}Rows: PagingBehavior.Snapshot<${java.nameType(url.resource)}>,
  </#if>
  ) : ${java.nameType(container.id)}State
  data class Error(
    val message: String
  ) : ${java.nameType(container.id)}State
}
</#list>

data class ${java.nameType(page.name)}ViewState (
<#list page.containers as container>
  <#if container.value("data") == ""><#continue></#if>
  val ${java.nameVariable(container.id)}State: ${java.nameType(container.id)}State = ${java.nameType(container.id)}State.Loading,
</#list>
)

class ${java.nameType(page.name)}ViewModel(
  private val repository: Repository,
  private val savedStateHandle: SavedStateHandle
) : ViewModel() {

  // view state 控制
  private val _viewState = MutableStateFlow<${java.nameType(page.name)}ViewState>(${java.nameType(page.name)}ViewState())
  val viewState: StateFlow<${java.nameType(page.name)}ViewState> = _viewState.asStateFlow()

<#-- 页面传参 -->
  // 页面初始入参
<#list pageParams as param>
  private val ${java.nameVariable(param)}: String? = savedStateHandle["${java.nameVariable(param)}"]
</#list>
<#-- 【加载更多】特性 —— 使用 PagingBehavior 封装分页状态与累加逻辑 -->
<#list page.containers as container>
  <#if container.value("data") == ""><#continue></#if>
  <#assign url = valuebase.url(container.value("data"))>

  val ${java.nameVariable(container.id)}Paging = PagingBehavior<${java.nameType(url.resource)}, ${java.nameType(url.resource)}Query>(fetch = { params, start, limit ->
    repository.fetch${java.nameType(inflector.pluralize(url.resource))}(params, start, limit)
  })
</#list>

  /**
   * 页面加载后，加载加载所有业务数据。
   */
  fun refresh() {
<#list page.containers as container>
  <#if container.value("data") == ""><#continue></#if>
    // 【${container.title}】界面状态控制
    viewModelScope.launch {
      _viewState.update { 
        it.copy(${java.nameVariable(container.id)}State = ${java.nameType(container.id)}State.Loading)
      }
      try {
<#-- 从服务器获取数据 -->
<#list page.containers as container>
  <#if container.value("data") == ""><#continue></#if>
  <#assign url = valuebase.url(container.value("data"))>
  <#if container.type == "entry_form" || container.type == "display_form" || container.type == "official_form">
        val ${java.nameVariable(container.id)}Data: ${java.nameType(url.resource)}? = repository.fetch${java.nameType(url.resource)}(paging.params)
  <#elseif container.type == "paged_table" || container.type == "paged_grid" || container.type == "excel_form">
        val page: Pagination<${java.nameType(url.resource)}> = repository.fetch${java.nameType(inflector.pluralize(url.resource))}(paging.params)
        val ${java.nameVariable(container.id)}  = page.data
  <#elseif container.type == "list_view">
        ${java.nameVariable(container.id)}Paging.refresh(${java.nameType(url.resource)}Query())
  <#elseif container.type == "calendar">
        val page: Pagination<${java.nameType(url.resource)}> = repository.fetch${java.nameType(inflector.pluralize(url.resource))}(paging.params)
        val ${java.nameVariable(container.id)}Cells = page.data
  </#if>
</#list>    
<#-- 转换成功状态 -->        
        _viewState.update { 
          it.copy(${java.nameVariable(container.id)}State = ${java.nameType(container.id)}State.Success(
  <#if container.type == "entry_form" || container.type == "display_form" || container.type == "official_form">
            ${java.nameVariable(container.id)}Data = ${java.nameVariable(container.id)}Data,
  <#elseif container.type == "paged_grid" || container.type == "list_view">
            ${java.nameVariable(guidbase.get_loading_more_widget(page).id)}Rows = ${java.nameVariable(container.id)}Paging.snapshot,
  <#elseif container.type == "calendar">
            ${java.nameVariable(container.id)}Cells = ${java.nameVariable(container.id)}Cells,
  </#if>            
          ))
        }
      } catch (e: Exception) {
        _viewState.update { 
          it.copy(${java.nameVariable(container.id)}State = ${java.nameType(container.id)}State.Error(
            message = e.message ?: "An unexpected error occurred"
          ))
        }
      }
    }
</#list>
  }
}