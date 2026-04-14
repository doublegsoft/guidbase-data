<#import "/$/guidbase.ftl" as guidbase>
<#if license??>
${objc.license(license)}
</#if>
#import "POCO/${objc.nameType(widget.id)}.h"
/*!
** 【${widget.id}】树节点数据。
*/
@interface ${objc.nameType(widget.id)}Data : NSObject

@property (nonatomic, readwrite) NSInteger level;

@property (nonatomic, readwrite) BOOL collapsed;

@property (nonatomic, retain) ${objc.nameType(widget.id)}* value;

@property (nonatomic, retain) NSMutableArray<${objc.nameType(widget.id)}Data*>* children;

- (instancetype)init;

@end