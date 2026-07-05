package ${namespace}.${java.nameNamespace(app.name)}.ui.design

import androidx.compose.foundation.background
import androidx.compose.foundation.border
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.ExperimentalLayoutApi
import androidx.compose.foundation.layout.FlowRow
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.RowScope
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.width
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.foundation.text.KeyboardOptions
import androidx.compose.material3.DropdownMenuItem
import androidx.compose.material3.ExperimentalMaterial3Api
import androidx.compose.material3.ExposedDropdownMenuBox
import androidx.compose.material3.ExposedDropdownMenuDefaults
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.OutlinedTextField
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.runtime.setValue
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.graphics.Brush
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.text.input.KeyboardType
import androidx.compose.ui.text.style.TextAlign
import androidx.compose.ui.text.style.TextOverflow
import androidx.compose.ui.unit.Dp
import androidx.compose.ui.unit.dp

// ═══════════════════════════════════════════════════════════════════════════
// INTERNAL — shared row layouts
// ═══════════════════════════════════════════════════════════════════════════

@Composable
private fun FieldRow(
  label: String,
  labelWidth: Dp,
  modifier: Modifier = Modifier,
  content: @Composable RowScope.() -> Unit
) {
  Row(
    modifier = modifier
      .fillMaxWidth()
      .padding(horizontal = Spacings.s5, vertical = Spacings.s4),
    verticalAlignment = Alignment.CenterVertically
  ) {
    Text(
      text = label,
      fontSize = Types.TextSm,
      color = Colors.TextSub,
      modifier = Modifier.width(labelWidth)
    )
    Spacer(Modifier.width(Spacings.s4))
    content()
  }
}

@Composable
private fun FieldRowTop(
  label: String,
  labelWidth: Dp,
  modifier: Modifier = Modifier,
  content: @Composable RowScope.() -> Unit
) {
  Row(
    modifier = modifier
      .fillMaxWidth()
      .padding(horizontal = Spacings.s5, vertical = Spacings.s4),
    verticalAlignment = Alignment.Top
  ) {
    Text(
      text = label,
      fontSize = Types.TextSm,
      color = Colors.TextSub,
      modifier = Modifier.width(labelWidth).padding(top = 2.dp)
    )
    Spacer(Modifier.width(Spacings.s4))
    content()
  }
}

@Composable
private fun InputRow(
  label: String,
  required: Boolean,
  modifier: Modifier = Modifier,
  content: @Composable () -> Unit
) {
  Column(modifier = modifier.fillMaxWidth()) {
    FieldLabel(text = label, required = required)
    Spacer(Modifier.height(Spacings.s1))
    content()
  }
}

