{
  "pages": [
    "page/index",
<#list pages![] as page>
  <#if !page.uri??><#continue></#if>
    "page/${page.uri?substring(page.uri?indexOf("/") + 1)}",
</#list>
    "page/common/search"
  ],
  "subpackages": [],
  "window": {
    "backgroundTextStyle": "light",
    "navigationBarBackgroundColor": "#fff",
    "navigationBarTitleText": "",
    "navigationBarTextStyle": "black"
  },
  "style": "v2",
  "sitemapLocation": "sitemap.json"
}