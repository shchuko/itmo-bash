#!/bin/bash

FILETOREAD="/var/log/Xorg.8.log";
LOGFILE="${PWD}/full.log"

sed -n "s/II/Information/p" $FILETOREAD | sed 1d > $LOGFILE;
sed -n "s/WW/Warning/p" $FILETOREAD | sed 1d >> $LOGFILE;
cat $LOGFILE;

