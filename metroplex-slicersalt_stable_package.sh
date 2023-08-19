export DISPLAY=:0.0 # just DISPLAY=:0.0 without export is not enough
# CMAKE_VERSION=NA - This comment is used by the maintenance script to look up the cmake version

echo "Job started at: $(date +'%T %D %Z')"

#-------------------------------------------------------------------------------
# Changing directory is required by "slicer-buildenv-qt5-centos7-latest" script
cd  /home/kitware/Dashboards/Slicer

#-------------------------------------------------------------------------------
# Download and patch the slicer-buildenv-qt5-centos7-latest as of 10/24/2022
SLICER_SALT_ENV_NAME=qt5-centos7
SLICER_SALT_ENV_VERSION=latest 

# Download build environment
slicer_salt_script=/home/kitware/bin/slicer-buildenv-${SLICER_SALT_ENV_NAME}-${SLICER_SALT_ENV_VERSION}
if [[ ! -f ${slicer_salt_script} ]]; then
  docker run --rm slicer/buildenv-${SLICER_SALT_ENV_NAME}:${SLICER_SALT_ENV_VERSION} > $slicer_salt_script
  chmod +x $slicer_salt_script
fi

# Update build environment
$slicer_salt_script update
# HACK: Workaround limitation of entrypoint.sh (see https://github.com/Slicer/SlicerBuildEnvironment/issues/16)
sed -i ${slicer_salt_script} -e "s/slicer\/buildenv-${SLICER_SALT_ENV_NAME}:latest/slicer\/buildenv-${SLICER_SALT_ENV_NAME}:${SLICER_SALT_ENV_VERSION}/"

# SlicerSALT dashboard settings
slicersalt_docker_args="-e run_ctest_with_disable_clean=${run_slicersalt_ctest_with_disable_clean-FALSE}"
slicersalt_docker_args+=" -e run_ctest_with_update=${run_slicersalt_ctest_with_update-TRUE}"
slicersalt_docker_args+=" -e run_ctest_with_test=${run_slicersalt_ctest_with_test-FALSE}" # XXX Re-enable testing after slicer/slicer-test images have been updated

# Slicer 'Stable' release
time ${slicer_salt_script} \
  --args "${slicersalt_docker_args}" \
  ctest -S /work/DashboardScripts/metroplex-slicersalt_stable_package.cmake -VV -O /work/Logs/metroplex-slicersalt_stable_package.log
