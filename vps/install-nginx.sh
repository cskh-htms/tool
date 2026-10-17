#!/bin/bash
set -e

echo "=== Update system ==="
sudo apt update -y && sudo apt -o Dpkg::Options::=--force-confdef -o Dpkg::Options::=--force-confold upgrade -y

echo "=== Install Nginx (Ubuntu repo - stable) ==="
sudo apt -o Dpkg::Options::=--force-confdef -o Dpkg::Options::=--force-confold install -y nginx
sudo systemctl enable nginx
sudo systemctl start nginx

echo "=== Allow Nginx through firewall (if UFW exists) ==="
if command -v ufw >/dev/null 2>&1; then
  sudo ufw allow 'Nginx Full'
  sudo ufw reload || true
fi

echo "=== Install Certbot via SNAP (recommended) ==="
sudo apt -o Dpkg::Options::=--force-confdef -o Dpkg::Options::=--force-confold install -y snapd
sudo snap install core || sudo snap refresh core
sudo snap refresh core || true
sudo snap install --classic certbot || sudo snap refresh certbot

echo "=== Symlink certbot ==="
sudo ln -sf /snap/bin/certbot /usr/bin/certbot

echo "=== Test certbot installation ==="
certbot --version

echo "=== Done ==="
echo "Next step:"
echo "  sudo certbot --nginx -d example.com -d www.example.com"
