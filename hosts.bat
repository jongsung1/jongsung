@echo off

:: ���� ��� ���� ��ġ,���� ����
set DIR=%SystemRoot%\system32\drivers\etc\host
set ADR=192.168.32.50
set DNS=idea.co.kr

echo ===================
echo ��� ���� ���� ��� : %DIR%
echo ���� ���� : %ADR% %DNS% �߰�
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
		echo "������ �������� �ʽ��ϴ�."
		goto STOP
	) else (
		echo �߸� �����̽��ϴ�. 1 �Ǵ� 2�� ���� �����Ͻʽÿ�
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
		:: ���� ��� ���� ���� ���� �߰�
		echo. >> %1
		:: ���� ���� �߰�
		echo %2 %3 >> %1
	)
::::::::::::::::::::::::::::::::::::

