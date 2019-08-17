::Script created and maintained by RootPrivacy.com
:: Release 1.0
::Currently only working with WiFi Connections (atleast the auto disconnect)
::Full warning: Drive letters and locations can and will SERIOUSLY fuck with this script,
::When I was attempting to run on USB it just had an infinate loop at the check permissions screen. 
::So, if you run into issues, you'll have to modify the script for your system.
@ECHO off
cd %CD:~0,3%
mkdir Temporary > nul 2>nul
C:
cd %USERPROFILE%

::update
echo Updating...
bitsadmin /transfer n http://http://github.com/Berowulf/Windows-VPNDetect/detect.cmd "%USERPROFILE%/detect.cmd" > nul
::downloads
::main file(s)
bitsadmin /transfer n http://github.com/Berowulf/Windows-VPNDetect/detect.cmd "%USERPROFILE%/detect.cmd" > nul
::sound files
bitsadmin /transfer n http://github.com/Berowulf/Windows-VPNDetect/intro.wav "%CD:~0,3%Temporary\intro-alert.wav" > nul

::
echo Detector can be run now at any time from %USERPROFILE%\detect.cmd
echo Press any key to continue.
pause >nul
cls
color 31


powershell -c (New-Object Media.SoundPlayer "%CD:~0,3%Temporary\intro-alert.wav").PlaySync();
:start
cls
echo #########################################################
echo #####Hello! Welcome to VPN Detect by RootPrivacy.com#####
echo #########################################################
echo.
echo Main Menu:
echo.
echo 1) Initial Setup(Setting Interface Name)
echo 2) Start detector


CHOICE /C 12 /CS /M "What would you like to do"

if "%ERRORLEVEL%" == "2" (
 cls
 type detect.cmd >> %CD:~0,3%Temporary\tmprequired.cmd
 type %CD:~0,3%Temporary\tmprequired.cmd > detect.cmd
 echo Script requires Administrator Permissions to run correctly.
 echo.
 echo If you do not know your password, you can manually run as administrator from %USERPROFILE%\detect.cmd
 echo.
 ::runas /user:Administrator detect.cmd
 detect.cmd
 goto start
 )
::Initial
if "%ERRORLEVEL%" == "1" (
 goto setinterface
)
 :setinterface
 cls
 echo Here is a list of all your network interfaces...
 timeout 1 > nul
 netsh interface show interface
 timeout 2 > nul
 echo.
 echo Please enter the exact name of your Main Interface
 set /p interface1="Interface Name:"

 (
 @Echo Off
 echo set interface1="%interface1%"
 )> %CD:~0,3%Temporary\tmprequired.cmd
 type detect.cmd >> %CD:~0,3%Temporary\tmprequired.cmd
 type %CD:~0,3%Temporary\tmprequired.cmd > detect.cmd

 echo.
 goto start
 

 
 


