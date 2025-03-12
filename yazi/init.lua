-- 
require("smart-enter"):setup {
  open_multi = true,
}

-- starship.yazi
require("starship"):setup({
  config = "~/.config/starship/starship.toml"
})

require("git"):setup()
