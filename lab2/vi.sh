#!/bin/bash

for FILEPATH in $(ls /var/log/*.log); do 
	let LINESCOUNT=$LINESCOUNT+$(wc -l < $FILEPATH); 
done; 
echo $LINESCOUNT

