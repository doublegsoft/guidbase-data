
<#function get_primitive_default_value widget>
  <#if widget.type == 'text'>
    <#return "''">
  <#elseif widget.type == 'number'>
    <#return "null">
  <#elseif widget.type == 'bool'>
    <#return "false">
  <#elseif widget.type == 'multiselect' || widget.type == 'tags' || widget.type == 'files' || 
           widget.type == 'images' || widget.type == 'videos'>
    <#return "[]">  
  <#else>
    <#return "''">
  </#if>
</#function>  