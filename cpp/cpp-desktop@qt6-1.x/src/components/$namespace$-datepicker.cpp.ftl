<#if license??>
${cpp.license(license)}
</#if>
#include <QGraphicsDropShadowEffect>
#include <QGuiApplication>
#include <QMouseEvent>
#include <QScreen>
#include <QStyle>

#include "${namespace}-datepicker.hpp"

namespace ${namespace} {

DatePickerPopup::DatePickerPopup(QWidget *parent)
    : QWidget(parent, Qt::Popup | Qt::FramelessWindowHint) {
  setAttribute(Qt::WA_TranslucentBackground);
  m_cursorDate = QDate::currentDate();
  initUi();
  applyStyles();
}

void DatePickerPopup::initUi() {
  QVBoxLayout *rootLayout = new QVBoxLayout(this);
  rootLayout->setContentsMargins(12, 12, 12, 12);

  m_card = new QFrame(this);
  m_card->setObjectName("dpCard");

  QGraphicsDropShadowEffect *shadow = new QGraphicsDropShadowEffect(m_card);
  shadow->setBlurRadius(24);
  shadow->setOffset(0, 6);
  shadow->setColor(QColor(0, 0, 0, 36));
  m_card->setGraphicsEffect(shadow);

  QVBoxLayout *cardLayout = new QVBoxLayout(m_card);
  cardLayout->setContentsMargins(14, 14, 14, 14);
  cardLayout->setSpacing(8);

  // 1. 顶部导航栏
  QHBoxLayout *headLayout = new QHBoxLayout();
  headLayout->setSpacing(4);

  m_btnPrevYear = new QPushButton("«", m_card);
  m_btnPrevMonth = new QPushButton("‹", m_card);
  m_btnTitle = new QPushButton(m_card);
  m_btnNextMonth = new QPushButton("›", m_card);
  m_btnNextYear = new QPushButton("»", m_card);

  m_btnPrevYear->setObjectName("navBtn");
  m_btnPrevMonth->setObjectName("navBtn");
  m_btnTitle->setObjectName("titleBtn");
  m_btnNextMonth->setObjectName("navBtn");
  m_btnNextYear->setObjectName("navBtn");

  headLayout->addWidget(m_btnPrevYear);
  headLayout->addWidget(m_btnPrevMonth);
  headLayout->addWidget(m_btnTitle, 1);
  headLayout->addWidget(m_btnNextMonth);
  headLayout->addWidget(m_btnNextYear);
  cardLayout->addLayout(headLayout);

  connect(m_btnPrevYear, &QPushButton::clicked, [this]() { onStep(-1, true); });
  connect(m_btnPrevMonth, &QPushButton::clicked,
          [this]() { onStep(-1, false); });
  connect(m_btnNextMonth, &QPushButton::clicked,
          [this]() { onStep(1, false); });
  connect(m_btnNextYear, &QPushButton::clicked, [this]() { onStep(1, true); });
  connect(m_btnTitle, &QPushButton::clicked, this,
          &DatePickerPopup::onTitleClicked);

  // 2. 堆叠视图区 (日/月/年)
  m_viewStack = new QStackedWidget(m_card);

  // (1) 日视图
  m_dayPage = new QWidget(m_viewStack);
  QVBoxLayout *dayLayout = new QVBoxLayout(m_dayPage);
  dayLayout->setContentsMargins(0, 4, 0, 0);
  dayLayout->setSpacing(4);

  QWidget *weekHeader = new QWidget(m_dayPage);
  weekHeader->setObjectName("weekHeader");
  QHBoxLayout *weekLayout = new QHBoxLayout(weekHeader);
  weekLayout->setContentsMargins(2, 4, 2, 4);

  const QStringList weekdays = {"日", "一", "二", "三", "四", "五", "六"};
  for (int i = 0; i < weekdays.size(); ++i) {
    QLabel *lbl = new QLabel(weekdays[i], weekHeader);
    lbl->setAlignment(Qt::AlignCenter);
    lbl->setObjectName(i == 0 || i == 6 ? "weekendLabel" : "weekdayLabel");
    weekLayout->addWidget(lbl);
  }
  dayLayout->addWidget(weekHeader);

  QGridLayout *daysGrid = new QGridLayout();
  daysGrid->setSpacing(3);
  for (int i = 0; i < 42; ++i) {
    QPushButton *btn = new QPushButton(m_dayPage);
    btn->setObjectName("dayBtn");
    btn->setFixedSize(32, 30);
    btn->setCursor(Qt::PointingHandCursor);
    connect(btn, &QPushButton::clicked, this, &DatePickerPopup::onDayClicked);
    daysGrid->addWidget(btn, i / 7, i % 7);
    m_dayButtons.append(btn);
  }
  dayLayout->addLayout(daysGrid);
  m_viewStack->addWidget(m_dayPage);

  // (2) 月视图
  m_monthPage = new QWidget(m_viewStack);
  QGridLayout *monthGrid = new QGridLayout(m_monthPage);
  monthGrid->setSpacing(8);
  monthGrid->setContentsMargins(0, 8, 0, 8);
  for (int i = 0; i < 12; ++i) {
    QPushButton *btn = new QPushButton(
        QString("%1 月").arg(i + 1, 2, 10, QChar('0')), m_monthPage);
    btn->setObjectName("gridBtn");
    btn->setFixedHeight(40);
    btn->setCursor(Qt::PointingHandCursor);
    btn->setProperty("monthVal", i + 1);
    connect(btn, &QPushButton::clicked, this, &DatePickerPopup::onMonthClicked);
    monthGrid->addWidget(btn, i / 3, i % 3);
    m_monthButtons.append(btn);
  }
  m_viewStack->addWidget(m_monthPage);

  // (3) 年视图
  m_yearPage = new QWidget(m_viewStack);
  QGridLayout *yearGrid = new QGridLayout(m_yearPage);
  yearGrid->setSpacing(8);
  yearGrid->setContentsMargins(0, 8, 0, 8);
  for (int i = 0; i < 12; ++i) {
    QPushButton *btn = new QPushButton(m_yearPage);
    btn->setObjectName("gridBtn");
    btn->setFixedHeight(40);
    btn->setCursor(Qt::PointingHandCursor);
    connect(btn, &QPushButton::clicked, this, &DatePickerPopup::onYearClicked);
    yearGrid->addWidget(btn, i / 3, i % 3);
    m_yearButtons.append(btn);
  }
  m_viewStack->addWidget(m_yearPage);

  cardLayout->addWidget(m_viewStack);

  // 3. 底部栏
  QFrame *line = new QFrame(m_card);
  line->setFrameShape(QFrame::HLine);
  line->setObjectName("divider");
  cardLayout->addWidget(line);

  QHBoxLayout *footLayout = new QHBoxLayout();
  footLayout->setContentsMargins(0, 2, 0, 0);

  QPushButton *btnClear = new QPushButton("重置", m_card);
  btnClear->setObjectName("btnClear");
  btnClear->setCursor(Qt::PointingHandCursor);

  QPushButton *btnToday = new QPushButton("今天", m_card);
  btnToday->setObjectName("btnToday");
  btnToday->setCursor(Qt::PointingHandCursor);

  footLayout->addWidget(btnClear);
  footLayout->addStretch();
  footLayout->addWidget(btnToday);
  cardLayout->addLayout(footLayout);

  connect(btnClear, &QPushButton::clicked, this,
          &DatePickerPopup::onClearClicked);
  connect(btnToday, &QPushButton::clicked, this,
          &DatePickerPopup::onTodayClicked);

  rootLayout->addWidget(m_card);
}

void DatePickerPopup::applyStyles() {
  setStyleSheet(R"(
    #dpCard {
      background: #f8fafc;
      border: 1px solid #e2e8f0;
      border-radius: 16px;
    }
    #navBtn {
      border: none;
      border-radius: 8px;
      background: transparent;
      color: #64748b;
      font-size: 15px;
      font-weight: bold;
      min-width: 28px;
      max-width: 28px;
      height: 28px;
    }
    #navBtn:hover {
      background: #e2e8f0;
      color: #3b82f6;
    }
    #navBtn:pressed {
      background: #cbd5e1;
    }
    #titleBtn {
      border: none;
      border-radius: 8px;
      background: transparent;
      color: #1e293b;
      font-size: 13.5px;
      font-weight: bold;
      height: 28px;
      padding: 0 8px;
    }
    #titleBtn:hover {
      background: #e2e8f0;
      color: #3b82f6;
    }
    #weekHeader {
      background: #f1f5f9;
      border-radius: 8px;
    }
    #weekdayLabel {
      color: #64748b;
      font-size: 11px;
      font-weight: 600;
    }
    #weekendLabel {
      color: #f43f5e;
      font-size: 11px;
      font-weight: 600;
    }
    #dayBtn {
      border: none;
      border-radius: 8px;
      background: transparent;
      color: #334155;
      font-size: 12px;
      font-weight: 500;
      font-family: -apple-system, "SF Pro Text", "Segoe UI", sans-serif;
    }
    #dayBtn:hover:!checked {
      background: #e0f2fe;
      color: #0284c7;
    }
    #dayBtn:checked {
      background: qlineargradient(x1:0, y1:0, x2:1, y2:1, stop:0 #3b82f6, stop:1 #2563eb);
      color: #ffffff;
      font-weight: bold;
    }
    #dayBtn:disabled {
      color: #cbd5e1;
    }
    #dayBtn[isOther="true"] {
      color: #94a3b8;
      opacity: 0.5;
    }
    #dayBtn[isToday="true"]:!checked {
      border: 1.5px solid #3b82f6;
      color: #3b82f6;
      font-weight: bold;
    }
    #gridBtn {
      border: 1px solid #e2e8f0;
      border-radius: 10px;
      background: #ffffff;
      color: #334155;
      font-size: 13px;
      font-weight: 600;
    }
    #gridBtn:hover:!checked {
      border-color: #93c5fd;
      color: #3b82f6;
      background: #eff6ff;
    }
    #gridBtn:checked {
      background: qlineargradient(x1:0, y1:0, x2:1, y2:1, stop:0 #3b82f6, stop:1 #2563eb);
      color: #ffffff;
      border: none;
    }
    #divider {
      color: #e2e8f0;
      max-height: 1px;
    }
    #btnClear {
      border: none;
      border-radius: 6px;
      background: transparent;
      color: #f43f5e;
      font-size: 12px;
      font-weight: 600;
      padding: 5px 10px;
    }
    #btnClear:hover {
      background: #ffe4e6;
    }
    #btnToday {
      border: none;
      border-radius: 8px;
      background: qlineargradient(x1:0, y1:0, x2:1, y2:1, stop:0 #3b82f6, stop:1 #2563eb);
      color: #ffffff;
      font-size: 12px;
      font-weight: 600;
      padding: 5px 14px;
    }
    #btnToday:hover {
      background: #1d4ed8;
    }
  )");
}

