#!/bin/bash

. ~/pistorasiat/.env

saved_hash=""
output_file="$ROOT_DIRECTORY/status_files/websocket_output"
remote_control_program="remote_control.py"

while true;
do
incoming_hash=$(md5sum <<< cat $output_file)
if [[ $incoming_hash != $saved_hash ]]; then
	case $(tail -1 $output_file) in

                "aon")
                        $ROOT_DIRECTORY/$remote_control_program A on
                        ;;

                "aoff")
                        $ROOT_DIRECTORY/$remote_control_program A off
                        ;;

		"bon")
			$ROOT_DIRECTORY/$remote_control_program B on
			;;

		"boff")
			$ROOT_DIRECTORY/$remote_control_program B off
			;;

		"con")
			$ROOT_DIRECTORY/$remote_control_program C on
			;;

		"coff")
			$ROOT_DIRECTORY/$remote_control_program C off
			;;

                "don")
                        $ROOT_DIRECTORY/$remote_control_program D on
                        ;;

                "doff")
                        $ROOT_DIRECTORY/$remote_control_program D off
                        ;;

		"eon")
			$ROOT_DIRECTORY/$remote_control_program E on
			;;

		"eoff")
			$ROOT_DIRECTORY/$remote_control_program E off
			;;

                "fon")
                        $ROOT_DIRECTORY/$remote_control_program F on
                        ;;

                "foff")
                        $ROOT_DIRECTORY/$remote_control_program F off
                        ;;

		"gon")
			$ROOT_DIRECTORY/$remote_control_program G on
			;;

		"goff")
			$ROOT_DIRECTORY/$remote_control_program G off
			;;

		"hon")
			$ROOT_DIRECTORY/$remote_control_program H on
			;;

		"hoff")
			$ROOT_DIRECTORY/$remote_control_program H off
			;;

                "ion")
                        $ROOT_DIRECTORY/$remote_control_program I on
                        ;;

                "ioff")
                        $ROOT_DIRECTORY/$remote_control_program I off
                        ;;

                "jon")
#                        ip=$(ping -c 1 $PUMPPU_SHELLY_HOSTNAME | head -1 | awk -F'[()]' '{print $2}')
                        ip=$(cat $ROOT_DIRECTORY/status_files/wifi_pistoke_ip)
                        curl --anyauth -u $PUMPPU_SHELLY_USERNAME:$PUMPPU_SHELLY_PASSWORD "http://$ip/rpc/Switch.Set?id=0&on=true" | grep "false" && bash $ROOT_DIRECTORY/send_to_ws.sh "pumpon"
                        $ROOT_DIRECTORY/$remote_control_program J on
                        ;;

                "joff")
                        ip=$(cat $ROOT_DIRECTORY/status_files/wifi_pistoke_ip)
                        curl --anyauth -u $PUMPPU_SHELLY_USERNAME:$PUMPPU_SHELLY_PASSWORD "http://$ip/rpc/Switch.Set?id=0&on=false" | grep "was_on" && bash $ROOT_DIRECTORY/send_to_ws.sh "pumpoff"
                        $ROOT_DIRECTORY/$remote_control_program J off
                        ;;

		"gaon")
			$ROOT_DIRECTORY/$remote_control_program GROUP_A on
			;;

		"gaoff")
			$ROOT_DIRECTORY/$remote_control_program GROUP_A off
			;;

		"gbon")
			$ROOT_DIRECTORY/$remote_control_program GROUP_B on
			;;

		"gboff")
			$ROOT_DIRECTORY/$remote_control_program GROUP_B off
			;;

		honoff*)
			$ROOT_DIRECTORY/$remote_control_program H on
			sleep $(tail -1 $output_file | cut -d' ' -f2)
			$ROOT_DIRECTORY/$remote_control_program H off
			;;

                jonoff*)
                        ip=$(cat $ROOT_DIRECTORY/status_files/wifi_pistoke_ip)
			seconds=$(tail -1 $output_file | cut -d' ' -f2)
                        curl --anyauth -u $PUMPPU_SHELLY_USERNAME:$PUMPPU_SHELLY_PASSWORD "http://$ip/rpc/Switch.Set?id=0&on=true" | grep "false" && bash $ROOT_DIRECTORY/send_to_ws.sh "pumpon"
                        $ROOT_DIRECTORY/$remote_control_program J on
			for i in $(seq 1 $seconds); do
				percentage=$(( (i * 100) / seconds ))
				bash $ROOT_DIRECTORY/send_to_ws.sh "progress_${percentage}%_kastelee-..."
				sleep 1
			done
                        curl --anyauth -u $PUMPPU_SHELLY_USERNAME:$PUMPPU_SHELLY_PASSWORD "http://$ip/rpc/Switch.Set?id=0&on=false" | grep "true" && bash $ROOT_DIRECTORY/send_to_ws.sh "pumpoff"
                        $ROOT_DIRECTORY/$remote_control_program J off
                        ;;

		"acctv")
			ssh $KOSTEUS_USERNAME@$KOSTEUS_ADDRESS 'bash '$KOSTEUS_ROOT_DIRECTORY'/get_image.sh'

	esac

	saved_hash=$incoming_hash
fi
sleep 0.2
done
