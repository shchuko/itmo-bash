#!/bin/bash
# Printing list of proccesses pid,command
ps -A -o pid,command | 
sed 1d | 
# Was executed from /sbin/
awk -F' ' '$2 ~ /\/sbin\/.*/ { print $1; }'

