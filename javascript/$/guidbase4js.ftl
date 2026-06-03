
<#function get_primitive_default_value widget>
  <#if widget.type == 'text'>
    <#return "''">
  <#elseif widget.type == 'number'>
    <#return "null">
  <#elseif widget.type == 'bool'>
    <#return "false">
  <#else>
    <#return "''">
  </#if>
</#function>  