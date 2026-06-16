export const MODULE_LIST = [
<#list app.modules as module>
  { key: '${js.nameVariable(module)}', label: '${modules[module]}' },
</#list>  
]

export const MENUS = {
<#assign visited_modules = {}>
<#list app.modules as module>
  ${js.nameVariable(module)}: {
    label: '${modules[module]}',
    sections: [{ 
      title: '${modules[module]}', 
      items: [
  <#list app.pages as page>
    <#if page.module != module><#continue></#if>      
        { id: '${js.nameFile(page.name)}', label: '${page.title!"页面"}', path: '/${js.nameFile(page.module)}/${js.nameFile(page.name)}', },
  </#list> 
      ],
    }],
  },
</#list>   
}
