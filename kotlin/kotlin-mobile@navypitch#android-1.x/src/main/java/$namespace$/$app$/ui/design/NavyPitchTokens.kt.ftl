package ${namespace}.${java.nameNamespace(app.name)}.ui.design

import androidx.compose.ui.graphics.Color
import androidx.compose.ui.graphics.Shadow
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

object NavyPitchColor {
  // Brand / Primary
  val Navy       = Color(0xFF0D1B2A)
  val NavyMid    = Color(0xFF152636)
  val NavyLight  = Color(0xFF1D3448)
  val Steel      = Color(0xFF1B4F72)

  // Accent
  val Teal       = Color(0xFF00C9A7)
  val TealHover  = Color(0xFF00B599)
  val Green      = Color(0xFF27AE60)
  val GreenHover = Color(0xFF219A52)
  val Amber      = Color(0xFFF5A623)
  val AmberHover = Color(0xFFE8981A)
  val Red        = Color(0xFFE74C6F)
  val Blue       = Color(0xFF3B8BEB)
  val Purple     = Color(0xFF9B59B6)

  // Accent — Dim backgrounds (12% opacity)
  val TealDim   = Color(0x1F00C9A7)
  val AmberDim  = Color(0x1FF5A623)
  val RedDim    = Color(0x1FE74C6F)
  val BlueDim   = Color(0x1F3B8BEB)
  val PurpleDim = Color(0x1A9B59B6)

  // Accent — Tag text
  val TealText   = Color(0xFF00A085)
  val AmberText  = Color(0xFFC8830A)
  val RedText    = Color(0xFFC0294F)
  val BlueText   = Color(0xFF2A6DC7)
  val PurpleText = Color(0xFF7D3C98)

  // Surfaces
  val Surface = Color(0xFFF0F4F8)
  val Card    = Color(0xFFFFFFFF)
  val Bg      = Color(0xFFF5F7FA)

  // Text
  val TextMain  = Color(0xFF1A2B3C)
  val TextSub   = Color(0xFF5A7080)
  val TextMuted = Color(0xFF95AABA)

  // Borders
  val Border = Color(0xFFE2EAF0)

  // Tab bar
  val TabText       = Color(0xFF95AABA)
  val TabTextActive = Color(0xFF00C9A7)

  // Shadows
  val ShadowLight = Color(0x140D1B2A)
  val ShadowMid   = Color(0x1F0D1B2A)

  // Misc
  val White = Color(0xFFFFFFFF)
}

// ── 2. TYPOGRAPHY ─────────────────────────────────────────────────────

object NavyPitchType {
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
  val pageTitle = TextStyle(fontSize = Text4xl, fontWeight = Bold, color = NpColor.TextMain)
  val sectionTitle = TextStyle(fontSize = TextMd, fontWeight = SemiBold, color = NpColor.TextMain)
  val bodyText = TextStyle(fontSize = TextBase, fontWeight = Normal, color = NpColor.TextMain)
  val caption = TextStyle(fontSize = TextXs, fontWeight = Normal, color = NpColor.TextSub)
  val muted = TextStyle(fontSize = TextXs, fontWeight = Normal, color = NpColor.TextMuted)
}

// ── 3. SPACING SCALE ───────────────────────────────────────────────────

object NavyPitchSpacing {
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

object NavyPitchRadius {
  val Xs   = 3.dp;  val Sm   = 6.dp;  val Md  = 8.dp
  val Lg   = 10.dp; val Xl   = 12.dp; val Xxl = 16.dp
  val Pill = 20.dp; val Full = 50.dp
}

// ── 5. SHADOWS ────────────────────────────────────────────────────────

object NavyPitchShadow {
  val Sm = Shadow(color = NpColor.ShadowLight, offset = androidx.compose.ui.geometry.Offset(0f, 2f), blurRadius = 16f)
  val Md = Shadow(color = NpColor.ShadowMid,   offset = androidx.compose.ui.geometry.Offset(0f, 4f), blurRadius = 24f)
}

// ── 6. MOTION ──────────────────────────────────────────────────────────

object NavyPitchMotion {
  const val Fast  = 120  // ms
  const val Base  = 150  // ms
  const val Smooth= 180  // ms
  const val Slow  = 280  // ms (for drawer slide)
}
