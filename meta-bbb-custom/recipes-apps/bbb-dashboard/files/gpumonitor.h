#ifndef GPUMONITOR_H
#define GPUMONITOR_H

#include <QObject>
#include <QTimer>

class GPUMonitor : public QObject
{
    Q_OBJECT
    Q_PROPERTY(int gpuUsage READ gpuUsage NOTIFY gpuUsageChanged)

public:
    explicit GPUMonitor(QObject *parent = nullptr);
    ~GPUMonitor();

    int gpuUsage() const { return m_gpuUsage; }

signals:
    void gpuUsageChanged(int usage);

private slots:
    void updateGPU();

private:
    int calculateGPUUsage();

    int m_gpuUsage;
    QTimer m_timer;
};

#endif // GPUMONITOR_H
