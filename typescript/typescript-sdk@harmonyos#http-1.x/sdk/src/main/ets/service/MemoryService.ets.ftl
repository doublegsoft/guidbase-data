<#import "/$/modelbase.ftl" as modelbase>
<#import "/$/guidbase4ts.ftl" as guidbase4ts>
import type * as model from '../model/Model'

export class MemoryService {
<#list model.objects as obj>

  /**
   * 从内存中获取【${modelbase.get_object_label(obj)}】的分页数据。
   */
  async fetch${ts.nameType(inflector.pluralize(obj.name))}(params: Record<string, Object>, start: number = 0, limit: number = 12): Promise<model.Pagination<model.${ts.nameType(obj.name)}>> {
    const retVal: model.Pagination<model.${ts.nameType(obj.name)}> = {
      'total': 100,
      'data': [{
  <#list 1..12 as index>
    <#if index != 1>
      },{
    </#if>
    <#list obj.attributes as attr>
      '${modelbase.get_attribute_sql_name(attr)}': ${guidbase4ts.value_attribute_test(attr)},
    </#list>   
  </#list>      
      }]
    }
    return retVal;
  }

  /**
   * 从内存中获取【${modelbase.get_object_label(obj)}】的单个数据。
   */
  async fetch${ts.nameType(obj.name)}(params: Record<string, Object>): Promise<model.${ts.nameType(obj.name)} | null> {
    const retVal: model.${ts.nameType(obj.name)} = {
  <#list obj.attributes as attr>
      '${modelbase.get_attribute_sql_name(attr)}': ${guidbase4ts.value_attribute_test(attr)},
  </#list>      
    }
    return retVal;
  }
</#list>
}

