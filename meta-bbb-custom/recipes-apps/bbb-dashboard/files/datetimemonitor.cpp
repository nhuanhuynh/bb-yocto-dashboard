#include "datetimemonitor.h"
#include <QDateTime>

DateTimeMonitor::DateTimeMonitor(QObject *parent)
    : QObject(parent), m_date(""), m_time(""), m_day("")
{
    timer = new QTimer(this);
    connect(timer, &QTimer::timeout, this, &DateTimeMonitor::updateDateTime);
    timer->start(1000);
    updateDateTime();
}

DateTimeMonitor::~DateTimeMonitor()
{
}

QString DateTimeMonitor::currentDate() const
{
    return m_date;
}

QString DateTimeMonitor::currentTime() const
{
    return m_time;
}

QString DateTimeMonitor::dayOfWeek() const
{
    return m_day;
}

void DateTimeMonitor::updateDateTime()
{
    QDateTime now = QDateTime::currentDateTime();
    
    // Format: ddd, d/M (Sun, 22/3)
    QString newDate = now.toString("ddd, d/M");
    if (newDate != m_date) {
        m_date = newDate;
        emit dateChanged();
    }
    
    // Format: HH:mm
    QString newTime = now.toString("hh:mm");
    if (newTime != m_time) {
        m_time = newTime;
        emit timeChanged();
    }
    
    // Format: ddd (Mon, Tue, Wed, etc.)
    QString newDay = now.toString("ddd");
    if (newDay != m_day) {
        m_day = newDay;
        emit dayChanged();
    }
}
