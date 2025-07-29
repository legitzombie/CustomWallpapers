@echo off
setlocal


set "inkatlas_generator=generate_inkatlas.py"

if not exist "%inkatlas_generator%" (

	python.exe Utils/modify_generate_inkatlas.py


)

endlocal