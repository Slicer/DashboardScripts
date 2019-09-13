# CMAKE_VERSION=3.15.1 - This comment is used by the maintenance script to look up the cmake version

# To facilitate execution of the command below by copy/paste, they do not include variables.

# Clear Slicer settings
rm -rf /Users/kitware/.config/www.na-mic.org/

# Slicer 'Preview' release
/Volumes/Dashboards/Support/CMake-3.15.1.app/Contents/bin/ctest -S /Volumes/Dashboards/DashboardScripts/factory-south-macos-slicer_preview_nightly.cmake -VV -O /Volumes/Dashboards/Logs/factory-south-macos-slicer_preview_nightly.log

# Slicer 'Preview' release extensions
/Volumes/Dashboards/Support/CMake-3.15.1.app/Contents/bin/ctest -S /Volumes/Dashboards/DashboardScripts/factory-south-macos-slicerextensions_preview_nightly.cmake -VV -O /Volumes/Dashboards/Logs/factory-south-macos-slicerextensions_preview_nightly.log

# Slicer 'Stable' release extensions
/Volumes/Dashboards/Support/CMake-3.15.1.app/Contents/bin/ctest -S /Volumes/Dashboards/DashboardScripts/factory-south-macos-slicerextensions_stable_nightly.cmake -VV -O /Volumes/Dashboards/Logs/factory-south-macos-slicerextensions_stable_nightly.log

# Clear SlicerSALT settings
rm -rf /Users/kitware/.config/kitware.com/

# SlicerSALT 'Preview' release
/Volumes/Dashboards/Support/CMake-3.15.1.app/Contents/bin/ctest -S /Volumes/Dashboards/DashboardScripts/factory-south-macos-slicersalt_preview_nightly.cmake -VV -O /Volumes/Dashboards/Logs/factory-south-macos-slicersalt_preview_nightly.log

# SlicerSALT 'Preview' release - generate package
/Volumes/Dashboards/Support/CMake-3.15.1.app/Contents/bin/cmake --build /Volumes/Dashboards/Preview/SSALT-0-build/Slicer-build --target package --config Release > /Volumes/Dashboards/Logs/factory-south-macos-slicersalt-generate-package.txt 2>&1

# SlicerSALT 'Preview' release - package upload
/Volumes/Dashboards/Support/CMake-3.15.1.app/Contents/bin/cmake -P /Volumes/Dashboards/DashboardScripts/scripts/slicersalt-upload-package.cmake > /Volumes/Dashboards/Logs/factory-south-macos-slicersalt-upload-package.txt 2>&1





