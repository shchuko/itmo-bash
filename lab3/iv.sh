#!/bin/bash
# For every pid 
for pid in $(ps a -o pid | sed 1d); do	
	# If process directory exists
	if [[ -d "/proc/$pid" ]]; then
		# Computing (resident-share) differnce, saving
		diff=$(cat /proc/$pid/statm |
			awk '{ print $2-$3 }');
		temp=$temp$(echo $pid:$diff)$'\n';
	fi;
done;
# Printing
echo "$temp" | sort -n -t ':' -k 2 | sed 1d;

