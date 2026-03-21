import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Layouts 1.15
import QtGraphicalEffects 1.15

Window {
    width: 320
    height: 240
    visible: true
    title: "BBB Dashboard"

    property int currentCpuUsage: 0
    property int currentMemoryUsage: 0
    property int currentGpuUsage: 0
    property int currentStorageUsage: 0
    property string currentDate: "00/00"
    property string currentTime: "00:00"

    Connections {
        target: cpuMonitor
        onCpuUsageChanged: {
            currentCpuUsage = cpuMonitor.cpuUsage
        }
    }

    Connections {
        target: memoryMonitor
        onMemoryUsageChanged: {
            currentMemoryUsage = memoryMonitor.memoryUsage
        }
    }

    Connections {
        target: gpuMonitor
        onGpuUsageChanged: {
            currentGpuUsage = gpuMonitor.gpuUsage
        }
    }

    Connections {
        target: storageMonitor
        onStorageUsageChanged: {
            currentStorageUsage = storageMonitor.storageUsage
        }
    }

    Connections {
        target: dateTimeMonitor
        onDateChanged: {
            currentDate = dateTimeMonitor.currentDate
        }
        onTimeChanged: {
            currentTime = dateTimeMonitor.currentTime
        }
    }

    Rectangle {
        anchors.fill: parent

        gradient: Gradient {
            GradientStop { position: 0.0; color: "#0f1a2e" }
            GradientStop { position: 1.0; color: "#1a0f2e" }
        }

        ColumnLayout {
            anchors.fill: parent
            anchors.margins: 8
            spacing: 8

            // Top bar: Time and Title
            RowLayout {
                Layout.fillWidth: true
                Layout.preferredHeight: 25
                spacing: 8

                Text {
                    text: dateTimeMonitor.currentTime
                    color: "#ffffff"
                    font.pixelSize: 15
                    font.bold: true
                    renderType: Text.NativeRendering
                }

                Item { Layout.fillWidth: true }

                Text {
                    text: "beaglebone-yocto"
                    color: "#aaaaaa"
                    font.pixelSize: 12
                    font.bold: true
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    renderType: Text.NativeRendering
                }

                Item { Layout.fillWidth: true }
            }

            // Main Grid 3x2
            GridLayout {
                Layout.fillWidth: true
                Layout.fillHeight: true
                columns: 3
                rows: 2
                columnSpacing: 8
                rowSpacing: 8

                // CPU
                Rectangle {
                    Layout.column: 0
                    Layout.row: 0
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    border.color: "#ffb700"
                    border.width: 0
                    radius: 5

                    gradient: Gradient {
                        GradientStop { position: 0.0; color: "#1a4a7e" }
                        GradientStop { position: 1.0; color: "#0a2a4a" }
                    }

                    ColumnLayout {
                        anchors.fill: parent
                        anchors.margins: 4
                        anchors.topMargin: 2
                        spacing: 3

                        Text {
                            text: "⚙ CPU"
                            color: "#ffffff"
                            font.pixelSize: 14
                            font.bold: true
                            Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                            renderType: Text.NativeRendering
                        }

                        Item {
                            Layout.alignment: Qt.AlignHCenter
                            Layout.preferredWidth: 50
                            Layout.preferredHeight: 50

                            Canvas {
                                anchors.fill: parent
                                onPaint: {
                                    var ctx = getContext("2d")
                                    var centerX = width / 2
                                    var centerY = height / 2
                                    var radius = 20
                                    
                                    ctx.strokeStyle = "#333333"
                                    ctx.lineWidth = 2
                                    ctx.beginPath()
                                    ctx.arc(centerX, centerY, radius, 0, Math.PI * 2)
                                    ctx.stroke()
                                    
                                    ctx.strokeStyle = "#ffb700"
                                    ctx.lineWidth = 2
                                    var angle = (currentCpuUsage / 100.0) * Math.PI * 2
                                    ctx.beginPath()
                                    ctx.arc(centerX, centerY, radius, -Math.PI/2, -Math.PI/2 + angle)
                                    ctx.stroke()
                                }
                                
                                Timer {
                                    interval: 100
                                    running: true
                                    repeat: true
                                    onTriggered: parent.requestPaint()
                                }
                            }

                            Text {
                                anchors.centerIn: parent
                                text: currentCpuUsage + "%"
                                color: "#ffffff"
                                font.pixelSize: 16
                                font.bold: true
                                renderType: Text.NativeRendering
                            }
                        }
                    }
                }

                // GPU
                Rectangle {
                    Layout.column: 1
                    Layout.row: 0
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    border.color: "#ffb700"
                    border.width: 0
                    radius: 5

                    gradient: Gradient {
                        GradientStop { position: 0.0; color: "#1a4a7e" }
                        GradientStop { position: 1.0; color: "#0a2a4a" }
                    }

                    ColumnLayout {
                        anchors.fill: parent
                        anchors.margins: 4
                        anchors.topMargin: 2
                        spacing: 3

                        Text {
                            text: "⚡ GPU"
                            color: "#ffffff"
                            font.pixelSize: 14
                            font.bold: true
                            Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                            renderType: Text.NativeRendering
                        }

                        Item {
                            Layout.alignment: Qt.AlignHCenter
                            Layout.preferredWidth: 50
                            Layout.preferredHeight: 50

                            Canvas {
                                anchors.fill: parent
                                onPaint: {
                                    var ctx = getContext("2d")
                                    var centerX = width / 2
                                    var centerY = height / 2
                                    var radius = 20
                                    
                                    ctx.strokeStyle = "#333333"
                                    ctx.lineWidth = 2
                                    ctx.beginPath()
                                    ctx.arc(centerX, centerY, radius, 0, Math.PI * 2)
                                    ctx.stroke()
                                    
                                    ctx.strokeStyle = "#ffb700"
                                    ctx.lineWidth = 2
                                    var angle = (currentGpuUsage / 100.0) * Math.PI * 2
                                    ctx.beginPath()
                                    ctx.arc(centerX, centerY, radius, -Math.PI/2, -Math.PI/2 + angle)
                                    ctx.stroke()
                                }
                                
                                Timer {
                                    interval: 100
                                    running: true
                                    repeat: true
                                    onTriggered: parent.requestPaint()
                                }
                            }

                            Text {
                                anchors.centerIn: parent
                                text: currentGpuUsage + "%"
                                color: "#ffffff"
                                font.pixelSize: 16
                                font.bold: true
                                renderType: Text.NativeRendering
                            }
                        }
                    }
                }

                // Memory
                Rectangle {
                    Layout.column: 0
                    Layout.row: 1
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    border.color: "#ffb700"
                    border.width: 0
                    radius: 5

                    gradient: Gradient {
                        GradientStop { position: 0.0; color: "#1a4a7e" }
                        GradientStop { position: 1.0; color: "#0a2a4a" }
                    }

                    ColumnLayout {
                        anchors.fill: parent
                        anchors.margins: 4
                        anchors.topMargin: 2
                        spacing: 3

                        Text {
                            text: "◉ MEMORY"
                            color: "#ffffff"
                            font.pixelSize: 12
                            font.bold: true
                            Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                            renderType: Text.NativeRendering
                        }

                        Item {
                            Layout.alignment: Qt.AlignHCenter
                            Layout.preferredWidth: 50
                            Layout.preferredHeight: 50

                            Canvas {
                                anchors.fill: parent
                                onPaint: {
                                    var ctx = getContext("2d")
                                    var centerX = width / 2
                                    var centerY = height / 2
                                    var radius = 20
                                    
                                    ctx.strokeStyle = "#333333"
                                    ctx.lineWidth = 2
                                    ctx.beginPath()
                                    ctx.arc(centerX, centerY, radius, 0, Math.PI * 2)
                                    ctx.stroke()
                                    
                                    ctx.strokeStyle = "#ffb700"
                                    ctx.lineWidth = 2
                                    var angle = (currentMemoryUsage / 100.0) * Math.PI * 2
                                    ctx.beginPath()
                                    ctx.arc(centerX, centerY, radius, -Math.PI/2, -Math.PI/2 + angle)
                                    ctx.stroke()
                                }
                                
                                Timer {
                                    interval: 100
                                    running: true
                                    repeat: true
                                    onTriggered: parent.requestPaint()
                                }
                            }

                            Text {
                                anchors.centerIn: parent
                                text: currentMemoryUsage + "%"
                                color: "#ffffff"
                                font.pixelSize: 16
                                font.bold: true
                                renderType: Text.NativeRendering
                            }
                        }
                    }
                }

                // Storage
                Rectangle {
                    Layout.column: 1
                    Layout.row: 1
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    border.color: "#ffb700"
                    border.width: 0
                    radius: 5

                    gradient: Gradient {
                        GradientStop { position: 0.0; color: "#1a4a7e" }
                        GradientStop { position: 1.0; color: "#0a2a4a" }
                    }

                    ColumnLayout {
                        anchors.fill: parent
                        anchors.margins: 4
                        anchors.topMargin: 2
                        spacing: 3

                        Text {
                            text: "◈ STORAGE"
                            color: "#ffffff"
                            font.pixelSize: 12
                            font.bold: true
                            Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                            renderType: Text.NativeRendering
                        }

                        Item {
                            Layout.alignment: Qt.AlignHCenter
                            Layout.preferredWidth: 50
                            Layout.preferredHeight: 50

                            Canvas {
                                anchors.fill: parent
                                onPaint: {
                                    var ctx = getContext("2d")
                                    var centerX = width / 2
                                    var centerY = height / 2
                                    var radius = 20
                                    
                                    ctx.strokeStyle = "#333333"
                                    ctx.lineWidth = 2
                                    ctx.beginPath()
                                    ctx.arc(centerX, centerY, radius, 0, Math.PI * 2)
                                    ctx.stroke()
                                    
                                    ctx.strokeStyle = "#ffb700"
                                    ctx.lineWidth = 2
                                    var angle = (currentStorageUsage / 100.0) * Math.PI * 2
                                    ctx.beginPath()
                                    ctx.arc(centerX, centerY, radius, -Math.PI/2, -Math.PI/2 + angle)
                                    ctx.stroke()
                                }
                                
                                Timer {
                                    interval: 100
                                    running: true
                                    repeat: true
                                    onTriggered: parent.requestPaint()
                                }
                            }

                            Text {
                                anchors.centerIn: parent
                                text: currentStorageUsage + "%"
                                color: "#ffffff"
                                font.pixelSize: 16
                                font.bold: true
                                renderType: Text.NativeRendering
                            }
                        }
                    }
                }

                // DateTime
                Rectangle {
                    Layout.column: 2
                    Layout.row: 0
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    Layout.rowSpan: 2
                    border.color: "#ffb700"
                    border.width: 0
                    radius: 5

                    gradient: Gradient {
                        GradientStop { position: 0.0; color: "#1a4a7e" }
                        GradientStop { position: 1.0; color: "#0a2a4a" }
                    }

                    ColumnLayout {
                        anchors.fill: parent
                        anchors.margins: 4
                        spacing: 5

                        Text {
                            text: "◎ TIME"
                            color: "#ffffff"
                            font.pixelSize: 14
                            font.bold: true
                            Layout.alignment: Qt.AlignHCenter | Qt.AlignTop
                            renderType: Text.NativeRendering
                        }

                        Item { Layout.fillHeight: true }

                        Text {
                            text: dateTimeMonitor.currentDate
                            color: "#ffffff"
                            font.pixelSize: 20
                            font.bold: true
                            Layout.alignment: Qt.AlignHCenter
                            renderType: Text.NativeRendering
                        }

                        Text {
                            text: dateTimeMonitor.currentTime
                            color: "#ffffff"
                            font.pixelSize: 28
                            font.bold: true
                            Layout.alignment: Qt.AlignHCenter
                            renderType: Text.NativeRendering
                        }

                        Item { Layout.fillHeight: true }
                    }
                }
            }

            // Bottom bar: Navigation buttons
            RowLayout {
                Layout.fillWidth: true
                Layout.preferredHeight: 25
                spacing: 0

                Text {
                    text: "⌂"
                    color: "#ffffff"
                    font.pixelSize: 28
                }

                Item { Layout.fillWidth: true }

                Text {
                    text: "◉"
                    color: "#888888"
                    font.pixelSize: 28
                }

                Item { Layout.fillWidth: true }

                Text {
                    text: "◈"
                    color: "#888888"
                    font.pixelSize: 28
                }

                Item { Layout.fillWidth: true }

                Text {
                    text: "⚙"
                    color: "#888888"
                    font.pixelSize: 28
                }

                Item { Layout.fillWidth: true }

                Text {
                    text: "☰"
                    color: "#888888"
                    font.pixelSize: 28
                }
            }
        }
    }
}
