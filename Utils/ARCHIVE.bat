@echo off
setlocal

set "script_path=%~dp0"
set "cli_path=%USERPROFILE%\.dotnet\tools\cp77tools.exe"

for %%i in ("%script_path%\..") do set "output_path=%%~fi"
for %%i in ("%script_path%\..") do set "archive_path=%%~fi/temp/archive"
for %%i in ("%script_path%\..") do set "perm_path=%%~fi/archive/pc/mod"


for %%i in ("%script_path%\..") do set "wallpaper_path=%%~fi\temp\raw"
for %%i in ("%script_path%\..") do set "temp_path=%%~fi\temp\archive\base\customwallpapers"

%cli_path% pack -p %archive_path% -o %perm_path%

rename "%perm_path%\archive.archive" "CustomWallpapers.archive"

endlocal