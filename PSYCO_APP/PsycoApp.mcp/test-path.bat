cd "C:\Users\PC\Documents\GitHub\PsycoApp_SentirseBien\PSYCO_APP\PsycoApp.mcp"

@'
@echo off
echo ====================================
echo TEST PATH DIAGNOSTIC
echo ====================================
echo Timestamp: %date% %time%
echo Current Directory: %cd%
echo Command received: %*
echo Full Path 0: %~f0
echo Full Path 1: %~f1
echo ====================================
echo Checking if file exists...
if exist "%~f1" (
    echo ✅ FILE EXISTS: %~f1
    echo File size: %~z1 bytes
) else (
    echo ❌ FILE NOT FOUND: %~f1
    echo Trying alternative paths...
    echo Looking for: PsycoApp.mcp.exe
    dir /s /b *.exe | findstr /i psycoapp
)
echo ====================================
echo Environment variables:
echo PATH starts with: %PATH:~0,200%...
echo ====================================
pause
'@ | Out-File -FilePath "test-path.bat" -Encoding ASCII