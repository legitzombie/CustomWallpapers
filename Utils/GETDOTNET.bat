@echo off
setlocal

set "runbat=%~dp0..\Run.bat"

set "sdk_path=%ProgramFiles%\dotnet\sdk"
if exist "%sdk_path%" (
    goto :install
)

echo [INFO] .NET SDK not found. Downloading installer...

set "installer_name=%TEMP%\dotnet-sdk-8.0.412-win-x64.exe"
set "dotnet_installer_url=https://dotnet.microsoft.com/en-us/download/dotnet/thank-you/sdk-8.0.412-windows-x64-installer"

curl -L -o "%installer_name%" "%dotnet_installer_url%"

if not exist "%installer_name%" (
    echo [ERROR] Failed to download .NET SDK installer.
    exit /b 1
)

echo [INFO] Installing .NET SDK... (may prompt for UAC)...
start /wait "" "%installer_name%" /install /quiet /norestart

timeout /t 5 >nul
dotnet --list-sdks >nul 2>nul
if errorlevel 1 (
    echo [SUCCESS] .NET SDK installed successfully!
    del "%installer_name%"
    goto :done
) 

:done
echo [INFO] .NET is ready.
echo [INFO] Restarting terminal and running Run.bat...
start "" cmd /k ""%runbat%""
exit /b

:install
exit /b 0
endlocal
