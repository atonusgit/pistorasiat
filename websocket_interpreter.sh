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
	esac

	saved_hash=$incoming_hash
fi
sleep 0.2
done
