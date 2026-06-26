<#--
 ###############################################################################
 ### 获取属性默认值 - 根据 widget.type 匹配对应的基础默认值
 ### 
 ### 映射关系说明：
 ### - 'text'                                             => 字符串空值 "''"
 ### - 'number'                                           => 空值 "null"
 ### - 'bool'                                             => 布尔假值 "false"
 ### - 'multiselect', 'tags', 'files', 'images', 'videos' => 空数组 "[]"
 ### - 其他未匹配类型                                       => 默认返回 "''"
 ###############################################################################
 -->
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