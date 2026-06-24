let sdk
if (typeof sdk === 'undefined') {
  sdk = {};
}
<#assign visited_widgets = {}>
<#list app.pages as page>
  <#list page.widgets as widget>
    <#if !widget.id?? || visited_widgets[widget.id]??><#continue></#if>
    <#if widget.type != "select"><#continue></#if>
    <#assign visited_widgets += {widget.id: widget}>
    <#if widget.value("data")?starts_with("enum[")>
      <#assign opts = typebase.enumtype(widget.value("data"))>
sdk.${js.nameVariable(widget.id)}Options = [{
      <#list opts as opt>
        <#if opt?index != 0>
},{        
        </#if>
  value: '${opt.code}', label: '${opt.text}',
      </#list>
}];

sdk.get${js.nameType(widget.id)}OptionLabel = function (value) {
  for (let i = 0; i < sdk.${js.nameVariable(widget.id)}Options.length; i++) {
    if (sdk.${js.nameVariable(widget.id)}Options[i].value == value) {
      return sdk.${js.nameVariable(widget.id)}Options[i].label;
    }
  }
  return null;
};
    <#else>

sdk.get${js.nameType(widget.id)}OptionLabel = function (value, options) {
  for (let i = 0; i < options.length; i++) {
    if (options[i].value == value) {
      return options[i].label;
    }
  }
  return null;
};
    </#if>
  </#list>
</#list>

export default sdk