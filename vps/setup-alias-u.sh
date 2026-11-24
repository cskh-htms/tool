#!/usr/bin/env bash

# Tao hoac cap nhat file ~/.bash_aliases.
(
    set -euo pipefail
    SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
    SOURCE_FILE="$SCRIPT_DIR/../alias ubuntu home"
    ALIASES_FILE="$HOME/.bash_aliases"
    BASHRC="$HOME/.bashrc"
    TMP_FILE="$(mktemp)"
    trap 'rm -f -- "$TMP_FILE"' EXIT

    # Lay noi dung file alias; bo CR cuoi dong de dung tren Linux.
    sed 's/\r$//' "$SOURCE_FILE" > "$TMP_FILE" || {
        echo "Khong doc duoc danh sach alias trong $SOURCE_FILE" >&2
        exit 1
    }
    bash -n "$TMP_FILE"

    # Moi lan chay se cap nhat toan bo file alias tu danh sach goc.
    cat -- "$TMP_FILE" > "$ALIASES_FILE"

    # Chi them khoi load neu chua co, khong them trung khi chay lai.
    if ! grep -Eq '^[[:space:]]*(source|\.)[[:space:]]+(~|\$HOME|"\$HOME)/\.bash_aliases"?([[:space:];]|$)' "$BASHRC" 2>/dev/null; then
        printf '\n# Load aliases from ~/.bash_aliases\nif [ -f "$HOME/.bash_aliases" ]; then\n    . "$HOME/.bash_aliases"\nfi\n' >> "$BASHRC"
    fi

    echo "Da cap nhat $ALIASES_FILE va cau hinh .bashrc de load file nay."
    echo 'Chay: source ~/.bashrc de nap vao terminal hien tai.'
)
