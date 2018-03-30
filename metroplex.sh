export DISPLAY=:0.0 # just DISPLAY=:0.0 without export is not enough
# CMAKE_VERSION=NA - This comment is used by the maintenance script to look up the cmake version

pushd /home/kitware/Dashboards/Slicer > /dev/null 2>&1

# To facilitate execution of the command below by copy/paste, they do not include variables.

# Slicer 'Preview' release
slicer-buildenv-qt5-centos7-latest \
  --args "-e run_ctest_with_test=FALSE" \
  ctest -S /work/DashboardScripts/metroplex-slicer_preview_nightly.cmake -VV -O /work/Support/Logs/metroplex-slicer_preview_nightly.log

# Slicer 'Stable' release extensions
# slicer-buildenv-qt5-centos7-latest \
#  --args "-e run_ctest_with_test=FALSE" \
#  ctest -S /work/DashboardScripts/metroplex-slicerextensions_stable_nightly.cmake -VV -O /work/Support/Logs/metroplex-slicerextensions_stable_nightly.log

# Slicer 'Preview' release extensions
#slicer-buildenv-qt5-centos7-latest \
#  --args "-e run_ctest_with_test=FALSE" \
#  ctest -S /work/DashboardScripts/metroplex-slicerextensions_preview_nightly.cmake -VV -O /work/Support/Logs/metroplex-slicerextensions_preview_nightly.log

