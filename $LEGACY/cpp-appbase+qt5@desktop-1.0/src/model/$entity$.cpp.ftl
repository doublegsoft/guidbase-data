<#import '/$/modelbase.ftl' as modelbase>
<#import '/$/qt5.ftl' as qt5>
<#if license??>
${cpp.license(license)}
</#if>

#include "${cpp.nameFile(entity.name)}.hpp"

${cpp.nameType(entity.name)}::${cpp.nameType(entity.name)}(void)
{

}

${cpp.nameType(entity.name)}::~${cpp.nameType(entity.name)}(void)
{
<#list entity.attributes as attr>
  <#if attr.type.custom>
  <#--delete ${cpp.nameVariable(attr.name)};-->
  <#elseif attr.type.collection && attr.type.componentType.custom>
  for (auto* ${cpp.nameVariable(attr.getLabelledOptions('name')['singular'])} : ${cpp.nameVariable(attr.name)})
    delete ${cpp.nameVariable(attr.getLabelledOptions('name')['singular'])};
  </#if>
</#list>  
}

void 
${cpp.nameType(entity.name)}::fromJSON(const QJsonObject& json)
{
<#list entity.attributes as attr>
  <#if attr.type.custom><#continue></#if>
  <#if attr.type.collection && attr.type.componentType.custom>
  QJsonArray array${cpp.nameType(attr.name)} = json["${cpp.nameVariable(attr.name)}"].toArray();
  for (auto item : array${cpp.nameType(attr.name)})
  {
    ${cpp.nameType(attr.type.componentType.name)}* ${cpp.nameVariable(attr.type.componentType.name)} = new ${cpp.nameType(attr.type.componentType.name)};
    ${cpp.nameVariable(attr.type.componentType.name)}->fromJSON(item.toObject());
    ${cpp.nameVariable(attr.name)}.append(${cpp.nameVariable(attr.type.componentType.name)});
  }
  <#else>
  set${cpp.nameType(attr.name)}(json["${js.nameVariable(attr.name)}"].${qt5.to_type_name(attr.type)}());
  </#if>
</#list>
}

QJsonObject 
${cpp.nameType(entity.name)}::toJSON(void)
{
  QJsonObject ret;
<#list entity.attributes as attr>
  <#if attr.type.custom><#continue></#if>
  <#if attr.type.collection && attr.type.componentType.custom>
  QJsonArray array${cpp.nameType(attr.name)};
  for (auto item : ${cpp.nameVariable(attr.name)})
  {
    QJsonObject jsonItem = item->toJSON();
    array${cpp.nameType(attr.name)}.append(jsonItem);
  }
  ret["${js.nameVariable(attr.name)}"] = array${cpp.nameType(attr.name)};
  <#else>
  ret["${js.nameVariable(attr.name)}"] = ${js.nameVariable(attr.name)};
  </#if>
</#list>
  return ret;
}
<#list entity.attributes as attr>
  <#if attr.type.custom><#continue></#if>

<#if !qt5.is_primitive(attr)>const </#if>${qt5.type_name(attr.type)}<#if !qt5.is_primitive(attr)>&</#if> 
${cpp.nameType(entity.name)}::get${cpp.nameType(attr.name)}(void)<#if !qt5.is_primitive(attr)> const</#if>
{
  return this->${cpp.nameVariable(attr.name)};
}
  
  <#if attr.type.collection>
void
${cpp.nameType(entity.name)}::add${cpp.nameType(attr.getLabelledOptions('name')['singular'])}(${qt5.type_name(attr.type.componentType)} ${cpp.nameVariable(attr.getLabelledOptions('name')['singular'])})
{
  this->${cpp.nameVariable(attr.name)}.append(${cpp.nameVariable(attr.getLabelledOptions('name')['singular'])});
}

void
${cpp.nameType(entity.name)}::remove${cpp.nameType(attr.getLabelledOptions('name')['singular'])}(${qt5.type_name(attr.type.componentType)} ${cpp.nameVariable(attr.getLabelledOptions('name')['singular'])})
{
  this->${cpp.nameVariable(attr.name)}.removeOne(${cpp.nameVariable(attr.getLabelledOptions('name')['singular'])});
}
  <#else>
void 
${cpp.nameType(entity.name)}::set${cpp.nameType(attr.name)}(${qt5.type_name(attr.type)} ${cpp.nameVariable(attr.name)})
{
  this->${cpp.nameVariable(attr.name)} = ${cpp.nameVariable(attr.name)};
}
  </#if>
</#list>  