@echo off

title 尋找程式是否啟動，並執行

echo 把控制台資訊打印到tasklist.log
tasklist > tasklist.log 
:tommyStart
echo *************************************************************
echo *************************************************************
echo *************************************************************
echo *************************************************************
echo **	------------------0.結束				**
echo **	------------------1.Q-Dir.exe				**
echo **	------------------2.chrome.exe				**
echo **								**
echo **								**
echo **								**
echo **								**
echo *************************************************************
set tommy=
set tommychoise =
set /p tommychoise=choise:
echo 您選擇了執行 %tommychoise%
if "%tommychoise%" == "1" (
	set tommy=Q-Dir.exe
	GOTO tommyMark1
)
if "%tommychoise%" == "2" (
	set tommy=chrome.exe
	GOTO tommyMark1
)






REM ===================================================
GOTO tommyEnd
:tommyMark1
echo 尋找tasklist.log檔案，裡面是否有%tommy%
for /f %%i in (tasklist.log) do (
	REM echo %%i

	if "%%i"=="%tommy%" (
		echo 找到%tommy%，已經啟動
		goto tommyIsRun
	) else (
		REM echo NO 
	)
)
REM ===================================================
if "%tommychoise%" == "1" (
	echo %tommy%找不到
	start E:\軟體啟動捷徑\免安裝軟體\四格的檔案總管Q-Dir\32bit\Q-Dir.exe
	GOTO tommyStart
)
if "%tommychoise%" == "2" (
	echo %tommy%找不到
	start C:\Users\Administrator\AppData\Local\Google\Chrome\Application\chrome.exe
	GOTO tommyStart
)






REM ===================================================
:tommyIsRun
(
	echo %tommy%已經啟動了
)
GOTO tommyStart
:tommyEnd
echo 清除無用資訊
set tommy=
echo 刪除tasklist.log
Del tasklist.log



