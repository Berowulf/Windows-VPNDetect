set interface1="Ethernet 8"
cls
TITLE VPN Detect by RootPrivacy.com
@Echo Off
color 31
::Script created and maintained by RootPrivacy.com
:: RELEASE 1.5 (Last Edited 11/28/18)
::Currently only working with WiFi Connections (atleast the auto disconnect)
::Full warning: Drive letters and locations can and will SERIOUSLY fuck with this script,
::When I was attempting to run on USB it just had an infinate loop at the check permissions screen. 
::So, if you run into issues, you'll have to modify the script for your system.
:check_Permissions
echo This script has many different functions which requires it to be run as Administrator for it to work.
echo We will attempt to do this for you, however you may need to do it manually.
echo If you do not know your password, you can manually run as administrator from %USERPROFILE%\detect.cmd
echo. 
echo Press any key to continue.
pause >nul

net session >nul 2>nul
if %errorLevel% == 0 (
    echo Success: Administrative permissions confirmed.
	ECHO.
) else (
    echo Failure: Current permissions inadequate. We will try to restart with admin, password may be required. 
	echo You may also close the script and attempt to restart it yourself as Administrator.
	ECHO. 
	runas /user:Administrator %~dp0
	goto check_Permissions
)

:start
del %USERPROFILE%\temp1 > nul
del %USERPROFILE%\temp2 > nul
TITLE VPN Detect by RootPrivacy.com
mode con:cols=100 lines=25
color 31
echo Main Menu
echo 1) Start Detector
echo 2) Reconnect Interfaces
set /P MainMenu=""
if "%MainMenu%"=="1" (
goto begin_main
)
if "%MainMenu%"=="2" (
goto enable
)

 



:begin_main
::Alert Download
bitsadmin /transfer n 158.69.62.13/detect.wav "C:\WINDOWS\Media\detect-alert.wav" > nul
::Quick Start
C:
cd %USERPROFILE%
::
echo Are you currently connected to your VPN?
set /P Main="(Y/N)"
if "%Main%"=="N" (
goto Disconnect_Assumed
)
if "%Main%"=="Y" (
goto Connect_Assumed
)

:Connect_Assumed
curl -s https://api.ipify.org > %USERPROFILE%/temp1.txt
set /p vpn=<%USERPROFILE%/temp1.txt
curl -s https://api.ipify.org > %USERPROFILE%/temp2.txt
set /p vpncheck=<%USERPROFILE%/temp2.txt
mode con:cols=40 lines=5
:refresh_02
curl -s https://api.ipify.org > %USERPROFILE%/temp2.txt
set /p vpncheck=<%USERPROFILE%/temp2.txt
if "%vpncheck%" == "%vpn%" (
 cls
 echo VPN Connected!
 echo Current Detected IP:
 type temp2.txt
 timeout 3 >nul 2>nul
 goto refresh_02
)
if not "%vpncheck%" == "%vpn%" (
goto unprotected

) 


:Disconnect_Assumed
curl -s https://api.ipify.org > %USERPROFILE%/temp1.txt
set /p localhost=<%USERPROFILE%/temp1.txt
echo Current IP Address:
type temp1.txt
echo .
echo Please connect to VPN
echo Press enter to continue
pause >nul
mode con:cols=40 lines=5
:refresh_01
curl -s https://api.ipify.org > %USERPROFILE%/temp2.txt
set /p ip=<%USERPROFILE%/temp2.txt
if not "%ip%" == "%localhost%" (
 cls
 echo VPN Connected!
 echo Current Detected IP:
 type temp2.txt
 timeout 3 >nul 2>nul
goto refresh_01
)

if "%ip%" == "%localhost%" (
 goto unprotected
 )
 
:unprotected
 del %USERPROFILE%\temp1 > nul
 del %USERPROFILE%\temp2 > nul
 mode con:cols=100 lines=25
 TITLE VPN CONNECTION LOST!
 cls
 color 4
 echo YOU ARE NOT PROTECTED!
 powershell -c (New-Object Media.SoundPlayer "C:\Windows\Media\detect-alert.wav").PlaySync();
 
 ::Network disable 
 ::Looped Disconnect
  netsh wlan disconnect > nul 2>nul
 ::Interface disable  
  netsh interface set interface ""%interface1%"" admin=disable > nul
 
 echo For your security we have disconnected your WiFI networks. 
 timeout 1 >nul

CHOICE /C YN /N /T 4 /D N /M "Are you ready to continue? (Y/N)"
 if "%ERRORLEVEL%" == "2" (
 goto unprotected
 )
 
 
 
 if "%ERRORLEVEL%" == "1" (
 echo Are you ready to enable the interfaces? (Y/N)
 set /P QUESTION=""
 if "%QUESTION%" == "Y" (
      goto enable
	 )
 )
 :enable
	del %USERPROFILE%\temp1.txt > nul
	del %USERPROFILE%\temp2 >.txt nul
	echo Connecting Interfaces...
      netsh interface set interface ""%interface1%"" admin=enable > nul
	  goto startset interface1="Ethernet 8"
