#!/bin/bash
set -e

BACKUP_DIR="/backup"
DATE=$(date +"%Y-%m-%d_%H-%M")
HOSTNAME=$(hostname)
BACKUP_FILE="vps-full-${HOSTNAME}-${DATE}.tar.zst"
MEGA_DIR="/VPS_BACKUP/${HOSTNAME}"

mkdir -p $BACKUP_DIR

echo "===> Stop Docker completely"
systemctl stop docker || true
systemctl stop docker.socket || true

echo "===> Start backup at $(date)"

START=$(date +%s)

ionice -c2 -n0 nice -n -5 \
tar \
--exclude=/proc \
--exclude=/sys \
--exclude=/dev \
--exclude=/tmp \
--exclude=/run \
--exclude=/mnt \
--exclude=/media \
--exclude=/swapfile \
--exclude=/lost+found \
--exclude=$BACKUP_DIR \
-cf - / \
| pv \
| zstd -15 -T0 -o $BACKUP_DIR/$BACKUP_FILE

END=$(date +%s)
DURATION=$((END - START))

echo "===> Backup finished in $((DURATION/60))m $((DURATION%60))s"

echo "===> Start Docker"
systemctl start docker.socket || true
systemctl start docker || true

echo "===> Upload to Mega"
mega-mkdir -p "$MEGA_DIR" || true
mega-put "$BACKUP_DIR/$BACKUP_FILE" "$MEGA_DIR"

echo "===> Cleanup local backup older than 3 days"
find $BACKUP_DIR -type f -mtime +3 -delete

echo "===> DONE"
