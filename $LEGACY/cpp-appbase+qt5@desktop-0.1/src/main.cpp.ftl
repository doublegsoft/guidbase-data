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

#include <QApplication>

#include "MainWindow.hpp"

#define   MAIN_WINDOW_WIDTH       800
#define   MAIN_WINDOW_HEIGHT      600
#define   APPLICATION_TITLE       ""

int main(int argc, char *argv[])
{
  QApplication app(argc, argv);
  MainWindow window;

  window.setFixedSize(QSize(MAIN_WINDOW_WIDTH, MAIN_WINDOW_HEIGHT));
  window.setWindowFlags(Qt::Window | Qt::MSWindowsFixedSizeDialogHint);
  window.setWindowTitle(QString::fromUtf8(APPLICATION_TITLE));
  window.show(); 

  return app.exec();
}


