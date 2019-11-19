 
#!/bin/bash

while true; do
    read LINE;
    case $LINE in
	"+")
		echo "Send USR1";
        	kill -USR1 $(cat .pid);
            	;;
        "*")
		echo "Send USR2";
            	kill -USR2 $(cat .pid);
            	;;
        TERM)
		echo "Send SIGTERM";
            	kill -SIGTERM $(cat .pid);
            	exit 0;
            	;;
        *)
		echo "NOP";
           	:;
            	;;
    esac;
done
