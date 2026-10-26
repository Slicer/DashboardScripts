#!/usr/bin/env bash

# CMAKE_VERSION=3.31.8 - This comment is used by the maintenance script to look up the cmake version

# Skip this run if the previous one is still going, since both would share the same build trees
LOCK_DIR=/D/Logs/computron.lock
if ! mkdir "${LOCK_DIR}" 2>/dev/null; then
  if kill -0 "$(cat "${LOCK_DIR}/pid" 2>/dev/null)" 2>/dev/null; then
    echo "Previous run (pid $(cat "${LOCK_DIR}/pid")) is still running, skipping"
    exit 1
  fi
fi
echo $$ > "${LOCK_DIR}/pid"
trap 'rm -rf "${LOCK_DIR}"' EXIT

# Reset the Launch Services database. Each build and package registers new Slicer.app bundles,
# and once tens of thousands accumulate lsd, Dock and tccd each spin a CPU core continuously.
/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister \
  -kill -r -domain local -domain system -domain user

# Clear Slicer settings
# See https://github.com/Slicer/Slicer/pull/6879 introduced in March 2023
rm -rf /Users/svc-dashboard/.config/slicer.org/

# Clear reports to help avoid "The last time you opened ... Do you want to try to reopen its windows again?" dialog
rm -rf /Users/svc-dashboard/Library/Application\ Support/CrashReporter/*

# Clear "Saved Application State" specific to Slicer
rm -rf /Users/svc-dashboard/Library/Saved\ Application\ State/org.slicer.slicer.savedState/

# Disable window state restoration for Slicer. Otherwise a Slicer killed mid-run (for example a test
# timeout) makes every later launch show the "reopen its windows?" dialog and hang until the test times out.
defaults write org.slicer.slicer ApplePersistenceIgnoreState -bool YES
defaults write org.slicer.slicer NSQuitAlwaysKeepsWindows -bool NO

# Restore 'site-packages' directory associated with Slicer 'Stable' build
# Note: Hyper-short name required on computron (S-0-build -> A)
rm -rf /D/S/A/python-install/lib/python3.12/site-packages
cp -rp \
  /D/S/A/python-install/lib/python3.12/site-packages.bkp \
  /D/S/A/python-install/lib/python3.12/site-packages

# Slicer 'Preview' release
/D/Support/CMake-3.31.8.app/Contents/bin/ctest -S /D/DashboardScripts/computron-slicer_preview_nightly.cmake -VV -O /D/Logs/computron-slicer_preview_nightly.log

# Slicer 'Preview' release extensions
/D/Support/CMake-3.31.8.app/Contents/bin/ctest -S /D/DashboardScripts/computron-slicerextensions_preview_nightly.cmake -VV -O /D/Logs/computron-slicerextensions_preview_nightly.log

# Slicer 'Stable' release extensions
/D/Support/CMake-3.31.8.app/Contents/bin/ctest -S /D/DashboardScripts/computron-slicerextensions_stable_nightly.cmake -VV -O /D/Logs/computron-slicerextensions_stable_nightly.log

# Medical Team Dashboard
/D/Med/MedicalTeamDashboardScripts/computron.sh > /D/Med/Logs/computron.log 2>&1
