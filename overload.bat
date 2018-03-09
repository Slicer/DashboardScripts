@ECHO OFF

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
:: Build Slicer Nightly
:: ----------------------------------------------------------------------------
::echo "Nightly build of slicer vs2015 64bits"
call :fastdel "D:\D\N\Slicer-1-build"
"C:\cmake-3.11.0-rc3\bin\ctest.exe" -S "D:\D\DashboardScripts\overload-vs2015-slicer_release_nightly.cmake" -C Release -VV -O D:\D\Logs\overload-vs2015-slicer_release_nightly.txt

:: ----------------------------------------------------------------------------
:: Build Slicer Extensions
:: ----------------------------------------------------------------------------
call :fastdel "D:\D\N\S-1-E-b"
call :fastdel "D:\D\N\S481-E-b"
if "%IS_WEEKEND%"=="1" (
  call :overload-vs2015-slicerextensions_release_nightly
  call :overload-vs2013-slicerextensions_48_release_nightly
) else (
  call :overload-vs2013-slicerextensions_48_release_nightly
  call :overload-vs2015-slicerextensions_release_nightly
)


:: force execution to quit at the end of the "main" logic
EXIT /B %ERRORLEVEL%


:: ----------------------------------------------------------------------------
:: Functions
:: ----------------------------------------------------------------------------

:: ----------------------------------------------------------------------------
:: a function to run Nightly extension dashboard
:overload-vs2015-slicerextensions_release_nightly
REM Nightly build of slicer extensions vs2015 64bits
::echo "Nightly build of slicer extensions vs2015 64bits"
"C:\cmake-3.11.0-rc3\bin\ctest.exe" -S "D:\D\DashboardScripts\overload-vs2015-slicerextensions_release_nightly.cmake" -C Release -VV -O D:\D\Logs\overload-vs2015-slicerextensions_release_nightly.txt
EXIT /B 0

:: ----------------------------------------------------------------------------
:: a function to run Release extension dashboard
:overload-vs2013-slicerextensions_48_release_nightly
REM Nightly build of slicer 4.8 extensions vs2013 64bits
::echo "Nightly build of slicer 4.8 extensions vs2013 64bits"
"C:\cmake-3.11.0-rc3\bin\ctest.exe" -S "D:\D\DashboardScripts\overload-vs2013-slicerextensions_48_release_nightly.cmake" -C Release -VV -O D:\D\Logs\overload-vs2013-slicerextensions_48_release_nightly.txt
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
