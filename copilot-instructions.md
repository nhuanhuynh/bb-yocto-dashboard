---
name: Quy tắc Yocto Project
description: "Hướng dẫn làm việc với tôi"
---

# Quy Tắc Phát Triển Yocto Project

## Ngôn ngữ
- Khi trao đổi với tôi, hãy sử dụng tiếng Việt. Tôi có thể hiểu và phản hồi bằng tiếng Việt một cách hiệu quả.
- Khi viết code, viết bình luận và commit code, hãy dùng tiếng Anh.

## Cách làm việc với tôi
- Tỗi sẽ đưa yêu cầu, bạn sẽ trả lời bằng tiếng Việt, giải thích chi tiết và cung cấp hướng dẫn cụ thể.

- Khi tôi Ok và yêu cầu sửa code, bạn sẽ chỉ sửa phần code đó, không thêm hoặc xóa các phần khác.

## Phong Cách Code & Định Dạng

### BitBake Recipe Files (.bb, .bbappend, .inc)
- **Thụt lề**: Sử dụng 4 khoảng trắng (không dùng Tab)
- **Độ dài dòng**: Giữ dòng dưới 100 ký tự nếu có thể
- **Tên biến**: Dùng CHỮ HOA cho biến BitBake, chữ thường cho biến shell
- **Bình luận**: Dùng `#` cho bình luận một dòng; giải thích "tại sao", không chỉ "cái gì"
- **Gán giá trị biến**: 
  - Dùng `VAR = "value"` cho gán đơn giản
  - Dùng `VAR:append = " extra"` để thêm giá trị
  - Dùng `VAR:prepend = "prefix "` để thêm phía trước
  - Nhóm các biến liên quan lại với nhau

### Ví dụ định dạng:
```bitbake
# Tốt: bình luận mô tả rõ
SUMMARY = "Mô tả ngắn gọi về package"
DESCRIPTION = "Mô tả chi tiết hơn về package \
có thể kéo dài trên nhiều dòng"

# Nhóm các biến tương tự
HOMEPAGE = "https://example.com"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://LICENSE;md5=xxxxx"

# Liệt kê dependencies rõ ràng
DEPENDS = "base-files virtual/libc"
RDEPENDS:${PN} = "libc6 bash"
```

### conf/local.conf
- Nhóm các setting liên quan với bình luận
- Dùng bình luận mô tả cho những setting không rõ ràng
- Tuân theo định dạng hiện có trong file

## Quy Trình Làm Việc

- Chỉ sửa code, tối sẽ review và tự buildbuild

### Khi Tạo BitBake Recipes Mới
1. **Kiểm tra recipes hiện có** - Tìm trong `poky/meta-*/recipes-*/` những package tương tự trước khi tạo mới
2. **Dùng PV (Package Version)** - Luôn chỉ định version rõ ràng, không dựa vào ${PN}
3. **Thêm thông tin giấy phép** - Luôn thêm `LICENSE` và `LIC_FILES_CHKSUM` từ source
4. **Sắp xếp biến theo logic**:
   - SUMMARY, DESCRIPTION
   - HOMEPAGE, LICENSE, LIC_FILES_CHKSUM
   - PV, SRC_URI, SRCREV
   - DEPENDS, RDEPENDS
   - Các câu lệnh inherit
   - Các hàm do_* ở cuối cùng
5. **Test build** - Luôn kiểm tra với `bitbake <recipe-name>` trước khi commit

### Khi Sửa Recipes Hiện Có
- Dùng `.bbappend` files khi làm việc trong custom layers (không sửa trực tiếp trong `poky/`)
- Bình luận rõ ràng tại sao cần sửa
- Ghi chú tương thích version nếu thay đổi là riêng cho version nào

### Build & Test
1. Clean trước các build lớn: `bitbake -c clean <recipe>` nếu cấu trúc thay đổi
2. Dùng incremental builds khi phát triển: `bitbake <recipe>` mà không clean
3. Kiểm tra lỗi build: Luôn xem build log trong `build/tmp/work/`
4. Test với `bitbake-layers show-recipes` để xác minh recipe visibility

### Commit Messages
- Bắt đầu bằng tên layer/recipe: `[meta-xxx] recipe-name: mô tả ngắn`
- Giải thích những gì thay đổi và tại sao
- Tham chiếu các số issue nếu có
- Thêm sign-off vào commit message

## Cấu Trúc Project
- **poky/** - OE-Core và meta-yocto (không sửa trực tiếp)
- **meta-*** folders - Custom/vendor layers (sửa via .bbappend hoặc tạo recipes mới)
- **build/conf/local.conf** - Cấu hình build cục bộ (riêng cho machine)
- **downloads/** - Cache source tarballs và git repos
- **sstate-cache/** - Cache build artefacts (có thể xóa để giải phóng dung lượng)

## Đường Dẫn Yocto Quan Trọng
- Recipes được tìm thấy thông qua các biến như `BBPATH` và `BBLAYERS`
- Luôn kiểm tra `bitbake-layers show-layers` để xem các layer hoạt động
- Dùng `bitbake-layers show-recipes <recipe-name>` để tìm layer nào cung cấp recipe

## Phụ lục thêm
- Nếu có yêu cầu tôi đưa ra không khớp với file này thì nhắc tôi cập nhật nó.
