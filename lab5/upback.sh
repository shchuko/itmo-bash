#!/bin/bash

cd $HOME;
backupdir=$(find . -maxdepth 1 -printf "%f\n" | sort | grep -oE "Backup-[0-9]{4}-[0-9]{2}-[0-9]{2}" | tail -1);
if [[ -z "$backupdir" ]]; then
	echo "Backup not found";
	exit;
fi;

cd "$backupdir";
files=$(find . -type f | grep -E -v ".[0-9]{4}-[0-9]{2}-[0-9]{2}");

restoredir="$HOME/restore/";
[[ ! -d "$restoredir" ]] && mkdir "$restoredir";

for filename in $files; do
	[[ $filename == ".*\.[0-9]{4}-[0-9]{2}-[0-9]{2}$" ]] && continue;
  	cp --parents "$filename" "$restoredir/";
done;
