package ${namespace}.${java.nameNamespace(app.name)}.ui.design

import androidx.compose.foundation.background
import androidx.compose.foundation.border
import androidx.compose.foundation.clickable
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.ColumnScope
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.size
import androidx.compose.foundation.layout.width
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.foundation.text.KeyboardOptions
import androidx.compose.material3.ButtonDefaults
import androidx.compose.material3.DropdownMenuItem
import androidx.compose.material3.ExperimentalMaterial3Api
import androidx.compose.material3.ExposedDropdownMenuBox
import androidx.compose.material3.ExposedDropdownMenuDefaults
import androidx.compose.material3.Icon
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.OutlinedButton
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
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.graphics.SolidColor
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.text.input.KeyboardType
import androidx.compose.ui.unit.dp

// ═══════════════════════════════════════════════════════════════════════
// Button
// ═══════════════════════════════════════════════════════════════════════

enum class ButtonVariant { Primary, Outline }
enum class ButtonSize { Sm, Md, Lg }

@Composable
fun Button(
  label: String,
  onClick: () -> Unit,
  variant: ButtonVariant = ButtonVariant.Primary,
  size: ButtonSize = ButtonSize.Md,
  modifier: Modifier = Modifier
) {
  val height = when (size) {
    ButtonSize.Sm -> 32.dp
    ButtonSize.Md -> 40.dp
    ButtonSize.Lg -> 48.dp
  }
  val fontSize = when (size) {
    ButtonSize.Sm -> Types.TextXs
    ButtonSize.Md -> Types.TextSm
    ButtonSize.Lg -> Types.TextBase
  }
  val shape = RoundedCornerShape(Radii.Sm)

  when (variant) {
    ButtonVariant.Primary -> androidx.compose.material3.Button(
      onClick = onClick,
      modifier = modifier.height(height),
      shape = shape,
      colors = ButtonDefaults.buttonColors(containerColor = Colors.Accent)
    ) {
      Text(label, fontSize = fontSize, fontWeight = FontWeight.Medium)
    }
    ButtonVariant.Outline -> OutlinedButton(
      onClick = onClick,
      modifier = modifier.height(height),
      shape = shape,
      colors = ButtonDefaults.outlinedButtonColors(contentColor = Colors.Accent),
      border = ButtonDefaults.outlinedButtonBorder.copy(brush = SolidColor(Colors.Border))
    ) {
      Text(label, fontSize = fontSize, fontWeight = FontWeight.Medium)
    }
  }
}

// ═══════════════════════════════════════════════════════════════════════
// Divider
// ═══════════════════════════════════════════════════════════════════════

@Composable
fun Divider(modifier: Modifier = Modifier) {
  androidx.compose.material3.Divider(
    modifier = modifier.fillMaxWidth(),
    thickness = 1.dp,
    color = Colors.Border
  )
}

// ═══════════════════════════════════════════════════════════════════════
// Card
// ═══════════════════════════════════════════════════════════════════════

/**
 * Card with integrated title header and content area.
 *
 * Title area (when [title] is not blank) renders with an accent bar,
 * subtitle, and Surface background — separated from [content] by a divider.
 *
 * Usage:
 * ```
 * Card(title = "基本信息", accent = Colors.Accent) {
 *     // fields …
 * }
 * ```
 */
