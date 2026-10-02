{
  "pages": [
<#list app.pages![] as page>
    "pages/${js.nameFile(page.id)}",
</#list>
    "pages/chat/chat"
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