#!/bin/bash
set -ex

if type bw >/dev/null 2>&1; then
    echo "Bitwarden cli is already installed"
else
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
fi
