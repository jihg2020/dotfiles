# === ZimFW auto-install ===
ZIM_HOME=${ZIM_HOME:-${HOME}/.local/state/zimfw}
ZIM_CONFIG_FILE=${ZIM_CONFIG_FILE:-${HOME}/.config/zsh/zimrc.zsh}
# Download zimfw plugin manager if missing.
if [[ ! -e ${ZIM_HOME}/zimfw.zsh ]]; then
  curl -fsSL --create-dirs -o ${ZIM_HOME}/zimfw.zsh \
    https://github.com/zimfw/zimfw/releases/latest/download/zimfw.zsh
fi
# Install missing modules, and update ${ZIM_HOME}/init.zsh if missing or outdated.
if [[ ! ${ZIM_HOME}/init.zsh -nt ${ZIM_CONFIG_FILE:-${ZDOTDIR:-${HOME}}/.zimrc} ]]; then
  source ${ZIM_HOME}/zimfw.zsh init
fi
# Initialize modules.
source ${ZIM_HOME}/init.zsh 2> /dev/null

# -----------------
# Zsh configuration
# -----------------
# Ensure Cache  directory exists
ZSH_CACHE_DIR="${HOME}/Library/Caches/zsh"
ZCOMPDUMP="${ZSH_CACHE_DIR}/zcompdump"
[[ -d ${HOME}/Library/Caches/zsh ]] || mkdir -p ${HOME}/Library/Caches/zsh
# History file location
HISTFILE="${ZSH_CACHE_DIR}/history"
HISTSIZE=100000               # 当前 session 可保存的历史条数
SAVEHIST=100000               # 实际写入文件的历史条数

# 加载代理配置
[[ -f $HOME/.config/zsh/proxy.zsh ]] && source $HOME/.config/zsh/proxy.zsh
# load alias
[[ -f $HOME/.config/zsh/alias.zsh ]] && source $HOME/.config/zsh/alias.zsh

# Homebrew
if [[ "$(uname -m)" == "arm64" ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Starship
if command starship -V &> /dev/null; then
  eval "$(starship init zsh)"
  export STARSHIP_CONFIG=$HOME/.config/starship/starship.toml
fi

# autojump  -- installed by homebrew
[ -f $(brew --prefix)/etc/profile.d/autojump.sh ] && . $(brew --prefix)/etc/profile.d/autojump.sh

# zoxide 
if command zoxide -V &> /dev/null; then
  eval "$(zoxide init zsh)"
fi

# Rust
[ -f $HOME/.cargo/env ] && . $HOME/.cargo/env

# openjdk
if command java --version &>/dev/null;then
  export CPPFLAGS="-I/opt/homebrew/opt/openjdk/include"
fi

