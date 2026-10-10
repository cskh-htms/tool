#!/bin/bash
set -e

echo "🔐 Setup SSL + Reverse Proxy cho web"

# =============================
# Config
# =============================
DOMAIN_NAME="demo.epacvn.com"
EMAIL="cskh.htms.vn@gmail.com"
PORT=3001

# =============================
# Cleanup default nginx site
# =============================
sudo rm -f /etc/nginx/sites-enabled/default

# =============================
# HTTP config (Certbot verify)
# =============================
sudo tee /etc/nginx/sites-available/${DOMAIN_NAME} > /dev/null <<EOF
server {
    listen 80;
    listen [::]:80;

    server_name ${DOMAIN_NAME};

    location / {
      proxy_pass http://127.0.0.1:${PORT};

      proxy_set_header Host \$host;
      proxy_set_header X-Forwarded-Host \$host;
      proxy_set_header X-Forwarded-Port \$server_port;
      proxy_set_header X-Real-IP \$remote_addr;
      proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
      proxy_set_header X-Forwarded-Proto \$scheme;

      proxy_http_version 1.1;
      proxy_set_header Upgrade \$http_upgrade;
      proxy_set_header Connection "upgrade";
    }
}
EOF

sudo ln -sf /etc/nginx/sites-available/${DOMAIN_NAME} /etc/nginx/sites-enabled/${DOMAIN_NAME}

sudo nginx -t
sudo systemctl reload nginx

# =============================
# SSL
# =============================
sudo certbot --nginx \
  -d ${DOMAIN_NAME} \
  --email ${EMAIL} \
  --agree-tos \
  --non-interactive \
  --redirect

sudo systemctl reload nginx

echo "✅  ready: https://${DOMAIN_NAME}"
