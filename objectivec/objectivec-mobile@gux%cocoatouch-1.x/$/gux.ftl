<#--
 ###############################################################################
 ### 【自定义导航栏】
 ###############################################################################
 -->
<#macro print_objectivec_declare_navigation_bar widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_objectivec_fields_navigation_bar widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_objectivec_methods_navigation_bar widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#--
 ###############################################################################
 ### 【工具栏位】
 ###############################################################################
 -->
<#macro print_objectivec_declare_toolbar widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_objectivec_fields_toolbar widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_objectivec_methods_toolbar widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#--
 ###############################################################################
 ### 【编辑表单】
 ###############################################################################
 -->
<#macro print_objectivec_declare_editable_form widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_objectivec_fields_editable_form widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_objectivec_methods_editable_form widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#--
 ###############################################################################
 ### 【只读表单】
 ###############################################################################
 -->
<#macro print_objectivec_declare_readonly_form widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_objectivec_fields_readonly_form widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_objectivec_methods_readonly_form widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#--
 ###############################################################################
 ### 【分页页签】
 ###############################################################################
 -->
<#macro print_objectivec_declare_tabs widget indent>
${""?left_pad(indent)}self.${objectivec.nameVariable(widget.id)} = [[UISegmentedControl alloc] init];
${""?left_pad(indent)}self.${objectivec.nameVariable(widget.id)}.frame = CGRectMake(Styles.padding, y,
${""?left_pad(indent)}                                         contentWidth, Styles.tabsHeight);
${""?left_pad(indent)}
  <#list widget.widgets as child>
${""?left_pad(indent)}[self.${objectivec.nameVariable(widget.id)} insertSegmentWithTitle:@"${child.options["title"]!"标签"}" atIndex:${child?index} animated:YES];
  </#list>
${""?left_pad(indent)}
${""?left_pad(indent)}self.${objectivec.nameVariable(widget.id)}.tintColor = Styles.primaryColor;
${""?left_pad(indent)}self.${objectivec.nameVariable(widget.id)}.selectedTabIndex4${objectivec.nameType(widget.id)} = 0;
${""?left_pad(indent)}
${""?left_pad(indent)}[self.${objectivec.nameVariable(widget.id)} addTarget:self action:@selector(${objectivec.nameVariable(widget.id)}TabChanged:) forControlEvents:UIControlEventValueChanged]; 
</#macro>

<#macro print_objectivec_fields_tabs widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}/*!
${""?left_pad(indent)}** 【${widget.options["title"]!"标题"}】分页标签界面对象。
${""?left_pad(indent)}*/
${""?left_pad(indent)}@property (nonatomic, strong) UISegmentedControl* ${objectivec.nameVariable(widget.id)};
${""?left_pad(indent)}
${""?left_pad(indent)}/*!
${""?left_pad(indent)}** 【${widget.options["title"]!"标题"}分页标签选中的序号。
${""?left_pad(indent)}*/
${""?left_pad(indent)}@property (nonatomic) NSInteger selectedTabIndex4${objectivec.nameType(widget.id)};
</#macro>

<#macro print_objectivec_methods_tabs widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}/*!
${""?left_pad(indent)}** 改变【${widget.options["title"]!"标签"}】分页标签的选择项而触发的方法。
${""?left_pad(indent)}*/
${""?left_pad(indent)}- (void)${objectivec.nameVariable(widget.id)}TabChanged:(UISegmentedControl *)sender {
${""?left_pad(indent)}  self.selectedTabIndex4${objectivec.nameType(widget.id)} = sender.selectedSegmentIndex;
${""?left_pad(indent)}} 
</#macro>

<#--
 ###############################################################################
 ### 【通知公告】
 ###############################################################################
 -->
