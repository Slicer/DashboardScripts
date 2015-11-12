export DISPLAY=:0.0 # just DISPLAY=:0.0 without export is not enough

HOSTNAME=factory-south-ubuntu
DASHBOARD_SCRIPTS_DIR=/home/kitware/Dashboards/DashboardScripts
LOG_DIR=/home/kitware/Dashboards/Logs
PACKAGE_VERSION=450

# Package build of slicer
/home/kitware/Dashboards/Support/cmake-3.1.0-rc3-Linux-x86_64/bin/ctest -S $DASHBOARD_SCRIPTS_DIR/${HOSTNAME}-64bits_slicer_${PACKAGE_VERSION}_release_package.cmake -VV -O $LOG_DIR/${HOSTNAME}-64bits_slicer_${PACKAGE_VERSION}_release_package.txt