void DatePickerPopup::setDateRange(const QDate &minDate, const QDate &maxDate) {
  m_minDate = minDate;
  m_maxDate = maxDate;
}

void DatePickerPopup::setCurrentDate(const QDate &date) {
  m_selectedDate = date;
  m_cursorDate = date.isValid() ? date : QDate::currentDate();
  m_viewMode = DayView;
  updateView();
}

void DatePickerPopup::showAt(const QPoint &globalPos, int triggerHeight) {
  adjustSize();
  QSize panelSize = sizeHint();
  QScreen *screen = QGuiApplication::screenAt(globalPos);
  QRect screenGeom =
      screen ? screen->availableGeometry() : QRect(0, 0, 1920, 1080);

  int x = globalPos.x() - 12;
  int y = globalPos.y() + triggerHeight - 4;

  if (y + panelSize.height() > screenGeom.bottom()) {
    y = globalPos.y() - panelSize.height() + 12;
  }
  if (x + panelSize.width() > screenGeom.right()) {
    x = screenGeom.right() - panelSize.width();
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
  int dayOfWeek = firstDay.dayOfWeek() % 7;
  QDate startDate = firstDay.addDays(-dayOfWeek);
  QDate today = QDate::currentDate();

  for (int i = 0; i < 42; ++i) {
    QDate cellDate = startDate.addDays(i);
    QPushButton *btn = m_dayButtons[i];
    btn->setText(QString::number(cellDate.day()));
    btn->setProperty("cellDate", cellDate);

    bool isOther = (cellDate.month() != m_cursorDate.month());
    bool isToday = (cellDate == today);
    bool disabled = isDateDisabled(cellDate);

    btn->setEnabled(!disabled);
    btn->setCheckable(true);
    btn->setChecked(m_selectedDate.isValid() && (cellDate == m_selectedDate));

    btn->setProperty("isOther", isOther);
    btn->setProperty("isToday", isToday);

    btn->style()->unpolish(btn);
    btn->style()->polish(btn);
  }
}

void DatePickerPopup::refreshMonthView() {
  int curY = m_cursorDate.year();
  int selY = m_selectedDate.isValid() ? m_selectedDate.year() : -1;
  int selM = m_selectedDate.isValid() ? m_selectedDate.month() : -1;

  for (int i = 0; i < 12; ++i) {
    QPushButton *btn = m_monthButtons[i];
    btn->setCheckable(true);
    btn->setChecked(selY == curY && selM == (i + 1));
  }
}

void DatePickerPopup::refreshYearView() {
  int baseYear = (m_cursorDate.year() / 12) * 12;
  int selY = m_selectedDate.isValid() ? m_selectedDate.year() : -1;

  for (int i = 0; i < 12; ++i) {
    int yr = baseYear + i;
    QPushButton *btn = m_yearButtons[i];
    btn->setText(QString::number(yr));
    btn->setProperty("yearVal", yr);
    btn->setCheckable(true);
    btn->setChecked(selY == yr);
  }
}

bool DatePickerPopup::isDateDisabled(const QDate &d) const {
  if (m_minDate.isValid() && d < m_minDate)
    return true;
  if (m_maxDate.isValid() && d > m_maxDate)
    return true;
  return false;
}

void DatePickerPopup::onStep(int dir, bool byYear) {
  if (m_viewMode == DayView) {
    m_cursorDate =
        byYear ? m_cursorDate.addYears(dir) : m_cursorDate.addMonths(dir);
  } else if (m_viewMode == MonthView) {
    m_cursorDate = m_cursorDate.addYears(dir);
  } else {
    m_cursorDate = m_cursorDate.addYears(dir * 12);
  }
  updateView();
}

void DatePickerPopup::onTitleClicked() {
  if (m_viewMode == DayView)
    m_viewMode = MonthView;
  else if (m_viewMode == MonthView)
    m_viewMode = YearView;
  updateView();
}

void DatePickerPopup::onDayClicked() {
  QPushButton *btn = qobject_cast<QPushButton *>(sender());
  if (!btn)
    return;
  QDate d = btn->property("cellDate").toDate();
  m_selectedDate = d;
  emit dateSelected(d);
  close();
}

void DatePickerPopup::onMonthClicked() {
  QPushButton *btn = qobject_cast<QPushButton *>(sender());
  if (!btn)
    return;
  int month = btn->property("monthVal").toInt();
  m_cursorDate.setDate(m_cursorDate.year(), month, 1);
  m_viewMode = DayView;
  updateView();
}

void DatePickerPopup::onYearClicked() {
  QPushButton *btn = qobject_cast<QPushButton *>(sender());
  if (!btn)
    return;
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
DatePicker::DatePicker(QWidget *parent) : QWidget(parent) {
  setCursor(Qt::PointingHandCursor);

  QVBoxLayout *outer = new QVBoxLayout(this);
  outer->setContentsMargins(0, 0, 0, 0);

  m_container = new QFrame(this);
  m_container->setObjectName("dpInput");

  QHBoxLayout *layout = new QHBoxLayout(m_container);
  layout->setContentsMargins(12, 0, 10, 0);
  layout->setSpacing(6);

  m_label = new QLabel(this);
  m_label->setObjectName("dpLabel");

  m_btnClear = new QToolButton(this);
  m_btnClear->setObjectName("dpClear");
  m_btnClear->setText("✕");
  m_btnClear->setCursor(Qt::PointingHandCursor);
  m_btnClear->hide();

  m_icon = new QLabel("📅", this);
  m_icon->setObjectName("dpIcon");

  layout->addWidget(m_label, 1);
  layout->addWidget(m_btnClear);
  layout->addWidget(m_icon);

  outer->addWidget(m_container);

  m_popup = new DatePickerPopup(this);

  connect(m_popup, &DatePickerPopup::dateSelected, this,
          [this](const QDate &d) { setDate(d); });
  connect(m_popup, &DatePickerPopup::cleared, this,
          [this]() { setDate(QDate()); });
  connect(m_btnClear, &QToolButton::clicked, this,
          [this]() { setDate(QDate()); });

  applyStyles();
  updateDisplay();
}

void DatePicker::applyStyles() {
  setStyleSheet(R"(
    #dpInput {
      background: #ffffff;
      border: 1.5px solid #cbd5e1;
      border-radius: 10px;
      min-height: 36px;
      max-height: 36px;
    }
    #dpInput:hover {
      border-color: #93c5fd;
    }
    #dpLabel {
      color: #1e293b;
      font-size: 13px;
      font-weight: 500;
      font-family: -apple-system, "SF Mono", "Menlo", monospace;
    }
    #dpLabel[isPlaceholder="true"] {
      color: #94a3b8;
    }
    #dpClear {
      border: none;
      background: #f1f5f9;
      color: #94a3b8;
      border-radius: 8px;
      min-width: 16px;
      max-width: 16px;
      height: 16px;
      font-size: 9px;
      font-weight: bold;
    }
    #dpClear:hover {
      background: #fecdd3;
      color: #e11d48;
    }
    #dpIcon {
      font-size: 13px;
      color: #64748b;
    }
  )");
}

