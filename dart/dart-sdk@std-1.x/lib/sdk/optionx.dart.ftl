<#import "/$/modelbase.ftl" as modelbase>
<#import "/$/modelbase4dart.ftl" as modelbase4dart>
<#if license??>
${dart.license(license)}
</#if>
import 'base.dart';
import '/model/dto.dart';

<#assign visited_objs = {}>
<#list app.pages as page>
  <#list page.widgets as widget>
    <#if !widget.value("data")?starts_with("enum") || widget.value("data")?contains(":")><#continue></#if>
    <#assign enumVal = typebase.enumref(widget.value("data"))>
    <#assign dataObj = model.findObjectByName(enumVal.name)>
    <#if visited_objs[dataObj.name]??><#continue></#if>
    <#if (widget.type == "select" || widget.type == "multiselect")>
      <#assign visited_objs += {dataObj.name:dataObj}>

///
/// Fetches options for widget `${widget.id}`
///
Future<List<Option>> fetch${dart.nameType(modelbase.get_object_plural(dataObj))}AsOptions(Find${dart.nameType(modelbase.get_object_plural(dataObj))}Fn find${dart.nameType(modelbase.get_object_plural(dataObj))}) async {
  ${dart.nameType(dataObj.name)}Query query = ${dart.nameType(dataObj.name)}Query();
  query.limit = -1;
  final page = await find${dart.nameType(modelbase.get_object_plural(dataObj))}(query: query);
  return page.data.map((item) => Option(
    text: item.${dart.nameVariable(enumVal.text)}.toString(),
    value: item.${dart.nameVariable(enumVal.code)}.toString(),
  )).toList();
}
  <#elseif widget.type == "cascade">
    <#assign visited_objs += {dataObj.name:dataObj}>

///
/// Fetches cascaded options for widget `${widget.id}`
///
Future<List<Option>> fetch${dart.nameType(modelbase.get_object_plural(dataObj))}AsOptions(${modelbase4dart.type_attribute_primitive(dataObj.getIdentifiableAttribute())}? parentId, Find${dart.nameType(modelbase.get_object_plural(dataObj))}Fn find${dart.nameType(modelbase.get_object_plural(dataObj))}) async {
  ${dart.nameType(dataObj.name)}Query query = ${dart.nameType(dataObj.name)}Query();
  query.limit = -1;
    <#list dataObj.attributes as attr>
      <#if attr.type.name == dataObj.name>
  if (parentId != null) {
    query.${modelbase.get_attribute_sql_name(attr)} = parentId;
  }
      </#if>
    </#list>
  final page = await find${dart.nameType(modelbase.get_object_plural(dataObj))}(query: query);
  return page.data.map((item) => Option(
    text: item.${dart.nameVariable(enumVal.text)}.toString(),
    value: item.${dart.nameVariable(enumVal.code)}.toString(),
  )).toList();
}
    </#if>
  </#list>
</#list>
