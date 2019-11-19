#!/bin/bash

if [[ ! -r v_data ]]; then
        echo "v_data file not exists";
        exit 0;
fi;

curpid=$(echo $$);
mode="+";
value=1;
echo "Start value: $value";

function calculate {
        if [[ "$mode" == "+" ]]; then
                let value=$value+$1;
                else
                let value=$value*$1;
        fi;
}

(tail -n 0 -f v_data) |
while true; do
        read LINE;
        case $LINE in
        "+")
                mode="+"
                echo "Add mode"
                ;;
        "*")
                mode="*"
                echo "Mul mode"
                ;;
        "QUIT")
                kill -- -$(ps -o pgid=$curpid | grep -o [0-9]*);
                exit 0;
                ;;
        *)
                if [[ "$LINE" =~ [0-9]+ ]]
                then
                        calculate $LINE;
                        echo "New value: $value";
                else
                        echo "Incorrect message"
                fi
                ;;
        esac;
done;
