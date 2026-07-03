package ${namespace}.${java.nameNamespace(app.name)}.ui.components

import androidx.compose.foundation.background
import androidx.compose.foundation.clickable
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.PaddingValues
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.RowScope
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.size
import androidx.compose.foundation.lazy.grid.GridCells
import androidx.compose.foundation.lazy.grid.LazyVerticalGrid
import androidx.compose.foundation.lazy.grid.items
import androidx.compose.foundation.shape.CircleShape
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.automirrored.filled.KeyboardArrowLeft
import androidx.compose.material.icons.automirrored.filled.KeyboardArrowRight
import androidx.compose.material3.Icon
import androidx.compose.material3.IconButton
import androidx.compose.material3.MaterialTheme
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
import androidx.compose.ui.text.style.TextAlign
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import ${namespace}.${java.nameNamespace(app.name)}.ui.design.NavyPitchColor
import ${namespace}.${java.nameNamespace(app.name)}.util.Dates
import java.util.Calendar

data class MonthCell(
  val date: String,
  val day: Int,
  val currentMonth: Boolean,
  val isToday: Boolean
)

data class WeekDay(
  val date: String,
  val day: Int,
  val month: Int,
  val weekday: Int,
  val isToday: Boolean,
  val isWeekend: Boolean
)

/**
 * Calendar component with month/week views.
 */