@Composable
private fun FieldLabel(text: String, required: Boolean) {
  Row {
    Text(
      text = text,
      fontSize = Types.TextSm,
      fontWeight = FontWeight.Medium,
      color = Colors.TextMain
    )
    if (required) {
      Text(
        text = " *",
        fontSize = Types.TextSm,
        color = Colors.Danger
      )
    }
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// TEXT DISPLAY — label + value
// ═══════════════════════════════════════════════════════════════════════════

@Composable
fun TextDisplay(
  label: String,
  value: String?,
  labelWidth: Dp = 80.dp,
  modifier: Modifier = Modifier
) {
  FieldRow(label = label, labelWidth = labelWidth, modifier = modifier) {
    Text(
      text = value?.ifBlank { "—" } ?: "—",
      fontSize = Types.TextSm,
      fontWeight = FontWeight.Medium,
      color = Colors.TextMain,
      maxLines = 1,
      overflow = TextOverflow.Ellipsis,
      modifier = Modifier.weight(1f)
    )
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// NUMBER DISPLAY — label + numeric value (right-aligned)
// ═══════════════════════════════════════════════════════════════════════════

@Composable
fun NumberDisplay(
  label: String,
  value: String?,
  labelWidth: Dp = 80.dp,
  modifier: Modifier = Modifier
) {
  FieldRow(label = label, labelWidth = labelWidth, modifier = modifier) {
    Text(
      text = value?.ifBlank { "—" } ?: "—",
      fontSize = Types.TextSm,
      fontWeight = FontWeight.Medium,
      color = Colors.TextMain,
      textAlign = TextAlign.End,
      modifier = Modifier.weight(1f)
    )
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// DATE DISPLAY — label + formatted date
// ═══════════════════════════════════════════════════════════════════════════

@Composable
fun DateDisplay(
  label: String,
  value: String?,
  labelWidth: Dp = 80.dp,
  modifier: Modifier = Modifier
) {
  TextDisplay(label = label, value = value, labelWidth = labelWidth, modifier = modifier)
}

// ═══════════════════════════════════════════════════════════════════════════
// TIME DISPLAY — label + formatted time
// ═══════════════════════════════════════════════════════════════════════════

@Composable
fun TimeDisplay(
  label: String,
  value: String?,
  labelWidth: Dp = 80.dp,
  modifier: Modifier = Modifier
) {
  TextDisplay(label = label, value = value, labelWidth = labelWidth, modifier = modifier)
}

// ═══════════════════════════════════════════════════════════════════════════
// SELECT DISPLAY — label + colored badge pill
// ═══════════════════════════════════════════════════════════════════════════

@Composable
fun SelectDisplay(
  label: String,
  value: String?,
  color: Color = Colors.Accent,
  labelWidth: Dp = 80.dp,
  modifier: Modifier = Modifier
) {
  FieldRow(label = label, labelWidth = labelWidth, modifier = modifier) {
    val display = value?.ifBlank { null } ?: "—"
    Box(
      modifier = Modifier
        .clip(RoundedCornerShape(Radii.Pill))
        .background(color.copy(alpha = 0.12f))
        .padding(horizontal = Spacings.s4, vertical = Spacings.s2)
    ) {
      Text(
        text = display,
        fontSize = Types.TextXs,
        fontWeight = FontWeight.SemiBold,
        color = color
      )
    }
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// OPTIONS DISPLAY — label + flow-row of bordered chips
// ═══════════════════════════════════════════════════════════════════════════

@OptIn(ExperimentalLayoutApi::class)
@Composable
fun OptionsDisplay(
  label: String,
  options: List<String>,
  labelWidth: Dp = 80.dp,
  accent: Color = Colors.Accent,
  modifier: Modifier = Modifier
) {
  FieldRowTop(label = label, labelWidth = labelWidth, modifier = modifier) {
    if (options.isEmpty()) {
      Text(text = "—", fontSize = Types.TextSm, color = Colors.TextMuted)
    } else {
      FlowRow(
        horizontalArrangement = Arrangement.spacedBy(Spacings.s2),
        verticalArrangement = Arrangement.spacedBy(Spacings.s1),
        modifier = Modifier.weight(1f)
      ) {
        options.forEach { opt ->
          Box(
            modifier = Modifier
              .clip(RoundedCornerShape(Radii.Sm))
              .border(1.dp, accent.copy(alpha = 0.3f), RoundedCornerShape(Radii.Sm))
              .background(accent.copy(alpha = 0.08f))
              .padding(horizontal = Spacings.s3, vertical = Spacings.s1)
          ) {
            Text(
              text = opt,
              fontSize = Types.Text2xs,
              fontWeight = FontWeight.Medium,
              color = accent
            )
          }
        }
      }
    }
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// TAGS DISPLAY — label + flow-row of colored pills
// ═══════════════════════════════════════════════════════════════════════════

val TagPalette = listOf(
  Colors.AccentText to Colors.AccentDim,
  Colors.WarningText to Colors.WarningDim,
  Colors.InfoText to Colors.InfoDim,
  Colors.DecorativeText to Colors.DecorativeDim,
  Colors.DangerText to Colors.DangerDim
)

@OptIn(ExperimentalLayoutApi::class)
@Composable
fun TagsDisplay(
  label: String,
  tags: List<String>,
  labelWidth: Dp = 80.dp,
  modifier: Modifier = Modifier
) {
  FieldRowTop(label = label, labelWidth = labelWidth, modifier = modifier) {
    if (tags.isEmpty()) {
      Text(text = "—", fontSize = Types.TextSm, color = Colors.TextMuted)
    } else {
      FlowRow(
        horizontalArrangement = Arrangement.spacedBy(Spacings.s2),
        verticalArrangement = Arrangement.spacedBy(Spacings.s1),
        modifier = Modifier.weight(1f)
      ) {
        tags.forEachIndexed { index, tag ->
          val (textColor, bgColor) = TagPalette[index % TagPalette.size]
          Box(
            modifier = Modifier
              .clip(RoundedCornerShape(Radii.Pill))
              .background(bgColor)
              .padding(horizontal = Spacings.s3, vertical = Spacings.s1)
          ) {
            Text(
              text = tag,
              fontSize = Types.Text2xs,
              fontWeight = FontWeight.SemiBold,
              color = textColor
            )
          }
        }
      }
    }
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// LONG TEXT DISPLAY — label + multi-line text
// ═══════════════════════════════════════════════════════════════════════════

@Composable
fun LongTextDisplay(
  label: String,
  value: String?,
  labelWidth: Dp = 80.dp,
  maxLines: Int = 5,
  modifier: Modifier = Modifier
) {
  FieldRowTop(label = label, labelWidth = labelWidth, modifier = modifier) {
    Text(
      text = value?.ifBlank { "—" } ?: "—",
      fontSize = Types.TextSm,
      fontWeight = FontWeight.Medium,
      color = Colors.TextMain,
      maxLines = maxLines,
      overflow = TextOverflow.Ellipsis,
      modifier = Modifier.weight(1f)
    )
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// TEXT INPUT — label + single-line text field
// ═══════════════════════════════════════════════════════════════════════════

@Composable
fun TextInput(
  label: String,
  value: String,
  onValueChange: (String) -> Unit,
  required: Boolean = false,
  placeholder: String = "",
  modifier: Modifier = Modifier
) {
  InputRow(label = label, required = required, modifier = modifier) {
    OutlinedTextField(
      value = value,
      onValueChange = onValueChange,
      placeholder = { if (placeholder.isNotBlank()) Text(placeholder, fontSize = Types.TextSm, color = Colors.TextMuted) },
      modifier = Modifier.fillMaxWidth(),
      shape = RoundedCornerShape(Radii.Sm),
      singleLine = true,
      textStyle = MaterialTheme.typography.bodyMedium.copy(color = Colors.TextMain)
    )
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// NUMBER INPUT — label + numeric text field
// ═══════════════════════════════════════════════════════════════════════════

@Composable
fun NumberInput(
  label: String,
  value: String,
  onValueChange: (String) -> Unit,
  required: Boolean = false,
  placeholder: String = "",
  modifier: Modifier = Modifier
) {
  InputRow(label = label, required = required, modifier = modifier) {
    OutlinedTextField(
      value = value,
      onValueChange = onValueChange,
      placeholder = { if (placeholder.isNotBlank()) Text(placeholder, fontSize = Types.TextSm, color = Colors.TextMuted) },
      modifier = Modifier.fillMaxWidth(),
      shape = RoundedCornerShape(Radii.Sm),
      singleLine = true,
      keyboardOptions = KeyboardOptions(keyboardType = KeyboardType.Decimal),
      textStyle = MaterialTheme.typography.bodyMedium.copy(color = Colors.TextMain)
    )
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// DATE INPUT — label + date field (YYYY-MM-DD)
// ═══════════════════════════════════════════════════════════════════════════

@Composable
fun DateInput(
  label: String,
  value: String,
  onValueChange: (String) -> Unit,
  required: Boolean = false,
  modifier: Modifier = Modifier
) {
  InputRow(label = label, required = required, modifier = modifier) {
    OutlinedTextField(
      value = value,
      onValueChange = onValueChange,
      placeholder = { Text("YYYY-MM-DD", fontSize = Types.TextSm, color = Colors.TextMuted) },
      modifier = Modifier.fillMaxWidth(),
      shape = RoundedCornerShape(Radii.Sm),
      singleLine = true,
      keyboardOptions = KeyboardOptions(keyboardType = KeyboardType.Number),
      textStyle = MaterialTheme.typography.bodyMedium.copy(color = Colors.TextMain)
    )
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// TIME INPUT — label + time field (HH:mm)
// ═══════════════════════════════════════════════════════════════════════════

@Composable
fun TimeInput(
  label: String,
  value: String,
  onValueChange: (String) -> Unit,
  required: Boolean = false,
  modifier: Modifier = Modifier
) {
  InputRow(label = label, required = required, modifier = modifier) {
    OutlinedTextField(
      value = value,
      onValueChange = onValueChange,
      placeholder = { Text("HH:mm", fontSize = Types.TextSm, color = Colors.TextMuted) },
      modifier = Modifier.fillMaxWidth(),
      shape = RoundedCornerShape(Radii.Sm),
      singleLine = true,
      keyboardOptions = KeyboardOptions(keyboardType = KeyboardType.Number),
      textStyle = MaterialTheme.typography.bodyMedium.copy(color = Colors.TextMain)
    )
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// SELECT INPUT — label + dropdown
// ═══════════════════════════════════════════════════════════════════════════

@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun SelectInput(
  label: String,
  value: String,
  options: List<String>,
  onValueChange: (String) -> Unit,
  required: Boolean = false,
  modifier: Modifier = Modifier
) {
  var expanded by remember { mutableStateOf(false) }

  InputRow(label = label, required = required, modifier = modifier) {
    ExposedDropdownMenuBox(
      expanded = expanded,
      onExpandedChange = { expanded = it }
    ) {
      OutlinedTextField(
        value = value,
        onValueChange = {},
        readOnly = true,
        modifier = Modifier.fillMaxWidth().menuAnchor(),
        shape = RoundedCornerShape(Radii.Sm),
        singleLine = true,
        textStyle = MaterialTheme.typography.bodyMedium.copy(color = Colors.TextMain),
        trailingIcon = { ExposedDropdownMenuDefaults.TrailingIcon(expanded = expanded) },
        colors = ExposedDropdownMenuDefaults.outlinedTextFieldColors()
      )
      ExposedDropdownMenu(
        expanded = expanded,
        onDismissRequest = { expanded = false }
      ) {
        options.forEach { option ->
          DropdownMenuItem(
            text = { Text(option) },
            onClick = {
              onValueChange(option)
              expanded = false
            }
          )
        }
      }
    }
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// LONG TEXT INPUT — label + multi-line text field
// ═══════════════════════════════════════════════════════════════════════════

@Composable
fun LongTextInput(
  label: String,
  value: String,
  onValueChange: (String) -> Unit,
  required: Boolean = false,
  placeholder: String = "",
  minLines: Int = 3,
  modifier: Modifier = Modifier
) {
  InputRow(label = label, required = required, modifier = modifier) {
    OutlinedTextField(
      value = value,
      onValueChange = onValueChange,
      placeholder = { if (placeholder.isNotBlank()) Text(placeholder, fontSize = Types.TextSm, color = Colors.TextMuted) },
      modifier = Modifier.fillMaxWidth(),
      shape = RoundedCornerShape(Radii.Sm),
      singleLine = false,
      minLines = minLines,
      textStyle = MaterialTheme.typography.bodyMedium.copy(color = Colors.TextMain)
    )
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// SECTION HEADER — title + subtitle with colored accent bar
// ═══════════════════════════════════════════════════════════════════════════

@Composable
fun SectionHeader(
  title: String,
  subtitle: String = "",
  accent: Color = Colors.Accent,
  modifier: Modifier = Modifier
) {
  Row(
    modifier = modifier
      .fillMaxWidth()
      .padding(start = Spacings.s5, end = Spacings.s5, top = Spacings.s3),
    verticalAlignment = Alignment.CenterVertically
  ) {
    Box(
      modifier = Modifier
        .width(3.dp)
        .height(18.dp)
        .clip(RoundedCornerShape(2.dp))
        .background(accent)
    )
    Spacer(Modifier.width(Spacings.s3))
    Text(
      text = title,
      fontSize = Types.TextMd,
      fontWeight = FontWeight.Bold,
      color = Colors.TextMain
    )
    if (subtitle.isNotBlank()) {
      Spacer(Modifier.width(Spacings.s2))
      Text(
        text = subtitle,
        fontSize = Types.Text2xs,
        color = Colors.TextMuted
      )
    }
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// FIELD DIVIDER — indented separator between field rows
// ═══════════════════════════════════════════════════════════════════════════

@Composable
fun FieldDivider(
  indent: Dp = Spacings.s9,
  modifier: Modifier = Modifier
) {
  Box(
    modifier = modifier
      .fillMaxWidth()
      .padding(start = indent)
      .height(1.dp)
      .background(Colors.Border.copy(alpha = 0.5f))
  )
}

// ═══════════════════════════════════════════════════════════════════════════
// HERO CARD — gradient background card for primary entity display
// ═══════════════════════════════════════════════════════════════════════════

@Composable
fun HeroCard(
  title: String,
  subtitle: (@Composable () -> Unit)? = null,
  tags: List<String> = emptyList(),
  gradient: List<Color> = listOf(Colors.Primary, Colors.PrimaryLight),
  modifier: Modifier = Modifier
) {
  Box(
    modifier = modifier
      .fillMaxWidth()
      .padding(Spacings.s5)
      .clip(RoundedCornerShape(Radii.Xxl))
      .background(Brush.verticalGradient(colors = gradient))
  ) {
    Column(modifier = Modifier.padding(Spacings.s7)) {
      Text(
        text = title.ifBlank { "—" },
        fontSize = Types.Text5xl,
        fontWeight = FontWeight.Bold,
        color = Colors.White
      )
      if (subtitle != null) {
        Spacer(Modifier.height(Spacings.s2))
        subtitle()
      }
      if (tags.isNotEmpty()) {
        Spacer(Modifier.height(Spacings.s5))
        Row(horizontalArrangement = Arrangement.spacedBy(Spacings.s2)) {
          tags.forEach { tag ->
            Box(
              modifier = Modifier
                .clip(RoundedCornerShape(Radii.Xs))
                .background(Colors.White.copy(alpha = 0.12f))
                .padding(horizontal = Spacings.s3, vertical = Spacings.s1)
            ) {
              Text(
                text = tag,
                fontSize = Types.Text2xs,
                color = Colors.White.copy(alpha = 0.85f),
                fontWeight = FontWeight.Medium
              )
            }
          }
        }
      }
    }
  }
}
