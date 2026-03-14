FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

SRC_URI += "file://am335x-boneblack.dts \
            file://am335x-boneblack-ili9341.dtsi \
            file://ili9341.cfg"

do_patch:prepend() {
    cp ${WORKDIR}/am335x-boneblack.dts ${S}/arch/arm/boot/dts/am335x-boneblack.dts
    cp ${WORKDIR}/am335x-boneblack-ili9341.dtsi ${S}/arch/arm/boot/dts/am335x-boneblack-ili9341.dtsi
}

do_configure:append() {
    ${S}/scripts/kconfig/merge_config.sh -m .config ${WORKDIR}/ili9341.cfg
}
