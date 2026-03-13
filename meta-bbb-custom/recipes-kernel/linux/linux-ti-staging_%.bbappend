FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

SRC_URI += "file://am335x-boneblack-ili9341.dtsi \
            file://ili9341.cfg"

do_patch:append() {
    echo '#include "am335x-boneblack-ili9341.dtsi"' >> \
    ${S}/arch/arm/boot/dts/am335x-boneblack.dts
}
