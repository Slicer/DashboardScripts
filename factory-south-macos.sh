open -a x11
export DISPLAY=:0.0 # just DISPLAY=:0.0 without export is not enough

# CMAKE_VERSION=3.11.0-rc3 - This comment is used by the maintenance script to look up the cmake version

# To facilitate execution of the command below by copy/paste, they do not include variables.

# Nightly build of slicer
/Volumes/Dashboards/Support/CMake-3.11.0-rc3.app/Contents/bin/ctest -S /Volumes/Dashboards/DashboardScripts/factory-south-macos-slicer_release_nightly.cmake -VV -O /Volumes/Dashboards/Logs/factory-south-macos-slicer_release_nightly.log

# Nightly build of slicer 4.8 extensions
#/Volumes/Dashboards/Support/CMake-3.11.0-rc3.app/Contents/bin/ctest -S /Volumes/Dashboards/DashboardScripts/factory-south-macos-slicerextensions_48_release_nightly.cmake -VV -O /Volumes/Dashboards/Logs/factory-south-macos-slicerextensions_48_release_nightly.log

# Nightly build of slicer extensions
/Volumes/Dashboards/Support/CMake-3.11.0-rc3.app/Contents/bin/ctest -S /Volumes/Dashboards/DashboardScripts/factory-south-macos-slicerextensions_release_nightly.cmake -VV -O /Volumes/Dashboards/Logs/factory-south-macos-slicerextensions_release_nightly.log