cls
TITLE VPN Detect by RootPrivacy.com
@Echo Off
color 31
::Script created and maintained by RootPrivacy.com
:: RELEASE 1.5 (Last Edited 11/28/18)
::Currently only working with WiFi Connections (atleast the auto disconnect)
::Full warning: Drive letters and locations can and will SERIOUSLY fuck with this script,
::When I was attempting to run on USB it just had an infinate loop at the check permissions screen. 
::So, if you run into issues, you'll have to modify the script for your system.
:check_Permissions
echo This script has many different functions which requires it to be run as Administrator for it to work.
echo We will attempt to do this for you, however you may need to do it manually.
echo If you do not know your password, you can manually run as administrator from %USERPROFILE%\detect.cmd
echo. 
echo Press any key to continue.
pause >nul

net session >nul 2>nul
if %errorLevel% == 0 (
    echo Success: Administrative permissions confirmed.
	ECHO.
) else (
    echo Failure: Current permissions inadequate. We will try to restart with admin, password may be required. 
	echo You may also close the script and attempt to restart it yourself as Administrator.
	ECHO. 
	runas /user:Administrator %~dp0
	goto check_Permissions
)

:start
del %USERPROFILE%\temp1 > nul
del %USERPROFILE%\temp2 > nul
TITLE VPN Detect by RootPrivacy.com
mode con:cols=100 lines=25
color 31
echo Main Menu
echo 1) Start Detector
echo 2) Reconnect Interfaces
set /P MainMenu=""
if "%MainMenu%"=="1" (
goto begin_main
)
if "%MainMenu%"=="2" (
goto enable
)

 



:begin_main
::Alert Download
bitsadmin /transfer n 158.69.62.13/detect.wav "C:\WINDOWS\Media\detect-alert.wav" > nul
::Quick Start
C:
cd %USERPROFILE%
::
echo Are you currently connected to your VPN?
set /P Main="(Y/N)"
if "%Main%"=="N" (
goto Disconnect_Assumed
)
if "%Main%"=="Y" (
goto Connect_Assumed
)

:Connect_Assumed
curl -s https://api.ipify.org > %USERPROFILE%/temp1.txt
set /p vpn=<%USERPROFILE%/temp1.txt
curl -s https://api.ipify.org > %USERPROFILE%/temp2.txt
set /p vpncheck=<%USERPROFILE%/temp2.txt
mode con:cols=40 lines=5
:refresh_02
curl -s https://api.ipify.org > %USERPROFILE%/temp2.txt
set /p vpncheck=<%USERPROFILE%/temp2.txt
if "%vpncheck%" == "%vpn%" (
 cls
 echo VPN Connected!
 echo Current Detected IP:
 type temp2.txt
 timeout 3 >nul 2>nul
 goto refresh_02
)
if not "%vpncheck%" == "%vpn%" (
goto unprotected

) 


:Disconnect_Assumed
curl -s https://api.ipify.org > %USERPROFILE%/temp1.txt
set /p localhost=<%USERPROFILE%/temp1.txt
echo Current IP Address:
type temp1.txt
echo .
echo Please connect to VPN
echo Press enter to continue
pause >nul
mode con:cols=40 lines=5
:refresh_01
curl -s https://api.ipify.org > %USERPROFILE%/temp2.txt
set /p ip=<%USERPROFILE%/temp2.txt
if not "%ip%" == "%localhost%" (
 cls
 echo VPN Connected!
 echo Current Detected IP:
 type temp2.txt
 timeout 3 >nul 2>nul
goto refresh_01
)

if "%ip%" == "%localhost%" (
 goto unprotected
 )
 
:unprotected
 del %USERPROFILE%\temp1 > nul
 del %USERPROFILE%\temp2 > nul
 mode con:cols=100 lines=25
 TITLE VPN CONNECTION LOST!
 cls
 color 4
 echo YOU ARE NOT PROTECTED!
 powershell -c (New-Object Media.SoundPlayer "C:\Windows\Media\detect-alert.wav").PlaySync();
 
 ::Network disable 
 ::Looped Disconnect
  netsh wlan disconnect > nul 2>nul
 ::Interface disable  
  netsh interface set interface ""%interface1%"" admin=disable > nul
 
 echo For your security we have disconnected your WiFI networks. 
 timeout 1 >nul

CHOICE /C YN /N /T 4 /D N /M "Are you ready to continue? (Y/N)"
 if "%ERRORLEVEL%" == "2" (
 goto unprotected
 )
 
 
 
 if "%ERRORLEVEL%" == "1" (
 echo Are you ready to enable the interfaces? (Y/N)
 set /P QUESTION=""
 if "%QUESTION%" == "Y" (
      goto enable
	 )
 )
 :enable
	del %USERPROFILE%\temp1.txt > nul
	del %USERPROFILE%\temp2 >.txt nul
	echo Connecting Interfaces...
      netsh interface set interface ""%interface1%"" admin=enable > nul
	  goto startcls
