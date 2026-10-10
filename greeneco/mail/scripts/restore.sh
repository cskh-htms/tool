#!/bin/bash

set -e

if [ -z "$1" ]; then
  echo "❌ Bạn phải truyền thư mục backup"
  echo "👉 Ví dụ:"
  echo "./restore-full-mailserver.sh backup-mailserver/2026-01-28_10-30-00"
  exit 1
fi

BACKUP_DIR="$1"

echo "⚠️ RESTORE docker-mailserver từ:"
echo "$BACKUP_DIR"

echo "⛔ Stop mailserver container..."
docker compose stop mailserver

echo "🧹 Xóa dữ liệu cũ..."
rm -rf maildata mailstate logs config

echo "📦 Restore maildata..."
rsync -a "$BACKUP_DIR/maildata/" maildata/

echo "📦 Restore mailstate..."
rsync -a "$BACKUP_DIR/mailstate/" mailstate/

echo "📦 Restore logs..."
rsync -a "$BACKUP_DIR/logs/" logs/

echo "📦 Restore config..."
rsync -a "$BACKUP_DIR/config/" config/

echo "📄 Restore docker-compose.yml"
cp "$BACKUP_DIR/docker-compose.yml" .

echo "📄 Restore .env"
cp "$BACKUP_DIR/.env" .

echo "▶️ Start mailserver container..."
docker compose up -d

echo "✅ RESTORE DONE!"
echo "📨 Mailserver chạy lại y nguyên"