<#macro print_objectivec_declare_scroll_notification widget indent>
${""?left_pad(indent)}UIView* scrollNotification = [[UIView alloc] initWithFrame:CGRectMake(0, y, GUX.screenWidth, 24)];
${""?left_pad(indent)}UIImageView* icon = [[UIImageView alloc] initWithFrame:CGRectMake(Styles.padding, 2, 20, 20)];
${""?left_pad(indent)}icon.image = [UIImage imageNamed:@"Image.Icon.Broadcast"];
${""?left_pad(indent)}
${""?left_pad(indent)}[scrollNotification addSubview:icon]; 
${""?left_pad(indent)}
${""?left_pad(indent)}self.carousel${objectivec.nameType(widget.id)} = [[iCarousel alloc] init];
${""?left_pad(indent)}self.carousel${objectivec.nameType(widget.id)}.frame = CGRectMake(Styles.padding * 3 / 2 + 20, 0, GUX.screenWidth - Styles.padding * 2 - 24, 24);
${""?left_pad(indent)}self.carousel${objectivec.nameType(widget.id)}.delegate = self;
${""?left_pad(indent)}self.carousel${objectivec.nameType(widget.id)}.dataSource = self;
${""?left_pad(indent)}self.carousel${objectivec.nameType(widget.id)}.vertical = YES;
${""?left_pad(indent)}self.carousel${objectivec.nameType(widget.id)}.type = iCarouselTypeLinear;
${""?left_pad(indent)}
${""?left_pad(indent)}[scrollNotification addSubview:self.carousel${objectivec.nameType(widget.id)}]; 
</#macro>

<#macro print_objectivec_fields_scroll_notification widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}/*!
${""?left_pad(indent)}** 【${widget.options["title"]!"标题"}】滚动通知界面对象。
${""?left_pad(indent)}*/
${""?left_pad(indent)}@property (nonatomic, strong) iCarousel* carousel${objectivec.nameType(widget.id)};
${""?left_pad(indent)}
${""?left_pad(indent)}/*!
${""?left_pad(indent)}** 【${widget.options["title"]!"标题"}】滚动通知自动翻页控制器。
${""?left_pad(indent)}*/
${""?left_pad(indent)}@property (nonatomic, strong) NSTimer* timer4${objectivec.nameType(widget.id)};
</#macro>

<#macro print_objectivec_methods_scroll_notification widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}#pragma mark - iCarouselDataSource
${""?left_pad(indent)}
${""?left_pad(indent)}/*!
${""?left_pad(indent)}** 第三方组件传送带的传送项个数。
${""?left_pad(indent)}*/
${""?left_pad(indent)}- (NSInteger)numberOfItemsInCarousel:(iCarousel*)carousel
${""?left_pad(indent)}{
${""?left_pad(indent)}  return 3;
${""?left_pad(indent)}}
${""?left_pad(indent)}
${""?left_pad(indent)}/*!
${""?left_pad(indent)}** 第三方组件传送带根据索引号绘制单项界面。
${""?left_pad(indent)}*/
${""?left_pad(indent)}- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view
${""?left_pad(indent)}{
${""?left_pad(indent)}  if (view == nil)
${""?left_pad(indent)}  {
${""?left_pad(indent)}    UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(Styles.padding + 24, 4, GUX.screenWidth - Styles.padding * 2 - 24, 24)];
${""?left_pad(indent)}    label.font = [UIFont systemFontOfSize:12 weight:UIFontWeightRegular];
${""?left_pad(indent)}    label.textColor = Styles.textSecondaryColor;
${""?left_pad(indent)}    if (index == 0) {
${""?left_pad(indent)}      label.text = @"GUX CocoaTouch ObjectiveC框架已经启动了！";
${""?left_pad(indent)}    } else if (index == 1) {
${""?left_pad(indent)}      label.text = @"目前GUX支持H5、WeChat、iOS了。";
${""?left_pad(indent)}    } else {
${""?left_pad(indent)}      label.text = @"预祝GUX项目取得成功！！";
${""?left_pad(indent)}    }
${""?left_pad(indent)}    view = label;
${""?left_pad(indent)}  }
${""?left_pad(indent)}  view.hidden = carousel.currentItemIndex != index;
${""?left_pad(indent)}  return view;
${""?left_pad(indent)}}
${""?left_pad(indent)}
${""?left_pad(indent)}/*!
${""?left_pad(indent)}** 第三方组件传送带的获取当前不同选项的值。
${""?left_pad(indent)}*/
${""?left_pad(indent)}- (CGFloat)carousel:(iCarousel *)carousel valueForOption:(iCarouselOption)option withDefault:(CGFloat)value {
${""?left_pad(indent)}  switch (option)
${""?left_pad(indent)}  {
${""?left_pad(indent)}    case iCarouselOptionWrap:
${""?left_pad(indent)}    {
${""?left_pad(indent)}      //normally you would hard-code this to YES or NO
${""?left_pad(indent)}      return YES;
${""?left_pad(indent)}    }
${""?left_pad(indent)}    case iCarouselOptionSpacing:
${""?left_pad(indent)}    {
${""?left_pad(indent)}      //add a bit of spacing between the item views
${""?left_pad(indent)}      return value * 1.0;
${""?left_pad(indent)}    }
${""?left_pad(indent)}    case iCarouselOptionFadeMax:
${""?left_pad(indent)}    {
${""?left_pad(indent)}      return value;
${""?left_pad(indent)}    }
${""?left_pad(indent)}    case iCarouselOptionShowBackfaces:
${""?left_pad(indent)}    case iCarouselOptionRadius:
${""?left_pad(indent)}    case iCarouselOptionAngle:
${""?left_pad(indent)}    case iCarouselOptionArc:
${""?left_pad(indent)}    case iCarouselOptionTilt:
${""?left_pad(indent)}    case iCarouselOptionCount:
${""?left_pad(indent)}    case iCarouselOptionFadeMin:
${""?left_pad(indent)}    case iCarouselOptionFadeMinAlpha:
${""?left_pad(indent)}    case iCarouselOptionFadeRange:
${""?left_pad(indent)}    case iCarouselOptionOffsetMultiplier:
${""?left_pad(indent)}    case iCarouselOptionVisibleItems:
${""?left_pad(indent)}    {
${""?left_pad(indent)}      return value;
${""?left_pad(indent)}    }
${""?left_pad(indent)}  }
${""?left_pad(indent)}}
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}#pragma mark - iCarouselDelegate
${""?left_pad(indent)}
${""?left_pad(indent)}/*!
${""?left_pad(indent)}** 第三方组件传送带的传送项改变所触发的方法。
${""?left_pad(indent)}*/
${""?left_pad(indent)}- (void)carouselCurrentItemIndexDidChange:(iCarousel *)carousel {
${""?left_pad(indent)}  [carousel reloadData];
${""?left_pad(indent)}} 
</#macro>