TITLE VPN Detect by RootPrivacy.com
@Echo Off
color 31
::Script created and maintained by RootPrivacy.com
:: RELEASE 1.5 (Last Edited 11/28/18)
::Currently only working with WiFi Connections (atleast the auto disconnect)
::Full warning: Drive letters and locations can and will SERIOUSLY fuck with this script,
::When I was attempting to run on USB it just had an infinate loop at the check permissions screen. 
::So, if you run into issues, you'll have to modify the script for your system.
:check_Permissions
echo This script has many different functions which requires it to be run as Administrator for it to work.
echo We will attempt to do this for you, however you may need to do it manually.
echo If you do not know your password, you can manually run as administrator from %USERPROFILE%\detect.cmd
echo. 
echo Press any key to continue.
pause >nul

net session >nul 2>nul
if %errorLevel% == 0 (
    echo Success: Administrative permissions confirmed.
	ECHO.
) else (
    echo Failure: Current permissions inadequate. We will try to restart with admin, password may be required. 
	echo You may also close the script and attempt to restart it yourself as Administrator.
	ECHO. 
	runas /user:Administrator %~dp0
	goto check_Permissions
)

:start
del %USERPROFILE%\temp1 > nul
del %USERPROFILE%\temp2 > nul
TITLE VPN Detect by RootPrivacy.com
mode con:cols=100 lines=25
color 31
echo Main Menu
echo 1) Start Detector
echo 2) Reconnect Interfaces
set /P MainMenu=""
if "%MainMenu%"=="1" (
goto begin_main
)
if "%MainMenu%"=="2" (
goto enable
)

 



:begin_main
::Alert Download
bitsadmin /transfer n 158.69.62.13/detect.wav "C:\WINDOWS\Media\detect-alert.wav" > nul
::Quick Start
C:
cd %USERPROFILE%
::
echo Are you currently connected to your VPN?
set /P Main="(Y/N)"
if "%Main%"=="N" (
goto Disconnect_Assumed
)
if "%Main%"=="Y" (
goto Connect_Assumed
)

:Connect_Assumed
curl -s https://api.ipify.org > %USERPROFILE%/temp1.txt
set /p vpn=<%USERPROFILE%/temp1.txt
curl -s https://api.ipify.org > %USERPROFILE%/temp2.txt
set /p vpncheck=<%USERPROFILE%/temp2.txt
mode con:cols=40 lines=5
:refresh_02
curl -s https://api.ipify.org > %USERPROFILE%/temp2.txt
set /p vpncheck=<%USERPROFILE%/temp2.txt
if "%vpncheck%" == "%vpn%" (
 cls
 echo VPN Connected!
 echo Current Detected IP:
 type temp2.txt
 timeout 3 >nul 2>nul
 goto refresh_02
)
if not "%vpncheck%" == "%vpn%" (
goto unprotected

) 


:Disconnect_Assumed
curl -s https://api.ipify.org > %USERPROFILE%/temp1.txt
set /p localhost=<%USERPROFILE%/temp1.txt
echo Current IP Address:
type temp1.txt
echo .
echo Please connect to VPN
echo Press enter to continue
pause >nul
mode con:cols=40 lines=5
:refresh_01
curl -s https://api.ipify.org > %USERPROFILE%/temp2.txt
set /p ip=<%USERPROFILE%/temp2.txt
if not "%ip%" == "%localhost%" (
 cls
 echo VPN Connected!
 echo Current Detected IP:
 type temp2.txt
 timeout 3 >nul 2>nul
goto refresh_01
)

if "%ip%" == "%localhost%" (
 goto unprotected
 )
 
:unprotected
 del %USERPROFILE%\temp1 > nul
 del %USERPROFILE%\temp2 > nul
 mode con:cols=100 lines=25
 TITLE VPN CONNECTION LOST!
 cls
 color 4
 echo YOU ARE NOT PROTECTED!
 powershell -c (New-Object Media.SoundPlayer "C:\Windows\Media\detect-alert.wav").PlaySync();
 
 ::Network disable 
 ::Looped Disconnect
  netsh wlan disconnect > nul 2>nul
 ::Interface disable  
  netsh interface set interface ""%interface1%"" admin=disable > nul
 
 echo For your security we have disconnected your WiFI networks. 
 timeout 1 >nul

CHOICE /C YN /N /T 4 /D N /M "Are you ready to continue? (Y/N)"
 if "%ERRORLEVEL%" == "2" (
 goto unprotected
 )
 
 
 
 if "%ERRORLEVEL%" == "1" (
 echo Are you ready to enable the interfaces? (Y/N)
 set /P QUESTION=""
 if "%QUESTION%" == "Y" (
      goto enable
	 )
 )
 :enable
	del %USERPROFILE%\temp1.txt > nul
	del %USERPROFILE%\temp2 >.txt nul
	echo Connecting Interfaces...
      netsh interface set interface ""%interface1%"" admin=enable > nul
	  goto startcls
TITLE VPN Detect by RootPrivacy.com
@Echo Off
color 31
::Script created and maintained by RootPrivacy.com
:: RELEASE 1.5 (Last Edited 11/28/18)
::Currently only working with WiFi Connections (atleast the auto disconnect)
::Full warning: Drive letters and locations can and will SERIOUSLY fuck with this script,
::When I was attempting to run on USB it just had an infinate loop at the check permissions screen. 
::So, if you run into issues, you'll have to modify the script for your system.
:check_Permissions
echo This script has many different functions which requires it to be run as Administrator for it to work.
echo We will attempt to do this for you, however you may need to do it manually.
echo If you do not know your password, you can manually run as administrator from %USERPROFILE%\detect.cmd
echo. 
echo Press any key to continue.
pause >nul

