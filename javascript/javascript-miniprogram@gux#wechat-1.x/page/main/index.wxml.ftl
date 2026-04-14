<#import "/$/guidbase.ftl" as guidbase>
<view>
<#list guidbase.get_navigable_pages(app) as nav> 
  <gx-navigable-page id="nav-${nav?index}" visible="{{activeIndex == ${nav?index}}}">
    <page-${nav.id?replace("_","-")} />
  </gx-navigable-page>
</#list>
<#--  
  <gx-navigable-page id="nav-1" visible="{{activeIndex == 1}}">
    <page-index />
  </gx-navigable-page>
  <gx-navigable-page id="nav-2" visible="{{activeIndex == 2}}">
    <page-user />
  </gx-navigable-page>
-->  
  <gx-tab-bar id="nav" navigators="{{entries}}" activeIndex="0"
   bind:active-changed="doTabBarActiveChanged" />
</view>
