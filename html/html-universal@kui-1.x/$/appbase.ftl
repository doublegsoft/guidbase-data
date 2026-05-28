<#function get_attribute_as_field_input attr>
  <#local domainType = attr.constraint.domainType?string>
  <#if domainType?starts_with("&")>
    <#return "select">
  <#elseif domainType?starts_with("enum")>
    <#return "select">
  <#elseif domainType == "datetime">
      <#return "date">
  <#elseif attr.identifiable>
    <#return "hidden">
  <#elseif attr.name == "note">
    <#return "longtext">
  <#elseif domainType == "integer">
    <#return "number">
  <#elseif is_attribute_attachment(attr)>
    <#return "file">
  </#if>
  <#return "text">
</#function>

<#function is_attribute_create_time attr>
  <#return attr.name?contains("creat") &&
  (attr.name?ends_with('date') || attr.name?ends_with('time'))>
</#function>

<#function is_attribute_create_user attr>
  <#return attr.name?contains("creator") || attr.name?contains("create_employee")>
</#function>

<#function is_attribute_attachment attr>
  <#return attr.name?contains("attachment")>
</#function>

<#function get_api_url_short object action>
  <#return object.getLabelledOptions("name")["schema"] + "/" + object.getLabelledOptions("name")["module"] + "/" + object.name + "/" + action>
</#function>

<#function get_api_url_full object action>
  <#return  "/api/v3/common/script/" + object.getLabelledOptions("name")["schema"] + "/" + object.getLabelledOptions("name")["module"] + "/" + object.name + "/" + action>
</#function>

<#function convert_hierarchized_to_attributes wrapper>
  <#local ret = []>
  <#local obj = wrapper.object>
  <#list obj.attributes as attr>
    <#if
    attr.name == "modifier_id" ||
    attr.name == "modifier_type" ||
    attr.name == "state" ||
    attr.name == "last_modified_time">
      <#continue>
    </#if>
    <#local ret = ret + [attr]>
  </#list>
  <#if wrapper.children??>
    <#list wrapper.children as child>
      <#if child.object.getLabelledOptions("persistence")["array"] == "true">
      <#else>
        <#local childAttrs = convert_hierarchized_to_attributes(child)>
        <#local ret = ret + childAttrs>
      </#if>
    </#list>
  </#if>
  <#return ret>
</#function>

<#function convert_hierarchized_to_objects wrapper>
  <#local ret = []>
  <#local obj = wrapper.object>
  <#local ret = ret + [wrapper.object]>
  <#if wrapper.children??>
    <#list wrapper.children as child>
      <#local childObjs = convert_hierarchized_to_objects(child)>
      <#local ret = ret + childObjs>
    </#list>
  </#if>
  <#return ret>
</#function>

<#function convert_hierarchized_to_fields wrapper>
  <#local ret = []>
  <#local obj = wrapper.object>
  <#list obj.attributes as attr>
    <#if
    attr.name == "modifier_id" ||
    attr.name == "modifier_type" ||
    attr.name == "state" ||
    attr.name == "last_modified_time" ||
    attr.name == "ordinal_position" ||
    attr.name == "status" ||
    is_attribute_create_time(attr) ||
    is_attribute_create_user(attr)>
      <#continue>
    </#if>
    <#local ret = ret + [attr]>
  </#list>
  <#if wrapper.children??>
    <#list wrapper.children as child>
      <#if child.object.getLabelledOptions("persistence")["array"] == "true">
      <#else>
        <#local childAttrs = convert_hierarchized_to_fields(child)>
        <#local ret = ret + childAttrs>
      </#if>
    </#list>
  </#if>
  <#return ret>
</#function>

<#function convert_hierarchized_to_columns wrapper>
  <#local ret = []>
  <#local obj = wrapper.object>
  <#list obj.attributes as attr>
    <#if
    attr.name != "name" &&
    attr.name != "type" &&
    attr.name != "serial_number" &&
    attr.name != "status" &&
    !is_attribute_create_user(attr)>
      <#continue>
    </#if>
    <#local ret = ret + [attr]>
  </#list>
  <#if wrapper.children??>
    <#list wrapper.children as child>
      <#if child.object.getLabelledOptions("persistence")["array"] == "true">
      <#else>
        <#local childAttrs = convert_hierarchized_to_columns(child)>
        <#local ret = ret + childAttrs>
      </#if>
    </#list>
  </#if>
  <#return ret>
</#function>

<#macro print_inner_params wrapper indent>
  <#assign obj = wrapper.object>
  <#if obj.getLabelledOptions("persistence")["array"] == "true">
${""?left_pad(indent)}'||${obj.getLabelledOptions("name")["schema"]}/${obj.getLabelledOptions("name")["module"]}/${obj.name}/batch': {
${""?left_pad(indent)}  ${js.nameVariable(obj.name)}s: this.assembleFromTable${js.nameType(obj.name)}(),
  <#else>
${""?left_pad(indent)}'||${obj.getLabelledOptions("name")["schema"]}/${obj.getLabelledOptions("name")["module"]}/${obj.name}/merge': {
${""?left_pad(indent)}
  </#if>
${""?left_pad(indent)}  _result_name: '${js.nameVariable(obj.name)}',
  <#list obj.attributes as attr>
    <#if attr.identifiable>
${""?left_pad(indent)}  ${modelbase.get_attribute_sql_name(attr)}: '${r"${"}${modelbase.get_attribute_sql_name(attr)}${r"}"}',
    </#if>
  </#list>
  <#if wrapper.children??>
    <#list wrapper.children as child>
<@print_inner_params wrapper=child indent=indent+2 />
    </#list>
  </#if>
${""?left_pad(indent)}},
</#macro>