net session >nul 2>nul
if %errorLevel% == 0 (
    echo Success: Administrative permissions confirmed.
	ECHO.
) else (
    echo Failure: Current permissions inadequate. We will try to restart with admin, password may be required. 
	echo You may also close the script and attempt to restart it yourself as Administrator.
	ECHO. 
	runas /user:Administrator %~dp0
	goto check_Permissions
)

:start
del %USERPROFILE%\temp1 > nul
del %USERPROFILE%\temp2 > nul
TITLE VPN Detect by RootPrivacy.com
mode con:cols=100 lines=25
color 31
echo Main Menu
echo 1) Start Detector
echo 2) Reconnect Interfaces
set /P MainMenu=""
if "%MainMenu%"=="1" (
goto begin_main
)
if "%MainMenu%"=="2" (
goto enable
)

 



:begin_main
::Alert Download
bitsadmin /transfer n 158.69.62.13/detect.wav "C:\WINDOWS\Media\detect-alert.wav" > nul
::Quick Start
C:
cd %USERPROFILE%
::
echo Are you currently connected to your VPN?
set /P Main="(Y/N)"
if "%Main%"=="N" (
goto Disconnect_Assumed
)
if "%Main%"=="Y" (
goto Connect_Assumed
)

:Connect_Assumed
curl -s https://api.ipify.org > %USERPROFILE%/temp1.txt
set /p vpn=<%USERPROFILE%/temp1.txt
curl -s https://api.ipify.org > %USERPROFILE%/temp2.txt
set /p vpncheck=<%USERPROFILE%/temp2.txt
mode con:cols=40 lines=5
:refresh_02
curl -s https://api.ipify.org > %USERPROFILE%/temp2.txt
set /p vpncheck=<%USERPROFILE%/temp2.txt
if "%vpncheck%" == "%vpn%" (
 cls
 echo VPN Connected!
 echo Current Detected IP:
 type temp2.txt
 timeout 3 >nul 2>nul
 goto refresh_02
)
if not "%vpncheck%" == "%vpn%" (
goto unprotected

) 


:Disconnect_Assumed
curl -s https://api.ipify.org > %USERPROFILE%/temp1.txt
set /p localhost=<%USERPROFILE%/temp1.txt
echo Current IP Address:
type temp1.txt
echo .
echo Please connect to VPN
echo Press enter to continue
pause >nul
mode con:cols=40 lines=5
:refresh_01
curl -s https://api.ipify.org > %USERPROFILE%/temp2.txt
set /p ip=<%USERPROFILE%/temp2.txt
if not "%ip%" == "%localhost%" (
 cls
 echo VPN Connected!
 echo Current Detected IP:
 type temp2.txt
 timeout 3 >nul 2>nul
goto refresh_01
)

if "%ip%" == "%localhost%" (
 goto unprotected
 )
 
:unprotected
 del %USERPROFILE%\temp1 > nul
 del %USERPROFILE%\temp2 > nul
 mode con:cols=100 lines=25
 TITLE VPN CONNECTION LOST!
 cls
 color 4
 echo YOU ARE NOT PROTECTED!
 powershell -c (New-Object Media.SoundPlayer "C:\Windows\Media\detect-alert.wav").PlaySync();
 
 ::Network disable 
 ::Looped Disconnect
  netsh wlan disconnect > nul 2>nul
 ::Interface disable  
  netsh interface set interface ""%interface1%"" admin=disable > nul
 
 echo For your security we have disconnected your WiFI networks. 
 timeout 1 >nul

CHOICE /C YN /N /T 4 /D N /M "Are you ready to continue? (Y/N)"
 if "%ERRORLEVEL%" == "2" (
 goto unprotected
 )
 
 
 
 if "%ERRORLEVEL%" == "1" (
 echo Are you ready to enable the interfaces? (Y/N)
 set /P QUESTION=""
 if "%QUESTION%" == "Y" (
      goto enable
	 )
 )
 :enable
	del %USERPROFILE%\temp1.txt > nul
	del %USERPROFILE%\temp2 >.txt nul
	echo Connecting Interfaces...
      netsh interface set interface ""%interface1%"" admin=enable > nul
	  goto startcls
TITLE VPN Detect by RootPrivacy.com
@Echo Off
color 31
::Script created and maintained by RootPrivacy.com
:: RELEASE 1.5 (Last Edited 11/28/18)
::Currently only working with WiFi Connections (atleast the auto disconnect)
::Full warning: Drive letters and locations can and will SERIOUSLY fuck with this script,
::When I was attempting to run on USB it just had an infinate loop at the check permissions screen. 
::So, if you run into issues, you'll have to modify the script for your system.
:check_Permissions
echo This script has many different functions which requires it to be run as Administrator for it to work.
echo We will attempt to do this for you, however you may need to do it manually.
echo If you do not know your password, you can manually run as administrator from %USERPROFILE%\detect.cmd
echo. 
echo Press any key to continue.
pause >nul

