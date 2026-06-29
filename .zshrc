# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

bindkey "\e\e[D" backward-word
bindkey "\e\e[C" forward-word

# Created by Zap installer
[ -f "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh" ] && source "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh"
plug "zsh-users/zsh-autosuggestions"
plug "zap-zsh/supercharge"
plug "zap-zsh/zap-prompt"
plug "zsh-users/zsh-syntax-highlighting"
plug "romkatv/powerlevel10k"

# Modular configuration (see ~/.config/zsh/)
ZSH_CONFIG_DIR="$HOME/.config/zsh"
source "$ZSH_CONFIG_DIR/env.zsh"
source "$ZSH_CONFIG_DIR/aliases.zsh"
source "$ZSH_CONFIG_DIR/functions.zsh"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Load and initialise completion system (must precede completions.zsh)
autoload -Uz compinit
compinit
source "$ZSH_CONFIG_DIR/completions.zsh"

# Load local secrets (not committed). Resolves the real dotfiles dir even when
# ~/.zshrc is a symlink.
ZSHRC_DIR="${${(%):-%x}:A:h}"
[[ -f "$ZSHRC_DIR/.zshrc.secrets" ]] && source "$ZSHRC_DIR/.zshrc.secrets"

# Load machine- and work-specific configuration (not committed)
[[ -f "$HOME/.zshrc.local" ]] && source "$HOME/.zshrc.local"
