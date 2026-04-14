<#import '/$/modelbase.ftl' as modelbase>
<#import '/$/qt5.ftl' as qt5>
<#if license??>
${cpp.license(license)}
</#if>

#ifndef ${entity.name?upper_case}_EDIT_DIALOG_HPP
#define ${entity.name?upper_case}_EDIT_DIALOG_HPP

#include <QtWidgets>
#include "../model/${cpp.nameType(entity.name)}.hpp"

<#assign label = modelbase.get_object_label(entity)>
/*!
** 【${label}】对象编辑对话框。 
**
** @author <a href="mailto:guo.guo.gan@gmail.com">Christian Gann</a>
**
** @since 1.0
*/
class ${cpp.nameType(entity.name)}EditDialog : public QDialog
{
Q_OBJECT

public:

  /*!
  ** 【${label}】编辑对话框构造函数。
  */
  ${cpp.nameType(entity.name)}EditDialog(QWidget*);

  /*!
  ** 【${label}】编辑对话框析构函数。
  */
  ~${cpp.nameType(entity.name)}EditDialog(void);

  /*!
  ** 获取【${label}】对象数据。
  */
  ${cpp.nameType(entity.name)}* get${cpp.nameType(entity.name)}Object(void);

  /*!
  ** 设置【${label}】对象数据。
  */
  void set${cpp.nameType(entity.name)}Object(${cpp.nameType(entity.name)}* ${cpp.nameVariable(entity.name)});

private:
  
  void initialize(void);
<#list entity.attributes as attr>
  <#if attr.type.collection><#continue></#if>
  <#assign label = modelbase.get_attribute_label(attr)>

  /*!
  ** 【${label}】属性编辑框的懒加载模式。 
  */
  <#if attr.constraint.domainType.name?index_of('enum') == 0>
  QComboBox*          getSelect${cpp.nameType(attr.name)}(void);
  <#else>
  QLineEdit*          getText${cpp.nameType(attr.name)}(void);
  </#if>
</#list>

  /*!
  ** 【确定】按钮懒加载。
  */
  QPushButton*        getButtonConfirm(void);

  /*!
  ** 【取消】按钮懒加载。
  */
  QPushButton*        getButtonClose(void);

  /*!
  ** 【错误】提示框懒加载。
  */
  QLabel*             getLabelError(void);

private:
<#list entity.attributes as attr>
  <#if attr.type.collection><#continue></#if>
  <#if attr.type.custom><#continue></#if>
  <#assign label = modelbase.get_attribute_label(attr)>
  /*!
  ** 【${label}】属性编辑框。 
  */
  <#if attr.constraint.domainType.name?index_of('enum') == 0>
  QComboBox*          select${cpp.nameType(attr.name)} = nullptr;
  <#else>
  QLineEdit*          text${cpp.nameType(attr.name)} = nullptr;
  </#if>
</#list>

  /*!
  ** 【确定】按钮，触发保存，成功即关闭，失败则提示错误。
  */
  QPushButton*        buttonConfirm = nullptr;

  /*!
  ** 【关闭】按钮
  */
  QPushButton*        buttonClose = nullptr;

  /*!
  ** 【错误】提示标签。
  */
  QLabel*             labelError = nullptr;

  ${cpp.nameType(entity.name)}*       present = nullptr;
};

#endif // ${entity.name?upper_case}_EDIT_DIALOG_HPP