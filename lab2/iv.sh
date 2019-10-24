#!/bin/bash

grep -EIrhs "^#!" /bin | # searching for non-binary files with shebang  
sed -r 's/#![[:space:]]*//g' | # removing shebang and spaces after it
sed -r 's/[[:space:]]+.*//g' | # removing interpreter options
sort | # sorting interpters paths 
uniq -c | # removing copies
sort -n -r | # sorting by the number of interpreter repeated
sed -n 1p | # printing the first linf
awk -F' ' '{print $2;}' # printing interpterer path


