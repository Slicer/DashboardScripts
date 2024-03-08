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

# Download and patch the slicer-buildenv-qt5-centos7:latest image
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

# Restore 'site-packages' directory associated with Slicer 'Stable' build
rm -rf /home/kitware/Dashboards/Slicer/Stable/Slicer-0-build/python-install/lib/python3.9/site-packages/
cp -rp \
  /home/kitware/Dashboards/Slicer/Stable/Slicer-0-build/python-install/lib/python3.9/site-packages.bkp/ \
  /home/kitware/Dashboards/Slicer/Stable/Slicer-0-build/python-install/lib/python3.9/site-packages/

# Slicer 'Stable' release extensions
time /home/kitware/bin/slicer-buildenv-qt5-centos7-slicer-5.6 \
   --args "${docker_args}" \
   ctest -S /work/DashboardScripts/metroplex-slicerextensions_stable_nightly.cmake -VV -O /work/Logs/metroplex-slicerextensions_stable_nightly.log

#-------------------------------------------------------------------------------
# See https://github.com/Slicer/SlicerDockerUpdate
time /bin/bash /home/kitware/Packaging/SlicerDockerUpdate/cronjob.sh >/home/kitware/Packaging/SlicerDockerUpdate/cronjob-log.txt 2>&1

if [ $with_itk_dashboard == 1 ]; then
  time /home/kitware/Dashboards/KWDashboardScripts/metroplex.sh > /home/kitware/Dashboards/Logs/metroplex.log 2>&1
fi

#Medical Team Dashboard
time /home/kitware/Dashboards/Medical/MedicalTeamDashboardScripts/metroplex.sh > /home/kitware/Dashboards/Medical/Logs/metroplex.log 2>&1

