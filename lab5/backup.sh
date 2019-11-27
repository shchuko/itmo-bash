#!/bin/bash
srcdir="$HOME/source";
if [[ ! -d $srcdir ]]; then
	echo "Directory $srcdir not exists";
	exit 1;
fi;

lastbackuptime=0;
cd $HOME;
backupslist=$(find . -maxdepth 1 -type d -printf "%f\n" | grep -soE "Backup-[0-9]{4}-[0-9]{2}-[0-9]{2}");
if [[ -n "$backupslist"  ]]; then 
	lastbackupdir=$(echo "$backupslist" | tail -1);
	lastbackupdate=$(echo "$lastbackupdir" | grep -soP "Backup-\K[0-9]{4}-[0-9]{2}-[0-9]{2}$");
	lastbackuptime=$(date -d $lastbackupdate +%s);
fi;

currentdate=$(date +%Y-%m-%d);
currenttime=$(date +%s);

let timediff=$currenttime-$lastbackuptime;
if [[ $timediff -gt 7*24*60*60 ]]; then
	backupdir="$HOME/Backup-$currentdate";
	mkdir $backupdir;
	backupexists=false;
else
	
	backupdir="$HOME/$lastbackupdir";
fi;

reportpath="$HOME/backup-report";
cd $srcdir;
fileslist=$(find . -maxdepth 1 -type f -printf "%f\n");

if [[ $backupexists = false ]]; then
	echo "$backupdir create  $currentdate" >> $reportpath;
	for filename in $fileslist; do
		cp --parents "$filename" "$backupdir/";
		echo "$filename backup done $currentdate" >> $reportpath;
	done;
else
	echo "$backupdir update  $currentdate" >> $reportpath;
	newfilesmsgs="";
	oldfilesmsgs="";
	for filename in $fileslist; do
		if [[ -e "$backupdir/$filename" ]]; then
			oldsize=$(stat -c%s "$backupdir/$filename")
			newsize=$(stat -c%s "$srcdir/$filename")

			if [[ $oldsize != $newsize ]]; then
				mv "$backupdir/$filename" "$backupdir/$filename.$currentdate";
				cp "$srcdir/$filename" "$backupdir/$filename";

				oldfilemsg=$oldfilemsg$(echo "$filename old backup moved to $filename.$currentdate $current_date")$'\n';
			fi;
		else
			cp --parents "$filename" "$backupdir/";
			newfilemsg=$newfilemsg$(echo "$filename backup done $currentdate")$'\n';
		fi;
	done;
	echo "$newfilemsg" | sed '/^$/d' >> $reportpath;
	echo "$oldfilemsg" | sed '/^$/d' >> $reportpath;
fi;
	
