 <p align="center">
  <a href="https://alfonsofortunato.com">
    <picture>
      <source media="(prefers-color-scheme: dark)" srcset="https://alfonsofortunato.com/img/logo.png">
      <img src="https://alfonsofortunato.com/img/logo.png" height="90">
    </picture>
    <h1 align="center">Dotfiles MacOS and Linux</h1>
  </a>
</p>

<p align="center">
  <a href="https://github.com/MovieMaker93/devpod-dotfiles-chezmoi/commit">
    <img alt="LastCommit" src="https://img.shields.io/github/last-commit/MovieMaker93/devpod-dotfiles-chezmoi/main?style=for-the-badge&logo=github&color=%237dcfff">
  </a>
  <!-- <a href="https://github.com/MovieMaker93/devpod-dotfiles-chezmoi/actions/workflows/"> -->
  <!-- </a> -->
  <a href="https://github.com/MovieMaker93/devpod-dotfiles-chezmoi/blob/main/LICENSE">
    <img alt="License" src="https://img.shields.io/github/license/MovieMaker93/devpod-dotfiles-chezmoi?style=for-the-badge&logo=github">
  </a>
  <a href="https://github.com/MovieMaker93/devpod-dotfiles-chezmoi/stars">
    <img alt="stars" src="https://img.shields.io/github/stars/MovieMaker93/devpod-dotfiles-chezmoi?style=for-the-badge&logo=github&color=%23f7768e">
  </a>
</p>

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

---

<p align="center">
  <a href="https://alfonsofortunato.com/posts/dotfile/">
    <img alt="Static Badge" src="https://img.shields.io/badge/Blog_Posts-Go?style=for-the-badge&label=%F0%9F%92%ADRead&color=%237aa2f7">
  </a>
</p>
