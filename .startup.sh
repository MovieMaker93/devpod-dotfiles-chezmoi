#!/bin/bash

set -ex

install_on_ubuntu() {
	if which nix; then
		echo 'Nix is already installed'
	else
		curl -L https://nixos.org/nix/install | sh -s -- --daemon
	fi
}

install_on_mac() {
	xcode-select --install || echo "XCode already installed"
	install_brew
	(
		echo
		echo 'eval "$(/opt/homebrew/bin/brew shellenv)"'
	) >>$HOME/.bashrc
	eval "$(/opt/homebrew/bin/brew shellenv)"
}

install_brew() {
	if which brew; then
		echo 'Homebrew is already installed'
	else
		/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
	fi
}

OS="$(uname -s)"
case "${OS}" in
Linux*)
	if [ -f /etc/lsb-release ]; then
		install_on_ubuntu
	else
		echo "Unsupported Linux distribution"
		exit 1
	fi
	;;
Darwin*)
	install_on_mac
	;;
*)
	echo "Unsupported operating system: ${OS}"
	exit 1
	;;
esac

chezmoi init https://github.com/MovieMaker93/devpod-dotfiles-chezmoi
chezmoi apply
