export DISPLAY=:0.0 # just DISPLAY=:0.0 without export is not enough
# CMAKE_VERSION=NA - This comment is used by the maintenance script to look up the cmake version

echo "Job started at: $(date +'%T %D %Z')"

#-------------------------------------------------------------------------------
# Changing directory is required by "slicer-buildenv-qt5-centos7-latest" script
cd  /home/kitware/Dashboards/Slicer

# Slicer dashboard settings
docker_args="-e run_ctest_with_disable_clean=${run_ctest_with_disable_clean-FALSE}"
docker_args+=" -e run_ctest_with_update=${run_ctest_with_update-TRUE}"
docker_args+=" -e run_ctest_with_test=${run_ctest_with_test-FALSE}" # XXX Re-enable testing after slicer/slicer-test images have been updated

# Slicer 'Stable' release
time /home/kitware/bin/slicer-buildenv-qt5-centos7-latest \
  --args "${docker_args}" \
  ctest -S /work/DashboardScripts/metroplex-slicersalt_220_release_package.cmake -VV -O /work/Logs/metroplex-slicersalt_220_release_package.log
