# CMAKE_VERSION=3.22.1 - This comment is used by the maintenance script to look up the cmake version

# Clear Slicer settings
rm -rf /Users/svc-dashboard/.config/www.na-mic.org/
rm -rf /Users/svc-dashboard/.config/www.slicer.org/

# Clear reports to help avoid "The last time you opened ... Do you want to try to reopen its windows again?" dialog
rm -rf /Users/svc-dashboard/Library/Application\ Support/CrashReporter/*

# Clear "Saved Application State" specific to Slicer
rm -rf /Users/svc-dashboard/Library/Saved\ Application\ State/org.slicer.slicer.savedState/

# Restore 'site-packages' directory associated with Slicer 'Stable' build
# TODO: Add logic for restoring 'site-packages'. See factory-south-macos.sh

# Slicer 'Preview' release
/D/Support/CMake-3.22.1.app/Contents/bin/ctest -S /D/DashboardScripts/computron-slicer_preview_nightly.cmake -VV -O /D/Logs/computron-slicer_preview_nightly.log

# Slicer 'Preview' release extensions
/D/Support/CMake-3.22.1.app/Contents/bin/ctest -S /D/DashboardScripts/computron-slicerextensions_preview_nightly.cmake -VV -O /D/Logs/factory-south-macos-slicerextensions_preview_nightly.log

# Restore 'site-packages' directory associated with Slicer 'Stable' build
# TODO

# Slicer 'Stable' release extensions
# TODO
