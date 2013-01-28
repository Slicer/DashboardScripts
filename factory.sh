open -a x11
export DISPLAY=:0.0 # just DISPLAY=:0.0 without export is not enough
export PATH=:/usr/local/git/bin:$PATH

CTEST=/Applications/CMake\ 2.8-8.app/Contents/bin/ctest
LOG_DIR=/Users/kitware/Dashboards/Logs
DASHBOARD_SCRIPTS_DIR=/Users/kitware/DashboardScripts

# Nightly build of CTKAppLauncher
"$CTEST" -S $DASHBOARD_SCRIPTS_DIR/factory-64bits_CTKAppLauncher_release_nightly.cmake -VV -O $LOG_DIR/factory-64bits_CTKAppLauncher_release_nightly.log

# Nightly build of slicer
"$CTEST" -S $DASHBOARD_SCRIPTS_DIR/factory-64bits_slicer4_release_nightly.cmake -VV -O $LOG_DIR/factory-64bits_slicer4_release_nightly.log

# Nightly build of slicer extensions testing
"$CTEST" -S $DASHBOARD_SCRIPTS_DIR/factory-64bits_slicerextensions_testing_release_nightly.cmake -VV -O $LOG_DIR/factory-64bits_slicerextensions_testing_release_nightly.log

# Nightly build of slicer extensions
"$CTEST" -S $DASHBOARD_SCRIPTS_DIR/factory-64bits_slicerextensions_release_nightly.cmake -VV -O $LOG_DIR/factory-64bits_slicerextensions_release_nightly.log

# Nightly build of slicer 4.1.1 extensions
#"$CTEST" -S $DASHBOARD_SCRIPTS_DIR/factory-64bits_slicerextensions_411_release_nightly.cmake -VV -O $LOG_DIR/factory-64bits_slicerextensions_411_release_nightly.log

# Nightly build of slicer 4.2 extensions
"$CTEST" -S $DASHBOARD_SCRIPTS_DIR/factory-64bits_slicerextensions_42_release_nightly.cmake -VV -O $LOG_DIR/factory-64bits_slicerextensions_42_release_nightly.log

# Nightly build of slicer ITKv4
"$CTEST" -S $DASHBOARD_SCRIPTS_DIR/factory-64bits_slicer4-itkv4_release_nightly.cmake -VV -O $LOG_DIR/factory-64bits_slicer4-itkv4_release_nightly.log

# Nightly build of Slicer's VTK
#"$CTEST" -S $DASHBOARD_SCRIPTS_DIR/factory_slicer_vtk_shared.cmake -V

# Nightly build of Slicer's ITK
"$CTEST" -S $DASHBOARD_SCRIPTS_DIR/factory_slicer_itk_shared.cmake -V

# CDash @home for 18 hours
cd /Users/kitware/Dashboards/Client/
"$CTEST" -S /Users/kitware/Dashboards/Client/factory.kitware.ctest -V
