<#--
 ### '/' API调用 do or did
 ### '#' 覆盖页 goto
 ### '%' 侧边页 goto
 ### '$' 正常页 goto
 ### '^' 弹出式（对话框）open
 ### ‘@’ 对页面上的组件
 -->

<#--
 ###
 ###
 ###
 -->
<#function type_widget widget framework>
  <#local widgetsDelphi = {'text':'TEdit', 'button':'TButton', 'form':'TGroupBox'}>
  <#local widgetsFrameworks = {'delphi': widgetsDelphi}>
  <#local ret = widgetsFrameworks[framework][widget.type]!>
  <#return ret>
</#function>

<#function get_tab_order widgetId page>
  <#local ret = 0>
  <#list page.pageWidgets as pageWidget>
    <#if !pageWidget.id??><#continue></#if>
    <#if pageWidget.id == widgetId>
      <#return ret>  
    <#else>
      <#local ret = ret + 1>
    </#if> 
  </#list>
  <#stop '在页面部件中没有找到指定的部件：' + widgetId>
</#function>

<#function name_widget_variable widget>
  <#local id = widget.id>
  <#local id = id?substring(id?index_of('_') + 1)>
  <#return naming.nameVariable(id)>
</#function>

<#--
 ### Gets the widget width.
 ###
 ### @param widget
 ###        the widget defined in guidbase
 ###
 ### @return the widget width
 -->
<#function get_widget_width position>
  <#if (position.size.width <= 0)><#return 12></#if>
  <#return (position.size.width / 100 * 12)?round>
</#function>

<#--
 ### Gets the identifiable in widget.
 ###
 ### @param widget
 ###        the widget defined in guidbase
 ###
 ### @return the child identifiable widget
 -->
<#function get_widget_identifiable widget>
  <#list widget.children![] as child>
    <#if child.role == 'hidden'>
      <#return child>
    </#if>
  </#list>
  <#return {'id': 'TODO'}>
</#function>

<#--
 ###############################################################################
 ### 公共函数
 ###############################################################################
 -->
 
<#function values_to_options_values values>
  <#if values == "[]">
    <#return []>
  </#if>  
  <#local str = values?substring(1,values?length-1)> 
  <#local strs = str?split(",")>
  <#local ret = []>
  <#list strs as s>
    <#local ss = s?split(":")>
    <#local ret += [{"value":ss[0]?trim,"text":ss[1]?trim}]>
  </#list>  
  <#return ret>
</#function>
 
<#function camel_to_snake str sep>
  <#local ret = "">
  <#list 0..str?length-1 as index>
    <#local char = str?substring(index, index+1)>
    <#if char?is_string && char?upper_case != char?lower_case && char == char?upper_case>
      <#local ret = ret + sep + char?lower_case>
    <#else>
      <#local ret = ret + char>
    </#if>
  </#list>
  <#if ret?starts_with(sep)>
    <#assign ret = ret?substring(1)>
  </#if>
  <#return ret>
</#function>
 
<#function has_toolbar_of_widget widget>
  <#list widget.widgets as child>
    <#if child.type?? && child.type == "toolbar">
      <#return true>
    </#if>
  </#list>
  <#return false>
</#function> 

<#function get_toolbar_of_widget widget>
  <#list widget.widgets as child>
    <#if child.type?? && child.type == "toolbar">
      <#return child>
    </#if>
  </#list>
</#function> 

<#function rename_widget_id widget>
  <#if !widget.id??><#return "unknown_id"></#if>
  <#return widget.id?replace("_id", "_name")?replace("_code", "_name")>
</#function>

<#function rename_widget_id widget>
  <#if !widget.id??><#return "unknown_id"></#if>
  <#return widget.id?replace("_id", "_name")?replace("_code", "_name")>
</#function>

<#function remake_column_width width>
  <#if width?length == 1><#return "0" + width></#if>
  <#return width>
</#function>

