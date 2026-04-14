<#import "/$/guidbase.ftl" as guidbase>

<#function bind_tap_if_url widget loopvar>
  <#if !widget.options["url"]??><#return ""></#if>
  <#local ret = " bind:tap=\"">
  <#local method = guidbase.url_to_method_name(widget.options["url"])>
  <#local params = guidbase.get_params_from_url(widget.options["url"])>
  <#local ret += js.nameVariable(method) + "\"">
  <#list params as param>
    <#local ret += " data-" + guidbase.camel_to_snake(param.name, "-") + "=\"">
    <#if param.value??>
      <#local ret += param.value + "\"">
    <#else>
      <#if loopvar == "">
        <#local ret += "{{" + param.name + "}}\"">
      <#else>
        <#local ret += "{{item." + param.name + "}}\"">
      </#if>  
    </#if>
  </#list>
  <#return ret>
</#function>

<#macro print_method_body_by_url url indent>
  <#local method = guidbase.url_to_method_name(url)>
  <#local sdkmethod = guidbase.url_to_method_sdk(url)>
  <#local pagepath = guidbase.url_to_page_path(url)>
  <#local params = guidbase.get_params_from_url(url)>
  <#if url?starts_with("$")>
${""?left_pad(indent)}let model = ev.currentTarget.dataset;
${""?left_pad(indent)}gux.navigateTo({
    <#if pagepath?starts_with("common")>
${""?left_pad(indent)}  url: `/page/${pagepath}/index${guidbase.state_params_with_values_in_url(params, "model")}`,    
    <#else>
${""?left_pad(indent)}  url: `/page/${app.name}/${pagepath}/index${guidbase.state_params_with_values_in_url(params, "model")}`,
    </#if>
${""?left_pad(indent)}});
  <#elseif url?starts_with("/")>
${""?left_pad(indent)}let model = ev.currentTarget.dataset;  
${""?left_pad(indent)}sdk.${js.nameVariable(sdkmethod)}(model).then(resp => {
${""?left_pad(indent)}  gux.navigateTo({
    <#if url?index_of("$") != -1>
      <#if pagepath?starts_with("common")>
${""?left_pad(indent)}    url: `/page/${pagepath}/index${guidbase.state_params_with_values_in_url(params, "model")}`,    
      <#else>
${""?left_pad(indent)}    url: `/page/${app.name}/${pagepath}/index${guidbase.state_params_with_values_in_url(params, "model")}`,
      </#if>
    </#if>
${""?left_pad(indent)}  });    
${""?left_pad(indent)}});  
  <#elseif url?starts_with("/")>
${""?left_pad(indent)}console.log('TODO');
  </#if>
</#macro>

<#macro print_request_params widget>
</#macro>

<#--
 ###############################################################################
 ### 【页面整体】的逻辑函数
 ###############################################################################
 -->

<#macro print_wxml_declare_widget widget indent>
  <#if !widget.type??><#return></#if>
  <#if widget.type == "row">  
${""?left_pad(indent)}<view class="gx-row">
    <#list widget.widgets![] as child>
<@print_wxml_declare_widget widget=child indent=indent+2 />    
    </#list>
${""?left_pad(indent)}</view>
  <#elseif widget.type == "col">  
    <#assign width = widget.options["width"]!"24">
${""?left_pad(indent)}<view class="gx-24-${guidbase.remake_column_width(width)}">
    <#list widget.widgets![] as child>
<@print_wxml_declare_widget widget=child indent=indent+2 />    
    </#list>
${""?left_pad(indent)}</view>
  <#elseif widget.type == "button">  
    <#if widget.options["url"]??>
      <#assign method = guidbase.url_to_method_name(widget.options["url"])>
${""?left_pad(indent)}<button class="primary outline" bind:tap="${js.nameVariable(method)}">${widget.options["title"]!"标题"}</button>    
    <#else>
${""?left_pad(indent)}<button class="primary outline">${widget.options["title"]!"标题"}</button>
    </#if>
  <#elseif widget.type == "text">  
${""?left_pad(indent)}<view class="gx-fs-24 gx-fb gx-px-16 gx-my-8">${widget.options["title"]!"标题"}</view>
  <#elseif widget.type == "tile">  
<@gux.print_wxml_declare_tile widget=widget indent=indent />
  <#elseif widget.type == "toolbar">  
<@gux.print_wxml_declare_toolbar widget=widget indent=indent />
  <#elseif widget.type == "editable_form">  
<@gux.print_wxml_declare_editable_form widget=widget indent=indent />
  <#elseif widget.type == "readonly_form">  
<@gux.print_wxml_declare_readonly_form widget=widget indent=indent />
  <#elseif widget.type == "tabs">  
<@gux.print_wxml_declare_tabs widget=widget indent=indent />
  <#elseif widget.type == "scroll_notification">  
<@gux.print_wxml_declare_scroll_notification widget=widget indent=indent />
  <#elseif widget.type == "swiper_navigator">  
<@gux.print_wxml_declare_swiper_navigator widget=widget indent=indent />
  <#elseif widget.type == "grid_navigator">  
<@gux.print_wxml_declare_grid_navigator widget=widget indent=indent />
  <#elseif widget.type == "scroll_navigator">  
<@gux.print_wxml_declare_scroll_navigator widget=widget indent=indent />
  <#elseif widget.type == "list_navigator">  
<@gux.print_wxml_declare_list_navigator widget=widget indent=indent />
  <#elseif widget.type == "grid_view">  
<@gux.print_wxml_declare_grid_view widget=widget indent=indent />
  <#elseif widget.type == "calendar">  
<@gux.print_wxml_declare_calendar widget=widget indent=indent />
  <#elseif widget.type == "tree">  
<@gux.print_wxml_declare_tree widget=widget indent=indent />
  <#elseif widget.type == "search_bar">  
<@gux.print_wxml_declare_search_bar widget=widget indent=indent />
  <#elseif widget.type == "list_view">  
<@gux.print_wxml_declare_list_view widget=widget indent=indent />
  <#elseif widget.type == "grid_view">  
<@gux.print_wxml_declare_grid_view widget=widget indent=indent />
  <#elseif widget.type == "timeline">  
<@gux.print_wxml_declare_timeline widget=widget indent=indent />
  <#elseif widget.type == "pagination_table">  
<@gux.print_wxml_declare_pagination_table widget=widget indent=indent />
  <#elseif widget.type == "pagination_grid">  
<@gux.print_wxml_declare_pagination_grid widget=widget indent=indent />
  <#elseif widget.type == "spreadsheet">  
<@gux.print_wxml_declare_spreadsheet widget=widget indent=indent />
  <#elseif widget.type == "kanban">  
<@gux.print_wxml_declare_kanban widget=widget indent=indent />
  <#elseif widget.type == "chat">  
<@gux.print_wxml_declare_chat widget=widget indent=indent />
  <#elseif widget.type == "pie_chart">  
<@gux.print_wxml_declare_pie_chart widget=widget indent=indent />
  <#elseif widget.type == "donut_chart">  
<@gux.print_wxml_declare_donut_chart widget=widget indent=indent />
  <#elseif widget.type == "bar_chart">  
<@gux.print_wxml_declare_bar_chart widget=widget indent=indent />
  <#elseif widget.type == "line_chart">  
<@gux.print_wxml_declare_line_chart widget=widget indent=indent />
  <#elseif widget.type == "stack_chart">  
<@gux.print_wxml_declare_stack_chart widget=widget indent=indent />
  <#elseif widget.type == "radar_chart">  
<@gux.print_wxml_declare_radar_chart widget=widget indent=indent />
  <#elseif widget.type == "network_topology_diagram">  
<@gux.print_wxml_declare_network_topology_diagram widget=widget indent=indent />
  <#elseif widget.type == "business_process_diagram">  
<@gux.print_wxml_declare_business_process_diagram widget=widget indent=indent />
  </#if>
</#macro>

<#--
 ###############################################################################
 ### 【数据瓦片】构造方法
 ###############################################################################
 -->
<#macro print_wxml_declare_tile widget indent>
  <#if widget.options["width"]??>
${""?left_pad(indent)}<view class="card gx-24-${guidbase.remake_column_width(widget.options["width"])}"   
  <#else>
${""?left_pad(indent)}<view class="card gx-p-16" 
  </#if>
${""?left_pad(indent)}      style="background:var(--color-surface);">
  <#if widget.options["title"]??>
${""?left_pad(indent)}  <view${bind_tap_if_url(widget,"")} class="gx-px-8 gx-d-flex gx-lh-32">
${""?left_pad(indent)}    <view class="gx-fb">${widget.options["title"]}</view>
${""?left_pad(indent)}    <view class="gx-fs-12 gx-text-primary gx-ml-auto">详情</view>
${""?left_pad(indent)}  </view>  
  </#if>
<@print_wxml_declare_tile_vertical widget=widget loopvar="" indent=indent+2 />  
${""?left_pad(indent)}</view>
</#macro>

<#macro print_wxml_declare_tile_horizontal widget loopvar indent>
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
${""?left_pad(indent)}<view${bind_tap_if_url(widget,loopvar)} class="gx-d-flex gx-p-16 gx-bb-1" style="align-items:center;" 
${""?left_pad(indent)}      wx:for="{{${loopvar}}}" wx:key="${js.nameVariable(objname + "_id")}" wx:for-item="item">
<@print_wxml_declare_tile_first_row widget=widget loopvar=loopvar indent=indent+2 />
${""?left_pad(indent)}</view>
  <#else>
${""?left_pad(indent)}<view${bind_tap_if_url(widget,loopvar)} class="gx-bb-1 gx-p-16" wx:for="{{${loopvar}}}" wx:key="${js.nameVariable(objname + "_id")}" wx:for-item="item">
${""?left_pad(indent)}  <view class="gx-d-flex" style="align-items:center;">
<@print_wxml_declare_tile_first_row widget=widget loopvar=loopvar indent=indent+4 />
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}  <view class="gx-d-flex">
<@print_wxml_declare_tile_second_row widget=widget loopvar=loopvar indent=indent+4 />
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}</view>
  </#if>
</#macro>

<#macro print_wxml_declare_tile_vertical widget loopvar indent>
  <#local hasPrimarySection = false>
  <#local hasQuaternarySection = false>
  <#local hasQuinarySection = false>
  <#list widget.widgets as child>
    <#if (child.options["level"]!"") == "image">
