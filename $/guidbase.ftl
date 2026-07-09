<#--
 ### '/' API调用 do or did
 ### '#' 覆盖页 goto
 ### '%' 侧边页 goto
 ### '$' 正常页 goto
 ### '^' 弹出式（对话框）open
 ### ‘@’ 对页面上的组件
 -->

<#--
 ###############################################################################
 ### 获取受参数影响的响应式组件 (Get Reactive Widgets For Param)
 ### 
 ### 该方法用于筛查指定页面中，其数据源 URL 包含特定查询变量（参数）的组件集合。
 ### 当这些参数发生变化时，相关的组件通常需要重新加载数据。
 ### 
 ### @param variable  待检测的依赖参数变量名称 (String)
 ### @param page      当前页面对象，用于获取下属 widgets 集合 (Object)
 ### @return          与该参数存在响应式数据依赖的组件数组 (Sequence)
 ###############################################################################
 -->
<#function get_reactive_widgets variable page>
  <#local retVal = []>
  <#list page.widgets as widget>
    <#if widget.value("data") == ""><#continue></#if>
    <#local url = valuebase.url(widget.value("data"))>
    <#if url.containVariable(variable)>
      <#local retVal += [widget]>
    </#if>
  </#list>
  <#return retVal>
</#function>

<#--
 ###############################################################################
 ### 生成组件数据加载方法名 (Generate Widget Load Method Name)
 ### 
 ### 根据组件类型（widget.type）和唯一标识（widget.id），生成符合命名规范的
 ### 后端/前端数据加载或初始化方法名称。
 ### 
 ### 命名后缀规则：
 ### - 列表/网格/表格类组件 => "load[WidgetId]Rows" （多行数据）
 ### - 基础/展示表单类组件   => "load[WidgetId]Data" （单条数据对象）
 ### - 日历日程类组件       => "load[WidgetId]Cells"（网格/单元格数据）
 ### - 数据图表类组件       => "load[WidgetId]Conf" （配置与报表数据）
 ### 
 ### @param widget  目标组件对象 (Object)
 ### @return       对应的数据加载方法名，不匹配已知类型时返回空字符串 (String)
 ###############################################################################
 -->
<#function name_widget_method_load widget>
  <#if widget.type == "list_view">
    <#return naming.nameVariable("load_" + widget.id + "_rows")>; 
  <#elseif widget.type == "split_list">
    <#return naming.nameVariable("load_" + widget.id + "_groups")>; 
  <#elseif widget.type == "paged_table">
    <#return naming.nameVariable("load_" + widget.id + "_rows")>; 
  <#elseif widget.type == "paged_grid">
    <#return naming.nameVariable("load_" + widget.id + "_rows")>;      
  <#elseif widget.type == "excel_form">
    <#return naming.nameVariable("load_" + widget.id + "_rows")>; 
  <#elseif widget.type == "entry_form">
    <#return naming.nameVariable("load_" + widget.id + "_data")>; 
  <#elseif widget.type == "display_form">
    <#return naming.nameVariable("load_" + widget.id + "_data")>;  
  <#elseif widget.type == "official_form">
    <#return naming.nameVariable("load_" + widget.id + "_data")>; 
  <#elseif widget.type == "calendar">
    <#return naming.nameVariable("load_" + widget.id + "_cells")>;  
  <#elseif widget.type == "chart">
    <#return naming.nameVariable("load_" + widget.id + "_conf")>; 
  </#if>
  <#return "">
</#function>

<#--
 ###############################################################################
 ### 生成按钮事件方法名称 (Generate Button Method Name)
 ### 
 ### 根据按钮对象的 ID，生成对应的事件处理方法（Handler）名称。
 ### 通常用于前端代码生成中，动态绑定按钮的点击或其他事件监听函数。
 ### 
 ### 命名生成规则：
 ### - 拼接固定前缀 "handle" 字符。
 ### - 结合 js.nameType 将按钮 ID 转换为符合规范的类型名称格式（如首字母大写）。
 ### - 示例：若按钮 ID 为 "submit_form"，生成的名称通常为 "handleSubmitForm"。
 ### 
 ### @param button  目标按钮对象 (Object)
 ### @return       生成的事件处理方法名称 (String)
 ###############################################################################
 -->