void DatePicker::setDate(const QDate &date) {
  if (m_date != date) {
    m_date = date;
    updateDisplay();
    emit dateChanged(m_date);
  }
}

void DatePicker::setFormat(const QString &format) {
  m_format = format;
  updateDisplay();
}

void DatePicker::setPlaceholder(const QString &text) {
  m_placeholder = text;
  updateDisplay();
}

void DatePicker::setDateRange(const QDate &minDate, const QDate &maxDate) {
  m_popup->setDateRange(minDate, maxDate);
}

void DatePicker::updateDisplay() {
  if (m_date.isValid()) {
    m_label->setText(m_date.toString(m_format));
    m_label->setProperty("isPlaceholder", false);
  } else {
    m_label->setText(m_placeholder);
    m_label->setProperty("isPlaceholder", true);
  }
  m_label->style()->unpolish(m_label);
  m_label->style()->polish(m_label);
}

void DatePicker::enterEvent(QEnterEvent *event) {
  if (m_date.isValid() && isEnabled()) {
    m_btnClear->show();
  }
  QWidget::enterEvent(event);
}

void DatePicker::leaveEvent(QEvent *event) {
  m_btnClear->hide();
  QWidget::leaveEvent(event);
}

void DatePicker::mousePressEvent(QMouseEvent *event) {
  if (event->button() == Qt::LeftButton && isEnabled()) {
    m_popup->setCurrentDate(m_date);
    m_popup->showAt(mapToGlobal(QPoint(0, 0)), height());
  }
  QWidget::mousePressEvent(event);
}

} // namespace