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

alias zshconfig="nvim ~/.zshrc"
alias ohmyzsh="nvim ~/.oh-my-zsh"
alias nvimconfig="cd ~/.config/nvim/ && nvim ."
alias vim='nvim --listen /tmp/nvim-server.pipe'
alias v="nvim"
alias gg="lazygit"
alias cat="bat -p"
# Kill processes on a specific port
killport() {
    if [ -z "$1" ]; then
        echo "Usage: killport <port> [tcp|udp|all]"
        echo "Example: killport 3000       # kills TCP processes on port 3000"
        echo "         killport 3000 all   # kills both TCP and UDP processes"
        return 1
    fi
    
    local port=$1
    local protocol=${2:-tcp}
    local found=false
    
    # Function to kill processes for a specific protocol
    kill_by_protocol() {
        local proto=$1
        local pids=$(lsof -ti :$port -s${proto}:LISTEN 2>/dev/null)
        
        if [ -n "$pids" ]; then
            # Show what's being killed
            echo "Killing ${proto} processes on port $port:"
            lsof -i ${proto}:$port 2>/dev/null | grep -v "^COMMAND" | while read line; do
                echo "  → $line" | awk '{printf "  → %s (PID: %s)\n", $1, $2}'
            done | sort -u
            
            # Kill the processes
            echo "$pids" | xargs kill -9 2>/dev/null
            found=true
        fi
    }
    
    # Handle different protocol options
    case $protocol in
        tcp|TCP)
            kill_by_protocol TCP
            ;;
        udp|UDP)
            kill_by_protocol UDP
            ;;
        all|ALL|both)
            kill_by_protocol TCP
            kill_by_protocol UDP
            ;;
        *)
            echo "Invalid protocol: $protocol (use tcp, udp, or all)"
            return 1
            ;;
    esac
    
    if [ "$found" = true ]; then
        echo "✅ Successfully killed process(es) on port $port"
    else
        echo "❌ No process found on port $port"
    fi
}

# Switch between factory-mono repo instances while preserving relative path
_switch_factory_repo() {
    local target_repo="$1"
    local current_path="$PWD"
    local relative_path=""
    
    # Detect which repo we're in and extract relative path
    if [[ "$current_path" == *"/factory-mono"* ]]; then
        relative_path="${current_path#*factory-mono}"
    elif [[ "$current_path" == *"/2factory-mono"* ]]; then
        relative_path="${current_path#*2factory-mono}"
    elif [[ "$current_path" == *"/3factory-mono"* ]]; then
        relative_path="${current_path#*3factory-mono}"
    elif [[ "$current_path" == *"/4factory-mono"* ]]; then
        relative_path="${current_path#*4factory-mono}"
    else
        echo "Error: Not currently in a factory-mono repo instance"
        return 1
    fi
    
    local new_path="$HOME/Development/${target_repo}${relative_path}"
    
    if [[ -d "$new_path" ]]; then
        cd "$new_path"
    else
        echo "Error: Directory does not exist: $new_path"
        return 1
    fi
}

alias st1='_switch_factory_repo factory-mono'
alias st2='_switch_factory_repo 2factory-mono'
alias st3='_switch_factory_repo 3factory-mono'
alias st4='_switch_factory_repo 4factory-mono'

# Shorthand aliases for common ports
alias kill3000='killport 3000'
alias kill3001='killport 3001'
alias kill8080='killport 8080'
alias kill5000='killport 5000'
alias facap='cd ~/Development/factory-mono/apps/factory-app'
alias cb='git branch --sort=-committerdate | fzf --header Checkout | xargs git checkout'
alias droid-dev='/Users/luke/.local/bin/droid-dev'
alias proddroid='/Users/luke/.local/bin/droid'
alias dotfiles='vim ~/dotfiles'
alias gsa='~/dotfiles/git-status-all.sh'
alias find-session='~/dotfiles/find-session.sh'

if [ -x "$(command -v lsd)" ]; then
  alias ls="lsd --group-dirs first"
  alias la="lsd --long --all --group-dirs first"
fi


# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

export XDG_CONFIG_HOME="$HOME/.config"
export DYLD_LIBRARY_PATH="$(brew --prefix)/libe$DYLD_LIBRARY_PATH"

# Adding libexec/bin to path
export PATH=$PATH:/opt/homebrew/opt/python@3/libexec/bin

# Load local secrets (not committed)
ZSHRC_DIR="${${(%):-%x}:A:h}"
[[ -f "$ZSHRC_DIR/.zshrc.secrets" ]] && source "$ZSHRC_DIR/.zshrc.secrets"



export AWS_PROFILE=Developer-686782615134

source <(fzf --zsh)

# Load and initialise completion system
autoload -Uz compinit
compinit

eval "$(zoxide init zsh)"

# # >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
# __conda_setup="$('/Users/luke/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
# if [ $? -eq 0 ]; then
#     eval "$__conda_setup"
# else
#     if [ -f "/Users/luke/miniconda3/etc/profile.d/conda.sh" ]; then
#         . "/Users/luke/miniconda3/etc/profile.d/conda.sh"
#     else
#         export PATH="/Users/luke/miniconda3/bin:$PATH"
#     fi
# fi
# unset __conda_setup
# # <<< conda initialize <<<
# export PATH=/usr/local/anaconda3/bin:$PATH
# export PATH=/opt/homebrew/anaconda3/bin:$PATH
#compdef gt
###-begin-gt-completions-###
#
# yargs command completion script
#
# Installation: gt completion >> ~/.zshrc
#    or gt completion >> ~/.zprofile on OSX.
#
_gt_yargs_completions()
{
  local reply
  local si=$IFS
  IFS=$'
' reply=($(COMP_CWORD="$((CURRENT-1))" COMP_LINE="$BUFFER" COMP_POINT="$CURSOR" gt --get-yargs-completions "${words[@]}"))
  IFS=$si
  _describe 'values' reply
}
compdef _gt_yargs_completions gt
###-end-gt-completions-###

#compdef gt
###-begin-gt-completions-###
#
# yargs command completion script
#
# Installation: gt completion >> ~/.zshrc
#    or gt completion >> ~/.zprofile on OSX.
#
_gt_yargs_completions()
{
  local reply
  local si=$IFS
  IFS=$'
' reply=($(COMP_CWORD="$((CURRENT-1))" COMP_LINE="$BUFFER" COMP_POINT="$CURSOR" gt --get-yargs-completions "${words[@]}"))
  IFS=$si
  _describe 'values' reply
}
compdef _gt_yargs_completions gt
###-end-gt-completions-###

export COREPACK_ENABLE_AUTO_PIN=0

# Unset npm_config_prefix to prevent nvm compatibility issues
unset npm_config_prefix

export NVM_DIR="$HOME/.config/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

