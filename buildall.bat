@echo off

REM run with ./buildall.bat from a Windows powershell terminal

REM Clean prepare/results directory
cd prepare
if exist results rmdir /s /q results

REM Render prepare Quarto project
quarto render

cd ..

REM Clean report/results directory
cd report
if exist results rmdir /s /q results

REM Render report Quarto project
quarto render
