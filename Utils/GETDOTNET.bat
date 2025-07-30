@echo off
setlocal

set "runbat=%~dp0..\Run.bat"

set "sdk_path=%ProgramFiles%\dotnet\sdk"
if exist "%sdk_path%" (
    goto :install
)

echo [INFO] .NET SDK not found. Downloading installer...

set "installer_name=%TEMP%\dotnet-sdk-8.0.412-win-x64.exe"
set "dotnet_installer_url=https://builds.dotnet.microsoft.com/dotnet/Sdk/8.0.412/dotnet-sdk-8.0.412-win-x64.exe"

curl -L -o "%installer_name%" "%dotnet_installer_url%"

if not exist "%installer_name%" (
    echo [ERROR] Failed to download .NET SDK installer.
    exit /b 1
)

echo [INFO] Installing .NET SDK... (may prompt for UAC)...
start /wait "" "%installer_name%" /install /quiet /norestart

set "retries=30"
set /a count=0

:check_dotnet
if exist "%sdk_path%" (
    echo [SUCCESS] .NET SDK installed successfully!
    del "%installer_name%"
    goto :done
)else (
	cls
	echo [INFO] Installing .NET SDK... (may prompt for UAC)...
	set "line="

	for /L %%i in (1,1,%count%) do (
		set "line=!line!*"
	)

	echo Progress: !line!
)

timeout /t 2 >nul
set /a count+=1
if %count% LSS %retries% goto :check_dotnet

echo [FAIL] .NET SDK install timed out or failed.
exit /b 1

:done
echo [INFO] .NET is ready.
start "" cmd /k ""%runbat%""
exit /b 123

:install
exit /b 0
endlocal
