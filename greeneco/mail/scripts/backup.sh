#!/bin/bash
set -euo pipefail

# =========================
# CẤU HÌNH
# =========================
MAIL_DIR="/opt/mailserver"
BACKUP_ROOT="/backup/mail"
MAX_FILES=50

# =========================
# CHECK MAILSERVER
# =========================
if [ ! -f "$MAIL_DIR/docker-compose.yml" ]; then
  echo "❌ docker-compose.yml not found in $MAIL_DIR"
  exit 1
fi

# =========================
# LOCK CHỐNG CHẠY TRÙNG
# =========================
LOCKFILE="/tmp/mail-backup.lock"
exec 9>"$LOCKFILE"
if ! flock -n 9; then
  echo "⏳ Backup is already running. Exit."
  exit 0
fi

# =========================
# ENSURE BACKUP DIR
# =========================
if [ ! -d "$BACKUP_ROOT" ]; then
  echo "📁 Creating $BACKUP_ROOT"
  mkdir -p "$BACKUP_ROOT"
  chown root:root /backup "$BACKUP_ROOT"
  chmod 755 /backup "$BACKUP_ROOT"
fi

# =========================
# TIMESTAMP
# =========================
TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")
TMP_BACKUP_DIR="$BACKUP_ROOT/tmp-$TIMESTAMP"
ARCHIVE_FILE="$BACKUP_ROOT/mail-backup-$TIMESTAMP.tar.gz"

echo "👉 Backup docker-mailserver (LIVE MODE)"
echo "📁 Temp dir : $TMP_BACKUP_DIR"
echo "📦 Archive  : $ARCHIVE_FILE"

mkdir -p "$TMP_BACKUP_DIR"

# =========================
# BACKUP DATA (LIVE)
# =========================
rsync -a --delete "$MAIL_DIR/maildata/"  "$TMP_BACKUP_DIR/maildata/"
rsync -a --delete "$MAIL_DIR/mailstate/" "$TMP_BACKUP_DIR/mailstate/"
rsync -a            "$MAIL_DIR/logs/"     "$TMP_BACKUP_DIR/logs/"
rsync -a            "$MAIL_DIR/config/"   "$TMP_BACKUP_DIR/config/"

cp "$MAIL_DIR/docker-compose.yml" "$TMP_BACKUP_DIR/"
[ -f "$MAIL_DIR/.env" ] && cp "$MAIL_DIR/.env" "$TMP_BACKUP_DIR/"

# =========================
# NÉN TAR.GZ
# =========================
echo "📦 Compressing backup..."
tar -czf "$ARCHIVE_FILE" -C "$TMP_BACKUP_DIR" .

# =========================
# XOÁ THƯ MỤC TẠM
# =========================
rm -rf "$TMP_BACKUP_DIR"

# =========================
# CHỈ GIỮ LẠI 15 FILE BACKUP MỚI NHẤT
# =========================
echo "🧹 Cleanup old backups (keep $MAX_FILES files)..."

ls -1t "$BACKUP_ROOT"/mail-backup-*.tar.gz 2>/dev/null \
  | tail -n +$((MAX_FILES + 1)) \
  | xargs -r rm -f

# =========================
# DONE
# =========================
echo "✅ Backup DONE!"
echo "📦 File saved at: $ARCHIVE_FILE"
