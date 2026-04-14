<#import '/$/modelbase.ftl' as modelbase>
<#import '/$/qt5.ftl' as qt5>
<#if license??>
${cpp.license(license)}
</#if>

#ifndef ${cpp.nameNamespace(app.name)?upper_case}_HPP
#define ${cpp.nameNamespace(app.name)?upper_case}_HPP

#define STYLE_LABEL_ERROR           "QLabel { color : #db2828; }"
#define STYLE_LABEL_SUCCESS         "QLabel { color : #21ba45; }"

#define FORMAT_CONNECTION_STRING    "Driver={SQL Server};Server=%1;Port=%2;Database=%3;Uid=%4;Pwd=%5;"

#endif // ${cpp.nameNamespace(app.name)?upper_case}_HPP