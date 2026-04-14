<#import "/$/guidbase.ftl" as guidbase>
<#if license??>
${objc.license(license)}
</#if>
#import "${objc.nameType(widget.id)}Node.h"
#import "${objc.nameType(widget.id)}Tree.h"
#import "${objc.nameType(widget.id)}TreeController.h"
#import "Constants.h"
#import "Theme/Theme.h"

@interface KnowledgeCategoryNode() {
  
  NSButton*                                   title;

  NSButton*                                   control;
  
  NSButton*                                   more;
  
  NSPopover*                                  moreActions;
  
  ${objc.nameType(widget.id)}Data*                      data;
  
  ${objc.nameType(widget.id)}TreeController*            treeController;
}
@end;

@implementation ${objc.nameType(widget.id)}Node

const int WIDTH_ICON = 16;

- (instancetype)initWithData:(${objc.nameType(widget.id)}Data*)data andController:(NSView*)controller {
  NSFont* far = [NSFont fontWithName:@"Font Awesome 5 Free Solid" size:12.0];
  CGFloat fontSize = 14.0;
  
  self = [super init];
  if (self) {
    self->treeController = (KnowledgeCategoryTreeController*)controller;
    
    self->data = data;
    self->control = [[NSButton alloc] initWithFrame:CGRectMake(PADDING_DEFAULT * (self->data.level + 1), (HEIGHT_KNOWLEDGE_CATEGORY_ITEM - WIDTH_ICON) / 2, WIDTH_ICON, WIDTH_ICON)];
    [self->control setTransparent:YES];
    [self->control setTarget:self];
    [self->control setState:NSControlStateValueOn];
    
    NSTextField* label = [[NSTextField alloc] initWithFrame:NSMakeRect(0, 0, WIDTH_ICON, WIDTH_ICON)];
    [label setEditable:NO];
    [label setBordered:NO];
    [label setBezeled:NO];
    [label setDrawsBackground:NO];
    [label setTextColor:[[Theme current] getColorNamed:COLOR_PRIMARY_FONT]];
    if (data.collapsed) {
      [label setStringValue:@"\uf0fe"];
    } else {
      [label setStringValue:@"\uf146"];
    }
    [label setFont:far];
    
    [self->control addSubview:label];
    [self->control setAction:@selector(onToggleNode:)];
    
    self->title = [[NSButton alloc] initWithFrame:CGRectMake(PADDING_DEFAULT * (self->data.level + 1) + WIDTH_ICON, (HEIGHT_KNOWLEDGE_CATEGORY_ITEM - WIDTH_ICON) / 2, 200, WIDTH_ICON)];
    [self->title setTransparent:YES];
    [self->title setTarget:self];
    [self->title setState:NSControlStateValueOn];
    
    label = [[NSTextField alloc] initWithFrame:NSMakeRect(0, 0, 200, WIDTH_ICON)];
    [label setEditable:NO];
    [label setBordered:NO];
    [label setBezeled:NO];
    [label setDrawsBackground:NO];
    [label setTextColor:[[Theme current] getColorNamed:COLOR_PRIMARY_FONT]];
    [label setStringValue:data.value.knowledgeCategoryName];
    [label setFont:far];
    
    NSFont* existingFont = label.font;
    NSFont* newFont = [NSFont fontWithName:existingFont.fontName size:fontSize];
    [label setFont:newFont];

    [self->title setAction:@selector(onSelectNode:)];
    [self->title addSubview:label];
    
    self->more = [[NSButton alloc] initWithFrame:CGRectMake(WIDTH_SIDEBAR - PADDING_DEFAULT - WIDTH_ICON,
                                                            (HEIGHT_KNOWLEDGE_CATEGORY_ITEM - WIDTH_ICON) / 2,
                                                            WIDTH_ICON,
                                                            WIDTH_ICON)];
    [self->more setTransparent:YES];
    [self->more setTarget:self];
    [self->more setState:NSControlStateValueOn];
    [self->more setAction:@selector(onMoreActions:)];
    
    label = [[NSTextField alloc] initWithFrame:NSMakeRect(0, 0, WIDTH_ICON, WIDTH_ICON)];
    [label setEditable:NO];
    [label setBordered:NO];
    [label setBezeled:NO];
    [label setDrawsBackground:NO];
    [label setTextColor:[[Theme current] getColorNamed:COLOR_PRIMARY_FONT]];
    [label setStringValue:@"\uf142"];
    [label setFont:far];
    
    [self->more addSubview:label];
    
    self->moreActions = [[NSPopover alloc] init];
    // self->moreActions.contentViewController = [[KnowledgeCategoryMoreViewController alloc] init];
    
    NSColor* bg = [[Theme current] getColorNamed:COLOR_SIDEBAR_BACKGROUND];
    self.wantsLayer = YES;
    self.layer.backgroundColor = bg.CGColor;
    
    [self addSubview:self->control];
    [self addSubview:self->title];
  }
  return self;
}

- (BOOL)isFlipped {
  return YES;
}

- (void)setTitle:(NSString*)title {
  self->title.stringValue = title;
}

- (${objc.nameType(widget.id)}Data*)getData {
  return self->data;
}

- (void)clearSelected {
  NSTextField* label = self->title.subviews[0];
  [label setTextColor:[[Theme current] getColorNamed:COLOR_PRIMARY_FONT]];
  label = self->control.subviews[0];
  [label setTextColor:[[Theme current] getColorNamed:COLOR_PRIMARY_FONT]];
  label = self->more.subviews[0];
  [label setTextColor:[[Theme current] getColorNamed:COLOR_PRIMARY_FONT]];
  [self->more removeFromSuperview];
}

- (void)collapse {
  NSTextField* label = self->control.subviews[0];
  [label setStringValue:@"\uf0fe"];
  self->data.collapsed = YES;
  [self->treeController collapseOrExpandNode:self forCollapsing:YES];
}

- (void)expand {
  NSTextField* label = self->control.subviews[0];
  [label setStringValue:@"\uf146"];
  self->data.collapsed = NO;
  [self->treeController collapseOrExpandNode:self forCollapsing:NO];
}

- (void)onToggleNode:(id)sender {
  if (self->data.collapsed) {
    [self expand];
  } else {
    [self collapse];
  }
}

- (void)onSelectNode:(id)sender {
  ${objc.nameType(widget.id)}Tree* tree = (${objc.nameType(widget.id)}Tree*)self.superview;
  [tree clearSelectedNode];
  NSTextField* label = self->title.subviews[0];
  [label setTextColor:[[Theme current] getColorNamed:COLOR_ACCENT]];
  label = self->control.subviews[0];
  [label setTextColor:[[Theme current] getColorNamed:COLOR_ACCENT]];
  label = self->more.subviews[0];
  [label setTextColor:[[Theme current] getColorNamed:COLOR_ACCENT]];
  [self addSubview:self->more];
}

- (void)onMoreActions:(id)sender {
  NSButton* target = (NSButton*)sender;
  [self->moreActions showRelativeToRect:[target bounds] ofView:sender preferredEdge:(NSRectEdge)CGRectMinXEdge];
}

@end
