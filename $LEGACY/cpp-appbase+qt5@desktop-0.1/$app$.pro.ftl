#-------------------------------------------------
#
# ${app.name} qmake file
#
#-------------------------------------------------

QT       += core gui

greaterThan(QT_MAJOR_VERSION, 4): QT += widgets

TARGET = ${app.name}
TEMPLATE = app

# The following define makes your compiler emit warnings if you use
# any feature of Qt which has been marked as deprecated (the exact warnings
# depend on your compiler). Please consult the documentation of the
# deprecated API in order to know how to port your code away from it.
DEFINES += QT_DEPRECATED_WARNINGS

# You can also make your code fail to compile if you use deprecated APIs.
# In order to do so, uncomment the following line.
# You can also select to disable deprecated APIs only up to a certain version of Qt.
#DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0

CONFIG += c++11 sdk_no_version_check

SOURCES += \
<#list app.usecases as usecase>
  src/${naming.nameFile(usecase.page.id)}.cpp \
</#list>
  src/Widgets.cpp \
  src/main.cpp

HEADERS += \
<#list app.usecases as usecase>
  src/${naming.nameFile(usecase.page.id)}.hpp \
</#list>
  src/Widgets.hpp

# Default rules for deployment.
qnx: target.path = /tmp/$${r'${TARGET}'}/bin
else: unix:!android: target.path = /opt/$${r'${TARGET}'}/bin
!isEmpty(target.path): INSTALLS += target

RESOURCES += \
  res/${app.name}.qrc

win32:ICON = res/${app.name}.ico
macos:ICON = res/${app.name}.icns