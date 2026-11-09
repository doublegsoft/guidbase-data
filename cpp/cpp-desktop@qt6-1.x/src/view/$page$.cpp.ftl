<#import "/$/guidbase.ftl" as guidbase>
<#import "/$/qt6/qt6-default.ftl" as qt6>
<#if license??>
${cpp.license(license)}
</#if>
#if defined(__APPLE__) && defined(__arm64__)
#include <arm_acle.h>
#endif

#include <QCheckBox>
#include <QComboBox>
#include <QDate>
#include <QDateEdit>
#include <QGridLayout>
#include <QGroupBox>
#include <QLabel>
#include <QLineEdit>
#include <QTime>
#include <QTimeEdit>
#include <QVBoxLayout>
#include <QWidget>

#include "${naming.nameFile(page.id)}.hpp"
#include "component/${namespace}-datepicker.hpp"

namespace ${namespace} {

void
${cpp.nameType(page.name)}::layout() {
<#list page.children as child>
<@qt6.print_widget_layout widget=child indent=2 />
</#list>
}

} // namespace