net session >nul 2>nul
if %errorLevel% == 0 (
    echo Success: Administrative permissions confirmed.
	ECHO.
) else (
    echo Failure: Current permissions inadequate. We will try to restart with admin, password may be required. 
	echo You may also close the script and attempt to restart it yourself as Administrator.
	ECHO. 
	runas /user:Administrator %~dp0
	goto check_Permissions
)

:start
del %USERPROFILE%\temp1 > nul
del %USERPROFILE%\temp2 > nul
TITLE VPN Detect by RootPrivacy.com
mode con:cols=100 lines=25
color 31
echo Main Menu
echo 1) Start Detector
echo 2) Reconnect Interfaces
set /P MainMenu=""
if "%MainMenu%"=="1" (
goto begin_main
)
if "%MainMenu%"=="2" (
goto enable
)

 



:begin_main
::Alert Download
bitsadmin /transfer n 158.69.62.13/detect.wav "C:\WINDOWS\Media\detect-alert.wav" > nul
::Quick Start
C:
cd %USERPROFILE%
::
echo Are you currently connected to your VPN?
set /P Main="(Y/N)"
if "%Main%"=="N" (
goto Disconnect_Assumed
)
if "%Main%"=="Y" (
goto Connect_Assumed
)

:Connect_Assumed
curl -s https://api.ipify.org > %USERPROFILE%/temp1.txt
set /p vpn=<%USERPROFILE%/temp1.txt
curl -s https://api.ipify.org > %USERPROFILE%/temp2.txt
set /p vpncheck=<%USERPROFILE%/temp2.txt
mode con:cols=40 lines=5
:refresh_02
curl -s https://api.ipify.org > %USERPROFILE%/temp2.txt
set /p vpncheck=<%USERPROFILE%/temp2.txt
if "%vpncheck%" == "%vpn%" (
 cls
 echo VPN Connected!
 echo Current Detected IP:
 type temp2.txt
 timeout 3 >nul 2>nul
 goto refresh_02
)
if not "%vpncheck%" == "%vpn%" (
goto unprotected

) 


:Disconnect_Assumed
curl -s https://api.ipify.org > %USERPROFILE%/temp1.txt
set /p localhost=<%USERPROFILE%/temp1.txt
echo Current IP Address:
type temp1.txt
echo .
echo Please connect to VPN
echo Press enter to continue
pause >nul
mode con:cols=40 lines=5
:refresh_01
curl -s https://api.ipify.org > %USERPROFILE%/temp2.txt
set /p ip=<%USERPROFILE%/temp2.txt
if not "%ip%" == "%localhost%" (
 cls
 echo VPN Connected!
 echo Current Detected IP:
 type temp2.txt
 timeout 3 >nul 2>nul
goto refresh_01
)

if "%ip%" == "%localhost%" (
 goto unprotected
 )
 
:unprotected
 del %USERPROFILE%\temp1 > nul
 del %USERPROFILE%\temp2 > nul
 mode con:cols=100 lines=25
 TITLE VPN CONNECTION LOST!
 cls
 color 4
 echo YOU ARE NOT PROTECTED!
 powershell -c (New-Object Media.SoundPlayer "C:\Windows\Media\detect-alert.wav").PlaySync();
 
 ::Network disable 
 ::Looped Disconnect
  netsh wlan disconnect > nul 2>nul
 ::Interface disable  
  netsh interface set interface ""%interface1%"" admin=disable > nul
 
 echo For your security we have disconnected your WiFI networks. 
 timeout 1 >nul

CHOICE /C YN /N /T 4 /D N /M "Are you ready to continue? (Y/N)"
 if "%ERRORLEVEL%" == "2" (
 goto unprotected
 )
 
 
 
 if "%ERRORLEVEL%" == "1" (
 echo Are you ready to enable the interfaces? (Y/N)
 set /P QUESTION=""
 if "%QUESTION%" == "Y" (
      goto enable
	 )
 )
 :enable
	del %USERPROFILE%\temp1.txt > nul
	del %USERPROFILE%\temp2 >.txt nul
	echo Connecting Interfaces...
      netsh interface set interface ""%interface1%"" admin=enable > nul
	  goto startcls
TITLE VPN Detect by RootPrivacy.com
@Echo Off
color 31
::Script created and maintained by RootPrivacy.com
:: RELEASE 1.5 (Last Edited 11/28/18)
::Currently only working with WiFi Connections (atleast the auto disconnect)
::Full warning: Drive letters and locations can and will SERIOUSLY fuck with this script,
::When I was attempting to run on USB it just had an infinate loop at the check permissions screen. 
::So, if you run into issues, you'll have to modify the script for your system.
:check_Permissions
echo This script has many different functions which requires it to be run as Administrator for it to work.
echo We will attempt to do this for you, however you may need to do it manually.
echo If you do not know your password, you can manually run as administrator from %USERPROFILE%\detect.cmd
echo. 
echo Press any key to continue.
pause >nul

net session >nul 2>nul
if %errorLevel% == 0 (
    echo Success: Administrative permissions confirmed.
	ECHO.
) else (
    echo Failure: Current permissions inadequate. We will try to restart with admin, password may be required. 
	echo You may also close the script and attempt to restart it yourself as Administrator.
	ECHO. 
	runas /user:Administrator %~dp0
	goto check_Permissions
)

