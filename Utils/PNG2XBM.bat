@echo off
setlocal

set "script_path=%~dp0"
set "cli_path=%USERPROFILE%\.dotnet\tools\cp77tools.exe"

for %%i in ("%script_path%\..") do set "wallpaper_path=%%~fi\temp\raw\base\customwallpapers"
for %%i in ("%script_path%\..") do set "temp_path=%%~fi\temp\archive\base\customwallpapers"


echo [INFO] Converting pngs to xbm... This can be a slow process...

%cli_path% import -p %wallpaper_path% -o "%temp_path%"


endlocal