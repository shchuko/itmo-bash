#!/bin/bash

echo $$ > .pid;

counter=1;
mode="wait";

add()
{
	mode="add"
}

mul()
{
	mode="mul"
}

termme()
{
	mode="termme"
}

trap 'add' USR1;
trap 'mul' USR2;
trap 'termme' SIGTERM;

while true; do
    case $mode in
        "add")
            let counter=$counter+2;
            echo $counter;
            mode="wait"
            ;;
        "mul")
            let counter=$counter*2;
            echo $counter;
            mode="wait";
            ;;
        "termme")
            echo "SIGTERM handled";
            rm .pid;
            exit 0;
            ;;
    esac;
   
    sleep 1;
done;
