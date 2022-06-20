@echo off

:: 수정 대상 파일 위치,내용 설정
set DIR=%SystemRoot%\system32\drivers\etc\host
set ADR=192.168.32.50
set DNS=idea.co.kr

echo ===================
echo 대상 파일 수정 경로 : %DIR%
echo 수정 내용 : %ADR% %DNS% 추가
echo.
echo [1] : YES
echo [2] : NO
echo ===================

SET /P CHOICE=select your choice ([1]/[2]):
echo Your choice is %CHOICE%

if %CHOICE%==1 (
	call :modify_file %DIR% %ADR% %DNS%
	goto STOP
) else (
	if %CHOICE%==2 (
		echo "파일을 수정하지 않습니다."
		goto STOP
	) else (
		echo 잘못 누르셨습니다. 1 또는 2를 눌러 선택하십시오
		goto STOP
	)
) 

:STOP
pause > null

::::::::::::::::::::::::::::::::::::
:modify_file <first> <second> <third>

	>nul find "%2" %1 && (
		echo "%2" was found.
	) || (
		echo "%2" was NOT found.
		:: 수정 대상 파일 공백 한줄 추가
		echo. >> %1
		:: 수정 내용 추가
		echo %2 %3 >> %1
	)
::::::::::::::::::::::::::::::::::::