:start
del %USERPROFILE%\temp1 > nul
del %USERPROFILE%\temp2 > nul
TITLE VPN Detect by RootPrivacy.com
mode con:cols=100 lines=25
color 31
echo Main Menu
echo 1) Start Detector
echo 2) Reconnect Interfaces
set /P MainMenu=""
if "%MainMenu%"=="1" (
goto begin_main
)
if "%MainMenu%"=="2" (
goto enable
)

 



:begin_main
::Alert Download

::Quick Start
C:
cd %USERPROFILE%
::
echo Are you currently connected to your VPN?
set /P Main="(Y/N)"
if "%Main%"=="N" (
goto Disconnect_Assumed
)
if "%Main%"=="Y" (
goto Connect_Assumed
)

:Connect_Assumed
::curl -s https://api.ipify.org > %USERPROFILE%/temp1.txt
powershell -c ($ip = Invoke-RestMethod -Uri 'https://api.ipify.org') > %USERPROFILE%/temp1.txt; 
set /p vpn=<%USERPROFILE%/temp1.txt
::curl -s https://api.ipify.org > %USERPROFILE%/temp2.txt
powershell -c ($ip = Invoke-RestMethod -Uri 'https://api.ipify.org') > %USERPROFILE%/temp2.txt; 
set /p vpncheck=<%USERPROFILE%/temp2.txt
mode con:cols=40 lines=6
:refresh_02
::curl -s https://api.ipify.org > %USERPROFILE%/temp2.txt
powershell -c ($ip = Invoke-RestMethod -Uri 'https://api.ipify.org') > %USERPROFILE%/temp2.txt; 
set /p vpncheck=<%USERPROFILE%/temp2.txt
if "%vpncheck%" == "%vpn%" (
 cls
 echo VPN Connected!
 echo Current Detected IP:
 type temp2.txt
 timeout 3 >nul 2>nul
 goto refresh_02
)
if not "%vpncheck%" == "%vpn%" (
goto unprotected

) 


:Disconnect_Assumed
powershell -c ($ip = Invoke-RestMethod -Uri 'https://api.ipify.org') > %USERPROFILE%/tmp1.txt; 
::curl -s https://api.ipify.org > %USERPROFILE%/temp1.txt
set /p localhost=<%USERPROFILE%/temp1.txt
echo Current IP Address:
type temp1.txt
echo .
echo Please connect to VPN
echo Press enter to continue
pause >nul
mode con:cols=40 lines=6
:refresh_01
::curl -s https://api.ipify.org > %USERPROFILE%/temp2.txt
powershell -c ($ip = Invoke-RestMethod -Uri 'https://api.ipify.org?format=json') > %USERPROFILE%/temp2.txt; 
set /p ip=<%USERPROFILE%/temp2.txt
if not "%ip%" == "%localhost%" (
 cls
 echo VPN Connected!
 echo Current Detected IP:
 type temp2.txt
 timeout 3 >nul 2>nul
goto refresh_01
)

if "%ip%" == "%localhost%" (
 goto unprotected
 )
 
:unprotected
 del %USERPROFILE%\temp1 > nul
 del %USERPROFILE%\temp2 > nul
 mode con:cols=100 lines=25
 TITLE VPN CONNECTION LOST!
 cls
 color 4
 echo YOU ARE NOT PROTECTED!
 powershell -c (New-Object Media.SoundPlayer "C:\Windows\Media\detect-alert.wav").PlaySync();
 
 ::Network disable 
 ::Looped Disconnect
  netsh wlan disconnect > nul 2>nul
 ::Interface disable  
  netsh interface set interface ""%interface1%"" admin=disable > nul
 
 echo For your security we have disconnected your WiFI networks. 
 timeout 1 >nul

CHOICE /C YN /N /T 4 /D N /M "Are you ready to continue? (Y/N)"
 if "%ERRORLEVEL%" == "2" (
 goto unprotected
 )
 
 
 
 if "%ERRORLEVEL%" == "1" (
 echo Are you ready to enable the interfaces? (Y/N)
 set /P QUESTION=""
 if "%QUESTION%" == "Y" (
      goto enable
	 )
 )
 :enable
	del %USERPROFILE%\temp1.txt > nul
	del %USERPROFILE%\temp2 >.txt nul
	echo Connecting Interfaces...
      netsh interface set interface ""%interface1%"" admin=enable > nul
	  goto startcls
TITLE VPN Detect by RootPrivacy.com
@Echo Off
color 31
::Script created and maintained by RootPrivacy.com
:: RELEASE 1.5 (Last Edited 11/28/18)
::Currently only working with WiFi Connections (atleast the auto disconnect)
::Full warning: Drive letters and locations can and will SERIOUSLY fuck with this script,
::When I was attempting to run on USB it just had an infinate loop at the check permissions screen. 
::So, if you run into issues, you'll have to modify the script for your system.
:check_Permissions
echo This script has many different functions which requires it to be run as Administrator for it to work.
echo We will attempt to do this for you, however you may need to do it manually.
echo If you do not know your password, you can manually run as administrator from %USERPROFILE%\detect.cmd
echo. 
echo Press any key to continue.
pause >nul

