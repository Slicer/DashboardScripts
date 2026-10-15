#!/usr/bin/env bash

# CMAKE_VERSION=3.31.8 - This comment is used by the maintenance script to look up the cmake version

# Clear Slicer settings
# See https://github.com/Slicer/Slicer/pull/6879 introduced in March 2023
rm -rf /Users/svc-dashboard/.config/slicer.org/

# Clear reports to help avoid "The last time you opened ... Do you want to try to reopen its windows again?" dialog
rm -rf /Users/svc-dashboard/Library/Application\ Support/CrashReporter/*

# Clear "Saved Application State" specific to Slicer
rm -rf /Users/svc-dashboard/Library/Saved\ Application\ State/org.slicer.slicer.savedState/

# Restore 'site-packages' directory associated with Slicer 'Stable' build
# Note: Hyper-short name required on recoil (S-0-build -> A)
rm -rf /D/S/A/python-install/lib/python3.12/site-packages
cp -rp \
  /D/S/A/python-install/lib/python3.12/site-packages.bkp \
  /D/S/A/python-install/lib/python3.12/site-packages

# Slicer 'Preview' release
/D/Support/CMake-3.31.8.app/Contents/bin/ctest -S /D/DashboardScripts/recoil-slicer_preview_nightly.cmake -VV -O /D/Logs/recoil-slicer_preview_nightly.log

# Slicer 'Preview' release extensions
/D/Support/CMake-3.31.8.app/Contents/bin/ctest -S /D/DashboardScripts/recoil-slicerextensions_preview_nightly.cmake -VV -O /D/Logs/recoil-slicerextensions_preview_nightly.log

# Slicer 'Stable' release extensions
/D/Support/CMake-3.31.8.app/Contents/bin/ctest -S /D/DashboardScripts/recoil-slicerextensions_stable_nightly.cmake -VV -O /D/Logs/recoil-slicerextensions_stable_nightly.log
