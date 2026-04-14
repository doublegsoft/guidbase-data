<#macro print_element_declare page widget firstWidgetInPage firstWidgetInRow rowIndex childIndex indent>
  <#assign pageWidth = page.position.size.width>
  <#assign pageHeight = page.position.size.height>
  <#assign widgetX = widget.position.rowIndex>
  <#assign widgetY = widget.position.cellIndex>
  <#assign widgetWidth = widget.size.width>
  <#assign widgetHeight = widget.size.height>
  <#assign firstY = firstWidgetInPage.position.cellIndex>
  <#if widget.type == "row">
    <#list widget.children as child>
<@print_element_declare page=page widget=child firstWidgetInPage=firstWidgetInPage firstWidgetInRow=firstWidgetInRow rowIndex=rowIndex childIndex=child?index indent=indent />  
    </#list>
    <#return>
  </#if>
  <#if childIndex == 0>
${""?left_pad(indent)}x = PADDING_LEFT;
  <#else>
${""?left_pad(indent)}x = PADDING_LEFT + ${(widgetX - firstWidgetInRow.position.rowIndex)?string("#")} * ratioOfWidth;
  </#if>
  <#if rowIndex == 0>
${""?left_pad(indent)}y = PADDING_TOP;
  <#else>
    <#if childIndex == 0>
${""?left_pad(indent)}y = PADDING_TOP + ${(widgetY - firstWidgetInPage.position.cellIndex)?string("#")} * ratioOfHeight;
    <#else>
${""?left_pad(indent)}y = PADDING_TOP + ${(firstWidgetInRow.position.cellIndex - firstWidgetInPage.position.cellIndex)?string("#")} * ratioOfHeight;    
    </#if>
  </#if>
  <#if widget.type == "text">
${""?left_pad(indent)}// 标签  
${""?left_pad(indent)}label = [[UILabel alloc] init];
    <#if (widgetHeight >= 48)>
${""?left_pad(indent)}label.numberOfLines = 0; 
${""?left_pad(indent)}label.lineBreakMode = NSLineBreakByWordWrapping; 
    </#if>
${""?left_pad(indent)}label.frame = CGRectMake(x, y, width - x * 2, 24);
${""?left_pad(indent)}label.text = @"${widget.text?trim}";
${""?left_pad(indent)}[label sizeToFit];
${""?left_pad(indent)}[self.contentView addSubview:label];
  <#elseif widget.type == "icon">
${""?left_pad(indent)}// 图标
${""?left_pad(indent)}icon = [[UIImageView alloc] init];
${""?left_pad(indent)}icon.backgroundColor = [UIColor blueColor];
${""?left_pad(indent)}icon.frame = CGRectMake(x, y, ICON_WIDTH, ICON_HEIGHT);
${""?left_pad(indent)}[self.contentView addSubview:icon];
  <#elseif widget.type == "image">
${""?left_pad(indent)}// 图片
${""?left_pad(indent)}w = ${(widgetWidth / pageWidth)} * size.width;
${""?left_pad(indent)}h = ${(widgetHeight / pageHeight)} * size.height;
${""?left_pad(indent)}icon = [[UIImageView alloc] init];
${""?left_pad(indent)}icon.backgroundColor = [UIColor redColor];
${""?left_pad(indent)}icon.frame = CGRectMake(x, y, w, h);
${""?left_pad(indent)}[self.contentView addSubview:icon];
  <#else>
${""?left_pad(indent)}// 标签  
${""?left_pad(indent)}w = ${(widgetWidth / pageWidth)} * size.width;
${""?left_pad(indent)}h = ${(widgetHeight / pageHeight)} * size.height;  
${""?left_pad(indent)}label = [[UILabel alloc] init];
${""?left_pad(indent)}label.text = @"${widget.text!""}";
${""?left_pad(indent)}label.frame = CGRectMake(x, y, w, h);
${""?left_pad(indent)}[self.contentView addSubview:label];
  </#if>
</#macro>