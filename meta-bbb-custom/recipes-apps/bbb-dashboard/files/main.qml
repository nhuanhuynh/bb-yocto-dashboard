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

            // Top bar: HOME title
            Text {
                Layout.fillWidth: true
                Layout.preferredHeight: 25
                text: "HOME"
                color: "#ffffff"
                font.pixelSize: 16
                font.bold: true
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                renderType: Text.NativeRendering
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
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    border.color: "#00ffff"
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

                            Rectangle {
                                anchors.fill: parent
                                radius: width / 2
                                color: "transparent"
                                border.color: "#00ffff"
                                border.width: 1
                            }

                            Text {
                                anchors.centerIn: parent
                                text: currentCpuUsage + "%"
                                color: "#00ffff"
                                font.pixelSize: 16
                                font.bold: true
                                renderType: Text.NativeRendering
                            }
                        }
                    }
                }

                // GPU
                Rectangle {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    border.color: "#00ffff"
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

                            Rectangle {
                                anchors.fill: parent
                                radius: width / 2
                                color: "transparent"
                                border.color: "#00ffff"
                                border.width: 1
                            }

                            Text {
                                anchors.centerIn: parent
                                text: "37%"
                                color: "#00ffff"
                                font.pixelSize: 16
                                font.bold: true
                                renderType: Text.NativeRendering
                            }
                        }
                    }
                }

                // DATE
                Rectangle {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    border.color: "#00ffff"
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
                            text: "📅 DATE"
                            color: "#ffffff"
                            font.pixelSize: 14
                            font.bold: true
                            Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                            renderType: Text.NativeRendering
                        }

                        Text {
                            text: "12/11"
                            color: "#00ffff"
                            font.pixelSize: 18
                            font.bold: true
                            Layout.alignment: Qt.AlignHCenter
                            renderType: Text.NativeRendering
                        }
                    }
                }

                // Memory
                Rectangle {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    border.color: "#00ffff"
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
                            text: "💾 Memory"
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

                            Rectangle {
                                anchors.fill: parent
                                radius: width / 2
                                color: "transparent"
                                border.color: "#00ffff"
                                border.width: 1
                            }

                            Text {
                                anchors.centerIn: parent
                                text: currentMemoryUsage + "%"
                                color: "#00ffff"
                                font.pixelSize: 16
                                font.bold: true
                                renderType: Text.NativeRendering
                            }
                        }
                    }
                }

                // Storage
                Rectangle {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    border.color: "#00ffff"
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
                            text: "💿 Storage"
                            color: "#ffffff"
                            font.pixelSize: 14
                            font.bold: true
                            Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                            renderType: Text.NativeRendering
                        }

                        Text {
                            text: "6.3%"
                            color: "#00ffff"
                            font.pixelSize: 18
                            font.bold: true
                            Layout.alignment: Qt.AlignHCenter
                            renderType: Text.NativeRendering
                        }
                    }
                }

                // Time
                Rectangle {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    border.color: "#00ffff"
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
                            text: "🕐 TIME"
                            color: "#ffffff"
                            font.pixelSize: 14
                            font.bold: true
                            Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                            renderType: Text.NativeRendering
                        }

                        Text {
                            text: "13:25"
                            color: "#00ffff"
                            font.pixelSize: 18
                            font.bold: true
                            Layout.alignment: Qt.AlignHCenter
                            renderType: Text.NativeRendering
                        }
                    }
                }
            }

            // Bottom bar: Navigation buttons
            RowLayout {
                Layout.fillWidth: true
                Layout.preferredHeight: 25
                spacing: 5

                Text {
                    text: "🏠"
                    font.pixelSize: 14
                }

                Text {
                    text: "⚙️"
                    font.pixelSize: 14
                }

                Item { Layout.fillWidth: true }

                Text {
                    text: "☰"
                    font.pixelSize: 14
                }
            }
        }
    }
}
