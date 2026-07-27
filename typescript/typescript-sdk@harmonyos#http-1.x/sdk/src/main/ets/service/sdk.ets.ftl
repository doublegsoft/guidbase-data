<#import "/$/modelbase.ftl" as modelbase>
import { MemoryService } from './MemoryService'
import type * as model from '../model/Model'

export class sdk {

  private static service: MemoryService = new MemoryService()
<#list model.objects as obj>

  /**
   * 从内存中获取【${modelbase.get_object_label(obj)}】的分页数据。
   */
  static async fetch${ts.nameType(inflector.pluralize(obj.name))}(params: Record<string, Object>, start: number = 0, limit: number = 12): Promise<model.Pagination<model.${ts.nameType(obj.name)}>> {
    return sdk.service.fetch${ts.nameType(inflector.pluralize(obj.name))}(params, start, limit);
  }

  /**
   * 从内存中获取【${modelbase.get_object_label(obj)}】的单个数据。
   */
  static async fetch${ts.nameType(obj.name)}(params: Record<string, Object>): Promise<model.${ts.nameType(obj.name)} | null> {
    return sdk.service.fetch${ts.nameType(obj.name)}(params);
  }
</#list>

}
