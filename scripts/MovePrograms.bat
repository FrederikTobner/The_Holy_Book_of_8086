@ECHO OFF
IF "%1" == "" (set /p folder=Folder location :) else (set folder=%1)
IF NOT EXIST "%folder%" (
mkdir "%folder%"
)
cd ..\build\
for /f "delims=" %%i in ('dir /b /a-d *.com') do (
copy  %%i "%folder%"
)
cd ..\scripts