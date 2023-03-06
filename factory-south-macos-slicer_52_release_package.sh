# CMAKE_VERSION=NA - This comment is used by the maintenance script to look up the cmake version

# Clear Slicer settings
rm -rf /Users/kitware/.config/www.na-mic.org/
rm -rf /Users/kitware/.config/www.slicer.org/

# Clear reports to help avoid "The last time you opened ... Do you want to try to reopen its windows again?" dialog
rm -rf /Users/kitware/Library/Application\ Support/CrashReporter/*

# Clear "Saved Application State" specific to Slicer
rm -rf /Users/kitware/Library/Saved\ Application\ State/org.slicer.slicer.savedState/

# Remove source and build directories
rm -rf /Volumes/D/S/S-0
rm -rf /Volumes/D/S/S-0-build
rm -rf /Volumes/D/S/S-0-E-b

# Slicer 'Stable' release
/Volumes/D/Support/CMake-3.22.1.app/Contents/bin/ctest -S /Volumes/D/DashboardScripts/factory-south-macos-slicer_52_release_package.cmake -VV -O /Volumes/D/Logs/factory-south-macos-slicer_52_release_package.log

# Backup 'site-packages' directory associated with Slicer 'Stable' build
cp -rp \
  /Volumes/D/S/S-0-build/python-install/lib/python3.9/site-packages \
  /Volumes/D/S/S-0-build/python-install/lib/python3.9/site-packages.bkp

# Slicer 'Stable' release extensions
/Volumes/D/Support/CMake-3.22.1.app/Contents/bin/ctest -S /Volumes/D/DashboardScripts/factory-south-macos-slicerextensions_stable_nightly.cmake -VV -O /Volumes/D/Logs/factory-south-macos-slicerextensions_stable_nightly.log
