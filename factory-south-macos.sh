# CMAKE_VERSION=3.12.2 - This comment is used by the maintenance script to look up the cmake version

# To facilitate execution of the command below by copy/paste, they do not include variables.

# Slicer 'Preview' release
/Volumes/Dashboards/Support/CMake-3.12.2.app/Contents/bin/ctest -S /Volumes/Dashboards/DashboardScripts/factory-south-macos-slicer_preview_nightly.cmake -VV -O /Volumes/Dashboards/Logs/factory-south-macos-slicer_preview_nightly.log

# SlicerSALT 'Preview' release
/Volumes/Dashboards/Support/CMake-3.12.2.app/Contents/bin/ctest -S /Volumes/Dashboards/DashboardScripts/factory-south-macos-slicersalt_preview_nightly.cmake -VV -O /Volumes/Dashboards/Logs/factory-south-macos-slicersalt_preview_nightly.log

# Slicer 'Stable' release extensions
/Volumes/Dashboards/Support/CMake-3.12.2.app/Contents/bin/ctest -S /Volumes/Dashboards/DashboardScripts/factory-south-macos-slicerextensions_stable_nightly.cmake -VV -O /Volumes/Dashboards/Logs/factory-south-macos-slicerextensions_stable_nightly.log

# Slicer 'Preview' release extensions
/Volumes/Dashboards/Support/CMake-3.12.2.app/Contents/bin/ctest -S /Volumes/Dashboards/DashboardScripts/factory-south-macos-slicerextensions_preview_nightly.cmake -VV -O /Volumes/Dashboards/Logs/factory-south-macos-slicerextensions_preview_nightly.log

