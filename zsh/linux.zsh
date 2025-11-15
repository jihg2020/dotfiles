# === ZimFW auto-install
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


# -----------------
# Zsh configuration
# -----------------
# Ensure Cache directory exists
ZSH_CACHE_DIR="${XDG_CACHE_HOME:-$HOME/.cache}/zsh"
ZCOMPDUMP="${ZSH_CACHE_DIR}/zcompdump"
[[ -d "${XDG_CACHE_HOME:-$HOME/.cache}/zsh" ]] || mkdir -p "${XDG_CACHE_HOME:-$HOME/.cache}/zsh"
# History file location
HISTFILE="${ZSH_CACHE_DIR}/history"
HISTSIZE=100000                         # 当前 session 可保存的历史条数
SAVEHIST=100000                         # 实际写入文件的历史条数
# Remove older command from the history if a duplicate is to be added.
setopt HIST_IGNORE_ALL_DUPS

# === Input/output
bindkey -v                              # Set editor default keymap to emacs (`-e`) or vi (`-v`)
WORDCHARS=${WORDCHARS//[\/]}            # Remove path separator from WORDCHARS.


# zoxide
if command zoxide -V &> /dev/null; then
  eval "$(zoxide init zsh)"
fi

# Rust
[ -f $HOME/.cargo/env ] && . $HOME/.cargo/env
