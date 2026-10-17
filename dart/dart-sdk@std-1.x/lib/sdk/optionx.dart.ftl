<#import "/$/modelbase.ftl" as modelbase>
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
Future<List<Option>> fetch${dart.nameType(modelbase.get_object_plural(dataObj))}AsOptions() async {
  ${dart.nameType(dataObj.name)}Query query = new ${dart.nameType(dataObj.name)}Query();
  query.limit = -1;
  final items = await find${dart.nameType(modelbase.get_object_plural(dataObj))}(query);
  return items.map((item) => Option(
    text: item.${dart.nameVariable(enumVal.text)}.toString(),
    value: item.${dart.nameVariable(enumVal.code)}.toString(),
  )).toList();
}
  <#elseif widget.type == "cascade">
    <#assign visited_objs += {dataObj.name:dataObj}>

///
/// Fetches cascaded options for widget `${widget.id}`
///
Future<List<Option>> fetch${dart.nameType(modelbase.get_object_plural(dataObj))}AsOptions(dynamic parentId) async {
  ${dart.nameType(dataObj.name)}Query query = new ${dart.nameType(dataObj.name)}Query();
  query.limit = -1;
  // TODO: set parent id
  final items = await find${dart.nameType(modelbase.get_object_plural(dataObj))}(query);
  return items.map((item) => Option(
    text: item.${dart.nameVariable(enumVal.text)}.toString(),
    value: item.${dart.nameVariable(enumVal.code)}.toString(),
  )).toList();
}
    </#if>
  </#list>
</#list>
