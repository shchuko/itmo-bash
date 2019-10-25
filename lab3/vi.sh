#!/bin/bash

# input file filepath
inputfilepath="v-out";

# initializing variable
sleepavg_sum=0;

# reading input file line by line
while read line; do
	# if line is empty, skip iteration
	if [[ -z $line ]]; then
		continue;
	fi;
	
	# reading ppid and sleepavg time from line
	ppid=$(echo $line | grep -Eo 'Parent_ProcessID=([[:digit:]]+)' | grep -Eo '[[:digit:]]+');
	sleep_avg=$(echo $line | grep -Eo 'Average_Sleepeing_Time=[[:digit:].]+' | grep -Eo '[[:digit:].]+');
	
	# if previous and current ppid are equal
	if [[ $ppid -eq $ppid_prev ]]; then
		# adding sleepavg time of current process to sum, incrementing counter 
		sleepavg_sum=$(echo "$sleepavg_sum $sleep_avg" | awk '{printf "%f", $1 + $2}');
		let counter=$counter+1;
	else
		# calculating average value for ppid, printing result
		sleepavg_res=$(echo "$sleepavg_sum $counter" | awk '{printf "%f", $1 / $2}');
		result=$result'Average_Sleeping_Children_of_ParentID='$ppid_prev' is '$sleepavg_res$'\n';
		
		# reseting counters
		sleepavg_sum=$sleep_avg;
		counter=1;
	fi;
	
	# updating previous value of ppid
	ppid_prev=$ppid;	

	# printing result
	result=$result$line$'\n';

done < $inputfilepath;

# printing the last calculated data
if [[ $counter > 0 ]]; then
	sleepavg_res=$(echo "$sleepavg_sum $counter" | awk '{printf "%f", $1 / $2}');
	result=$result'Average_Sleeping_Children_of_ParentID='$ppid_prev' is '$sleepavg_res$'\n';
fi;
echo "$result";