<#--
 ###############################################################################
 ### 【滚动导航】
 ###############################################################################
 -->
<#macro print_objectivec_declare_swiper_navigator widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_objectivec_fields_swiper_navigator widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_objectivec_methods_swiper_navigator widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#--
 ###############################################################################
 ### 【滑动导航】
 ###############################################################################
 -->
<#macro print_objectivec_declare_scroll_navigator widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_objectivec_fields_scroll_navigator widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_objectivec_methods_scroll_navigator widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#--
 ###############################################################################
 ### 【列表导航】
 ###############################################################################
 -->
<#macro print_objectivec_declare_list_navigator widget indent>
${""?left_pad(indent)}UIScrollView* scroll4${objectivec.nameType(widget.id)} = [[UIScrollView alloc] init];
${""?left_pad(indent)}scroll4${objectivec.nameType(widget.id)}.frame = CGRectMake(0, y, GUX.screenWidth, GUX.screenHeight - y - Styles.padding);
${""?left_pad(indent)}[self.view addSubview:scroll4${objectivec.nameType(widget.id)}];
${""?left_pad(indent)}
${""?left_pad(indent)}long yInScroll4${objectivec.nameType(widget.id)} = 0;
  <#list widget.widgets as child>
${""?left_pad(indent)}[scroll4${objectivec.nameType(widget.id)} addSubview:[self makeTile4${objectivec.nameType(widget.id)}AtY:yInScroll4${objectivec.nameType(widget.id)} andImage:@"" andTitle:@"${widget.options["title"]!"标题"}"]];
${""?left_pad(indent)}yInScroll4${objectivec.nameType(widget.id)} += Styles.navigatorTileHeight;
  </#list>
${""?left_pad(indent)}
${""?left_pad(indent)}scroll4${objectivec.nameType(widget.id)}.contentSize = CGSizeMake(GUX.screenWidth, yInScroll); 
</#macro>

