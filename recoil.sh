#!/usr/bin/env bash

# CMAKE_VERSION=3.31.8 - This comment is used by the maintenance script to look up the cmake version

# Unregister app bundles left in the Launch Services database by previous builds. Each build and package
# registers new Slicer.app bundles, and once tens of thousands accumulate lsd, Dock and tccd each spin a
# CPU core continuously. "lsregister -kill" was removed in macOS 26, so unregister them individually.
LSREGISTER=/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister
"${LSREGISTER}" -dump \
  | sed -n -E 's#^path: +(/Users/svc-dashboard/D/.*) \(0x[0-9a-f]+\)$#\1#p' \
  | sort -u | tr '\n' '\0' | xargs -0 "${LSREGISTER}" -u

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
# /D/Support/CMake-3.31.8.app/Contents/bin/ctest -S /D/DashboardScripts/recoil-slicerextensions_stable_nightly.cmake -VV -O /D/Logs/recoil-slicerextensions_stable_nightly.log
