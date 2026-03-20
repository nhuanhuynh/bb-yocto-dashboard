#ifndef STORAGEMONITOR_H
#define STORAGEMONITOR_H

#include <QObject>
#include <QTimer>

class StorageMonitor : public QObject
{
    Q_OBJECT
    Q_PROPERTY(int storageUsage READ storageUsage NOTIFY storageUsageChanged)

public:
    explicit StorageMonitor(QObject *parent = nullptr);
    ~StorageMonitor();

    int storageUsage() const;

signals:
    void storageUsageChanged();

private slots:
    void updateStorage();

private:
    QTimer *timer;
    int m_storageUsage;
};

#endif // STORAGEMONITOR_H
