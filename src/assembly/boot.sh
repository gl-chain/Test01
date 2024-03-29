#!/bin/bash

# shellcheck disable=SC2046
# shellcheck disable=SC2164
cd $(dirname "$0"); pwd

# Java ENV（此处需要修改，需要预先安装JDK）
export JAVA_HOME=/opt/jdk/v17
export JRE_HOME=${JAVA_HOME}/jre

# 应用名称
APP_NAME=com.chengl.test01.Test01Application
# shellcheck disable=SC2125
CLASSPATH=classpath:./lib/*

# Shell Info

# 使用说明，用来提示输入参数
usage() {
  echo "Usage: sh boot [start|stop|restart|status]"
  exit 1
}

# 检查程序是否在运行
is_exist() {
  # 获取PID
  # shellcheck disable=SC2009
  PID=$(ps -ef | grep ${APP_NAME} | grep -v "$0" | grep -v grep | awk '{print $2}')
  # -z "${pid}"判断pid是否存在，如果不存在返回1，存在返回0
  if [ -z "${PID}" ]; then
    # 如果进程不存在返回1
    return 1
  else
    # 进程存在返回0
    return 0
  fi
}

# 定义启动程序函数
start() {
  is_exist
  # shellcheck disable=SC2181
  if [ $? -eq "0" ]; then
    echo "${APP_NAME} is already running, PID=${PID}"
  else
    nohup $JAVA_HOME/bin/java -server -Xms1g -Xmx1g -Xss256k -Xmn600m -classpath "$CLASSPATH" $APP_NAME -XX:MetaspaceSize=128m -XX:MaxMetaspaceSize=256m -XX:-OmitStackTraceInFastThrow -Duser.timezone=Asia/Shanghai -Dclient.encoding.override=UTF-8 -Dfile.encoding=UTF-8 > ./console.log 2>&1 &
    # shellcheck disable=SC2116
    PID=$(echo $!)
    echo "${APP_NAME} start success, PID=$!"
  fi
}

# 停止进程函数
stop() {
  is_exist
  # shellcheck disable=SC2181
  if [ $? -eq "0" ]; then
    kill -9 "${PID}"
    echo "${APP_NAME} process stop, PID=${PID}"
  else
    echo "There is not the process of ${APP_NAME}"
  fi
}

# 重启进程函数
restart() {
  stop
  start
}

# 查看进程状态
status() {
  is_exist
  # shellcheck disable=SC2181
  if [ $? -eq "0" ]; then
    echo "${APP_NAME} is running, PID=${PID}"
  else
    echo "There is not the process of ${APP_NAME}"
  fi
}

case $1 in
"start")
  start
  ;;
"stop")
  stop
  ;;
"restart")
  restart
  ;;
"status")
  status
  ;;
*)
  usage
  ;;
esac
exit 0