<#function name_button_method button>
  <#local ret = "handle">
  <#local action = valuebase.action(button.value("action"))>
  <#return "handle" + js.nameType(button.id)>
</#function>

<#--
 ###############################################################################
 ### 获取输入项变量名称 (Get Input Variable Name)
 ### 
 ### 根据输入项（input）及其容器（container）的类型，生成对应的前端变量访问路径。
 ### 用于在前端代码中区分和绑定查询条件输入项与常规数据输入项的变量。
 ### 
 ### 容器类型与命名规则：
 ### - 容器类型为 "criteria_form" => "[containerId]Crit.[inputId]" （查询条件变量）
 ### - 其他容器类型              => "[containerId]Data.[inputId]" （常规数据变量）
 ### 
 ### @param input  目标输入项对象 (Object)
 ### @return       生成的变量路径名称 (String)
 ###############################################################################
 -->
<#function name_input_variable input>
  <#if input.container.type == "criteria_form">
    <#return js.nameVariable(input.container.id) + "Crit." + js.nameVariable(input.id)>
  <#else>
    <#return js.nameVariable(input.container.id) + "Data." + js.nameVariable(input.id)>
  </#if>
</#function>

<#--
 ###############################################################################
 ### 获取按钮样式变体 (Get Button Style Variant)
 ### 
 ### 根据按钮对象中的动作类型（action），返回对应的 UI 样式变体名称。
 ### 用于动态绑定前端组件的颜色和视觉风格。
 ### 
 ### 动作与样式映射规则：
 ### - "reset"  => "warning" （警告/重置操作）
 ### - "save"   => "primary" （主色/保存操作）
 ### - "search" => "success" （成功/查询操作）
 ### - "edit"   => "success" （成功/编辑操作）
 ### - "remove" => "danger"  （危险/删除操作）
 ### - 其他动作 => "default" （默认基础样式）
 ### 
 ### @param button  目标按钮对象 (Object)
 ### @return       对应的样式变体名称 (String)
 ###############################################################################
 -->
<#function get_button_variant button>
  <#local action = valuebase.action(button.value("action"))>
  <#if action.method??>
    <#local method = action.method>
    <#if method == "reset" || method == "clear">
      <#return "warning">
    <#elseif method == "save">
      <#return "primary">
    <#elseif method == "search">
      <#return "primary">  
    <#elseif method == "edit">
      <#return "primary">
    <#elseif method == "open">
      <#return "success">  
    <#elseif method == "remove" || method == "delete">
      <#return "danger">
    <#elseif method == "close" || method == "cancel">
      <#return "warning">      
    </#if>
  <#elseif action.type.name() == "DRAWER">
    <#return "success">
  <#elseif action.type.name() == "DIALOG">
    <#return "primary">
  <#elseif action.type.name() == "OVERLAY">
    <#return "primary">    
  <#elseif action.type.name() == "GOTO">
    <#return "default">  
  </#if>
  <#return "default">  
</#function>

<#--
 ###############################################################################
 ### 获取动作关联的组件 (Get Action Widget)
 ### 
 ### 根据按钮对象中的动作（action），获取并返回对应的页面组件（Widget）。
 ### 用于动态定位和操作与该按钮绑定的 UI 元素。
 ### 
 ### 查找与定位规则：
 ### - 优先从按钮中解析出 action 对象。
 ### - 若 action 存在 "resource" 属性，则优先通过该资源 ID 查找并返回组件。
 ### - 若无 "resource" 属性，则退而使用 "path" 属性的值进行组件查找与返回。
 ### 
 ### @param button  目标按钮对象 (Object)
 ### @return       对应的页面组件对象 (Widget Object)
 ###############################################################################
 -->
<#function get_action_widget button>
  <#local action = valuebase.action(button.value("action"))>
  <#if action.resource??>
    <#return button.page.byId(action.resource)>
  <#else>
    <#return button.page.byId(action.path)>
  </#if>
</#function>