@Composable
fun CalendarComponent(
  eventDates: Set<String>,
  selectedDate: String,
  onDateSelected: (String) -> Unit,
  onViewChange: (String) -> Unit,
  modifier: Modifier = Modifier,
  defaultView: String = "week"
) {
  val colorScheme = MaterialTheme.colorScheme
  var currentView by remember { mutableStateOf(defaultView) }
  val today = Dates.today()

  val selComponents = remember(selectedDate) { Dates.components(selectedDate) }
  val selYear = selComponents?.first ?: Calendar.getInstance().get(Calendar.YEAR)
  val selMonth = selComponents?.second ?: Calendar.getInstance().get(Calendar.MONTH)

  var displayYear by remember(selYear) { mutableStateOf(selYear) }
  var displayMonth by remember(selMonth) { mutableStateOf(selMonth) }

  val monthCells = remember(displayYear, displayMonth, today) {
    buildMonthGrid(displayYear, displayMonth, today)
  }
  val weekDays = remember(selectedDate, today) { buildWeekDays(selectedDate, today) }

  val title = remember(displayYear, displayMonth) {
    Dates.formatTitle(displayYear, displayMonth)
  }
  val sub = remember(selectedDate) {
    val range = Dates.weekRange(selectedDate)
    if (range != null) "${r"${"}range.first} - ${r"${"}range.second}" else ""
  }

  Column(
    modifier = modifier
      .fillMaxWidth()
      .background(colorScheme.surface)
  ) {
    CalendarHeader(
      title = title,
      sub = if (currentView == "week") sub else "",
      currentView = currentView,
      onViewToggle = {
        currentView = if (currentView == "month") "week" else "month"
        onViewChange(currentView)
      },
      onPrev = {
        if (currentView == "month") {
          if (displayMonth == 0) { displayMonth = 11; displayYear-- }
          else displayMonth--
        } else {
          onDateSelected(Dates.addDays(selectedDate, -7))
        }
      },
      onNext = {
        if (currentView == "month") {
          if (displayMonth == 11) { displayMonth = 0; displayYear++ }
          else displayMonth++
        } else {
          onDateSelected(Dates.addDays(selectedDate, 7))
        }
      },
      onToday = {
        val t = Dates.today()
        onDateSelected(t)
        val comps = Dates.components(t)
        if (comps != null) { displayYear = comps.first; displayMonth = comps.second }
      }
    )

    if (currentView == "month") {
      MonthGridView(cells = monthCells, selectedDate = selectedDate, eventDates = eventDates,
        onDateSelected = { onDateSelected(it) })
    } else {
      WeekStripView(weekDays = weekDays, selectedDate = selectedDate, eventDates = eventDates,
        onDateSelected = { onDateSelected(it) })
    }
  }
}

@Composable
private fun CalendarHeader(
  title: String,
  sub: String,
  currentView: String,
  onViewToggle: () -> Unit,
  onPrev: () -> Unit,
  onNext: () -> Unit,
  onToday: () -> Unit
) {
  val colorScheme = MaterialTheme.colorScheme

  Column(
    modifier = Modifier
      .fillMaxWidth()
      .background(colorScheme.primary)
      .padding(horizontal = 12.dp, vertical = 8.dp)
  ) {
    Row(
      modifier = Modifier.fillMaxWidth(),
      verticalAlignment = Alignment.CenterVertically
    ) {
      Row(
        modifier = Modifier
          .clip(RoundedCornerShape(8.dp))
          .background(Color.White.copy(alpha = 0.2f))
          .padding(2.dp),
        horizontalArrangement = Arrangement.spacedBy(1.dp)
      ) {
        CalendarTab("月", isActive = currentView == "month", onClick = {
          if (currentView != "month") onViewToggle()
        })
        CalendarTab("周", isActive = currentView == "week", onClick = {
          if (currentView != "week") onViewToggle()
        })
      }

      Spacer(modifier = Modifier.weight(1f))

      Column(horizontalAlignment = Alignment.CenterHorizontally) {
        Text(
          text = title,
          color = colorScheme.onPrimary,
          fontSize = 15.sp,
          fontWeight = FontWeight.SemiBold
        )
        if (sub.isNotBlank()) {
          Text(
            text = sub,
            color = colorScheme.onPrimary.copy(alpha = 0.7f),
            fontSize = 11.sp
          )
        }
      }

      Spacer(modifier = Modifier.weight(1f))

      Row {
        IconButton(onClick = onToday, modifier = Modifier.size(32.dp)) {
          Text(
            text = "今",
            color = colorScheme.onPrimary,
            fontSize = 12.sp,
            fontWeight = FontWeight.Bold
          )
        }
        IconButton(onClick = onPrev, modifier = Modifier.size(32.dp)) {
          Icon(Icons.AutoMirrored.Filled.KeyboardArrowLeft,
            contentDescription = "上一步",
            tint = colorScheme.onPrimary.copy(alpha = 0.8f),
            modifier = Modifier.size(20.dp))
        }
        IconButton(onClick = onNext, modifier = Modifier.size(32.dp)) {
          Icon(Icons.AutoMirrored.Filled.KeyboardArrowRight,
            contentDescription = "下一步",
            tint = colorScheme.onPrimary.copy(alpha = 0.8f),
            modifier = Modifier.size(20.dp))
        }
      }
    }
  }
}

@Composable
private fun CalendarTab(label: String, isActive: Boolean, onClick: () -> Unit) {
  val colorScheme = MaterialTheme.colorScheme
  Box(
    modifier = Modifier
      .clip(RoundedCornerShape(6.dp))
      .background(if (isActive) Color.White else Color.Transparent)
      .clickable(onClick = onClick)
      .padding(horizontal = 16.dp, vertical = 6.dp),
    contentAlignment = Alignment.Center
  ) {
    Text(
      text = label,
      color = if (isActive) colorScheme.primary else colorScheme.onPrimary.copy(alpha = 0.7f),
      fontSize = 13.sp,
      fontWeight = if (isActive) FontWeight.SemiBold else FontWeight.Normal
    )
  }
}

@Composable
private fun MonthGridView(
  cells: List<MonthCell>,
  selectedDate: String,
  eventDates: Set<String>,
  onDateSelected: (String) -> Unit
) {
  val colorScheme = MaterialTheme.colorScheme
  Column(
    modifier = Modifier
      .fillMaxWidth()
      .background(colorScheme.surface)
      .padding(horizontal = 8.dp)
  ) {
    Row(modifier = Modifier.fillMaxWidth()) {
      Dates.weekdayNames.forEachIndexed { index, name ->
        Box(modifier = Modifier.weight(1f), contentAlignment = Alignment.Center) {
          Text(
            text = name,
            color = if (index == 0 || index == 6) NavyPitchColor.Red.copy(alpha = 0.7f)
            else colorScheme.onSurfaceVariant,
            fontSize = 11.sp,
            textAlign = TextAlign.Center
          )
        }
      }
    }

    Spacer(modifier = Modifier.height(4.dp))

    LazyVerticalGrid(
      columns = GridCells.Fixed(7),
      modifier = Modifier.fillMaxWidth().height(240.dp),
      contentPadding = PaddingValues(0.dp),
      verticalArrangement = Arrangement.spacedBy(2.dp),
      horizontalArrangement = Arrangement.spacedBy(0.dp)
    ) {
      items(cells) { cell ->
        MonthDayCell(
          cell = cell,
          isSelected = cell.date == selectedDate,
          hasEvent = cell.date in eventDates,
          onDateSelected = { onDateSelected(cell.date) }
        )
      }
    }
  }
}

@Composable
private fun MonthDayCell(
  cell: MonthCell,
  isSelected: Boolean,
  hasEvent: Boolean,
  onDateSelected: () -> Unit
) {
  val colorScheme = MaterialTheme.colorScheme

  val bgColor = when {
    isSelected -> colorScheme.primary
    cell.isToday -> colorScheme.primary.copy(alpha = 0.15f)
    else -> Color.Transparent
  }

  val textColor = when {
    isSelected -> colorScheme.onPrimary
    cell.isToday -> colorScheme.primary
    !cell.currentMonth -> colorScheme.onSurface.copy(alpha = 0.25f)
    Dates.isWeekend(cell.date) -> NavyPitchColor.Red.copy(alpha = 0.8f)
    else -> colorScheme.onSurface
  }

  Box(
    modifier = Modifier
      .clip(RoundedCornerShape(6.dp))
      .background(bgColor)
      .clickable(onClick = onDateSelected)
      .padding(vertical = 4.dp),
    contentAlignment = Alignment.Center
  ) {
    Column(horizontalAlignment = Alignment.CenterHorizontally) {
      Text(
        text = "${r"${"}cell.day}",
        color = textColor,
        fontSize = 13.sp,
        fontWeight = if (isSelected || cell.isToday) FontWeight.Bold else FontWeight.Normal
      )
      if (hasEvent) {
        Box(
          modifier = Modifier
            .size(5.dp)
            .clip(CircleShape)
            .background(NavyPitchColor.Teal)
        )
      }
    }
  }
}

@Composable
private fun WeekStripView(
  weekDays: List<WeekDay>,
  selectedDate: String,
  eventDates: Set<String>,
  onDateSelected: (String) -> Unit
) {
  val colorScheme = MaterialTheme.colorScheme
  Row(
    modifier = Modifier
      .fillMaxWidth()
      .background(colorScheme.surface)
      .padding(horizontal = 6.dp, vertical = 8.dp),
    horizontalArrangement = Arrangement.spacedBy(4.dp)
  ) {
    weekDays.forEach { wd ->
      WeekDayCell(
        weekDay = wd,
        isSelected = wd.date == selectedDate,
        hasEvent = wd.date in eventDates,
        onClick = { onDateSelected(wd.date) }
      )
    }
  }
}

@Composable
private fun RowScope.WeekDayCell(
  weekDay: WeekDay,
  isSelected: Boolean,
  hasEvent: Boolean,
  onClick: () -> Unit
) {
  val colorScheme = MaterialTheme.colorScheme

  val bgColor = when {
    isSelected -> colorScheme.primary
    weekDay.isToday -> colorScheme.primary.copy(alpha = 0.15f)
    else -> colorScheme.surfaceVariant
  }

  val labelColor = when {
    weekDay.isWeekend -> NavyPitchColor.Red.copy(alpha = 0.7f)
    else -> colorScheme.onSurfaceVariant
  }

  val numColor = when {
    isSelected -> colorScheme.onPrimary
    weekDay.isToday -> colorScheme.primary
    weekDay.isWeekend -> NavyPitchColor.Red.copy(alpha = 0.8f)
    else -> colorScheme.onSurface
  }

  Column(
    modifier = Modifier
      .weight(1f)
      .clip(RoundedCornerShape(8.dp))
      .background(bgColor)
      .clickable(onClick = onClick)
      .padding(vertical = 6.dp),
    horizontalAlignment = Alignment.CenterHorizontally
  ) {
    Text(
      text = Dates.weekdayNames[weekDay.weekday],
      color = labelColor,
      fontSize = 10.sp
    )
    Text(
      text = "${r"${"}weekDay.day}",
      color = numColor,
      fontSize = 16.sp,
      fontWeight = if (isSelected || weekDay.isToday) FontWeight.Bold else FontWeight.Normal,
      modifier = Modifier.padding(vertical = 2.dp)
    )
    if (hasEvent) {
      Box(
        modifier = Modifier
          .size(5.dp)
          .clip(CircleShape)
          .background(NavyPitchColor.Teal)
      )
    }
  }
}

// --- Calendar math ---

private fun buildMonthGrid(year: Int, month: Int, today: String): List<MonthCell> {
  val dim = Dates.daysInMonth(year, month)
  val fdom = Dates.firstDayOfWeek(year, month)
  val cells = mutableListOf<MonthCell>()

  val prevMonth = if (month == 0) 11 else month - 1
  val prevYear = if (month == 0) year - 1 else year
  val prevDim = Dates.daysInMonth(prevYear, prevMonth)
  for (i in fdom - 1 downTo 0) {
    val day = prevDim - i
    val date = formatDate(prevYear, prevMonth, day)
    cells.add(MonthCell(date, day, currentMonth = false, isToday = date == today))
  }
  for (day in 1..dim) {
    val date = formatDate(year, month, day)
    cells.add(MonthCell(date, day, currentMonth = true, isToday = date == today))
  }
  val nextMonth = if (month == 11) 0 else month + 1
  val nextYear = if (month == 11) year + 1 else year
  var nextDay = 1
  while (cells.size < 42) {
    val date = formatDate(nextYear, nextMonth, nextDay)
    cells.add(MonthCell(date, nextDay, currentMonth = false, isToday = date == today))
    nextDay++
  }
  return cells
}

private fun buildWeekDays(dateStr: String, today: String): List<WeekDay> {
  val range = Dates.weekRange(dateStr) ?: return emptyList()
  val startCal = Dates.parse(range.first)?.let { Calendar.getInstance().apply { time = it } }
    ?: return emptyList()
  val days = mutableListOf<WeekDay>()
  for (i in 0..6) {
    val cal = startCal.clone() as Calendar
    cal.add(Calendar.DAY_OF_MONTH, i)
    val d = Dates.format(cal.time)
    val comps = Dates.components(d) ?: continue
    days.add(WeekDay(date = d, day = comps.third, month = comps.second + 1,
      weekday = i, isToday = d == today, isWeekend = i == 0 || i == 6))
  }
  return days
}

private fun formatDate(year: Int, month: Int, day: Int): String =
  "%04d-%02d-%02d".format(year, month + 1, day)
