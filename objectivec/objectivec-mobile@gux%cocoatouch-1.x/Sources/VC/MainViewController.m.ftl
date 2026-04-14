<#if license??>
${objectivec.license(license)}
</#if>
#import "MainViewController.h"

<#assign navs = []>
<#list app.pages as page>
  <#if page.options["navigable"]?? && page.options["navigable"] == "true">
#import "VC/Navigable/${objectivec.nameType(page.id)}ViewController.h"
    <#assign navs += [page]>
  </#if>
</#list>

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
  [super viewDidLoad];
<#list navs as page>

  ${objectivec.nameType(page.id)}ViewController* ${objectivec.nameVariable(page.id)} = [[${objectivec.nameType(page.id)}ViewController alloc] init];
  ${objectivec.nameVariable(page.id)}.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"${page.options["title"]!"页面标题"}"
                                                    image:[UIImage imageNamed:@"Image.Icon.Logo"]
                                                      tag:${page?index}];
  UINavigationController* nc${page?index} = [[UINavigationController alloc] initWithRootViewController:${objectivec.nameVariable(page.id)}];
</#list>  
    
  [self setViewControllers:[NSArray arrayWithObjects:<#list navs as page>nc${page?index}, </#list>nil]];
}

@end
