open -a x11
# CMAKE_VERSION=3.11.0-rc3 - This comment is used by the maintenance script to look up the cmake version

# To facilitate execution of the command below by copy/paste, they do not include variables.

# Slicer "Preview" release
/Volumes/Dashboards/Support/CMake-3.11.0-rc3.app/Contents/bin/ctest -S /Volumes/Dashboards/DashboardScripts/factory-south-macos-slicer_preview_nightly.cmake -VV -O /Volumes/Dashboards/Logs/factory-south-macos-slicer_preview_nightly.log

# Slicer "Stable" release extensions
#/Volumes/Dashboards/Support/CMake-3.11.0-rc3.app/Contents/bin/ctest -S /Volumes/Dashboards/DashboardScripts/factory-south-macos-slicerextensions_stable_nightly.cmake -VV -O /Volumes/Dashboards/Logs/factory-south-macos-slicerextensions_stable_nightly.log

# Slicer "Preview" release extensions
/Volumes/Dashboards/Support/CMake-3.11.0-rc3.app/Contents/bin/ctest -S /Volumes/Dashboards/DashboardScripts/factory-south-macos-slicerextensions_preview_nightly.cmake -VV -O /Volumes/Dashboards/Logs/factory-south-macos-slicerextensions_preview_nightly.log

