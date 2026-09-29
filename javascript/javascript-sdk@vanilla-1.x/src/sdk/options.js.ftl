<#import "/$/guidbase.ftl" as guidbase>
let sdk
if (typeof sdk === 'undefined') {
  sdk = {};
}
<#assign visited_widgets = {}>
<#list app.pages as page>
  <#list page.widgets as widget>
    <#if !widget.id?? || visited_widgets[widget.id]??><#continue></#if>
    <#-- select, multiselect, segment支持枚举类型 -->
    <#if widget.type != "select" && widget.type != "multiselect" && widget.type != "segments"><#continue></#if>
    <#if widget.value("data") == ""><#continue></#if>
    <#assign visited_widgets += {widget.id: widget}>
    <#if guidbase.get_widget_enum_ref(widget)??>

sdk.get${js.nameType(widget.id)}OptionLabel = function (value, options) {
  for (let i = 0; i < options.length; i++) {
    if (options[i].value == value) {
      return options[i].label;
    }
  }
  return null;
};

sdk.get${js.nameType(widget.id)}OptionValue = function (label, options) {
  for (let i = 0; i < options.length; i++) {
    if (options[i].label == label) {
      return options[i].value;
    }
  }
  return null;
};      
    <#else>
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

sdk.get${js.nameType(widget.id)}OptionValue = function (label) {
  for (let i = 0; i < sdk.${js.nameVariable(widget.id)}Options.length; i++) {
    if (sdk.${js.nameVariable(widget.id)}Options[i].label == label) {
      return sdk.${js.nameVariable(widget.id)}Options[i].value;
    }
  }
  return null;
};
    </#if>
  </#list>
</#list>

export default sdk