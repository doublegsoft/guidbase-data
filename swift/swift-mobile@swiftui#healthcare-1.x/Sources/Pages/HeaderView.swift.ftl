//
//  HeaderView.swift
//  hello
//
//  Status bar, header (location + search), and insurance card.
//

import SwiftUI

// MARK: - Status Bar

struct StatusBarView: View {
  var body: some View {
    HStack {
      Text("09:41")
        .font(.system(size: 12, weight: .medium))

      Spacer()

      HStack(spacing: 4) {
        Image(systemName: "antenna.radiowaves.left.and.right")
        Image(systemName: "battery.100")
      }
      .font(.system(size: 10))
    }
    .foregroundColor(.white)
    .padding(.horizontal, 20)
    .padding(.vertical, 6)
    .background(Color.primary)
  }
}

// MARK: - Header View

struct HeaderView: View {
  var body: some View {
    VStack(spacing: 0) {
      locationBar
        .padding(.bottom, 12)

      searchBox
        .padding(.bottom, 16)

      InsuranceCardView()
    }
    .padding(.horizontal, 16)
    .padding(.top, 15)
    .padding(.bottom, 20)
    .background(
      LinearGradient(
        colors: [.headerGradientStart, .headerGradientEnd],
        startPoint: .top,
        endPoint: .bottom
      )
    )
    .clipShape(
      UnevenRoundedRectangle(
        bottomLeadingRadius: 28,
        bottomTrailingRadius: 28
      )
    )
    .shadow(color: .primary.opacity(0.15), radius: 16, y: 4)
  }

  // MARK: Location Bar

  private var locationBar: some View {
    HStack {
      HStack(spacing: 4) {
        Text("📍 北京市第一人民医院")
          .font(.system(size: 15, weight: .bold))

        Image(systemName: "chevron.down")
          .font(.system(size: 10))
      }

      Spacer()

      Image(systemName: "bell.fill")
        .font(.system(size: 18))
    }
    .foregroundColor(.white)
  }

  // MARK: Search Box

  private var searchBox: some View {
    HStack(spacing: 8) {
      Image(systemName: "magnifyingglass")
        .font(.system(size: 14))

      Text("搜索医生、科室、疾病、科普...")
        .font(.system(size: 14))

      Spacer()
    }
    .foregroundColor(.white.opacity(0.85))
    .padding(.horizontal, 16)
    .padding(.vertical, 8)
    .background(Color.white.opacity(0.18))
    .clipShape(Capsule())
  }
}

// MARK: - Insurance Card

struct InsuranceCardView: View {
  var body: some View {
    ZStack(alignment: .bottomTrailing) {
      VStack(spacing: 0) {
        HStack {
          HStack(spacing: 6) {
            Text("🇨🇳")
              .font(.system(size: 16))

            Text("国家医保电子凭证")
              .font(.system(size: 15, weight: .bold))
              .foregroundColor(.insuranceBlue)
          }

          Spacer()

          Button(action: {}) {
            Text("立即刷码")
              .font(.system(size: 12, weight: .bold))
              .foregroundColor(.white)
              .padding(.horizontal, 14)
              .padding(.vertical, 6)
              .background(
                LinearGradient(
                  colors: [.accentOrange, .accentOrangeDark],
                  startPoint: .topLeading,
                  endPoint: .bottomTrailing
                )
              )
              .clipShape(Capsule())
              .shadow(color: .accentOrange.opacity(0.2), radius: 10, y: 4)
          }
        }
        .padding(.bottom, 14)

        Divider()
          .overlay(Color.divider)
          .padding(.bottom, 12)

        HStack(alignment: .bottom) {
          VStack(alignment: .leading, spacing: 2) {
            Text("张*华")
              .font(.system(size: 14, weight: .bold))
              .foregroundColor(.textPrimary)

            Text("北京市海淀区参保人员")
              .font(.system(size: 11))
              .foregroundColor(.textSecondary)
          }

          Spacer()

          Text("国家医疗保障局监制")
            .font(.system(size: 11))
            .foregroundColor(.textMuted)
        }
      }
      .padding(16)

      // Watermark
      Text("医保凭证")
        .font(.system(size: 54, weight: .black))
        .foregroundColor(.nationalRed.opacity(0.04))
        .rotationEffect(.degrees(-15))
        .offset(x: 10, y: 15)
        .allowsHitTesting(false)
    }
    .background(Color.surface)
    .clipShape(RoundedRectangle(cornerRadius: 12))
    .shadow(color: .black.opacity(0.08), radius: 24, y: 8)
  }
}

#Preview {
  VStack(spacing: 0) {
    StatusBarView()
    HeaderView()
  }
}
