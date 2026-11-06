<#if license??>
${cpp.license(license)}
</#if>
#if defined(__APPLE__) && defined(__aarch64__)
#include <arm_acle.h>
#endif

#include <QApplication>
#include <QWidget>
#include <QVBoxLayout>
#include <QLabel>
#include <QDebug>

#include "${namespace}-datepicker.hpp"

use namespace ${namespace};

int main(int argc, char* argv[]) {
  QApplication app(argc, argv);

  QWidget window;
  window.setWindowTitle("DatePicker Demo");
  window.resize(360, 240);

  QVBoxLayout* layout = new QVBoxLayout(&window);
  layout->setSpacing(16);
  layout->setContentsMargins(24, 24, 24, 24);

  // 1. 基础默认用法
  QLabel* label1 = new QLabel("默认日期选择器：", &window);
  DatePicker* picker1 = new DatePicker(&window);
  picker1->setPlaceholder("请选择日期 (YYYY-MM-DD)");

  QObject::connect(picker1, &DatePicker::dateChanged, [](const QDate& date) {
    if (date.isValid()) {
      qDebug("Picker 1 选中日期: %s", qUtf8Printable(date.toString("yyyy-MM-dd")));
    } else {
      qDebug("Picker 1 已重置清空");
    }
  });

  // 2. 带初始值、自定义格式与日期范围限制
  QLabel* label2 = new QLabel("限制范围 (当月前后15天) & 自定义格式：", &window);
  DatePicker* picker2 = new DatePicker(&window);
  picker2->setFormat("yyyy/MM/dd");

  QDate today = QDate::currentDate();
  picker2->setDateRange(today.addDays(-15), today.addDays(15));
  picker2->setDate(today);

  QObject::connect(picker2, &DatePicker::dateChanged, [](const QDate& date) {
    if (date.isValid()) {
      qDebug("Picker 2 选中日期: %s", qUtf8Printable(date.toString("yyyy/MM/dd")));
    } else {
      qDebug("Picker 2 已重置清空");
    }
  });

  layout->addWidget(label1);
  layout->addWidget(picker1);
  layout->addWidget(label2);
  layout->addWidget(picker2);
  layout->addStretch();

  window.show();
  return app.exec();
}
