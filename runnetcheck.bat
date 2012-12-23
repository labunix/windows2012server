@echo off

cd /d %~dp0

netcheck.bat > "%~0.log" 2>&1