#!/bin/bash

./iv_infinite.sh & pid1=$!;
./iv_infinite.sh & pid2=$!;

echo $pid1, $pid2;

sleep 5;

while true; do
	cpuni=$(ps -p $pid1 -o %cpu,ni | sed 1d);
	cpu=$(echo $cpuni | awk -F' ' '{ print $1; }');
	niceness=$(echo $cpuni | awk -F' ' '{ print $2; }');
	let niceness=niceness+1;
	
	echo "CPU usage: ${cpu}%";
	if (( $(echo "$cpu > 20" |bc -l) )); then
		renice "+${niceness}" $pid1;
	else
		echo "CPU usage normalized";
		break;
	fi;
	
	sleep 3;
	
done;

echo $pid1, $pid2;
#cpulimit -p $pid1 -l 20;
# kill $pid1 $pid2;
