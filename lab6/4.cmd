@echo off

set pwd=%cd%
cd /D c:\temp

driverquery /NH > drivers.txt
 
sort /R DRIVERS.txt > driversSorted.txt

cd /D %pwd%