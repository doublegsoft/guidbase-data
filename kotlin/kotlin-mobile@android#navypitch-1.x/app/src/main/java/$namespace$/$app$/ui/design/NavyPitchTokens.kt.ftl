package ${namespace}.${java.nameNamespace(app.name)}.ui.design

import androidx.compose.ui.text.TextStyle
import androidx.compose.ui.text.font.FontFamily
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp

/* ═══════════════════════════════════════════════════════════════════════
   NAVYPITCH · Android Design System — Design Tokens
   Based on Academy Pro WXSS, adapted for Jetpack Compose
   ═══════════════════════════════════════════════════════════════════════ */

// ── 1. COLOR PALETTE ──────────────────────────────────────────────────

object Colors {
  // Brand / Primary
  val Primary      = androidx.compose.ui.graphics.Color(0xFF0D1B2A)
  val PrimaryDark  = androidx.compose.ui.graphics.Color(0xFF152636)
  val PrimaryLight = androidx.compose.ui.graphics.Color(0xFF1D3448)
  val PrimaryMuted = androidx.compose.ui.graphics.Color(0xFF1B4F72)

  // Semantic accent
  val Accent       = androidx.compose.ui.graphics.Color(0xFF00C9A7)
  val AccentHover  = androidx.compose.ui.graphics.Color(0xFF00B599)
  val Success      = androidx.compose.ui.graphics.Color(0xFF27AE60)
  val SuccessHover = androidx.compose.ui.graphics.Color(0xFF219A52)
  val Warning      = androidx.compose.ui.graphics.Color(0xFFF5A623)
  val WarningHover = androidx.compose.ui.graphics.Color(0xFFE8981A)
  val Danger       = androidx.compose.ui.graphics.Color(0xFFE74C6F)
  val Info         = androidx.compose.ui.graphics.Color(0xFF3B8BEB)
  val Decorative   = androidx.compose.ui.graphics.Color(0xFF9B59B6)

  // Semantic — Dim backgrounds (12% opacity)
  val AccentDim  = androidx.compose.ui.graphics.Color(0x1F00C9A7)
  val WarningDim = androidx.compose.ui.graphics.Color(0x1FF5A623)
  val DangerDim  = androidx.compose.ui.graphics.Color(0x1FE74C6F)
  val InfoDim    = androidx.compose.ui.graphics.Color(0x1F3B8BEB)
  val DecorativeDim  = androidx.compose.ui.graphics.Color(0x1A9B59B6)

  // Semantic — Tag text
  val AccentText  = androidx.compose.ui.graphics.Color(0xFF00A085)
  val WarningText = androidx.compose.ui.graphics.Color(0xFFC8830A)
  val DangerText  = androidx.compose.ui.graphics.Color(0xFFC0294F)
  val InfoText    = androidx.compose.ui.graphics.Color(0xFF2A6DC7)
  val DecorativeText  = androidx.compose.ui.graphics.Color(0xFF7D3C98)

  // Surfaces
  val Surface = androidx.compose.ui.graphics.Color(0xFFF0F4F8)
  val Card    = androidx.compose.ui.graphics.Color(0xFFFFFFFF)
  val Bg      = androidx.compose.ui.graphics.Color(0xFFF5F7FA)

  // Text
  val TextMain  = androidx.compose.ui.graphics.Color(0xFF1A2B3C)
  val TextSub   = androidx.compose.ui.graphics.Color(0xFF5A7080)
  val TextMuted = androidx.compose.ui.graphics.Color(0xFF95AABA)

  // Borders
  val Border = androidx.compose.ui.graphics.Color(0xFFE2EAF0)

  // Tab bar
  val TabText       = androidx.compose.ui.graphics.Color(0xFF95AABA)
  val TabTextActive = androidx.compose.ui.graphics.Color(0xFF00C9A7)

  // Shadows
  val ShadowLight = androidx.compose.ui.graphics.Color(0x140D1B2A)
  val ShadowMid   = androidx.compose.ui.graphics.Color(0x1F0D1B2A)

