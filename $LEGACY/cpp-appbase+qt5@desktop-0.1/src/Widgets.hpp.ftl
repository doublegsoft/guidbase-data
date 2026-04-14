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

#ifndef WIDGETS_HPP
#define WIDGETS_HPP

#include <QtWidgets>

class Widgets
{

public:

  static QPlainTextEdit*    createPlainTextEdit(void);

  /*!
  ** @brief Creates a line edit to display hex string.
  **
  ** @param maxLength
  **        the max length for line edit
  **
  ** @return a line edit instance
  */
  static QLineEdit*         createLineEditHex(uint length);

  static QLineEdit*         createLineEdit(void);

  static QLabel*            createLabel(QString text);

  static QHBoxLayout*       createButtons(int count, ...);

  /*!
  **
  */
  static QHBoxLayout*       createButtons(QList<QPushButton*>& buttons);

  /*!
  ** @brief Creates form layout for each tab content widget.
  **
  ** @return a form layout instance
  */
  static QFormLayout*       createFormLayout(void);

  static QPushButton*       createPushButton(QString text);

  static QPushButton*       createPushButtonEncrypt(QString text);

  static QPushButton*       createPushButtonDecrypt(QString text);

  static QPushButton*       createPushButtonCalculate(QString text);

  static QPushButton*       createPushButtonSetting(QString text);

  static QPushButton*       createPushButtonRequest(QString text);

  static QPushButton*       createPushButtonSave(QString text);

  static QPushButton*       createPushButtonQuit(void);

public:

  static const uint         WIDGET_PLAIN_TEXT_EDIT_HEIGHT = 120;

  static const uint         WIDGET_LABEL_WIDTH = 100;

  static const uint         WIDGET_PUSH_BUTTON_WIDTH = 110;

  static const uint         WIDGET_LABEL_HEIGHT = 28;

  static const uint         WIDGET_LINE_EDIT_HEIGHT = 28;

};

#endif // WIDGETS_HPP
