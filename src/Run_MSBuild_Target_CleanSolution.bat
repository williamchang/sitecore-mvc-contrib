@echo off

:: Microsoft MSBuild

:: Require Microsoft .NET Framework 4.0.30319
:: Target DeployToWebLocal aka Copy Files To Webroot For Internet Information Services (IIS)

echo.
echo BEGIN Script
echo.

:: Declare path.
set ProgramExecutable="%WINDIR%\Microsoft.NET\Framework\v4.0.30319\MSBuild.exe"
echo ProgramExecutable : %ProgramExecutable%

:: Run operation.
echo.
echo BEGIN Operation
echo.

%ProgramExecutable% Sitecore.Files\Build.msbuildproj /t:CleanSolution

echo.
echo END Operation
echo.

:end
echo.
echo END Script
echo.

:: Keep command window open.
pause
