<#import "/$/guidbase.ftl" as guidbase>

<#function url_to_page_name url>
  <#local method = guidbase.url_to_method_name(url)>
  <#return method?replace("goto_", "")?replace("do_", "")>
</#function>

<#macro print_method_body_by_url url indent>
  <#local pagepath = guidbase.url_to_page_path(url)>
  <#local params = guidbase.get_params_from_url(url)>
  <#if url?starts_with("$")>
${""?left_pad(indent)}Navigator.pushNamed(context, '/${pagepath}', arguments: <String,dynamic>{
    <#list params as param>
${""?left_pad(indent)}  '${param.name}': <#if param.value??>'${param.value}'<#else>params['${param.name}']</#if>,
    </#list>
${""?left_pad(indent)}},);
  <#elseif url?starts_with("/")>
${""?left_pad(indent)} // call api  
    <#local successPage = "">
    <#local index = url?index_of("$")>
    <#if index != -1 > 
<@print_method_body_by_url url=url?substring(index+1) indent=indent />    
    </#if>
  </#if>
</#macro>

<#--
 ###############################################################################
 ### 【数据瓦片】构造方法
 ###############################################################################
 --> 
<#macro print_dart_declare_tile widget indent>
  <#local hasContainer = false>
  <#if widget.container.type == "grid_navigator">
    <#local columns = widget.container.options["columns"]!"2">
  </#if>
  <#if widget.container.type == "list_view">
    <#local hasContainer = true>
${""?left_pad(indent)}buildTile4${dart.nameType(widget.container.id)}(row),
    <#return>
  </#if>
  <#local container = widget.container>
  <#local objname = container.options["object"]!"object">
${""?left_pad(indent)}Container(  
  <#if columns??>
${""?left_pad(indent)}  width: (MediaQuery.of(context).size.width - styles.padding * (${columns} + 4)) / ${columns},  
${""?left_pad(indent)}  decoration: BoxDecoration(
${""?left_pad(indent)}    color: styles.colorSurface,
${""?left_pad(indent)}    borderRadius: BorderRadius.circular(8.0), 
${""?left_pad(indent)}  ),
  <#elseif widget.options["width"]??>
${""?left_pad(indent)}  width: styles.width(context, 0, ${widget.options["width"]}),  
  </#if>
${""?left_pad(indent)}  child: styles.buildTile(context,
<@print_dart_declare_widgets_in_tile widget=widget loopvar="" indent=indent+4 />
  <#if widget.options["url"]??>
    <#local url = widget.options["url"]>
    <#local pagename = url_to_page_name(url)>
    <#local method = guidbase.url_to_method_name(url)>   
    <#local params = guidbase.get_params_from_url(url)>
${""?left_pad(indent)}    onTap: () {    
${""?left_pad(indent)}      ${dart.nameVariable(method)}(context, <#if hasContainer>row<#else>{}</#if>);   
${""?left_pad(indent)}    },   
  </#if>
${""?left_pad(indent)}  ),  
${""?left_pad(indent)}),
</#macro>

<#macro print_dart_declare_widgets_in_tile widget loopvar indent>
  <#local hasImage = false>
  <#local hasAvatar = false>
  <#local hasPrimary = false>
  <#local hasSecondary = false>
  <#local hasTertiary = false>
  <#local hasAccent = false>
  <#list widget.widgets as child>
    <#local level = child.options["level"]!"">
    <#if level == "image">
      <#local hasImage = true>
    </#if>
    <#if level == "avatar">
      <#local hasAvatar = true>
    </#if>
    <#if level == "primary">
      <#local hasPrimary = true>
    </#if>
    <#if level == "secondary">
      <#local hasSecondary = true>
    </#if>
    <#if level == "tertiary">
      <#local hasTertiary = true>
    </#if>
    <#if level == "accent">
      <#local hasAccent = true>
    </#if>
  </#list>
  <#if hasImage>
    <#local image = guidbase.get_child_from_tile(widget, "image")>
    <#if loopvar != "">
${""?left_pad(indent)}imageWidget: Container(),// gux.getImage(${loopvar}['${dart.nameVariable(image.id)}']??'', 80, 55),    
    <#else>
${""?left_pad(indent)}imageWidget: Container(),//gux.getImage('${image.options["url"]!""}', 80, 55),
    </#if>
  <#elseif hasAvatar>
    <#local avatar = guidbase.get_child_from_tile(widget, "avatar")>
    <#if loopvar != "">
${""?left_pad(indent)}imageWidget: Container(),//gux.getAvatar(${loopvar}['${dart.nameVariable(avatar.id)}']??'', 32),    
    <#else>
${""?left_pad(indent)}imageWidget: Container(),//gux.getAvatar('${avatar.options["url"]!""}', 32),
    </#if>
  </#if>
  <#if hasPrimary>
    <#local primary = guidbase.get_child_from_tile(widget, "primary")>  
    <#if loopvar != "">
${""?left_pad(indent)}title: ${loopvar}['${dart.nameVariable(primary.id)}']??'',
    <#else>
${""?left_pad(indent)}titleWidget: 
<@print_dart_declare_widget widget=primary indent=indent />
    </#if>
  </#if>
  <#if hasSecondary>
    <#local secondary = guidbase.get_child_from_tile(widget, "secondary")>
    <#if loopvar != "">
${""?left_pad(indent)}subtitle: ${loopvar}['${dart.nameVariable(secondary.id)}']??'',
    <#else>
${""?left_pad(indent)}subtitleWidget: 
<@print_dart_declare_widget widget=secondary indent=indent />
    </#if>
  </#if>    
  <#if hasTertiary>
    <#local tertiary = guidbase.get_child_from_tile(widget, "tertiary")>
    <#if loopvar != "">
${""?left_pad(indent)}descrption: ${loopvar}['${dart.nameVariable(tertiary.id)}']??'',
    <#else>
${""?left_pad(indent)}descriptionWidget: 
<@print_dart_declare_widget widget=tertiary indent=indent />
    </#if>  
  </#if> 
  <#if hasAccent>
    <#local accent = guidbase.get_child_from_tile(widget, "accent")>
    <#if accent.options["url"]??>
      <#local url = accent.options["url"]>
      <#local pagename = url_to_page_name(url)>
      <#local method = guidbase.url_to_method_name(url)>
${""?left_pad(indent)}accent: TextButton(
${""?left_pad(indent)}  onPressed: () {
${""?left_pad(indent)}    ${dart.nameVariable(method)}(context, <String,dynamic>{});
${""?left_pad(indent)}  },
${""?left_pad(indent)}  child: 
<@print_dart_declare_widget widget=accent indent=indent+2 />
${""?left_pad(indent)}),   
    <#else>
${""?left_pad(indent)}accent: Text('${accent.options["title"]!"强调"}'),
    </#if>
  </#if>
</#macro>

<#macro print_dart_methods_tile widget indent>
  <#local hasContainer = (widget.container.type == "list_view" || widget.container.type == 'grid_view')>
  <#if !hasContainer>
    <#local container = widget>
  <#else>
    <#local container = widget.container>
  </#if>
  <#if !hasContainer>
    <#if widget.options["url"]??>
      <#local url = widget.options["url"]>
      <#local method = guidbase.url_to_method_name(url)>
      <#local pagepath = guidbase.url_to_page_path(url)>
      <#local params = guidbase.get_params_from_url(url)>
${""?left_pad(indent)}    
${""?left_pad(indent)}/*!
${""?left_pad(indent)}** 点击【${widget.options["title"]!"标题"}】响应事件。
${""?left_pad(indent)}*/
${""?left_pad(indent)}void ${dart.nameVariable(method)}(BuildContext context, Map<String,dynamic> params) {
<@gux.print_method_body_by_url url=url indent=indent+2 />
${""?left_pad(indent)}}    
    </#if>  
    <#return>
  </#if>
  <#local objname = container.options["object"]!"object">
${""?left_pad(indent)}
${""?left_pad(indent)}/*!
${""?left_pad(indent)}** 构建【${container.options["title"]!"标题"}】数据瓦片。
${""?left_pad(indent)}*/  
${""?left_pad(indent)}Widget buildTile4${dart.nameType(widget.container.id)}(Map<String,dynamic> row) {
${""?left_pad(indent)}  return styles.buildTile(context,
  <#if hasContainer>
<@print_dart_declare_widgets_in_tile widget=widget loopvar="row" indent=indent+4 />
  <#else>
<@print_dart_declare_widgets_in_tile widget=widget loopvar="" indent=indent+4 />  
  </#if>
  <#if widget.options["url"]??>
    <#local url = widget.options["url"]>
    <#local pagename = url_to_page_name(url)>
    <#local method = guidbase.url_to_method_name(url)>   
    <#local params = guidbase.get_params_from_url(url)>
${""?left_pad(indent)}    onTap: () {    
${""?left_pad(indent)}      ${dart.nameVariable(method)}(context, row);   
${""?left_pad(indent)}    },   
  </#if>
${""?left_pad(indent)}  );
${""?left_pad(indent)}}
</#macro>

<#macro print_dart_declare_tile_horizontal widget loopvar indent>
  <#local rows = 1>
  <#local objname = guidbase.get_object_from_url(widget.options["url"]!"module/object/action")>
  <#list widget.widgets as child>
    <#if (child.options["level"]!"") == "quinary" ||  
         (child.options["level"]!"") == "senary" ||
         (child.options["level"]!"") == "septenary">
      <#local rows = rows + 1>   
    </#if>     
  </#list>
  <#if rows == 1> 
${""?left_pad(indent)}<view${bind_tap_if_url(widget)} class="gx-d-flex gx-p-16 gx-bb-1" style="align-items:center;" 
${""?left_pad(indent)}      wx:for="{{${loopvar}}}" wx:key="${dart.nameVariable(objname + "_id")}" wx:for-item="item">
<@print_dart_declare_tile_first_row widgets=widget.widgets indent=indent+2 />
${""?left_pad(indent)}</view>
  <#else>
${""?left_pad(indent)}<view${bind_tap_if_url(widget)} class="gx-bb-1 gx-p-16" wx:for="{{${loopvar}}}" wx:key="${dart.nameVariable(objname + "_id")}" wx:for-item="item">
${""?left_pad(indent)}  <view class="gx-d-flex" style="align-items:center;">
<@print_dart_declare_tile_first_row widgets=widget.widgets indent=indent+4 />
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}  <view class="gx-d-flex">
<@print_dart_declare_tile_second_row widgets=widget.widgets indent=indent+4 />
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}</view>
  </#if>
