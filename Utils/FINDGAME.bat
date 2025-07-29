@echo off
setlocal enabledelayedexpansion

set "script_path=%~dp0"
for %%i in ("%script_path%\..") do set "archive_path=%%~fi\archive\pc\mod"

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

echo [FAIL] Cyberpunk 2077 not found in any Steam library.
echo [FAIL] Move the archive folder to the cyberpunk 2077 folder.
pause
exit /b 1

:checkFolder
set "gamePath=%~1\steamapps\common\Cyberpunk 2077"
if exist "!gamePath!\bin\x64\Cyberpunk2077.exe" (

    set "mod_folder=!gamePath!\archive\pc\mod"

    if not exist "!mod_folder!" (
        mkdir "!mod_folder!"
    )

    xcopy /E /Y /I "%archive_path%\*" "!mod_folder!\" >nul

    echo [INFO] Files copied successfully to !mod_folder!
	echo [SUCCESS] You can now launch the game.
    exit /b 0
)
exit /b 1

:found
pause
exit /b 0

