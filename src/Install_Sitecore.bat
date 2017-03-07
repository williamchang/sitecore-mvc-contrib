@echo off
setlocal enabledelayedexpansion

:: Install Sitecore

:: Batch Commands:
:: Get directory of batch file : %~dp0
:: Get file name in for-loop : %%~nf
:: Get file name and file type in for-loop : %%~nxf

echo.
echo BEGIN Script
echo.

:: Run operation.
echo.
echo BEGIN Operation
echo.

powershell.exe Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope CurrentUser
powershell.exe -File .\Install_Sitecore.ps1 -ZipFileBaseName "Sitecore 8.2 rev. 161221" -SiteName "site1.com" -DatabasePrefixName "Site1"

echo.
echo END Operation
echo.

:end
echo.
echo END Script
echo.

:: Keep command window open.
pause
