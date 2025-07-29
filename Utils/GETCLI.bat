@echo off
setlocal

set "cli_path=%USERPROFILE%\.dotnet\tools\cp77tools.exe"


if not exist "%cli_path%" (
	echo [INFO] Installing wolvenkit...

    dotnet tool install -g wolvenkit.cli
)

endlocal