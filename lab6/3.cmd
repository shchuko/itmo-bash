@echo off

set pwd=%cd%
cd /D c:\temp

net start > services.txt

net stop Dnscache

net start > servicesStopDns.txt

fc /A /L servicesStopDns.txt services.txt > servicesDiff.txt

net start Dnscache

cd /D %pwd%