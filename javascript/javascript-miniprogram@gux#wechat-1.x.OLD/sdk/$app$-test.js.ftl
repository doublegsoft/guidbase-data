const sdk = {
  options: {},
};
<#assign options = {}>
<#list app.pages as page>
  <#list page.pageWidgets as widget>
    <#if widget.type?? && widget.id?? && widget.type == 'select' && !options[widget.id]??>
sdk.options['${js.nameVariable(widget.id)}'] = {
  values: [
    {value: '1', text: 'A'},
    {value: '2', text: 'B'}
  ]
};
      <#assign options = options + {widget.id: ""}>
    </#if>
  </#list>
</#list>

module.exports = sdk;