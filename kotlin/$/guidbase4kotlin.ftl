<#--
 ###############################################################################
 ### 获取 Kotlin 属性类型 - 根据 input.type 匹配对应的 Kotlin 语言基础或集合类型
 ### 
 ### 映射关系说明：
 ### - 'text', 'longtext'                                 => Kotlin 类型 "String"
 ### - 'number'                                           => Kotlin 类型 "Int"
 ### - 'bool'                                             => Kotlin 类型 "Boolean"
 ### - 'select'                                           => Kotlin 类型 "String"
 ### - 'image', 'avatar'                                  => Kotlin 类型 "String"
 ### - 'date', 'time', 'datetime'                         => Kotlin 类型 "Date"
 ### - 'multiselect', 'tags', 'files', 'images', 'videos',
 ###   'cascade'                                          => Kotlin 集合 "List<String>"
 ### - 其他未匹配类型                                       => 默认返回 "String"
 ###############################################################################
 -->
<#function type_input_primitive input>
  <#if input.type == "text" || input.type == "longtext">
    <#return "String">
  <#elseif input.type == "number">
    <#return "BigDecimal">
  <#elseif input.type == "int" || input.type == "integer">
    <#return "Int">
  <#elseif input.type == "float" || input.type == "double">
    <#return "Double">
  <#elseif input.type == "long">
    <#return "Long">
  <#elseif input.type == "bool">
    <#return "Boolean">
  <#elseif input.type == "select">
    <#return "Option">
  <#elseif input.type == "image" || input.type == "avatar">
    <#return "String">  
  <#elseif input.type == "date" || input.type == "time" || input.type == "datetime">
    <#return "Date">
  <#elseif input.type == "multiselect" || input.type == "files" || 
           input.type == "images" || input.type == "videos" || input.type == "cascade">
    <#return "List<Option>">
  <#elseif input.type == "tags">
    <#return "List<String>">
  <#else>
    <#return "String">
  </#if>
</#function>

<#function get_primitive_default_value input>
  <#if input.type == 'text'>
    <#return "\"\"">
  <#elseif input.type == 'number'>
    <#return "null">
  <#elseif input.type == 'date' || input.type == 'time' || input.type == 'datetime'>
    <#return "null">
  <#elseif input.type == 'bool'>
    <#return "false">
  <#elseif input.type == 'select'>
    <#return "null">  
  <#elseif input.type == 'multiselect' || input.type == 'tags' || input.type == 'files' || 
           input.type == 'images' || input.type == 'videos' || input.type == 'cascade'>
    <#return "emptyList()">  
  <#else>
    <#return "\"\"">
  </#if>
</#function>  