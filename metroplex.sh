#!/usr/bin/env bash

# CMAKE_VERSION=NA - This comment is used by the maintenance script to look up the cmake version

echo "Job started at: $(date +'%T %D %Z')"

#-------------------------------------------------------------------------------
# Changing directory is required by "slicer-buildenv-<ENV_NAME>-<ENV_VERSION>" script
cd  /home/svc-dashboard/Dashboards/Slicer

# Download and patch the slicer-buildenv-<ENV_NAME>-<ENV_VERSION> image
SLICER_PREVIEW_ENV_NAME=qt5-almalinux8-gcc14
SLICER_PREVIEW_ENV_VERSION=latest

# Download build environment
slicer_preview_script=/home/svc-dashboard/bin/slicer-buildenv-${SLICER_PREVIEW_ENV_NAME}-${SLICER_PREVIEW_ENV_VERSION}
if [[ ! -f ${slicer_preview_script} ]]; then
  docker run --rm slicer/buildenv-${SLICER_PREVIEW_ENV_NAME}:${SLICER_PREVIEW_ENV_VERSION} > $slicer_preview_script
  chmod +x $slicer_preview_script
fi

# Update build environment
$slicer_preview_script update

# Slicer dashboard settings
docker_args="-e run_ctest_with_disable_clean=${run_ctest_with_disable_clean-FALSE}"
docker_args+=" -e run_ctest_with_update=${run_ctest_with_update-TRUE}"
docker_args+=" -e run_ctest_with_test=${run_ctest_with_test-TRUE}" 
docker_args+=" -e run_extension_ctest_with_test=${run_extension_ctest_with_test-TRUE}" 

# Slicer 'Preview' release
time ${slicer_preview_script} \
  --args "${docker_args}" \
  ctest -S /work/DashboardScripts/metroplex-slicer_preview_nightly.cmake -VV -O /work/Logs/metroplex-slicer_preview_nightly.log

# Slicer 'Preview' release extensions
time ${slicer_preview_script} \
  --args "${docker_args}" \
  ctest -S /work/DashboardScripts/metroplex-slicerextensions_preview_nightly.cmake -VV -O /work/Logs/metroplex-slicerextensions_preview_nightly.log

#-------------------------------------------------------------------------------
# Restore 'site-packages' directory associated with Slicer 'Stable' build
rm -rf /home/svc-dashboard/Dashboards/Slicer/Stable/Slicer-0-build/python-install/lib/python3.12/site-packages/
cp -rp \
  /home/svc-dashboard/Dashboards/Slicer/Stable/Slicer-0-build/python-install/lib/python3.12/site-packages.bkp/ \
  /home/svc-dashboard/Dashboards/Slicer/Stable/Slicer-0-build/python-install/lib/python3.12/site-packages/

# Slicer 'Stable' release extensions
time /home/svc-dashboard/bin/slicer-buildenv-qt5-centos7-slicer-5.8 \
   --args "${docker_args}" \
   ctest -S /work/DashboardScripts/metroplex-slicerextensions_stable_nightly.cmake -VV -O /work/Logs/metroplex-slicerextensions_stable_nightly.log

#-------------------------------------------------------------------------------
# Download and patch the slicer-buildenv-<ENV_NAME>-<ENV_VERSION> image
SLICER_SALT_ENV_NAME=qt5-centos7
SLICER_SALT_ENV_VERSION=latest

# Download build environment
slicer_salt_script=/home/svc-dashboard/bin/slicer-buildenv-${SLICER_SALT_ENV_NAME}-${SLICER_SALT_ENV_VERSION}
if [[ ! -f ${slicer_salt_script} ]]; then
  docker run --rm slicer/buildenv-${SLICER_SALT_ENV_NAME}:${SLICER_SALT_ENV_VERSION} > $slicer_salt_script
  chmod +x $slicer_salt_script
fi

# Update build environment
$slicer_salt_script update

# SlicerSALT dashboard settings
slicersalt_docker_args="-e run_ctest_with_disable_clean=${run_slicersalt_ctest_with_disable_clean-FALSE}"
slicersalt_docker_args+=" -e run_ctest_with_update=${run_slicersalt_ctest_with_update-TRUE}"
slicersalt_docker_args+=" -e run_ctest_with_test=${run_slicersalt_ctest_with_test-TRUE}" 
docker_args+=" -e QT_QPA_PLATFORM=offscreen"  #Allows headlesss testing with some graphics failures

# SlicerSALT 'Preview' release
time ${slicer_salt_script} \
  --args "${slicersalt_docker_args}" \
  ctest -S /work/DashboardScripts/metroplex-slicersalt_preview_nightly.cmake -VV -O /work/Logs/metroplex-slicersalt_preview_nightly.log

# SlicerSALT 'Preview' release - generate package
time ${slicer_salt_script} \
  cmake --build /work/Preview/SSALT-0-build/Slicer-build/ --target package --config Release > /home/svc-dashboard/Dashboards/Logs/metroplex-slicersalt-generate-package.txt 2>&1

# SlicerSALT 'Preview' release - package upload
/home/svc-dashboard/.nix-profile/bin/cmake -P /home/svc-dashboard/Dashboards/Slicer/DashboardScripts/scripts/slicersalt-upload-package.cmake > /home/svc-dashboard/Dashboards/Logs/metroplex-slicersalt-upload-package.txt 2>&1

#Medical Team Dashboard
time /home/svc-dashboard/Dashboards/Medical/MedicalTeamDashboardScripts/metroplex.sh > /home/svc-dashboard/Dashboards/Medical/Logs/metroplex.log 2>&1

