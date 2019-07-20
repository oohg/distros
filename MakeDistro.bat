@echo off
rem
rem $Id: MakeDistro.bat $
rem

:MAIN

   cls
   if /I "%1"=="HM30" goto CONTINUE
   if /I "%1"=="HM32" goto CONTINUE
   if /I "%1"=="HM34" goto CONTINUE
   if /I "%1"=="XB"   goto CONTINUE
   if /I "%1"=="XM"   goto CONTINUE
   echo.
   echo Usage: MakeDistro HarbourVersion [ /C ] [ /L ] [ /I ] [ /S ] [ /A ]
   echo where
   echo HarbourVersion is one of the following
   echo   HM30 - Harbour 3.0 and MinGW
   echo   HM32 - Harbour 3.2 and MinGW
   echo   HM34 - Harbour 3.4 and MinGW
   echo   XB   - xHarbour and BCC
   echo   XM   - xHarbour and MinGW
   echo /C means erase destination folder before building
   echo /L means build libraries only
   echo /I means use incremental building
   echo /S means don't beep on exit
   echo /A means copy (x)Harbour and MinGW compilers
   echo.
   goto END

:ERROR1

   echo.
   echo Can't create folder %BASE_DISTRO_DIR%
   echo.
   goto END

:ERROR2

   echo.
   echo %HG_ROOT%\distros\MakeExclude.txt is missing
   echo.
   goto END

:ERROR3

   echo.
   echo Can't create subfolder %BASE_DISTRO_SUBDIR%
   echo.
   popd
   goto END

:ERROR4

   echo.
   echo Can't delete folder %BASE_DISTRO_DIR%
   echo.
   goto END

:ERROR5

   echo.
   echo Can't find subfolder %BASE_DISTRO_SUBDIR%
   echo.
   popd
   goto END

:ERROR6

   echo.
   echo Folder %BASE_DISTRO_DIR% is not valid !!!
   echo.
   goto END

:CONTINUE

   rem Change these sets to use different sources for OOHG, Harbour and MinGW
   if "%HG_ROOT%" == "" set HG_ROOT=C:\OOHG

   if /I "%1"=="HM30" if "%HG_HRB%" == ""   set HG_HRB=C:\HB30
   if /I "%1"=="HM30" if "%HG_MINGW%" == "" set HG_MINGW=C:\HB30\COMP\MINGW
   if /I "%1"=="HM30" if "%LIB_GUI%" == ""  set LIB_GUI=lib
   if /I "%1"=="HM30" if "%LIB_HRB%" == ""  set LIB_HRB=lib
   if /I "%1"=="HM30" if "%BIN_HRB%" == ""  set BIN_HRB=bin
   if /I "%1"=="HM30" set HG_HB30=yes
   if /I "%1"=="HM30" set HG_HB32=
   if /I "%1"=="HM30" set HG_HB34=

   if /I "%1"=="HM32" if "%HG_HRB%" == ""   set HG_HRB=C:\HB32
   if /I "%1"=="HM32" if "%HG_MINGW%" == "" set HG_MINGW=C:\HB32\COMP\MINGW
   if /I "%1"=="HM32" if "%LIB_GUI%" == ""  set LIB_GUI=lib\hb\mingw
   if /I "%1"=="HM32" if "%LIB_HRB%" == ""  set LIB_HRB=lib\win\mingw
   if /I "%1"=="HM32" if "%BIN_HRB%" == ""  set BIN_HRB=bin
   if /I "%1"=="HM32" set HG_HB30=
   if /I "%1"=="HM32" set HG_HB32=yes
   if /I "%1"=="HM32" set HG_HB34=

   if /I "%1"=="HM34" if "%HG_HRB%" == ""   set HG_HRB=C:\HB34
   if /I "%1"=="HM34" if "%HG_MINGW%" == "" set HG_MINGW=C:\HB34\COMP\MINGW
   if /I "%1"=="HM34" if "%LIB_GUI%"  == "" set LIB_GUI=lib\hb34\mingw
   if /I "%1"=="HM34" if "%LIB_HRB%"  == "" set LIB_HRB=lib\win\clang
   if /I "%1"=="HM34" if "%BIN_HRB%"  == "" set BIN_HRB=bin
   if /I "%1"=="HM34" set HG_HB30=
   if /I "%1"=="HM34" set HG_HB32=
   if /I "%1"=="HM34" set HG_HB34=yes

   if /I "%1"=="XB"   if "%HG_HRB%" == ""   set HG_HRB=C:\XHBCC
   if /I "%1"=="XB"   if "%HG_BCC%" == ""   set HG_BCC=C:\BORLAND\BCC55
   if /I "%1"=="XB"   if "%LIB_GUI%"  == "" set LIB_GUI=lib\xhb\bcc
   if /I "%1"=="XB"   if "%LIB_HRB%"  == "" set LIB_HRB=lib
   if /I "%1"=="XB"   if "%BIN_HRB%"  == "" set BIN_HRB=bin

   if /I "%1"=="XM"   if "%HG_HRB%" == ""   set HG_HRB=C:\XHMINGW
   if /I "%1"=="XM"   if "%HG_MINGW%" == "" set HG_MINGW=C:\XHMINGW\COMP\MINGW
   if /I "%1"=="XM"   if "%LIB_GUI%"  == "" set LIB_GUI=lib\xhb\mingw
   if /I "%1"=="XM"   if "%LIB_HRB%"  == "" set LIB_HRB=lib
   if /I "%1"=="XM"   if "%BIN_HRB%"  == "" set BIN_HRB=bin

   if not exist %HG_ROOT%\distros\MakeExclude.txt goto ERROR2

:DISTRO_FOLDER

   if not "%BASE_DISTRO_DIR%"=="" goto PREPARE
   if /I "%1"=="HM30" set BASE_DISTRO_DIR=C:\OOHG_HM30
   if /I "%1"=="HM32" set BASE_DISTRO_DIR=C:\OOHG_HM32
   if /I "%1"=="HM34" set BASE_DISTRO_DIR=C:\OOHG_HM34
   if /I "%1"=="XB"   set BASE_DISTRO_DIR=C:\OOHG_XB
   if /I "%1"=="XM"   set BASE_DISTRO_DIR=C:\OOHG_XM

