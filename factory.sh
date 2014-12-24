open -a x11
export DISPLAY=:0.0 # just DISPLAY=:0.0 without export is not enough
export PATH=:/usr/local/git/bin:$PATH

# Nightly build of slicer
/Users/kitware/Dashboards/Support/CMake\ 3.0.1.app/Contents/bin/ctest -S /Users/kitware/DashboardScripts/factory-64bits_slicer4_release_nightly.cmake -VV -O /Users/kitware/Dashboards/Logs/factory-64bits_slicer4_release_nightly.log

# Nightly build of slicer extensions testing
/Users/kitware/Dashboards/Support/CMake\ 3.0.1.app/Contents/bin/ctest -S /Users/kitware/DashboardScripts/factory-64bits_slicerextensions_testing_release_nightly.cmake -VV -O /Users/kitware/Dashboards/Logs/factory-64bits_slicerextensions_testing_release_nightly.log

# Nightly build of slicer extensions
/Users/kitware/Dashboards/Support/CMake\ 3.0.1.app/Contents/bin/ctest -S /Users/kitware/DashboardScripts/factory-64bits_slicerextensions_release_nightly.cmake -VV -O /Users/kitware/Dashboards/Logs/factory-64bits_slicerextensions_release_nightly.log

# Nightly build of slicer 4.4 extensions
/Users/kitware/Dashboards/Support/CMake\ 3.0.1.app/Contents/bin/ctest -S /Users/kitware/DashboardScripts/factory-64bits_slicerextensions_44_release_nightly.cmake -VV -O /Users/kitware/Dashboards/Logs/factory-64bits_slicerextensions_44_release_nightly.log

# Publish Slicer extension module metadata
/Users/kitware/DashboardScripts/factory-south-ubuntu-slicer-publish-extension-module-metadata.sh > /Users/kitware/Dashboards/Logs/factory-south-ubuntu-slicer-publish-extension-module-metadata.log 2>&1

# Nightly build of CTKAppLauncher
/Users/kitware/Dashboards/Support/CMake\ 3.0.1.app/Contents/bin/ctest -S /Users/kitware/DashboardScripts/factory-64bits_CTKAppLauncher_release_nightly.cmake -VV -O /Users/kitware/Dashboards/Logs/factory-64bits_CTKAppLauncher_release_nightly.log

# Nightly build of Slicer's VTK
#/Users/kitware/Dashboards/Support/CMake\ 3.0.1.app/Contents/bin/ctest -S /Users/kitware/DashboardScripts/factory_slicer_vtk_shared.cmake -V

# Nightly build of Slicer's ITK
/Users/kitware/Dashboards/Support/CMake\ 3.0.1.app/Contents/bin/ctest -S /Users/kitware/DashboardScripts/factory_slicer_itk_shared.cmake -V

# CDash @home for 18 hours
cd /Users/kitware/Dashboards/Client/
/Users/kitware/Dashboards/Support/CMake\ 3.0.1.app/Contents/bin/ctest -S /Users/kitware/Dashboards/Client/factory.kitware.ctest -V
