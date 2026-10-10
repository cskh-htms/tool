#!/bin/bash
set -euo pipefail

BACKUP_DIR="/backup/mail"
MEGA_DIR="/mail-backup"
UPLOADED_LOG="$BACKUP_DIR/.uploaded"

# Đảm bảo file log tồn tại
touch "$UPLOADED_LOG"

# ===============================
# Đảm bảo thư mục Mega tồn tại
# ===============================
if ! mega-ls "$MEGA_DIR" >/dev/null 2>&1; then
  echo "📁 Mega folder $MEGA_DIR chưa tồn tại → tạo mới"
  mega-mkdir "$MEGA_DIR"
else
  echo "📁 Mega folder $MEGA_DIR đã tồn tại → dùng luôn"
fi

# ===============================
# Upload file chưa upload
# ===============================
for file in "$BACKUP_DIR"/mail-backup-*.tar.gz; do
  [ -e "$file" ] || continue

  fname="$(basename "$file")"

  if ! grep -Fxq "$fname" "$UPLOADED_LOG"; then
    echo "☁️ Uploading $fname to Mega..."
    mega-put "$file" "$MEGA_DIR/"

    echo "$fname" >> "$UPLOADED_LOG"
    echo "✅ Uploaded $fname"
  else
    echo "⏭️  Bỏ qua $fname (đã upload)"
  fi
done