${""?left_pad(indent)}<view class="gx-d-flex gx-w-full">
${""?left_pad(indent)}  <image src="{{<#if loopvar != "">item.</#if>${js.nameVariable(child.id)}}}" mode="scaleToFill" 
${""?left_pad(indent)}         style="width:100%;min-height: 120px;" class="gx-m-auto"></image>
${""?left_pad(indent)}</view>  
    <#elseif (child.options["level"]!"") == "avatar">
${""?left_pad(indent)}<view class="gx-px-16 gx-m-auto" style="">
${""?left_pad(indent)}  <image src="{{<#if loopvar != "">item.</#if>${js.nameVariable(child.id)}}}" class="gx-wh-64 gx-b-round"></image>
${""?left_pad(indent)}</view>      
    </#if>
    <#if (child.options["level"]!"") == "primary" || 
         (child.options["level"]!"") == "secondary" ||
         (child.options["level"]!"") == "tertiary">
      <#local hasPrimarySection = true>   
    </#if> 
    <#if (widget.options["level"]!"") == "quaternary">
      <#local hasQuaternarySection = true>
    </#if>
    <#if (child.options["level"]!"") == "quinary" || 
         (child.options["level"]!"") == "senary" ||
         (child.options["level"]!"") == "septenary">
      <#local hasQuinarySection = true>   
    </#if> 
  </#list>
  <#if hasPrimarySection>   
${""?left_pad(indent)}<view class="gx-d-flex gx-w-full">  
${""?left_pad(indent)}  <view class="gx-w-full">  
    <#list widget.widgets as child>
      <#if (child.options["level"]!"") == "primary">
        <#if child.options["title"]??>
${""?left_pad(indent)}    <view class="gx-text-primary gx-text-center gx-fb gx-fs-14">${child.options["title"]}</view>        
        <#else>
