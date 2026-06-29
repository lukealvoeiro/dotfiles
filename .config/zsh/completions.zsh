# Completions and tool shell integrations.
# Sourced after `compinit` so `compdef` is available.

# fzf
source <(fzf --zsh)

# zoxide
eval "$(zoxide init zsh)"

# graphite (gt) completions
_gt_yargs_completions()
{
  local reply
  local si=$IFS
  IFS=$'\n' reply=($(COMP_CWORD="$((CURRENT-1))" COMP_LINE="$BUFFER" COMP_POINT="$CURSOR" gt --get-yargs-completions "${words[@]}"))
  IFS=$si
  _describe 'values' reply
}
compdef _gt_yargs_completions gt

# bun completions
[ -s "$BUN_INSTALL/_bun" ] && source "$BUN_INSTALL/_bun"
