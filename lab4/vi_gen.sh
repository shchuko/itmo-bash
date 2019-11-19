#!/bin/bash
while true; do
	read LINE
	case $LINE in
 		TERM)
			kill -SIGKILL $(cat .pid)
			exit 0;
 			;;
		*)
 			:
		;;
	esac
done
