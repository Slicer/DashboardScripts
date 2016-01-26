@ECHO OFF

REM Nightly build of slicer vs2008 64bits
::echo "Nightly build of slicer vs2008 64bits"
"C:\D\Support\CMake 3.4.1\bin\ctest.exe" -S "C:\D\DashboardScripts\factory-south-win7-vs2008-64bits_slicer4_release_nightly.cmake" -C Release -V -O C:\D\Logs\factory-south-win7-vs2008-64bits_slicer4_release_nightly.txt

REM Nightly build of slicer extensions testing vs2008 64bits
::echo "Nightly build of slicer extensions testing vs2008 64bits"
"C:\D\Support\CMake 3.4.1\bin\ctest.exe" -S "C:\D\DashboardScripts\factory-south-win7-vs2008-64bits_slicerextensions_testing_release_nightly.cmake" -C Release -V -O C:\D\Logs\factory-south-win7-vs2008-64bits_slicerextensions_testing_release_nightly.txt

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
  CALL :factory-south-win7-vs2008-64bits_slicerextensions_45_release_nightly
  CALL :factory-south-win7-vs2008-64bits_slicerextensions_release_nightly
) else (
  CALL :factory-south-win7-vs2008-64bits_slicerextensions_release_nightly
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
:factory-south-win7-vs2008-64bits_slicerextensions_release_nightly
REM Nightly build of slicer extensions vs2008 64bits
::echo "Nightly build of slicer extensions vs2008 64bits"
"C:\D\Support\CMake 3.4.1\bin\ctest.exe" -S "C:\D\DashboardScripts\factory-south-win7-vs2008-64bits_slicerextensions_release_nightly.cmake" -C Release -V -O C:\D\Logs\factory-south-win7-vs2008-64bits_slicerextensions_release_nightly.txt
EXIT /B 0


:: a function to run Release extension dashboard
:factory-south-win7-vs2008-64bits_slicerextensions_45_release_nightly
REM Nightly build of slicer 4.5 extensions vs2008 64bits
::echo "Nightly build of slicer 4.5 extensions vs2008 64bits"
"C:\D\Support\CMake 3.4.1\bin\ctest.exe" -S "C:\D\DashboardScripts\factory-south-win7-vs2008-64bits_slicerextensions_45_release_nightly.cmake" -C Release -V -O C:\D\Logs\factory-south-win7-vs2008-64bits_slicerextensions_45_release_nightly.txt
EXIT /B 0
