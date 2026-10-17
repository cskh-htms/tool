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

# dpkg asks how to handle locally changed config files during upgrades.
# Set the default in both dpkg and apt config so it applies even when a helper
# script invokes apt without forwarding command-line options. Restore existing
# files on exit, including when a step fails.
DPKG_CONFIG_DIR=/etc/dpkg/dpkg.cfg.d
DPKG_CONFIG_FILE="$DPKG_CONFIG_DIR/99-llasta-noninteractive"
APT_CONFIG_DIR=/etc/apt/apt.conf.d
APT_CONFIG_FILE="$APT_CONFIG_DIR/99-llasta-noninteractive"
DPKG_CONFIG_BACKUP=""
APT_CONFIG_BACKUP=""

backup_if_present() {
  local source_file="$1"
  local backup_var="$2"
  if sudo test -e "$source_file"; then
    local backup_file
    backup_file="$(mktemp)"
    sudo cp -p "$source_file" "$backup_file"
    printf -v "$backup_var" '%s' "$backup_file"
  fi
}

backup_if_present "$DPKG_CONFIG_FILE" DPKG_CONFIG_BACKUP
backup_if_present "$APT_CONFIG_FILE" APT_CONFIG_BACKUP
sudo mkdir -p "$DPKG_CONFIG_DIR" "$APT_CONFIG_DIR"
printf '%s\n' 'force-confdef' 'force-confold' | sudo tee "$DPKG_CONFIG_FILE" >/dev/null
sudo tee "$APT_CONFIG_FILE" >/dev/null <<'EOF'
Dpkg::Options {
  "--force-confold";
};
EOF

# Package conffile prompts are handled by dpkg, not debconf. Pass the option
# directly to every apt/dpkg process as a final safeguard against a frontend
# ignoring the config snippets above.
export DEBIAN_FRONTEND=noninteractive
export DEBIAN_PRIORITY=critical
export UCF_FORCE_CONFFOLD=1
export NEEDRESTART_MODE=a

restore_config_file() {
  local target_file="$1"
  local backup_file="$2"
  if [[ -n "$backup_file" ]]; then
    sudo cp -p "$backup_file" "$target_file"
    rm -f "$backup_file"
  else
    sudo rm -f "$target_file"
  fi
}

cleanup() {
  restore_config_file "$DPKG_CONFIG_FILE" "$DPKG_CONFIG_BACKUP"
  restore_config_file "$APT_CONFIG_FILE" "$APT_CONFIG_BACKUP"
  if [[ -n "${SUDO_KEEPALIVE_PID:-}" ]]; then
    kill "$SUDO_KEEPALIVE_PID" 2>/dev/null || true
  fi
}
trap cleanup EXIT

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
