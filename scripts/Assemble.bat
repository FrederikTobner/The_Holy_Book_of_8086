@ECHO OFF
IF "%1" == "" (set /p program=Program to build :) else (set program=%1)
if "%program:~-4%" equ ".asm" (
    ECHO Please specify the program without the asm file extension
    EXIT 64
)
nasm -f bin %program%.asm -l %program%.lst -o %program%.com
IF NOT EXIST ..\build (
mkdir ..\build
)
cd ..\src\
:: Moving command files
for /f "delims=" %%i in ('dir /b /a-d *.com') do (
move  %%i ..\build
)
:: Moving listings
for /f "delims=" %%i in ('dir /b /a-d *.lst') do (
move  %%i ..\build
)
cd ..\scripts
EXIT 0