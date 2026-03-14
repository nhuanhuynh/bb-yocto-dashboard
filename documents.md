# Cheat Sheet

## Flash SD Card
```bash
cd ~/working/yocto/build/tmp/deploy/images/beaglebone-yocto/
sudo umount /dev/sdc1
sudo umount /dev/sdc2
sudo dd \
  if=core-image-minimal-beaglebone-yocto.wic \
  of=/dev/sdc \
  bs=4M status=progress conv=fsync
```

## Minicom
```bash
sudo minicom -D /dev/ttyUSB0 -b 115200
```

## Check ILI9341 Driver
```bash
dmesg | grep -i "ili9341\|fbtft\|fb0"
```
