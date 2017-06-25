@echo off
cls
setlocal enabledelayedexpansion
Color 0A
cls
title MOD Downloader - Wip v4 - A Stable PoC
set nag="Welcome To The Wip v4 - A Stable PoC"

if not exist .\bin\ mkdir .\bin\

:MENU

cls

if exist mod_list.txt del mod_list.txt
if not exist .\bin\wget.exe call :Download-Wget
.\bin\wget.exe -q --show-progress https://raw.githubusercontent.com/MarioMasta64/ModDownloaderPortable/master/mod_list.txt
if not exist mod_list.txt goto OFFLINE

cls
echo %nag%
call :Get-Mod-Info
For /L %%C in (1,1,%Counter%) Do (echo %%C. !mod-title_%%C! & set max-mod=%%C)
del mod_list.txt
set /p mod="choose a mod: "
:: if "%mod%"=="menu" exit /b 2
set /a "mod=%mod%"
if "%mod%"=="" set nag="please choose a choice between 1-%max-mod%" & goto MENU
if "%mod%" LSS "1" set nag="please choose a choice between 1-%max-mod%" & goto MENU
if "%mod%" GTR "%max-mod%" set nag="please choose a choice between 1-%max-mod%" & goto MENU

cls
echo !mod-title_%mod%!
:: .\bin\wget.exe !mod-link_%mod%!
echo !mod-link_%mod%!
:: set file=!mod-filename_%mod%!
echo !mod-filename_%mod%!
:: if "!mod-rename-to_%mod%!" NEQ "-" rename "%file%" "!mod-rename-to_%mod%!"
echo !mod-rename-to_%mod%!
:: if "!mod-action_%mod%!" EQU "move-file" move !mod-rename-to_%mod%! !mod-folder_%mod%!!mod-rename-to_%mod%!
:: if "!mod-action_%mod%!" EQU "extract-zip" <insert command to extract !mod-rename-to_%mod%! to !mod-folder_%mod%!!mod-rename-to_%mod%!>
echo !mod-folder_%mod%!
:: just for additional info
echo !mod-website_%mod%!
:: mod action to take extract-zip and move-file will be added soon
echo !mod-action_%mod%!
:: Free Space 1
echo !mod-null1_%mod%!
:: Free Space 2
echo !mod-null2_%mod%!
:: Free Space 3
echo !mod-null3_%mod%!
pause

cls

if exist "!mod-filename_%mod%!" del "!mod-filename_%mod%!"
.\bin\wget.exe -q --show-progress "!mod-link_%mod%!"

if "!mod-rename-to_%mod%!" NEQ "-" rename "!mod-filename_%mod%!" "!mod-rename-to_%mod%!" & set "file=!mod-rename-to_%mod%!"
if "!mod-rename-to_%mod%!" EQU "-" set "file=!mod-filename_%mod%!"
if "!mod-action_%mod%!" EQU "move-to" if not exist "!mod-folder_%mod%!" mkdir "!mod-folder_%mod%!"
if "!mod-action_%mod%!" EQU "move-to" move "%file%" "!mod-folder_%mod%!%file%"
if "!mod-action_%mod%!" EQU "extract-zip" call :Extract-Zip & del "%file%"

pause

goto MENU

########################################################################

