# Shell aliases.

alias zshconfig="nvim ~/.zshrc"
alias ohmyzsh="nvim ~/.oh-my-zsh"
alias nvimconfig="cd ~/.config/nvim/ && nvim ."
alias vim='nvim --listen /tmp/nvim-server.pipe'
alias v="nvim"
alias gg="lazygit"
alias cat="bat -p"
alias dotfiles='vim ~/dotfiles'

# Checkout a recent branch via fzf
alias cb='git branch --sort=-committerdate | fzf --header Checkout | xargs git checkout'

# Helper scripts
alias gsa='~/dotfiles/scripts/git-status-all.sh'
alias find-session='~/dotfiles/scripts/find-session.sh'

# Shorthand aliases for common ports (see killport in functions.zsh)
alias kill3000='killport 3000'
alias kill3001='killport 3001'
alias kill8080='killport 8080'
alias kill5000='killport 5000'

if [ -x "$(command -v lsd)" ]; then
  alias ls="lsd --group-dirs first"
  alias la="lsd --long --all --group-dirs first"
fi
