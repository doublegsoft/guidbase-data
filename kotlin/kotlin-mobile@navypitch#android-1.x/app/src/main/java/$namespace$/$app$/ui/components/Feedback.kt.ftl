package ${namespace}.${java.nameNamespace(app.name)}.components

import android.app.AlertDialog
import android.content.Context
import android.widget.Toast
import ${namespace}.${java.nameNamespace(app.name)}.${java.nameType(app.name)}

/**
 * UI feedback utilities (mirrors mini-program utils/feedback.js).
 * Provides success/error/warning/info/confirm dialogs and toasts.
 */
object Feedback {

  private val context: Context get() = ${java.nameType(app.name)}.instance

  /** Success toast (mirrors wx.showToast) */
  fun success(title: String, message: String = "") {
    val text = if (message.isNotBlank()) "$title: $message" else title
    Toast.makeText(context, "✅ $text", Toast.LENGTH_SHORT).show()
  }

  /** Error dialog (mirrors wx.showModal with "关闭") */
  fun error(title: String, message: String = "", onDismiss: (() -> Unit)? = null) {
    AlertDialog.Builder(context)
      .setTitle(title)
      .setMessage(message)
      .setPositiveButton("关闭") { dialog, _ ->
        dialog.dismiss()
        onDismiss?.invoke()
      }
      .show()
  }

  /** Warning dialog (mirrors wx.showModal with "我知道了") */
  fun warning(title: String, message: String = "", onDismiss: (() -> Unit)? = null) {
    AlertDialog.Builder(context)
      .setTitle(title)
      .setMessage(message)
      .setPositiveButton("我知道了") { dialog, _ ->
        dialog.dismiss()
        onDismiss?.invoke()
      }
      .show()
  }

  /** Info dialog (mirrors wx.showModal with "确定") */
  fun info(title: String, message: String = "", onDismiss: (() -> Unit)? = null) {
    AlertDialog.Builder(context)
      .setTitle(title)
      .setMessage(message)
      .setPositiveButton("确定") { dialog, _ ->
        dialog.dismiss()
        onDismiss?.invoke()
      }
      .show()
  }

  /** Confirm dialog (mirrors wx.showModal with confirm/cancel, returns Boolean via callback) */
  fun confirm(
    title: String,
    message: String = "",
    onResult: (Boolean) -> Unit
  ) {
    AlertDialog.Builder(context)
      .setTitle(title)
      .setMessage(message)
      .setPositiveButton("确定") { _, _ -> onResult(true) }
      .setNegativeButton("取消") { _, _ -> onResult(false) }
      .show()
  }
}
