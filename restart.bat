@echo off
:: 설정 - 사용할 포트와 JAR 파일 경로
SET PORT=8084
SET JAR_PATH=C:\ProgramData\Jenkins\.jenkins\workspace\test1\build\libs\hgm.jar
SET LOG_PATH=C:\logs\output.log



:: 새로운 JAR 실행 (백그라운드)
echo Starting application: %JAR_PATH%
start /B java -jar %JAR_PATH%

:: 대기 시간 (서버가 실행될 시간을 기다림)
timeout /t 10 /nobreak >nul

:: 스크립트 종료
echo Deployment script completed.

exit 0
