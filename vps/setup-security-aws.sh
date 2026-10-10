#!/bin/bash
set -e

echo "🚀 START VPS HARDEN..."

# Update
sudo apt update
sudo apt upgrade -y

# Packages
sudo apt install -y fail2ban curl

# Fail2ban
sudo systemctl enable fail2ban

sudo tee /etc/fail2ban/jail.local > /dev/null <<'EOF'
[DEFAULT]
bantime = 1h
findtime = 10m
maxretry = 5
backend = systemd

[sshd]
enabled = true
port = 22
EOF

# Test config trước khi restart
sudo fail2ban-client -t

sudo systemctl restart fail2ban
sudo systemctl status fail2ban --no-pager

echo ""
echo "✅ BASIC HARDEN COMPLETE"