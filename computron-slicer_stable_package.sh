# CMAKE_VERSION=NA - This comment is used by the maintenance script to look up the cmake version

# Clear Slicer settings
# See https://github.com/Slicer/Slicer/pull/6879 introduced in March 2023
rm -rf /Users/svc-dashboard/.config/slicer.org/

# Clear reports to help avoid "The last time you opened ... Do you want to try to reopen its windows again?" dialog
rm -rf /Users/kitware/Library/Application\ Support/CrashReporter/*

# Clear "Saved Application State" specific to Slicer
rm -rf /Users/kitware/Library/Saved\ Application\ State/org.slicer.slicer.savedState/

# Remove source and build directories
# Note: Hyper-short name required on computron (S-0-build -> A)
rm -rf /D/S/S-0
rm -rf /D/S/A
rm -rf /D/S/S-0-E-b

# Slicer 'Stable' release
/D/Support/CMake-3.22.1.app/Contents/bin/ctest -S /D/DashboardScripts/computron-slicer_stable_package.cmake -VV -O /D/Logs/computron-slicer_stable_package.log

# Backup 'site-packages' directory associated with Slicer 'Stable' build
# Note: Hyper-short name required on computron (S-0-build -> A)
cp -rp \
  /D/S/A/python-install/lib/python3.9/site-packages \
  /D/S/A/python-install/lib/python3.9/site-packages.bkp

# Slicer 'Stable' release extensions
/D/Support/CMake-3.22.1.app/Contents/bin/ctest -S /D/DashboardScripts/computron-slicerextensions_stable_nightly.cmake -VV -O /D/Logs/computron-slicerextensions_stable_nightly.log
