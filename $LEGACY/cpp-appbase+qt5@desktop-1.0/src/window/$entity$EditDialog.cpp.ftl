<#import '/$/modelbase.ftl' as modelbase>
<#import '/$/qt5.ftl' as qt5>
<#if license??>
${cpp.license(license)}
</#if>

#include <appbase/appbase.hpp>
#include "../${cpp.nameType(app.name)?lower_case}.hpp"
#include "${cpp.nameType(entity.name)}EditDialog.hpp"

extern appbase::ObservableObject observable;

${cpp.nameType(entity.name)}EditDialog::${cpp.nameType(entity.name)}EditDialog(QWidget* parent) : QDialog(parent)
{
  initialize();
}

${cpp.nameType(entity.name)}EditDialog::~${cpp.nameType(entity.name)}EditDialog(void)
{
  
}

${cpp.nameType(entity.name)}* 
${cpp.nameType(entity.name)}EditDialog::get${cpp.nameType(entity.name)}Object(void)
{
  ${cpp.nameType(entity.name)}* ${cpp.nameVariable(entity.name)};
  if (present == nullptr)
    ${cpp.nameVariable(entity.name)} = new ${cpp.nameType(entity.name)};
  else
    ${cpp.nameVariable(entity.name)} = present;
<#list entity.attributes as attr>
  <#if attr.type.collection><#continue></#if>
  <#if attr.type.custom><#continue></#if>
  <#assign typename = qt5.type_name(attr.type)>
  <#if attr.constraint.domainType.name?index_of('enum') == 0>
  QVariant data${cpp.nameType(attr.name)} = getSelect${cpp.nameType(attr.name)}()->currentData(Qt::UserRole);
  ${cpp.nameVariable(entity.name)}->set${cpp.nameType(attr.name)}(data${cpp.nameType(attr.name)}.value<QString>());
  <#elseif typename == 'QString'>
  ${cpp.nameVariable(entity.name)}->set${cpp.nameType(attr.name)}(getText${cpp.nameType(attr.name)}()->text());
  <#elseif typename == 'int'>
  ${cpp.nameVariable(entity.name)}->set${cpp.nameType(attr.name)}(getText${cpp.nameType(attr.name)}()->text().toInt());
  </#if>
</#list>
  return ${cpp.nameVariable(entity.name)};
}

void
${cpp.nameType(entity.name)}EditDialog::set${cpp.nameType(entity.name)}Object(${cpp.nameType(entity.name)}* ${cpp.nameVariable(entity.name)})
{
  present = ${cpp.nameVariable(entity.name)};
  if (present == nullptr) return;

<#list entity.attributes as attr>
  <#if attr.type.collection><#continue></#if>
  <#if attr.type.custom><#continue></#if>
  <#assign typename = qt5.type_name(attr.type)>
  <#if attr.constraint.domainType.name?index_of('enum') == 0>
  for (int i = 0; i < getSelect${cpp.nameType(attr.name)}()->count(); i++) {
    QVariant data = getSelect${cpp.nameType(attr.name)}()->itemData(i, Qt::UserRole);
    if (data.value<QString>() == ${cpp.nameVariable(entity.name)}->get${cpp.nameType(attr.name)}()) {
      getSelect${cpp.nameType(attr.name)}()->setCurrentIndex(i);
      break;
    }
  }
  <#elseif typename == 'QString'>
  getText${cpp.nameType(attr.name)}()->setText(${cpp.nameVariable(entity.name)}->get${cpp.nameType(attr.name)}());
  <#elseif typename == 'int'>
  getText${cpp.nameType(attr.name)}()->setText(QString::number(${cpp.nameVariable(entity.name)}->get${cpp.nameType(attr.name)}()));
  </#if>
</#list>
}

void
${cpp.nameType(entity.name)}EditDialog::initialize(void)
{
  QFormLayout* form = new QFormLayout;
<#list entity.attributes as attr>
  <#if attr.type.collection><#continue></#if>
  <#if attr.type.custom><#continue></#if>
  <#assign label = modelbase.get_attribute_label(attr)>
  <#if attr.constraint.domainType.name?index_of('enum') == 0>
  form->addRow(appbase::WidgetFactory::createLabel(QString::fromUtf8("${label}：")), getSelect${cpp.nameType(attr.name)}());
  <#else>
  form->addRow(appbase::WidgetFactory::createLabel(QString::fromUtf8("${label}：")), getText${cpp.nameType(attr.name)}());
  </#if>
  form->addItem(new QSpacerItem(0, 12));
</#list>

  form->addWidget(getLabelError());

  QHBoxLayout* hbox = new QHBoxLayout;
  hbox->setAlignment(Qt::AlignRight);
  hbox->addWidget(getButtonConfirm());
  hbox->addItem(new QSpacerItem(10, 10));
  hbox->addWidget(getButtonClose());
  
  form->addRow(hbox);

  setLayout(form);
  setWindowTitle(QString::fromUtf8("${modelbase.get_object_label(entity)}编辑"));
  setFixedWidth(650);
}

