<#import '/$/modelbase.ftl' as modelbase>
<#import '/$/qt5.ftl' as qt5>
<#if license??>
${cpp.license(license)}
</#if>
<#assign iterableName = entity.getLabelledOptions('entity')['iterable']!'TODO'>

#include <QtCore>

#include "${cpp.nameFile(iterableName)}.hpp"

${cpp.nameType(iterableName)}::${cpp.nameType(iterableName)}(void)
{

}

${cpp.nameType(iterableName)}::~${cpp.nameType(iterableName)}(void)
{
  for (auto* ${cpp.nameVariable(entity.getLabelledOptions('name')['singular'])} : ${cpp.nameVariable(entity.getLabelledOptions('name')['plural'])}) 
    delete ${cpp.nameVariable(entity.getLabelledOptions('name')['singular'])};
}

void
${cpp.nameType(iterableName)}::fromJSON(const QJsonArray& array)
{
  for(auto item : array)
  {
    const QJsonObject& jsonItem = item.toObject();
    ${cpp.nameType(entity.name)}* ${cpp.nameVariable(entity.name)} = new ${cpp.nameType(entity.name)}();
    ${cpp.nameVariable(entity.name)}->fromJSON(jsonItem);
    add${cpp.nameType(entity.name)}(${cpp.nameVariable(entity.name)});
  }
}

QJsonArray 
${cpp.nameType(iterableName)}::toJSON(void)
{
  QJsonArray ret;
  for (auto* item : ${cpp.nameVariable(entity.getLabelledOptions('name')['plural'])})
  {
    QJsonObject jsonItem = item->toJSON();
    ret.append(jsonItem);
  }
  return ret;
}

void 
${cpp.nameType(iterableName)}::add${cpp.nameType(entity.name)}(${cpp.nameType(entity.name)}* ${cpp.nameVariable(entity.name)})
{
  this->${cpp.nameVariable(entity.getLabelledOptions('name')['plural'])}.append(${cpp.nameVariable(entity.name)});
}

const QList<${cpp.nameType(entity.name)}*>& 
${cpp.nameType(iterableName)}::get${cpp.nameType(entity.getLabelledOptions('name')['plural'])}(void) const
{
  return this->${cpp.nameVariable(entity.getLabelledOptions('name')['plural'])};
}