:PREPARE

   echo Preparing folder %BASE_DISTRO_DIR%...
   echo.

:CLEAN

   if /I "%BASE_DISTRO_DIR%"=="C:" goto ERROR6
   if /I "%BASE_DISTRO_DIR%"=="D:" goto ERROR6
   if /I "%BASE_DISTRO_DIR%"=="E:" goto ERROR6
   if /I "%BASE_DISTRO_DIR%"=="F:" goto ERROR6
   if /I "%BASE_DISTRO_DIR%"=="G:" goto ERROR6
   if /I "%BASE_DISTRO_DIR%"=="H:" goto ERROR6
   if /I "%BASE_DISTRO_DIR%"=="I:" goto ERROR6
   if /I "%BASE_DISTRO_DIR%"=="J:" goto ERROR6
   if /I "%BASE_DISTRO_DIR%"=="K:" goto ERROR6
   if /I "%BASE_DISTRO_DIR%"=="L:" goto ERROR6
   if /I "%BASE_DISTRO_DIR%"=="M:" goto ERROR6
   if /I "%BASE_DISTRO_DIR%"=="N:" goto ERROR6
   if /I "%BASE_DISTRO_DIR%"=="O:" goto ERROR6
   if /I "%BASE_DISTRO_DIR%"=="P:" goto ERROR6
   if /I "%BASE_DISTRO_DIR%"=="Q:" goto ERROR6
   if /I "%BASE_DISTRO_DIR%"=="R:" goto ERROR6
   if /I "%BASE_DISTRO_DIR%"=="S:" goto ERROR6
   if /I "%BASE_DISTRO_DIR%"=="T:" goto ERROR6
   if /I "%BASE_DISTRO_DIR%"=="U:" goto ERROR6
   if /I "%BASE_DISTRO_DIR%"=="V:" goto ERROR6
   if /I "%BASE_DISTRO_DIR%"=="W:" goto ERROR6
   if /I "%BASE_DISTRO_DIR%"=="X:" goto ERROR6
   if /I "%BASE_DISTRO_DIR%"=="Y:" goto ERROR6
   if /I "%BASE_DISTRO_DIR%"=="Z:" goto ERROR6
   if not exist %BASE_DISTRO_DIR%\nul goto CREATE

:PARSE_SWITCHES

   set CLEAN=F
   if /I "%2"=="/C" set CLEAN=T
   if /I "%3"=="/C" set CLEAN=T
   if /I "%4"=="/C" set CLEAN=T
   if /I "%5"=="/C" set CLEAN=T
   if /I "%6"=="/C" set CLEAN=T
   set ADDCOMPS=F
   if /I "%2"=="/A" set ADDCOMPS=T
   if /I "%3"=="/A" set ADDCOMPS=T
   if /I "%4"=="/A" set ADDCOMPS=T
   if /I "%5"=="/A" set ADDCOMPS=T
   if /I "%6"=="/A" set ADDCOMPS=T
   set NOIDE=F
   if /I "%2"=="/L" set NOIDE=T
   if /I "%3"=="/L" set NOIDE=T
   if /I "%4"=="/L" set NOIDE=T
   if /I "%5"=="/L" set NOIDE=T
   if /I "%6"=="/L" set NOIDE=T
   set INCRE=F
   if /I "%2"=="/I" set INCRE=T
   if /I "%3"=="/I" set INCRE=T
   if /I "%4"=="/I" set INCRE=T
   if /I "%5"=="/I" set INCRE=T
   if /I "%6"=="/I" set INCRE=T
   set BEEP=
   if /I "%2"=="/S" set BEEP=-beep-
   if /I "%3"=="/S" set BEEP=-beep-
   if /I "%4"=="/S" set BEEP=-beep-
   if /I "%5"=="/S" set BEEP=-beep-
   if /I "%6"=="/S" set BEEP=-beep-

   if not "%CLEAN%"=="T" goto CREATE

   del /f /s /q %BASE_DISTRO_DIR%\*.* > nul
   attrib -s -h %BASE_DISTRO_DIR%\*.* /s /d > nul
   del /f /s /q %BASE_DISTRO_DIR%\*.* > nul
   rd /s /q %BASE_DISTRO_DIR% > nul
   if exist %BASE_DISTRO_DIR%\nul goto ERROR4

:CREATE

   if not exist %BASE_DISTRO_DIR%\nul md %BASE_DISTRO_DIR%
   if not exist %BASE_DISTRO_DIR%\nul goto ERROR1

:FOLDERS

   pushd %BASE_DISTRO_DIR%
   set BASE_DISTRO_SUBDIR=doc
   if not exist doc\nul md doc
   if not exist doc\nul goto ERROR3
   if not "%ADDCOMPS%"=="T" goto FOLDERS_CONTINUE
   if /I "%1"=="HM30" set BASE_DISTRO_SUBDIR=hb30
   if /I "%1"=="HM30" if not exist hb30\nul md hb30
   if /I "%1"=="HM30" if not exist hb30\nul goto ERROR3
   if /I "%1"=="HM32" set BASE_DISTRO_SUBDIR=hb32
   if /I "%1"=="HM32" if not exist hb32\nul md hb32
   if /I "%1"=="HM32" if not exist hb32\nul goto ERROR3
   if /I "%1"=="HM34" set BASE_DISTRO_SUBDIR=hb34
   if /I "%1"=="HM34" if not exist hb34\nul md hb34
   if /I "%1"=="HM34" if not exist hb34\nul goto ERROR3
   if /I "%1"=="XB"   set BASE_DISTRO_SUBDIR=xhbcc
   if /I "%1"=="XB"   if not exist xhbcc\nul md xhbcc
   if /I "%1"=="XB"   if not exist xhbcc\nul goto ERROR3
   if /I "%1"=="XM"   set BASE_DISTRO_SUBDIR=xhmingw
   if /I "%1"=="XM"   if not exist xhmingw\nul md xhmingw
   if /I "%1"=="XM"   if not exist xhmingw\nul goto ERROR3

