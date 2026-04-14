<#import "/$/guidbase.ftl" as guidbase>
<#if license??>
${objc.license(license)}
</#if>
#import "${objc.nameType(widget.id)}Tree.h"
#import "${objc.nameType(widget.id)}Node.h"

#import "POCO/${objc.nameType(widget.id)}.h"
#import "Constants.h"
#import "Theme/Theme.h"

@implementation ${objc.nameType(widget.id)}Tree

- (instancetype)init {
  self = [super init];
  if (self) {
    self.wantsLayer = YES;
    self.layer.backgroundColor = [[Theme current] getColorNamed:COLOR_SIDEBAR_BACKGROUND].CGColor;
  }
  
  return self;
}

- (BOOL)isFlipped {
  return YES;
}

- (void)clearSelectedNode {
  for (int i = 0; i < self.subviews.count; i++) {
    NSView* subview = self.subviews[i];
    if ([subview isKindOfClass:[${objc.nameType(widget.id)}Node class]]) {
      ${objc.nameType(widget.id)}Node* node = (${objc.nameType(widget.id)}Node*)subview;
      [node clearSelected];
    }
  }
}

@end
