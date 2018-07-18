#!/bin/bash
echo $TOMCAT_HOME
if [ $? -eq 0 ]; then
    echo 'TOMCAT_HOME set well.'
else
    echo 'TOMCAT_HOME not set, must be set'
fi
if [ $# -ne 1 ]; then
    echo 'shell args not enough,must be 1'
    exit 1
fi
filename=$1
if [ -f "${TOMCAT_HOME}/webapps/ROOT/WEB-INF/slaves" ];then
  tables=`cat $TOMCAT_HOME/webapps/ROOT/WEB-INF/slaves`
  if [ -z "${tables}" ];then
     echo "从文件:slaves  文件为空!!!"
     exit
  fi
  for table in $tables;
  do
    table=`echo $table|grep ^[^#]` ##过滤以＃开头的字符串
    echo "###正在向${table}同步${filename}..."
    folder=`echo ${filename%/*}` #切割出来文件夹目录，如果文件夹不存在则创建
    ssh $table "mkdir -p $folder;exit"
    echo "mkdirs"
    scp $filename $table:$folder
    echo "Done"
  done
else
  echo "从文件:slaves  不存在!!!"
  exit
fi
'''
本版本是两个服务器先做好免密设置，如果没有做的话先做免密或者expect 输入密码登录
'''