<#--
 ### Gets the ancestor widget which has id value for the given widget.
 ###
 ### @param parent
 ###        the parent widget
 ### 
 ### @return the parent widget for this widget
 -->
<#function get_widget_ancestor parent>
  <#if !parent??><#return ''></#if>
  <#local id = parent.id!>
  <#if id != ''>
    <#return parent>
  </#if>
  <#return get_widget_ancestor(parent.parent)>
</#function>

<#function url_to_method_name url>
  <#local ret = "">
  <#if url?starts_with("/")>
    <#local ret = ret + "do_">
    <#local atIndex = url?index_of('@')>
    <#local dollarIndex = url?index_of('$')>
    <#local widgetName = "">
    <#if atIndex != -1>
      <#if dollarIndex == -1>
        <#local widgetName = url?substring(atIndex+1)>
      <#else>
        <#local widgetName = url?substring(atIndex+1,dollarIndex)>
      </#if>
      <#local url = url?substring(0, atIndex)>
    </#if>
    <#if url?index_of("?") != -1>
      <#local url = url?substring(0, url?index_of("?"))>
    </#if>
    <#local action = url?substring(url?last_index_of("/")+1)>
    <#if widgetName == "">
      <#local ret += action>
    <#else>
      <#local ret += action + "_" + widgetName>
    </#if>
    <#return ret>
  </#if>
  <#if url?index_of("?") != -1>
    <#local url = url?substring(0, url?index_of("?"))>
  </#if>
  <#if url?starts_with("%") || url?starts_with("#") || url?starts_with("$")>
    <#local ret = ret + "goto_">
    <#local url = url?substring(1)>
  <#elseif url?starts_with("$")>
    <#local ret = ret + "goto_">
    <#local url = url?substring(1)>
    <#if url?index_of(")") != -1>
      <#local url = url?substring(url?index_of(")") + 1)>
    </#if>
  <#elseif url?starts_with("^")>  
    <#local ret = ret + "open_">
    <#local url = url?substring(1)>
  </#if>
  <#local strs = url?split("/")>
  <#if strs?size == 1>
    <#local ret += strs[0]>
    <#return ret>
  </#if>
  <#if (strs?size >= 3)>
    <#list 1..(strs?size-1) as index>
      <#if ret != "goto_" && ret != "do_">
        <#local ret += "_">
      </#if>  
      <#local ret += strs[index]>
    </#list>
    <#return ret>
  </#if>
  <#local ret = ret + strs[strs?size - 1] + "_">
  <#local ret = ret + strs[strs?size - 2]>
  <#return ret>
</#function>

<#function url_to_method_sdk url>
  <#local ret = "">
  <#if url?starts_with("/")>
    <#if url?index_of("?") != -1>
      <#local url = url?substring(0, url?index_of("?"))>
    </#if>
    <#local atIndex = url?index_of('@')>
    <#if atIndex != -1>
      <#local url = url?substring(0, atIndex)>
    </#if>
    <#local dollarIndex = url?index_of('$')>
    <#if dollarIndex != -1>
      <#local url = url?substring(0, dollarIndex)>
    </#if>
    <#local strs = url?split("/")>
    <#return strs[strs?size-1] + "_" + strs[strs?size-2]>
  </#if>
  <#return ret>
</#function>

<#function url_to_page_name url>
  <#local method = url_to_method_name(url)>
  <#return method?replace("goto_", "page_")?replace("do_", "page_")>
</#function>

<#function url_to_api_url url>
  <#if !url?starts_with("/")>
    <#return "">
  </#if>
  <#if url?index_of("?") != -1>
    <#return url?substring(0, url?index_of("?"))>
  </#if>
  <#local atIndex = url?index_of('@')>
  <#if atIndex != -1>
    <#return url?substring(0, atIndex)>
  </#if>
  <#local dollarIndex = url?index_of('$')>
  <#if dollarIndex != -1>
    <#return url?substring(0, dollarIndex)>
  </#if>
  <#return url>
