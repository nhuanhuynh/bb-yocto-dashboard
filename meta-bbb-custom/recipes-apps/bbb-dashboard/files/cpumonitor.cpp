#include "cpumonitor.h"
#include <QFile>
#include <QTextStream>
#include <QRegularExpression>

CPUMonitor::CPUMonitor(QObject *parent)
    : QObject(parent), m_cpuUsage(0)
{
    m_lastCPUTimes = readCPUTimes();

    connect(&m_timer, &QTimer::timeout, this, &CPUMonitor::updateCPU);
    m_timer.start(1000); // Update every 1 second
}

CPUMonitor::~CPUMonitor()
{
    m_timer.stop();
}

CPUMonitor::CPUTimes CPUMonitor::readCPUTimes()
{
    CPUTimes times = {0, 0, 0, 0, 0};

    QFile file("/proc/stat");
    if (!file.open(QIODevice::ReadOnly | QIODevice::Text)) {
        return times;
    }

    QTextStream in(&file);
    QString line = in.readLine();
    file.close();

    // Parse "cpu  user nice system idle iowait ..."
    if (line.startsWith("cpu ")) {
        line.remove(0, 4); // Remove "cpu "
        QStringList parts = line.split(QRegularExpression("\\s+"), Qt::SkipEmptyParts);

        if (parts.size() >= 4) {
            times.user = parts[0].toULong();
            times.nice = parts[1].toULong();
            times.system = parts[2].toULong();
            times.idle = parts[3].toULong();
            if (parts.size() > 4) {
                times.iowait = parts[4].toULong();
            }
        }
    }

    return times;
}

int CPUMonitor::calculateUsage(const CPUTimes &prev, const CPUTimes &curr)
{
    unsigned long prevTotal = prev.user + prev.nice + prev.system + prev.idle + prev.iowait;
    unsigned long currTotal = curr.user + curr.nice + curr.system + curr.idle + curr.iowait;

    unsigned long prevWork = prev.user + prev.nice + prev.system;
    unsigned long currWork = curr.user + curr.nice + curr.system;

    unsigned long totalDelta = currTotal - prevTotal;
    unsigned long workDelta = currWork - prevWork;

    if (totalDelta == 0) {
        return 0;
    }

    return static_cast<int>((workDelta * 100) / totalDelta);
}

void CPUMonitor::updateCPU()
{
    CPUTimes currentTimes = readCPUTimes();
    int newUsage = calculateUsage(m_lastCPUTimes, currentTimes);
    m_lastCPUTimes = currentTimes;

    if (newUsage != m_cpuUsage) {
        m_cpuUsage = newUsage;
        emit cpuUsageChanged(newUsage);
    }
}
