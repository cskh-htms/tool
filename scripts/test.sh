#!/bin/bash
set -euo pipefail

# ==============================
# CẤU HÌNH
# ==============================
BOT_TOKEN="8674412445:AAGU5s7mMLe2Ecwt5QCHoNPARa0g7zxDdc4"
CHAT_ID="-1003526970766"
CAPTION="Test gửi file test.zip"

# Lấy thư mục chứa file .sh này
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# File cần gửi
FILE_PATH="$SCRIPT_DIR/test.zip"

echo "==> Kiểm tra file..."
if [ ! -f "$FILE_PATH" ]; then
  echo "❌ Không tìm thấy file: $FILE_PATH"
  exit 1
fi

FILE_SIZE_MB=$(du -m "$FILE_PATH" | cut -f1)
echo "==> File cần gửi: $FILE_PATH"
echo "==> Kích thước: ${FILE_SIZE_MB} MB"

echo "==> Gửi file lên Telegram channel..."
RESPONSE=$(curl -sS -X POST "https://api.telegram.org/bot${BOT_TOKEN}/sendDocument" \
  -F "chat_id=${CHAT_ID}" \
  -F "caption=${CAPTION}" \
  -F "document=@${FILE_PATH}")

echo "==> Response từ Telegram:"
echo "$RESPONSE"

echo "==> Hoàn tất"