@echo off

set /A counter=1
set myprocess=xcopy.exe

call 2_scheduled.cmd

:Loop
echo Attemp...
TASKLIST | FINDSTR -i %myprocess% >NUL 2>&1 || (
	echo Process %myprocess% not found
	if %counter% equ 120 goto:Error 
	set /A counter+=1
	ping 127.0.0.1 -n 2 > nul
	goto:Loop
)

:Success
	echo %myprocess% found
	call 2_clr_sched
	
	TASKKILL /F /IM %myprocess%
	call 2_compare C:\CD\ubuntu.iso \\%computername%\temp\ubuntu.iso 
	ping 127.0.0.1 -n 5 > nul 

	call 2_copy c:\CD\ubuntu.iso 
	call 2_compare C:\CD\ubuntu.iso \\%computername%\temp\ubuntu.iso

	goto:eof

:Error
	echo Process not found
	goto:eof