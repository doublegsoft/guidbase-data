<#import "/$/guidbase.ftl" as guidbase>
<#if license??>
${swift.license(license)}
</#if>
import SwiftUI

@main
struct ${swift.nameType(app.name)}App: App {
  var body: some Scene {
    WindowGroup {
      HomePage()
    }
  }
}