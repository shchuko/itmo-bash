#!/bin/bash
# Saving list of processes with user == $USER 
plist=$(ps -A -u $USER o pid,cmd);
# Saving number of processes
pcount=$(echo "$plist" | sed 1d | wc -l);
# Printing results
echo "$plist";
echo "Total processes: ${pcount}";