${""?left_pad(indent)}    <view class="gx-text-primary gx-text-center gx-fb gx-fs-14">{{<#if loopvar != "">item.</#if>${js.nameVariable(guidbase.rename_widget_id(child))}}}</view>
        </#if>
      <#elseif (child.options["level"]!"") == "secondary">
        <#if child.type?ends_with("_chart")>
<@print_wxml_declare_widget widget=child indent=indent + 4 />
        <#elseif child.options["title"]??>
${""?left_pad(indent)}    <view class="gx-text-secondary gx-text-center gx-fb gx-fs-12">${child.options["title"]}</view>        
        <#else>
${""?left_pad(indent)}    <view class="gx-text-secondary gx-text-center gx-fb gx-fs-12">{{<#if loopvar != "">item.</#if>${js.nameVariable(guidbase.rename_widget_id(child))}}}</view>
        </#if>
      <#elseif (child.options["level"]!"") == "tertiary">
        <#if child.type?ends_with("_chart")>
<@print_wxml_declare_widget widget=child indent=indent + 4 />        
        <#else>
${""?left_pad(indent)}    <view class="gx-text-secondary gx-fs-10">{{<#if loopvar != "">item.</#if>${js.nameVariable(guidbase.rename_widget_id(child))}}}</view>
        </#if>
      </#if>
    </#list>
${""?left_pad(indent)}  </view>  
    <#list widget.widgets as child>
      <#if (child.options["level"]!"") == "accent">
        <#if child.type?ends_with("_chart")>
<@print_wxml_declare_widget widget=child indent=indent + 4 />
        <#elseif child.options["title"]??>
${""?left_pad(indent)}  <view${bind_tap_if_url(child,loopvar)} class="gx-fs-12 gx-fb gx-ml-auto">${child.options["title"]}</view>        
        <#else>
${""?left_pad(indent)}  <view${bind_tap_if_url(child,loopvar)} class="gx-fs-12 gx-fb gx-ml-auto">{{<#if loopvar != "">item.</#if>${js.nameVariable(guidbase.rename_widget_id(child))}}}</view>
        </#if>
      </#if>
     </#list>
${""?left_pad(indent)}</view>  
  </#if>
  <#if hasQuaternarySection>
    <#list widget.widgets as child>
      <#if (child.options["level"]!"") != "quaternary"><#continue></#if>
${""?left_pad(indent)}<view class="gx-text-secondary gx-fs-10">{{<#if loopvar != "">item.</#if>${js.nameVariable(guidbase.rename_widget_id(child))}}}</view>
    </#list>
  </#if>
  <#if hasQuinarySection>
${""?left_pad(indent)}<view class="gx-d-flex">    
    <#list widget.widgets as child>
      <#if (child.options["level"]!"") == "quinary">
${""?left_pad(indent)}  <view class="gx-d-flex gx-ml-auto">
${""?left_pad(indent)}    <text class="fas fa-star gx-fs-10 gx-pos-relative" style="top:2px;"></text>
${""?left_pad(indent)}    <view class="ms-auto gx-fs-11">{{<#if loopvar != "">item.</#if>${js.nameVariable(child.id?replace("_id", "_name")?replace("_code", "_name"))}}}</view>
${""?left_pad(indent)}  </view>
      <#elseif (child.options["level"]!"") == "senary">
${""?left_pad(indent)}  <view class="gx-d-flex">
${""?left_pad(indent)}    <text class="fas fa-star gx-fs-10 gx-pos-relative" style="top:2px;"></text>
${""?left_pad(indent)}    <view class="ms-auto gx-fs-11">{{<#if loopvar != "">item.</#if>${js.nameVariable(child.id?replace("_id", "_name")?replace("_code", "_name"))}}}</view>
${""?left_pad(indent)}  </view>
      <#elseif (child.options["level"]!"") == "septenary">
${""?left_pad(indent)}  <view class="gx-d-flex gx-ml-auto">
${""?left_pad(indent)}    <text class="fas fa-star gx-fs-10 gx-pos-relative" style="top:2px;"></text>
${""?left_pad(indent)}    <view class="ms-auto gx-fs-11">{{<#if loopvar != "">item.</#if>${js.nameVariable(child.id?replace("_id", "_name")?replace("_code", "_name"))}}}</view>
${""?left_pad(indent)}  </view>
      </#if>
    </#list>
${""?left_pad(indent)}</view>
  </#if>
</#macro>

<#macro print_wxml_declare_tile_first_row widget loopvar indent>
  <#local hasPrimarySection = false>
  <#local hasQuaternarySection = false>
  <#list widget.widgets as child>
    <#if (child.options["level"]!"") == "image">
${""?left_pad(indent)}<view class="gx-w-64 gx-mr-8">
${""?left_pad(indent)}  <image src="{{item.${js.nameVariable(child.id)}}}" class="gx-wh-64"></image>
${""?left_pad(indent)}</view>  
    <#elseif (child.options["level"]!"") == "avatar">
${""?left_pad(indent)}<view class="gx-w-64 gx-mr-8">
${""?left_pad(indent)}  <image src="{{item.${js.nameVariable(child.id)}}}" class="gx-wh-64 gx-b-round"></image>
${""?left_pad(indent)}</view>     
    </#if>
    <#if (child.options["level"]!"") == "primary" || 
         (child.options["level"]!"") == "secondary" ||
         (child.options["level"]!"") == "tertiary">
      <#local hasPrimarySection = true>   
    </#if> 
    <#if (child.options["level"]!"") == "quaternary">
      <#local hasQuaternarySection = true>
    </#if>
  </#list>
  <#if hasPrimarySection>   
${""?left_pad(indent)}<view>  
  <#list widget.widgets as child>
    <#if (child.options["level"]!"") == "primary">
${""?left_pad(indent)}  <view class="gx-text-primary gx-fs-14">{{<#if loopvar != "">item.</#if>${js.nameVariable(guidbase.rename_widget_id(child))}}}</view>
    <#elseif (child.options["level"]!"") == "secondary">
${""?left_pad(indent)}  <view class="gx-text-secondary gx-fs-14">{{<#if loopvar != "">item.</#if>${js.nameVariable(guidbase.rename_widget_id(child))}}}</view>
    <#elseif (child.options["level"]!"") == "tertiary">
${""?left_pad(indent)}  <view class="gx-text-secondary gx-fs-12">{{<#if loopvar != "">item.</#if>${js.nameVariable(guidbase.rename_widget_id(child))}}}</view>
    </#if>
  </#list>
${""?left_pad(indent)}</view>  
  </#if>
  <#if hasQuaternarySection>
    <#list widget.widgets as child>
      <#if (child.options["level"]!"") != "quaternary"><#continue></#if>
${""?left_pad(indent)}<view class="gx-text-secondary gx-fs-10">{{<#if loopvar != "">item.</#if>${js.nameVariable(guidbase.rename_widget_id(child))}}}</view>
    </#list>
  </#if>
  <#list widget.widgets as child>
    <#if (child.options["level"]!"") == "accent">
${""?left_pad(indent)}<view class="gx-fs-14 gx-fb gx-ml-auto">{{<#if loopvar != "">item.</#if>${js.nameVariable(guidbase.rename_widget_id(child))}}}</view>

    </#if>
  </#list>
</#macro>

<#macro print_wxml_declare_tile_second_row widget loopvar indent> 
  <#list widget.widgets as child>
    <#if (child.options["level"]!"") == "quinary">
${""?left_pad(indent)}<view class="gx-d-flex" style="flex:1;">
${""?left_pad(indent)}  <text class="fas fa-star gx-fs-10 gx-pos-relative" style="top:2px;"></text>
${""?left_pad(indent)}  <view class="ms-auto gx-fs-11">{{<#if loopvar != "">item.</#if>${js.nameVariable(guidbase.rename_widget_id(child))}}}</view>
${""?left_pad(indent)}</view>
    <#elseif (child.options["level"]!"") == "senary">
${""?left_pad(indent)}<view class="gx-d-flex" style="flex:1;">
${""?left_pad(indent)}  <text class="fas fa-star gx-fs-10 gx-pos-relative" style="top:2px;"></text>
${""?left_pad(indent)}  <view class="ms-auto gx-fs-11">{{<#if loopvar != "">item.</#if>${js.nameVariable(guidbase.rename_widget_id(child))}}}</view>
${""?left_pad(indent)}</view>
    <#elseif (child.options["level"]!"") == "septenary">
${""?left_pad(indent)}<view class="gx-d-flex" style="flex:1;">
${""?left_pad(indent)}  <text class="fas fa-star gx-fs-10 gx-pos-relative" style="top:2px;"></text>
${""?left_pad(indent)}  <view class="ms-auto gx-fs-11">{{<#if loopvar != "">item.</#if>${js.nameVariable(guidbase.rename_widget_id(child))}}}</view>
${""?left_pad(indent)}</view>
    </#if>
  </#list>
</#macro>

<#macro print_js_declare_tile widget indent> 
  <#if !widget.options["object"]??><#return></#if>
${""?left_pad(indent)}
${""?left_pad(indent)}sdk.fetch${js.nameType(widget.options["object"])}({
${""?left_pad(indent)}}).then(data => {
${""?left_pad(indent)}  this.setData(data);
${""?left_pad(indent)}});
</#macro>

<#macro print_js_fields_tile widget indent> 
${""?left_pad(indent)}
  <#list widget.widgets as child>
    <#if !child.id??><#continue></#if>
    <#if child.id == "thumbnail">
${""?left_pad(indent)}${js.nameVariable(child.id)}: '/asset/image/thumbnail.png',    
    <#elseif child.id == "avatar">
${""?left_pad(indent)}${js.nameVariable(child.id)}: '/asset/image/avatar.png',   
    <#else>
${""?left_pad(indent)}${js.nameVariable(child.id)}: '',
    </#if>
  </#list>
</#macro>

<#macro print_js_methods_tile widget indent>
  <#local methods = {}>
  <#if !widget.options["url"]??><#return></#if>
  <#local url = guidbase.get_url_from_tile(widget)>
  <#local method = guidbase.url_to_method_name(url)>
  <#if methods[method]??><#return></#if>
  <#local methods += {method:method}>
  <#local pagepath = guidbase.url_to_page_path(url)>
  <#local params = guidbase.get_params_from_url(url)>
  <#local clickable = guidbase.get_clickable_from_tile(widget)>
${""?left_pad(indent)}    
${""?left_pad(indent)}/*!
${""?left_pad(indent)}** 点击【${widget.options["title"]!"标题"}】响应事件。
${""?left_pad(indent)}*/
${""?left_pad(indent)}${js.nameVariable(method)}(ev) {
<@print_method_body_by_url url=url indent=indent+2 />
${""?left_pad(indent)}},
</#macro>

<#--
 ###############################################################################
 ### 【控制按钮】构造方法
 ###############################################################################
 -->
<#macro print_js_methods_button widget indent>
  <#if !widget.options["url"]??><#return></#if>
  <#local url = widget.options["url"]>
  <#local method = guidbase.url_to_method_name(url)>
  <#local pagepath = guidbase.url_to_page_path(url)>
${""?left_pad(indent)}
${""?left_pad(indent)}/*!
${""?left_pad(indent)}** 点击【${widget.options["title"]!"按钮标题"}】触发的事件逻辑。
${""?left_pad(indent)}*/
${""?left_pad(indent)}${js.nameVariable(method)}(ev) {
<@print_method_body_by_url url=url indent=indent+2 />
${""?left_pad(indent)}},
</#macro>

<#--
 ###############################################################################
 ### 【自定义导航栏】
 ###############################################################################
 -->
<#macro print_js_declare_navigation_bar widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_js_fields_navigation_bar widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_jsgnavigation_bar widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_wxml_declare_navigation_bar widget indent>
<view class="gx-w-full gx-pos-top" 
      style="z-index:9999;background:var(--color-background);height:{{height}}px;">
  <#list widget.widgets as child>
${""?left_pad(indent)}<@print_wxml_declare_widget widget=child indent=indent+2/>
  </#list>
</view>  
</#macro>

<#--
 ###############################################################################
 ### 【工具栏位】
 ###############################################################################
 -->
<#macro print_js_declare_toolbar widget indent>
</#macro>

<#macro print_js_fields_toolbar widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_js_methods_toolbar widget indent>
  <#list widget.widgets as child>
    <#if child.type == "button">
      <#if !child.options??><#continue></#if>
      <#if !child.options["url"]??><#continue></#if>
      <#local url = child.options["url"]>
      <#local params = guidbase.get_params_from_url(url)>
    </#if>
  </#list>  
</#macro>

<#macro print_wxml_declare_toolbar widget indent>
${""?left_pad(indent)}<view class="gx-d-flex gx-px-16 gx-py-8">
  <#list widget.widgets as child>
${""?left_pad(indent)}  <view class="gx-mx-8">
${""?left_pad(indent)}    <text class="gx-fs-12">${child.options["title"]!"标题"}</text>
${""?left_pad(indent)}    <text class="gx-i gx-i-arrow-right gx-fs-10"></text>
${""?left_pad(indent)}  </view>  
  </#list>
${""?left_pad(indent)}</view>  
</#macro>

<#--
 ###############################################################################
 ### 【编辑表单】
 ###############################################################################
 -->
<#macro print_js_declare_editable_form widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_js_fields_editable_form widget indent>
${""?left_pad(indent)}values${js.nameType(widget.id)}: {},
  <#assign fieldIndex = 0>
${""?left_pad(indent)}fields${js.nameType(widget.id)}: [{
  <#list widget.widgets as field>
    <#assign input = field.type!"text">
    <#if input == 'none' || input == 'constant' || input == 'id'><#continue></#if>
    <#assign name = field.id!"unset">
    <#if name?starts_with('meta_')>
      <#assign name = field.options['title']>
    <#else>
      <#assign name = field.id>
    </#if>
    <#if fieldIndex != 0>
${""?left_pad(indent)}},{
    </#if>
${""?left_pad(indent)}  title: "${field.options['title']!""}",
    <#if input == 'select'>
      <#if field['local']??>
        <#assign strs = field['local']?replace('[',"")?replace(']',"")?split(',')>
${""?left_pad(indent)}  name: '${name}',
${""?left_pad(indent)}  input: 'select',
${""?left_pad(indent)}  options: {
${""?left_pad(indent)}    values: [
        <#list strs as str>
${""?left_pad(indent)}      {value: '${str?substring(0, str?index_of(':'))?trim}', text: '${str?substring(str?index_of(':') + 1)?trim}', <#if str?index == 0>checked: true,</#if>},
        </#list>
${""?left_pad(indent)}    ],
${""?left_pad(indent)}  },
      <#elseif field.domainType?? && field.domainType?starts_with("&")>
        <#assign objname = field.domainType?substring(1, field.domainType?index_of('('))>
        <#assign attrname = field.domainType?substring(field.domainType?index_of('(') + 1, field.domainType?index_of(')'))>
${""?left_pad(indent)}  input: "select",
        <#if field.variant == js.nameVariable(objname)>
${""?left_pad(indent)}  name: "${js.nameVariable(objname) + js.nameType(attrname)}",
        <#else>
${""?left_pad(indent)}  name: "${field.variant}${js.nameType(objname)}${js.nameType(attrname)}",
        </#if>
${""?left_pad(indent)}  options: {
        <#if field['remote']??>
${""?left_pad(indent)}    url: '${field['remote']}',
        <#else>
${""?left_pad(indent)}    url: '/api/v3/common/script/${'stdbiz/' + field.parentPersistenceName?split('_')[1] + '/' + objname + '/find'}',
        </#if>
${""?left_pad(indent)}    fields: {
${""?left_pad(indent)}      value: "${js.nameVariable(objname)}${js.nameType(attrname)}",
${""?left_pad(indent)}      text: "${js.nameVariable(objname)}Name",
${""?left_pad(indent)}    },
${""?left_pad(indent)}  },
      <#else>
${""?left_pad(indent)}  name: '${name}',
${""?left_pad(indent)}  input: 'select',
${""?left_pad(indent)}  options: sdk.options['${field.options["object"]}#${field.options["attribute"]}'],
      </#if>
    <#elseif input == 'radio'>
${""?left_pad(indent)}  name: '${name}',
${""?left_pad(indent)}  input: 'radio',
${""?left_pad(indent)}  options: ${app.name}.options['${name}'],
    <#elseif input == 'check'>
${""?left_pad(indent)}  name: '${name}',
${""?left_pad(indent)}  input: 'check',
${""?left_pad(indent)}  options: ${app.name}.options['${name}'],
    <#elseif input == 'segment'>
      <#local values = field.options["values"]!"[]">
      <#local vals = guidbase.values_to_options_values(values)>
${""?left_pad(indent)}  name: '${name}',
${""?left_pad(indent)}  input: 'segment',
${""?left_pad(indent)}  options: {
${""?left_pad(indent)}    values: [{
      <#list vals as val>
        <#if val?index != 0>
${""?left_pad(indent)}    },{
        </#if>
${""?left_pad(indent)}      text: '${val.text}', value: '${val.value}',
      </#list>
${""?left_pad(indent)}    }], 
${""?left_pad(indent)}  },
    <#else>
${""?left_pad(indent)}  name: '${name}',
${""?left_pad(indent)}  input: '${field.type!"text"}',
    </#if>
    <#if field['required']!false == true>
${""?left_pad(indent)}  required: true,
    </#if>
    <#if field.unit?? && field.unit != "">
${""?left_pad(indent)}  unit: '${field.unit}',
    </#if>
    <#assign fieldIndex = fieldIndex + 1>
  </#list>
${""?left_pad(indent)}}],
</#macro>

<#macro print_js_methods_editable_form widget indent>
  <#assign fieldIds = []>
  <#assign pageName = page.id>
  <#assign objpath = (widget.options["object"]!"module/object")>
  <#assign objname = guidbase.get_object_from_object(objpath)>
  <#assign modname = guidbase.get_module_from_object(objpath)>
${""?left_pad(indent)}  
${""?left_pad(indent)}/**
${""?left_pad(indent)} * 提交【${widget.id}】表单。
${""?left_pad(indent)} */
${""?left_pad(indent)}doSave${js.nameType(widget.id)}: async function () {
${""?left_pad(indent)}  try {
${""?left_pad(indent)}    let data = await sdk.save${js.nameType(objname)}(this.data.values${js.nameType(widget.id)});
${""?left_pad(indent)}    wx.showToast({title: '数据保存成功！', icon: 'success'});
${""?left_pad(indent)}  } catch (err) {
${""?left_pad(indent)}    wx.showToast({title: err, icon: 'error'});
${""?left_pad(indent)}  }
${""?left_pad(indent)}},
${""?left_pad(indent)}  
${""?left_pad(indent)}/**
${""?left_pad(indent)} * 加载【${widget.id}】数据到表单。
${""?left_pad(indent)} */
${""?left_pad(indent)}doRead${js.nameType(widget.id)}: async function (id) {
${""?left_pad(indent)}  let data = await sdk.fetch${js.nameType(objname)}(id);
${""?left_pad(indent)}
${""?left_pad(indent)}  if (data.error) {
${""?left_pad(indent)}    wx.showToast({
${""?left_pad(indent)}      icon: "error",
${""?left_pad(indent)}      title: "程序出错啦！",
${""?left_pad(indent)}    });
${""?left_pad(indent)}    return;
${""?left_pad(indent)}  }
${""?left_pad(indent)}
${""?left_pad(indent)}  this.form${js.nameType(widget.id)} = this.selectComponent('#form${js.nameType(widget.id)}');
${""?left_pad(indent)}  this.form${js.nameType(widget.id)}.setValues(data);
${""?left_pad(indent)}},
</#macro>

<#macro print_wxml_declare_editable_form widget indent>
  <#if widget.options["columns"]?? && widget.options["columns"] == "1">
${""?left_pad(indent)}<gx-single-column-form fields="{{fields${js.nameType(widget.id)}}}" 
${""?left_pad(indent)}                       data="{{values${js.nameType(widget.id)}}}" 
${""?left_pad(indent)}                       id="form${js.nameType(widget.id)}"
${""?left_pad(indent)}                       bind:onSubmit="doSaveForm${js.nameType(widget.id)}" />  
  <#else>
${""?left_pad(indent)}<gx-two-column-form fields="{{fields${js.nameType(widget.id)}}}" 
${""?left_pad(indent)}                    data="{{values${js.nameType(widget.id)}}}" 
${""?left_pad(indent)}                    id="form${js.nameType(widget.id)}"
${""?left_pad(indent)}                    bind:onSubmit="doSaveForm${js.nameType(widget.id)}" 
${""?left_pad(indent)}                    labelWidth="200" />
  </#if>
</#macro>

<#macro print_json_declare_editable_form widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#--
 ###############################################################################
 ### 【只读表单】
 ###############################################################################
 -->
<#macro print_js_declare_readonly_form widget indent>
  <#if !widget.id??><#return></#if>
${""?left_pad(indent)}
${""?left_pad(indent)}sdk.fetch${js.nameType(widget.options["object"]!"unknown")}({
${""?left_pad(indent)}}).then(data => {
${""?left_pad(indent)}  let form = this.selectComponent('#form${js.nameType(widget.id)}');
${""?left_pad(indent)}  form.setValues(data);
${""?left_pad(indent)}  // this.setData({values${js.nameType(widget.id)}:data});
${""?left_pad(indent)}});
</#macro>

<#macro print_js_fields_readonly_form widget indent>
${""?left_pad(indent)}values${js.nameType(widget.id)}: {},
  <#assign fieldIndex = 0>
${""?left_pad(indent)}fields${js.nameType(widget.id)}: [{
  <#list widget.widgets as field>
    <#assign input = field.type!"text">
    <#if input == 'none' || input == 'constant' || input == 'id'><#continue></#if>
    <#assign name = field.id!"unset">
    <#if name?starts_with('meta_')>
      <#assign name = field.options['title']>
    <#else>
      <#assign name = js.nameVariable(field.id)>
    </#if>
    <#if fieldIndex != 0>
${""?left_pad(indent)}},{
    </#if>
${""?left_pad(indent)}  title: "${field.options['title']!"标题"}",
    <#if input == 'select'>
      <#if field['local']??>
        <#assign strs = field['local']?replace('[',"")?replace(']',"")?split(',')>
${""?left_pad(indent)}  name: '${name}',
${""?left_pad(indent)}  input: 'select',
${""?left_pad(indent)}  options: {
${""?left_pad(indent)}    values: [
        <#list strs as str>
${""?left_pad(indent)}      {value: '${str?substring(0, str?index_of(':'))?trim}', text: '${str?substring(str?index_of(':') + 1)?trim}', <#if str?index == 0>checked: true,</#if>},
        </#list>
${""?left_pad(indent)}    ],
${""?left_pad(indent)}  },
      <#elseif field.domainType?? && field.domainType?starts_with("&")>
        <#assign objname = field.domainType?substring(1, field.domainType?index_of('('))>
        <#assign attrname = field.domainType?substring(field.domainType?index_of('(') + 1, field.domainType?index_of(')'))>
${""?left_pad(indent)}  input: "select",
        <#if field.variant == js.nameVariable(objname)>
${""?left_pad(indent)}  name: "${js.nameVariable(objname) + js.nameType(attrname)}",
        <#else>
${""?left_pad(indent)}  name: "${field.variant}${js.nameType(objname)}${js.nameType(attrname)}",
        </#if>
${""?left_pad(indent)}  options: {
        <#if field['remote']??>
${""?left_pad(indent)}    url: '${field['remote']}',
        <#else>
${""?left_pad(indent)}    url: '/api/v3/common/script/${'stdbiz/' + field.parentPersistenceName?split('_')[1] + '/' + objname + '/find'}',
        </#if>
${""?left_pad(indent)}    fields: {
${""?left_pad(indent)}      value: "${js.nameVariable(objname)}${js.nameType(attrname)}",
${""?left_pad(indent)}      text: "${js.nameVariable(objname)}Name",
${""?left_pad(indent)}    },
${""?left_pad(indent)}  },
      <#else>
${""?left_pad(indent)}  name: '${name}',
${""?left_pad(indent)}  input: 'select',
${""?left_pad(indent)}  options: sdk.options['${field.options["object"]}#${field.options["attribute"]}'],
      </#if>
    <#elseif input == 'radio'>
${""?left_pad(indent)}  name: '${name}',
${""?left_pad(indent)}  input: 'radio',
${""?left_pad(indent)}  options: ${app.name}.options['${name}'],
    <#elseif input == 'check'>
${""?left_pad(indent)}  name: '${name}',
${""?left_pad(indent)}  input: 'check',
${""?left_pad(indent)}  options: ${app.name}.options['${name}'],
    <#else>
${""?left_pad(indent)}  name: '${name}',
${""?left_pad(indent)}  input: '${field.type!"text"}',
    </#if>
    <#if field['required']!false == true>
${""?left_pad(indent)}  required: true,
    </#if>
    <#if field.unit?? && field.unit != "">
${""?left_pad(indent)}  unit: '${field.unit}',
    </#if>
    <#assign fieldIndex = fieldIndex + 1>
  </#list>
${""?left_pad(indent)}}],
</#macro>

<#macro print_js_methods_readonly_form widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_wxml_declare_readonly_form widget indent>
${""?left_pad(indent)}<view class="card gx-mt-16">
${""?left_pad(indent)}  <gx-two-column-form fields="{{fields${js.nameType(widget.id)}}}" 
${""?left_pad(indent)}                      data="{{values${js.nameType(widget.id)}}}" 
${""?left_pad(indent)}                      id="form${js.nameType(widget.id)}"
${""?left_pad(indent)}                      readonly="{{true}}"
${""?left_pad(indent)}                      input-group-ex="input-group"
${""?left_pad(indent)}                      field-ex="field"
${""?left_pad(indent)}                      labelWidth="200" />
${""?left_pad(indent)}</view>
</#macro>

<#macro print_json_declare_readonly_form widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#--
 ###############################################################################
 ### 【分页页签】
 ###############################################################################
 -->
<#macro print_js_declare_tabs widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_js_fields_tabs widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}index4${js.nameType(widget.id!'todo')}: 0,
${""?left_pad(indent)}items4${js.nameType(widget.id!'todo')}: [<#list widget.widgets as item>"${item.options["title"]!"页签标题"}",</#list>],
</#macro>

<#macro print_js_methods_tabs widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}doSwipe${js.nameType(widget.id!'todo')}(ev) {
${""?left_pad(indent)}  let tabs = this.selectComponent('#${js.nameVariable(widget.id!'todo')}');
${""?left_pad(indent)}  tabs.setData({currentTabIndex: ev.detail.current,});
${""?left_pad(indent)}},
${""?left_pad(indent)}
${""?left_pad(indent)}didClickTabItem(ev) {
${""?left_pad(indent)}  this.setData({
${""?left_pad(indent)}    index4${js.nameType(widget.id!'todo')}: ev.detail.index,
${""?left_pad(indent)}  });
${""?left_pad(indent)}},
</#macro>

<#macro print_wxml_declare_tabs widget indent>
${""?left_pad(indent)}<gx-tabs id="${js.nameVariable(widget.id!'todo')}" items="{{items4${js.nameType(widget.id!'todo')}}}" 
${""?left_pad(indent)}         bind:didClickTabItem="didClickTabItem" alwaysOnTop="{{true}}">
${""?left_pad(indent)}  <swiper class="tab-content" duration="300" current="{{index4${js.nameType(widget.id!'todo')}}}"
${""?left_pad(indent)}          bind:change="doSwipe${js.nameType(widget.id!'todo')}" style="height:240px;">      
${""?left_pad(indent)}    <swiper-item wx:for="{{items4${js.nameType(widget.id!'todo')}}}" wx:key="index">
  <#list widget.widgets as child>
${""?left_pad(indent)}      <view wx:if="{{index == ${child?index}}}" style="padding: 16px;">          
<@print_wxml_declare_widget widget=child indent=indent+8 />  
${""?left_pad(indent)}      </view>
  </#list>
${""?left_pad(indent)}    </swiper-item>
${""?left_pad(indent)}  </swiper>
${""?left_pad(indent)}</gx-tabs>
</#macro>

<#macro print_json_declare_tabs widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#--
 ###############################################################################
 ### 【通知公告】
 ###############################################################################
 -->
<#macro print_js_declare_scroll_notification widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}sdk.fetchApplicationNotifications().then(notifs => {
${""?left_pad(indent)}  this.setData({
${""?left_pad(indent)}    applicationNotifications: notifs,
${""?left_pad(indent)}  });
${""?left_pad(indent)}});
</#macro>

<#macro print_js_fields_scroll_notification widget indent>
</#macro>

<#macro print_js_methods_scroll_notification widget indent>
<#--
${""?left_pad(indent)}
${""?left_pad(indent)}startScrollNotification() {
${""?left_pad(indent)}  let that = this;
${""?left_pad(indent)}  const scrollSpeed = 1; 
${""?left_pad(indent)}  const scrollStep = 1; 
${""?left_pad(indent)}  const resetPosition = -100; 
${""?left_pad(indent)}
${""?left_pad(indent)}  const query = wx.createSelectorQuery();
${""?left_pad(indent)}  query.select('.scroll-content').boundingClientRect();
${""?left_pad(indent)}  query.exec((res) => {
${""?left_pad(indent)}    const contentWidth = res[0].width;
${""?left_pad(indent)}    this.scrollTimer = setInterval(() => {
${""?left_pad(indent)}      that.setData({
${""?left_pad(indent)}        scrollLeft: that.data.scrollLeft + scrollStep
${""?left_pad(indent)}      });
${""?left_pad(indent)}      if (that.data.scrollLeft > contentWidth) {
${""?left_pad(indent)}        that.setData({
${""?left_pad(indent)}          scrollLeft: resetPosition
${""?left_pad(indent)}        });
${""?left_pad(indent)}      }
${""?left_pad(indent)}    }, 30); // Adjust the interval time for smoother scrolling
${""?left_pad(indent)}  });
${""?left_pad(indent)}},
-->
</#macro>

<#macro print_wxml_declare_scroll_notification widget indent>
${""?left_pad(indent)}<view class="gx-d-flex gx-px-8" style="height: 20px; line-height: 20px;">
${""?left_pad(indent)}  <text class="gx-i gx-i-broadcast gx-color-primary gx-fs-18"></text>
${""?left_pad(indent)}  <swiper autoplay="true" vertical="true" circular="true" duration="500" style="height: 20px;width: 100%;">
${""?left_pad(indent)}    <swiper-item class="gx-fs-12 gx-px-8" wx:for="{{applicationNotifications}}" wx:key="index">{{item.content}}</swiper-item>
${""?left_pad(indent)}  </swiper>
${""?left_pad(indent)}</view>
</#macro>

<#--
 ###############################################################################
 ### 【滚动导航】
 ###############################################################################
 -->
<#macro print_js_declare_swiper_navigator widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}this.refresh${js.nameType(widget.id)}();
</#macro>

<#macro print_js_fields_swiper_navigator widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}items4${js.nameType(widget.id)}: [],
</#macro>

<#macro print_js_methods_swiper_navigator widget indent>
  <#local url = widget.options["url"]>
${""?left_pad(indent)}
${""?left_pad(indent)}/*!
${""?left_pad(indent)}** 加载并渲染加载的【${widget.options["title"]!"未设置"}】数据。
${""?left_pad(indent)}*/
${""?left_pad(indent)}async fetchAndRender${js.nameType(widget.id)}() {
${""?left_pad(indent)}  let items = await sdk.fetch${js.nameType(guidbase.pluralize_widget_object(widget))}(this.data.params4${js.nameType(widget.id)});
${""?left_pad(indent)}  items = this.data.items4${js.nameType(widget.id)}.concat(items);
${""?left_pad(indent)}  this.setData({
${""?left_pad(indent)}    items4${js.nameType(widget.id)}: items,
${""?left_pad(indent)}  });
${""?left_pad(indent)}},
${""?left_pad(indent)}
${""?left_pad(indent)}/*!
${""?left_pad(indent)}** 重新刷新【${widget.options["title"]!"未设置"}】列表。
${""?left_pad(indent)}*/
${""?left_pad(indent)}async refresh${js.nameType(widget.id)}() {
${""?left_pad(indent)}  this.data.items4${js.nameType(widget.id)} = [];
${""?left_pad(indent)}  this.fetchAndRender${js.nameType(widget.id)}();
${""?left_pad(indent)}},
</#macro>

<#macro print_wxml_declare_swiper_navigator widget indent>
  <#local url = widget.options["url"]>
  <#local objname = guidbase.get_object_from_url(url)>
${""?left_pad(indent)}<view style="height: 320px;">
${""?left_pad(indent)}  <swiper indicator-dots="{{false}}" autoplay="{{true}}" interval="{{3000}}" duration="{{500}}" circular="{{true}}" 
${""?left_pad(indent)}          indicator-color="#D8D8D8" indicator-active-color="#3F86FF" style="height:100%;">
${""?left_pad(indent)}    <swiper-item wx:for="{{items4${js.nameType(widget.id)}}}" wx:key="${js.nameVariable(objname + "_id")}">
${""?left_pad(indent)}      <navigator url="/page/{{item.url}}" class="swiper-item">
${""?left_pad(indent)}        <image class="banner-img" src="{{item.imagePath}}" mode="scaleToFit" style="width:100%;height:320px;"></image>
${""?left_pad(indent)}      </navigator>
${""?left_pad(indent)}    </swiper-item>
${""?left_pad(indent)}  </swiper>
${""?left_pad(indent)}</view>
</#macro>

<#macro print_json_declare_swiper_navigator widget indent>

</#macro>

<#--
 ###############################################################################
 ### 【滑动导航】
 ###############################################################################
 -->
<#macro print_js_declare_scroll_navigator widget indent>
  <#if widget.widgets?size != 0>
    <#return>
  </#if>
${""?left_pad(indent)}
${""?left_pad(indent)}this.fetchAndRender${js.nameType(widget.id)}();
</#macro>

<#macro print_js_fields_scroll_navigator widget indent>
  <#if widget.widgets?size != 0>
    <#return>
  </#if>
${""?left_pad(indent)}
${""?left_pad(indent)}items4${js.nameType(widget.id)}:[],
</#macro>

<#macro print_js_methods_scroll_navigator widget indent>
  <#if widget.widgets?size != 0>
    <#return>
  </#if>
  <#local url = widget.options["url"]>
${""?left_pad(indent)}
${""?left_pad(indent)}/*!
${""?left_pad(indent)}** 加载并渲染加载的【${widget.options["title"]!"未设置"}】数据。
${""?left_pad(indent)}*/
${""?left_pad(indent)}async fetchAndRender${js.nameType(widget.id)}() {
${""?left_pad(indent)}  let items = await sdk.fetch${js.nameType(guidbase.pluralize_widget_object(widget))}({
${""?left_pad(indent)}    limit: 5
${""?left_pad(indent)}  });
${""?left_pad(indent)}  this.setData({
${""?left_pad(indent)}    items4${js.nameType(widget.id)}: items,
${""?left_pad(indent)}  });
${""?left_pad(indent)}},
</#macro>

<#macro print_wxml_declare_scroll_navigator widget indent>
  <#if widget.options["title"]??>
${""?left_pad(indent)}<view class="gx-d-flex gx-p-16">
${""?left_pad(indent)}  <view class="gx-fs-16 gx-fb">${widget.options["title"]}</view>
${""?left_pad(indent)}</view>
  </#if>
  <#if widget.widgets?size != 0>
${""?left_pad(indent)}<view class="px-2" style="height: 200px;">
${""?left_pad(indent)}  <swiper display-multiple-items="3" 
${""?left_pad(indent)}          indicator-dots="{{false}}" 
${""?left_pad(indent)}          autoplay="{{false}}" circular="{{true}}" indicator-color="#D8D8D8" 
${""?left_pad(indent)}          indicator-active-color="#3F86FF" style="height:100%;">
    <#list widget.widgets as child>
${""?left_pad(indent)}    <swiper-item wx:for="{{items4${js.nameType(widget.id)}}}">
${""?left_pad(indent)}      <navigator url="/page/${app.name}/${child.options["url"]!""}" 
${""?left_pad(indent)}                 class="swiper-item" 
${""?left_pad(indent)}                 style="margin-left: 16px;">
${""?left_pad(indent)}        <image src="${child.options["image"]!""}" mode="scaleToFill" style="width:100%;height:200px;"></image>
${""?left_pad(indent)}      </navigator>
${""?left_pad(indent)}    </swiper-item>
    </#list>
${""?left_pad(indent)}  </swiper>
${""?left_pad(indent)}</view>  
    <#return>
  </#if>
  <#local image = widget.options["image"]!"image">
  <#local url = widget.options["url"]>
  <#local objname = guidbase.get_object_from_url(url)>
${""?left_pad(indent)}<view class="px-2" style="height: 200px;">
${""?left_pad(indent)}  <swiper display-multiple-items="3" 
${""?left_pad(indent)}          indicator-dots="{{false}}" 
${""?left_pad(indent)}          autoplay="{{false}}" circular="{{true}}" indicator-color="#D8D8D8" 
${""?left_pad(indent)}          indicator-active-color="#3F86FF" style="height:100%;">
${""?left_pad(indent)}    <swiper-item wx:for="{{items4${js.nameType(widget.id)}}}">
${""?left_pad(indent)}      <navigator url="/page/${app.name}" 
${""?left_pad(indent)}                 class="swiper-item" 
${""?left_pad(indent)}                 style="margin-left: 16px;">
${""?left_pad(indent)}        <image src="{{item.${image}}}" mode="scaleToFill" style="width:100%;height:200px;"></image>
${""?left_pad(indent)}      </navigator>
${""?left_pad(indent)}    </swiper-item>
${""?left_pad(indent)}  </swiper>
${""?left_pad(indent)}</view>
</#macro>

<#--
 ###############################################################################
 ### 【列表导航】
 ###############################################################################
 -->
<#macro print_js_declare_list_navigator widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_js_fields_list_navigator widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_js_methods_list_navigator widget indent>
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
${""?left_pad(indent)}${js.nameVariable(method)}(ev) {
<@print_method_body_by_url url=url indent=indent+2 />
${""?left_pad(indent)}},
  </#list>
</#macro>

<#macro print_wxml_declare_list_navigator widget indent>
${""?left_pad(indent)}<view class="<#if widget.options["width"]??> gx-24-${guidbase.remake_column_width(widget.options["width"])}</#if>">
${""?left_pad(indent)}  <view class="card gx-m-8 gx-p-16" style="background:var(--color-surface-light);border-radius:10px;">
  <#if widget.options["title"]?? || guidbase.has_toolbar_of_widget(widget)>
${""?left_pad(indent)}    <view class="card-header gx-d-flex">
${""?left_pad(indent)}      <view class="gx-fb">${widget.options["title"]!""}</view>
    <#if guidbase.has_toolbar_of_widget(widget)>
      <#assign toolbar = guidbase.get_toolbar_of_widget(widget)>
${""?left_pad(indent)}      <view class="gx-d-flex gx-ml-auto" style="align-items:center;">     
      <#list toolbar.widgets as child> 
${""?left_pad(indent)}        <view${bind_tap_if_url(child,"")} class="gx-fs-11">${child.options["title"]!"未定义"}</view>
      </#list>
${""?left_pad(indent)}      </view>
    </#if>
${""?left_pad(indent)}    </view>
  </#if>
${""?left_pad(indent)}    <view widget-id="widget${js.nameType(widget.id)}" class="card-body">
  <#-- 如果没有定义url属性，则说明是静态渲染的，这是一个规则 -->
${""?left_pad(indent)}      <view class="list-group">
  <#list widget.widgets as child>
    <#if child.type != "tile"><#continue></#if>
${""?left_pad(indent)}        <view${bind_tap_if_url(widget,"")} class="list-group-item">
<@print_wxml_declare_tile widget=child indent=indent+8 />
${""?left_pad(indent)}        </view>    
  </#list>
${""?left_pad(indent)}      </view>  
${""?left_pad(indent)}    </view>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}</view>
</#macro>

<#--
 ###############################################################################
 ### 【栅格导航】
 ###############################################################################
 -->
<#macro print_js_declare_grid_navigator widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_js_fields_grid_navigator widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_js_methods_grid_navigator widget indent>
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
${""?left_pad(indent)}${js.nameVariable(method)}(ev) {
<@print_method_body_by_url url=url indent=indent+2 />
${""?left_pad(indent)}},
  </#list>
</#macro>

<#macro print_wxml_declare_grid_navigator widget indent>
  <#local columns = widget.options["columns"]!"3">
  <#local childWidth = "33.33% - 16px">
  <#if columns == "2">
    <#local childWidth = "50% - 12px">
  <#elseif columns == "4">
    <#local childWidth = "25% - 20px">
  <#elseif columns == "5">
    <#local childWidth = "20% - 25px">
  </#if>
${""?left_pad(indent)}<view class="<#if widget.options["width"]??> gx-24-${guidbase.remake_column_width(widget.options["width"])}</#if>">
${""?left_pad(indent)}  <view class="card gx-m-8 gx-p-16" style="background:var(--color-surface-light);border-radius:10px;">
  <#if widget.options["title"]?? || guidbase.has_toolbar_of_widget(widget)>
${""?left_pad(indent)}    <view class="card-header gx-d-flex">
${""?left_pad(indent)}      <view class="gx-fb">${widget.options["title"]!""}</view>
    <#if guidbase.has_toolbar_of_widget(widget)>
      <#assign toolbar = guidbase.get_toolbar_of_widget(widget)>
${""?left_pad(indent)}      <view class="gx-d-flex gx-ml-auto" style="align-items:center;">     
      <#list toolbar.widgets as child> 
${""?left_pad(indent)}        <view${bind_tap_if_url(child,"")} class="gx-fs-11">${child.options["title"]!"未定义"}</view>
      </#list>
${""?left_pad(indent)}      </view>
    </#if>
${""?left_pad(indent)}    </view>
  </#if>
${""?left_pad(indent)}    <view class="card-body">
${""?left_pad(indent)}      <view class="buttons">
  <#list widget.widgets as child>
    <#if child.type != "tile"><#continue></#if>
${""?left_pad(indent)}        <view${bind_tap_if_url(child,"")} class="button" style="width:calc(${childWidth});max-width:calc(${childWidth});">
<@print_wxml_declare_tile_vertical widget=child loopvar="" indent=indent+8 />
${""?left_pad(indent)}        </view>
  </#list>
${""?left_pad(indent)}      </view>
${""?left_pad(indent)}    </view>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}</view>
</#macro>

<#macro print_json_declare_grid_navigator widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#--
 ###############################################################################
 ### 【事件日历】
 ###############################################################################
 -->
<#macro print_js_declare_calendar widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_js_fields_calendar widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}selectedDays4${js.nameType(widget.id)}: [],
</#macro>

<#macro print_js_methods_calendar widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}/*!
${""?left_pad(indent)}** 点击选择日历日期。
${""?left_pad(indent)}*/
${""?left_pad(indent)}doSelectDateOf${js.nameType(widget.id)}(ev) {
${""?left_pad(indent)}
${""?left_pad(indent)}},
</#macro>

<#macro print_wxml_declare_calendar widget indent>
${""?left_pad(indent)}<gx-calendar id="${js.nameVariable(widget.id)}" isOpen="{{true}}" 
${""?left_pad(indent)}             background="var(--color-background)" 
${""?left_pad(indent)}             selected="{{selectedDays4${js.nameType(widget.id)}}}"
${""?left_pad(indent)}             bind:select="doSelectDateOf${js.nameType(widget.id)}"></gx-calendar>     
</#macro>

<#macro print_json_declare_calendar widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#--
 ###############################################################################
 ### 【树型结构】
 ###############################################################################
 -->
<#macro print_js_declare_tree widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_js_fields_tree widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_js_methods_tree widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_wxml_declare_tree widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_json_declare_tree widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#--
 ###############################################################################
 ### 【搜索栏位】
 ###############################################################################
 -->
<#macro print_js_declare_search_bar widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_js_fields_search_bar widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_js_methods_search_bar widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}gotoSearch() {
${""?left_pad(indent)}  gux.navigateTo({
${""?left_pad(indent)}    url: '/page/common/search/index',
${""?left_pad(indent)}  });
${""?left_pad(indent)}},
${""?left_pad(indent)}
${""?left_pad(indent)}doSearch(criteria) {
${""?left_pad(indent)}  this.setData({
${""?left_pad(indent)}    searchCriteria: criteria,
${""?left_pad(indent)}  });
${""?left_pad(indent)}},
</#macro>

<#macro print_wxml_declare_search_bar widget indent>
${""?left_pad(indent)}<view class="search-bar">
${""?left_pad(indent)}  <icon type="search" color="#999" class="icon" />
${""?left_pad(indent)}  <input type="text" style="flex: 1;" placeholder-class="placeholder" placeholder="搜索" 
${""?left_pad(indent)}         bind:tap="gotoSearch" value="{{searchCriteria}}" />
${""?left_pad(indent)}</view>
</#macro>

<#--
 ###############################################################################
 ### 【传统列表】
 ###############################################################################
 -->
<#macro print_js_declare_list_view widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}this.refresh${js.nameType(widget.id)}();
</#macro>

<#macro print_js_fields_list_view widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}items4${js.nameType(widget.id)}: [],
${""?left_pad(indent)}
${""?left_pad(indent)}params4${js.nameType(widget.id)}: {
${""?left_pad(indent)}  start: 0,
  <#if widget.options["top"]??>
${""?left_pad(indent)}  limit: ${widget.options["top"]},
  <#else>
${""?left_pad(indent)}  limit: 15,
  </#if>
${""?left_pad(indent)}},
</#macro>

<#macro print_js_methods_list_view widget indent>
  <#assign url = widget.options["url"]!"module/object/action">
  <#local objname = guidbase.get_object_from_url(widget.options["url"]!"module/object/action")>
${""?left_pad(indent)}
${""?left_pad(indent)}/*!
${""?left_pad(indent)}** 加载并渲染加载的【${widget.options["title"]!"未设置"}】数据。
${""?left_pad(indent)}*/
${""?left_pad(indent)}async fetchAndRender${js.nameType(widget.id)}() {
${""?left_pad(indent)}  let items = await sdk.fetch${js.nameType(guidbase.pluralize_widget_object(widget))}(this.data.params4${js.nameType(widget.id)});
${""?left_pad(indent)}  items = this.data.items4${js.nameType(widget.id)}.concat(items);
${""?left_pad(indent)}  this.setData({
${""?left_pad(indent)}    items4${js.nameType(widget.id)}: items,
${""?left_pad(indent)}  });
${""?left_pad(indent)}},
${""?left_pad(indent)}
${""?left_pad(indent)}/*!
${""?left_pad(indent)}** 重新刷新【${widget.options["title"]!"未设置"}】列表。
${""?left_pad(indent)}*/
${""?left_pad(indent)}async refresh${js.nameType(widget.id)}() {
${""?left_pad(indent)}  this.data.params4${js.nameType(widget.id)}.start = 0;
${""?left_pad(indent)}  this.data.items4${js.nameType(widget.id)} = [];
${""?left_pad(indent)}  this.fetchAndRender${js.nameType(widget.id)}();
${""?left_pad(indent)}},
${""?left_pad(indent)}
${""?left_pad(indent)}/*!
${""?left_pad(indent)}** 加载更多【${widget.options["title"]!"未设置"}】列表。
${""?left_pad(indent)}*/
${""?left_pad(indent)}async load${js.nameType(widget.id)}() {
${""?left_pad(indent)}  this.data.params4${js.nameType(widget.id)}.start += this.data.params4${js.nameType(widget.id)}.limit;
${""?left_pad(indent)}  this.fetchAndRender${js.nameType(widget.id)}();
${""?left_pad(indent)}},
  <#list widget.widgets as child>
    <#local url = guidbase.get_url_from_tile(child)>
    <#if url == ""><#continue></#if>
    <#local method = guidbase.url_to_method_name(url)>
    <#local pagepath = guidbase.url_to_page_path(url)>
    <#local params = guidbase.get_params_from_url(url)>
    <#local clickable = guidbase.get_clickable_from_tile(child)>
${""?left_pad(indent)}    
${""?left_pad(indent)}/*!
${""?left_pad(indent)}** 点击【${child.options["title"]!"标题"}】响应事件。
${""?left_pad(indent)}*/
${""?left_pad(indent)}${js.nameVariable(method)}(ev) {
<@print_method_body_by_url url=url indent=indent+2 />
${""?left_pad(indent)}},
  </#list>
</#macro>

<#macro print_wxml_declare_list_view widget indent>
  <#local objname = guidbase.get_object_from_url(widget.options["url"]!"module/object/action")>
${""?left_pad(indent)}<view class="<#if widget.options["width"]??> gx-24-${guidbase.remake_column_width(widget.options["width"])}</#if>">
  <#if widget.options["title"]?? || guidbase.has_toolbar_of_widget(widget)>
  <#-- 有标题的卡片 -->
${""?left_pad(indent)}  <view class="card gx-m-8 gx-p-16" style="background:var(--color-surface-light);border-radius:10px;">
${""?left_pad(indent)}    <view class="card-header gx-d-flex">
${""?left_pad(indent)}      <view class="gx-fb">${widget.options["title"]!""}</view>
    <#if guidbase.has_toolbar_of_widget(widget)>
      <#assign toolbar = guidbase.get_toolbar_of_widget(widget)>
${""?left_pad(indent)}      <view class="gx-d-flex gx-ml-auto" style="align-items:center;">     
      <#list toolbar.widgets as child> 
        <#if child.options["url"]??>
          <#local url = child.options["url"]>
          <#local method = guidbase.url_to_method_name(url)>
${""?left_pad(indent)}        <view bind:tap="${js.nameVariable(method)}" class="gx-fs-11">${child.options["title"]!"未定义"}</view>        
        <#else>
${""?left_pad(indent)}        <view class="gx-fs-11">${child.options["title"]!"未定义"}</view>
        </#if>
      </#list>
${""?left_pad(indent)}      </view>
    </#if>
${""?left_pad(indent)}    </view>
  <#else>
  <#-- 没有标题的卡片 -->
${""?left_pad(indent)}  <view class="card gx-m-8 gx-p-16"> 
  </#if>
${""?left_pad(indent)}    <view widget-id="widget${js.nameType(widget.id)}" class="card-body">
${""?left_pad(indent)}      <gx-list-view id="${js.nameVariable(widget.id)}" local="{{items4${js.nameType(widget.id)}}}" 
${""?left_pad(indent)}              <#if !widget.options["title"]??>height="{{viewHeight}}" </#if>enableLoadMore="true">
  <#list widget.widgets as child>
    <#if child.type != "tile"><#continue></#if>
<@print_wxml_declare_tile_horizontal widget=child loopvar="items4${js.nameType(widget.id)}" indent=indent+8 />
  </#list>
${""?left_pad(indent)}      </gx-list-view>
${""?left_pad(indent)}    </view>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}</view>
</#macro>

<#--
 ###############################################################################
 ### 【栅格列表】
 ###############################################################################
 -->
<#macro print_js_declare_grid_view widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}this.refresh${js.nameType(widget.id)}();
</#macro>

<#macro print_js_fields_grid_view widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}oddItems4${js.nameType(widget.id)}: [],
${""?left_pad(indent)}
${""?left_pad(indent)}evenItems${js.nameType(widget.id)}: [],
${""?left_pad(indent)}
${""?left_pad(indent)}params4${js.nameType(widget.id)}: {
${""?left_pad(indent)}  start: 0,
${""?left_pad(indent)}  limit: 16,
${""?left_pad(indent)}},
</#macro>

<#macro print_js_methods_grid_view widget indent>
<#assign url = widget.options["url"]!"module/object/action">
${""?left_pad(indent)}
${""?left_pad(indent)}/*!
${""?left_pad(indent)}** 加载并渲染加载的【${widget.options["title"]!"未设置"}】数据。
${""?left_pad(indent)}*/
${""?left_pad(indent)}async fetchAndRender${js.nameType(widget.id)}() {
${""?left_pad(indent)}  this.data.params4${js.nameType(widget.id)}.start += this.data.params4${js.nameType(widget.id)}.limit;
${""?left_pad(indent)}  let items = await sdk.fetch${js.nameType(guidbase.pluralize_widget_object(widget))}(this.data.params4${js.nameType(widget.id)});
${""?left_pad(indent)}  let oddItems = this.data.oddItems4${js.nameType(widget.id)};
${""?left_pad(indent)}  let evenItems = this.data.evenItems4${js.nameType(widget.id)};
${""?left_pad(indent)}  for (let i = 0; i < items.length; i++) {
${""?left_pad(indent)}    if (i % 2 == 0) {
${""?left_pad(indent)}      oddItems.push(items[i]);
${""?left_pad(indent)}    } else {
${""?left_pad(indent)}      evenItems.push(items[i]);
${""?left_pad(indent)}    }
${""?left_pad(indent)}  }
${""?left_pad(indent)}  this.setData({
${""?left_pad(indent)}    evenItems4${js.nameType(widget.id)}: evenItems,
${""?left_pad(indent)}    oddItems4${js.nameType(widget.id)}: oddItems,
${""?left_pad(indent)}  });
${""?left_pad(indent)}},
${""?left_pad(indent)}
${""?left_pad(indent)}/*!
${""?left_pad(indent)}** 重新刷新【${widget.options["title"]!"未设置"}】列表。
${""?left_pad(indent)}*/
${""?left_pad(indent)}async refresh${js.nameType(widget.id)}() {
${""?left_pad(indent)}  this.data.params4${js.nameType(widget.id)}.start = 0;
${""?left_pad(indent)}  this.data.oddItems4${js.nameType(widget.id)} = [];
${""?left_pad(indent)}  this.data.evenItems4${js.nameType(widget.id)} = [];
${""?left_pad(indent)}  this.fetchAndRender${js.nameType(widget.id)}();
${""?left_pad(indent)}},
${""?left_pad(indent)}
${""?left_pad(indent)}/*!
${""?left_pad(indent)}** 加载更多【${widget.options["title"]!"未设置"}】列表。
${""?left_pad(indent)}*/
${""?left_pad(indent)}async loadAndRender${js.nameType(widget.id)}() {
${""?left_pad(indent)}  this.data.params4${js.nameType(widget.id)}.start += this.data.params4${js.nameType(widget.id)}.limit;
${""?left_pad(indent)}  this.fetchAndRender${js.nameType(widget.id)}();
${""?left_pad(indent)}},
</#macro>

<#macro print_wxml_declare_grid_view widget indent>
  <#local objname = guidbase.get_object_from_url(widget.options["url"]!"module/object/action")>
${""?left_pad(indent)}<gx-grid-view id="${js.nameVariable(widget.id)}" local="{{oddItems4${js.nameType(widget.id)}}}" height="{{viewHeight-48}}" enableLoadMore="true">
${""?left_pad(indent)}  <view class="gx-row">
${""?left_pad(indent)}    <view class="gx-24-12">
${""?left_pad(indent)}      <view class="gx-b-1 gx-m-8 gx-mr-4" style="padding: 16px 16px;" wx:for="{{oddItems4${js.nameType(widget.id)}}}" wx:key="${js.nameVariable(objname + "_id")}" wx:for-item="item">
<@print_wxml_declare_tile_vertical widget=widget loopvar="oddItems4${js.nameType(widget.id)}" indent=indent+6 />
${""?left_pad(indent)}      </view>
${""?left_pad(indent)}    </view>
${""?left_pad(indent)}    <view class="gx-24-12">
${""?left_pad(indent)}      <view class="gx-b-1 gx-m-8 gx-ml-4" style="padding: 16px 16px;" wx:for="{{evenItems4${js.nameType(widget.id)}}}" wx:key="${js.nameVariable(objname + "_id")}" wx:for-item="item">
<@print_wxml_declare_tile_vertical widget=widget loopvar="evenItems4${js.nameType(widget.id)}" indent=indent+6 />
${""?left_pad(indent)}      </view>
${""?left_pad(indent)}    </view>
${""?left_pad(indent)}  </view>
${""?left_pad(indent)}</gx-grid-view>
</#macro>

<#--
 ###############################################################################
 ### 【时间线条】
 ###############################################################################
 -->
<#macro print_js_declare_timeline widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_js_fields_timeline widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_js_methods_timeline widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_wxml_declare_timeline widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_json_declare_timeline widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#--
 ###############################################################################
 ### 【分页表格】
 ###############################################################################
 -->
<#macro print_js_declare_pagination_table widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_js_fields_pagination_table widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_js_methods_pagination_table widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_wxml_declare_pagination_table widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_json_declare_pagination_table widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#--
 ###############################################################################
 ### 【分页栅格】
 ###############################################################################
 -->
<#macro print_js_declare_pagination_grid widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_js_fields_pagination_grid widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_js_methods_pagination_grid widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_wxml_declare_pagination_grid widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_json_declare_pagination_grid widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#--
 ###############################################################################
 ### 【广义表格】
 ###############################################################################
 -->
<#macro print_js_declare_spreadsheet widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_js_fields_spreadsheet widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_js_methods_spreadsheet widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_wxml_declare_spreadsheet widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_json_declare_spreadsheet widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#--
 ###############################################################################
 ### 【看板列表】
 ###############################################################################
 -->
<#macro print_js_declare_kanban widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_js_fields_kanban widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_js_methods_kanban widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_wxml_declare_kanban widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_json_declare_kanban widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#--
 ###############################################################################
 ### 【聊天列表】
 ###############################################################################
 -->
<#macro print_js_declare_chat widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_js_fields_chat widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_js_methods_chat widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_wxml_declare_chat widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_json_declare_chat widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#--
 ###############################################################################
 ### 【饼状图】
 ###############################################################################
 -->
<#macro print_js_declare_pie_chart widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}wx.createSelectorQuery().in(this)
${""?left_pad(indent)}.select('#${js.nameVariable(widget.id)}')
${""?left_pad(indent)}.fields({ node: true, size: true }).exec(res => {
${""?left_pad(indent)}  let dpr = wx.getSystemInfoSync().pixelRatio;
${""?left_pad(indent)}  this.canvas = res[0].node
${""?left_pad(indent)}  let ctx = this.canvas.getContext('2d');
${""?left_pad(indent)}  this.canvas.width = res[0].width * dpr;
${""?left_pad(indent)}  this.canvas.height = res[0].height * dpr;
${""?left_pad(indent)}  ctx.scale(dpr, dpr);
${""?left_pad(indent)}  ctx.clearRect(0,0,this.canvas.width,this.canvas.height);
${""?left_pad(indent)}  new Charts({
${""?left_pad(indent)}    animation: true,
${""?left_pad(indent)}    type: 'pie',
${""?left_pad(indent)}    series: [{
${""?left_pad(indent)}      name: '成交量1',
${""?left_pad(indent)}      data: 15,
${""?left_pad(indent)}    },{
${""?left_pad(indent)}      name: '成交量2',
${""?left_pad(indent)}      data: 35,
${""?left_pad(indent)}    },{
${""?left_pad(indent)}      name: '成交量3',
${""?left_pad(indent)}      data: 78,
${""?left_pad(indent)}    },{
${""?left_pad(indent)}      name: '成交量4',
${""?left_pad(indent)}      data: 63,
${""?left_pad(indent)}    }],
${""?left_pad(indent)}    context: ctx,
${""?left_pad(indent)}    width: this.data.viewWidth,
${""?left_pad(indent)}    height: 240,
${""?left_pad(indent)}    dataLabel: false,
${""?left_pad(indent)}  });
${""?left_pad(indent)}});
</#macro>

<#macro print_js_fields_pie_chart widget indent>
${""?left_pad(indent)}
</#macro>

<#macro print_js_methods_pie_chart widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_wxml_declare_pie_chart widget indent>
${""?left_pad(indent)}<view style="height:240px;width:100%;">
${""?left_pad(indent)}  <canvas id="${js.nameVariable(widget.id)}" canvas-id="${js.nameVariable(widget.id)}" type="2d"
${""?left_pad(indent)}          style="height:240px;width:100%;" bindtouchstart="doClickItem"></canvas>
${""?left_pad(indent)}</view>
</#macro>

<#--
 ###############################################################################
 ### 【圈状图】
 ###############################################################################
 -->
<#macro print_js_declare_donut_chart widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}wx.createSelectorQuery().in(this)
${""?left_pad(indent)}.select('#${js.nameVariable(widget.id)}')
${""?left_pad(indent)}.fields({ node: true, size: true }).exec(res => {
${""?left_pad(indent)}  let dpr = wx.getSystemInfoSync().pixelRatio;
${""?left_pad(indent)}  this.canvas = res[0].node
${""?left_pad(indent)}  let ctx = this.canvas.getContext('2d');
${""?left_pad(indent)}  this.canvas.width = res[0].width * dpr;
${""?left_pad(indent)}  this.canvas.height = res[0].height * dpr;
${""?left_pad(indent)}  ctx.scale(dpr, dpr);
${""?left_pad(indent)}  ctx.clearRect(0,0,this.canvas.width,this.canvas.height);
${""?left_pad(indent)}  new Charts({
${""?left_pad(indent)}    animation: true,
${""?left_pad(indent)}    type: 'pie',
${""?left_pad(indent)}    series: [{
${""?left_pad(indent)}      name: '成交量1',
${""?left_pad(indent)}      data: 15,
${""?left_pad(indent)}    },{
${""?left_pad(indent)}      name: '成交量2',
${""?left_pad(indent)}      data: 35,
${""?left_pad(indent)}    },{
${""?left_pad(indent)}      name: '成交量3',
${""?left_pad(indent)}      data: 78,
${""?left_pad(indent)}    },{
${""?left_pad(indent)}      name: '成交量4',
${""?left_pad(indent)}      data: 63,
${""?left_pad(indent)}    }],
${""?left_pad(indent)}    context: ctx,
${""?left_pad(indent)}    width: this.data.viewWidth,
${""?left_pad(indent)}    height: 240,
${""?left_pad(indent)}    dataLabel: false,
${""?left_pad(indent)}  });
${""?left_pad(indent)}});
</#macro>

<#macro print_js_fields_donut_chart widget indent>
${""?left_pad(indent)}
</#macro>

<#macro print_js_methods_donut_chart widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_wxml_declare_donut_chart widget indent>
${""?left_pad(indent)}<view style="height:240px;width:100%;">
${""?left_pad(indent)}  <canvas id="${js.nameVariable(widget.id)}" canvas-id="${js.nameVariable(widget.id)}" type="2d"
${""?left_pad(indent)}          style="height:240px;width:100%;" bindtouchstart="doClickItem"></canvas>
${""?left_pad(indent)}</view>
</#macro>

<#--
 ###############################################################################
 ### 【柱状图】
 ###############################################################################
 -->
<#macro print_js_declare_bar_chart widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}wx.createSelectorQuery().in(this)
${""?left_pad(indent)}.select('#${js.nameVariable(widget.id)}')
${""?left_pad(indent)}.fields({ node: true, size: true }).exec(res => {
${""?left_pad(indent)}  let dpr = wx.getSystemInfoSync().pixelRatio;
${""?left_pad(indent)}  this.canvas = res[0].node
${""?left_pad(indent)}  let ctx = this.canvas.getContext('2d');
${""?left_pad(indent)}  this.canvas.width = res[0].width * dpr;
${""?left_pad(indent)}  this.canvas.height = res[0].height * dpr;
${""?left_pad(indent)}  ctx.scale(dpr, dpr);
${""?left_pad(indent)}  ctx.clearRect(0,0,this.canvas.width,this.canvas.height);
${""?left_pad(indent)}  new Charts({
${""?left_pad(indent)}    animation: true,
${""?left_pad(indent)}    type: 'column',
${""?left_pad(indent)}    categories: ['','','',''],
${""?left_pad(indent)}    series: [{
${""?left_pad(indent)}      name: '',
${""?left_pad(indent)}      data: [15, 20, 25, 40],
${""?left_pad(indent)}    }],
${""?left_pad(indent)}    context: ctx,
${""?left_pad(indent)}    width: this.data.viewWidth,
${""?left_pad(indent)}    height: 240,
${""?left_pad(indent)}    dataLabel: false,
${""?left_pad(indent)}  });
${""?left_pad(indent)}});
</#macro>

<#macro print_js_fields_bar_chart widget indent>
${""?left_pad(indent)}
</#macro>

<#macro print_js_methods_bar_chart widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_wxml_declare_bar_chart widget indent>
${""?left_pad(indent)}<view style="height:240px;width:100%;">
${""?left_pad(indent)}  <canvas id="${js.nameVariable(widget.id)}" canvas-id="${js.nameVariable(widget.id)}" type="2d"
${""?left_pad(indent)}          style="height:240px;width:100%;" bindtouchstart="doClickItem"></canvas>
${""?left_pad(indent)}</view>
</#macro>

<#--
 ###############################################################################
 ### 【折线图】
 ###############################################################################
 -->
<#macro print_js_declare_line_chart widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}wx.createSelectorQuery().in(this)
${""?left_pad(indent)}.select('#${js.nameVariable(widget.id)}')
${""?left_pad(indent)}.fields({ node: true, size: true }).exec(res => {
${""?left_pad(indent)}  let dpr = wx.getSystemInfoSync().pixelRatio;
${""?left_pad(indent)}  this.canvas = res[0].node
${""?left_pad(indent)}  let ctx = this.canvas.getContext('2d');
${""?left_pad(indent)}  this.canvas.width = res[0].width * dpr;
${""?left_pad(indent)}  this.canvas.height = res[0].height * dpr;
${""?left_pad(indent)}  ctx.scale(dpr, dpr);
${""?left_pad(indent)}  ctx.clearRect(0,0,this.canvas.width,this.canvas.height);
${""?left_pad(indent)}  new Charts({
${""?left_pad(indent)}    animation: true,
${""?left_pad(indent)}    type: 'line',
${""?left_pad(indent)}    categories: ['','','',''],
${""?left_pad(indent)}    series: [{
${""?left_pad(indent)}      name: '',
${""?left_pad(indent)}      data: [15, 20, 25, 40],
${""?left_pad(indent)}    }],
${""?left_pad(indent)}    context: ctx,
${""?left_pad(indent)}    width: this.data.viewWidth,
${""?left_pad(indent)}    height: 240,
${""?left_pad(indent)}    dataLabel: false,
${""?left_pad(indent)}    dataPointShape: true,
${""?left_pad(indent)}    extra: {
${""?left_pad(indent)}      lineStyle: 'curve'
${""?left_pad(indent)}    },
${""?left_pad(indent)}  });
${""?left_pad(indent)}});
</#macro>

<#macro print_js_fields_line_chart widget indent>
${""?left_pad(indent)}
</#macro>

<#macro print_js_methods_line_chart widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_wxml_declare_line_chart widget indent>
${""?left_pad(indent)}<view style="height:240px;width:100%;">
${""?left_pad(indent)}  <canvas id="${js.nameVariable(widget.id)}" canvas-id="${js.nameVariable(widget.id)}" type="2d"
${""?left_pad(indent)}          style="height:240px;width:100%;" bindtouchstart="doClickItem"></canvas>
${""?left_pad(indent)}</view>
</#macro>

<#--
 ###############################################################################
 ### 【堆栈图】
 ###############################################################################
 -->
<#macro print_js_declare_stack_chart widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_js_fields_stack_chart widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_js_methods_stack_chart widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_wxml_declare_stack_chart widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_json_declare_stack_chart widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#--
 ###############################################################################
 ### 【雷达图】
 ###############################################################################
 -->
<#macro print_js_declare_radar_chart widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_js_fields_radar_chart widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_js_methods_radar_chart widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_wxml_declare_radar_chart widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_json_declare_radar_chart widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#--
 ###############################################################################
 ### 【网络拓扑图】
 ###############################################################################
 -->
<#macro print_js_declare_network_topology_diagram widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_js_fields_network_topology_diagram widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_js_methods_network_topology_diagram widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_wxml_declare_network_topology_diagram widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_json_declare_network_topology_diagram widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#--
 ###############################################################################
 ### 【业务流程图】
 ###############################################################################
 -->
<#macro print_js_declare_business_process_diagram widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_js_fields_business_process_diagram widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_js_methods_business_process_diagram widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_wxml_declare_business_process_diagram widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_json_declare_business_process_diagram widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#--
 ###############################################################################
 ### 【底部弹框】
 ###############################################################################
 -->
<#macro print_js_declare_bottom_sheet widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_js_fields_bottom_sheet widget indent>
${""?left_pad(indent)}
${""?left_pad(indent)}
${""?left_pad(indent)}
</#macro>

<#macro print_js_methods_bottom_sheet widget indent>
${""?left_pad(indent)}    
${""?left_pad(indent)}/*!
${""?left_pad(indent)}** 打开【${widget.options["title"]!"标题"}】底部弹窗。
${""?left_pad(indent)}*/
${""?left_pad(indent)}open${js.nameType(widget.id)}(model) {
${""?left_pad(indent)}  let bs = this.selectComponent('#widget${js.nameType(widget.id)}');
${""?left_pad(indent)}  bs.show();
${""?left_pad(indent)}},
</#macro>

<#macro print_wxml_declare_bottom_sheet widget indent>
${""?left_pad(indent)}<view class="gx-w-full gx-h-full">
  <#list widget.widgets as child>
<@print_wxml_declare_widget widget=child indent=indent+2 />
  </#list>
${""?left_pad(indent)}</view>
</#macro>

