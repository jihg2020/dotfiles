
# 本机的IP地址
hostip="localhost"

# 监听端口
port_http=1087
port_socks=1080

# 两种代理方式：一种基于http，一种基于socket5
PROXY_HTTP="http://${hostip}:${port_http}"
PROXY_SOCKS="socks5://${hostip}:${port_socks}"


# 开启代理
set_proxy () {
  export all_proxy="${PROXY_HTTP}"
  export ALL_PROXY="${PROXY_HTTP}"

  echo "[I]  $(date "+%Y-%m-%d %H:%M:%S")  Proxy has been opend."
}

# 关闭代理
unset_proxy () {
  unset all_proxy
  unset ALL_PROXY

  echo "[I]  $(date "+%Y-%m-%d %H:%M:%S")  Proxy has been closed."
}

# 测试代理是否开启成功
test_proxy () {
  echo "[I]  $(date "+%Y-%m-%d %H:%M:%S")  Try to connect to Google ... "

  resp=$(curl -I -s --connect-timeout 5 -m 5 -w "%{http_code}" -o /dev/null www.google.com )
  if [ ${resp} = 200 ]; then
    echo "[I]  $(date "+%Y-%m-%d %H:%M:%S")  Proxy setup succeeded!!!"
  else
    echo "[E]  $(date "+%Y-%m-%d %H:%M:%S")  Proxy setup failed!!!"
  fi 
}

proxy () {
  if [ "$1" = "on" ]; then
    set_proxy
    test_proxy
  elif [ "$1" = "off" ]; then
    unset_proxy
  elif [ "$1" = "test" ]; then 
    test_proxy
  else
    echo "[W]  $(date "+%Y-%m-%d %H:%M:%S")  Unsupport arguments."
  fi
}

