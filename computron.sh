# CMAKE_VERSION=3.22.1 - This comment is used by the maintenance script to look up the cmake version

# Clear Slicer settings
rm -rf /Users/svc-dashboard/.config/www.na-mic.org/
rm -rf /Users/svc-dashboard/.config/www.slicer.org/

# Slicer 'Preview' release
/D/Support/CMake-3.22.1.app/Contents/bin/ctest -S /D/DashboardScripts/computron-slicer_preview_nightly.cmake -VV -O /D/Logs/computron-slicer_preview_nightly.log

# Slicer 'Preview' release extensions
/D/Support/CMake-3.22.1.app/Contents/bin/ctest -S /D/DashboardScripts/computron-slicerextensions_preview_nightly.cmake -VV -O /D/Logs/factory-south-macos-slicerextensions_preview_nightly.log
