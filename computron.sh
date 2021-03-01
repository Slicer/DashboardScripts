# CMAKE_VERSION=3.17.2 - This comment is used by the maintenance script to look up the cmake version

# Clear Slicer settings
rm -rf /Users/svc-dashboard/.config/www.na-mic.org/

# Slicer 'Preview' release
/D/Support/CMake-3.17.2.app/Contents/bin/ctest -S /D/DashboardScripts/computron-slicer_preview_nightly.cmake -VV -O /D/Logs/computron-slicer_preview_nightly.log
