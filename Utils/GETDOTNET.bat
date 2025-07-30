@echo off
setlocal enabledelayedexpansion

set "runbat=%~dp0..\Run.bat"

set "sdk_path=%ProgramFiles%\dotnet\sdk"
if exist "%sdk_path%" (
    exit /b 0
)

echo [INFO] .NET SDK not found. Downloading installer...

for %%i in ("%TEMP%\dotnet-sdk-8.0.412-win-x64.exe") do set "installer_name=%%~fi"
set "dotnet_installer_url=https://builds.dotnet.microsoft.com/dotnet/Sdk/8.0.412/dotnet-sdk-8.0.412-win-x64.exe"

curl -L -o "%installer_name%" "%dotnet_installer_url%"

if not exist "%installer_name%" (
    echo [ERROR] Failed to download .NET SDK installer.
    exit /b 1
)

echo [INFO] Installing .NET SDK... (may prompt for UAC)...
"%installer_name%" /install /quiet /norestart

echo [SUCCESS] .NET SDK installed successfully!
del "%installer_name%"
goto :done

:done
echo [INFO] .NET is ready.
start "" cmd /k ""%runbat%""
exit /b 123

exit /b 0
endlocal
