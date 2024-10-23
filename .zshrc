# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Created by Zap installer
[ -f "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh" ] && source "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh"
plug "zsh-users/zsh-autosuggestions"
plug "zap-zsh/supercharge"
plug "zap-zsh/zap-prompt"
plug "zsh-users/zsh-syntax-highlighting"
plug "romkatv/powerlevel10k"

alias zshconfig="nvim ~/.zshrc"
alias ohmyzsh="nvim ~/.oh-my-zsh"
alias dashenv='source ~/Development/dashboard/frontend/dashboard/env/bin/activate'
alias nvimconfig="cd ~/.config/nvim/ && nvim ."
alias v="nvim"
alias lg="lazygit"

if [ -x "$(command -v lsd)" ]; then
  alias ls="lsd --group-dirs first"
  alias la="lsd --long --all --group-dirs first"
fi


# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

export XDG_CONFIG_HOME="$HOME/.config"

# killport alias
alias killport='lsof -t -i tcp:$1 | xargs kill'

# Adding libexec/bin to path
export PATH=$PATH:/opt/homebrew/opt/python@3/libexec/bin

source <(fzf --zsh)

# Load and initialise completion system
autoload -Uz compinit
compinit
