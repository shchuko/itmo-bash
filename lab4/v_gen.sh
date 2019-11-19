#!/bin/bash

while true; do
	read LINE;
	echo "$LINE" >> v_data;
	if [[ $LINE == "QUIT" ]]; then
		echo "Generator exit";
		break;
	fi;
done;
		
