export DISPLAY=:0.0 # just DISPLAY=:0.0 without export is not enough

# Nightly build of slicer (Documentation & Package)
/home/kitware/Dashboards/Support/cmake-3.9.0-Linux-x86_64/bin/ctest -S /home/kitware/Dashboards/DashboardScripts/factory-south-ubuntu-slicer4_release_nightly.cmake -VV -O /home/kitware/Dashboards/Logs/factory-south-ubuntu-slicer4_release_nightly.log

# Push generated documentation archives
(cd /home/kitware/Dashboards/Doxygen && rsync ./Slicer-cpp.tar.gz kitware@public:./Slicer_Doc/)
(cd /home/kitware/Dashboards/Doxygen && rsync ./SlicerWizard.tar.gz kitware@public:./Slicer_Doc/)

# Nightly build of slicer extensions testing
/home/kitware/Dashboards/Support/cmake-3.9.0-Linux-x86_64/bin/ctest -S /home/kitware/Dashboards/DashboardScripts/factory-south-ubuntu-slicerextensions_testing_release_nightly.cmake -VV -O /home/kitware/Dashboards/Logs/factory-south-ubuntu-slicerextensions_testing_release_nightly.log

# Nightly build of slicer extensions
/home/kitware/Dashboards/Support/cmake-3.9.0-Linux-x86_64/bin/ctest -S /home/kitware/Dashboards/DashboardScripts/factory-south-ubuntu-slicerextensions_release_nightly.cmake -VV -O /home/kitware/Dashboards/Logs/factory-south-ubuntu-slicerextensions_release_nightly.log

# Nightly build of slicer 4.6 extensions
/home/kitware/Dashboards/Support/cmake-3.9.0-Linux-x86_64/bin/ctest -S /home/kitware/Dashboards/DashboardScripts/factory-south-ubuntu-slicerextensions_46_release_nightly.cmake -VV -O /home/kitware/Dashboards/Logs/factory-south-ubuntu-slicerextensions_46_release_nightly.log

# 2017.04.18 - DISABLED
# Publish Slicer extension module metadata
# /home/kitware/Dashboards/DashboardScripts/factory-south-ubuntu-slicer-publish-extension-module-metadata.sh > /home/kitware/Dashboards/Logs/factory-south-ubuntu-slicer-publish-extension-module-metadata.log 2>&1

# 2017.04.18 - DISABLED
# Update wiki
# /home/kitware/Dashboards/DashboardScripts/factory-south-ubuntu-slicer-update-wiki.sh > /home/kitware/Dashboards/Logs/factory-south-ubuntu-slicer-update-wiki.log 2>&1

# Nightly build of CTKAppLauncher
# /home/kitware/Dashboards/Support/cmake-3.9.0-Linux-x86_64/bin/ctest -S /home/kitware/Dashboards/DashboardScripts/factory-south-ubuntu-CTKAppLauncher_release_nightly.cmake -VV -O /home/kitware/Dashboards/Logs/factory-south-ubuntu-CTKAppLauncher_release_nightly.log


# Nightly build of slicer (Coverage)
#/home/kitware/Dashboards/Support/cmake-3.9.0-Linux-x86_64/bin/ctest -S /home/kitware/Dashboards/DashboardScripts/factory-south-ubuntu-slicer4_release_nightly_coverage.cmake -VV -O /home/kitware/Dashboards/Logs/factory-south-ubuntu-slicer4_release_nightly_coverage.log

# Nightly build of slicer (Valgrind)
#/home/kitware/Dashboards/Support/cmake-3.9.0-Linux-x86_64/bin/ctest -S /home/kitware/Dashboards/DashboardScripts/factory-south-ubuntu-slicer4_release_nightly_valgrind.cmake -VV -O /home/kitware/Dashboards/Logs/factory-south-ubuntu-slicer4_release_nightly_valgrind.log

#if [ "$#" -gt "0" ]
#then
#  # CDash @home for 16 hours
#  cd /home/kitware/Dashboards/Client/
#  /home/kitware/Dashboards/Support/cmake-3.9.0-Linux-x86_64/bin/ctest -S /home/kitware/Dashboards/Client/factory-ubuntu.kitware.ctest -VV -O /home/kitware/Dashboards/Logs/slicer4_cdash_at_home.log
#fi
