<#import "/$/modelbase.ftl" as modelbase>
<#import "/$/guidbase4swift.ftl" as guidbase4swift>
import Foundation

class SDK {

  private static let service = MemoryService()
<#list model.objects as obj>

  /**
   * 从内存中获取【${modelbase.get_object_label(obj)}】的分页数据。
   */
  static func fetch${ts.nameType(inflector.pluralize(obj.name))}(params: [String: Any], start: Int = 0, limit: Int = 12) async -> Pagination<${ts.nameType(obj.name)}> {
    return await SDK.service.fetch${ts.nameType(inflector.pluralize(obj.name))}(params: params, start: start, limit: limit)
  }

  /**
   * 从内存中获取【${modelbase.get_object_label(obj)}】的单个数据。
   */
  static func fetch${ts.nameType(obj.name)}(params: [String: Any]) async -> ${ts.nameType(obj.name)}? {
    return await SDK.service.fetch${ts.nameType(obj.name)}(params: params)
  }
</#list>
<#assign optionResources = {}>
<#list app.pages as page>
  <#list page.inputs as input>
    <#if input.value("data") == ""><#continue></#if>
    <#if input.value("data")?starts_with("enum[")>
      <#assign opts = typebase.enumtype(input.value("data"))>
      
  static func get${ts.nameType(input.id)}Options() -> [Option] {
    return [
      <#list opts as opt>
        Option(value: "${opt.code}", label: "${opt.text}")<#if opt_has_next>,</#if>
      </#list>      
    ]
  }
    <#else>
      <#assign url = valuebase.url(input.value("data"))>
      <#if optionResources[url.resource]??><#continue></#if>
      <#assign optionResources += {url.resource: url}>

  static func fetch${ts.nameType(url.resource)}AsOptions() async -> [Option] {
    var retVal: [Option] = []
    let response = await SDK.service.fetch${ts.nameType(inflector.pluralize(url.resource))}(params: ["start": 0, "limit": -1])
    let rows = response.data
    for row in rows {
      let opt = Option(
        value: row.${ts.nameVariable(input.value("value"))} != nil ? String(describing: row.${ts.nameVariable(input.value("value"))}!) : "",
        label: row.${ts.nameVariable(input.value("label"))} != nil ? String(describing: row.${ts.nameVariable(input.value("label"))}!) : ""
      )
      retVal.append(opt)
    }
    return retVal
  }
    </#if>
  </#list>
</#list>
<#list model.objects as obj>

  static func new${ts.nameType(obj.name)}() -> ${ts.nameType(obj.name)} {
    return ${ts.nameType(obj.name)}(
  <#list obj.attributes as attr>
    <#assign swiftType = guidbase4swift.type_attribute_primitive(attr)>
    <#if swiftType == "Int" || swiftType == "Double">
      ${modelbase.get_attribute_sql_name(attr)}: nil<#if attr_has_next>,</#if>
    <#elseif swiftType == "Bool">
      ${modelbase.get_attribute_sql_name(attr)}: false<#if attr_has_next>,</#if>
    <#elseif swiftType == "String">
      ${modelbase.get_attribute_sql_name(attr)}: ""<#if attr_has_next>,</#if>
    <#else>
      ${modelbase.get_attribute_sql_name(attr)}: nil<#if attr_has_next>,</#if>
    </#if>
  </#list>
    )
  }
</#list>
}