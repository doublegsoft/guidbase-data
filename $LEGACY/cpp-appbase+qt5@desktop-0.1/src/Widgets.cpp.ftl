/*
** ${app.name}
**
** Copyright (C) 2019 Christian Gann
**
** This program is free software: you can redistribute it and/or modify
** it under the terms of the GNU General Public License as published by
** the Free Software Foundation, either version 3 of the License, or
** (at your option) any later version.
**
** This program is distributed in the hope that it will be useful,
** but WITHOUT ANY WARRANTY; without even the implied warranty of
** MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
** GNU General Public License for more details.
**
** You should have received a copy of the GNU General Public License
** along with this program.  If not, see <https://www.gnu.org/licenses/>.
*/

#include "Widgets.hpp"
#include "MainWindow.hpp"

// QStatusBar* MainWindow::statusMain;

/*!
** @brief Creates a line edit instance.
**
** @return a line edit instance
*/
QLineEdit*
Widgets::createLineEdit()
{
  QLineEdit* ret = new QLineEdit;
  ret->setFixedHeight(WIDGET_LINE_EDIT_HEIGHT);
  return ret;
}

/*!
** @brief Creates form layout for each tab content widget.
**
** @return a form layout instance
*/
QFormLayout*
Widgets::createFormLayout(void)
{
  QFormLayout* ret = new QFormLayout;
  ret->setRowWrapPolicy(QFormLayout::DontWrapRows);
  ret->setFieldGrowthPolicy(QFormLayout::ExpandingFieldsGrow);
  ret->setFormAlignment(Qt::AlignLeft | Qt::AlignTop);
  ret->setLabelAlignment(Qt::AlignLeft | Qt::AlignVCenter);
  return ret;
}

/*!
** @brief Creates a label according to application GUI specification.
**
** @param text
**        the text to display
**
** @return a label instance
*/
QLabel*
Widgets::createLabel(QString text)
{
  QLabel* ret = new QLabel;
  ret->setText(text);
  ret->setFixedSize(QSize(WIDGET_LABEL_WIDTH, WIDGET_LABEL_HEIGHT));
  return ret;
}

QPushButton*
Widgets::createPushButton(QString text)
{
  QPushButton* ret = new QPushButton;
  ret->setText(text);
  ret->setFixedWidth(WIDGET_PUSH_BUTTON_WIDTH);
  return ret;
}

QHBoxLayout*
Widgets::createButtons(int count, ...)
{
  QHBoxLayout* ret = new QHBoxLayout;
  ret->setAlignment(Qt::AlignRight);
  va_list buttons;
  va_start(buttons, count);

  int i = 0;

  for (i = 0; i < count; i++)
  {
    QPushButton* button = va_arg(buttons, QPushButton*);
    ret->addWidget(button);
  }
  va_end(buttons);
  return ret;
}

QHBoxLayout*
Widgets::createButtons(QList<QPushButton*>& buttons)
{
  QHBoxLayout* ret = new QHBoxLayout;
  ret->setAlignment(Qt::AlignRight);
  for (auto& button : buttons)
    ret->addWidget(button);
  return ret;
}
