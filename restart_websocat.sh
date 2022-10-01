#!/usr/bin/bash

. ~/pistorasiat/.env
/usr/bin/bash $ROOT_DIRECTORY/dyndns.sh

original_pwd=$(pwd)

sudo kill $(ps -x | grep autoreconnect | grep -v "color" | awk '{print $1;}')
sudo kill $(ps -x | grep websocket_interpreter.sh | grep -v "color" | awk '{print $1;}')

cd $ROOT_DIRECTORY/status_files; nohup websocat -tvvv autoreconnect:ws://$(cat $ROOT_DIRECTORY/status_files/kappe_ip):$WEBSOCKET_PORT writefile:$ROOT_DIRECTORY/status_files/websocket_output --ping-interval 60 & >> $ROOT_DIRECTORY/wsock_stout.log 2>> $ROOT_DIRECTORY/wsock_error.log
cd $ROOT_DIRECTORY/status_files; nohup /usr/bin/bash $ROOT_DIRECTORY/websocket_interpreter.sh & >/dev/null

cd $original_pwd
