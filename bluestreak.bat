@ECHO OFF

:: CMAKE_VERSION=3.22.1 - This comment is used by the maintenance script to look up the cmake version

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
:: See https://github.com/Slicer/Slicer/pull/6879 introduced in March 2023
call :fastdel "C:\Users\svc-dashboard\AppData\Roaming\slicer.org"

:: ----------------------------------------------------------------------------
:: Build Slicer
:: ----------------------------------------------------------------------------
::echo "Slicer 'Preview' release"
call :fastdel "C:\D\P\S-0-build"
"C:\cmake-3.22.1\bin\ctest.exe" -S "C:\D\DashboardScripts\bluestreak-vs2022-slicer_preview_nightly.cmake" -C Release -VV -O C:\D\Logs\bluestreak-vs2022-slicer_preview_nightly.txt

:: ----------------------------------------------------------------------------
:: Restore 'site-packages' directory associated with Slicer 'Stable' build
:: ----------------------------------------------------------------------------
::call :fastdel "C:\D\S\S-0-build\python-install\Lib\site-packages"
::robocopy C:\D\S\S-0-build\python-install\Lib\site-packages.bkp C:\D\S\S-0-build\python-install\Lib\site-packages /E

:: ----------------------------------------------------------------------------
:: Build Slicer Extensions
:: ----------------------------------------------------------------------------
call :fastdel "C:\D\P\S-0-E-b"
call :fastdel "C:\D\S\S-0-E-b"
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
call :fastdel "C:\Users\svc-dashboard\AppData\Roaming\Kitware, Inc"

:: force execution to quit at the end of the "main" logic
EXIT /B %ERRORLEVEL%


:: ----------------------------------------------------------------------------
:: Functions
:: ----------------------------------------------------------------------------

:: ----------------------------------------------------------------------------
:slicerextensions_preview_nightly
::echo "Slicer 'Preview' release extensions"
"C:\cmake-3.22.1\bin\ctest.exe" -S "C:\D\DashboardScripts\bluestreak-vs2022-slicerextensions_preview_nightly.cmake" -C Release -VV -O C:\D\Logs\bluestreak-vs2022-slicerextensions_preview_nightly.txt
EXIT /B 0

:: ----------------------------------------------------------------------------
:slicerextensions_stable_nightly
::echo "Slicer 'Stable' release extensions"
"C:\cmake-3.22.1\bin\ctest.exe" -S "C:\D\DashboardScripts\bluestreak-vs2022-slicerextensions_stable_nightly.cmake" -C Release -VV -O C:\D\Logs\bluestreak-vs2019-slicerextensions_stable_nightly.txt
EXIT /B 0

:: ----------------------------------------------------------------------------
:: a function to efficiently remove a large directory
:: See https://mattpilz.com/fastest-way-to-delete-large-folders-windows/#comment-9340
:fastdel
if NOT EXIST %1 (
  EXIT /B 0
)
echo "Removing %1 [%time%]"
set empty_dir=%1-empty-%RANDOM%
mkdir %empty_dir%
robocopy %empty_dir% %1 /purge > nul
rmdir /s/q %empty_dir%
echo "Removing %1 - done [%time%]"
:: Note:
::  * Using rm.exe (as suggested in link below) should be the fastest but it complains about path too long when deleting extension build directory.
::  * See http://serverfault.com/questions/12680/what-is-the-best-way-to-remove-100-000-files-from-a-windows-directory/12684#12684
::  * "C:\Program Files (x86)\Git\bin\rm.exe" -rf %1
EXIT /B 0
