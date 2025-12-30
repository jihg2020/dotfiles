if status is-interactive
    # Commands to run in interactive sessions can go here
end

# 环境变量加载
if test "$(uname)" = Linux
        test -f ~/.config/fish/linux.fish; and source ~/.config/fish/linux.fish
else if test "$(uname)" = Darwin
        test -f ~/.config/fish/macOS.fish; and source ~/.config/fish/macOS.fish
end

# Homebrew
export HOMEBREW_BREW_GIT_REMOTE="https://mirrors.ustc.edu.cn/brew.git"
export HOMEBREW_CORE_GIT_REMOTE="https://mirrors.ustc.edu.cn/homebrew-core.git"
export HOMEBREW_BOTTLE_DOMAIN="https://mirrors.ustc.edu.cn/homebrew-bottles"
export HOMEBREW_API_DOMAIN="https://mirrors.ustc.edu.cn/homebrew-bottles/api"

# Rust Proxy
export RUSTUP_DIST_SERVER="https://rsproxy.cn"
export RUSTUP_UPDATE_ROOT="https://rsproxy.cn/rustup"
