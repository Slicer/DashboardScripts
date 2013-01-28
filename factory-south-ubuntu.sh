export DISPLAY=:0.0 # just DISPLAY=:0.0 without export is not enough

# Nightly build of CTKAppLauncher
/home/kitware/Dashboards/Support/cmake-2.8.10.2-Linux-i386/bin/ctest -S /home/kitware/Dashboards/DashboardScripts/factory-south-ubuntu-64bits_CTKAppLauncher_release_nightly.cmake -VV > /home/kitware/Dashboards/Logs/factory-south-ubuntu-64bits_CTKAppLauncher_release_nightly.txt 2>&1

# Nightly build of slicer (Documentation & Package)
/home/kitware/Dashboards/Support/cmake-2.8.10.2-Linux-i386/bin/ctest -S /home/kitware/Dashboards/DashboardScripts/factory-south-ubuntu-64bits_slicer4_release_nightly_doc.cmake -VV > /home/kitware/Dashboards/Logs/factory-south-ubuntu-64bits_slicer4_release_nightly_doc.txt 2>&1

# Nightly build of slicer extensions testing
/home/kitware/Dashboards/Support/cmake-2.8.10.2-Linux-i386/bin/ctest -S /home/kitware/Dashboards/DashboardScripts/factory-south-ubuntu-64bits_slicerextensions_testing_release_nightly.cmake -VV > /home/kitware/Dashboards/Logs/factory-south-ubuntu-64bits_slicerextensions_testing_release_nightly.log 2>&1

# Nightly build of slicer extensions
/home/kitware/Dashboards/Support/cmake-2.8.10.2-Linux-i386/bin/ctest -S /home/kitware/Dashboards/DashboardScripts/factory-south-ubuntu-64bits_slicerextensions_release_nightly.cmake -VV > /home/kitware/Dashboards/Logs/factory-south-ubuntu-64bits_slicerextensions_release_nightly.log 2>&1

# Nightly build of slicer 4.1.1 extensions
#/home/kitware/Dashboards/Support/cmake-2.8.10.2-Linux-i386/bin/ctest -S /home/kitware/Dashboards/DashboardScripts/factory-south-ubuntu-64bits_slicerextensions_411_release_nightly.cmake -VV > /home/kitware/Dashboards/Logs/factory-south-ubuntu-64bits_slicerextensions_411_release_nightly.log 2>&1

# Nightly build of slicer 4.2 extensions
/home/kitware/Dashboards/Support/cmake-2.8.10.2-Linux-i386/bin/ctest -S /home/kitware/Dashboards/DashboardScripts/factory-south-ubuntu-64bits_slicerextensions_42_release_nightly.cmake -VV > /home/kitware/Dashboards/Logs/factory-south-ubuntu-64bits_slicerextensions_42_release_nightly.log 2>&1

# Nightly build of slicer ITKv4
#/home/kitware/Dashboards/Support/cmake-2.8.10.2-Linux-i386/bin/ctest -S /home/kitware/Dashboards/DashboardScripts/factory-south-ubuntu-64bits_slicer4-itkv4_release_nightly.cmake -VV > /home/kitware/Dashboards/Logs/factory-south-ubuntu-64bits_slicer4-itkv4_release_nightly.txt 2>&1

# Nightly build of slicer (Coverage)
#/home/kitware/Dashboards/Support/cmake-2.8.10.2-Linux-i386/bin/ctest -S /home/kitware/Dashboards/DashboardScripts/factory-south-ubuntu-64bits_slicer4_release_nightly_coverage.cmake -VV > /home/kitware/Dashboards/Logs/factory-south-ubuntu-64bits_slicer4_release_nightly_coverage.txt 2>&1

# Nightly build of slicer (Valgrind)
#/home/kitware/Dashboards/Support/cmake-2.8.10.2-Linux-i386/bin/ctest -S /home/kitware/Dashboards/DashboardScripts/factory-south-ubuntu-64bits_slicer4_release_nightly_valgrind.cmake -VV > /home/kitware/Dashboards/Logs/factory-south-ubuntu-64bits_slicer4_release_nightly_valgrind.txt 2>&1

#if [ "$#" -gt "0" ]
#then
#  # CDash @home for 16 hours
#  cd /home/kitware/Dashboards/Client/
#  /home/kitware/Dashboards/Support/cmake-2.8.10.2-Linux-i386/bin/ctest -S /home/kitware/Dashboards/Client/factory-ubuntu.kitware.ctest -VV > /home/kitware/Dashboards/Logs/slicer4_cdash_at_home.txt 2>&1
#fi
