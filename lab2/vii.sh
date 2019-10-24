#!/bin/bash

man bash | # getting text 
sed -r 's/[[:space:]]+/\n/g' | # splitting test to format 'one word per line'
sort | # sorting
uniq -c | # removing copies
sort -n -r | # sorting by the number word repeated
# printig words with length >=4
awk -F' ' '{ 
	if (length($2) >= 4) {
		print $2;
	}
}' | 
sed -n 1,3p # printing first three lines

