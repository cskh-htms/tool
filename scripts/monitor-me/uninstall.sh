#!/usr/bin/env bash
set -euo pipefail
if (( EUID != 0 )); then exec sudo bash "$0" "$@"; fi
systemctl disable --now vps-resource-{collect,check,cleanup,nginx}.timer vps-resource-api.service
systemctl stop vps-resource-{collect,check,cleanup,nginx}.service
for name in collect check cleanup nginx api; do
  rm -f "/etc/systemd/system/vps-resource-$name.service"
done
for name in collect check cleanup nginx; do
  rm -f "/etc/systemd/system/vps-resource-$name.timer"
done
rm -f /etc/systemd/system/vps-resource-monitor.slice
systemctl daemon-reload
echo 'Đã gỡ dịch vụ. Giữ nguyên cấu hình, mã và database để có thể cài lại.'
