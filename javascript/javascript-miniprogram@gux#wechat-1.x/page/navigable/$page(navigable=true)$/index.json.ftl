{
  "navigationBarTitleText": "${page.title!'页面标题'}",
  "usingComponents": {
<#assign imported = {}>  
<#list pagedef.pageWidgets as widget>    
  <#if !widget.type??><#continue></#if>
  <#if widget.type == "navigation_bar">  
  <#elseif widget.type == "toolbar">  
  <#elseif widget.type == "editable_form" && !imported["gx-two-column-form"]??>  
    <#assign imported = imported + {"gx-two-column-form":widget}>
    <#assign imported = imported + {"gx-single-column-form":widget}>
    "gx-two-column-form":"/vendor/gux/widget/gx-two-column-form",
    "gx-single-column-form":"/vendor/gux/widget/gx-single-column-form",
  <#elseif widget.type == "readonly_form" && !imported["gx-two-column-form"]??>  
    <#assign imported = imported + {"gx-two-column-form":widget}>
    <#assign imported = imported + {"gx-single-column-form":widget}>
  <#elseif widget.type == "tabs" && !imported["gx-tabs"]??>  
    <#assign imported = imported + {"gx-tabs":widget}>
    "gx-tabs": "/vendor/gux/widget/gx-tabs/index",
  <#elseif widget.type == "scroll_notification">  
  <#elseif widget.type == "swiper_navigator">  
  <#elseif widget.type == "scroll_navigator">  
  <#elseif widget.type == "list_navigator">  
  <#elseif widget.type == "grid_navigator">  
  <#elseif widget.type == "calendar">  
    "gx-calendar":"/vendor/gux/widget/gx-calendar",
  <#elseif widget.type == "tree">  
  <#elseif widget.type == "list_view" && !imported["gx-list-view"]??>  
    <#assign imported = imported + {"gx-list-view":widget}>
    "gx-list-view": "/vendor/gux/widget/gx-list-view/index",
  <#elseif widget.type == "grid_view" && !imported["gx-grid-view"]??>  
    <#assign imported = imported + {"gx-grid-view":widget}>
    "gx-grid-view": "/vendor/gux/widget/gx-grid-view/index",
  <#elseif widget.type == "timeline">  
  <#elseif widget.type == "pagination_table">  
  <#elseif widget.type == "pagination_grid">  
  <#elseif widget.type == "spreadsheet">  
  <#elseif widget.type == "kanban">  
  <#elseif widget.type == "chat">  
  <#elseif widget.type == "network_topology_diagram">  
  <#elseif widget.type == "business_process_diagram">  
  <#elseif widget.type == "bottom_sheet" && !imported["gx-bottom-sheet"]??>
    <#assign imported = imported + {"gx-bottom-sheet":widget}>
    "gx-bottom-sheet": "/vendor/gux/widget/gx-bottom-sheet/index",
  </#if>    
</#list>
    "gx-navigation-bar": "/vendor/gux/widget/gx-navigation-bar/index"
  }
}