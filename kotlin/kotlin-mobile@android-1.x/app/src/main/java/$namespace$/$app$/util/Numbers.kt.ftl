package ${namespace}.${java.nameNamespace(app.name)}.util

import java.math.BigDecimal

object Numbers {

  /** Format any value for display; BigDecimal uses toPlainString() to avoid scientific notation. */
  fun format(value: Any?): String = when (value) {
    is BigDecimal -> value.toPlainString()
    null -> ""
    else -> value.toString()
  }
}
