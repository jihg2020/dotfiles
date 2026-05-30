# === Zsh configuration
[[ -d ${HOME}/Library/Caches/zsh ]] || mkdir -p ${HOME}/Library/Caches/zsh
export ZSH_CACHE_DIR="${HOME}/Library/Caches/zsh"
export ZSH_COMPDUMP="${ZSH_CACHE_DIR}"
HISTFILE="${ZSH_CACHE_DIR}/history"
HISTSIZE=50000               # 当前 session 可保存的历史条数
SAVEHIST=50000               # 实际写入文件的历史条数

# 如果历史里已有相同命令，删除旧的只保留最新
setopt HIST_IGNORE_ALL_DUPS

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
source ${ZIM_HOME}/init.zsh 2>/dev/null


# 加载代理配置
[[ -f $HOME/.config/zsh/proxy.zsh ]] && source $HOME/.config/zsh/proxy.zsh

# System
alias sudo="sudo -E"

# python
alias python="python3"
alias pip="pip3"

# Homebrew
if [[ "$(uname -m)" == "arm64" ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# fzf
# if command -v fzf &>/dev/null; then
#   # Set up fzf key bindings and fuzzy completion
#   source <(fzf --zsh --no-completion)
# fi

# lazygit
if command -v lazygit &>/dev/null; then
  alias lg="lazygit"
fi

# yazi
if command -v yazi &>/dev/null; then
  function yz() {
    local tmp="$(mktemp -t "yazi-cwd.XXXXX")"
    yazi "$@" --cwd-file="$tmp"
    if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
      cd -- "$cwd"
    fi
    rm -f -- "$tmp"
  }
fi

# autojump  -- installed by homebrew
[ -f $(brew --prefix)/etc/profile.d/autojump.sh ] && . $(brew --prefix)/etc/profile.d/autojump.sh

# zoxide 
if command zoxide -V &>/dev/null; then
  eval "$(zoxide init zsh)"
fi

# Rust
[ -f $HOME/.cargo/env ] && . $HOME/.cargo/env

# Orbstack
if command -v orb &>/dev/null; then
  source ~/.orbstack/shell/init.zsh 2>/dev/null || :
fi
