<#import "/$/modelbase.ftl" as modelbase>
<#import "/$/guidbase.ftl" as guidbase>
<#import "/$/guidbase4ts.ftl" as guidbase4ts>
<#import "/$/tile@harmonyos.ftl" as tile>
<#import "/$/harmonyos.ftl" as harmonyos>
<#assign usingObjs = []>
<#list page.widgets as widget>
  <#if widget.value("data") == "" || widget.value("data")?starts_with("enum")><#continue></#if>
  <#assign url = valuebase.url(widget.value("data"))>
  <#if usingObjs?seq_contains(url.resource)><#continue></#if>
  <#assign usingObjs += [url.resource]>
</#list>
import { router } from '@kit.ArkUI'
import { AdaptiveText, Tag, Navbar, FormSection, FormSectionTitle, 
  InputRow, DateRow, DropdownRow, MultiSelectRow, ReadonlyRow,
  LoadingFooter,
} from '../../components/components'
import { sdk, Option,<#list usingObjs as objname> ${ts.nameType(objname)},</#list> } from 'sdk'

/**
 * 【${page.title}】页面。
 */
@Entry
@Component
struct ${ts.nameType(page.name)}Index {
<@harmonyos.print_page_variables page=page indent=2 />
<@harmonyos.print_page_methods page=page indent=2 />

  build() {
    Column() {
      Navbar({
        navTitle: '${page.title}',
        showBack: true,
        onBack: () => { 
          const uiContext = this.getUIContext();
          const router = uiContext.getRouter();
          router.back() 
        }
      })
<@harmonyos.print_page_layout page=page indent=6 />
    }
    .width('100%')
    .height('100%')
  }
}