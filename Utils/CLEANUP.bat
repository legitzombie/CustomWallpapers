@echo off
setlocal

set "script_path=%~dp0"
for %%i in ("%script_path%\..") do set "temp_path=%%~fi\temp"

if exist "%temp_path%" (
	rmdir /s /q "%temp_path%"
) 

endlocal