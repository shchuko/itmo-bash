@echo off
set command="%~dp02_copy.cmd C:\CD\ubuntu.iso"



FOR /F "TOKENS=1 DELIMS=:" %%A IN ('echo %TIME%') DO SET HH=%%A
FOR /F "TOKENS=2 DELIMS=:" %%A IN ('echo %TIME%') DO SET MM=%%A
FOR /F "TOKENS=3 DELIMS=:" %%A IN ('echo %TIME%') DO SET SS=%%A
FOR /F "TOKENS=1 DELIMS=," %%A IN ('echo %SS%') DO SET SS=%%A
FOR /F "TOKENS=1" %%A IN ('echo %SS%') DO SET SS=%%A

set /A timesecs=%hh% * 3600 + %mm% * 60 + %ss% + 60
set /A hhnew=%timesecs% / 3600
set /A mmnew=(%timesecs% - %hhnew% * 3600) / 60
set /A ssnew=(%timesecs% - %hhnew% * 3600 - %mmnew% * 60)

SET hhnew=00%hhnew%
SET hhnew=%hhnew:~-2%

SET mmnew=00%mmnew%
SET mmnew=%mmnew:~-2%

SET ssnew=00%ssnew%
SET ssnew=%ssnew:~-2%

echo Exec in 1 minute: %command%
echo At %hhnew%:%mmnew%:%ssnew%

schtasks /create /SC once /TN myTestTask /TR %command% /ST %hhnew%:%mmnew%:%ssnew% /ru Administrator /rp 123654

