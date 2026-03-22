#ifndef DATETIMEMONITOR_H
#define DATETIMEMONITOR_H

#include <QObject>
#include <QTimer>
#include <QString>

class DateTimeMonitor : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString currentDate READ currentDate NOTIFY dateChanged)
    Q_PROPERTY(QString currentTime READ currentTime NOTIFY timeChanged)
    Q_PROPERTY(QString dayOfWeek READ dayOfWeek NOTIFY dayChanged)

public:
    explicit DateTimeMonitor(QObject *parent = nullptr);
    ~DateTimeMonitor();

    QString currentDate() const;
    QString currentTime() const;
    QString dayOfWeek() const;

signals:
    void dateChanged();
    void timeChanged();
    void dayChanged();

private slots:
    void updateDateTime();

private:
    QTimer *timer;
    QString m_date;
    QString m_time;
    QString m_day;
};

#endif // DATETIMEMONITOR_H
