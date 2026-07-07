<#import "/$/kotlin-navypitch.ftl" as kotlin>
package ${namespace}.${java.nameNamespace(app.name)}.ui.screens

import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.width
import androidx.compose.foundation.rememberScrollState
import androidx.compose.foundation.verticalScroll
import androidx.compose.material3.Text
import androidx.compose.runtime.collectAsState
import androidx.compose.runtime.Composable
import androidx.compose.runtime.LaunchedEffect
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.runtime.setValue
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.text.style.TextAlign
import androidx.compose.ui.unit.sp
import ${namespace}.${java.nameNamespace(app.name)}.ui.components.*
import ${namespace}.${java.nameNamespace(app.name)}.ui.design.*
import ${namespace}.${java.nameNamespace(app.name)}.viewmodel.*
import ${namespace}.${java.nameNamespace(app.name)}.model.*
import ${namespace}.${java.nameNamespace(app.name)}.util.*

/**
 * 【${page.title}】界面。
 */
@Composable
fun ${java.nameType(page.name)}Screen(
  viewModel: ${java.nameType(page.name)}ViewModel,
  onBack: () -> Unit
) {

  PageShell(
    topBar = {
      Row(
        modifier = Modifier
          .fillMaxWidth()
          .padding(Spacings.s5, Spacings.s5),
        verticalAlignment = Alignment.CenterVertically
      ) {
        Button(
          label = "← 返回",
          onClick = onBack,
          variant = ButtonVariant.Outline,
          size = ButtonSize.Sm
        )
        Spacer(Modifier.width(Spacings.s5))
        Text(
          text = "日程详情",
          fontSize = Types.TextLg,
          fontWeight = FontWeight.Bold,
          color = Colors.TextMain,
          modifier = Modifier.weight(1f)
        )
        Button(
          label = "保存",
          onClick = { },
          variant = ButtonVariant.Primary,
          size = ButtonSize.Sm
        )
      }
      Divider()
    }
  ) {
    LaunchedEffect(Unit) {
      viewModel.loadData()
    }

    val state by viewModel.viewState.collectAsState()
    val sta = state
    when (sta) {
      is ${java.nameType(page.id)}ViewState.Loading -> {
        Loading()
      }
      is ${java.nameType(page.id)}ViewState.Error -> {
        Error(
          message = sta.message,
          retryLabel = "重试",
          onRetry = { viewModel.loadData() }
        )
      }
      is ${java.nameType(page.id)}ViewState.Success -> {
<#list page.containers as container>    
  <#if container.type == "entry_form" || container.type == "display_form">
        ${java.nameType(page.id)}Body(data = sta.${java.nameVariable(container.id)}Data)
  <#elseif container.type == "list_view">    
        ${java.nameType(page.id)}Body(rows = sta.${java.nameVariable(container.id)}Rows)
  </#if>
</#list>
      }
    }
  }
}

@Composable
private fun ${java.nameType(page.id)}Body(data: Demo?) {
  if (data == null) {
    Empty()
    return
  }
  Column(
    modifier = Modifier
      .fillMaxSize()
      .verticalScroll(rememberScrollState())
  ) {
<@kotlin.print_page_layout page=page indent=4 /> 
  }
}
