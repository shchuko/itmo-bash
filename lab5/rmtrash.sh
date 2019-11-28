#!/bin/bash

logpath=$HOME/.trash.log
trashpath=$HOME/.trash

if [[ $# -ne 1 ]]; then
	echo "Illegal numbel of arguments. One argument required";
	echo "Aborting...";
	exit 1;
fi;

if [[ ! -f $1 ]]; then 
	echo "File ${1} does not exist";
	echo "Aborting...";
	exit 1;
fi;

if [[ ! -d $trashpath ]]; then 
	mkdir $trashpath;
	touch $logpath;
	counter=1;
else
	let counter=$(cat $logpath | awk -F':' 'END { print $2; }')+1;
fi;

fullpath=$(readlink -m $1);
ln $1 "$trashpath/$counter";
rm $1;

timestamp=$(date "+%Y-%m-%d-%H:%M:%S");
echo "$fullpath:$counter:$timestamp" >> $logpath;