<#macro print_objectivec_fields_list_navigator widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_objectivec_methods_list_navigator widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}/*!
${""?left_pad(indent)}** 在具体的Y轴坐标下，构造【${widget.options["title"]!"标题"}】列表导航的瓦片项。
${""?left_pad(indent)}*/
${""?left_pad(indent)}- (UIView*)makeTile4${objectivec.nameType(widget.id)}AtY:(long)y andImage:(NSString*)imageName andTitle:(NSString*)title {
${""?left_pad(indent)}  UIView* ret = [[UIView alloc] init];
${""?left_pad(indent)}  int height = 56;
${""?left_pad(indent)}  int iconWidth = 36;
${""?left_pad(indent)}  ret.frame = CGRectMake(Styles.padding, y, GUX.screenWidth - Styles.padding * 2, height);
${""?left_pad(indent)}
${""?left_pad(indent)}  UIImageView* imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
${""?left_pad(indent)}  imageView.frame = CGRectMake(0, (height - iconWidth) / 2, iconWidth, iconWidth);
${""?left_pad(indent)}  [ret addSubview:imageView];
${""?left_pad(indent)}
${""?left_pad(indent)}  UILabel* label = [[UILabel alloc] init];
${""?left_pad(indent)}  label.frame = CGRectMake(iconWidth + Styles.padding, (height - 20) / 2, 120, 20);
${""?left_pad(indent)}  label.text = title;
${""?left_pad(indent)}  [ret addSubview:label];
${""?left_pad(indent)}
${""?left_pad(indent)}  iconWidth = 20;
${""?left_pad(indent)}  UIImageView* iconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Image.Icon.Right_Arrow"]];
${""?left_pad(indent)}  iconView.frame = CGRectMake(ret.frame.size.width - iconWidth,
${""?left_pad(indent)}                              (height - iconWidth) / 2, iconWidth, iconWidth);
${""?left_pad(indent)}  [ret addSubview:iconView];
${""?left_pad(indent)}
${""?left_pad(indent)}  UIView *bottomLine = [[UIView alloc] initWithFrame:CGRectMake(0, ret.frame.size.height - 1, ret.frame.size.width, 1)];
${""?left_pad(indent)}  bottomLine.backgroundColor = Styles.dividerColor;
${""?left_pad(indent)}  [ret addSubview:bottomLine];
${""?left_pad(indent)}
${""?left_pad(indent)}  UITapGestureRecognizer* tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doTap${objectivec.nameType(widget.id)}Tile:)];
${""?left_pad(indent)}  [ret addGestureRecognizer:tapGesture];
${""?left_pad(indent)}
${""?left_pad(indent)}  return ret;
${""?left_pad(indent)}} 
${""?left_pad(indent)}
${""?left_pad(indent)}/*!
${""?left_pad(indent)}** 点击【${widget.options["title"]!"标题"}】列表导航中瓦片项的处理方法。
${""?left_pad(indent)}*/
${""?left_pad(indent)}- (void)doTap${objectivec.nameType(widget.id)}Tile:(UITapGestureRecognizer *)sender {
${""?left_pad(indent)}  [self.navigationController.view makeToast:@"模拟跳转到指定页面"];
${""?left_pad(indent)}}
</#macro>

<#--
 ###############################################################################
 ### 【栅格导航】
 ###############################################################################
 -->
<#macro print_objectivec_declare_grid_navigator widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_objectivec_fields_grid_navigator widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_objectivec_methods_grid_navigator widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#--
 ###############################################################################
 ### 【搜索栏位】
 ###############################################################################
 -->
<#macro print_objectivec_declare_search_bar widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_objectivec_fields_search_bar widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_objectivec_methods_search_bar widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#--
 ###############################################################################
 ### 【事件日历】
 ###############################################################################
 -->
<#macro print_objectivec_declare_calendar widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_objectivec_fields_calendar widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_objectivec_methods_calendar widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#--
 ###############################################################################
 ### 【树型结构】
 ###############################################################################
 -->
<#macro print_objectivec_declare_tree widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_objectivec_fields_tree widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_objectivec_methods_tree widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#--
 ###############################################################################
 ### 【内容编辑】
 ###############################################################################
 -->
<#macro print_objectivec_declare_content_editor widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_objectivec_fields_content_editor widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_objectivec_methods_content_editor widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#--
 ###############################################################################
 ### 【系统输出】
 ###############################################################################
 -->
<#macro print_objectivec_declare_system_console widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_objectivec_fields_system_console widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_objectivec_methods_system_console widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#--
 ###############################################################################
 ### 【手机模拟】
 ###############################################################################
 -->
<#macro print_objectivec_declare_mobile_simulator widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_objectivec_fields_mobile_simulator widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_objectivec_methods_mobile_simulator widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#--
 ###############################################################################
 ### 【传统列表】
 ###############################################################################
 -->
