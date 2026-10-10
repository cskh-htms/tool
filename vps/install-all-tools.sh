#!/bin/bash
#
#
#
#
#
#
#
#
#
#
#
#
echo "Cài các tools cần thiết....."

# Install unzip
echo "Đang cài unzip"
if sudo apt install -y unzip; then
  echo "unzip đã được cài đặt thành công"
else
  echo "Cài đặt unzip thất bại" >&2
  exit 1
fi


# Install nload
echo "Đang cài nload"
if sudo apt install -y nload; then
  echo "nload đã được cài đặt thành công"
else
  echo "Cài đặt nload thất bại" >&2
  exit 1
fi

# Install iftop
echo "Đang cài iftop"
if sudo apt install -y iftop; then
  echo "iftop đã được cài đặt thành công"
else
  echo "Cài đặt iftop thất bại" >&2
  exit 1
fi

# Install pv
echo "Đang cài pv"
if sudo apt install -y pv; then
  echo "pv đã được cài đặt thành công"
else
  echo "Cài đặt pv thất bại" >&2
  exit 1
fi






# Install net-tools
echo "Đang cài net-tools"
if sudo apt install -y net-tools; then
  echo "net-tools đã được cài đặt thành công"
else
  echo "Cài đặt net-tools thất bại" >&2
  exit 1
fi

# Install inotify-tools
echo "Đang cài inotify-tools"
if sudo apt install -y inotify-tools; then
  echo "inotify-tools đã được cài đặt thành công"
else
  echo "Cài đặt inotify-tools thất bại" >&2
  exit 1
fi


# Install rclone
echo "Đang cài rclone"
if curl https://rclone.org/install.sh | sudo bash; then
  echo "rclone đã được cài đặt thành công"
else
  echo "Cài đặt rclone thất bại" >&2
  exit 1
fi

# Install tree
echo "Đang cài tree"
if sudo apt install -y tree; then
  echo "tree đã được cài đặt thành công"
else
  echo "Cài đặt tree thất bại" >&2
  exit 1
fi

echo "da cai all tool thanh cong"