:Extract-Zip
cls
set folder=%CD%
if %CD%==%~d0\ set folder=%CD:~0,2%
echo. > .\bin\extractmod.vbs
echo 'The location of the zip file. >> .\bin\extractmod.vbs
echo ZipFile="%CD%\%file%" >> .\bin\extractmod.vbs
echo 'The folder the contents should be extracted to. >> .\bin\extractmod.vbs
echo ExtractTo="%CD%\!mod-folder_%mod%!" >> .\bin\extractmod.vbs
echo. >> .\bin\extractmod.vbs
echo 'If the extraction location does not exist create it. >> .\bin\extractmod.vbs
echo Set fso = CreateObject("Scripting.FileSystemObject") >> .\bin\extractmod.vbs
echo If NOT fso.FolderExists(ExtractTo) Then >> .\bin\extractmod.vbs
echo    fso.CreateFolder(ExtractTo) >> .\bin\extractmod.vbs
echo End If >> .\bin\extractmod.vbs
echo. >> .\bin\extractmod.vbs
echo 'Extract the contants of the zip file. >> .\bin\extractmod.vbs
echo set objShell = CreateObject("Shell.Application") >> .\bin\extractmod.vbs
echo set FilesInZip=objShell.NameSpace(ZipFile).items >> .\bin\extractmod.vbs
echo objShell.NameSpace(ExtractTo).CopyHere(FilesInZip) >> .\bin\extractmod.vbs
echo Set fso = Nothing >> .\bin\extractmod.vbs
echo Set objShell = Nothing >> .\bin\extractmod.vbs
echo. >> .\bin\extractmod.vbs
cscript .\bin\extractmod.vbs
del .\bin\extractmod.vbs
(goto) 2>nul

########################################################################

:Download-Wget
cls
echo ' Set your settings > .\bin\downloadwget.vbs
echo    strFileURL = "https://eternallybored.org/misc/wget/current/wget.exe" >> .\bin\downloadwget.vbs
echo    strHDLocation = "wget.exe" >> .\bin\downloadwget.vbs
echo. >> .\bin\downloadwget.vbs
echo ' Fetch the file >> .\bin\downloadwget.vbs
echo     Set objXMLHTTP = CreateObject("MSXML2.XMLHTTP") >> .\bin\downloadwget.vbs
echo. >> .\bin\downloadwget.vbs
echo     objXMLHTTP.open "GET", strFileURL, false >> .\bin\downloadwget.vbs
echo     objXMLHTTP.send() >> .\bin\downloadwget.vbs
echo. >> .\bin\downloadwget.vbs
echo If objXMLHTTP.Status = 200 Then >> .\bin\downloadwget.vbs
echo Set objADOStream = CreateObject("ADODB.Stream") >> .\bin\downloadwget.vbs
echo objADOStream.Open >> .\bin\downloadwget.vbs
echo objADOStream.Type = 1 'adTypeBinary >> .\bin\downloadwget.vbs
echo. >> .\bin\downloadwget.vbs
echo objADOStream.Write objXMLHTTP.ResponseBody >> .\bin\downloadwget.vbs
echo objADOStream.Position = 0    'Set the stream position to the start >> .\bin\downloadwget.vbs
echo. >> .\bin\downloadwget.vbs
echo Set objFSO = Createobject("Scripting.FileSystemObject") >> .\bin\downloadwget.vbs
echo If objFSO.Fileexists(strHDLocation) Then objFSO.DeleteFile strHDLocation >> .\bin\downloadwget.vbs
echo Set objFSO = Nothing >> .\bin\downloadwget.vbs
echo. >> .\bin\downloadwget.vbs
echo objADOStream.SaveToFile strHDLocation >> .\bin\downloadwget.vbs
echo objADOStream.Close >> .\bin\downloadwget.vbs
echo Set objADOStream = Nothing >> .\bin\downloadwget.vbs
echo End if >> .\bin\downloadwget.vbs
echo. >> .\bin\downloadwget.vbs
echo Set objXMLHTTP = Nothing >> .\bin\downloadwget.vbs
cscript.exe .\bin\downloadwget.vbs
move wget.exe .\bin\
(goto) 2>nul

########################################################################

:Get-Mod-Info
:: number of lines to count by minus which line you want to start with
:: exa. num=7 start with line 1, num=6 start with line 2, num=5 start with line 3, etc...
:: this line says if num is equal to blah execute this. basically it counts by this many lines it also resets the counter on completion
:: number of lines to count by

