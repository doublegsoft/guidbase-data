<#import "/$/guidbase.ftl" as guidbase>
<#if license??>
${objc.license(license)}
</#if>
#import <Cocoa/Cocoa.h>

@interface ${objc.nameType(page.id)}ViewController: NSViewController

@end