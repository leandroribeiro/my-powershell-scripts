@ECHO OFF
 
REM Make sure this batch file is being run with Windows XP
VER | FINDSTR /L "5.1." > NUL
IF %ERRORLEVEL% NEQ 0 ECHO It appears that you're not using Windows XP, so this batch file will exit now.&GOTO EOF
 
REM See if PowerShell is installed
FOR /F "tokens=3" %%A IN ('REG QUERY "HKLM\SOFTWARE\Microsoft\PowerShell\1" /v Install ^| FIND "Install"') DO SET PowerShellInstalled=%%A
CLS
 
IF NOT "%PowerShellInstalled%"=="0x1" ECHO PowerShell doesn't appear to be installed.&GOTO CheckPrerequisites
 
REM PowerShell is installed, so now see which version it is
FOR /F "tokens=3" %%A IN ('REG QUERY "HKLM\SOFTWARE\Microsoft\PowerShell\1\PowerShellEngine" /v PowerShellVersion ^| FIND "PowerShellVersion"') DO SET PowerShellVersion=%%A
CLS
 
IF "%PowerShellVersion%"=="" (
 ECHO PowerShell appears to be installed, but the version number was unable to be
 ECHO determined.
 GOTO CheckPrerequisites
)
 
ECHO PowerShell %PowerShellVersion% appears to be installed.
IF %PowerShellVersion%==2.0 GOTO EOF
 
:CheckPrerequisites
ECHO.
ECHO Version 2 will now be installed.
ECHO.
 
REM Make sure service pack 3 for Windows is installed
REG QUERY "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion" /v CSDVersion | FIND "Service Pack 3" > NUL
IF %ERRORLEVEL% EQU 0 GOTO CheckNETFramework2SP
CLS
 
ECHO It appears that you're using Windows XP, but without service pack 3. Please
ECHO install service pack 3 and then run this batch file again.
ECHO.
GOTO EOF
 
:CheckNETFramework2SP
REM Service pack 3 for Windows is installed, so now make sure .NET Framework 2.0 (at least SP1) is installed
FOR /F "tokens=3" %%A IN ('REG QUERY "HKLM\SOFTWARE\Microsoft\NET Framework Setup\NDP\v2.0.50727" /v SP ^| FIND "SP"') DO SET NETFramework2SP=%%A
CLS
 
IF NOT "%NETFramework2SP%"=="" IF NOT "%NETFramework2SP%"=="0x0" GOTO InstallPowerShell2
 
ECHO Installing .NET Framework 2.0 SP1...
START "" /WAIT NetFx20SP1_x86.exe /q /norestart
ECHO.
 
:InstallPowerShell2
ECHO Installing PowerShell 2.0...
START "" /WAIT WindowsXP-KB968930-x86-ENG.exe /quiet /passive /norestart
 
:EOF