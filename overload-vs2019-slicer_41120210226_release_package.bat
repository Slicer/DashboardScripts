@ECHO OFF
:: CMAKE_VERSION=NA - This comment is used by the maintenance script to look up the cmake version

:: ----------------------------------------------------------------------------
:: Build Slicer
:: ----------------------------------------------------------------------------
::echo "Slicer 'Stable' release"
"C:\cmake-3.17.2\bin\ctest.exe" -S "D:\D\DashboardScripts\overload-vs2019-slicer_41120210226_release_package.cmake" -C Release -VV -O D:\D\Logs\overload-vs2015-slicer_41120210226_release_package.txt

:: ----------------------------------------------------------------------------
:: Build Slicer Extensions
:: ----------------------------------------------------------------------------
::echo "Slicer 'Stable' release extensions"
"C:\cmake-3.17.2\bin\ctest.exe" -S "D:\D\DashboardScripts\overload-vs2019-slicerextensions_stable_nightly.cmake" -C Release -VV -O D:\D\Logs\overload-vs2019-slicerextensions_stable_nightly.txt
