# 🦴 BeagleBone Black Yocto Dashboard

Yocto image for BeagleBone Black with ILI9341 2.8 inch TFT display.

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
```

## 🏗️ Build
```bash
source poky/oe-init-build-env build
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

## ✅ Check ILI9341 Driver
```bash
dmesg | grep -i "ili9341\|fbtft\|fb0"
```

## ℹ️ Yocto Info

| | |
|---|---|
| Release | Kirkstone (LTS) |
| Kernel | 5.15 |
| Machine | beaglebone-yocto |