@Composable
fun Card(
  title: String = "",
  subtitle: String = "",
  accent: Color = Colors.Accent,
  modifier: Modifier = Modifier,
  content: @Composable ColumnScope.() -> Unit
) {
  Column(
    modifier = modifier
      .fillMaxWidth()
      .clip(RoundedCornerShape(Radii.Lg))
      .background(Colors.Card)
      .border(1.dp, Colors.Border, RoundedCornerShape(Radii.Lg))
  ) {
    if (title.isNotBlank()) {
      Row(
        modifier = Modifier
          .fillMaxWidth()
          .background(Colors.Surface)
          .padding(horizontal = Spacings.s5, vertical = Spacings.s4),
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
      Divider()
    }
    Column(modifier = Modifier.padding(Spacings.s5)) {
      content()
    }
  }
}

// ═══════════════════════════════════════════════════════════════════════
// Page Shell
// ═══════════════════════════════════════════════════════════════════════

@Composable
fun PageShell(
  topBar: @Composable () -> Unit,
  modifier: Modifier = Modifier,
  content: @Composable () -> Unit
) {
  Column(
    modifier = modifier
      .fillMaxSize()
      .background(Colors.Bg)
  ) {
    topBar()
    content()
  }
}

// ═══════════════════════════════════════════════════════════════════════
// Entry Form (editable fields container)
// ═══════════════════════════════════════════════════════════════════════

@Composable
fun EntryForm(
  title: String = "",
  description: String = "",
  modifier: Modifier = Modifier,
  content: @Composable ColumnScope.() -> Unit
) {
  Column(modifier = modifier.fillMaxWidth()) {
    if (title.isNotBlank()) {
      Text(
        text = title,
        fontSize = Types.TextLg,
        fontWeight = FontWeight.Bold,
        color = Colors.TextMain
      )
      if (description.isNotBlank()) {
        Spacer(Modifier.height(Spacings.s1))
        Text(
          text = description,
          fontSize = Types.TextXs,
          color = Colors.TextMuted
        )
      }
      Spacer(Modifier.height(Spacings.s5))
    }
    Column(verticalArrangement = Arrangement.spacedBy(Spacings.s4)) {
      content()
    }
  }
}

// ═══════════════════════════════════════════════════════════════════════
// Field — Text
// ═══════════════════════════════════════════════════════════════════════

@Composable
fun FieldText(
  label: String,
  value: String,
  onValueChange: (String) -> Unit,
  required: Boolean = false,
  placeholder: String = "",
  modifier: Modifier = Modifier
) {
  Column(modifier = modifier.fillMaxWidth()) {
    FieldLabel(label = label, required = required)
    Spacer(Modifier.height(Spacings.s1))
    OutlinedTextField(
      value = value,
      onValueChange = onValueChange,
      placeholder = { Text(placeholder, fontSize = Types.TextSm, color = Colors.TextMuted) },
      modifier = Modifier.fillMaxWidth(),
      shape = RoundedCornerShape(Radii.Sm),
      singleLine = true,
      textStyle = MaterialTheme.typography.bodyMedium.copy(color = Colors.TextMain)
    )
  }
}

// ═══════════════════════════════════════════════════════════════════════
// Field — Select (dropdown)
// ═══════════════════════════════════════════════════════════════════════

@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun FieldSelect(
  label: String,
  value: String,
  options: List<String>,
  onValueChange: (String) -> Unit,
  required: Boolean = false,
  modifier: Modifier = Modifier
) {
  var expanded by remember { mutableStateOf(false) }

  Column(modifier = modifier.fillMaxWidth()) {
    FieldLabel(label = label, required = required)
    Spacer(Modifier.height(Spacings.s1))
    ExposedDropdownMenuBox(
      expanded = expanded,
      onExpandedChange = { expanded = it }
    ) {
      OutlinedTextField(
        value = value,
        onValueChange = {},
        readOnly = true,
        modifier = Modifier
          .fillMaxWidth()
          .menuAnchor(),
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

// ═══════════════════════════════════════════════════════════════════════
// Field — Date
// ═══════════════════════════════════════════════════════════════════════

@Composable
fun FieldDate(
  label: String,
  value: String,
  onValueChange: (String) -> Unit,
  required: Boolean = false,
  modifier: Modifier = Modifier
) {
  Column(modifier = modifier.fillMaxWidth()) {
    FieldLabel(label = label, required = required)
    Spacer(Modifier.height(Spacings.s1))
    OutlinedTextField(
      value = value,
      onValueChange = onValueChange,
      placeholder = { Text("YYYY-MM-DD", fontSize = Types.TextSm, color = Colors.TextMuted) },
      modifier = Modifier.fillMaxWidth(),
      shape = RoundedCornerShape(Radii.Sm),
      singleLine = true,
      textStyle = MaterialTheme.typography.bodyMedium.copy(color = Colors.TextMain),
      keyboardOptions = KeyboardOptions(keyboardType = KeyboardType.Number)
    )
  }
}

// ═══════════════════════════════════════════════════════════════════════
// Display Form (read-only fields container)
// ═══════════════════════════════════════════════════════════════════════

@Composable
fun DisplayForm(
  modifier: Modifier = Modifier,
  content: @Composable ColumnScope.() -> Unit
) {
  Column(
    modifier = modifier.fillMaxWidth(),
    verticalArrangement = Arrangement.spacedBy(0.dp)
  ) {
    content()
  }
}

// ═══════════════════════════════════════════════════════════════════════
// Display Row (read-only label-value pair)
// ═══════════════════════════════════════════════════════════════════════

@Composable
fun DisplayRow(
  label: String,
  value: String,
  modifier: Modifier = Modifier
) {
  Row(
    modifier = modifier
      .fillMaxWidth()
      .padding(vertical = Spacings.s3),
    verticalAlignment = Alignment.Top
  ) {
    Text(
      text = label,
      fontSize = Types.TextSm,
      color = Colors.TextSub,
      modifier = Modifier.width(64.dp)
    )
    Spacer(Modifier.width(Spacings.s4))
    Text(
      text = value.ifBlank { "-" },
      fontSize = Types.TextSm,
      fontWeight = FontWeight.Medium,
      color = Colors.TextMain,
      modifier = Modifier.weight(1f)
    )
  }
}

// ═══════════════════════════════════════════════════════════════════════
// Match Card (hero-style card for schedule events)
// ═══════════════════════════════════════════════════════════════════════

@Composable
fun MatchCard(
  league: String,
  homeTeam: String,
  awayTeam: String,
  homeScore: Int,
  awayScore: Int,
  modifier: Modifier = Modifier,
  footer: (@Composable () -> Unit)? = null
) {
  Column(
    modifier = modifier
      .fillMaxWidth()
      .clip(RoundedCornerShape(Radii.Xl))
      .background(Colors.Primary)
      .padding(Spacings.s7)
  ) {
    // League/tag label
    Text(
      text = league,
      fontSize = Types.TextXs,
      color = Colors.Accent,
      fontWeight = FontWeight.SemiBold
    )

    Spacer(Modifier.height(Spacings.s5))

    // Home team
    Text(
      text = homeTeam.ifBlank { "—" },
      fontSize = Types.Text3xl,
      fontWeight = FontWeight.Bold,
      color = Colors.White
    )

    // Score
    Text(
      text = "$homeScore : $awayScore",
      fontSize = Types.TextXl,
      fontWeight = FontWeight.Bold,
      color = Colors.Accent
    )

    // Away team
    Text(
      text = awayTeam.ifBlank { "—" },
      fontSize = Types.Text3xl,
      fontWeight = FontWeight.Bold,
      color = Colors.White
    )

    if (footer != null) {
      Spacer(Modifier.height(Spacings.s5))
      Divider()
      Spacer(Modifier.height(Spacings.s4))
      footer()
    }
  }
}

// ═══════════════════════════════════════════════════════════════════════
// Shared helpers
// ═══════════════════════════════════════════════════════════════════════

@Composable
private fun FieldLabel(label: String, required: Boolean) {
  Row {
    Text(
      text = label,
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
