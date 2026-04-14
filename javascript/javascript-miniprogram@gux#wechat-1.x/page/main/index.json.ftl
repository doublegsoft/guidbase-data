<#import "/$/guidbase.ftl" as guidbase>
{
  "usingComponents": {
<#list guidbase.get_navigable_pages(app) as nav>   
    "page-${nav.id?replace("_","-")}": "/page/navigable/${nav.id}/index",
</#list>    
<#-- 
    "page-index": "/page/navigable/index/index",
    "page-user": "/page/navigable/user/index",
-->    
    "gx-navigable-page": "/vendor/gux/widget/gx-navigable-page/index",
    "gx-tab-bar": "/vendor/gux/widget/gx-tab-bar/index"
  }
}