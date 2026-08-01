<#--
 ###############################################################################
 ### 将属性类型转换为 Swift 原始类型 (Map Attribute Type to Swift Primitive)
 ### 
 ### @param attr  属性对象，必须包含 type 属性 (例如 "varchar", "int", "datetime")
 ### @return      Swift 对应的类型字符串 (如 "String", "Int", "Double", "Bool", "Date")
 ###############################################################################
 -->
<#function type_attribute_primitive attr>
  <#local type = (attr.type.name!"any")?lower_case>
  <#if type == "string" || type == "varchar" || type == "char" || type == "text" || type == "clob">
    <#return "String">
  <#elseif type == "int" || type == "integer" || type == "long" || type == "short">
    <#return "Int">
  <#elseif type == "double" || type == "float" || type == "decimal" || type == "number" || type == "numeric">
    <#return "Double">
  <#elseif type == "boolean" || type == "bool" || type == "bit">
    <#return "Bool">
  <#elseif type == "date" || type == "datetime" || type == "timestamp" || type == "time">
    <#return "Date"> <#-- 亦可根据项目需求返回 "String" -->
  <#elseif attr.type.custom>
    <#return "Int"> <#-- 对应原逻辑中的自定义类型默认数值 -->
  <#else>
    <#return "String">
  </#if>
</#function>

<#--
 ###############################################################################
 ### 获取并格式化属性测试值 (Get and Format Attribute Test Value for Swift)
 ### 
 ### @param attr  属性对象 (Attribute Object)
 ### @return      格式化后的 Swift 测试字面量字符串
 ###############################################################################
 -->
<#function value_attribute_test attr>
  <#local value = tatabase.value(attr)>
  <#local type = type_attribute_primitive(attr)>
  <#if attr.type.custom>
    <#return tatabase.number(1, 100, 0)>
  <#elseif type == "Int" || type == "Double" || type == "Bool">
    <#return value>
  <#elseif type == "Date">
    <#return "Date()">
  <#else>
    <#-- Swift 的字符串字面量必须使用双引号 "\" 进行包装 -->
    <#return "\"" + value + "\"">
  </#if>
</#function>