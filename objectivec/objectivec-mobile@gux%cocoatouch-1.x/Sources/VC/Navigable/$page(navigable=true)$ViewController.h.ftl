<#import "/$/guidbase.ftl" as guidbase>
<#if license??>
${objc.license(license)}
</#if>
#import <UIKit/UIKit.h>

@interface ${objc.nameType(page.id)}ViewController: UIViewController

@end