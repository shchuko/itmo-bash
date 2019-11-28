@ECHO OFF 
chcp 1251  

if not exist C:\LAB6 md C:\LAB6

set pwd=%cd%
cd /D C:\LAB6
systeminfo > systeminfo.txt

wmic logicaldisk get description,name > diskinfo.txt

if not exist TEST md TEST
copy . TEST

copy TEST\systeminfo.txt+TEST\diskinfo.txt concatres.txt

del systeminfo.txt, diskinfo.txt

cd /D %pwd%
