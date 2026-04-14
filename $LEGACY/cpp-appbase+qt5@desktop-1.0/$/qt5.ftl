<#function type_name type>
  <#if type.name == 'int' || type.name == 'integer'>
    <#return 'int'>
  <#elseif type.name == 'bool'>
    <#return 'bool'>
  <#elseif type.name == 'string'>
    <#return 'QString'>
  <#elseif type.custom>
    <#return cpp.nameType(type.name) + '*'>
  <#elseif type.collection>
    <#assign componentType = type.componentType>
    <#return 'QList<' + type_name(componentType) + '>'>
  </#if>
  <#return 'QString'>
</#function>

<#function to_type_name type>
  <#if type.name == 'int' || type.name == 'integer'>
    <#return 'toInt'>
  <#elseif type.name == 'bool'>
    <#return 'toBool'>
  <#elseif type.name == 'string'>
    <#return 'toString'>
  <#elseif type.name == 'number'>
    <#return 'toDouble'>
  </#if>
  <#return 'toString'>
</#function>

<#function is_primitive attr>
  <#return !attr.type.custom && !attr.type.collection && attr.type.name != 'string'>
</#function>