@echo off
goto:Begin

:WrongArgumentsMsg
	echo Wrong arguments
	echo Two arguments required: Paths to files to be compared
	goto:eof

:FirstFileNotExistsMsg
	echo File %1 not exists
	goto:eof

:SecondFileNotExistsMsg
	echo File %2 not exists
	goto:eof

:FilesAreDifferentMsg
	echo Files eq test failed
	goto:eof

:Begin
	set argC=0
	for %%x in (%*) do Set /A argC+=1
	if  not "%argC%" == "2" goto:WrongArgumentsMsg

	if not exist %1 goto:FirstFileNotExistsMsg
	if not exist %2 goto:SecondFileNotExistsMsg
	

	fc %1 %2 > nul
	if errorlevel 1 goto:FilesAreDifferentMsg

	echo Files are equal
	