:FOLDERS_CONTINUE

   set BASE_DISTRO_SUBDIR=ide
   if not exist ide\nul md ide
   if not exist ide\nul goto ERROR3
   set BASE_DISTRO_SUBDIR=include
   if not exist include\nul md include
   if not exist include\nul goto ERROR3
   if /I "%1"=="HM30" set BASE_DISTRO_SUBDIR=lib
   if /I "%1"=="HM32" set BASE_DISTRO_SUBDIR=lib\hb\mingw
   if /I "%1"=="HM34" set BASE_DISTRO_SUBDIR=lib\hb34\mingw
   if /I "%1"=="XB"   set BASE_DISTRO_SUBDIR=lib\xhb\bcc
   if /I "%1"=="XM"   set BASE_DISTRO_SUBDIR=lib\xhb\mingw
   if not exist %BASE_DISTRO_SUBDIR%\nul md %BASE_DISTRO_SUBDIR%
   if not exist %BASE_DISTRO_SUBDIR%\nul goto ERROR3
   set BASE_DISTRO_SUBDIR=fmt
   if not exist fmt\nul md fmt
   if not exist fmt\nul goto ERROR3
   set BASE_DISTRO_SUBDIR=resources
   if not exist resources\nul md resources
   if not exist resources\nul goto ERROR3
   set BASE_DISTRO_SUBDIR=samples
   if not exist samples\nul md samples
   if not exist samples\nul goto ERROR3
   set BASE_DISTRO_SUBDIR=source
   if not exist source\nul md source
   if not exist source\nul goto ERROR3

:FILES

   echo Copying %HG_ROOT%...
   xcopy %HG_ROOT%\core\*.* /r /c /q /y /d /exclude:%HG_ROOT%\distros\MakeExclude.txt
   xcopy %HG_ROOT%\core\compile.bat /r /y /d /q
   if /I "%1"=="HM30" xcopy %HG_ROOT%\core\compile30.bat /r /y /d /q
   if /I "%1"=="HM32" xcopy %HG_ROOT%\core\compile32.bat /r /y /d /q
   if /I "%1"=="HM34" xcopy %HG_ROOT%\core\compile34.bat /r /y /d /q
   if /I "%1"=="XB"   xcopy %HG_ROOT%\core\compileXB.bat /r /y /d /q
   if /I "%1"=="XM"   xcopy %HG_ROOT%\core\compileXM.bat /r /y /d /q
   if /I "%1"=="HM30" xcopy %HG_ROOT%\core\compile_mingw.bat /r /y /d /q
   if /I "%1"=="HM32" xcopy %HG_ROOT%\core\compile_mingw.bat /r /y /d /q
   if /I "%1"=="HM34" xcopy %HG_ROOT%\core\compile_mingw.bat /r /y /d /q
   if /I "%1"=="XB"   xcopy %HG_ROOT%\core\compile_bcc.bat /r /y /d /q
   if /I "%1"=="XM"   xcopy %HG_ROOT%\core\compile_mingw.bat /r /y /d /q
   if /I "%1"=="HM30" xcopy %HG_ROOT%\core\BuildApp30.bat /r /y /d /q
   if /I "%1"=="HM32" xcopy %HG_ROOT%\core\BuildApp32.bat /r /y /d /q
   if /I "%1"=="HM34" xcopy %HG_ROOT%\core\BuildApp34.bat /r /y /d /q
   if /I "%1"=="HM30" xcopy %HG_ROOT%\core\BuildApp.bat /r /y /d /q
   if /I "%1"=="HM32" xcopy %HG_ROOT%\core\BuildApp.bat /r /y /d /q
   if /I "%1"=="HM34" xcopy %HG_ROOT%\core\BuildApp.bat /r /y /d /q
   if /I "%1"=="HM30" xcopy %HG_ROOT%\core\BuildApp_hbmk2.bat /r /y /d /q
   if /I "%1"=="HM32" xcopy %HG_ROOT%\core\BuildApp_hbmk2.bat /r /y /d /q
   if /I "%1"=="HM34" xcopy %HG_ROOT%\core\BuildApp_hbmk2.bat /r /y /d /q
   if /I "%1"=="HM30" xcopy %HG_ROOT%\core\oohg.hbc /r /y /d /q
   if /I "%1"=="HM32" xcopy %HG_ROOT%\core\oohg.hbc /r /y /d /q
   if /I "%1"=="HM34" xcopy %HG_ROOT%\core\oohg.hbc /r /y /d /q
   if /I "%1"=="XM"   xcopy %HG_ROOT%\core\oohg.hbc /r /y /d /q
   echo.

:DOC

   echo Copying DOC...
   set BASE_DISTRO_SUBDIR=doc
   if not exist doc\nul goto ERROR5
   cd doc
   xcopy %HG_ROOT%\doc\english\*.* /r /s /e /c /q /y /d /exclude:%HG_ROOT%\distros\MakeExclude.txt
REM TODO: Add manual's build here
   xcopy %HG_ROOT%\doc\manual\*.* /r /s /e /c /q /y /d /exclude:%HG_ROOT%\distros\MakeExclude.txt
   cd ..
   echo.

:COMPILERS

   if not "%ADDCOMPS%"=="T" goto IDE

:HM30

   if /I not "%1"=="HM30" goto HM32
   echo Copying HM30...
   set BASE_DISTRO_SUBDIR=hb30
   if not exist hb30\nul goto ERROR5
   cd hb30
   xcopy %HG_HRB%\*.* /r /s /e /c /q /y /d
   if exist uninstall.exe del uninstall.exe
   if /I "%HG_MINGW%" == "%HG_HRB%\COMP\MINGW" cd ..
   if /I "%HG_MINGW%" == "%HG_HRB%\COMP\MINGW" echo.
   if /I "%HG_MINGW%" == "%HG_HRB%\COMP\MINGW" goto IDE
   set BASE_DISTRO_SUBDIR=comp
   if not exist comp\nul md comp
   if not exist comp\nul goto ERROR5
   cd comp
   set BASE_DISTRO_SUBDIR=mingw
   if not exist mingw\nul md mingw
   if not exist mingw\nul goto ERROR5
   cd mingw
   xcopy %HG_MINGW%\*.* /r /s /e /c /q /y /d
   cd ..
   cd ..
   cd ..
   echo.

