#!/bin/bash

trashpath=$HOME/.trash;
logpath=$HOME/.trash.log;

readYesNo() {
while true; do
	echo $1;
		read answ;
		case $answ in 
			"y"|"Y") 	
				yesnoflag=true;	
				break;
				;;
			"n"|"N"|"")
				yesnoflag=false;	
				break;
				;;
				
			*)
				echo "Wrong answer. Try again...";
				;;
		esac;
	done;
}

if [[ $# -ne 1 ]]; then
        echo "Illegal numbel of arguments. One argument required";
        echo "Aborting...";
        exit 1;
fi;


linecounter=1;
for line in $(grep -sE "^(/.+)+/$1:.*$" $logpath); do
	fullpath=$(echo $line | awk -F':' '{ print $1; }');
	dirpath=$(echo $fullpath | awk -F '/' 'BEGIN { OFS="/" } {$NF=""; print $0;}');
	counter=$(echo $line | awk -F':' '{ print $2; }');
	timestamp=$(echo $line | grep -osE "[0-9]+-[0-9]+-[0-9]+-[0-9]+:[0-9]+:[0-9]+$");
	trashedpath=$trashpath/$counter;
	
	if [[ -e $trashedpath ]]; then
		readYesNo "Restore $fullpath (deleted $timestamp) (y/N)?";
		restoreflag=$yesnoflag;	
		
			
		if [[ $restoreflag = true && ! -d $dirpath ]]; then
			echo "File location directory not found. Restoring to $HOME"; 
			dirpath=$HOME;
			fullpath=$dirpath/$1;
		fi;

		if [[ $restoreflag == true && -e $fullpath ]]; then
			readYesNo "File $fullpath already exists. Overwrite (y/N)?";
			if [[ $yesnoflag == true ]]; then
				rm $fullpath;
			else
				echo "Restore aborded";
				exit;
			fi;
		fi;
		

		if [[ $restoreflag == true ]]; then
			ln $trashedpath $fullpath;
			rm $trashedpath;
			
			sed -i ${linecounter}d $logpath;
			exit;
		fi;

	fi;
	let linecounter=$linecounter+1;
done;	

