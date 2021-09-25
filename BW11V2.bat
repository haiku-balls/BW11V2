@echo off
SETLOCAL EnableDelayedExpansion
for /F "tokens=1,2 delims=#" %%a in ('"prompt #$H#$E# & echo on & for %%b in (1) do     rem"') do (
  set "DEL=%%a"
)

:: BatchGotAdmin
:-------------------------------------
REM  --> Check for permissions
    IF "%PROCESSOR_ARCHITECTURE%" EQU "amd64" (
>nul 2>&1 "%SYSTEMROOT%\SysWOW64\cacls.exe" "%SYSTEMROOT%\SysWOW64\config\system"
) ELSE (
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"
)

REM --> If error flag set, we do not have admin.
if '%errorlevel%' NEQ '0' (
    echo Requesting administrative privileges...
    goto UACPrompt
) else ( goto gotAdmin )

:UACPrompt
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
    set params= %*
    echo UAC.ShellExecute "cmd.exe", "/c ""%~s0"" %params:"=""%", "", "runas", 1 >> "%temp%\getadmin.vbs"

    "%temp%\getadmin.vbs"
    del "%temp%\getadmin.vbs"
    exit /B

:gotAdmin
    pushd "%CD%"
    CD /D "%~dp0"
:--------------------------------------
cls
title BW11V2
echo [35m-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
echo Bypass Windows 11 Version 2 (BW11V2)
echo By Baka - Second Release
echo -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
echo [37mBypasses the Windows 11 Update Checks && echo.
echo Press any key to continue.
pause > nul
cls
call :colorEcho 40 "Microsoft recommends not doing this. You've been warned" && echo.
echo This script is intended if you're attempting to upgrade your build or to Windows 11 using the settings app.
echo If so, upgrade normal, once the setup appears and it reports that you're not compatible. Close the setup.
echo.
echo Then press any key to continue.
pause > nul
xcopy appraiserres.dll C:\$WINDOWS.~BT\Sources /Y
cls
echo Now, press "Fix issues" or "Try again" in windows update. When the setup re-appears, it won't prevent you from upgrading.
echo Make sure to do this everytime you want to update or upgrade. :) && echo.
echo Press any key to exit.
pause > nul
exit
:colorEcho
echo off
<nul set /p ".=%DEL%" > "%~2"
findstr /v /a:%1 /R "^$" "%~2" nul
del "%~2" > nul 2>&1i
