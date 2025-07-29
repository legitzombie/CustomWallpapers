@echo off
setlocal enabledelayedexpansion

:: Check if SDK is already installed
dotnet --list-sdks >nul 2>nul
if not errorlevel 1 (
    exit /b 0
)

echo [INFO] .NET SDK not found. Attempting to download and install...

set "dotnet_version=8.0"
set "dotnet_installer_url=https://builds.dotnet.microsoft.com/dotnet/Sdk/8.0.412/dotnet-sdk-8.0.412-win-x64.exe"
set "installer_name=dotnet-sdk-8.0.412-win-x64.exe"

echo [INFO] Downloading .NET SDK installer...
powershell -Command "Invoke-WebRequest -Uri '%dotnet_installer_url%' -OutFile '%installer_name%'" >nul 2>&1

if not exist "%installer_name%" (
    echo [ERROR] Failed to download SDK installer.
    exit /b 1
)

echo [INFO] Installing .NET SDK silently...
"%installer_name%" /install /quiet /norestart

timeout /t 10 >nul
dotnet --list-sdks >nul 2>nul
if not errorlevel 1 (
    echo [SUCCESS] .NET SDK installed successfully!
    del "%installer_name%"
    exit /b 0
) else (
    echo [ERROR] .NET SDK install failed.
    exit /b 1
)

endlocal
