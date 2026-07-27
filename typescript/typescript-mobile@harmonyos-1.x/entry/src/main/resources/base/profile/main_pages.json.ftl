{
  "src": [
<#list app.pages as page>    
    "pages/${page.module}/${ts.nameType(page.name)}",
</#list>
    "pages/HomePage"
  ]
}