<#list entity.attributes as attr>
  <#if attr.type.collection><#continue></#if>
  <#if attr.type.custom><#continue></#if>
  <#assign label = modelbase.get_attribute_label(attr)>
  <#if attr.constraint.domainType.name?index_of('enum') == 0>
    <#assign pairs = typebase.enumtype(attr.constraint.domainType.name)>
QComboBox*          
${cpp.nameType(entity.name)}EditDialog::getSelect${cpp.nameType(attr.name)}(void)
{
  if (select${cpp.nameType(attr.name)} == nullptr)
  {
    select${cpp.nameType(attr.name)} = appbase::WidgetFactory::createComboBox();
    <#list pairs as pair>
    select${cpp.nameType(attr.name)}->addItem(QString::fromUtf8("${pair.value}"), QVariant("${pair.key}"));
    </#list>
  }
  return select${cpp.nameType(attr.name)};
}
  <#else>
QLineEdit*          
${cpp.nameType(entity.name)}EditDialog::getText${cpp.nameType(attr.name)}(void)
{
  if (text${cpp.nameType(attr.name)} == nullptr)
  {
    text${cpp.nameType(attr.name)} = appbase::WidgetFactory::createLineEdit();
<#if attr.constraint.defaultValue??>
    text${cpp.nameType(attr.name)}->setText("${attr.constraint.defaultValue?replace("'", '')}");
</#if>
<#if attr.constraint.domainType.name == 'integer'>
  <#assign min = attr.getLabelledOptions('value')['min']!'0'>
  <#assign max = attr.getLabelledOptions('value')['max']!'9999'>
    text${cpp.nameType(attr.name)}->setValidator(new QIntValidator(${min}, ${max}, this));
<#elseif attr.constraint.domainType.name == 'number'>
  <#assign min = attr.getLabelledOptions('value')['min']!'0'>
  <#assign max = attr.getLabelledOptions('value')['max']!'9999'>
    text${cpp.nameType(attr.name)}->setValidator(new QIntValidator(${min}, ${max}, 2, this));
<#elseif attr.constraint.domainType.name == 'password'>
    text${cpp.nameType(attr.name)}->setEchoMode(QLineEdit::Password);
</#if>
  }
  return text${cpp.nameType(attr.name)};
}
  </#if>
</#list>

QPushButton*        
${cpp.nameType(entity.name)}EditDialog::getButtonConfirm(void)
{
  if (buttonConfirm == nullptr)
  {
    buttonConfirm = appbase::WidgetFactory::createPushButton(QString::fromUtf8("确  定"));
    buttonConfirm->setFixedSize(appbase::SIZE_BUTTON);
    connect(buttonConfirm, &QPushButton::clicked, this, [=]() {
      labelError->clear();
<#list entity.attributes as attr>
  <#if attr.type.custom || attr.type.collection><#continue></#if>
  <#if !attr.constraint.nullable || attr.constraint.identifiable>
      if (text${cpp.nameType(attr.name)}->text().isEmpty()) {
        labelError->setText("${modelbase.get_attribute_label(attr)}需要填写！");
        return;
      }
  </#if>
</#list>
      QVariant data;
      ${cpp.nameType(entity.name)}* ${cpp.nameVariable(entity.name)} = get${cpp.nameType(entity.name)}Object();
      data.setValue(${cpp.nameVariable(entity.name)});
      if (present == nullptr)
        observable.setProperty(PROP_CREATED_${cpp.nameType(entity.name)?upper_case}, data);
      else
        observable.setProperty(PROP_UPDATED_${cpp.nameType(entity.name)?upper_case}, data);
      close();
    });
  }
  return buttonConfirm;
}

QPushButton*        
${cpp.nameType(entity.name)}EditDialog::getButtonClose(void)
{
  if (buttonClose == nullptr)
  {
    buttonClose = appbase::WidgetFactory::createPushButton(QString::fromUtf8("关  闭"));
    buttonClose->setFixedSize(appbase::SIZE_BUTTON);
    connect(buttonClose, &QPushButton::clicked, this, [=](){
      close();
    });
  }
  return buttonClose;
}

QLabel*             
${cpp.nameType(entity.name)}EditDialog::getLabelError(void)
{
  if (labelError == nullptr)
  {
    labelError = new QLabel();
    labelError->setStyleSheet(STYLE_LABEL_ERROR);
  }
  return labelError;
}