</#macro>

<#macro print_dart_declare_tile_vertical widget loopvar indent>
  <#local hasPrimarySection = false>
  <#local hasQuinarySection = false>
  <#list widget.widgets as child>
    <#if (child.options["level"]!"") == "image">
${""?left_pad(indent)}  <view class="gx-d-flex gx-w-full">
${""?left_pad(indent)}    <image src="{{<#if loopvar != "">item.</#if>${dart.nameVariable(child.id)}}}" mode="scaleToFill" 
${""?left_pad(indent)}           style="width:100%;" class="gx-m-auto"></image>
${""?left_pad(indent)}  </view>  
    <#elseif (child.options["level"]!"") == "avatar">
${""?left_pad(indent)}  <view class="gx-px-16 gx-m-auto" style="">
${""?left_pad(indent)}    <image src="{{<#if loopvar != "">item.</#if>${dart.nameVariable(child.id)}}}" class="gx-wh-64"></image>
${""?left_pad(indent)}  </view>      
    </#if>
    <#if (child.options["level"]!"") == "primary" || 
         (child.options["level"]!"") == "secondary" ||
         (child.options["level"]!"") == "tertiary">
      <#local hasPrimarySection = true>   
    </#if> 
    <#if (child.options["level"]!"") == "quinary" || 
         (child.options["level"]!"") == "senary" ||
         (child.options["level"]!"") == "septenary">
      <#local hasQuinarySection = true>   
    </#if> 
  </#list>
  <#if hasPrimarySection>   
${""?left_pad(indent)}<view class="gx-d-flex" style="align-items:center;">  
${""?left_pad(indent)}  <view>  
    <#list widget.widgets as child>
      <#if (child.options["level"]!"") == "primary">
        <#if child.options["title"]??>
${""?left_pad(indent)}    <view class="gx-text-primary gx-fb gx-fs-14">${child.options["title"]}</view>        
        <#else>