net session >nul 2>nul
if %errorLevel% == 0 (
    echo Success: Administrative permissions confirmed.
	ECHO.
) else (
    echo Failure: Current permissions inadequate. We will try to restart with admin, password may be required. 
	echo You may also close the script and attempt to restart it yourself as Administrator.
	ECHO. 
	runas /user:Administrator %~dp0
	goto check_Permissions
)

:start
del %USERPROFILE%\temp1 > nul
del %USERPROFILE%\temp2 > nul
TITLE VPN Detect by RootPrivacy.com
mode con:cols=100 lines=25
color 31
echo Main Menu
echo 1) Start Detector
echo 2) Reconnect Interfaces
set /P MainMenu=""
if "%MainMenu%"=="1" (
goto begin_main
)
if "%MainMenu%"=="2" (
goto enable
)

 



:begin_main
::Alert Download

::Quick Start
C:
cd %USERPROFILE%
::
echo Are you currently connected to your VPN?
set /P Main="(Y/N)"
if "%Main%"=="N" (
goto Disconnect_Assumed
)
if "%Main%"=="Y" (
goto Connect_Assumed
)

:Connect_Assumed
::curl -s https://api.ipify.org > %USERPROFILE%/temp1.txt
powershell -c ($ip = Invoke-RestMethod -Uri 'https://api.ipify.org') > %USERPROFILE%/temp1.txt; 
set /p vpn=<%USERPROFILE%/temp1.txt
::curl -s https://api.ipify.org > %USERPROFILE%/temp2.txt
powershell -c ($ip = Invoke-RestMethod -Uri 'https://api.ipify.org') > %USERPROFILE%/temp2.txt; 
set /p vpncheck=<%USERPROFILE%/temp2.txt
mode con:cols=40 lines=6
:refresh_02
::curl -s https://api.ipify.org > %USERPROFILE%/temp2.txt
powershell -c ($ip = Invoke-RestMethod -Uri 'https://api.ipify.org') > %USERPROFILE%/temp2.txt; 
set /p vpncheck=<%USERPROFILE%/temp2.txt
if "%vpncheck%" == "%vpn%" (
 cls
 echo VPN Connected!
 echo Current Detected IP:
 type temp2.txt
 timeout 3 >nul 2>nul
 goto refresh_02
)
if not "%vpncheck%" == "%vpn%" (
goto unprotected

) 


:Disconnect_Assumed
powershell -c ($ip = Invoke-RestMethod -Uri 'https://api.ipify.org') > %USERPROFILE%/tmp1.txt; 
::curl -s https://api.ipify.org > %USERPROFILE%/temp1.txt
set /p localhost=<%USERPROFILE%/temp1.txt
echo Current IP Address:
type temp1.txt
echo .
echo Please connect to VPN
echo Press enter to continue
pause >nul
mode con:cols=40 lines=6
:refresh_01
::curl -s https://api.ipify.org > %USERPROFILE%/temp2.txt
powershell -c ($ip = Invoke-RestMethod -Uri 'https://api.ipify.org?format=json') > %USERPROFILE%/temp2.txt; 
set /p ip=<%USERPROFILE%/temp2.txt
if not "%ip%" == "%localhost%" (
 cls
 echo VPN Connected!
 echo Current Detected IP:
 type temp2.txt
 timeout 3 >nul 2>nul
goto refresh_01
)

if "%ip%" == "%localhost%" (
 goto unprotected
 )
 
:unprotected
 del %USERPROFILE%\temp1 > nul
 del %USERPROFILE%\temp2 > nul
 mode con:cols=100 lines=25
 TITLE VPN CONNECTION LOST!
 cls
 color 4
 echo YOU ARE NOT PROTECTED!
 powershell -c (New-Object Media.SoundPlayer "C:\Windows\Media\detect-alert.wav").PlaySync();
 
 ::Network disable 
 ::Looped Disconnect
  netsh wlan disconnect > nul 2>nul
 ::Interface disable  
  netsh interface set interface ""%interface1%"" admin=disable > nul
 
 echo For your security we have disconnected your WiFI networks. 
 timeout 1 >nul

CHOICE /C YN /N /T 4 /D N /M "Are you ready to continue? (Y/N)"
 if "%ERRORLEVEL%" == "2" (
 goto unprotected
 )
 
 
 
 if "%ERRORLEVEL%" == "1" (
 echo Are you ready to enable the interfaces? (Y/N)
 set /P QUESTION=""
 if "%QUESTION%" == "Y" (
      goto enable
	 )
 )
 :enable
	del %USERPROFILE%\temp1.txt > nul
	del %USERPROFILE%\temp2 >.txt nul
	echo Connecting Interfaces...
      netsh interface set interface ""%interface1%"" admin=enable > nul
	  goto startcls
