
# starship
starship init fish | source
export STARSHIP_CONFIG=$HOME/.config/starship/starship.toml

# autojump
  [ -f $(brew --prefix)/share/autojump/autojump.fish ]; and source  $(brew --prefix)/share/autojump/autojump.fish

  # Rust
  [ -f $HOME/.cargo/env.fish ]; and source "$HOME/.cargo/env.fish"
