# 📋 Yocto BeagleBone Black Dashboard - Tóm Tắt Dự Án

## 🎯 Mục Đích
Xây dựng Linux image Yocto tùy chỉnh cho **BeagleBone Black** với:
- **Display**: TFT 2.8" SPI ILI9341 (320x240)
- **UI**: Qt5 (Qt Framework v5)
- **Tên project**: BBB Dashboard

## 📂 Cấu Trúc Thư Mục Chính

| Thư mục | Mục đích |
|---------|----------|
| **poky/** | OE-Core + meta-yocto từ Yocto Project (branch kirkstone) |
| **meta-ti/** | TI chip-specific layers (BeagleBone Black) |
| **meta-arm/** | ARM architecture support |
| **meta-openembedded/** | Community layers (additional packages, libraries) |
| **meta-qt5/** | Qt5 framework và tools |
| **meta-bbb-custom/** | 🔴 Layer tùy chỉnh cho project (recipes, configs riêng) |
| **build/** | Build output (cấu hình, artefacts) |
| **downloads/** | Source code cache (tarballs, git repos) |
| **sstate-cache/** | Build cache (có thể xóa để giải phóng dung lượng) |

## 🛠️ Tech Stack

| Component | Version |
|-----------|---------|
| Yocto | kirkstone (branch) |
| Kernel | Linux (TI optimized) |
| C Library | glibc |
| Package Manager | opkg |
| Build System | BitBake |
| UI Framework | Qt5 |
| Graphics | OpenGL, Pixbuf |

## 📋 Build Targets

- **bbb-dashboard** - Custom image với Qt5 UI cho TFT display
- **core-image-minimal** - Minimal Linux image

## 🔑 Key Files & Configurations

### BitBake Recipes (Recipes tùy chỉnh)
- Nằm trong **meta-bbb-custom/recipes-*** directories
- Theo dõi bởi BitBake thông qua `BBLAYERS` configuration

### Build Configuration
- **build/conf/local.conf** - Machine-specific settings, features tùy chỉnh
- **build/conf/bblayers.conf** - Liệt kê các layers hoạt động (poky, meta-ti, meta-qt5, etc.)

### Meta Layer Organization
```
meta-bbb-custom/
├── recipes-core/        # Core packages
├── recipes-qt/          # Qt-specific recipes
├── recipes-extended/    # Extended packages
├── conf/
│   └── layer.conf       # Layer definition
└── COPYING              # License info
```

## 🔄 Quy Trình Làm Việc Chính

1. **Chuẩn bị môi trường**: `source poky/oe-init-build-env build`
2. **Build image**: `bitbake bbb-dashboard` hoặc `bitbake core-image-minimal`
3. **Xem output**: `build/tmp/deploy/images/beaglebone-yocto/`
4. **Flash SD Card**: Sử dụng `dd` hoặc Balena Etcher

## 📦 Các Layer Đang Dùng

| Layer | Nguồn | Branch | Mục đích |
|-------|-------|--------|----------|
| poky | git.yoctoproject.org | kirkstone | Core OE + Yocto |
| meta-ti | git.yoctoproject.org | kirkstone | TI hardware support |
| meta-arm | git.yoctoproject.org | kirkstone | ARM architecture |
| meta-openembedded | github.com/openembedded | kirkstone | Community packages |
| meta-qt5 | github.com/meta-qt5 | kirkstone | Qt5 framework |
| meta-bbb-custom | local (custom) | - | Project-specific recipes |

## 🚀 Quick Start

```bash
# 1. Init environment
cd ~/working/yocto
source poky/oe-init-build-env build

# 2. Build
bitbake bbb-dashboard

# 3. Output location
ls build/tmp/deploy/images/beaglebone-yocto/
```

## ⚠️ Lưu Ý Quan Trọng

- Không sửa trực tiếp trong **poky/** - dùng `.bbappend` files trong meta-bbb-custom
- BitBake caching có thể lớn - **sstate-cache/** có thể xóa khi cần dung lượng
- Build process dài, lần đầu có thể mất vài giờ
- Luôn kiểm tra `bitbake-layers show-layers` để xác minh layer hoạt động
- Dùng `bitbake-layers show-recipes <recipe>` để tìm recipe từ layer nào

## 📚 Useful Commands

```bash
# Xem các layer hoạt động
bitbake-layers show-layers

# Tìm recipe cụ thể
bitbake-layers show-recipes qt5-qml

# Clean recipe
bitbake -c clean <recipe-name>

# Clean all (start fresh)
bitbake -c cleanall <recipe-name>

# Xem build log
cat build/tmp/work/armv7a-oe-linux-gnueabi/<recipe>/temp/log.do_build
```

## 📖 Khi Cần Mở Rộng

1. **Thêm package mới**: Tạo recipe mới trong `meta-bbb-custom/recipes-*`
2. **Sửa package hiện có**: Tạo `.bbappend` file
3. **Thay đổi image**: Sửa bbb-dashboard recipe hoặc tạo image mới
4. **Tuning performance**: Sửa local.conf hoặc layer.conf

---
**Ngôn ngữ giao tiếp**: Tiếng Việt  
**Ngôn ngữ code/comments**: Tiếng Anh  
**Branch mục tiêu**: kirkstone
