# BeagleBone Black Yocto Dashboard

Yocto image for BeagleBone Black with ILI9341 2.8 inch TFT display.

## Hardware
- BeagleBone Black
- TFT 2.8 inch SPI ILI9341 (320x240)

## Dependencies

Clone the following layers into the same directory:
```bash
mkdir -p ~/working/yocto && cd ~/working/yocto
git clone -b kirkstone https://git.yoctoproject.org/poky
git clone -b kirkstone https://git.yoctoproject.org/meta-ti
git clone -b kirkstone https://git.yoctoproject.org/meta-arm
```

## Build
```bash
source poky/oe-init-build-env build
bitbake core-image-minimal
```

## Yocto
- Release: Kirkstone (LTS)
- Kernel: 5.15
- Machine: beaglebone-yocto
