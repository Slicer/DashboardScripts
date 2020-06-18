# CMAKE_VERSION=NA - This comment is used by the maintenance script to look up the cmake version

# Disable tests
export run_ctest_with_test=FALSE

# CellLocator 'Preview' release
/Volumes/D/Support/CMake-3.12.2.app/Contents/bin/ctest -S /Volumes/D/DashboardScripts/factory-south-macos-cell-locator_preview_experimental.cmake -VV -O /Volumes/D/Logs/factory-south-macos-cell-locator_preview_experimental.log

# CellLocator 'Preview' release - generate package
/Volumes/D/Support/CMake-3.12.2.app/Contents/bin/cmake --build /Volumes/D/Preview/CL-0-build/Slicer-build --target package --config Release > /Volumes/D/Logs/factory-south-macos-cell-locator_preview_experimental-generate-package.txt 2>&1
