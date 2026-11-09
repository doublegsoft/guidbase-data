<#import "/$/guidbase.ftl" as guidbase>
<#import "/$/qt6/qt6-default.ftl" as qt6>
<#if license??>
${cpp.license(license)}
</#if>
#pragma once

#include <QWidget>

namespace ${namespace} {

class ${cpp.nameType(page.name)} : public QWidget {
  Q_OBJECT

public:

  explicit ${cpp.nameType(page.name)}(QWidget* parent = nullptr)  {
    layout();
  }
  
  ~${cpp.nameType(page.name)}() override = default;

  void layout();

<#list page.children as child>
<#--  <@print_widget_variables widget=child indent=2 />  -->
</#list>
};

} // namespace