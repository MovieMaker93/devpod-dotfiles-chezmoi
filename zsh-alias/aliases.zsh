alias today='date +%Y-%m-%d'
alias md="mkdir"

#alias cd
alias script='cd $SCRIPTS'
alias cdblog="cd ~/websites/blog-site/blog/"
alias cdpblog='cd $VAULT/Areas/Blogging/content'
alias vault='cd $VAULT'
alias nconf='cd $HOME/.config/nvim/'

#repos
alias hl='cd $HOMELAB'
alias dot='cd $DOTFILES'
alias repos='cd $REPOS'
alias ghrepos='cd $GHREPOS'

# count files
alias count='find . -type f | wc -l'
alias v='nvim'
alias fv='nvim $(fzfb)'

#tmux alias
alias tns='tmux new -s $(echo $(pwd) | xargs basename)'
alias tx=tmuxifier

#fzf azlias
alias fzfb='fzf --preview "bat --color always --style numbers {}"'

#cat alias
alias cat='bat --paging never --theme DarkNeon --style plain'

#kubectl aliases
alias k='kubectl'
alias kl='kubectl logs'
alias kg='kubectl get $1'
alias kgy='kubectl get $1 $2 -oyaml'
alias kn='kubens'
alias kc='kubectx'

#git aliases
alias g='git'
alias ga='git add'
alias gaa='git add -A'
alias gs='git status --short'
alias gst='git status'
alias gc='git commit -m'
alias gca='git commit --amend'
alias gb='git branch'
alias gco='git checkout'
alias gp='git push origin $(git rev-parse --abbrev-ref HEAD)'
alias gmg='git merge'
alias gpf='git push --force'
alias lg='lazygit'

# gcap: commit all and push
gcap() {
    git commit -a -m $1
    git push
}

# gmerge: merge current branch to the given branch
gmerge() {
    branch=$(git rev-parse --abbrev-ref HEAD) && \
    echo "merging" $branch "to" $1
    git checkout $1 && \
    git merge $branch
}


# source the zsh config file
alias sc='source $HOME/.zshrc'
# edit the zsh config file
alias ec='$EDITOR $HOME/.zshrc'

#go to second brain note
alias gn='cd $HOME/workspace/note-taking/my-second-braing/'

# make dir and cd into it
mdcd() {
  mkdir -p -- "$1" && cd -P -- "$1"
}

#flux short
alias fgk='flux get kustomization'