</#function>

<#function url_to_page_path url>
  <#if url?starts_with("/")>
    <#if url?index_of("$") == -1>
      <#return "">
    </#if>
    <#return url?substring(url?index_of("$")+1)>
  </#if>
  <#if url?index_of("?") != -1>
    <#local url = url?substring(0, url?index_of("?"))>
  </#if>
  <#if url?starts_with("%") || url?starts_with("#") || url?starts_with("^")>
    <#return url?substring(1)>
  <#elseif url?starts_with("$")>
    <#if url?index_of(")") != -1>
      <#return url?substring(url?index_of(")") + 1)>
    <#else>  
      <#return url?substring(1)>
    </#if>
  </#if>  
  <#return url>
</#function>

<#function url_to_container url>
  <#if !url?starts_with("$")><#return "unknown"></#if>
  <#if url?index_of("(") != -1 && (url?index_of(")") > url?index_of("("))>
    <#return url?substring(url?index_of("(") + 1, url?index_of(")"))>
  </#if>
  <#return "unknown">
</#function>

<#function page_id_to_page_name pageId>
  <#local strs = pageId?split("/")>
  <#if (strs?size >= 3)>
    <#local ret = "">
    <#list 1..(strs?size-1) as index>
      <#if ret != "">
        <#local ret += "_">
      </#if>  
      <#local ret += strs[index]>
    </#list>
    <#return ret>
  </#if>
  <#return pageId>
</#function>

<#function page_id_to_module pageId>
  <#local strs = pageId?split("/")>
  <#if (strs?size >= 3)>
    <#return strs[0]>
  </#if>
  <#return "">
</#function>


<#-- 
 ### 处理url表达式
 -->
<#function get_uri_from_url url>
  <#if url?starts_with("%") || url?starts_with("#") || url?starts_with("$")  || url?starts_with("^") || url?starts_with("@")>
    <#local url = url?substring(1)>
  </#if>
  <#local indexOfParams = url?index_of("?")>
  <#local ret = []>
  <#if indexOfParams == -1>
    <#return url?substring(0)>
  </#if>
  <#return url?substring(0, indexOfParams)>
</#function>

<#function get_object_from_url url>
  <#if url?starts_with("%") || url?starts_with("#") || url?starts_with("$") || url?starts_with("^") || url?starts_with("@")>
    <#local url = url?substring(1)>
  </#if>
  <#local strs = url?split("/")>
  <#return strs[strs?size - 2]>
</#function>

<#-- 
 ### 处理object表达式
 -->
<#function get_module_from_object object>
  <#local strs = object?split("/")>
  <#if strs?size == 1>
    <#return "module">
  </#if>
  <#return strs[strs?size - 2]>
</#function>

<#function get_app_from_object object>
  <#local strs = object?split("/")>
  <#if (strs?size <= 2)>
    <#return "stdbiz">
  </#if>
  <#return strs[strs?size - 3]>
</#function>

<#function get_object_from_object object>
  <#local strs = object?split("/")>
  <#return strs[strs?size - 1]>
</#function>

<#function get_params_from_url url>
  <#local indexOfParams = url?index_of("?")>
  <#local ret = []>
  <#if indexOfParams == -1>
    <#return ret>
  </#if>
  <#local strParams = url?substring(indexOfParams + 1)>
  <#local params = strParams?split("&")>
  <#list params as param>
    <#local strs = param?split("=")>
    <#if strs?size == 1>
      <#local ret = ret + [{"name": strs[0]}]>
    <#else>
      <#local ret = ret + [{"name": strs[0], "value": strs[1]}]>
    </#if>
  </#list>
  <#return ret>
</#function>

<#function get_url_from_tile widget>
  <#if widget.options["url"]??>
    <#return widget.options["url"]>
  </#if>
  <#list widget.widgets as child>
    <#if child.options["url"]??>
      <#return child.options["url"]>
    </#if>
  </#list>
  <#return "">
</#function> 

