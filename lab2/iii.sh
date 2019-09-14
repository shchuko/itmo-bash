#!/bin/bash

CHECKDIR="/etc"
OUTFILE="${PWD}/emails.lst";

grep -EIrhosi "[[:alnum:]_-]+@[[:alnum:]]+((\.)[[:alnum:]]{2,6})+" $CHECKDIR |
tr -s "\n" "," > $OUTFILE;
echo >> $OUTFILE;
