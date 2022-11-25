# CMAKE_VERSION=3.22.1 - This comment is used by the maintenance script to look up the cmake version

# To facilitate execution of the command below by copy/paste, they do not include variables.

# Clear Slicer settings
rm -rf /Users/kitware/.config/www.na-mic.org/

# Clear reports to help avoid "The last time you opened ... Do you want to try to reopen its windows again?" dialog
rm -rf /Users/kitware/Library/Application\ Support/CrashReporter/*

# Clear "Saved Application State" specific to Slicer
rm -rf /Users/kitware/Library/Saved\ Application\ State/org.slicer.slicer.savedState/

# Slicer 'Preview' release
/Volumes/D/Support/CMake-3.22.1.app/Contents/bin/ctest -S /Volumes/D/DashboardScripts/factory-south-macos-slicer_preview_nightly.cmake -VV -O /Volumes/D/Logs/factory-south-macos-slicer_preview_nightly.log

# Slicer 'Preview' release extensions
/Volumes/D/Support/CMake-3.22.1.app/Contents/bin/ctest -S /Volumes/D/DashboardScripts/factory-south-macos-slicerextensions_preview_nightly.cmake -VV -O /Volumes/D/Logs/factory-south-macos-slicerextensions_preview_nightly.log

# Restore 'site-packages' directory associated with Slicer 'Stable' build
rm -rf /Volumes/D/S/S-0-build/python-install/lib/python3.9/site-packages
cp -rp \
  /Volumes/D/S/S-0-build/python-install/lib/python3.9/site-packages.bkp \
  /Volumes/D/S/S-0-build/python-install/lib/python3.9/site-packages

# Slicer 'Stable' release extensions
/Volumes/D/Support/CMake-3.22.1.app/Contents/bin/ctest -S /Volumes/D/DashboardScripts/factory-south-macos-slicerextensions_stable_nightly.cmake -VV -O /Volumes/D/Logs/factory-south-macos-slicerextensions_stable_nightly.log

# Clear SlicerSALT settings
rm -rf /Users/kitware/.config/kitware.com/

# SlicerSALT 'Preview' release
/Volumes/D/Support/CMake-3.22.1.app/Contents/bin/ctest -S /Volumes/D/DashboardScripts/factory-south-macos-slicersalt_preview_nightly.cmake -VV -O /Volumes/D/Logs/factory-south-macos-slicersalt_preview_nightly.log

# SlicerSALT 'Preview' release - generate package
/Volumes/D/Support/CMake-3.22.1.app/Contents/bin/cmake --build /Volumes/D/P/SSALT-0-build/Slicer-build --target package --config Release > /Volumes/D/Logs/factory-south-macos-slicersalt-generate-package.txt 2>&1

# SlicerSALT 'Preview' release - package upload
/Volumes/D/Support/CMake-3.22.1.app/Contents/bin/cmake -P /Volumes/D/DashboardScripts/scripts/slicersalt-upload-package.cmake > /Volumes/D/Logs/factory-south-macos-slicersalt-upload-package.txt 2>&1

#Medical Team Dashboard
/Volumes/D/Med/MedicalTeamDashboardScripts/factory-macos-south.sh > /Volumes/D/Med/Logs/factory-macos-south.log 2>&1



