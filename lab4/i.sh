#!/bin/bash

mkdir ~/"test" && (
echo "catalog test was created successfully" > ~/report;
touch ~/test/$(date +"%F_%R");
);
host="www.net_nikogo.ru"
ping -c 1 $host || 
echo "Unable to make a connection to host: $host" >> ~/report
