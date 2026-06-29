# Environment variables and PATH setup.

export XDG_CONFIG_HOME="$HOME/.config"

# Homebrew-provided dynamic libraries
if command -v brew >/dev/null 2>&1; then
  export DYLD_LIBRARY_PATH="$(brew --prefix)/lib:$DYLD_LIBRARY_PATH"
fi

# Homebrew python libexec/bin
export PATH="$PATH:/opt/homebrew/opt/python@3/libexec/bin"

export COREPACK_ENABLE_AUTO_PIN=0

# nvm (unset npm_config_prefix to avoid nvm compatibility issues)
unset npm_config_prefix
export NVM_DIR="$HOME/.config/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
