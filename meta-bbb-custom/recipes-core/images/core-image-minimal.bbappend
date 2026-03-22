# Enable systemd-timesyncd service auto-start on boot
IMAGE_PREPROCESS_COMMAND:append = " systemd_enable_service;"

systemd_enable_service() {
    mkdir -p "${IMAGE_ROOTFS}${sysconfdir}/systemd/system/multi-user.target.wants"
    ln -sf /lib/systemd/system/systemd-timesyncd.service \
           "${IMAGE_ROOTFS}${sysconfdir}/systemd/system/multi-user.target.wants/systemd-timesyncd.service" || true
}
