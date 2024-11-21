@echo off

@echo off
setlocal enabledelayedexpansion

:: 찾고자 하는 포트 번호 설정
set PORT=8084
:: 해당 포트를 사용하는 프로세스의 PID 찾기
for /f "tokens=5" %%a in ('netstat -ano ^| findstr :%PORT%') do (
    set PID=%%a
)

:: PID가 존재하는 경우 프로세스를 종료
if defined PID (
    echo Killing process with PID: !PID!
    taskkill /F /PID !PID!
) else (
    echo No process found on port %PORT%.
)

endlocal

:: 새로 빌드된 JAR 파일 실행

java -jar C:\ProgramData\Jenkins\.jenkins\workspace\test1\build\libs\hgm.jar

echo Application restarted successfully.