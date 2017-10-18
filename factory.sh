open -a x11
export DISPLAY=:0.0 # just DISPLAY=:0.0 without export is not enough
export PATH=:/usr/local/git/bin:$PATH

# Nightly build of slicer
/Users/kitware/Dashboards/Support/CMake-3.9.0.app/Contents/bin/ctest -S /Users/kitware/DashboardScripts/factory-slicer4_release_nightly.cmake -VV -O /Users/kitware/Dashboards/Logs/factory-slicer4_release_nightly.log

# Nightly build of slicer extensions testing
/Users/kitware/Dashboards/Support/CMake-3.9.0.app/Contents/bin/ctest -S /Users/kitware/DashboardScripts/factory-slicerextensions_testing_release_nightly.cmake -VV -O /Users/kitware/Dashboards/Logs/factory-slicerextensions_testing_release_nightly.log

# Nightly build of slicer extensions
/Users/kitware/Dashboards/Support/CMake-3.9.0.app/Contents/bin/ctest -S /Users/kitware/DashboardScripts/factory-slicerextensions_release_nightly.cmake -VV -O /Users/kitware/Dashboards/Logs/factory-slicerextensions_release_nightly.log

# Nightly build of slicer 4.6 extensions
/Users/kitware/Dashboards/Support/CMake-3.9.0.app/Contents/bin/ctest -S /Users/kitware/DashboardScripts/factory-slicerextensions_46_release_nightly.cmake -VV -O /Users/kitware/Dashboards/Logs/factory-slicerextensions_46_release_nightly.log

# 2017.04.18 - DISABLED 
# Publish Slicer extension module metadata
# /Users/kitware/DashboardScripts/factory-slicer-publish-extension-module-metadata.sh > /Users/kitware/Dashboards/Logs/factory-slicer-publish-extension-module-metadata.log 2>&1

# Nightly build of CTKAppLauncher
# /Users/kitware/Dashboards/Support/CMake-3.9.0.app/Contents/bin/ctest -S /Users/kitware/DashboardScripts/factory-CTKAppLauncher_release_nightly.cmake -VV -O /Users/kitware/Dashboards/Logs/factory-CTKAppLauncher_release_nightly.log

# Nightly build of Slicer's VTK
#/Users/kitware/Dashboards/Support/CMake-3.9.0.app/Contents/bin/ctest -S /Users/kitware/DashboardScripts/factory_slicer_vtk_shared.cmake -V

# Nightly build of Slicer's ITK
/Users/kitware/Dashboards/Support/CMake-3.9.0.app/Contents/bin/ctest -S /Users/kitware/DashboardScripts/factory_slicer_itk_shared.cmake -V

# CDash @home for 18 hours
cd /Users/kitware/Dashboards/Client/
/Users/kitware/Dashboards/Support/CMake-3.9.0.app/Contents/bin/ctest -S /Users/kitware/Dashboards/Client/factory.kitware.ctest -V
