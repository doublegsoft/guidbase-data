<#import "/$/modelbase.ftl" as modelbase>
<#import "/$/appbase.ftl" as appbase>
import SwiftUI
import TabBar
import CodeScanner
import AlertToast

private enum TabItem: Int, Tabbable {
  case first = 0
  case second
  case third

  var icon: String {
    switch self {
      case .first: return "house"
      case .second: return "ellipsis.message"
      case .third: return "person"
    }
  }

  var title: String {
    switch self {
      case .first: return "页面"
      case .second: return "聊天"
      case .third: return "用户"
    }
  }
}

struct IndexView: View {

  /**
   * 欢迎页面
   */
  @EnvironmentObject private var launchScreenState: LaunchScreenStateManager

  /**
   * 是否显示二维码扫描
   */
  @State private var isShowingScanner = false

  /**
   * 页签导航变量
   */
  @State private var selectedTabItem: TabItem = .first

  /**
   * 错误显示变量
   */
  @State private var isShowingError = false
  @State private var messageError = ""

  /**
   * 聊天会话变量
   */
  @State private var conversations: [ObjectMap] = []

  let pages = [
<#list pages![] as page>
  <#if page.options.isComponent?? && page.options.isComponent == 'T'><#continue></#if>
    ["title": "${page.title}", "uri": "${page.uri}"],
</#list>
  ]

  var body: some View {
    GeometryReader { geometry in
      NavigationStack {
        TabBar(selection: $selectedTabItem) {
          ZStack {
            List(pages, id: \.["uri"]) { page in
              NavigationLink {
                switch page["uri"]! {
<#list pages![] as page>
  <#if page.options.isComponent?? && page.options.isComponent == 'T'><#continue></#if>
    <#assign pageName = modelbase.url_to_page_name(page.uri)>
              case "${page.uri}":
                ${swift.nameType(pageName)}View()
</#list>
                default:
                  Text("Error")
                }
              } label: {
                HStack {
                  Text(page["title"]!)
                  Spacer()
                }
              }
              .isDetailLink(false)
            }
            .navigationBarTitle("页面", displayMode: .inline)
            .tabItem(for: TabItem.first)
            .navigationBarItems(trailing: HStack {
              Button {
                isShowingScanner.toggle()
              } label: {
                Image(systemName: "qrcode.viewfinder").resizable().frame(width: 20, height: 20).padding([.trailing], 4)
              }
              .sheet(isPresented: $isShowingScanner) {
                CodeScannerView(codeTypes: [.qr], simulatedData: "Paul Hudson\npaul@hackingwithswift.com", completion: doHandleScan)
              }
            }.buttonStyle(PlainButtonStyle()))

            ConversationsView().tabItem(for: TabItem.second)

            Text("Third").tabItem(for: TabItem.third)
          }
          .padding(.bottom, geometry.safeAreaInsets.bottom + 25)
          .background(Color(UIColor.systemGroupedBackground))
        }
        .tabBar(style: CustomTabBarStyle())
        .tabItem(style: CustomTabItemStyle())
      } // NavigationView
    } // GeometryReader
    .toast(isPresenting: $isShowingError){
      AlertToast(type: .error(Color.red), title: messageError)
    }
    .task {
      await Task.sleep(1_500_000_000)
      self.launchScreenState.dismiss()
    }
  }

  private func doHandleScan(result: Result<ScanResult, ScanError>) {
    isShowingScanner = false
    // more code to come
  }
}
