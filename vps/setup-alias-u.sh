#!/usr/bin/env bash

# Tao file alias rieng; khong sua ~/.bash_aliases.
(
    set -euo pipefail
    SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
    SOURCE_FILE="$SCRIPT_DIR/setup-alias.sh"
    ALIASES_FILE="$HOME/.bash_aliasu"
    BASHRC="$HOME/.bashrc"
    TMP_FILE="$(mktemp)"
    trap 'rm -f -- "$TMP_FILE"' EXIT

    # Chi lay danh sach alias/ham, khong chay script cai dat goc.
    awk '
        /^cat > "\$ALIASES_FILE" <<\047EOF\047$/ { inside = 1; next }
        inside && /^EOF$/ { found = 1; exit }
        inside { print }
        END { if (!found) exit 1 }
    ' "$SOURCE_FILE" > "$TMP_FILE" || {
        echo "Khong doc duoc danh sach alias trong $SOURCE_FILE" >&2
        exit 1
    }
    bash -n "$TMP_FILE"

    # Moi lan chay se cap nhat toan bo file rieng tu danh sach goc.
    cat -- "$TMP_FILE" > "$ALIASES_FILE"

    # Chi them khoi load neu chua co, khong them trung khi chay lai.
    if ! grep -Eq '^[[:space:]]*(source|\.)[[:space:]]+(~|\$HOME|"\$HOME)/\.bash_aliasu"?([[:space:];]|$)' "$BASHRC" 2>/dev/null; then
        printf '\n# Load aliases from ~/.bash_aliasu\nif [ -f "$HOME/.bash_aliasu" ]; then\n    . "$HOME/.bash_aliasu"\nfi\n' >> "$BASHRC"
    fi

    echo "Da cap nhat $ALIASES_FILE va cau hinh .bashrc de load file nay."
    echo 'Chay: source ~/.bashrc de nap vao terminal hien tai.'
)
