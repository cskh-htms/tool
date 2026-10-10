#!/bin/bash
set -e

echo "Thêm domain để chạy SSL"

# =============================
# Khai báo biến
# =============================
DOMAIN_NAME="mail.green-ecosystem.com"
EMAIL="cskh.htms.vn@gmail.com"

# =============================
# Cài nginx + certbot
# =============================
sudo apt update
sudo apt install -y certbot python3-certbot-nginx

# =============================
# Cấu hình nginx (chỉ để certbot verify)
# =============================
sudo tee /etc/nginx/sites-available/${DOMAIN_NAME} > /dev/null <<EOF
server {
    listen 80;
    server_name ${DOMAIN_NAME};

    location /.well-known/acme-challenge/ {
        allow all;
    }
}
EOF

sudo ln -sf /etc/nginx/sites-available/${DOMAIN_NAME} /etc/nginx/sites-enabled/${DOMAIN_NAME}

sudo nginx -t
sudo systemctl reload nginx

# =============================
# Cài SSL
# =============================
sudo certbot --nginx \
  -d ${DOMAIN_NAME} \
  --email ${EMAIL} \
  --agree-tos \
  --non-interactive \
  --redirect

sudo systemctl reload nginx

echo "✅ SSL đã được cài thành công cho ${DOMAIN_NAME}"

