#include "datetimemonitor.h"
#include <QDateTime>

DateTimeMonitor::DateTimeMonitor(QObject *parent)
    : QObject(parent), m_date(""), m_time("")
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

void DateTimeMonitor::updateDateTime()
{
    QDateTime now = QDateTime::currentDateTime();
    
    // Format: D/M
    QString newDate = now.toString("d/M");
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
}
