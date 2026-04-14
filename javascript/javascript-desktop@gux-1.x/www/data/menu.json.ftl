<#import "/$/guidbase.ftl" as guidbase>
<#function get_module_title_from_pages pages>
  <#local name = "XXXXXXXXXXXXXXXXXXXXXXXXX">
  <#list pages as page>
    <#if (page.options["title"]?length < name?length)>
      <#local name = page.options["title"]>
    </#if>
  </#list>
  <#return name?replace("列表","")?replace("集合","")?replace("编辑","")?replace("详情","")>
</#function>
<#assign modules = {}>
<#list app.pages as page>
  <#assign strs = page.id?split("/")>
  <#assign name = strs[0] + "/" + strs[1]>
  <#if !modules[name]??>
    <#assign modules += {name: []}>
  </#if>
  <#assign ps = modules[name]>
  <#assign ps += [page]>
  <#assign modules += {name: ps}>
</#list>
{
  "home": {
    "text": "首页",
    "icon": "nav-icon icon-speedometer",
    "url": "javascript:ajax.view({url:'html/home.html', containerId: 'container'});"
  },
  "groups": [{
    "title": "生成页面",
    "menus": [{  
<#list modules as name,ps>    
  <#if name?index != 0>
     },{
  </#if>
      "text": "${get_module_title_from_pages(ps)}",
      "icon": "nav-icon fa-solid fa-cubes",
      "items": [{
  <#list ps as p>      
    <#if p?index != 0>
      },{
    </#if>
        "text": "${p.options["title"]}",
        "icon": "nav-icon icon-note font-16",
        "url": "javascript:ajax.view({url: 'html/${app.name}/${p.id}.html', containerId: 'container'});"
  </#list>   
      }]
</#list>  
    }]
  }]
}        