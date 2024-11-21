@echo off
:: 설정 - 사용할 포트와 JAR 파일 경로
SET PORT=8084
SET JAR_PATH=C:\ProgramData\Jenkins\.jenkins\workspace\test1\build\libs\hgm.jar

:: 기존 포트 사용 프로세스 찾기
FOR /F "tokens=5" %%i IN ('netstat -ano ^| findstr :%PORT%') DO (
    SET PID=%%i
    echo Port %PORT% is being used by process ID: %PID%
)

:: 프로세스 종료
IF NOT "%PID%"=="" (
    echo Terminating process %PID% using port %PORT%...
    taskkill /PID %PID% /F
    IF %ERRORLEVEL%==0 (
        echo Successfully terminated process %PID%.
    ) ELSE (
        echo Failed to terminate process %PID%. Ensure you have administrator privileges.
        exit /b 1
    )
) ELSE (
    echo No process found using port %PORT%.
)

:: 새로운 JAR 실행
echo Starting application: %JAR_PATH%
cmd /c java -jar %JAR_PATH% > C:\logs\output.log 2>&1

:: 대기 시간 (필요하면 수정 가능)
timeout 5 >nul

echo Deployment script completed.
exit 0