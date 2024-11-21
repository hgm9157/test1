@echo off
:: 설정 - 사용할 포트와 JAR 파일 경로
SET PORT=8084
SET JAR_PATH=C:\ProgramData\Jenkins\.jenkins\workspace\test1\build\libs\hgm.jar
SET LOG_PATH=C:\logs\output.log

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


:: 새로운 JAR 실행 (백그라운드)
echo Starting application: %JAR_PATH%
start /min java -jar %JAR_PATH%

:: 대기 시간 (서버가 실행될 시간을 기다림)
::timeout /t 10 /nobreak >nul

:: 스크립트 종료
echo Deployment script completed.

::exit 0
