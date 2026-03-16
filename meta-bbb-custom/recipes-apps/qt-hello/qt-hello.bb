DESCRIPTION = "Qt5 Hello World for BeagleBone Black"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

DEPENDS = "qtbase"

SRC_URI = "file://main.cpp \
           file://CMakeLists.txt"

S = "${WORKDIR}"

inherit cmake cmake_qt5

do_install() {
    install -d ${D}${bindir}
    install -m 0755 ${B}/qt-hello ${D}${bindir}/qt-hello
}
