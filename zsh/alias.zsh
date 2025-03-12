# System
alias sudo="sudo -E"
alias cl="clear"

# lsd
if command lsd -V &> /dev/null; then
  alias ls="lsd";  alias ll="lsd -l";  alias la="lsd -al"
fi

# lazygit
alias lg="lazygit"

# yazi
function y() {
  local tmp="$(mktemp -t "yazi-cwd.XXXXX")"
  yazi "$@" --cwd-file="$tmp"
  if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
    cd -- "$cwd"
  fi
  rm -f -- "$tmp"
}

# python
alias python="python3"
alias pip="pip3"
