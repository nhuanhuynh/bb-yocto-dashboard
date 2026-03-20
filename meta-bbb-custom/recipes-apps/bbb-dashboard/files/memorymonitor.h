#ifndef MEMORYMONITOR_H
#define MEMORYMONITOR_H

#include <QObject>
#include <QTimer>

class MemoryMonitor : public QObject
{
    Q_OBJECT
    Q_PROPERTY(int memoryUsage READ memoryUsage NOTIFY memoryUsageChanged)

public:
    explicit MemoryMonitor(QObject *parent = nullptr);
    ~MemoryMonitor();

    int memoryUsage() const { return m_memoryUsage; }

signals:
    void memoryUsageChanged(int usage);

private slots:
    void updateMemory();

private:
    int calculateMemoryUsage();

    int m_memoryUsage;
    QTimer m_timer;
};

#endif // MEMORYMONITOR_H
