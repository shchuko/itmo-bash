@ECHO OFF 

if not exist C:\LAB6 md C:\LAB6

set pwd=%cd%
cd /D C:\LAB6

wmic os get Caption > caption.txt 
wmic os get FreePhysicalMemory,TotalVisibleMemorySize > memoryinfo.txt 
wmic logicaldisk get name,description > diskinfo.txt

if not exist TEST md TEST
copy . TEST

copy TEST\*.txt concatres.txt

del caption.txt, memoryinfo.txt, diskinfo.txt

cd /D %pwd%
