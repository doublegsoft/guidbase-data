#include "DatePicker.h"
#include <QScreen>
#include <QGuiApplication>
#include <QMouseEvent>

// ==========================================
// DatePickerPopup 实现
// ==========================================
DatePickerPopup::DatePickerPopup(QWidget* parent)
  : QWidget(parent, Qt::Popup | Qt::FramelessWindowHint) {
  setAttribute(Qt::WA_DeleteOnClose, false);
  m_cursorDate = QDate::currentDate();
  initUi();
}

void DatePickerPopup::initUi() {
  QVBoxLayout* mainLayout = new QVBoxLayout(this);
  mainLayout->setContentsMargins(8, 8, 8, 8);

  // --- 1. 顶部导航栏 ---
  QHBoxLayout* headLayout = new QHBoxLayout();
  m_btnPrevYear = new QPushButton("<<", this);
  m_btnPrevMonth = new QPushButton("<", this);
  m_btnTitle = new QPushButton(this);
  m_btnNextMonth = new QPushButton(">", this);
  m_btnNextYear = new QPushButton(">>", this);

  headLayout->addWidget(m_btnPrevYear);
  headLayout->addWidget(m_btnPrevMonth);
  headLayout->addWidget(m_btnTitle, 1);
  headLayout->addWidget(m_btnNextMonth);
  headLayout->addWidget(m_btnNextYear);
  mainLayout->addLayout(headLayout);

  connect(m_btnPrevYear, &QPushButton::clicked, [this]() { onStep(-1, true); });
  connect(m_btnPrevMonth, &QPushButton::clicked, [this]() { onStep(-1, false); });
  connect(m_btnNextMonth, &QPushButton::clicked, [this]() { onStep(1, false); });
  connect(m_btnNextYear, &QPushButton::clicked, [this]() { onStep(1, true); });
  connect(m_btnTitle, &QPushButton::clicked, this, &DatePickerPopup::onTitleClicked);

  // --- 2. 堆叠视图区 (日/月/年) ---
  m_viewStack = new QStackedWidget(this);

  // (1) 日视图
  m_dayPage = new QWidget(this);
  QVBoxLayout* dayLayout = new QVBoxLayout(m_dayPage);
  dayLayout->setContentsMargins(0, 0, 0, 0);

  // 星期表头
  QHBoxLayout* weekHeadLayout = new QHBoxLayout();
  const QStringList weekdays = {"日", "一", "二", "三", "四", "五", "六"};
  for (const QString& w : weekdays) {
    QLabel* lbl = new QLabel(w, m_dayPage);
    lbl->setAlignment(Qt::AlignCenter);
    weekHeadLayout->addWidget(lbl);
  }
  dayLayout->addLayout(weekHeadLayout);

  // 42个日期格子 (6 * 7)
  QGridLayout* daysGrid = new QGridLayout();
  daysGrid->setSpacing(2);
  for (int i = 0; i < 42; ++i) {
    QPushButton* btn = new QPushButton(m_dayPage);
    btn->setFixedSize(30, 26);
    connect(btn, &QPushButton::clicked, this, &DatePickerPopup::onDayClicked);
    daysGrid->addWidget(btn, i / 7, i % 7);
    m_dayButtons.append(btn);
  }
  dayLayout->addLayout(daysGrid);
  m_viewStack->addWidget(m_dayPage);

  // (2) 月视图
  m_monthPage = new QWidget(this);
  QGridLayout* monthGrid = new QGridLayout(m_monthPage);
  for (int i = 0; i < 12; ++i) {
    QPushButton* btn = new QPushButton(QString("%1月").arg(i + 1, 2, 10, QChar('0')), m_monthPage);
    btn->setProperty("monthVal", i + 1);
    connect(btn, &QPushButton::clicked, this, &DatePickerPopup::onMonthClicked);
    monthGrid->addWidget(btn, i / 3, i % 3);
    m_monthButtons.append(btn);
  }
  m_viewStack->addWidget(m_monthPage);

  // (3) 年视图
  m_yearPage = new QWidget(this);
  QGridLayout* yearGrid = new QGridLayout(m_yearPage);
  for (int i = 0; i < 12; ++i) {
    QPushButton* btn = new QPushButton(m_yearPage);
    connect(btn, &QPushButton::clicked, this, &DatePickerPopup::onYearClicked);
    yearGrid->addWidget(btn, i / 3, i % 3);
    m_yearButtons.append(btn);
  }
  m_viewStack->addWidget(m_yearPage);

  mainLayout->addWidget(m_viewStack);

  // --- 3. 底部栏 ---
  QHBoxLayout* footLayout = new QHBoxLayout();
  QPushButton* btnClear = new QPushButton("重置", this);
  QPushButton* btnToday = new QPushButton("今天", this);
  footLayout->addWidget(btnClear);
  footLayout->addStretch();
  footLayout->addWidget(btnToday);
  mainLayout->addLayout(footLayout);

  connect(btnClear, &QPushButton::clicked, this, &DatePickerPopup::onClearClicked);
  connect(btnToday, &QPushButton::clicked, this, &DatePickerPopup::onTodayClicked);
}

