@import '/app.wxss';

<#assign imported = {}>  
<#list pagedef.widgets as widget>    
  <#if !widget.type??><#continue></#if>
  <#if widget.type == "toolbar">  
  <#elseif widget.type == "editable_form" && !imported["gx-two-column-form"]??>  
    <#assign imported = imported + {"gx-two-column-form":widget}>
  <#elseif widget.type == "readonly_form" && !imported["gx-two-column-form"]??>  
    <#assign imported = imported + {"gx-two-column-form":widget}>
.input-group {
  border-bottom: none!important;
  height: 64rpx;
}

.field {
  margin-top: 0!important;
  margin-bottom: 0!important;
}    
  <#elseif widget.type == "tabs" && !imported["gx-tabs"]??>  
    <#assign imported = imported + {"gx-tabs":widget}>
  <#elseif widget.type == "scroll_notification">  
  <#elseif widget.type == "swiper_navigator">  
  <#elseif widget.type == "scroll_navigator">  
  <#elseif widget.type == "list_navigator">  
  <#elseif widget.type == "grid_navigator">  
.buttons {
  padding: 16px;
  display: flex;
  flex-wrap: wrap;
  width: calc(100% - 32px);
  gap: 16px;
}

.button {
  flex: 1 1 1;
  display: flex;
  justify-content: center;
  align-items: center;
  border: 2px solid var(--color-primary);
  color: var(--color-primary);
  font-size: 24px;
  border-radius: 8px;
}
  <#elseif widget.type == "calendar">  
  <#elseif widget.type == "tree">  
  <#elseif widget.type == "list_view" && !imported["gx-list-view"]??>  
    <#assign imported = imported + {"gx-list-view":widget}>
  <#elseif widget.type == "grid_view" && !imported["gx-grid-view"]??>  
    <#assign imported = imported + {"gx-grid-view":widget}>
  <#elseif widget.type == "timeline">  
  <#elseif widget.type == "pagination_table">  
  <#elseif widget.type == "pagination_grid">  
  <#elseif widget.type == "spreadsheet">  
  <#elseif widget.type == "kanban">  
  <#elseif widget.type == "chat">  
  <#elseif widget.type == "pie_chart" && !imported["ec-canvas"]??>  
  <#elseif widget.type == "donut_chart" && !imported["ec-canvas"]??>  
  <#elseif widget.type == "bar_chart" && !imported["ec-canvas"]??>  
  <#elseif widget.type == "line_chart" && !imported["ec-canvas"]??>  
  <#elseif widget.type == "stack_chart" && !imported["ec-canvas"]??>  
  <#elseif widget.type == "radar_chart" && !imported["ec-canvas"]??>  
  <#elseif widget.type == "network_topology_diagram">  
  <#elseif widget.type == "business_process_diagram">  
  </#if>    
</#list>