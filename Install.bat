@echo off
SETLOCAL EnableDelayedExpansion
for /F "tokens=1,2 delims=#" %%a in ('"prompt #$H#$E# & echo on & for %%b in (1) do     rem"') do (
  set "DEL=%%a"
)

set forgeFileName=forge-1.20.1-47.2.18.jar
set sourcePath=%~dp0
set minecraftPath=%APPDATA%\.minecraft\

echo Do you have Forge installed? y/n
echo.
set /p firstInstall=

if %firstInstall%==n (
	echo.
	call :colorEcho 06 "Installing Forge.."
	echo.
	java -jar "%sourcePath%forge\%forgeFileName%" --installClient "%minecraftPath%\" > nul 2>&1
	echo.
	echo.
	call :colorEcho 0a "Forge installed."
	echo.
)

echo Checking for old mods..
if exist %minecraftPath%mods\ (
	rmdir /s /q %minecraftPath%mods
	echo.
	call :colorEcho 06 "Removing old mods.."
	echo.
)
echo.
echo Checking for old shaders..
if exist %minecraftPath%shaderpacks\ (
	rmdir /s /q %minecraftPath%shaderpacks
	echo.
	call :colorEcho 06 "Removing old shaders.."
	echo.
)
echo.
call :colorEcho 06 "Copying mods."
echo.
robocopy "%sourcePath%mods" "%minecraftPath%mods" /E /LOG:nul
call :colorEcho 06 "Copying shaders."
echo.
robocopy "%sourcePath%shaderpacks" "%minecraftPath%shaderpacks" /E /LOG:nul
echo.
echo.
call :colorEcho 0a "All done."
echo.
echo.
echo.

pause
exit

:colorEcho
echo off
<nul set /p ".=%DEL%" > "%~2"
findstr /v /a:%1 /R "^$" "%~2" nul
del "%~2" > nul 2>&1i