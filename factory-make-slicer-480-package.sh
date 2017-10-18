open -a x11
export DISPLAY=:0.0 # just DISPLAY=:0.0 without export is not enough
export PATH=:/usr/local/git/bin:$PATH

HOSTNAME=factory
DASHBOARD_SCRIPTS_DIR=/Users/kitware/DashboardScripts
LOG_DIR=/Users/kitware/Dashboards/Logs
PACKAGE_VERSION=480

# Package build of slicer
/Users/kitware/Dashboards/Support/CMake-3.9.0.app/Contents/bin/ctest -S $DASHBOARD_SCRIPTS_DIR/${HOSTNAME}-slicer_${PACKAGE_VERSION}_release_package.cmake -VV -O $LOG_DIR/${HOSTNAME}-slicer_${PACKAGE_VERSION}_release_package.txt
