FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

SRC_URI += "file://timesyncd.conf"

do_install:append() {
    install -d ${D}${sysconfdir}/systemd/
    install -m 0644 ${WORKDIR}/timesyncd.conf ${D}${sysconfdir}/systemd/timesyncd.conf
}

FILES:${PN} += "${sysconfdir}/systemd/timesyncd.conf"
