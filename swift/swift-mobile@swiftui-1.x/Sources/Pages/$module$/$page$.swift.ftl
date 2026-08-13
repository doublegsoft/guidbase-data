<#import "/$/modelbase.ftl" as modelbase>
<#import "/$/guidbase.ftl" as guidbase>
<#import "/$/guidbase4swift.ftl" as guidbase4swift>
<#import "/$/tile@swiftui.ftl" as tile>
<#import "/$/swiftui@mobile.ftl" as swiftui>
<#if license??>
${swift.license(license)}
</#if>

import SwiftUI

// MARK: - ${swift.nameType(page.name)}

struct ${swift.nameType(page.name)}: View {

<#list guidbase.get_page_params(page) as param>
  let ${swift.nameVariable(param.name)}: Int
</#list>  
<@swiftui.print_page_variables page=page indent=2 />
<@swiftui.print_page_methods page=page indent=2 />  

  var body: some View {
    VStack(spacing: 0) {
<@swiftui.print_page_layout page=page indent=6 />        
    }
    .background(Color.background)
    .navigationTitle("${page.title}")
    .navigationBarTitleDisplayMode(.inline)
  }
}
