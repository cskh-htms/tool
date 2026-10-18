#!/usr/bin/env bash
set -euo pipefail
systemctl status vps-resource-api.service vps-resource-monitor.slice --no-pager || true
systemctl list-timers 'vps-resource-*' --no-pager
journalctl -u 'vps-resource-*.service' -n 30 --no-pager
