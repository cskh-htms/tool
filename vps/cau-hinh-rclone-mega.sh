#!/bin/bash
set -euo pipefail

REMOTE_NAME="mega"

read -rp "Mega email: " MEGA_USER
read -rsp "Mega password: " MEGA_PASS
echo

if ! command -v rclone >/dev/null 2>&1; then
  echo "❌ rclone not found"
  exit 1
fi

if rclone listremotes | grep -qx "${REMOTE_NAME}:"; then
  echo "👉 Remote $REMOTE_NAME already exists, deleting old config..."
  rclone config delete "$REMOTE_NAME"
fi

echo "👉 Creating Mega remote: $REMOTE_NAME"

rclone config create "$REMOTE_NAME" mega \
  user "$MEGA_USER" \
  pass "$MEGA_PASS"

echo "✅ Mega remote created"

echo "👉 Testing remote..."
rclone lsd "${REMOTE_NAME}:"

echo "✅ Done"