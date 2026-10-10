#!/bin/bash
set -e

echo "🔐 Setup SSL + Reverse Proxy cho Website"

DOMAIN_NAME="green-ecosystem.com"
EMAIL="cskh.htms.vn@gmail.com"
APP_PORT=3000   # port container web của bạn

sudo mkdir -p /var/www/html

sudo tee /etc/nginx/sites-available/${DOMAIN_NAME} > /dev/null <<EOF
server {
    listen 80;
    listen [::]:80;

    server_name ${DOMAIN_NAME};

    location /.well-known/acme-challenge/ {
        root /var/www/html;
    }

    location / {
        proxy_pass http://127.0.0.1:${APP_PORT};
        proxy_set_header Host \$host;
        proxy_set_header X-Real-IP \$remote_addr;
        proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto \$scheme;
    }
}
EOF

sudo ln -sf /etc/nginx/sites-available/${DOMAIN_NAME} /etc/nginx/sites-enabled/${DOMAIN_NAME}

sudo nginx -t
sudo systemctl reload nginx

sudo certbot --nginx \
  -d ${DOMAIN_NAME} \
  --email ${EMAIL} \
  --agree-tos \
  --non-interactive \
  --redirect

sudo systemctl reload nginx

echo "✅ Website sẵn sàng tại https://${DOMAIN_NAME}"