<#function get_child_from_tile widget level>
  <#list widget.widgets as child>
    <#if (child.options["level"]!"") == level>
      <#return child>
    </#if>
  </#list>
</#function> 

<#function estimate_height_of_tile widget>
  <#local ret = 76>
  <#if get_child_from_tile(widget, "secondary")??>
    <#local ret = 76>
  </#if>
  <#if get_child_from_tile(widget, "image")??>
    <#local ret = 64>
  </#if>
  <#if get_child_from_tile(widget, "avatar")??>
    <#local ret = 72>
  </#if>
  <#if get_child_from_tile(widget, "tertiary")??>
    <#local ret = 78>
  </#if>
  <#-- TODO -->
  <#return ret>
</#function>

<#function get_clickable_from_tile widget>
  <#if widget.options["url"]??>
    <#return widget>
  </#if>
  <#list widget.widgets as child>
    <#if child.options["url"]??>
      <#return child>
    </#if>
  </#list>
</#function>

<#function state_params_in_url params>
  <#local ret = "?">
  <#list params as param>
    <#if ret != "?">
      <#local ret += "&">
    </#if>
    <#local ret += param.name>
    <#if param.value??>
      <#local ret += "=" + param.value>
    </#if>
  </#list>
  <#if ret == "?">
    <#return "">
  </#if>
  <#return ret>  
</#function>

<#function state_params_with_values_in_url params holder>
  <#local ret = "?">
  <#list params as param>
    <#if ret != "?">
      <#local ret += "&">
    </#if>
    <#local ret += param.name + "=${" + holder + "." + param.name + "}">
  </#list>
  <#if ret == "?">
    <#return "">
  </#if>
  <#return ret>  
</#function>

<#function pluralize_widget_object widget>
  <#local plural = widget.options["plural"]!"">
  <#local url = widget.options["url"]!"module/object/action">
  <#local objname = get_object_from_url(url)>
  <#if objname == "object" && widget.options["object"]??>
    <#local objname = widget.options["object"]>
  </#if>
  <#if plural == "">
    <#return objname + "s">
  </#if>
  <#return plural>
</#function>

<#function pluralize_object objname>
  <#return inflector.pluralize(objname)>
</#function>

<#-- 
 ### Gets object name defined in widget options.
 -->
<#function get_widget_object widget>
  <#local url = widget.options["url"]!"module/object/action">
  <#local objname = get_object_from_url(url)>
  <#if widget.options["object"]??>
    <#return widget.options["object"]>
  </#if>
  <#return objname>
</#function>

<#function get_widget_id_attribute widget>
  <#local url = widget.options["url"]!"module/object/action">
  <#local objname = get_object_from_url(url)>
  <#if widget.options["object"]??>
    <#return widget.options["object"] + "_id">
  </#if>
  <#return objname + "_id">
</#function>

<#-- 
 ### Gets all navigable pages defined in application, and the navigable 
 ### page is relative with bottom tab bar item.
 -->
<#function get_navigable_pages app>
  <#local navs = {}>
  <#list app.pages as page>
    <#if page.options["navigable"]?? && page.options["navigable"] == "true">
      <#local index = page.options["index"]!"9999">
      <#local navs += {index:page}>
    </#if>
  </#list>
  <#local ret = []>
  <#list navs?keys?sort as index>
    <#local ret += [navs[index]]>
  </#list>
  <#return ret>
</#function>

<#-- 
 ### Gets frontend model objects defined from guidbase files.
 ###
 ### @IMPORTANT
 -->
<#function get_frontend_model app>
  <#local existings = {}>
  <#list app.pages as page>
    <#list page.pageWidgets as widget>
      <#if !widget.options["url"]?? && widget.options["url"]?index_of("/") != 0><#continue></#if>
      <#local url = widget.options["url"]>
      <#local objname = guidbase.get_object_from_url(url)>
    </#list>
  </#list>
  <#local ret = []>

  <#return ret>
</#function>