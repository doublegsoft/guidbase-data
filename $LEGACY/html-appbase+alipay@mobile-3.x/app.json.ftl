{
  "pages": [
    "page/index",
<#list pages![] as page>
  <#if !page.uri??><#continue></#if>
    "page/${page.uri?substring(page.uri?indexOf("/") + 1)}",
</#list>
    "page/common/search"
  ],
  "window": {
    "defaultTitle": "应用程序标题"
  }
}