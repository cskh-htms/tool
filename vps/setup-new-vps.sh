#!/usr/bin/env bash

# Run the standard VPS setup in the same order as llastbm, llastat,
# llastdk, llastng, and llastsw. Authenticate sudo once, then run all
# steps without interactive confirmation prompts.
set -Eeuo pipefail

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"

if [[ "$EUID" -ne 0 ]]; then
  echo 'Nhập mật khẩu sudo một lần để bắt đầu cài đặt.'
  sudo -v
  # Keep sudo credentials alive while this setup is running.
  while true; do sudo -n true; sleep 50; kill -0 "$BASHPID" 2>/dev/null || exit; done &
  SUDO_KEEPALIVE_PID=$!
  trap 'kill "$SUDO_KEEPALIVE_PID" 2>/dev/null || true' EXIT
fi

# Prevent apt/dpkg from asking whether to keep or replace configuration files.
export DEBIAN_FRONTEND=noninteractive

run_step() {
  local label="$1"
  local script="$2"

  printf '\n\n========== %s ==========\n' "$label"
  if ! sudo -E bash "$SCRIPT_DIR/$script"; then
    printf '\nERROR: %s failed; stopping setup.\n' "$label" >&2
    exit 1
  fi
}

create_swap() {
  local swapfile=/swapfile
  local fstab_entry='/swapfile none swap sw 0 0'

  printf '\n\n========== Create 2G swap ==========\n'
  if swapon --show=NAME --noheadings | grep -Fxq "$swapfile"; then
    echo 'Swap /swapfile is already active; skipping creation.'
  else
    if [[ ! -e "$swapfile" ]]; then
      fallocate -l 2G "$swapfile"
    elif [[ "$(stat -c '%s' "$swapfile")" -lt 2147483648 ]]; then
      echo '/swapfile exists and is smaller than 2G; refusing to overwrite it.' >&2
      exit 1
    fi

    chmod 600 "$swapfile"
    mkswap "$swapfile"
    swapon "$swapfile"
  fi

  if ! grep -Fqx "$fstab_entry" /etc/fstab; then
    printf '%s\n' "$fstab_entry" >> /etc/fstab
  fi
  free -h
}

if [[ "${1:-}" == "--swap-only" ]]; then
  if [[ "$EUID" -ne 0 ]]; then
    echo 'Nhập mật khẩu sudo một lần để tạo swap.'
    sudo -v
    exec sudo -E env DEBIAN_FRONTEND=noninteractive bash "$0" --swap-only
  fi
  create_swap
  exit 0
elif [[ $# -gt 0 ]]; then
  echo "Usage: $0 [--swap-only]" >&2
  exit 2
fi

run_step '1/5 VPS security' 'setup-security.sh'
run_step '2/5 Common tools' 'install-all-tools.sh'
run_step '3/5 Docker' 'install-docker.sh'
run_step '4/5 Nginx and Certbot' 'install-nginx.sh'
create_swap

printf '\n✅ VPS setup completed successfully.\n'
