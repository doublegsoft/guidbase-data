package ${namespace}.${java.nameNamespace(app.name)}.ui.components

import androidx.compose.animation.animateColorAsState
import androidx.compose.animation.core.tween
import androidx.compose.foundation.background
import androidx.compose.foundation.clickable
import androidx.compose.foundation.horizontalScroll
import androidx.compose.foundation.interaction.MutableInteractionSource
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.defaultMinSize
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.rememberScrollState
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.runtime.LaunchedEffect
import androidx.compose.runtime.getValue
import androidx.compose.runtime.remember
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.text.style.TextAlign
import androidx.compose.ui.text.style.TextOverflow
import androidx.compose.ui.unit.dp
import ${namespace}.${java.nameNamespace(app.name)}.ui.design.Colors
import ${namespace}.${java.nameNamespace(app.name)}.ui.design.Radii
import ${namespace}.${java.nameNamespace(app.name)}.ui.design.Spacings
import ${namespace}.${java.nameNamespace(app.name)}.ui.design.Types

/**
 * A segmented control for mutually-exclusive option switching.
 *
 * Renders [items] as a horizontal row of tappable segments. When items exceed
 * the available width the row scrolls horizontally. The active segment is
 * highlighted with a filled pill background and animates color transitions.
 *
 * Usage:
 * ```
 * Segment(
 *   items = listOf("列表", "日历"),
 *   selectedIndex = 0,
 *   onItemSelected = { index -> /* switch view */ }
 * )
 * ```
 *
 * @param items         Labels for each segment option.
 * @param selectedIndex Zero-based index of the currently selected segment.
 * @param onItemSelected Callback invoked with the tapped segment index.
 * @param modifier       Optional modifier for the outer container.
 */
@Composable
fun Segment(
  items: List<String>,
  selectedIndex: Int = 0,
  onItemSelected: (Int) -> Unit,
  modifier: Modifier = Modifier
) {
  if (items.isEmpty()) return

  val shape = RoundedCornerShape(Radii.Pill)
  val scrollState = rememberScrollState()

  // Auto-scroll the selected segment into view (snap to nearest edge)
  LaunchedEffect(selectedIndex) {
    if (items.size <= 1) return@LaunchedEffect
    // Estimate item width — rough but sufficient for scroll-to-reveal
    val estItemWidth = 80 // dp-equivalent pixels approximated below
    val target = (estItemWidth * selectedIndex - scrollState.viewportSize / 2 + estItemWidth / 2)
      .coerceIn(0, scrollState.maxValue)
    scrollState.animateScrollTo(target)
  }

  Row(
    modifier = modifier
      .clip(shape)
      .background(Colors.Surface)
      .padding(Spacings.s1)
      .horizontalScroll(scrollState),
    horizontalArrangement = Arrangement.spacedBy(Spacings.s1)
  ) {
    items.forEachIndexed { index, label ->
      val isSelected = index == selectedIndex

      val bgColor by animateColorAsState(
        targetValue = if (isSelected) Colors.Accent else Color.Transparent,
        animationSpec = tween(200),
        label = "segmentBg"
      )
      val textColor by animateColorAsState(
        targetValue = if (isSelected) Colors.White else Colors.TextSecondary,
        animationSpec = tween(200),
        label = "segmentText"
      )

      Box(
        modifier = Modifier
          .clip(shape)
          .background(bgColor)
          .clickable(
            onClick = { onItemSelected(index) },
            interactionSource = remember { MutableInteractionSource() },
            indication = null
          )
          .padding(horizontal = Spacings.s5, vertical = Spacings.s2)
          .defaultMinSize(minWidth = 56.dp)
          .height(32.dp),
        contentAlignment = Alignment.Center
      ) {
        Text(
          text = label,
          fontSize = Types.TextSm,
          fontWeight = if (isSelected) FontWeight.SemiBold else FontWeight.Normal,
          color = textColor,
          textAlign = TextAlign.Center,
          maxLines = 1,
          overflow = TextOverflow.Ellipsis
        )
      }
    }
  }
}
