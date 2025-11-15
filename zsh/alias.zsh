# System
alias sudo="sudo -E"
alias cl="clear"

# lazygit
alias lg="lazygit"

# yazi
function yz() {
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
