
# starship
if type -q starship
  starship init fish | source
  export STARSHIP_CONFIG=$HOME/.config/starship/starship.toml
end

# autojump
[ -f $(brew --prefix)/share/autojump/autojump.fish ]; and source  $(brew --prefix)/share/autojump/autojump.fish

# zoxide
if type -q zoxide
  zoxide init fish | source
end

# Rust
[ -f $HOME/.cargo/env.fish ]; and source "$HOME/.cargo/env.fish"

