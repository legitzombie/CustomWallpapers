@echo off
setlocal enabledelayedexpansion

dotnet --list-sdks >nul 2>nul
if not errorlevel 1 (
    exit /b 0
)

echo [INFO] .NET SDK not found. Attempting to download and install...

set "dotnet_version=8.0"
set "dotnet_installer_url=https://download.visualstudio.microsoft.com/download/pr/2e6ec747-04b2-47b8-bbb5-2ac24e6370b7/2c64a7c64824d94a22f254f7cdb06fd2/dotnet-sdk-8.0.412-win-x64.exe"
set "installer_name=dotnet-sdk-8.0.412-win-x64.exe"

echo [INFO] Downloading .NET SDK installer...
curl -L "%dotnet_installer_url%" -o "%installer_name%"

if not exist "%installer_name%" (
    echo [ERROR] Failed to download SDK installer.
    exit /b 1
)

echo [INFO] Installing .NET SDK silently...
start /wait "" "%installer_name%" /install /quiet /norestart

set "max_retries=30"
set "retry_count=0"

:wait_for_sdk
timeout /t 2 >nul
dotnet --list-sdks >nul 2>nul
if not errorlevel 1 (
    echo [SUCCESS] .NET SDK installed successfully!
    del "%installer_name%"
    exit /b 0
)

set /a retry_count+=1
if !retry_count! lss !max_retries! (
    goto wait_for_sdk
)

echo [ERROR] .NET SDK install failed or timed out.
exit /b 1

endlocal
