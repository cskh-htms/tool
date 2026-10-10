#!/bin/bash
set -e

# Reset the repository history to a single fresh commit and force-push it.
# Use this only when old Git history should be discarded permanently.

GIT_NAME="${GIT_NAME:-cskh-htms}"
GIT_EMAIL="${GIT_EMAIL:-cskh.htms.vn@gmail.com}"
BRANCH="${BRANCH:-main}"
REMOTE_NAME="${REMOTE_NAME:-origin}"
REMOTE_URL="${REMOTE_URL:-}"
SSH_KEY=""

SCRIPT_DIR="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"
REPO_DIR="$(CDPATH= cd -- "$SCRIPT_DIR/.." && pwd)"
VERSIONS_DIR="$REPO_DIR/.aversions"
VERSION_FILE_LABEL="none"

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

cd "$REPO_DIR" || exit 1

if [ ! -d "$REPO_DIR/.git" ]; then
  echo "ERROR: Not a git repository: $REPO_DIR"
  exit 1
fi

if [ -z "$REMOTE_URL" ]; then
  REMOTE_URL="$(git remote get-url "$REMOTE_NAME" 2>/dev/null || true)"
fi

if [ -z "$REMOTE_URL" ]; then
  echo "ERROR: Cannot find remote URL. Set REMOTE_URL=git@github.com:owner/repo.git"
  exit 1
fi

if [ -d "$VERSIONS_DIR" ]; then
  VERSION_FILE_LABEL="$(find "$VERSIONS_DIR" -maxdepth 1 -type f | sort | tail -n 1 | xargs -r basename)"
  if [ -z "$VERSION_FILE_LABEL" ]; then
    VERSION_FILE_LABEL="none"
  fi
fi

CURRENT_DATE="$(date "+%Y-%m-%d %H:%M")"
COMMIT_TEXT="${COMMIT_TEXT:-fresh clean snapshot ${VERSION_FILE_LABEL} ${CURRENT_DATE}}"

echo ""
echo "======================================"
echo "  CLEAN GIT HISTORY AND FORCE PUSH"
echo "  Repo   : $REPO_DIR"
echo "  Remote : $REMOTE_URL"
echo "  Branch : $BRANCH"
echo "======================================"
echo ""
echo "This will remove local Git history, create one new commit from current files,"
echo "then force-push it to GitHub. Old GitHub history will no longer be part of"
echo "new clones from this branch."
echo ""

if [ "${YES:-}" != "1" ]; then
  printf "Type y to continue: "
  read -r CONFIRM
  case "$CONFIRM" in
    y|Y) ;;
    *)
    echo "Cancelled."
    exit 1
      ;;
  esac
fi

echo ""
echo "Setting git user..."
git config --global user.name "$GIT_NAME"
git config --global user.email "$GIT_EMAIL"

echo "Removing old .git history..."
rm -rf .git

echo "Creating fresh repository..."
git init
git checkout -b "$BRANCH"
git remote add "$REMOTE_NAME" "$REMOTE_URL"
git config user.name "$GIT_NAME"
git config user.email "$GIT_EMAIL"

echo "Adding current files..."
git add -A

if git diff --cached --quiet; then
  echo "ERROR: No files staged. Check .gitignore or repository contents."
  exit 1
fi

echo "Creating fresh commit..."
git commit -m "$COMMIT_TEXT"

echo "Cleaning local git object cache..."
git reflog expire --expire=now --all
git gc --prune=now --aggressive

echo "Force pushing clean history to GitHub..."
git push --force "$REMOTE_NAME" "$BRANCH"

echo ""
echo "======================================"
echo "  DONE"
echo "  GitHub branch now points to one clean commit."
echo "  Other machines should re-clone, or run:"
echo "    git fetch origin"
echo "    git reset --hard origin/$BRANCH"
echo "======================================"
