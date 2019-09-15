#!/bin/bash

grep -EIrs "^#!" /bin | # searching for non-binary files with shebang  
sed -r 's/#![[:space:]]*//g' | # removing shebang and spaces after it
sed -r 's/[[:space:]]+.*//g' | # removing interpreter options 
column -t -s ':' # making output beautiful

