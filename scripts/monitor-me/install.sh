#!/usr/bin/env bash
set -euo pipefail
if (( EUID != 0 )); then
  exec sudo --preserve-env=DEPLOY_USER,TELEGRAM_ENV bash "$0" "$@"
fi
SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
SOURCE_DIR="$(cd -- "$SCRIPT_DIR/../../monitor/me" && pwd)"
export PYTHONDONTWRITEBYTECODE=1
if [[ ! -f /etc/debian_version || ! -d /run/systemd/system ]]; then
  echo 'Cần Ubuntu/Debian có systemd đang hoạt động.' >&2
  exit 1
fi
if ! command -v python3 >/dev/null; then
  apt-get update
  apt-get install -y python3
fi
python3 - "$SOURCE_DIR/agent.py" <<'PY'
from pathlib import Path
import sys
compile(Path(sys.argv[1]).read_bytes(),sys.argv[1],'exec')
PY
python3 -B "$SOURCE_DIR/repair_repo_cache.py" "$SOURCE_DIR"
# One installer at a time, independent of checkout location.
exec 9>/run/lock/vps-resource-monitor-install.lock
flock -n 9 || { echo 'Một installer khác đang chạy; vui lòng thử lại sau.' >&2; exit 1; }
stage_dir="$(mktemp -d)"
trap 'rm -rf -- "$stage_dir"' EXIT
python3 -B "$SOURCE_DIR/configure.py" "$SOURCE_DIR" /etc/vps-resource-monitor "$stage_dir" "$SCRIPT_DIR/../.."
# Validate before stopping existing jobs or replacing their configuration.
for unit in vps-resource-{collect,check,cleanup,nginx}.timer vps-resource-{collect,check,cleanup,nginx,api}.service; do
  if systemctl cat "$unit" >/dev/null 2>&1; then
    systemctl stop "$unit"
  fi
done
id vps-resource-monitor >/dev/null 2>&1 || useradd --system --home-dir /var/lib/vps-resource-monitor --shell /usr/sbin/nologin vps-resource-monitor
install -d -m 755 /opt/vps-resource-monitor
install -d -m 755 /opt/vps-resource-monitor/scripts
install -d -m 750 -o root -g vps-resource-monitor /etc/vps-resource-monitor
install -d -m 750 -o vps-resource-monitor -g vps-resource-monitor /var/lib/vps-resource-monitor
install -m 644 "$SOURCE_DIR/agent.py" /opt/vps-resource-monitor/agent.py
for command in status test uninstall; do
  install -m 755 "$SCRIPT_DIR/$command.sh" "/opt/vps-resource-monitor/scripts/$command.sh"
done
install -m 640 -o root -g vps-resource-monitor "$stage_dir/config.json" /etc/vps-resource-monitor/config.json
install -m 640 -o root -g vps-resource-monitor "$stage_dir/telegram.env" /etc/vps-resource-monitor/telegram.env
# Runtime reads only its installed code, configuration and database.
cat > /etc/systemd/system/vps-resource-monitor.slice <<'UNIT'
[Unit]
Description=Shared resource budget for VPS monitor
[Slice]
CPUQuota=10%
CPUWeight=10
MemoryHigh=64M
MemoryMax=96M
MemorySwapMax=0
IOWeight=10
TasksMax=32
UNIT
for job in collect check cleanup nginx api; do
  kind=oneshot
  start_limit=0
  supplementary_groups=
  [[ "$job" == api ]] && kind=simple
  [[ "$job" == api ]] && start_limit=300
  [[ "$job" == nginx ]] && supplementary_groups='SupplementaryGroups=adm'
  cat > "/etc/systemd/system/vps-resource-$job.service" <<UNIT
[Unit]
Description=VPS resource monitor $job
After=network.target
StartLimitIntervalSec=$start_limit
StartLimitBurst=3
[Service]
Type=$kind
User=vps-resource-monitor
Group=vps-resource-monitor
Slice=vps-resource-monitor.slice
ExecStart=/usr/bin/python3 /opt/vps-resource-monitor/agent.py $job
Environment=VPS_MONITOR_TELEGRAM=/etc/vps-resource-monitor/telegram.env
Environment=PYTHONDONTWRITEBYTECODE=1
WorkingDirectory=/var/lib/vps-resource-monitor
Nice=15
IOSchedulingClass=idle
$supplementary_groups
UMask=0027
NoNewPrivileges=yes
ProtectSystem=strict
ProtectHome=yes
PrivateTmp=yes
ReadWritePaths=/var/lib/vps-resource-monitor
RestrictAddressFamilies=AF_UNIX AF_INET AF_INET6
TimeoutStartSec=30
TimeoutStopSec=5
UNIT
  if [[ "$job" == api ]]; then
    cat >> "/etc/systemd/system/vps-resource-$job.service" <<'UNIT'
Restart=on-failure
RestartSec=15
[Install]
WantedBy=multi-user.target
UNIT
  fi
done
for job in collect check cleanup nginx; do
  case "$job" in
    collect) schedule='*-*-* *:*:00' ;;
    check) schedule='*-*-* *:0/2:15' ;;
    cleanup) schedule='*-*-* *:00:30' ;;
    nginx) schedule='*-*-* *:*:05' ;;
  esac
  cat > "/etc/systemd/system/vps-resource-$job.timer" <<UNIT
[Unit]
Description=Schedule VPS resource $job
[Timer]
OnCalendar=$schedule
AccuracySec=1s
Unit=vps-resource-$job.service
[Install]
WantedBy=timers.target
UNIT
done
runuser -u vps-resource-monitor -- env VPS_MONITOR_TELEGRAM=/etc/vps-resource-monitor/telegram.env python3 /opt/vps-resource-monitor/agent.py validate
runuser -u vps-resource-monitor -- python3 /opt/vps-resource-monitor/agent.py init
systemctl daemon-reload
systemd-analyze verify /etc/systemd/system/vps-resource-{collect,check,cleanup,nginx,api}.service /etc/systemd/system/vps-resource-{collect,check,cleanup,nginx}.timer /etc/systemd/system/vps-resource-monitor.slice
systemctl reset-failed vps-resource-{collect,check,cleanup,api}.service
systemctl reset-failed vps-resource-nginx.service >/dev/null 2>&1 || true
systemctl enable vps-resource-{collect,check,cleanup,nginx}.timer vps-resource-api.service
systemctl restart vps-resource-{collect,check,cleanup,nginx}.timer vps-resource-api.service
systemctl start vps-resource-{collect,nginx}.service
systemctl is-active --quiet vps-resource-api.service
port="$(python3 -c 'import json; print(json.load(open("/etc/vps-resource-monitor/config.json"))["port"])')"
echo "Đã bật dịch vụ và lịch tự chạy sau reboot. API: http://IP_VPS:$port/api/v1/health"
echo 'Nếu có firewall/security group, cần cho phép TCP cổng API để truy cập từ ngoài.'
echo 'Sửa Telegram tại file gốc rồi chạy lại installer để cập nhật bản dùng cho dịch vụ.'
