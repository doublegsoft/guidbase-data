<#import "/$/guidbase.ftl" as guidbase>
<#if license??>
${objc.license(license)}
</#if>
#import <Cocoa/Cocoa.h>
#import "POCO/${objc.nameType(widget.id)}.h"
#import "${objc.nameType(widget.id)}Node.h"

@protocol ${objc.nameType(widget.id)}DataSource 

- (NSUInteger)numberOfKnowledgeCategories;

- (${objc.nameType(widget.id)}Data*)${objc.nameType(widget.id)}AtIndex:(NSUInteger)index;

@end

@interface ${objc.nameType(widget.id)}Tree : NSView

@property (weak) id <${objc.nameType(widget.id)}DataSource> dataSource;

- (void)clearSelectedNode;

@end