void DatePickerPopup::setDateRange(const QDate& minDate, const QDate& maxDate) {
  m_minDate = minDate;
  m_maxDate = maxDate;
}

void DatePickerPopup::setCurrentDate(const QDate& date) {
  m_selectedDate = date;
  m_cursorDate = date.isValid() ? date : QDate::currentDate();
  m_viewMode = DayView;
  updateView();
}

void DatePickerPopup::showAt(const QPoint& globalPos, int triggerHeight) {
  adjustSize();
  QSize panelSize = sizeHint();
  QScreen* screen = QGuiApplication::screenAt(globalPos);
  QRect screenGeom = screen ? screen->availableGeometry() : QRect(0, 0, 1920, 1080);

  int x = globalPos.x();
  int y = globalPos.y() + triggerHeight + 4; // 默认在下方弹出

  if (y + panelSize.height() > screenGeom.bottom()) {
    y = globalPos.y() - panelSize.height() - 4; // 下方空间不足则向上弹出
  }
  if (x + panelSize.width() > screenGeom.right()) {
    x = screenGeom.right() - panelSize.width() - 8;
  }

  move(x, y);
  show();
}

void DatePickerPopup::updateView() {
  m_viewStack->setCurrentIndex(static_cast<int>(m_viewMode));

  m_btnPrevMonth->setVisible(m_viewMode == DayView);
  m_btnNextMonth->setVisible(m_viewMode == DayView);

  if (m_viewMode == DayView) {
    m_btnTitle->setText(m_cursorDate.toString("yyyy 年 MM 月"));
    refreshDayView();
  } else if (m_viewMode == MonthView) {
    m_btnTitle->setText(m_cursorDate.toString("yyyy 年"));
    refreshMonthView();
  } else {
    int baseYear = (m_cursorDate.year() / 12) * 12;
    m_btnTitle->setText(QString("%1 - %2").arg(baseYear).arg(baseYear + 11));
    refreshYearView();
  }
}

void DatePickerPopup::refreshDayView() {
  QDate firstDay(m_cursorDate.year(), m_cursorDate.month(), 1);
  int dayOfWeek = firstDay.dayOfWeek() % 7; // 周日=0, 周一=1 ...
  QDate startDate = firstDay.addDays(-dayOfWeek);

  for (int i = 0; i < 42; ++i) {
    QDate cellDate = startDate.addDays(i);
    QPushButton* btn = m_dayButtons[i];
    btn->setText(QString::number(cellDate.day()));
    btn->setProperty("cellDate", cellDate);

    bool isCurrentMonth = (cellDate.month() == m_cursorDate.month());
    bool disabled = isDateDisabled(cellDate);

    btn->setEnabled(!disabled);
    btn->setCheckable(true);
    btn->setChecked(m_selectedDate.isValid() && (cellDate == m_selectedDate));

    if (!isCurrentMonth) {
      btn->setStyleSheet("color: gray;");
    } else {
      btn->setStyleSheet("");
    }
  }
}

void DatePickerPopup::refreshMonthView() {
  int curY = m_cursorDate.year();
  int selY = m_selectedDate.isValid() ? m_selectedDate.year() : -1;
  int selM = m_selectedDate.isValid() ? m_selectedDate.month() : -1;

  for (int i = 0; i < 12; ++i) {
    QPushButton* btn = m_monthButtons[i];
    btn->setCheckable(true);
    btn->setChecked(selY == curY && selM == (i + 1));
  }
}

void DatePickerPopup::refreshYearView() {
  int baseYear = (m_cursorDate.year() / 12) * 12;
  int selY = m_selectedDate.isValid() ? m_selectedDate.year() : -1;

  for (int i = 0; i < 12; ++i) {
    int yr = baseYear + i;
    QPushButton* btn = m_yearButtons[i];
    btn->setText(QString::number(yr));
    btn->setProperty("yearVal", yr);
    btn->setCheckable(true);
    btn->setChecked(selY == yr);
  }
}

