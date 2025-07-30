@echo off
setlocal enabledelayedexpansion

set "runbat=%~dp0..\Run.bat"

set "python_exe=%ProgramFiles%\Python312\python.exe"
if exist "%python_exe%" (
    exit /b 0
)

echo [INFO] Python not found. Downloading installer...

for %%i in ("%TEMP%\python_installer.exe") do set "temp_installer=%%~fi"
curl -o "%temp_installer%" https://www.python.org/ftp/python/3.12.3/python-3.12.3-amd64.exe

echo [INFO] Installing Python... (may prompt for UAC)...
"%temp_installer%" /quiet InstallAllUsers=1 PrependPath=1 Include_test=0

echo [SUCCESS] Python installed at "%python_exe%"
goto :done

:done
echo [INFO] Python is ready.
echo [SUCCESS] Please re-launch this terminal to complete the installation.
pause
exit /b 123

endlocal
exit /b 0