TITLE VPN Detect by RootPrivacy.com
@Echo Off
color 31
::Script created and maintained by RootPrivacy.com
:: RELEASE 1.5 (Last Edited 11/28/18)
::Currently only working with WiFi Connections (atleast the auto disconnect)
::Full warning: Drive letters and locations can and will SERIOUSLY fuck with this script,
::When I was attempting to run on USB it just had an infinate loop at the check permissions screen. 
::So, if you run into issues, you'll have to modify the script for your system.
:check_Permissions
echo This script has many different functions which requires it to be run as Administrator for it to work.
echo We will attempt to do this for you, however you may need to do it manually.
echo If you do not know your password, you can manually run as administrator from %USERPROFILE%\detect.cmd
echo. 
echo Press any key to continue.
pause >nul

net session >nul 2>nul
if %errorLevel% == 0 (
    echo Success: Administrative permissions confirmed.
	ECHO.
) else (
    echo Failure: Current permissions inadequate. We will try to restart with admin, password may be required. 
	echo You may also close the script and attempt to restart it yourself as Administrator.
	ECHO. 
	runas /user:Administrator %~dp0
	goto check_Permissions
)

:start
del %USERPROFILE%\temp1 > nul
del %USERPROFILE%\temp2 > nul
TITLE VPN Detect by RootPrivacy.com
mode con:cols=100 lines=25
color 31
echo Main Menu
echo 1) Start Detector
echo 2) Reconnect Interfaces
set /P MainMenu=""
if "%MainMenu%"=="1" (
goto begin_main
)
if "%MainMenu%"=="2" (
goto enable
)

 



:begin_main
::Alert Download

::Quick Start
C:
cd %USERPROFILE%
::
echo Are you currently connected to your VPN?
set /P Main="(Y/N)"
if "%Main%"=="N" (
goto Disconnect_Assumed
)
if "%Main%"=="Y" (
goto Connect_Assumed
)

:Connect_Assumed
::curl -s https://api.ipify.org > %USERPROFILE%/temp1.txt
powershell -c ($ip = Invoke-RestMethod -Uri 'https://api.ipify.org') > %USERPROFILE%/temp1.txt; 
set /p vpn=<%USERPROFILE%/temp1.txt
::curl -s https://api.ipify.org > %USERPROFILE%/temp2.txt
powershell -c ($ip = Invoke-RestMethod -Uri 'https://api.ipify.org') > %USERPROFILE%/temp2.txt; 
set /p vpncheck=<%USERPROFILE%/temp2.txt
mode con:cols=40 lines=6
:refresh_02
::curl -s https://api.ipify.org > %USERPROFILE%/temp2.txt
powershell -c ($ip = Invoke-RestMethod -Uri 'https://api.ipify.org') > %USERPROFILE%/temp2.txt; 
set /p vpncheck=<%USERPROFILE%/temp2.txt
if "%vpncheck%" == "%vpn%" (
 cls
 echo VPN Connected!
 echo Current Detected IP:
 type temp2.txt
 timeout 3 >nul 2>nul
 goto refresh_02
)
if not "%vpncheck%" == "%vpn%" (
goto unprotected

) 


:Disconnect_Assumed
powershell -c ($ip = Invoke-RestMethod -Uri 'https://api.ipify.org') > %USERPROFILE%/tmp1.txt; 
::curl -s https://api.ipify.org > %USERPROFILE%/temp1.txt
set /p localhost=<%USERPROFILE%/temp1.txt
echo Current IP Address:
type temp1.txt
echo .
echo Please connect to VPN
echo Press enter to continue
pause >nul
mode con:cols=40 lines=6
:refresh_01
::curl -s https://api.ipify.org > %USERPROFILE%/temp2.txt
powershell -c ($ip = Invoke-RestMethod -Uri 'https://api.ipify.org?format=json') > %USERPROFILE%/temp2.txt; 
set /p ip=<%USERPROFILE%/temp2.txt
if not "%ip%" == "%localhost%" (
 cls
 echo VPN Connected!
 echo Current Detected IP:
 type temp2.txt
 timeout 3 >nul 2>nul
goto refresh_01
)

if "%ip%" == "%localhost%" (
 goto unprotected
 )
 
:unprotected
 del %USERPROFILE%\temp1 > nul
 del %USERPROFILE%\temp2 > nul
 mode con:cols=100 lines=25
 TITLE VPN CONNECTION LOST!
 cls
 color 4
 echo YOU ARE NOT PROTECTED!
 powershell -c (New-Object Media.SoundPlayer "C:\Windows\Media\detect-alert.wav").PlaySync();
 
 ::Network disable 
 ::Looped Disconnect
  netsh wlan disconnect > nul 2>nul
 ::Interface disable  
  netsh interface set interface ""%interface1%"" admin=disable > nul
 
 echo For your security we have disconnected your WiFI networks. 
 timeout 1 >nul

CHOICE /C YN /N /T 4 /D N /M "Are you ready to continue? (Y/N)"
 if "%ERRORLEVEL%" == "2" (
 goto unprotected
 )
 
 
 
 if "%ERRORLEVEL%" == "1" (
 echo Are you ready to enable the interfaces? (Y/N)
 set /P QUESTION=""
 if "%QUESTION%" == "Y" (
      goto enable
	 )
 )
 :enable
	del %USERPROFILE%\temp1.txt > nul
	del %USERPROFILE%\temp2 >.txt nul
	echo Connecting Interfaces...
      netsh interface set interface ""%interface1%"" admin=enable > nul
	  goto start