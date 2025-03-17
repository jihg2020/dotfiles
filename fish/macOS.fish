# Homebrew
if test "$(uname -m)" = arm64
  eval "$(/opt/homebrew/bin/brew shellenv)"
end

# starship
if type -q starship
  starship init fish | source
  export STARSHIP_CONFIG=$HOME/.config/starship/starship.toml
end

# autojump
[ -f /opt/homebrew/share/autojump/autojump.fish ]; and source /opt/homebrew/share/autojump/autojump.fish

# Rust
[ -f $HOME/.cargo/env.fish ]; and source "$HOME/.cargo/env.fish"
