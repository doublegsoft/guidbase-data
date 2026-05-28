${app.name} = {};

<#list pages as page>
${app.name}.URL_${app.name?upper_case}_COMMON_SEARCH = '/${app.name}/json/common/search.json';
  <#list page.widgets as widget>
    <#if widget.widgetType == '传统列表' || widget.widgetType == '栅格列表'>
${app.name}.URL_${(page.uri + '_' + widget.variable!'TODO')?replace('/', '_')?upper_case} = '/${app.name}/json/${page.uri?replace(app.name + '/', '') + '/' + widget.variable!'TODO'}.json';
    </#if>
  </#list>
</#list>