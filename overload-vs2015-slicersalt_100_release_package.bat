@ECHO OFF
:: CMAKE_VERSION=NA - This comment is used by the maintenance script to look up the cmake version

:: ----------------------------------------------------------------------------
:: Build Slicer
:: ----------------------------------------------------------------------------
::echo "Slicer 'Stable' release"
"C:\cmake-3.12.2\bin\ctest.exe" -S "D:\D\DashboardScripts\overload-vs2015-slicersalt_100_release_package.cmake" -C Release -VV -O D:\D\Logs\overload-vs2015-slicersalt_100_release_package.txt
