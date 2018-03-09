export DISPLAY=:0.0 # just DISPLAY=:0.0 without export is not enough

# Nightly build of slicer
/home/kitware/Dashboards/Support/cmake-3.11.0-rc3-Linux-x86_64/bin/ctest -S /home/kitware/Dashboards/DashboardScripts/factory-south-ubuntu-slicer_release_nightly.cmake -VV -O /home/kitware/Dashboards/Logs/factory-south-ubuntu-slicer_release_nightly.log

# Nightly build of slicer 4.8 extensions
/home/kitware/Dashboards/Support/cmake-3.11.0-rc3-Linux-x86_64/bin/ctest -S /home/kitware/Dashboards/DashboardScripts/factory-south-ubuntu-slicerextensions_48_release_nightly.cmake -VV -O /home/kitware/Dashboards/Logs/factory-south-ubuntu-slicerextensions_48_release_nightly.log

# Nightly build of slicer extensions
/home/kitware/Dashboards/Support/cmake-3.11.0-rc3-Linux-x86_64/bin/ctest -S /home/kitware/Dashboards/DashboardScripts/factory-south-ubuntu-slicerextensions_release_nightly.cmake -VV -O /home/kitware/Dashboards/Logs/factory-south-ubuntu-slicerextensions_release_nightly.log

