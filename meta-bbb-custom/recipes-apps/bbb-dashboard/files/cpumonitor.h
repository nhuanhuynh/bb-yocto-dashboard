#ifndef CPUMONITOR_H
#define CPUMONITOR_H

#include <QObject>
#include <QTimer>

class CPUMonitor : public QObject
{
    Q_OBJECT
    Q_PROPERTY(int cpuUsage READ cpuUsage NOTIFY cpuUsageChanged)

public:
    explicit CPUMonitor(QObject *parent = nullptr);
    ~CPUMonitor();

    int cpuUsage() const { return m_cpuUsage; }

signals:
    void cpuUsageChanged(int usage);

private slots:
    void updateCPU();

private:
    struct CPUTimes {
        unsigned long user;
        unsigned long nice;
        unsigned long system;
        unsigned long idle;
        unsigned long iowait;
    };

    CPUTimes readCPUTimes();
    int calculateUsage(const CPUTimes &prev, const CPUTimes &curr);

    int m_cpuUsage;
    CPUTimes m_lastCPUTimes;
    QTimer m_timer;
};

#endif // CPUMONITOR_H
