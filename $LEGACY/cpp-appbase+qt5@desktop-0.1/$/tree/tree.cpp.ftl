QTreeWidget*
${cpp.nameType(pageOwner.id)}::get${cpp.nameType(id)}(void)
{
  if (!${cpp.nameVariable(id)})
  {
    const QFont font(QString::fromUtf8("宋体"), 12);

    ${cpp.nameVariable(id)} = new QTreeWidget;
    ${cpp.nameVariable(id)}->setHeaderHidden(true);

    QPixmap pixmapTemplate("res/template.png");
    QPixmap pixmapDatabase("res/database.png");

    QTreeWidgetItem* item = new QTreeWidgetItem;
    item->setText(0, QString::fromUtf8("数据库"));
    item->setIcon(0, QIcon(pixmapDatabase));
    item->setFont(0, font);
    ${cpp.nameVariable(id)}->addTopLevelItem(item);

    item = new QTreeWidgetItem;
    item->setText(0, QString::fromUtf8("工作区"));
    item->setIcon(0, QIcon(pixmapTemplate));
    item->setFont(0, font);
    ${cpp.nameVariable(id)}->addTopLevelItem(item);

    QTreeWidgetItem* subitem = new QTreeWidgetItem;
    subitem->setText(0, QString::fromUtf8("XXXX"));
    item->addChild(subitem);
  }
  return ${cpp.nameVariable(id)};
}