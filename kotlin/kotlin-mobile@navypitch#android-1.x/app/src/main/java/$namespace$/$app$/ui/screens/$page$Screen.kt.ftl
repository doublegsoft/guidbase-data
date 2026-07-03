package ${namespace}.${java.nameNamespace(app.name)}.ui.screens

import androidx.compose.foundation.background
import androidx.compose.foundation.layout.Arrangement
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
import androidx.compose.foundation.rememberScrollState
import androidx.compose.foundation.shape.CircleShape
import androidx.compose.foundation.verticalScroll
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.runtime.setValue
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import ${namespace}.${java.nameNamespace(app.name)}.ui.design.NavyPitchButton
import ${namespace}.${java.nameNamespace(app.name)}.ui.design.NavyPitchButtonSize
import ${namespace}.${java.nameNamespace(app.name)}.ui.design.NavyPitchButtonVariant
import ${namespace}.${java.nameNamespace(app.name)}.ui.design.NavyPitchCard
import ${namespace}.${java.nameNamespace(app.name)}.ui.design.NavyPitchColor
import ${namespace}.${java.nameNamespace(app.name)}.ui.design.NavyPitchDisplayForm
import ${namespace}.${java.nameNamespace(app.name)}.ui.design.NavyPitchDisplayRow
import ${namespace}.${java.nameNamespace(app.name)}.ui.design.NavyPitchDivider
import ${namespace}.${java.nameNamespace(app.name)}.ui.design.NavyPitchEntryForm
import ${namespace}.${java.nameNamespace(app.name)}.ui.design.NavyPitchFieldDate
import ${namespace}.${java.nameNamespace(app.name)}.ui.design.NavyPitchFieldSelect
import ${namespace}.${java.nameNamespace(app.name)}.ui.design.NavyPitchFieldText
import ${namespace}.${java.nameNamespace(app.name)}.ui.design.NavyPitchMatchCard
import ${namespace}.${java.nameNamespace(app.name)}.ui.design.NavyPitchPageShell
import ${namespace}.${java.nameNamespace(app.name)}.ui.design.NavyPitchRadius
import ${namespace}.${java.nameNamespace(app.name)}.ui.design.NavyPitchSpacing
import ${namespace}.${java.nameNamespace(app.name)}.ui.design.NavyPitchType

/**
 * Schedule event detail screen.
 * Displays full information for a single [ScheduleEvent] and supports editing.
 */
@Composable
fun ${java.nameType(page.name)}Screen(
  onBack: () -> Unit
) {

  NavyPitchPageShell(
    topBar = {
      Row(
        modifier = Modifier
          .fillMaxWidth()
          .padding(NavyPitchSpacing.s5, NavyPitchSpacing.s5),
        verticalAlignment = Alignment.CenterVertically
      ) {
        NavyPitchButton(
          label = "← 返回",
          onClick = onBack,
          variant = NavyPitchButtonVariant.Outline,
          size = NavyPitchButtonSize.Sm
        )
        Spacer(Modifier.width(NavyPitchSpacing.s5))
        Text(
          text = "日程详情",
          fontSize = NavyPitchType.TextLg,
          fontWeight = FontWeight.Bold,
          color = NavyPitchColor.TextMain,
          modifier = Modifier.weight(1f)
        )
        NavyPitchButton(
          label = "保存",
          onClick = { },
          variant = NavyPitchButtonVariant.Primary,
          size = NavyPitchButtonSize.Sm
        )
      }
      NavyPitchDivider()
    }
  ) {
    Column(
      modifier = Modifier
        .fillMaxSize()
        .verticalScroll(rememberScrollState())
        .padding(NavyPitchSpacing.s5)
    ) {
      
    }
  }
}
