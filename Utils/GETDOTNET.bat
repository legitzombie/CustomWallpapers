@echo off
setlocal enabledelayedexpansion

:: Check if SDK is already installed
dotnet --list-sdks >nul 2>nul
if not errorlevel 1 (
    echo [INFO] .NET SDK is already installed.
    exit /b 0
)

echo [INFO] .NET SDK not found. Attempting to download and install...

set "dotnet_version=8.0"
set "dotnet_installer_url=https://dotnet.microsoft.com/en-us/download/dotnet/thank-you/sdk-8.0.412-windows-x64-installer"
set "installer_name=dotnet-sdk-8.0.412-win-x64.exe"

echo [INFO] Downloading .NET SDK installer...
curl -L -o "%installer_name%" "%dotnet_installer_url%"

:: Check file size
if not exist "%installer_name%" (
    echo [ERROR] Failed to download SDK installer.
    exit /b 1
)
for %%I in ("%installer_name%") do set "filesize=%%~zI"
if !filesize! lss 1024 (
    echo [ERROR] Downloaded file is too small (!filesize! bytes). Likely corrupted.
    del "%installer_name%"
    exit /b 1
)

echo [INFO] Running .NET SDK installer (may prompt for UAC)...
start /wait "" "%installer_name%" /install /quiet /norestart

:: Wait and retry until dotnet appears
set "max_retries=30"
set "retry_count=0"

:wait_for_sdk
timeout /t 2 >nul
dotnet --list-sdks >nul 2>nul
if not errorlevel 1 (
    echo [SUCCESS] .NET SDK installed successfully!
    del "%installer_name%"
	echo [INFO] Restarting terminal...
	start "" cmd /k ""%runbat%""
	exit /b
)

set /a retry_count+=1
if !retry_count! lss !max_retries! (
    goto wait_for_sdk
)

echo [ERROR] .NET SDK install failed or timed out after %max_retries% tries.
exit /b 1
