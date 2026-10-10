#!/bin/bash
set -e

echo "🔐 Setup SSL + Reverse Proxy cho Roundcube Webmail"

# =============================
# Biến cấu hình
# =============================
DOMAIN_NAME="webmail.green-ecosystem.com"
EMAIL="cskh.htms.vn@gmail.com"
ROUNDCUBE_PORT=8080   # port bạn expose từ docker roundcube

# =============================
# Nginx config (HTTP – để certbot verify)
# =============================
sudo tee /etc/nginx/sites-available/${DOMAIN_NAME} > /dev/null <<EOF
server {
    listen 80;
    listen [::]:80;

    server_name ${DOMAIN_NAME};

    location /.well-known/acme-challenge/ {
        root /var/www/html;
    }

    location / {
        proxy_pass http://127.0.0.1:${ROUNDCUBE_PORT};
        proxy_set_header Host \$host;
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
# Cài SSL Let's Encrypt
# =============================
sudo certbot --nginx \
  -d ${DOMAIN_NAME} \
  --email ${EMAIL} \
  --agree-tos \
  --non-interactive \
  --redirect

sudo systemctl reload nginx

echo "✅ Webmail Roundcube đã sẵn sàng tại https://${DOMAIN_NAME}"
