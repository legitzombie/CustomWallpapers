@echo off
setlocal

set "python_exe=%ProgramFiles%\Python312\python.exe"
if exist "%python_exe%" (
    goto :done
)

echo [INFO] Python not found. Downloading installer...

set "temp_installer=%TEMP%\python_installer.exe"
curl -o "%temp_installer%" https://www.python.org/ftp/python/3.12.3/python-3.12.3-amd64.exe

if exist "%temp_installer%" (
    echo [INFO] Installing Python... (may prompt for UAC)...
    start /wait "" "%temp_installer%" /quiet InstallAllUsers=1 PrependPath=1 Include_test=0
) else (
    echo [ERROR] Failed to download Python installer.
    exit /b 1
)

set "retries=30"
set /a count=0

:check_python
if exist "%python_exe%" (
    echo [SUCCESS] Python installed at "%python_exe%"
    goto :done
)
timeout /t 2 >nul
set /a count+=1
if %count% LSS %retries% goto :check_python

echo [FAIL] Python install timed out or failed.
exit /b 1

:done
echo [INFO] Python is ready.
echo [INFO] Restarting terminal...
start "" cmd /k ""%runbat%""
exit /b
endlocal
exit /b 0
