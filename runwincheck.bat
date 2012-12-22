@echo off

cd /d %~dp0

wincheck.bat > "%~0.log" 2>&1