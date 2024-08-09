{
  packageOverrides = pkgs: with pkgs; {
    myPackages = pkgs.buildEnv {
      name = "alfonsofortunato-tools";
      paths = [
        bash-completion
        neovim
        git
        htop
        jetbrains-mono
        (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
        curl
        wget
        unzip
        bat
        lua
        rustup
        groovy
        jq
        yq
        zsh
        tmux
        gnumake
        python3
        tmuxinator
        wezterm
        docker
        go
        nodejs_22
        tmuxifier
        fd
        ripgrep
        fzf
        lazygit
        kubectl
        kubectx
        yarn
      ];
    };
  };
}

