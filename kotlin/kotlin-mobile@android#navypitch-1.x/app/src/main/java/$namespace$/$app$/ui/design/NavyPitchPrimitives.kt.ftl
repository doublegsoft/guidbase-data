package ${namespace}.${java.nameNamespace(app.name)}.ui.design

import android.graphics.Bitmap
import android.graphics.BitmapFactory
import android.media.MediaMetadataRetriever
import android.net.Uri
import java.text.SimpleDateFormat
import java.util.Calendar
import java.util.Locale
import androidx.activity.compose.rememberLauncherForActivityResult
import androidx.activity.result.PickVisualMediaRequest
import androidx.activity.result.contract.ActivityResultContracts
import androidx.compose.foundation.Image
import androidx.compose.foundation.background
import androidx.compose.foundation.border
import androidx.compose.foundation.clickable
import androidx.compose.foundation.interaction.MutableInteractionSource
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.defaultMinSize
import androidx.compose.foundation.layout.ExperimentalLayoutApi
import androidx.compose.foundation.layout.FlowRow
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.RowScope
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.size
import androidx.compose.foundation.layout.width
import androidx.compose.foundation.shape.CircleShape
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.foundation.text.BasicTextField
import androidx.compose.foundation.text.KeyboardOptions
import androidx.compose.material3.AlertDialog
import androidx.compose.material3.Checkbox
import androidx.compose.material3.CheckboxDefaults
import androidx.compose.material3.DatePicker
import androidx.compose.material3.DatePickerDialog
import androidx.compose.material3.DropdownMenu
import androidx.compose.material3.DropdownMenuItem
import androidx.compose.material3.ExposedDropdownMenuDefaults
import androidx.compose.material3.Text
import androidx.compose.material3.TextButton
import androidx.compose.material3.TimePicker
import androidx.compose.material3.rememberDatePickerState
import androidx.compose.material3.rememberTimePickerState
import androidx.compose.runtime.Composable
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.produceState
import androidx.compose.runtime.remember
import androidx.compose.runtime.setValue
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.graphics.Brush
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.graphics.asImageBitmap
import androidx.compose.ui.layout.ContentScale
import androidx.compose.ui.platform.LocalContext
import androidx.compose.ui.text.TextStyle
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.text.input.KeyboardType
import androidx.compose.ui.text.style.TextOverflow
import androidx.compose.ui.unit.Dp
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import df.entryform.model.Option
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.withContext

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
      color = if (value.isNullOrBlank()) Colors.TextMuted else Colors.TextMain,
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
      color = if (value.isNullOrBlank()) Colors.TextMuted else Colors.TextMain,
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
    if (display == "—") {
      Text(
        text = value?.ifBlank { "—" } ?: "—",
        fontSize = Types.TextSm,
        fontWeight = FontWeight.Medium,
        color = Colors.TextMuted,
        maxLines = 1,
        overflow = TextOverflow.Ellipsis,
        modifier = Modifier.weight(1f)
      )
      return@FieldRow
    }
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
      color = if (value.isNullOrBlank()) Colors.TextMuted else Colors.TextMain,
      maxLines = maxLines,
      overflow = TextOverflow.Ellipsis,
      modifier = Modifier.weight(1f)
    )
  }
}

// ── Shared Custom BasicTextField for Sleek/Compact Style ─────────────────

@Composable
private fun BaseCompactTextField(
  value: String,
  onValueChange: (String) -> Unit,
  modifier: Modifier = Modifier,
  placeholder: String = "",
  readOnly: Boolean = false,
  singleLine: Boolean = true,
  minLines: Int = 1,
  keyboardOptions: KeyboardOptions = KeyboardOptions.Default,
  trailingIcon: @Composable (() -> Unit)? = null
) {
  BasicTextField(
    value = value,
    onValueChange = onValueChange,
    readOnly = readOnly,
    singleLine = singleLine,
    minLines = minLines,
    keyboardOptions = keyboardOptions,
    textStyle = TextStyle(
      fontSize = 12.sp, // 精简字体尺寸
      color = Colors.TextMain
    ),
    modifier = modifier,
    decorationBox = { innerTextField ->
      Row(
        modifier = Modifier
          .fillMaxWidth()
          .defaultMinSize(minHeight = 32.dp) // 将默认高度从 36dp+ 严控在 32dp
          .background(Colors.Surface, RoundedCornerShape(Radii.Xs))
          .border(
            width = 1.dp,
            color = Colors.Border,
            shape = RoundedCornerShape(Radii.Xs)
          )
          .padding(horizontal = Spacings.s3, vertical = 6.dp), // 压缩上下内边距
        verticalAlignment = if (singleLine) Alignment.CenterVertically else Alignment.Top
      ) {
        Box(modifier = Modifier.weight(1f)) {
          if (value.isEmpty() && placeholder.isNotEmpty()) {
            Text(
              text = placeholder,
              fontSize = 12.sp,
              color = Colors.TextMuted
            )
          }
          innerTextField()
        }
        if (trailingIcon != null) {
          Spacer(Modifier.width(Spacings.s2))
          trailingIcon()
        }
      }
    }
  )
}