:: Mod Name
set slot-max=10
set /a "num=%slot-max%-1"
set "counter=0"
for /f "DELIMS=" %%i in (mod_list.txt) do (
    set /a num+=1
    if "!num!"=="%slot-max%" (set /a counter+=1&set "mod-title_!counter!=%%i"&set num=0)
)
:: Mod Download Link
set /a "num=%slot-max%-2"
set "counter=0"
for /f "DELIMS=" %%i in (mod_list.txt) do (
    set /a num+=1
    if "!num!"=="%slot-max%" (set /a counter+=1&set "mod-link_!counter!=%%i"&set num=0)
)
:: Mod File-Name
set /a "num=%slot-max%-3"
set "counter=0"
for /f "DELIMS=" %%i in (mod_list.txt) do (
    set /a num+=1
    if "!num!"=="%slot-max%" (set /a counter+=1&set "mod-filename_!counter!=%%i"&set num=0)
)
:: Mod Rename To
set /a "num=%slot-max%-4"
set "counter=0"
for /f "DELIMS=" %%i in (mod_list.txt) do (
    set /a num+=1
    if "!num!"=="%slot-max%" (set /a counter+=1&set "mod-rename-to_!counter!=%%i"&set num=0)
)
:: Mod Folder
set /a "num=%slot-max%-5"
set "counter=0"
for /f "DELIMS=" %%i in (mod_list.txt) do (
    set /a num+=1
    if "!num!"=="%slot-max%" (set /a counter+=1&set "mod-folder_!counter!=%%i"&set num=0)
)
:: Mod Website
set /a "num=%slot-max%-6"
set "counter=0"
for /f "DELIMS=" %%i in (mod_list.txt) do (
    set /a num+=1
    if "!num!"=="%slot-max%" (set /a counter+=1&set "mod-website_!counter!=%%i"&set num=0)
)
:: Action To Take
set /a "num=%slot-max%-7"
set "counter=0"
for /f "DELIMS=" %%i in (mod_list.txt) do (
    set /a num+=1
    if "!num!"=="%slot-max%" (set /a counter+=1&set "mod-action_!counter!=%%i"&set num=0)
)
:: Free Space
set /a "num=%slot-max%-8"
set "counter=0"
for /f "DELIMS=" %%i in (mod_list.txt) do (
    set /a num+=1
    if "!num!"=="%slot-max%" (set /a counter+=1&set "mod-null1_!counter!=%%i"&set num=0)
)
:: Free Space
set /a "num=%slot-max%-9"
set "counter=0"
for /f "DELIMS=" %%i in (mod_list.txt) do (
    set /a num+=1
    if "!num!"=="%slot-max%" (set /a counter+=1&set "mod-null2_!counter!=%%i"&set num=0)
)
:: Free Space
set /a "num=%slot-max%-10"
set "counter=0"
for /f "DELIMS=" %%i in (mod_list.txt) do (
    set /a num+=1
    if "!num!"=="%slot-max%" (set /a counter+=1&set "mod-null3_!counter!=%%i"&set num=0)
)
exit /b

########################################################################

:OFFLINE
cls
echo 1. force update in case you have an old version
echo 2. exit
echo you're either offline or you have an outdated version.
echo you can use option d in the cemu menu to redownload me.
set /p eh="choice: "
set /a "eh=%eh%"
if "%eh%"=="1" goto :Update
if "%eh%"=="2" exit
goto :OFFLINE

########################################################################

:Update-Now
cls & if not exist .\bin\wget.exe call :Download-Wget
cls & title Portable Cemu Mod Downloader Launcher - Experimental Edition - Updating Launcher
cls & .\bin\wget.exe -q --show-progress https://github.com/MarioMasta64/ModDownloaderPortable/raw/master/launch_cemu_moddownloader.bat
cls & if exist launch_cemu_moddownloader.bat.1 goto Replacer-Create
cls & call :OFFLINE
(goto) 2>nul

########################################################################

:Replacer-Create
cls
echo @echo off > replacer.bat
echo Color 0A >> replacer.bat
echo del launch_cemu_moddownloader.bat >> replacer.bat
echo rename launch_cemu_moddownloader.bat.1 launch_cemu_moddownloader.bat >> replacer.bat
echo start launch_cemu_moddownloader.bat >> replacer.bat
:: launcher exits, deletes itself, and then exits again. yes. its magic.
echo (goto) 2^>nul ^& del "%%~f0" ^& exit >> replacer.bat
wscript "%CD%\bin\hide.vbs" "replacer.bat"
exit

########################################################################