:HM32

   if /I not "%1"=="HM32" goto HM34
   echo Copying HM32...
   set BASE_DISTRO_SUBDIR=hb32
   if not exist hb32\nul goto ERROR5
   cd hb32
   xcopy %HG_HRB%\*.* /r /s /e /c /q /y /d
   if exist uninstall.exe del uninstall.exe
   if /I "%HG_MINGW%" == "%HG_HRB%\COMP\MINGW" cd ..
   if /I "%HG_MINGW%" == "%HG_HRB%\COMP\MINGW" echo.
   if /I "%HG_MINGW%" == "%HG_HRB%\COMP\MINGW" goto IDE
   set BASE_DISTRO_SUBDIR=comp
   if not exist comp\nul md comp
   if not exist comp\nul goto ERROR5
   cd comp
   set BASE_DISTRO_SUBDIR=mingw
   if not exist mingw\nul md mingw
   if not exist mingw\nul goto ERROR5
   cd mingw
   xcopy %HG_MINGW%\*.* /r /s /e /c /q /y /d
   cd ..
   cd ..
   cd ..
   echo.

:HM34

   if /I not "%1"=="HM34" goto XB
   echo Copying HM34...
   set BASE_DISTRO_SUBDIR=hb34
   if not exist hb34\nul goto ERROR5
   cd hb34
   xcopy %HG_HRB%\*.* /r /s /e /c /q /y /d
   if exist uninstall.exe del uninstall.exe
   if /I "%HG_MINGW%" == "%HG_HRB%\COMP\MINGW" cd ..
   if /I "%HG_MINGW%" == "%HG_HRB%\COMP\MINGW" echo.
   if /I "%HG_MINGW%" == "%HG_HRB%\COMP\MINGW" goto IDE
   set BASE_DISTRO_SUBDIR=comp
   if not exist comp\nul md comp
   if not exist comp\nul goto ERROR5
   cd comp
   set BASE_DISTRO_SUBDIR=mingw
   if not exist mingw\nul md mingw
   if not exist mingw\nul goto ERROR5
   cd mingw
   xcopy %HG_MINGW%\*.* /r /s /e /c /q /y /d
   cd ..
   cd ..
   cd ..
   echo.

:XB

   if /I not "%1"=="XB" goto XM
   echo Copying xHarbour...
   set BASE_DISTRO_SUBDIR=xhbcc
   if not exist xhbcc\nul goto ERROR5
   cd xhbcc
   xcopy %HG_HRB%\*.* /r /s /e /c /q /y /d
   if exist uninstall.exe del uninstall.exe
   if /I "%HG_BCC%" == "%HG_HRB%\COMP\BCC" cd ..
   if /I "%HG_BCC%" == "%HG_HRB%\COMP\BCC" echo.
   if /I "%HG_BCC%" == "%HG_HRB%\COMP\BCC" goto IDE
   set BASE_DISTRO_SUBDIR=comp
   if not exist comp\nul md comp
   if not exist comp\nul goto ERROR5
   cd comp
   set BASE_DISTRO_SUBDIR=bcc
   if not exist bcc\nul md bcc
   if not exist bcc\nul goto ERROR5
   cd bcc
   xcopy %HG_BCC%\*.* /r /s /e /c /q /y /d
   cd ..
   cd ..
   cd ..
   echo.

:XM

   if /I not "%1"=="XM" goto IDE
   echo Copying xHarbour...
   set BASE_DISTRO_SUBDIR=xhmingw
   if not exist xhmingw\nul goto ERROR5
   cd xhmingw
   xcopy %HG_HRB%\*.* /r /s /e /c /q /y /d
   if exist uninstall.exe del uninstall.exe
   if /I "%HG_MINGW%" == "%HG_HRB%\COMP\MINGW" cd ..
   if /I "%HG_MINGW%" == "%HG_HRB%\COMP\MINGW" echo.
   if /I "%HG_MINGW%" == "%HG_HRB%\COMP\MINGW" goto IDE
   set BASE_DISTRO_SUBDIR=comp
   if not exist comp\nul md comp
   if not exist comp\nul goto ERROR5
   cd comp
   set BASE_DISTRO_SUBDIR=mingw
   if not exist mingw\nul md mingw
   if not exist mingw\nul goto ERROR5
   cd mingw
   xcopy %HG_MINGW%\*.* /r /s /e /c /q /y /d
   cd ..
   cd ..
   cd ..
   echo.

:IDE

   echo Copying IDE...
   set BASE_DISTRO_SUBDIR=ide
   if not exist ide\nul goto ERROR5
   cd ide
   xcopy %HG_ROOT%\ide\*.* /r /s /e /c /q /y /d /exclude:%HG_ROOT%\distros\MakeExclude.txt
   if /I "%1"=="HM30" xcopy %HG_ROOT%\ide\build.bat /r /y /d /q
   if /I "%1"=="HM30" xcopy %HG_ROOT%\ide\mgide.hbp /r /y /d /q
   if /I "%1"=="HM32" xcopy %HG_ROOT%\ide\build.bat /r /y /d /q
   if /I "%1"=="HM32" xcopy %HG_ROOT%\ide\mgide.hbp /r /y /d /q
   if /I "%1"=="HM34" xcopy %HG_ROOT%\ide\build.bat /r /y /d /q
   if /I "%1"=="HM34" xcopy %HG_ROOT%\ide\mgide.hbp /r /y /d /q
   if /I "%1"=="XB"   xcopy %HG_ROOT%\ide\compile.bat /r /y /d /q
   if /I "%1"=="XM"   xcopy %HG_ROOT%\ide\compile.bat /r /y /d /q
   cd ..
   echo.

:INCLUDE

   echo Copying INCLUDE...
   set BASE_DISTRO_SUBDIR=include
   if not exist include\nul goto ERROR5
   cd include
   xcopy %HG_ROOT%\core\include\*.* /r /s /e /c /q /y /d /exclude:%HG_ROOT%\distros\MakeExclude.txt
   cd ..
   echo.

