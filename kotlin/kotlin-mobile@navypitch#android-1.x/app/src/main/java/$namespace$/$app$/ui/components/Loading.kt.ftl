package ${namespace}.${java.nameNamespace(app.name)}.ui.components

import androidx.compose.animation.core.LinearEasing
import androidx.compose.animation.core.RepeatMode
import androidx.compose.animation.core.animateFloat
import androidx.compose.animation.core.infiniteRepeatable
import androidx.compose.animation.core.rememberInfiniteTransition
import androidx.compose.animation.core.tween
import androidx.compose.foundation.Canvas
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.size
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.runtime.getValue
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.rotate
import androidx.compose.ui.graphics.StrokeCap
import androidx.compose.ui.graphics.drawscope.Stroke
import androidx.compose.ui.text.style.TextAlign
import androidx.compose.ui.unit.dp
import df.displayform.ui.design.Colors
import df.displayform.ui.design.Spacings
import df.displayform.ui.design.Types

/**
 * Loading state component with custom animated spinner.
 */
@Composable
fun Loading(
  message: String = "加载中…",
  modifier: Modifier = Modifier
) {
  val transition = rememberInfiniteTransition(label = "loading")
  val rotation by transition.animateFloat(
    initialValue = 0f,
    targetValue = 360f,
    animationSpec = infiniteRepeatable(
      animation = tween(durationMillis = 900, easing = LinearEasing),
      repeatMode = RepeatMode.Restart
    ),
    label = "rotation"
  )

  Box(
    modifier = modifier.fillMaxSize(),
    contentAlignment = Alignment.Center
  ) {
    Column(
      horizontalAlignment = Alignment.CenterHorizontally,
      verticalArrangement = Arrangement.Center
    ) {
      val accent = Colors.Accent
      val track = Colors.Border

      Canvas(
        modifier = Modifier
          .size(36.dp)
          .rotate(rotation)
      ) {
        // Full track circle (subtle)
        drawArc(
          color = track,
          startAngle = 0f,
          sweepAngle = 360f,
          useCenter = false,
          style = Stroke(width = 3.dp.toPx(), cap = StrokeCap.Round)
        )
        // Sweeping arc
        drawArc(
          color = accent,
          startAngle = 0f,
          sweepAngle = 270f,
          useCenter = false,
          style = Stroke(width = 3.dp.toPx(), cap = StrokeCap.Round)
        )
      }

      if (message.isNotBlank()) {
        Spacer(modifier = Modifier.height(Spacings.s4))
        Text(
          text = message,
          fontSize = Types.TextSm,
          color = Colors.TextMuted,
          textAlign = TextAlign.Center
        )
      }
    }
  }
}