<#macro print_objectivec_declare_list_view widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_objectivec_fields_list_view widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_objectivec_methods_list_view widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#--
 ###############################################################################
 ### 【栅格列表】
 ###############################################################################
 -->
<#macro print_objectivec_declare_grid_view widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_objectivec_fields_grid_view widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_objectivec_methods_grid_view widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#--
 ###############################################################################
 ### 【时间线条】
 ###############################################################################
 -->
<#macro print_objectivec_declare_timeline widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_objectivec_fields_timeline widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_objectivec_methods_timeline widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#--
 ###############################################################################
 ### 【分页表格】
 ###############################################################################
 -->
<#macro print_objectivec_declare_pagination_table widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_objectivec_fields_pagination_table widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_objectivec_methods_pagination_table widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#--
 ###############################################################################
 ### 【分页栅格】
 ###############################################################################
 -->
<#macro print_objectivec_declare_pagination_grid widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_objectivec_fields_pagination_grid widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_objectivec_methods_pagination_grid widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#--
 ###############################################################################
 ### 【广义表格】
 ###############################################################################
 -->
<#macro print_objectivec_declare_spreadsheet widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_objectivec_fields_spreadsheet widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_objectivec_methods_spreadsheet widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#--
 ###############################################################################
 ### 【看板列表】
 ###############################################################################
 -->
<#macro print_objectivec_declare_kanban widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_objectivec_fields_kanban widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_objectivec_methods_kanban widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#--
 ###############################################################################
 ### 【聊天列表】
 ###############################################################################
 -->
<#macro print_objectivec_declare_chat widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_objectivec_fields_chat widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_objectivec_methods_chat widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#--
 ###############################################################################
 ### 【饼状图】
 ###############################################################################
 -->
<#macro print_objectivec_declare_pie_chart widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_objectivec_fields_pie_chart widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_objectivec_methods_pie_chart widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#--
 ###############################################################################
 ### 【圈状图】
 ###############################################################################
 -->
<#macro print_objectivec_declare_donut_chart widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_objectivec_fields_donut_chart widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_objectivec_methods_donut_chart widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#--
 ###############################################################################
 ### 【柱状图】
 ###############################################################################
 -->
<#macro print_objectivec_declare_bar_chart widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_objectivec_fields_bar_chart widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_objectivec_methods_bar_chart widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#--
 ###############################################################################
 ### 【折线图】
 ###############################################################################
 -->
<#macro print_objectivec_declare_line_chart widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_objectivec_fields_line_chart widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_objectivec_methods_line_chart widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#--
 ###############################################################################
 ### 【堆栈图】
 ###############################################################################
 -->
<#macro print_objectivec_declare_stack_chart widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_objectivec_fields_stack_chart widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_objectivec_methods_stack_chart widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#--
 ###############################################################################
 ### 【雷达图】
 ###############################################################################
 -->
<#macro print_objectivec_declare_radar_chart widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_objectivec_fields_radar_chart widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_objectivec_methods_radar_chart widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#--
 ###############################################################################
 ### 【网络拓扑图】
 ###############################################################################
 -->
<#macro print_objectivec_declare_network_topology_diagram widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_objectivec_fields_network_topology_diagram widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_objectivec_methods_network_topology_diagram widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#--
 ###############################################################################
 ### 【业务流程图】
 ###############################################################################
 -->
<#macro print_objectivec_declare_business_process_diagram widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_objectivec_fields_business_process_diagram widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_objectivec_methods_business_process_diagram widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#--
 ###############################################################################
 ### 【底部弹框】
 ###############################################################################
 -->
<#macro print_objectivec_declare_bottom_sheet widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_objectivec_fields_bottom_sheet widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_objectivec_methods_bottom_sheet widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#--
 ###############################################################################
 ### 【整体部件】
 ###############################################################################
 -->

<#-- OBJECTIVEC DECLARE -->
<#macro print_objectivec_declare_widget widget indent>
  <#if widget.type == "navigation_bar">  
<@gux.print_objectivec_declare_navigation_bar widget=widget indent=indent />
  <#elseif widget.type == "toolbar">  
