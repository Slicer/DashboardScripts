open -a xquartz
export DISPLAY=:0.0 # just DISPLAY=:0.0 without export is not enough
export PATH=:/usr/local/git/bin:$PATH

# Nightly build of slicer
/Volumes/Dashboards/Support/CMake-3.9.0.app/Contents/bin/ctest -S /Volumes/Dashboards/DashboardScripts/factory-south-macosx-64bits_slicer4_release_nightly.cmake -VV -O /Volumes/Dashboards/Logs/factory-south-macosx-64bits_slicer4_release_nightly.log

# Nightly build of slicer extensions
/Volumes/Dashboards/Support/CMake-3.9.0.app/Contents/bin/ctest -S /Volumes/Dashboards/DashboardScripts/factory-south-macosx-64bits_slicerextensions_release_nightly.cmake -VV -O /Volumes/Dashboards/Logs/factory-south-macosx-64bits_slicerextensions_release_nightly.log
