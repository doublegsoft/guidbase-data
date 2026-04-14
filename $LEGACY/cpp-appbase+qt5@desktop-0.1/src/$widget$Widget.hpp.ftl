<#if license??>
${cpp.license(license)}
</#if>

<#assign widgetPrefix = widget.name?split('_')[0]>
<#assign widgetName = widget.name?replace(widgetPrefix + '_') + '_' + widgetPrefix>

#ifndef __${widgetName?upper_case}_WIDGET_HPP__
#define __${widgetName?upper_case}_WIDGET_HPP__

#include <QtWidgets>

class ${cpp.nameType(widgetName)}Widget : public QWidget 
{
Q_OBJECT

public:

  ${cpp.nameType(widgetName)}Widget(void);

private:
  
  void initialize(void);

private slots:

private:

};


#endif // __${widgetName?upper_case}_WIDGET_HPP__