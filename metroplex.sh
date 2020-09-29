export DISPLAY=:0.0 # just DISPLAY=:0.0 without export is not enough
# CMAKE_VERSION=NA - This comment is used by the maintenance script to look up the cmake version

#-------------------------------------------------------------------------------
with_itk_dashboard=0

while [[ $# != 0 ]]; do
    case $1 in
        --with-itk-dashboard)
            with_itk_dashboard=1
            shift 1
            ;;
        -*)
            err Unknown option \"$1\"
            help
            exit 1
            ;;
        *)
            break
            ;;
    esac
done

echo "Job started at: $(date +'%T %D %Z')"
echo "with_itk_dashboard [${with_itk_dashboard}]"

#-------------------------------------------------------------------------------
# Changing directory is required by "slicer-buildenv-qt5-centos7-latest" script
cd  /home/kitware/Dashboards/Slicer

# Download and patch the slicer-buildenv-qt5-centos7-slicer-4.11-2018.10.17 image
SLICER_PREVIEW_ENV_NAME=qt5-centos7
SLICER_PREVIEW_ENV_VERSION=latest

# Download build environment
slicer_preview_script=/home/kitware/bin/slicer-buildenv-${SLICER_PREVIEW_ENV_NAME}-${SLICER_PREVIEW_ENV_VERSION}
if [[ ! -f ${slicer_preview_script} ]]; then
  docker run --rm slicer/buildenv-${SLICER_PREVIEW_ENV_NAME}:${SLICER_PREVIEW_ENV_VERSION} > $slicer_preview_script
  chmod +x $slicer_preview_script
fi

# Update build environment
$slicer_preview_script update
# HACK: Workaround limitation of entrypoint.sh (see https://github.com/Slicer/SlicerBuildEnvironment/issues/16)
sed -i ${slicer_preview_script} -e "s/slicer\/buildenv-${SLICER_PREVIEW_ENV_NAME}:latest/slicer\/buildenv-${SLICER_PREVIEW_ENV_NAME}:${SLICER_PREVIEW_ENV_VERSION}/"

# Slicer dashboard settings
docker_args="-e run_ctest_with_disable_clean=${run_ctest_with_disable_clean-FALSE}"
docker_args+=" -e run_ctest_with_update=${run_ctest_with_update-TRUE}"
docker_args+=" -e run_ctest_with_test=${run_ctest_with_test-FALSE}" # XXX Re-enable testing after slicer/slicer-test images have been updated
docker_args+=" -e run_extension_ctest_with_test=${run_extension_ctest_with_test-FALSE}" # XXX Re-enable testing after slicer/slicer-test images have been updated

# Slicer 'Preview' release
time ${slicer_preview_script} \
  --args "${docker_args}" \
  ctest -S /work/DashboardScripts/metroplex-slicer_preview_nightly.cmake -VV -O /work/Logs/metroplex-slicer_preview_nightly.log

# Slicer 'Preview' release extensions
time ${slicer_preview_script} \
  --args "${docker_args}" \
  ctest -S /work/DashboardScripts/metroplex-slicerextensions_preview_nightly.cmake -VV -O /work/Logs/metroplex-slicerextensions_preview_nightly.log

# Slicer 'Stable' release extensions
time /home/kitware/bin/slicer-buildenv-qt5-centos7-slicer-4.10 \
   --args "${docker_args}" \
   ctest -S /work/DashboardScripts/metroplex-slicerextensions_stable_nightly.cmake -VV -O /work/Logs/metroplex-slicerextensions_stable_nightly.log

#-------------------------------------------------------------------------------
# See https://github.com/Slicer/SlicerDockerUpdate
time /bin/bash /home/kitware/Packaging/SlicerDockerUpdate/cronjob.sh >/home/kitware/Packaging/SlicerDockerUpdate/cronjob-log.txt 2>&1

if [ $with_itk_dashboard == 1 ]; then
  time /home/kitware/Dashboards/KWDashboardScripts/metroplex.sh > /home/kitware/Dashboards/Logs/metroplex.log 2>&1
fi

#-------------------------------------------------------------------------------
# Download and patch the slicer-buildenv-qt5-centos7-slicer-4.11-2018.10.17 image
SLICER_SALT_ENV_NAME=qt5-centos7
SLICER_SALT_ENV_VERSION=slicer-4.11-2018.10.17

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

# SlicerSALT 'Preview' release
time ${slicer_salt_script} \
  --args "${slicersalt_docker_args}" \
  ctest -S /work/DashboardScripts/metroplex-slicersalt_preview_nightly.cmake -VV -O /work/Logs/metroplex-slicersalt_preview_nightly.log

# SlicerSALT 'Preview' release - generate package
time ${slicer_salt_script} \
  cmake --build /work/Preview/SSALT-0-build/Slicer-build/ --target package --config Release > /home/kitware/Dashboards/Logs/metroplex-slicersalt-generate-package.txt 2>&1

# SlicerSALT 'Preview' release - package upload
/home/kitware/.nix-profile/bin/cmake -P /home/kitware/Dashboards/Slicer/DashboardScripts/scripts/slicersalt-upload-package.cmake > /home/kitware/Dashboards/Logs/metroplex-slicersalt-upload-package.txt 2>&1

#Medical Team Dashboard
time /home/kitware/Dashboards/Medical/MedicalTeamDashboardScripts/metroplex.sh > /home/kitware/Dashboards/Medical/Logs/metroplex.log 2>&1

