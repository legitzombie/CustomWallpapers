@echo off
setlocal

pip --version >nul 2>&1
if %errorlevel%==0 (
    goto :end
)

echo [INFO] pip not found. Downloading pip...

set "temp_pip=%TEMP%\get-pip.py"
curl -o "%temp_pip%" https://bootstrap.pypa.io/get-pip.py

if exist "%temp_pip%" (
    echo [INFO] Installing pip...
    python "%temp_pip%"
) else (
    echo [ERROR] Failed to download get-pip.py
    pause
    exit /b 1
)

echo [INFO] Waiting for pip to install...
timeout /t 5 >nul

pip --version >nul 2>&1
if %errorlevel%==0 (
    echo [SUCCESS] pip installed successfully.
) else (
    echo [FAIL] pip install may have failed. Please install manually.
)

:end
exit /b
