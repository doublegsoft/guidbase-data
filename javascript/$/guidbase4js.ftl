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

<#--
 ###############################################################################
 ### 获取 URL 参数值 - 根据参数类型（urlParam.type）格式化并返回对应的 JS 值或变量
 ### 
 ### 逻辑与映射关系说明：
 ### 1. 当存在参数值 (urlParam.value) 时：
 ###    - 'VARIABLE' => 转换为安全 JS 变量名：js.nameVariable(value)
 ###    - 'STRING'   => 转换为带单引号的字符串：'value'
 ###    - 'NUMBER'   => 直接返回数值
 ### 
 ### 2. 当无参数值或不满足上述条件时（默认兜底）：
 ###    - 使用参数名 (urlParam.name) 转换为安全 JS 变量名：js.nameVariable(name)
 ###############################################################################
 -->
<#function get_param_value urlParam>
  <#if urlParam.value??>
    <#if urlParam.type?string == "VARIABLE">
      <#return js.nameVariable(urlParam.value)>
    <#elseif urlParam.type?string == "STRING">
      <#return "'" + urlParam.value + "'">
    <#elseif urlParam.type?string == "NUMBER">
      <#return urlParam.value>
    </#if>
  </#if>
  <#return js.nameVariable(urlParam.name)>
</#function>