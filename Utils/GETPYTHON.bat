@echo off
setlocal enabledelayedexpansion

set "python_exe=%LOCALAPPDATA%\Programs\Python\Python312\python.exe"
if exist "%python_exe%" (
    exit /b 0
)

echo [INFO] Python not found. Downloading installer...

for %%i in ("%TEMP%\python_installer.exe") do set "temp_installer=%%~fi"
curl -o "%temp_installer%" https://www.python.org/ftp/python/3.12.3/python-3.12.3-amd64.exe


echo [INFO] Installing Python... (may prompt for UAC)...
"%temp_installer%" /quiet InstallAllUsers=1 PrependPath=1 Include_test=0


set "retries=30"
set /a count=0

:check_python
if exist "%python_exe%" (
    echo [SUCCESS] Python installed at "%python_exe%"
    goto :done
)else (
	cls
	echo [INFO] Installing Python... (may prompt for UAC)...
	set "line="

	for /L %%i in (1,1,%count%) do (
		set "line=!line!*"
	)

	echo Progress: !line!
)
timeout /t 2 >nul
set /a count+=1
if !count! LSS !retries! goto :check_python

echo [FAIL] Python install timed out or failed.
exit /b 1

:done
echo [INFO] Python is ready.
start "" cmd /k ""%runbat%""
exit /b 123

endlocal
exit /b 0
