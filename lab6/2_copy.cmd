@echo off
goto:begin

:WrongArgumentsMsg
	echo Wrong arguments. One argument required: Path to file to be copied to \\%computername%\temp\
	goto:eof

:FileNotExistsMsg
	echo File "%1" not exists
	goto:eof

:SmallFileSizeError
	echo File size is lesser than 2Mib
	goto:eof

:Begin
	set argC=0
	for %%x in (%*) do Set /A argC+=1
	if not "%argC%" == "1" goto:WrongArgumentsMsg

	if not exist %1 goto:FileNotExistsMsg
	
	set /A size=%~z1
	set /A minsize=2*1024*1024
	if %size% lss %minsize% goto:SmallFileSizeError
	
:StartCopy
	xcopy /Z /Y %1 \\%computername%\temp\
	
	