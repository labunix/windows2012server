@echo off

cd /d %~dp0

netcheck_debug.bat > "%~0.log" 2>&1