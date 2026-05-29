let sdk
if (typeof sdk === 'undefined') {
  sdk = {};
}
<#assign visited_widgets = {}>
<#list app.pages as page>
  <#list page.widgets as widget>
    <#if !widget.id?? || visited_widgets[widget.id]??><#continue></#if>
    <#if widget.type != "select" || !(widget.value("data")!"")?starts_with("enum[")><#continue></#if>
    <#assign visited_widgets += {widget.id: widget}>
    <#assign opts = typebase.enumtype(widget.value("data"))>

sdk.${js.nameVariable(widget.id)}Options = [{
      <#list opts as opt>
        <#if opt?index != 0>
},{        
        </#if>
  value: '${opt.code}', label: '${opt.text}',
      </#list>
}];
  </#list>
</#list>

export default sdk