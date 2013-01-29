open -a x11
export DISPLAY=:0.0 # just DISPLAY=:0.0 without export is not enough
export PATH=:/usr/local/git/bin:$PATH

# Nightly build of CTKAppLauncher
/Applications/CMake\ 2.8-8.app/Contents/bin/ctest -S /Users/kitware/DashboardScripts/factory-64bits_CTKAppLauncher_release_nightly.cmake -VV -O /Users/kitware/Dashboards/Logs/factory-64bits_CTKAppLauncher_release_nightly.log

# Nightly build of slicer
/Applications/CMake\ 2.8-8.app/Contents/bin/ctest -S /Users/kitware/DashboardScripts/factory-64bits_slicer4_release_nightly.cmake -VV -O /Users/kitware/Dashboards/Logs/factory-64bits_slicer4_release_nightly.log

# Nightly build of slicer extensions testing
/Applications/CMake\ 2.8-8.app/Contents/bin/ctest -S /Users/kitware/DashboardScripts/factory-64bits_slicerextensions_testing_release_nightly.cmake -VV -O /Users/kitware/Dashboards/Logs/factory-64bits_slicerextensions_testing_release_nightly.log

# Nightly build of slicer extensions
/Applications/CMake\ 2.8-8.app/Contents/bin/ctest -S /Users/kitware/DashboardScripts/factory-64bits_slicerextensions_release_nightly.cmake -VV -O /Users/kitware/Dashboards/Logs/factory-64bits_slicerextensions_release_nightly.log

# Nightly build of slicer 4.2 extensions
/Applications/CMake\ 2.8-8.app/Contents/bin/ctest -S /Users/kitware/DashboardScripts/factory-64bits_slicerextensions_42_release_nightly.cmake -VV -O /Users/kitware/Dashboards/Logs/factory-64bits_slicerextensions_42_release_nightly.log

# Nightly build of slicer ITKv4
/Applications/CMake\ 2.8-8.app/Contents/bin/ctest -S /Users/kitware/DashboardScripts/factory-64bits_slicer4-itkv4_release_nightly.cmake -VV -O /Users/kitware/Dashboards/Logs/factory-64bits_slicer4-itkv4_release_nightly.log

# Nightly build of Slicer's VTK
#/Applications/CMake\ 2.8-8.app/Contents/bin/ctest -S /Users/kitware/DashboardScripts/factory_slicer_vtk_shared.cmake -V

# Nightly build of Slicer's ITK
/Applications/CMake\ 2.8-8.app/Contents/bin/ctest -S /Users/kitware/DashboardScripts/factory_slicer_itk_shared.cmake -V

# CDash @home for 18 hours
cd /Users/kitware/Dashboards/Client/
/Applications/CMake\ 2.8-8.app/Contents/bin/ctest -S /Users/kitware/Dashboards/Client/factory.kitware.ctest -V
