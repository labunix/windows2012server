@echo off
echo ################################################################################
echo #
echo # 0. 初期化、このバッチファイルフォルダに移動
echo #
echo ################################################################################
@echo on

set NUM=0
cd /d %~dp0

set /a NUM=%NUM%+1
@echo off
echo ################################################################################
echo #
echo # %NUM%. 日付フォルダの作成(2012/12/22, 文字範囲 0-3,5-6,8-9 , 文字数 4,2,2)
echo #
echo ################################################################################
@echo on

set MYDATE=%date:~0,4%%date:~5,2%%date:~8,2%
dir /b/ad "%MYDATE%_%COMPUTERNAME%" >NUL 2>NUL || mkdir "%MYDATE%_%COMPUTERNAME%"
dir /b/ad "%MYDATE%_%COMPUTERNAME%" >NUL 2>NUL && cd "%MYDATE%_%COMPUTERNAME%"
echo . 2> %NUM%_date.log
if ERRORLEVEL 1 exit /b %NUM%

set /a NUM=%NUM%+1
@echo off
echo ################################################################################
echo #
echo # %NUM% システム情報(Comma/CSV)
echo #
echo ################################################################################
@echo on

systeminfo /FO CSV > %NUM%_systeminfo.csv
if ERRORLEVEL 1 exit /b %NUM%

set /a NUM=%NUM%+1
@echo off
echo ################################################################################
echo #
echo # %NUM% 稼働中サービス一覧
echo #
echo ################################################################################
@echo on

net start > %NUM%_net_start.log
if ERRORLEVEL 1 exit /b %NUM%

set /a NUM=%NUM%+1
@echo off
echo ################################################################################
echo #
echo # %NUM% 全サービス一覧(表示名)
echo #
echo ################################################################################
@echo on

sc query | findstr "^D" > %NUM%_sc_query.log
if ERRORLEVEL 1 exit /b %NUM%

set /a NUM=%NUM%+1
@echo off
echo ################################################################################
echo #
echo # %NUM% 全サービス一覧(サービス名)
echo #
echo ################################################################################
@echo on

sc query | findstr "^S" >> %NUM%_sc_query.log
if ERRORLEVEL 1 exit /b %NUM%

set /a NUM=%NUM%+1
@echo off
echo ################################################################################
echo #
echo # %NUM% ドライバ一覧(Comma/CSV)
echo #
echo ################################################################################
@echo on

driverquery /FO CSV > %NUM%_drivequery.csv
if ERRORLEVEL 1 exit /b %NUM%

set /a NUM=%NUM%+1
@echo off
echo ################################################################################
echo #
echo # %NUM% ローカルユーザ一覧
echo #
echo ################################################################################
@echo on

net user > %NUM%_net_user.log
if ERRORLEVEL 1 exit /b %NUM%

set /a NUM=%NUM%+1
@echo off
echo ################################################################################
echo #
echo # %NUM% WindowsUpdate一覧(tab/CSV)
echo #
echo ################################################################################
@echo on

wmic qfe > %NUM%_wmic_qfe.log
if ERRORLEVEL 1 exit /b %NUM%

set /a NUM=%NUM%+1
@echo off
echo ################################################################################
echo #
echo # %NUM% アプリケーション一覧
echo #
echo ################################################################################
@echo on

reg query "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall" /s | findstr "DisplayName" | findstr /V "更新 修正 (KB" > %NUM%_Uninstall.log
if ERRORLEVEL 1 exit /b %NUM%

set /a NUM=%NUM%+1
@echo off
echo ################################################################################
echo #
echo # %NUM% 役割/機能一覧
echo #
echo ################################################################################
@echo on

powershell import-module servermanager
powershell get-windowsfeature > %NUM%_getwindowsfeature_all.log
powershell get-windowsfeature | find "[X]" > %NUM%_getwindowsfeature.log
if ERRORLEVEL 1 exit /b %NUM%

set /a NUM=%NUM%+1
@echo off
echo ################################################################################
echo #
echo # %NUM% 後処理
echo #
echo ################################################################################
@echo on

if EXIST ..\runwincheck.bat.log type ..\runwincheck.bat.log > "%NUM%_%MYDATE%_%COMPUTERNAME%.log"
if ERRORLEVEL 1 exit /b %NUM%
echo 正常終了 >> "%NUM%_%MYDATE%_%COMPUTERNAME%.log"




