@echo off
setlocal

:: Check if Pillow is already installed
pip show requests >nul 2>&1
if %errorlevel%==0 (
    goto :end
)

echo [INFO] Installing requests...
pip install requests >nul 2>&1
if %errorlevel%==0 (
    echo [SUCCESS] requests installed.
) else (
    echo [ERROR] requests installation failed. Try manually: pip install requests
)

:end
exit /b