{
  "pages": [
<#list app.pages![] as page>
    "pages/${js.nameFile(page.id)}"<#if page?index != app.pages?size - 1>,</#if>
</#list>
  ],
  "subpackages": [],
  "window": {
    "backgroundTextStyle": "light",
    "navigationBarBackgroundColor": "#fff",
    "navigationBarTitleText": "",
    "navigationBarTextStyle": "black"
  },
  "resolveAlias": {
    "@/*": "/*"
  },
  "style": "v2",
  "sitemapLocation": "sitemap.json"
}