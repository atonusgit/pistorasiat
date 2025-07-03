# this file is loaded at ~/.profile
# with adding line . ~/pistorasiat/.profile

. ~/pistorasiat/.env

alias ll="ls -lah"

kappe () {
        kappe_ip=$(curl -u $VALLE_DYNDNS_USERNAME:$VALLE_DYNDNS_PASSWORD http://valle.fi/dyndns/)
        ssh $KAPPE_USERNAME@$kappe_ip -p $KAPPE_SSH_PORT
}

alias sensorit="ssh pi@$SENSORIT_ADDRESS"

alias aon="python3 $ROOT_DIRECTORY/remote_control.py A on"
alias aoff="python3 $ROOT_DIRECTORY/remote_control.py A off"

alias bon="python3 $ROOT_DIRECTORY/remote_control.py B on"
alias boff="python3 $ROOT_DIRECTORY/remote_control.py B off"

alias con="python3 $ROOT_DIRECTORY/remote_control.py C on"
alias coff="python3 $ROOT_DIRECTORY/remote_control.py C off"

alias don="python3 $ROOT_DIRECTORY/remote_control.py D on"
alias doff="python3 $ROOT_DIRECTORY/remote_control.py D off"

alias eon="python3 $ROOT_DIRECTORY/remote_control.py E on"
alias eoff="python3 $ROOT_DIRECTORY/remote_control.py E off"

alias fon="python3 $ROOT_DIRECTORY/remote_control.py F on"
alias foff="python3 $ROOT_DIRECTORY/remote_control.py F off"

alias gon="python3 $ROOT_DIRECTORY/remote_control.py G on"
alias goff="python3 $ROOT_DIRECTORY/remote_control.py G off"

alias hon="python3 $ROOT_DIRECTORY/remote_control.py H on"
alias hoff="python3 $ROOT_DIRECTORY/remote_control.py H off"

alias ion="python3 $ROOT_DIRECTORY/remote_control.py I on"
alias ioff="python3 $ROOT_DIRECTORY/remote_control.py I off"

alias jon="python3 $ROOT_DIRECTORY/remote_control.py J on"
alias joff="python3 $ROOT_DIRECTORY/remote_control.py J off"

alias gaon="python3 $ROOT_DIRECTORY/remote_control.py GROUP_A on"
alias gaoff="python3 $ROOT_DIRECTORY/remote_control.py GROUP_A off"

alias gbon="python3 $ROOT_DIRECTORY/remote_control.py GROUP_B on"
alias gboff="python3 $ROOT_DIRECTORY/remote_control.py GROUP_B off"

alias wsock="cd $ROOT_DIRECTORY/status_files; nohup websocat -tvvv autoreconnect:ws://$(cat $ROOT_DIRECTORY/status_files/kappe_ip):$WEBSOCKET_PORT writefile:$ROOT_DIRECTORY/status_files/websocket_output --ping-interval 60 & >> $ROOT_DIRECTORY/wsock_stout.log 2>> $ROOT_DIRECTORY/wsock_error.log"
alias wsockint="cd $ROOT_DIRECTORY/status_files; nohup bash $ROOT_DIRECTORY/websocket_interpreter.sh & >/dev/null"

honoff () {
        python3 $ROOT_DIRECTORY/remote_control.py H on
        sleep $1
        python3 $ROOT_DIRECTORY/remote_control.py H off
}

pumpon () {
	ip=$(ping -c 1 $PUMPPU_SHELLY_HOSTNAME | head -1 | awk -F'[()]' '{print $2}')
	curl --anyauth -u $PUMPPU_SHELLY_USERNAME:$PUMPPU_SHELLY_PASSWORD "http://$ip/rpc/Switch.Set?id=0&on=true"
}

pumpoff () {
        ip=$(ping -c 1 $PUMPPU_SHELLY_HOSTNAME | head -1 | awk -F'[()]' '{print $2}')
        curl --anyauth -u $PUMPPU_SHELLY_USERNAME:$PUMPPU_SHELLY_PASSWORD "http://$ip/rpc/Switch.Set?id=0&on=false"
}

cd $ROOT_DIRECTORY
