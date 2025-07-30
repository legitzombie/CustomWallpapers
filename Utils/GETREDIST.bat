@echo off
setlocal

reg query "HKLM\SOFTWARE\Microsoft\VisualStudio\14.0\VC\Runtimes\x64" /v Installed >nul 2>&1
if %errorlevel%==0 (
    goto :end
)

echo [INFO] VC++ Redist not found. Downloading latest x64 runtime...

set "vc_redist=%TEMP%\vc_redist.x64.exe"

curl -L -o "%vc_redist%" https://aka.ms/vs/17/release/vc_redist.x64.exe

if exist "%vc_redist%" (
    echo [INFO] Installing Visual C++ Redistributable...  (may prompt for UAC)...
    start /wait "" "%vc_redist%" /quiet InstallAllUsers=1 PrependPath=1 Include_test=0
) else (
    echo [ERROR] Failed to download VC++ redist.
    pause
    exit /b 1
)

reg query "HKLM\SOFTWARE\Microsoft\VisualStudio\14.0\VC\Runtimes\x64" /v Installed >nul 2>&1
if %errorlevel%==0 (
    echo [SUCCESS] Visual C++ Redistributable installed successfully.
) else (
    echo [FAIL] Installation may have failed. Please install manually from Microsoft.
)

:end
exit /b
