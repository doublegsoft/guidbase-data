let sdk
if (typeof sdk === 'undefined') {
  sdk = {};
}
<#assign visited_widgets = {}>
<#list app.pages as page>
  <#list page.widgets as widget>
    <#if !widget.id?? || visited_widgets[widget.id]??><#continue></#if>
    <#assign objname = widget.value("object",widget.id)>
    <#assign visited_widgets += {widget.id: widget}>
    <#if (widget.type == "select" || widget.type == "multiselect")>
      <#if !widget.value("data","")?starts_with("enum[")>   

sdk.fetch${js.nameType(inflector.pluralize(objname))} = async () => {
  return [];
};
      </#if>
    <#elseif widget.type == "cascade">

sdk.fetch${js.nameType(inflector.pluralize(objname))} = async () => {    
  return [];
};
    <#elseif widget.type == "paged_table">

sdk.fetch${js.nameType(inflector.pluralize(objname))} = async (params, start, limit) => {
  return {
    total: 0,
    data: []
  };
};
    </#if>
  </#list>
</#list>
    
export default sdk