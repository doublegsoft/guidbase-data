package ${namespace}.${java.nameNamespace(app.name)}.ui.design

import android.app.Activity
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.lightColorScheme
import androidx.compose.runtime.Composable
import androidx.compose.runtime.SideEffect
import androidx.compose.ui.graphics.toArgb
import androidx.compose.ui.platform.LocalView
import androidx.core.view.WindowCompat

/**
 * NavyPitch Material 3 Theme — Light only.
 *
 * Maps NavyPitch design tokens onto a Material3 light color scheme.
 */
private val LightColorScheme = lightColorScheme(
  primary            = Colors.Accent,
  onPrimary          = Colors.White,
  primaryContainer   = Colors.AccentDim,
  onPrimaryContainer = Colors.AccentText,
  secondary          = Colors.Warning,
  onSecondary        = Colors.White,
  secondaryContainer = Colors.WarningDim,
  tertiary           = Colors.Info,
  onTertiary         = Colors.White,
  tertiaryContainer  = Colors.InfoDim,
  error              = Colors.Danger,
  onError            = Colors.White,
  errorContainer     = Colors.DangerDim,
  background         = Colors.Bg,
  onBackground       = Colors.TextMain,
  surface            = Colors.Card,
  onSurface          = Colors.TextMain,
  surfaceVariant     = Colors.Surface,
  onSurfaceVariant   = Colors.TextSub,
  outline            = Colors.Border,
  outlineVariant     = Colors.Border.copy(alpha = 0.5f)
)

@Composable
fun Theme(
  content: @Composable () -> Unit
) {
  val view = LocalView.current
  if (!view.isInEditMode) {
    SideEffect {
      val window = (view.context as Activity).window
      window.statusBarColor = Colors.Card.toArgb()
      WindowCompat.getInsetsController(window, view).isAppearanceLightStatusBars = true
    }
  }

  MaterialTheme(
    colorScheme = LightColorScheme,
    typography = Typography,
    content = content
  )
}
