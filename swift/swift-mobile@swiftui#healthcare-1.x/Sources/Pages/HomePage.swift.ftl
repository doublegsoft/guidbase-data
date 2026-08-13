<#import "/$/guidbase.ftl" as guidbase>
<#import "/$/tile@swiftui.ftl" as tile>
<#import "/$/swiftui@mobile.ftl" as swiftui>
<#if license??>
${swift.license(license)}
</#if>

import SwiftUI

/// 服务网络单元模型
struct ServiceItem: Identifiable {
  let id = UUID()
  let name: String
  let icon: String // 使用 Emoji 作为图标
  let color: Color // 每个图标背景的独特主题色
}

extension ServiceItem {
  /// 预设的 4×2（共 8 项）医疗健康常用服务模拟数据
  static let sampleData: [ServiceItem] = [
<#list app.pages as page>    
    ServiceItem(name: "${page.title}", icon: "📅", color: .blue),
</#list>
    <#--  ServiceItem(name: "门诊缴费", icon: "💳", color: .orange),
    ServiceItem(name: "报告查询", icon: "📄", color: .green),
    ServiceItem(name: "住院服务", icon: "🏥", color: .purple),
    ServiceItem(name: "在线问诊", icon: "💬", color: .teal),
    ServiceItem(name: "健康档案", icon: "📁", color: .indigo),
    ServiceItem(name: "用药提醒", icon: "💊", color: .red),
    ServiceItem(name: "排队候诊", icon: "⏳", color: .yellow)  -->
  ]
}

// MARK: - Content View

struct HomePage: View {
  @State private var selectedTab = 0
  @State private var navigationPath = NavigationPath()

  var body: some View {
    NavigationStack(path: $navigationPath) {
      ZStack(alignment: .bottom) {
        Color.background
          .ignoresSafeArea()

        VStack(spacing: 0) {
          // Fixed top area (does not scroll)
          StatusBarView()
          HeaderView()

          ScrollView {
            VStack(spacing: 0) {
              ServiceGridView { serviceName in
                navigationPath.append(serviceName)
              }
              .padding(.horizontal, 16)
              .padding(.top, 16)
            }
            .padding(.bottom, 80)
          }
        }

        MainTabBarView(selectedTab: $selectedTab)
      }
      .navigationBarHidden(true)
      .navigationDestination(for: String.self) { destination in
        switch destination {
<#list app.pages as page>          
  <#assign params = guidbase.get_page_params(page)>
        case "${page.title}":
          ${swift.nameType(page.name)}(<#list params as param>${swift.nameVariable(param.name)}: 0,</#list>)
</#list>
        default:
          EmptyView()
        }
      }
    }
  }
}

// MARK: - Service Grid (4×2)

struct ServiceGridView: View {
  let onServiceTap: (String) -> Void

  private let columns: [GridItem] = Array(
    repeating: GridItem(.flexible(), spacing: 8),
    count: 4
  )

  var body: some View {
    LazyVGrid(columns: columns, spacing: 16) {
      ForEach(ServiceItem.sampleData) { item in
        Button(action: { onServiceTap(item.name) }) {
          VStack(spacing: 6) {
            ZStack {
              RoundedRectangle(cornerRadius: 14)
                .fill(item.color.opacity(0.08))
                .frame(width: 44, height: 44)

              Text(item.icon)
                .font(.system(size: 20))
            }

            Text(item.name)
              .font(.system(size: 12))
              .foregroundColor(.textPrimary)
          }
        }
      }
    }
    .padding(16)
    .background(Color.surface)
    .clipShape(RoundedRectangle(cornerRadius: 12))
    .shadow(color: .black.opacity(0.02), radius: 8, y: 2)
  }
}