:FMT

   echo Copying FMT...
   set BASE_DISTRO_SUBDIR=fmt
   if not exist fmt\nul goto ERROR5
   cd fmt
   xcopy %HG_ROOT%\fmt\*.* /r /s /e /c /q /y /d /exclude:%HG_ROOT%\distros\MakeExclude.txt
   if /I "%1"=="HM30" xcopy %HG_ROOT%\fmt\build.bat /r /y /d /q
   if /I "%1"=="HM30" xcopy %HG_ROOT%\fmt\ofmt.hbp /r /y /d /q
   if /I "%1"=="HM32" xcopy %HG_ROOT%\fmt\build.bat /r /y /d /q
   if /I "%1"=="HM32" xcopy %HG_ROOT%\fmt\ofmt.hbp /r /y /d /q
   if /I "%1"=="HM34" xcopy %HG_ROOT%\fmt\build.bat /r /y /d /q
   if /I "%1"=="HM34" xcopy %HG_ROOT%\fmt\ofmt.hbp /r /y /d /q
   if /I "%1"=="XB"   xcopy %HG_ROOT%\fmt\compile.bat /r /y /d /q
   if /I "%1"=="XM"   xcopy %HG_ROOT%\fmt\compile.bat /r /y /d /q
   cd ..
   echo.
   if /I not "%1"=="HM30" goto RESOURCES

:RESOURCES

   echo Copying RESOURCES...
   set BASE_DISTRO_SUBDIR=resources
   if not exist resources\nul goto ERROR5
   cd resources
   xcopy %HG_ROOT%\core\resources\*.* /r /s /e /c /q /y /d /exclude:%HG_ROOT%\distros\MakeExclude.txt
   if /I "%1"=="HM30" xcopy %HG_ROOT%\core\resources\compileres_mingw.bat /r /y /d /q
   if /I "%1"=="HM32" xcopy %HG_ROOT%\core\resources\compileres_mingw.bat /r /y /d /q
   if /I "%1"=="HM34" xcopy %HG_ROOT%\core\resources\compileres_mingw.bat /r /y /d /q
   if /I "%1"=="XB"   xcopy %HG_ROOT%\core\resources\compileres_bcc.bat /r /y /d /q
   if /I "%1"=="XM"   xcopy %HG_ROOT%\core\resources\compileres_mingw.bat /r /y /d /q
   if /I "%1"=="HM30" xcopy %HG_ROOT%\core\resources\oohg.rc /r /y /d /q
   if /I "%1"=="HM32" xcopy %HG_ROOT%\core\resources\oohg.rc /r /y /d /q
   if /I "%1"=="HM34" xcopy %HG_ROOT%\core\resources\oohg.rc /r /y /d /q
   if /I "%1"=="XB"   xcopy %HG_ROOT%\core\resources\oohg_bcc.rc /r /y /d /q
   if /I "%1"=="XM"   xcopy %HG_ROOT%\core\resources\oohg.rc /r /y /d /q
   cd ..
   echo.

:SAMPLES

   echo Copying SAMPLES...
   set BASE_DISTRO_SUBDIR=samples
   if not exist samples\nul goto ERROR5
   cd samples
   if /I "%1"=="HM30" xcopy %HG_ROOT%\samples\*.* /r /s /e /c /q /y /d /exclude:%HG_ROOT%\distros\MakeExclude.txt+%HG_ROOT%\distros\MakeExclude30.txt
   if /I not "%1"=="HM30" xcopy %HG_ROOT%\samples\*.* /r /s /e /c /q /y /d /exclude:%HG_ROOT%\distros\MakeExclude.txt
   cd ..
   echo.

:SOURCE

   echo Copying SOURCE...
   set BASE_DISTRO_SUBDIR=source
   if not exist source\nul goto ERROR5
   cd source
   xcopy %HG_ROOT%\core\source\*.* /r /s /e /c /q /y /d /exclude:%HG_ROOT%\distros\MakeExclude.txt
   if /I "%1"=="HM30" xcopy %HG_ROOT%\core\source\BuildLib30.bat /r /y /d /q
   if /I "%1"=="HM32" xcopy %HG_ROOT%\core\source\BuildLib32.bat /r /y /d /q
   if /I "%1"=="HM34" xcopy %HG_ROOT%\core\source\BuildLib34.bat /r /y /d /q
   if /I "%1"=="HM30" xcopy %HG_ROOT%\core\source\buildlib.bat /r /y /d /q
   if /I "%1"=="HM32" xcopy %HG_ROOT%\core\source\buildlib.bat /r /y /d /q
   if /I "%1"=="HM34" xcopy %HG_ROOT%\core\source\buildlib.bat /r /y /d /q
   if /I "%1"=="HM30" xcopy %HG_ROOT%\core\source\buildlib_hbmk2.bat /r /y /d /q
   if /I "%1"=="HM32" xcopy %HG_ROOT%\core\source\buildlib_hbmk2.bat /r /y /d /q
   if /I "%1"=="HM34" xcopy %HG_ROOT%\core\source\buildlib_hbmk2.bat /r /y /d /q
   if /I "%1"=="HM30" xcopy %HG_ROOT%\core\source\oohg.hbp /r /y /d /q
   if /I "%1"=="HM32" xcopy %HG_ROOT%\core\source\oohg.hbp /r /y /d /q
   if /I "%1"=="HM34" xcopy %HG_ROOT%\core\source\oohg.hbp /r /y /d /q
   if /I "%1"=="HM30" xcopy %HG_ROOT%\core\source\bostaurus.hbp /r /y /d /q
   if /I "%1"=="HM32" xcopy %HG_ROOT%\core\source\bostaurus.hbp /r /y /d /q
   if /I "%1"=="HM34" xcopy %HG_ROOT%\core\source\bostaurus.hbp /r /y /d /q
   if /I "%1"=="HM30" xcopy %HG_ROOT%\core\source\miniprint.hbp /r /y /d /q
   if /I "%1"=="HM32" xcopy %HG_ROOT%\core\source\miniprint.hbp /r /y /d /q
   if /I "%1"=="HM34" xcopy %HG_ROOT%\core\source\miniprint.hbp /r /y /d /q
   if /I "%1"=="HM30" xcopy %HG_ROOT%\core\source\hbprinter.hbp /r /y /d /q
   if /I "%1"=="HM32" xcopy %HG_ROOT%\core\source\hbprinter.hbp /r /y /d /q
   if /I "%1"=="HM34" xcopy %HG_ROOT%\core\source\hbprinter.hbp /r /y /d /q
   if /I "%1"=="HM30" xcopy %HG_ROOT%\core\source\MakeLib30.bat /r /y /d /q
   if /I "%1"=="HM32" xcopy %HG_ROOT%\core\source\MakeLib32.bat /r /y /d /q
   if /I "%1"=="HM34" xcopy %HG_ROOT%\core\source\MakeLib34.bat /r /y /d /q
   if /I "%1"=="XM"   xcopy %HG_ROOT%\core\source\MakeLibXM.bat /r /y /d /q
   if /I "%1"=="HM30" xcopy %HG_ROOT%\core\source\makelib_mingw.bat /r /y /d /q
   if /I "%1"=="HM32" xcopy %HG_ROOT%\core\source\makelib_mingw.bat /r /y /d /q
   if /I "%1"=="HM34" xcopy %HG_ROOT%\core\source\makelib_mingw.bat /r /y /d /q
   if /I "%1"=="XM"   xcopy %HG_ROOT%\core\source\makelib_mingw.bat /r /y /d /q
   if /I "%1"=="XB"   xcopy %HG_ROOT%\core\source\MakeLibXB.bat /r /y /d /q
   if /I "%1"=="XB"   xcopy %HG_ROOT%\core\source\makelib_bcc.bat /r /y /d /q
   cd ..
   echo.

