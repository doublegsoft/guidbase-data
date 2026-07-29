<#import "/$/modelbase.ftl" as modelbase>
<#import "/$/guidbase4ts.ftl" as guidbase4ts>
/**
 * 极简分页数据结构
 * @param T 列表中数据项的类型
 */
export interface Pagination<T> {
  total: number;
  data: T[];     
}

export interface Option {
  value: string;
  label: string;
}
<#list model.objects as obj>

/**
 * 【${modelbase.get_object_label(obj)}】对象模型。
 */
export interface ${ts.nameType(obj.name)} {
  <#list obj.attributes as attr>
  ${modelbase.get_attribute_sql_name(attr)}: ${guidbase4ts.type_attribute_primitive(attr)} | null
  </#list>
}
</#list>