bool DatePickerPopup::isDateDisabled(const QDate& d) const {
  if (m_minDate.isValid() && d < m_minDate) return true;
  if (m_maxDate.isValid() && d > m_maxDate) return true;
  return false;
}

void DatePickerPopup::onStep(int dir, bool byYear) {
  if (m_viewMode == DayView) {
    m_cursorDate = byYear ? m_cursorDate.addYears(dir) : m_cursorDate.addMonths(dir);
  } else if (m_viewMode == MonthView) {
    m_cursorDate = m_cursorDate.addYears(dir);
  } else {
    m_cursorDate = m_cursorDate.addYears(dir * 12);
  }
  updateView();
}

void DatePickerPopup::onTitleClicked() {
  if (m_viewMode == DayView) m_viewMode = MonthView;
  else if (m_viewMode == MonthView) m_viewMode = YearView;
  updateView();
}

void DatePickerPopup::onDayClicked() {
  QPushButton* btn = qobject_cast<QPushButton*>(sender());
  if (!btn) return;
  QDate d = btn->property("cellDate").toDate();
  m_selectedDate = d;
  emit dateSelected(d);
  close();
}

void DatePickerPopup::onMonthClicked() {
  QPushButton* btn = qobject_cast<QPushButton*>(sender());
  if (!btn) return;
  int month = btn->property("monthVal").toInt();
  m_cursorDate.setDate(m_cursorDate.year(), month, 1);
  m_viewMode = DayView;
  updateView();
}

void DatePickerPopup::onYearClicked() {
  QPushButton* btn = qobject_cast<QPushButton*>(sender());
  if (!btn) return;
  int year = btn->property("yearVal").toInt();
  m_cursorDate.setDate(year, m_cursorDate.month(), 1);
  m_viewMode = MonthView;
  updateView();
}

void DatePickerPopup::onTodayClicked() {
  QDate today = QDate::currentDate();
  if (!isDateDisabled(today)) {
    m_selectedDate = today;
    emit dateSelected(today);
    close();
  }
}

void DatePickerPopup::onClearClicked() {
  m_selectedDate = QDate();
  emit cleared();
  close();
}

// ==========================================
// DatePicker (主触发器) 实现
// ==========================================
DatePicker::DatePicker(QWidget* parent) : QWidget(parent) {
  QHBoxLayout* layout = new QHBoxLayout(this);
  layout->setContentsMargins(4, 2, 4, 2);

  m_label = new QLabel(this);
  m_btnClear = new QToolButton(this);
  m_btnClear->setText("×");
  m_btnClear->setCursor(Qt::PointingHandCursor);
  m_btnClear->hide();

  m_btnIcon = new QToolButton(this);
  m_btnIcon->setText("📅");
  m_btnIcon->setCursor(Qt::PointingHandCursor);

  layout->addWidget(m_label, 1);
  layout->addWidget(m_btnClear);
  layout->addWidget(m_btnIcon);

  m_popup = new DatePickerPopup(this);

  connect(m_popup, &DatePickerPopup::dateSelected, this, [this](const QDate& d) {
    setDate(d);
  });
  connect(m_popup, &DatePickerPopup::cleared, this, [this]() {
    setDate(QDate());
  });

  connect(m_btnClear, &QToolButton::clicked, this, [this]() {
    setDate(QDate());
  });

  updateDisplay();
}

void DatePicker::setDate(const QDate& date) {
  if (m_date != date) {
    m_date = date;
    updateDisplay();
    emit dateChanged(m_date);
  }
}

void DatePicker::setFormat(const QString& format) {
  m_format = format;
  updateDisplay();
}

void DatePicker::setPlaceholder(const QString& text) {
  m_placeholder = text;
  updateDisplay();
}

void DatePicker::setDateRange(const QDate& minDate, const QDate& maxDate) {
  m_popup->setDateRange(minDate, maxDate);
}

void DatePicker::updateDisplay() {
  if (m_date.isValid()) {
    m_label->setText(m_date.toString(m_format));
    m_btnClear->show();
  } else {
    m_label->setText(m_placeholder);
    m_btnClear->hide();
  }
}

void DatePicker::mousePressEvent(QMouseEvent* event) {
  if (event->button() == Qt::LeftButton && isEnabled()) {
    m_popup->setCurrentDate(m_date);
    m_popup->showAt(mapToGlobal(QPoint(0, 0)), height());
  }
  QWidget::mousePressEvent(event);
}