<@gux.print_objectivec_declare_toolbar widget=widget indent=indent />
  <#elseif widget.type == "editable_form">  
<@gux.print_objectivec_declare_editable_form widget=widget indent=indent />
  <#elseif widget.type == "readonly_form">  
<@gux.print_objectivec_declare_readonly_form widget=widget indent=indent />
  <#elseif widget.type == "tabs">  
<@gux.print_objectivec_declare_tabs widget=widget indent=indent />
  <#elseif widget.type == "scroll_notification">  
<@gux.print_objectivec_declare_scroll_notification widget=widget indent=indent />
  <#elseif widget.type == "swiper_navigator">  
<@gux.print_objectivec_declare_swiper_navigator widget=widget indent=indent />
  <#elseif widget.type == "scroll_navigator">  
<@gux.print_objectivec_declare_scroll_navigator widget=widget indent=indent />
  <#elseif widget.type == "list_navigator">  
<@gux.print_objectivec_declare_list_navigator widget=widget indent=indent />
  <#elseif widget.type == "grid_navigator">  
<@gux.print_objectivec_declare_grid_navigator widget=widget indent=indent />
  <#elseif widget.type == "search_bar">  
<@gux.print_objectivec_declare_search_bar widget=widget indent=indent />
  <#elseif widget.type == "calendar">  
<@gux.print_objectivec_declare_calendar widget=widget indent=indent />
  <#elseif widget.type == "tree">  
<@gux.print_objectivec_declare_tree widget=widget indent=indent />
  <#elseif widget.type == "content_editor">  
<@gux.print_objectivec_declare_content_editor widget=widget indent=indent />
  <#elseif widget.type == "system_console">  
<@gux.print_objectivec_declare_system_console widget=widget indent=indent />
  <#elseif widget.type == "mobile_simulator">  
<@gux.print_objectivec_declare_mobile_simulator widget=widget indent=indent />
  <#elseif widget.type == "list_view">  
<@gux.print_objectivec_declare_list_view widget=widget indent=indent />
  <#elseif widget.type == "grid_view">  
<@gux.print_objectivec_declare_grid_view widget=widget indent=indent />
  <#elseif widget.type == "timeline">  
<@gux.print_objectivec_declare_timeline widget=widget indent=indent />
  <#elseif widget.type == "pagination_table">  
<@gux.print_objectivec_declare_pagination_table widget=widget indent=indent />
  <#elseif widget.type == "pagination_grid">  
<@gux.print_objectivec_declare_pagination_grid widget=widget indent=indent />
  <#elseif widget.type == "spreadsheet">  
<@gux.print_objectivec_declare_spreadsheet widget=widget indent=indent />
  <#elseif widget.type == "kanban">  
<@gux.print_objectivec_declare_kanban widget=widget indent=indent />
  <#elseif widget.type == "chat">  
<@gux.print_objectivec_declare_chat widget=widget indent=indent />
  <#elseif widget.type == "pie_chart">  
<@gux.print_objectivec_declare_pie_chart widget=widget indent=indent />
  <#elseif widget.type == "donut_chart">  
<@gux.print_objectivec_declare_donut_chart widget=widget indent=indent />
  <#elseif widget.type == "bar_chart">  
<@gux.print_objectivec_declare_bar_chart widget=widget indent=indent />
  <#elseif widget.type == "line_chart">  
<@gux.print_objectivec_declare_line_chart widget=widget indent=indent />
  <#elseif widget.type == "stack_chart">  
<@gux.print_objectivec_declare_stack_chart widget=widget indent=indent />
  <#elseif widget.type == "radar_chart">  
<@gux.print_objectivec_declare_radar_chart widget=widget indent=indent />
  <#elseif widget.type == "network_topology_diagram">  
<@gux.print_objectivec_declare_network_topology_diagram widget=widget indent=indent />
  <#elseif widget.type == "business_process_diagram">  
<@gux.print_objectivec_declare_business_process_diagram widget=widget indent=indent />
  <#elseif widget.type == "bottom_sheet">  
<@gux.print_objectivec_declare_bottom_sheet widget=widget indent=indent />
  </#if>
</#macro>  

<#-- OBJECTIVEC FIELDS -->
<#macro print_objectivec_fields_widget widget indent>
  <#if widget.type == "navigation_bar">  
<@gux.print_objectivec_fields_navigation_bar widget=widget indent=indent />
  <#elseif widget.type == "toolbar">  
