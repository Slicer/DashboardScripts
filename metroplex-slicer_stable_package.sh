export DISPLAY=:0.0 # just DISPLAY=:0.0 without export is not enough
# CMAKE_VERSION=NA - This comment is used by the maintenance script to look up the cmake version

echo "Job started at: $(date +'%T %D %Z')"

#-------------------------------------------------------------------------------
# Changing directory is required by "slicer-buildenv-qt5-centos7-latest" script
cd  /home/kitware/Dashboards/Slicer

# Slicer dashboard settings
docker_args="-e run_ctest_with_disable_clean=${run_ctest_with_disable_clean-FALSE}"
docker_args+=" -e run_ctest_with_update=${run_ctest_with_update-TRUE}"
docker_args+=" -e run_ctest_with_test=${run_ctest_with_test-TRUE}"
docker_args+=" -e run_extension_ctest_with_test=${run_extension_ctest_with_test-TRUE}"

# Remove source and build directories
rm -rf /home/kitware/Dashboards/Slicer/Stable/Slicer-0
rm -rf /home/kitware/Dashboards/Slicer/Stable/Slicer-0-build
rm -rf /home/kitware/Dashboards/Slicer/Stable/S-0-E-b

# Slicer 'Stable' release
time /home/kitware/bin/slicer-buildenv-qt5-centos7-slicer-5.2 \
  --args "${docker_args}" \
  ctest -S /work/DashboardScripts/metroplex-slicer_stable_package.cmake -VV -O /work/Logs/metroplex-slicer_stable_package.log

# Backup 'site-packages' directory associated with Slicer 'Stable' build
time cp -rp \
  /home/kitware/Dashboards/Slicer/Stable/Slicer-0-build/python-install/lib/python3.9/site-packages/ \
  /home/kitware/Dashboards/Slicer/Stable/Slicer-0-build/python-install/lib/python3.9/site-packages.bkp/

# Slicer 'Stable' release extensions
time /home/kitware/bin/slicer-buildenv-qt5-centos7-slicer-5.2 \
   --args "${docker_args}" \
   ctest -S /work/DashboardScripts/metroplex-slicerextensions_stable_nightly.cmake -VV -O /work/Logs/metroplex-slicerextensions_stable_nightly.log
