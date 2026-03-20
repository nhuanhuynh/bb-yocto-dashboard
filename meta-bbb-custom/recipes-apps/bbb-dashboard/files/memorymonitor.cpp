#include "memorymonitor.h"
#include <QFile>
#include <QStringList>

MemoryMonitor::MemoryMonitor(QObject *parent)
    : QObject(parent), m_memoryUsage(0)
{
    connect(&m_timer, &QTimer::timeout, this, &MemoryMonitor::updateMemory);
    m_timer.start(1000); // Update every 1 second
}

MemoryMonitor::~MemoryMonitor()
{
    m_timer.stop();
}

int MemoryMonitor::calculateMemoryUsage()
{
    QFile file("/proc/meminfo");
    if (!file.open(QIODevice::ReadOnly)) {
        return 0;
    }

    QByteArray content = file.readAll();
    file.close();
    
    unsigned long memTotal = 0, memAvailable = 0;
    
    QStringList lines = QString::fromLocal8Bit(content).split('\n');

    for (const QString &line : lines) {
        QString trimmed = line.trimmed();
        if (trimmed.isEmpty()) continue;

        if (trimmed.startsWith("MemTotal:")) {
            int colonPos = trimmed.indexOf(':');
            int kbPos = trimmed.lastIndexOf("kB");
            if (colonPos > 0 && kbPos > colonPos) {
                QString numStr = trimmed.mid(colonPos + 1, kbPos - colonPos - 1).trimmed();
                memTotal = numStr.toULong();
            }
        }
        else if (trimmed.startsWith("MemAvailable:")) {
            int colonPos = trimmed.indexOf(':');
            int kbPos = trimmed.lastIndexOf("kB");
            if (colonPos > 0 && kbPos > colonPos) {
                QString numStr = trimmed.mid(colonPos + 1, kbPos - colonPos - 1).trimmed();
                memAvailable = numStr.toULong();
            }
        }
    }

    if (memTotal == 0) {
        return 0;
    }

    unsigned long memUsed = memTotal - memAvailable;
    return static_cast<int>((memUsed * 100) / memTotal);
}

void MemoryMonitor::updateMemory()
{
    int newUsage = calculateMemoryUsage();

    if (newUsage != m_memoryUsage) {
        m_memoryUsage = newUsage;
        emit memoryUsageChanged(newUsage);
    }
}
