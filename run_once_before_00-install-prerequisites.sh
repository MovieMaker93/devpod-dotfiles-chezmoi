#!/bin/bash
set -eu

if command -v bw >/dev/null 2>&1; then
    echo "Bitwarden CLI already installed"
    exit 0
fi

case "$(uname -s)" in
Darwin)
    brew install bitwarden-cli
    ;;
Linux*)
    nix-env -iA nixpkgs.bitwarden-cli
    ;;
*)
    echo "unsupported OS"
    exit 1
    ;;
esac
