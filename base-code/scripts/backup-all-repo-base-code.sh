#!/bin/bash
set -euo pipefail

# ==============================
# CẤU HÌNH
# ==============================

# Thư mục gốc để chứa bản backup tạm
BASE_DIR="$HOME/Desktop/backup_all_repo_base_code"

# Tên gói backup theo ngày giờ
TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")
WORK_DIR="$BASE_DIR/backup_all_repo_base_code_$TIMESTAMP"
ARCHIVE_FILE="$BASE_DIR/backup_all_repo_base_code_$TIMESTAMP.tar.gz"

# Danh sách 5 repo
REPOS=(
  "git@github.com:cskh-htms/htms_api.git"
  "git@github.com:cskh-htms/htms_redis.git"
  "git@github.com:cskh-htms/htms_devcontainer.git"
)

# ==============================
# CHẠY
# ==============================

echo "==> Tạo thư mục gốc: $BASE_DIR"
mkdir -p "$BASE_DIR"

echo "==> Tạo thư mục làm việc: $WORK_DIR"
mkdir -p "$WORK_DIR"

echo "==> Bắt đầu clone các project..."
for REPO in "${REPOS[@]}"; do
  echo "   -> Clone $REPO"
  git clone  "$REPO" "$WORK_DIR/$(basename "$REPO" .git)"
done

echo "==> Nén thư mục thành file: $ARCHIVE_FILE"
tar -czf "$ARCHIVE_FILE" -C "$BASE_DIR" "$(basename "$WORK_DIR")"

echo "==> Xóa thư mục clone tạm: $WORK_DIR"
rm -rf "$WORK_DIR"

echo "==> Hoàn tất"
echo "File backup nằm tại: $ARCHIVE_FILE"