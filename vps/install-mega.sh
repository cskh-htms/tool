#!/bin/bash

echo "🔽 Đang tải megacmd .deb ..."
wget https://mega.nz/linux/repo/xUbuntu_22.04/amd64/megacmd-xUbuntu_22.04_amd64.deb
if [ $? -eq 0 ]; then
    echo "✅ Tải megacmd thành công!"
else
    echo "❌ Lỗi khi tải megacmd!"
    exit 1
fi

echo "🔄 Cập nhật danh sách gói..."
sudo apt update

echo "📦 Đang cài đặt libfuse2..."
sudo apt install -y libfuse2
if [ $? -eq 0 ]; then
    echo "✅ Cài đặt libfuse2 thành công!"
else
    echo "❌ Lỗi khi cài đặt libfuse2!"
    exit 1
fi

echo "📦 Đang cài đặt megacmd..."
sudo dpkg -i megacmd-xUbuntu_22.04_amd64.deb
if [ $? -eq 0 ]; then
    echo "✅ Cài đặt megacmd thành công!"
else
    echo "❌ Lỗi khi cài đặt megacmd!"
    exit 1
fi

echo "🧪 Kiểm tra phiên bản megacmd..."
mega-cmd --version

#echo "🔐 Đăng nhập vào Mega..."
#mega-cmd login cskh.htms.vn@gmail.com Vanluc@2003@1105
#if [ $? -eq 0 ]; then
#    echo "✅ Đăng nhập thành công!"
#else
 #   echo "❌ Đăng nhập thất bại!"
  #  exit 1
#fi
