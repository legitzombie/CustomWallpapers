@echo off
setlocal enabledelayedexpansion

set "script_path=%~dp0"
set "targetMod=CustomWallpapers.archive"

set "defaultSteamPath=%ProgramFiles(x86)%\Steam"
set "libraryFoldersFile=%defaultSteamPath%\steamapps\libraryfolders.vdf"

call :checkFolder "%defaultSteamPath%"
if !errorlevel! == 0 goto :found

if not exist "%libraryFoldersFile%" (
    echo [ERROR] Cannot find Steam library...
    pause
    exit /b 1
)

for /f "usebackq tokens=*" %%l in ("%libraryFoldersFile%") do (
    set "line=%%l"
    echo !line! | findstr /i "\"path\"" >nul
    if !errorlevel! == 0 (
        for /f "tokens=2 delims=	" %%a in ("!line!") do (
            set "libPath=%%~a"
            set "libPath=!libPath:"=!"
            set "libPath=!libPath:\\=\!"
            call :checkFolder "!libPath!"
            if !errorlevel! == 0 goto :found
        )
    )
)

echo [ERROR] Cyberpunk 2077 installation not found.
pause
exit /b 1

:checkFolder
set "gamePath=%~1\steamapps\common\Cyberpunk 2077"
set "mod_folder=!gamePath!\archive\pc\mod"

if exist "!gamePath!\bin\x64\Cyberpunk2077.exe" (
    if exist "!mod_folder!\%targetMod%" (
        del /f /q "!mod_folder!\%targetMod%"
        echo [SUCCESS] Deleted %targetMod% from !mod_folder!
    ) else (
        echo [SUCCESS?] Mod %targetMod% not found in !mod_folder!
    )
    exit /b 0
)
exit /b 1

:found
pause
exit /b 0