<@gux.print_objectivec_fields_toolbar widget=widget indent=indent />
  <#elseif widget.type == "editable_form">  
<@gux.print_objectivec_fields_editable_form widget=widget indent=indent />
  <#elseif widget.type == "readonly_form">  
<@gux.print_objectivec_fields_readonly_form widget=widget indent=indent />
  <#elseif widget.type == "tabs">  
<@gux.print_objectivec_fields_tabs widget=widget indent=indent />
  <#elseif widget.type == "scroll_notification">  
<@gux.print_objectivec_fields_scroll_notification widget=widget indent=indent />
  <#elseif widget.type == "swiper_navigator">  
<@gux.print_objectivec_fields_swiper_navigator widget=widget indent=indent />
  <#elseif widget.type == "scroll_navigator">  
<@gux.print_objectivec_fields_scroll_navigator widget=widget indent=indent />
  <#elseif widget.type == "list_navigator">  
<@gux.print_objectivec_fields_list_navigator widget=widget indent=indent />
  <#elseif widget.type == "grid_navigator">  
<@gux.print_objectivec_fields_grid_navigator widget=widget indent=indent />
  <#elseif widget.type == "search_bar">  
<@gux.print_objectivec_fields_search_bar widget=widget indent=indent />
  <#elseif widget.type == "calendar">  
<@gux.print_objectivec_fields_calendar widget=widget indent=indent />
  <#elseif widget.type == "tree">  
<@gux.print_objectivec_fields_tree widget=widget indent=indent />
  <#elseif widget.type == "content_editor">  
<@gux.print_objectivec_fields_content_editor widget=widget indent=indent />
  <#elseif widget.type == "system_console">  
<@gux.print_objectivec_fields_system_console widget=widget indent=indent />
  <#elseif widget.type == "mobile_simulator">  
<@gux.print_objectivec_fields_mobile_simulator widget=widget indent=indent />
  <#elseif widget.type == "list_view">  
<@gux.print_objectivec_fields_list_view widget=widget indent=indent />
  <#elseif widget.type == "grid_view">  
<@gux.print_objectivec_fields_grid_view widget=widget indent=indent />
  <#elseif widget.type == "timeline">  
<@gux.print_objectivec_fields_timeline widget=widget indent=indent />
  <#elseif widget.type == "pagination_table">  
<@gux.print_objectivec_fields_pagination_table widget=widget indent=indent />
  <#elseif widget.type == "pagination_grid">  
<@gux.print_objectivec_fields_pagination_grid widget=widget indent=indent />
  <#elseif widget.type == "spreadsheet">  
<@gux.print_objectivec_fields_spreadsheet widget=widget indent=indent />
  <#elseif widget.type == "kanban">  
<@gux.print_objectivec_fields_kanban widget=widget indent=indent />
  <#elseif widget.type == "chat">  
<@gux.print_objectivec_fields_chat widget=widget indent=indent />
  <#elseif widget.type == "pie_chart">  
<@gux.print_objectivec_fields_pie_chart widget=widget indent=indent />
  <#elseif widget.type == "donut_chart">  
<@gux.print_objectivec_fields_donut_chart widget=widget indent=indent />
  <#elseif widget.type == "bar_chart">  
<@gux.print_objectivec_fields_bar_chart widget=widget indent=indent />
  <#elseif widget.type == "line_chart">  
<@gux.print_objectivec_fields_line_chart widget=widget indent=indent />
  <#elseif widget.type == "stack_chart">  
<@gux.print_objectivec_fields_stack_chart widget=widget indent=indent />
  <#elseif widget.type == "radar_chart">  
<@gux.print_objectivec_fields_radar_chart widget=widget indent=indent />
  <#elseif widget.type == "network_topology_diagram">  
<@gux.print_objectivec_fields_network_topology_diagram widget=widget indent=indent />
  <#elseif widget.type == "business_process_diagram">  
<@gux.print_objectivec_fields_business_process_diagram widget=widget indent=indent />
  <#elseif widget.type == "bottom_sheet">  
<@gux.print_objectivec_fields_bottom_sheet widget=widget indent=indent />
  </#if>
</#macro>  

<#-- OBJECTIVEC METHODS -->
<#macro print_objectivec_methods_widget widget indent>
  <#if widget.type == "navigation_bar">  
