{
  "data":[{
<#list 0..9 as i>
  <#if i != 0>
    },{
  </#if>
  <#list widget.vars as var>
    <#if var == 'image' || var == 'thumbnail'>
      <#assign num = tatabase.number(1, 60)>
      <#if num?index_of(".") != -1>
        <#assign num = num?substring(0, num?index_of("."))>
      </#if>
      "${var}": "/img/test/${num}.jpg",
    <#elseif var == 'price'>
      <#assign num = tatabase.number(1, 60)>
      <#if num?index_of(".") != -1>
        <#assign num = num?substring(0, num?index_of("."))>
      </#if>
      "${var}": "${num}",
    <#else>
      "${var}": "${tatabase.string(12)}",
    </#if>
  </#list>
      "${js.nameVariable(widget.variable)}Id": "${tatabase.string(12)}"
</#list>
  }]
}