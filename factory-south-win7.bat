@ECHO OFF

REM Nightly build of slicer vs2013 64bits
::echo "Nightly build of slicer vs2013 64bits"
call :fastdel "C:\D\N\Slicer-1-build"
"C:\D\Support\CMake 3.4.1\bin\ctest.exe" -S "C:\D\DashboardScripts\factory-south-win7-vs2013-64bits_slicer4_release_nightly.cmake" -C Release -VV -O C:\D\Logs\factory-south-win7-vs2013-64bits_slicer4_release_nightly.txt


REM Nightly build of slicer extensions testing vs2013 64bits
::echo "Nightly build of slicer extensions testing vs2013 64bits"
call :fastdel "C:\D\N\S-1-E-T-b"
"C:\D\Support\CMake 3.4.1\bin\ctest.exe" -S "C:\D\DashboardScripts\factory-south-win7-vs2013-64bits_slicerextensions_testing_release_nightly.cmake" -C Release -VV -O C:\D\Logs\factory-south-win7-vs2013-64bits_slicerextensions_testing_release_nightly.txt

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
  call :fastdel "C:\D\N\S450-E-b"
  CALL :factory-south-win7-vs2008-64bits_slicerextensions_45_release_nightly
  call :fastdel "C:\D\N\S-1-E-b"
  CALL :factory-south-win7-vs2013-64bits_slicerextensions_release_nightly
) else (
  call :fastdel "C:\D\N\S-1-E-b"
  CALL :factory-south-win7-vs2013-64bits_slicerextensions_release_nightly
  call :fastdel "C:\D\N\S450-E-b"
  CALL :factory-south-win7-vs2008-64bits_slicerextensions_45_release_nightly
)

:: Publish Slicer extension module metadata
::call C:\D\DashboardScripts\factory-south-win7-slicer-publish-extension-module-metadata.bat >C:\D\Logs\factory-south-win7-slicer-publish-extension-module-metadata.log 2>&1

REM Nightly build of slicer vs2010 64bits
REM "C:\D\Support\CMake 3.4.1\bin\ctest.exe" -S "C:\D\DashboardScripts\factory-south-win7-vs2010-64bits_slicer4_release_nightly.cmake" -C Release -V -O C:\D\Logs\factory-south-win7-vs2010-64bits_slicer4_release_nightly.txt

REM cd "C:\Dashboards\Client"

REM "C:\D\Support\CMake 3.4.1\bin\ctest.exe" -S "C:\Dashboards\Client\factory.kitware.ctest" -V -O "C:\Dashboards\Logs\itk_cdash_at_home.txt"

:: force execution to quit at the end of the "main" logic
EXIT /B %ERRORLEVEL%

:: a function to run Nightly extension dashboard
:factory-south-win7-vs2013-64bits_slicerextensions_release_nightly
REM Nightly build of slicer extensions vs2013 64bits
::echo "Nightly build of slicer extensions vs2013 64bits"
"C:\D\Support\CMake 3.4.1\bin\ctest.exe" -S "C:\D\DashboardScripts\factory-south-win7-vs2013-64bits_slicerextensions_release_nightly.cmake" -C Release -VV -O C:\D\Logs\factory-south-win7-vs2013-64bits_slicerextensions_release_nightly.txt
EXIT /B 0


:: a function to run Release extension dashboard
:factory-south-win7-vs2008-64bits_slicerextensions_45_release_nightly
REM Nightly build of slicer 4.5 extensions vs2008 64bits
::echo "Nightly build of slicer 4.5 extensions vs2008 64bits"
"C:\D\Support\CMake 3.4.1\bin\ctest.exe" -S "C:\D\DashboardScripts\factory-south-win7-vs2008-64bits_slicerextensions_45_release_nightly.cmake" -C Release -VV -O C:\D\Logs\factory-south-win7-vs2008-64bits_slicerextensions_45_release_nightly.txt
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
::  * "C:\Program Files (x86)\Git\bin\rm.exe" -rf %1
EXIT /B 0
