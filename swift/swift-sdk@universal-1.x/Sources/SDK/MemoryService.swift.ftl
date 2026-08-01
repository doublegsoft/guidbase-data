<#import "/$/modelbase.ftl" as modelbase>
<#import "/$/guidbase4swift.ftl" as guidbase4swift>
import Foundation

class MemoryService {
<#list model.objects as obj>

  /**
   * 从内存中获取【${modelbase.get_object_label(obj)}】的分页数据。
   */
  func fetch${ts.nameType(inflector.pluralize(obj.name))}(params: [String: Any], start: Int = 0, limit: Int = 12) async -> Pagination<${ts.nameType(obj.name)}> {
    let retVal = Pagination<${ts.nameType(obj.name)}>(
      total: 100,
      data: [
  <#list 1..12 as index>
        ${ts.nameType(obj.name)}(
    <#list obj.attributes as attr>
          ${modelbase.get_attribute_sql_name(attr)}: ${guidbase4swift.value_attribute_test(attr)}<#if attr_has_next>,</#if>
    </#list>
        )<#if index != 12>,</#if>
  </#list>
      ]
    )
    return retVal
  }

  /**
   * 从内存中获取【${modelbase.get_object_label(obj)}】的单个数据。
   */
  func fetch${ts.nameType(obj.name)}(params: [String: Any]) async -> ${ts.nameType(obj.name)}? {
    let retVal = ${ts.nameType(obj.name)}(
  <#list obj.attributes as attr>
      ${modelbase.get_attribute_sql_name(attr)}: ${guidbase4swift.value_attribute_test(attr)}<#if attr_has_next>,</#if>
  </#list>
    )
    return retVal
  }
</#list>
}