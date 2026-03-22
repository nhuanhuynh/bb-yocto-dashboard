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

## ✅ Check ILI9341 Driver
```bash
dmesg | grep -i "ili9341\|fbtft\|fb0"
```

## 🚀 Run Qt App
```bash
bbb-dashboard -platform linuxfb
```

## 🌐 Configure Network (Static IP)
```bash
# Set static IP on eth0
ip addr add 192.168.1.100/24 dev eth0
ip route add default via 192.168.1.1

# Set DNS
echo "nameserver 8.8.8.8" > /etc/resolv.conf

# Verify
ip addr show eth0
ping 8.8.8.8
```

**Or for permanent configuration (persists across reboots):**
```bash
cat > /etc/systemd/network/10-eth0.network << 'EOF'
[Match]
Name=eth0

[Network]
DHCP=no
Address=192.168.1.100/24
Gateway=192.168.1.1
DNS=8.8.8.8
EOF

systemctl restart systemd-networkd
```

## 🌍 Share Internet from Host to BeagleBone

When BeagleBone is connected via LAN cable directly to PC:

**On Host (Ubuntu):**

```bash
# 1. Enable IP forwarding
sudo sysctl -w net.ipv4.ip_forward=1

# 2. Configure LAN interface (eno2 or your interface name)
sudo ifconfig eno2 192.168.1.1 netmask 255.255.255.0

# 3. Setup NAT to share internet from WiFi (wlo1) to LAN (eno2)
sudo iptables -t nat -A POSTROUTING -o wlo1 -j MASQUERADE
sudo iptables -A FORWARD -i eno2 -j ACCEPT
sudo iptables -A FORWARD -o eno2 -j ACCEPT
```

**On BeagleBone:**

```bash
# 1. Configure eth0 interface
sudo ip addr add 192.168.1.2/24 dev eth0
sudo ip link set eth0 up

# 2. Set default gateway
sudo ip route add default via 192.168.1.1

# 3. Configure DNS
echo "nameserver 8.8.8.8" | sudo tee /etc/resolv.conf
echo "nameserver 8.8.4.4" | sudo tee -a /etc/resolv.conf

# 4. Test connectivity
ping 8.8.8.8
nslookup pool.ntp.org

# 5. Verify NTP synchronization
timedatectl status
systemctl status systemd-timesyncd
```

**Find your network interfaces on Host:**
```bash
ip link show
```

Replace `eno2` and `wlo1` with your actual interface names.

## ⚙️ Auto-boot Dashboard on Startup (systemd)

**1. Create systemd service file:**
```bash
cat > /etc/systemd/system/bbb-dashboard.service << 'EOF'
[Unit]
Description=BBB Dashboard Qt5 Application
After=network.target

[Service]
Type=simple
User=root
ExecStart=/usr/bin/bbb-dashboard -platform linuxfb
Restart=on-failure
RestartSec=5s

[Install]
WantedBy=multi-user.target
EOF
```

**2. Enable and start the service:**
```bash
systemctl daemon-reload
systemctl enable bbb-dashboard
systemctl start bbb-dashboard
```

**3. Verify service is running:**
```bash
systemctl status bbb-dashboard
journalctl -u bbb-dashboard -n 20
```

**4. Test auto-boot:**
```bash
reboot
```
The dashboard should appear automatically after the board boots (30-60 seconds).

**Note:** Use `systemctl stop bbb-dashboard` or `killall bbb-dashboard` to stop the app.

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
