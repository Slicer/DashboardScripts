@ECHO OFF

:: CMAKE_VERSION=3.17.2 - This comment is used by the maintenance script to look up the cmake version

:: To facilitate execution of the command below by copy/paste, they do not include variables.

:: ----------------------------------------------------------------------------
:: Set IS_WEEKEND
:: ----------------------------------------------------------------------------
:: Since nightly windows build starts after midnight, the following weekday are associated with weekend build:
::  6 -> Saturday
::  7 -> Sunday
echo DAYOFWEEK[%DAYOFWEEK%]

:: Get day of the week
:: See http://serverfault.com/questions/94824/finding-day-of-week-in-batch-file-windows-server-2008
:: and http://stackoverflow.com/a/14882478/1539918
for /f "skip=2 tokens=2 delims=," %%a in ('wmic path win32_localtime get dayofweek /format:csv') do set DAYOFWEEK=%%a

set IS_WEEKEND=0
::if "%DAYOFWEEK%"=="6" set IS_WEEKEND=1
if "%DAYOFWEEK%"=="7" set IS_WEEKEND=1

echo IS_WEEKEND[%IS_WEEKEND%]


:: ----------------------------------------------------------------------------
:: Clean Slicer settings
:: ----------------------------------------------------------------------------
call :fastdel "C:\Users\dashboard\AppData\Roaming\NA-MIC"

:: ----------------------------------------------------------------------------
:: Build Slicer
:: ----------------------------------------------------------------------------
::echo "Slicer 'Preview' release"
call :fastdel "D:\D\P\Slicer-0-build"
"C:\cmake-3.17.2\bin\ctest.exe" -S "D:\D\DashboardScripts\overload-vs2019-slicer_preview_nightly.cmake" -C Release -VV -O D:\D\Logs\overload-vs2019-slicer_preview_nightly.txt

:: ----------------------------------------------------------------------------
:: Build Slicer Extensions
:: ----------------------------------------------------------------------------
call :fastdel "D:\D\P\S-0-E-b"
call :fastdel "D:\D\S\S-41120200930-E-b"
if "%IS_WEEKEND%"=="1" (
  call :slicerextensions_stable_nightly
  call :slicerextensions_preview_nightly
) else (
  call :slicerextensions_preview_nightly
  call :slicerextensions_stable_nightly
)

:: ----------------------------------------------------------------------------
:: Clean SlicerSALT settings
:: ----------------------------------------------------------------------------
call :fastdel "C:\Users\dashboard\AppData\Roaming\Kitware, Inc"

:: ----------------------------------------------------------------------------
:: Build SlicerSALT
:: ----------------------------------------------------------------------------
::echo "SlicerSALT 'Preview' release"
call :fastdel "D:\D\P\SSALT-0-build"
"C:\cmake-3.13.4\bin\ctest.exe" -S "D:\D\DashboardScripts\overload-vs2015-slicersalt_preview_nightly.cmake" -C Release -VV -O D:\D\Logs\overload-vs2015-slicersalt_preview_nightly.txt

::echo "SlicerSALT 'Preview' release - generate package"
"C:\cmake-3.13.4\bin\cmake.exe" --build "D:\D\P\SSALT-0-build/Slicer-build" --target PACKAGE --config Release > D:\D\Logs\overload-slicersalt-generate-package.txt 2>&1

::echo "SlicerSALT 'Preview' release - package upload"
"C:\cmake-3.13.4\bin\cmake.exe" -P "D:\D\DashboardScripts\scripts\slicersalt-upload-package.cmake" > D:\D\Logs\overload-slicersalt-upload-package.txt 2>&1

:: force execution to quit at the end of the "main" logic
EXIT /B %ERRORLEVEL%


:: ----------------------------------------------------------------------------
:: Functions
:: ----------------------------------------------------------------------------

:: ----------------------------------------------------------------------------
:slicerextensions_preview_nightly
::echo "Slicer 'Preview' release extensions"
"C:\cmake-3.17.2\bin\ctest.exe" -S "D:\D\DashboardScripts\overload-vs2019-slicerextensions_preview_nightly.cmake" -C Release -VV -O D:\D\Logs\overload-vs2019-slicerextensions_preview_nightly.txt
EXIT /B 0

:: ----------------------------------------------------------------------------
:slicerextensions_stable_nightly
::echo "Slicer 'Stable' release extensions"
"C:\cmake-3.15.1\bin\ctest.exe" -S "D:\D\DashboardScripts\overload-vs2015-slicerextensions_stable_nightly.cmake" -C Release -VV -O D:\D\Logs\overload-vs2015-slicerextensions_stable_nightly.txt
EXIT /B 0

:: ----------------------------------------------------------------------------
:: a function to efficiently remove a large directory
:: See http://mattpilz.com/fastest-way-to-delete-large-folders-windows/
:fastdel
if NOT EXIST %1 (
  EXIT /B 0
)
echo "Removing %1 [%time%]"
del /f/s/q %1 > nul
rmdir /s/q %1
echo "Removing %1 - done [%time%]"
:: Note:
::  * Using rm.exe (as suggested in link below) should be the fastest but it complains about path too long when deleting extension build directory.
::  * See http://serverfault.com/questions/12680/what-is-the-best-way-to-remove-100-000-files-from-a-windows-directory/12684#12684
::  * "D:\Program Files (x86)\Git\bin\rm.exe" -rf %1
EXIT /B 0
