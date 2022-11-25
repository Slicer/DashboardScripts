@ECHO OFF
:: CMAKE_VERSION=NA - This comment is used by the maintenance script to look up the cmake version

:: ----------------------------------------------------------------------------
:: Build Slicer
:: ----------------------------------------------------------------------------
::echo "Slicer 'Stable' release"
"C:\cmake-3.22.1\bin\ctest.exe" -S "D:\D\DashboardScripts\overload-vs2022-slicersalt_40_release_package.cmake" -C Release -VV -O D:\D\Logs\overload-vs2022-slicersalt_40_release_package.txt
