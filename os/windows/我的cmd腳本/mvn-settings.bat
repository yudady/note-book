@echo off
title �۰ʳ]�w�ɡA�}��
COLOR A

echo windir %windir%
echo SystemRoot %SystemRoot%   
:: ===    C:\WINDOWS    (%windir% �P��)
echo ProgramFiles %ProgramFiles% 
:: ===    C:\Program Files
echo USERPROFILE %USERPROFILE%  
rem===    C:\Documents and Settings\Administrator  (�l�ؿ����u�ୱ�v,�u�}�l���v,�u���ç��v��)
echo APPDATA %APPDATA%      
rem===    C:\Documents and Settings\Administrator\Application Data
echo TEMP %TEMP%         
rem===    C:\DOCUME~1\ADMINI~1\LOCALS~1\Temp  (%TEM% �P��)
echo OS %OS%           
rem===    Windows_NT (�t��)
echo Path %Path%         
:: ===    %SystemRoot%\system32;%SystemRoot%;%SystemRoot%\System32\Wbem  (�쥻���]�m)
echo HOMEDRIVE %HOMEDRIVE%    
rem===    C:   (�t�νL)
echo HOMEPATH %HOMEPATH%     
rem===    \Documents and Settings\Administrator



echo *************************************************************
echo *************************************************************
echo *************************************************************
echo *************************************************************
echo **	------------------1.���q				**
echo **	------------------2.�a��				**
echo **	------------------3.���q				**
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
	echo ���b�]�m�N�z���A���K�K
	reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v ProxyEnable /t REG_DWORD /d 1 /f
	reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v ProxyServer /d "10.160.3.88:8080" /f
	reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v ProxyOverride /t REG_SZ /d "" /f
	reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v AutoConfigURL /d "http://web.chtn.com.tw" /f

	echo ���b��s�]�m�K�K
	ipconfig /flushdns
	net stop nexus

)
if "%tommychoise%" == "2" (
	echo ---2.copy localhost
	copy C:\Users\Administrator\.m2\back\settings-localhost.xml C:\Users\Administrator\.m2\settings.xml
	echo ���b�M�ťN�z���A���]�m�K�K
	reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v ProxyEnable /t REG_DWORD /d 0 /f
	reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v ProxyServer /d "" /f
	reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v ProxyOverride /t REG_SZ /d 0 /f
	reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v AutoConfigURL /d "" /f
	echo �N�z���A���]�m�w�g�M��
	echo ���b��s�]�m�K�K
	ipconfig /flushdns
	net start nexus
	
)
if "%tommychoise%" == "3" (
	echo ---1.copy hinet
	copy C:\Users\Administrator\.m2\back\settings-hinet.xml C:\Users\Administrator\.m2\settings.xml
	echo ���b�]�m�N�z���A���K�K
	reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v ProxyEnable /t REG_DWORD /d 0 /f
	reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v ProxyServer /d "" /f
	reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v ProxyOverride /t REG_SZ /d "" /f
	reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v AutoConfigURL /d "http://autoproxy.cht.com.tw/proxy.pac" /f

	echo ���b��s�]�m�K�K
	ipconfig /flushdns
	net stop nexus

)
type C:\Users\Administrator\.m2\settings.xml