<#--
 ###############################################################################
 ### 获取页面参数 (Get Page Parameters)
 ### 
 ### 根据页面对象中的 "params" 属性，解析并返回一个清洗后的参数列表。
 ### 用于动态提取、分割和净化页面绑定的配置参数。
 ### 
 ### 查找与定位规则：
 ### - 从页面对象中获取 "params" 属性的值。
 ### - 若 "params" 为空字符串，直接返回空列表。
 ### - 若 "params" 不为空，则以逗号 (",") 为分隔符进行拆分，并去除每个参数的前后空格。
 ### 
 ### @param page  页面对象 (Object)
 ### @return      格式化后的参数列表 (List of Strings)
 ###############################################################################
 -->
<#function get_page_params page>
  <#local ret = []>
  <#if page.value("params") == "">
    <#return ret>
  </#if>
  <#local params = page.value("params")?split(",")>
  <#list params as param>
    <#local ret += [param?trim]>
  </#list>
  <#return ret>
</#function>

<#--
 ###############################################################################
 ### 判断是否包含加载更多 (Check If Page Has Load More)
 ### 
 ### 根据页面对象中的 "containers" 和 "children" 属性，判断该页面是否支持加载更多功能。
 ### 主要用于检测页面底部是否为可滚动的列表或网格视图。
 ### 
 ### 查找与定位规则：
 ### - 检查页面的容器数量，若 "containers" 数量大于 1，则直接返回 false。
 ### - 获取页面的最后一个子元素 ("children" 列表中的最后一项)。
 ### - 若最后一个子元素的类型 ("type") 为 "list_view" 或 "grid_view"，则返回 true，否则返回 false。
 ### 
 ### @param page  页面对象 (Object)
 ### @return      是否支持加载更多 (Boolean)
 ###############################################################################
 -->
<#function has_loading_more page>
  <#if (page.containers?size > 1)>
    <#return false>
  </#if>
  <#local lastChild = page.children[page.children?size - 1]>
  <#if lastChild.type == "list_view" || lastChild.type == "grid_view">
    <#return true>
  </#if>
  <#return false>
</#function>

<#--
 ###############################################################################
 ### 获取页面关联资源对象 (Get Page Resource Object)
 ### 
 ### 遍历页面中的组件列表，获取首个包含有效数据（"data"）的组件所关联的资源。
 ### 
 ### 查找与定位规则：
 ### - 依次遍历页面对象（page）中的组件列表（widgets）。
 ### - 检查每个组件的 "data" 属性，如果该属性值为空，则跳过当前组件。
 ### - 遇到首个包含非空 "data" 属性的组件时，解析该数据的 URL 并返回对应的资源（resource）。
 ### 
 ### @param page  页面对象 (Object)
 ### @return      解析后的资源对象或路径，若未找到有效数据则返回空 (Resource Object / Null)
 ###############################################################################
 -->
<#function get_page_object page>
  <#list page.widgets as widget>
    <#if widget.value("data") == ""><#continue></#if>
    <#return valuebase.url(widget.value("data")).resource>
  </#list>
</#function>

<#--
 ###############################################################################
 ### 获取加载更多组件 (Get Load More Widget)
 ### 
 ### 遍历页面中的组件，寻找第一个类型为列表视图（list_view）或分页网格（paged_grid）
 ### 且包含有效数据的组件对象。
 ### 
 ### 查找与定位规则：
 ### - 依次遍历页面对象（page）中的组件列表（widgets）。
 ### - 检查组件的 "data" 属性，若值为空字符串则忽略并继续。
 ### - 评估组件的类型（type），若为 "list_view" 或 "paged_grid"，则返回该组件。
 ### 
 ### @param page  页面对象 (Object)
 ### @return      符合条件的加载更多组件对象，若未找到则无返回值 (Widget Object / Null)
 ###############################################################################
 -->
<#function get_loading_more_widget page>
  <#list page.widgets as widget>
    <#if widget.value("data") == ""><#continue></#if>
    <#if widget.type == "list_view" || widget.type == "paged_grid">
      <#return widget>
    </#if>
  </#list>
</#function>

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

<#function get_child_from_tile widget prop>
  <#list widget.children as child>
    <#if (child.options["property"]!"") == prop>
      <#return child>
    </#if>
  </#list>
</#function>

<#function has_child_widget widget prop>
  <#list widget.children as child>
    <#if (child.options["property"]!"") == prop>
      <#return true>
    </#if>
  </#list>
  <#return false>
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