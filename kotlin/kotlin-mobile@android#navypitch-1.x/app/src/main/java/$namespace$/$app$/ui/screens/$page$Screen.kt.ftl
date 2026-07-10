<#import "/$/guidbase.ftl" as guidbase>
<#import "/$/kotlin-navypitch.ftl" as kotlin>
package ${namespace}.${java.nameNamespace(app.name)}.ui.screens

import androidx.compose.animation.core.LinearEasing
import androidx.compose.animation.core.RepeatMode
import androidx.compose.animation.core.animateFloat
import androidx.compose.animation.core.infiniteRepeatable
import androidx.compose.animation.core.rememberInfiniteTransition
import androidx.compose.animation.core.tween
import androidx.compose.foundation.Canvas
import androidx.compose.foundation.background
import androidx.compose.foundation.border
import androidx.compose.foundation.clickable
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.size
import androidx.compose.foundation.layout.width
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.foundation.lazy.items
import androidx.compose.foundation.lazy.rememberLazyListState
import androidx.compose.foundation.rememberScrollState
import androidx.compose.foundation.shape.CircleShape
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.foundation.verticalScroll
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.automirrored.filled.ArrowBack
import androidx.compose.material3.Icon
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.runtime.LaunchedEffect
import androidx.compose.runtime.collectAsState
import androidx.compose.runtime.derivedStateOf
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateListOf
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.runtime.setValue
import androidx.compose.runtime.snapshotFlow
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.draw.rotate
import androidx.compose.ui.graphics.StrokeCap
import androidx.compose.ui.graphics.drawscope.Stroke
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import ${namespace}.${java.nameNamespace(app.name)}.ui.components.*
import ${namespace}.${java.nameNamespace(app.name)}.ui.design.*
import ${namespace}.${java.nameNamespace(app.name)}.sdk.payload.*
import ${namespace}.${java.nameNamespace(app.name)}.viewmodel.*
import ${namespace}.${java.nameNamespace(app.name)}.behavior.*
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
        Box(
          modifier = Modifier
            .size(36.dp)
            .clip(CircleShape)
            .background(Colors.Surface)
            .clickable(onClick = onBack),
          contentAlignment = Alignment.Center
        ) {
          Icon(
            imageVector = Icons.AutoMirrored.Filled.ArrowBack,
            contentDescription = "返回",
            tint = Colors.TextMain,
            modifier = Modifier.size(20.dp)
          )
        }
        Spacer(Modifier.width(Spacings.s5))
        Text(
          text = "${page.title}",
          fontSize = Types.TextLg,
          fontWeight = FontWeight.Bold,
          color = Colors.TextMain,
          modifier = Modifier.weight(1f)
        )
      }
      Divider()
    }
  ) {
    LaunchedEffect(Unit) {
      viewModel.refresh()
    }

    val state by viewModel.viewState.collectAsState()
    val sta = state
<#list page.containers as container>
  <#if container.value("data") == "">#continue></#if>    
    when (val widgetState = sta.${java.nameVariable(container.id)}State) {
      is ${java.nameType(container.id)}State.Loading -> {
        Loading()
      }
      is ${java.nameType(container.id)}State.Error -> {
        Error(
          message = widgetState.message,
          retryLabel = "重试",
          onRetry = { viewModel.refresh() }
        )
      }
      is ${java.nameType(container.id)}State.Success -> {  
  <#if container.type == "entry_form" || container.type == "display_form">
        ${java.nameType(page.id)}Body(data = sta.${java.nameVariable(container.id)}Data)
  <#elseif container.type == "list_view">    
        ${java.nameType(container.id)}Body(
          paging = viewModel.${java.nameVariable(container.id)}Paging,
        )
  </#if>
</#list>
      }
    }
  }
}
<#-- 【Body】函数 -->
<@kotlin.print_layout_page_methods page=page />