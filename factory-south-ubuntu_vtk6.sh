export DISPLAY=:0.0 # just DISPLAY=:0.0 without export is not enough

# VTK 6 - Nightly build of slicer (Package)
/home/kitware/Dashboards/Support/cmake-2.8.10.2-Linux-i386/bin/ctest -S /home/kitware/Dashboards/DashboardScripts/factory-south-ubuntu-64bits_slicer4_release_nightly_vtk6.cmake -VV -O /home/kitware/Dashboards/Logs/factory-south-ubuntu-64bits_slicer4_release_nightly_vtk6.log

# VTK 6 - Nightly build of slicer extensions testing
/home/kitware/Dashboards/Support/cmake-2.8.10.2-Linux-i386/bin/ctest -S /home/kitware/Dashboards/DashboardScripts/factory-south-ubuntu-64bits_slicerextensions_testing_release_nightly_vtk6.cmake -VV -O /home/kitware/Dashboards/Logs/factory-south-ubuntu-64bits_slicerextensions_testing_release_nightly_vtk6.log

# VTK 6 - Nightly build of slicer extensions
/home/kitware/Dashboards/Support/cmake-2.8.10.2-Linux-i386/bin/ctest -S /home/kitware/Dashboards/DashboardScripts/factory-south-ubuntu-64bits_slicerextensions_release_nightly_vtk6.cmake -VV -O /home/kitware/Dashboards/Logs/factory-south-ubuntu-64bits_slicerextensions_release_nightly_vtk6.log
