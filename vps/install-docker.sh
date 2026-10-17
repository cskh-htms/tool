#!/bin/bash

set -e

echo "==============================="
echo " Docker setup for Ubuntu 22.04 "
echo "==============================="

# Lấy user hiện tại (kể cả khi chạy bằng sudo)
CURRENT_USER=${SUDO_USER:-$USER}

echo "👉 User hiện tại: $CURRENT_USER"

# 1. Update hệ thống
echo "🔄 Update hệ thống..."
sudo apt update -y
sudo apt -o Dpkg::Options::=--force-confdef -o Dpkg::Options::=--force-confold upgrade -y

# 2. Cài các gói cần thiết
echo "📦 Cài gói phụ thuộc..."
sudo apt -o Dpkg::Options::=--force-confdef -o Dpkg::Options::=--force-confold install -y \
    ca-certificates \
    curl \
    gnupg \
    lsb-release \
    apt-transport-https

# 3. Thêm Docker GPG key
echo "🔑 Thêm Docker GPG key..."
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | \
sudo gpg --dearmor --yes -o /etc/apt/keyrings/docker.gpg

# 4. Thêm Docker repo
echo "➕ Thêm Docker repository..."
echo \
"deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] \
https://download.docker.com/linux/ubuntu \
$(lsb_release -cs) stable" | \
sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# 5. Cài Docker Engine + Compose
echo "🐳 Cài Docker Engine & Docker Compose..."
sudo apt update -y
sudo apt -o Dpkg::Options::=--force-confdef -o Dpkg::Options::=--force-confold install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# 6. Enable Docker service
echo "🚀 Enable Docker service..."
sudo systemctl enable docker
sudo systemctl start docker

# 7. Tạo group docker nếu chưa có
if ! getent group docker > /dev/null; then
    echo "👥 Tạo group docker..."
    sudo groupadd docker
fi

# 8. Add user vào group docker
echo "➕ Add user $CURRENT_USER vào group docker..."
if ! id -nG "$CURRENT_USER" | tr ' ' '\n' | grep -Fxq docker; then
    sudo usermod -aG docker "$CURRENT_USER"
fi

# 9. Test docker
echo "🧪 Test Docker..."
sudo docker run --rm hello-world

echo "==============================="
echo "✅ Docker cài đặt XONG"
echo "⚠️ Logout & login lại để dùng docker KHÔNG cần sudo"
echo "👉 Hoặc reboot: sudo reboot"
echo "==============================="
