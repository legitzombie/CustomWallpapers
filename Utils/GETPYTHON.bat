@echo off
setlocal

python --version >nul 2>&1
if %errorlevel%==0 (
    goto :end
)

echo [INFO] Python not found. Downloading...

set "temp_installer=%TEMP%\python_installer.exe"
curl -o "%temp_installer%" https://www.python.org/ftp/python/3.12.3/python-3.12.3-amd64.exe

if exist "%temp_installer%" (
    "%temp_installer%" /quiet InstallAllUsers=1 PrependPath=1 Include_test=0
) else (
    echo [ERROR] Failed to download Python installer.
    pause
    exit /b 1
)

echo [INFO] Installing Python...
timeout /t 10 >nul

python --version >nul 2>&1
if %errorlevel%==0 (
    echo [SUCCESS] Python installed successfully.
) else (
    echo [FAIL] Python install may have failed. Please install manually.
)

:end
exit /b
