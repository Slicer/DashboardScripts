open -a x11

# CMAKE_VERSION=3.9.0 - This comment is used by the maintenance script to look up the cmake version

# To facilitate execution of the command below by copy/paste, they do not include variables.

# Nightly build of slicer 4.8 extensions
/Users/kitware/Dashboards/Support/CMake-3.9.0.app/Contents/bin/ctest -S /Users/kitware/DashboardScripts/factory-macos-slicerextensions_48_release_nightly.cmake -VV -O /Users/kitware/Dashboards/Logs/factory-macos-slicerextensions_48_release_nightly.log
