open -a x11
export DISPLAY=:0.0 # just DISPLAY=:0.0 without export is not enough
export PATH=:/usr/local/git/bin:$PATH

HOSTNAME=factory
DASHBOARD_SCRIPTS_DIR=/Users/kitware/DashboardScripts
LOG_DIR=/Users/kitware/Dashboards/Logs
PACKAGE_VERSION=411

# Package build of slicer
/Applications/CMake\ 2.8-10.app/Contents/bin/ctest -S $DASHBOARD_SCRIPTS_DIR/${HOSTNAME}-64bits_slicer_${PACKAGE_VERSION}_release_package.cmake -VV -O $LOG_DIR/${HOSTNAME}-64bits_slicer_${PACKAGE_VERSION}_release_package.txt
