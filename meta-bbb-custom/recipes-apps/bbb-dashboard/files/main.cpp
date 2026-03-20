#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include "cpumonitor.h"
#include "memorymonitor.h"
#include "gpumonitor.h"
#include "storagemonitor.h"

int main(int argc, char *argv[])
{
    qputenv("QT_QPA_FONTDIR", "/usr/share/fonts/truetype");
    qputenv("QML_DISABLE_DISK_CACHE", "1");

#if QT_VERSION < QT_VERSION_CHECK(6, 0, 0)
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
#endif
    QGuiApplication app(argc, argv);

    // Create and register CPU Monitor
    CPUMonitor *cpuMonitor = new CPUMonitor(&app);
    // Create and register Memory Monitor
    MemoryMonitor *memoryMonitor = new MemoryMonitor(&app);
    // Create and register GPU Monitor
    GPUMonitor *gpuMonitor = new GPUMonitor(&app);
    // Create and register Storage Monitor
    StorageMonitor *storageMonitor = new StorageMonitor(&app);

    QQmlApplicationEngine engine;
    engine.rootContext()->setContextProperty("cpuMonitor", cpuMonitor);
    engine.rootContext()->setContextProperty("memoryMonitor", memoryMonitor);
    engine.rootContext()->setContextProperty("gpuMonitor", gpuMonitor);
    engine.rootContext()->setContextProperty("storageMonitor", storageMonitor);
    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated, &app, [url](QObject *obj, const QUrl &objUrl)
                     {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1); }, Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}
