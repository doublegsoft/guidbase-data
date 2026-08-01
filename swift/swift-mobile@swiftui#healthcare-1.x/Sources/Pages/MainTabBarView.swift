//
//  MainTabBarView.swift
//  hello
//
//  Fixed bottom tab bar with four tabs.
//

import SwiftUI

struct MainTabBarView: View {
  @Binding var selectedTab: Int

  private let tabs: [(icon: String, title: String)] = [
    ("🏠", "首页"),
    ("📊", "健康管理"),
    ("🧭", "发现"),
    ("👤", "我的"),
  ]

  var body: some View {
    HStack {
      ForEach(Array(tabs.enumerated()), id: \.offset) { index, tab in
        Button(action: { selectedTab = index }) {
          VStack(spacing: 3) {
            Text(tab.icon)
              .font(.system(size: 20))

            Text(tab.title)
              .font(.system(size: 10))
          }
          .foregroundColor(
            selectedTab == index ? .primary : .textMuted
          )
          .frame(maxWidth: .infinity)
        }
      }
    }
    .padding(.top, 8)
    .padding(.bottom, 8)
    .background(.regularMaterial)
    .overlay(alignment: .top) {
      Divider()
        .overlay(Color.tabBarBorder)
    }
  }
}

#Preview {
  MainTabBarView(selectedTab: .constant(0))
}
