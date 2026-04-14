<#import "/$/guidbase.ftl" as guidbase>
QT       += core gui widgets

CONFIG += c++17

# You can make your code fail to compile if it uses deprecated APIs.
# In order to do so, uncomment the following line.
#DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0

INCLUDEPATH += lib

SOURCES += \
<#list app.pages as page>
  <#assign module = guidbase.page_id_to_module(page.id)>
  <#assign pageName = guidbase.page_id_to_page_name(page.id)>
  <#if module == "">
  src/Page${cpp.nameType(pageName)}.cpp \
  <#else>
  src/${module}/Page${cpp.nameType(pageName)}.cpp \
  </#if>
</#list>
  lib/gux/widget/GXSidebar.cpp              \
  lib/gux/gux.cpp                           \
  src/main.cpp

HEADERS += \
<#list app.pages as page>
  <#assign module = guidbase.page_id_to_module(page.id)>
  <#assign pageName = guidbase.page_id_to_page_name(page.id)>
  <#if module == "">
  src/Page${cpp.nameType(pageName)}.hpp \
  <#else>
  src/${module}/${cpp.nameType(pageName)}Page.hpp \
  </#if>
</#list>   
  lib/gux/widget/GXSidebar.hpp              \
  lib/gux/gux.hpp                           

# Default rules for deployment.
qnx: target.path = /tmp/$${r"${"}TARGET${r"}"}/bin
else: unix:!android: target.path = /opt/$${r"${"}TARGET${r"}"}/bin
!isEmpty(target.path): INSTALLS += target
