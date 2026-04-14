<#import "/$/modelbase.ftl" as modelbase>
<#import "/$/appbase.ftl" as appbase>
import SwiftUI
import UIKit
import Charts

import ACarousel
import SnapToScroll
import SlidingTabView
import FSCalendar
import Refresher
import SlidingRuler
import CodeScanner
import SwiftUIFontIcon
import CachedAsyncImage
<#assign pageName = modelbase.url_to_page_name(page.uri)>
<#list page.widgets as widget>
<@appbase.print_source_code snippet="types" widget=widget indent=0 />
</#list>

struct ${swift.nameType(pageName)}View: View {

  @State 
  private var isCompletedLoading = false

  let ${swift.nameVariable(app.name)} = ${swift.nameType(app.name)}()

  /**
   * 页面传入参数
   */
  var params: [String:Any] = [:]

<#list page.widgets as widget>
<@appbase.print_source_code snippet="fields" widget=widget indent=2 />
</#list>

  init() {
    // TODO
  }

  var body: some View {
    contentView()
  }

  func contentView() -> AnyView {
    if (!isCompletedLoading) {
      return AnyView(
        LoadingAnimation()
        .onAppear() {
          DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.isCompletedLoading = true
          }
        }
      )
    } else {
      return buildContentView()
    }
  }

  public func buildContentView() -> AnyView {
    AnyView(ScrollView(
      showsIndicators: false) {
        VStack {
<#list page.widgets as widget>
<@appbase.print_source_code snippet="declare" widget=widget indent=10 />
</#list>
          Spacer()
        } // VStack
      } // ScrollView
      .refresher(refreshView: AppRefreshView.init) {
        await doRefresh()
      }
      .navigationBarTitle(Text("${page.title}"), displayMode: .inline)
      .background(Color("color.screen.background"))
      .coordinateSpace(name: "SCROLL")
    )
  }

  public func doRefresh() async -> Void {
<#list page.widgets as widget>
  <#if widget.widgetType == "滚动导航" || widget.widgetType == "滑动导航" || widget.widgetType == "传统列表">
    items${swift.nameType(widget.variable)} = await ${swift.nameVariable(widget.applicationName)}.asyncLoad${swift.nameType(widget.variable)}4${swift.nameType(widget.pageName)}(params: params);
  </#if>
</#list>
  }

<#list page.widgets as widget>
<@appbase.print_source_code snippet="methods" widget=widget indent=2 />
</#list>
}