:RES_FILE

   echo Compiling resource file...
   cd resources
   set HG_ROOT=%BASE_DISTRO_DIR%
   if /I "%1"=="HM30" call compileres_mingw.bat /NOCLS HM30
   if /I "%1"=="HM32" call compileres_mingw.bat /NOCLS HM32
   if /I "%1"=="HM34" call compileres_mingw.bat /NOCLS HM34
   if /I "%1"=="XB"   call compileres_bcc.bat /NOCLS
   if /I "%1"=="XM"   call compileres_mingw.bat /NOCLS XM
   cd ..

:BUILDLIBS

   if /I "%1"=="HM30" goto LIBSHM30
   if /I "%1"=="HM32" goto LIBSHM32
   if /I "%1"=="HM34" goto LIBSHM34
   if /I "%1"=="XB"   goto LIBSXB
   if /I "%1"=="XM"   goto LIBSXM
   popd
   goto END

:LIBSHM30

   echo Building libs...
   cd source
   set TPATH=%PATH%
   set PATH=%HG_MINGW%\bin;%HG_HRB%\%BIN_HRB%;C:\WINDOWS\SYSTEM32
   if /I "%INCRE%"=="T" goto BUILD_LIBSHM30
   if not exist %BASE_DISTRO_DIR%\%LIB_GUI%\.hbmk\nul goto BUILD_LIBSHM30
   attrib -s -h %BASE_DISTRO_DIR%\%LIB_GUI%\.hbmk /s /d
   rd %BASE_DISTRO_DIR%\%LIB_GUI%\.hbmk /s /q

:BUILD_LIBSHM30

   hbmk2 oohg.hbp %BEEP%
   hbmk2 bostaurus.hbp %BEEP%
   hbmk2 miniprint.hbp %BEEP%
   hbmk2 hbprinter.hbp %BEEP%
   set PATH=%TPATH%
   set TPATH=
   if /I "%INCRE%"=="T" goto REST_LIBSHM30
   attrib -s -h %BASE_DISTRO_DIR%\%LIB_GUI%\.hbmk /s /d
   rd %BASE_DISTRO_DIR%\%LIB_GUI%\.hbmk /s /q

:REST_LIBSHM30
   echo.
   cd ..
   if /I "%NOIDE%"=="T" goto END
   goto OIDE_HBMK2

:LIBSHM32

   echo Building libs...
   cd source
   set TPATH=%PATH%
   set PATH=%HG_MINGW%\bin;%HG_HRB%\%BIN_HRB%;C:\WINDOWS\SYSTEM32
   if /I "%INCRE%"=="T" goto BUILD_LIBSHM32
   if not exist %BASE_DISTRO_DIR%\%LIB_GUI%\.hbmk\nul goto BUILD_LIBSHM32
   attrib -s -h %BASE_DISTRO_DIR%\%LIB_GUI%\.hbmk /s /d
   rd %BASE_DISTRO_DIR%\%LIB_GUI%\.hbmk /s /q

:BUILD_LIBSHM32

   hbmk2 oohg.hbp      %BEEP%
   hbmk2 bostaurus.hbp %BEEP%
   hbmk2 miniprint.hbp %BEEP%
   hbmk2 hbprinter.hbp %BEEP%
   set PATH=%TPATH%
   set TPATH=
   if /I "%INCRE%"=="T" goto REST_LIBSHM32
   attrib -s -h %BASE_DISTRO_DIR%\%LIB_GUI%\.hbmk /s /d
   rd %BASE_DISTRO_DIR%\%LIB_GUI%\.hbmk /s /q

:REST_LIBSHM32
   echo.
   cd ..
   if /I "%NOIDE%"=="T" goto END
   goto OIDE_HBMK2

:LIBSHM34

   echo Building libs...
   cd source
   set TPATH=%PATH%
   set PATH=%HG_MINGW%\bin;%HG_HRB%\%BIN_HRB%;C:\WINDOWS\SYSTEM32
   if /I "%INCRE%"=="T" goto BUILD_LIBSHM34
   if not exist %BASE_DISTRO_DIR%\%LIB_GUI%\.hbmk\nul goto BUILD_LIBSHM34
   attrib -s -h %BASE_DISTRO_DIR%\%LIB_GUI%\.hbmk /s /d
   rd %BASE_DISTRO_DIR%\%LIB_GUI%\.hbmk /s /q

:BUILD_LIBSHM34

   hbmk2 oohg.hbp %BEEP%
   hbmk2 bostaurus.hbp %BEEP%
   hbmk2 miniprint.hbp %BEEP%
   hbmk2 hbprinter.hbp %BEEP%
   set PATH=%TPATH%
   set TPATH=
   if /I "%INCRE%"=="T" goto REST_LIBSHM34
   attrib -s -h %BASE_DISTRO_DIR%\%LIB_GUI%\.hbmk /s /d
   rd %BASE_DISTRO_DIR%\%LIB_GUI%\.hbmk /s /q

:REST_LIBSHM34
   echo.
   cd ..
   if /I "%NOIDE%"=="T" goto END
   goto OIDE_HBMK2

