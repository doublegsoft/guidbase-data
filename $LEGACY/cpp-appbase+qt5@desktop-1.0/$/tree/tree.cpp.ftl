QTreeWidget*
MainWindow::get${java.nameType(id)}(void)
{
  if (!${java.nameVariable(id)})
  {
    ${java.nameVariable(id)} = new QTreeWidget;
    ${java.nameVariable(id)}->setHeaderHidden(true);
    ${java.nameVariable(id)}->setContextMenuPolicy(Qt::CustomContextMenu);
    connect(${java.nameVariable(id)}, &QTreeWidget::customContextMenuRequested, this, [=](const QPoint& point) {
      QList<QTreeWidgetItem*> items = ${java.nameVariable(id)}->selectedItems();
      if (items.size() == 0) {
        return;
      }
    });
    connect(${java.nameVariable(id)}, &QTreeWidget::itemSelectionChanged, this, [=](){
      // change workspace selected
      QTreeWidgetItem* selectionTop = getSelectedTreeItemWorkspace();
      QVariant data = selectionTop->data(0, Qt::UserRole);
      observable.setProperty(PROP_SELECTED_WORKSPACE, data);
    });
  }
  return ${java.nameVariable(id)};
}