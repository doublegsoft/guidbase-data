let sdk
if (typeof sdk === 'undefined') {
  sdk = {};
}
<#assign visited_widgets = {}>
<#list app.pages as page>
  <#list page.widgets as widget>
    <#if !widget.id?? || visited_widgets[widget.id]??><#continue></#if>
    <#assign visited_widgets += {widget.id: widget}>
    <#if (widget.type == "select" || widget.type == "multiselect")>
      <#if (widget.value("data")!"")?starts_with("enum[")>
        <#assign enumOpts = typebase.enumtype(widget.value("data"))>

sdk.fetch${js.nameType(widget.id)}Options = async () => {
  return sdk.${js.nameVariable(widget.id)}Options
};        
      <#else>

sdk.fetch${js.nameType(widget.id)}Options = async () => {
  return [];
};
      </#if>
    <#elseif widget.type == "cascade">

sdk.fetch${js.nameType(widget.id)}Options = async () => {    
  return [];
}
    <#elseif widget.type == "paged_table">

sdk.fetch${js.nameType(widget.id)}Rows = async (params, start, limit) => {
  return {
    total: 0,
    data: []
  };
};
    </#if>
  </#list>
</#list>
    
export default sdk