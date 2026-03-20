#include "gpumonitor.h"
#include <QFile>
#include <QStringList>

GPUMonitor::GPUMonitor(QObject *parent)
    : QObject(parent), m_gpuUsage(0)
{
    connect(&m_timer, &QTimer::timeout, this, &GPUMonitor::updateGPU);
    m_timer.start(1000); // Update every 1 second
}

GPUMonitor::~GPUMonitor()
{
    m_timer.stop();
}

int GPUMonitor::calculateGPUUsage()
{
    QFile file("/proc/meminfo");
    if (!file.open(QIODevice::ReadOnly)) {
        return 0;
    }

    QByteArray content = file.readAll();
    file.close();
    
    unsigned long cmaTotal = 0, cmaFree = 0;
    
    QStringList lines = QString::fromLocal8Bit(content).split('\n');

    for (const QString &line : lines) {
        QString trimmed = line.trimmed();
        if (trimmed.isEmpty()) continue;

        if (trimmed.startsWith("CmaTotal:")) {
            int colonPos = trimmed.indexOf(':');
            int kbPos = trimmed.lastIndexOf("kB");
            if (colonPos > 0 && kbPos > colonPos) {
                QString numStr = trimmed.mid(colonPos + 1, kbPos - colonPos - 1).trimmed();
                cmaTotal = numStr.toULong();
            }
        }
        else if (trimmed.startsWith("CmaFree:")) {
            int colonPos = trimmed.indexOf(':');
            int kbPos = trimmed.lastIndexOf("kB");
            if (colonPos > 0 && kbPos > colonPos) {
                QString numStr = trimmed.mid(colonPos + 1, kbPos - colonPos - 1).trimmed();
                cmaFree = numStr.toULong();
            }
        }
    }

    if (cmaTotal == 0) {
        return 0;
    }

    unsigned long cmaUsed = cmaTotal - cmaFree;
    return static_cast<int>((cmaUsed * 100) / cmaTotal);
}

void GPUMonitor::updateGPU()
{
    int newUsage = calculateGPUUsage();

    if (newUsage != m_gpuUsage) {
        m_gpuUsage = newUsage;
        emit gpuUsageChanged(newUsage);
    }
}
