# Clear Slicer settings
rm -rf /Users/svc-dashboard/.config/www.na-mic.org/

# Slicer 'Preview' release
/D/Support/CMake-3.15.1.app/Contents/bin/ctest -S /D/DashboardScripts/computron-slicer_preview_nightly.cmake -VV -O /D/Logs/computron-slicer_preview_nightly.log