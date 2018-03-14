
# CMAKE_VERSION=3.11.0-rc3 - This comment is used by the maintenance script to look up the cmake version

# To facilitate execution of the command below by copy/paste, they do not include variables.

# Slicer 'Preview' release
/home/kitware/Dashboards/Support/cmake-3.11.0-rc3-Linux-x86_64/bin/ctest -S /home/kitware/Dashboards/DashboardScripts/factory-south-ubuntu-slicer_preview_nightly.cmake -VV -O /home/kitware/Dashboards/Logs/factory-south-ubuntu-slicer_preview_nightly.log

# Slicer 'Stable' release extensions
/home/kitware/Dashboards/Support/cmake-3.11.0-rc3-Linux-x86_64/bin/ctest -S /home/kitware/Dashboards/DashboardScripts/factory-south-ubuntu-slicerextensions_stable_nightly.cmake -VV -O /home/kitware/Dashboards/Logs/factory-south-ubuntu-slicerextensions_stable_nightly.log

# Slicer 'Preview' release extensions
/home/kitware/Dashboards/Support/cmake-3.11.0-rc3-Linux-x86_64/bin/ctest -S /home/kitware/Dashboards/DashboardScripts/factory-south-ubuntu-slicerextensions_preview_nightly.cmake -VV -O /home/kitware/Dashboards/Logs/factory-south-ubuntu-slicerextensions_preview_nightly.log