// ── Read-only field with clickable transparent overlay ──────────────────

@Composable
private fun ClickableField(
  value: String,
  placeholder: String,
  trailingIcon: @Composable (() -> Unit)?,
  onClick: () -> Unit,
  modifier: Modifier = Modifier
) {
  Box(modifier = modifier) {
    BaseCompactTextField(
      value = value,
      onValueChange = {},
      readOnly = true,
      placeholder = placeholder,
      modifier = Modifier.fillMaxWidth(),
      trailingIcon = trailingIcon
    )
    Box(
      modifier = Modifier
        .matchParentSize()
        .clickable(
          onClick = onClick,
          interactionSource = remember { MutableInteractionSource() },
          indication = null
        )
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
    BaseCompactTextField(
      value = value,
      onValueChange = onValueChange,
      placeholder = placeholder,
      modifier = Modifier.fillMaxWidth()
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
    BaseCompactTextField(
      value = value,
      onValueChange = onValueChange,
      placeholder = placeholder,
      modifier = Modifier.fillMaxWidth(),
      keyboardOptions = KeyboardOptions(keyboardType = KeyboardType.Decimal)
    )
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// DATE INPUT — label + Material3 DatePicker dialog
// ═══════════════════════════════════════════════════════════════════════════

@OptIn(androidx.compose.material3.ExperimentalMaterial3Api::class)
@Composable
fun DateInput(
  label: String,
  value: String,
  onValueChange: (String) -> Unit,
  required: Boolean = false,
  modifier: Modifier = Modifier
) {
  var showDialog by remember { mutableStateOf(false) }

  val initialMillis = remember(value) {
    runCatching {
      val parts = value.split("-")
      if (parts.size == 3) {
        Calendar.getInstance().apply { set(parts[0].toInt(), parts[1].toInt() - 1, parts[2].toInt()) }.timeInMillis
      } else System.currentTimeMillis()
    }.getOrDefault(System.currentTimeMillis())
  }

  val state = rememberDatePickerState(initialSelectedDateMillis = initialMillis)

  if (showDialog) {
    DatePickerDialog(
      onDismissRequest = { showDialog = false },
      confirmButton = {
        TextButton(onClick = {
          state.selectedDateMillis?.let { millis ->
            val cal = Calendar.getInstance().apply { timeInMillis = millis }
            onValueChange("%04d-%02d-%02d".format(cal.get(Calendar.YEAR), cal.get(Calendar.MONTH) + 1, cal.get(Calendar.DAY_OF_MONTH)))
          }
          showDialog = false
        }) { Text("确定", color = Colors.Accent) }
      },
      dismissButton = {
        TextButton(onClick = { showDialog = false }) { Text("取消") }
      }
    ) {
      DatePicker(state = state)
    }
  }

  InputRow(label = label, required = required, modifier = modifier) {
    ClickableField(
      value = value,
      placeholder = "YYYY-MM-DD",
      trailingIcon = { Text("📅", fontSize = 14.sp) },
      onClick = { showDialog = true },
      modifier = Modifier.fillMaxWidth()
    )
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// TIME INPUT — label + Material3 TimePicker dialog
// ═══════════════════════════════════════════════════════════════════════════

@OptIn(androidx.compose.material3.ExperimentalMaterial3Api::class)
@Composable
fun TimeInput(
  label: String,
  value: String,
  onValueChange: (String) -> Unit,
  required: Boolean = false,
  modifier: Modifier = Modifier
) {
  var showDialog by remember { mutableStateOf(false) }

  val (initialHour, initialMinute) = remember(value) {
    runCatching {
      val parts = value.split(":")
      if (parts.size == 2) parts[0].toInt() to parts[1].toInt() else 8 to 0
    }.getOrDefault(8 to 0)
  }

  val state = rememberTimePickerState(initialHour = initialHour, initialMinute = initialMinute, is24Hour = true)

  if (showDialog) {
    AlertDialog(
      onDismissRequest = { showDialog = false },
      title = { Text("选择时间", fontSize = Types.TextMd, fontWeight = FontWeight.Bold) },
      text = { TimePicker(state = state) },
      confirmButton = {
        TextButton(onClick = {
          onValueChange("%02d:%02d".format(state.hour, state.minute))
          showDialog = false
        }) { Text("确定", color = Colors.Accent) }
      },
      dismissButton = {
        TextButton(onClick = { showDialog = false }) { Text("取消") }
      }
    )
  }

  InputRow(label = label, required = required, modifier = modifier) {
    ClickableField(
      value = value,
      placeholder = "HH:mm",
      trailingIcon = { Text("🕐", fontSize = 14.sp) },
      onClick = { showDialog = true },
      modifier = Modifier.fillMaxWidth()
    )
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// SELECT INPUT — label + dropdown
// ═══════════════════════════════════════════════════════════════════════════

@OptIn(androidx.compose.material3.ExperimentalMaterial3Api::class)
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
    Box {
      ClickableField(
        value = value,
        placeholder = "",
        trailingIcon = { ExposedDropdownMenuDefaults.TrailingIcon(expanded = expanded) },
        onClick = { expanded = true },
        modifier = Modifier.fillMaxWidth()
      )
      DropdownMenu(
        expanded = expanded,
        onDismissRequest = { expanded = false },
        modifier = Modifier.fillMaxWidth(0.9f)
      ) {
        options.forEach { option ->
          DropdownMenuItem(
            text = { Text(option, fontSize = Types.TextSm) },
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
    BaseCompactTextField(
      value = value,
      onValueChange = onValueChange,
      placeholder = placeholder,
      modifier = Modifier.fillMaxWidth(),
      singleLine = false,
      minLines = minLines
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

// ═══════════════════════════════════════════════════════════════════════════
// MEDIA HELPERS — async thumbnail loading from content URIs
// ═══════════════════════════════════════════════════════════════════════════

@Composable
private fun rememberImageThumbnail(option: Option): Bitmap? {
  val context = LocalContext.current
  val uri = option.label
  return produceState<Bitmap?>(initialValue = null, key1 = uri) {
    withContext(Dispatchers.IO) {
      try {
        val stream = context.contentResolver.openInputStream(Uri.parse(uri))
        val opts = BitmapFactory.Options().apply { inSampleSize = 4 }
        value = BitmapFactory.decodeStream(stream, null, opts)
        stream?.close()
      } catch (_: Exception) {
        value = null
      }
    }
  }.value
}

@Composable
private fun rememberVideoThumbnail(option: Option): Bitmap? {
  val context = LocalContext.current
  val uri = option.label
  return produceState<Bitmap?>(initialValue = null, key1 = uri) {
    withContext(Dispatchers.IO) {
      try {
        val retriever = MediaMetadataRetriever()
        retriever.setDataSource(context, Uri.parse(uri))
        value = retriever.frameAtTime
        retriever.release()
      } catch (_: Exception) {
        value = null
      }
    }
  }.value
}

// ═══════════════════════════════════════════════════════════════════════════
// MEDIA THUMBNAIL — square preview card with remove button (shared)
// ═══════════════════════════════════════════════════════════════════════════

private enum class MediaThumbnailType { Image, Video }

@Composable
private fun MediaThumbnail(
  option: Option,
  type: MediaThumbnailType,
  onRemove: () -> Unit,
  size: Dp = 80.dp,
  modifier: Modifier = Modifier
) {
  val bitmap = when (type) {
    MediaThumbnailType.Image -> rememberImageThumbnail(option)
    MediaThumbnailType.Video -> rememberVideoThumbnail(option)
  }

  Box(
    modifier = modifier
      .size(size)
      .clip(RoundedCornerShape(Radii.Sm))
      .border(1.dp, Colors.Border, RoundedCornerShape(Radii.Sm))
      .background(Colors.Surface)
  ) {
    if (bitmap != null) {
      Image(
        bitmap = bitmap.asImageBitmap(),
        contentDescription = if (type == MediaThumbnailType.Image) "图片" else "视频",
        modifier = Modifier.fillMaxSize(),
        contentScale = ContentScale.Crop
      )
    } else {
      Box(Modifier.fillMaxSize(), contentAlignment = Alignment.Center) {
        Text(if (type == MediaThumbnailType.Image) "🖼" else "🎬", fontSize = 28.sp)
      }
    }
    Box(
      modifier = Modifier
        .align(Alignment.TopEnd).padding(2.dp).size(18.dp)
        .clip(CircleShape).background(Colors.Danger)
        .clickable(onClick = onRemove),
      contentAlignment = Alignment.Center
    ) {
      Text("×", color = Colors.White, fontSize = 11.sp, fontWeight = FontWeight.Bold)
    }
  }
}

@Composable
private fun AddMediaButton(
  onClick: () -> Unit,
  label: String,
  icon: String,
  size: Dp = 80.dp,
  modifier: Modifier = Modifier
) {
  Box(
    modifier = modifier
      .size(size)
      .clip(RoundedCornerShape(Radii.Sm))
      .border(1.5.dp, Brush.verticalGradient(listOf(Colors.Accent.copy(alpha = 0.6f), Colors.Accent)), RoundedCornerShape(Radii.Sm))
      .background(Colors.AccentDim)
      .clickable(onClick = onClick),
    contentAlignment = Alignment.Center
  ) {
    Column(horizontalAlignment = Alignment.CenterHorizontally, verticalArrangement = Arrangement.spacedBy(2.dp)) {
      Text(icon, fontSize = 22.sp)
      Text(label, fontSize = Types.Text2xs, color = Colors.Accent, fontWeight = FontWeight.Medium)
    }
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// IMAGES INPUT — label + multi-image picker with thumbnail grid
// ═══════════════════════════════════════════════════════════════════════════

@OptIn(ExperimentalLayoutApi::class)
@Composable
fun ImagesInput(
  label: String,
  options: List<Option>,
  onOptionsChange: (List<Option>) -> Unit,
  required: Boolean = false,
  maxCount: Int = 9,
  modifier: Modifier = Modifier,
  thumbSize: Dp = 80.dp
) {
  val launcher = rememberLauncherForActivityResult(
    contract = ActivityResultContracts.PickMultipleVisualMedia(maxCount)
  ) { result ->
    if (result.isNotEmpty()) {
      val remaining = (maxCount - options.size).coerceAtLeast(0)
      val newOptions = result.take(remaining).map { uri -> Option(value = uri.toString(), label = uri.toString()) }
      onOptionsChange(options + newOptions)
    }
  }

  InputRow(label = label, required = required, modifier = modifier) {
    Column(modifier = Modifier.fillMaxWidth()) {
      FlowRow(
        horizontalArrangement = Arrangement.spacedBy(Spacings.s2),
        verticalArrangement = Arrangement.spacedBy(Spacings.s2),
        modifier = Modifier.fillMaxWidth()
      ) {
        options.forEach { option ->
          MediaThumbnail(option = option, type = MediaThumbnailType.Image, onRemove = { onOptionsChange(options.filter { it != option }) }, size = thumbSize)
        }
        if (options.size < maxCount) {
          AddMediaButton(
            onClick = { launcher.launch(PickVisualMediaRequest(ActivityResultContracts.PickVisualMedia.ImageOnly)) },
            label = "图片", icon = "🖼", size = thumbSize
          )
        }
      }
      if (options.isNotEmpty() || maxCount > 0) {
        Spacer(Modifier.height(Spacings.s1))
        Text("已选 ${r"${"}options.size}/$maxCount 张", fontSize = Types.Text2xs, color = Colors.TextMuted)
      }
    }
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// VIDEOS INPUT — label + multi-video picker with thumbnail grid
// ═══════════════════════════════════════════════════════════════════════════

@OptIn(ExperimentalLayoutApi::class)
@Composable
fun VideosInput(
  label: String,
  options: List<Option>,
  onOptionsChange: (List<Option>) -> Unit,
  required: Boolean = false,
  maxCount: Int = 5,
  modifier: Modifier = Modifier,
  thumbSize: Dp = 80.dp
) {
  val launcher = rememberLauncherForActivityResult(
    contract = ActivityResultContracts.PickMultipleVisualMedia(maxCount)
  ) { result ->
    if (result.isNotEmpty()) {
      val remaining = (maxCount - options.size).coerceAtLeast(0)
      val newOptions = result.take(remaining).map { uri -> Option(value = uri.toString(), label = uri.toString()) }
      onOptionsChange(options + newOptions)
    }
  }

  InputRow(label = label, required = required, modifier = modifier) {
    Column(modifier = Modifier.fillMaxWidth()) {
      FlowRow(
        horizontalArrangement = Arrangement.spacedBy(Spacings.s2),
        verticalArrangement = Arrangement.spacedBy(Spacings.s2),
        modifier = Modifier.fillMaxWidth()
      ) {
        options.forEach { option ->
          MediaThumbnail(option = option, type = MediaThumbnailType.Video, onRemove = { onOptionsChange(options.filter { it != option }) }, size = thumbSize)
        }
        if (options.size < maxCount) {
          AddMediaButton(
            onClick = { launcher.launch(PickVisualMediaRequest(ActivityResultContracts.PickVisualMedia.VideoOnly)) },
            label = "视频", icon = "🎬", size = thumbSize
          )
        }
      }
      if (options.isNotEmpty() || maxCount > 0) {
        Spacer(Modifier.height(Spacings.s1))
        Text("已选 ${r"${"}options.size}/$maxCount 个", fontSize = Types.Text2xs, color = Colors.TextMuted)
      }
    }
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// IMAGES DISPLAY — label + read-only image thumbnail gallery
// ═══════════════════════════════════════════════════════════════════════════

@OptIn(ExperimentalLayoutApi::class)
@Composable
fun ImagesDisplay(
  label: String,
  options: List<Option>,
  labelWidth: Dp = 80.dp,
  modifier: Modifier = Modifier,
  thumbSize: Dp = 80.dp
) {
  FieldRowTop(label = label, labelWidth = labelWidth, modifier = modifier) {
    if (options.isEmpty()) {
      Text(text = "—", fontSize = Types.TextSm, color = Colors.TextMuted)
    } else {
      FlowRow(
        horizontalArrangement = Arrangement.spacedBy(Spacings.s2),
        verticalArrangement = Arrangement.spacedBy(Spacings.s2),
        modifier = Modifier.weight(1f)
      ) {
        options.forEach { option ->
          val bitmap = rememberImageThumbnail(option)
          Box(
            modifier = Modifier
              .size(thumbSize)
              .clip(RoundedCornerShape(Radii.Sm))
              .border(1.dp, Colors.Border, RoundedCornerShape(Radii.Sm))
              .background(Colors.Surface)
          ) {
            if (bitmap != null) {
              Image(bitmap = bitmap.asImageBitmap(), contentDescription = "图片", modifier = Modifier.fillMaxSize(), contentScale = ContentScale.Crop)
            } else {
              Box(Modifier.fillMaxSize(), contentAlignment = Alignment.Center) { Text("🖼", fontSize = 22.sp) }
            }
          }
        }
      }
    }
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// VIDEOS DISPLAY — label + read-only video thumbnail gallery
// ═══════════════════════════════════════════════════════════════════════════

@OptIn(ExperimentalLayoutApi::class)
@Composable
fun VideosDisplay(
  label: String,
  options: List<Option>,
  labelWidth: Dp = 80.dp,
  modifier: Modifier = Modifier,
  thumbSize: Dp = 80.dp
) {
  FieldRowTop(label = label, labelWidth = labelWidth, modifier = modifier) {
    if (options.isEmpty()) {
      Text(text = "—", fontSize = Types.TextSm, color = Colors.TextMuted)
    } else {
      FlowRow(
        horizontalArrangement = Arrangement.spacedBy(Spacings.s2),
        verticalArrangement = Arrangement.spacedBy(Spacings.s2),
        modifier = Modifier.weight(1f)
      ) {
        options.forEach { option ->
          val bitmap = rememberVideoThumbnail(option)
          Box(
            modifier = Modifier
              .size(thumbSize)
              .clip(RoundedCornerShape(Radii.Sm))
              .border(1.dp, Colors.Border, RoundedCornerShape(Radii.Sm))
              .background(Colors.Surface)
          ) {
            if (bitmap != null) {
              Image(bitmap = bitmap.asImageBitmap(), contentDescription = "视频", modifier = Modifier.fillMaxSize(), contentScale = ContentScale.Crop)
            } else {
              Box(Modifier.fillMaxSize(), contentAlignment = Alignment.Center) { Text("🎬", fontSize = 22.sp) }
            }
          }
        }
      }
    }
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// TAGS INPUT — free-form tag entry with chips and optional suggestions
// ═══════════════════════════════════════════════════════════════════════════

@OptIn(ExperimentalLayoutApi::class)
@Composable
fun TagsInput(
  label: String,
  tags: List<String>,
  onTagsChange: (List<String>) -> Unit,
  suggestions: List<String> = emptyList(),
  required: Boolean = false,
  maxCount: Int = 20,
  modifier: Modifier = Modifier
) {
  var text by remember { mutableStateOf("") }
  var showSuggestions by remember { mutableStateOf(false) }

  val filtered = if (text.isBlank()) emptyList()
    else suggestions.filter { it.contains(text, ignoreCase = true) && it !in tags }

  InputRow(label = label, required = required, modifier = modifier) {
    Column(modifier = Modifier.fillMaxWidth()) {
      // Tag chips
      if (tags.isNotEmpty()) {
        FlowRow(
          horizontalArrangement = Arrangement.spacedBy(Spacings.s2),
          verticalArrangement = Arrangement.spacedBy(Spacings.s2),
          modifier = Modifier.fillMaxWidth()
        ) {
          tags.forEach { tag ->
            Box(
              modifier = Modifier
                .clip(RoundedCornerShape(Radii.Pill))
                .border(1.dp, Colors.Accent.copy(alpha = 0.4f), RoundedCornerShape(Radii.Pill))
                .background(Colors.AccentDim)
                .clickable { onTagsChange(tags.filter { it != tag }) }
                .padding(start = Spacings.s3, end = Spacings.s2, top = Spacings.s1, bottom = Spacings.s1)
            ) {
              Row(verticalAlignment = Alignment.CenterVertically) {
                Text(tag, fontSize = Types.Text2xs, fontWeight = FontWeight.Medium, color = Colors.AccentText)
                Spacer(Modifier.width(Spacings.s1))
                Text("×", fontSize = 13.sp, fontWeight = FontWeight.Bold, color = Colors.AccentText)
              }
            }
          }
        }
        Spacer(Modifier.height(Spacings.s2))
      }

      // Text input
      Box {
        BaseCompactTextField(
          value = text,
          onValueChange = {
            text = it
            showSuggestions = it.isNotBlank() && filtered.isNotEmpty()
          },
          placeholder = "输入标签，回车添加",
          modifier = Modifier.fillMaxWidth(),
          keyboardOptions = KeyboardOptions.Default
        )
        DropdownMenu(
          expanded = showSuggestions,
          onDismissRequest = { showSuggestions = false },
          modifier = Modifier.fillMaxWidth(0.8f)
        ) {
          filtered.take(8).forEach { suggestion ->
            DropdownMenuItem(
              text = { Text(suggestion, fontSize = Types.TextSm) },
              onClick = {
                if (tags.size < maxCount) {
                  onTagsChange(tags + suggestion)
                  text = ""
                  showSuggestions = false
                }
              }
            )
          }
        }
      }

      // Helper
      Spacer(Modifier.height(Spacings.s1))
      Text("回车添加，已填 ${r"${"}tags.size}/$maxCount", fontSize = Types.Text2xs, color = Colors.TextMuted)
    }
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// MULTI-SELECT — checkable dropdown for selecting multiple options
// ═══════════════════════════════════════════════════════════════════════════

@OptIn(ExperimentalLayoutApi::class, androidx.compose.material3.ExperimentalMaterial3Api::class)
@Composable
fun MultiSelect(
  label: String,
  selected: List<Option>,
  options: List<Option>,
  onSelectionChange: (List<Option>) -> Unit,
  required: Boolean = false,
  modifier: Modifier = Modifier
) {
  var expanded by remember { mutableStateOf(false) }

  InputRow(label = label, required = required, modifier = modifier) {
    Column(modifier = Modifier.fillMaxWidth()) {
      // Selected chips
      if (selected.isNotEmpty()) {
        FlowRow(
          horizontalArrangement = Arrangement.spacedBy(Spacings.s2),
          verticalArrangement = Arrangement.spacedBy(Spacings.s2),
          modifier = Modifier.fillMaxWidth()
        ) {
          selected.forEach { opt ->
            Box(
              modifier = Modifier
                .clip(RoundedCornerShape(Radii.Sm))
                .border(1.dp, Colors.Accent.copy(alpha = 0.3f), RoundedCornerShape(Radii.Sm))
                .background(Colors.Accent.copy(alpha = 0.08f))
                .clickable { onSelectionChange(selected.filter { it != opt }) }
                .padding(start = Spacings.s3, end = Spacings.s2, top = Spacings.s1, bottom = Spacings.s1)
            ) {
              Row(verticalAlignment = Alignment.CenterVertically) {
                Text(opt.label, fontSize = Types.Text2xs, fontWeight = FontWeight.Medium, color = Colors.AccentText)
                Spacer(Modifier.width(Spacings.s1))
                Text("×", fontSize = 13.sp, fontWeight = FontWeight.Bold, color = Colors.AccentText)
              }
            }
          }
        }
        Spacer(Modifier.height(Spacings.s2))
      }

      // Dropdown trigger
      Box {
        ClickableField(
          value = if (selected.isEmpty()) "" else "已选 ${r"${"}selected.size} 项",
          placeholder = "",
          trailingIcon = { ExposedDropdownMenuDefaults.TrailingIcon(expanded = expanded) },
          onClick = { expanded = true },
          modifier = Modifier.fillMaxWidth()
        )
        DropdownMenu(
          expanded = expanded,
          onDismissRequest = { expanded = false },
          modifier = Modifier.fillMaxWidth(0.9f)
        ) {
          if (options.isEmpty()) {
            DropdownMenuItem(
              text = { Text("无选项", fontSize = Types.TextSm, color = Colors.TextMuted) },
              onClick = { expanded = false }
            )
          } else {
            options.forEach { option ->
              val isChecked = selected.any { it.value == option.value }
              DropdownMenuItem(
                text = {
                  Row(verticalAlignment = Alignment.CenterVertically) {
                    Checkbox(
                      checked = isChecked,
                      onCheckedChange = null,
                      colors = CheckboxDefaults.colors(checkedColor = Colors.Accent),
                      modifier = Modifier.size(20.dp)
                    )
                    Spacer(Modifier.width(Spacings.s2))
                    Text(option.label, fontSize = Types.TextSm)
                  }
                },
                onClick = {
                  onSelectionChange(
                    if (isChecked) selected.filter { it.value != option.value }
                    else selected + option
                  )
                }
              )
            }
          }
        }
      }
    }
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// CASCADE SELECT — single-box drill-down with breadcrumbs
// ═══════════════════════════════════════════════════════════════════════════

@OptIn(androidx.compose.material3.ExperimentalMaterial3Api::class)
@Composable
fun CascadeSelect(
  label: String,
  selectedPath: List<Option>,
  topOptions: List<Option>,
  onPathChange: (List<Option>) -> Unit,
  childrenProvider: (Option) -> List<Option>,
  required: Boolean = false,
  modifier: Modifier = Modifier
) {
  var expanded by remember { mutableStateOf(false) }

  // Navigation stack: each element is the option list for a level
  var navStack: List<List<Option>> by remember { mutableStateOf(listOf(topOptions)) }

  // Reset nav stack when external path changes
  val currentOptions = navStack.last()
  val depth = navStack.size

  InputRow(label = label, required = required, modifier = modifier) {
    Box {
      ClickableField(
        value = if (selectedPath.isEmpty()) "" else selectedPath.joinToString(" › ") { it.label },
        placeholder = "请选择",
        trailingIcon = { ExposedDropdownMenuDefaults.TrailingIcon(expanded = expanded) },
        onClick = {
          navStack = listOf(topOptions)
          selectedPath.dropLast(1).forEach { sel ->
            val children = childrenProvider(sel)
            if (children.isNotEmpty()) navStack = navStack + listOf(children)
          }
          expanded = true
        },
        modifier = Modifier.fillMaxWidth()
      )

      // Dropdown
      DropdownMenu(
        expanded = expanded,
        onDismissRequest = { expanded = false },
        modifier = Modifier.fillMaxWidth(0.9f)
      ) {
        // Back button when deeper than level 1
        if (depth > 1) {
          DropdownMenuItem(
            text = {
              Text("← 返回上级", fontSize = Types.TextSm, color = Colors.Accent, fontWeight = FontWeight.Medium)
            },
            onClick = {
              navStack = navStack.dropLast(1)
              onPathChange(selectedPath.dropLast(1))
            }
          )
        }

        if (currentOptions.isEmpty()) {
          DropdownMenuItem(
            text = { Text("无选项", fontSize = Types.TextSm, color = Colors.TextMuted) },
            onClick = { expanded = false }
          )
        } else {
          currentOptions.forEach { option ->
            val hasChildren = childrenProvider(option).isNotEmpty()
            DropdownMenuItem(
              text = {
                Row(
                  modifier = Modifier.fillMaxWidth(),
                  horizontalArrangement = Arrangement.SpaceBetween,
                  verticalAlignment = Alignment.CenterVertically
                ) {
                  Text(option.label, fontSize = Types.TextSm)
                  if (hasChildren) {
                    Text("›", fontSize = Types.TextSm, color = Colors.TextMuted)
                  }
                }
              },
              onClick = {
                val newPath = selectedPath.take(depth - 1) + option
                val children = childrenProvider(option)
                if (children.isNotEmpty()) {
                  navStack = navStack + listOf(children)
                  onPathChange(newPath)
                } else {
                  onPathChange(newPath)
                  expanded = false
                }
              }
            )
          }
        }
      }
    }
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// AVATAR INPUT — circular image picker with preview
// ═══════════════════════════════════════════════════════════════════════════

@Composable
fun AvatarInput(
  label: String,
  uri: String,
  onUriChange: (String) -> Unit,
  modifier: Modifier = Modifier,
  size: Dp = 80.dp
) {
  val launcher = rememberLauncherForActivityResult(
    contract = ActivityResultContracts.PickVisualMedia()
  ) { result ->
    if (result != null) onUriChange(result.toString())
  }

  InputRow(label = label, required = false, modifier = modifier) {
    Row(
      modifier = Modifier.fillMaxWidth(),
      horizontalArrangement = Arrangement.Center
    ) {
      Box(
        modifier = Modifier
          .size(size)
          .clip(CircleShape)
          .border(2.dp, Colors.Border, CircleShape)
          .background(Colors.Surface)
          .clickable(
            onClick = { launcher.launch(PickVisualMediaRequest(ActivityResultContracts.PickVisualMedia.ImageOnly)) },
            interactionSource = remember { MutableInteractionSource() },
            indication = null
          ),
        contentAlignment = Alignment.Center
      ) {
        if (uri.isNotBlank()) {
          val bitmap = rememberImageThumbnail(Option(value = uri, label = uri))
          if (bitmap != null) {
            Image(
              bitmap = bitmap.asImageBitmap(),
              contentDescription = "头像",
              modifier = Modifier.fillMaxSize(),
              contentScale = ContentScale.Crop
            )
          } else {
            Text("🖼", fontSize = 28.sp)
          }
        } else {
          Column(horizontalAlignment = Alignment.CenterHorizontally) {
            Text("📷", fontSize = 24.sp)
            Text("点击上传", fontSize = Types.Text2xs, color = Colors.TextMuted)
          }
        }
      }

      if (uri.isNotBlank()) {
        Spacer(Modifier.width(Spacings.s4))
        Column(verticalArrangement = Arrangement.Center) {
          Button(
            label = "更换",
            onClick = { launcher.launch(PickVisualMediaRequest(ActivityResultContracts.PickVisualMedia.ImageOnly)) },
            variant = ButtonVariant.Primary,
            size = ButtonSize.Sm
          )
          Spacer(Modifier.height(Spacings.s1))
          Text(
            text = "清除",
            fontSize = Types.Text2xs,
            color = Colors.Danger,
            fontWeight = FontWeight.Medium,
            modifier = Modifier.clickable(
              onClick = { onUriChange("") },
              interactionSource = remember { MutableInteractionSource() },
              indication = null
            )
          )
        }
      }
    }
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// FILES INPUT — file picker with name list and remove
// ═══════════════════════════════════════════════════════════════════════════

@Composable
fun FilesInput(
  label: String,
  options: List<Option>,
  onOptionsChange: (List<Option>) -> Unit,
  required: Boolean = false,
  maxCount: Int = 10,
  modifier: Modifier = Modifier
) {
  val launcher = rememberLauncherForActivityResult(
    contract = ActivityResultContracts.GetMultipleContents()
  ) { result ->
    if (result.isNotEmpty()) {
      val remaining = (maxCount - options.size).coerceAtLeast(0)
      val newFiles = result.take(remaining).map { uri ->
        val name = uri.lastPathSegment ?: uri.toString()
        Option(value = uri.toString(), label = name)
      }
      onOptionsChange(options + newFiles)
    }
  }

  InputRow(label = label, required = required, modifier = modifier) {
    Column(modifier = Modifier.fillMaxWidth()) {
      options.forEach { file ->
        Row(
          modifier = Modifier
            .fillMaxWidth()
            .padding(vertical = Spacings.s1)
            .clip(RoundedCornerShape(Radii.Sm))
            .border(1.dp, Colors.Border, RoundedCornerShape(Radii.Sm))
            .background(Colors.Surface)
            .padding(horizontal = Spacings.s3, vertical = Spacings.s2),
          verticalAlignment = Alignment.CenterVertically
        ) {
          Text("📄", fontSize = 14.sp)
          Spacer(Modifier.width(Spacings.s2))
          Text(
            text = file.label,
            fontSize = Types.TextSm,
            color = Colors.TextMain,
            maxLines = 1,
            overflow = TextOverflow.Ellipsis,
            modifier = Modifier.weight(1f)
          )
          Box(
            modifier = Modifier
              .size(20.dp)
              .clip(CircleShape)
              .background(Colors.Danger)
              .clickable(
                onClick = { onOptionsChange(options.filter { it != file }) },
                interactionSource = remember { MutableInteractionSource() },
                indication = null
              ),
            contentAlignment = Alignment.Center
          ) {
            Text("×", color = Colors.White, fontSize = 12.sp, fontWeight = FontWeight.Bold)
          }
        }
      }

      Spacer(Modifier.height(Spacings.s2))

      if (options.size < maxCount) {
        Button(
          label = "📎 添加文件",
          onClick = { launcher.launch("*/*") },
          variant = ButtonVariant.Primary,
          size = ButtonSize.Sm
        )
      }

      Spacer(Modifier.height(Spacings.s1))
      Text("已选 ${r"${"}options.size}/$maxCount 个", fontSize = Types.Text2xs, color = Colors.TextMuted)
    }
  }
}
