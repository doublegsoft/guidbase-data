<#import "/$/guidbase.ftl" as guidbase>
<#import "/$/cocoatouch.ftl" as cocoatouch>
<#if license??>
${objc.license(license)}
</#if>
<#assign pageWidth = page.position.size.width>
<#assign pageHeight = page.position.size.height>
<#assign strs = page.id?split("/")>
<#if (strs?size >= 3)>
#import "${objc.nameType(page.id?replace(strs[0] + "/", ""))}ViewController.h"
<#else>
#import "${objc.nameType(page.id)}ViewController.h"
</#if>

#import "GUX/Common/GUX.h"
#import "Styles.h"

@interface ${objc.nameType(page.id)}ViewController() {
<#list page.pageWidgets as widget>
  <#if widget.id??>
    <#if widget.container.equals(page)>
  ${widget.id}:${widget.type}  
    </#if>
  </#if>
</#list>
}

@property (nonatomic, strong) UIScrollView*   scrollView;
@property (nonatomic, strong) UIView*         contentView;

@end

@implementation ${objc.nameType(page.id)}ViewController
- (void)viewDidLoad {
  [super viewDidLoad];

  UIView* view = [[UIScrollView alloc] initWithFrame:self.view.bounds];
  view.backgroundColor = [UIColor whiteColor];
  [self.view addSubview:view];
}

@end