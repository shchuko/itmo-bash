#!/bin/bash

awk -F ':' '{ print "Username: " $1 "~UID: " $3 }' /etc/passwd | # getting data
sort -n -t ':' -k 3 | #sorting by UID
column -t -s '~' # printing

