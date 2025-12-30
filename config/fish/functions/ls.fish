function ls
  if type lsd -q
    command lsd $argv
  else
    command ls --color $argv
  end
end
