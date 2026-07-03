package ${namespace}.${java.nameNamespace(app.name)}.util

import java.text.SimpleDateFormat
import java.util.Calendar
import java.util.Date
import java.util.Locale

object Dates {

  private val dateFormat = SimpleDateFormat("yyyy-MM-dd", Locale.getDefault())
  private val titleFormat = SimpleDateFormat("yyyy年 M月", Locale.getDefault())

  /** Return today's date as "YYYY-MM-DD" */
  fun today(): String = dateFormat.format(Date())

  /** Parse "YYYY-MM-DD" to Date */
  fun parse(dateStr: String): Date? = try {
    dateFormat.parse(dateStr)
  } catch (_: Exception) {
    null
  }

  /** Format Date to "YYYY-MM-DD" */
  fun format(date: Date): String = dateFormat.format(date)

  /** Format year-month title like "2026年 6月" */
  fun formatTitle(year: Int, month: Int): String {
    val cal = Calendar.getInstance()
    cal.set(year, month, 1)
    return titleFormat.format(cal.time)
  }

  /** Days in month */
  fun daysInMonth(year: Int, month: Int): Int {
    val cal = Calendar.getInstance()
    cal.set(year, month, 1)
    return cal.getActualMaximum(Calendar.DAY_OF_MONTH)
  }

  /** First day-of-week of month (0=Sunday, 1=Monday, ..., 6=Saturday) */
  fun firstDayOfWeek(year: Int, month: Int): Int {
    val cal = Calendar.getInstance()
    cal.set(year, month, 1)
    return cal.get(Calendar.DAY_OF_WEEK) - 1 // Calendar.SUNDAY=1 => 0
  }

  /** Get year/month/day from Date string */
  fun components(dateStr: String): Triple<Int, Int, Int>? {
    return try {
      val parts = dateStr.split("-")
      Triple(parts[0].toInt(), parts[1].toInt() - 1, parts[2].toInt()) // month 0-based
    } catch (_: Exception) {
      null
    }
  }

  /** Get week range (start..end) for a date */
  fun weekRange(dateStr: String): Pair<String, String>? {
    val cal = parse(dateStr)?.let { d -> Calendar.getInstance().apply { time = d } } ?: return null
    val dayOfWeek = cal.get(Calendar.DAY_OF_WEEK)
    cal.add(Calendar.DAY_OF_MONTH, -(dayOfWeek - 1)) // back to Sunday
    val start = format(cal.time)
    cal.add(Calendar.DAY_OF_MONTH, 6) // forward to Saturday
    val end = format(cal.time)
    return Pair(start, end)
  }

  /** Add days to a date string */
  fun addDays(dateStr: String, days: Int): String {
    val cal = parse(dateStr)?.let { d -> Calendar.getInstance().apply { time = d } }
      ?: return dateStr
    cal.add(Calendar.DAY_OF_MONTH, days)
    return format(cal.time)
  }

  /** Weekday names in Chinese */
  val weekdayNames = listOf("日", "一", "二", "三", "四", "五", "六")

  /** Check if a date falls on weekend (Saturday=6, Sunday=0) */
  fun isWeekend(dateStr: String): Boolean {
    val cal = parse(dateStr)?.let { d -> Calendar.getInstance().apply { time = d } }
      ?: return false
    val dow = cal.get(Calendar.DAY_OF_WEEK)
    return dow == Calendar.SUNDAY || dow == Calendar.SATURDAY
  }
}
