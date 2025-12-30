#!/usr/bin/env bash

set -u
TARGET_DIR=${DST_DIR:-$HOME/.config}
CURRENT_DIR=$(cd $(dirname $0); pwd)   # 获取当前执行的脚本文件所在的目录

# 检查 $DEST_DIR 是否存在。
if [[ ! -d "${TARGET_DIR}" ]]; then
  set confirm
  echo "install.sh: < ${TARGET_DIR} > not exist."
  echo "auto create it? [Y/n]?  (dafulf=Y) ";  read confirm
  if [[ ${confirm,,} = "y" ]] || [[ -z ${confirm} ]]; then
    mkdir $TARGET_DIR
  else
    echo "退出脚本"
    exit 1
  fi
  unset confirm
fi

config_alias() {
  # 遍历当前文件，并在$HOME/.config下建立对应软连接
  for name in `ls ${CURRENT_DIR}/config`; do
    if [[ -d "${CURRENT_DIR}/config/${name}" ]]; then
      if [[ -d ${TARGET_DIR}/${name} ]]; then
        mv $TARGET_DIR/${name} $TARGET_DIR/${name}.bak 
      fi
      ln -sf ${CURRENT_DIR}/config/${name} ${TARGET_DIR}/
    fi
  done
}

software_alias() {

	if [ $(command -v nvim) ]; then
	 # echo "neovim is installed, create alias nv for neovim."
		 ln -sf $(command -v nvim) $(dirname "$(command -v nvim)")/nv
	fi
}

# 在用户家目录中创建.zshrc文件 
create_zshrc() {
  tee "${HOME}/.zshrc" > /dev/null << 'EOF'
# 加载环境配置
if [[ "$(uname)" == "Darwin" ]]; then
  [[ -f $HOME/.config/zsh/macOS.zsh ]] && source $HOME/.config/zsh/macOS.zsh
elif [[ "$(uname)" == "Linux" ]]; then
  PS1="%n@%m: %1~ %# "                # Default prompt
  [[ -f $HOME/.config/zsh/linux.zsh ]] && source $HOME/.config/zsh/linux.zsh
fi
EOF
}

main() {
	config_alias
	software_alias
	create_zshrc
}


main "$@"


