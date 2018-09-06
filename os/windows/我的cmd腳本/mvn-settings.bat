@echo off
title 自動設定檔，腳本
COLOR A

echo windir %windir%
echo SystemRoot %SystemRoot%   
:: ===    C:\WINDOWS    (%windir% 同樣)
echo ProgramFiles %ProgramFiles% 
:: ===    C:\Program Files
echo USERPROFILE %USERPROFILE%  
rem===    C:\Documents and Settings\Administrator  (子目錄有「桌面」,「開始菜單」,「收藏夾」等)
echo APPDATA %APPDATA%      
rem===    C:\Documents and Settings\Administrator\Application Data
echo TEMP %TEMP%         
rem===    C:\DOCUME~1\ADMINI~1\LOCALS~1\Temp  (%TEM% 同樣)
echo OS %OS%           
rem===    Windows_NT (系統)
echo Path %Path%         
:: ===    %SystemRoot%\system32;%SystemRoot%;%SystemRoot%\System32\Wbem  (原本的設置)
echo HOMEDRIVE %HOMEDRIVE%    
rem===    C:   (系統盤)
echo HOMEPATH %HOMEPATH%     
rem===    \Documents and Settings\Administrator



echo *************************************************************
echo *************************************************************
echo *************************************************************
echo *************************************************************
echo **	------------------1.公司				**
echo **	------------------2.家裡				**
echo **	------------------3.公司				**
echo **								**
echo **								**
echo **								**
echo *************************************************************
set tommychoise =
set /p tommychoise=choise:

echo u choise %tommychoise%

if "%tommychoise%" == "1" (
	echo ---1.copy hinet
	copy C:\Users\Administrator\.m2\back\settings-hinet.xml C:\Users\Administrator\.m2\settings.xml
	echo 正在設置代理伺服器……
	reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v ProxyEnable /t REG_DWORD /d 1 /f
	reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v ProxyServer /d "10.160.3.88:8080" /f
	reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v ProxyOverride /t REG_SZ /d "" /f
	reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v AutoConfigURL /d "http://web.chtn.com.tw" /f

	echo 正在刷新設置……
	ipconfig /flushdns
	net stop nexus

)
if "%tommychoise%" == "2" (
	echo ---2.copy localhost
	copy C:\Users\Administrator\.m2\back\settings-localhost.xml C:\Users\Administrator\.m2\settings.xml
	echo 正在清空代理伺服器設置……
	reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v ProxyEnable /t REG_DWORD /d 0 /f
	reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v ProxyServer /d "" /f
	reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v ProxyOverride /t REG_SZ /d 0 /f
	reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v AutoConfigURL /d "" /f
	echo 代理伺服器設置已經清空
	echo 正在刷新設置……
	ipconfig /flushdns
	net start nexus
	
)
if "%tommychoise%" == "3" (
	echo ---1.copy hinet
	copy C:\Users\Administrator\.m2\back\settings-hinet.xml C:\Users\Administrator\.m2\settings.xml
	echo 正在設置代理伺服器……
	reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v ProxyEnable /t REG_DWORD /d 0 /f
	reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v ProxyServer /d "" /f
	reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v ProxyOverride /t REG_SZ /d "" /f
	reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v AutoConfigURL /d "http://autoproxy.cht.com.tw/proxy.pac" /f

	echo 正在刷新設置……
	ipconfig /flushdns
	net stop nexus

)
type C:\Users\Administrator\.m2\settings.xml


