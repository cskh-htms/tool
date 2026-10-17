#!/usr/bin/env bash

# Run the standard VPS setup in the same order as llastbm, llastf2,
# llastat, llastdk, llastng, and llastsw. Authenticate sudo once, then run all
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

# dpkg's conffile prompt is controlled by dpkg itself, so set its defaults
# globally for this run. This also covers packages installed by helper scripts
# that invoke apt without forwarding command-line options. Preserve any existing
# file and restore it on success or failure.
DPKG_CONFIG_DIR=/etc/dpkg/dpkg.cfg.d
DPKG_CONFIG_FILE="$DPKG_CONFIG_DIR/99-llasta-noninteractive"
DPKG_CONFIG_BACKUP=""
if [[ -e "$DPKG_CONFIG_FILE" ]]; then
  DPKG_CONFIG_BACKUP="$(mktemp)"
  sudo cp -p "$DPKG_CONFIG_FILE" "$DPKG_CONFIG_BACKUP"
fi
sudo mkdir -p "$DPKG_CONFIG_DIR"
printf '%s\n' 'force-confdef' 'force-confold' | sudo tee "$DPKG_CONFIG_FILE" >/dev/null
restore_dpkg_config() {
  if [[ -n "$DPKG_CONFIG_BACKUP" ]]; then
    sudo cp -p "$DPKG_CONFIG_BACKUP" "$DPKG_CONFIG_FILE"
    rm -f "$DPKG_CONFIG_BACKUP"
  else
    sudo rm -f "$DPKG_CONFIG_FILE"
  fi
}
trap restore_dpkg_config EXIT

# Keep locally modified configuration files (including sshd_config) and
# answer package-manager questions noninteractively. This is dpkg's default.
export DEBIAN_FRONTEND=noninteractive
export DEBIAN_PRIORITY=critical
export UCF_FORCE_CONFFOLD=1
export NEEDRESTART_MODE=a

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
      sudo fallocate -l 2G "$swapfile"
    elif [[ "$(sudo stat -c '%s' "$swapfile")" -lt 2147483648 ]]; then
      echo '/swapfile exists and is smaller than 2G; refusing to overwrite it.' >&2
      exit 1
    fi

    sudo chmod 600 "$swapfile"
    sudo mkswap "$swapfile"
    sudo swapon "$swapfile"
  fi

  if ! sudo grep -Fqx "$fstab_entry" /etc/fstab; then
    printf '%s\n' "$fstab_entry" | sudo tee -a /etc/fstab >/dev/null
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

run_step '1/6 VPS security' 'setup-security.sh'
run_step '2/6 Configure Fail2ban SSH on port 23266' 'cau-hinh-fail2ban-ssh-23266.sh'
run_step '3/6 Common tools' 'install-all-tools.sh'
run_step '4/6 Docker' 'install-docker.sh'
run_step '5/6 Nginx and Certbot' 'install-nginx.sh'
create_swap

printf '\n✅ VPS setup completed successfully.\n'
