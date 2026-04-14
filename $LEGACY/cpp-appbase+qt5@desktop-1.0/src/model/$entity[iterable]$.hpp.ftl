<#import '/$/modelbase.ftl' as modelbase>
<#import '/$/qt5.ftl' as qt5>
<#if license??>
${cpp.license(license)}
</#if>
<#assign entityName = entity.getLabelledOptions('entity')['iterable']!'TODO'>
#ifndef ${app.name?upper_case}_${entityName?upper_case}_HPP
#define ${app.name?upper_case}_${entityName?upper_case}_HPP

#include <QtCore>

#include "${cpp.nameFile(entity.name)}.hpp"

<#assign label = modelbase.get_object_label(entity)>
/*!
** ${label}集合对象类型。
*/
class ${cpp.nameType(entityName)}
{

public:

  /*!
  ** ${label}构造函数。
  */
  ${cpp.nameType(entityName)}(void);

  /*!
  ** ${label}析构函数。
  */
  ~${cpp.nameType(entityName)}(void);

  /*!
  ** 通过JSON初始化对象。
  */
  void fromJSON(const QJsonArray& array);

  /*!
  ** 转换为JSON字符串。
  */
  QJsonArray toJSON(void);

  /*!
  ** 添加【${modelbase.get_object_label(entity)}】对象。
  */
  void add${cpp.nameType(entity.name)}(${cpp.nameType(entity.name)}* ${cpp.nameVariable(entity.name)});

  /*!
  ** 获取【${modelbase.get_object_label(entity)}】集合对象。
  */
  const QList<${cpp.nameType(entity.name)}*>& get${cpp.nameType(entity.getLabelledOptions('name')['plural'])}(void) const;

private:

  QList<${cpp.nameType(entity.name)}*>      ${cpp.nameVariable(entity.getLabelledOptions('name')['plural'])};
};

#endif // ${app.name?upper_case}_${entityName?upper_case}_HPP