#pragma once

#include <QWidget>
#include <QDate>
#include <QLabel>
#include <QToolButton>
#include <QPushButton>
#include <QStackedWidget>
#include <QGridLayout>
#include <QVBoxLayout>
#include <QHBoxLayout>

// ==========================================
// 1. 日历弹窗面板 (DatePickerPopup)
// ==========================================
class DatePickerPopup : public QWidget {
  Q_OBJECT
public:
  enum ViewMode { DayView = 0, MonthView = 1, YearView = 2 };

  explicit DatePickerPopup(QWidget* parent = nullptr);

  void setDateRange(const QDate& minDate, const QDate& maxDate);
  void setCurrentDate(const QDate& date);
  void showAt(const QPoint& globalPos, int triggerHeight);

signals:
  void dateSelected(const QDate& date);
  void cleared();

private slots:
  void onStep(int dir, bool byYear);
  void onTitleClicked();
  void onDayClicked();
  void onMonthClicked();
  void onYearClicked();
  void onTodayClicked();
  void onClearClicked();

private:
  void initUi();
  void updateView();
  void refreshDayView();
  void refreshMonthView();
  void refreshYearView();
  bool isDateDisabled(const QDate& d) const;

  ViewMode m_viewMode = DayView;
  QDate m_cursorDate;    // 当前视图浏览的年月
  QDate m_selectedDate;  // 选中的日期
  QDate m_minDate;
  QDate m_maxDate;

  // UI 元素
  QPushButton* m_btnPrevYear;
  QPushButton* m_btnPrevMonth;
  QPushButton* m_btnTitle;
  QPushButton* m_btnNextMonth;
  QPushButton* m_btnNextYear;

  QStackedWidget* m_viewStack;
  QWidget* m_dayPage;
  QWidget* m_monthPage;
  QWidget* m_yearPage;

  QList<QPushButton*> m_dayButtons;   // 6行7列 = 42个单元格
  QList<QPushButton*> m_monthButtons; // 12个月
  QList<QPushButton*> m_yearButtons;  // 12年跨度
};

// ==========================================
// 2. 外部主触发控件 (DatePicker)
// ==========================================
class DatePicker : public QWidget {
  Q_OBJECT
  Q_PROPERTY(QDate date READ date WRITE setDate NOTIFY dateChanged)

public:
  explicit DatePicker(QWidget* parent = nullptr);

  QDate date() const { return m_date; }
  void setDate(const QDate& date);

  void setFormat(const QString& format);
  void setPlaceholder(const QString& text);
  void setDateRange(const QDate& minDate, const QDate& maxDate);

signals:
  void dateChanged(const QDate& date);

protected:
  void mousePressEvent(QMouseEvent* event) override;

private:
  void updateDisplay();

  QDate m_date;
  QString m_format = "yyyy-MM-dd";
  QString m_placeholder = "YYYY-MM-DD";

  QLabel* m_label;
  QToolButton* m_btnClear;
  QToolButton* m_btnIcon;
  DatePickerPopup* m_popup;
};