  // Misc
  val White = androidx.compose.ui.graphics.Color(0xFFFFFFFF)

  // Legacy palette (migrated from ui/theme/Color.kt)
  val Primary800 = androidx.compose.ui.graphics.Color(0xFF1B2838)
  val Accent500  = androidx.compose.ui.graphics.Color(0xFF4ECDC4)
  val Gray500    = androidx.compose.ui.graphics.Color(0xFFADB5BD)
}

// ── 2. TYPOGRAPHY ─────────────────────────────────────────────────────

object Types {
  // Type scale — converted from rpx to sp (roughly rpx/2 = sp)
  val Text2xs = 10.sp;  val TextXs  = 11.sp;  val TextSm  = 12.sp
  val TextBase= 13.sp;  val TextMd  = 14.sp;  val TextBody= 15.sp
  val TextLg  = 16.sp;  val TextXl  = 17.sp;  val Text2xl = 18.sp
  val Text3xl = 20.sp;  val Text4xl = 22.sp;  val Text5xl = 24.sp
  val Text6xl = 28.sp;  val Text7xl = 32.sp

  // Font weights
  val Normal    = FontWeight.Normal    // 400
  val Medium    = FontWeight.Medium    // 500
  val SemiBold  = FontWeight.SemiBold  // 600
  val Bold      = FontWeight.Bold      // 700
  val ExtraBold = FontWeight.ExtraBold // 800

  // Font family
  val Base = FontFamily.Default

  // Pre-built text styles for common uses
  val pageTitle = TextStyle(fontSize = Text4xl, fontWeight = Bold, color = Colors.TextMain)
  val sectionTitle = TextStyle(fontSize = TextMd, fontWeight = SemiBold, color = Colors.TextMain)
  val bodyText = TextStyle(fontSize = TextBase, fontWeight = Normal, color = Colors.TextMain)
  val caption = TextStyle(fontSize = TextXs, fontWeight = Normal, color = Colors.TextSub)
  val muted = TextStyle(fontSize = TextXs, fontWeight = Normal, color = Colors.TextMuted)
}

// ── 3. SPACING SCALE ───────────────────────────────────────────────────

object Spacings {
  val s1  = 4.dp;   val s2  = 6.dp;   val s3  = 8.dp;   val s4  = 12.dp
  val s5  = 16.dp;  val s6  = 20.dp;  val s7  = 24.dp;  val s8  = 28.dp
  val s9  = 32.dp;  val s10 = 36.dp;  val s11 = 40.dp;  val s12 = 44.dp
  val s13 = 48.dp;  val s14 = 56.dp

  // Semantic aliases
  val cardPadding    = s8
  val cardGap        = s6
  val sectionGap     = s8
  val listItemPadding= s8
  val pagePadding    = s10
  val formGap        = s3
  val formFieldPad   = s7
}

// ── 4. BORDER RADIUS ──────────────────────────────────────────────────

object Radii {
  val Xs   = 3.dp;  val Sm   = 6.dp;  val Md  = 8.dp
  val Lg   = 10.dp; val Xl   = 12.dp; val Xxl = 16.dp
  val Pill = 20.dp; val Full = 50.dp
}

// ── 5. SHADOWS ────────────────────────────────────────────────────────

object Shadows {
  val Sm = androidx.compose.ui.graphics.Shadow(color = Colors.ShadowLight, offset = androidx.compose.ui.geometry.Offset(0f, 2f), blurRadius = 16f)
  val Md = androidx.compose.ui.graphics.Shadow(color = Colors.ShadowMid,   offset = androidx.compose.ui.geometry.Offset(0f, 4f), blurRadius = 24f)
}

// ── 6. MOTION ──────────────────────────────────────────────────────────

object Motions {
  const val Fast  = 120  // ms
  const val Base  = 150  // ms
  const val Smooth= 180  // ms
  const val Slow  = 280  // ms (for drawer slide)
}
