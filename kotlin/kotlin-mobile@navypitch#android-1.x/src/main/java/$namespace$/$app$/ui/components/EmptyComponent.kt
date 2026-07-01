package com.doublegsoft.calendarsplitlist.ui.components

import androidx.compose.foundation.background
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.size
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material3.Button
import androidx.compose.material3.ButtonDefaults
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.text.style.TextAlign
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import com.doublegsoft.calendarsplitlist.ui.theme.Amber
import com.doublegsoft.calendarsplitlist.ui.theme.Blue
import com.doublegsoft.calendarsplitlist.ui.theme.Gray500
import com.doublegsoft.calendarsplitlist.ui.theme.Navy800
import com.doublegsoft.calendarsplitlist.ui.theme.Red
import com.doublegsoft.calendarsplitlist.ui.theme.Teal500

/**
 * Action button color variants.
 */
enum class EmptyActionColor { Teal, Amber, Red, Blue, Outline }

/**
 * Empty state component (mirrors mini-program components/empty/empty).
 * Displayed when a list has no content.
 */
@Composable
fun EmptyComponent(
  icon: String = "📭",
  title: String = "暂无数据",
  description: String = "",
  actionText: String = "",
  actionColor: EmptyActionColor = EmptyActionColor.Teal,
  onAction: (() -> Unit)? = null,
  modifier: Modifier = Modifier
) {
  Column(
    modifier = modifier
      .fillMaxWidth()
      .padding(vertical = 48.dp, horizontal = 32.dp),
    horizontalAlignment = Alignment.CenterHorizontally,
    verticalArrangement = Arrangement.Center
  ) {
    // Emoji icon
    if (icon.isNotBlank()) {
      Text(
        text = icon,
        fontSize = 56.sp,
        textAlign = TextAlign.Center
      )
      Spacer(modifier = Modifier.height(16.dp))
    }

    // Title
    if (title.isNotBlank()) {
      Text(
        text = title,
        color = MaterialTheme.colorScheme.onSurface.copy(alpha = 0.7f),
        fontSize = 16.sp,
        fontWeight = FontWeight.Medium,
        textAlign = TextAlign.Center
      )
      Spacer(modifier = Modifier.height(8.dp))
    }

    // Description
    if (description.isNotBlank()) {
      Text(
        text = description,
        color = MaterialTheme.colorScheme.onSurface.copy(alpha = 0.45f),
        fontSize = 13.sp,
        textAlign = TextAlign.Center,
        modifier = Modifier.padding(horizontal = 16.dp)
      )
      Spacer(modifier = Modifier.height(20.dp))
    }

    // Action button
    if (actionText.isNotBlank() && onAction != null) {
      Button(
        onClick = onAction,
        colors = ButtonDefaults.buttonColors(
          containerColor = when (actionColor) {
            EmptyActionColor.Teal -> Teal500
            EmptyActionColor.Amber -> Amber
            EmptyActionColor.Red -> Red
            EmptyActionColor.Blue -> Blue
            EmptyActionColor.Outline -> Color.Transparent
          },
          contentColor = when (actionColor) {
            EmptyActionColor.Outline -> Teal500
            else -> Color.White
          }
        ),
        shape = RoundedCornerShape(20.dp)
      ) {
        Text(
          text = actionText,
          fontSize = 14.sp,
          fontWeight = FontWeight.Medium
        )
      }
    }
  }
}
