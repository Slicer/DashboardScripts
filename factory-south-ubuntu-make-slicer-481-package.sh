export DISPLAY=:0.0 # just DISPLAY=:0.0 without export is not enough

HOSTNAME=factory-south-ubuntu
DASHBOARD_SCRIPTS_DIR=/home/kitware/Dashboards/DashboardScripts
LOG_DIR=/home/kitware/Dashboards/Logs
PACKAGE_VERSION=481

# Package build of slicer
/home/kitware/Dashboards/Support/cmake-3.10.2-Linux-x86_64/bin/ctest -S $DASHBOARD_SCRIPTS_DIR/${HOSTNAME}-slicer_${PACKAGE_VERSION}_release_package.cmake -VV -O $LOG_DIR/${HOSTNAME}-slicer_${PACKAGE_VERSION}_release_package.txt
