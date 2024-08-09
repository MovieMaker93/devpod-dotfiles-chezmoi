# Dotfiles
This repository contains my dotfiles for configuring new machines or initializing development containers using the Chezmoi tool.   
It provides cross-platform dotfiles compatible with macOS and various Linux distributions.

## Requirements
- Chezmoi (must be installed)

## Installation
The `startup.sh` script will install the appropriate package manager (Homebrew for macOS, Nix for Linux) and set up the dotfiles:
```bash
curl -sfL https://raw.githubusercontent.com/MovieMaker93/devpod-dotfiles-chezmoi/main/.startup.sh | bash
```
This script initializes and applies Chezmoi with this GitHub repository.

## Adding New Dotfiles
If you want to add new dotfiles or modify the existing ones:
```bash
chezmoi add <name_of_the_file>
```
Then navigate to .local/share/chezmoi to push changes to git.

## Updating Dotfiles
To pull latest changes:
```bash
chezmoi git pull -- --autostash --rebase && chezmoi diff
```
If you're satisfied with the changes, apply them:
```bash
chezmoi apply
```

