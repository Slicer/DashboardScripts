@ECHO OFF
:: CMAKE_VERSION=3.12.2 - This comment is used by the maintenance script to look up the cmake version

:: Disable tests
set run_ctest_with_test=FALSE

:: ----------------------------------------------------------------------------
:: Build CellLocator
:: ----------------------------------------------------------------------------
::echo "CellLocator 'Preview' release"
"C:\cmake-3.12.2\bin\ctest.exe" -S "D:\D\DashboardScripts\overload-vs2015-cell-locator_preview_experimental.cmake" -C Release -VV -O D:\D\Logs\overload-vs2015-cell-locator_preview_experimental.txt

::echo "CellLocator 'Preview' release - generate package"
"C:\cmake-3.12.2\bin\cmake.exe" --build "D:\D\P\CL-0-build/Slicer-build" --target PACKAGE --config Release > D:\D\Logs\overload-vs2015-cell-locator_preview_experimental-generate-package.txt 2>&1
