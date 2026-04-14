/*
** EngineTool SPAAS
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

#ifndef MAIN_WINDOW_HPP
#define MAIN_WINDOW_HPP

#include <QtWidgets>

class MainWindow : public QMainWindow
{
  Q_OBJECT

public:

  MainWindow(QWidget* parent = nullptr);

  ~MainWindow();

protected:

  void                  closeEvent(QCloseEvent *event) override;

private:

  void                  initialize(void);

  QSystemTrayIcon*      getApplicationTray(void);

private slots:

  void                  iconActivated(QSystemTrayIcon::ActivationReason reason);

private:

  QSystemTrayIcon*      trayApplication = nullptr;

};

#endif // MAIN_WINDOW_HPP
