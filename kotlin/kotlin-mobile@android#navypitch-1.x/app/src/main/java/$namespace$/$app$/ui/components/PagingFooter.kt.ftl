package ${namespace}.${java.nameNamespace(app.name)}.ui.components


import androidx.compose.animation.core.*
import androidx.compose.foundation.Canvas
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.size
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.runtime.getValue
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.rotate
import androidx.compose.ui.graphics.StrokeCap
import androidx.compose.ui.graphics.drawscope.Stroke
import androidx.compose.ui.unit.dp
import ${namespace}.${java.nameNamespace(app.name)}.ui.design.*

@Composable
fun PagingFooter(
  isLoadingMore: Boolean,
  hasMore: Boolean,
  modifier: Modifier = Modifier
) {
  Box(
    modifier = modifier
      .fillMaxWidth()
      .padding(16.dp),
    contentAlignment = Alignment.Center
  ) {
    when {
      isLoadingMore -> {
        LoadMoreSpinner()
      }
      !hasMore -> {
        Text(
          text = "没有更多数据了",
          fontSize = Types.TextSm,
          color = Colors.TextMuted
        )
      }
    }
  }
}

@Composable
private fun LoadMoreSpinner() {
  val transition = rememberInfiniteTransition(label = "loadMore")
  val rotation by transition.animateFloat(
    initialValue = 0f,
    targetValue = 360f,
    animationSpec = infiniteRepeatable(
      animation = tween(durationMillis = 900, easing = LinearEasing),
      repeatMode = RepeatMode.Restart
    ),
    label = "rotation"
  )
  Canvas(
    modifier = Modifier
      .size(24.dp)
      .rotate(rotation)
  ) {
    drawArc(
      color = Colors.Border,
      startAngle = 0f,
      sweepAngle = 360f,
      useCenter = false,
      style = Stroke(width = 2.5.dp.toPx(), cap = StrokeCap.Round)
    )
    drawArc(
      color = Colors.Accent,
      startAngle = 0f,
      sweepAngle = 270f,
      useCenter = false,
      style = Stroke(width = 2.5.dp.toPx(), cap = StrokeCap.Round)
    )
  }
}