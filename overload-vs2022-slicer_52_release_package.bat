@ECHO OFF
:: CMAKE_VERSION=NA - This comment is used by the maintenance script to look up the cmake version

:: ----------------------------------------------------------------------------
:: Clean Slicer settings
:: ----------------------------------------------------------------------------
call :fastdel "C:\Users\svc-dashboard\AppData\Roaming\NA-MIC"

:: ----------------------------------------------------------------------------
:: Remove source and build directories
:: ----------------------------------------------------------------------------
call :fastdel "D:\D\S\S-0"
call :fastdel "D:\D\S\S-0-build"
call :fastdel "D:\D\S\S-0-E-b"

:: ----------------------------------------------------------------------------
:: Build Slicer
:: ----------------------------------------------------------------------------
::echo "Slicer 'Stable' release"
"C:\cmake-3.22.1\bin\ctest.exe" -S "D:\D\DashboardScripts\overload-vs2022-slicer_52_release_package.cmake" -C Release -VV -O D:\D\Logs\overload-vs2022-slicer_52_release_package.txt

:: ----------------------------------------------------------------------------
:: Backup 'site-packages' directory associated with 'Stable' build
:: ----------------------------------------------------------------------------
robocopy D:\D\S\S-0-build\python-install\Lib\site-packages D:\D\S\S-0-build\python-install\Lib\site-packages.bkp /E

:: ----------------------------------------------------------------------------
:: Build Slicer Extensions
:: ----------------------------------------------------------------------------
::echo "Slicer 'Stable' release extensions"
"C:\cmake-3.22.1\bin\ctest.exe" -S "D:\D\DashboardScripts\overload-vs2022-slicerextensions_stable_nightly.cmake" -C Release -VV -O D:\D\Logs\overload-vs2022-slicerextensions_stable_nightly.txt

:: force execution to quit at the end of the "main" logic
EXIT /B %ERRORLEVEL%


:: ----------------------------------------------------------------------------
:: Functions
:: ----------------------------------------------------------------------------

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
