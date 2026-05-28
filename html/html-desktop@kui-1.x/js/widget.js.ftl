<#import "/$/modelbase.ftl" as modelbase>
<#import "/$/appbase.ftl" as appbase>

<#assign page = {"name": ""}>
<#if widgetType == 'FormLayout'>
<@appbase.print_js_declare_formlayout widget=properties indent=2 />
<#elseif widgetType == 'ReadonlyForm'>
<@appbase.print_js_declare_readonlyform widget=properties indent=2 />
<#elseif widgetType == 'PaginationTable'>
<@appbase.print_js_declare_paginationtable widget=properties indent=2 />
<#elseif widgetType == 'PaginationGrid'>
<@appbase.print_js_declare_paginationgrid widget=properties indent=2 />
<#elseif widgetType == 'ListView'>
<@appbase.print_js_methods_listview page=page widget=properties indent=2 />
<@appbase.print_js_declare_listview widget=properties indent=2 />
<#elseif widgetType == 'Timeline'>
<@appbase.print_js_methods_timeline page=page widget=properties indent=2 />
<@appbase.print_js_declare_timeline widget=properties indent=2 />
<#elseif widgetType == 'Tabs'>
<@appbase.print_js_declare_tabs widget=properties indent=2 />
<#elseif widgetType == 'Calendar'>
<@appbase.print_js_declare_calendar widget=properties indent=2 />
<#elseif widgetType == 'Richtext'>
<@appbase.print_js_declare_richtext widget=properties indent=2 />
<#elseif widgetType == 'AOW'>
<@appbase.print_js_declare_AOW widget=properties indent=2 />
<#elseif widgetType == 'SURD'>
<@appbase.print_js_declare_SURD widget=properties indent=2 />
<#elseif widgetType == 'GIM'>
<@appbase.print_js_declare_GIM widget=properties indent=2 />
</#if>