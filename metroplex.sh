export DISPLAY=:0.0 # just DISPLAY=:0.0 without export is not enough
# CMAKE_VERSION=NA - This comment is used by the maintenance script to look up the cmake version

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

# Changing directory is required by "slicer-buildenv-qt5-centos7-latest" script
cd  /home/kitware/Dashboards/Slicer

# Slicer dashboard settings
docker_args="-e run_ctest_with_disable_clean=${run_ctest_with_disable_clean-FALSE}"
docker_args+=" -e run_ctest_with_update=${run_ctest_with_update-TRUE}"
docker_args+=" -e run_ctest_with_test=${run_ctest_with_test-FALSE}" # XXX Re-enable testing after slicer/slicer-test images have been updated

# Slicer 'Preview' release
time /home/kitware/bin/slicer-buildenv-qt5-centos7-latest \
  --args "${docker_args}" \
  ctest -S /work/DashboardScripts/metroplex-slicer_preview_nightly.cmake -VV -O /work/Logs/metroplex-slicer_preview_nightly.log

# Slicer 'Stable' release extensions
# time /home/kitware/bin/slicer-buildenv-qt5-centos7-latest \
#   --args "${docker_args}" \
#   ctest -S /work/DashboardScripts/metroplex-slicerextensions_stable_nightly.cmake -VV -O /work/Logs/metroplex-slicerextensions_stable_nightly.log

# Slicer 'Preview' release extensions
# time /home/kitware/bin/slicer-buildenv-qt5-centos7-latest \
#   --args "${docker_args}" \
#   ctest -S /work/DashboardScripts/metroplex-slicerextensions_preview_nightly.cmake -VV -O /work/Logs/metroplex-slicerextensions_preview_nightly.log

# See https://github.com/Slicer/SlicerDockerUpdate
time /bin/bash /home/kitware/Packaging/SlicerDockerUpdate/cronjob.sh >/home/kitware/Packaging/SlicerDockerUpdate/cronjob-log.txt 2>&1

if [ $with_itk_dashboard == 1 ]; then
  time /home/kitware/Dashboards/KWDashboardScripts/metroplex.sh > /home/kitware/Dashboards/Logs/metroplex.log 2>&1
fi
