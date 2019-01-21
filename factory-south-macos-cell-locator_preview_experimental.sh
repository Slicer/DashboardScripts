# CMAKE_VERSION=NA - This comment is used by the maintenance script to look up the cmake version

# XXX Re-enable if a CTestConfig file is added and a dashboard is created on CDash
export run_ctest_submit=FALSE

# Disable tests
export run_ctest_with_test=FALSE

# CellLocator 'Preview' release
/Volumes/Dashboards/Support/CMake-3.12.2.app/Contents/bin/ctest -S /Volumes/Dashboards/DashboardScripts/factory-south-macos-cell-locator_preview_experimental.cmake -VV -O /Volumes/Dashboards/Logs/factory-south-macos-cell-locator_preview_experimental.log

# CellLocator 'Preview' release - generate package
/Volumes/Dashboards/Support/CMake-3.12.2.app/Contents/bin/cmake --build /Volumes/Dashboards/Preview/CL-0-build/Slicer-build --target package --config Release > /Volumes/Dashboards/Logs/factory-south-macos-cell-locator_preview_experimental-generate-package.txt 2>&1
