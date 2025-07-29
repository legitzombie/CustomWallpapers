@echo off
setlocal

color 0D

call Utils/GETREDIST.bat

call Utils/GETDOTNET.bat

call Utils/GETPYTHON.bat

call Utils/GETPIP.bat

call Utils/GETPILLOW.bat

call Utils/GETCLI.bat

call Utils/CREATEFOLDERS.bat

call Utils/RENAMEWALLPAPERS.bat

call Utils/GETATLASGENERATOR.bat

python.exe Utils/generate_inkatlas.py

call Utils/JSON2INKATLAS.bat

call Utils/PNG2XBM.bat 

call Utils/ARCHIVE.bat

call Utils/CLEANUP.bat

call Utils/FINDGAME.bat

endlocal