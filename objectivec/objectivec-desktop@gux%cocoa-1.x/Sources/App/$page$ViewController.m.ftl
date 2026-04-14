<#import "/$/guidbase.ftl" as guidbase>
<#if license??>
${objc.license(license)}
</#if>
#import "${objc.nameType(page.id)}ViewController.h"

@interface ${objc.nameType(page.id)}ViewController() {
<#list page.pageWidgets as widget>
  <#if widget.id??>
  <#if widget.container.equals(page)>
  ${widget.id}:${widget.type}  
  </#if>
  </#if>
</#list>
}
@end

@implementation ${objc.nameType(page.id)}ViewController

@end