<#if license??>
${cpp.license(license)}
</#if>

<#assign pageName = page.name?replace('page_', '')>

#ifndef ${pageName?upper_case}_WIDGET_HPP
#define ${pageName?upper_case}_WIDGET_HPP

#include <QtWidgets>

class ${cpp.nameType(pageName)}Widget : public QWidget 
{
Q_OBJECT

public:

  ${cpp.nameType(pageName)}Widget(void);

private:
  
  void initialize(void);

private:

<#list pageOwner.pageWidgets as widget>
${plugin.render(widget, 2, '.hpp')}
</#list>

};


#endif // ${pageName?upper_case}_WIDGET_HPP