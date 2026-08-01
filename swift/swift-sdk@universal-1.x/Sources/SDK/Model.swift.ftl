<#import "/$/modelbase.ftl" as modelbase>
<#import "/$/guidbase4swift.ftl" as guidbase4swift>
import Foundation

/**
 * 极简分页数据结构
 * @param T 列表中数据项的类型
 */
struct Pagination<T: Codable>: Codable {
    var total: Int
    var data: [T]
}

/**
 * 下拉及多选选项数据结构
 */
struct Option: Codable, Identifiable, Hashable {
    // 适配 SwiftUI 的 Identifiable 协议，使用 value 作为唯一标识
    var id: String { value }
    var value: String
    var label: String
}
<#list model.objects as obj>

/**
 * 【${modelbase.get_object_label(obj)}】对象模型。
 */
struct ${ts.nameType(obj.name)}: Codable {
  <#list obj.attributes as attr>
    var ${modelbase.get_attribute_sql_name(attr)}: ${guidbase4swift.type_attribute_primitive(attr)}?
  </#list>
}
</#list>