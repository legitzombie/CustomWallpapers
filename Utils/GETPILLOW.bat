@echo off
setlocal

:: Check if Pillow is already installed
pip show Pillow >nul 2>&1
if %errorlevel%==0 (
    goto :end
)

echo [INFO] Installing Pillow...
pip install Pillow >nul 2>&1
if %errorlevel%==0 (
    echo [SUCCESS] Pillow installed.
) else (
    echo [ERROR] Pillow installation failed. Try manually: pip install Pillow
)

:end
exit /b
