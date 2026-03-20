#include "storagemonitor.h"
#include <sys/statvfs.h>

StorageMonitor::StorageMonitor(QObject *parent)
    : QObject(parent), m_storageUsage(0)
{
    timer = new QTimer(this);
    connect(timer, &QTimer::timeout, this, &StorageMonitor::updateStorage);
    timer->start(1000);
    updateStorage();
}

StorageMonitor::~StorageMonitor()
{
}

int StorageMonitor::storageUsage() const
{
    return m_storageUsage;
}

void StorageMonitor::updateStorage()
{
    struct statvfs buf;
    if (statvfs("/", &buf) == 0) {
        unsigned long long total = buf.f_blocks * buf.f_frsize;
        unsigned long long available = buf.f_bavail * buf.f_frsize;
        unsigned long long used = total - available;
        
        if (total > 0) {
            m_storageUsage = (used * 100) / total;
        } else {
            m_storageUsage = 0;
        }
        emit storageUsageChanged();
    }
}
