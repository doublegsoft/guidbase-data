<#import "/$/guidbase.ftl" as guidbase>
<#if license??>
${swift.license(license)}
</#if>
import SwiftUI

// MARK: - Design System · Colors

extension Color {

  // MARK: Brand

  /// Primary brand — medical blue  (#0078FF)
  static let primary = Color(hex: "0078FF")

  /// Secondary brand — health green (#00C4B4)
  static let secondary = Color(hex: "00C4B4")

  // MARK: Backgrounds

  /// Main screen background (#F6F7FB)
  static let background = Color(hex: "F6F7FB")

  /// Card surface
  static let surface = Color.white

  // MARK: Text

  /// Primary text (#333333)
  static let textPrimary = Color(hex: "333333")

  /// Secondary text (#666666)
  static let textSecondary = Color(hex: "666666")

  /// Muted / tertiary text (#999999)
  static let textMuted = Color(hex: "999999")

  // MARK: Accent

  /// Orange call-to-action (#FF9900)
  static let accentOrange = Color(hex: "FF9900")

  /// Dark orange — button gradient end (#FF7700)
  static let accentOrangeDark = Color(hex: "FF7700")

  /// Alert / destructive red (#FF4D4F)
  static let accentRed = Color(hex: "FF4D4F")

  // MARK: Insurance Card

  /// Insurance card deep blue (#0B409C)
  static let insuranceBlue = Color(hex: "0B409C")

  /// National emblem red (#E60012)
  static let nationalRed = Color(hex: "E60012")

  // MARK: Promo Banner

  /// Promo title indigo (#1D39C4)
  static let promoIndigo = Color(hex: "1D39C4")

  /// Promo subtitle blue (#2F54EB)
  static let promoBlue = Color(hex: "2F54EB")

  /// Promo background start (#E6F7FF)
  static let promoBgStart = Color(hex: "E6F7FF")

  /// Promo background end (#F0F5FF)
  static let promoBgEnd = Color(hex: "F0F5FF")

  /// Promo border (#D6E4FF)
  static let promoBorder = Color(hex: "D6E4FF")

  // MARK: Header Gradient

  /// Header gradient start
  static let headerGradientStart = Color(hex: "0078FF")

  /// Header gradient end (#308EFF)
  static let headerGradientEnd = Color(hex: "308EFF")

  // MARK: Dividers

  /// Subtle card divider (#F0F0F0)
  static let divider = Color(hex: "F0F0F0")

  /// Tab bar top border (#E5E5E5)
  static let tabBarBorder = Color(hex: "E5E5E5")

  // MARK: Status

  /// Available / has slots (#00C4B4)
  static let statusAvailable = Color(hex: "00C4B4")

  /// Tight / few slots (#FF4D4F)
  static let statusTight = Color(hex: "FF4D4F")
}

// MARK: - Hex Initializer

extension Color {

  /// Initialize a `Color` from a hex string.
  ///
  /// Supports 3-, 6-, and 8-character hex codes, with or without `#`.
  ///
  /// ```swift
  /// Color(hex: "#0078FF")
  /// Color(hex: "F6F7FB")
  /// Color(hex: "FFF")  // expands to #FFFFFF
  /// ```
  init(hex: String) {
    let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
    var int: UInt64 = 0
    Scanner(string: hex).scanHexInt64(&int)

    let a, r, g, b: UInt64
    switch hex.count {
    case 3:
      (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
    case 6:
      (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
    case 8:
      (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
    default:
      (a, r, g, b) = (255, 0, 0, 0)
    }

    self.init(
      .sRGB,
      red: Double(r) / 255,
      green: Double(g) / 255,
      blue: Double(b) / 255,
      opacity: Double(a) / 255
    )
  }
}
