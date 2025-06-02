# 加载代理配置
[[ -f $HOME/.config/zsh/proxy.zsh ]] && source $HOME/.config/zsh/proxy.zsh

# load aliad
[[ -f $HOME/.config/zsh/alias.zsh ]] && source $HOME/.config/zsh/alias.zsh

# plugins manager
[[ -f $HOME/.config/zsh/plugins.zsh ]] && source $HOME/.config/zsh/plugins.zsh

# Use modern completion system
autoload -Uz compinit && compinit
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'

# Starship
if command starship -V &> /dev/null; then
  eval "$(starship init zsh)"
  export STARSHIP_CONFIG=$HOME/.config/starship/starship.toml
fi

# Neovim
if command nvim -v &> /dev/null; then
  export EDITOR="nvim"
fi

# autojump  -- installed by homebrew
[ -f $(brew --prefix)/etc/profile.d/autojump.sh ] && . $(brew --prefix)/etc/profile.d/autojump.sh

# zoxide 
if command zoxide -V &> /dev/null; then
  eval "$(zoxide init zsh)"
fi

# Rust
[ -f $HOME/.cargo/env ] && . $HOME/.cargo/env




