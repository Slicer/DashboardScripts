export DISPLAY=:0.0 # just DISPLAY=:0.0 without export is not enough

CTEST=/home/kitware/Dashboards/Support/cmake-2.8.10.2-Linux-i386/bin/ctest
LOG_DIR=/home/kitware/Dashboards/Logs
DASHBOARD_SCRIPTS_DIR=/home/kitware/Dashboards/DashboardScripts

# Nightly build of CTKAppLauncher
$CTEST -S $DASHBOARD_SCRIPTS_DIR/factory-south-ubuntu-64bits_CTKAppLauncher_release_nightly.cmake -VV > $LOG_DIR/factory-south-ubuntu-64bits_CTKAppLauncher_release_nightly.txt 2>&1

# Nightly build of slicer (Documentation & Package)
$CTEST -S $DASHBOARD_SCRIPTS_DIR/factory-south-ubuntu-64bits_slicer4_release_nightly_doc.cmake -VV > $LOG_DIR/factory-south-ubuntu-64bits_slicer4_release_nightly_doc.txt 2>&1

# Nightly build of slicer extensions testing
$CTEST -S $DASHBOARD_SCRIPTS_DIR/factory-south-ubuntu-64bits_slicerextensions_testing_release_nightly.cmake -VV > $LOG_DIR/factory-south-ubuntu-64bits_slicerextensions_testing_release_nightly.log 2>&1

# Nightly build of slicer extensions
$CTEST -S $DASHBOARD_SCRIPTS_DIR/factory-south-ubuntu-64bits_slicerextensions_release_nightly.cmake -VV > $LOG_DIR/factory-south-ubuntu-64bits_slicerextensions_release_nightly.log 2>&1

# Nightly build of slicer 4.1.1 extensions
#$CTEST -S $DASHBOARD_SCRIPTS_DIR/factory-south-ubuntu-64bits_slicerextensions_411_release_nightly.cmake -VV > $LOG_DIR/factory-south-ubuntu-64bits_slicerextensions_411_release_nightly.log 2>&1

# Nightly build of slicer 4.2 extensions
$CTEST -S $DASHBOARD_SCRIPTS_DIR/factory-south-ubuntu-64bits_slicerextensions_42_release_nightly.cmake -VV > $LOG_DIR/factory-south-ubuntu-64bits_slicerextensions_42_release_nightly.log 2>&1

# Nightly build of slicer ITKv4
#$CTEST -S $DASHBOARD_SCRIPTS_DIR/factory-south-ubuntu-64bits_slicer4-itkv4_release_nightly.cmake -VV > $LOG_DIR/factory-south-ubuntu-64bits_slicer4-itkv4_release_nightly.txt 2>&1

# Nightly build of slicer (Coverage)
#$CTEST -S $DASHBOARD_SCRIPTS_DIR/factory-south-ubuntu-64bits_slicer4_release_nightly_coverage.cmake -VV > $LOG_DIR/factory-south-ubuntu-64bits_slicer4_release_nightly_coverage.txt 2>&1

# Nightly build of slicer (Valgrind)
#$CTEST -S $DASHBOARD_SCRIPTS_DIR/factory-south-ubuntu-64bits_slicer4_release_nightly_valgrind.cmake -VV > $LOG_DIR/factory-south-ubuntu-64bits_slicer4_release_nightly_valgrind.txt 2>&1

#if [ "$#" -gt "0" ]
#then
#  # CDash @home for 16 hours
#  cd /home/kitware/Dashboards/Client/
#  $CTEST -S /home/kitware/Dashboards/Client/factory-ubuntu.kitware.ctest -VV > $LOG_DIR/slicer4_cdash_at_home.txt 2>&1
#fi
