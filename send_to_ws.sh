. ~/pistorasiat/.env

echo $1 | websocat -1 ws://$(cat $ROOT_DIRECTORY/status_files/kappe_ip):$WEBSOCKET_PORT | exit