:LIBSXB

   echo Building libs...
   cd source
   echo xHarbour: Compiling sources...
   set HG_FILES1_PRG=h_error h_windows h_form h_ipaddress h_monthcal h_help h_status h_tree h_toolbar h_init h_media h_winapimisc h_slider h_button h_checkbox h_combo h_controlmisc h_datepicker h_editbox h_dialogs h_grid h_image h_label h_listbox h_menu h_msgbox h_frame h_progressbar h_radio h_spinner h_tab h_textbox h_application h_notify
   set HG_FILES2_PRG=h_graph h_richeditbox h_edit h_edit_ex h_scrsaver h_browse h_crypt h_zip h_comm h_print h_scroll h_splitbox h_progressmeter h_scrollbutton h_xbrowse h_internal h_textarray h_hotkeybox h_activex h_pdf h_hotkey h_hyperlink h_tooltip h_picture h_dll h_checklist h_timer h_cursor h_ini h_report h_registry h_anigif
   set HG_X_FLAGS=-i"%HG_HRB%\include;%HG_ROOT%\include" -n1 -gc0 -q0
   %HG_HRB%\%BIN_HRB%\harbour %HG_FILES1_PRG% %HG_FILES2_PRG% miniprint winprint bostaurus %HG_X_FLAGS%
   if not errorlevel 1 goto LIBSXB_BCC
   echo Error building XB libs!
   goto END

:LIBSXB_BCC

   echo BCC32: Compiling C files...
   if exist resul.txt del resul.txt
   set HG_X_FLAGS=-c -O2 -tW -tWM -d -a8 -OS -5 -6 -w -I%HG_HRB%\include;%HG_BCC%\include;%HG_ROOT%\include; -L%HG_HRB%\%LIB_HRB%;%HG_BCC%\lib;
   set HG_FILES_C=c_media c_controlmisc c_resource c_cursor c_font c_dialogs c_windows c_image c_msgbox c_winapimisc c_scrsaver c_graph c_activex c_gdiplus
   for %%a in ( %HG_FILES1_PRG% %HG_FILES2_PRG% %HG_FILES_C% miniprint winprint bostaurus ) do if not errorlevel 1 %HG_BCC%\bin\bcc32 %HG_X_FLAGS% %%a.c >> resul.txt
   if not errorlevel 1 goto LIBSXB_TLIB
   echo Error building XB libs!
   type resul.txt
   goto END

:LIBSXB_TLIB

   echo TLIB: Building library %HG_ROOT%\%LIB_GUI%\oohg.lib...
   for %%a in ( %HG_FILES1_PRG% %HG_FILES2_PRG% %HG_FILES_C% ) do (
      %HG_BCC%\bin\tlib %HG_ROOT%\%LIB_GUI%\oohg + %%a.obj /P32 > nul
      if errorlevel 1 goto END
   )
   echo TLIB: Building library %HG_ROOT%\%LIB_GUI%\hbprinter.lib...
   %HG_BCC%\bin\tlib %HG_ROOT%\%LIB_GUI%\hbprinter + winprint.obj > nul
   if errorlevel 1 goto END
   echo TLIB: Building library %HG_ROOT%\%LIB_GUI%\miniprint.lib...
   %HG_BCC%\bin\tlib %HG_ROOT%\%LIB_GUI%\miniprint + miniprint.obj > nul
   if errorlevel 1 goto END
   echo TLIB: Building library %HG_ROOT%\%LIB_GUI%\bostaurus.lib...
   %HG_BCC%\bin\tlib %HG_ROOT%\%LIB_GUI%\bostaurus + bostaurus.obj > nul
   if errorlevel 1 goto END
   echo Build finished OK !!!
   del %HG_ROOT%\%LIB_GUI%\*.bak /q > nul
   del *.obj /q
   del h_*.c /q
   del winprint.c /q
   del miniprint.c /q
   del bostaurus.c /q
   del resul.txt
   set HG_X_FLAGS=
   set HG_FILES_C=
   set HG_FILES2_PRG=
   set HG_FILES1_PRG=
   echo.
   cd ..
   if /I "%NOIDE%"=="T" goto FMT_XBCC
   goto OIDE_XBCC

:LIBSXM

   echo Building libs...
   cd source
   echo xHarbour: Compiling sources...
   set HG_FILES1_PRG=h_error h_windows h_form h_ipaddress h_monthcal h_help h_status h_tree h_toolbar h_init h_media h_winapimisc h_slider h_button h_checkbox h_combo h_controlmisc h_datepicker h_editbox h_dialogs h_grid h_image h_label h_listbox h_menu h_msgbox h_frame h_progressbar h_radio h_spinner h_tab h_textbox h_application h_notify
   set HG_FILES2_PRG=h_graph h_richeditbox h_edit h_edit_ex h_scrsaver h_browse h_crypt h_zip h_comm h_print h_scroll h_splitbox h_progressmeter h_scrollbutton h_xbrowse h_internal h_textarray h_hotkeybox h_activex h_pdf h_hotkey h_hyperlink h_tooltip h_picture h_dll h_checklist h_timer h_cursor h_ini h_report h_registry h_anigif
   set HG_X_FLAGS=-i"%HG_HRB%\include;%HG_ROOT%\include" -n1 -gc0 -q0
   %HG_HRB%\%BIN_HRB%\harbour %HG_FILES1_PRG% %HG_FILES2_PRG% miniprint winprint bostaurus %HG_X_FLAGS%
   if not errorlevel 1 goto LIBSXM_GCC
   echo Error building XM libs!
   goto END

:LIBSXM_GCC

   echo GCC: Compiling C files...
   set TPATH=%PATH%
   set PATH=%HG_MINGW%\bin;%HG_HRB%\%BIN_HRB%;C:\WINDOWS\SYSTEM32
   set HG_X_FLAGS=-W -Wall -O3 -c -I%HG_HRB%\include -I%HG_MINGW%\include -I%HG_ROOT%\include -L%HG_HRB%\%LIB_HRB% -L%HG_MINGW%\lib
   set HG_FILES_C=c_media c_controlmisc c_resource c_cursor c_font c_dialogs c_windows c_image c_msgbox c_winapimisc c_scrsaver c_graph c_activex c_gdiplus
   for %%a in ( %HG_FILES1_PRG% ) do if not errorlevel 1 gcc %HG_X_FLAGS% %%a.c
   if errorlevel 1 goto END
   for %%a in ( %HG_FILES2_PRG% ) do if not errorlevel 1 gcc %HG_X_FLAGS% %%a.c
   if errorlevel 1 goto END
   for %%a in  (%HG_FILES_C% )    do if not errorlevel 1 gcc %HG_X_FLAGS% %%a.c
   if errorlevel 1 goto END
   if exist winprint.c  gcc %HG_X_FLAGS% winprint.c
   if errorlevel 1 goto END
   if exist miniprint.c gcc %HG_X_FLAGS% miniprint.c
   if errorlevel 1 goto END
   if exist bostaurus.c gcc %HG_X_FLAGS% bostaurus.c
   if errorlevel 1 goto END

