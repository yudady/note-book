@echo off
echo 當前盤符：%~d0
echo 當前盤符和路徑：%~dp0
echo 當前批處理全路徑：%~f0
echo 當前盤符和路徑的短文件名格式：%~sdp0
echo 當前CMD默認目錄：%cd%
echo 目錄中有空格也可以加入""避免找不到路徑
echo 當前盤符："%~d0"
echo 當前盤符和路徑："%~dp0"
echo 當前批處理全路徑："%~f0"
echo 當前盤符和路徑的短文件名格式："%~sdp0"
echo 當前CMD默認目錄："%cd%"
rem 放在TOMCAT目錄中
SET JAVA_HOME=E:\SoftWare\javaTools\OracleSun\jdk1.6.0_27
SET CATALINA_HOME=%cd%
./bin/startup.bat



