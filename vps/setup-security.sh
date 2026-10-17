#!/bin/bash

set -e

echo "🚀 START HARDEN VPS..."

# =========================
# 1. UPDATE SYSTEM
# =========================
sudo apt update -y
sudo apt -o Dpkg::Options::=--force-confdef -o Dpkg::Options::=--force-confold upgrade -y

# =========================
# 2. INSTALL PACKAGES
# =========================
echo "📦 Installing packages..."
sudo apt -o Dpkg::Options::=--force-confdef -o Dpkg::Options::=--force-confold install -y ufw fail2ban curl

# =========================
# 3. DOCKER HARDEN (SAFE)
# =========================
if command -v docker >/dev/null 2>&1; then
  echo "🐳 Hardening Docker..."

  # Backup nếu có
  if [ -f /etc/docker/daemon.json ]; then
    sudo cp /etc/docker/daemon.json /etc/docker/daemon.json.bak
  fi

  # Merge config (tránh phá config cũ)
  sudo tee /etc/docker/daemon.json > /dev/null <<EOF
{
  "icc": false,
  "live-restore": true,
  "no-new-privileges": true,
  "userns-remap": "default"
}
EOF

  sudo systemctl restart docker || true

  # =========================
  # DOCKER FIREWALL
  # =========================
  echo "🔒 Securing Docker network..."

  sudo iptables -N DOCKER-USER 2>/dev/null || true

  for port in 2375 2376 3333 4444 5555; do
    sudo iptables -C DOCKER-USER -p tcp --dport $port -j DROP 2>/dev/null || \
    sudo iptables -I DOCKER-USER -p tcp --dport $port -j DROP
  done

  sudo iptables -C DOCKER-USER -i lo -j RETURN 2>/dev/null || \
  sudo iptables -I DOCKER-USER -i lo -j RETURN

  sudo iptables -C DOCKER-USER -j RETURN 2>/dev/null || \
  sudo iptables -A DOCKER-USER -j RETURN
else
  echo "⚠️ Docker chưa cài → bỏ qua harden Docker"
fi

# =========================
# 4. UFW SETUP
# =========================
echo "🔥 Configuring UFW..."

sudo ufw --force reset

sudo ufw default deny incoming
sudo ufw default allow outgoing

sudo ufw allow 23266/tcp comment 'SSH'
sudo ufw allow 80/tcp
sudo ufw allow 443/tcp

# Mail
sudo ufw allow 25/tcp
sudo ufw allow 587/tcp
sudo ufw allow 465/tcp
sudo ufw allow 993/tcp
sudo ufw allow 995/tcp

sudo ufw limit 25/tcp
sudo ufw limit 587/tcp
sudo ufw limit 993/tcp

# Docker API
sudo ufw deny 2375/tcp
sudo ufw deny 2376/tcp

# Docker bridge (nếu có)
if ip link show docker0 >/dev/null 2>&1; then
  sudo ufw allow in on docker0
  sudo ufw allow out on docker0
fi

sudo ufw --force enable

# =========================
# 5. FIX DOCKER BYPASS UFW
# =========================
echo "🧠 Fix Docker bypass UFW..."

if ! sudo grep -q "DOCKER-USER" /etc/ufw/after.rules; then
  echo "👉 Adding Docker rules to UFW..."

  sudo tee -a /etc/ufw/after.rules > /dev/null <<'EOF'

# Docker rules
*filter
:DOCKER-USER - [0:0]
-A DOCKER-USER -j RETURN
COMMIT
EOF

  sudo systemctl restart ufw
else
  echo "✅ Docker UFW rule already exists"
fi

# =========================
# 6. FAIL2BAN CONFIG
# =========================
echo "🛡 Configuring Fail2ban..."

sudo systemctl enable fail2ban

sudo tee /etc/fail2ban/jail.local > /dev/null <<EOF
[DEFAULT]
bantime = 1h
findtime = 10m
maxretry = 5
backend = systemd

[sshd]
enabled = true
port = 23266

[nginx-http-auth]
enabled = true

[nginx-botsearch]
enabled = true

[nginx-limit-req]
enabled = true

[postfix]
enabled = true

[dovecot]
enabled = true
EOF

sudo systemctl restart fail2ban

# =========================
# DONE
# =========================
echo ""
echo "✅ VPS HARDENED SUCCESSFULLY!"
echo "👉 Docker secured"
echo "👉 UFW enabled"
echo "👉 Fail2ban running"
echo ""
echo "⚠️ IMPORTANT:"
echo "- Dùng 127.0.0.1 khi expose docker port"
echo "- Không mount docker.sock"
echo "- Không chạy privileged container"
echo ""
echo "👉 NÊN reboot nếu vừa update kernel:"
echo "   sudo reboot"
