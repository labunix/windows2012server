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
if ERRORLEVEL 1 echo ERROR %NUM%

set /a NUM=%NUM%+1
@echo off
echo ################################################################################
echo #
echo # %NUM%. ファイアウォールの状態
echo #
echo ################################################################################
@echo on

netsh advfirewall show allprofiles state > %NUM%_netsh_advfirewall.log
netsh advfirewall show currentprofile >> %NUM%_netsh_advfirewall.log
if ERRORLEVEL 1 echo ERROR %NUM%


set /a NUM=%NUM%+1
@echo off
echo ################################################################################
echo #
echo # %NUM%. ファイアウォールのルール一覧
echo #
echo ################################################################################
@echo on

netsh advfirewall firewall show rule all >> %NUM%_netsh_firewall_rule.log
if ERRORLEVEL 1 echo ERROR %NUM%

set /a NUM=%NUM%+1
@echo off
echo ################################################################################
echo #
echo # %NUM%. ネットワーク構成
echo #
echo ################################################################################
@echo on

netsh dump > %NUM%_netsh.log
if ERRORLEVEL 1 echo ERROR %NUM%

set /a NUM=%NUM%+1
@echo off
echo ################################################################################
echo #
echo # %NUM%. ネットワークアダプタ
echo #
echo ################################################################################
@echo on

ipconfig /all > %NUM%_ipconfig.log
if ERRORLEVEL 1 echo ERROR %NUM%

set /a NUM=%NUM%+1
@echo off
echo ################################################################################
echo #
echo # %NUM%. アクティブな接続
echo #
echo ################################################################################
@echo on

netstat -an > %NUM%_netstat.log
if ERRORLEVEL 1 echo ERROR %NUM%

set /a NUM=%NUM%+1
@echo off
echo ################################################################################
echo #
echo # %NUM%. ルーティング
echo #
echo ################################################################################
@echo on

route print > %NUM%_route.log
if ERRORLEVEL 1 echo ERROR %NUM%

set /a NUM=%NUM%+1
@echo off
echo ################################################################################
echo #
echo # %NUM%. ARP
echo #
echo ################################################################################
@echo on

arp -a > %NUM%_arp.log
if ERRORLEVEL 1 echo ERROR %NUM%

set /a NUM=%NUM%+1
@echo off
echo ################################################################################
echo #
echo # %NUM%. ネットワーク経路
echo #
echo ################################################################################
@echo on

tracert google.co.jp > %NUM%_tracert.log
if ERRORLEVEL 1 echo ERROR %NUM%

set /a NUM=%NUM%+1
@echo off
echo ################################################################################
echo #
echo # %NUM%. ネットワーク経路統計
echo #
echo ################################################################################
@echo on

pathping google.co.jp
if ERRORLEVEL 1 echo ERROR %NUM%

set /a NUM=%NUM%+1
@echo off
echo ################################################################################
echo #
echo # %NUM%. パケットエラー
echo #
echo ################################################################################
@echo on

netstat -e > %NUM%_netstat_e.log
if ERRORLEVEL 1 echo ERROR %NUM%

if ERRORLEVEL 1 echo ERROR %NUM%

set /a NUM=%NUM%+1
@echo off
echo ################################################################################
echo #
echo # %NUM%. パケット統計
echo #
echo ################################################################################
@echo on

netstat -s > %NUM%_netstat_s.log
if ERRORLEVEL 1 echo ERROR %NUM%

set /a NUM=%NUM%+1
@echo off
echo ################################################################################
echo #
echo # %NUM%. 名前解決(DNS)
echo #
echo ################################################################################
@echo on

nslookup -type=NS www.google.co.jp > %NUM%_nslookup.log
if ERRORLEVEL 1 echo ERROR %NUM%

set /a NUM=%NUM%+1
@echo off
echo ################################################################################
echo #
echo # %NUM%. コンピュータ名を一覧(NetBios)
echo #
echo ################################################################################
@echo on

net view > %NUM%_net_view.log
if ERRORLEVEL 1 echo ERROR %NUM%

set /a NUM=%NUM%+1
@echo off
echo ################################################################################
echo #
echo # %NUM%. 共有リソース(管理共有)
echo #
echo ################################################################################
@echo on

net share /N > %NUM%_net_share.log
if ERRORLEVEL 1 echo ERROR %NUM%

set /a NUM=%NUM%+1
@echo off
echo ################################################################################
echo #
echo # %NUM%. ドライブ直下のアクセス権
echo #
echo ################################################################################
@echo on

icacls %HOMEDRIVE%\* > %NUM%_icacls.log
if ERRORLEVEL 1 echo ERROR %NUM%

set /a NUM=%NUM%+1
@echo off
echo ################################################################################
echo #
echo # %NUM%. ドライブ直下のファイルの属性
echo #
echo ################################################################################
@echo on

attrib %HOMEDRIVE%\* > %NUM%_attrib.log
if ERRORLEVEL 1 echo ERROR %NUM%

set /a NUM=%NUM%+1
@echo off
echo ################################################################################
echo #
echo # %NUM%. ドライブ直下のファイルの一覧
echo #
echo ################################################################################
@echo on

dir /s /b %HOMEDRIVE%\ > %NUM%_dir.log
if ERRORLEVEL 1 echo ERROR %NUM%
set /a NUM=%NUM%+1
set /a NUM=%NUM%+1

@echo off
echo ################################################################################
echo #
echo # %NUM% 後処理
echo #
echo ################################################################################
@echo on

if EXIST ..\runnetcheck_debug.bat.log type ..\runnetcheck_debug.bat.log > "%NUM%_%MYDATE%_%COMPUTERNAME%.log"
if ERRORLEVEL 1 echo ERROR %NUM%
echo 正常終了 >> "%NUM%_%MYDATE%_%COMPUTERNAME%.log"

