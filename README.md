# 🦴 BeagleBone Black Yocto Dashboard

Yocto image for BeagleBone Black with ILI9341 2.8 inch TFT display and Qt5 UI.

## 🔧 Hardware
- BeagleBone Black
- TFT 2.8 inch SPI ILI9341 (320x240)

## 📦 Dependencies

Clone the following layers into the same directory:
```bash
mkdir -p ~/working/yocto && cd ~/working/yocto
git clone -b kirkstone https://git.yoctoproject.org/poky
git clone -b kirkstone https://git.yoctoproject.org/meta-ti
git clone -b kirkstone https://git.yoctoproject.org/meta-arm
git clone -b kirkstone https://github.com/openembedded/meta-openembedded.git
git clone -b kirkstone https://github.com/meta-qt5/meta-qt5.git
```

## 🏗️ Build
```bash
source poky/oe-init-build-env build
bitbake bbb-dashboard
bitbake core-image-minimal
```

## 💾 Flash SD Card
```bash
cd ~/working/yocto/build/tmp/deploy/images/beaglebone-yocto/
sudo umount /dev/sdc1
sudo umount /dev/sdc2
sudo dd \
  if=core-image-minimal-beaglebone-yocto.wic \
  of=/dev/sdc \
  bs=4M status=progress conv=fsync
```

## 🖥️ Serial Console
```bash
sudo minicom -D /dev/ttyUSB0 -b 115200
```

## 🚀 Run Qt App
```bash
bbb-dashboard -platform linuxfb
```

## ⚙️ Auto-boot Dashboard on Startup

**1. Copy the init script to the board:**
```bash
scp meta-bbb-custom/recipes-apps/bbb-dashboard/files/bbb-dashboard.init root@192.168.1.2:/etc/init.d/bbb-dashboard
chmod +x /etc/init.d/bbb-dashboard
```

**2. Enable auto-start by creating symlinks in rc*.d:**
```bash
ln -s /etc/init.d/bbb-dashboard /etc/rc5.d/S99bbb-dashboard
ln -s /etc/init.d/bbb-dashboard /etc/rc3.d/S99bbb-dashboard
```

**3. Start the app immediately (without reboot):**
```bash
/etc/init.d/bbb-dashboard start
```

**4. Test auto-boot:**
```bash
reboot
```
The dashboard should appear automatically after the board boots (30-60 seconds).

**Note:** Use `killall bbb-dashboard` or `/etc/init.d/bbb-dashboard stop` to stop the app if needed.

## ✅ Check ILI9341 Driver
```bash
dmesg | grep -i "ili9341\|fbtft\|fb0"
```

## ⏰ Set Timezone
```bash
timedatectl set-timezone Asia/Ho_Chi_Minh
timedatectl status
```

## ℹ️ Yocto Info

| | |
|---|---|
| Release | Kirkstone (LTS) |
| Kernel | 5.15 |
| Machine | beaglebone-yocto |
| Qt | 5.15.7 |
