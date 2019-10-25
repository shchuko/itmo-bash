#!/bin/bash
outfile="v-out";

# For every pid in /proc/ directory
for pid in $(ps -A -o pid); do	
	# If stat and sched files exists 
	if [[ -d "/proc/$pid/" ]]; then
		# Reading /proc/$pid/ status and sched data
		avgtime=$(cat /proc/$pid/sched 2>/dev/null | 
			sed 1,2d |
		     	awk -F':' '$1 ~ /avg_atom/ {print $2;}' |
			sed -e 's/^[[:space:]]*//g');

		ppid=$(cat /proc/$pid/status 2>/dev/null |
			awk -F':' '$1 == "PPid" {print $2;}' |
			sed -e 's/^[[:space:]]*//g');
		
		# Saving data to temp variable
		temp=$temp$(echo $pid:$ppid:$avgtime)$'\n';
	fi;
done;

# Printing data
echo "$temp" |
# Sorting data by PPID
sort -n -t ':' -k 2 |
#  Printing result in format PID:PPID:AVGTIME
awk -F':' 'BEGIN { OFS = ":" } ; { 
	print("ProcessID="$1" ",
		" Parent_ProcessID="$2" ",
		" Average_Sleepeing_Time="$3" "); 
}' |
sed 1d > $outfile;

