@ECHO OFF
IF "%1" == "" (set /p program=Program to build :) else (set program=%1)
if "%program:~-4%" equ ".asm" (
    ECHO Please specify the program without the asm file extension
    EXIT 64
)
IF NOT EXIST ..\build (
mkdir ..\build
)
nasm -f bin %program%.asm -l ..\build\%program%.lst -o ..\build\%program%.com
EXIT 0