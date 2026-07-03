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
private val NavyPitchLightColorScheme = lightColorScheme(
  primary            = NavyPitchColor.Teal,
  onPrimary          = NavyPitchColor.White,
  primaryContainer   = NavyPitchColor.TealDim,
  onPrimaryContainer = NavyPitchColor.TealText,
  secondary          = NavyPitchColor.Amber,
  onSecondary        = NavyPitchColor.White,
  secondaryContainer = NavyPitchColor.AmberDim,
  tertiary           = NavyPitchColor.Blue,
  onTertiary         = NavyPitchColor.White,
  tertiaryContainer  = NavyPitchColor.BlueDim,
  error              = NavyPitchColor.Red,
  onError            = NavyPitchColor.White,
  errorContainer     = NavyPitchColor.RedDim,
  background         = NavyPitchColor.Bg,
  onBackground       = NavyPitchColor.TextMain,
  surface            = NavyPitchColor.Card,
  onSurface          = NavyPitchColor.TextMain,
  surfaceVariant     = NavyPitchColor.Surface,
  onSurfaceVariant   = NavyPitchColor.TextSub,
  outline            = NavyPitchColor.Border,
  outlineVariant     = NavyPitchColor.Border.copy(alpha = 0.5f)
)

@Composable
fun NavyPitchTheme(
  content: @Composable () -> Unit
) {
  val view = LocalView.current
  if (!view.isInEditMode) {
    SideEffect {
      val window = (view.context as Activity).window
      window.statusBarColor = NavyPitchColor.Card.toArgb()
      WindowCompat.getInsetsController(window, view).isAppearanceLightStatusBars = true
    }
  }

  MaterialTheme(
    colorScheme = NavyPitchLightColorScheme,
    typography = NavyPitchTypography,
    content = content
  )
}
