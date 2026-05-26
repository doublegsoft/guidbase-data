<#macro print_form_imports form indent>

</#macro>

<#macro print_form_variables form indent>
${""?left_pad(indent)}const ${js.nameVariable(form.id)}Data = reactive({
  <#list form.inputs as input>
${""?left_pad(indent)}  ${js.nameVariable(input.id)}: '',
  </#list>
});
</#macro>

<#macro print_form_methods form indent>
</#macro>

