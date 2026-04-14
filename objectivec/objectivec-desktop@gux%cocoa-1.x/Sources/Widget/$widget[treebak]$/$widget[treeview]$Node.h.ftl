<#import "/$/guidbase.ftl" as guidbase>
<#if license??>
${objc.license(license)}
</#if>
#import <Cocoa/Cocoa.h>
#import "${objc.nameType(widget.id)}Data.h"

/*!
** 【${widget.id}】树节点。
*/
@interface ${objc.nameType(widget.id)}Node : NSView

- (instancetype)initWithData:(${objc.nameType(widget.id)}Data*)data andController:(NSViewController*)controller;

- (void)setTitle:(NSString*)title;

- (${objc.nameType(widget.id)}Data*)getData;

- (void)clearSelected;

@end