<@gux.print_objectivec_methods_navigation_bar widget=widget indent=indent />
  <#elseif widget.type == "toolbar"> 
<@gux.print_objectivec_methods_toolbar widget=widget indent=indent />
  <#elseif widget.type == "editable_form"> 
<@gux.print_objectivec_methods_editable_form widget=widget indent=indent />
  <#elseif widget.type == "readonly_form"> 
<@gux.print_objectivec_methods_readonly_form widget=widget indent=indent />
  <#elseif widget.type == "tabs"> 
<@gux.print_objectivec_methods_tabs widget=widget indent=indent />
  <#elseif widget.type == "scroll_notification"> 
<@gux.print_objectivec_methods_scroll_notification widget=widget indent=indent />
  <#elseif widget.type == "swiper_navigator"> 
<@gux.print_objectivec_methods_swiper_navigator widget=widget indent=indent />
  <#elseif widget.type == "scroll_navigator"> 
<@gux.print_objectivec_methods_scroll_navigator widget=widget indent=indent />
  <#elseif widget.type == "list_navigator"> 
<@gux.print_objectivec_methods_list_navigator widget=widget indent=indent />
  <#elseif widget.type == "grid_navigator"> 
<@gux.print_objectivec_methods_grid_navigator widget=widget indent=indent />
  <#elseif widget.type == "search_bar"> 
<@gux.print_objectivec_methods_search_bar widget=widget indent=indent />
  <#elseif widget.type == "calendar"> 
<@gux.print_objectivec_methods_calendar widget=widget indent=indent />
  <#elseif widget.type == "tree"> 
<@gux.print_objectivec_methods_tree widget=widget indent=indent />
  <#elseif widget.type == "content_editor"> 
<@gux.print_objectivec_methods_content_editor widget=widget indent=indent />
  <#elseif widget.type == "system_console"> 
<@gux.print_objectivec_methods_system_console widget=widget indent=indent />
  <#elseif widget.type == "mobile_simulator"> 
<@gux.print_objectivec_methods_mobile_simulator widget=widget indent=indent />
  <#elseif widget.type == "list_view"> 
<@gux.print_objectivec_methods_list_view widget=widget indent=indent />
  <#elseif widget.type == "grid_view"> 
<@gux.print_objectivec_methods_grid_view widget=widget indent=indent />
  <#elseif widget.type == "timeline"> 
<@gux.print_objectivec_methods_timeline widget=widget indent=indent />
  <#elseif widget.type == "pagination_table"> 
<@gux.print_objectivec_methods_pagination_table widget=widget indent=indent />
  <#elseif widget.type == "pagination_grid"> 
<@gux.print_objectivec_methods_pagination_grid widget=widget indent=indent />
  <#elseif widget.type == "spreadsheet"> 
<@gux.print_objectivec_methods_spreadsheet widget=widget indent=indent />
  <#elseif widget.type == "kanban"> 
<@gux.print_objectivec_methods_kanban widget=widget indent=indent />
  <#elseif widget.type == "chat"> 
<@gux.print_objectivec_methods_chat widget=widget indent=indent />
  <#elseif widget.type == "pie_chart"> 
<@gux.print_objectivec_methods_pie_chart widget=widget indent=indent />
  <#elseif widget.type == "donut_chart"> 
<@gux.print_objectivec_methods_donut_chart widget=widget indent=indent />
  <#elseif widget.type == "bar_chart"> 
<@gux.print_objectivec_methods_bar_chart widget=widget indent=indent />
  <#elseif widget.type == "line_chart"> 
<@gux.print_objectivec_methods_line_chart widget=widget indent=indent />
  <#elseif widget.type == "stack_chart"> 
<@gux.print_objectivec_methods_stack_chart widget=widget indent=indent />
  <#elseif widget.type == "radar_chart"> 
<@gux.print_objectivec_methods_radar_chart widget=widget indent=indent />
  <#elseif widget.type == "network_topology_diagram"> 
<@gux.print_objectivec_methods_network_topology_diagram widget=widget indent=indent />
  <#elseif widget.type == "business_process_diagram"> 
<@gux.print_objectivec_methods_business_process_diagram widget=widget indent=indent />
  <#elseif widget.type == "bottom_sheet"> 
<@gux.print_objectivec_methods_bottom_sheet widget=widget indent=indent />
  </#if>
</#macro>  
