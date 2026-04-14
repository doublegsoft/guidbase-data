<#import "/$/modelbase.ftl" as modelbase>

<#macro print_source_code snippet widget indent>
<@modelbase.print_source_code platform="MOBILE" framework="swiftui" language="swift" snippet=snippet
                              component=widget.widgetType widget=widget indent=indent />
</#macro>