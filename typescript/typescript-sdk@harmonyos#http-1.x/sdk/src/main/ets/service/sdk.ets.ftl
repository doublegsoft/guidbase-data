<#import "/$/modelbase.ftl" as modelbase>
<#import "/$/guidbase4ts.ftl" as guidbase4ts>
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
<#assign optionResources = {}>
<#list app.pages as page>
  <#list page.inputs as input>
    <#if input.value("data") == ""><#continue></#if>
    <#if input.value("data")?starts_with("enum[")>
      <#assign opts = typebase.enumtype(input.value("data"))>
      
  static get${ts.nameType(input.id)}Options(): model.Option[] {
    return [{
      <#list opts as opt>
        <#if opt?index != 0>
    },{        
        </#if>
      'value': '${opt.code}', 'label': '${opt.text}',
      </#list>      
    }];
  }
    <#else>
      <#assign url = valuebase.url(input.value("data"))>
      <#if optionResources[url.resource]??><#continue></#if>
      <#assign optionResources += {url.resource: url}>

  static async fetch${ts.nameType(url.resource)}AsOptions(): Promise<model.Option[]> {
    const retVal: model.Option[] = [];
    const response = await sdk.service.fetch${ts.nameType(inflector.pluralize(url.resource))}({ 'start': 0, 'limit': -1 });
    const rows = response.data || []; 
    rows.forEach(row => {
      const opt: model.Option = {
        'value': String(row.${ts.nameVariable(input.value("value"))}),
        'label': String(row.${ts.nameVariable(input.value("label"))}),
      }
      retVal.push(opt)
    });
    return retVal
  }
    </#if>
  </#list>
</#list>
<#list model.objects as obj>

  static new${ts.nameType(obj.name)}(): model.${ts.nameType(obj.name)} {
    return {
  <#list obj.attributes as attr>
    <#assign tsType = guidbase4ts.type_attribute_primitive(attr)>
    <#if tsType == "number">
      ${modelbase.get_attribute_sql_name(attr)}: null,
    <#elseif tsType == "number">
      ${modelbase.get_attribute_sql_name(attr)}: false,
    <#else>
      ${modelbase.get_attribute_sql_name(attr)}: '',
    </#if>
  </#list>
    };
  }
</#list>
}
