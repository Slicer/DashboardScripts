@ECHO OFF

REM Nightly build of slicer vs2013 64bits
::echo "Nightly build of slicer vs2013 64bits"
call :fastdel "D:\D\N\Slicer-1-build"
"C:\cmake-3.9.0\bin\ctest.exe" -S "D:\D\DashboardScripts\overload-vs2013-slicer4_release_nightly.cmake" -C Release -VV -O D:\D\Logs\overload-vs2013-slicer4_release_nightly.txt


REM Nightly build of slicer extensions testing vs2013 64bits
::echo "Nightly build of slicer extensions testing vs2013 64bits"
::call :fastdel "D:\D\N\S-1-E-T-b"
::"C:\cmake-3.9.0\bin\ctest.exe" -S "D:\D\DashboardScripts\overload-vs2013-slicerextensions_testing_release_nightly.cmake" -C Release -VV -O D:\D\Logs\overload-vs2013-slicerextensions_testing_release_nightly.txt

:: See http://serverfault.com/questions/94824/finding-day-of-week-in-batch-file-windows-server-2008
:: and http://stackoverflow.com/a/14882478/1539918
for /f "skip=2 tokens=2 delims=," %%a in ('wmic path win32_localtime get dayofweek /format:csv') do set DAYOFWEEK=%%a

:: Since nightly windows build starts after midnight, the following weekday are associated with weekend build:
::  6 -> Saturday
::  7 -> Sunday
echo DAYOFWEEK[%DAYOFWEEK%]

set STABLE_BEFORE_NIGHTLY=0
::if "%DAYOFWEEK%"=="6" set STABLE_BEFORE_NIGHTLY=1
if "%DAYOFWEEK%"=="7" set STABLE_BEFORE_NIGHTLY=1

echo STABLE_BEFORE_NIGHTLY[%STABLE_BEFORE_NIGHTLY%]

if "%STABLE_BEFORE_NIGHTLY%"=="1" (
::  call :fastdel "D:\D\N\S460-E-b"
::  CALL :overload-vs2013-slicerextensions_46_release_nightly
  call :fastdel "D:\D\N\S-1-E-b"
  CALL :overload-vs2013-slicerextensions_release_nightly
) else (
  call :fastdel "D:\D\N\S-1-E-b"
  CALL :overload-vs2013-slicerextensions_release_nightly
::  call :fastdel "D:\D\N\S460-E-b"
::  CALL :overload-vs2013-slicerextensions_46_release_nightly
)

:: 2017.04.18 - DISABLED
:: Publish Slicer extension module metadata
:: call D:\D\DashboardScripts\overload-slicer-publish-extension-module-metadata.bat >D:\D\Logs\overload-slicer-publish-extension-module-metadata.log 2>&1

REM Nightly build of slicer vs2010 64bits
REM "C:\cmake-3.9.0\bin\ctest.exe" -S "D:\D\DashboardScripts\overload-vs2010-slicer4_release_nightly.cmake" -C Release -V -O D:\D\Logs\overload-vs2010-slicer4_release_nightly.txt

REM cd "D:\Dashboards\Client"

REM "C:\cmake-3.9.0\bin\ctest.exe" -S "D:\Dashboards\Client\factory.kitware.ctest" -V -O "D:\Dashboards\Logs\itk_cdash_at_home.txt"

:: force execution to quit at the end of the "main" logic
EXIT /B %ERRORLEVEL%

:: a function to run Nightly extension dashboard
:overload-vs2013-slicerextensions_release_nightly
REM Nightly build of slicer extensions vs2013 64bits
::echo "Nightly build of slicer extensions vs2013 64bits"
"C:\cmake-3.9.0\bin\ctest.exe" -S "D:\D\DashboardScripts\overload-vs2013-slicerextensions_release_nightly.cmake" -C Release -VV -O D:\D\Logs\overload-vs2013-slicerextensions_release_nightly.txt
EXIT /B 0


:: a function to run Release extension dashboard
:overload-vs2013-slicerextensions_46_release_nightly
REM Nightly build of slicer 4.6 extensions vs2013 64bits
::echo "Nightly build of slicer 4.6 extensions vs2013 64bits"
"C:\cmake-3.9.0\bin\ctest.exe" -S "D:\D\DashboardScripts\overload-vs2013-slicerextensions_46_release_nightly.cmake" -C Release -VV -O D:\D\Logs\overload-vs2013-slicerextensions_46_release_nightly.txt
EXIT /B 0

:: a function to efficiently remove a large directory
:: See http://mattpilz.com/fastest-way-to-delete-large-folders-windows/
:fastdel
echo "Removing %1 [%time%]"
del /f/s/q %1 > nul
rmdir /s/q %1
echo "Removing %1 - done [%time%]"
:: Note:
::  * Using rm.exe (as suggested in link below) should be the fastest but it complains about path too long when deleting extension build directory.
::  * See http://serverfault.com/questions/12680/what-is-the-best-way-to-remove-100-000-files-from-a-windows-directory/12684#12684
::  * "D:\Program Files (x86)\Git\bin\rm.exe" -rf %1
EXIT /B 0
