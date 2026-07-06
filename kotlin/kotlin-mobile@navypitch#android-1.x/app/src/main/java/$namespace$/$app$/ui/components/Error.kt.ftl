package ${namespace}.${java.nameNamespace(app.name)}.ui.components

import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.height
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.text.style.TextAlign
import androidx.compose.ui.unit.sp
import ${namespace}.${java.nameNamespace(app.name)}.ui.design.Button
import ${namespace}.${java.nameNamespace(app.name)}.ui.design.ButtonSize
import ${namespace}.${java.nameNamespace(app.name)}.ui.design.ButtonVariant
import ${namespace}.${java.nameNamespace(app.name)}.ui.design.Colors
import ${namespace}.${java.nameNamespace(app.name)}.ui.design.Spacings
import ${namespace}.${java.nameNamespace(app.name)}.ui.design.Types

/**
 * Error state component with retry action.
 */
@Composable
fun Error(
  message: String = "",
  title: String = "加载失败",
  retryLabel: String = "",
  onRetry: (() -> Unit)? = null,
  modifier: Modifier = Modifier
) {
  Box(
    modifier = modifier.fillMaxSize(),
    contentAlignment = Alignment.Center
  ) {
    Column(
      horizontalAlignment = Alignment.CenterHorizontally,
      verticalArrangement = Arrangement.Center
    ) {
      Text(text = "⚠️", fontSize = 48.sp)

      if (title.isNotBlank()) {
        Spacer(modifier = Modifier.height(Spacings.s4))
        Text(
          text = title,
          fontSize = Types.TextMd,
          fontWeight = FontWeight.SemiBold,
          color = Colors.TextMain
        )
      }

      if (message.isNotBlank()) {
        Spacer(modifier = Modifier.height(Spacings.s2))
        Text(
          text = message,
          fontSize = Types.TextSm,
          color = Colors.TextMuted,
          textAlign = TextAlign.Center
        )
      }

      if (retryLabel.isNotBlank() && onRetry != null) {
        Spacer(modifier = Modifier.height(Spacings.s6))
        Button(
          label = retryLabel,
          onClick = onRetry,
          variant = ButtonVariant.Primary,
          size = ButtonSize.Md
        )
      }
    }
  }
}
