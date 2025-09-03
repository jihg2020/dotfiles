#!/usr/bin/env bash

set -u
DST_DIR=${DST_DIR:-$HOME/.config}
CUR_DIR=$(cd $(dirname $0); pwd)   # 获取当前执行的脚本文件所在的目录

# 检查 $DEST_DIR 是否存在。
if [[ ! -d "${DST_DIR}" ]]; then
  set confirm
  echo "install.sh: < ${DST_DIR} > not exist."
  echo "auto create it? [Y/n]?  (dafulf=Y) ";  read confirm
  if [[ ${confirm,,} = "y" ]] || [[ -z ${confirm} ]]; then
    mkdir $DST_DIR
  else
    echo "推出脚本"
    exit 1
  fi
  unset confirm
fi

# 遍历当前文件，并在$HOME/.config下建立对应软连接
for name in `ls ${CUR_DIR}`; do
  if [[ -d "${CUR_DIR}/${name}" ]]; then
  	if [[ -d ${DST_DIR}/${name} ]]; then
    	mv $DST_DIR/${name} $DST_DIR/${name}.bak 
  	fi
  	ln -sf ${CUR_DIR}/${name} ${DST_DIR}/
  else
	continue
  fi
done

create_alias() {

	if [ $(command -v nvim) ]; then
	 # echo "neovim is installed, create alias nv for neovim."
		 ln -sf $(command -v nvim) $(dirname "$(command -v nvim)")/nv
	fi
}

# 在用户家目录中创建.zshrc文件 
create_zshrc() {
  tee "$HOME/.zshrc" > /dev/null << 'EOF'
# 加载环境配置
if [[ "$(uname)" == "Linux" ]]; then
  # Save command history
  [[ -d ${HOME}/.cache/zsh ]] || mkdir ${HOME}/.cache/zsh
  HISTFILE=${HOME}/.cache/zsh/history
  # Default prompt
  PS1="%n@%m: %1~ %# "

  [[ -f $HOME/.config/zsh/linux.zsh ]] && source $HOME/.config/zsh/linux.zsh
elif [[ "$(uname)" == "Darwin" ]]; then
  # Save command history
  [[ -d ${HOME}/Library/Caches/zsh ]] || mkdir ${HOME}/Library/Caches/zsh
  HISTFILE=${HOME}/Library/Caches/zsh/history

  [[ -f $HOME/.config/zsh/macOS.zsh ]] && source $HOME/.config/zsh/macOS.zsh
fi
EOF
}

main() {
	create_alias
	create_zshrc
}


main "$@"