:LIBSXM_BUILD

   echo AR: Creating archive %HG_ROOT%\%LIB_GUI%\liboohg.a...
   %HG_MINGW%\bin\ar rc %HG_ROOT%\%LIB_GUI%\liboohg.a h_scrsaver.o h_edit.o h_edit_ex.o h_error.o h_ipaddress.o h_monthcal.o h_help.o h_status.o h_tree.o h_toolbar.o h_init.o h_media.o c_media.o c_resource.o h_cursor.o c_cursor.o h_ini.o h_report.o c_font.o h_hyperlink.o c_scrsaver.o h_hotkey.o h_graph.o c_graph.o h_richeditbox.o h_browse.o h_scroll.o h_zip.o h_progressmeter.o h_comm.o h_print.o h_splitbox.o h_scrollbutton.o h_pdf.o h_tooltip.o h_application.o h_notify.o
   if errorlevel 2 goto END
   %HG_MINGW%\bin\ar rc %HG_ROOT%\%LIB_GUI%\liboohg.a h_windows.o h_form.o c_windows.o h_crypt.o h_winapimisc.o h_slider.o c_controlmisc.o c_dialogs.o c_image.o c_msgbox.o c_winapimisc.o h_button.o h_checkbox.o h_combo.o h_controlmisc.o h_datepicker.o h_editbox.o h_dialogs.o h_grid.o h_image.o h_label.o h_listbox.o h_menu.o h_msgbox.o h_frame.o h_progressbar.o h_radio.o h_spinner.o h_tab.o h_textbox.o h_timer.o h_registry.o h_internal.o h_dll.o h_checklist.o
   if errorlevel 2 goto END
   %HG_MINGW%\bin\ar rc %HG_ROOT%\%LIB_GUI%\liboohg.a h_xbrowse.o h_activex.o c_activex.o h_textarray.o h_picture.o h_hotkeybox.o c_gdiplus.o h_anigif.o
   if errorlevel 2 goto END
   echo AR: Creating archive %HG_ROOT%\%LIB_GUI%\libhbprinter.a...
   if exist winprint.o  %HG_MINGW%\bin\ar rc %HG_ROOT%\%LIB_GUI%\libhbprinter.a winprint.o
   if errorlevel 2 goto END
   echo AR: Creating archive %HG_ROOT%\%LIB_GUI%\libminiprint.a...
   if exist miniprint.o %HG_MINGW%\bin\ar rc %HG_ROOT%\%LIB_GUI%\libminiprint.a miniprint.o
   if errorlevel 2 goto END
   echo AR: Creating archive %HG_ROOT%\%LIB_GUI%\libbostaurus.a...
   if exist bostaurus.o %HG_MINGW%\bin\ar rc %HG_ROOT%\%LIB_GUI%\libbostaurus.a bostaurus.o
   if errorlevel 2 goto END
   echo Build finished OK !!!
   del *.o /q
   del h_*.c /q
   del winprint.c /q
   del miniprint.c /q
   del bostaurus.c /q
   set HG_X_FLAGS=
   set HG_FILES_C=
   set HG_FILES2_PRG=
   set HG_FILES1_PRG=
   echo.
   cd ..
   if /I "%NOIDE%"=="T" goto END
   goto OIDE_XMINGW

:OIDE_HBMK2

   echo Building oIDE...
   cd ide
   set TPATH=%PATH%
   set PATH=%HG_MINGW%\bin;%HG_HRB%\%BIN_HRB%
   echo #define oohgpath %HG_ROOT%\RESOURCES > _oohg_resconfig.h
   copy /b mgide.rc + %HG_ROOT%\resources\oohg.rc _temp.rc > nul
   windres -i _temp.rc -o _temp.o
   hbmk2 mgide.hbp _temp.o %BEEP%
   del _oohg_resconfig.h /q
   del _temp.* /q
   set PATH=%TPATH%
   set TPATH=
   attrib -s -h .hbmk /s /d
   rd .hbmk /s /q
   echo.
   cd ..
   goto FMT_HBMK2

:OIDE_XBCC

   echo Building oIDE...
   cd ide
   call compile.bat /nocls
   cd ..
   goto FMT_XBCC

:OIDE_XMINGW

   echo Building oIDE...
   cd ide
   call compile.bat /nocls
   cd ..
   goto FMT_XBCC

:FMT_HBMK2

   echo Building oFMT...
   cd fmt
   set TPATH=%PATH%
   set PATH=%HG_MINGW%\bin;%HG_HRB%\%BIN_HRB%
   echo #define oohgpath %HG_ROOT%\RESOURCES > _oohg_resconfig.h
   copy /b %HG_ROOT%\resources\oohg.rc + ofmt.rc _temp.rc > nul
   hbmk2 ofmt.hbp _temp.rc %HG_ROOT%\oohg.hbc %BEEP%
   del _oohg_resconfig.h /q
   del _temp.* /q
   set PATH=%TPATH%
   set TPATH=
   if exist .hbmk\nul attrib -s -h .hbmk /s /d
   if exist .hbmk\nul rd .hbmk /s /q
   echo.
   cd ..
   goto END

:FMT_XBCC

   echo Building oFMT...
   cd fmt
   call compile.bat /nocls
   cd ..
   goto END

:END

   set BASE_DISTRO_DIR=
   set CLEAN=
   set ADDCOMPS=
   set NOIDE=
   set INCRE=
   set BEEP=
   set BASE_DISTRO_SUBDIR=
   set TPATH=
   set HG_FILES1_PRG=
   set HG_FILES2_PRG=
   set HG_X_FLAGS=
   set HG_FILES_C=

   echo End reached.
