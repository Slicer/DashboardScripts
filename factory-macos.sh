open -a x11
export DISPLAY=:0.0 # just DISPLAY=:0.0 without export is not enough
export PATH=:/usr/local/git/bin:$PATH

# Nightly build of slicer
/Users/kitware/Dashboards/Support/CMake-3.9.0.app/Contents/bin/ctest -S /Users/kitware/DashboardScripts/factory-macos-slicer_release_nightly.cmake -VV -O /Users/kitware/Dashboards/Logs/factory-macos-slicer_release_nightly.log

# Nightly build of slicer extensions testing
/Users/kitware/Dashboards/Support/CMake-3.9.0.app/Contents/bin/ctest -S /Users/kitware/DashboardScripts/factory-macos-slicerextensions_testing_release_nightly.cmake -VV -O /Users/kitware/Dashboards/Logs/factory-macos-slicerextensions_testing_release_nightly.log

# Nightly build of slicer extensions
/Users/kitware/Dashboards/Support/CMake-3.9.0.app/Contents/bin/ctest -S /Users/kitware/DashboardScripts/factory-macos-slicerextensions_release_nightly.cmake -VV -O /Users/kitware/Dashboards/Logs/factory-macos-slicerextensions_release_nightly.log

# Nightly build of slicer 4.8 extensions
/Users/kitware/Dashboards/Support/CMake-3.9.0.app/Contents/bin/ctest -S /Users/kitware/DashboardScripts/factory-macos-slicerextensions_48_release_nightly.cmake -VV -O /Users/kitware/Dashboards/Logs/factory-macos-slicerextensions_48_release_nightly.log

# Nightly build of Slicer's ITK
/Users/kitware/Dashboards/Support/CMake-3.9.0.app/Contents/bin/ctest -S /Users/kitware/DashboardScripts/factory_slicer_itk_shared.cmake -V

# CDash @home for 18 hours
cd /Users/kitware/Dashboards/Client/
/Users/kitware/Dashboards/Support/CMake-3.9.0.app/Contents/bin/ctest -S /Users/kitware/Dashboards/Client/factory.kitware.ctest -V
