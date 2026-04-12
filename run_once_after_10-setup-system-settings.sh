#!/bin/bash

set -eu

echo "> Using zsh shell"

if [ "${SHELL:-}" = "/bin/zsh" ]; then
    exit 0
fi

zsh_path="$(command -v zsh)"

if ! grep -qx "$zsh_path" /etc/shells; then
    printf '%s\n' "$zsh_path" | sudo tee -a /etc/shells >/dev/null
fi

sudo chsh -s "$zsh_path" "$USER"
