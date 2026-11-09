<#if license??>
${cpp.license(license)}
</#if>
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
#include <QFrame>

namespace ${namespace} {

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
  void applyStyles();
  void updateView();
  void refreshDayView();
  void refreshMonthView();
  void refreshYearView();
  bool isDateDisabled(const QDate& d) const;

  ViewMode m_viewMode = DayView;
  QDate m_cursorDate;
  QDate m_selectedDate;
  QDate m_minDate;
  QDate m_maxDate;

  QFrame* m_card;

  QPushButton* m_btnPrevYear;
  QPushButton* m_btnPrevMonth;
  QPushButton* m_btnTitle;
  QPushButton* m_btnNextMonth;
  QPushButton* m_btnNextYear;

  QStackedWidget* m_viewStack;
  QWidget* m_dayPage;
  QWidget* m_monthPage;
  QWidget* m_yearPage;

  QList<QPushButton*> m_dayButtons;
  QList<QPushButton*> m_monthButtons;
  QList<QPushButton*> m_yearButtons;
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
  void enterEvent(QEnterEvent* event) override;
  void leaveEvent(QEvent* event) override;

  private:
  void applyStyles();
  void updateDisplay();

  QDate m_date;
  QString m_format = "yyyy-MM-dd";
  QString m_placeholder = "YYYY-MM-DD";

  QFrame* m_container;
  QLabel* m_label;
  QToolButton* m_btnClear;
  QLabel* m_icon;
  DatePickerPopup* m_popup;
};

} // namespace