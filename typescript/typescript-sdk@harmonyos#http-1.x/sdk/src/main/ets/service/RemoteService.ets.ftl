<#import "/$/modelbase.ftl" as modelbase>
import { httpGet, httpPost, httpPut, httpDelete } from '../http/HttpUtil'
import type * as model from '../model/Model'

export class RemoteService {
<#list model.objects as obj>

  /**
   * 从服务器获取【${modelbase.get_object_label(obj)}】的分页数据。
   */
  async fetch${ts.nameType(inflector.pluralize(obj.name))}(params: Record<string, Object>, start: number = 0, limit: number = 12): Promise<model.Pagination<model.${ts.nameType(obj.name)}>> {
    const requestBody: Record<string, Object> = {}
    const paramKeys = Object.keys(params)
    requestBody['start'] = start
    requestBody['limit'] = limit
    for (let i = 0; i < paramKeys.length; i++) {
      const key = paramKeys[i]
      requestBody[key] = params[key]
    }

    try {
      const response = await httpPost<Record<string, Object>>('/${modelbase.get_object_module(obj)}/${obj.name}/find', requestBody)
      const total: number = (response.data != null ? (response.data as Record<string, Object>)['total'] : 0) as number ?? 0
      const data: model.${ts.nameType(obj.name)}[] = (response.data != null ? (response.data as Record<string, Object>)['data'] : []) as model.${ts.nameType(obj.name)}[] ?? []
      const retVal: model.Pagination<model.${ts.nameType(obj.name)}> = { total: total, data: data }
      return retVal
    } catch (error) {
      throw error as Error;
    }
  }

  /**
   * 从服务器获取【${modelbase.get_object_label(obj)}】的单个数据。
   */
  async fetch${ts.nameType(obj.name)}(params: Record<string, Object>): Promise<model.${ts.nameType(obj.name)} | null> {
    const requestBody: Record<string, Object> = {}
    const paramKeys = Object.keys(params)
    for (let i = 0; i < paramKeys.length; i++) {
      const key = paramKeys[i]
      requestBody[key] = params[key]
    }
    try {
      const response = await httpPost<Record<string, Object>>('/${modelbase.get_object_module(obj)}/${obj.name}/read', requestBody)
      const retVal: model.${ts.nameType(obj.name)} = (response.data != null ? (response.data as Record<string, Object>)['data'] : null) as model.${ts.nameType(obj.name)} ?? null
      return retVal
    } catch (error) {
      throw error as Error;
    }
  }
</#list>
}

