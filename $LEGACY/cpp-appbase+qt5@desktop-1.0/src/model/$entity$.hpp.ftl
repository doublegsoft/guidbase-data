<#import '/$/modelbase.ftl' as modelbase>
<#import '/$/qt5.ftl' as qt5>
<#if license??>
${cpp.license(license)}
</#if>
#ifndef ${app.name?upper_case}_${entity.name?upper_case}_HPP
#define ${app.name?upper_case}_${entity.name?upper_case}_HPP

#include <QtCore>

<#assign includes = {}>
<#list entity.attributes as attr>
  <#if attr.type.custom>
    <#--assign includes = includes + {attr.type.name: ''}-->
  <#elseif (attr.type.collection && attr.type.componentType.custom)>
    <#assign includes = includes + {attr.type.componentType.name: ''}>
  </#if>
</#list>
<#list includes?keys as inc>
#include "${cpp.nameFile(inc)}.hpp"
</#list>

<#assign label = modelbase.get_object_label(entity)>
/*!
** ${label}对象类型。
*/
class ${cpp.nameType(entity.name)}
{

public:

  /*!
  ** ${label}构造函数。
  */
  ${cpp.nameType(entity.name)}(void);

  /*!
  ** ${label}析构函数。
  */
  ~${cpp.nameType(entity.name)}(void);

  /*!
  ** 通过JSON初始化对象。
  */
  void fromJSON(const QJsonObject& json);

  /*!
  ** 转换为JSON字符串。
  */
  QJsonObject toJSON(void);
<#list entity.attributes as attr>
  <#if attr.type.custom><#continue></#if>

  /*!
  ** 获取【${modelbase.get_attribute_label(attr)}】属性方法。
  */
  <#if !qt5.is_primitive(attr)>const </#if>${qt5.type_name(attr.type)}<#if !qt5.is_primitive(attr)>&</#if> get${cpp.nameType(attr.name)}(void)<#if !qt5.is_primitive(attr)> const</#if>;
  
  <#if attr.type.collection>
  /*!
  ** 添加单个【${modelbase.get_attribute_label(attr)}】属性方法。
  */
  void add${cpp.nameType(attr.getLabelledOptions('name')['singular'])}(${qt5.type_name(attr.type.componentType)} ${cpp.nameVariable(attr.getLabelledOptions('name')['singular'])});

  /*!
  ** 删除单个【${modelbase.get_attribute_label(attr)}】属性方法。
  */
  void remove${cpp.nameType(attr.getLabelledOptions('name')['singular'])}(${qt5.type_name(attr.type.componentType)} ${cpp.nameVariable(attr.getLabelledOptions('name')['singular'])});
  
  <#elseif attr.type.custom>
    <#-- 自定义的单个引用什么都不用干 -->
  <#else>
  /*!
  ** 设置【${modelbase.get_attribute_label(attr)}】属性方法。
  */
  void set${cpp.nameType(attr.name)}(${qt5.type_name(attr.type)} ${cpp.nameVariable(attr.name)});
  </#if>
</#list>  

private:
<#list entity.attributes as attr>
  <#if attr.type.custom><#continue></#if>

  /*!
  ** 【${modelbase.get_attribute_label(attr)}】属性。
  */
  ${qt5.type_name(attr.type)?right_pad(16)} ${cpp.nameVariable(attr.name)};
</#list>  
};

Q_DECLARE_METATYPE(${cpp.nameType(entity.name)});
Q_DECLARE_METATYPE(${cpp.nameType(entity.name)}*);

#endif // ${app.name?upper_case}_${entity.name?upper_case}_HPP