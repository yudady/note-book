@echo off

title �M��{���O�_�ҰʡA�ð���

echo �ⱱ��x��T���L��tasklist.log
tasklist > tasklist.log 
:tommyStart
echo *************************************************************
echo *************************************************************
echo *************************************************************
echo *************************************************************
echo **	------------------0.����				**
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
echo �z��ܤF���� %tommychoise%
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
echo �M��tasklist.log�ɮסA�̭��O�_��%tommy%
for /f %%i in (tasklist.log) do (
	REM echo %%i

	if "%%i"=="%tommy%" (
		echo ���%tommy%�A�w�g�Ұ�
		goto tommyIsRun
	) else (
		REM echo NO 
	)
)
REM ===================================================
if "%tommychoise%" == "1" (
	echo %tommy%�䤣��
	start E:\�n��Ұʱ��|\�K�w�˳n��\�|�檺�ɮ��`��Q-Dir\32bit\Q-Dir.exe
	GOTO tommyStart
)
if "%tommychoise%" == "2" (
	echo %tommy%�䤣��
	start C:\Users\Administrator\AppData\Local\Google\Chrome\Application\chrome.exe
	GOTO tommyStart
)






REM ===================================================
:tommyIsRun
(
	echo %tommy%�w�g�ҰʤF
)
GOTO tommyStart
:tommyEnd
echo �M���L�θ�T
set tommy=
echo �R��tasklist.log
Del tasklist.log



