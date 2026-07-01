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
 * Navypitch Material 3 Theme.
 *
 * Maps the Academy Pro design tokens onto a M3 light color scheme.
 * Set [navyHeader] to true when the top-of-screen is the navy page chrome;
 * otherwise the status bar matches the surface.
 */
private val NavyPitchLightColorScheme = lightColorScheme(
  primary            = NpColor.Teal,
  onPrimary          = NpColor.White,
  primaryContainer   = NpColor.TealDim,
  onPrimaryContainer = NpColor.TealText,
  secondary          = NpColor.Amber,
  onSecondary        = NpColor.White,
  secondaryContainer = NpColor.AmberDim,
  tertiary           = NpColor.Blue,
  onTertiary         = NpColor.White,
  tertiaryContainer  = NpColor.BlueDim,
  error              = NpColor.Red,
  onError            = NpColor.White,
  errorContainer     = NpColor.RedDim,
  background         = NpColor.Bg,
  onBackground       = NpColor.TextMain,
  surface            = NpColor.Card,
  onSurface          = NpColor.TextMain,
  surfaceVariant     = NpColor.Surface,
  onSurfaceVariant   = NpColor.TextSub,
  outline            = NpColor.Border,
  outlineVariant     = NpColor.Border.copy(alpha = 0.5f)
)

@Composable
fun NavyPitchTheme(
  content: @Composable () -> Unit
) {
  val colorScheme = NavyPitchLightColorScheme

  val view = LocalView.current
  if (!view.isInEditMode) {
    SideEffect {
      val window = (view.context as Activity).window
      window.statusBarColor = NpColor.Card.toArgb()
      WindowCompat.getInsetsController(window, view).isAppearanceLightStatusBars = true
    }
  }

  MaterialTheme(
    colorScheme = colorScheme,
    typography = NavyPitchTypography,
    content = content
  )
}
