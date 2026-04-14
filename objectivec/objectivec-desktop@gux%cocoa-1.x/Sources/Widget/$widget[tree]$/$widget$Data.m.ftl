<#import "/$/guidbase.ftl" as guidbase>
<#if license??>
${objc.license(license)}
</#if>
#import "POCO/${objc.nameType(widget.id)}.h"
/*!
** 【${widget.id}】树节点数据。
*/
#import "${objc.nameType(widget.id)}Data.h"

@implementation ${objc.nameType(widget.id)}Data

- (instancetype)init {
  self = [super init];
  if (self) {
    self.children = [[NSMutableArray alloc] init];
  }
  return self;
}

@end
