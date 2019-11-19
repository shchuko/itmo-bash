#!/bin/bash
echo $$ > .pid
A=0
MODE="rabota"
usr1()
{
	MODE="ostanov"
}
trap 'usr1' SIGTERM;
while true; do
	case $MODE in
		"rabota")
			let A=$A+1
			echo $A
			;;
		"ostanov")
			echo "Stopped by SIGTERM signal"
#			rm ".pid";
#			exit 0;
		;;
	esac
	sleep 1;
done
