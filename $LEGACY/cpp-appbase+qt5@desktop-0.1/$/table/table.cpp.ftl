/*!
** @brief lazy-load ${cpp.nameVariable(id)} object.
**
** @return ${cpp.nameVariable(id)} instance
*/
QTableWidget* 
${cpp.nameType(pageOwner.id)}::get${cpp.nameType(id)}(void)
{
  if (${cpp.nameVariable(id)} == nullptr)
  {
    ${cpp.nameVariable(id)} = new QTableWidget(0, ${children![]?size});
    ${cpp.nameVariable(id)}->setSelectionMode(QTableWidget::SelectionMode::SingleSelection);
    ${cpp.nameVariable(id)}->setFixedHeight(300);

    QStringList headers;
<#list children as child>
  <#if child?index == 0>
    headers << QString::fromUtf8("${child.text}")
  <#elseif child?index == children?size - 1>
            << QString::fromUtf8("${child.text}");
  <#else>
            << QString::fromUtf8("${child.text}")
  </#if>
</#list>
    ${cpp.nameVariable(id)}->setHorizontalHeaderLabels(headers);

<#list children as child>
    ${cpp.nameVariable(id)}->setColumnWidth(${child?index}, 300);
</#list>

    connect(${cpp.nameVariable(id)}, &QTableWidget::clicked, this, [=]() {
      QList<QTableWidgetSelectionRange> ranges = ${cpp.nameVariable(id)}->selectedRanges();
      if (ranges.empty())
        return;
      int row = ranges.at(0).topRow();
      QTableWidgetItem* item = tableAPI->itemAt(row, 0);
      // TODO: ADD YOUR LOGIC
    });
  }
  return ${cpp.nameVariable(id)};
}