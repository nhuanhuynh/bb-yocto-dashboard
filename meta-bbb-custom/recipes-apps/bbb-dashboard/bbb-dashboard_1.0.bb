SUMMARY = "BeagleBone Black Dashboard"
DESCRIPTION = "System monitoring dashboard UI for BeagleBone Black with Qt5 QML"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COREBASE}/meta/files/common-licenses/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

DEPENDS = "qtbase qtdeclarative qtgraphicaleffects"
RDEPENDS:${PN} = "qtdeclarative-qmlplugins qtgraphicaleffects"

FILES:${PN} = "${bindir}/bbb-dashboard"

SRC_URI = "file://main.cpp \
           file://main.qml \
           file://qml.qrc \
           file://cpumonitor.h \
           file://cpumonitor.cpp \
           file://memorymonitor.h \
           file://memorymonitor.cpp \
           file://gpumonitor.h \
           file://gpumonitor.cpp \
           file://storagemonitor.h \
           file://storagemonitor.cpp \
           file://CMakeLists.txt"

S = "${WORKDIR}"

inherit cmake cmake_qt5

do_install() {
    install -d ${D}${bindir}
    install -m 0755 ${B}/bbb-dashboard ${D}${bindir}/bbb-dashboard
}
