#!/bin/sh
set -eu

SSH_PORT="${SSH_PORT:-23266}"
IGNORE_IP="${IGNORE_IP:-127.0.0.1/8 ::1}"
JAIL_LOCAL="/etc/fail2ban/jail.local"
BACKUP="${JAIL_LOCAL}.bak-$(date +%Y%m%d%H%M%S)"

echo "=== CHECK SSH PORT ==="
echo "Configured SSH port from script: ${SSH_PORT}"
sudo sshd -T 2>/dev/null | grep '^port ' || true
sudo ss -tlnp | grep sshd || true

echo
echo "=== CHECK FAIL2BAN ==="
if ! command -v fail2ban-client >/dev/null 2>&1; then
  echo "ERROR: fail2ban-client not found. Install fail2ban first."
  exit 1
fi

systemctl is-active fail2ban || true
systemctl is-enabled fail2ban || true
sudo fail2ban-client status || true

echo
echo "=== BACKUP CONFIG ==="
if [ -f "$JAIL_LOCAL" ]; then
  sudo cp "$JAIL_LOCAL" "$BACKUP"
  echo "Backup saved: $BACKUP"
else
  echo "No existing $JAIL_LOCAL found. A new one will be created."
fi

echo
echo "=== WRITE JAIL CONFIG ==="
TMP_FILE="$(mktemp)"
cat > "$TMP_FILE" <<EOF
[DEFAULT]
# Ban IP for repeated failed attempts.
bantime  = 12h
findtime = 1h
maxretry = 3

# Whitelist local/admin IPs.
ignoreip = ${IGNORE_IP}

# Ubuntu/systemd log backend.
backend = systemd

# ======================
# SSH PROTECTION
# ======================
[sshd]
enabled = true
port    = ${SSH_PORT}
filter  = sshd[mode=aggressive]
backend = systemd
maxretry = 3
findtime = 1h
bantime = 12h

# ======================
# NGINX
# ======================
[nginx-http-auth]
enabled = true

[nginx-botsearch]
enabled = true

[nginx-limit-req]
enabled = true

[nginx-bad-request]
enabled = true
EOF

sudo cp "$TMP_FILE" "$JAIL_LOCAL"
rm -f "$TMP_FILE"

echo
echo "=== TEST CONFIG ==="
sudo fail2ban-client -t

echo
echo "=== RESTART FAIL2BAN ==="
sudo systemctl restart fail2ban
sleep 2

echo
echo "=== AFTER ==="
systemctl is-active fail2ban
sudo fail2ban-client status
sudo fail2ban-client status sshd

echo
echo "=== NFTABLES FAIL2BAN RULE ==="
sudo nft list table inet f2b-table 2>/dev/null || true

echo
echo "Done. SSH jail should ban on port: ${SSH_PORT}"
echo "Config file: ${JAIL_LOCAL}"
