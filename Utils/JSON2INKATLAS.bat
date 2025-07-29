@echo off
setlocal

set "script_path=%~dp0"
set "cli_path=%USERPROFILE%\.dotnet\tools\cp77tools.exe"

for %%i in ("%script_path%\..") do set "wallpaper_path=%%~fi\temp\raw\base\customwallpapers"
for %%i in ("%script_path%\..") do set "temp_path=%%~fi\temp\archive\base\customwallpapers"

set "json_file=%wallpaper_path%\customwallpapers.inkatlas.json"

if exist "%json_file%" (

    %cli_path% convert d "%json_file%"

	for %%F in ("%wallpaper_path%\*") do (
		if /I "%%~nxF"=="customwallpapers.inkatlas" (
			move /Y "%%F" "%temp_path%\%%~nxF"
		)
	)
)

endlocal
