package ${namespace}.${java.nameNamespace(app.name)}.util

import ${namespace}.${java.nameNamespace(app.name)}.model.Option
import java.math.BigDecimal
import java.util.Date

/**
 * Type-safe parse helpers.
 * All methods are static-equivalent via Kotlin `object`.
 */
object Safe {

  // ── String ──────────────────────────────────────────────────────────

  fun string(value: Any?, default: String = ""): String =
    value?.toString() ?: default

  // ── Numeric ─────────────────────────────────────────────────────────

  fun int(value: Any?, default: Int = 0): Int =
    (value as? Number)?.toInt() ?: default

  fun long(value: Any?, default: Long = 0L): Long =
    (value as? Number)?.toLong() ?: default

  fun double(value: Any?, default: Double = 0.0): Double =
    (value as? Number)?.toDouble() ?: default

  fun float(value: Any?, default: Float = 0f): Float =
    (value as? Number)?.toFloat() ?: default

  fun decimal(value: Any?, default: BigDecimal = BigDecimal.ZERO): BigDecimal =
    when (value) {
      is BigDecimal -> value
      is Number -> BigDecimal(value.toString())
      is String -> runCatching { BigDecimal(value) }.getOrDefault(default)
      else -> default
    }

  // ── Boolean ─────────────────────────────────────────────────────────

  fun bool(value: Any?, default: Boolean = false): Boolean =
    when (value) {
      is Boolean -> value
      is String -> value.equals("true", ignoreCase = true)
      is Number -> value.toInt() != 0
      else -> default
    }

  // ── Date ────────────────────────────────────────────────────────────

  fun date(value: Any?): Date =
    if (value is Date) value else Date()

  fun option(
    value: Any?,
    valueField: String = "value",
    labelField: String = "label"
  ): Option? {
    val map = value as? Map<*, *> ?: return null
    return Option(
      value = string(map[valueField]),
      label = string(map[labelField])
    )
  }  

  // ── Collections ─────────────────────────────────────────────────────

  fun strings(value: Any?): List<String> =
    (value as? List<*>)?.mapNotNull { it?.toString() } ?: emptyList()

  fun ints(value: Any?): List<Int> =
    (value as? List<*>)?.mapNotNull { (it as? Number)?.toInt() } ?: emptyList()

  fun options(
    value: Any?,
    valueField: String = "value",
    labelField: String = "label"
  ): List<Option> =
    (value as? List<*>)?.mapNotNull { item ->
      val map = item as? Map<*, *> ?: return@mapNotNull null
      Option(
        value = string(map[valueField]),
        label = string(map[labelField])
      )
    } ?: emptyList()
}
