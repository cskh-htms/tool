#!/bin/bash

# ===============================
# CONFIG
# ===============================
SCRIPT_DIR="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"
REPO_DIR="$(CDPATH= cd -- "$SCRIPT_DIR/.." && pwd)"
GIT_NAME="tool"
GIT_EMAIL="cskh.htms.vn@gmail.com"
BRANCH="main"
VERSIONS_DIR="$REPO_DIR/.aversions"
VERSION_FILE_LABEL="none"
SSH_KEY=""

# ===============================
# SSH SETUP
# ===============================
find_github_key() {
  local search_dir="$1"
  [ -d "$search_dir" ] || return 0
  find "$search_dir" -maxdepth 1 -type f -iname '*github*' ! -iname '*.pub' \
    -print 2>/dev/null | sort | head -n 1
}

SSH_KEY="$(find_github_key "$REPO_DIR/ssh/key")"

if [ -z "$SSH_KEY" ]; then
  UBUNTU_SSH_DIRS=(/root/.ssh)
  if [ -n "${HOME:-}" ]; then
    UBUNTU_SSH_DIRS=("$HOME/.ssh" "${UBUNTU_SSH_DIRS[@]}")
  fi
  for user_ssh_dir in /home/*/.ssh; do
    UBUNTU_SSH_DIRS+=("$user_ssh_dir")
  done
  for ssh_dir in "${UBUNTU_SSH_DIRS[@]}"; do
    SSH_KEY="$(find_github_key "$ssh_dir")"
    [ -n "$SSH_KEY" ] && break
  done
fi

if [ -z "$SSH_KEY" ]; then
  echo "Không tìm thấy SSH key có tên chứa 'github' trong ssh/key hoặc các thư mục .ssh của Ubuntu."
  exit 1
fi

chmod 600 "$SSH_KEY"
echo "Sử dụng SSH key: $SSH_KEY"

CURRENT_SSH_DIR="${HOME:-/root}/.ssh"
mkdir -p "$CURRENT_SSH_DIR"
ssh-keyscan -H github.com >> "$CURRENT_SSH_DIR/known_hosts" 2>/dev/null
printf -v GIT_SSH_COMMAND \
  'ssh -i %q -o IdentitiesOnly=yes -o StrictHostKeyChecking=no' "$SSH_KEY"
export GIT_SSH_COMMAND

# ===============================
# SET GIT USER (GLOBAL)
# ===============================
git config --global user.name "$GIT_NAME"
git config --global user.email "$GIT_EMAIL"

# ===============================
# CHECK DIR
# ===============================
if [ ! -d "$REPO_DIR" ]; then
  echo "Khong tim thay thu muc: $REPO_DIR"
  exit 1
fi

cd "$REPO_DIR" || exit 1

echo "Repo: $(pwd)"

if [ -d "$VERSIONS_DIR" ]; then
  VERSION_FILE_LABEL="$(find "$VERSIONS_DIR" -maxdepth 1 -type f | sort | tail -n 1 | xargs -r basename)"

  if [ -z "$VERSION_FILE_LABEL" ]; then
    VERSION_FILE_LABEL="none"
  fi
fi

# ===============================
# TIME FORMAT
# ===============================
CURRENT_DATE=$(date "+%Y-%m-%d %H:%M")
COMMIT_TEXT="update ${VERSION_FILE_LABEL} ${CURRENT_DATE}"

# ===============================
# GIT ACTIONS
# ===============================
echo "git add ."
git add .

echo "git commit"
git commit -m "$COMMIT_TEXT" || echo "Khong co thay doi de commit"

echo "git push (SSH)"
git push origin "$BRANCH"

if [ $? -ne 0 ]; then
  echo "Push that bai"
  exit 1
fi

echo "Push thanh cong!"
