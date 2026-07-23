{
  "src": [
<#list app.pages as page>    
    "pages/${ts.nameType(page.name)}Index"<#if page?index != app.pages?size - 1>,</#if>
</#list>
  ]
}
