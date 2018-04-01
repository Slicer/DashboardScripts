export DISPLAY=:0.0 # just DISPLAY=:0.0 without export is not enough
# CMAKE_VERSION=NA - This comment is used by the maintenance script to look up the cmake version

# Changing directory is required by slicer-buildenv-qt5-centos7-latest
cd  /home/kitware/Dashboards/Slicer

# Slicer dashboard settings
docker_args="-e run_ctest_with_disable_clean=${run_ctest_with_disable_clean-FALSE}"
docker_args+=" -e run_ctest_with_update=${run_ctest_with_update-TRUE}"
docker_args+=" -e run_ctest_with_test=${run_ctest_with_test-FALSE}" # XXX Re-enable testing after slicer/slicer-test images have been updated

# Slicer 'Preview' release
/home/kitware/bin/slicer-buildenv-qt5-centos7-latest \
  --args "${docker_args}" \
  ctest -S /work/DashboardScripts/metroplex-slicer_preview_nightly.cmake -VV -O /work/Logs/metroplex-slicer_preview_nightly.log

# Slicer 'Stable' release extensions
# /home/kitware/bin/slicer-buildenv-qt5-centos7-latest \
#   --args "${docker_args}" \
#   ctest -S /work/DashboardScripts/metroplex-slicerextensions_stable_nightly.cmake -VV -O /work/Logs/metroplex-slicerextensions_stable_nightly.log

# Slicer 'Preview' release extensions
# /home/kitware/bin/slicer-buildenv-qt5-centos7-latest \
#   --args "${docker_args}" \
#   ctest -S /work/DashboardScripts/metroplex-slicerextensions_preview_nightly.cmake -VV -O /work/Logs/metroplex-slicerextensions_preview_nightly.log

# ITKPythonPackage, ITK CodeCov, ...
/home/kitware/Dashboards/KWDashboardScripts/metroplex.sh > /home/kitware/Dashboards/Logs/metroplex.log 2>&1
