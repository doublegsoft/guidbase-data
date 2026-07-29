<#--
 ###############################################################################
 ### 将属性类型转换为 TypeScript 原始类型 (Map Attribute Type to TypeScript Primitive)
 ### 
 ### @param attr  属性对象，必须包含 type 属性 (例如 "varchar", "int", "datetime")
 ### @return      TypeScript 对应的类型字符串 (如 "string", "number", "boolean", "any")
 ###############################################################################
 -->
<#function type_attribute_primitive attr>
  <#local type = (attr.type.name!"any")?lower_case>
  <#if type == "string" || type == "varchar" || type == "char" || type == "text" || type == "clob">
    <#return "string">
  <#elseif type == "int" || type == "integer" || type == "long" || type == "short" || 
           type == "double" || type == "float" || type == "decimal" || type == "number" || type == "numeric">
    <#return "number">
  <#elseif type == "boolean" || type == "bool" || type == "bit">
    <#return "boolean">
  <#elseif type == "date" || type == "datetime" || type == "timestamp" || type == "time">
    <#return "string"> 
  <#elseif attr.type.custom>
    <#return "number">
  <#else>
    <#return "string">
  </#if>
</#function>

<#--
 ###############################################################################
 ### 获取并格式化属性测试值 (Get and Format Attribute Test Value)
 ### 
 ### 根据属性的 TypeScript 类型，将测试值格式化为符合语法规范的字面量。
 ### 
 ### 格式化与包装规则：
 ### - 首先通过 tatabase.value 获取属性的原始测试值，并获取其 TypeScript 原始类型。
 ### - 若类型为数值 (number) 或布尔值 (boolean)，则直接返回原始值（不带引号）。
 ### - 若为其它类型（如 string），则使用单引号将值进行包裹后返回（例如：'value'）。
 ### 
 ### @param attr  属性对象 (Attribute Object)
 ### @return      格式化后的测试字面量字符串 (Formatted Test Value String)
 ###############################################################################
 -->
<#function value_attribute_test attr>
  <#local value = tatabase.value(attr)>
  <#local type = type_attribute_primitive(attr)>
  <#if attr.type.custom>
    <#return tatabase.number(1, 100, 0)>
  <#elseif type == "number" || type == "boolean">
    <#return value>
  <#else>
    <#return "'" + value + "'">
  </#if>
</#function>