
# See https://gist.github.com/jcfr/811a23d722bc245fe077e08d897d20e8
export LD_LIBRARY_PATH=/usr/local/lib64:/usr/local/lib
export PKG_CONFIG_PATH=/usr/local/lib/pkgconfig
export PATH=/usr/local/bin:$PATH

# CMAKE_VERSION=3.11.0-rc3 - This comment is used by the maintenance script to look up the cmake version

# To facilitate execution of the command below by copy/paste, they do not include variables.

# Slicer 'Stable' release extensions
/home/kitware/Dashboards/Support/cmake-3.11.0-rc3-Linux-x86_64/bin/ctest -S /home/kitware/Dashboards/DashboardScripts/factory-south-ubuntu-slicerextensions_stable_nightly.cmake -VV -O /home/kitware/Dashboards/Logs/factory-south-ubuntu-slicerextensions_stable_nightly.log