${""?left_pad(indent)}    <view class="gx-text-primary gx-fb gx-fs-14">{{<#if loopvar != "">item.</#if>${dart.nameVariable(guidbase.rename_widget_id(child))}}}</view>
        </#if>
      <#elseif (child.options["level"]!"") == "secondary">
        <#if child.options["title"]??>
${""?left_pad(indent)}    <view class="gx-text-secondary gx-fb gx-fs-12">${child.options["title"]}</view>        
        <#else>
${""?left_pad(indent)}    <view class="gx-text-secondary gx-fb gx-fs-12">{{<#if loopvar != "">item.</#if>${dart.nameVariable(guidbase.rename_widget_id(child))}}}</view>
        </#if>
      <#elseif (child.options["level"]!"") == "tertiary">
${""?left_pad(indent)}    <view class="gx-text-secondary gx-fs-10">{{<#if loopvar != "">item.</#if>${dart.nameVariable(guidbase.rename_widget_id(child))}}}</view>
      </#if>
    </#list>
${""?left_pad(indent)}  </view>  
    <#list widget.widgets as child>
      <#if (child.options["level"]!"") == "accent">
        <#if child.options["title"]??>
${""?left_pad(indent)}  <view${bind_tap_if_url(child)} class="gx-fs-12 gx-fb gx-ml-auto">${child.options["title"]}</view>        
        <#else>
${""?left_pad(indent)}  <view${bind_tap_if_url(child)} class="gx-fs-12 gx-fb gx-ml-auto">{{<#if loopvar != "">item.</#if>${dart.nameVariable(guidbase.rename_widget_id(child))}}}</view>
        </#if>
      </#if>
     </#list>
${""?left_pad(indent)}</view>  
  </#if>
  <#if hasQuaternarySection>
    <#list widget.widgets as child>
      <#if (child.options["level"]!"") != "quaternary"><#continue></#if>
${""?left_pad(indent)}<view class="gx-text-secondary gx-fs-10">{{<#if loopvar != "">item.</#if>${dart.nameVariable(guidbase.rename_widget_id(child))}}}</view>
    </#list>
  </#if>
  <#if hasQuinarySection>
${""?left_pad(indent)}<view class="d-flex">    
    <#list widget.widgets as child>
      <#if (child.options["level"]!"") == "quinary">
${""?left_pad(indent)}  <view class="gx-d-flex gx-ml-auto">
${""?left_pad(indent)}    <text class="fas fa-star gx-fs-10 gx-pos-relative" style="top:2px;"></text>
${""?left_pad(indent)}    <view class="ms-auto gx-fs-11">{{<#if loopvar != "">item.</#if>${dart.nameVariable(child.id?replace("_id", "_name")?replace("_code", "_name"))}}}</view>
${""?left_pad(indent)}  </view>
      <#elseif (child.options["level"]!"") == "senary">
${""?left_pad(indent)}  <view class="gx-d-flex">
${""?left_pad(indent)}    <text class="fas fa-star gx-fs-10 gx-pos-relative" style="top:2px;"></text>
${""?left_pad(indent)}    <view class="ms-auto gx-fs-11">{{<#if loopvar != "">item.</#if>${dart.nameVariable(child.id?replace("_id", "_name")?replace("_code", "_name"))}}}</view>
${""?left_pad(indent)}  </view>
      <#elseif (child.options["level"]!"") == "septenary">
${""?left_pad(indent)}  <view class="gx-d-flex gx-ml-auto">
${""?left_pad(indent)}    <text class="fas fa-star gx-fs-10 gx-pos-relative" style="top:2px;"></text>
${""?left_pad(indent)}    <view class="ms-auto gx-fs-11">{{<#if loopvar != "">item.</#if>${dart.nameVariable(child.id?replace("_id", "_name")?replace("_code", "_name"))}}}</view>
${""?left_pad(indent)}  </view>
      </#if>
    </#list>
${""?left_pad(indent)}</view>
  </#if>
</#macro>
<#--
 ###############################################################################
 ### 【自定义导航栏】
 ###############################################################################
 -->
<#macro print_dart_declare_navigation_bar widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_dart_fields_navigation_bar widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_dart_methods_navigation_bar widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#--
 ###############################################################################
 ### 【工具栏位】
 ###############################################################################
 -->
<#macro print_dart_declare_toolbar widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_dart_fields_toolbar widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_dart_methods_toolbar widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#--
 ###############################################################################
 ### 【编辑表单】
 ###############################################################################
 -->
<#macro print_dart_declare_editable_form widget indent>
  <#local url = widget.options["url"]>
  <#local objname = guidbase.get_object_from_url(url)>
  <#local params = guidbase.get_params_from_url(url)>
${""?left_pad(indent)}BlocConsumer<${dart.nameType(objname)}Bloc, ${dart.nameType(objname)}State>(
${""?left_pad(indent)}  builder: (context, state) {
${""?left_pad(indent)}    if (state is ${dart.nameType(objname)}InitialState) {
${""?left_pad(indent)}      context.read<${dart.nameType(objname)}Bloc>().add(${dart.nameType(objname)}ReadEvent(
  <#list params as param>
${""?left_pad(indent)}        ${param.name}: widget.${param.name},
  </#list>
${""?left_pad(indent)}      ));
${""?left_pad(indent)}    } else if (state is ${dart.nameType(objname)}LoadingState) {
${""?left_pad(indent)}      return Skeletonizer(
${""?left_pad(indent)}        enabled: true,
${""?left_pad(indent)}        child: GXTwoColumnForm(
${""?left_pad(indent)}          fields: getFields({}),
${""?left_pad(indent)}        ),
${""?left_pad(indent)}      );
${""?left_pad(indent)}    } 
${""?left_pad(indent)}    return GXTwoColumnForm(
${""?left_pad(indent)}      fields: getFields({}),
${""?left_pad(indent)}    );
${""?left_pad(indent)}  },
${""?left_pad(indent)}  listener: (context, state) {
${""?left_pad(indent)}  
${""?left_pad(indent)}  },
${""?left_pad(indent)}),
</#macro>

<#macro print_dart_fields_editable_form widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_dart_methods_editable_form widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}List<Map<String, dynamic>> getFields(Map values) {
${""?left_pad(indent)}  List<Map<String, dynamic>> ret = [];
  <#list widget.widgets as child>
    <#if child?index == 0>
${""?left_pad(indent)}  Map<String,dynamic> field = {};
    <#else>
${""?left_pad(indent)}  field = {};    
    </#if>
${""?left_pad(indent)}  field['title'] = '${child.options["title"]!""}';
${""?left_pad(indent)}  field['name'] = '${dart.nameVariable(child.id)}';
${""?left_pad(indent)}  field['input'] = '${child.type}';
    <#if child.type == "select">
${""?left_pad(indent)}  field['options'] = {};    
      <#if widget.options["values"]??>
        <#assign values = widget.options["values"]>
        <#assign pairs = values?substring(1,values?length-1)?split(",")>    
${""?left_pad(indent)}  field['options']['values'] = [
        <#list pairs as pair>
         <#assign strs = pair?split(":")>
${""?left_pad(indent)}    {'value': '${strs[0]?trim}', 'text': '${strs[1]?trim}'},
${""?left_pad(indent)}  ],
        </#list>
      <#else>
${""?left_pad(indent)}  field['options']['values'] = [];
      </#if>
    </#if>
${""?left_pad(indent)}  ret.add(field);
  </#list>
${""?left_pad(indent)}
${""?left_pad(indent)}  return ret;
${""?left_pad(indent)}}
</#macro>

<#--
 ###############################################################################
 ### 【只读表单】
 ###############################################################################
 -->
<#macro print_dart_declare_readonly_form widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_dart_fields_readonly_form widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_dart_methods_readonly_form widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#--
 ###############################################################################
 ### 【分页页签】
 ###############################################################################
 -->
<#macro print_dart_declare_tabs widget indent>
${""?left_pad(indent)}/*!
${""?left_pad(indent)}** 【页签导航】
${""?left_pad(indent)}*/
${""?left_pad(indent)}DefaultTabController(
${""?left_pad(indent)}  length: ${widget.widgets?size},
${""?left_pad(indent)}  child: Column(
${""?left_pad(indent)}    children: [
${""?left_pad(indent)}      PreferredSize(
${""?left_pad(indent)}        preferredSize: const Size.fromHeight(40),
${""?left_pad(indent)}        child: ClipRRect(
${""?left_pad(indent)}          borderRadius: const BorderRadius.all(Radius.circular(10)),
${""?left_pad(indent)}          child: Container(
${""?left_pad(indent)}            height: 40,
${""?left_pad(indent)}            margin: const EdgeInsets.symmetric(horizontal: 20),
${""?left_pad(indent)}            decoration: BoxDecoration(
${""?left_pad(indent)}              borderRadius: const BorderRadius.all(Radius.circular(10)),
${""?left_pad(indent)}              color: Colors.green.shade100,
${""?left_pad(indent)}            ),
${""?left_pad(indent)}            child: const TabBar(
${""?left_pad(indent)}              indicatorSize: TabBarIndicatorSize.tab,
${""?left_pad(indent)}              dividerColor: Colors.transparent,
${""?left_pad(indent)}              indicator: BoxDecoration(
${""?left_pad(indent)}                color: Colors.green,
${""?left_pad(indent)}                borderRadius: BorderRadius.all(Radius.circular(10)),
${""?left_pad(indent)}              ),
${""?left_pad(indent)}              labelColor: Colors.white,
${""?left_pad(indent)}              unselectedLabelColor: Colors.black54,
${""?left_pad(indent)}              tabs: [
  <#list widget.widgets as child>
${""?left_pad(indent)}                GXTabItem(title: '${child.options["title"]!"页签标题"}', count: 0),
  </#list>
${""?left_pad(indent)}              ],
${""?left_pad(indent)}            ),
${""?left_pad(indent)}          ),
${""?left_pad(indent)}        ),
${""?left_pad(indent)}      ),
${""?left_pad(indent)}      Container(
${""?left_pad(indent)}        height: 300,
${""?left_pad(indent)}        child: TabBarView(
${""?left_pad(indent)}          children: [
  <#list widget.widgets as child>
<@print_dart_declare_widget widget=child indent=indent+12 />
  </#list>
${""?left_pad(indent)}          ],
${""?left_pad(indent)}        ),
${""?left_pad(indent)}      ),
${""?left_pad(indent)}    ],
${""?left_pad(indent)}  ),
${""?left_pad(indent)}),
</#macro>

<#macro print_dart_fields_tabs widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_dart_methods_tabs widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#--
 ###############################################################################
 ### 【通知公告】
 ###############################################################################
 -->
<#macro print_dart_declare_scroll_notification widget indent>
${""?left_pad(indent)}/*!
${""?left_pad(indent)}** 【滚动通知】
${""?left_pad(indent)}*/
${""?left_pad(indent)}FutureBuilder<List<dynamic>>(
${""?left_pad(indent)}  future: sdk.fetchApplicationNotifications(),
${""?left_pad(indent)}  builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
${""?left_pad(indent)}    if (snapshot.hasData) {
${""?left_pad(indent)}      return Container(
${""?left_pad(indent)}        padding: EdgeInsets.symmetric(vertical: 4, horizontal: 16),
${""?left_pad(indent)}        height: 28,
${""?left_pad(indent)}        child: Row(
${""?left_pad(indent)}          crossAxisAlignment: CrossAxisAlignment.center,
${""?left_pad(indent)}          children: [
${""?left_pad(indent)}            Container(
${""?left_pad(indent)}              width: 24,
${""?left_pad(indent)}              padding: EdgeInsets.only(bottom: 0),
${""?left_pad(indent)}              margin: EdgeInsets.only(right: 8),
${""?left_pad(indent)}              child: Image.asset('asset/image/icon/broadcast.png',
${""?left_pad(indent)}                width: 22,
${""?left_pad(indent)}                height: 22,
${""?left_pad(indent)}                fit: BoxFit.cover,
${""?left_pad(indent)}              ),
${""?left_pad(indent)}            ),
${""?left_pad(indent)}            Expanded(
${""?left_pad(indent)}              child: Container(
${""?left_pad(indent)}                padding: EdgeInsets.only(top: 0),
${""?left_pad(indent)}                child: Swiper(
${""?left_pad(indent)}                  itemHeight: 24,
${""?left_pad(indent)}                  itemBuilder: (BuildContext context,int index){
${""?left_pad(indent)}                    return Container(
${""?left_pad(indent)}                      height: 28,
${""?left_pad(indent)}                      child: Text(snapshot.data![index]["content"],
${""?left_pad(indent)}                        style: TextStyle(fontSize: 16),
${""?left_pad(indent)}                      ),
${""?left_pad(indent)}                    );
${""?left_pad(indent)}                  },
${""?left_pad(indent)}                  autoplay: true,
${""?left_pad(indent)}                  itemCount: snapshot.data!.length,
${""?left_pad(indent)}                  scrollDirection: Axis.vertical,
${""?left_pad(indent)}                ),
${""?left_pad(indent)}              ),
${""?left_pad(indent)}            ),
${""?left_pad(indent)}          ],
${""?left_pad(indent)}        ),
${""?left_pad(indent)}      );
${""?left_pad(indent)}    } else {
${""?left_pad(indent)}      return Container();
${""?left_pad(indent)}    }
${""?left_pad(indent)}  },
${""?left_pad(indent)}),
</#macro>

<#macro print_dart_fields_scroll_notification widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_dart_methods_scroll_notification widget indent>
${""?left_pad(indent)}
</#macro>

<#--
 ###############################################################################
 ### 【滚动导航】
 ###############################################################################
 -->
<#macro print_dart_declare_swiper_navigator widget indent>
${""?left_pad(indent)}Swiper(
${""?left_pad(indent)}  itemBuilder: (BuildContext context,int index){
${""?left_pad(indent)}    return Image.network("https://via.placeholder.com/350x150",fit: BoxFit.fill,);
${""?left_pad(indent)}  },
${""?left_pad(indent)}  itemCount: 3,
${""?left_pad(indent)}  pagination: SwiperPagination(),
${""?left_pad(indent)}  control: SwiperControl(),
${""?left_pad(indent)}),
</#macro>

<#macro print_dart_fields_swiper_navigator widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_dart_methods_swiper_navigator widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#--
 ###############################################################################
 ### 【滑动导航】
 ###############################################################################
 -->
<#macro print_dart_declare_scroll_navigator widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_dart_fields_scroll_navigator widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_dart_methods_scroll_navigator widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#--
 ###############################################################################
 ### 【列表导航】
 ###############################################################################
 -->
<#macro print_dart_declare_list_navigator widget indent>
  <#if widget.options["width"]??>
${""?left_pad(indent)}Expanded(
${""?left_pad(indent)}  flex: 1,
${""?left_pad(indent)}  child: Column(
${""?left_pad(indent)}    children: [
    <#list widget.widgets as child>
      <#if child.type == "tile">
<@print_dart_declare_tile widget=child indent=indent+6 />
      </#if>
    </#list>
${""?left_pad(indent)}    ],
${""?left_pad(indent)}  ),
${""?left_pad(indent)}),  
  <#else>
${""?left_pad(indent)}Column(
${""?left_pad(indent)}  children: [
    <#list widget.widgets as child>
      <#if child.type == "tile">
<@print_dart_declare_tile widget=child indent=indent+4 />
      </#if>
    </#list>
${""?left_pad(indent)}  ],
${""?left_pad(indent)}),  
  </#if>
</#macro>

<#macro print_dart_fields_list_navigator widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_dart_methods_list_navigator widget indent>
  <#local methods = {}>
  <#list widget.widgets as child>
    <#local url = guidbase.get_url_from_tile(child)>
    <#if url == ""><#continue></#if>
    <#local method = guidbase.url_to_method_name(url)>
    <#if methods[method]??><#continue></#if>
    <#local methods += {method:method}>
    <#local pagepath = guidbase.url_to_page_path(url)>
    <#local params = guidbase.get_params_from_url(url)>
    <#local clickable = guidbase.get_clickable_from_tile(child)>
${""?left_pad(indent)}    
${""?left_pad(indent)}/*!
${""?left_pad(indent)}** 点击【${child.options["title"]!"标题"}】响应事件。
${""?left_pad(indent)}*/
${""?left_pad(indent)}void ${dart.nameVariable(method)}(BuildContext context, Map<String,dynamic> params) {
<@gux.print_method_body_by_url url=url indent=indent+2 />
${""?left_pad(indent)}}
  </#list>
</#macro>

<#--
 ###############################################################################
 ### 【栅格导航】
 ###############################################################################
 -->
<#macro print_dart_declare_grid_navigator widget indent>
  <#local columns = widget.options["columns"]!"3">
${""?left_pad(indent)}Card(
${""?left_pad(indent)}  elevation: 0,
${""?left_pad(indent)}  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
${""?left_pad(indent)}  shape: RoundedRectangleBorder(
${""?left_pad(indent)}    borderRadius: BorderRadius.circular(16.0), // Custom corner radius
${""?left_pad(indent)}  ),
${""?left_pad(indent)}  child: Column(
${""?left_pad(indent)}    children: [
  <#if widget.options["title"]?? || guidbase.has_toolbar_of_widget(widget)>
${""?left_pad(indent)}      Row(
${""?left_pad(indent)}        mainAxisAlignment: MainAxisAlignment.spaceBetween,
${""?left_pad(indent)}        children: [
${""?left_pad(indent)}          Align(
${""?left_pad(indent)}            alignment: Alignment.topLeft,
${""?left_pad(indent)}            child: Padding(
${""?left_pad(indent)}              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
${""?left_pad(indent)}              child: Text("${widget.options["title"]!""}", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold,)),
${""?left_pad(indent)}            ),
${""?left_pad(indent)}          ),
    <#if guidbase.has_toolbar_of_widget(widget)>
      <#local toolbar = guidbase.get_toolbar_of_widget(widget)>
      <#list toolbar.widgets as child>
        <#if child.options["url"]??>
          <#local url = child.options["url"]>
          <#local pagename = url_to_page_name(url)>
          <#local method = guidbase.url_to_method_name(url)>
${""?left_pad(indent)}          Padding(
${""?left_pad(indent)}            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
${""?left_pad(indent)}            child: TextButton(
${""?left_pad(indent)}              onPressed: () {
${""?left_pad(indent)}                ${dart.nameVariable(method)}(context, <String,dynamic>{});
${""?left_pad(indent)}              },
${""?left_pad(indent)}              child: Text("${child.options["title"]!"按钮"}", style: TextStyle(fontSize: 13)),
${""?left_pad(indent)}            ),
${""?left_pad(indent)}          ),
        </#if>
      </#list>
    </#if>
${""?left_pad(indent)}        ],
${""?left_pad(indent)}      ),
  </#if>
${""?left_pad(indent)}      Padding(  
${""?left_pad(indent)}        padding: EdgeInsets.all(16),
${""?left_pad(indent)}        child: Wrap(
${""?left_pad(indent)}          direction: Axis.horizontal,
${""?left_pad(indent)}          spacing: 16,
${""?left_pad(indent)}          runSpacing: 16,
${""?left_pad(indent)}          children: [
  <#list widget.widgets as child>
    <#if child.type == "tile">
<@print_dart_declare_tile widget=child indent=indent+12 />         
    </#if>
  </#list>
${""?left_pad(indent)}          ],
${""?left_pad(indent)}        ),
${""?left_pad(indent)}      ),
${""?left_pad(indent)}    ],
${""?left_pad(indent)}  ),
${""?left_pad(indent)}),
</#macro>

<#macro print_dart_fields_grid_navigator widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_dart_methods_grid_navigator widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#--
 ###############################################################################
 ### 【搜索栏位】
 ###############################################################################
 -->
<#macro print_dart_declare_search_bar widget indent>
${""?left_pad(indent)}Padding(
${""?left_pad(indent)}  padding: const EdgeInsets.all(8.0),
${""?left_pad(indent)}  child: TextField(
${""?left_pad(indent)}    controller: _controller4${dart.nameType(widget.id)},
${""?left_pad(indent)}    decoration: InputDecoration(
${""?left_pad(indent)}      labelText: 'Search',
${""?left_pad(indent)}      prefixIcon: Icon(Icons.search),
${""?left_pad(indent)}      border: OutlineInputBorder(
${""?left_pad(indent)}        borderRadius: BorderRadius.circular(25.0),
${""?left_pad(indent)}      ),
${""?left_pad(indent)}    ),
${""?left_pad(indent)}  ),
${""?left_pad(indent)}),
</#macro> 
 
<#macro print_dart_fields_search_bar widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}TextEditingController _controller4${dart.nameType(widget.id)} = TextEditingController();
</#macro>

<#macro print_dart_methods_search_bar widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#--
 ###############################################################################
 ### 【事件日历】
 ###############################################################################
 -->
<#macro print_dart_declare_calendar widget indent>
${""?left_pad(indent)}TableCalendar(
${""?left_pad(indent)}  locale: 'zh_CN',
${""?left_pad(indent)}  firstDay: DateTime(1900, 1, 1),
${""?left_pad(indent)}  lastDay: DateTime(2099, 12, 31),
${""?left_pad(indent)}  calendarFormat: _calendarFormat4${dart.nameType(widget.id)},
${""?left_pad(indent)}  focusedDay: _focusedDay4${dart.nameType(widget.id)},
${""?left_pad(indent)}  selectedDayPredicate: (day) => isSameDay(_selectedDay4${dart.nameType(widget.id)}, day),
${""?left_pad(indent)}  onFormatChanged: (format) {
${""?left_pad(indent)}    if (_calendarFormat4${dart.nameType(widget.id)} != format) {
${""?left_pad(indent)}      setState(() {
${""?left_pad(indent)}        _calendarFormat4${dart.nameType(widget.id)} = format;
${""?left_pad(indent)}      });
${""?left_pad(indent)}    }
${""?left_pad(indent)}  },
${""?left_pad(indent)}  onDaySelected: (selectedDay, focusedDay) {
${""?left_pad(indent)}    setState(() {
${""?left_pad(indent)}      _selectedDay4${dart.nameType(widget.id)} = selectedDay;
${""?left_pad(indent)}      _focusedDay4${dart.nameType(widget.id)} = selectedDay; 
${""?left_pad(indent)}    });
${""?left_pad(indent)}  },
${""?left_pad(indent)}),
</#macro>

<#macro print_dart_fields_calendar widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}/*!
${""?left_pad(indent)}** 日历显示格式。
${""?left_pad(indent)}*/
${""?left_pad(indent)}CalendarFormat _calendarFormat4${dart.nameType(widget.id)} = CalendarFormat.week;
${""?left_pad(indent)}
${""?left_pad(indent)}/*!
${""?left_pad(indent)}** 选择的日期。
${""?left_pad(indent)}*/
${""?left_pad(indent)}late DateTime _selectedDay4${dart.nameType(widget.id)};
${""?left_pad(indent)}
${""?left_pad(indent)}/*!
${""?left_pad(indent)}** 高亮的日期。
${""?left_pad(indent)}*/
${""?left_pad(indent)}DateTime _focusedDay4${dart.nameType(widget.id)} = DateTime.now();
</#macro>

<#macro print_dart_methods_calendar widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#--
 ###############################################################################
 ### 【树型结构】
 ###############################################################################
 -->
<#macro print_dart_declare_tree widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_dart_fields_tree widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_dart_methods_tree widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#--
 ###############################################################################
 ### 【传统列表】
 ###############################################################################
 -->
<#macro print_dart_declare_list_view widget indent>
  <#local url = widget.options["url"]!"/module/object/find">
  <#local objname = guidbase.get_object_from_url(url)>
  <#local objplural = guidbase.pluralize_object(objname)>
  <#list widget.widgets as child>
    <#if child.type?? && child.type == "tile">
      <#local tile = child>
    </#if>
  </#list>
  <#local widgetIndex = -1>
  <#list widget.container.widgets as sibling>
    <#if sibling.id?? && widget.id == sibling.id>
      <#local widgetIndex = sibling?index>
      <#break>
    </#if>
  </#list>
${""?left_pad(indent)}Container(  
  <#if widgetIndex == widget.container.widgets?size - 1>
${""?left_pad(indent)}  height: MediaQuery.of(context).size.height - 300 /* change height here */,  
  <#else>
${""?left_pad(indent)}  height: 300 /* change height here */,
  </#if>
${""?left_pad(indent)}  child: BlocConsumer<${dart.nameType(objname)}Bloc, ${dart.nameType(objname)}State>(
${""?left_pad(indent)}    builder: (context, state) {
${""?left_pad(indent)}      if (state is ${dart.nameType(objname)}InitialState) {
${""?left_pad(indent)}        context.read<${dart.nameType(objname)}Bloc>().add(${dart.nameType(objname)}LoadEvent(start: _start4${dart.nameType(widget.id)},));
${""?left_pad(indent)}      } else if (state is ${dart.nameType(objname)}LoadingState) {
${""?left_pad(indent)}        return Center(child: CircularProgressIndicator(),);
${""?left_pad(indent)}      } 
${""?left_pad(indent)}      return GXListView(
${""?left_pad(indent)}        start: _start4${dart.nameType(widget.id)},
${""?left_pad(indent)}        widgetLoadMore: Container(
${""?left_pad(indent)}          height: 150,
${""?left_pad(indent)}          child: Center(
${""?left_pad(indent)}            child: Image.asset('asset/image/common/loading.gif', width: 150, height: 105, fit: BoxFit.cover),
${""?left_pad(indent)}          ),
${""?left_pad(indent)}        ),
${""?left_pad(indent)}        itemBuilder: (context, item, columnIndex) {
${""?left_pad(indent)}          return GXWidgetSize(
${""?left_pad(indent)}            height: 0 /* unused in list view */,
${""?left_pad(indent)}            onChange: (size) {},
${""?left_pad(indent)}            child: styles.buildTile(context,
  <#if tile??>
<@print_dart_declare_widgets_in_tile widget=tile loopvar="item" indent=indent+14 />
  </#if>
${""?left_pad(indent)}            ),
${""?left_pad(indent)}          );
${""?left_pad(indent)}        },
${""?left_pad(indent)}        onLoadMore: () async {
${""?left_pad(indent)}          _start4${dart.nameType(widget.id)} += 15;
${""?left_pad(indent)}          await sdk.load${dart.nameType(objplural)}({
${""?left_pad(indent)}            'start': _start4${dart.nameType(widget.id)},
${""?left_pad(indent)}          });
${""?left_pad(indent)}        },
${""?left_pad(indent)}      );
${""?left_pad(indent)}    },
${""?left_pad(indent)}    listener: (context, state) {  
${""?left_pad(indent)}
${""?left_pad(indent)}    },
${""?left_pad(indent)}  ),
${""?left_pad(indent)}),
</#macro>

<#macro print_dart_fields_list_view widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}/*!
${""?left_pad(indent)}** 已经加载【${(widget.options["title"]!widget.id)}】数据集合的变量。
${""?left_pad(indent)}*/
${""?left_pad(indent)}int _start4${dart.nameType(widget.id)} = 0;
</#macro>

<#macro print_dart_methods_list_view widget indent>
  <#list widget.widgets as child>
    <#if child.type == "tile">
      <#local tile = child>
      <#break>
    </#if>
  </#list>
  <#--if tile??>
<@print_dart_methods_tile widget=tile indent=indent />  
  </#if-->
  <#local methods = {}>
  <#list widget.widgets as child>
    <#local url = guidbase.get_url_from_tile(child)>
    <#if url == ""><#continue></#if>
    <#local method = guidbase.url_to_method_name(url)>
    <#if methods[method]??><#continue></#if>
    <#local methods += {method:method}>
    <#local pagepath = guidbase.url_to_page_path(url)>
    <#local params = guidbase.get_params_from_url(url)>
    <#local clickable = guidbase.get_clickable_from_tile(child)>
${""?left_pad(indent)}    
${""?left_pad(indent)}/*!
${""?left_pad(indent)}** 点击【${child.options["title"]!"标题"}】响应事件。
${""?left_pad(indent)}*/
${""?left_pad(indent)}void ${dart.nameVariable(method)}(BuildContext context, Map<String,dynamic> params) {
<@gux.print_method_body_by_url url=url indent=indent+2 />
${""?left_pad(indent)}}
  </#list>
</#macro>

<#--
 ###############################################################################
 ### 【栅格列表】
 ###############################################################################
 -->
<#macro print_dart_declare_grid_view widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_dart_fields_grid_view widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_dart_methods_grid_view widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#--
 ###############################################################################
 ### 【时间线条】
 ###############################################################################
 -->
<#macro print_dart_declare_timeline widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_dart_fields_timeline widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_dart_methods_timeline widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#--
 ###############################################################################
 ### 【分页表格】
 ###############################################################################
 -->
<#macro print_dart_declare_pagination_table widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_dart_fields_pagination_table widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_dart_methods_pagination_table widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#--
 ###############################################################################
 ### 【分页栅格】
 ###############################################################################
 -->
<#macro print_dart_declare_pagination_grid widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_dart_fields_pagination_grid widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_dart_methods_pagination_grid widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#--
 ###############################################################################
 ### 【广义表格】
 ###############################################################################
 -->
<#macro print_dart_declare_spreadsheet widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_dart_fields_spreadsheet widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_dart_methods_spreadsheet widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#--
 ###############################################################################
 ### 【看板列表】
 ###############################################################################
 -->
<#macro print_dart_declare_kanban widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_dart_fields_kanban widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_dart_methods_kanban widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#--
 ###############################################################################
 ### 【聊天列表】
 ###############################################################################
 -->
<#macro print_dart_declare_chat widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_dart_fields_chat widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_dart_methods_chat widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#--
 ###############################################################################
 ### 【饼状图】
 ###############################################################################
 -->
<#macro print_dart_declare_pie_chart widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_dart_fields_pie_chart widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_dart_methods_pie_chart widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#--
 ###############################################################################
 ### 【圈状图】
 ###############################################################################
 -->
<#macro print_dart_declare_donut_chart widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_dart_fields_donut_chart widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_dart_methods_donut_chart widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#--
 ###############################################################################
 ### 【柱状图】
 ###############################################################################
 -->
<#macro print_dart_declare_bar_chart widget indent>
${""?left_pad(indent)}Container(
${""?left_pad(indent)}  width: 150,
${""?left_pad(indent)}  height: 80,
${""?left_pad(indent)}  child: BarChart(
${""?left_pad(indent)}    BarChartData(
${""?left_pad(indent)}      barGroups: [10, 20, 30, 40, 50, 60, 70]
${""?left_pad(indent)}          .asMap()
${""?left_pad(indent)}          .map((index, value) => MapEntry(
${""?left_pad(indent)}        index,
${""?left_pad(indent)}        BarChartGroupData(
${""?left_pad(indent)}          x: index,
${""?left_pad(indent)}          barRods: [
${""?left_pad(indent)}            BarChartRodData(
${""?left_pad(indent)}              toY: value.toDouble(),
${""?left_pad(indent)}              color: Colors.blue,
${""?left_pad(indent)}              width: 10,
${""?left_pad(indent)}            ),
${""?left_pad(indent)}          ],
${""?left_pad(indent)}        ),
${""?left_pad(indent)}      )).values.toList(),
${""?left_pad(indent)}      titlesData: FlTitlesData(
${""?left_pad(indent)}        show: false, 
${""?left_pad(indent)}      ),
${""?left_pad(indent)}      gridData: FlGridData(
${""?left_pad(indent)}        show: false,
${""?left_pad(indent)}      ),
${""?left_pad(indent)}      borderData: FlBorderData(
${""?left_pad(indent)}        show: false, 
${""?left_pad(indent)}      ),
${""?left_pad(indent)}    ),
${""?left_pad(indent)}  ),
${""?left_pad(indent)}),
</#macro>

<#macro print_dart_fields_bar_chart widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_dart_methods_bar_chart widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#--
 ###############################################################################
 ### 【折线图】
 ###############################################################################
 -->
<#macro print_dart_declare_line_chart widget indent>
${""?left_pad(indent)}Container(
${""?left_pad(indent)}  width: 150,
${""?left_pad(indent)}  height: 80,
${""?left_pad(indent)}  child: LineChart(
${""?left_pad(indent)}    LineChartData(
${""?left_pad(indent)}      lineBarsData: [
${""?left_pad(indent)}        LineChartBarData(
${""?left_pad(indent)}          spots: [
${""?left_pad(indent)}            FlSpot(0, 3),
${""?left_pad(indent)}            FlSpot(1, 2),
${""?left_pad(indent)}            FlSpot(2, 5),
${""?left_pad(indent)}            FlSpot(3, 3),
${""?left_pad(indent)}            FlSpot(4, 6),
${""?left_pad(indent)}            FlSpot(5, 4),
${""?left_pad(indent)}            FlSpot(6, 7),
${""?left_pad(indent)}          ],
${""?left_pad(indent)}          isCurved: true,
${""?left_pad(indent)}          color: Colors.blue,
${""?left_pad(indent)}          barWidth: 3,
${""?left_pad(indent)}          isStrokeCapRound: true,
${""?left_pad(indent)}          dotData: FlDotData(
${""?left_pad(indent)}            show: true,
${""?left_pad(indent)}          ),
${""?left_pad(indent)}          belowBarData: BarAreaData(
${""?left_pad(indent)}            show: false,
${""?left_pad(indent)}          ),
${""?left_pad(indent)}        ),
${""?left_pad(indent)}      ],
${""?left_pad(indent)}      titlesData: FlTitlesData(
${""?left_pad(indent)}        show: false,
${""?left_pad(indent)}      ),
${""?left_pad(indent)}      gridData: FlGridData(
${""?left_pad(indent)}        show: false,
${""?left_pad(indent)}      ),
${""?left_pad(indent)}      borderData: FlBorderData(
${""?left_pad(indent)}        show: false, 
${""?left_pad(indent)}      ),
${""?left_pad(indent)}    ),
${""?left_pad(indent)}  ),
${""?left_pad(indent)}),
</#macro>

<#macro print_dart_fields_line_chart widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_dart_methods_line_chart widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#--
 ###############################################################################
 ### 【堆栈图】
 ###############################################################################
 -->
<#macro print_dart_declare_stack_chart widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_dart_fields_stack_chart widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_dart_methods_stack_chart widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#--
 ###############################################################################
 ### 【雷达图】
 ###############################################################################
 -->
<#macro print_dart_declare_radar_chart widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_dart_fields_radar_chart widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_dart_methods_radar_chart widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#--
 ###############################################################################
 ### 【网络拓扑图】
 ###############################################################################
 -->
<#macro print_dart_declare_network_topology_diagram widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_dart_fields_network_topology_diagram widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_dart_methods_network_topology_diagram widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#--
 ###############################################################################
 ### 【业务流程图】
 ###############################################################################
 -->
<#macro print_dart_declare_business_process_diagram widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_dart_fields_business_process_diagram widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_dart_methods_business_process_diagram widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#--
 ###############################################################################
 ### 【底部弹框】
 ###############################################################################
 -->
<#macro print_dart_declare_bottom_sheet widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_dart_fields_bottom_sheet widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_dart_methods_bottom_sheet widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#--
 ###############################################################################
 ### 【界面部件】
 ###############################################################################
 -->
 
<#macro print_dart_declare_widget widget indent> 
  <#if widget.type == "tile">
<@print_dart_declare_tile widget=widget indent=indent />  
  <#elseif widget.type == "row">  
${""?left_pad(indent)}Row(
${""?left_pad(indent)}  crossAxisAlignment: CrossAxisAlignment.start,
${""?left_pad(indent)}  children: <Widget>[
    <#list widget.widgets as child>
<@print_dart_declare_widget widget=child indent=indent+4 />    
    </#list>
${""?left_pad(indent)}  ],
${""?left_pad(indent)}),
  <#elseif widget.type == "col">  
${""?left_pad(indent)}Container(
${""?left_pad(indent)}  // flex: 1,
${""?left_pad(indent)}  child: Column(
${""?left_pad(indent)}    mainAxisAlignment: MainAxisAlignment.start,
${""?left_pad(indent)}    children: <Widget>[
    <#list widget.widgets as child>
<@print_dart_declare_widget widget=child indent=indent+6 />    
    </#list>
${""?left_pad(indent)}    ],
${""?left_pad(indent)}  ),
${""?left_pad(indent)}),
  <#elseif widget.type == "navigation_bar">  
<@gux.print_dart_declare_navigation_bar widget=widget indent=indent />
  <#elseif widget.type == "toolbar">  
<@gux.print_dart_declare_toolbar widget=widget indent=indent />
  <#elseif widget.type == "editable_form">  
<@gux.print_dart_declare_editable_form widget=widget indent=indent />
  <#elseif widget.type == "readonly_form">  
<@gux.print_dart_declare_readonly_form widget=widget indent=indent />
  <#elseif widget.type == "tabs">  
<@gux.print_dart_declare_tabs widget=widget indent=indent />
  <#elseif widget.type == "scroll_notification">  
<@gux.print_dart_declare_scroll_notification widget=widget indent=indent />
  <#elseif widget.type == "swiper_navigator">  
<@gux.print_dart_declare_swiper_navigator widget=widget indent=indent />
  <#elseif widget.type == "scroll_navigator">  
<@gux.print_dart_declare_scroll_navigator widget=widget indent=indent />
  <#elseif widget.type == "list_navigator">  
<@gux.print_dart_declare_list_navigator widget=widget indent=indent />
  <#elseif widget.type == "grid_navigator">  
<@gux.print_dart_declare_grid_navigator widget=widget indent=indent />
  <#elseif widget.type == "search_bar">  
<@gux.print_dart_declare_search_bar widget=widget indent=indent />
  <#elseif widget.type == "calendar">  
<@gux.print_dart_declare_calendar widget=widget indent=indent />
  <#elseif widget.type == "tree">  
<@gux.print_dart_declare_tree widget=widget indent=indent />
  <#elseif widget.type == "content_editor">  
<@gux.print_dart_declare_content_editor widget=widget indent=indent />
  <#elseif widget.type == "system_console">  
<@gux.print_dart_declare_system_console widget=widget indent=indent />
  <#elseif widget.type == "mobile_simulator">  
<@gux.print_dart_declare_mobile_simulator widget=widget indent=indent />
  <#elseif widget.type == "list_view">  
<@gux.print_dart_declare_list_view widget=widget indent=indent />
  <#elseif widget.type == "grid_view">  
<@gux.print_dart_declare_grid_view widget=widget indent=indent />
  <#elseif widget.type == "timeline">  
<@gux.print_dart_declare_timeline widget=widget indent=indent />
  <#elseif widget.type == "pagination_table">  
<@gux.print_dart_declare_pagination_table widget=widget indent=indent />
  <#elseif widget.type == "pagination_grid">  
<@gux.print_dart_declare_pagination_grid widget=widget indent=indent />
  <#elseif widget.type == "bottom_sheet">  
<@gux.print_dart_declare_bottom_sheet widget=widget indent=indent />
  <#elseif widget.type == "spreadsheet">  
<@gux.print_dart_declare_spreadsheet widget=widget indent=indent />
  <#elseif widget.type == "kanban">  
<@gux.print_dart_declare_kanban widget=widget indent=indent />
  <#elseif widget.type == "chat">  
<@gux.print_dart_declare_chat widget=widget indent=indent />
  <#elseif widget.type == "pie_chart">  
<@gux.print_dart_declare_pie_chart widget=widget indent=indent />
  <#elseif widget.type == "donut_chart">  
<@gux.print_dart_declare_donut_chart widget=widget indent=indent />
  <#elseif widget.type == "bar_chart">  
<@gux.print_dart_declare_bar_chart widget=widget indent=indent />
  <#elseif widget.type == "line_chart">  
<@gux.print_dart_declare_line_chart widget=widget indent=indent />
  <#elseif widget.type == "stack_chart">  
<@gux.print_dart_declare_stack_chart widget=widget indent=indent />
  <#elseif widget.type == "radar_chart">  
<@gux.print_dart_declare_radar_chart widget=widget indent=indent />
  <#elseif widget.type == "network_topology_diagram">  
<@gux.print_dart_declare_network_topology_diagram widget=widget indent=indent />
  <#elseif widget.type == "business_process_diagram">  
<@gux.print_dart_declare_business_process_diagram widget=widget indent=indent />
  <#elseif widget.type == 'progress'>
${""?left_pad(indent)}LinearProgressIndicator(
${""?left_pad(indent)}  value: 0.5, // Set the progress value between 0.0 and 1.0
${""?left_pad(indent)}  backgroundColor: Colors.grey[200],
${""?left_pad(indent)}  valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
${""?left_pad(indent)}),  
  <#elseif widget.type == "text">  
${""?left_pad(indent)}Text('${widget.options["title"]!"标题"}'),
  <#else>
${""?left_pad(indent)}Center(child: Text('${widget.options["title"]!"占位部件"}')),  
  </#if>
</#macro>  

<#macro print_dart_fields_widget widget indent> 
  <#if widget.type == "navigation_bar">  
<@gux.print_dart_fields_navigation_bar widget=widget indent=indent />
  <#elseif widget.type == "toolbar">  
<@gux.print_dart_fields_toolbar widget=widget indent=indent />
  <#elseif widget.type == "editable_form">  
<@gux.print_dart_fields_editable_form widget=widget indent=indent />
  <#elseif widget.type == "readonly_form">  
<@gux.print_dart_fields_readonly_form widget=widget indent=indent />
  <#elseif widget.type == "tabs">  
<@gux.print_dart_fields_tabs widget=widget indent=indent />
  <#elseif widget.type == "scroll_notification">  
<@gux.print_dart_fields_scroll_notification widget=widget indent=indent />
  <#elseif widget.type == "swiper_navigator">  
<@gux.print_dart_fields_swiper_navigator widget=widget indent=indent />
  <#elseif widget.type == "scroll_navigator">  
<@gux.print_dart_fields_scroll_navigator widget=widget indent=indent />
  <#elseif widget.type == "list_navigator">  
<@gux.print_dart_fields_list_navigator widget=widget indent=indent />
  <#elseif widget.type == "grid_navigator">  
<@gux.print_dart_fields_grid_navigator widget=widget indent=indent />
  <#elseif widget.type == "search_bar">  
<@gux.print_dart_fields_search_bar widget=widget indent=indent />
  <#elseif widget.type == "calendar">  
<@gux.print_dart_fields_calendar widget=widget indent=indent />
  <#elseif widget.type == "tree">  
<@gux.print_dart_fields_tree widget=widget indent=indent />
  <#elseif widget.type == "content_editor">  
<@gux.print_dart_fields_content_editor widget=widget indent=indent />
  <#elseif widget.type == "system_console">  
<@gux.print_dart_fields_system_console widget=widget indent=indent />
  <#elseif widget.type == "mobile_simulator">  
<@gux.print_dart_fields_mobile_simulator widget=widget indent=indent />
  <#elseif widget.type == "list_view">  
<@gux.print_dart_fields_list_view widget=widget indent=indent />
  <#elseif widget.type == "grid_view">  
<@gux.print_dart_fields_grid_view widget=widget indent=indent />
  <#elseif widget.type == "timeline">  
<@gux.print_dart_fields_timeline widget=widget indent=indent />
  <#elseif widget.type == "pagination_table">  
<@gux.print_dart_fields_pagination_table widget=widget indent=indent />
  <#elseif widget.type == "pagination_grid">  
<@gux.print_dart_fields_pagination_grid widget=widget indent=indent />
  <#elseif widget.type == "bottom_sheet">  
<@gux.print_dart_fields_bottom_sheet widget=widget indent=indent />
  <#elseif widget.type == "spreadsheet">  
<@gux.print_dart_fields_spreadsheet widget=widget indent=indent />
  <#elseif widget.type == "kanban">  
<@gux.print_dart_fields_kanban widget=widget indent=indent />
  <#elseif widget.type == "chat">  
<@gux.print_dart_fields_chat widget=widget indent=indent />
  <#elseif widget.type == "pie_chart">  
<@gux.print_dart_fields_pie_chart widget=widget indent=indent />
  <#elseif widget.type == "donut_chart">  
<@gux.print_dart_fields_donut_chart widget=widget indent=indent />
  <#elseif widget.type == "bar_chart">  
<@gux.print_dart_fields_bar_chart widget=widget indent=indent />
  <#elseif widget.type == "line_chart">  
<@gux.print_dart_fields_line_chart widget=widget indent=indent />
  <#elseif widget.type == "stack_chart">  
<@gux.print_dart_fields_stack_chart widget=widget indent=indent />
  <#elseif widget.type == "radar_chart">  
<@gux.print_dart_fields_radar_chart widget=widget indent=indent />
  <#elseif widget.type == "network_topology_diagram">  
<@gux.print_dart_fields_network_topology_diagram widget=widget indent=indent />
  <#elseif widget.type == "business_process_diagram">  
<@gux.print_dart_fields_business_process_diagram widget=widget indent=indent />
  </#if>
</#macro>

<#macro print_dart_methods_widget widget indent> 
  <#if widget.type == "tile">  
<@print_dart_methods_tile widget=widget indent=indent />
  <#elseif widget.type == "navigation_bar">  
<@gux.print_dart_methods_navigation_bar widget=widget indent=indent />
  <#elseif widget.type == "toolbar"> 
<@gux.print_dart_methods_toolbar widget=widget indent=indent />
  <#elseif widget.type == "editable_form"> 
<@gux.print_dart_methods_editable_form widget=widget indent=indent />
  <#elseif widget.type == "readonly_form"> 
<@gux.print_dart_methods_readonly_form widget=widget indent=indent />
  <#elseif widget.type == "tabs"> 
<@gux.print_dart_methods_tabs widget=widget indent=indent />
  <#elseif widget.type == "scroll_notification"> 
<@gux.print_dart_methods_scroll_notification widget=widget indent=indent />
  <#elseif widget.type == "swiper_navigator"> 
<@gux.print_dart_methods_swiper_navigator widget=widget indent=indent />
  <#elseif widget.type == "scroll_navigator"> 
<@gux.print_dart_methods_scroll_navigator widget=widget indent=indent />
  <#elseif widget.type == "list_navigator"> 
<@gux.print_dart_methods_list_navigator widget=widget indent=indent />
  <#elseif widget.type == "grid_navigator"> 
<@gux.print_dart_methods_grid_navigator widget=widget indent=indent />
  <#elseif widget.type == "search_bar"> 
<@gux.print_dart_methods_search_bar widget=widget indent=indent />
  <#elseif widget.type == "calendar"> 
<@gux.print_dart_methods_calendar widget=widget indent=indent />
  <#elseif widget.type == "tree"> 
<@gux.print_dart_methods_tree widget=widget indent=indent />
  <#elseif widget.type == "content_editor"> 
<@gux.print_dart_methods_content_editor widget=widget indent=indent />
  <#elseif widget.type == "system_console"> 
<@gux.print_dart_methods_system_console widget=widget indent=indent />
  <#elseif widget.type == "mobile_simulator"> 
<@gux.print_dart_methods_mobile_simulator widget=widget indent=indent />
  <#elseif widget.type == "list_view"> 
<@gux.print_dart_methods_list_view widget=widget indent=indent />
  <#elseif widget.type == "grid_view"> 
<@gux.print_dart_methods_grid_view widget=widget indent=indent />
  <#elseif widget.type == "timeline"> 
<@gux.print_dart_methods_timeline widget=widget indent=indent />
  <#elseif widget.type == "pagination_table"> 
<@gux.print_dart_methods_pagination_table widget=widget indent=indent />
  <#elseif widget.type == "pagination_grid"> 
<@gux.print_dart_methods_pagination_grid widget=widget indent=indent />
  <#elseif widget.type == "bottom_sheet"> 
<@gux.print_dart_methods_bottom_sheet widget=widget indent=indent />
  <#elseif widget.type == "spreadsheet"> 
<@gux.print_dart_methods_spreadsheet widget=widget indent=indent />
  <#elseif widget.type == "kanban"> 
<@gux.print_dart_methods_kanban widget=widget indent=indent />
  <#elseif widget.type == "chat"> 
<@gux.print_dart_methods_chat widget=widget indent=indent />
  <#elseif widget.type == "pie_chart"> 
<@gux.print_dart_methods_pie_chart widget=widget indent=indent />
  <#elseif widget.type == "donut_chart"> 
<@gux.print_dart_methods_donut_chart widget=widget indent=indent />
  <#elseif widget.type == "bar_chart"> 
<@gux.print_dart_methods_bar_chart widget=widget indent=indent />
  <#elseif widget.type == "line_chart"> 
<@gux.print_dart_methods_line_chart widget=widget indent=indent />
  <#elseif widget.type == "stack_chart"> 
<@gux.print_dart_methods_stack_chart widget=widget indent=indent />
  <#elseif widget.type == "radar_chart"> 
<@gux.print_dart_methods_radar_chart widget=widget indent=indent />
  <#elseif widget.type == "network_topology_diagram"> 
<@gux.print_dart_methods_network_topology_diagram widget=widget indent=indent />
  <#elseif widget.type == "business_process_diagram"> 
<@gux.print_dart_methods_business_process_diagram widget=widget indent=indent />
  </#if>
</#macro>  