<#import '/$/modelbase.ftl' as modelbase>
<#import '/$/qt5.ftl' as qt5>
<#if license??>
${cpp.license(license)}
</#if>

#include <QtWidgets/QtWidgets>

#include "window/MainWindow.hpp"
#include "window/ObservableObject.hpp"

ObservableObject observable;

int main(int argc, char *argv[])
{
  QApplication a(argc, argv);
  MainWindow w;
  w.showMaximized();

  return a.exec();
}
