cmake_minimum_required(VERSION 3.10)

project(${app.name} C CXX)

set(CMAKE_C_FLAGS "${r"${"}CMAKE_C_FLAGS${r"}"} -Wno-shadow-ivar -Wno-nonnull ")

##
## link_directories
##
set(${app.name?upper_case}_SOURCES
<#list app.usecases as uc>
  <#assign page = uc.page>
  "Sources/App/${objc.nameType(page.id)}ViewController.m"
</#list>
<#list app.usecases as uc>
  <#assign page = uc.page>
  <#list page.pageWidgets as widget>
    <#if widget.type == "listview" || widget.type == "gridview">
  "Sources/Widget/Tile/${objc.nameType(widget.id)}Tile.m"
    </#if>
  </#list>
</#list>
)

<#assign libname = app.name>
<#if libname?starts_with("lib")>
  <#assign libname = libname?substring(3)>
</#if>
add_library(${libname} STATIC ${r"${"}${app.name?upper_case}_SOURCES${r"}"})
add_library(${libname}_shared SHARED ${r"${"}${app.name?upper_case}_SOURCES${r"}"})
set_target_properties(${libname}_shared PROPERTIES OUTPUT_NAME ${libname})

target_link_libraries(${libname} PRIVATE
  "-framework foundation"
  "-framework cocoa"
)

target_link_libraries(${libname}_shared PRIVATE
  "-framework foundation"
  "-framework cocoa"
)