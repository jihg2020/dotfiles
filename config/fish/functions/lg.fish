function lg
  if type lazygit -q
    command lazygit $argv
  else
    echo "fish: Command not found: lg" 
  end
end
